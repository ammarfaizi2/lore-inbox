Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbUCTOk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 09:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263425AbUCTOk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 09:40:26 -0500
Received: from holomorphy.com ([207.189.100.168]:23944 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263424AbUCTOkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 09:40:25 -0500
Date: Sat, 20 Mar 2004 06:40:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320144022.GC2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040320133025.GH9009@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320133025.GH9009@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 02:30:25PM +0100, Andrea Arcangeli wrote:
> Anyways returning to the non-ram returned by ->nopage see the below
> email exchange with Jens. the bug triggering of course is the
> BUG_ON(!pfn_valid(page_to_pfn(new_page))).
> If we want to return non-ram, we could, but I believe we should change
> the API to return a pfn not a page_t * if we want to.

This would be very helpful for other reasons also. There's a general
API issue with drivers that want or need to do this. The one I've
heard most about is /dev/mem when it's used to mmap() physical areas
lying in memory holes not covered by ->node_mem_map. Once ->mmap() and
->nopage() supplied by drivers are liberated from reliance on struct
page, numerous hacks, validation overheads, and stability issues may be
eliminated. I'd rather strongly advocate such an API change for mainline,
as it's something that fixes a number of drivers at once, but only if
the implementation carries out a full sweep of all affected callees
and only if it actually resolves the issues with these drivers.

But there's another question that should be asked up-front: in order to
give drivers sufficient expressiveness to correctly implement their
->mmap() methods, is this even sufficient? There is a serious question
of whether the core can actually handle the driver-specific issues,
which suggests devolving a larger swath of the fault handling codepath
to drivers supporting ->mmap() if it is insufficient after all. For
instance, will cache-disabled mappings or bolted/locked TLB entries
that the core doesn't understand be required? I'd like to get someone
with more driver experience or who may have architecture-specific
issues with driver ->nopage() methods to chime in here with respect to
the sufficiency of a pfn-based ->nopage() vs. stronger methods, since
it's pointless to make the pfn-based ->nopage() change if it's
insufficient anyway.

There is also a special case that's hitting a number of architectures
simultaneously that may or may not be a mainline concern. This is that
a number of people actually want to handle faults on hugetlb and do
ZFOD fault handling so that, for instance, various kinds of NUMA and
latency issues can be addressed. The current methods are to trap the
fault before calling handle_mm_fault() in arch code, but a cleaner
solution would very nicely reuse more general or stronger forms of
driver fault handling that would fix driver issues also. It's basically
an upstream call as to whether this will be allowed to have any
influence on the design of a solution to the more critical "drivers are
getting bitten by the requirement of a struct page * return value of
->nopage()" issue, and it looks like upstream is cc:'d on this thread. =)


-- wli
