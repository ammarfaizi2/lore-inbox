Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWFWN5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWFWN5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWFWN5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:57:48 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:64182 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1750730AbWFWNqg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:46:36 -0400
Date: Fri, 23 Jun 2006 14:46:34 +0100
To: franck.bui-huu@innova-card.com
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
Message-ID: <20060623134634.GA6071@skynet.ie>
References: <20060621034857.35cfe36f.akpm@osdl.org> <449AB01A.5000608@innova-card.com> <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie> <449ABC3E.5070609@innova-card.com> <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie> <cda58cb80606221025y63906e81wbec9597b94069b6a@mail.gmail.com> <20060623102037.GA1973@skynet.ie> <449BDCF5.6040808@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <449BDCF5.6040808@innova-card.com>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/06 14:22), Franck Bui-Huu didst pronounce:
> Mel Gorman wrote:
> > On (22/06/06 19:25), Franck Bui-Huu didst pronounce:
> >>>>
> >>> I know, but what I'm getting at is that ARCH_PFN_OFFSET may be unnecessary
> >>> with flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch applied.
> >> yes it seems so. But ARCH_PFN_OFFSET has been used before your patch
> >> has been sent. So your patch seems to be incomplete...
> > 
> > Difficult to argue with that logic.
> > 
> 
> sorry, I was just meaning that ARCH_PFN_OFFSET had been introduced to
> solve this before your patch has been sent. So the requirement for
> memory to start at pfn 0 is already solved.
> 

In that case, the patch is as simple as you suggested earlier (patch
below). The only downside is that we hold onto ARCH_PFN_OFFSET which is a
bit of an obscure #define if you ask me. The obscurity can be lived with of
course, but it'd be nice to kick away ARCH_PFN_OFFSET if possible.

> IMHO the question is now, which method is the best one ?

My method should very slightly reduce the size of the kernel and have a
very minor performance improvement. How measurable it is depends on how
often page_to_pfn and pfn_to_page are called.

> the we probably need to get ride of the previous method and add yours
> (but don't forget to modify arch such ARM which are currently using
> ARCH_PFN_OFFSET).
> 

If we decide to simply hold onto ARCH_PFN_OFFSET, the fix is simply;

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
+++ linux-2.6.17-mm1-archpfnfix/mm/page_alloc.c	2006-06-23 14:00:11.000000000 +0100
@@ -2316,7 +2316,7 @@ static void __init alloc_node_mem_map(st
 		 * is true. Adjust map relative to node_mem_map to
 		 * maintain this relationship.
 		 */
-		map -= pgdat->node_start_pfn;
+		map -= ARCH_PFN_OFFSET;
 	}
 #ifdef CONFIG_FLATMEM
 	/*

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
