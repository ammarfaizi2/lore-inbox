Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVCRHtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVCRHtm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 02:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVCRHtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 02:49:42 -0500
Received: from mx2.elte.hu ([157.181.151.9]:7566 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261485AbVCRHti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 02:49:38 -0500
Date: Fri, 18 Mar 2005 08:49:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318074903.GA27656@elte.hu>
References: <20050318002026.GA2693@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318002026.GA2693@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-3.101, required 5.9,
	BAYES_00 -4.90, DRASTIC_REDUCED 1.80
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> Seems to me that it would be good to have an RCU implementation that
> meet the requirements of the Real-Time Preemption patch, but that is
> 100% compatible with the "classic RCU" API.  Such an implementation
> must meet a number of requirements, which are listed at the end of
> this message (search for "REQUIREMENTS").

[ Wow. you must be a secret telepatic mind-reader - yesterday i was
  thinking about mailing you, because my approach to RCU preemptability
  (the API variants) clearly sucked and caused problems all around, both
  in terms of maintainability and in terms of stability and
  scalability. ]

> 5.	The final version, which both scales and meets realtime
> 	requirements, as well as exactly matching the "classic RCU"
> 	API.
> 
> I have tested this approach, but in user-level scaffolding.  All of
> these implementations should therefore be regarded with great
> suspicion: untested, probably don't even compile.  Besides which, I
> certainly can't claim to fully understand the real-time preempt patch,
> so I am bound to have gotten something wrong somewhere.  In any case,
> none of these implementations are a suitable replacement for "classic
> RCU" on large servers, since they acquire locks in the RCU read-side
> critical sections. However, they should scale enough to support small
> SMP systems, inflicting only a modest performance penalty.

basically for PREEMPT_RT the only constraint is that RCU sections should
be preemptable. Whatever the performance cost. If PREEMPT_RT is merged
into the upstream kernel then it will (at least initially) be at a
status similar to NOMMU: it will be tolerated as long as it causes no
'drag' on the main code. The RCU API variants i introduced clearly
violated this requirement, and were my #1 worry wrt. upstream
mergability.

> I believe that implementation #5 is most appropriate for real-time
> preempt kernels. [...]

yeah, agreed - it looks perfect - both the read and write side is
preemptable. Can i just plug the code you sent into rcupudate.c and
expect it to work, or would you like to send a patch? If you prefer you
can make it an unconditional patch against an upstream kernel to keep
things simple for you - i'll then massage it to be properly PREEMPT_RT
dependent.

> [...] In theory, #3 might be appropriate, but if I understand the
> real-time preempt implementation of reader-writer lock, it will not
> perform well if there are long RCU read-side critical sections, even
> in UP kernels.

all RCU-locked sections must be preemptable in -RT.  Basically RCU is a
mainstream API that is used by lots of code and will be introduced in
many other areas as well. From the -RT kernel's POV sees this as an
'uncontrollable latency source', which keeps introducing critical
sections. One major goal of PREEMPT_RT is to convert all popular
critical section APIs into preemptible sections, so that the amount of
code that is non-preemptable is drastically reduced and can be managed
(and thus can be trusted). This goal has a higher priority than any
performance consideration, because it doesnt matter what performance you
have, if you cannot trust the kernel to be deterministic.

	Ingo
