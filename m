Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSJYWTt>; Fri, 25 Oct 2002 18:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261638AbSJYWTk>; Fri, 25 Oct 2002 18:19:40 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:42144 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261645AbSJYWQD>;
	Fri, 25 Oct 2002 18:16:03 -0400
Date: Fri, 25 Oct 2002 15:22:08 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] 2/6 2.5.44 scsi multi-path IO - mid layer changes
Message-ID: <20021025152208.B17527@eng2.beaverton.ibm.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20021025152116.A17462@eng2.beaverton.ibm.com> <20021025152149.A17527@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021025152149.A17527@eng2.beaverton.ibm.com>; from patman on Fri, Oct 25, 2002 at 03:21:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI mid-layer multi-path IO changes

 scsi_ioctl.c |   62 +-
 scsi_lib.c   |  348 ++++++++-----
 scsi_merge.c |   57 ++
 scsi_paths.c | 1499 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1827 insertions(+), 139 deletions(-)

diff -Nru a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
--- a/drivers/scsi/scsi_ioctl.c	Fri Oct 25 11:26:48 2002
+++ b/drivers/scsi/scsi_ioctl.c	Fri Oct 25 11:26:48 2002
@@ -129,10 +129,15 @@
 				break;
 			}
 		default:	/* Fall through for non-removable media */
-			printk("SCSI error: host %d id %d lun %d return code = %x\n",
-			       dev->host->host_no,
-			       dev->id,
-			       dev->lun,
+			/*
+			 * This is a bit klugey, since we rely on SRpnt
+			 * to contain the scsi_cmnd for the IO.
+			 */
+			printk("SCSI error: host %d channel %d id %d lun %d return code = %x\n",
+			       SRpnt->sr_command->host->host_no,
+			       SRpnt->sr_command->channel,
+			       SRpnt->sr_command->target,
+			       SRpnt->sr_command->lun,
 			       SRpnt->sr_result);
 			printk("\tSense class %x, sense error %x, extended sense %x\n",
 			       sense_class(SRpnt->sr_sense_buffer[0]),
@@ -214,6 +219,7 @@
 	char *cmd_in;
 	Scsi_Request *SRpnt;
 	Scsi_Device *SDpnt;
+	struct Scsi_Host *SHpnt;
 	unsigned char opcode;
 	unsigned int inlen, outlen, cmdlen;
 	unsigned int needed, buf_needed;
@@ -223,7 +229,9 @@
 	if (!sic)
 		return -EINVAL;
 
-	if (dev->host->unchecked_isa_dma)
+	if ((SHpnt = scsi_get_host(dev)) == NULL)
+		return -ENODEV;
+	if (SHpnt->unchecked_isa_dma)
 		gfp_mask |= GFP_DMA;
 
 	/*
@@ -395,10 +403,16 @@
 static int
 scsi_ioctl_get_pci(Scsi_Device * dev, void *arg)
 {
+	struct Scsi_Host *SHpnt;
 
-        if (!dev->host->pci_dev) return -ENXIO;
-        return copy_to_user(arg, dev->host->pci_dev->slot_name,
-                            sizeof(dev->host->pci_dev->slot_name));
+	/*
+	 * XXX this ioctl should be replaced by a host specific interface
+	 */ 
+	if ((SHpnt = scsi_get_host(dev)) == NULL)
+		return -ENODEV;
+        if (!SHpnt->pci_dev) return -ENXIO;
+        return copy_to_user(arg, SHpnt->pci_dev->slot_name,
+                            sizeof(SHpnt->pci_dev->slot_name));
 }
 
 
@@ -410,6 +424,8 @@
 int scsi_ioctl(Scsi_Device * dev, int cmd, void *arg)
 {
 	char scsi_cmd[MAX_COMMAND_SIZE];
+	struct scsi_path_id scsi_path;
+	struct Scsi_Host *SHpnt;
 
 	/* No idea how this happens.... */
 	if (!dev)
@@ -430,15 +446,23 @@
 		if (verify_area(VERIFY_WRITE, arg, sizeof(Scsi_Idlun)))
 			return -EFAULT;
 
-		__put_user((dev->id & 0xff)
-			 + ((dev->lun & 0xff) << 8)
-			 + ((dev->channel & 0xff) << 16)
-			 + ((dev->host->host_no & 0xff) << 24),
+		/*
+		 * Just get first path, and use its
+		 * id/lun/channel/host_no. This is fine for single path
+		 * devices, or when no multi-path IO.
+		 */
+		scsi_get_path(dev, &scsi_path);
+		__put_user((scsi_path.spi_id & 0xff)
+			 + ((scsi_path.spi_lun & 0xff) << 8)
+			 + ((scsi_path.spi_channel & 0xff) << 16)
+			 + ((scsi_path.spi_shpnt->host_no & 0xff) << 24),
 			 &((Scsi_Idlun *) arg)->dev_id);
-		__put_user(dev->host->unique_id, &((Scsi_Idlun *) arg)->host_unique_id);
+		__put_user(scsi_path.spi_shpnt->unique_id, &((Scsi_Idlun *) arg)->host_unique_id);
 		return 0;
 	case SCSI_IOCTL_GET_BUS_NUMBER:
-		return put_user(dev->host->host_no, (int *) arg);
+		if ((SHpnt = scsi_get_host(dev)) == NULL)
+			return -ENODEV;
+		return put_user(SHpnt->host_no, (int *) arg);
 	/*
 	 * The next two ioctls either need to go or need to be changed to
 	 * pass tagged queueing changes through the low level drivers.
@@ -464,7 +488,9 @@
 		dev->current_tag = 0;
 		return 0;
 	case SCSI_IOCTL_PROBE_HOST:
-		return ioctl_probe(dev->host, arg);
+		if ((SHpnt = scsi_get_host(dev)) == NULL)
+			return -ENODEV;
+		return ioctl_probe(SHpnt, arg);
 	case SCSI_IOCTL_SEND_COMMAND:
 		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 			return -EACCES;
@@ -502,8 +528,10 @@
                 return scsi_ioctl_get_pci(dev, arg);
                 break;
 	default:
-		if (dev->host->hostt->ioctl)
-			return dev->host->hostt->ioctl(dev, cmd, arg);
+		if ((SHpnt = scsi_get_host(dev)) == NULL)
+			return -ENODEV;
+		if (SHpnt->hostt->ioctl)
+			return SHpnt->hostt->ioctl(dev, cmd, arg);
 		return -EINVAL;
 	}
 	return -EINVAL;
diff -Nru a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c	Fri Oct 25 11:26:47 2002
+++ b/drivers/scsi/scsi_lib.c	Fri Oct 25 11:26:47 2002
@@ -37,6 +37,7 @@
 #define __KERNEL_SYSCALLS__
 
 #include <linux/unistd.h>
+#include <linux/slab.h>
 
 #include <asm/system.h>
 #include <asm/irq.h>
@@ -46,6 +47,8 @@
 #include "hosts.h"
 #include <scsi/scsi_ioctl.h>
 
+struct scsi_device *scsi_sdev_list;
+
 /*
  * This entire source file deals with the new queueing code.
  */
@@ -126,7 +129,14 @@
 	SCpnt->serial_number = 0;
 	SCpnt->serial_number_at_timeout = 0;
 	SCpnt->flags = 0;
+#if 0
+	/*
+	 * FIXME - what do we do for multi-path? Not resetting this means that
+	 * QUEUE_FULL and host busy cases will not be retried. There are 
+	 * probably other cases where we should also retry longer.
+	 */
 	SCpnt->retries = 0;
+#endif
 
 	SCpnt->abort_reason = 0;
 
@@ -219,12 +229,14 @@
  *		permutations grows as 2**N, and if too many more special cases
  *		get added, we start to get screwed.
  */
-void scsi_queue_next_request(request_queue_t * q, Scsi_Cmnd * SCpnt)
+void scsi_queue_next_request(request_queue_t * q, Scsi_Cmnd * SCpnt,
+			     struct Scsi_Host * SHpnt)
 {
-	int all_clear;
 	unsigned long flags;
 	Scsi_Device *SDpnt;
-	struct Scsi_Host *SHpnt;
+	/* see comment further below */
+	int all_clear;
+	struct scsi_traverse_hndl strav_hndl;
 
 	ASSERT_LOCK(q->queue_lock, 0);
 
@@ -249,7 +261,6 @@
 	q->request_fn(q);
 
 	SDpnt = (Scsi_Device *) q->queuedata;
-	SHpnt = SDpnt->host;
 
 	/*
 	 * If this is a single-lun device, and we are currently finished
@@ -261,7 +272,7 @@
 	if (SDpnt->single_lun && blk_queue_empty(q) && SDpnt->device_busy ==0) {
 		request_queue_t *q;
 
-		for (SDpnt = SHpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
+		scsi_for_each_host_sdev(&strav_hndl, SDpnt, SHpnt->host_no) {
 			if (((SHpnt->can_queue > 0)
 			     && (SHpnt->host_busy >= SHpnt->can_queue))
 			    || (SHpnt->host_blocked)
@@ -285,7 +296,7 @@
 	 */
 	all_clear = 1;
 	if (SHpnt->some_device_starved) {
-		for (SDpnt = SHpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
+		scsi_for_each_host_sdev(&strav_hndl, SDpnt, SHpnt->host_no) {
 			request_queue_t *q;
 			if ((SHpnt->can_queue > 0 && (SHpnt->host_busy >= SHpnt->can_queue))
 			    || (SHpnt->host_blocked) 
@@ -338,6 +349,7 @@
 	request_queue_t *q = &SCpnt->device->request_queue;
 	struct request *req = SCpnt->request;
 	unsigned long flags;
+	struct Scsi_Host * SHpnt = SCpnt->host;
 
 	ASSERT_LOCK(q->queue_lock, 0);
 
@@ -353,7 +365,7 @@
 		 * Bleah.  Leftovers again.  Stick the leftovers in
 		 * the front of the queue, and goose the queue again.
 		 */
-		scsi_queue_next_request(q, SCpnt);
+		scsi_queue_next_request(q, SCpnt, SHpnt);
 		return SCpnt;
 	}
 
@@ -375,7 +387,7 @@
 	__scsi_release_command(SCpnt);
 
 	if (frequeue)
-		scsi_queue_next_request(q, NULL);
+		scsi_queue_next_request(q, NULL, SHpnt);
 
 	return NULL;
 }
@@ -491,38 +503,7 @@
 	 */
 	ASSERT_LOCK(q->queue_lock, 0);
 
-	/*
-	 * Free up any indirection buffers we allocated for DMA purposes. 
-	 * For the case of a READ, we need to copy the data out of the
-	 * bounce buffer and into the real buffer.
-	 */
-	if (SCpnt->use_sg) {
-		struct scatterlist *sgpnt;
-
-		sgpnt = (struct scatterlist *) SCpnt->buffer;
-		scsi_free_sgtable(SCpnt->buffer, SCpnt->sglist_len);
-	} else {
-		if (SCpnt->buffer != req->buffer) {
-			if (rq_data_dir(req) == READ) {
-				unsigned long flags;
-				char *to = bio_kmap_irq(req->bio, &flags);
-
-				memcpy(to, SCpnt->buffer, SCpnt->bufflen);
-				bio_kunmap_irq(to, &flags);
-			}
-			kfree(SCpnt->buffer);
-		}
-	}
-
-	/*
-	 * Zero these out.  They now point to freed memory, and it is
-	 * dangerous to hang onto the pointers.
-	 */
-	SCpnt->buffer  = NULL;
-	SCpnt->bufflen = 0;
-	SCpnt->request_buffer = NULL;
-	SCpnt->request_bufflen = 0;
-
+	scsi_cleanup_io(SCpnt);
 	/*
 	 * Next deal with any sectors which we were able to correctly
 	 * handle.
@@ -582,7 +563,7 @@
 			 */
 			if (SCpnt->sense_buffer[12] == 0x04 &&
 			    SCpnt->sense_buffer[13] == 0x01) {
-				scsi_queue_next_request(q, SCpnt);
+				scsi_queue_next_request(q, SCpnt, SCpnt->host);
 				return;
 			}
 			if ((SCpnt->sense_buffer[2] & 0xf) == UNIT_ATTENTION) {
@@ -600,7 +581,8 @@
 				 	* media change, so we just retry the
 				 	* request and see what happens.  
 				 	*/
-					scsi_queue_next_request(q, SCpnt);
+					scsi_queue_next_request(q, SCpnt,
+								SCpnt->host);
 					return;
 				}
 			}
@@ -620,7 +602,7 @@
 				 * This will cause a retry with a 6-byte
 				 * command.
 				 */
-				scsi_queue_next_request(q, SCpnt);
+				scsi_queue_next_request(q, SCpnt, SCpnt->host);
 				result = 0;
 			} else {
 				SCpnt = scsi_end_request(SCpnt, 0, this_count);
@@ -652,7 +634,7 @@
 		 * recovery reasons.  Just retry the request
 		 * and see what happens.  
 		 */
-		scsi_queue_next_request(q, SCpnt);
+		scsi_queue_next_request(q, SCpnt, SCpnt->host);
 		return;
 	}
 	if (result) {
@@ -661,10 +643,10 @@
 		STpnt = scsi_get_request_dev(SCpnt->request);
 		printk("SCSI %s error : host %d channel %d id %d lun %d return code = %x\n",
 		       (STpnt ? STpnt->name : "device"),
-		       SCpnt->device->host->host_no,
-		       SCpnt->device->channel,
-		       SCpnt->device->id,
-		       SCpnt->device->lun, result);
+		       SCpnt->host->host_no,
+		       SCpnt->channel,
+		       SCpnt->target,
+		       SCpnt->lun, result);
 
 		if (driver_byte(result) & DRIVER_SENSE)
 			print_sense("sd", SCpnt);
@@ -730,6 +712,36 @@
 }
 
 /*
+ * Function:    scsi_dec_check_host_busy
+ *
+ * Purpose:     Decrement host_busy, and see if any action should be taken.
+ *
+ * Arguments:   SHpnt and request q.
+ *
+ * Lock status: Assumes that queue_lock is held when called.
+ *
+ * Returns:     Nothing
+ *
+ * Notes: 	The q arg and local flags are only needed for the locking hack.
+ */
+void scsi_dec_check_host_busy (struct Scsi_Host *SHpnt, request_queue_t * q)
+{
+	unsigned long flags;
+
+	/* XXX gross lock hack */
+	if (SHpnt->host_lock != q->queue_lock)
+		spin_lock_irqsave(SHpnt->host_lock, flags);
+	SHpnt->host_busy--;
+	/*
+	 * XXX check to see if the change in host_busy should kick off
+	 * error handling. This is really only needed if we drop and then
+	 * later lock queue_lock, but it is OK to always check it.
+	 */
+	if (SHpnt->host_lock != q->queue_lock)
+		spin_unlock_irqrestore(SHpnt->host_lock, flags);
+}
+
+/*
  * Function:    scsi_request_fn()
  *
  * Purpose:     Generic version of request function for SCSI hosts.
@@ -754,8 +766,9 @@
 	Scsi_Cmnd *SCpnt;
 	Scsi_Request *SRpnt;
 	Scsi_Device *SDpnt;
-	struct Scsi_Host *SHpnt;
 	struct Scsi_Device_Template *STpnt;
+	struct scsi_path_id path;
+	int res;
 
 	ASSERT_LOCK(q->queue_lock, 1);
 
@@ -763,7 +776,6 @@
 	if (!SDpnt) {
 		panic("Missing device");
 	}
-	SHpnt = SDpnt->host;
 
 	/*
 	 * To start with, we keep looping until the queue is empty, or until
@@ -771,69 +783,41 @@
 	 */
 	while (1 == 1) {
 		/*
-		 * Check this again - each time we loop through we will have
-		 * released the lock and grabbed it again, so each time
-		 * we need to check to see if the queue is plugged or not.
+		 * Each time we loop through we will have released the
+		 * lock and grabbed it again, so each time we need to
+		 * check to see if the queue is plugged or not.
 		 */
-		if (SHpnt->in_recovery || blk_queue_plugged(q))
+		if (blk_queue_plugged(q))
 			return;
-
-		if(SHpnt->host_busy == 0 && SHpnt->host_blocked) {
-			/* unblock after host_blocked iterates to zero */
-			if(--SHpnt->host_blocked == 0) {
-				SCSI_LOG_MLQUEUE(3, printk("scsi%d unblocking host at zero depth\n", SHpnt->host_no));
-			} else {
-				blk_plug_device(q);
-				break;
-			}
-		}
-		if(SDpnt->device_busy == 0 && SDpnt->device_blocked) {
-			/* unblock after device_blocked iterates to zero */
-			if(--SDpnt->device_blocked == 0) {
-				SCSI_LOG_MLQUEUE(3, printk("scsi%d (%d:%d) unblocking device at zero depth\n", SHpnt->host_no, SDpnt->id, SDpnt->lun));
-			} else {
-				blk_plug_device(q);
-				break;
-			}
-		}
-		/*
-		 * If the device cannot accept another request, then quit.
-		 */
-		if (SDpnt->device_blocked) {
-			break;
-		}
-		if ((SHpnt->can_queue > 0 && (SHpnt->host_busy >= SHpnt->can_queue))
-		    || (SHpnt->host_blocked) 
-		    || (SHpnt->host_self_blocked)) {
-			/*
-			 * If we are unable to process any commands at all for
-			 * this device, then we consider it to be starved.
-			 * What this means is that there are no outstanding
-			 * commands for this device and hence we need a
-			 * little help getting it started again
-			 * once the host isn't quite so busy.
-			 */
-			if (SDpnt->device_busy == 0) {
-				SDpnt->starved = 1;
-				SHpnt->some_device_starved = 1;
-			}
-			break;
-		} else {
-			SDpnt->starved = 0;
-		}
-
 		/*
 		 * If we couldn't find a request that could be queued, then we
 		 * can also quit.
 		 */
 		if (blk_queue_empty(q))
 			break;
-
 		/*
 		 * get next queueable request.
 		 */
 		req = elv_next_request(q);
 
+		res = scsi_get_best_path(SDpnt, &path, req);
+		if (res == 1) {
+			/*
+			 * IO is blocked.
+			 */
+			req->flags &= ~REQ_STARTED;
+			return;
+		} else if (res == 2) {
+			/*
+			 * No active paths available.
+			 */
+			blkdev_dequeue_request(req);
+			if (end_that_request_first(req, 0, req->nr_sectors))
+				BUG();
+			end_that_request_last(req);
+			return;
+		}
+
 		/*
 		 * Find the actual device driver associated with this command.
 		 * The SPECIAL requests are things like character device or
@@ -849,12 +833,32 @@
 			SCpnt = (Scsi_Cmnd *) req->special;
 			SRpnt = (Scsi_Request *) req->special;
 
+			/*
+			 * A scsi_do_cmd() or scsi_do_req().
+			 *
+			 * XXX modify Scsi_Request to include a path, if a
+			 * path is set in Scsi_Request, use it here.
+			 */
 			if( SRpnt->sr_magic == SCSI_REQ_MAGIC ) {
 				SCpnt = scsi_allocate_device(SRpnt->sr_device, 
-							     FALSE, FALSE);
-				if (!SCpnt)
+							     FALSE, FALSE, &path);
+				if (!SCpnt) {
+					scsi_host_busy_dec_and_test(path.spi_shpnt, SDpnt);
+					req->flags &= ~REQ_STARTED;
 					break;
+				}
 				scsi_init_cmd_from_req(SCpnt, SRpnt);
+			} else {
+				/* 
+				 * Either a scsi_do_cmd() or a retry of
+				 * scsi_do_req() or scsi_do_cmd().
+				 *
+				 * set SCpnt host/id/lun/channel
+				 */
+				SCpnt->host = path.spi_shpnt;
+				SCpnt->target = path.spi_id;
+				SCpnt->lun = path.spi_lun;
+				SCpnt->channel = path.spi_channel;
 			}
 
 		} else if (req->flags & (REQ_CMD | REQ_BLOCK_PC)) {
@@ -867,30 +871,37 @@
 			 * Now try and find a command block that we can use.
 			 */
 			if (req->special) {
+				/*
+				 * Retry.
+				 */
 				SCpnt = (Scsi_Cmnd *) req->special;
+				SCpnt->host = path.spi_shpnt;
+				SCpnt->target = path.spi_id;
+				SCpnt->lun = path.spi_lun;
+				SCpnt->channel = path.spi_channel;
 			} else {
-				SCpnt = scsi_allocate_device(SDpnt, FALSE, FALSE);
+				SCpnt = scsi_allocate_device(SDpnt, FALSE, FALSE, &path);
 			}
 			/*
 			 * If so, we are ready to do something.  Bump the count
 			 * while the queue is locked and then break out of the
 			 * loop. Otherwise loop around and try another request.
 			 */
-			if (!SCpnt)
+			if (!SCpnt) {
+				scsi_host_busy_dec_and_test(path.spi_shpnt, SDpnt);
+				req->flags &= ~REQ_STARTED;
 				break;
+			}
 
 			/* pull a tag out of the request if we have one */
 			SCpnt->tag = req->tag;
 		} else {
 			blk_dump_rq_flags(req, "SCSI bad req");
+			scsi_host_busy_dec_and_test(path.spi_shpnt, SDpnt);
+			req->flags &= ~REQ_STARTED;
 			break;
 		}
 
-		/*
-		 * Now bump the usage count for both the host and the
-		 * device.
-		 */
-		SHpnt->host_busy++;
 		SDpnt->device_busy++;
 
 		/*
@@ -941,11 +952,11 @@
 			 */
 			if (!scsi_init_io(SCpnt)) {
 				spin_lock_irq(q->queue_lock);
-				SHpnt->host_busy--;
-				SDpnt->device_busy--;
+				scsi_host_busy_dec_and_test(path.spi_shpnt, SDpnt);
+				SDpnt->device_busy--;	/* XXX race */
 				if (SDpnt->device_busy == 0) {
 					SDpnt->starved = 1;
-					SHpnt->some_device_starved = 1;
+					path.spi_shpnt->some_device_starved = 1;
 				}
 				SCpnt->request->special = SCpnt;
 				SCpnt->request->flags |= REQ_SPECIAL;
@@ -967,8 +978,8 @@
 					panic("Should not have leftover blocks\n");
 				}
 				spin_lock_irq(q->queue_lock);
-				SHpnt->host_busy--;
-				SDpnt->device_busy--;
+				scsi_host_busy_dec_and_test(path.spi_shpnt, SDpnt);
+				SDpnt->device_busy--;	/* XXX race */
 				continue;
 			}
 		}
@@ -1035,11 +1046,13 @@
 void scsi_unblock_requests(struct Scsi_Host * SHpnt)
 {
 	Scsi_Device *SDloop;
+	struct scsi_traverse_hndl strav_hndl;
 
 	SHpnt->host_self_blocked = FALSE;
 	/* Now that we are unblocked, try to start the queues. */
-	for (SDloop = SHpnt->host_queue; SDloop; SDloop = SDloop->next)
-		scsi_queue_next_request(&SDloop->request_queue, NULL);
+	scsi_for_each_host_sdev(&strav_hndl, SDloop, SHpnt->host_no) {
+		scsi_queue_next_request(&SDloop->request_queue, NULL, SHpnt);
+	}
 }
 
 /*
@@ -1066,11 +1079,11 @@
 void scsi_report_bus_reset(struct Scsi_Host * SHpnt, int channel)
 {
 	Scsi_Device *SDloop;
-	for (SDloop = SHpnt->host_queue; SDloop; SDloop = SDloop->next) {
-		if (channel == SDloop->channel) {
-			SDloop->was_reset = 1;
-			SDloop->expecting_cc_ua = 1;
-		}
+	struct scsi_traverse_hndl strav_hndl;
+
+	scsi_for_each_host_sdev(&strav_hndl, SDloop, SHpnt->host_no) {
+		SDloop->was_reset = 1;
+		SDloop->expecting_cc_ua = 1;
 	}
 }
 
@@ -1089,4 +1102,97 @@
 
 void scsi_deregister_blocked_host(struct Scsi_Host * SHpnt)
 {
+}
+
+
+/**
+ * scsi_lookup_id - Lookup a scsi device matching an id
+ * @id:	id terminated with '\0'
+ * @sdev_skip:	possibly NULL Scsi_Device to skip if matched
+ *
+ * Description:
+ * Look for a Scsi_Device matching *@id. Uses a linear search. If a
+ * matching Scsi_Device not equal to sdev_skip is found return a pointer
+ * to it, else return NULL.
+ *
+ * Notes:
+ * Change to use driverfs tree.
+ **/
+Scsi_Device *scsi_lookup_id(char *id, Scsi_Device *sdev_skip)
+{
+	Scsi_Device *sdev;
+	struct scsi_traverse_hndl strav_hndl;
+
+	SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO "scsi: id '%s'", id));
+	if (id[0] != SCSI_UID_UNKNOWN)
+		scsi_for_all_sdevs(&strav_hndl, sdev) {
+			/*
+			 * Both id and name should be '\0' terminated.
+			 */
+			if ((sdev != sdev_skip) && 
+			    strcmp(sdev->sdev_driverfs_dev.name,
+				   (char *) id) == 0) {
+				SCSI_LOG_SCAN_BUS(3, printk("; found\n"));
+				return sdev;
+			}
+		}
+	SCSI_LOG_SCAN_BUS(3, printk("; no match\n"));
+	return NULL;
+}
+
+/*
+ * Function:    scsi_add_scsi_device()
+ *
+ * Purpose:     Add a SDpnt to the list of Scsi_Devices, add it to the
+ *		"tail" of the list. If needed, add it to the list for
+ *		shostpnt.
+ *
+ * Arguments:   Scsi_Device pointer SDpnt.
+ *
+ * Notes:       Doesn't do anything other than link in SDpnt, we should add
+ *		other code that is common to the addition of all Scsi_Devices.
+ */
+void scsi_add_scsi_device(Scsi_Device *SDpnt, struct Scsi_Host *shostpnt)
+{
+	Scsi_Device *sdtailpnt;
+
+	SDpnt->sdev_prev = NULL;
+	SDpnt->sdev_next = NULL;
+	if (scsi_sdev_list != NULL) {
+		sdtailpnt = scsi_sdev_list;
+		while (sdtailpnt->sdev_next != NULL)
+			sdtailpnt = sdtailpnt->sdev_next;
+		sdtailpnt->sdev_next = SDpnt;
+		SDpnt->sdev_prev = sdtailpnt;
+	} else
+		scsi_sdev_list = SDpnt;
+}
+
+/*
+ * Function:    scsi_remove_scsi_device
+ *
+ * Purpose:     Remove SDpnt from the list of Scsi_Devices.
+ *
+ * Arguments:   Scsi_Device pointer SDpnt.
+ *
+ * Notes:       unlink and kfree SDpnt, we should add other code that is common
+ * 		to removal of all Scsi_Devices.
+ */
+void scsi_remove_scsi_device(Scsi_Device *SDpnt)
+{
+	if (SDpnt == NULL)
+		return;
+	if (SDpnt->sdev_next != NULL)
+		SDpnt->sdev_next->sdev_prev = SDpnt->sdev_prev;
+	if (SDpnt->sdev_prev != NULL)
+		SDpnt->sdev_prev->sdev_next = SDpnt->sdev_next;
+	if (scsi_sdev_list == SDpnt)
+		scsi_sdev_list = SDpnt->sdev_next;
+	blk_cleanup_queue(&SDpnt->request_queue);
+	scsi_release_commandblocks(SDpnt);
+	scsi_remove_path(SDpnt, SCSI_FIND_ALL_HOST_NO,  SCSI_FIND_ALL_CHANNEL,
+		SCSI_FIND_ALL_ID, SCSI_FIND_ALL_LUN);
+	if (SDpnt->inquiry != NULL)
+		kfree(SDpnt->inquiry);
+	kfree((char *) SDpnt);
 }
diff -Nru a/drivers/scsi/scsi_merge.c b/drivers/scsi/scsi_merge.c
--- a/drivers/scsi/scsi_merge.c	Fri Oct 25 11:26:48 2002
+++ b/drivers/scsi/scsi_merge.c	Fri Oct 25 11:26:48 2002
@@ -22,6 +22,7 @@
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/bio.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/stat.h>
@@ -130,6 +131,58 @@
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
@@ -144,10 +197,12 @@
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
diff -Nru a/drivers/scsi/scsi_paths.c b/drivers/scsi/scsi_paths.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/scsi/scsi_paths.c	Fri Oct 25 11:26:48 2002
@@ -0,0 +1,1499 @@
+/*
+ * Scsi Multi-path Support Library
+ *
+ * Copyright (c) 2002 IBM
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to patmans@us.ibm.com and/or andmike@us.ibm.com
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/blk.h>
+#include <linux/bio.h>
+#include <asm/uaccess.h>
+
+#include "scsi.h"
+#include "hosts.h"
+#include "scsi_paths.h"
+
+#define	SCSI_PATHS_VERSION "Version: 0.05.00"
+
+#ifdef CONFIG_SCSI_MULTI_PATH_IO
+
+#if defined (CONFIG_SCSI_PATH_POLICY_LPU)
+static enum scsi_path_policy scsi_path_dflt_path_policy = SCSI_PATH_POLICY_LPU;
+#elif defined (CONFIG_SCSI_PATH_POLICY_RR)
+static enum scsi_path_policy scsi_path_dflt_path_policy =
+    SCSI_PATH_POLICY_ROUND_ROBIN;
+#else
+#error "Unknown path selection policy"
+#endif
+
+#ifdef MODULE
+MODULE_PARM(scsi_path_dflt_path_policy, "i");
+MODULE_PARM_DESC(scsi_path_dflt_path_policy,
+	"path selection policy, Last Path Used = 1, Round Robin = 2");
+#else
+
+static int __init scsi_path_policy_setup(char *str)
+{
+	unsigned int tmp;
+
+	if (get_option(&str, &tmp) == 1) {
+		scsi_path_dflt_path_policy = tmp;
+		return 1;
+	} else {
+		printk(KERN_INFO "scsi_path_policy_setup: usage "
+		       "scsi_path_dflt_path_policy=n "
+		       "Last Path Used = 1, Round Robin = 2");
+		return 0;
+	}
+}
+
+__setup("scsi_path_dflt_path_policy=", scsi_path_policy_setup);
+
+#endif
+#else
+/*
+ * The path policy has no affect, since there is only one path.
+ */
+static enum scsi_path_policy scsi_path_dflt_path_policy =
+    SCSI_PATH_POLICY_ROUND_ROBIN;
+#endif
+
+
+/*
+ * XXX audit and ensure that we have a lock whenver accessing any paths.
+ */
+
+/**
+ * scsi_paths_printk - printk for each path using the specified format.
+ * @sdev: printk all paths of this Scsi_Device
+ * @prefix: prefix string
+ * @format: a printf format string
+ *
+ * Description: For each path on @sdev, printk the host/channel/id/lun
+ * using the specified @format. For all but the first printk, output
+ * @prefix before @format. @prefix can include a level (such as KERN_INFO).
+ **/
+void scsi_paths_printk(Scsi_Device *sdev, char *prefix, char *format)
+{
+	struct list_head *lh;
+	struct scsi_mpath *mpath;
+	struct scsi_path *pathcur;
+	int not_first_path = 0;
+
+	if (sdev->sdev_paths != NULL) {
+		mpath = (struct scsi_mpath *) sdev->sdev_paths;
+		list_for_each(lh, &mpath->scsi_mp_paths_head) {
+			pathcur =
+			    list_entry(lh, struct scsi_path, sp_path_list);
+			if (not_first_path && prefix)
+				printk(prefix);
+			else
+				not_first_path = 1;
+			printk(format, pathcur->sp_path_id.spi_shpnt->host_no,
+			       pathcur->sp_path_id.spi_channel,
+			       pathcur->sp_path_id.spi_id,
+			       pathcur->sp_path_id.spi_lun);
+		}
+	} else
+		printk("no paths");
+}
+
+/**
+ * scsi_remove_path_from_list - remove a path from an active list
+ * @mpath: get an active list from here
+ * @oldpath:     path to remove
+ * @ind_active: remove from this last active list
+ *
+ * Description:
+ * Remove @oldpath from the active list @ind_active of @mpath. It is
+ * safe to call this function if path is not on the active list.
+ **/
+void scsi_remove_path_from_list(struct scsi_mpath *mpath,
+				struct scsi_path *oldpath, int ind_active)
+{
+	struct scsi_path *last_active;
+	struct scsi_path *pathcur;
+	int ind_next;
+
+	SCSI_LOG_SCAN_BUS(4, printk(KERN_INFO
+		"%s: path <%d, %d, %d, %d>, ind_active %d\n",
+		__FUNCTION__, oldpath->sp_path_id.spi_shpnt->host_no,
+		oldpath->sp_path_id.spi_id, oldpath->sp_path_id.spi_lun,
+		oldpath->sp_path_id.spi_channel, ind_active));
+
+	BUG_ON(ind_active >= SCSI_MAX_ACTIVE_LIST);
+	last_active = mpath->scsi_mp_last_active[ind_active];
+	if (last_active == NULL)
+		return;
+
+	if (ind_active == SCSI_PATHS_ALL_LIST) {
+		ind_next = SCSI_ALL_ACTIVE_NEXT_LIST;
+	} else {
+		ind_next = SCSI_NID_ACTIVE_NEXT_LIST;
+	}
+	pathcur = last_active;
+	do {
+		if (pathcur->sp_active_next[ind_next] == oldpath) {
+			if (pathcur == oldpath)
+				mpath->scsi_mp_last_active[ind_active] = NULL;
+			else {
+				pathcur->sp_active_next[ind_next] =
+				    oldpath->sp_active_next[ind_next];
+				if (last_active == oldpath)
+					mpath->scsi_mp_last_active[ind_active] =
+					    oldpath->sp_active_next[ind_next];
+			}
+			--mpath->scsi_mp_path_active_cnt[ind_active];
+			oldpath->sp_active_next[ind_next] = NULL;
+			return;
+		}
+		pathcur = pathcur->sp_active_next[ind_next];
+	} while (pathcur != last_active);
+}
+
+/**
+ * scsi_remove_active_path - Remove a path from all active lists
+ * @sdev:  Scsi_Device
+ * @oldpath: A scsi path
+ *
+ * Description:
+ * Remove @oldpath from the active lists of Scsi_Device @sdev. It is safe to
+ * call this function if path is not on the active list.
+ **/
+static void scsi_remove_active_path(Scsi_Device *sdev,
+				    struct scsi_path *oldpath)
+{
+	struct scsi_mpath *mpath;
+	int nid;
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	if (mpath == NULL)
+		return;
+
+	nid = scsihost_to_node(oldpath->sp_path_id.spi_shpnt);
+	scsi_remove_path_from_list(mpath, oldpath, nid);
+	if (nid != SCSI_PATHS_ALL_LIST)
+		/*
+		 * No CONFIG_NUMA
+		 */
+		scsi_remove_path_from_list(mpath, oldpath,
+					   SCSI_PATHS_ALL_LIST);
+}
+
+/**
+ * scsi_host_type_check - verify that the host-adapters are the same
+ * @host1 - the Scsi_Host pointer for the first adapter
+ * @host2 - the Scsi_Host pointer for the second adapter
+ *
+ * Description:
+ * Look at host pointers and check the values of certain fields,
+ * looking for incompatibilities that could cause problems.
+ *
+ * Return 1 if they don't match, 0 if they do.
+ **/
+static int scsi_host_type_check(struct Scsi_Host *host1,
+				struct Scsi_Host *host2)
+{
+	int ret = 0;
+
+	static const char message[] = {
+		KERN_WARNING "scsi: the parameter '%s' differs for two"
+			" adapters attached to the same device.\n"
+	};
+
+#define	CHECK_HOST_PARAMS(param) \
+	if (host1->param != host2->param) { \
+		printk(message, __stringify(param)); \
+		ret = 1; \
+	}
+
+	CHECK_HOST_PARAMS(hostt);
+	CHECK_HOST_PARAMS(sg_tablesize);
+	CHECK_HOST_PARAMS(max_sectors);
+	CHECK_HOST_PARAMS(highmem_io);
+	CHECK_HOST_PARAMS(unchecked_isa_dma);
+	CHECK_HOST_PARAMS(use_clustering);
+	CHECK_HOST_PARAMS(max_cmd_len);
+
+#undef CHECK_HOST_PARAMS
+
+	return ret;
+}
+
+/**
+ * scsi_add_active_path - Add a path to an active list
+ * @sdev:  Scsi_Device
+ * @pathcur: A scsi path
+ * @ind_active: index into the scsi_mp_last_active
+ * @ind_next:   index into the sp_active_next
+ *
+ * Description: Add @pathcur to the active list of Scsi_Device @sdev. It is
+ * safe to add a path that is already on the active list (the list will
+ * not be changed).
+ **/
+static void scsi_add_active_path(Scsi_Device *sdev, struct scsi_path *pathcur,
+				 int ind_active)
+{
+	struct scsi_mpath *mpath;
+	struct scsi_path *last_active;
+	int ind_next;
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	if (mpath == NULL)
+		return;
+	BUG_ON(ind_active >= SCSI_MAX_ACTIVE_LIST);
+	if (ind_active == SCSI_PATHS_ALL_LIST)
+		ind_next = SCSI_ALL_ACTIVE_NEXT_LIST;
+	else
+		ind_next = SCSI_NID_ACTIVE_NEXT_LIST;
+	if (pathcur->sp_active_next[ind_next] != NULL)
+		/*
+		 * The path is already on the active list.
+		 */
+		return;
+	else {
+		SCSI_LOG_SCAN_BUS(4, printk(KERN_INFO
+			"%s: sdev 0x%p, path <%d, %d, %d, %d> ind_active %d\n",
+			__FUNCTION__, sdev,
+			pathcur->sp_path_id.spi_shpnt->host_no,
+			pathcur->sp_path_id.spi_id,
+			pathcur->sp_path_id.spi_lun,
+			pathcur->sp_path_id.spi_channel, ind_active));
+
+		last_active = mpath->scsi_mp_last_active[ind_active];
+		if (last_active != NULL) {
+			pathcur->sp_active_next[ind_next] =
+				last_active->sp_active_next[ind_next];
+			last_active->sp_active_next[ind_next] = pathcur;
+		} else {
+			mpath->scsi_mp_last_active[ind_active] = pathcur;
+			pathcur->sp_active_next[ind_next] = pathcur;
+		}
+		++mpath->scsi_mp_path_active_cnt[ind_active];
+	}
+}
+
+/**
+ * scsi_add_path - Add a path to a scsi device
+ * @sdev:  Scsi_Device to add a path to
+ * @shost: Scsi_Host of the path
+ * @channel: Channel value of the path
+ * @id: Id value of the path
+ * @lun: Lun value of the path
+ *
+ * Description:
+ * Add a path corresponding to @shost, @channel, @id, and @lun to the
+ * Scsi_Device @sdev. The new path is also added to the active path. Must
+ * be called with user context (kmalloc GFP_KERNEL).
+ *
+ * Return 1 on error, 0 on success.
+ **/
+int scsi_add_path(Scsi_Device *sdev, struct Scsi_Host *shost,
+		  unsigned int channel, unsigned int id, unsigned int lun)
+{
+	struct scsi_mpath *mpath;
+	struct scsi_path *pathcur;
+	struct Scsi_Host *shostcur;
+	int i, nid;
+
+	SCSI_LOG_SCAN_BUS(4, printk(KERN_INFO
+		"%s: sdev 0x%p path: <%d, %d, %d, %d>\n", __FUNCTION__,
+		sdev, shost->host_no, channel, id, lun));
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+
+	pathcur = kmalloc(sizeof(*pathcur), GFP_KERNEL);
+	if (pathcur == NULL) {
+		printk(KERN_WARNING
+		       "%s: memory allocation failure.\n", __FUNCTION__);
+		return 1;
+	}
+	for (i = 0; i < SCSI_PATHS_MAX_PATH_LISTS; i++)
+		pathcur->sp_active_next[i] = NULL;
+	pathcur->sp_state = SCSI_PATH_STATE_GOOD;
+	pathcur->sp_failures = 0;
+	pathcur->sp_weight = 0;	/* lowest is best */
+	pathcur->sp_path_id.spi_shpnt = shost;
+	pathcur->sp_path_id.spi_id = id;
+	pathcur->sp_path_id.spi_lun = lun;
+	pathcur->sp_path_id.spi_channel = channel;
+
+	if (mpath == NULL) {
+		/*
+		 * First path.
+		 */
+		SCSI_LOG_SCAN_BUS(5, printk(KERN_INFO
+			"%s: adding first path\n", __FUNCTION__));
+		mpath = kmalloc(sizeof(*mpath), GFP_KERNEL);
+		if (mpath == NULL) {
+			printk(KERN_WARNING "%s: memory allocation failure.\n",
+			       __FUNCTION__);
+			kfree(pathcur);
+			return 1;
+		}
+		INIT_LIST_HEAD(&mpath->scsi_mp_paths_head);
+		mpath->scsi_mp_path_policy = scsi_path_dflt_path_policy;
+		for (i = 0; i < SCSI_MAX_ACTIVE_LIST; i++) {
+			mpath->scsi_mp_last_active[i] = NULL;
+			mpath->scsi_mp_path_active_cnt[i] = 0;
+		}
+		(struct scsi_mpath *) sdev->sdev_paths = mpath;
+	} else {
+		if (sdev->single_lun) {
+			printk(KERN_WARNING
+			       "scsi: Multi-path single LUN devices are not "
+			       "supported. path host %d chan %d id %d lun %d "
+			       "not added\n", shost->host_no, channel, id, lun);
+			kfree(pathcur);
+			return 1;
+		}
+		shostcur = scsi_get_host(sdev);
+		BUG_ON(shostcur == NULL);
+		if (scsi_host_type_check(shost, shostcur)) {
+			printk(KERN_ERR "scsi: path host %d chan %d id %d"
+			       " lun %d not added\n", shost->host_no, channel,
+			       id, lun);
+			kfree(pathcur);
+			return 1;
+		}
+		SCSI_LOG_SCAN_BUS(5, printk(KERN_INFO
+			"scsi: adding more paths\n"));
+	}
+
+	list_add_tail(&pathcur->sp_path_list, &mpath->scsi_mp_paths_head);
+	/*
+	 * Add the path to the all list, and possibly to a nid list.
+	 */
+	nid = scsihost_to_node(shost);
+	scsi_add_active_path(sdev, pathcur, nid);
+	if (nid != SCSI_PATHS_ALL_LIST)
+		/*
+		 * CONFIG_NUMA
+		 */
+		scsi_add_active_path(sdev, pathcur, SCSI_PATHS_ALL_LIST);
+
+	SCSI_LOG_SCAN_BUS(5, {
+			  printk(KERN_INFO "%s: All paths for sdev 0x%p:\n    ",
+				 __FUNCTION__, sdev);
+			  scsi_paths_printk(sdev, KERN_INFO "    ",
+					    "<%d, %d, %d, %d>\n");
+			  }
+	);
+	return 0;
+}
+
+/**
+ * scsi_remove_path - Remove a path from a scsi device
+ * @host_no: Host number of the path
+ * @channel: Channel value of the path
+ * @id: Id value of the path
+ * @lun: Lun value of the path
+ * @sdev:  Scsi_Device to add a path to
+ *
+ * Description:
+ * Remove the path corresponding to @host_no, @channel, @id, and @lun from
+ * the Scsi_Device @sdev. The path does not have to exist, so interfaces
+ * can wild card removal of all paths without first checking if any of the
+ * paths actually exist.
+ **/
+void scsi_remove_path(Scsi_Device *sdev, unsigned int host_no,
+		      unsigned int channel, unsigned int id, unsigned int lun)
+{
+	struct scsi_mpath *mpath;
+	struct list_head *lh, *tmplh;
+	struct scsi_path *pathcur;
+
+	SCSI_LOG_SCAN_BUS(4, printk(KERN_INFO
+		 "%s: sdev 0x%p path <%d, %d, %d, %d>\n", __FUNCTION__,
+		 sdev, host_no, channel, id, lun));
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	if (mpath == NULL)
+		return;
+
+	/*
+	 * Look for a matching path, and remove it.
+	 *
+	 * XXX should be common code used by the scsi iterators.
+	 */
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	list_for_each_safe(lh, tmplh, &mpath->scsi_mp_paths_head) {
+		pathcur = list_entry(lh, struct scsi_path, sp_path_list);
+		if ((host_no == SCSI_FIND_ALL_HOST_NO ||
+		     host_no == pathcur->sp_path_id.spi_shpnt->host_no) &&
+		    (channel == SCSI_FIND_ALL_CHANNEL ||
+		     channel == pathcur->sp_path_id.spi_channel) &&
+		    (id == SCSI_FIND_ALL_ID ||
+		     id == pathcur->sp_path_id.spi_id) &&
+		    (lun == SCSI_FIND_ALL_LUN ||
+		     lun == pathcur->sp_path_id.spi_lun)) {
+			scsi_remove_active_path(sdev, pathcur);
+			list_del(&pathcur->sp_path_list);
+			kfree(pathcur);
+		}
+	}
+
+	if (list_empty(&mpath->scsi_mp_paths_head)) {
+		SCSI_LOG_SCAN_BUS(4, printk(KERN_INFO
+		    "%s: sdev 0x%p removed last path\n", __FUNCTION__, sdev));
+		kfree(mpath);
+		sdev->sdev_paths = NULL;
+	}
+	return;
+}
+
+/**
+ * scsi_replace_path - replace the current and only path to a Scsi_Device
+ * @sdev:  replace a path on this Scsi_Device
+ * @host_no: new host number
+ * @channel: new channel value
+ * @id: new id
+ * @lun: new lun
+ *
+ * Description:
+ * Modify the one and only path on @sdev to use @host_no, @channel, @id,
+ * and @lun. This function is _only_ for use during scsi scan, where one
+ * sdev is used to scan an entire host. It is an optimization to avoid
+ * doing a scsi_remove_path and scsi_add_path for each LUN we want to
+ * scan.
+ **/
+void scsi_replace_path(Scsi_Device *sdev, struct Scsi_Host *shost,
+	unsigned int channel, unsigned int id, unsigned int lun)
+{
+	struct scsi_mpath *mpath;
+	struct scsi_path_id *pathid;
+	struct scsi_path *pathcur;
+	int nid;
+	struct list_head *lh;
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	BUG_ON(mpath == NULL);
+	/*
+	 * There should be one and only one path for this sdev.
+	 */
+	list_for_each(lh, &mpath->scsi_mp_paths_head) {
+		pathcur = list_entry(lh, struct scsi_path, sp_path_list);
+		pathid = &pathcur->sp_path_id;
+		SCSI_LOG_SCAN_BUS(5, printk(KERN_INFO
+			 "%s: sdev* 0x%p replace <%d, %d, %d, %d> with"
+			 " <%d, %d, %d, %d>\n", __FUNCTION__, sdev,
+			 pathid->spi_shpnt->host_no, pathid->spi_channel,
+			 pathid->spi_id, pathid->spi_lun,
+			 shost->host_no, channel, id, lun));
+		pathid->spi_shpnt = shost;
+		pathid->spi_channel = channel;
+		pathid->spi_id = id;
+		pathid->spi_lun = lun;
+
+		/*
+		 * Make sure it is still an active path, in case previous
+		 * IO failed the path.
+		 */
+		nid = scsihost_to_node(pathcur->sp_path_id.spi_shpnt);
+		scsi_add_active_path(sdev, pathcur, nid);
+		if (nid != SCSI_PATHS_ALL_LIST)
+			/*
+			 * CONFIG_NUMA
+			 */
+			scsi_add_active_path(sdev, pathcur,
+				SCSI_PATHS_ALL_LIST);
+		return;
+	}
+	BUG();
+}
+
+/**
+ * scsi_get_host - get a Scsi_Host pointer to a Scsi_Device
+ *
+ * @sdev: Get the Scsi_Host of this Scsi_Device pointer
+ *
+ * Description:
+ * Return a pointer to a Scsi_Host so that the capabilities of the of the
+ * host driver can be determined; if no paths exist to sdev, return NULL.
+ *
+ * This should return some generic information rather than a Scsi_Host*.
+ * Alternatively (and probably even better) have one function for each
+ * value needed.
+ *
+ * This function assumes that all paths to a Scsi_Device use the same host
+ * driver - this is enforced during device scanning/discovery. This
+ * function must only be used to get capabilities or the template of the
+ * host - using it to set or get per-Scsi_Host (verus per-host driver)
+ * specific values is a bug (for example, using this to get a host pointer
+ * and then referencing host_busy).
+ **/
+struct Scsi_Host *scsi_get_host(Scsi_Device *sdev)
+{
+	struct scsi_path *pathcur;
+	struct list_head *lh;
+	struct scsi_mpath *mpath;
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	if (mpath == NULL)
+		return NULL;
+	list_for_each(lh, &mpath->scsi_mp_paths_head) {
+		pathcur = list_entry(lh, struct scsi_path, sp_path_list);
+		return pathcur->sp_path_id.spi_shpnt;
+	}
+	return NULL;
+}
+
+/**
+ * scsi_get_path - Get a path to a scsi device
+ * @sdev:  Scsi_Device
+ * @pathid: path id (tuple)
+ *
+ * Description:
+ * Get any @pathid to a Scsi_Device, used by semi-broken code that wants
+ * one host/channel/id/lun of a device. The path returned might not be
+ * active. Return 0 if a path is found, else return 1.
+ **/
+int scsi_get_path(Scsi_Device *sdev, struct scsi_path_id *pathid)
+{
+	struct scsi_path *pathcur;
+	struct scsi_mpath *mpath;
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	if (mpath == NULL)
+		return 1;
+	pathcur = list_entry(mpath->scsi_mp_paths_head.next, struct scsi_path,
+			     sp_path_list);
+	*pathid = pathcur->sp_path_id;
+	return 0;
+}
+
+/**
+ * scsi_path_traverse_sdevs - Return the next Scsi_Device matching the
+ * search requested
+ *
+ * @handle: Handle used to bookmark location of search thus far
+ * @host_no: Host to search for
+ * @channel: Channel to search for
+ * @id:	Id to search for
+ * @lun: Lun to search for
+ *
+ * Description:
+ * Returns - A pointer to Scsi_Device, NULL when the list is complete.
+ * Notes -  Assumes that we do not remove a device between calls.
+ **/
+Scsi_Device *scsi_traverse_sdevs(struct scsi_traverse_hndl *handle, uint
+				 host_no, uint channel, uint id, uint lun)
+{
+	Scsi_Device	*sdev;
+
+	if (handle == NULL)
+		/*
+		 * Really a locate and not a traversal.
+		 */
+		sdev = scsi_sdev_list;
+	else
+		sdev = handle->next_sdev;
+
+	for (; sdev; sdev = sdev->sdev_next) {
+		if (sdev->sdev_paths != NULL) {
+			struct list_head *lh;
+			struct scsi_mpath *mpath_iopnt;
+			struct scsi_path *pathpnt;
+
+			mpath_iopnt = (struct scsi_mpath *) sdev->sdev_paths;
+			list_for_each(lh, &mpath_iopnt->scsi_mp_paths_head) {
+				pathpnt = list_entry(lh, struct scsi_path,
+						    sp_path_list);
+				if ((host_no == SCSI_FIND_ALL_HOST_NO ||
+				   host_no == pathpnt->sp_path_id.spi_shpnt->host_no ) &&
+				   (channel == SCSI_FIND_ALL_CHANNEL ||
+				   channel == pathpnt->sp_path_id.spi_channel ) &&
+				   (id == SCSI_FIND_ALL_ID ||
+				   id == pathpnt->sp_path_id.spi_id ) &&
+				   (lun == SCSI_FIND_ALL_LUN ||
+				   lun == pathpnt->sp_path_id.spi_lun )) {
+					goto done;
+				}
+			}
+		}
+	}
+
+done:
+	if (handle && sdev)
+		handle->next_sdev = sdev->sdev_next;
+	return sdev;
+}
+
+/**
+ * scsi_get_best_path - Get a path for a scsi device.
+ * @sdev:  Scsi_Device
+ * @pathid: A scsi path id (tuple)
+ * @req: request for NUMA so the node closest to req can be found
+ *
+ * Description:
+ * This code is used for normal IO. Get a @pathid for Scsi_Device @sdev.
+ * Skip paths on a busy or blocked host, mark hosts and devices as starved
+ * if needed. Return 2 if no paths at all, 1 if resources are busy, 0 if a
+ * path is found.
+ **/
+int scsi_get_best_path(Scsi_Device *sdev, struct scsi_path_id *pathid,
+		       struct request *req)
+{
+	struct scsi_path *pathcur, *first_path;
+	struct scsi_mpath *mpath;
+	struct Scsi_Host *shost;
+	request_queue_t *q;
+	int found_path, starving, ind_active, ind_next;
+	unsigned long flags = 0;
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	if ((mpath == NULL) ||
+	    (mpath->scsi_mp_last_active[SCSI_PATHS_ALL_LIST] == NULL)) {
+		/*
+		 * No paths or no active paths available.
+		 *
+		 * XXX Fix the following message to include a device name or ?
+		 */
+		printk(KERN_WARNING
+		       "scsi: No active paths available Scsi_Device 0x%p.\n",
+		       sdev);
+		return 2;
+	}
+
+	ind_active = req_to_nid(req);
+#if (MAX_NUMNODES != 1)
+	/*
+	 * If MAX_NUMNODES is 1, not NUMA, and the following check is not
+	 * needed.
+	 */
+	if (ind_active <= MAX_NUMNODES)
+		if (mpath->scsi_mp_last_active[ind_active] == NULL)
+			ind_active = SCSI_PATHS_ALL_LIST;
+#endif
+	first_path = pathcur = mpath->scsi_mp_last_active[ind_active];
+	BUG_ON(ind_active >= SCSI_MAX_ACTIVE_LIST);
+	if (ind_active == SCSI_PATHS_ALL_LIST)
+		ind_next = SCSI_ALL_ACTIVE_NEXT_LIST;
+	else
+		ind_next = SCSI_NID_ACTIVE_NEXT_LIST;
+	found_path = 0;
+	starving = 0;
+	do {
+		shost = pathcur->sp_path_id.spi_shpnt;
+		/*
+		 * XXX hack: host_lock might not equal queue_lock for
+		 * multi-path, or if code is changed. We already hold
+		 * queue_lock.
+		 */
+		q = &sdev->request_queue;
+		if (shost->host_lock != q->queue_lock)
+			spin_lock_irqsave(shost->host_lock, flags);
+		if (!shost->in_recovery) {
+			if ((shost->can_queue > 0 &&
+			     (shost->host_busy >= shost->can_queue))
+			    || (shost->host_blocked)
+			    || (shost->host_self_blocked)) {
+				if (sdev->device_busy == 0) {
+					starving = 1;
+				}
+			} else {
+				found_path = 1;
+				starving = 0;
+				/* do not unlock host shost */
+				break;
+			}
+		}
+		if (shost->host_lock != q->queue_lock)
+			spin_unlock_irqrestore(shost->host_lock, flags);
+		if (mpath->scsi_mp_path_policy != SCSI_PATH_POLICY_LPU)
+			pathcur = pathcur->sp_active_next[ind_next];
+	} while (first_path != pathcur);
+
+	if (starving) {
+		/*
+		 * For now, wait for the local node (or all paths) to get a
+		 * free slot. This means NUMA systems might have a path
+		 * available on a non-local node, but we do not try and
+		 * use it. A hung device should eventually cause
+		 * the local paths to fail, and then the non-local paths
+		 * would be used for futher IO.
+		 *
+		 * All available hosts (on all paths) are busy, and sdev
+		 * is starved. Mark all hosts as having a starved device.
+		 *
+		 * It would be better to put starved devices on a list,
+		 * rather than set a flag.
+		 */
+		sdev->starved = 1;
+		pathcur = first_path = mpath->scsi_mp_last_active[ind_active];
+		do {
+			if (shost->host_lock != q->queue_lock)
+				spin_lock_irqsave(shost->host_lock, flags);
+			shost->some_device_starved = 1;
+			if (shost->host_lock != q->queue_lock)
+				spin_unlock_irqrestore(shost->host_lock, flags);
+			pathcur = pathcur->sp_active_next[ind_next];
+		} while (first_path != pathcur);
+		return 1;
+	} else if (found_path) {
+		sdev->starved = 0;
+		shost->host_busy++;
+		if (shost->host_lock != q->queue_lock)
+			spin_unlock_irqrestore(shost->host_lock, flags);
+	} else
+		/*
+		 * All available hosts (on all paths) are busy, and sdev
+		 * is NOT starved.
+		 */
+		return 1;
+
+	if (mpath->scsi_mp_path_policy == SCSI_PATH_POLICY_ROUND_ROBIN)
+		/*
+		 * This actually sets scsi_mp_last_active[ind_active] to the
+		 * next path to be used, not the last path used.
+		 */
+		mpath->scsi_mp_last_active[ind_active] =
+		    mpath->scsi_mp_last_active[ind_active]->sp_active_next[ind_next];
+	else if (mpath->scsi_mp_path_policy != SCSI_PATH_POLICY_LPU) {
+		printk(KERN_ERR
+		       "%s: invalid scsi_mp_path_policy %d\n", __FUNCTION__,
+		       mpath->scsi_mp_path_policy);
+		return 1;
+	}
+
+	/*
+	 * XXX races with path becoming failed via /proc or user level
+	 * change, this is not too horrible, as the IO will be sent and
+	 * then fail the path again. Fix with proper SMP locking.
+	 */
+	*pathid = pathcur->sp_path_id;
+	return 0;
+}
+
+/**
+ * scsi_check_paths - Check a path in a scsi device.
+ * @path_state: Path state to upate paths with
+ * @check_path: Paths to match
+ * @sdev:  Scsi_Device
+ *
+ * Description:
+ * For the paths in @sdev that match path_list_p, update its path state,
+ * and return a value based on the remaining available paths and the
+ * path_state argument. Called for every IO completion.
+ *
+ * XXX optimize so that the normal case (IO completed with no errors)
+ * requires no searching of all paths. Do this by caching if any paths are
+ * failing, and by caching paths_left. So, for an IO with no errors, the
+ * only time we have to search the paths is when there are any paths failing.
+ * Right now, just caching paths_left is enough since
+ * SCSI_PATH_STATE_FAILING and SCSI_PATH_STATE_DEAD are treated the same.
+ *
+ * Returns REQUEUE (resend the IO) if any paths are left, else returns
+ * SUCCESS (meaning the IO completed, not that it was successful).
+ **/
+static int scsi_check_paths(enum scsi_path_state path_state,
+			    struct scsi_path_id *check_path,
+			    Scsi_Cmnd *scmd)
+{
+	struct scsi_path *pathcur;
+	struct list_head *lh;
+	struct scsi_mpath *mpath;
+	unsigned int paths_left;
+	Scsi_Device *sdev = scmd->device;
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	if ((mpath == NULL) || (sdev->scanning &&
+				(path_state != SCSI_PATH_STATE_GOOD)))
+		/*
+		 * IO should not be retried if there is no sdev_paths, or
+		 * if we have a failure during scanning.
+		 */
+		return SUCCESS;
+	paths_left = 0;
+	list_for_each(lh, &mpath->scsi_mp_paths_head) {
+		pathcur = list_entry(lh, struct scsi_path, sp_path_list);
+		if ((check_path->spi_shpnt->host_no ==
+		     pathcur->sp_path_id.spi_shpnt->host_no)
+		    && (check_path->spi_channel ==
+			pathcur->sp_path_id.spi_channel)
+		    && (check_path->spi_id == pathcur->sp_path_id.spi_id)
+		    && (check_path->spi_lun == pathcur->sp_path_id.spi_lun)) {
+			if (path_state == SCSI_PATH_STATE_GOOD) {
+				/*
+				 * Nothing for now - but this could be
+				 * used to decrement or reset sp_failures.
+				 */
+			} else if (path_state == SCSI_PATH_STATE_FAILING) {
+				pathcur->sp_failures++;
+				if (pathcur->sp_failures > 0) {
+					/*
+					 * For now, treat a possibly failing
+					 * path as a dead path.
+					 */
+					pathcur->sp_state = SCSI_PATH_STATE_DEAD;
+					scsi_remove_active_path(sdev, pathcur);
+					printk(KERN_ERR "scsi: result 0x%x caused path host %d"
+					       " channel %d id %d lun %d failure\n",
+					       scmd->result,
+					       pathcur->sp_path_id.spi_shpnt->host_no,
+					       pathcur->sp_path_id.spi_channel,
+					       pathcur->sp_path_id.spi_id,
+					       pathcur->sp_path_id.spi_lun);
+				}
+			} else if (path_state == SCSI_PATH_STATE_DEAD) {
+				pathcur->sp_state = SCSI_PATH_STATE_DEAD;
+				scsi_remove_active_path(sdev, pathcur);
+				printk(KERN_ERR "scsi: result 0x%x caused path host %d"
+				       " channel %d id %d lun %d failure\n",
+				       scmd->result,
+				       pathcur->sp_path_id.spi_shpnt->host_no,
+				       pathcur->sp_path_id.spi_channel,
+				       pathcur->sp_path_id.spi_id,
+				       pathcur->sp_path_id.spi_lun);
+			} else
+				BUG();
+		}
+		if (pathcur->sp_state == SCSI_PATH_STATE_GOOD)
+			paths_left++;
+	}
+	/*
+	 * Allow up to scmd->allowed retries per path. This is not ideal, but
+	 * allows us to retry at least a few more times - this probably will
+	 * work OK but for example if a new path is added and we get a
+	 * CHECK_CONDITION, if we were in the middle of retrying, we might
+	 * not retry enough times to clear the check on all initiators. There
+	 * might be a similiar issue when failing or removing a path.
+	 *
+	 * A time limit on the IO rather than a retry count would help fix this
+	 * issue - retry until so much time goes by, rather than retry a fixed
+	 * number of times. There are still problems for commands that will
+	 * keep getting (for example) a DID_ERROR.
+	 *
+	 * Also, for tape IO, this prevents any command from being requeued,
+	 * a bad thing for errors that we know could not have gone out to
+	 * the drive.
+	 */
+	SCSI_LOG_ERROR_RECOVERY(5, printk("%s: retries %d, allowed %d,"
+				" paths_left %d\n", __FUNCTION__, 
+				scmd->retries, scmd->allowed, paths_left));
+	if (++scmd->retries < (scmd->allowed * paths_left))
+		return REQUEUE;
+	else
+		return SUCCESS;
+}
+
+/**
+ * scsi_decide_disposition - Check the result of a scsi command
+ * @scmd: Scsi command
+ *
+ * Description:
+ * Check the result of @scmd, and determine how to procede.
+ **/
+int scsi_decide_disposition(Scsi_Cmnd *scmd)
+{
+	int rtn;
+	struct scsi_path_id pathid;
+
+	if (scmd->device->online == FALSE) {
+		SCSI_LOG_ERROR_RECOVERY(5, printk("%s: device offline - report"
+						  " as SUCCESS\n",
+						  __FUNCTION__));
+		return SUCCESS;
+	}
+	pathid.spi_shpnt = scmd->host;
+	pathid.spi_channel = scmd->channel;
+	pathid.spi_id = scmd->target;
+	pathid.spi_lun = scmd->lun;
+	/*
+	 * First check the host byte, to see if there is anything in there
+	 * that would indicate what we need to do.
+	 */
+	switch (host_byte(scmd->result)) {
+	case DID_PASSTHROUGH:
+		/*
+		 * No matter what, pass this through to the upper layer.
+		 * Nuke this special code so that it looks like we are saying
+		 * DID_OK.
+		 */
+		scmd->result &= 0xff00ffff;
+		(void) scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid, scmd);
+		return SUCCESS;
+	case DID_OK:
+		/*
+		 * Looks good.  Drop through, and check the next byte.
+		 */
+		break;
+	case DID_NO_CONNECT:
+	case DID_BAD_TARGET:
+		/*
+		 * Assumes the IO could not have made it to the device.
+		 */
+		rtn = scsi_check_paths(SCSI_PATH_STATE_DEAD, &pathid, scmd);
+		return rtn;
+	case DID_ABORT:
+		/*
+		 * Could this IO have made it to the device?
+		 */
+		rtn = scsi_check_paths(SCSI_PATH_STATE_FAILING, &pathid, scmd);
+		return rtn;
+		/*
+		 * When the low level driver returns DID_SOFT_ERROR,
+		 * it is responsible for keeping an internal retry counter
+		 * in order to avoid endless loops (DB)
+		 *
+		 * Actually this is a bug in this function here.  We should
+		 * be mindful of the maximum number of retries specified
+		 * and not get stuck in a loop.
+		 */
+	case DID_SOFT_ERROR:
+		/*
+		 * Assumes the IO might have made it out to the device.
+		 */
+		goto maybe_retry;
+
+	case DID_ERROR:
+		if (msg_byte(scmd->result) == COMMAND_COMPLETE &&
+		    status_byte(scmd->result) == RESERVATION_CONFLICT)
+			/*
+			 * execute reservation conflict processing code
+			 * lower down
+			 */
+			break;
+		/* fallthrough */
+
+	case DID_BUS_BUSY:
+	case DID_PARITY:
+		/*
+		 * XXX set path to SCSI_PATH_STATE_FAILING?
+		 */
+		goto maybe_retry;
+	case DID_TIME_OUT:
+		/*
+		   * When we scan the bus, we get timeout messages for
+		   * these commands if there is no device available.
+		   * Other hosts report DID_NO_CONNECT for the same thing.
+		 */
+		if ((scmd->cmnd[0] == TEST_UNIT_READY ||
+		     scmd->cmnd[0] == INQUIRY)) {
+			/*
+			 * XXX check the sdev->scanning bit, return
+			 * success if it is set. TUR's should no longer be
+			 * a problem.
+			 */
+			(void) scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid,
+						scmd);
+			return SUCCESS;
+		} else {
+			rtn = scsi_check_paths(SCSI_PATH_STATE_FAILING, &pathid,
+					       scmd);
+			if (rtn == REQUEUE)
+				/*
+				 * FIXME could cause scsi_check_paths to
+				 * incorrectly be called again.
+				 */
+				goto maybe_retry;
+			else
+				return FAILED;
+		}
+	case DID_RESET:
+		/*
+		 * In the normal case where we haven't initiated a reset,
+		 * this is a failure.
+		 */
+		if (scmd->flags & IS_RESETTING) {
+			scmd->flags &= ~IS_RESETTING;
+			goto maybe_retry;
+		}
+		(void) scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid, scmd);
+		return SUCCESS;
+	default:
+		/*
+		 * Likely a bug.
+		 */
+		return FAILED;
+	}
+
+	/*
+	 * Next, check the message byte.
+	 */
+	if (msg_byte(scmd->result) != COMMAND_COMPLETE) {
+		/*
+		 * XXX Use SCSI_PATH_DEAD or SCSI_PATH_FAILING?
+		 */
+		rtn = scsi_check_paths(SCSI_PATH_STATE_DEAD, &pathid, scmd);
+		return rtn;
+	}
+	/*
+	 * Now, check the status byte to see if this indicates anything special.
+	 */
+	switch (status_byte(scmd->result)) {
+	case QUEUE_FULL:
+		/*
+		 * The case of trying to send too many commands to a tagged
+		 * queueing device.
+		 */
+		/* fallthrough */
+	case BUSY:
+		/*
+		 * device can't talk to us at the moment.  Should only
+		 * occur (SAM-3) when the task queue is empty, so will cause
+		 * the empty queue handling to trigger a stall in the
+		 * device.
+		 */
+		(void) scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid, scmd);
+		return ADD_TO_MLQUEUE;
+	case GOOD:
+	case COMMAND_TERMINATED:
+		/*
+		 * Optimize IO completion with no errors case by not calling
+		 * scsi_check_paths here. This is OK as long as there is no
+		 * SCSI_PATH_STATE_FAILING support.
+		 */
+		return SUCCESS;
+	case CHECK_CONDITION:
+		rtn = scsi_check_sense(scmd);
+		if (rtn == NEEDS_RETRY)
+			goto maybe_retry;
+		(void) scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid, scmd);
+		return rtn;
+	case CONDITION_GOOD:
+	case INTERMEDIATE_GOOD:
+	case INTERMEDIATE_C_GOOD:
+		/*
+		 * Who knows?  FIXME(eric)
+		 */
+		(void) scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid, scmd);
+		return SUCCESS;
+	case RESERVATION_CONFLICT:
+		printk(KERN_ERR "scsi%d (%d,%d,%d) : RESERVATION CONFLICT\n",
+		       scmd->host->host_no, scmd->channel,
+		       scmd->target, scmd->lun);
+		(void) scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid, scmd);
+		return SUCCESS; /* causes immediate I/O error */
+	default:
+		(void) scsi_check_paths(SCSI_PATH_STATE_DEAD, &pathid, scmd);
+		return FAILED;
+	}
+	/*
+	 * Dead code.
+	 */
+	return FAILED;
+
+      maybe_retry:
+
+	return scsi_check_paths(SCSI_PATH_STATE_GOOD, &pathid, scmd);
+}
+
+#ifdef CONFIG_PROC_FS
+
+/*
+ * FIXME Add locking to protect paths access via /proc.
+ */
+
+/*
+ * FIXME: generally, use driverfs for attributes rather than procfs.
+ */
+
+/**
+ * scsi_paths_modify - modify a path of a Scsi_Device.
+ *
+ * @sdev:  Scsi_Device pointer to the device whose path is being
+ * modified.
+ * @host_no: Host number of path
+ * @channel: Channel value for lookup
+ * @dev: Id value for lookup
+ * @lun: Lun value for lookup
+ * @new_state: New value for the path's sp_state
+ * @new_failures: New value for the path's sp_failures count
+ * @new_weight: New value for the path's sp_weight
+ *
+ * Description:
+ * For @sdev, modify any path matching the path id with the new values
+ * passed. This is currently only used by the proc interface, but is
+ * likely useful for any user level interface (sysctl or ioctl).
+ **/
+static void scsi_paths_modify(Scsi_Device *sdev, unsigned int host_no,
+			      unsigned int channel, unsigned int id,
+			      unsigned int lun, enum scsi_path_state new_state,
+			      unsigned int new_failures,
+			      unsigned int new_weight)
+{
+	struct scsi_mpath *mpath;
+	struct list_head *lh;
+	struct scsi_path *pathcur;
+	unsigned int prev_path_state;
+
+	if ((sdev == NULL) || (sdev->sdev_paths == NULL))
+		return;
+
+	mpath = (struct scsi_mpath *) sdev->sdev_paths;
+	list_for_each(lh, &mpath->scsi_mp_paths_head) {
+		pathcur = list_entry(lh, struct scsi_path, sp_path_list);
+		if ((host_no == SCSI_FIND_ALL_HOST_NO ||
+		     host_no == pathcur->sp_path_id.spi_shpnt->host_no) &&
+		    (channel == SCSI_FIND_ALL_CHANNEL ||
+		     channel == pathcur->sp_path_id.spi_channel) &&
+		    (id == SCSI_FIND_ALL_ID ||
+		     id == pathcur->sp_path_id.spi_id) &&
+		    (lun == SCSI_FIND_ALL_LUN ||
+		     lun == pathcur->sp_path_id.spi_lun)) {
+			prev_path_state = pathcur->sp_state;
+			pathcur->sp_state = new_state;
+			if (prev_path_state != new_state) {
+				if (new_state == SCSI_PATH_STATE_GOOD) {
+					int nid;
+
+					printk(KERN_WARNING "scsi: setting path host %d"
+					       " channel %d id %d lun %d"
+					       " to good\n",
+					       pathcur->sp_path_id.spi_shpnt->host_no,
+					       pathcur->sp_path_id.spi_channel,
+					       pathcur->sp_path_id.spi_id,
+					       pathcur->sp_path_id.spi_lun);
+					nid = scsihost_to_node(pathcur->sp_path_id.spi_shpnt);
+					scsi_add_active_path(sdev, pathcur,
+							     nid);
+					if (nid != SCSI_PATHS_ALL_LIST)
+						/*
+						 * CONFIG_NUMA
+						 */
+						scsi_add_active_path(sdev,
+							pathcur,
+							SCSI_PATHS_ALL_LIST);
+				} else if (new_state == SCSI_PATH_STATE_FAILING) {
+					/*
+					 * XXX handle failing case.
+					 */
+					printk(KERN_WARNING "scsi: setting path host %d"
+					       " channel %d id %d lun %d"
+					       " to failing\n",
+					       pathcur->sp_path_id.spi_shpnt->host_no,
+					       pathcur->sp_path_id.spi_channel,
+					       pathcur->sp_path_id.spi_id,
+					       pathcur->sp_path_id.spi_lun);
+					scsi_remove_active_path(sdev, pathcur);
+				} else {
+					/*
+					 * SCSI_PATH_STATE_DEAD
+					 */
+					printk(KERN_WARNING "scsi: setting path host %d"
+					       " channel %d id %d lun %d"
+					       " to failed\n",
+					       pathcur->sp_path_id.spi_shpnt->host_no,
+					       pathcur->sp_path_id.spi_channel,
+					       pathcur->sp_path_id.spi_id,
+					       pathcur->sp_path_id.spi_lun);
+					scsi_remove_active_path(sdev, pathcur);
+				}
+			}
+			if (pathcur->sp_failures != new_failures) {
+				pathcur->sp_failures = new_failures;
+				/*
+				 * XXX handle failing case
+				 */
+			}
+			if (pathcur->sp_weight != new_weight) {
+				pathcur->sp_weight = new_weight;
+				/*
+				 * XXX call a function to re-check active
+				 * paths.
+				 */
+			}
+		}
+	}
+}
+
+#include <linux/proc_fs.h>
+static struct proc_dir_entry *scsi_paths_proc_mpp = NULL;
+static const char *scsi_paths_proc_dirname = "scsi_path";
+static const char *scsi_paths_proc_leaf_names[] = { "paths", "version" };
+
+static int scsi_paths_proc_paths_read(char *buffer, char **start, off_t offset,
+				      int size, int *eof, void *data);
+static int scsi_paths_proc_paths_write(struct file *filp, const char *buffer,
+				       unsigned long count, void *data);
+static int scsi_paths_proc_version_read(char *buffer, char **start,
+					off_t offset, int size, int *eof,
+					void *data);
+static read_proc_t *scsi_paths_proc_leaf_reads[] = {
+	scsi_paths_proc_paths_read,
+	scsi_paths_proc_version_read
+};
+
+static write_proc_t *scsi_paths_proc_leaf_writes[] = {
+	scsi_paths_proc_paths_write,
+	NULL			/* version write */
+};
+
+/*
+ * These two macros where copied from
+ * Douglas Gilbert's sg.c
+ */
+#define PRINT_PROC(fmt,args...)                                 \
+    do {                                                        \
+	*len += sprintf(buffer + *len, fmt, ##args);            \
+	if (*begin + *len > offset + size)                      \
+		return 0;                                       \
+	if (*begin + *len < offset) {                           \
+		*begin += *len;                                 \
+		*len = 0;                                       \
+	}                                                       \
+    } while(0)
+
+#define SP_PROC_READ_FN(infofp)                                 \
+    do {                                                        \
+	int len = 0;                                            \
+	off_t begin = 0;                                        \
+	*eof = infofp(buffer, &len, &begin, offset, size);      \
+	if (offset >= (begin + len))                            \
+		return 0;                                       \
+	*start = buffer + offset - begin;                       \
+	return (size < (begin + len - offset)) ?                \
+				size : begin + len - offset;    \
+    } while(0)
+
+int scsi_paths_proc_init(void)
+{
+	int k, mask;
+	int leaves = sizeof(scsi_paths_proc_leaf_names) /
+	    sizeof(scsi_paths_proc_leaf_names[0]);
+	struct proc_dir_entry *pdep;
+
+	if (!proc_scsi)
+		return 1;
+	scsi_paths_proc_mpp = create_proc_entry(scsi_paths_proc_dirname,
+						S_IFDIR | S_IRUGO | S_IXUGO,
+						proc_scsi);
+	if (!scsi_paths_proc_mpp)
+		return 1;
+	for (k = 0; k < leaves; k++) {
+		mask = scsi_paths_proc_leaf_writes[k] ? S_IRUGO | S_IWUSR :
+		    S_IRUGO;
+		pdep = create_proc_entry(scsi_paths_proc_leaf_names[k], mask,
+					 scsi_paths_proc_mpp);
+		if (pdep) {
+			pdep->read_proc = scsi_paths_proc_leaf_reads[k];
+			/*
+			 * scsi_paths_proc_leaf_writes[k] can be NULL.
+			 */
+			pdep->write_proc = scsi_paths_proc_leaf_writes[k];
+		}
+	}
+
+	return 0;
+}
+
+void scsi_paths_proc_cleanup(void)
+{
+	int k;
+	int leaves =
+	    sizeof(scsi_paths_proc_leaf_names) /
+	    sizeof(scsi_paths_proc_leaf_names[0]);
+
+	if ((!proc_scsi) || (!scsi_paths_proc_mpp))
+		return;
+	for (k = 0; k < leaves; ++k)
+		remove_proc_entry(scsi_paths_proc_leaf_names[k],
+				  scsi_paths_proc_mpp);
+	remove_proc_entry(scsi_paths_proc_dirname, proc_scsi);
+}
+
+int scsi_paths_proc_print_paths(Scsi_Device *sdev, char *buffer,
+				char *format)
+{
+	int len = 0;
+	struct list_head *lh;
+	struct scsi_mpath *mpath;
+	struct scsi_path *pathcur;
+
+	if (sdev->sdev_paths != NULL) {
+		mpath = (struct scsi_mpath *) sdev->sdev_paths;
+		list_for_each(lh, &mpath->scsi_mp_paths_head) {
+			pathcur =
+			    list_entry(lh, struct scsi_path, sp_path_list);
+			len += sprintf(buffer + len, format,
+				    pathcur->sp_path_id.spi_shpnt->host_no,
+				    pathcur->sp_path_id.spi_channel,
+				    pathcur->sp_path_id.spi_id,
+				    pathcur->sp_path_id.spi_lun);
+		}
+	}
+	return len;
+}
+
+static int scsi_paths_proc_paths_info(char * buffer, int * len, off_t * begin,
+				      off_t offset, int size)
+{
+	Scsi_Device *sdev;
+	struct scsi_traverse_hndl strav_hndl;
+
+	scsi_for_all_sdevs(&strav_hndl, sdev) {
+		if (sdev->sdev_paths != NULL) {
+			struct list_head *lh;
+			struct scsi_mpath *mpath;
+			struct scsi_path *pathcur;
+
+			/*
+			 * For each path of each device, display:
+			 *
+			 * name:host_no:chan:id:lun:state:failures:weight
+			 *
+			 * The name can now includes spaces, so add a ':'
+			 * separator.
+			 */
+			mpath = (struct scsi_mpath *) sdev->sdev_paths;
+			list_for_each(lh, &mpath->scsi_mp_paths_head) {
+				pathcur = list_entry(lh, struct scsi_path,
+					       sp_path_list);
+				PRINT_PROC("%s", sdev->sdev_driverfs_dev.name);
+				PRINT_PROC(":%x:%x:%x:%x:%x:%x:%x\n",
+					   pathcur->sp_path_id.spi_shpnt->
+					   host_no,
+					   pathcur->sp_path_id.spi_channel,
+					   pathcur->sp_path_id.spi_id,
+					   pathcur->sp_path_id.spi_lun,
+					   pathcur->sp_state,
+					   pathcur->sp_failures,
+					   pathcur->sp_weight);
+			}
+		}
+	}
+
+	return 1;
+}
+
+static int scsi_paths_proc_paths_read(char * buffer, char ** start,
+				      off_t offset, int size, int * eof,
+				      void * data)
+{
+	SP_PROC_READ_FN(scsi_paths_proc_paths_info);
+}
+
+static int scsi_paths_proc_paths_write(struct file *filp, const char *buffer,
+				       unsigned long count, void *data)
+{
+	int res;
+	unsigned int host_no, channel, id, lun;
+	unsigned int path_failures, path_weight;
+	enum scsi_path_state path_state;
+	unsigned char *buff_in = NULL;
+	unsigned char *name_id = NULL;
+	unsigned char *ch_in, *ch_out;
+	Scsi_Device *sdev;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	/*
+	 * We need one more byte for the '\0'
+	 */
+	buff_in = kmalloc(count + 1, GFP_KERNEL);
+	if (buff_in == NULL) {
+		printk(KERN_WARNING "%s: could not malloc\n", __FUNCTION__);
+		count = -ENOMEM;
+		goto done;
+	}
+	name_id = kmalloc(count + 1, GFP_KERNEL);
+	if (name_id == NULL) {
+		printk(KERN_WARNING "%s: could not malloc\n", __FUNCTION__);
+		count = -ENOMEM;
+		goto done;
+	}
+	name_id[0] = '\0';
+
+	if (copy_from_user(buff_in, buffer, count)) {
+		count = -EFAULT;
+		goto done;
+	}
+	buff_in[count] = '\0';
+
+	/*
+	 * For now, only support path state modification by passing in a
+	 * long string. The input string must be 8 values of the form:
+	 *
+	 * name_id:host_no:chan:id:lun:path_state:path_failures:path_weight
+	 *
+	 * name_id is an ASCII string, each of the other values must be hex.
+	 *
+	 * For driverfs, maybe have each path have a field for each value of
+	 * interest; this might be a bit execessive, as we will have (at
+	 * least) 3 values for each path for each device, more if we also
+	 * want to display non-writable values. For example, with 8 paths,
+	 * this is 24 values per Scsi_Device; with 100 Scsi_Devices, this
+	 * is 800 values (just path attributes).
+	 */
+
+	/*
+	 * Since sscanf stops parsing at a space character, pull out the
+	 * name_id first.
+	 */
+	ch_in = buff_in;
+	ch_out = name_id;
+	while (*ch_in != '\0' && *ch_in != ':')
+		*ch_out++ = *ch_in++;
+	*ch_out = '\0';
+
+	if (*ch_in == '\0') {
+		/*
+		 * No ':' at all.
+		 */
+		count = -EINVAL;
+		goto done;
+	}
+
+	res = sscanf(ch_in, ":%x:%x:%x:%x:%x:%x:%x", &host_no, &channel, &id,
+		     &lun, (unsigned int *) &path_state, &path_failures,
+		     &path_weight);
+	if ((res != 7) || ((path_state != SCSI_PATH_STATE_GOOD) &&
+	    (path_state != SCSI_PATH_STATE_FAILING) &&
+	    (path_state != SCSI_PATH_STATE_DEAD))) {
+		count = -EINVAL;
+		goto done;
+	}
+
+	sdev = scsi_lookup_id(name_id, NULL);
+	if (sdev != NULL)
+		scsi_paths_modify(sdev, host_no, channel, id, lun, path_state,
+				  path_failures, path_weight);
+
+  done:
+	if (buff_in != NULL)
+		kfree(buff_in);
+	if (name_id != NULL)
+		kfree(name_id);
+	return count;
+}
+
+static int scsi_paths_proc_version_info(char *buffer, int *len, off_t *begin,
+					off_t offset, int size)
+{
+	PRINT_PROC("%s\n", SCSI_PATHS_VERSION);
+	return 1;
+}
+
+static int scsi_paths_proc_version_read(char *buffer, char **start,
+					off_t offset, int size, int *eof,
+					void *data)
+{
+	SP_PROC_READ_FN(scsi_paths_proc_version_info);
+}
+
+#endif				/* CONFIG_PROC_FS */
