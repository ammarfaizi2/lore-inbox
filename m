Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUIEQtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUIEQtp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 12:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUIEQtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 12:49:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:12471 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262605AbUIEQth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 12:49:37 -0400
Date: Sun, 5 Sep 2004 09:49:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
In-Reply-To: <413AA7B2.4000907@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0409050911450.2331@ppc970.osdl.org>
References: <413AA7B2.4000907@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Sep 2004, Nick Piggin wrote:
> 
> So my solution? Just teach kswapd and the watermark code about higher
> order allocations in a fairly simple way. If pages_low is (say), 1024KB,
> we now also require 512KB of order-1 and above pages, 256K of order-2
> and up, 128K of order 3, etc. (perhaps we should stop at about order-3?)

I'm pretty sure we did something like this (where we not only required a
certain amount of memory free, but also a certain buddy availability) for
a short while in the 2.3.x timeframe or something like that, and that it
caused problems for some machines that just kept on trying to free memory.

I wrote a program at the time to check why, but I've long since lost it, 
so I re-created it just now (probably buggy as hell), and append it here 
for you to debug the dang thing.

In it's first rough draft (ie "it might be totally wrong") using this 
script:

	for i in 4 64 128 256 512 1024 2048 4096; do
		echo $i megabytes:
		./a.out $(($i*256)) pages
		echo
	done

I get

	4 megabytes:
	Got 2**1 buddy in 63 iterations (6%)
	Got 2**2 buddy in 199 iterations (19%)
	Got 2**3 buddy in 623 iterations (60%)

	64 megabytes:
	Got 2**1 buddy in 66 iterations (0%)
	Got 2**2 buddy in 1541 iterations (9%)
	Got 2**3 buddy in 4872 iterations (29%)

	128 megabytes:
	Got 2**1 buddy in 66 iterations (0%)
	Got 2**2 buddy in 2865 iterations (8%)
	Got 2**3 buddy in 7247 iterations (22%)

	256 megabytes:
	Got 2**1 buddy in 66 iterations (0%)
	Got 2**2 buddy in 5593 iterations (8%)
	Got 2**3 buddy in 13163 iterations (20%)

	512 megabytes:
	Got 2**1 buddy in 66 iterations (0%)
	Got 2**2 buddy in 10897 iterations (8%)
	Got 2**3 buddy in 30265 iterations (23%)

	1024 megabytes:
	Got 2**1 buddy in 1539 iterations (0%)
	Got 2**2 buddy in 20664 iterations (7%)
	Got 2**3 buddy in 67737 iterations (25%)

	2048 megabytes:
	Got 2**1 buddy in 1539 iterations (0%)
	Got 2**2 buddy in 32541 iterations (6%)
	Got 2**3 buddy in 122437 iterations (23%)

	4096 megabytes:
	Got 2**1 buddy in 1539 iterations (0%)
	Got 2**2 buddy in 38852 iterations (3%)
	Got 2**3 buddy in 220501 iterations (21%)

ie it shows how it's _really_ hard to get high-order buddies if you don't 
have a lot of memory.

Now, this test-result is not "real life", in that the whole point of the 
buddy allocator is that it is good at trying to keep higher orders free, 
and as such real life should behave much better. But this _is_ pretty 
accurate for the case where we totally ran out of memory and are trying
to randomly free one page here and one page there. That's where buddy 
doesn't much help us, so this kind of shows the worst case.

(Rule: you should not allow the machine to get to this point, exactly 
because at the < ~5% free point, buddy stops being very effective).

Notice how you may need to free 20% of memory to get a 2**3 allocation, if 
you have totally depleted your pages. And it's much worse if you have very 
little memory to begin with.

Anyway. I haven't debugged this program, so it may have serious bugs, and 
be off by an order of magnitude or two. Whatever. If I'm wrong, somebody 
can fix the program/script and see what the real numbers are.

		Linus

----
#include <stdlib.h>

#define MAX_NR_PAGES (1024*1024)

#define DECLARE_BITMAP(x,size) \
	unsigned int x[((size)+31)/32];


DECLARE_BITMAP(first, MAX_NR_PAGES);
DECLARE_BITMAP(second, MAX_NR_PAGES/2);
DECLARE_BITMAP(third, MAX_NR_PAGES/4);
DECLARE_BITMAP(fourth, MAX_NR_PAGES/8);

static int switch_bit(int nr, unsigned int *bitmap)
{
	unsigned int mask = 1U << (nr & 31);
	unsigned int *map = bitmap + (nr >> 5);
	unsigned int old = *map;

	*map = old ^ mask;
	return (old & mask) != 0;
}

static int set_bit(int nr, unsigned int *bitmap)
{
	unsigned int mask = 1U << (nr & 31);
	unsigned int *map = bitmap + (nr >> 5);
	unsigned int old = *map;

	*map = old | mask;
	return (old & mask) != 0;
}

static void fill_one(int nr, int max, int random)
{
	random >>= 1;
	if (switch_bit(random, second)) {
		static int hit = 0;

		if (!hit) {
			hit = 1;
			printf("Got 2**1 buddy in %d iterations (%d%%)\n", nr, nr*100/max);
		}
		random >>= 1;
		if (switch_bit(random, third)) {
			static int hit = 0;

			if (!hit) {
				hit = 1;
				printf("Got 2**2 buddy in %d iterations (%d%%)\n", nr, nr*100/max);
			}
			random >>= 1;
			if (switch_bit(random, fourth)) {
				printf("Got 2**3 buddy in %d iterations (%d%%)\n", nr, nr*100/max);
				exit(0);
			}
		}
	}
}

int main(int argc, char **argv)
{
	int i;
	int nrpages;

	if (argc < 2)
		return -1;
	nrpages = atoi(argv[1]);
	if (nrpages < 1 || nrpages > MAX_NR_PAGES)
		return -1;
	srandom(time(NULL));

	i = 0;
	do {
		unsigned r = random() % nrpages;
		if (set_bit(r, first))
			continue;
		i++;
		fill_one(i, nrpages, r);
	} while (i < nrpages * 3 / 4);
	printf("Filled 75% (%d)\n", i);
	return -1;
}
