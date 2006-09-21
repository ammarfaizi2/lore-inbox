Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWIUTLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWIUTLW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 15:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWIUTLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 15:11:22 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:52199 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750964AbWIUTLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 15:11:21 -0400
Date: Thu, 21 Sep 2006 21:02:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
Message-ID: <20060921190257.GA15151@elte.hu>
References: <20060920141907.GA30765@elte.hu> <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20060920182553.GC1292@us.ibm.com> <200609201436.47042.gene.heskett@verizon.net> <20060920194650.GA21037@elte.hu> <1158783590.29177.19.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20060920201450.GA22482@elte.hu> <1158784266.29177.21.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158784266.29177.21.camel@c-67-180-230-165.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> On Wed, 2006-09-20 at 22:14 +0200, Ingo Molnar wrote:
> > >         if (up->port.sysrq) {
> > >                 /* serial8250_handle_port() already took the lock */
> > >                 locked = 0;
> 
> 
> In this case it had interrupts off in the !PREEMPT_RT case, but your 
> change leaves them on here.. _irqsave only runs in two of the three 
> cases..

doh, right you are. I updated to the patch below.

	Ingo

Index: linux/drivers/serial/8250.c
===================================================================
--- linux.orig/drivers/serial/8250.c
+++ linux/drivers/serial/8250.c
@@ -2252,14 +2252,10 @@ serial8250_console_write(struct console 
 
 	touch_nmi_watchdog();
 
-	local_irq_save(flags);
-	if (up->port.sysrq) {
-		/* serial8250_handle_port() already took the lock */
-		locked = 0;
-	} else if (oops_in_progress) {
-		locked = spin_trylock(&up->port.lock);
-	} else
-		spin_lock(&up->port.lock);
+	if (up->port.sysrq || oops_in_progress)
+		locked = spin_trylock_irqsave(&up->port.lock, flags);
+	else
+		spin_lock_irqsave(&up->port.lock, flags);
 
 	/*
 	 *	First save the IER then disable the interrupts
@@ -2281,8 +2277,7 @@ serial8250_console_write(struct console 
 	serial_out(up, UART_IER, ier);
 
 	if (locked)
-		spin_unlock(&up->port.lock);
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
 static int serial8250_console_setup(struct console *co, char *options)
