Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751873AbWF2MJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbWF2MJj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 08:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWF2MJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 08:09:39 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:64703 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751873AbWF2MJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 08:09:38 -0400
Date: Thu, 29 Jun 2006 08:09:24 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Esben Nielsen <nielsen.esben@googlemail.com>
cc: Milan Svoboda <msvoboda@ra.rockwell.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Deepak Saxena <dsaxena@plexity.net>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUG] Linux-2.6.17-rt3 on arm ixdp465
In-Reply-To: <Pine.LNX.4.64.0606291334540.10401@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0606290803190.25935@gandalf.stny.rr.com>
References: <OF92240490.78BE8F01-ONC125719C.0037A4FD-C125719C.00389E07@ra.rockwell.com>
 <Pine.LNX.4.64.0606291334540.10401@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Jun 2006, Esben Nielsen wrote:

>
> On Thu, 29 Jun 2006, Milan Svoboda wrote:
>
>
> It seems that dma_unmap_single() on arm contains
>  	local_irq_save(flags);
>
>  	unmap_single(dev, dma_addr, size, dir);
>
>  	local_irq_restore(flags);
>

Yeah I saw this too.

> I don't know the dma code on arm. It doesn't look like a per-cpu code but it
> seems to me that it is not SMP safe and therefore not preempt-realtime
> safe, either.
>
> The hard thing is to figure out which datastructures exactly is protected
> by those irq-disable and put in a spinlock..
>
> I added Deepak Saxena on CC as he seems to be the last one who touched the
> file.
>

Well, the following patch may not be the best but I don't see it being any
worse than what is already there.  I don't have any arm platforms or even
an arm compiler, so I haven't even tested this patch with a compile.  But
it should be at least a temporary fix.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rt4/arch/arm/common/dmabounce.c
===================================================================
--- linux-2.6.17-rt4.orig/arch/arm/common/dmabounce.c	2006-06-29 07:56:54.000000000 -0400
+++ linux-2.6.17-rt4/arch/arm/common/dmabounce.c	2006-06-29 08:04:42.000000000 -0400
@@ -386,6 +386,8 @@ sync_single(struct device *dev, dma_addr

 /* ************************************************** */

+static DEFINE_SPINLOCK(dma_lock);
+
 /*
  * see if a buffer address is in an 'unsafe' range.  if it is
  * allocate a 'safe' buffer and copy the unsafe buffer into it.
@@ -404,11 +406,11 @@ dma_map_single(struct device *dev, void

 	BUG_ON(dir == DMA_NONE);

-	local_irq_save(flags);
+	spin_lock_irqsave(&dma_lock, flags);

 	dma_addr = map_single(dev, ptr, size, dir);

-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&dma_lock, flags);

 	return dma_addr;
 }
@@ -431,11 +433,11 @@ dma_unmap_single(struct device *dev, dma

 	BUG_ON(dir == DMA_NONE);

-	local_irq_save(flags);
+	spin_lock_irqsave(&dma_lock, flags);

 	unmap_single(dev, dma_addr, size, dir);

-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&dma_lock, flags);
 }

 int
@@ -450,7 +452,7 @@ dma_map_sg(struct device *dev, struct sc

 	BUG_ON(dir == DMA_NONE);

-	local_irq_save(flags);
+	spin_lock_irqsave(&dma_lock, flags);

 	for (i = 0; i < nents; i++, sg++) {
 		struct page *page = sg->page;
@@ -462,7 +464,7 @@ dma_map_sg(struct device *dev, struct sc
 			map_single(dev, ptr, length, dir);
 	}

-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&dma_lock, flags);

 	return nents;
 }
@@ -479,7 +481,7 @@ dma_unmap_sg(struct device *dev, struct

 	BUG_ON(dir == DMA_NONE);

-	local_irq_save(flags);
+	spin_lock_irqsave(&dma_lock, flags);

 	for (i = 0; i < nents; i++, sg++) {
 		dma_addr_t dma_addr = sg->dma_address;
@@ -488,7 +490,7 @@ dma_unmap_sg(struct device *dev, struct
 		unmap_single(dev, dma_addr, length, dir);
 	}

-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&dma_lock, flags);
 }

 void
@@ -500,11 +502,11 @@ dma_sync_single_for_cpu(struct device *d
 	dev_dbg(dev, "%s(ptr=%p,size=%d,dir=%x)\n",
 		__func__, (void *) dma_addr, size, dir);

-	local_irq_save(flags);
+	spin_lock_irqsave(&dma_lock, flags);

 	sync_single(dev, dma_addr, size, dir);

-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&dma_lock, flags);
 }

 void
@@ -516,11 +518,11 @@ dma_sync_single_for_device(struct device
 	dev_dbg(dev, "%s(ptr=%p,size=%d,dir=%x)\n",
 		__func__, (void *) dma_addr, size, dir);

-	local_irq_save(flags);
+	spin_lock_irqsave(&dma_lock, flags);

 	sync_single(dev, dma_addr, size, dir);

-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&dma_lock, flags);
 }

 void
@@ -535,7 +537,7 @@ dma_sync_sg_for_cpu(struct device *dev,

 	BUG_ON(dir == DMA_NONE);

-	local_irq_save(flags);
+	spin_lock_irqsave(&dma_lock, flags);

 	for (i = 0; i < nents; i++, sg++) {
 		dma_addr_t dma_addr = sg->dma_address;
@@ -544,7 +546,7 @@ dma_sync_sg_for_cpu(struct device *dev,
 		sync_single(dev, dma_addr, length, dir);
 	}

-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&dma_lock, flags);
 }

 void
@@ -559,7 +561,7 @@ dma_sync_sg_for_device(struct device *de

 	BUG_ON(dir == DMA_NONE);

-	local_irq_save(flags);
+	spin_lock_irqsave(&dma_lock, flags);

 	for (i = 0; i < nents; i++, sg++) {
 		dma_addr_t dma_addr = sg->dma_address;
@@ -568,7 +570,7 @@ dma_sync_sg_for_device(struct device *de
 		sync_single(dev, dma_addr, length, dir);
 	}

-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&dma_lock, flags);
 }

 static int
