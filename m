Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264807AbSIQWt6>; Tue, 17 Sep 2002 18:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSIQWth>; Tue, 17 Sep 2002 18:49:37 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:41118 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264701AbSIQWrl>; Tue, 17 Sep 2002 18:47:41 -0400
Date: Tue, 17 Sep 2002 15:51:20 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC] [PATCH] 3/7 2.5.35 SCSI multi-path
Message-ID: <20020917155120.C18424@eng2.beaverton.ibm.com>
References: <20020917154940.A18401@eng2.beaverton.ibm.com> <20020917155018.A18424@eng2.beaverton.ibm.com> <20020917155041.B18424@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020917155041.B18424@eng2.beaverton.ibm.com>; from patman on Tue, Sep 17, 2002 at 03:50:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 3 of 3 to add mid-layer scsi changes to simplify and enable the
addition of scsi multi-path IO support.

This does not add multi-path support, it adds changes that simplify the
addition of the actual scsi multi-path code.

 drivers/scsi/scsi_merge.c |   59 +++++++
 drivers/scsi/scsi_proc.c  |    8 -
 drivers/scsi/scsi_queue.c |   29 +++
 drivers/scsi/scsi_scan.c  |  361 +++++++++++++++++++++++-----------------------
 drivers/scsi/scsi_syms.c  |    6 
 include/scsi/scsi.h       |   23 ++
 6 files changed, 303 insertions(+), 183 deletions(-)

diff -Nru a/drivers/scsi/scsi_merge.c b/drivers/scsi/scsi_merge.c
--- a/drivers/scsi/scsi_merge.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/scsi_merge.c	Mon Sep 16 15:29:45 2002
@@ -22,6 +22,7 @@
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/bio.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/stat.h>
@@ -117,6 +118,58 @@
 }
 
 /*
+ * Function:    scsi_cleanup_io()
+ *
+ * Purpose:     SCSI I/O cleanup io function.
+ *
+ * Arguments:   SCpnt - Command descriptor we wish to cleanup
+ *
+ * Returns:     N/A
+ *
+ * Lock status: 
+ *
+ * Notes:       Code was previously part of scsi_io_completion, moved here
+ *              as we now also call it when redriving IO that does not make
+ *              it to the upper layer.
+ */
+void scsi_cleanup_io(Scsi_Cmnd *SCpnt)
+{
+	struct request *req = SCpnt->request;
+
+	/*
+	 * Free up any indirection buffers we allocated for DMA purposes. 
+	 * For the case of a READ, we need to copy the data out of the
+	 * bounce buffer and into the real buffer.
+	 */
+	if (SCpnt->use_sg) {
+		struct scatterlist *sgpnt;
+
+		sgpnt = (struct scatterlist *) SCpnt->buffer;
+		scsi_free_sgtable(SCpnt->buffer, SCpnt->sglist_len);
+	} else {
+		if (SCpnt->buffer != req->buffer) {
+			if (rq_data_dir(req) == READ) {
+				unsigned long flags;
+				char *to = bio_kmap_irq(req->bio, &flags);
+
+				memcpy(to, SCpnt->buffer, SCpnt->bufflen);
+				bio_kunmap_irq(to, &flags);
+			}
+			kfree(SCpnt->buffer);
+		}
+	}
+
+	/*
+	 * Zero these out.  They now point to freed memory, and it is
+	 * dangerous to hang onto the pointers.
+	 */
+	SCpnt->buffer  = NULL;
+	SCpnt->bufflen = 0;
+	SCpnt->request_buffer = NULL;
+	SCpnt->request_bufflen = 0;
+}
+
+/*
  * Function:    scsi_initialize_merge_fn()
  *
  * Purpose:     Initialize merge function for a host
@@ -131,16 +184,18 @@
  */
 void scsi_initialize_merge_fn(Scsi_Device * SDpnt)
 {
-	struct Scsi_Host *SHpnt = SDpnt->host;
+	struct Scsi_Host *SHpnt;
 	request_queue_t *q = &SDpnt->request_queue;
 	u64 bounce_limit;
 
+	SHpnt = scsi_get_host(SDpnt);
+	BUG_ON(SHpnt == NULL);
 	/*
 	 * The generic merging functions work just fine for us.
 	 * Enable highmem I/O, if appropriate.
 	 */
 	bounce_limit = BLK_BOUNCE_HIGH;
-	if (SHpnt->highmem_io && (SDpnt->type == TYPE_DISK)) {
+	if (SHpnt->highmem_io) {
 		if (!PCI_DMA_BUS_IS_PHYS)
 			/* Platforms with virtual-DMA translation
  			 * hardware have no practical limit.
diff -Nru a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
--- a/drivers/scsi/scsi_proc.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/scsi_proc.c	Mon Sep 16 15:29:45 2002
@@ -255,15 +255,15 @@
 	return (cmdIndex);
 }
 
-void proc_print_scsidevice(Scsi_Device * scd, char *buffer, int *size, int len)
+void proc_print_scsidevice(Scsi_Device *scd, char *buffer, int *size, int len)
 {
 
 	int x, y = *size;
 	extern const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE];
 
-	y = sprintf(buffer + len,
-	     "Host: scsi%d Channel: %02d Id: %02d Lun: %02d\n  Vendor: ",
-		    scd->host->host_no, scd->channel, scd->id, scd->lun);
+	y = scsi_paths_proc_print_paths(scd, buffer + len,
+		"Host: scsi%d Channel: %02d Id: %02d Lun: %02d\n");
+	y += sprintf(buffer + len + y, "Vendor: ");
 	for (x = 0; x < 8; x++) {
 		if (scd->vendor[x] >= 0x20)
 			y += sprintf(buffer + len + y, "%c", scd->vendor[x]);
diff -Nru a/drivers/scsi/scsi_queue.c b/drivers/scsi/scsi_queue.c
--- a/drivers/scsi/scsi_queue.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/scsi_queue.c	Mon Sep 16 15:29:45 2002
@@ -76,7 +76,8 @@
  */
 int scsi_mlqueue_insert(Scsi_Cmnd * cmd, int reason)
 {
-	struct Scsi_Host *host;
+	struct Scsi_Host *host; 
+	unsigned long flags;
 
 	SCSI_LOG_MLQUEUE(1, printk("Inserting command %p into mlqueue\n", cmd));
 
@@ -106,7 +107,7 @@
 			}
 		}
 		host->host_blocked = TRUE;
-	} else {
+	} else if (reason == SCSI_MLQUEUE_DEVICE_BUSY) {
 		/*
 		 * Protect against race conditions.  If the device isn't busy,
 		 * assume that something actually completed, and that we should
@@ -121,6 +122,11 @@
 			}
 		}
 		cmd->device->device_blocked = TRUE;
+	} else {
+		/*
+		 * Must be SCSI_MLQUEUE_RETRY: requeue without marking
+		 * host or device as busy.
+		 */
 	}
 
 	/*
@@ -134,12 +140,27 @@
 	 * Decrement the counters, since these commands are no longer
 	 * active on the host/device.
 	 */
+	spin_lock_irqsave(cmd->device->request_queue.queue_lock, flags);
+	cmd->device->device_busy--; /* XXX race */
 	scsi_host_busy_dec_and_test(cmd->host, cmd->device);
-
+	spin_unlock_irqrestore(cmd->device->request_queue.queue_lock, flags);
 	/*
 	 * Insert this command at the head of the queue for it's device.
 	 * It will go before all other commands that are already in the queue.
 	 */
-	scsi_insert_special_cmd(cmd, 1);
+	if (cmd->request->flags & REQ_SPECIAL) {
+		/*
+		 * Calling this for REQ_CMD requests is fatal.
+		 */
+		scsi_insert_special_cmd(cmd, 1);
+	} else {
+		/*
+		 * Clean up the IO, and requeue it without setting cmd to
+		 * REQ_SPECIAL.
+		 */
+		scsi_cleanup_io(cmd);
+		scsi_queue_next_request(&cmd->device->request_queue, cmd,
+					cmd->host);
+	}
 	return 0;
 }
diff -Nru a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/scsi_scan.c	Mon Sep 16 15:29:45 2002
@@ -189,26 +189,22 @@
 	" SCSI scanning, some SCSI devices might not be configured\n"
 
 /*
- * Prefix values for the SCSI id's (stored in driverfs name field)
- */
-#define SCSI_UID_SER_NUM 'S'
-#define SCSI_UID_UNKNOWN 'Z'
-
-/*
- * Return values of some of the scanning functions.
+ * Return values for (some of) the scanning functions, these are masks.
  *
  * SCSI_SCAN_NO_RESPONSE: no valid response received from the target, this
  * includes allocation or general failures preventing IO from being sent.
  *
- * SCSI_SCAN_TARGET_PRESENT: target responded, but no device is available
- * on the given LUN.
+ * SCSI_SCAN_TARGET_PRESENT: target responded, a device may or may not be
+ * present on a given LUN in such cases.
+ *
+ * SCSI_SCAN_LUN_PRESENT: A device is available on a given LUN.
  *
- * SCSI_SCAN_LUN_PRESENT: target responded, and a device is available on a
- * given LUN.
+ * SCSI_SCAN_NEW_LUN: This is a pre-existing device with a new path.
  */
-#define SCSI_SCAN_NO_RESPONSE		0
-#define SCSI_SCAN_TARGET_PRESENT	1
-#define SCSI_SCAN_LUN_PRESENT		2
+#define SCSI_SCAN_NO_RESPONSE		0x00
+#define SCSI_SCAN_TARGET_PRESENT	0x01
+#define SCSI_SCAN_LUN_PRESENT		0x02
+#define SCSI_SCAN_NEW_LUN		0x04
 
 static char *scsi_null_device_strs = "nullnullnullnull";
 
@@ -291,15 +287,11 @@
  **/
 static void scsi_unlock_floptical(Scsi_Request *sreq, unsigned char *result)
 {
-	Scsi_Device *sdscan = sreq->sr_device;
 	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
 
 	printk(KERN_NOTICE "scsi: unlocking floptical drive\n");
 	scsi_cmd[0] = MODE_SENSE;
-	if (sdscan->scsi_level <= SCSI_2)
-		scsi_cmd[1] = (sdscan->lun << 5) & 0xe0;
-	else
-		scsi_cmd[1] = 0;
+	scsi_cmd[1] = 0;
 	scsi_cmd[2] = 0x2e;
 	scsi_cmd[3] = 0;
 	scsi_cmd[4] = 0x2a;	/* size */
@@ -490,9 +482,8 @@
  * scsi_alloc_sdev - allocate and setup a Scsi_Device
  *
  * Description:
- *     Allocate, initialize for io, and return a pointer to a Scsi_Device.
- *     Stores the @shost, @channel, @id, and @lun in the Scsi_Device, and
- *     adds Scsi_Device to the appropriate list.
+ *     Allocate, initialize for io, add to the device list, and return a
+ *     pointer to a Scsi_Device.
  *
  * Return value:
  *     Scsi_Device pointer, or NULL on failure.
@@ -510,10 +501,16 @@
 		sdev->vendor = scsi_null_device_strs;
 		sdev->model = scsi_null_device_strs;
 		sdev->rev = scsi_null_device_strs;
-		sdev->host = shost;
-		sdev->id = id;
-		sdev->lun = lun;
-		sdev->channel = channel;
+
+		/*
+		 * XXX move this out, if it is overly redundant; if so, be
+		 * sure to call scsi_add_path somewhere, or modify
+		 * scsi_replace_path.
+		 */
+		if (scsi_add_path(sdev, shost, channel, id, lun)) {
+			kfree(sdev);
+			return (NULL);
+		}
 		sdev->online = TRUE;
 		/*
 		 * Some low level driver could use device->type
@@ -531,17 +528,7 @@
 		scsi_initialize_merge_fn(sdev);
 		init_waitqueue_head(&sdev->scpnt_wait);
 
-		/*
-		 * Add it to the end of the shost->host_queue list.
-		 */
-		if (shost->host_queue != NULL) {
-			sdev->prev = shost->host_queue;
-			while (sdev->prev->next != NULL)
-				sdev->prev = sdev->prev->next;
-			sdev->prev->next = sdev;
-		} else
-			shost->host_queue = sdev;
-
+		scsi_add_scsi_device(sdev, shost);
 	}
 	return (sdev);
 }
@@ -556,17 +543,13 @@
  **/
 static void scsi_free_sdev(Scsi_Device *sdev)
 {
-	if (sdev->prev != NULL)
-		sdev->prev->next = sdev->next;
-	else
-		sdev->host->host_queue = sdev->next;
-	if (sdev->next != NULL)
-		sdev->next->prev = sdev->prev;
-
+	/*
+	 * XXX move the following to scsi_remove_scsi_device?
+	 */
+	scsi_remove_path(sdev, SCSI_FIND_ALL_HOST_NO, SCSI_FIND_ALL_CHANNEL,
+			 SCSI_FIND_ALL_ID, SCSI_FIND_ALL_LUN);
 	blk_cleanup_queue(&sdev->request_queue);
-	if (sdev->inquiry != NULL)
-		kfree(sdev->inquiry);
-	kfree(sdev);
+	scsi_remove_scsi_device(sdev);
 }
 
 /**
@@ -585,11 +568,10 @@
 static int scsi_check_id_size(Scsi_Device *sdev, int size)
 {
 	if (size > DEVICE_NAME_SIZE) {
-		printk(KERN_WARNING "scsi scan: host %d channel %d id %d lun %d"
-		       " identifier too long, length %d, max %d. Device might"
-		       " be improperly identified.\n", sdev->host->host_no,
-		       sdev->channel, sdev->id, sdev->lun, size,
-		       DEVICE_NAME_SIZE);
+		printk(KERN_WARNING "scsi scan: ");
+		scsi_paths_printk(sdev, " ", "host %d channel %d id %d lun %d");
+		printk(" identifier too long, length %d, max %d. Device might"
+		       " be improperly identified.\n", size, DEVICE_NAME_SIZE);
 		return 1;
 	} else
 		return 0;
@@ -607,32 +589,28 @@
  * Return:
  *     A pointer to data containing the results on success, else NULL.
  **/
-unsigned char *scsi_get_evpd_page(Scsi_Device *sdev, Scsi_Request *sreq)
+unsigned char *scsi_get_evpd_page(Scsi_Device *sdev, Scsi_Request *sreq,
+				  struct scsi_path_id *pathid)
 {
 	unsigned char *evpd_page;
 	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
-	int lun = sdev->lun;
-	int scsi_level = sdev->scsi_level;
 	int max_lgth = 255;
 
 retry:
 	evpd_page = kmalloc(max_lgth, GFP_ATOMIC |
-			      (sdev->host->unchecked_isa_dma) ?
+			      (pathid->spi_shpnt->unchecked_isa_dma) ?
 			      GFP_DMA : 0);
 	if (!evpd_page) {
-		printk(KERN_WARNING "scsi scan: Allocation failure identifying"
-		       " host %d channel %d id %d lun %d, device might be"
-		       " improperly identified.\n", sdev->host->host_no,
-		       sdev->channel, sdev->id, sdev->lun);
+		printk(KERN_WARNING "scsi scan: Allocation failure identifying ");
+		scsi_paths_printk(sdev, " ", "host %d channel %d id %d lun %d");
+		printk("device might be improperly identified.\n");
 		return NULL;
 	}
+	memset(evpd_page, 0, max_lgth);
 
 	memset(scsi_cmd, 0, MAX_COMMAND_SIZE);
 	scsi_cmd[0] = INQUIRY;
-	if ((lun > 0) && (scsi_level <= SCSI_2))
-		scsi_cmd[1] = ((lun << 5) & 0xe0) | 0x01;
-	else
-		scsi_cmd[1] = 0x01;	/* SCSI_3 and higher, don't touch */
+	scsi_cmd[1] = 0x01;
 	scsi_cmd[4] = max_lgth;
 	sreq->sr_cmd_len = 0;
 	sreq->sr_sense_buffer[0] = 0;
@@ -865,33 +843,30 @@
  *     0: Failure
  *     1: Success
  **/
-int scsi_get_deviceid(Scsi_Device *sdev, Scsi_Request *sreq)
+int scsi_get_deviceid(Scsi_Device *sdev, Scsi_Request *sreq,
+		      struct scsi_path_id *pathid)
 {
 	unsigned char *id_page;
 	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
 	int id_idx, scnt, ret;
-	int lun = sdev->lun;
-	int scsi_level = sdev->scsi_level;
 	int max_lgth = 255;
 
+
 retry:
 	id_page = kmalloc(max_lgth, GFP_ATOMIC |
-			      (sdev->host->unchecked_isa_dma) ?
+			      (pathid->spi_shpnt->unchecked_isa_dma) ?
 			      GFP_DMA : 0);
 	if (!id_page) {
-		printk(KERN_WARNING "scsi scan: Allocation failure identifying"
-		       " host %d channel %d id %d lun %d, device might be"
-		       " improperly identified.\n", sdev->host->host_no,
-		       sdev->channel, sdev->id, sdev->lun);
+		printk(KERN_WARNING "scsi scan: Allocation failure identifying ");
+		scsi_paths_printk(sdev, " ", "host %d channel %d id %d lun %d");
+		printk("device might be improperly identified.\n");
 		return 0;
 	}
+	memset(id_page, 0, max_lgth);
 
 	memset(scsi_cmd, 0, MAX_COMMAND_SIZE);
 	scsi_cmd[0] = INQUIRY;
-	if ((lun > 0) && (scsi_level <= SCSI_2))
-		scsi_cmd[1] = ((lun << 5) & 0xe0) | 0x01;
-	else
-		scsi_cmd[1] = 0x01;	/* SCSI_3 and higher, don't touch */
+	scsi_cmd[1] = 0x01;
 	scsi_cmd[2] = 0x83;
 	scsi_cmd[4] = max_lgth;
 	sreq->sr_cmd_len = 0;
@@ -930,8 +905,9 @@
 				SCSI_LOG_SCAN_BUS(4, printk(KERN_INFO
 				  "scsi scan: host %d channel %d id %d lun %d"
 				  " used id desc %d/%d/%d\n",
-				  sdev->host->host_no, sdev->channel,
-				  sdev->id, sdev->lun,
+				  pathid->spi_shpnt->host_no,
+				  pathid->spi_channel, pathid->spi_id,
+				  pathid->spi_lun,
 				  id_search_list[id_idx].id_type,
 				  id_search_list[id_idx].naa_type,
 				  id_search_list[id_idx].code_set));
@@ -941,8 +917,9 @@
 				SCSI_LOG_SCAN_BUS(4, printk(KERN_INFO
 				  "scsi scan: host %d channel %d id %d lun %d"
 				  " no match/error id desc %d/%d/%d\n",
-				  sdev->host->host_no, sdev->channel,
-				  sdev->id, sdev->lun,
+				  pathid->spi_shpnt->host_no,
+				  pathid->spi_channel, pathid->spi_id,
+				  pathid->spi_lun,
 				  id_search_list[id_idx].id_type,
 				  id_search_list[id_idx].naa_type,
 				  id_search_list[id_idx].code_set));
@@ -973,32 +950,28 @@
  *     0: Failure
  *     1: Success
  **/
-int scsi_get_serialnumber(Scsi_Device *sdev, Scsi_Request *sreq)
+int scsi_get_serialnumber(Scsi_Device *sdev, Scsi_Request *sreq,
+			  struct scsi_path_id *pathid)
 {
 	unsigned char *serialnumber_page;
 	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
-	int lun = sdev->lun;
-	int scsi_level = sdev->scsi_level;
 	int max_lgth = 255;
 
  retry:
 	serialnumber_page = kmalloc(max_lgth, GFP_ATOMIC |
-			      (sdev->host->unchecked_isa_dma) ?
+			      (pathid->spi_shpnt->unchecked_isa_dma) ?
 			      GFP_DMA : 0);
 	if (!serialnumber_page) {
-		printk(KERN_WARNING "scsi scan: Allocation failure identifying"
-		       " host %d channel %d id %d lun %d, device might be"
-		       " improperly identified.\n", sdev->host->host_no,
-		       sdev->channel, sdev->id, sdev->lun);
+		printk(KERN_WARNING "scsi scan: Allocation failure identifying ");
+		scsi_paths_printk(sdev, " ", "host %d channel %d id %d lun %d");
+		printk("device might be improperly identified.\n");
 		return 0;
 	}
+	memset(serialnumber_page, 0, max_lgth);
 
 	memset(scsi_cmd, 0, MAX_COMMAND_SIZE);
 	scsi_cmd[0] = INQUIRY;
-	if ((lun > 0) && (scsi_level <= SCSI_2))
-		scsi_cmd[1] = ((lun << 5) & 0xe0) | 0x01;
-	else
-		scsi_cmd[1] = 0x01;	/* SCSI_3 and higher, don't touch */
+	scsi_cmd[1] = 0x01;
 	scsi_cmd[2] = 0x80;
 	scsi_cmd[4] = max_lgth;
 	sreq->sr_cmd_len = 0;
@@ -1093,14 +1066,20 @@
 {
 	unsigned char *evpd_page = NULL;
 	int cnt;
+	struct scsi_path_id pathid;
 
 	memset(sdev->sdev_driverfs_dev.name, 0, DEVICE_NAME_SIZE);
-	evpd_page = scsi_get_evpd_page(sdev, sreq);
+	if (scsi_get_path(sdev, &pathid)) {
+		printk(KERN_ERR "scsi scan: no path to scan device.\n");
+		scsi_get_default_name(sdev);
+		return;
+	}
+	evpd_page = scsi_get_evpd_page(sdev, sreq, &pathid);
 	if (evpd_page == NULL) {
 		/*
 		 * try to obtain serial number anyway
 		 */
-		(void)scsi_get_serialnumber(sdev, sreq);
+		(void)scsi_get_serialnumber(sdev, sreq, &pathid);
 	} else {
 		/*
 		 * XXX search high to low, since the pages are lowest to
@@ -1108,23 +1087,25 @@
 		 */
 		for(cnt = 4; cnt <= evpd_page[3] + 3; cnt++)
 			if (evpd_page[cnt] == 0x83)
-				if (scsi_get_deviceid(sdev, sreq))
+				if (scsi_get_deviceid(sdev, sreq, &pathid))
 					goto leave;
 
 		for(cnt = 4; cnt <= evpd_page[3] + 3; cnt++)
 			if (evpd_page[cnt] == 0x80)
-				if (scsi_get_serialnumber(sdev, sreq))
+				if (scsi_get_serialnumber(sdev, sreq, &pathid))
 					goto leave;
 
-		if (sdev->sdev_driverfs_dev.name[0] == 0)
-			scsi_get_default_name(sdev);
 
 	}
+	if (sdev->sdev_driverfs_dev.name[0] == 0)
+		scsi_get_default_name(sdev);
 leave:
 	if (evpd_page) kfree(evpd_page);
-	SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO "scsi scan: host %d channel %d"
-	    " id %d lun %d name/id: '%s'\n", sdev->host->host_no,
-	    sdev->channel, sdev->id, sdev->lun, sdev->sdev_driverfs_dev.name));
+	SCSI_LOG_SCAN_BUS(3, {
+		printk(KERN_INFO "scsi scan: ");
+		scsi_paths_printk(sdev, " ", "host %d channel %d id %d lun %d");
+		printk(" name/id: '%s'\n", sdev->sdev_driverfs_dev.name);
+		});
 	return;
 }
 
@@ -1143,9 +1124,10 @@
 {
 	int res = SCSI_2;
 	Scsi_Device *sdev;
+	scsi_traverse_hndl_t strav_hndl;
 
-	for (sdev = shost->host_queue; sdev; sdev = sdev->next)
-		if ((id == sdev->id) && (channel == sdev->channel))
+	scsi_for_each_sdev_lun (&strav_hndl, sdev, shost->host_no,
+				channel, id)
 			return (int) sdev->scsi_level;
 	/*
 	 * FIXME No matching target id is configured, this needs to get
@@ -1175,14 +1157,13 @@
 	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
 	int possible_inq_resp_len;
 
-	SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO "scsi scan: INQUIRY to host %d"
-			" channel %d id %d lun %d\n", sdev->host->host_no,
-			sdev->channel, sdev->id, sdev->lun));
+	SCSI_LOG_SCAN_BUS(3, {
+		printk(KERN_INFO "scsi scan: INQUIRY to ");
+		scsi_paths_printk(sdev, " ", "host %d channel %d id %d lun %d\n");
+	});
 
 	memset(scsi_cmd, 0, 6);
 	scsi_cmd[0] = INQUIRY;
-	if ((sdev->lun > 0) && (sdev->scsi_level <= SCSI_2))
-		scsi_cmd[1] = (sdev->lun << 5) & 0xe0;
 	scsi_cmd[4] = 36;	/* issue conservative alloc_length */
 	sreq->sr_cmd_len = 0;
 	sreq->sr_data_direction = SCSI_DATA_READ;
@@ -1230,8 +1211,6 @@
 	if (possible_inq_resp_len > 36) {	/* do additional INQUIRY */
 		memset(scsi_cmd, 0, 6);
 		scsi_cmd[0] = INQUIRY;
-		if ((sdev->lun > 0) && (sdev->scsi_level <= SCSI_2))
-			scsi_cmd[1] = (sdev->lun << 5) & 0xe0;
 		scsi_cmd[4] = (unsigned char) possible_inq_resp_len;
 		sreq->sr_cmd_len = 0;
 		sreq->sr_data_direction = SCSI_DATA_READ;
@@ -1308,9 +1287,7 @@
  *     NULL, store the address of the new Scsi_Device in *@sdevnew (needed
  *     when scanning a particular LUN).
  *
- * Return:
- *     SCSI_SCAN_NO_RESPONSE: could not allocate or setup a Scsi_Device
- *     SCSI_SCAN_LUN_PRESENT: a new Scsi_Device was allocated and initialized
+ * Returns a SCSI_SCAN_ mask value.
  **/
 static int scsi_add_lun(Scsi_Device *sdevscan, Scsi_Device **sdevnew,
 			Scsi_Request *sreq, char *inq_result, int *bflags)
@@ -1319,9 +1296,19 @@
 	struct Scsi_Device_Template *sdt;
 	char devname[64];
 	extern devfs_handle_t scsi_devfs_handle;
+	struct scsi_path_id pathid;
 
-	sdev = scsi_alloc_sdev(sdevscan->host, sdevscan->channel,
-				     sdevscan->id, sdevscan->lun);
+	/*
+	 * sdevscan must have only one path, add it to this device.  XXX
+	 * this is a bit ugly, there must be a better solution, maybe pass
+	 * a scsi_path_id everywhere.
+	 */
+	if (scsi_get_path(sdevscan, &pathid)) {
+		printk(KERN_ERR "scsi scan: no path to scan device.\n");
+		return SCSI_SCAN_NO_RESPONSE;
+	}
+	sdev = scsi_alloc_sdev(pathid.spi_shpnt, pathid.spi_channel,
+			       pathid.spi_id, pathid.spi_lun);
 	if (sdev == NULL)
 		return SCSI_SCAN_NO_RESPONSE;
 
@@ -1348,6 +1335,15 @@
 	sdev->model = (char *) (sdev->inquiry + 16);
 	sdev->rev = (char *) (sdev->inquiry + 32);
 
+	/*
+	 * XXX move the identifier and driverfs/devfs setup to a new
+	 * function
+	 *
+	 * scsi_load_identifier is the only reason sreq is needed in this
+	 * function; it also requires that the inquiry strings be set up.
+	 */
+	scsi_load_identifier(sdev, sreq);
+
 	if (*bflags & BLIST_ISROM) {
 		/*
 		 * It would be better to modify sdev->type, and set
@@ -1410,20 +1406,12 @@
 	sdev->soft_reset = (inq_result[7] & 1) && ((inq_result[3] & 7) == 2);
 
 	/*
-	 * XXX maybe move the identifier and driverfs/devfs setup to a new
-	 * function, and call them after this function is called.
-	 *
-	 * scsi_load_identifier is the only reason sreq is needed in this
-	 * function.
-	 */
-	scsi_load_identifier(sdev, sreq);
-
-	/*
 	 * create driverfs files
 	 */
 	sprintf(sdev->sdev_driverfs_dev.bus_id,"%d:%d:%d:%d",
-		sdev->host->host_no, sdev->channel, sdev->id, sdev->lun);
-	sdev->sdev_driverfs_dev.parent = &sdev->host->host_driverfs_dev;
+		pathid.spi_shpnt->host_no, pathid.spi_channel, pathid.spi_id,
+		pathid.spi_lun);
+	sdev->sdev_driverfs_dev.parent = &pathid.spi_shpnt->host_driverfs_dev;
 	sdev->sdev_driverfs_dev.bus = &scsi_driverfs_bus_type;
 	device_register(&sdev->sdev_driverfs_dev);
 
@@ -1433,7 +1421,8 @@
 	device_create_file(&sdev->sdev_driverfs_dev, &dev_attr_type);
 
 	sprintf(devname, "host%d/bus%d/target%d/lun%d",
-		sdev->host->host_no, sdev->channel, sdev->id, sdev->lun);
+		pathid.spi_shpnt->host_no, pathid.spi_channel, pathid.spi_id,
+		pathid.spi_lun);
 	if (sdev->de)
 		printk(KERN_WARNING "scsi devfs dir: \"%s\" already exists\n",
 		       devname);
@@ -1468,7 +1457,8 @@
 	if (sdevnew != NULL)
 		*sdevnew = sdev;
 
-	return SCSI_SCAN_LUN_PRESENT;
+	return (SCSI_SCAN_TARGET_PRESENT | SCSI_SCAN_LUN_PRESENT |
+		SCSI_SCAN_NEW_LUN);
 }
 
 /**
@@ -1481,11 +1471,7 @@
  *     Call scsi_probe_lun, if a LUN with an attached device is found,
  *     allocate and set it up by calling scsi_add_lun.
  *
- * Return:
- *     SCSI_SCAN_NO_RESPONSE: could not allocate or setup a Scsi_Device
- *     SCSI_SCAN_TARGET_PRESENT: target responded, but no device is
- *         attached at the LUN
- *     SCSI_SCAN_LUN_PRESENT: a new Scsi_Device was allocated and initialized
+ * Returns a SCSI_SCAN_ mask value.
  **/
 static int scsi_probe_and_add_lun(Scsi_Device *sdevscan, Scsi_Device **sdevnew,
 				  int *bflagsp)
@@ -1495,7 +1481,15 @@
 	unsigned char *scsi_result = NULL;
 	int bflags;
 	int res;
+	struct scsi_path_id pathid;
 
+	if (sdevnew != NULL)
+		*sdevnew = NULL;
+
+	if (scsi_get_path(sdevscan, &pathid)) {
+		printk(KERN_ERR "scsi scan: no path to scan device.\n");
+		return SCSI_SCAN_NO_RESPONSE;
+	}
 	/*
 	 * Any command blocks allocated are fixed to use sdevscan->lun,
 	 * so they must be allocated and released if sdevscan->lun
@@ -1521,9 +1515,8 @@
 	 * The sreq is for use only with sdevscan.
 	 */
 
-	scsi_result = kmalloc(256, GFP_ATOMIC |
-			      (sdevscan->host->unchecked_isa_dma) ?
-			      GFP_DMA : 0);
+	scsi_result = kmalloc(256, GFP_ATOMIC | 
+	    (pathid.spi_shpnt->unchecked_isa_dma) ?  GFP_DMA : 0);
 	if (scsi_result == NULL)
 		goto alloc_failed;
 
@@ -1552,12 +1545,12 @@
 		} else {
 			res = scsi_add_lun(sdevscan, &sdev, sreq, scsi_result,
 					   &bflags);
-			if (res == SCSI_SCAN_LUN_PRESENT) {
+			if (res & SCSI_SCAN_LUN_PRESENT) {
 				BUG_ON(sdev == NULL);
-				if ((bflags & BLIST_KEY) != 0) {
+				if ((res & SCSI_SCAN_NEW_LUN) &&
+				    (bflags & BLIST_KEY) != 0) {
 					sdev->lockable = 0;
-					scsi_unlock_floptical(sreq,
-							      scsi_result);
+					scsi_unlock_floptical(sreq, scsi_result);
 					/*
 					 * scsi_result no longer contains
 					 * the INQUIRY data.
@@ -1606,22 +1599,26 @@
 static void scsi_sequential_lun_scan(Scsi_Device *sdevscan, int bflags,
 				     int lun0_res)
 {
-	struct Scsi_Host *shost = sdevscan->host;
 	unsigned int sparse_lun;
 	unsigned int max_dev_lun;
+	struct scsi_path_id pathid;
 
+	if (scsi_get_path(sdevscan, &pathid)) {
+		printk(KERN_ERR "scsi scan: no path to scan device.\n");
+		return;
+	}
 	SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO "scsi scan: Sequential scan of"
-			" host %d channel %d id %d\n", sdevscan->host->host_no,
-			sdevscan->channel, sdevscan->id));
+		" host %d channel %d id %d\n", pathid.spi_shpnt->host_no,
+		pathid.spi_channel, pathid.spi_id));
 
-	max_dev_lun = min(max_scsi_luns, shost->max_lun);
+	max_dev_lun = min(max_scsi_luns, pathid.spi_shpnt->max_lun);
 	/*
 	 * If this device is known to support sparse multiple units,
 	 * override the other settings, and scan all of them. Normally,
 	 * SCSI-3 devices should be scanned via the REPORT LUNS.
 	 */
 	if (bflags & BLIST_SPARSELUN) {
-		max_dev_lun = shost->max_lun;
+		max_dev_lun = pathid.spi_shpnt->max_lun;
 		sparse_lun = 1;
 	} else
 		sparse_lun = 0;
@@ -1630,7 +1627,7 @@
 	 * If not sparse lun and no device attached at LUN 0 do not scan
 	 * any further.
 	 */
-	if (!sparse_lun && (lun0_res != SCSI_SCAN_LUN_PRESENT))
+	if (!sparse_lun && !(lun0_res & SCSI_SCAN_LUN_PRESENT))
 		return;
 
 	/*
@@ -1647,7 +1644,7 @@
 	 * the other settings, and scan all of them.
 	 */
 	if (bflags & BLIST_FORCELUN)
-		max_dev_lun = shost->max_lun;
+		max_dev_lun = pathid.spi_shpnt->max_lun;
 	/*
 	 * REGAL CDC-4X: avoid hang after LUN 4
 	 */
@@ -1665,10 +1662,16 @@
 	 * until we reach the max, or no LUN is found and we are not
 	 * sparse_lun.
 	 */
-	for (sdevscan->lun = 1; sdevscan->lun < max_dev_lun; ++sdevscan->lun)
-		if ((scsi_probe_and_add_lun(sdevscan, NULL, NULL)
-		     != SCSI_SCAN_LUN_PRESENT) && !sparse_lun)
+
+	for (pathid.spi_lun = 1; pathid.spi_lun < max_dev_lun;
+	     ++pathid.spi_lun) {
+		scsi_replace_path(sdevscan, pathid.spi_shpnt,
+				   pathid.spi_channel, pathid.spi_id,
+				  pathid.spi_lun);
+		if (!(scsi_probe_and_add_lun(sdevscan, NULL, NULL)
+		     & SCSI_SCAN_LUN_PRESENT) && !sparse_lun)
 			return;
+	}
 }
 
 #ifdef CONFIG_SCSI_REPORT_LUNS
@@ -1732,6 +1735,7 @@
 	ScsiLun *fcp_cur_lun, *lun_data;
 	Scsi_Request *sreq;
 	char *data;
+	struct scsi_path_id pathid;
 
 	/*
 	 * Only support SCSI-3 and up devices.
@@ -1739,6 +1743,13 @@
 	if (sdevscan->scsi_level < SCSI_3)
 		return 1;
 
+	if (scsi_get_path(sdevscan, &pathid)) {
+		printk(KERN_ERR "scsi scan: no path to scan device.\n");
+		/*
+		 * An inconsistency, so don't try scanning any further.
+		 */
+		return 0;
+	}
 	sdevscan->queue_depth = 1;
 	scsi_build_commandblocks(sdevscan);
 	if (sdevscan->has_cmdblocks == 0) {
@@ -1750,8 +1761,8 @@
 	}
 	sreq = scsi_allocate_request(sdevscan);
 
-	sprintf(devname, "host %d channel %d id %d", sdevscan->host->host_no,
-		sdevscan->channel, sdevscan->id);
+	sprintf(devname, "host %d channel %d id %d", pathid.spi_shpnt->host_no,
+		pathid.spi_channel, pathid.spi_id);
 	/*
 	 * Allocate enough to hold the header (the same size as one ScsiLun)
 	 * plus the max number of luns we are requesting.
@@ -1763,9 +1774,8 @@
 	 * prevent us from finding any LUNs on this target.
 	 */
 	length = (max_scsi_report_luns + 1) * sizeof(ScsiLun);
-	lun_data = (ScsiLun *) kmalloc(length, GFP_ATOMIC |
-					   (sdevscan->host->unchecked_isa_dma ?
-					    GFP_DMA : 0));
+	lun_data = (ScsiLun *) kmalloc(length, GFP_ATOMIC | 
+	    (pathid.spi_shpnt->unchecked_isa_dma ?  GFP_DMA : 0));
 	if (lun_data == NULL) {
 		printk(ALLOC_FAILURE_MSG, __FUNCTION__);
 		scsi_release_commandblocks(sdevscan);
@@ -1845,9 +1855,8 @@
 	} else
 		num_luns = (length / sizeof(ScsiLun));
 
-	SCSI_LOG_SCAN_BUS(3, printk (KERN_INFO "scsi scan: REPORT LUN scan of"
-			" host %d channel %d id %d\n", sdevscan->host->host_no,
-			sdevscan->channel, sdevscan->id));
+	SCSI_LOG_SCAN_BUS(3, 
+	    printk(KERN_INFO "scsi scan: REPORT LUN scan of %s\n", devname));
 	/*
 	 * Scan the luns in lun_data. The entry at offset 0 is really
 	 * the header, so start at 1 and go up to and including num_luns.
@@ -1877,22 +1886,23 @@
 			/*
 			 * LUN 0 has already been scanned.
 			 */
-		} else if (lun > sdevscan->host->max_lun) {
+		} else if (lun > pathid.spi_shpnt->max_lun) {
 			printk(KERN_WARNING "scsi: %s lun%d has a LUN larger"
 			       " than allowed by the host adapter\n",
 			       devname, lun);
 		} else {
-			int res;
-
-			sdevscan->lun = lun;
-			res = scsi_probe_and_add_lun(sdevscan, NULL, NULL);
-			if (res == SCSI_SCAN_NO_RESPONSE) {
+			pathid.spi_lun = lun;
+			scsi_replace_path(sdevscan, pathid.spi_shpnt,
+					   pathid.spi_channel, pathid.spi_id,
+					  pathid.spi_lun);
+			if (scsi_probe_and_add_lun(sdevscan, NULL, NULL) ==
+			    SCSI_SCAN_NO_RESPONSE) {
 				/*
 				 * Got some results, but now none, abort.
 				 */
 				printk(KERN_ERR "scsi: Unexpected response"
 				       " from %s lun %d while scanning, scan"
-				       " aborted\n", devname, sdevscan->lun);
+				       " aborted\n", devname, pathid.spi_lun);
 				break;
 			}
 		}
@@ -1938,18 +1948,15 @@
 		 */
 		return;
 
-	sdevscan->host = shost;
-	sdevscan->id = id;
-	sdevscan->channel = channel;
+	scsi_replace_path(sdevscan, shost, channel, id, 0 /* LUN */);
 	/*
 	 * Scan LUN 0, if there is some response, scan further. Ideally, we
 	 * would not configure LUN 0 until all LUNs are scanned.
 	 *
 	 * The scsi_level is set (in scsi_probe_lun) if a target responds.
 	 */
-	sdevscan->lun = 0;
 	res = scsi_probe_and_add_lun(sdevscan, NULL, &bflags);
-	if (res != SCSI_SCAN_NO_RESPONSE) {
+	if (res & SCSI_SCAN_TARGET_PRESENT) {
 		/*
 		 * Some scsi devices cannot properly handle a lun != 0.
 		 * BLIST_NOLUN also prevents a REPORT LUN from being sent.
@@ -1995,9 +2002,10 @@
 		return;
 
 	sdevscan->scsi_level = scsi_find_scsi_level(channel, id, shost);
+	sdevscan->scanning = 1;
 	res = scsi_probe_and_add_lun(sdevscan, &sdev, NULL);
 	scsi_free_sdev(sdevscan);
-	if (res == SCSI_SCAN_LUN_PRESENT) {
+	if (res & SCSI_SCAN_NEW_LUN) {
 		BUG_ON(sdev == NULL);
 		/*
 		 * FIXME calling select_queue_depths is wrong for adapters
@@ -2014,7 +2022,6 @@
 		 */
 		if (shost->select_queue_depths != NULL)
 			(shost->select_queue_depths) (shost, shost->host_queue);
-
 		for (sdt = scsi_devicelist; sdt; sdt = sdt->next)
 			if (sdt->init && sdt->dev_noticed)
 				(*sdt->init) ();
@@ -2080,11 +2087,19 @@
 		 * queue_nr_requests requests are allocated. Don't do so
 		 * here for scsi_scan_selected_lun, since we end up
 		 * calling select_queue_depths with an extra Scsi_Device
-		 * on the host_queue list.
+		 * on the device list.
 		 */
 		sdevscan = scsi_alloc_sdev(shost, 0, 0, 0);
 		if (sdevscan == NULL)
 			return;
+		/*
+		 * Set the scanning bit, so error messages about errors
+		 * and path failure are not printed; this should be used
+		 * in scsi_error.c to prevent overly aggressive action on
+		 * failure for a scan. This is never reset, as the default
+		 * state for a new Scsi_Device is 0.
+		 */
+		sdevscan->scanning = 1;
 		/*
 		 * The sdevscan host, channel, id and lun are filled in as
 		 * needed to scan.
diff -Nru a/drivers/scsi/scsi_syms.c b/drivers/scsi/scsi_syms.c
--- a/drivers/scsi/scsi_syms.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/scsi_syms.c	Mon Sep 16 15:29:45 2002
@@ -102,6 +102,12 @@
 EXPORT_SYMBOL(scsi_add_timer);
 EXPORT_SYMBOL(scsi_delete_timer);
 
+EXPORT_SYMBOL(scsi_add_path);
+EXPORT_SYMBOL(scsi_remove_path);
+EXPORT_SYMBOL(scsi_get_path);
+EXPORT_SYMBOL(scsi_get_host);
+EXPORT_SYMBOL(scsi_paths_printk);
+EXPORT_SYMBOL(scsi_traverse_sdevs);
 /*
  * driverfs support for determining driver types
  */
diff -Nru a/include/scsi/scsi.h b/include/scsi/scsi.h
--- a/include/scsi/scsi.h	Mon Sep 16 15:29:45 2002
+++ b/include/scsi/scsi.h	Mon Sep 16 15:29:45 2002
@@ -91,6 +91,29 @@
 #define WRITE_LONG_2          0xea
 
 /*
+ * SCSI INQUIRY Flags (byte 7)
+ */
+#define SCSI_EVPD       0x01   /* enable vital product data */
+#define SCSI_RMB7       0x80   /* removable media */
+#define SCSI_AENC       0x80   /* asynchronous event notification capability */
+#define SCSI_TRMIOP     0x40   /* terminate I/O process capability */
+#define SCSI_RELADR7    0x80   /* relative addressing capability */
+#define SCSI_WBUS16     0x20   /* 16 byte wide transfer capabilitiy */
+#define SCSI_WBUS32     0x40   /* 32 byte wide transfer capabilitiy */
+#define SCSI_SYNC       0x10   /* synchronous data transfer capability */
+#define SCSI_LINKED     0x08   /* linked command capability */
+#define SCSI_CMDQUE     0x02   /* command queueing capability */
+#define SCSI_SFTRE      0x01   /* soft reset capability */
+
+/*
+ * SCSI INQUIRY Vital Product Data Page Codes
+ */
+#define SCSI_VPROD_SUPPORTED            0x00
+#define SCSI_VPROD_UNIT_SERIAL          0x80
+#define SCSI_VPROD_AODEFN               0x82
+#define SCSI_VPROD_DEVICE_ID            0x83
+
+/*
  *  Status codes
  */
 
