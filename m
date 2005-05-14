Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVENO2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVENO2Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 10:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbVENO2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 10:28:16 -0400
Received: from mx1.elte.hu ([157.181.1.137]:45242 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262765AbVENO2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 10:28:12 -0400
Date: Sat, 14 May 2005 16:27:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Does smp_reschedule_interrupt really reschedule?
Message-ID: <20050514142756.GA4595@elte.hu>
References: <1116008299.4728.19.camel@localhost.localdomain> <20050513182631.GA15916@elte.hu> <1116010280.4728.29.camel@localhost.localdomain> <20050514063741.GA12217@elte.hu> <1116070349.1604.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116070349.1604.20.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> In finish_task_switch, we have:
> 
> #if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
> 	/*
> 	 * If we pushed an RT task off the runqueue,
> 	 * then kick other CPUs, they might run it:
> 	 */
> 	if (unlikely(rt_task(current) && prev->array && rt_task(prev))) {
> 		rt_overload_schedule++;
> 		smp_send_reschedule_allbutself();
> 	}
> #endif
> 
> 
> Here's my question, where does CPU1 get need_resched set?  As 
> discussed earlier, smp_send_reschedule_allbutself doesn't do it.

hm, you are right - the 'kick other CPUs' portion of RT-overload 
handling (which is a new scheduler feature currently being tested in the 
-RT kernel) is missing this step. So we might as well force a reschedule 
from the IPI handler - the way you suggested it. We might overdo 
scheduling a bit, but it cannot hurt - and it will definitely make a 
difference for the case where an RT task is waiting to be run.

the vanilla kernel is not affected.

	Ingo
