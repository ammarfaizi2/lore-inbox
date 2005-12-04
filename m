Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVLDSJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVLDSJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 13:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVLDSJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 13:09:58 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:49679 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932095AbVLDSJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 13:09:57 -0500
Date: Sun, 4 Dec 2005 19:09:19 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: andersen@codepoet.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] 2.4.x SATA with highmem
Message-ID: <20051204180919.GA6289@alpha.home.local>
References: <20051201214837.GA25256@havoc.gtf.org> <20051201231008.GA7921@codepoet.org> <438FA62D.2040707@pobox.com> <20051204155911.GA5924@alpha.home.local> <20051204174240.GA6191@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051204174240.GA6191@alpha.home.local>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Again,

sorry for the noise. I applied this patch on an already patched
kernel. KM_BIO_IRQ does not exist on vanilla 2.4.32. However,
KM_SOFTIRQ0 is not used, so here is the patch reworked to use
that instead.

Regards,
Willy

diff -urN linux-2.4.32-libata1/drivers/scsi/libata-core.c linux-2.4.32-libata1-highmem/drivers/scsi/libata-core.c
--- linux-2.4.32-libata1/drivers/scsi/libata-core.c	2005-12-04 16:32:33.000000000 +0100
+++ linux-2.4.32-libata1-highmem/drivers/scsi/libata-core.c	2005-12-04 18:37:28.000000000 +0100
@@ -2424,9 +2424,9 @@
 		sg[qc->orig_n_elem - 1].length += qc->pad_len;
 		if (pad_buf) {
 			struct scatterlist *psg = &qc->pad_sgent;
-			void *addr = kmap_atomic(psg->page, KM_IRQ0);
+			void *addr = kmap_atomic(psg->page, KM_SOFTIRQ0);
 			memcpy(addr + psg->offset, pad_buf, qc->pad_len);
-			kunmap_atomic(psg->page, KM_IRQ0);
+			kunmap_atomic(psg->page, KM_SOFTIRQ0);
 		}
 	} else {
 		if (sg_dma_len(&sg[0]) > 0)
@@ -2698,9 +2698,9 @@
 		psg->offset = offset_in_page(offset);
 
 		if (qc->tf.flags & ATA_TFLAG_WRITE) {
-			void *addr = kmap_atomic(psg->page, KM_IRQ0);
+			void *addr = kmap_atomic(psg->page, KM_SOFTIRQ0);
 			memcpy(pad_buf, addr + psg->offset, qc->pad_len);
-			kunmap_atomic(psg->page, KM_IRQ0);
+			kunmap_atomic(psg->page, KM_SOFTIRQ0);
 		}
 
 		sg_dma_address(psg) = ap->pad_dma + (qc->tag * ATA_DMA_PAD_SZ);
