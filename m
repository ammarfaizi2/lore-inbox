Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270479AbTHGUNH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270484AbTHGUNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:13:07 -0400
Received: from hera.cwi.nl ([192.16.191.8]:20719 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S270479AbTHGUM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:12:56 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 7 Aug 2003 22:12:55 +0200 (MEST)
Message-Id: <UTC200308072012.h77KCtf02202.aeb@smtp.cwi.nl>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH] use ide-identify.h, fix endian bug
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given ide-identify.h, we can simplify ide-floppy.c and ide-tape.c a lot.
In fact ide-tape.c was broken on big-endian machines.
(Unfortunately much more is broken that was fixed here,
ide-tape.c is not in a good shape today.)

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	Wed Aug  6 23:02:38 2003
+++ b/drivers/ide/ide-floppy.c	Thu Aug  7 22:13:37 2003
@@ -392,32 +392,6 @@
 #define	IDEFLOPPY_ERROR_GENERAL		101
 
 /*
- *	The following is used to format the general configuration word of
- *	the ATAPI IDENTIFY DEVICE command.
- */
-struct idefloppy_id_gcw {	
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned packet_size		:2;	/* Packet Size */
-	unsigned reserved234		:3;	/* Reserved */
-	unsigned drq_type		:2;	/* Command packet DRQ type */
-	unsigned removable		:1;	/* Removable media */
-	unsigned device_type		:5;	/* Device type */
-	unsigned reserved13		:1;	/* Reserved */
-	unsigned protocol		:2;	/* Protocol type */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned protocol		:2;	/* Protocol type */
-	unsigned reserved13		:1;	/* Reserved */
-	unsigned device_type		:5;	/* Device type */
-	unsigned removable		:1;	/* Removable media */
-	unsigned drq_type		:2;	/* Command packet DRQ type */
-	unsigned reserved234		:3;	/* Reserved */
-	unsigned packet_size		:2;	/* Packet Size */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-};
-
-/*
  *	INQUIRY packet command - Data Format
  */
 typedef struct {
@@ -1646,33 +1620,32 @@
 
 static int idefloppy_identify_device (ide_drive_t *drive,struct hd_driveid *id)
 {
-	struct idefloppy_id_gcw gcw;
-
-	*((u16 *) &gcw) = id->config;
+	int devtype = atapi_device_type(id);
 
 #ifdef CONFIG_PPC
 	/* kludge for Apple PowerBook internal zip */
-	if ((gcw.device_type == 5) &&
-	    !strstr(id->model, "CD-ROM") &&
-	    strstr(id->model, "ZIP"))
-		gcw.device_type = 0;			
+	if (devtype == ATAPI_CD_ROM &&
+	    !strstr(id->model, "CD-ROM") && strstr(id->model, "ZIP"))
+		devtype = 0;		
 #endif
 
 #if IDEFLOPPY_DEBUG_INFO
         ide_dump_identify_info(id, "ide-floppy");
 #endif /* IDETAPE_DEBUG_INFO */
 
-	if (gcw.protocol != 2)
+	if (!ide_is_atapi(id))
 		printk(KERN_ERR "ide-floppy: Protocol is not ATAPI\n");
-	else if (gcw.device_type != 0)
-		printk(KERN_ERR "ide-floppy: Device type is not set to floppy\n");
-	else if (!gcw.removable)
+	else if (devtype != 0)
+		printk(KERN_ERR
+		       "ide-floppy: Device type is not set to floppy\n");
+	else if (!ide_is_removable(id))
 		printk(KERN_ERR "ide-floppy: The removable flag is not set\n");
-	else if (gcw.drq_type == 3) {
-		printk(KERN_ERR "ide-floppy: Sorry, DRQ type %d not supported\n", gcw.drq_type);
-	} else if (gcw.packet_size != 0) {
-		printk(KERN_ERR "ide-floppy: Packet size is not 12 bytes long\n");
-	} else
+	else if (atapi_drq_type(id) == 3)
+		printk(KERN_ERR
+		       "ide-floppy: Sorry, DRQ type 3 not supported\n");
+	else if (atapi_packet_size(id) != ATAPI_12BYTE)
+		printk(KERN_ERR "ide-floppy: Packet size is not 12 bytes\n");
+	else
 		return 1;
 	return 0;
 }
@@ -1695,15 +1668,12 @@
  */
 static void idefloppy_setup (ide_drive_t *drive, idefloppy_floppy_t *floppy)
 {
-	struct idefloppy_id_gcw gcw;
-
-	*((u16 *) &gcw) = drive->id->config;
 	drive->driver_data = floppy;
 	drive->ready_stat = 0;
 	memset(floppy, 0, sizeof(idefloppy_floppy_t));
 	floppy->drive = drive;
 	floppy->pc = floppy->pc_stack;
-	if (gcw.drq_type == 1)
+	if (atapi_drq_sets_intrq(drive->id))
 		set_bit(IDEFLOPPY_DRQ_INTERRUPT, &floppy->flags);
 	/*
 	 *	We used to check revisions here. At this point however
@@ -1714,6 +1684,9 @@
 	 *	and the workaround below used to hide it. It should
 	 *	be fixed as of version 1.9, but to be on the safe side
 	 *	we'll leave the limitation below for the 2.2.x tree.
+	 *
+	 *	(Note - often the model string contains more spaces.
+	 *	the below check is inaccurate.)
 	 */
 
 	if (strcmp(drive->id->model, "IOMEGA ZIP 100 ATAPI") == 0) {
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	Wed Aug  6 20:45:59 2003
+++ b/drivers/ide/ide-tape.c	Thu Aug  7 21:49:09 2003
@@ -1194,20 +1194,6 @@
 } idetape_chrdev_t;
 
 /*
- *	The following is used to format the general configuration word of
- *	the ATAPI IDENTIFY DEVICE command.
- */
-struct idetape_id_gcw {	
-	unsigned packet_size		:2;	/* Packet Size */
-	unsigned reserved234		:3;	/* Reserved */
-	unsigned drq_type		:2;	/* Command packet DRQ type */
-	unsigned removable		:1;	/* Removable media */
-	unsigned device_type		:5;	/* Device type */
-	unsigned reserved13		:1;	/* Reserved */
-	unsigned protocol		:2;	/* Protocol type */
-};
-
-/*
  *	INQUIRY packet command - Data Format (From Table 6-8 of QIC-157C)
  */
 typedef struct {
@@ -5588,30 +5574,28 @@
 
 static int idetape_identify_device (ide_drive_t *drive)
 {
-	struct idetape_id_gcw gcw;
 	struct hd_driveid *id = drive->id;
 
 	if (drive->id_read == 0)
 		return 1;
 
-	*((unsigned short *) &gcw) = id->config;
-
 #if IDETAPE_DEBUG_INFO
 	ide_dump_identify_info(id, "ide-tape");
 #endif /* IDETAPE_DEBUG_INFO */
 
 	/* Check that we can support this device */
 
-	if (gcw.protocol !=2 )
+	if (!ide_is_atapi(id))
 		printk(KERN_ERR "ide-tape: Protocol is not ATAPI\n");
-	else if (gcw.device_type != 1)
+	else if (atapi_device_type(id) != ATAPI_SEQUENTIAL_ACCESS)
 		printk(KERN_ERR "ide-tape: Device type is not set to tape\n");
-	else if (!gcw.removable)
+	else if (ide_is_removable(id))
 		printk(KERN_ERR "ide-tape: The removable flag is not set\n");
-	else if (gcw.packet_size != 0) {
-		printk(KERN_ERR "ide-tape: Packet size is not 12 bytes long\n");
-		if (gcw.packet_size == 1)
-			printk(KERN_ERR "ide-tape: Sorry, padding to 16 bytes is still not supported\n");
+	else if (atapi_packet_size(id) != ATAPI_12BYTE) {
+		printk(KERN_ERR "ide-tape: Packet size is not 12 bytes\n");
+		if (atapi_packet_size(id) == ATAPI_16BYTE)
+			printk(KERN_ERR "ide-tape: Sorry, padding to 16 bytes"
+			       " is not supported yet\n");
 	} else
 		return 1;
 	return 0;
@@ -5946,7 +5930,6 @@
 {
 	unsigned long t1, tmid, tn, t;
 	int speed;
-	struct idetape_id_gcw gcw;
 	int stage_size;
 	struct sysinfo si;
 
@@ -5977,8 +5960,8 @@
 	tape->pc = tape->pc_stack;
 	tape->max_insert_speed = 10000;
 	tape->speed_control = 1;
-	*((unsigned short *) &gcw) = drive->id->config;
-	if (gcw.drq_type == 1)
+
+	if (atapi_drq_sets_intrq(drive->id))
 		set_bit(IDETAPE_DRQ_INTERRUPT, &tape->flags);
 
 	tape->min_pipeline = tape->max_pipeline = tape->max_stages = 10;
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/ide-identify.h b/include/linux/ide-identify.h
--- a/include/linux/ide-identify.h	Wed Aug  6 20:45:59 2003
+++ b/include/linux/ide-identify.h	Thu Aug  7 21:51:26 2003
@@ -67,6 +67,10 @@
  *  31: unknown or no device
  * just like for SCSI
  */
+#define ATAPI_DIRECT_ACCESS	0
+#define ATAPI_SEQUENTIAL_ACCESS	1
+#define ATAPI_CD_ROM		5
+
 static inline int
 atapi_device_type(const struct hd_driveid *id) {
 	return (id->config & 0x1f00) >> 8;
@@ -84,6 +88,10 @@
 }
 
 /* 0: 12 bytes, 1: 16 bytes, 2,3: reserved */
+
+#define ATAPI_12BYTE	0
+#define ATAPI_16BYTE	1
+
 static inline int
 atapi_packet_size(const struct hd_driveid *id) {
 	return (id->config & 0x0003);
