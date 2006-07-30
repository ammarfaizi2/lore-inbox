Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWG3U47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWG3U47 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 16:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWG3U47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 16:56:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51365 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932143AbWG3U46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 16:56:58 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>
Subject: Re: let md auto-detect 128+ raid members, fix potential race condition
References: <ork65veg2y.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<20060730124139.45861b47.akpm@osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Sun, 30 Jul 2006 17:56:31 -0300
In-Reply-To: <20060730124139.45861b47.akpm@osdl.org> (Andrew Morton's message of "Sun, 30 Jul 2006 12:41:39 -0700")
Message-ID: <orac6qerr4.fsf@free.oliva.athome.lsd.ic.unicamp.br>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

On Jul 30, 2006, Andrew Morton <akpm@osdl.org> wrote:

> On Sun, 30 Jul 2006 03:56:21 -0300
> Alexandre Oliva <aoliva@redhat.com> wrote:

>> -void md_autodetect_dev(dev_t dev);
>> +int md_register_autodetect_dev(dev_t dev);

> Put it in a header file, please.
 
AFAICT it really isn't supposed to be used elsewhere.  I suppose I
could add it to either blkdev.h, fs.h or raid/md.h, since it's more of
glue code between two modules than something that belongs to one
specific module.  E.g., if it goes in raid/md.h, where it feels the
most appropriate, then fs/parititions/check.c has to include it, which
doesn't sound right.  OTOH, if it goes in blkdev.h or fs.h, then a lot
of code ends up seeing the declaration that shouldn't be available.
Thoughts?

Maybe we could replace this with some register/unregister notifier
interface, such that add_partitions() could then notify multiple
watchers when a new partition is configured.  This would remove the
backwards dependency here, but I feel it should be done in a separate
patch.  I don't mind if they're integrated at once, but I don't feel
that changing two unrelated issues at once is a good approach.

>> +	if (!ldev)
>> +	  return -1;

> whitespace broke.

Oops, thanks, fixed below.

>> #ifdef CONFIG_BLK_DEV_MD
>> -		if (state->parts[p].flags)
>> -			md_autodetect_dev(bdev->bd_dev+p);
>> +		if (state->parts[p].flags
>> +		    && md_register_autodetect_dev(bdev->bd_dev+p))
>> +			printk(KERN_ERR "md: out of memory registering %s%d\n",
>> +			       disk->disk_name, p);
>> #endif

> What happens if CONFIG_BLK_DEV_MD=m?

AFAIK then you'd get a link failure.  One more reason to go with the
notifier approach, I guess.  It wouldn't quite enable md to
auto-detect from partitions set up before the module was loaded, but
it would at least remove this presumed link error.

Another approach would be to split the autodetect stuff out of md.c
into a separate file that goes in the main kernel image (if
CONFIG_MD=y, it's never m) even if CONFIG_BLK_DEV_MD=m.  Would this be
a desirable arrangement?


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=raid-detected-list.patch

Index: kernel-2.6.17-1.2462.fc6/drivers/md/md.c
===================================================================
--- kernel-2.6.17-1.2462.fc6.orig/drivers/md/md.c	2006-07-30 01:03:28.000000000 -0300
+++ kernel-2.6.17-1.2462.fc6/drivers/md/md.c	2006-07-30 03:40:54.000000000 -0300
@@ -1435,7 +1435,7 @@ static void unlock_rdev(mdk_rdev_t *rdev
 	blkdev_put_partition(bdev);
 }
 
-void md_autodetect_dev(dev_t dev);
+int md_register_autodetect_dev(dev_t dev);
 
 static void export_rdev(mdk_rdev_t * rdev)
 {
@@ -1447,7 +1447,8 @@ static void export_rdev(mdk_rdev_t * rde
 	free_disk_sb(rdev);
 	list_del_init(&rdev->same_set);
 #ifndef MODULE
-	md_autodetect_dev(rdev->bdev->bd_dev);
+	if (md_register_autodetect_dev(rdev->bdev->bd_dev))
+		printk(KERN_ERR "md: out of memory re-registering %s\n", b);
 #endif
 	unlock_rdev(rdev);
 	kobject_put(&rdev->kobj);
@@ -5575,27 +5576,40 @@ static int __init md_init(void)
  * Searches all registered partitions for autorun RAID arrays
  * at boot time.
  */
-static dev_t detected_devices[128];
-static int dev_cnt;
+static LIST_HEAD(detected_devices);
+static DEFINE_SPINLOCK(detected_devices_lock);
 
-void md_autodetect_dev(dev_t dev)
+struct detected_dev_list_t {
+	struct list_head list;
+	dev_t dev;
+};
+
+int md_register_autodetect_dev(dev_t dev)
 {
-	if (dev_cnt >= 0 && dev_cnt < 127)
-		detected_devices[dev_cnt++] = dev;
+	struct detected_dev_list_t *ldev = kzalloc(sizeof (*ldev), GFP_KERNEL);
+
+	if (!ldev)
+	  return -1;
+
+	ldev->dev = dev;
+
+	spin_lock(&detected_devices_lock);
+	list_add_tail(&ldev->list, &detected_devices);
+	spin_unlock(&detected_devices_lock);
+
+	return 0;
 }
 
 
 static void autostart_arrays(int part)
 {
-	mdk_rdev_t *rdev;
-	int i;
+	struct detected_dev_list_t *ldev, *next;
 
 	printk(KERN_INFO "md: Autodetecting RAID arrays.\n");
 
-	for (i = 0; i < dev_cnt; i++) {
-		dev_t dev = detected_devices[i];
-
-		rdev = md_import_device(dev,0, 0);
+	spin_lock(&detected_devices_lock);
+	list_for_each_entry_safe(ldev, next, &detected_devices, list) {
+		mdk_rdev_t *rdev = md_import_device(ldev->dev, 0, 0);
 		if (IS_ERR(rdev))
 			continue;
 
@@ -5604,8 +5618,11 @@ static void autostart_arrays(int part)
 			continue;
 		}
 		list_add(&rdev->same_set, &pending_raid_disks);
+		list_del(&ldev->list);
+		kfree(ldev);
 	}
-	dev_cnt = 0;
+	BUG_ON(!list_empty(&detected_devices));
+	spin_unlock(&detected_devices_lock);
 
 	autorun_devices(part);
 }
Index: kernel-2.6.17-1.2462.fc6/fs/partitions/check.c
===================================================================
--- kernel-2.6.17-1.2462.fc6.orig/fs/partitions/check.c	2006-07-30 01:03:34.000000000 -0300
+++ kernel-2.6.17-1.2462.fc6/fs/partitions/check.c	2006-07-30 03:41:02.000000000 -0300
@@ -36,7 +36,7 @@
 #include "karma.h"
 
 #ifdef CONFIG_BLK_DEV_MD
-extern void md_autodetect_dev(dev_t dev);
+extern int md_register_autodetect_dev(dev_t dev);
 #endif
 
 int warn_no_part = 1; /*This is ugly: should make genhd removable media aware*/
@@ -471,8 +471,10 @@ int rescan_partitions(struct gendisk *di
 		}
 		add_partition(disk, p, from, size);
 #ifdef CONFIG_BLK_DEV_MD
-		if (state->parts[p].flags)
-			md_autodetect_dev(bdev->bd_dev+p);
+		if (state->parts[p].flags
+		    && md_register_autodetect_dev(bdev->bd_dev+p))
+			printk(KERN_ERR "md: out of memory registering %s%d\n",
+			       disk->disk_name, p);
 #endif
 	}
 	kfree(state);

--=-=-=


-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
Secretary for FSF Latin America        http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}

--=-=-=--
