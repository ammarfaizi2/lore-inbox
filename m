Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266088AbUKBDwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266088AbUKBDwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 22:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S379619AbUKAW4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:56:01 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:43416 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S272981AbUKAVXm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:23:42 -0500
Date: Mon, 1 Nov 2004 13:23:42 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: linux-os@analogic.com
cc: Linus Torvalds <torvalds@osdl.org>, Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.61.0411011542430.24533@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0411011311520.8483@twinlark.arctic.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de>
 <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
 <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410291424180.4870@chaos.analogic.com>
 <Pine.LNX.4.58.0410291209170.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410312024150.19538@chaos.analogic.com>
 <Pine.LNX.4.61.0411011219200.8483@twinlark.arctic.org>
 <Pine.LNX.4.61.0411011542430.24533@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004, linux-os wrote:

> On Mon, 1 Nov 2004, dean gaudet wrote:
> 
> > On Sun, 31 Oct 2004, linux-os wrote:
> > 
> > > Timer overhead = 88 CPU clocks
> > > push 3, pop 3 = 12 CPU clocks
> > > push 3, pop 2 = 12 CPU clocks
> > > push 3, pop 1 = 12 CPU clocks
> > > push 3, pop none using ADD = 8 CPU clocks
> > > push 3, pop none using LEA = 8 CPU clocks
> > > push 3, pop into same register = 12 CPU clocks
> > 
> > your microbenchmark makes assumptions about rdtsc which haven't been valid
> > since the days of the 486.  rdtsc has serializing aspects and overhead that
> > you can't just eliminate by running it in a tight loop and subtracting out
> > that "overhead".
> > 
> 
> Wrong.

if you were correct then i should be able to measure 1 cycle differences
in sequences such as the following:

	rdtsc
	mov %eax,%edi
	shr $1,%ecx
	rdtsc

	rdtsc
	mov %eax,%edi
	shr $1,%ecx
	shr $1,%ecx
	rdtsc
...
	rdtsc
	mov %eax,%edi
	shr $1,%ecx
	shr $1,%ecx
	shr $1,%ecx
	shr $1,%ecx
	shr $1,%ecx
	shr $1,%ecx
	shr $1,%ecx
	shr $1,%ecx
	rdtsc

yet the attached program demonstrates that such measurements are
inaccurate.  the results should be a sequence of numbers increasing
by 1 each time.

p4 model 2:	80 80 84 84 84 84 84 84
p4 model 3:	120 120 120 120 120 120 120 128
p-m model 9:	47 46 47 48 49 50 56 57
k8:		5 5 5 5 5 5 5 5

-dean

% gcc -O -o rdtsc-rounding rdtsc-rounding.c

rdtsc-rounding.c:

#include <stdio.h>
#include <stdint.h>

#define template(n) \
	static uint32_t foo##n(void) \
	{ \
		uint32_t start, done, trash1, trash2; \
 \
		__asm volatile( \
			"\n	rdtsc" \
			"\n	mov %%eax,%0" \
			x##n("\n	shr $1,%1") \
			"\n	rdtsc" \
			: "=&r" (start), "=&r" (trash1), "=&a" (done), "=&d" (trash2) \
		); \
		return done - start; \
	}

#define x1(x) x
#define x2(x) x x
#define x3(x) x x x
#define x4(x) x2(x) x2(x)
#define x5(x) x4(x) x
#define x6(x) x3(x2(x))
#define x7(x) x6(x) x
#define x8(x) x4(x2(x))

template(1)
template(2)
template(3)
template(4)
template(5)
template(6)
template(7)
template(8)

static uint32_t (*fn[9])(void) = {
	0, foo1, foo2, foo3, foo4, foo5, foo6, foo7, foo8
};


static uint32_t bench(uint32_t (*f)(void))
{
	uint32_t best;
	unsigned i;

	best = ~0;
	for (i = 0; i < 100000; ++i) {
		uint32_t cur = f();
		if (cur < best) {
			best = cur;
		}
	}
	return best;
}


int main(int argc, char **argv)
{
	unsigned i;

	for (i = 1; i < sizeof(fn)/sizeof(fn[0]); ++i) {
		printf("%u ", bench(fn[i]));
	}
	printf("\n");
	return 0;
}
