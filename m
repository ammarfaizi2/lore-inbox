Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264125AbUDGH2b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 03:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264139AbUDGH2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 03:28:31 -0400
Received: from mx1.elte.hu ([157.181.1.137]:34779 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264125AbUDGH2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 03:28:25 -0400
Date: Wed, 7 Apr 2004 09:25:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Eric Whiting <ewhiting@amis.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040407072517.GA32140@elte.hu>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu> <20040406202548.GI2234@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406202548.GI2234@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> BTW, which is the latest 4:4 patch to use on top of 2.4? I'm porting
> the one in Andrew's rc3-mm4 in order to run the benchmark on top of
> the same kernel codebase. is that the latest one?

yeah, the one in -mm is the latest one. (right now it's out to isolate
early-bootup and ACPI problems, but it's very recent otherwise)

the 2.4 one i kept minimalistic, the latest one you can find in the
RHEL3 srpm. The 2.6 one also contains related cleanups to x86
infrastructure.

> we perfectly know that the biggest slowdown is in mysql-like and
> databases running gettimeofday, they're quite common workloads.
> Numbers were posted to the list too. vgettimeofday mitigates it.

ok. I'm not sure it's due to gettimeofday, but vgettimeofday is nice no
matter what.

> > you should also consider that while 4:4 does introduce extra TLB
> > flushes, it also removes the TLB flush at context-switch. So for
> > context-switch intensive workloads the 4:4 overhead will be smaller. (in
> 
> yes, that's also why threaded apps are hurted most. And due the
> serialized copy-user probably you shouldn't enable the threading support
> in apache2 for 4:4. Did you get the 5% slowdown with threading enabled?

it was Apache 2.0, but without threading enabled. (the default install)

> I'd expect more if you enable the threading, partly because 3:1 should
> run a bit faster with threading, and mostly because 4:4 serializes the
> copy-user. (OTOH not sure if apache does that much copy-user, in the
> past they used mmapped I/O, and mmapped I/O should scale well with
> threading on 4:4 too)

with the serialization it can get really slow. I have some copy-user
optimizations in the 2.4 patch. All it needs is a "safe" pagetable
walking function, which doesnt get confused by things like large pages. 
If this function fails then we try user_pages() - to make sure we catch
mappings not present in the pagetables (e.g. hugepages on some
platforms). Another problem are IO vmas. It might not be legal to touch
them via the user-copy functions.

but if it's possible to walk the pagetables without having to look at
the vma tree then the copy-user functions can be done lockless. This
feature is not in the 2.6 patch yet.

> > But for pure userspace code (which started this discussion), where
> > userspace overhead dominates by far, the cost is negligible even with
> > 1000Hz.
> 
> I thought hz 1000 would hurt more than %0.02 given 900 irqs per second
> themselfs wastes 1% of the cpu, but I may very well be wrong about that

the slowdown is higher: %0.2. This is the table again:

   1000Hz:               -1.08%
   1000Hz + PAE:         -1.08%
   1000Hz + 4:4:         -1.11%
   1000Hz + PAE + 4:4:   -1.39%

so we slow down from -1.08% to -1.39%, by -0.21%.

> (it's just your previous post wasn't convincing due the apparently too
> artificial testcase), [...]

as i mentioned it before, i did generate a dTLB testcase too - see the
simple code below. (it's hardcoded to my setup, the # of TLBs is
slightly below the real # of TLBs to not trash them.) It simply loops
through 60 pages and touches them. Feel free to modify it to have more
pages to see the effect on TLB-trashing apps [that should be a smaller
effect]. Also you can try other effects: nonlinear access to the pages,
and/or a more spread out layout of the working set.

but please be extremely careful with this testcase. It needs static
linking & init= booting to produce stable, comparable numbers. I did
this for a couple of key kernels and made sure the effect is the same as
in the simple loop_print.c case, but it's a real PITA to ensure stable
numbers.

	Ingo

#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define rdtscll(val) \
     __asm__ __volatile__ ("rdtsc;" : "=A" (val))

#define SECS 10ULL

#define TLBS 60

volatile char pages[TLBS*4096];

void touch_dtlbs(void)
{
	volatile char x;
	int i;

	for (i = 0; i < TLBS; i++)
		x = pages[i*4096];
}

main () {
	unsigned long long start, now, mhz = 525000000, limit = mhz * SECS;
	unsigned int count;

	printf("dtlb-intense workload:\n");
	memset(pages, 1, TLBS*4096);
repeat:
	rdtscll(start);
	count = 0;
	for (;;) {
		touch_dtlbs();
		count++;
		rdtscll(now);
		if (now - start > limit)
			break;
	}
	printf("speed: %d loops.\n", count/SECS); fflush(stdout);
	goto repeat;
}
