Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbULUKJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbULUKJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 05:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbULUKJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 05:09:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:64718 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261606AbULUKJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 05:09:50 -0500
Date: Tue, 21 Dec 2004 11:09:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Loic Domaigne <loic-dev@gmx.net>
Cc: piggin@cyberone.com.au, nptl@bullopensource.org,
       Linux-Kernel@Vger.Kernel.ORG
Subject: Re: Re: OSDL Bug 3770
Message-ID: <20041221100934.GA31538@elte.hu>
References: <9785.1103562168@www38.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9785.1103562168@www38.gmx.net>
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


* Loic Domaigne <loic-dev@gmx.net> wrote:

> N> lkml: We're discussing the fact that on SMP machines, our realtime 
> N> scheduling policies are per-CPU only. This caused a problem where a 
> N> high priority task on one CPU caused all lower priority tasks on that 
> N> CPU to be starved, while tasks on another CPU with the same low 
> N> priority were able to run.
> 
> That summary should readily motivate you to make a patch ;-)

note that my -RT patchset includes scheduler changes that implement
"global RT scheduling" on SMP systems. Give it a go, it's at:

   http://redhat.com/~mingo/realtime-preempt/

you have to enable CONFIG_PREEMPT_RT to active this feature. I've
designed this code to not hurt non-RT scheduling, and i've optimized
performance for the 'lightly loaded case' (which is the most common to
occur on mainline-using systems).

A very short description of the design: there's a global 'RT overload
counter' - which is zero and causes no overhead if there is at most 1 RT
task in every runqueue.  (i.e. at most 2 RT tasks on a 2-way system, at
most 4 RT tasks on a 4-way system, etc.) If the system gets into 'RT
overload' mode (e.g. the third RT task gets activated on a 2-way box),
then the scheduler starts to balance the RT tasks agressively. Also,
whenever an RT task is preempted on a CPU, or is woken up but cannot
preempt a higher-prio RT task on a given CPU, then it's 'pushed' to
other CPUs if possible. This design avoids global locking (it avoids a
global runqueue), which simplifies things immensely. (I first tried a
global runqueue for RT tasks but the complexity impact was much bigger.)

(note that these scheduler changes are resonably self-contained and do
not depend on other parts of PREEMPT_RT, so in theory they could be
added to mainline too, after some time - given lots of testing and broad
agreement.)

anyway, the first step would be to try this scheduler and give feedback
of how well it works for you :-)

	Ingo
