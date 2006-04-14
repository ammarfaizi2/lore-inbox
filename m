Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWDNNMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWDNNMx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 09:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWDNNMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 09:12:53 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:5263 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751068AbWDNNMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 09:12:52 -0400
Date: Fri, 14 Apr 2006 14:12:35 +0100
To: "Luck, Tony" <tony.luck@intel.com>
Cc: davej@codemonkey.org.uk, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture independent manner V2
Message-ID: <20060414131235.GA19064@skynet.ie>
References: <20060412232036.18862.84118.sendpatchset@skynet> <20060413095207.GA4047@skynet.ie> <20060413171942.GA15047@agluck-lia64.sc.intel.com> <20060413173008.GA19402@skynet.ie> <20060413174720.GA15183@agluck-lia64.sc.intel.com> <20060413191402.GA20606@skynet.ie> <20060413215358.GA15957@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060413215358.GA15957@agluck-lia64.sc.intel.com>
User-Agent: Mutt/1.5.9i
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (13/04/06 14:53), Luck, Tony didst pronounce:
> On Thu, Apr 13, 2006 at 08:14:02PM +0100, Mel Gorman wrote:
> > When you get around to it later, there is one case you may hit that Bob
> > Picco encountered and fixed for me. It's where a "new" range is registered
> > that is inside an existing area; e.g.
> > 
> > add_active_range:    0->10000
> > add_active_range: 9800->10000
> > 
> > It ends up merging incorrectly and you end up with one region from
> > 9800-10000. The fix is below. 
> 
> I applied that fix on top of all the others and re-built and booted
> a "generic" kernel (using arch/ia64/defconfig) and a "sparse" kernel
> (based on arch/ia64/configs/gensparse_defconfig).
> 
> Both booted just fine on my tiger, the memory amounts looked
> a bit suspicious though ... as if you are reporting *all* the
> memory in range for the zone, rather than the usable parts.
> 
> Diffing console log from the boot of a 2.6.17-rc1 generic
> kernel against one with your patches the relevent bit is:
> 
> < On node 0 totalpages: 259873
> <   DMA zone: 128931 pages, LIFO batch:7
> <   Normal zone: 130942 pages, LIFO batch:7
> ---
> > On node 0 totalpages: 262144
> >   DMA zone: 131072 pages, LIFO batch:7
> >   Normal zone: 131072 pages, LIFO batch:7
> 
> That's a very precise 4G total, split exactly 2G+2G between
> DMA and normal zones.  Same thing for the sparse kernel
> (though I didn't check what an unpatched kernel prints).
> 

Interesting.  I register active ranges inside count_node_pages() which is an
EFI memmap_walk callback. So, I'd expect to see one call to add_active_range()
for each active range in the EFI map;

> add_active_range(0, 0, 4096): New
> add_active_range(0, 0, 131072): Merging forward
> add_active_range(0, 0, 131072): Existing
> add_active_range(0, 393216, 523264): New
> add_active_range(0, 393216, 523264): Existing
> add_active_range(0, 393216, 524288): Merging forward
> add_active_range(0, 393216, 524288): Existing

That appears fine, but I call add_active_range() after a GRANULEROUNDUP and
GRANULEROUNDDOWN has taken place so that might be the problem, especially as
all those ranges are aligned on a 16MiB boundary. The following patch calls
add_active_range() before the rounding takes place. Can you try it out please?

diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-zonesizing-v6/arch/ia64/mm/discontig.c linux-2.6.17-rc1-107-debug/arch/ia64/mm/discontig.c
--- linux-2.6.17-rc1-zonesizing-v6/arch/ia64/mm/discontig.c	2006-04-13 10:30:49.000000000 +0100
+++ linux-2.6.17-rc1-107-debug/arch/ia64/mm/discontig.c	2006-04-14 11:37:51.000000000 +0100
@@ -636,6 +636,7 @@ static __init int count_node_pages(unsig
 {
 	unsigned long end = start + len;
 
+	add_active_range(node, start >> PAGE_SHIFT, end >> PAGE_SHIFT);
 	mem_data[node].num_physpages += len >> PAGE_SHIFT;
 	if (start <= __pa(MAX_DMA_ADDRESS))
 		mem_data[node].num_dma_physpages +=
@@ -647,7 +648,6 @@ static __init int count_node_pages(unsig
 				     end >> PAGE_SHIFT);
 	mem_data[node].min_pfn = min(mem_data[node].min_pfn,
 				     start >> PAGE_SHIFT);
-	add_active_range(node, start >> PAGE_SHIFT, end >> PAGE_SHIFT);
 
 	return 0;
 }
