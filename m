Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUG0R5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUG0R5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 13:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266501AbUG0R5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 13:57:19 -0400
Received: from mx1.elte.hu ([157.181.1.137]:33983 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266498AbUG0RzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 13:55:01 -0400
Date: Tue, 27 Jul 2004 18:27:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: William Lee Irwin III <wli@holomorphy.com>, Lenar L?hmus <lenar@vision.ee>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
Message-ID: <20040727162759.GA32548@elte.hu>
References: <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726204720.GA26561@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've uploaded -L2:
 
  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-L2

the big change in the -L2 release is a new latency-reduction feature:
the redirection of hardirqs to irqd. This enables lock-break methods
that make hardirqs preemptable.

I've done the lock-break of the IDE driver's completion path and i now
cannot trigger larger than 100 usecs hardirq latencies via the IDE
driver anymore, on a 2GHz x86 box - even if max_sectors is kept at the
default 1024K value. (!)

the hardirq-redirection feature is activated via voluntary-preemption=3
(default). All irqs except the timer irq are redirected. (the timer irq
needs to run from irq context - but it has constant latency and constant
frequency so it's not an issue. Soft timers are executed from the timer
softirq which is redirected and hence preemptable.)

this means that with this patch applied the 2.6 UP kernel is quite close
to being hard-RT capable (using controlled drivers and workloads). All
unbound-latency asynchronous workloads have been unloaded into
synchronous, schedulable process contexts - so nothing can delay a
high-prio RT task. (assuming we caught all the latencies. Any remaining
latency can be fixed with the existing methods.)

other changes in -L2:

i've done a softirq lock-break in the atkbd and ps2mouse drivers - this
should fix the big latencies triggered by NumLock/CapsLock, reported by
Lee Revell.

BIG WARNING: the hardirq-redirection feature is quite intrusive to
drivers so it's possible that some drivers will break under it.  The
changes done to the IDE driver might also endanger stability. Be careful
when applying this patch to production systems. If your system doesnt
boot then please try the voluntary-preempt=2 boot-option to turn off
hardirq redirection.

I've done some stresstesting on a desktop-style IDE-based system and
everything seems to work fine. YMMV.

	Ingo
