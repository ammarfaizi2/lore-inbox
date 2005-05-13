Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbVEMS43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbVEMS43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbVEMSyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:54:36 -0400
Received: from [24.24.2.57] ([24.24.2.57]:27132 "EHLO ms-smtp-03.nyroc.rr.com")
	by vger.kernel.org with ESMTP id S262487AbVEMSwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:52:12 -0400
Subject: Re: Does smp_reschedule_interrupt really reschedule?
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050513182631.GA15916@elte.hu>
References: <1116008299.4728.19.camel@localhost.localdomain>
	 <20050513182631.GA15916@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 13 May 2005 14:51:20 -0400
Message-Id: <1116010280.4728.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 20:26 +0200, Ingo Molnar wrote:
> it's all a bit tricky. The short story is that i think both vanilla and 
> -RT kernels are fine.
> 
> Here is how smp_send_reschedule() is used:
> 
> 	CPU#0				CPU#1
> 
> 	set_tsk_need_resched(rq->curr);
> 	...
> 	smp_send_reschedule()
> 			--- IPI --->
> 					smp_reschedule_interrupt();
> 					...
> 					entry.S's need_resched check
> 

OK, Forget about vanilla, I'm keeping to your kernel now ;-) 

In finish_task_switch, where is need_resched set?


> _but_, this is intentionally racy: if CPU#1 happens to reschedule before 
> the IPI reaches CPU#1 (an IPI can take 10 usecs easily so the window is 
> not small), then need_resched might be cleared before the IPI hits. In 
> that case you wont get a reschedule after the IPI hits, because it was 
> done before!
> 
> so the correct thing to measure is what the -RT kernel's wakeup-latency 
> timing feature does: the time from setting need_resched, to the point 
> the task starts to run. The feature works on SMP too - and it doesnt 
> show any large latencies.
> 
> are you seeing actual process delays? If not then i think those large 
> latencies are just the result of the wrong assumptions in your 
> measurement code.

No this wasn't from real world applications yet. So the bug may rightly
be with the placement of my timers.  I was looking at the code and
didn't know how the reschedule takes place and started testing it.  Let
me know where that need_resched is with that finish_task_switch code,
and I'll probably be happy with just that.

Thanks,

-- Steve

