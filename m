Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbUJ3OLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbUJ3OLQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 10:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbUJ3OLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:11:16 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:17048 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261174AbUJ3OLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:11:10 -0400
Date: Sat, 30 Oct 2004 16:10:59 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: PG_zero
Message-ID: <20041030141059.GA16861@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This experiment is incremental with lowmem_reserve-3 (downloadble in the
same place), and it's against 2.6.9, it rejects against kernel CVS but
it should be easy to fixup.

	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9/PG_zero-2

I think it's much better to have PG_zero in the main page allocator than
to put the ptes in the slab. This way we can share available zero pages with
all zero-page users and we have a central place where people can
generate zero pages and allocate them later efficiently.

This gives a whole internal knowledge to the whole buddy system and
per-cpu subsystem of zero pages.

I also refile zeropages from the hot-cold quicklist to the zero
quicklist, clearing them if needed, with the idle task.

this microbenchmark runs 3 times faster with the patch applied.

#include <stdlib.h>
#include <strings.h>
#include <stdio.h>
#include <asm/msr.h>

#define SIZE (1024*1024*4)

int main(void)
{
	unsigned long before, after;
	unsigned long * p = malloc(SIZE), * end = p + (SIZE / sizeof(long));

	rdtscl(before);
	while (p < end) {
		*p = 0;
		p += 4096;
	}
	rdtscl(after);

	printf("time %lu\n", after-before);

	return 0;
}

Some fix included in the patch is to fallback in the quicklist for the
whole classzone before eating from the buddy, otherwise 1G boxes are
very penalized in terms of entering the buddy system too early, and not
using the quicklists of the lower zones (2.4-aa wasn't penalized). Plus
this adds a sysctl so the thing is tunable at runtime. And there was no
need of using two quicklists for cold and hot pages, less resources are
wasted by just using the lru ordering to diferentiate from hot/cold
allocations and hot/cold freeing.

The API with PG_zero is that if you set __GFP_ZERO in the gfp_mask, then
you must check PG_zero. If PG_zero is set, then you don't need to clear
the page. However you must clear PG_zero before freeing the page if its
contents are not zero anymore by the time you free it, or future users
of __GFP_ZERO will be screwed. So the pagetables for example never clear
PG_zero for the whole duration of the page, infact they set PG_zero if
they're forced to execute clear_page. shmem as well in a fail path if it
fails getting an entry it will free the zero page again and it won't
have to touch PG_zero since it didn't modify the page contents.

The zero pages tries to go into the zero quicklist, if the zero
quicklist is full they go into the hot-cold but they retain the PG_zero
information. If even that is full it fallbacks into the buddy with the
"batch" pass and even the buddy system retains the PG_zero info which is
zero cost to retain and it may be still useful later. For __GFP_ZERO
allocations I only look if something is available in the zero quicklist,
I don't search for zero pages in the other lists. The idle task as well
is 100% scalable, since it only tries to refile pages from the hot-cold
list to the zero quicklist, but only if the zero quicklist isn't full
yet and if the hot-cold list isn't empty (so normally the idle task does
nothing and it doesn't even cli ever). It's only the idle task capable
of refiling the stuff and potentially taking advantage of the PG_zero
info in the pages that are outside the zero quicklist. the idle clearing
can be disabled via sysctl, then the overhead will be just 1 cacheline
for the sysctl in the idle task.

__GFP_ONLY_ZERO can be used in combination of __GFP_ZERO,
__GFP_ONLY_ZERO will not fallback into the hot-cold quicklist and it
won't fallback in the buddy, it will be atomic as well. This is only
used by the wp fault that detects if the ZERO_PAGE was istantiated in
the pte and it avoids the copy-page in such case (if we can find a
zeropage during wp fault we don't even drop locks and remap the
high-pte).

Not sure if this experiment will turn out to be worthwhile or just an
useless complication (I can't get measure difference with any real life
program), but since it works and it's stable and the above
microbenchmark got a 200% boost (the writeprotect fault after zeropage I
exect will get a 200% boost too), it seems worth posting. The idle
zeroing is the most suspect thing, since it has a chance to hurt caches,
but it's only refilling the quicklist with total scalability. I would
never attempt to do a idle-zeroing in the buddy (I think I was negative
about patches trying to do that), that could never work well with the
spinlock bouncing and there's way too much free memory for each cpu that
would really keep freeing ram too frequently throwing away a lot more
cache. One more detail, I clear at most 1 page for each "halt" wakeup.
Not sure amount monitor/mwait, mainline doesn't support it anyways, I
don't rememebr by memory if mwait gets a wakeup after an irq handler,
but anyways that bit is fixable. I believe this is the best design to
handle zero page caching with idle zeroing on top of it. One can always
increase the size of the per-cpu queues via sysctl if more zero pages
are needed.

shmem allocations as well should get a nice boost in any micro
benchmark, since they're now using the native PG_zero too.

Obvious improvements would be to implement a long_write_zero(ptr)
operation that doesn't pollute the cache. IIRC it exists on the alpha, I
assume it exists on x86/x86-64 too. But that's incremental on top of
this.

It seems stable, I'm running it while writing this.

I guess testing on a memory bound architecture would be more interesting
(more cpus will make it more memory bound somewhat).

Comments welcome.
