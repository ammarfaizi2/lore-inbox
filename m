Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWFDDlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWFDDlr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 23:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWFDDlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 23:41:46 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:38366 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751503AbWFDDli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 23:41:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=EVxG+9OUYNfGIx5bjCpeTFtMxSL/nJqWJJY9gKQ2yQT9tCZrqvMcD7YOHbIUleokMxqL6qERBguw63/oW12wYXwtxrpDm6rsEp6DAG7NKQ/Lhm8yJHkspo/6cUrH9zA/g7JCzZ5GscHEfR28AtZF+6QJmhJ99kazhDiojHu8yk0=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/5] libata: add cpu cache flushes after kmapping and modifying a page
In-Reply-To: <1149392479501-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Sun, 4 Jun 2006 12:41:20 +0900
Message-Id: <11493924801664-git-send-email-htejun@gmail.com>
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

 drivers/scsi/libata-core.c |    5 +++++
 drivers/scsi/libata-scsi.c |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

cc874e5080d87eff23a1576df11ddaaeae9575ec
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b046ffa..47eb263 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2821,6 +2821,7 @@ static void ata_sg_clean(struct ata_queu
 			struct scatterlist *psg = &qc->pad_sgent;
 			void *addr = kmap_atomic(psg->page, KM_IRQ0);
 			memcpy(addr + psg->offset, pad_buf, qc->pad_len);
+			flush_kernel_dcache_page(kmap_atomic_to_page(addr));
 			kunmap_atomic(addr, KM_IRQ0);
 		}
 	} else {
@@ -3451,6 +3452,8 @@ static void ata_pio_sector(struct ata_qu
 	do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	ata_data_xfer(ap, buf, ATA_SECT_SIZE, do_write);
 
+	if (!do_write)
+		flush_kernel_dcache_page(page);
 	kunmap(page);
 }
 
@@ -3533,6 +3536,8 @@ next_sg:
 	/* do the actual data transfer */
 	ata_data_xfer(ap, buf, count, do_write);
 
+	if (!do_write)
+		flush_kernel_dcache_page(page);
 	kunmap(page);
 
 	if (bytes)
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index a0289ec..b65d7f5 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1500,6 +1500,7 @@ static inline void ata_scsi_rbuf_put(str
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *) cmd->request_buffer;
+		flush_kernel_dcache_page(kmap_atomic_to_page(buf - sg->offset));
 		kunmap_atomic(buf - sg->offset, KM_USER0);
 	}
 }
-- 
1.3.2


