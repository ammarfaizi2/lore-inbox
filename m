Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279968AbRKFSnJ>; Tue, 6 Nov 2001 13:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279943AbRKFSmu>; Tue, 6 Nov 2001 13:42:50 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:55468 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279968AbRKFSmf>; Tue, 6 Nov 2001 13:42:35 -0500
Date: Tue, 6 Nov 2001 13:42:34 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using %cr2 to reference "current"
Message-ID: <20011106134234.A27718@redhat.com>
In-Reply-To: <20011106121313.B16245@redhat.com> <Pine.LNX.4.33.0111060918380.2194-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111060918380.2194-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Nov 06, 2001 at 09:49:15AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2001 at 09:49:15AM -0800, Linus Torvalds wrote:
> That said, how expensive is loading %cr2 anyway? We can do all the same
> tricks with a 16kB stack and just playing games with using the higher bits
> as the "offset", ie things like

Here are some numbers:

read cr2 best: 11  av: 11.12
write cr2 cr2 best: 61  av: 64.42
read cr2 best: 11  av: 11.12
write cr2 cr2 best: 61  av: 65.01
read stk best: 10  av: 11.03
write cr2 stk best: 61  av: 64.95
read stk best: 10  av: 11.03
write cr2 stk best: 61  av: 65.23

Which come from insmod of the below two modules.  I didn't test writing to 
the stack register, but I expect it's similarly expensive as it affects the 
call return stack and other behind the scenes dependancies.  Suffice it to 
say that reading %cr2 is essentially free on my box (athlon mp).  Maybe 
we should use it as a pointer into a per-cpu area to avoid writing it?

		-ben

----teststk_k.c----
#define USE_STK 1
#include "testcr2_k.c"
----testcr2_k.c----
#include <linux/module.h>
#include <linux/kernel.h>
#include <asm/errno.h>
#include <linux/init.h>

static inline long long rdtsc(void)
{
        unsigned int low,high;
        __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high));
        return low + (((long long)high)<<32);
}

long dummy;

long doit(void)
{
	long long start, end;
	long val;

	start = rdtsc();
#ifdef USE_STK
#define WHICH	"stk"
	__asm__ __volatile__(
                "movl $0x0003c000,%%eax  \n" // 4 bits at bit 14
                "movl $-16384,%%edx      \n" // remove low 14 bits
                "andl %%esp,%%eax		\n"
                "andl %%esp,%%edx		\n"
                "shrl $7,%%eax           \n" // color it by 128 bytes
                "addl %%edx,%%eax		\n"
		: "=a" (val) :: "edx");
#else
#define WHICH "cr2"
        __asm__ __volatile__("movl %%cr2,%0" : "=r" (val));
#endif
	val += 100;
	dummy = val;
	end = rdtsc();

	return end - start;
}

long doit2(void)
{
	long long start, end;
	long val;

	start = rdtsc();
	val = dummy;
        __asm__ __volatile__("movl %0,%%cr2" : "=r" (val));
	end = rdtsc();

	return end - start;
}

int test_init (void)
{
	long min = 1000000000, av = 0;
	int i;
	for (i=0; i<100; i++) {
		long dur = doit();
		if (dur < min)
			min = dur;
		av += dur;
	}
	printk("read " WHICH " best: %ld  av: %ld.%02ld\n", min, av / 100, av % 100);

	min = 10000000;
	av = 0;
	for (i=0; i<100; i++) {
		long dur = doit2();
		if (dur < min)
			min = dur;
		av += dur;
	}
	printk("write cr2 " WHICH " best: %ld  av: %ld.%02ld\n", min, av / 100, av % 100);
	return -ENODEV;
}

void test_exit(void)
{
	return;
}

module_init(test_init);
module_exit(test_exit);
MODULE_LICENSE("GPL");
---snip---
