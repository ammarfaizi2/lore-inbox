Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131585AbRAOV0F>; Mon, 15 Jan 2001 16:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131570AbRAOVZy>; Mon, 15 Jan 2001 16:25:54 -0500
Received: from pD95071BA.dip.t-dialin.net ([217.80.113.186]:19420 "EHLO
	linux-buechse.de") by vger.kernel.org with ESMTP id <S131502AbRAOVZg>;
	Mon, 15 Jan 2001 16:25:36 -0500
From: Juergen E Fischer <fischer@linux-buechse.de>
Date: Mon, 15 Jan 2001 22:24:35 +0100
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: SCSI scanner problem with all kernels since 2.3.42
Message-ID: <20010115222434.A9099@linux-buechse.de>
In-Reply-To: <3A5B7A2E.E3F964A8@torque.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A5B7A2E.E3F964A8@torque.net>; from dougg@torque.net on Tue, Jan 09, 2001 at 03:53:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Doug,

On Tue, Jan 09, 2001 at 03:53:02PM -0500, Douglas Gilbert wrote:
> There is also a problem report with the  SnapScan 1236 <--> aha152x 
> combination also based on SANE 1.0.3 . This one is looking 
> like an "uninitialized errno" bug fixed in SANE 1.0.4 .

This should be solved with the attached patch.   As you might remember
it's the same problem we already discussed with Abel Deuring.

Normally there should be no need to use REQUEST SENSE from outside,
when the driver supports auto-sense. It should be wrong as devices are
required to clear the sense data after the first, automatically issued
REQUEST SENSE.  BTW the new eh code requires low-level drivers to do
auto-sense.  The driver assumed that these are wrong and ignores them.
This behaviour was adopted from the aha1542 driver.

But for the SnapScan REQUEST SENSE is not only used on CHECK CONDITION,
but also to request the warmup time.  Therefore the REQUEST SENSE is
valid here and proves the assumption wrong for such devices.

Even more worse is that the driver returned SUCCESS instead of 0 on
REQUEST SENSE.  That's plain wrong and apparently tells the mid-level
code not to queue any more commands.

The warmup time issue with the SnapScan (and maybe other devices) should
also apply to the aha1542 driver.


Juergen

-- 
Juergen E Fischer


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="aha152x.diff"
Content-Transfer-Encoding: 8bit

diff -ur orig/linux/drivers/scsi/aha152x.c linux/drivers/scsi/aha152x.c
--- orig/linux/drivers/scsi/aha152x.c	Fri Dec 29 23:35:47 2000
+++ linux/drivers/scsi/aha152x.c	Sun Jan 14 21:31:12 2001
@@ -1,6 +1,6 @@
 /* aha152x.c -- Adaptec AHA-152x driver
  * Author: Jürgen E. Fischer, fischer@norbit.de
- * Copyright 1993-1999 Jürgen E. Fischer
+ * Copyright 1993-2000 Jürgen E. Fischer
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -13,9 +13,13 @@
  * General Public License for more details.
  *
  *
- * $Id: aha152x.c,v 2.3 2000/11/04 16:40:26 fischer Exp $
+ * $Id: aha152x.c,v 2.4 2000/12/16 12:53:56 fischer Exp $
  *
  * $Log: aha152x.c,v $
+ * Revision 2.4  2000/12/16 12:53:56  fischer
+ * - allow REQUEST SENSE to be queued
+ * - handle shared PCI interrupts
+ *
  * Revision 2.3  2000/11/04 16:40:26  fischer
  * - handle data overruns
  * - extend timeout for data phases
@@ -932,6 +936,8 @@
         	printk(KERN_ERR "aha152x%d: catched software interrupt for unknown controller.\n", HOSTNO);
 
 	HOSTDATA(shpnt)->swint++;
+
+	SETPORT(DMACNTRL0, INTEN);
 }
 
 
@@ -1274,7 +1280,7 @@
 		SETPORT(SIMODE0, 0);
 		SETPORT(SIMODE1, 0);
 
-		ok = request_irq(shpnt->irq, swintr, SA_INTERRUPT, "aha152x", shpnt);
+		ok = request_irq(shpnt->irq, swintr, SA_INTERRUPT|SA_SHIRQ, "aha152x", shpnt);
 		if (ok < 0) {
 			if (ok==-EINVAL)
 				printk(KERN_ERR "aha152x%d: bad IRQ %d.\n", HOSTNO, shpnt->irq);
@@ -1308,6 +1314,8 @@
 				printk("failed.\n");
 			}
 
+			SETPORT(DMACNTRL0, INTEN);
+
 			printk(KERN_ERR "aha152x%d: IRQ %d possibly wrong.  Please verify.\n", HOSTNO, shpnt->irq);
 
 			registered_count--;
@@ -1319,13 +1327,12 @@
 		}
 		printk("ok.\n");
 
-		SETPORT(DMACNTRL0, INTEN);
 
 		/* clear interrupts */
 		SETPORT(SSTAT0, 0x7f);
 		SETPORT(SSTAT1, 0xef);
 
-		if (request_irq(shpnt->irq, intr, SA_INTERRUPT, "aha152x", shpnt) < 0) {
+		if (request_irq(shpnt->irq, intr, SA_INTERRUPT|SA_SHIRQ, "aha152x", shpnt) < 0) {
 			printk(KERN_ERR "aha152x%d: failed to reassign interrupt.\n", HOSTNO);
 
 			scsi_unregister(shpnt);
@@ -1469,12 +1476,14 @@
 
 int aha152x_queue(Scsi_Cmnd *SCpnt, void (*done)(Scsi_Cmnd *))
 {
+#if 0
 	if(*SCpnt->cmnd == REQUEST_SENSE) {
 		SCpnt->result = 0;
 		done(SCpnt);
 
-		return SUCCESS;
+		return 0;
 	}
+#endif
 
 	return aha152x_internal_queue(SCpnt, 0, 0, 0, done);
 }
diff -ur orig/linux/drivers/scsi/aha152x.h linux/drivers/scsi/aha152x.h
--- orig/linux/drivers/scsi/aha152x.h	Mon Dec 11 22:19:02 2000
+++ linux/drivers/scsi/aha152x.h	Fri Jan 12 13:18:24 2001
@@ -2,7 +2,7 @@
 #define _AHA152X_H
 
 /*
- * $Id: aha152x.h,v 2.3 2000/11/04 16:41:37 fischer Exp $
+ * $Id: aha152x.h,v 2.4 2000/12/16 12:48:48 fischer Exp $
  */
 
 #if defined(__KERNEL__)
@@ -27,7 +27,7 @@
    (unless we support more than 1 cmd_per_lun this should do) */
 #define AHA152X_MAXQUEUE 7
 
-#define AHA152X_REVID "Adaptec 152x SCSI driver; $Revision: 2.3 $"
+#define AHA152X_REVID "Adaptec 152x SCSI driver; $Revision: 2.4 $"
 
 /* Initial value of Scsi_Host entry */
 #define AHA152X { proc_name:			"aha152x",		\

--Kj7319i9nmIyA2yE--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
