Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946048AbWGOOJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946048AbWGOOJA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 10:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946049AbWGOOJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 10:09:00 -0400
Received: from [212.76.81.5] ([212.76.81.5]:64007 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1946050AbWGOOI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 10:08:59 -0400
From: Al Boldi <a1426z@gawab.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality permits it
Date: Sat, 15 Jul 2006 17:09:45 +0300
User-Agent: KMail/1.5
Cc: Frank van Maarseveen <frankvm@frankvm.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
References: <200607112257.22069.a1426z@gawab.com> <200607151429.32298.a1426z@gawab.com> <1152966159.3114.19.camel@laptopd505.fenrus.org>
In-Reply-To: <1152966159.3114.19.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607151709.45870.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, 2006-07-15 at 14:29 +0300, Al Boldi wrote:
> > Arjan van de Ven wrote:
> > > > BTW, why does randomize_stack_top() mod against (8192*1024) instead
> > > > of (8192) like arch_align_stack()?
> > >
> > >  because it wants to randomize for 8Mb, unlike arch_align_stack which
> > > wants to randomize the last 8Kb within this 8Mb ;)
> >
> > Randomizing twice?
>
> a VMA can only be randomized in 4Kb (well page size) granularity, so the
> 8Mb randomization can only work in that 4Kb unit, the "second"
> randomization can work in 16 byte granularity.
>
> > There is even a case where a mere rename or running through an extra
> > shell causes a slowdown.  And that's with randomization turned off.
>
> randomization off will slow stuff down yes... you get cache alias
> contention that way.

Randomization on.  Executable runs with 8x blips/hits.
Randomization off.  Executable runs without blips/hits.
With randomization off, a mere rename causes an 8x-slowdown to occur.  Run 
this renamed executable through sh -c ./tstExec, and the slowdown 
disappears.  Really weired :)

> > 2.4.31 doesn't show these slowdowns.
>
> 2.4.31 randomizes the stack with 8Kb.
>
> > What is 2.6 doing?
>
> you're not providing a lot of info ;)
>
> why do you suspect randomization as cause for whatever slowdown you are
> seeing?

echo 0 > /proc/sys/kernel/randomize_va_space makes the blips/hits to go away, 
most of the time.

> What kind of slowdown are you seeing?

see below.

Beware, this is highly compiler/glibc/distribution dependent.
My test environment is mdk9.1, gcc-3.2.2-3, 2.6.17.4, compile with -Os switch
Confirmed on rhel4, gcc-4.0.1, 2.6.9-5.EL, compile with no switches

Thanks!

--
Al

---
#include <stdio.h>
#include <sys/time.h>

unsigned long elapsed(int start) {

	static struct timeval s,e;
	if (start) return gettimeofday(&s, NULL);
	gettimeofday(&e, NULL);
	return ((e.tv_sec - s.tv_sec) * 1000 + (e.tv_usec - s.tv_usec) / 1000);
}

void fn2(double *x, double *y) {

	*x = *y;
}

void fn() {

	long i = 9999999;
	double x,y;

	elapsed(1);
	while (i--) fn2(&x,&y);
	printf("%4lu ",elapsed(0));
}

int main(int argc, char **argv) {

	fn();
	fn();
	fn();
	fn();
	fn();
	fn();
	fn();
	fn();
	fn();
	fn();
	printf("msec\n");
	
	return 0;
}

