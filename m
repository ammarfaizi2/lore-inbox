Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWFZOcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWFZOcE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWFZOcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:32:03 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:48619 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1030229AbWFZOcB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:32:01 -0400
Date: Mon, 26 Jun 2006 15:31:59 +0100
To: "vagabon >> Franck" <vagabon.xyz@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm1
Message-ID: <20060626143159.GA700@skynet.ie>
References: <20060623134634.GA6071@skynet.ie> <449C036D.6060004@innova-card.com> <20060623151322.GA13130@skynet.ie> <449C0DF3.601@innova-card.com> <Pine.LNX.4.64.0606231728040.13746@skynet.skynet.ie> <449F9B4C.6000404@innova-card.com> <Pine.LNX.4.64.0606261011480.24431@skynet.skynet.ie> <449FC592.8050409@innova-card.com> <Pine.LNX.4.64.0606261409140.24431@skynet.skynet.ie> <449FE5E0.3050603@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <449FE5E0.3050603@innova-card.com>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (26/06/06 15:49), Franck Bui-Huu didst pronounce:
> Mel Gorman wrote:
> > On Mon, 26 Jun 2006, Franck Bui-Huu wrote:
> > 
> >> Mel Gorman wrote:
> > 
> >>>>> Not all arches will use init_bootmem(). Arm for example uses
> >>>>> init_bootmem_node(). ARCH_PFN_OFFSET is only meant to affect mem_map,
> >>>>>
> >>>> well, I don't agree here. ARCH_PFN_OFFSET is used to save the first
> >>>> page number that has physical memory. I don't see why we couldn't
> >>>> useit to correctly initialise the memory system...
> >>>
> >>> Architectures will not always have a known fixed start of physical
> >>> memory. On IA64 at least, they initialise memory as if it starts at 0
> >>> but on my one test machine, the beginning part is always a memory hole.
> >>
> >> in that case ARCH_PFN_OFFSET is 0 which is the old behaviour, nothing
> >> change...
> >>
> > 
> > The change is that ARCH_PFN_OFFSET has a slightly different meaning when
> > you alter those two initialisation functions. Currently it is used to
> > offset memmap from NODE_DATA(0)->node_start_pfn. By changing
> > free_area_init() and init_bootmem(), it changes to altering the value of
> > NODE_DATA(0)->node_start_pfn but only when memory is initialised in a
> > particular way. 
> 
> well I don't see your point there. Is ARCH_PFN_OFFSET != 0 supposed to work
> with free_area_init() and init_bootmem() ?

I don't know for sure and for that reason alone, I'd rather not change
the meaning of ARCH_PFN_OFFSET as part of a "fix".

> If so, there is a bug since
> NODE_DATA(0)->node_start_pfn is not setup correctly...
> 
> > I think we should just fix the problem at hand now for which two simple
> > patches have been posted and consider making further changes to
> > free_area_init() and init_bootmem() as a separate issue.
> > 
> 
> I agree this is a separate issue. We should resolve it in a different thread.
> Mind to start a new one that involve people who can shed some light here ?
> 

Lets close this out first and then figure out where to go next.  The following
patch should fix the problem where mem_map is offset twice when ARCH_PFN_OFFSET
!= 0 and documents what ARCH_PFN_OFFSET is for.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm2-clean/include/asm-generic/memory_model.h linux-2.6.17-mm2-archpfnfix/include/asm-generic/memory_model.h
--- linux-2.6.17-mm2-clean/include/asm-generic/memory_model.h	2006-06-26 11:38:21.000000000 +0100
+++ linux-2.6.17-mm2-archpfnfix/include/asm-generic/memory_model.h	2006-06-26 15:22:19.000000000 +0100
@@ -6,6 +6,20 @@
 
 #if defined(CONFIG_FLATMEM)
 
+/*
+ * With FLATMEM, the mem_map on node 0 is used as the global mem_map.
+ * This implicitly assumes that NODE_DATA(0)->node_start_pfn == 0 and
+ * represents the first physical page frame in the system. This is not
+ * always the case as an architecture may start physical memory at 3GB
+ * for example. Rather than allocating an empty mem_map to represent
+ * the non-existent memory, ARCH_PFN_OFFSET is subtracted from
+ * NODE_DATA(0)->node_mem_map such that;
+ *
+ * PFN 0 = mem_map = NODE_DATA(0)->node_mem_map - ARCH_PFN_OFFSET
+ *
+ * One would expect NODE_DATA(0)->node_start_pfn == ARCH_PFN_OFFSET but
+ * depending on how memory is initialised, this is not always the case.
+ */
 #ifndef ARCH_PFN_OFFSET
 #define ARCH_PFN_OFFSET		(0UL)
 #endif
@@ -28,9 +42,8 @@
  */
 #if defined(CONFIG_FLATMEM)
 
-#define __pfn_to_page(pfn)	(mem_map + ((pfn) - ARCH_PFN_OFFSET))
-#define __page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
-				 ARCH_PFN_OFFSET)
+#define __pfn_to_page(pfn)	(mem_map + (pfn))
+#define __page_to_pfn(page)	((unsigned long)((page) - mem_map))
 #elif defined(CONFIG_DISCONTIGMEM)
 
 #define __pfn_to_page(pfn)			\
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm2-clean/mm/page_alloc.c linux-2.6.17-mm2-archpfnfix/mm/page_alloc.c
--- linux-2.6.17-mm2-clean/mm/page_alloc.c	2006-06-26 11:38:21.000000000 +0100
+++ linux-2.6.17-mm2-archpfnfix/mm/page_alloc.c	2006-06-26 15:11:29.000000000 +0100
@@ -2103,7 +2103,7 @@ static void __init alloc_node_mem_map(st
 		 * is true. Adjust map relative to node_mem_map to
 		 * maintain this relationship.
 		 */
-		map -= pgdat->node_start_pfn;
+		map -= ARCH_PFN_OFFSET;
 	}
 #ifdef CONFIG_FLATMEM
 	/*

-- 
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
