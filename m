Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVASMxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVASMxp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 07:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVASMxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 07:53:45 -0500
Received: from mx2.elte.hu ([157.181.151.9]:43239 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261707AbVASMxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 07:53:39 -0500
Date: Wed, 19 Jan 2005 13:52:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: pipe performance regression on ia64
Message-ID: <20050119125257.GA8112@elte.hu>
References: <200501181741.j0IHfGf30058@unix-os.sc.intel.com> <Pine.LNX.4.58.0501180951050.8178@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501180951050.8178@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> The "wake_up_sync()" hack only helps for the special case where we
> know the writer is going to write more. Of course, we could make the
> pipe code use that "synchronous" write unconditionally, and benchmarks
> would look better, but I suspect it would hurt real life.

not just that, it's incorrect scheduling, because it introduces the
potential to delay the woken up task by a long time, amounting to a
missed wakeup.

> I don't know how to make the benchmark look repeatable and good,
> though.  The CPU affinity thing may be the right thing.

the fundamental bw_pipe scenario is this: the wakeup will happen earlier
than the waker suspends. (because it's userspace that decides about
suspension.) So the kernel rightfully notifies another, idle CPU to run
the freshly woken task. If the message passing across CPUs and the
target CPU is fast enough to 'grab' the task, then we'll get the "slow"
benchmark case, waker remaining on this CPU, wakee running on another
CPU. If this CPU happens to be fast enough suspending, before that other
CPU had the chance to grab the CPU (we 'steal the task back') then we'll
see the "fast" benchmark scenario.

i've seen traces where a single bw_pipe testrun showed _both_ variants
in chunks of 100s of milliseconds, probably due to cacheline placement
putting the overhead sometimes above the critical latency, sometimes
below it.

so there will always be this 'latency and tendency to reschedule on
another CPU' thing that will act as a barrier between 'really good' and
'really bad' numbers, and if a test happens to be around that boundary
it will fluctuate back and forth.

and this property also has another effect: _worse_ scheduling decisions
(not waking up an idle CPU when we could) can result in _better_ bw_pipe
numbers. Also, a _slower_ scheduler can sometimes move the bw_pipe
workload below the threshold, resulting in _better_ numbers. So as far
as SMP systems are concerned, bw_pipe numbers have to be considered very
carefully.

this is a generic thing: message passing latency scales inversely always
to the quality of distribution of SMP tasks. The better we are at
spreading out tasks, the worse message passing latency gets. (nothing
will beat passive, work-less 'message passing' between two tasks on the
same CPU.)

	Ingo
