Return-Path: <linux-kernel-owner+w=401wt.eu-S1422761AbWLUG0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422761AbWLUG0j (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 01:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422758AbWLUG0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 01:26:39 -0500
Received: from cantor2.suse.de ([195.135.220.15]:53846 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422754AbWLUG0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 01:26:38 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 21 Dec 2006 17:27:04 +1100
Message-Id: <1061221062704.4950@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] md: Fix a few problems with the interface (sysfs and ioctl) to md.
References: <20061221172556.4916.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch is suitable for 2.6.20.  It fixes some minor bugs that
need to be fix in order to use new functionality in mdadm-2.6.
Thanks,
NeilBrown


### Comments for Changeset

While developing more functionality in mdadm I found some bugs in md...

- When we remove a device from an inactive array (write 'remove' to 
  the 'state' sysfs file - see 'state_store') would should not
  update the superblock information - as we may not have
  read and processed it all properly yet.

- initialise all raid_disk entries to '-1' else the 'slot sysfs file
  will claim '0' for all devices in an array before the array is
  started.

- all '\n' not to be present at the end of words written to
  sysfs files
- when we use SET_ARRAY_INFO to set the md metadata version,
  set the flag to say that there is persistant metadata.
- allow GET_BITMAP_FILE to be called on an array that hasn't
  been started yet.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-12-21 16:29:31.000000000 +1100
+++ ./drivers/md/md.c	2006-12-21 16:29:40.000000000 +1100
@@ -1795,7 +1795,8 @@ state_store(mdk_rdev_t *rdev, const char
 		else {
 			mddev_t *mddev = rdev->mddev;
 			kick_rdev_from_array(rdev);
-			md_update_sb(mddev, 1);
+			if (mddev->pers)
+				md_update_sb(mddev, 1);
 			md_new_event(mddev);
 			err = 0;
 		}
@@ -2007,6 +2008,7 @@ static mdk_rdev_t *md_import_device(dev_
 
 	rdev->desc_nr = -1;
 	rdev->saved_raid_disk = -1;
+	rdev->raid_disk = -1;
 	rdev->flags = 0;
 	rdev->data_offset = 0;
 	rdev->sb_events = 0;
@@ -2236,7 +2238,6 @@ static int update_raid_disks(mddev_t *md
 static ssize_t
 raid_disks_store(mddev_t *mddev, const char *buf, size_t len)
 {
-	/* can only set raid_disks if array is not yet active */
 	char *e;
 	int rv = 0;
 	unsigned long n = simple_strtoul(buf, &e, 10);
@@ -2634,7 +2635,7 @@ metadata_store(mddev_t *mddev, const cha
 		return -EINVAL;
 	buf = e+1;
 	minor = simple_strtoul(buf, &e, 10);
-	if (e==buf || *e != '\n')
+	if (e==buf || (*e && *e != '\n') )
 		return -EINVAL;
 	if (major >= sizeof(super_types)/sizeof(super_types[0]) ||
 	    super_types[major].name == NULL)
@@ -3984,6 +3985,7 @@ static int set_array_info(mddev_t * mdde
 		mddev->major_version = info->major_version;
 		mddev->minor_version = info->minor_version;
 		mddev->patch_version = info->patch_version;
+		mddev->persistent = ! info->not_persistent;
 		return 0;
 	}
 	mddev->major_version = MD_MAJOR_VERSION;
@@ -4309,9 +4311,10 @@ static int md_ioctl(struct inode *inode,
 	 * Commands querying/configuring an existing array:
 	 */
 	/* if we are not initialised yet, only ADD_NEW_DISK, STOP_ARRAY,
-	 * RUN_ARRAY, and SET_BITMAP_FILE are allowed */
+	 * RUN_ARRAY, and GET_ and SET_BITMAP_FILE are allowed */
 	if (!mddev->raid_disks && cmd != ADD_NEW_DISK && cmd != STOP_ARRAY
-			&& cmd != RUN_ARRAY && cmd != SET_BITMAP_FILE) {
+			&& cmd != RUN_ARRAY && cmd != SET_BITMAP_FILE
+	    		&& cmd != GET_BITMAP_FILE) {
 		err = -ENODEV;
 		goto abort_unlock;
 	}
