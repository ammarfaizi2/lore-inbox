Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266489AbRGDCUB>; Tue, 3 Jul 2001 22:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266487AbRGDCTx>; Tue, 3 Jul 2001 22:19:53 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:45168 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S266485AbRGDCTk>; Tue, 3 Jul 2001 22:19:40 -0400
Date: Tue, 3 Jul 2001 22:19:36 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mike@bigstorage.com>, <kevin@bigstorage.com>
Subject: [PATCH] 64 bit scsi read/write
In-Reply-To: <20010703065312.J4841@vestdata.no>
Message-ID: <Pine.LNX.4.33.0107032211120.30968-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2001, Ragnar Kjørstad wrote:

> What about LVM?

Errr, I'll refrain from talking about LVM.

> We'll see what we can do to test the scsi-code. Please send it to us
> when you have code. I guess there are fixes for both generic-scsi code
> and for each controller, right? What controllers are you planning on
> fixing first?
> What tests do you recommend?
> mkfs on a big device, and then putting >2TB data on it?

Here's the [completely untested] generic scsi fixup, but I'm told that
some controllers will break with it.  Give it a whirl and let me know how
many pieces you're left holding. =)  Please note that msdos partitions do
*not* work on devices larger than 2TB, so you'll have to use the scsi disk
directly.  This patch applies on top of v2.4.6-pre8-largeblock4.diff.

Testing wise, I'm looking for tests on ext2, the block device and raw
devices that write out enough data to fill the device and then reads the
data back looking for any corruption.  There are a few test programs I've
got to this end, but I need to clean them up before releasing them.  If
anyone wants to help sort out issues on other filesystems, I'll certainly
track patches and feedback.  Cheers,

		-ben

.... ~/patches/v2.4.6-pre8-lb-scsi.diff ....
diff -ur lb-2.4.6-pre8/drivers/scsi/scsi.h lb-2.4.6-pre8.scsi/drivers/scsi/scsi.h
--- lb-2.4.6-pre8/drivers/scsi/scsi.h	Tue Jul  3 01:31:47 2001
+++ lb-2.4.6-pre8.scsi/drivers/scsi/scsi.h	Tue Jul  3 22:03:16 2001
@@ -351,7 +351,7 @@
 #define DRIVER_MASK         0x0f
 #define SUGGEST_MASK        0xf0

-#define MAX_COMMAND_SIZE    12
+#define MAX_COMMAND_SIZE    16
 #define SCSI_SENSE_BUFFERSIZE   64

 /*
@@ -613,6 +613,7 @@
 	unsigned expecting_cc_ua:1;	/* Expecting a CHECK_CONDITION/UNIT_ATTN
 					 * because we did a bus reset. */
 	unsigned device_blocked:1;	/* Device returned QUEUE_FULL. */
+	unsigned sixteen:1;		/* use 16 byte read / write */
 	unsigned ten:1;		/* support ten byte read / write */
 	unsigned remap:1;	/* support remapping  */
 	unsigned starved:1;	/* unable to process commands because
diff -ur lb-2.4.6-pre8/drivers/scsi/sd.c lb-2.4.6-pre8.scsi/drivers/scsi/sd.c
--- lb-2.4.6-pre8/drivers/scsi/sd.c	Tue Jul  3 22:08:28 2001
+++ lb-2.4.6-pre8.scsi/drivers/scsi/sd.c	Tue Jul  3 22:05:46 2001
@@ -277,11 +277,12 @@

 static int sd_init_command(Scsi_Cmnd * SCpnt)
 {
-	int dev, devm, block, this_count;
+	int dev, devm, this_count;
 	Scsi_Disk *dpnt;
 #if CONFIG_SCSI_LOGGING
 	char nbuff[6];
 #endif
+	blkoff_t block;

 	devm = SD_PARTITION(SCpnt->request.rq_dev);
 	dev = DEVICE_NR(SCpnt->request.rq_dev);
@@ -289,7 +290,7 @@
 	block = SCpnt->request.sector;
 	this_count = SCpnt->request_bufflen >> 9;

-	SCSI_LOG_HLQUEUE(1, printk("Doing sd request, dev = %d, block = %d\n", devm, block));
+	SCSI_LOG_HLQUEUE(1, printk("Doing sd request, dev = %d, block = %"BLKOFF_FMT"\n", devm, block));

 	dpnt = &rscsi_disks[dev];
 	if (devm >= (sd_template.dev_max << 4) ||
@@ -374,7 +375,21 @@

 	SCpnt->cmnd[1] = (SCpnt->lun << 5) & 0xe0;

-	if (((this_count > 0xff) || (block > 0x1fffff)) || SCpnt->device->ten) {
+	if (SCpnt->device->sixteen) {
+		SCpnt->cmnd[0] += READ_16 - READ_6;
+		SCpnt->cmnd[2] = (unsigned char) (block >> 56) & 0xff;
+		SCpnt->cmnd[3] = (unsigned char) (block >> 48) & 0xff;
+		SCpnt->cmnd[4] = (unsigned char) (block >> 40) & 0xff;
+		SCpnt->cmnd[5] = (unsigned char) (block >> 32) & 0xff;
+		SCpnt->cmnd[6] = (unsigned char) (block >> 24) & 0xff;
+		SCpnt->cmnd[7] = (unsigned char) (block >> 16) & 0xff;
+		SCpnt->cmnd[8] = (unsigned char) (block >> 8) & 0xff;
+		SCpnt->cmnd[9] = (unsigned char) block & 0xff;
+		SCpnt->cmnd[10] = (unsigned char) (this_count >> 24) & 0xff;
+		SCpnt->cmnd[11] = (unsigned char) (this_count >> 16) & 0xff;
+		SCpnt->cmnd[12] = (unsigned char) (this_count >> 8) & 0xff;
+		SCpnt->cmnd[13] = (unsigned char) this_count & 0xff;
+	} else if (SCpnt->device->ten || (this_count > 0xff) || (block > 0x1fffff)) {
 		if (this_count > 0xffff)
 			this_count = 0xffff;

@@ -882,14 +897,61 @@
 		 */
 		rscsi_disks[i].ready = 1;

-		rscsi_disks[i].capacity = 1 + ((buffer[0] << 24) |
-					       (buffer[1] << 16) |
-					       (buffer[2] << 8) |
-					       buffer[3]);
+		rscsi_disks[i].capacity = buffer[0];
+		rscsi_disks[i].capacity <<= 8;
+		rscsi_disks[i].capacity |= buffer[1];
+		rscsi_disks[i].capacity <<= 8;
+		rscsi_disks[i].capacity |= buffer[2];
+		rscsi_disks[i].capacity <<= 8;
+		rscsi_disks[i].capacity |= buffer[3];
+		rscsi_disks[i].capacity += 1;

 		sector_size = (buffer[4] << 24) |
 		    (buffer[5] << 16) | (buffer[6] << 8) | buffer[7];

+
+		/* Is this disk larger than 32 bits? */
+		if (rscsi_disks[i].capacity == 0x100000000) {
+			cmd[0] = READ_CAPACITY;
+			cmd[1] = (rscsi_disks[i].device->lun << 5) & 0xe0;
+			cmd[1] |= 0x2;	/* Longlba */
+			memset((void *) &cmd[2], 0, 8);
+			memset((void *) buffer, 0, 8);
+			SRpnt->sr_cmd_len = 0;
+			SRpnt->sr_sense_buffer[0] = 0;
+			SRpnt->sr_sense_buffer[2] = 0;
+
+			SRpnt->sr_data_direction = SCSI_DATA_READ;
+			scsi_wait_req(SRpnt, (void *) cmd, (void *) buffer,
+				    8, SD_TIMEOUT, MAX_RETRIES);
+
+			/* cool!  64 bit goodness... */
+			if (!SRpnt->sr_result) {
+				rscsi_disks[i].capacity = buffer[0];
+				rscsi_disks[i].capacity <<= 8;
+				rscsi_disks[i].capacity |= buffer[1];
+				rscsi_disks[i].capacity <<= 8;
+				rscsi_disks[i].capacity |= buffer[2];
+				rscsi_disks[i].capacity <<= 8;
+				rscsi_disks[i].capacity |= buffer[3];
+				rscsi_disks[i].capacity <<= 8;
+				rscsi_disks[i].capacity |= buffer[4];
+				rscsi_disks[i].capacity <<= 8;
+				rscsi_disks[i].capacity |= buffer[5];
+				rscsi_disks[i].capacity <<= 8;
+				rscsi_disks[i].capacity |= buffer[6];
+				rscsi_disks[i].capacity <<= 8;
+				rscsi_disks[i].capacity |= buffer[7];
+				rscsi_disks[i].capacity += 1;
+
+				sector_size = (buffer[8] << 24) |
+				    (buffer[9] << 16) | (buffer[10] << 8) |
+				     buffer[11];
+
+				SRpnt->sr_device->sixteen = 1;
+			}
+		}
+
 		if (sector_size == 0) {
 			sector_size = 512;
 			printk("%s : sector size 0 reported, assuming 512.\n",
@@ -930,7 +992,7 @@
 			 */
 			int m;
 			int hard_sector = sector_size;
-			int sz = rscsi_disks[i].capacity * (hard_sector/256);
+			blkoff_t sz = rscsi_disks[i].capacity * (hard_sector/256);

 			/* There are 16 minors allocated for each major device */
 			for (m = i << 4; m < ((i + 1) << 4); m++) {
@@ -938,7 +1000,7 @@
 			}

 			printk("SCSI device %s: "
-			       "%d %d-byte hdwr sectors (%d MB)\n",
+			       "%"BLKOFF_FMT" %d-byte hdwr sectors (%"BLKOFF_FMT" MB)\n",
 			       nbuff, rscsi_disks[i].capacity,
 			       hard_sector, (sz/2 - sz/1250 + 974)/1950);
 		}
diff -ur lb-2.4.6-pre8/drivers/scsi/sd.h lb-2.4.6-pre8.scsi/drivers/scsi/sd.h
--- lb-2.4.6-pre8/drivers/scsi/sd.h	Tue Jul  3 01:31:47 2001
+++ lb-2.4.6-pre8.scsi/drivers/scsi/sd.h	Tue Jul  3 22:03:16 2001
@@ -26,7 +26,7 @@
 extern struct hd_struct *sd;

 typedef struct scsi_disk {
-	unsigned capacity;	/* size in blocks */
+	u64 capacity;	/* size in blocks */
 	Scsi_Device *device;
 	unsigned char ready;	/* flag ready for FLOPTICAL */
 	unsigned char write_prot;	/* flag write_protect for rmvable dev */
diff -ur lb-2.4.6-pre8/include/scsi/scsi.h lb-2.4.6-pre8.scsi/include/scsi/scsi.h
--- lb-2.4.6-pre8/include/scsi/scsi.h	Thu May  3 11:22:20 2001
+++ lb-2.4.6-pre8.scsi/include/scsi/scsi.h	Tue Jul  3 18:06:43 2001
@@ -78,6 +78,9 @@
 #define MODE_SENSE_10         0x5a
 #define PERSISTENT_RESERVE_IN 0x5e
 #define PERSISTENT_RESERVE_OUT 0x5f
+#define READ_16               0x88
+#define WRITE_16              0x8a
+#define WRITE_VERIFY_16       0x8e
 #define MOVE_MEDIUM           0xa5
 #define READ_12               0xa8
 #define WRITE_12              0xaa

