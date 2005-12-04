Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVLDRnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVLDRnd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 12:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVLDRnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 12:43:33 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:47375 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751143AbVLDRnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 12:43:33 -0500
Date: Sun, 4 Dec 2005 18:42:40 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: andersen@codepoet.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] 2.4.x SATA with highmem
Message-ID: <20051204174240.GA6191@alpha.home.local>
References: <20051201214837.GA25256@havoc.gtf.org> <20051201231008.GA7921@codepoet.org> <438FA62D.2040707@pobox.com> <20051204155911.GA5924@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051204155911.GA5924@alpha.home.local>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Sun, Dec 04, 2005 at 04:59:11PM +0100, Willy Tarreau wrote:
> > >libata-core.c:2427: error: for each function it appears in.)
> > >libata-core.c: In function `ata_sg_setup':
> > >libata-core.c:2701: error: `KM_IRQ0' undeclared (first use in this 
> > >function)
> > >make[2]: *** [libata-core.o] Error 1
> > 
> > hmmm, interesting.  Easy enough to fix.  I guess I didn't build on a 
> > highmem box.
> 
> Same problem for me, but unfortunately, I don't know how to fix this. I've
> seen that KM_IRQ* are not defined on x86. I don't know if I can use other
> ones, not what would be the consequences. Would you please enlighten me a
> bit on this, I'm willing to test it but don't know how to build it first.

Well, after finding a good doc on kmap_atomic on lwn.net, I think I
understood how to fix this. I grepped the whole kernel for kmap_atomic()
and found that KM_BIO_IRQ was only used by ntfs, which had a comment
stating that it was used to support highmem. So I thought we could share
the same type and rediffed the patch, and now the kernel builds.

Here is my proposal, I hope it's correct.

Cheers,
Willy


diff -urN linux-2.4.32-libata1/drivers/scsi/libata-core.c linux-2.4.32-libata1-highmem/drivers/scsi/libata-core.c
--- linux-2.4.32-libata1/drivers/scsi/libata-core.c	2005-12-04 16:32:33.000000000 +0100
+++ linux-2.4.32-libata1-highmem/drivers/scsi/libata-core.c	2005-12-04 18:37:28.000000000 +0100
@@ -2424,9 +2424,9 @@
 		sg[qc->orig_n_elem - 1].length += qc->pad_len;
 		if (pad_buf) {
 			struct scatterlist *psg = &qc->pad_sgent;
-			void *addr = kmap_atomic(psg->page, KM_IRQ0);
+			void *addr = kmap_atomic(psg->page, KM_BIO_IRQ);
 			memcpy(addr + psg->offset, pad_buf, qc->pad_len);
-			kunmap_atomic(psg->page, KM_IRQ0);
+			kunmap_atomic(psg->page, KM_BIO_IRQ);
 		}
 	} else {
 		if (sg_dma_len(&sg[0]) > 0)
@@ -2698,9 +2698,9 @@
 		psg->offset = offset_in_page(offset);
 
 		if (qc->tf.flags & ATA_TFLAG_WRITE) {
-			void *addr = kmap_atomic(psg->page, KM_IRQ0);
+			void *addr = kmap_atomic(psg->page, KM_BIO_IRQ);
 			memcpy(pad_buf, addr + psg->offset, qc->pad_len);
-			kunmap_atomic(psg->page, KM_IRQ0);
+			kunmap_atomic(psg->page, KM_BIO_IRQ);
 		}
 
 		sg_dma_address(psg) = ap->pad_dma + (qc->tag * ATA_DMA_PAD_SZ);


