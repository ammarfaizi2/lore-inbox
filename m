Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVEMS1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVEMS1b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVEMS1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:27:30 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22171 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262469AbVEMS1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:27:22 -0400
Date: Fri, 13 May 2005 20:26:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Does smp_reschedule_interrupt really reschedule?
Message-ID: <20050513182631.GA15916@elte.hu>
References: <1116008299.4728.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116008299.4728.19.camel@localhost.localdomain>
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

> As the comment says, do nothing since all the work is automatically 
> done at the return from interrupt. But is it?  Doesn't the 
> need_resched need to be set?  Here's what I'm seeing with Ingo's 
> kernel.  I capture the time in sched.c when the 
> smp_send_reschedule_allbutself is called, and also a capture of the 
> time when the schedule actually takes place.  I'm finding differences 
> up to 2 tenths of a second.  That's TENTHS!  I added the following 
> patch:

it's all a bit tricky. The short story is that i think both vanilla and 
-RT kernels are fine.

Here is how smp_send_reschedule() is used:

	CPU#0				CPU#1

	set_tsk_need_resched(rq->curr);
	...
	smp_send_reschedule()
			--- IPI --->
					smp_reschedule_interrupt();
					...
					entry.S's need_resched check

_but_, this is intentionally racy: if CPU#1 happens to reschedule before 
the IPI reaches CPU#1 (an IPI can take 10 usecs easily so the window is 
not small), then need_resched might be cleared before the IPI hits. In 
that case you wont get a reschedule after the IPI hits, because it was 
done before!

so the correct thing to measure is what the -RT kernel's wakeup-latency 
timing feature does: the time from setting need_resched, to the point 
the task starts to run. The feature works on SMP too - and it doesnt 
show any large latencies.

are you seeing actual process delays? If not then i think those large 
latencies are just the result of the wrong assumptions in your 
measurement code.

	Ingo
