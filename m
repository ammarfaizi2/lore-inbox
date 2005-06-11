Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVFKQxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVFKQxA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVFKQxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:53:00 -0400
Received: from mail-gw.turkuamk.fi ([195.148.208.32]:23949 "EHLO
	mail-gw.turkuamk.fi") by vger.kernel.org with ESMTP id S261738AbVFKQvx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:51:53 -0400
Message-ID: <42AB1712.3080301@kolumbus.fi>
Date: Sat, 11 Jun 2005 19:53:38 +0300
From: =?UTF-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Esben Nielsen <simlo@phys.au.dk>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
References: <1118449247.27756.47.camel@dhcp153.mvista.com>	 <Pine.OSF.4.05.10506111455240.2917-100000@da410.phys.au.dk>	 <20050611135111.GB31025@elte.hu>  <42AAFC75.7090601@kolumbus.fi> <1118508323.9519.84.camel@sdietrich-xp.vilm.net>
In-Reply-To: <1118508323.9519.84.camel@sdietrich-xp.vilm.net>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.13a
  |April 8, 2004) at 11.06.2005 19:51:49,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4|March
 27, 2005) at 11.06.2005 19:51:49,
	Serialize complete at 11.06.2005 19:51:49
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven-Thorsten Dietrich wrote:

>On Sat, 2005-06-11 at 18:00 +0300, Mika Penttilä wrote:
>  
>
>>Ingo Molnar wrote:
>>
>>    
>>
>>>i've done two more things in the latest patches:
>>>
>>>- decoupled the 'soft IRQ flag' from the hard IRQ flag. There's
>>> basically no need for the hard IRQ state to follow the soft IRQ state. 
>>> This makes the hard IRQ disable primitives a bit faster.
>>>
>>>- for raw spinlocks i've reintroduced raw_local_irq primitives again.
>>> This helped get rid of some grossness in sched.c, and the raw
>>> spinlocks disable preemption anyway. It's also safer to just assume
>>> that if a raw spinlock is used together with the IRQ flag that the
>>> real IRQ flag has to be disabled.
>>>
>>>these changes dont really impact scheduling/preemption behavior, they 
>>>are cleanup/robustization changes.
>>>
>>>	Ingo
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>> 
>>>
>>>      
>>>
>>With the soft IRQ flag local_irq_disable() doesn't seem to protect 
>>against soft interrupts (via SA_NODELAY interrupt-> invoke_softirq()). 
>>Could this be a problem?
>>    
>>
>
>Only if you run SOFT IRQs as SA_NODELAY, which is going to KILL all your
>preemption gains with the first arriving network packet.
>
>And that is, if you don't get buried in "scheduling while atomic" printk
>messages first.
>
>SA_NODELAY is not generally allowed in PREEMPT_RT, except for code
>designed to take advantage of the IRQ void that has been created. 
>
>This code must follow a new set of rules, which people who design RT
>apps are really happy to accet, they have to accept worse compromises
>with the alternatives (subkernel or ANOTHER OS (ugh))
>
>Sven
>
>
>
>  
>
The timer irq is run as NODELAY, so soft irqs are run against 
local_irq_disable sections all the time.

--Mika


