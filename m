Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422691AbWA0XfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422691AbWA0XfK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbWA0XfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:35:09 -0500
Received: from lixom.net ([66.141.50.11]:43984 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1422691AbWA0XfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:35:07 -0500
Date: Sat, 28 Jan 2006 12:34:43 +1300
To: Mark Haverkamp <markh@osdl.org>
Cc: Olof Johansson <olof@lixom.net>,
       "linuxppc64-dev@ozlabs.org" <linuxppc64-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: iommu_alloc failure and panic
Message-ID: <20060127233443.GB26653@pb15.lixom.net>
References: <1138381060.11796.22.camel@markh3.pdx.osdl.net> <20060127204022.GA26653@pb15.lixom.net> <1138401590.11796.26.camel@markh3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138401590.11796.26.camel@markh3.pdx.osdl.net>
User-Agent: Mutt/1.5.9i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 02:39:50PM -0800, Mark Haverkamp wrote:

> I would have thought that the npages would be 1 now.

No, npages is the size of the allocation coming from the driver, that
won't chance. The table blocksize just says how wide the cacheline size
is, i.e. how far it should advance between allocations.

This is a patch that should probably have been added a while ago, to
give a bit more info. Can you apply it and give it a go?


Thanks,

Olof




Index: 2.6/arch/powerpc/kernel/iommu.c
===================================================================
--- 2.6.orig/arch/powerpc/kernel/iommu.c	2006-01-28 12:18:56.000000000 +1300
+++ 2.6/arch/powerpc/kernel/iommu.c	2006-01-28 12:31:20.000000000 +1300
@@ -146,6 +146,8 @@ static unsigned long iommu_range_alloc(s
 	if (handle)
 		*handle = end;
 
+	tbl->it_used += npages;
+
 	return n;
 }
 
@@ -214,6 +216,8 @@ static void __iommu_free(struct iommu_ta
 	
 	for (i = 0; i < npages; i++)
 		__clear_bit(free_entry+i, tbl->it_map);
+
+	tbl->it_used -= npages;
 }
 
 static void iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
@@ -281,9 +285,11 @@ int iommu_map_sg(struct device *dev, str
 
 		/* Handle failure */
 		if (unlikely(entry == DMA_ERROR_CODE)) {
-			if (printk_ratelimit())
-				printk(KERN_INFO "iommu_alloc failed, tbl %p vaddr %lx"
+			if (printk_ratelimit()) {
+				printk(KERN_INFO "iommu_alloc_sg failed, tbl %p vaddr %lx"
 				       " npages %lx\n", tbl, vaddr, npages);
+				printk(KERN_INFO "table size %lx used %lx\n", tbl->it_size, tbl->it_used);
+			}
 			goto failure;
 		}
 
@@ -422,6 +428,7 @@ struct iommu_table *iommu_init_table(str
 
 	tbl->it_hint = 0;
 	tbl->it_largehint = tbl->it_halfpoint;
+	tbl->it_used = 0;
 	spin_lock_init(&tbl->it_lock);
 
 	/* Clear the hardware table in case firmware left allocations in it */
@@ -496,6 +503,7 @@ dma_addr_t iommu_map_single(struct iommu
 				printk(KERN_INFO "iommu_alloc failed, "
 						"tbl %p vaddr %p npages %d\n",
 						tbl, vaddr, npages);
+				printk(KERN_INFO "table size %lx used %lx\n", tbl->it_size, tbl->it_used);
 			}
 		} else
 			dma_handle |= (uaddr & ~PAGE_MASK);
Index: 2.6/include/asm-powerpc/iommu.h
===================================================================
--- 2.6.orig/include/asm-powerpc/iommu.h	2006-01-21 03:14:30.000000000 +1300
+++ 2.6/include/asm-powerpc/iommu.h	2006-01-28 12:26:39.000000000 +1300
@@ -47,6 +47,7 @@ struct iommu_table {
 	unsigned long  it_largehint; /* Hint for large allocs */
 	unsigned long  it_halfpoint; /* Breaking point for small/large allocs */
 	spinlock_t     it_lock;      /* Protects it_map */
+	unsigned long  it_used;
 	unsigned long *it_map;       /* A simple allocation bitmap for now */
 };
 
