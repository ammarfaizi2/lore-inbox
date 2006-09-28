Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWI1XDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWI1XDW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWI1XDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:03:22 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:31932 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750754AbWI1XDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:03:21 -0400
Date: Fri, 29 Sep 2006 01:03:16 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: oom kill oddness.
In-Reply-To: <20060927205435.GF1319@redhat.com>
Message-ID: <Pine.LNX.4.64.0609290035060.6762@scrub.home>
References: <20060927205435.GF1319@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 27 Sep 2006, Dave Jones wrote:

> So I have two boxes that are very similar.
> Both have 2GB of RAM & 1GB of swap space.
> One has a 2.8GHz CPU, the other a 2.93GHz CPU, both dualcore.
> 
> The slower box survives a 'make -j bzImage' of a 2.6.18 kernel tree
> without incident. (Although it takes ~4 minutes longer than a -j2)
> 
> The faster box goes absolutely nuts, oomkilling everything in sight,
> until eventually after about 10 minutes, the box locks up dead,
> and won't even respond to pings.
> 
> Oh, the only other difference - the slower box has 1 disk, whereas the
> faster box has two in RAID0.   I'm not surprised that stuff is getting
> oom-killed given the pathological scenario, but the fact that the
> box never recovered at all is a little odd.  Does md lack some means
> of dealing with low memory scenarios ?

I think I see the same thing on the other end on slow machines, here it 
only takes a single compile job, which doesn't quite fit into memory and 
another task (like top) which occasionally wakes up and tries to allocate 
memory and then kills the compile job - that's very annoying.

AFAICT the basic problem is that "did_some_progress" in __alloc_pages() is 
rather local information, other processes can still make progress and keep 
this process from making progress, which gets grumpy and starts killing. 
What's happing here is that most memory is either mapped or in the swap 
cache, so we have a race between processes trying to free memory from the 
cache and processes mapping memory back into their address space.

If someone wants to play with the problem, the example program below 
triggers the problem relatively easily (booting with only little ram 
helps), it starts a number of readers, which should touch a bit more 
memory than is available and a few writers, which occasionally allocate 
memory.

bye, Roman


#include <stdlib.h>
#include <string.h>
#include <time.h>

#define MEM_SIZE (24 << 20)

int main(int ac, char **av)
{
	volatile char *mem;
	int i, memsize;

	memsize = MEM_SIZE;
	if (ac > 1)
		memsize = atoi(av[1]) << 20;
	mem = malloc(memsize);

	memset(mem, 0, memsize);
	for (i = 0; i < 32; i++) {
		if (!fork()) {
			while (1) {
				*(mem + random() % memsize);
			}
		}
	}
	for (i = 0; i < 5; i++) {
		if (!fork()) {
			while (1) {
				volatile char *p;
				struct timespec ts;
				int t = random() % 5000;
				ts.tv_sec = t / 1000;
				ts.tv_nsec = (t % 1000) * 1000000;
				nanosleep(&ts, NULL);
				p = malloc(1 << 16);
				memset(p, 0, 1 << 16);
				free(p);
			}
		}
	}
	while (1)
		pause();
}
