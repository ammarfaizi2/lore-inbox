Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318069AbSHaXZq>; Sat, 31 Aug 2002 19:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318067AbSHaXZq>; Sat, 31 Aug 2002 19:25:46 -0400
Received: from hera.cwi.nl ([192.16.191.8]:43651 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S318060AbSHaXZk>;
	Sat, 31 Aug 2002 19:25:40 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 1 Sep 2002 01:29:58 +0200 (MEST)
Message-Id: <UTC200208312329.g7VNTwF11470.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, mdharm-usb@one-eyed-alien.net
Subject: Feiya 5-in-1 Card Reader
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a USB 5-in-1 Card Reader, that will read CF and SM and SD/MMC.
Under Linux it appears as three SCSI devices.
For today, the report is on the CF part.

The CF part works fine under ordinary usb-storage SCSI simulation,
with one small problem: 8 and 32 MB cards, that are detected as
having 15872 and 63488 sectors by other readers, are detected as
having 15873 and 63489 sectors by this Feiya reader
(0x090c / 0x1132).
In the good old days probably nobody would have noticed, but these
days the partition reading code also wants to read the last sector.
This results in the SCSI code taking the device off line:

[USB storage does a READ_10, which fails since the sector is past
the end of the disk. Then it tries a READ_6 and nothing ever happens,
probably because the device does not support READ_6. Then the
error handler does an abort which triggers some bugs in scsiglue.c
and transport.c, then the error handler does a device reset, then
a host reset, then a bus reset, and finally the device is taken offline.]

The patch below does not address any bugs in the SCSI error code
(a big improvement would be just to rip it all out - this error code
never achieves anything useful but has crashed many a machine)
and does not fix the USB code either.
It just adds a flag to the unusual_devices section mentioning that
this device (my revision is 1.00) has this bug.

Without the patch the kernel crashes, or insmod usb-storage hangs.
With the patch the CF part of the device works perfectly.

(Another change is to only print "Fixing INQUIRY data" when
really something is changed, not when the data was OK already.)

Andries


diff -u --recursive --new-file -X /linux/dontdiff a/drivers/usb/storage/protocol.c b/drivers/usb/storage/protocol.c
--- a/drivers/usb/storage/protocol.c	Sun Jun  9 07:26:30 2002
+++ b/drivers/usb/storage/protocol.c	Sun Sep  1 00:23:37 2002
@@ -54,10 +54,27 @@
  * Helper routines
  ***********************************************************************/
 
-/* Fix-up the return data from an INQUIRY command to show 
+static void *
+find_data_location(Scsi_Cmnd *srb) {
+	if (srb->use_sg) {
+		/*
+		 * This piece of code only works if the first page is
+		 * big enough to hold more than 3 bytes -- which is
+		 * _very_ likely.
+		 */
+		struct scatterlist *sg;
+
+		sg = (struct scatterlist *) srb->request_buffer;
+		return (void *) page_address(sg[0].page) + sg[0].offset;
+	} else
+		return (void *) srb->request_buffer;
+}
+
+/*
+ * Fix-up the return data from an INQUIRY command to show 
  * ANSI SCSI rev 2 so we don't confuse the SCSI layers above us
  */
-void fix_inquiry_data(Scsi_Cmnd *srb)
+static void fix_inquiry_data(Scsi_Cmnd *srb)
 {
 	unsigned char *data_ptr;
 
@@ -65,24 +82,43 @@
 	if (srb->cmnd[0] != INQUIRY)
 		return;
 
-	US_DEBUGP("Fixing INQUIRY data to show SCSI rev 2\n");
+	data_ptr = find_data_location(srb);
 
-	/* find the location of the data */
-	if (srb->use_sg) {
-		/* this piece of code only works if the first page is big enough to
-		 * hold more than 3 bytes -- which is _very_ likely
-		 */
-		struct scatterlist *sg;
+	if ((data_ptr[2] & 7) == 2)
+		return;
 
-		sg = (struct scatterlist *) srb->request_buffer;
-		data_ptr = (unsigned char *) page_address(sg[0].page) + sg[0].offset;
-	} else
-		data_ptr = (unsigned char *)srb->request_buffer;
+	US_DEBUGP("Fixing INQUIRY data to show SCSI rev 2 - was %d\n",
+		  data_ptr[2] & 7);
 
 	/* Change the SCSI revision number */
 	data_ptr[2] = (data_ptr[2] & ~7) | 2;
 }
 
+/*
+ * Fix-up the return data from a READ CAPACITY command. My Feiya reader
+ * returns a value that is 1 too large.
+ */
+static void fix_read_capacity(Scsi_Cmnd *srb)
+{
+	unsigned char *dp;
+	unsigned long capacity;
+
+	/* verify that it's a READ CAPACITY command */
+	if (srb->cmnd[0] != READ_CAPACITY)
+		return;
+
+	dp = find_data_location(srb);
+
+	capacity = (dp[0]<<24) + (dp[1]<<16) + (dp[2]<<8) + (dp[3]);
+	US_DEBUGP("US: Fixing capacity: from %ld to %ld\n",
+	       capacity+1, capacity);
+	capacity--;
+	dp[0] = (capacity >> 24);
+	dp[1] = (capacity >> 16);
+	dp[2] = (capacity >> 8);
+	dp[3] = (capacity);
+}
+
 /***********************************************************************
  * Protocol routines
  ***********************************************************************/
@@ -346,8 +382,11 @@
 		if ((us->flags & US_FL_MODE_XLATE) && (old_cmnd == MODE_SENSE))
 			usb_stor_scsiSense10to6(srb);
 
-		/* fix the INQUIRY data if necessary */
+		/* Fix the INQUIRY data if necessary */
 		fix_inquiry_data(srb);
+
+		/* Fix the READ CAPACITY result if necessary */
+		if (us->flags & US_FL_FIX_CAPACITY)
+			fix_read_capacity(srb);
 	}
 }
-
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
--- a/drivers/usb/storage/unusual_devs.h	Tue Aug 27 23:58:37 2002
+++ b/drivers/usb/storage/unusual_devs.h	Sun Sep  1 00:30:30 2002
@@ -507,6 +507,13 @@
 		US_SC_8070, US_PR_CB, NULL,
 		US_FL_FIX_INQUIRY ),
 
+/* aeb */
+UNUSUAL_DEV( 0x090c, 0x1132, 0x0000, 0xffff,
+	        "Feiya",
+	        "5-in-1 Card Reader",
+	        US_SC_SCSI, US_PR_BULK, NULL,
+	        US_FL_FIX_CAPACITY ),
+
 UNUSUAL_DEV(  0x097a, 0x0001, 0x0000, 0x0001,
 		"Minds@Work",
 		"Digital Wallet",
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/usb/storage/usb.h b/drivers/usb/storage/usb.h
--- a/drivers/usb/storage/usb.h	Tue Aug 27 23:58:37 2002
+++ b/drivers/usb/storage/usb.h	Sun Sep  1 00:18:31 2002
@@ -102,6 +102,7 @@
 #define US_FL_IGNORE_SER      0x00000010 /* Ignore the serial number given  */
 #define US_FL_SCM_MULT_TARG   0x00000020 /* supports multiple targets	    */
 #define US_FL_FIX_INQUIRY     0x00000040 /* INQUIRY response needs fixing   */
+#define US_FL_FIX_CAPACITY    0x00000080 /* READ CAPACITY response too big  */
 
 #define US_FL_DEV_ATTACHED    0x00010000 /* is the device attached?	    */
 #define US_FLIDX_IP_WANTED   17  /* 0x00020000	is an IRQ expected?	    */
