Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVFMApt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVFMApt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 20:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVFMApt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 20:45:49 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28266
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261280AbVFMApl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 20:45:41 -0400
Date: Mon, 13 Jun 2005 02:45:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Karim Yaghmour <karim@opersys.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
Message-ID: <20050613004530.GH5796@g5.random>
References: <42AA6A6B.5040907@opersys.com> <20050611191448.GA24152@elte.hu> <42AB662B.4010104@opersys.com> <20050612061108.GA4554@elte.hu> <42AC8D00.4030809@opersys.com> <20050612205902.GA31928@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612205902.GA31928@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 10:59:02PM +0200, Ingo Molnar wrote:
> if you want to measure hw-interrupt delays then under PREEMPT_RT you'll 
> need to use an SA_NODELAY interrupt handler. (which is a PREEMPT_RT 
> specific flag) If you use normal request_irq() or some parport driver 
> then the driver function will run in an interrupt thread and what you 
> are measuring is not interrupt latency but rescheduling latency.

Karim, just in case you're not very familiar with parport, this should
do the trick:

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2286,7 +2286,7 @@ struct parport *parport_pc_probe_port (u
 	}
 	if (p->irq != PARPORT_IRQ_NONE) {
 		if (request_irq (p->irq, parport_pc_interrupt,
-				 0, p->name, p)) {
+				 SA_NODELAY, p->name, p)) {
 			printk (KERN_WARNING "%s: irq %d in use, "
 				"resorting to polled operation\n",
 				p->name, p->irq);

Unless I'm missing something, this mode is only valid if coding the RT
code in the hardirq handler, which didn't seem the main benefit of
preempt-RT to me, but it's still an interesting basic benchmark,
especially now that local_irq_disable is "soft".

But I'd be nice to also measure the performance of the non-RT part of
the workload, just a suggestion if you have time.

With above patch applied my crystal ball expects preempt-RT to perform
much closer to adeos, but with the difference that the non-RT part of
the system will still get the burden of the added complexity that adeos
won't have.

Thanks.
