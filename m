Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161248AbWG1Tnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161248AbWG1Tnd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 15:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWG1Tnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 15:43:33 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:44908 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030286AbWG1Tnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 15:43:33 -0400
Date: Fri, 28 Jul 2006 21:41:04 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] bootmem: use MAX_DMA_ADDRESS instead of LOW32LIMIT
Message-ID: <20060728194104.GA11622@osiris.ibm.com>
References: <20060728130852.GB9559@osiris.boeblingen.de.ibm.com> <20060728131306.GA32513@elte.hu> <1154098725.3211.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154098725.3211.5.camel@localhost>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 04:58:45PM +0200, Martin Schwidefsky wrote:
> On Fri, 2006-07-28 at 15:13 +0200, Ingo Molnar wrote:
> > > -#define LOW32LIMIT 0xffffffff
> > 
> > >  		if ((ptr = __alloc_bootmem_core(bdata, size,
> > > -						 align, goal, LOW32LIMIT)))
> > > +						 align, goal, MAX_DMA_ADDRESS)))
> > 
> > but this limits things to 16MB on i686. Are you sure this wont break 
> > anything?
> 
> That is something we should not do. MAX_DMA_ADDRESS is not the correct
> value, it says something about the DMA limitations. LOW32LIMIT says
> something about the cpu addressing limitations which is a completly
> different thing. I think it would be best to introduce an architecture
> overridable define like LOW_ADDRESS_LIMIT. The default is 4GB-1, for
> s390 it is 2GB-1. The current name is misleading LOW32LIMIT indicates
> that the address for alloc_bootmem_low objects has 32 bits, which isn't
> true for s390.

Hm... how about this one then:

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Introduce ARCH_LOW_ADDRESS_LIMIT which can be set per architecture to
override the 4GB default limit used by the bootmem allocater within
__alloc_bootmem_low() and __alloc_bootmem_low_node().
E.g. s390 needs a 2GB limit instead of 4GB.

Cc: Ingo Molnar <mingo@elte.hu>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 include/asm-s390/processor.h |    2 ++
 mm/bootmem.c                 |   11 ++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/asm-s390/processor.h b/include/asm-s390/processor.h
index 5b71d37..a21d2c5 100644
--- a/include/asm-s390/processor.h
+++ b/include/asm-s390/processor.h
@@ -337,6 +337,8 @@ struct notifier_block;
 int register_idle_notifier(struct notifier_block *nb);
 int unregister_idle_notifier(struct notifier_block *nb);
 
+#define ARCH_LOW_ADDRESS_LIMIT	0x7fffffffUL
+
 #endif
 
 #endif                                 /* __ASM_S390_PROCESSOR_H           */
diff --git a/mm/bootmem.c b/mm/bootmem.c
index 50353e0..bf99002 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <asm/dma.h>
 #include <asm/io.h>
+#include <asm/processor.h>
 #include "internal.h"
 
 /*
@@ -436,7 +437,9 @@ void * __init __alloc_bootmem_node(pg_da
 	return __alloc_bootmem(size, align, goal);
 }
 
-#define LOW32LIMIT 0xffffffff
+#ifndef ARCH_LOW_ADDRESS_LIMIT
+#define ARCH_LOW_ADDRESS_LIMIT	0xffffffffUL
+#endif
 
 void * __init __alloc_bootmem_low(unsigned long size, unsigned long align, unsigned long goal)
 {
@@ -445,7 +448,8 @@ void * __init __alloc_bootmem_low(unsign
 
 	list_for_each_entry(bdata, &bdata_list, list)
 		if ((ptr = __alloc_bootmem_core(bdata, size,
-						 align, goal, LOW32LIMIT)))
+						align, goal,
+						ARCH_LOW_ADDRESS_LIMIT)))
 			return(ptr);
 
 	/*
@@ -459,5 +463,6 @@ void * __init __alloc_bootmem_low(unsign
 void * __init __alloc_bootmem_low_node(pg_data_t *pgdat, unsigned long size,
 				       unsigned long align, unsigned long goal)
 {
-	return __alloc_bootmem_core(pgdat->bdata, size, align, goal, LOW32LIMIT);
+	return __alloc_bootmem_core(pgdat->bdata, size, align, goal,
+				    ARCH_LOW_ADDRESS_LIMIT);
 }
