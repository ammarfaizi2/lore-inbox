Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266921AbRGKXYg>; Wed, 11 Jul 2001 19:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266915AbRGKXY1>; Wed, 11 Jul 2001 19:24:27 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:65271 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266921AbRGKXYG>; Wed, 11 Jul 2001 19:24:06 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107112322.f6BNMsSq010289@webber.adilger.int>
Subject: [PATCH] LVM OOPS fixup
To: torvalds@transmeta.com
Date: Wed, 11 Jul 2001 17:22:54 -0600 (MDT)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux LVM Development list <lvm-devel@sistina.com>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a longstanding user-exploitable OOPS in the LVM code.
I had hopes that in the last several months this fix would make it to the
stock kernel through official channels, but it has not.

The problem is in the LV_BMAP ioctl, which is similar to the FIBMAP ioctl,
so LILO can map kernel/initrd files from an LVM partition.  The current
code incorrectly uses i_dev instead of i_rdev, so you reference an
invalid LV if /boot is not on the root fs.  This causes an immediate NULL
pointer dereference.  I have held back a patch from the LILO maintainer
to add LVM support to LILO until this is fixed in the mainline kernel,
and I don't want to wait any longer.

The patch changes the return value from LV_BMAP to be in blocks (as
the input value was) and not sectors (as lvm_map() returns).  This
is how it has been in LVM CVS for a long time, and how FIBMAP also
works (which makes LILO on LVM happy).

The patch has been in the LVM CVS repository for many months and is also
in the -ac kernel.  It also includes one other minor fix from LVM CVS
(SNAPSHOT_MIN_CHUNK) which should be added to the stock kernel as well,
not that there aren't lots more, but you have to start somewhere.

Cheers, Andreas

PS - lvm-devel is CC'd but for an unknown reason I have not gotten any
     email from any of the LVM mailing lists in the last month or so,
     so replies should be sent to me directly or to linux-kernel.  Yes,
     I'm still subscribed to the lists (according to the web subscription
     page), and I tried emailing the list maintainer a couple of days ago
     with alternate contact email addresses in case of problems.

=========================================================================
diff -ru linux-2.4.6.orig/Documentation/ioctl-number.txt linux-2.4.6-aed/Documentation/ioctl-number.txt
--- linux-2.4.6.orig/Documentation/ioctl-number.txt	Tue May 29 13:12:42 2001
+++ linux-2.4.6-aed/Documentation/ioctl-number.txt	Mon Jun  4 17:16:42 2001
@@ -187,3 +187,5 @@
 0xB1	00-1F	PPPoX			<mailto:mostrows@styx.uwaterloo.ca>
 0xCB	00-1F	CBM serial IEC bus	in development:
 					<mailto:michael.klein@puffin.lb.shuttle.de>
+
+0xFE	00-9F	Logical Volume Manager	<mailto:linux-lvm@sistina.com>
diff -ru linux-2.4.6.orig/drivers/md/lvm.c linux-2.4.6-aed/drivers/md/lvm.c
--- linux-2.4.6.orig/drivers/md/lvm.c	Tue May  8 17:16:13 2001
+++ linux-2.4.6-aed/drivers/md/lvm.c	Tue Jun 19 11:57:39 2001
@@ -988,6 +990,10 @@
 
 	case LV_BMAP:
 		/* turn logical block into (dev_t, block). non privileged. */
+		/* don't bmap a snapshot, since the mapping can change */
+		if (lv_ptr->lv_access & LV_SNAPSHOT)
+			return -EPERM;
+
 		return lvm_user_bmap(inode, (struct lv_bmap *) arg);
 		break;

@@ -1075,8 +1101,8 @@
 		return -EFAULT;
 
 	memset(&bh,0,sizeof bh);
-	bh.b_rsector = block;
-	bh.b_dev = bh.b_rdev = inode->i_dev;
+	bh.b_blocknr = block;
+	bh.b_dev = bh.b_rdev = inode->i_rdev;
 	bh.b_size = lvm_get_blksize(bh.b_dev);
 	if ((err=lvm_map(&bh, READ)) < 0)  {
 		printk("lvm map failed: %d\n", err);
@@ -1084,7 +1110,8 @@
 	}
 
 	return put_user(kdev_t_to_nr(bh.b_rdev), &user_result->lv_dev) ||
-	put_user(bh.b_rsector, &user_result->lv_block) ? -EFAULT : 0;
+	       put_user(bh.b_rsector/(bh.b_size>>9), &user_result->lv_block) ?
+	       -EFAULT : 0;
 }
 
 
diff -ru linux-2.4.6.orig/include/linux/lvm.h linux-2.4.6-aed/include/linux/lvm.h
--- linux-2.4.6.orig/include/linux/lvm.h	Tue Apr 10 16:43:37 2001
+++ linux-2.4.6-aed/include/linux/lvm.h	Thu Jun 28 15:52:52 2001
@@ -299,7 +314,7 @@
 
 #define	LVM_SNAPSHOT_MAX_CHUNK	1024	/* 1024 KB */
 #define	LVM_SNAPSHOT_DEF_CHUNK	64	/* 64  KB */
-#define	LVM_SNAPSHOT_MIN_CHUNK	1	/* 1   KB */
+#define	LVM_SNAPSHOT_MIN_CHUNK	(PAGE_SIZE/1024)	/* 4 or 8 KB */
 
 #define	UNDEF	-1
 #define FALSE	0
@@ -585,7 +585,7 @@
 } le_remap_req_t;
 
 typedef struct lv_bmap {
-	ulong lv_block;
+	uint32_t lv_block;
 	dev_t lv_dev;
 } lv_bmap_t;
 
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
