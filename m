Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262197AbTCWA44>; Sat, 22 Mar 2003 19:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262199AbTCWA44>; Sat, 22 Mar 2003 19:56:56 -0500
Received: from franka.aracnet.com ([216.99.193.44]:49553 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262197AbTCWA4y>; Sat, 22 Mar 2003 19:56:54 -0500
Date: Sat, 22 Mar 2003 17:07:47 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@digeo.com>, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm2 vs 2.5.65-mm3 (full objrmap)
Message-ID: <370130000.1048381666@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0303222309050.1617-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303222309050.1617-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Did you keep the pte_direct
>> optimisation? That seems worth keeping, with partial objrmap as well
>> (I think that was removed in Dave's patch, but would presumably be easy
>> to put back).
> 
> Dave didn't remove it at all, just went another way so that it became
> irrelevant to obj rmaps (or you could say, every obj rmap direct,
> apart from the sys_remap_file pages).  I did the same with anonymous,
> they're almost all direct (since a given anon page is almost always
> mapped at the same user virtual address in whatever mms it appears),
> the exception needing chains coming from a perverse use of mremap.

OK, so you're saying we can still use the direct map for singletons
that are filebacked? I thought that dissappeared for some reason ...
don't recall what. I just thought it'd save some time on the lookup
side of the equation .. but I'm not sure our testing is doing any
lookup ;-)

> The clearest advantage of anobjrmap so far is for your HIGHMEM64G
> HIGHPTE configurations: which had a 64-bit direct pte_addr_t in
> struct page, now just a 32-bit count like in the non-PAE configs.
> (Though that saving could have been achieved in other ways.)

Ah, I don't run highpte, too much performance impact from kmap, even
once they were made atomic instead of persistant. Were you using highpte 
in your tests? shpte seems to work much better in terms of performance,
and control the high-use cases for ptes ... I think the UKVA based
version with each process permanently mapping its own pagetables will
perform much better.

>> Or maybe we just need some more tuning ;-)
> 
> Be nice if a magic wand would make it go faster, but it seems too
> simple for tuning.  A lot of effort went into speeding up pte_chains,
> looks like the effort paid off. 

Well, I think the real key is that we're hardly using pte_chains any
more with the partial objrmap code ... they're mostly direct mapped
singletons anyway, so you're not saving much. I had a crude /proc 
thingy to draw histograms of chain length somewhere that I did my 
initial analysis on, I'll try to dig it out.

Did you measure either partial objrmap or anon-objrmap under memory
pressure? 

> (It's particularly helpful that the
> chains got collapsed back to direct lazily, by page_referenced, not
> by page_remove_rmap - that means a repetitively forking process
> was not perpetually convulsed in allocating and freeing chains).

mmm ... can you explain that one a bit more? I think I missed that
bit, and maybe it explains why we don't see too much impact from
the fork/exec stuff for anon pages.

Thanks,

M.

