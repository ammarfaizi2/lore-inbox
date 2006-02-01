Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWBAOi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWBAOi7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 09:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWBAOi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 09:38:57 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:26793 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932450AbWBAOi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 09:38:56 -0500
Date: Wed, 1 Feb 2006 15:37:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
Message-ID: <20060201143727.GA9915@elte.hu>
References: <1138736609.7088.35.camel@localhost.localdomain> <43E02CC2.3080805@bigpond.net.au> <1138797874.7088.44.camel@localhost.localdomain> <43E0B24E.8080508@yahoo.com.au> <43E0B342.6090700@yahoo.com.au> <20060201132054.GA31156@elte.hu> <43E0BBEC.3020209@yahoo.com.au> <43E0BDA3.8040003@yahoo.com.au> <20060201141248.GA6277@elte.hu> <43E0C4CF.8090501@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E0C4CF.8090501@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> What I am talking about is when you want a task to have the highest 
> possible scheduling priority and you'd like to guarantee that it is 
> not interrupted for more than Xus, including scheduling latency.

this is not a big issue in practice, because it's very hard to saturate 
current x86 systems running the -rt kernel with pure IRQ load. The APIC 
messages all have a natural latency, which serves as a throttler.

[ Pretty much the only way i know to lock up a box via hardirq load is
  to misprogram the local APIC timer IRQ. (but we have protection
  against that in the HRT code, and the same is not possible via
  external interrupts.) ]

in case this becomes a problem (on some other platforms) we have a 
solution for it: interrupt prioritiziation. We didnt want to complicate 
things with this in the current IRQ preemption model, but it's all 
pretty straightforward to do.

> Now in your kernel you can measure a single long interrupt time, but 
> if you "break" that latency by splitting it into two interrupts, the 
> end result will be the same if not worse due to decreased efficiency.

there really is a maximum rate of interrupts you can inject, which has 
an effect of slowing down the CPU, which has a linear effect on the 
worst-case latency - but not not some other drastic effect.

> >not really - isolcpus is useful for certain problems, but it is not 
> >generic as it puts heavy constraints on usability and resource 
> >utilization. We have really, really good latencies on SMP too in the -rt 
> >kernel, with _arbitrary_ SCHED_OTHER workloads. Rwsems and rwlocks are 
> >not an issue, pretty much the only issue is the scheduler's 
> >load-balancing.
> 
> Then it is a fine hack for the RT kernel (or at least an improved, 
> batched version of the patch). No arguments from me.

no, it is also fine for the mainline scheduler, as long as the patch is 
clean and does the obviously right thing [which the current patch doesnt 
offer]. A 1+ msec latency with irqs off is nothing to sniff at. Trying 
to argue that 'you can get the same by using rwsems so why should we 
bother' is pretty lame: rwsems are rare and arguably broken in behavior, 
and i'd not say the same about the scheduler (just yet :-).

	Ingo
