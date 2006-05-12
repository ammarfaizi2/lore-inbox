Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWELL7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWELL7H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWELL7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:59:07 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:44482 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1751260AbWELL7G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:59:06 -0400
Message-ID: <44647885.2020902@compro.net>
Date: Fri, 12 May 2006 07:59:01 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH -rt] irqd starvation on SMP by a single process?
References: <1147401812.1907.14.camel@cog.beaverton.ibm.com> <20060512055025.GA25824@elte.hu> <Pine.LNX.4.58.0605120337150.26721@gandalf.stny.rr.com> <4464740C.8060305@compro.net> <20060512115614.GA28377@elte.hu>
In-Reply-To: <20060512115614.GA28377@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Mark Hounschell <markh@compro.net> wrote:
> 
>> Steven Rostedt wrote:
>>> On Fri, 12 May 2006, Ingo Molnar wrote:
>>>
>>>> ah. This actually uncovered a real bug. We were calling __do_softirq()
>>>> with interrupts enabled (and being preemptible) - which is certainly
>>>> bad.
>>> Hmm, I wonder if this is also affecting Mark's problem.
>> I thought the same thing when I read it??
> 
> could you try the patch below?
> 
> 	Ingo
> 
> ----
> 
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>> one solution would be to forbid disable_irq() from softirq contexts, and
>>> to convert the vortex timeout function to a workqueue and use the
>>> *_delayed_work() APIs to drive it - and cross fingers there's not many
>>> places to fix.
>> I prefer the above. Maybe even add a WARN_ON(in_softirq()) in 
>> disable_irq.
>>
>> But I must admit, I wouldn't know how to make that change without 
>> spending more time on it then I have for this.
> 
> the simplest fix for now would be to use the _nosync variant in the 
> vortex timeout function.
> 
> Mark, does this fix the problem?
> 
> 	Ingo
> 
> Index: linux-rt.q/drivers/net/3c59x.c
> ===================================================================
> --- linux-rt.q.orig/drivers/net/3c59x.c
> +++ linux-rt.q/drivers/net/3c59x.c
> @@ -1897,7 +1897,8 @@ vortex_timer(unsigned long data)
>  
>  	if (vp->medialock)
>  		goto leave_media_alone;
> -	disable_irq(dev->irq);
> +	/* hack! */
> +	disable_irq_nosync(dev->irq);
>  	old_window = ioread16(ioaddr + EL3_CMD) >> 13;
>  	EL3WINDOW(4);
>  	media_status = ioread16(ioaddr + Wn4_Media);
> 

I'm trying that right this moment. It may take a while before I know if
it helps.

Mark
