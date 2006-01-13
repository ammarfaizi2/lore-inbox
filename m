Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161144AbWAMPYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbWAMPYs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161548AbWAMPYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:24:47 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:59047 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161483AbWAMPY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:24:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=paLPUNWgR0595s5u04rsyYhAj1xWC2b3yVND6DcU8hY9rMpW2ssywtm9XUWJXgaXUiNofVub3bGzPIMMAlBUywwJOdEZqZLNILkAhRnfYGnQn03fMGGYBY+kw0pNu2lCNy2nMI8HPBtmZub4cR6gcz+qqh3nWgSEjJpqj2wtdKA=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/8] block: convert scsi to use blk_kmap helpers
In-Reply-To: <11371658562541-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Sat, 14 Jan 2006 00:24:17 +0900
Message-Id: <1137165857259-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, bzolnier@gmail.com, rmk@arm.linux.org.uk,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert direct uses of kmap/unmap to blk_kmap/unmap in SCSI.  This
combined with the previous bio helper change fixes PIO cache coherency
bugs on architectures with aliased caches.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/3w-9xxx.c        |    8 ++++----
 drivers/scsi/3w-xxxx.c        |    4 ++--
 drivers/scsi/aacraid/aachba.c |    4 ++--
 drivers/scsi/gdth.c           |    5 +++--
 drivers/scsi/ide-scsi.c       |   14 ++++++++------
 drivers/scsi/ips.c            |   21 ++++++++++++++-------
 drivers/scsi/iscsi_tcp.c      |    4 ++--
 drivers/scsi/megaraid.c       |    8 +++++---
 drivers/scsi/qlogicpti.c      |    5 +++--
 drivers/scsi/scsi_debug.c     |   10 ++++++----
 10 files changed, 49 insertions(+), 34 deletions(-)

388ce61deda6116ffeafe3f71ed0e36ba48c8e26
diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 3ff74f4..dd343e1 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -1863,9 +1863,9 @@ static int twa_scsiop_execute_scsi(TW_De
 			if ((tw_dev->srb[request_id]->use_sg == 1) && (tw_dev->srb[request_id]->request_bufflen < TW_MIN_SGL_LENGTH)) {
 				if (tw_dev->srb[request_id]->sc_data_direction == DMA_TO_DEVICE || tw_dev->srb[request_id]->sc_data_direction == DMA_BIDIRECTIONAL) {
 					struct scatterlist *sg = (struct scatterlist *)tw_dev->srb[request_id]->request_buffer;
-					char *buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
+					char *buf = blk_kmap_atomic(sg->page, KM_IRQ0, DMA_TO_DEVICE) + sg->offset;
 					memcpy(tw_dev->generic_buffer_virt[request_id], buf, sg->length);
-					kunmap_atomic(buf - sg->offset, KM_IRQ0);
+					blk_kunmap_atomic(buf - sg->offset, KM_IRQ0, DMA_TO_DEVICE);
 				}
 				command_packet->sg_list[0].address = tw_dev->generic_buffer_phys[request_id];
 				command_packet->sg_list[0].length = TW_MIN_SGL_LENGTH;
@@ -1942,9 +1942,9 @@ static void twa_scsiop_execute_scsi_comp
 		}
 		if (tw_dev->srb[request_id]->use_sg == 1) {
 			struct scatterlist *sg = (struct scatterlist *)tw_dev->srb[request_id]->request_buffer;
-			char *buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
+			char *buf = blk_kmap_atomic(sg->page, KM_IRQ0, DMA_FROM_DEVICE) + sg->offset;
 			memcpy(buf, tw_dev->generic_buffer_virt[request_id], sg->length);
-			kunmap_atomic(buf - sg->offset, KM_IRQ0);
+			blk_kunmap_atomic(buf - sg->offset, KM_IRQ0, DMA_FROM_DEVICE);
 		}
 	}
 } /* End twa_scsiop_execute_scsi_complete() */
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index 283f6d2..21955ed 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -1511,7 +1511,7 @@ static void tw_transfer_internal(TW_Devi
 	if (cmd->use_sg) {
 		struct scatterlist *sg =
 			(struct scatterlist *)cmd->request_buffer;
-		buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
+		buf = blk_kmap_atomic(sg->page, KM_IRQ0, DMA_FROM_DEVICE) + sg->offset;
 		transfer_len = min(sg->length, len);
 	} else {
 		buf = cmd->request_buffer;
@@ -1524,7 +1524,7 @@ static void tw_transfer_internal(TW_Devi
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *)cmd->request_buffer;
-		kunmap_atomic(buf - sg->offset, KM_IRQ0);
+		blk_kunmap_atomic(buf - sg->offset, KM_IRQ0, DMA_FROM_DEVICE);
 	}
 }
 
diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 7139659..089ab56 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -366,7 +366,7 @@ static void aac_internal_transfer(struct
 	struct scatterlist *sg = scsicmd->request_buffer;
 
 	if (scsicmd->use_sg) {
-		buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
+		buf = blk_kmap_atomic(sg->page, KM_IRQ0, DMA_FROM_DEVICE) + sg->offset;
 		transfer_len = min(sg->length, len + offset);
 	} else {
 		buf = scsicmd->request_buffer;
@@ -376,7 +376,7 @@ static void aac_internal_transfer(struct
 	memcpy(buf + offset, data, transfer_len - offset);
 
 	if (scsicmd->use_sg) 
-		kunmap_atomic(buf - sg->offset, KM_IRQ0);
+		blk_kunmap_atomic(buf - sg->offset, KM_IRQ0, DMA_FROM_DEVICE);
 
 }
 
diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
index a6deb01..de5e5cf 100644
--- a/drivers/scsi/gdth.c
+++ b/drivers/scsi/gdth.c
@@ -2560,10 +2560,11 @@ static void gdth_copy_internal_data(int 
                 return;
             }
 	    local_irq_save(flags);
-	    address = kmap_atomic(sl->page, KM_BIO_SRC_IRQ) + sl->offset;
+	    address = blk_kmap_atomic(sl->page, KM_BIO_SRC_IRQ,
+				      DMA_FROM_DEVICE) + sl->offset;
             memcpy(address,buffer,cpnow);
 	    flush_dcache_page(sl->page);
-	    kunmap_atomic(address, KM_BIO_SRC_IRQ);
+	    blk_kunmap_atomic(address, KM_BIO_SRC_IRQ, DMA_FROM_DEVICE);
 	    local_irq_restore(flags);
             if (cpsum == cpcount)
                 break;
diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index 3c688ef..ef935d7 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -184,11 +184,12 @@ static void idescsi_input_buffers (ide_d
 			unsigned long flags;
 
 			local_irq_save(flags);
-			buf = kmap_atomic(pc->sg->page, KM_IRQ0) +
-					pc->sg->offset;
+			buf = blk_kmap_atomic(pc->sg->page, KM_IRQ0,
+					      DMA_FROM_DEVICE) + pc->sg->offset;
 			drive->hwif->atapi_input_bytes(drive,
 						buf + pc->b_count, count);
-			kunmap_atomic(buf - pc->sg->offset, KM_IRQ0);
+			blk_kunmap_atomic(buf - pc->sg->offset, KM_IRQ0,
+					  DMA_FROM_DEVICE);
 			local_irq_restore(flags);
 		} else {
 			buf = page_address(pc->sg->page) + pc->sg->offset;
@@ -219,11 +220,12 @@ static void idescsi_output_buffers (ide_
 			unsigned long flags;
 
 			local_irq_save(flags);
-			buf = kmap_atomic(pc->sg->page, KM_IRQ0) +
-						pc->sg->offset;
+			buf = blk_kmap_atomic(pc->sg->page, KM_IRQ0,
+					      DMA_TO_DEVICE) + pc->sg->offset;
 			drive->hwif->atapi_output_bytes(drive,
 						buf + pc->b_count, count);
-			kunmap_atomic(buf - pc->sg->offset, KM_IRQ0);
+			blk_kunmap_atomic(buf - pc->sg->offset, KM_IRQ0,
+					  DMA_TO_DEVICE);
 			local_irq_restore(flags);
 		} else {
 			buf = page_address(pc->sg->page) + pc->sg->offset;
diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 3882d48..9c1ec4c 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -1626,14 +1626,17 @@ ips_is_passthru(Scsi_Cmnd * SC)
 			/* kmap_atomic() ensures addressability of the user buffer.*/
 			/* local_irq_save() protects the KM_IRQ0 address slot.     */
 			local_irq_save(flags);
-			buffer = kmap_atomic(sg->page, KM_IRQ0) + sg->offset; 
+			buffer = blk_kmap_atomic(sg->page, KM_IRQ0,
+                                                 DMA_TO_DEVICE) + sg->offset; 
 			if (buffer && buffer[0] == 'C' && buffer[1] == 'O' &&
 			    buffer[2] == 'P' && buffer[3] == 'P') {
-				kunmap_atomic(buffer - sg->offset, KM_IRQ0);
+				blk_kunmap_atomic(buffer - sg->offset, KM_IRQ0,
+                                                  DMA_TO_DEVICE);
 				local_irq_restore(flags);
 				return 1;
 			}
-			kunmap_atomic(buffer - sg->offset, KM_IRQ0);
+			blk_kunmap_atomic(buffer - sg->offset, KM_IRQ0,
+                                          DMA_TO_DEVICE);
 			local_irq_restore(flags);
 		}
 	}
@@ -3675,9 +3678,11 @@ ips_scmd_buf_write(Scsi_Cmnd * scmd, voi
 			/* kmap_atomic() ensures addressability of the data buffer.*/
 			/* local_irq_save() protects the KM_IRQ0 address slot.     */
 			local_irq_save(flags);
-			buffer = kmap_atomic(sg[i].page, KM_IRQ0) + sg[i].offset;
+			buffer = blk_kmap_atomic(sg[i].page, KM_IRQ0,
+                                                 DMA_FROM_DEVICE) + sg[i].offset;
 			memcpy(buffer, &cdata[xfer_cnt], min_cnt);
-			kunmap_atomic(buffer - sg[i].offset, KM_IRQ0);
+			blk_kunmap_atomic(buffer - sg[i].offset, KM_IRQ0,
+                                          DMA_FROM_DEVICE);
 			local_irq_restore(flags);
 
 			xfer_cnt += min_cnt;
@@ -3714,9 +3719,11 @@ ips_scmd_buf_read(Scsi_Cmnd * scmd, void
 			/* kmap_atomic() ensures addressability of the data buffer.*/
 			/* local_irq_save() protects the KM_IRQ0 address slot.     */
 			local_irq_save(flags);
-			buffer = kmap_atomic(sg[i].page, KM_IRQ0) + sg[i].offset;
+			buffer = blk_kmap_atomic(sg[i].page, KM_IRQ0,
+                                                 DMA_TO_DEVICE) + sg[i].offset;
 			memcpy(&cdata[xfer_cnt], buffer, min_cnt);
-			kunmap_atomic(buffer - sg[i].offset, KM_IRQ0);
+			blk_kunmap_atomic(buffer - sg[i].offset, KM_IRQ0,
+                                          DMA_TO_DEVICE);
 			local_irq_restore(flags);
 
 			xfer_cnt += min_cnt;
diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 10bcf42..376a56e 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -948,10 +948,10 @@ static int iscsi_scsi_data_in(struct isc
 	for (i = ctask->sg_count; i < sc->use_sg; i++) {
 		char *dest;
 
-		dest = kmap_atomic(sg[i].page, KM_SOFTIRQ0);
+		dest = blk_kmap_atomic(sg[i].page, KM_SOFTIRQ0, DMA_FROM_DEVICE);
 		rc = iscsi_ctask_copy(conn, ctask, dest + sg[i].offset,
 				      sg[i].length, offset);
-		kunmap_atomic(dest, KM_SOFTIRQ0);
+		blk_kunmap_atomic(dest, KM_SOFTIRQ0, DMA_FROM_DEVICE);
 		if (rc == -EAGAIN)
 			/* continue with the next SKB/PDU */
 			return rc;
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 4a6feb1..28087a1 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -661,8 +661,9 @@ mega_build_cmd(adapter_t *adapter, Scsi_
 				struct scatterlist *sg;
 
 				sg = (struct scatterlist *)cmd->request_buffer;
-				buf = kmap_atomic(sg->page, KM_IRQ0) +
-					sg->offset;
+				buf = blk_kmap_atomic(sg->page, KM_IRQ0,
+						      DMA_FROM_DEVICE);
+				buf += sg->offset;
 			} else
 				buf = cmd->request_buffer;
 			memset(buf, 0, cmd->cmnd[4]);
@@ -670,7 +671,8 @@ mega_build_cmd(adapter_t *adapter, Scsi_
 				struct scatterlist *sg;
 
 				sg = (struct scatterlist *)cmd->request_buffer;
-				kunmap_atomic(buf - sg->offset, KM_IRQ0);
+				blk_kunmap_atomic(buf - sg->offset, KM_IRQ0,
+						  DMA_FROM_DEVICE);
 			}
 			cmd->result = (DID_OK << 16);
 			cmd->scsi_done(cmd);
diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 1fd5fc6..fe5f40a 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1128,7 +1128,8 @@ static unsigned int scsi_rbuf_get(struct
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *) cmd->request_buffer;
-		buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
+		buf = blk_kmap_atomic(sg->page, KM_IRQ0, DMA_FROM_DEVICE)
+			+ sg->offset;
 		buflen = sg->length;
 	} else {
 		buf = cmd->request_buffer;
@@ -1145,7 +1146,7 @@ static void scsi_rbuf_put(struct scsi_cm
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *) cmd->request_buffer;
-		kunmap_atomic(buf - sg->offset, KM_IRQ0);
+		blk_kunmap_atomic(buf - sg->offset, KM_IRQ0, DMA_FROM_DEVICE);
 	}
 }
 
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 3ded9da..446fbb1 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -503,7 +503,8 @@ static int fill_from_dev_buffer(struct s
 	for (k = 0, req_len = 0, act_len = 0; k < scp->use_sg; ++k, ++sgpnt) {
 		if (active) {
 			kaddr = (unsigned char *)
-				kmap_atomic(sgpnt->page, KM_USER0);
+				blk_kmap_atomic(sgpnt->page, KM_USER0,
+						DMA_FROM_DEVICE);
 			if (NULL == kaddr)
 				return (DID_ERROR << 16);
 			kaddr_off = (unsigned char *)kaddr + sgpnt->offset;
@@ -513,7 +514,7 @@ static int fill_from_dev_buffer(struct s
 				len = arr_len - req_len;
 			}
 			memcpy(kaddr_off, arr + req_len, len);
-			kunmap_atomic(kaddr, KM_USER0);
+			blk_kunmap_atomic(kaddr, KM_USER0, DMA_FROM_DEVICE);
 			act_len += len;
 		}
 		req_len += sgpnt->length;
@@ -546,7 +547,8 @@ static int fetch_to_dev_buffer(struct sc
 	}
 	sgpnt = (struct scatterlist *)scp->request_buffer;
 	for (k = 0, req_len = 0, fin = 0; k < scp->use_sg; ++k, ++sgpnt) {
-		kaddr = (unsigned char *)kmap_atomic(sgpnt->page, KM_USER0);
+		kaddr = (unsigned char *)blk_kmap_atomic(sgpnt->page, KM_USER0,
+							 DMA_TO_DEVICE);
 		if (NULL == kaddr)
 			return -1;
 		kaddr_off = (unsigned char *)kaddr + sgpnt->offset;
@@ -556,7 +558,7 @@ static int fetch_to_dev_buffer(struct sc
 			fin = 1;
 		}
 		memcpy(arr + req_len, kaddr_off, len);
-		kunmap_atomic(kaddr, KM_USER0);
+		blk_kunmap_atomic(kaddr, KM_USER0, DMA_TO_DEVICE);
 		if (fin)
 			return req_len + len;
 		req_len += sgpnt->length;
-- 
1.0.6


