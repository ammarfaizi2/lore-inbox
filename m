Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317269AbSFLKF1>; Wed, 12 Jun 2002 06:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317377AbSFLKF0>; Wed, 12 Jun 2002 06:05:26 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:13545 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S317269AbSFLKFZ>; Wed, 12 Jun 2002 06:05:25 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Wed, 12 Jun 2002 20:05:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15623.7418.873420.697290@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] - and RFC - O_EXCL for block devices
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fs/block_dev.c contains bd_claim and bd_release that can be used to
provide exclusive access to block devices.
This is currently used when mounting a filesystem from a block device,
when enabling swap to a block device, and when incorporating a block
device into an md/raid array.

This patch
  - enhances bd_claim to claim the whole block device when a partition
    is claimed  and
  - (possibly more contravertially) defines open(.., O_EXCL) on a
    block device to bd_claim that device for that file.   This makes
    it trivial for applications like mkfs and fsck to check if a
    device is mounted, but does not stop them from accessing the
    device that is mounted.

    SUS says that open with O_EXCL but without O_CREAT is undefined,
    so this doesn't break SUS compliance.

Other places where bd_claim should be used:

    LVM
    loop

but I'll leave those for others to fix.

NeilBrown
 
(patch against 2.5.21 ... actually cset 1.474)

### Comments for ChangeSet
Extension to block device claiming

1/ when a partition is claimed, claim the whole device for partitioning
2/ when a blockdev is opened O_EXCL, claim for that file.


 ----------- Diffstat output ------------
 block_dev.c |   38 ++++++++++++++++++++++++++++++++++----
 1 files changed, 34 insertions(+), 4 deletions(-)

--- ./fs/block_dev.c	2002/06/12 06:20:49	1.1
+++ ./fs/block_dev.c	2002/06/12 09:57:41
@@ -376,15 +376,34 @@
 	spin_unlock(&bdev_lock);
 }
 
-int bd_claim(struct block_device *bdev, void *holder)
+static int __bd_claim(struct block_device *bdev, void *holder)
 {
 	int res = -EBUSY;
-	spin_lock(&bdev_lock);
 	if (!bdev->bd_holder || bdev->bd_holder == holder) {
 		bdev->bd_holder = holder;
 		bdev->bd_holders++;
 		res = 0;
 	}
+	return res;
+}
+
+static void __bd_release(struct block_device *bdev)
+{
+	if (!--bdev->bd_holders)
+		bdev->bd_holder = NULL;
+}
+
+int bd_claim(struct block_device *bdev, void *holder)
+{
+	int res = 0;
+	spin_lock(&bdev_lock);
+	if (bdev->bd_contains != bdev)
+		res = __bd_claim(bdev->bd_contains, bd_claim);
+	if (!res) {
+		res = __bd_claim(bdev, holder);
+		if (res && bdev->bd_contains != bdev)
+			__bd_release(bdev->bd_contains);
+	}
 	spin_unlock(&bdev_lock);
 	return res;
 }
@@ -392,8 +411,9 @@
 void bd_release(struct block_device *bdev)
 {
 	spin_lock(&bdev_lock);
-	if (!--bdev->bd_holders)
-		bdev->bd_holder = NULL;
+	if (bdev->bd_contains != bdev)
+		__bd_release(bdev->bd_contains);
+	__bd_release(bdev);
 	spin_unlock(&bdev_lock);
 }
 
@@ -653,6 +673,14 @@
 	bd_acquire(inode);
 	bdev = inode->i_bdev;
 
+	if (filp->f_flags & O_EXCL) {
+		int res = bd_claim(bdev, filp);
+		if (res) {
+			bdput(bdev);
+			return res;
+		}
+	}
+
 	return do_open(bdev, inode, filp);
 }	
 
@@ -692,6 +720,8 @@
 
 int blkdev_close(struct inode * inode, struct file * filp)
 {
+	if (inode->i_bdev->bd_holder == filp)
+		bd_release(inode->i_bdev);
 	return blkdev_put(inode->i_bdev, BDEV_FILE);
 }
 


