Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269148AbUJESPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269148AbUJESPF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 14:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269135AbUJESPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 14:15:04 -0400
Received: from lists.us.dell.com ([143.166.224.162]:58475 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S269148AbUJESOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 14:14:14 -0400
Date: Tue, 5 Oct 2004 13:13:39 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Paul Bristow <paul@paulbristow.net>, B.Zolnierkiewicz@elka.pw.edu.pl,
       alan@redhat.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] idefloppy suppress media not present errors
Message-ID: <20041005181339.GA9479@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul, Bartlomiej, Alan:

Below is a patch to suppress printing uninformative errors from
ide-floppy.c in response to commands to floppy drives in which no
media is present.

Without this patch, commands sent to ide-floppy devices without media
inserted cause error messages on the console (KERN_ERR level) such as:

ide-floppy: ide: I/O error, pc = 0 key = 2, asc = 3a asq = 0
ide-floppy: ide: I/O error, pc = 1b key = 2, asc = 3a asq = 0
ide-floppy: ide: I/O error, pc = 23 key = 2, asc = 3a asq = 0
ide-floppy: ide: I/O error, pc = 1e key = 2, asc = 3a asq = 0
ide-floppy: ide: I/O error, pc = 1e key = 2, asc = 3a asq = 0

Dell's Virtual Floppy (system management presents to the local system
an IDE floppy device, which is actually a floppy device in a remote
system connected over an IP link) exhibits this also, when connecting
to a remote floppy drive with no media present.

Please review and apply.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


===== ide-floppy.c 1.40 vs edited =====
--- 1.40/drivers/ide/ide-floppy.c	2004-08-12 19:03:53 -05:00
+++ edited/ide-floppy.c	2004-10-05 11:13:59 -05:00
@@ -989,6 +989,20 @@
 	return ide_started;
 }
 
+/**
+ * idefloppy_should_report_error()
+ *
+ * Supresses error messages resulting from Medium not present
+ */
+static inline int idefloppy_should_report_error(idefloppy_floppy_t *floppy)
+{
+	if (floppy->sense_key == 0x02 &&
+	    floppy->asc       == 0x3a &&
+	    floppy->ascq      == 0x00)
+		return 0;
+	return 1;
+}
+
 /*
  *	Issue a packet command
  */
@@ -1021,12 +1035,13 @@
 		 */
 		if (!test_bit(PC_ABORT, &pc->flags)) {
 			if (!test_bit(PC_SUPPRESS_ERROR, &pc->flags)) {
-				printk(KERN_ERR "ide-floppy: %s: I/O error, "
-						"pc = %2x, key = %2x, "
-						"asc = %2x, ascq = %2x\n",
-						drive->name, pc->c[0],
-						floppy->sense_key,
-						floppy->asc, floppy->ascq);
+				if (idefloppy_should_report_error(floppy))
+					printk(KERN_ERR "ide-floppy: %s: I/O error, "
+					       "pc = %2x, key = %2x, "
+					       "asc = %2x, ascq = %2x\n",
+					       drive->name, pc->c[0],
+					       floppy->sense_key,
+					       floppy->asc, floppy->ascq);
 			}
 			/* Giving up */
 			pc->error = IDEFLOPPY_ERROR_GENERAL;
@@ -1242,11 +1257,13 @@
 			rq->nr_sectors, rq->current_nr_sectors);
 
 	if (rq->errors >= ERROR_MAX) {
-		if (floppy->failed_pc != NULL)
-			printk(KERN_ERR "ide-floppy: %s: I/O error, pc = %2x,"
-					" key = %2x, asc = %2x, ascq = %2x\n",
-				drive->name, floppy->failed_pc->c[0],
-				floppy->sense_key, floppy->asc, floppy->ascq);
+		if (floppy->failed_pc != NULL) {
+			if (idefloppy_should_report_error(floppy))
+				printk(KERN_ERR "ide-floppy: %s: I/O error, pc = %2x,"
+				       " key = %2x, asc = %2x, ascq = %2x\n",
+				       drive->name, floppy->failed_pc->c[0],
+				       floppy->sense_key, floppy->asc, floppy->ascq);
+		}
 		else
 			printk(KERN_ERR "ide-floppy: %s: I/O error\n",
 				drive->name);
