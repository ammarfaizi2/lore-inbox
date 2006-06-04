Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWFDDlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWFDDlo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 23:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWFDDlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 23:41:42 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:27857 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751497AbWFDDli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 23:41:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=GIWYFRRma6QyqLASQPBQRvdLg/3+7r2TlkePhpOiX1BWRxsYe0SPg6ZWz05m56VpjmRxh/Z8c19jRrBhQVQVpxUWe4wxlWZ+YLyMPYe6rpVq2g7/W7T8Nn8xoqbKV6uPeoLsFdFObARkhL5rIDSWX/iaEeMPbifOMkRGFL9384E=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/5] SCSI: add cpu cache flushes after kmapping and modifying a page
In-Reply-To: <1149392479501-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Sun, 4 Jun 2006 12:41:20 +0900
Message-Id: <11493924803460-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: Jens Axboe <axboe@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
       Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       mattjreimer@gmail.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       rmk@arm.linux.org.uk, lkml <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add calls to flush_kernel_dcache_page() after CPU has kmapped and
modified a page.  This fixes PIO cache coherency bugs on architectures
with aliased caches.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/3w-9xxx.c        |    1 +
 drivers/scsi/3w-xxxx.c        |    1 +
 drivers/scsi/aacraid/aachba.c |    4 +++-
 drivers/scsi/ide-scsi.c       |    1 +
 drivers/scsi/ips.c            |    2 ++
 drivers/scsi/iscsi_tcp.c      |    1 +
 drivers/scsi/megaraid.c       |    2 ++
 drivers/scsi/qlogicpti.c      |    1 +
 drivers/scsi/scsi_debug.c     |    1 +
 drivers/scsi/scsi_lib.c       |    1 +
 10 files changed, 14 insertions(+), 1 deletions(-)

9b4bdd1409efb726d4a6561a4f7e2aff878ab4f4
diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index caeb6d2..172f16b 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -1948,6 +1948,7 @@ static void twa_scsiop_execute_scsi_comp
 			local_irq_save(flags);
 			buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
 			memcpy(buf, tw_dev->generic_buffer_virt[request_id], sg->length);
+			flush_kernel_dcache_page(kmap_atomic_to_page(buf - sg->offset));
 			kunmap_atomic(buf - sg->offset, KM_IRQ0);
 			local_irq_restore(flags);
 		}
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index e8e41e6..8449551 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -1527,6 +1527,7 @@ static void tw_transfer_internal(TW_Devi
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *)cmd->request_buffer;
+		flush_kernel_dcache_page(kmap_atomic_to_page(buf - sg->offset));
 		kunmap_atomic(buf - sg->offset, KM_IRQ0);
 		local_irq_restore(flags);
 	}
diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 642a3b4..b7c00b8 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -376,8 +376,10 @@ static void aac_internal_transfer(struct
 
 	memcpy(buf + offset, data, transfer_len - offset);
 
-	if (scsicmd->use_sg) 
+	if (scsicmd->use_sg) {
+		flush_kernel_dcache_page(kmap_atomic_to_page(buf - sg->offset));
 		kunmap_atomic(buf - sg->offset, KM_IRQ0);
+	}
 
 }
 
diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index 39b760a..9c28b95 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -189,6 +189,7 @@ static void idescsi_input_buffers (ide_d
 					pc->sg->offset;
 			drive->hwif->atapi_input_bytes(drive,
 						buf + pc->b_count, count);
+			flush_kernel_dcache_page(kmap_atomic_to_page(buf - pc->sg->offset));
 			kunmap_atomic(buf - pc->sg->offset, KM_IRQ0);
 			local_irq_restore(flags);
 		} else {
diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index a4c0b04..29eb3f0 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -3682,6 +3682,8 @@ ips_scmd_buf_write(Scsi_Cmnd * scmd, voi
 			local_irq_save(flags);
 			buffer = kmap_atomic(sg[i].page, KM_IRQ0) + sg[i].offset;
 			memcpy(buffer, &cdata[xfer_cnt], min_cnt);
+                        flush_kernel_dcache_page(
+                                kmap_atomic_to_page(buffer - sg[i].offset));
 			kunmap_atomic(buffer - sg[i].offset, KM_IRQ0);
 			local_irq_restore(flags);
 
diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 2068b66..ae9784c 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -945,6 +945,7 @@ static int iscsi_scsi_data_in(struct isc
 		dest = kmap_atomic(sg[i].page, KM_SOFTIRQ0);
 		rc = iscsi_ctask_copy(conn, ctask, dest + sg[i].offset,
 				      sg[i].length, offset);
+		flush_kernel_dcache_page(kmap_atomic_to_page(dest));
 		kunmap_atomic(dest, KM_SOFTIRQ0);
 		if (rc == -EAGAIN)
 			/* continue with the next SKB/PDU */
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index de35ffe..7cb7590 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -671,6 +671,8 @@ #endif
 				struct scatterlist *sg;
 
 				sg = (struct scatterlist *)cmd->request_buffer;
+				flush_kernel_dcache_page(
+					kmap_atomic_to_page(buf - sg->offset));
 				kunmap_atomic(buf - sg->offset, KM_IRQ0);
 			}
 			cmd->result = (DID_OK << 16);
diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index c7e78dc..f8201f2 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1146,6 +1146,7 @@ static void scsi_rbuf_put(struct scsi_cm
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *) cmd->request_buffer;
+		flush_kernel_dcache_page(kmap_atomic_to_page(buf - sg->offset));
 		kunmap_atomic(buf - sg->offset, KM_IRQ0);
 	}
 }
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 5a5d2af..88543db 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -511,6 +511,7 @@ static int fill_from_dev_buffer(struct s
 				len = arr_len - req_len;
 			}
 			memcpy(kaddr_off, arr + req_len, len);
+			flush_kernel_dcache_page(kmap_atomic_to_page(kaddr));
 			kunmap_atomic(kaddr, KM_USER0);
 			act_len += len;
 		}
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 764a8b3..8bb2f6c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -945,6 +945,7 @@ void scsi_io_completion(struct scsi_cmnd
 			unsigned long flags;
 			char *to = bio_kmap_irq(req->bio, &flags);
 			memcpy(to, cmd->buffer, cmd->bufflen);
+			flush_kernel_dcache_page(kmap_atomic_to_page(to));
 			bio_kunmap_irq(to, &flags);
 		}
 		kfree(cmd->buffer);
-- 
1.3.2


