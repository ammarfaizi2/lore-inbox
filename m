Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278709AbRJ1WOa>; Sun, 28 Oct 2001 17:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278703AbRJ1WOX>; Sun, 28 Oct 2001 17:14:23 -0500
Received: from [63.231.122.81] ([63.231.122.81]:25146 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S278707AbRJ1WNZ>;
	Sun, 28 Oct 2001 17:13:25 -0500
Date: Sun, 28 Oct 2001 00:10:19 -0600
From: Andreas Dilger <adilger@turbolabs.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Subject: [PATCH] more lvm merging
Message-ID: <20011028001019.A4229@lynx.no>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	lvm-devel@sistina.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
this patch is a further merge of LVM CVS into the main kernel.  It again
is a simple code-reorg (moving a big chunk of code into a helper function
and does not impact actual operations).  This should also already be in
Alan's LVM codebase.

Also, (I don't want to send a huge patch to do this) renaming the file
drivers/md/lvm-snap.h to drivers/md/lvm-internal.h (and fix the #includes
in drivers/md/lvm.c and drivers/md/lvm-snap.c) would be a big help in
getting the kernel up-to-date with LVM CVS.

Cheers, Andreas
===========================================================================
--- linux.orig/drivers/md/lvm.c	Thu Oct 25 03:04:38 2001
+++ linux/drivers/md/lvm.c	Sat Oct 27 14:26:43 2001
@@ -998,40 +1014,11 @@
 		break;
 
 	case LV_SNAPSHOT_USE_RATE:
-		if (!(lv_ptr->lv_access & LV_SNAPSHOT)) return -EPERM;
-		{
-			lv_snapshot_use_rate_req_t	lv_snapshot_use_rate_req;
-
-			if (copy_from_user(&lv_snapshot_use_rate_req, arg,
-					   sizeof(lv_snapshot_use_rate_req_t)))
-				return -EFAULT;
-			if (lv_snapshot_use_rate_req.rate < 0 ||
-			    lv_snapshot_use_rate_req.rate  > 100) return -EFAULT;
-
-			switch (lv_snapshot_use_rate_req.block)
-			{
-			case 0:
-				lv_ptr->lv_snapshot_use_rate = lv_snapshot_use_rate_req.rate;
-				if (lv_ptr->lv_remap_ptr * 100 / lv_ptr->lv_remap_end < lv_ptr->lv_snapshot_use_rate)
-					interruptible_sleep_on (&lv_ptr->lv_snapshot_wait);
-				break;
-
-			case O_NONBLOCK:
-				break;
-
-			default:
-				return -EFAULT;
-			}
-			lv_snapshot_use_rate_req.rate = lv_ptr->lv_remap_ptr * 100 / lv_ptr->lv_remap_end;
-			if (copy_to_user(arg, &lv_snapshot_use_rate_req,
-					 sizeof(lv_snapshot_use_rate_req_t)))
-				return -EFAULT;
-		}
-		break;
+		return lvm_get_snapshot_use_rate(lv_ptr, arg);
 
 	default:
 		printk(KERN_WARNING
-		       "%s -- lvm_blk_ioctl: unknown command %d\n",
+		       "%s -- lvm_blk_ioctl: unknown command 0x%x\n",
 		       lvm_name, command);
 		return -EINVAL;
 	}
@@ -1063,6 +1047,38 @@
 	return 0;
 } /* lvm_blk_close() */
 
+static int lvm_get_snapshot_use_rate(lv_t *lv, void *arg)
+{
+	lv_snapshot_use_rate_req_t lv_rate_req;
+
+	if (!(lv->lv_access & LV_SNAPSHOT))
+		return -EPERM;
+
+	if (copy_from_user(&lv_rate_req, arg, sizeof(lv_rate_req)))
+		return -EFAULT;
+
+	if (lv_rate_req.rate < 0 || lv_rate_req.rate > 100)
+		return -EINVAL;
+
+	switch (lv_rate_req.block) {
+	case 0:
+		lv->lv_snapshot_use_rate = lv_rate_req.rate;
+		if (lv->lv_remap_ptr * 100 / lv->lv_remap_end <
+		    lv->lv_snapshot_use_rate)
+			interruptible_sleep_on(&lv->lv_snapshot_wait);
+		break;
+
+	case O_NONBLOCK:
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	lv_rate_req.rate = lv->lv_remap_ptr * 100 / lv->lv_remap_end;
+
+	return copy_to_user(arg, &lv_rate_req,
+			    sizeof(lv_rate_req)) ? -EFAULT : 0;
+}
 
 static int lvm_user_bmap(struct inode *inode, struct lv_bmap *user_result)
 {
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

