Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132804AbRDIRaQ>; Mon, 9 Apr 2001 13:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132805AbRDIRaH>; Mon, 9 Apr 2001 13:30:07 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:16992 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132804AbRDIR34>; Mon, 9 Apr 2001 13:29:56 -0400
Date: Mon, 9 Apr 2001 19:31:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: softirq buggy
Message-ID: <20010409193125.A758@athlon.random>
In-Reply-To: <200104081758.VAA15670@ms2.inr.ac.ru> <3AD0D9A8.189AA43C@colorfullife.com> <20010409155052.H7108@athlon.random> <3AD1D4A3.1E7FACD8@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <3AD1D4A3.1E7FACD8@colorfullife.com>; from manfred@colorfullife.com on Mon, Apr 09, 2001 at 05:26:27PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 09, 2001 at 05:26:27PM +0200, Manfred Spraul wrote:
> The return path to user space checks for pending softirqs. A delay of

And it breaks the loop too if new softirq events become pending again in
background.

> 1/HZ is only possible if the cpu loops in kernel space without returning
> to user space - and the functions that can loop check

It is also possible when new events are posted and I think it makes
sense to scale the softirq load with the scheduler when it is flooding.

Theoretically one could move the _whole_ softirq load into the ksoftirqd, but
that would increase the latency too much and I think it is better to use it
only as a fallback when we have to giveup but we still would like to keep
processing the softirq load so we let the scheduler to choose if we still can
do that or if we should giveup on the softirq.

> Is a full thread really necessary? Just setting 'need_resched' should be
> enough, schedule() checks for pending softirqs.

If you abuse need_resched then you can starve userspace again, if you are ok
to starve userspace indefinitely then it is more efficient to keep looping
forever into do_softirq as far as new events are posted in background instead
of exiting do_softirq and waiting the scheduler to kickin again.

> And do you have a rough idea how often that new thread is scheduled
> under load?

The scheduling is not as heavy as with tasks, it's a kernel thread
so the tlb isn't touched. However yes it will generate some overhead
with schedule() compared to just waiting the 1/HZ but letting the scheduler to
understand when the softirq should keep running instead of another task is
supposed to be a feature. I run a netpipe run with an alpha SMP as receiver
with the ksoftirqd patch and then without and the numbers didn't changed at all
even if the ksofitrqd was often running (1/2% of the load of the machine).

> Btw, you don't schedule the ksoftirqd thread if do_softirq() returns
> from the 'if(in_interrupt())' check.

That's not necessary and it's intentional, such check will be passed in the
last do_softirq executed before returning to userspace or kernel normal
context, the reason of such check is only to avoid recursing too much on the
stack during nested irqs.

> I assume that this is the most common case of delayed softirq
> processing:
> 
> ; in process context
> spin_lock_bh();
> ; hw interrupt arrives
> ; do_softirq returns immediately
> spin_unlock_bh();

This is yet another case and it's handled before returning to userspace so the
latency should still be pretty small (and there would be no singificant
advantage and almost certainly only a performance drop in waking up ksoftirqd
from the `do_softirq returns immediatly' line).

Andrea

--liOOAslEiF7prFVr
Content-Type: image/png
Content-Disposition: attachment; filename="ksofitrqd.png"
Content-Transfer-Encoding: base64

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

--liOOAslEiF7prFVr--
