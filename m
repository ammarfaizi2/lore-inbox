Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264722AbRFSTE1>; Tue, 19 Jun 2001 15:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264725AbRFSTES>; Tue, 19 Jun 2001 15:04:18 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:16992 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264722AbRFSTEJ>; Tue, 19 Jun 2001 15:04:09 -0400
Date: Tue, 19 Jun 2001 21:03:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
        kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: softirq in pre3 and all linux ports
Message-ID: <20010619210312.Z11631@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With pre3 there are bugs introduced into mainline that are getting
extended to all architectures.

First of all nucking the handle_softirq from entry.S is wrong. ppc
copied without thinking and we'll need to resurrect it too for example
so please arch maintainers don't kill that check (alpha in pre3 by luck
didn't killed it I think).

Without such check before returning to userspace any tasklet or softirq 
posted by kernel code will get a latency of 1/HZ.

Secondly the pre3 softirq re-enables irqs before returning from
do_softirq which is wrong as well because it can generate irq flood and
stack overflow and do_softirq run not at the first not nested irq layer.

Third if a softirq or a tasklet post itself running again the do_softirq
can starve userspace in one or more cpus.

Fourth if the tasklet or softirq or bottom half hander is been marked
running again because of another even (like a nested irq) the kernel can
starve userspace too. (softirqs are much heavier than the irq handler so
it can also live lockup much more easily this way)

This patch that I have in my tree since some day fixes all those issues.

The assmembler changes needed in the entry.S files while returning to
userspace can be described in C code this way, this is the 2.4.5 way:

	if (softirq_active(cpu) & softirq_mask(cpu))
		do_softirq();

This is the 2.4.6pre3+belowfix way:

	if (softirq_pending(cpu))
		do_softirq()

pending doesn't need to be a 64bit integer (it can though) but it needs
to be at least a 32bit integer. An `int' is fine for most archs, on
alpha we use a long though and that's fine too.

So I recommend Linus merging this patch that fixes all the above
mentioned bugs (the anti starvation/live lockup logic is called
ksoftirqd):

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre3aa1/00_ksoftirqd-6

Plus those SMP race fixes for archs where atomic operations aren't
implicit memory barriers:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre3aa1/00_softirq-fixes-4

Plus this scheduler generic cpu binding fix to avoid ksoftirqd
deadlocking at boot:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre3aa1/00_cpus_allowed-1

I verified the patches applies just fine to 2.4.6pre3 and they're not
controversial.

If you've any question on how to update a certain kernel port I will do
my best to help in the update process!

Andrea
