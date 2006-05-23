Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWEWQdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWEWQdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 12:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWEWQdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 12:33:22 -0400
Received: from wmp-pc40.wavecom.fr ([81.80.89.162]:33807 "EHLO
	domino.wavecom.fr") by vger.kernel.org with ESMTP id S1750847AbWEWQdW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 12:33:22 -0400
In-Reply-To: <1148400138.21012.6.camel@localhost.localdomain>
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
Message-ID: <OF75506F98.64DD61BC-ONC1257177.005A42A4-C1257177.005AF51F@wavecom.fr>
From: Yann.LEPROVOST@wavecom.fr
Date: Tue, 23 May 2006 18:27:15 +0200
X-MIMETrack: Serialize by Router on domino/wavecom(Release 6.5.4|March 27, 2005) at 05/23/2006
 06:27:20 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to say that I let SA_SHIRQ as the IRQ line is shared...
It seems to work correctly...

Yann



                                                                           
             Steven Rostedt                                                
             <rostedt@goodmis.                                             
             org>                                                       To 
                                       Daniel Walker <dwalker@mvista.com>  
             23/05/2006 18:02                                           cc 
                                       Yann.LEPROVOST@wavecom.fr,          
                                       linux-kernel@vger.kernel.org,       
                                       Thomas Gleixner                     
                                       <tglx@linutronix.de>, Ingo Molnar   
                                       <mingo@elte.hu>                     
                                                                   Subject 
                                       Re: Ingo's  realtime_preempt patch  
                                       causes kernel oops                  
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




On Tue, 2006-05-23 at 08:33 -0700, Daniel Walker wrote:
> On Tue, 2006-05-23 at 10:19 -0400, Steven Rostedt wrote:
>
> >
> > The fault is at 0x40 and looking at profile_tick it calls
> > user_mode(regs).  user_mode(x) is defined in arm as
> >    (((regs)->ARM_cpsr & 0xf) == 0)
> >
> > And ARM_cpsr is uregs[16]  So if arm has 4 byte words and regs was
NULL,
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
--- linux-2.6.16-rt23.orig/arch/arm/mach-at91rm9200/time.c
2006-05-23 11:58:21.000000000 -0400
+++ linux-2.6.16-rt23/arch/arm/mach-at91rm9200/time.c        2006-05-23
11:58:45.000000000 -0400
@@ -87,7 +87,7 @@ static irqreturn_t at91rm9200_timer_inte

 static struct irqaction at91rm9200_timer_irq = {
             .name                         = "at91_tick",
-            .flags                        = SA_SHIRQ | SA_INTERRUPT,
+            .flags                        = SA_INTERRUPT | SA_NODELAY,
             .handler          = at91rm9200_timer_interrupt
 };





