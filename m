Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbWJCE2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWJCE2J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 00:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbWJCE2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 00:28:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:15787 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965102AbWJCE2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 00:28:06 -0400
Subject: Re: 2.6.18-rc6-mm2: fix for error compiling ppc/mm/init.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Judith Lebzelter <judith@osdl.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0609141910440.1812@skynet.skynet.ie>
References: <20060914173705.GC19807@shell0.pdx.osdl.net>
	 <Pine.LNX.4.64.0609141910440.1812@skynet.skynet.ie>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 14:24:51 +1000
Message-Id: <1159849491.5482.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 19:11 +0100, Mel Gorman wrote:
> On Thu, 14 Sep 2006, Judith Lebzelter wrote:
> 
> > For ppc in our cross-compile build farm (PLM), there is an error
> > compiling file ppc/mm/init.c:
> >
> >  CC      arch/ppc/mm/init.o
> >  CC      arch/powerpc/kernel/init_task.o
> > arch/ppc/mm/init.c: In function 'paging_init':
> > arch/ppc/mm/init.c:381: error: subscripted value is neither array nor pointer
> > arch/ppc/mm/init.c:383: warning: passing argument 1 of '/' makes pointer from integer without a cast
> > make[1]: [arch/ppc/mm/init.o] Error 1 (ignored)
> >
> >
> > This is caused by an error/oversight in file
> > 'have-power-use-add_active_range-and-free_area_init_nodes.patch'
> >
> > Here is a patch to fix that patch.
> >
> 
> Looks good. Thanks
> 
> Acked-by: Mel Gorman <mel@csn.ul.ie>

Note that the whole ppc patch here seems broken. Sorry for not jumping
earlier, I've been swamped with other things.

First, why the heck do you use indices 0 and 1 explicitely rather than
the symbolic constants ? ppc doesn't have a ZONE_NORMAL, so we should be
filling ZONE_DMA and ZONE_HIGHMEM but you end up filling ZONE_DMA and
ZONE_NORMAL and leave ZONE_HIGHMEM alone. Also, you leave other entries
filled with crap (the array isn't initialized) which cause some strange
display of the PFN list, if not worse problems later, I don't know for
sure at this stage.

I've about to run some tests with this patch. Looks like we need give a
closer look at those patches, in case that breakage appears on other
archs as well (or similar).
---

New zone initialisation on powerpc is broken, especially with
CONFIG_HIGHMEM, this fixes it by initializing the array to 0 and filling
up the right entries.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/mm/mem.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/mem.c	2006-10-03 12:41:03.000000000 +1000
+++ linux-work/arch/powerpc/mm/mem.c	2006-10-03 14:08:30.000000000 +1000
@@ -307,11 +307,12 @@ void __init paging_init(void)
 	       top_of_ram, total_ram);
 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
 	       (top_of_ram - total_ram) >> 20);
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
 #ifdef CONFIG_HIGHMEM
-	max_zone_pfns[0] = total_lowmem >> PAGE_SHIFT;
-	max_zone_pfns[1] = top_of_ram >> PAGE_SHIFT;
+	max_zone_pfns[ZONE_DMA] = total_lowmem >> PAGE_SHIFT;
+	max_zone_pfns[ZONE_HIGHMEM] = top_of_ram >> PAGE_SHIFT;
 #else
-	max_zone_pfns[0] = top_of_ram >> PAGE_SHIFT;
+	max_zone_pfns[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
 #endif
 	free_area_init_nodes(max_zone_pfns);
 }



