Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUIMGfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUIMGfe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 02:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUIMGfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 02:35:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:54748 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266181AbUIMGfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 02:35:19 -0400
Date: Mon, 13 Sep 2004 08:35:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Zwane Mwaikambo <zwane@fsmlabs.com>, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Yielding processor resources during lock contention
Message-ID: <20040913063548.GA11661@elte.hu>
References: <7F740D512C7C1046AB53446D372001730232E11C@scsmsx402.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D372001730232E11C@scsmsx402.amr.corp.intel.com>
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


* Nakajima, Jun <jun.nakajima@intel.com> wrote:

> The instruction mwait is just a hint for the processor to enter an
> (implementation-specific) optimized state, and in general it cannot
> cause indefinite delays because of various break events, including
> interrupts. If an interrupt happens, then the processor gets out of
> the mwait state. [...]

the problem is, there is no guarantee that an interrupt may happen on a
CPU from that point on _ever_. Currently we do have a periodic timer
interrupt but this is not cast into stone. So we cannot really use MWAIT
for the idle loop either - at most as a replacement for HLT without any
latency assumptions. We could monitor the idle task's ->need_resched
flag.

> [...] The instruction does not support a restart at the mwait
> instruction. In other words the processor needs to redo the mwait
> instruction to reenter the state after a break event. Event time-outs
> may take the processor out of the state, depending on the
> implementation.

this is not a problem. The proper way to fix MWAIT for spinlocks (as i
suggested in the first email) would be to monitor a given cacheline's
existence in the L2 cache. I.e. to snoop for invalidates of that 
cacheline. That would make it possible to do:

	while (!spin_trylock(lock)) {
		MONITOR(lock);
		if (spin_is_locked(lock))
			MWAIT(lock);
	}

the first spin_trylock() test brings the cacheline into the L2 cache. 
There is no guarantee that by the time MONITOR executes it will still be
there but the likelyhood is high. Then we execute MONITOR which clears
the event flag. The second spin_is_locked() test brings the cacheline
into the L2 for sure - then we enter MWAIT which waits until the
event-flag is clear. If at any point another CPU moves the cacheline
into Exclusive (and then Modified) state then this CPU _must_ invalidate
the lock cacheline - hence the event flag will be set and MWAIT
immediately exits. I know that this is not how MONITOR/MWAIT works right
now but this is how MONITOR/MWAIT could work well for spinlocks.

(if the cache is not MESI but MOESI then the second test has to be
spin_trylock() as well [which dirties the cacheline] - since in that
case there would be no guarantee that the spin_is_locked() read-only
test would invalidate the possibly dirty cacheline on the spinlock owner
CPU.)

	Ingo
