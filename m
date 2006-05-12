Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWELMik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWELMik (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 08:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWELMij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 08:38:39 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:29930 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1751267AbWELMij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 08:38:39 -0400
Message-ID: <446481C8.4090506@compro.net>
Date: Fri, 12 May 2006 08:38:32 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, johnstul@us.ibm.com
Subject: Re: rt20 patch question
References: <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com> <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com> <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com> <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com> <20060512081628.GA26736@elte.hu> <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com> <20060512092159.GC18145@elte.hu>
In-Reply-To: <20060512092159.GC18145@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
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

It looks like it does fix at least the BUG and network disconnection
problem I am/was seeing. It's been 45 minutes or so without a glitch.

I'm still not running this in complete preempt mode. Should I see if it
helps that situation also? It only took a few minutes for that one to
show up.

Mark
