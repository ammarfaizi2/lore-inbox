Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318154AbSHPEqM>; Fri, 16 Aug 2002 00:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318155AbSHPEqM>; Fri, 16 Aug 2002 00:46:12 -0400
Received: from holomorphy.com ([66.224.33.161]:41405 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318154AbSHPEqM>;
	Fri, 16 Aug 2002 00:46:12 -0400
Date: Thu, 15 Aug 2002 21:47:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020816044756.GR29459@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Benjamin LaHaise <bcrl@redhat.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org
References: <Pine.LNX.4.44.0208152041120.1271-100000@home.transmeta.com> <Pine.LNX.4.44.0208152045330.1271-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208152045330.1271-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 08:50:58PM -0700, Linus Torvalds wrote:
> Actually, the simplest schenario is to just make an arbitrary cut-off at
> 8G or 16G of RAM, and make anything above it default to the hugetlb zone,
> and make that use a separate hugetlb map which does refcounts at 2MB
> granularity). And create fake "struct page" entries for those things that
> have to have it, along with a separate kmap area that holds a few of the 
> big mappings.
> There's an almost complete overlap between people who want hugetlb and 
> 64GB x86 machines anyway, so I doubt you'd find people to complain.
> And the advantage of the hugetlb stuff is exactly the fact that the normal 
> VM doesn't need to worry about it. It's nonswappable, and doesn't get IO 
> done into it through any of the normal paths.
> Minimal impact.

Ew! 64GB doesn't need or want any of that. It just needs bugfixes more
badly than most machines & page clustering to keep mem_map down to a
decent size IIRC. The "highmem ratio" is irrelevant, it's just
implementing page clustering and bugfixing. The core kernel doesn't
need to know the page size is fake, and needs the rest of the bugfixes
for e.g. buffer_heads proliferating out of control anyway. No magic.
No uglies.

32GB has already been booted & verified to run Linux. The only badness
is sizeof(mem_map) and the usual contingent of "buffer_heads are out of
control and shrink_cache() can't figure out when to shoot down a slab"
issues. And, well, performance issues show up now and then but those
improvements propagate back to the smaller machines, albeit in smaller
proportions.

This notion of cutting highmem boxen off at 16GB really does not sound
hot at all. At the very least webserving goes on at 32+GB and that has
no use whatsoever for the hugetlb stuff. Still other workloads, e.g.
client front ends for databases, are in similar positions. People are
actually trying to get things done that need more than 32GB pagecache
on i386 machines.

The big reason the database people are interested in hugetlb stuff is
to work around the pagetable proliferation bugs. They got a backdoor
to take over the VM, so they're even happier than they would be with
a bugfix. But they're not the only workloads around, and the bugfix is
still needed for all 64-bit and more general 32-bit workloads (it was
not fixed by pte-highmem).


Cheers,
Bill
