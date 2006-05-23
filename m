Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWEWQCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWEWQCo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 12:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWEWQCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 12:02:44 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:26302 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750793AbWEWQCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 12:02:43 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Yann.LEPROVOST@wavecom.fr, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1148398425.3535.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
References: <OF20E79D4D.33810FF5-ONC1257177.00493588-C1257177.004BB870@wavecom.fr>
	 <1148393971.4997.24.camel@localhost.localdomain>
	 <1148398425.3535.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Tue, 23 May 2006 12:02:18 -0400
Message-Id: <1148400138.21012.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 08:33 -0700, Daniel Walker wrote:
> On Tue, 2006-05-23 at 10:19 -0400, Steven Rostedt wrote:
> 
> > 
> > The fault is at 0x40 and looking at profile_tick it calls
> > user_mode(regs).  user_mode(x) is defined in arm as 
> >    (((regs)->ARM_cpsr & 0xf) == 0)
> > 
> > And ARM_cpsr is uregs[16]  So if arm has 4 byte words and regs was NULL,
> > it would fault on 16*4 = 64 or 0x40
> > 
> > It looks like the timer interrupt on this board is having a NULL regs
> > passed to it when hard interrupts are threads.  Which might mean that
> > the timer interrupt is itself a thread.
> 
> Hmm, well usually ARM timer interrupts have the SA_TIMER flag .. In
> realtime ARM changes SA_TIMER includes SA_NODELAY .. 
> 
> In 2.6.17-rc4 
> 
> arch/arm/mach-at91rm9200/time.c
> 
> static struct irqaction at91rm9200_timer_irq = {
>         .name           = "at91_tick",
>         .flags          = SA_SHIRQ | SA_INTERRUPT,
>         .handler        = at91rm9200_timer_interrupt
> };
> 
> No SA_TIMER, and no SA_NODELAY , so i'd imagine it's is in a thread .. 

Yep, I would say it is.

Yann, could you try the following patch to see if it makes it better for
you.  I added SA_NODELAY so that the timer is run in interrupt context,
and removed the shared flag, because I have no idea what might share a
timer interrupt, and it might cause other bugs.  If something needs to
share this interrupt, then we need to do something else.

Since I don't have any arm boards, I cant test it, so this wasn't even
compiled.

-- Steve

Index: linux-2.6.16-rt23/arch/arm/mach-at91rm9200/time.c
===================================================================
--- linux-2.6.16-rt23.orig/arch/arm/mach-at91rm9200/time.c	2006-05-23 11:58:21.000000000 -0400
+++ linux-2.6.16-rt23/arch/arm/mach-at91rm9200/time.c	2006-05-23 11:58:45.000000000 -0400
@@ -87,7 +87,7 @@ static irqreturn_t at91rm9200_timer_inte
 
 static struct irqaction at91rm9200_timer_irq = {
 	.name		= "at91_tick",
-	.flags		= SA_SHIRQ | SA_INTERRUPT,
+	.flags		= SA_INTERRUPT | SA_NODELAY,
 	.handler	= at91rm9200_timer_interrupt
 };
 


