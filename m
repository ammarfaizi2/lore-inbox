Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314486AbSECP5s>; Fri, 3 May 2002 11:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSECP5r>; Fri, 3 May 2002 11:57:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:38162 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314486AbSECP5q>; Fri, 3 May 2002 11:57:46 -0400
Date: Fri, 3 May 2002 17:58:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Virtual address space exhaustion (was  Discontigmem virt_to_page() )
Message-ID: <20020503175819.A14505@dualathlon.random>
In-Reply-To: <20020503103813.K11414@dualathlon.random> <4055279713.1020413842@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 08:17:23AM -0700, Martin J. Bligh wrote:
> We don't have to tlb flush every time we map something in, only when
> we delete it. For the sake of illustration, imagine a huge kmap pool
> for each task, we just map things in as we need them (say some pagecache

yes, the pool will "cache" the mem_map virtual window for a while, but
the complexity of the pool management isn't trivial, in the page
structure you won't find the associated per-task cached virtual address,
you will need something like a lookup on a data structure associated
with the task struct to find if you just have it in cache or not in the
per-process userspace kmap pool. The current kmap pool is an order of
magnitude simpler thanks to page->virtual but you cannot have a
page->virtual[nr_tasks] array.

Another interesting problem is that 'struct page *' will be as best a
cookie, not a valid pointer anymore, not sure what's the best way to
handle that. Working with pfn would be cleaner rather than working with
a cookie (somebody could dereference the cookie by mistake thinking it's
a page structure old style), but if __alloc_pages returns a pfn a whole
lot of kernel code will break.

> older 32 bit machines in the field for a few years yet to come, and
> we have to cope with them as best we can.

Sure.

> Though that'd reduce the size of some of the structures, I'd still
> have other concerns (such as tlb size, which is something stupid
> like 4 pages, IIRC), and the space wastage you mentioned. Page 

it has 8 pages for data and 2 for instructions, that's 16M data and 4M
of instructions with PAE.  4k pages can be cached with at most 64 slots
for data and 32 entries for instructions, that means 256K of data and
128k of instructions. The main disavantage is that we basically would
waste the 4k tlb slots, and we'd share the same slots with the kernel.
It mostly depend on the workload but in theory the 8 pages for data
could reduce the pte walking (also not to mention a layer less of pte
would make the pte walking faster too). So I think 2M pages could
speedup some application, but the main advantage remains that you
wouldn't need to change the page structure handling.

Andrea
