Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVCaHub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVCaHub (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVCaHuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:50:21 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:27293 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261192AbVCaHqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:46:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=pkCFYWkRXMWCxnIVsmqmcP2oVcu4z4stvsoWPMGwyfXRJZOWVY21V4PgbElosFHe0pSDO3J58cEBDa0hbl05WKoBAUhpB5BENGLX0LHAkyDfj/igqTA90GvuCbw3hwrbXAGgReQWjuOv7ZljCwh2+MVRUo4lDTwiQQ3DdETz8Rw=
Message-ID: <df35dfeb05033023463a986df4@mail.gmail.com>
Date: Wed, 30 Mar 2005 23:46:51 -0800
From: Yum Rayan <yum.rayan@gmail.com>
Reply-To: Yum Rayan <yum.rayan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Reduce stack usage in time.c
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to reduce stack usage in time.c (linux-2.6.12-rc1-mm3). Stack
usage was noted using checkstack.pl. Specifically:

Before patch
------------
sys_adjtimex - 128

After patch
-----------
sys_adjtimex - none (register usage only)

Signed-off-by: Yum Rayan <yum.rayan@gmail.com>

--- a/kernel/time.c	2005-03-25 22:11:06.000000000 -0800
+++ b/kernel/time.c	2005-03-30 16:59:51.000000000 -0800
@@ -413,17 +413,27 @@
 
 asmlinkage long sys_adjtimex(struct timex __user *txc_p)
 {
-	struct timex txc;		/* Local copy of parameter */
-	int ret;
+	struct timex *txc;		/* Local copy of parameter */
+	int retval;
+
+	txc = kmalloc(sizeof(struct timex), GFP_KERNEL);
+	if (!txc)
+		return -ENOMEM;
 
 	/* Copy the user data space into the kernel copy
 	 * structure. But bear in mind that the structures
 	 * may change
 	 */
-	if(copy_from_user(&txc, txc_p, sizeof(struct timex)))
-		return -EFAULT;
-	ret = do_adjtimex(&txc);
-	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
+	if(copy_from_user(txc, txc_p, sizeof(struct timex))) {
+		retval = -EFAULT;
+		goto free_txc;
+	}
+	retval = do_adjtimex(txc);
+	if (copy_to_user(txc_p, txc, sizeof(struct timex)))
+		retval = -EFAULT;
+free_txc:
+	kfree(txc);
+	return retval;
 }
 
 inline struct timespec current_kernel_time(void)
