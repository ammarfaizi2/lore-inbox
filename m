Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966097AbWKJG2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966097AbWKJG2I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 01:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966098AbWKJG2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 01:28:08 -0500
Received: from cantor2.suse.de ([195.135.220.15]:32730 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S966097AbWKJG2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 01:28:05 -0500
From: Neil Brown <neilb@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 10 Nov 2006 17:28:11 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17748.7163.111098.788069@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fbuihuu@gmail.com, adaplas@pol.net, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.19-rc5-mm1: HPC nx6325 breakage, VESA fb problem, md-raid problem
In-Reply-To: message from Rafael J. Wysocki on Thursday November 9
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	<20061108165540.0d3c4340.akpm@osdl.org>
	<200611090204.45299.rjw@sisk.pl>
	<200611091642.01453.rjw@sisk.pl>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 9, rjw@sisk.pl wrote:
> On Thursday, 9 November 2006 02:04, Rafael J. Wysocki wrote:
> > > > and the kernel says it cannot mount the root fs (which is on an md-raid).
> > > 
> > > hm, there was probably some earlier message which tells us why that
> > > happened.  Doing a capure-and-compare on the dmesg output would be nice
> > > (netconsole?)
> 
> This happens because of md-change-lifetime-rules-for-md-devices.patch and
> seems to be a universal breakage.

Thanks for the report.
Are you at all interested in confirming that this version of the patch
works for you?  I'm fairly sure it will, but I've been wrong before.

Thanks either-way.

NeilBrown

----------------------------------------------
Subject: Change lifetime rules for 'md' devices.

Currently md devices are created when first opened and remain in existence
until the module is unloaded.
This isn't a major problem, but it somewhat ugly.

This patch changes the lifetime rules so that an md device will
disappear on the last close if it has no state.

Locking rules depend on bd_mutex being held in do_open and
__blkdev_put, and on setting bd_disk->private_data to 'mddev'.

There is room for a race because md_probe is called early in do_open
(get_gendisk) to create the mddev.  As this isn't protected by
bd_mutex, a concurrent call to md_close can destroy that mddev before
do_open calls md_open to get a reference on it.
md_open and md_close are serialised by md_mutex so the worst that
can happen is that md_open finds that the mddev structure doesn't
exist after all.  In this case bd_disk->private_data will be NULL,
and md_open chooses to exit with -EBUSY in this case, which is
arguable and appropriate result.

The new 'dead' field in mddev is used to track whether it is time
to destroy the mddev (if a last-close happens).  It is cleared when
any state is create (set_array_info) and set when the array is stopped
(do_md_stop).

mddev_put becomes simpler. It just destroys the mddev when the
refcount hits zero.  This will normally be the reference held in
bd_disk->private_data.
  

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c           |   32 +++++++++++++++++++++++---------
 ./include/linux/raid/md_k.h |    3 +++
 2 files changed, 26 insertions(+), 9 deletions(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-11-10 17:12:55.000000000 +1100
+++ ./drivers/md/md.c	2006-11-10 17:23:25.000000000 +1100
@@ -226,13 +226,14 @@ static void mddev_put(mddev_t *mddev)
 {
 	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
 		return;
-	if (!mddev->raid_disks && list_empty(&mddev->disks)) {
-		list_del(&mddev->all_mddevs);
-		spin_unlock(&all_mddevs_lock);
-		blk_cleanup_queue(mddev->queue);
-		kobject_unregister(&mddev->kobj);
-	} else
-		spin_unlock(&all_mddevs_lock);
+	list_del(&mddev->all_mddevs);
+	spin_unlock(&all_mddevs_lock);
+
+	del_gendisk(mddev->gendisk);
+	mddev->gendisk = NULL;
+	blk_cleanup_queue(mddev->queue);
+	mddev->queue = NULL;
+	kobject_unregister(&mddev->kobj);
 }
 
 static mddev_t * mddev_find(dev_t unit)
@@ -273,6 +274,7 @@ static mddev_t * mddev_find(dev_t unit)
 	atomic_set(&new->active, 1);
 	spin_lock_init(&new->write_lock);
 	init_waitqueue_head(&new->sb_wait);
+	new->dead = 1;
 
 	new->queue = blk_alloc_queue(GFP_KERNEL);
 	if (!new->queue) {
@@ -1384,6 +1386,7 @@ static int bind_rdev_to_array(mdk_rdev_t
 		ko = &rdev->bdev->bd_disk->kobj;
 	sysfs_create_link(&rdev->kobj, ko, "block");
 	bd_claim_by_disk(rdev->bdev, rdev, mddev->gendisk);
+	mddev->dead = 0;
 	return 0;
 }
 
@@ -3360,6 +3363,8 @@ static int do_md_stop(mddev_t * mddev, i
 		mddev->array_size = 0;
 		mddev->size = 0;
 		mddev->raid_disks = 0;
+		mddev->dead = 1;
+
 		mddev->recovery_cp = 0;
 
 	} else if (mddev->pers)
@@ -4022,6 +4027,7 @@ static int set_array_info(mddev_t * mdde
 	mddev->new_layout = mddev->layout;
 	mddev->delta_disks = 0;
 
+	mddev->dead = 0;
 	return 0;
 }
 
@@ -4422,8 +4428,12 @@ static int md_open(struct inode *inode, 
 	 * Succeed if we can lock the mddev, which confirms that
 	 * it isn't being stopped right now.
 	 */
-	mddev_t *mddev = inode->i_bdev->bd_disk->private_data;
-	int err;
+	mddev_t *mddev;
+	int err = -EBUSY;
+
+	mddev = inode->i_bdev->bd_disk->private_data;
+	if (!mddev)
+		goto out;
 
 	if ((err = mutex_lock_interruptible_nested(&mddev->reconfig_mutex, 1)))
 		goto out;
@@ -4442,6 +4452,10 @@ static int md_release(struct inode *inod
  	mddev_t *mddev = inode->i_bdev->bd_disk->private_data;
 
 	BUG_ON(!mddev);
+	if (inode->i_bdev->bd_openers == 0 && mddev->dead) {
+		inode->i_bdev->bd_disk->private_data = NULL;
+		mddev_put(mddev);
+	}
 	mddev_put(mddev);
 
 	return 0;

diff .prev/include/linux/raid/md_k.h ./include/linux/raid/md_k.h
--- .prev/include/linux/raid/md_k.h	2006-11-10 17:12:55.000000000 +1100
+++ ./include/linux/raid/md_k.h	2006-11-10 17:16:50.000000000 +1100
@@ -119,6 +119,9 @@ struct mddev_s
 #define MD_CHANGE_PENDING 2	/* superblock update in progress */
 
 	int				ro;
+	int				dead; /* array should be discarded on
+					       * last close
+					       */
 
 	struct gendisk			*gendisk;
 
