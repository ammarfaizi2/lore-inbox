Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271420AbTHRMTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271692AbTHRMTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:19:54 -0400
Received: from hera.cwi.nl ([192.16.191.8]:6882 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S271687AbTHRMTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:19:47 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 18 Aug 2003 14:19:41 +0200 (MEST)
Message-Id: <UTC200308181219.h7ICJfw14963.aeb@smtp.cwi.nl>
To: Dominik.Strasser@t-online.de, hch@infradead.org
Subject: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -    u_char  block_length_hi;
> +    u8  block_length_hi;

I see that Linus already applied this, but I am quite unhappy with
these changes. Entirely needlessly user space software is broken.

This file scsi.h was specifically designed for inclusion
in user space programs. (For our favorite mantra: "no inclusion
from user space", see below.) The header still proclaims this:

/*
 * This header file contains public constants and structures used by
 * the scsi code for linux.
 */

Slowly over time the file has been polluted with random scsi-related
stuff. But now inclusion has been made a lot more difficult -
A strange type u8, and the inclusion of <linux/types.h>, a really
bad idea in user space.

The right approach is not to break userspace without any kernel
benefit whatsoever, but to eliminate the accumulated cruft from
scsi.h.

For example, this unfortunate discussion started with the u8 in
ScsiLun, but this concept, introduced in 2.5.11, has been almost
entirely removed again in 2.5.69, and today only occurs in
scsi_debug.c. So, we can do

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
--- a/drivers/scsi/scsi_debug.c	Mon Jul 28 05:39:31 2003
+++ b/drivers/scsi/scsi_debug.c	Mon Aug 18 14:16:12 2003
@@ -57,6 +57,13 @@
 
 static const char * scsi_debug_version_str = "Version: 1.70 (20030507)";
 
+/*
+ * ScsiLun: 8 byte LUN.
+ */
+typedef struct scsi_lun {
+	u8 scsi_lun[8];
+} ScsiLun;
+
 /* Additional Sense Code (ASC) used */
 #define NO_ADDED_SENSE 0x0
 #define UNRECOVERED_READ_ERR 0x11
@@ -65,7 +72,7 @@
 #define INVALID_FIELD_IN_CDB 0x24
 #define POWERON_RESET 0x29
 #define SAVING_PARAMS_UNSUP 0x39
-#define THRESHHOLD_EXCEEDED 0x5d
+#define THRESHOLD_EXCEEDED 0x5d
 
 #define SDEBUG_TAGGED_QUEUING 0 /* 0 | MSG_SIMPLE_TAG | MSG_ORDERED_TAG */
 
@@ -415,7 +422,7 @@
 		errsts = resp_read(SCpnt, upper_blk, block, num, devip);
 		if (inj_recovered && (0 == errsts)) {
 			mk_sense_buffer(devip, RECOVERED_ERROR, 
-					THRESHHOLD_EXCEEDED, 0, 18);
+					THRESHOLD_EXCEEDED, 0, 18);
 			errsts = check_condition_result;
 		}
 		break;
@@ -453,7 +460,7 @@
 		errsts = resp_write(SCpnt, upper_blk, block, num, devip);
 		if (inj_recovered && (0 == errsts)) {
 			mk_sense_buffer(devip, RECOVERED_ERROR, 
-					THRESHHOLD_EXCEEDED, 0, 18);
+					THRESHOLD_EXCEEDED, 0, 18);
 			errsts = check_condition_result;
 		}
 		break;
diff -u --recursive --new-file -X /linux/dontdiff a/include/scsi/scsi.h b/include/scsi/scsi.h
--- a/include/scsi/scsi.h	Fri May 30 18:12:58 2003
+++ b/include/scsi/scsi.h	Mon Aug 18 14:10:42 2003
@@ -223,13 +223,6 @@
 };
 
 /*
- * ScsiLun: 8 byte LUN.
- */
-typedef struct scsi_lun {
-	u8 scsi_lun[8];
-} ScsiLun;
-
-/*
  *  MESSAGE CODES
  */
 

Andries


[
Yes, about our famous mantra: "User space must not include kernel headers".
I know it. Indeed, I invented it. These days I need not say it so often -
hch is my prophet.
But we should never forget that this is a bad deficiency of Linux,
not something to be proud of. At some point in time we must separate
out headers into the ABI-defining structures and constants, and the
kernel-internal stuff. In the meantime we should try not to pollute
headers that are perfectly good for user space with kernel-specific stuff.
]
