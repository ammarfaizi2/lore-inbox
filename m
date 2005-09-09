Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030517AbVIIVDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030517AbVIIVDt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 17:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbVIIVDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 17:03:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:16573 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030344AbVIIVDp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 17:03:45 -0400
Date: Fri, 9 Sep 2005 22:03:44 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] __user annotations (scsi/ch)
Message-ID: <20050909210344.GF9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git7-s2io-u64/drivers/scsi/ch.c RC13-git7-scsi-ch/drivers/scsi/ch.c
--- RC13-git7-s2io-u64/drivers/scsi/ch.c	2005-08-28 23:09:45.000000000 -0400
+++ RC13-git7-scsi-ch/drivers/scsi/ch.c	2005-09-07 13:55:19.000000000 -0400
@@ -565,7 +565,7 @@
 	return result;
 }
 
-static int ch_gstatus(scsi_changer *ch, int type, unsigned char *dest)
+static int ch_gstatus(scsi_changer *ch, int type, unsigned char __user *dest)
 {
 	int retval = 0;
 	u_char data[16];
@@ -639,6 +639,7 @@
 {
 	scsi_changer *ch = file->private_data;
 	int retval;
+	void __user *argp = (void __user *)arg;
 	
 	switch (cmd) {
 	case CHIOGPARAMS:
@@ -651,7 +652,7 @@
 		params.cp_nportals  = ch->counts[CHET_IE];
 		params.cp_ndrives   = ch->counts[CHET_DT];
 		
-		if (copy_to_user((void *) arg, &params, sizeof(params)))
+		if (copy_to_user(argp, &params, sizeof(params)))
 			return -EFAULT;
 		return 0;
 	}
@@ -676,7 +677,7 @@
 			vparams.cvp_n4  = ch->counts[CHET_V4];
 			strncpy(vparams.cvp_label4,vendor_labels[3],16);
 		}
-		if (copy_to_user((void *) arg, &vparams, sizeof(vparams)))
+		if (copy_to_user(argp, &vparams, sizeof(vparams)))
 			return -EFAULT;
 		return 0;
 	}
@@ -685,7 +686,7 @@
 	{
 		struct changer_position pos;
 		
-		if (copy_from_user(&pos, (void*)arg, sizeof (pos)))
+		if (copy_from_user(&pos, argp, sizeof (pos)))
 			return -EFAULT;
 
 		if (0 != ch_checkrange(ch, pos.cp_type, pos.cp_unit)) {
@@ -704,7 +705,7 @@
 	{
 		struct changer_move mv;
 
-		if (copy_from_user(&mv, (void*)arg, sizeof (mv)))
+		if (copy_from_user(&mv, argp, sizeof (mv)))
 			return -EFAULT;
 
 		if (0 != ch_checkrange(ch, mv.cm_fromtype, mv.cm_fromunit) ||
@@ -726,7 +727,7 @@
 	{
 		struct changer_exchange mv;
 		
-		if (copy_from_user(&mv, (void*)arg, sizeof (mv)))
+		if (copy_from_user(&mv, argp, sizeof (mv)))
 			return -EFAULT;
 
 		if (0 != ch_checkrange(ch, mv.ce_srctype,  mv.ce_srcunit ) ||
@@ -751,7 +752,7 @@
 	{
 		struct changer_element_status ces;
 		
-		if (copy_from_user(&ces, (void*)arg, sizeof (ces)))
+		if (copy_from_user(&ces, argp, sizeof (ces)))
 			return -EFAULT;
 		if (ces.ces_type < 0 || ces.ces_type >= CH_TYPES)
 			return -EINVAL;
@@ -767,7 +768,7 @@
 		unsigned int elem;
 		int     result,i;
 		
-		if (copy_from_user(&cge, (void*)arg, sizeof (cge)))
+		if (copy_from_user(&cge, argp, sizeof (cge)))
 			return -EFAULT;
 
 		if (0 != ch_checkrange(ch, cge.cge_type, cge.cge_unit))
@@ -830,7 +831,7 @@
 		kfree(buffer);
 		up(&ch->lock);
 		
-		if (copy_to_user((void*)arg, &cge, sizeof (cge)))
+		if (copy_to_user(argp, &cge, sizeof (cge)))
 			return -EFAULT;
 		return result;
 	}
@@ -848,7 +849,7 @@
 		struct changer_set_voltag csv;
 		int elem;
 
-		if (copy_from_user(&csv, (void*)arg, sizeof(csv)))
+		if (copy_from_user(&csv, argp, sizeof(csv)))
 			return -EFAULT;
 
 		if (0 != ch_checkrange(ch, csv.csv_type, csv.csv_unit)) {
@@ -866,7 +867,7 @@
 	}
 
 	default:
-		return scsi_ioctl(ch->device, cmd, (void*)arg);
+		return scsi_ioctl(ch->device, cmd, argp);
 
 	}
 }
@@ -899,9 +900,9 @@
 	case CHIOGSTATUS32:
 	{
 		struct changer_element_status32 ces32;
-		unsigned char *data;
+		unsigned char __user *data;
 		
-		if (copy_from_user(&ces32, (void*)arg, sizeof (ces32)))
+		if (copy_from_user(&ces32, (void __user *)arg, sizeof (ces32)))
 			return -EFAULT;
 		if (ces32.ces_type < 0 || ces32.ces_type >= CH_TYPES)
 			return -EINVAL;
diff -urN RC13-git7-s2io-u64/include/linux/chio.h RC13-git7-scsi-ch/include/linux/chio.h
--- RC13-git7-s2io-u64/include/linux/chio.h	2005-08-28 23:09:48.000000000 -0400
+++ RC13-git7-scsi-ch/include/linux/chio.h	2005-09-07 13:55:19.000000000 -0400
@@ -96,7 +96,7 @@
  */
 struct changer_element_status {
 	int             ces_type;
-	unsigned char   *ces_data;
+	unsigned char   __user *ces_data;
 };
 #define CESTATUS_FULL     0x01 /* full */
 #define CESTATUS_IMPEXP   0x02	/* media was imported (inserted by sysop) */
