Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289028AbSAIVnS>; Wed, 9 Jan 2002 16:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289030AbSAIVnJ>; Wed, 9 Jan 2002 16:43:09 -0500
Received: from daytona.gci.com ([205.140.80.57]:59910 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S289028AbSAIVm7> convert rfc822-to-8bit;
	Wed, 9 Jan 2002 16:42:59 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA31506DB46F4@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ScanLogic USB-ATAPI Adapter (Thread followup)
Date: Wed, 9 Jan 2002 12:42:53 -0900 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Posted this to the usb-devel list, but for the folks here that
are interested in the outcome of the earlier thread, feel free
to beat up on this, or if it doesn't work for you, submit your
device information to me and i'll work on getting it supported.

This patch should apply pretty cleanly to 2.4 (tested with .16)
and 2.5 (.2-pre9 tested)

-----Original Message-----
From: Leif Sawyer
Sent: Wednesday, January 09, 2002 9:20 AM
To: Matthew Dharm; linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] ScanLogic USB-ATAPI Adapter, please apply


Matthew Dharm writes:
> I'm not going to patch anything until either:
> (a) You determine what's wrong with Rene's setup and fix it, or
> (b) You determine that your issue is orthogonal to his

Both (a) and (b).   We have different revs of the same hardware, and
of course what's good for the goose isn't for the gander.

Here's the results, tested across multiple revs, all working:

--- usb.h.dist	Fri Dec 14 16:17:44 2001
+++ usb.h	Mon Jan  7 20:40:13 2002
@@ -101,6 +101,7 @@
 #define US_FL_IGNORE_SER      0x00000010 /* Ignore the serial number given
*/
 #define US_FL_SCM_MULT_TARG   0x00000020 /* supports multiple targets */
 #define US_FL_FIX_INQUIRY     0x00000040 /* INQUIRY response needs fixing
*/
+#define US_FL_SL_IDE_BUG      0x00000100 /* ScanLogic usb-ide workaround */
 
 #define USB_STOR_STRING_LEN 32
 
--- transport.c.dist	Fri Nov  9 13:37:14 2001
+++ transport.c	Tue Jan  8 07:51:10 2002
@@ -1157,7 +1157,7 @@
 		  le32_to_cpu(bcs.Signature), bcs.Tag, 
 		  bcs.Residue, bcs.Status);
 	if (bcs.Signature != cpu_to_le32(US_BULK_CS_SIGN) || 
-	    bcs.Tag != bcb.Tag || 
+	    ((bcs.Tag != bcb.Tag ) && (!(us->flags & US_FL_SL_IDE_BUG))) || 
 	    bcs.Status > US_BULK_STAT_PHASE || partial != 13) {
 		US_DEBUGP("Bulk logical error\n");
 		return USB_STOR_TRANSPORT_ERROR;

--- unusual_devs.h.dist	Fri Dec 14 16:17:51 2001
+++ unusual_devs.h	Tue Jan  8 07:47:57 2002
@@ -86,6 +86,27 @@
 		"FinePix 1400Zoom",
 		US_SC_8070, US_PR_CBI, NULL, US_FL_FIX_INQUIRY),
 
+/* Reported by Peter Wächtler */
+UNUSUAL_DEV(  0x04ce, 0x0002, 0x0074, 0x0074,
+		"ScanLogic",
+		"SL11R-IDE 0049SQFP-1.2 A002",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_FIX_INQUIRY ),
+
+/* Reported by Leif Sawyer */
+UNUSUAL_DEV(  0x04ce, 0x0002, 0x0240, 0x0240,
+		"H45 ScanLogic",
+		"SL11R-IDE 9951SQFP-1.2 K004",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_FIX_INQUIRY | US_FL_SL_IDE_BUG ),
+
+/* Reported by Rene Engelhard and Dylan Egan */
+UNUSUAL_DEV(  0x04ce, 0x0002, 0x0260, 0x0260,
+		"ScanLogic",
+		"SL11R-IDE unknown HW rev",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_SL_IDE_BUG ),
+
 /* Most of the following entries were developed with the help of
  * Shuttle/SCM directly.
  */
<---------------- cut here


_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
