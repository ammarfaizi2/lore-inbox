Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWEOM1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWEOM1g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 08:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWEOM1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 08:27:36 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:57735 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751448AbWEOM1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 08:27:36 -0400
Date: Mon, 15 May 2006 13:27:29 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, davej@codemonkey.org.uk,
       tony.luck@intel.com, linux-kernel@vger.kernel.org, bob.picco@hp.com,
       ak@suse.de, linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6] Have ia64 use add_active_range() and free_area_init_nodes
Message-ID: <20060515122728.GA29253@skynet.ie>
References: <20060508141030.26912.93090.sendpatchset@skynet> <20060508141211.26912.48278.sendpatchset@skynet> <20060514203158.216a966e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060514203158.216a966e.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (14/05/06 20:31), Andrew Morton didst pronounce:
> Mel Gorman <mel@csn.ul.ie> wrote:
> >
> > Size zones and holes in an architecture independent manner for ia64.
> > 
> 
> This one makes my ia64 die very early in boot.   The trace is pretty useless.
> 
> config at http://www.zip.com.au/~akpm/linux/patches/stuff/config-ia64
> 
> <log snipped>

Curses. When I tried to reproduce this, the machine booted with my default
config but died before initialising the console with your config. The machine
is far away so I can't see the screen or restart the machine remotely so
I can only assume it is dying for the same reasons yours did.

> Note the misaligned pfns.
> 
> Andy's (misspelled) CONFIG_UNALIGNED_ZONE_BOUNDRIES patch didn't actually
> include an update to any Kconfig files.  But hacking that in by hand didn't
> help.

It would not have helped in this case because the zone boundaries would still
be in the wrong place for ia64. Below is a patch that aligns the zones on
all architectures that use CONFIG_ARCH_POPULATES_NODE_MAP . That is currently
i386, x86_64, powerpc, ppc and ia64. It does *not* align pgdat->node_start_pfn
but I don't believe that it is necessary.

I can't test it on ia64 until I get someone to restart the machine. The patch
compiles and is currently boot-testing on a range of other machines. I hope
to know within 5-6 hours if everything is ok.

diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc4-mm4-clean/mm/page_alloc.c linux-2.6.17-rc4-mm4-ia64_force_alignment/mm/page_alloc.c
--- linux-2.6.17-rc4-mm4-clean/mm/page_alloc.c	2006-05-15 10:37:55.000000000 +0100
+++ linux-2.6.17-rc4-mm4-ia64_force_alignment/mm/page_alloc.c	2006-05-15 13:10:42.000000000 +0100
@@ -2640,14 +2640,20 @@ void __init free_area_init_nodes(unsigne
 {
 	unsigned long nid;
 	int zone_index;
+	unsigned long lowest_pfn = find_min_pfn_with_active_regions();
+
+	lowest_pfn = zone_boundary_align_pfn(lowest_pfn);
+	arch_max_dma_pfn = zone_boundary_align_pfn(arch_max_dma_pfn);
+	arch_max_dma32_pfn = zone_boundary_align_pfn(arch_max_dma32_pfn);
+	arch_max_low_pfn = zone_boundary_align_pfn(arch_max_low_pfn);
+	arch_max_high_pfn = zone_boundary_align_pfn(arch_max_high_pfn);
 
 	/* Record where the zone boundaries are */
 	memset(arch_zone_lowest_possible_pfn, 0,
 				sizeof(arch_zone_lowest_possible_pfn));
 	memset(arch_zone_highest_possible_pfn, 0,
 				sizeof(arch_zone_highest_possible_pfn));
-	arch_zone_lowest_possible_pfn[ZONE_DMA] =
-					find_min_pfn_with_active_regions();
+	arch_zone_lowest_possible_pfn[ZONE_DMA] = lowest_pfn;
 	arch_zone_highest_possible_pfn[ZONE_DMA] = arch_max_dma_pfn;
 	arch_zone_highest_possible_pfn[ZONE_DMA32] = arch_max_dma32_pfn;
 	arch_zone_highest_possible_pfn[ZONE_NORMAL] = arch_max_low_pfn;
