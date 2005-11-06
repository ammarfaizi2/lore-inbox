Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVKFQMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVKFQMj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 11:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVKFQMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 11:12:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62679 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932109AbVKFQMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 11:12:38 -0500
Date: Sun, 6 Nov 2005 08:12:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Ingo Molnar <mingo@elte.hu>, Paul Jackson <pj@sgi.com>,
       andy@thermo.lanl.gov, mbligh@mbligh.org, akpm@osdl.org,
       arjan@infradead.org, arjanv@infradead.org, haveblue@us.ibm.com,
       kravetz@us.ibm.com, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <796B585C-CB1C-4EBA-9EF4-C11996BC9C8B@mac.com>
Message-ID: <Pine.LNX.4.64.0511060756010.3316@g5.osdl.org>
References: <20051104010021.4180A184531@thermo.lanl.gov>
 <Pine.LNX.4.64.0511032105110.27915@g5.osdl.org> <20051103221037.33ae0f53.pj@sgi.com>
 <20051104063820.GA19505@elte.hu> <Pine.LNX.4.64.0511040725090.27915@g5.osdl.org>
 <796B585C-CB1C-4EBA-9EF4-C11996BC9C8B@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Nov 2005, Kyle Moffett wrote:
> 
> Hmm, this brings up something that I haven't seen discussed on this list
> (maybe a long time ago, but perhaps it should be brought up again?).  What are
> the pros/cons to having a non-physically-linear kernel virtual memory space?

Well, we _do_ actually have that, and we use it quite a bit. Both 
vmalloc() and HIGHMEM work that way.

The biggest problem with vmalloc() is that the virtual space is often as 
constrained as the physical one (ie on old x86-32, the virtual address 
space is the bigger problem - you may have 36 bits of physical memory, but 
the kernel has only 30 bits of virtual). But it's quite commonly used for 
stuff that wants big linear areas.

The HIGHMEM approach works fine, but the overhead of essentially doing a 
software TLB is quite high, and if we never ever have to do it again on 
any architecture, I suspect everybody will be pretty happy.

> Would it be theoretically possible to allow some kind of dynamic kernel page
> swapping, such that the _same_ kernel-virtual pointer goes to a different
> physical memory page?  That would definitely satisfy the memory hotplug
> people, but I don't know what the tradeoffs would be for normal boxen.

Any virtualization will try to do that, but they _all_ prefer huge pages 
if they care at all about performance.

If you thought the database people wanted big pages, the kernel is worse. 
Unlike databases or HPC, the kernel actually wants to use the physical 
page address quite often, notably for IO (but also for just mapping them 
into some other virtual address - the users).

And no standard hardware allows you to do that in hw, so we'd end up doing 
a software page table walk for it (or, more likely, we'd have to make 
"struct page" bigger).

You could do it today, although at a pretty high cost. And you'd have to 
forget about supporting any hardware that really wants contiguous memory 
for DMA (sound cards etc). It just isn't worth it.

Real memory hotplug needs hardware support anyway (if only buffering the 
memory at least electrically). At which point you're much better off 
supporting some remapping in the buffering too, I'm convinced. There's no 
_need_ to do these things in software.

			Linus
