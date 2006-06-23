Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932994AbWFWKUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932994AbWFWKUl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932995AbWFWKUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:20:41 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:28075 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S932994AbWFWKUk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:20:40 -0400
Date: Fri, 23 Jun 2006 11:20:38 +0100
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
Message-ID: <20060623102037.GA1973@skynet.ie>
References: <20060621034857.35cfe36f.akpm@osdl.org> <449AB01A.5000608@innova-card.com> <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie> <449ABC3E.5070609@innova-card.com> <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie> <cda58cb80606221025y63906e81wbec9597b94069b6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <cda58cb80606221025y63906e81wbec9597b94069b6a@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/06/06 19:25), Franck Bui-Huu didst pronounce:
> 2006/6/22, Mel Gorman <mel@csn.ul.ie>:
> >On Thu, 22 Jun 2006, Franck Bui-Huu wrote:
> >
> >> Mel Gorman wrote:
> >>> On Thu, 22 Jun 2006, Franck Bui-Huu wrote:
> >>>>
> >>>> Should ARCH_PFN_OFFSET macro be used instead in order to make pfn/page
> >>>> convertions work when node 0 start offset do not start at 0 ?
> >>>>
> >>>
> >>> What happens if you have ARCH_PFN_OFFSET as
> >>>
> >>> #define ARCH_PFN_OFFSET (0UL)
> >>>
> >>> ?
> >>
> >> It's the default value (see memory_model.h). It means that pfn start
> >> for node 0 is 0, therefore your physical memory address starts at 0.
> >>
> >
> >I know, but what I'm getting at is that ARCH_PFN_OFFSET may be unnecessary
> >with flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch applied.
> 
> yes it seems so. But ARCH_PFN_OFFSET has been used before your patch
> has been sent. So your patch seems to be incomplete...

Difficult to argue with that logic.

> 
> >ARCH_PFN_OFFSET is used as
> >
> >#define page_to_pfn(page)       ((unsigned long)((page) - mem_map) + \
> >                                  ARCH_PFN_OFFSET)
> >
> >because it knew that the map may not start at PFN 0. With
> >flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch, the map will
> >start at PFN 0 even if physical memory does not start until later.
> >
> 
> well your approach's trick is on the mem_map address whereas
> ARCH_PFN_OFFSET's one is on the computation of the index. Your
> solution may result in smaller kernel (when ARCH_PFN_OFFSET != 0)
> because in your case page/pfn conversion is simpler.
> 
> Maybe in your patch instead of doing:
> 
>        map -= pgdat->node_start_pfn;
> 
> you could do:
> 
>        map -= ARCH_OFFSET_PFN;
> 

That will assume that ARCH_OFFSET_PFN is always equal to
NODE_DATA(0)->node_start_pfn which may cause other breakage further down
the line. How about something like this? (boot tested on x86 only)


>>> Begin patch

The FLATMEM memory model assumes that memory is
on contiguous area starting from PFN 0.  The patch
flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch relaxed
this assumption by offsetting mem_map from NODE_DATA(0)->node_mem_map
by NODE_DATA(0)->node_start_pfn. However, some architectures are using
ARCH_OFFSET_PFN to do a similar job at a runtime cost which causes the map
to get offset twice.

This patch catches the situation where ARCH_OFFSET_PFN was being used to
workaround NODE_DATA(0)->node_start_pfn != 0 and prints a message letting
the arch maintainer know that ARCH_OFFSET_PFN may be safe to remove.
Once the message appears on no architectures, it may be safe to remove
ARCH_OFFSET_PFN totally.

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm1-clean/include/asm-generic/memory_model.h linux-2.6.17-mm1-archpfnfix/include/asm-generic/memory_model.h
--- linux-2.6.17-mm1-clean/include/asm-generic/memory_model.h	2006-06-23 09:26:15.000000000 +0100
+++ linux-2.6.17-mm1-archpfnfix/include/asm-generic/memory_model.h	2006-06-23 10:44:18.000000000 +0100
@@ -28,9 +28,8 @@
  */
 #if defined(CONFIG_FLATMEM)
 
-#define __pfn_to_page(pfn)	(mem_map + ((pfn) - ARCH_PFN_OFFSET))
-#define __page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
-				 ARCH_PFN_OFFSET)
+#define __pfn_to_page(pfn)	(mem_map + (pfn))
+#define __page_to_pfn(page)	((unsigned long)((page) - mem_map))
 #elif defined(CONFIG_DISCONTIGMEM)
 
 #define __pfn_to_page(pfn)			\
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm1-clean/mm/page_alloc.c linux-2.6.17-mm1-archpfnfix/mm/page_alloc.c
--- linux-2.6.17-mm1-clean/mm/page_alloc.c	2006-06-23 09:26:15.000000000 +0100
+++ linux-2.6.17-mm1-archpfnfix/mm/page_alloc.c	2006-06-23 10:49:01.000000000 +0100
@@ -2316,7 +2316,22 @@ static void __init alloc_node_mem_map(st
 		 * is true. Adjust map relative to node_mem_map to
 		 * maintain this relationship.
 		 */
-		map -= pgdat->node_start_pfn;
+		if (ARCH_PFN_OFFSET == 0)
+			map -= pgdat->node_start_pfn;
+		else {
+			/*
+			 * If ARCH_PFN_OFFSET is being used to to workaround
+			 * old assumptions of the FLATMEM memory model, print
+			 * a message so that ARCH_PFN_OFFSET can be safely
+			 * removed. If there are no remaining users of
+			 * ARCH_PFN_OFFSET after this message no longer
+			 * shows up, it'll be safe to remove this else block
+			 */
+			if (ARCH_PFN_OFFSET == pgdat->node_start_pfn)
+				printk("ARCH_PFN_OFFSET not necessary\n");
+
+			map -= ARCH_PFN_OFFSET;
+		}
 	}
 #ifdef CONFIG_FLATMEM
 	/*

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
