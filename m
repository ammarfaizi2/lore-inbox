Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbWILIbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbWILIbX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWILIbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:31:23 -0400
Received: from gw.goop.org ([64.81.55.164]:19348 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965054AbWILIbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:31:22 -0400
Message-ID: <45067056.70201@goop.org>
Date: Tue, 12 Sep 2006 01:31:18 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: akpm@osdl.org, ak@suse.de, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: i386 PDA patches use of %gs
References: <1158046540.2992.5.camel@laptopd505.fenrus.org>	 <4506665D.2090001@goop.org> <1158047806.2992.7.camel@laptopd505.fenrus.org>
In-Reply-To: <1158047806.2992.7.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> gcc can be fixed if needed. I don't see the kernel switching to use that
> any time soon though...

I have a preliminary patch to implement per_cpu() in terms of __thread.

Hm, my initial tests comparing reloading a NULL selector vs a real 
selector shows absolutely no measurable difference, on either a modern 
Core Duo, or an old P4...  Admittedly this is with an artificial 
usermode test program, but I'd expect to see *some* difference if 
there's a difference.

    J


--

/* gcc -o time-segops time-segops.c -O2 -Wall -lrt -fomit-frame-pointer -funroll-loops */
#include <stdio.h>
#include <time.h>

#define COUNT 10000000

static inline void sync(void)
{
	int a,b,c,d;

	asm volatile("cpuid"
		     : "=a" (a), "=b" (b), "=c" (c), "=d" (d)
		     : "0" (0), "2" (0)
		     : "memory");
}

static void test_none(void)
{
	int i;

	for(i = 0; i < COUNT; i++) {
		sync();
	}
}

static void test_fs(void)
{
	int i, ds;
	asm volatile("mov %%ds,%0" : "=r" (ds));

	for(i = 0; i < COUNT; i++) {
		asm volatile("push %%fs; mov %0, %%fs; popl %%fs"
			     : : "r" (ds));
		sync();
	}
}

static void test_gs(void)
{
	int i, ds;
	asm volatile("mov %%ds,%0" : "=r" (ds));

	for(i = 0; i < COUNT; i++) {
		asm volatile("push %%gs; mov %0, %%gs; popl %%gs"
			     : : "r" (ds));
		sync();
	}
}

typedef void (*test_t)(void);

static test_t tests[] = {
	test_none,
	test_fs,
	test_gs,
	NULL,
};

int main()
{
	int i;
	int ds, fs, gs;

	asm volatile("mov %%ds, %0; "
		     "mov %%fs, %1; "
		     "mov %%gs, %2"
		     : "=r" (ds), "=r" (fs), "=r" (gs) : : "memory");

	printf("fs=%x gs=%x\n", fs, gs);
	for(i = 0; tests[i]; i++) {
		struct timespec start, end;
		unsigned long long delta;

		clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
		(*tests[i])();
		clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);

		delta = (end.tv_sec * 1000000000ull + end.tv_nsec) - 
			(start.tv_sec * 1000000000ull + start.tv_nsec);
		delta /= COUNT;

		printf("%lluns/iteration\n", delta);
	}

	return 0;
}

