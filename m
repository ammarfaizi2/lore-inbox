Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWFCVoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWFCVoA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 17:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWFCVoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 17:44:00 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:11930 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751410AbWFCVn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 17:43:58 -0400
Subject: Re: Interrupts disabled for too long in printk
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: linux-kernel@vger.kernel.org, ltt-dev@shafik.org
In-Reply-To: <20060603111934.GA14581@Krystal>
References: <20060603111934.GA14581@Krystal>
Content-Type: text/plain
Date: Sat, 03 Jun 2006 17:43:48 -0400
Message-Id: <1149371028.13993.171.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-03 at 07:19 -0400, Mathieu Desnoyers wrote:
> Hi,
> 
> I ran some experiments with my kernel tracer (LTTng : http://ltt.polymtl.ca)
> that showed missing interrupts. I wrote a small paper to show how to use my
> tracer to solve this kind of problem which I presented at the CE Linux Form
> last April.
> 
> http://tree.celinuxforum.org/CelfPubWiki/ELC2006Presentations?action=AttachFile&do=get&target=celf2006-desnoyers.pdf
> 
> It shows that, when the serial console is activated, the following code disables
> interrupts for up to 15ms. On a system configured with a 250HZ timer (each 4ms),
> it means that 3 scheduler ticks are lost.
> 
> In the current git :
> 
> kernel/printk.c: release_console_sem()
> 
>         for ( ; ; ) {
> ----->          spin_lock_irqsave(&logbuf_lock, flags);
>                 wake_klogd |= log_start - log_end;
>                 if (con_start == log_end)
>                         break;                  /* Nothing to print */
>                 _con_start = con_start;
>                 _log_end = log_end;
>                 con_start = log_end;            /* Flush */
>                 spin_unlock(&logbuf_lock);
>                 call_console_drivers(_con_start, _log_end);
> ----->          local_irq_restore(flags);
>         }
> 
> I guess interrupts are disabled for a good reason (to protect this spinlock for
> being taken by a nested interrupt handler. One way I am thinking to fix this
> problem would be to do a spin try lock and fail if it is already taken.

So what's the problem?

printk is more for debugging. If you don't like the latency then disable
printks.  But turning the spin_lock_irqsave into a spin_lock means you
need to do a trylock every time in printk.  Since printk can be called
from interrupt handlers.  So what do you do when you fail? just return?
So you just lost your printk that you needed, which could be of
importance.

Actually, the spin_lock is not your problem, since it is not held when
the console drivers are being called. But...

There may be console drivers that grab spin_locks without turning off
interrupts, which mean that you can again deadlock if an interrupt that
calls printk happens in one of those drivers.

If latency is your worry, then try out Ingo Molnar's -rt patch
http://people.redhat.com/mingo/realtime-preempt/
It isn't affected by this problem.

-- Steve

