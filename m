Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263179AbVCDXcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbVCDXcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbVCDXXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:23:00 -0500
Received: from fire.osdl.org ([65.172.181.4]:57498 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263237AbVCDVRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:17:24 -0500
Message-Id: <200503042117.j24LHJLM017976@shell0.pdx.osdl.net>
Subject: [patch 5/5] make st seekable again
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, kai.makisara@kolumbus.fi
From: akpm@osdl.org
Date: Fri, 04 Mar 2005 13:16:58 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Kai Makisara <kai.makisara@kolumbus.fi>

Apparently `tar' errors out if it cannot perform lseek() against a tape.  Work
around that in-kernel.

Signed-off-by: Kai Makisara <kai.makisara@kolumbus.fi>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/ide/ide-tape.c |    8 +++++++-
 25-akpm/drivers/scsi/osst.c    |    8 +++++++-
 25-akpm/drivers/scsi/st.c      |    8 +++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff -puN drivers/ide/ide-tape.c~make-st-seekable-again drivers/ide/ide-tape.c
--- 25/drivers/ide/ide-tape.c~make-st-seekable-again	2005-03-04 13:16:32.000000000 -0800
+++ 25-akpm/drivers/ide/ide-tape.c	2005-03-04 13:16:32.000000000 -0800
@@ -4100,7 +4100,13 @@ static int idetape_chrdev_open (struct i
 	idetape_pc_t pc;
 	int retval;
 
-	nonseekable_open(inode, filp);
+	/*
+	 * We really want to do nonseekable_open(inode, filp); here, but some
+	 * versions of tar incorrectly call lseek on tapes and bail out if that
+	 * fails.  So we disallow pread() and pwrite(), but permit lseeks.
+	 */
+	filp->f_mode &= ~(FMODE_PREAD | FMODE_PWRITE);
+
 #if IDETAPE_DEBUG_LOG
 	printk(KERN_INFO "ide-tape: Reached idetape_chrdev_open\n");
 #endif /* IDETAPE_DEBUG_LOG */
diff -puN drivers/scsi/st.c~make-st-seekable-again drivers/scsi/st.c
--- 25/drivers/scsi/st.c~make-st-seekable-again	2005-03-04 13:16:32.000000000 -0800
+++ 25-akpm/drivers/scsi/st.c	2005-03-04 13:16:32.000000000 -0800
@@ -1004,7 +1004,13 @@ static int st_open(struct inode *inode, 
 	int dev = TAPE_NR(inode);
 	char *name;
 
-	nonseekable_open(inode, filp);
+	/*
+	 * We really want to do nonseekable_open(inode, filp); here, but some
+	 * versions of tar incorrectly call lseek on tapes and bail out if that
+	 * fails.  So we disallow pread() and pwrite(), but permit lseeks.
+	 */
+	filp->f_mode &= ~(FMODE_PREAD | FMODE_PWRITE);
+
 	write_lock(&st_dev_arr_lock);
 	if (dev >= st_dev_max || scsi_tapes == NULL ||
 	    ((STp = scsi_tapes[dev]) == NULL)) {
diff -puN drivers/scsi/osst.c~make-st-seekable-again drivers/scsi/osst.c
--- 25/drivers/scsi/osst.c~make-st-seekable-again	2005-03-04 13:16:32.000000000 -0800
+++ 25-akpm/drivers/scsi/osst.c	2005-03-04 13:16:32.000000000 -0800
@@ -4318,7 +4318,13 @@ static int os_scsi_tape_open(struct inod
 	int		      dev  = TAPE_NR(inode);
 	int		      mode = TAPE_MODE(inode);
 
-	nonseekable_open(inode, filp);
+	/*
+	 * We really want to do nonseekable_open(inode, filp); here, but some
+	 * versions of tar incorrectly call lseek on tapes and bail out if that
+	 * fails.  So we disallow pread() and pwrite(), but permit lseeks.
+	 */
+	filp->f_mode &= ~(FMODE_PREAD | FMODE_PWRITE);
+
 	write_lock(&os_scsi_tapes_lock);
 	if (dev >= osst_max_dev || os_scsi_tapes == NULL ||
 	    (STp = os_scsi_tapes[dev]) == NULL || !STp->device) {
_
