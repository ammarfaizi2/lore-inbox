Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267068AbSL3VOv>; Mon, 30 Dec 2002 16:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267072AbSL3VOv>; Mon, 30 Dec 2002 16:14:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19723 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267068AbSL3VOt>; Mon, 30 Dec 2002 16:14:49 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Intel P6 vs P7 system call performance
Date: Mon, 30 Dec 2002 21:22:14 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <auqde6$1pv$1@penguin.transmeta.com>
References: <200212090830.gB98USW05593@flux.loup.net> <20021228203706.GD1258@niksula.cs.hut.fi> <20021229020510.GA22540@core.home> <20021230182209.GA3981@core.home>
X-Trace: palladium.transmeta.com 1041283377 15047 127.0.0.1 (30 Dec 2002 21:22:57 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 30 Dec 2002 21:22:57 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021230182209.GA3981@core.home>,
Christian Leber  <christian@leber.de> wrote:
>
>But now the right and interesting lines:
>
>2.5.53:
>igor3:~# ./a.out
>166.283549 cycles
>278.461609 cycles
>
>2.5.53-bk5:
>igor3:~# ./a.out
>150.895348 cycles
>279.441955 cycles
>
>The question is: are the numbers correct?

Roughly. The program I posted has some overflow errors (which you will
hit if testing expensive system calls that take >4000 cycles). They also

do an average, which is "mostly correct", but not stable if there is
some load in the machine. The right way to do timings like this is
probably to do minimums for individual calls, and then subtract out the
TSC reading overhead. See attached silly program.

>And why have int 80 also gotten faster?

Random luck. Sometimes you get cacheline alignment magic etc. Or just
because the timings aren't stable for other reasons (background
processes etc).

>Is this a valid testprogramm to find out how long a system call takes?

Not really. The results won't be stable, since you might have cache
misses, page faults, other processes, whatever.

So you'll get _somehat_ correct numbers, but they may be randomly off.

		Linus

---
#include <sys/types.h>
#include <time.h>
#include <sys/time.h>
#include <sys/fcntl.h>
#include <asm/unistd.h>
#include <sys/stat.h>
#include <stdio.h>

#define rdtsc() ({ unsigned long a, d; asm volatile("rdtsc":"=a" (a), "=d" (d)); a; })

// for testing _just_ system call overhead.
//#define __NR_syscall __NR_stat64
#define __NR_syscall __NR_getpid

#define NR (100000)

int main()
{
	int i, ret;
	unsigned long fast = ~0UL, slow = ~0UL, overhead = ~0UL;
	struct timeval x,y;
	char *filename = "test";
	struct stat st;
	int j;

	for (i = 0; i < NR; i++) {
		unsigned long cycles = rdtsc();
		asm volatile("");
		cycles = rdtsc() - cycles;
		if (cycles < overhead)
			overhead = cycles;
	}

	printf("overhead: %6d\n", overhead);

	for (j = 0; j < 10; j++)
	for (i = 0; i < NR; i++) {
		unsigned long cycles = rdtsc();
		asm volatile("call 0xffffe000"
			:"=a" (ret)
			:"0" (__NR_syscall),
			 "b" (filename),
			 "c" (&st));
		cycles = rdtsc() - cycles;
		if (cycles < fast)
			fast = cycles;
	}

	fast -= overhead;
	printf("sysenter: %6d cycles\n", fast);

	for (i = 0; i < NR; i++) {
		unsigned long cycles = rdtsc();
		asm volatile("int $0x80"
			:"=a" (ret)
			:"0" (__NR_syscall),
			 "b" (filename),
			 "c" (&st));
		cycles = rdtsc() - cycles;
		if (cycles < slow)
			slow = cycles;
	}

	slow -= overhead;
	printf("int0x80:  %6d cycles\n", slow);
	printf("          %6d cycles difference\n", slow-fast);
	printf("factor %f\n", (double) slow / fast);
}


