Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWFAFQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWFAFQl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWFAFQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:16:37 -0400
Received: from ns1.suse.de ([195.135.220.2]:25559 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751784AbWFAFOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:14:09 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 1 Jun 2006 15:13:58 +1000
Message-Id: <1060601051358.27613@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 006 of 10] md: Set/get state of array via sysfs
References: <20060601150955.27444.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This allows the state of an md/array to be directly controlled
via sysfs and adds the ability to stop and array without
tearing it down.

Array states/settings:

 clear
     No devices, no size, no level
     Equivalent to STOP_ARRAY ioctl
 inactive
     May have some settings, but array is not active
        all IO results in error
     When written, doesn't tear down array, but just stops it
 suspended (not supported yet)
     All IO requests will block. The array can be reconfigured.
     Writing this, if accepted, will block until array is quiescent
 readonly
     no resync can happen.  no superblocks get written.
     write requests fail
 read-auto
     like readonly, but behaves like 'clean' on a write request.

 clean - no pending writes, but otherwise active.
     When written to inactive array, starts without resync
     If a write request arrives then
       if metadata is known, mark 'dirty' and switch to 'active'.
       if not known, block and switch to write-pending
     If written to an active array that has pending writes, then fails.
 active
     fully active: IO and resync can be happening.
     When written to inactive array, starts with resync

 write-pending (not supported yet)
     clean, but writes are blocked waiting for 'active' to be written.

 active-idle
     like active, but no writes have been seen for a while (100msec).

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./Documentation/md.txt |   39 +++++++++
 ./drivers/md/md.c      |  197 ++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 227 insertions(+), 9 deletions(-)

diff ./Documentation/md.txt~current~ ./Documentation/md.txt
--- ./Documentation/md.txt~current~	2006-06-01 15:03:28.000000000 +1000
+++ ./Documentation/md.txt	2006-06-01 15:05:29.000000000 +1000
@@ -216,6 +216,45 @@ All md devices contain:
      period as a number of seconds.  The default is 200msec (0.200).
      Writing a value of 0 disables safemode.
 
+   array_state
+     This file contains a single word which describes the current
+     state of the array.  In many cases, the state can be set by
+     writing the word for the desired state, however some states
+     cannot be explicitly set, and some transitions are not allowed.
+
+     clear
+         No devices, no size, no level
+         Writing is equivalent to STOP_ARRAY ioctl
+     inactive
+         May have some settings, but array is not active
+            all IO results in error
+         When written, doesn't tear down array, but just stops it
+     suspended (not supported yet)
+         All IO requests will block. The array can be reconfigured.
+         Writing this, if accepted, will block until array is quiessent
+     readonly
+         no resync can happen.  no superblocks get written.
+         write requests fail
+     read-auto
+         like readonly, but behaves like 'clean' on a write request.
+
+     clean - no pending writes, but otherwise active.
+         When written to inactive array, starts without resync
+         If a write request arrives then
+           if metadata is known, mark 'dirty' and switch to 'active'.
+           if not known, block and switch to write-pending
+         If written to an active array that has pending writes, then fails.
+     active
+         fully active: IO and resync can be happening.
+         When written to inactive array, starts with resync
+
+     write-pending
+         clean, but writes are blocked waiting for 'active' to be written.
+
+     active-idle
+         like active, but no writes have been seen for a while (safe_mode_delay).
+
+
    sync_speed_min
    sync_speed_max
      This are similar to /proc/sys/dev/raid/speed_limit_{min,max}

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-06-01 15:05:29.000000000 +1000
+++ ./drivers/md/md.c	2006-06-01 15:05:29.000000000 +1000
@@ -2185,6 +2185,176 @@ chunk_size_store(mddev_t *mddev, const c
 static struct md_sysfs_entry md_chunk_size =
 __ATTR(chunk_size, 0644, chunk_size_show, chunk_size_store);
 
+/*
+ * The array state can be:
+ *
+ * clear
+ *     No devices, no size, no level
+ *     Equivalent to STOP_ARRAY ioctl
+ * inactive
+ *     May have some settings, but array is not active
+ *        all IO results in error
+ *     When written, doesn't tear down array, but just stops it
+ * suspended (not supported yet)
+ *     All IO requests will block. The array can be reconfigured.
+ *     Writing this, if accepted, will block until array is quiessent
+ * readonly
+ *     no resync can happen.  no superblocks get written.
+ *     write requests fail
+ * read-auto
+ *     like readonly, but behaves like 'clean' on a write request.
+ *
+ * clean - no pending writes, but otherwise active.
+ *     When written to inactive array, starts without resync
+ *     If a write request arrives then
+ *       if metadata is known, mark 'dirty' and switch to 'active'.
+ *       if not known, block and switch to write-pending
+ *     If written to an active array that has pending writes, then fails.
+ * active
+ *     fully active: IO and resync can be happening.
+ *     When written to inactive array, starts with resync
+ *
+ * write-pending
+ *     clean, but writes are blocked waiting for 'active' to be written.
+ *
+ * active-idle
+ *     like active, but no writes have been seen for a while (100msec).
+ *
+ */
+enum array_state { clear, inactive, suspended, readonly, read_auto, clean, active,
+		   write_pending, active_idle, bad_word};
+char *array_states[] = {
+	"clear", "inactive", "suspended", "readonly", "read-auto", "clean", "active",
+	"write-pending", "active-idle", NULL };
+
+static int match_word(const char *word, char **list)
+{
+	int n;
+	for (n=0; list[n]; n++)
+		if (cmd_match(word, list[n]))
+			break;
+	return n;
+}
+
+static ssize_t
+array_state_show(mddev_t *mddev, char *page)
+{
+	enum array_state st = inactive;
+
+	if (mddev->pers)
+		switch(mddev->ro) {
+		case 1:
+			st = readonly;
+			break;
+		case 2:
+			st = read_auto;
+			break;
+		case 0:
+			if (mddev->in_sync)
+				st = clean;
+			else if (mddev->safemode)
+				st = active_idle;
+			else
+				st = active;
+		}
+	else {
+		if (list_empty(&mddev->disks) &&
+		    mddev->raid_disks == 0 &&
+		    mddev->size == 0)
+			st = clear;
+		else
+			st = inactive;
+	}
+	return sprintf(page, "%s\n", array_states[st]);
+}
+
+static int do_md_stop(mddev_t * mddev, int ro);
+static int do_md_run(mddev_t * mddev);
+static int restart_array(mddev_t *mddev);
+
+static ssize_t
+array_state_store(mddev_t *mddev, const char *buf, size_t len)
+{
+	int err = -EINVAL;
+	enum array_state st = match_word(buf, array_states);
+	switch(st) {
+	case bad_word:
+		break;
+	case clear:
+		/* stopping an active array */
+		if (mddev->pers) {
+			if (atomic_read(&mddev->active) > 1)
+				return -EBUSY;
+			err = do_md_stop(mddev, 0);
+		}
+		break;
+	case inactive:
+		/* stopping an active array */
+		if (mddev->pers) {
+			if (atomic_read(&mddev->active) > 1)
+				return -EBUSY;
+			err = do_md_stop(mddev, 2);
+		}
+		break;
+	case suspended:
+		break; /* not supported yet */
+	case readonly:
+		if (mddev->pers)
+			err = do_md_stop(mddev, 1);
+		else {
+			mddev->ro = 1;
+			err = do_md_run(mddev);
+		}
+		break;
+	case read_auto:
+		/* stopping an active array */
+		if (mddev->pers) {
+			err = do_md_stop(mddev, 1);
+			if (err == 0)
+				mddev->ro = 2; /* FIXME mark devices writable */
+		} else {
+			mddev->ro = 2;
+			err = do_md_run(mddev);
+		}
+		break;
+	case clean:
+		if (mddev->pers) {
+			restart_array(mddev);
+			spin_lock_irq(&mddev->write_lock);
+			if (atomic_read(&mddev->writes_pending) == 0) {
+				mddev->in_sync = 1;
+				mddev->sb_dirty = 1;
+			}
+			spin_unlock_irq(&mddev->write_lock);
+		} else {
+			mddev->ro = 0;
+			mddev->recovery_cp = MaxSector;
+			err = do_md_run(mddev);
+		}
+		break;
+	case active:
+		if (mddev->pers) {
+			restart_array(mddev);
+			mddev->sb_dirty = 0;
+			wake_up(&mddev->sb_wait);
+			err = 0;
+		} else {
+			mddev->ro = 0;
+			err = do_md_run(mddev);
+		}
+		break;
+	case write_pending:
+	case active_idle:
+		/* these cannot be set */
+		break;
+	}
+	if (err)
+		return err;
+	else
+		return len;
+}
+static struct md_sysfs_entry md_array_state = __ATTR(array_state, 0644, array_state_show, array_state_store);
+
 static ssize_t
 null_show(mddev_t *mddev, char *page)
 {
@@ -2553,6 +2723,7 @@ static struct attribute *md_default_attr
 	&md_metadata.attr,
 	&md_new_device.attr,
 	&md_safe_delay.attr,
+	&md_array_state.attr,
 	NULL,
 };
 
@@ -2919,11 +3090,8 @@ static int restart_array(mddev_t *mddev)
 		md_wakeup_thread(mddev->thread);
 		md_wakeup_thread(mddev->sync_thread);
 		err = 0;
-	} else {
-		printk(KERN_ERR "md: %s has no personality assigned.\n",
-			mdname(mddev));
+	} else
 		err = -EINVAL;
-	}
 
 out:
 	return err;
@@ -2955,7 +3123,12 @@ static void restore_bitmap_write_access(
 	spin_unlock(&inode->i_lock);
 }
 
-static int do_md_stop(mddev_t * mddev, int ro)
+/* mode:
+ *   0 - completely stop and dis-assemble array
+ *   1 - switch to readonly
+ *   2 - stop but do not disassemble array
+ */
+static int do_md_stop(mddev_t * mddev, int mode)
 {
 	int err = 0;
 	struct gendisk *disk = mddev->gendisk;
@@ -2977,12 +3150,15 @@ static int do_md_stop(mddev_t * mddev, i
 
 		invalidate_partition(disk, 0);
 
-		if (ro) {
+		switch(mode) {
+		case 1: /* readonly */
 			err  = -ENXIO;
 			if (mddev->ro==1)
 				goto out;
 			mddev->ro = 1;
-		} else {
+			break;
+		case 0: /* disassemble */
+		case 2: /* stop */
 			bitmap_flush(mddev);
 			md_super_wait(mddev);
 			if (mddev->ro)
@@ -3002,7 +3178,7 @@ static int do_md_stop(mddev_t * mddev, i
 			mddev->in_sync = 1;
 			md_update_sb(mddev);
 		}
-		if (ro)
+		if (mode == 1)
 			set_disk_ro(disk, 1);
 		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	}
@@ -3010,7 +3186,7 @@ static int do_md_stop(mddev_t * mddev, i
 	/*
 	 * Free resources if final stop
 	 */
-	if (!ro) {
+	if (mode == 0) {
 		mdk_rdev_t *rdev;
 		struct list_head *tmp;
 		struct gendisk *disk;
@@ -3034,6 +3210,9 @@ static int do_md_stop(mddev_t * mddev, i
 		export_array(mddev);
 
 		mddev->array_size = 0;
+		mddev->size = 0;
+		mddev->raid_disks = 0;
+
 		disk = mddev->gendisk;
 		if (disk)
 			set_capacity(disk, 0);
