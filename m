Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVJaARj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVJaARj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 19:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVJaARj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 19:17:39 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:29673 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932419AbVJaARh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 19:17:37 -0500
Date: Sun, 30 Oct 2005 19:17:27 -0500
From: Bob Picco <bob.picco@hp.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
Message-ID: <20051031001727.GC6019@localhost.localdomain>
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi> <Pine.OSF.4.61.0510291312160.426625@rock.it.helsinki.fi> <Pine.OSF.4.61.0510291749360.404250@rock.it.helsinki.fi> <200510291841.49214.ak@suse.de> <1130607017.12551.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130607017.12551.5.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:	[Sat Oct 29 2005, 01:30:17PM EDT]
> On Sat, 2005-10-29 at 18:41 +0200, Andi Kleen wrote:
> > On Saturday 29 October 2005 16:54, Janne M O Heikkinen wrote:
> > > On Sat, 29 Oct 2005, Janne M O Heikkinen wrote:
> > > 
> > > > No, I get same panics with numa=noacpi or even with numa=off. If I compile
> > > > 2.6.14 kernel without CONFIG_ACPI_NUMA it does boot.
> > > 
> > > It wasn't removing of CONFIG_ACPI_NUMA that made it boot after all, I had
> > > also changed memory model from "Sparse" to "Discontiguous". And now
> > > when I recompiled with CONFIG_ACPI_NUMA=y and with "Discontiguous" memory
> > > model it booted just fine.
> > 
> > Ok, that would explain it. I never test sparse, only discontiguous.
> > sparse is only an experimental option that is not really maintained
> > yet. 	Probably need to disable it if it's broken.
> > 
> > Perhaps Dave H. knows what to do with it.
> 
> I'll try to dig up an Opteron machine on Monday and see what I can do.
> 
> -- Dave
Dave,

This is a slightly modified patch I used on x86_64 for EXTREME testing. The
original 2.6.13-rc1-mhp1 patch didn't apply cleanly against 2.6.14. It will 
apply with this untested patch.  The patch needs to have arch_sparse_init
which is only active for SPARSEMEM. This patch was just for testing EXTREME 
on x86_64 NUMA and needs review.

I think the bootmem allocator is being used before initialized.  This wouldn't
have happened before SPARSEMEM_EXTREME became the default.

If you feel my analysis is correct, I'll generate a cleaner patch and
test on my 4 way.

bob


Index: linux-2.6.14/arch/x86_64/mm/numa.c
===================================================================
--- linux-2.6.14.orig/arch/x86_64/mm/numa.c	2005-10-28 14:24:58.000000000 -0400
+++ linux-2.6.14/arch/x86_64/mm/numa.c	2005-10-30 18:49:20.000000000 -0500
@@ -94,7 +94,6 @@ void __init setup_node_bootmem(int nodei
 	start_pfn = start >> PAGE_SHIFT;
 	end_pfn = end >> PAGE_SHIFT;
 
-	memory_present(nodeid, start_pfn, end_pfn);
 	nodedata_phys = find_e820_area(start, end, pgdat_size); 
 	if (nodedata_phys == -1L) 
 		panic("Cannot find memory pgdat in node %d\n", nodeid);
@@ -280,9 +279,14 @@ unsigned long __init numa_free_all_bootm
 void __init paging_init(void)
 { 
 	int i;
-	for_each_online_node(i) {
+
+	for_each_online_node(i) 
+		memory_present(node_start_pfn(i), node_end_pfn(i));
+	
+	sparse_init();
+
+	for_each_online_node(i) 
 		setup_node_zones(i); 
-	}
 } 
 
 /* [numa=off] */
Index: linux-2.6.14/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.14.orig/arch/x86_64/kernel/setup.c	2005-10-28 14:24:58.000000000 -0400
+++ linux-2.6.14/arch/x86_64/kernel/setup.c	2005-10-30 18:50:05.000000000 -0500
@@ -657,8 +657,6 @@ void __init setup_arch(char **cmdline_p)
 	}
 #endif
 
-	sparse_init();
-
 	paging_init();
 
 	check_ioapic();


