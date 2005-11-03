Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbVKCOnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbVKCOnQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 09:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbVKCOnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 09:43:16 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:44717 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1030193AbVKCOnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 09:43:15 -0500
Date: Thu, 3 Nov 2005 09:43:05 -0500
From: Bob Picco <bob.picco@hp.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       Bob Picco <bob.picco@hp.com>, Dave Hansen <haveblue@us.ibm.com>,
       Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>,
       matthew.e.tolentino@intel.com, discuss@x86-64.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
Message-ID: <20051103144305.GA22938@localhost.localdomain>
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi> <1130607017.12551.5.camel@localhost> <20051031001727.GC6019@localhost.localdomain> <200510310312.18395.ak@suse.de> <222900000.1130908059@[10.10.2.4]> <43690083.5020605@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43690083.5020605@shadowen.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added Matt and discuss@x86-64.org to cc:
Andy Wihitcroft wrote:	[Wed Nov 02 2005, 01:08:03PM EST]
> Martin J. Bligh wrote:
> > 
> > --Andi Kleen <ak@suse.de> wrote (on Monday, October 31, 2005 03:12:17 +0100):
> > 
> > 
> >>On Monday 31 October 2005 01:17, Bob Picco wrote:
> >>Ok the question is - why did nobody submit this patch in time? When
> >>sparse was merged I assumed folks would actually test and maintain
> >>it. But that doesn't seem to be the case? Somewhat surprising.
> 
> We are activly maintaining sparsemem.  But we do seem to have fallen
> short on the testing front on some of the architectures.  I'm looking
> right now into getting some automated testing sorted out for SPARSEMEM
> specifically so that we catch this stuff much earlier in the pipeline,
> as its much simpler for us to find the earlier a problem appears.
> 
> >>I personally don't care much about sparsemem right now because it doesn't have 
> >>any advantage and if it's unmaintained would consider to mark it 
> >>CONFIG_BROKEN. That's simply because we can't have highly experimental 
> >>CONFIGs in a production kernel that unsuspecting users can just set and break 
> >>their configuration.
> >>
> >>Dave, is there someone in charge for sparsemem on x86-64?
> 
> I had assumed that it was being maintained, but its not obvious from
> this thread that we're all on the same page.  But we'll find out and get
> that sorted.
> 
> -apw
> -

Matt responded to a private that I posted to Dave and Matt. Matt is
traveling and told me to go ahead and post a fix.

I removed memory_present called from the FLATMEM routine contig_initmem_init.
Otherwise my original quick patch used for testing SPARSEMEM EXTREME
was nearly complete.

I've boot tested all three configurations (SPARSEMEM, DISCONTIGMEM and CONTIG)
on my DL585 (4 node machine).

bob

Signed-off-by: Bob Picco <bob.picco@hp.com>

 arch/x86_64/kernel/setup.c |    3 ---
 arch/x86_64/mm/numa.c      |   18 +++++++++++++++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

Index: linux-2.6.14/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.14.orig/arch/x86_64/kernel/setup.c	2005-10-30 20:14:11.000000000 -0500
+++ linux-2.6.14/arch/x86_64/kernel/setup.c	2005-11-02 14:23:18.000000000 -0500
@@ -412,7 +412,6 @@ contig_initmem_init(unsigned long start_
 {
 	unsigned long bootmap_size, bootmap;
 
-	memory_present(0, start_pfn, end_pfn);
 	bootmap_size = bootmem_bootmap_pages(end_pfn)<<PAGE_SHIFT;
 	bootmap = find_e820_area(0, end_pfn<<PAGE_SHIFT, bootmap_size);
 	if (bootmap == -1L)
@@ -657,8 +656,6 @@ void __init setup_arch(char **cmdline_p)
 	}
 #endif
 
-	sparse_init();
-
 	paging_init();
 
 	check_ioapic();
Index: linux-2.6.14/arch/x86_64/mm/numa.c
===================================================================
--- linux-2.6.14.orig/arch/x86_64/mm/numa.c	2005-10-31 11:31:02.000000000 -0500
+++ linux-2.6.14/arch/x86_64/mm/numa.c	2005-11-02 17:35:02.000000000 -0500
@@ -94,7 +94,6 @@ void __init setup_node_bootmem(int nodei
 	start_pfn = start >> PAGE_SHIFT;
 	end_pfn = end >> PAGE_SHIFT;
 
-	memory_present(nodeid, start_pfn, end_pfn);
 	nodedata_phys = find_e820_area(start, end, pgdat_size); 
 	if (nodedata_phys == -1L) 
 		panic("Cannot find memory pgdat in node %d\n", nodeid);
@@ -277,9 +276,26 @@ unsigned long __init numa_free_all_bootm
 	return pages;
 } 
 
+#ifdef CONFIG_SPARSEMEM
+static void __init arch_sparse_init(void)
+{
+	int i;
+
+	for_each_online_node(i)
+		memory_present(i, node_start_pfn(i), node_end_pfn(i));
+
+	sparse_init();
+}
+#else
+#define arch_sparse_init() do {} while (0)
+#endif
+
 void __init paging_init(void)
 { 
 	int i;
+
+	arch_sparse_init();
+
 	for_each_online_node(i) {
 		setup_node_zones(i); 
 	}
