Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269878AbRHSCgi>; Sat, 18 Aug 2001 22:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269891AbRHSCg2>; Sat, 18 Aug 2001 22:36:28 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:62570 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269878AbRHSCgW>; Sat, 18 Aug 2001 22:36:22 -0400
Date: Sun, 19 Aug 2001 04:36:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: first benchmark results of mmap-rb-4 [Re: 2.4.9aa2 and please test mmap-rb-4]
Message-ID: <20010819043647.B1719@athlon.random>
In-Reply-To: <20010818060615.A1719@athlon.random> <20010819022500.O1719@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010819022500.O1719@athlon.random>; from andrea@suse.de on Sun, Aug 19, 2001 at 02:25:01AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2001 at 02:25:01AM +0200, Andrea Arcangeli wrote:
> I benchmarked it a little bit here.

one more benchmark. This one is intended to benchmark the improvement
of the better rebuild of the tree during fork (not just because of the
faster rbtree balancing but also because of avoiding all such stupid
tree lookups that the old code in 2.4.9 was used to do, the new code
does zero lookup on the tree during the rebuild).

This is the testcase I wrote for it (really only the fork() syscall gets
benchmarked):

rebuild-tree.c:

----------------------------------------------------------------
#include <sys/mman.h>
#include <asm/msr.h>

#define NR_MAPS 55000

main()
{
	void * p[NR_MAPS];
	int i;
	char * addr = (char *) 0x50000000;
	unsigned long long start, stop;
	int pid;

	for (i = 0; i < NR_MAPS; i++) {
#if 0
		p[i] = mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE, -1, 0);
#else
		p[i] = mmap(addr, 4096, PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE|MAP_FIXED, -1, 0);
#if 0
		addr += 4096;
#else
		addr += 8192;
#endif
#endif
		if ((unsigned long) p[i] == (unsigned long) -1)
			perror("mmap"), exit(1);
#if 0
		printf("%p\n", p[i]);
#endif
	}
	
#if 0
	pause();
#endif

	rdtscll(start);
	pid = fork();
	rdtscll(stop);
	if (!pid) {
		pause();
		return;
	}

	printf("fork latency due tree rebuild %Lu cpu cycles\n", stop-start);
	kill(pid, 15);
}
----------------------------------------------------------------

Here the results:

without mmap-rb-4 patch:

andrea@laser:/misc/andrea-athlon/vma-merging > for i in 1 2 3 4 5 6 7 8 9 10; do ./rebuild-tree ;done
fork latency due tree rebuild 48842213 cpu cycles
fork latency due tree rebuild 48069185 cpu cycles
fork latency due tree rebuild 47687032 cpu cycles
fork latency due tree rebuild 47568124 cpu cycles
fork latency due tree rebuild 47363311 cpu cycles
fork latency due tree rebuild 47446545 cpu cycles
fork latency due tree rebuild 47446201 cpu cycles
fork latency due tree rebuild 47485410 cpu cycles
fork latency due tree rebuild 47474240 cpu cycles
fork latency due tree rebuild 47472238 cpu cycles
andrea@laser:/misc/andrea-athlon/vma-merging > 

with mmap-rb-4 patch:

andrea@laser:/misc/andrea-athlon/vma-merging > for i in 1 2 3 4 5 6 7 8 9 10; do ./rebuild-tree ;done
fork latency due tree rebuild 43566796 cpu cycles
fork latency due tree rebuild 43808195 cpu cycles
fork latency due tree rebuild 43877997 cpu cycles
fork latency due tree rebuild 43971400 cpu cycles
fork latency due tree rebuild 43959884 cpu cycles
fork latency due tree rebuild 43584169 cpu cycles
fork latency due tree rebuild 43521534 cpu cycles
fork latency due tree rebuild 42923027 cpu cycles
fork latency due tree rebuild 43092195 cpu cycles
fork latency due tree rebuild 43110561 cpu cycles
andrea@laser:/misc/andrea-athlon/vma-merging > 

So it's a +8%.

Andrea
