Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVATPJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVATPJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVATPJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:09:42 -0500
Received: from users.linvision.com ([62.58.92.114]:37271 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262151AbVATPJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:09:05 -0500
Date: Thu, 20 Jan 2005 15:57:39 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: lkml@bitwizard.nl, pavel@ucw.cz, steve@chygwyn.com,
       James.Bottomley@SteelEye.com, Paul.Clements@SteelEye.com,
       erik@harddisk-recovery.nl
Subject: PATCH: nbd fix. 
Message-ID: <20050120145739.GA1189@bitwizard.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


The NBD driver seems to require CAP_SYSADMIN capabilities for 
innocent things like asking what the capacity is. 

Patch attached. 

	Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=nbd_fix

diff -ur linux-2.4.28.clean/drivers/block/nbd.c linux-2.4.28.nbd-fix/drivers/block/nbd.c
--- linux-2.4.28.clean/drivers/block/nbd.c	Wed Jan 19 18:14:01 2005
+++ linux-2.4.28.nbd-fix/drivers/block/nbd.c	Wed Jan 19 16:36:59 2005
@@ -408,10 +408,7 @@
 	int dev, error, temp;
 	struct request sreq ;
 
-	/* Anyone capable of this syscall can do *real bad* things */
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
 	if (!inode)
 		return -EINVAL;
 	dev = MINOR(inode->i_rdev);
@@ -419,6 +416,20 @@
 		return -ENODEV;
 
 	lo = &nbd_dev[dev];
+
+	/* these are innocent, but.... */
+	switch (cmd) {
+	case BLKGETSIZE:
+		return put_user(nbd_bytesizes[dev] >> 9, (unsigned long *) arg);
+	case BLKGETSIZE64:
+		return put_user((u64)nbd_bytesizes[dev], (u64 *) arg);
+	}
+
+	/* ... anyone capable of any of the below ioctls can do *real bad* 
+	   things */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	switch (cmd) {
 	case NBD_DISCONNECT:
 	        printk("NBD_DISCONNECT\n");
@@ -524,10 +535,6 @@
 		       dev, lo->queue_head.next, lo->queue_head.prev, requests_in, requests_out);
 		return 0;
 #endif
-	case BLKGETSIZE:
-		return put_user(nbd_bytesizes[dev] >> 9, (unsigned long *) arg);
-	case BLKGETSIZE64:
-		return put_user((u64)nbd_bytesizes[dev], (u64 *) arg);
 	}
 	return -EINVAL;
 }

--liOOAslEiF7prFVr--
