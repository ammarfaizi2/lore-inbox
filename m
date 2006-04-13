Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWDMA65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWDMA65 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 20:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWDMA65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 20:58:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:58267 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932392AbWDMA65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 20:58:57 -0400
From: Andi Kleen <ak@suse.de>
To: Mel Gorman <mel@skynet.ie>
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture independent manner V2
Date: Thu, 13 Apr 2006 02:56:59 +0200
User-Agent: KMail/1.9.1
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bob.picco@hp.com, Linux Memory Management List <linux-mm@kvack.org>
References: <20060412232036.18862.84118.sendpatchset@skynet> <200604130153.08604.ak@suse.de> <Pine.LNX.4.64.0604130058210.18950@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0604130058210.18950@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604130257.00203.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 April 2006 02:22, Mel Gorman wrote:

> I experimented with the idea of all architectures sharing the struct 
> node_active_region rather than storing the information twice. It got very 
> messy, particularly for x86 because it needs to store more than nid, 
> start_pfn and end_pfn for a range of page frames (see node_memory_chunk_s 
> in arch/i386/kernel/srat.c). Worse, some architecture-specific code 
> remembers the ranges of active memory as addresses and others as pfn's. In 
> the end, I was not too worried about having the information in two places, 
> because the active ranges are kept in __initdata and gets freed.

The problem is not memory consumption but complexity of code/data structures.
Keeping information in two places is usually a good cue that something 
is wrong. This code is also fragile and hard to test.
 
> I'll admit that for x86_64, the entire code path for initialisation (i.e. 
> architecture specific and architecture independent paths) is now more 
> complex. The architecture independent code needed to be able to handle 
> every variety of node layout which is overkill for x86_64. Nevertheless, 
> without size_zones(), I thought the architecture-specific code for x86_64 
> memory initialisation was a bit easier to read. With 
> architecture-independent zone size and hole calculation, you only have to 
> understand the relevant code once, not once for each architecture.


I think i386 SRAT NUMA should be just removed at some point - it never
worked all that well and is quite complicated. That leaves IA64, x86-64
and ppc64.  I suspect keeping the code there near their low level
data structures is better.

> > I have my doubts that is really a improvement over the old state.
> >
> 
> For x86_64 in isolation or the entire set of patches?

For x86-64/i386. I haven't read the other architectures.

> > I think it would be better if you just defined some simple "library functions"
> > that can be called from the architecture specific code instead of adding
> > all this new high level code.
> >
> 
> What sort of library functions would you recommend? x86_64 uses 
> add_active_range() and free_area_init_nodes() from this patchset which 
> seemed fairly straight-forward.

e.g. a generic size_zones(). Possibly some others.

-Andi

