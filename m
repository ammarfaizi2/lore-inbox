Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291088AbSCRRsC>; Mon, 18 Mar 2002 12:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291102AbSCRRrx>; Mon, 18 Mar 2002 12:47:53 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:37077 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291088AbSCRRrj>; Mon, 18 Mar 2002 12:47:39 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200203181746.g2IHkH526567@eng2.beaverton.ibm.com>
Subject: [PATCH] Small fix to pci_alloc_consistent()
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, axboe@suse.de
Date: Mon, 18 Mar 2002 09:46:17 -0800 (PST)
Cc: pbadari@us.ibm.com, janetmor@us.ibm.com (Janet Morgan)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

pci_alloc_consistent() is returning zone DMA memory to highmem 
enabled drivers when it really should have been returning zone NORMAL.

Found this while testing qlogicfc driver for > 4GB support.

Thanks,
Badari


diff -Naur -X dontdiff linux/arch/i386/kernel/pci-dma.c linux.2417all/arch/i386/kernel/pci-dma.c
--- linux/arch/i386/kernel/pci-dma.c    Thu Mar 14 16:01:42 2002
+++ linux.2417all/arch/i386/kernel/pci-dma.c	Thu Mar 14 15:41:40 2002
@@ -19,7 +19,7 @@
 		 void *ret;
 		 int gfp = GFP_ATOMIC;
 
-		 if (hwdev == NULL || hwdev->dma_mask != 0xffffffff)
+		 if (hwdev == NULL || ((u32)hwdev->dma_mask != 0xffffffff))
 		 		 gfp |= GFP_DMA;
 		 ret = (void *)__get_free_pages(gfp, get_order(size));

