Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbVHVWe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbVHVWe5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbVHVWe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:34:56 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:53386 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751477AbVHVWe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:34:29 -0400
Date: Mon, 22 Aug 2005 09:38:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Roland McGrath <roland@redhat.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [PATCH 2.6.13-rc6-rt9]  PI aware dynamic priority adjustment
Message-ID: <20050822073833.GB19022@elte.hu>
References: <20050818060126.GA13152@elte.hu> <1124495303.23647.579.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124495303.23647.579.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Hi all,
> 
> On Thu, 2005-08-18 at 08:01 +0200, Ingo Molnar wrote:
> > i have released the 2.6.13-rc6-rt9 tree, which can be downloaded from 
> > the usual place:
> 
> I reworked the code for dynamically setting the priority of the 
> hrtimer softirq to be aware of PI.

looks mostly good to me. I'm uneasy about the fact that we touch 
p->normal_prio without taking the runqueue lock. Best would be to clean 
these things up by introducing a wake_up_process_prio() and 
wake_up_process_chprio() method that does these things embedded in 
try_to_wake_up().

> I stumbled over "//#define MUTEX_IRQS_OFF" in the first attempt. My 
> assumption that all code protected by pi_lock (which is a raw lock) is 
> irq save turned out to be wrong. I missed that commented define :( I 
> guess it was introduced during the "IRQ latency contest" to squeeze 
> out the last nsecs :)
>
> Switching it back on is not really influencing system performance in a 
> measurable way, but it allows to use the pi aware boosting function in 
> irq context.
> 
> Quite contrary it makes the system more snappy and the overall test 
> latencies go down.

we can undo that flag - it's indeed only a couple of cycles worth of 
optimization, which wont count for most workloads. I've applied your 
patch, but we need to do those cleanups and the fact needs to be 
documented that !MUTEX_IRQS_OFF is not safe anymore. (most likely this 
means that the MUTEX_IRQS_OFF flag and all related changes needs to be 
gotten rid of)

	Ingo
