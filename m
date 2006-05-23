Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWEWPds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWEWPds (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 11:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWEWPds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 11:33:48 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:40456 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750715AbWEWPdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 11:33:47 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yann.LEPROVOST@wavecom.fr, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1148393971.4997.24.camel@localhost.localdomain>
References: <OF20E79D4D.33810FF5-ONC1257177.00493588-C1257177.004BB870@wavecom.fr>
	 <1148393971.4997.24.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 23 May 2006 08:33:44 -0700
Message-Id: <1148398425.3535.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 10:19 -0400, Steven Rostedt wrote:

> 
> The fault is at 0x40 and looking at profile_tick it calls
> user_mode(regs).  user_mode(x) is defined in arm as 
>    (((regs)->ARM_cpsr & 0xf) == 0)
> 
> And ARM_cpsr is uregs[16]  So if arm has 4 byte words and regs was NULL,
> it would fault on 16*4 = 64 or 0x40
> 
> It looks like the timer interrupt on this board is having a NULL regs
> passed to it when hard interrupts are threads.  Which might mean that
> the timer interrupt is itself a thread.

Hmm, well usually ARM timer interrupts have the SA_TIMER flag .. In
realtime ARM changes SA_TIMER includes SA_NODELAY .. 

In 2.6.17-rc4 

arch/arm/mach-at91rm9200/time.c

static struct irqaction at91rm9200_timer_irq = {
        .name           = "at91_tick",
        .flags          = SA_SHIRQ | SA_INTERRUPT,
        .handler        = at91rm9200_timer_interrupt
};

No SA_TIMER, and no SA_NODELAY , so i'd imagine it's is in a thread .. 

Daniel

