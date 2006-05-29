Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWE2VDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWE2VDS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWE2VDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:03:18 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:1926 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751294AbWE2VDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:03:17 -0400
Subject: Re: [-rt BUG] scheduling with irqs disabled: swapper
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       mingo@redhat.com, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060528064026.GA14665@elte.hu>
References: <1f1b08da0605261553v5e55ebdfpc790ebd5e5b0add8@mail.gmail.com>
	 <1148692456.5381.7.camel@localhost.localdomain>
	 <1148775233.30211.1.camel@leatherman>
	 <1148778806.5381.11.camel@localhost.localdomain>
	 <20060528064026.GA14665@elte.hu>
Content-Type: text/plain
Date: Mon, 29 May 2006 14:03:10 -0700
Message-Id: <1148936590.30211.9.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-28 at 08:40 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Thanks, but I was looking more into the code, and I'm wondering... 
> > Does this machine have "irqfixup" or "irqpoll" set in the kernel 
> > command line?
> > 
> > I think that -rt doesn't support it yet.  That is, it can call a 
> > handler from interrupt context, which should have been a thread.
> > 
> > Let me know if that was the case.
> 
> the backtrace shows misrouted_irq(), which is only called if "irqfixup" 
> is enabled. That indeed isnt supported in -rt yet.

Ugh. You and Steven are right. We've been bitten by this a few times,
but we thought we got rid of that option on all of our boxes. I guess
one slipped by.

Anyway, thanks for pointing that out. Would you consider a patch like
the following so that folks don't continue to slip over this?

thanks
-john

Index: rtdev/kernel/irq/spurious.c
===================================================================
--- rtdev.orig/kernel/irq/spurious.c
+++ rtdev/kernel/irq/spurious.c
@@ -194,6 +194,11 @@ __setup("noirqdebug", noirqdebug_setup);
 
 static int __init irqfixup_setup(char *str)
 {
+#ifdef CONFIG_PREEMPT_RT
+	printk(KERN_WARNING "irqfixup boot option not supported "
+		"w/ CONFIG_PREEMT_RT\n");
+	return 1;
+#endif
 	irqfixup = 1;
 	printk(KERN_WARNING "Misrouted IRQ fixup support enabled.\n");
 	printk(KERN_WARNING "This may impact system performance.\n");
@@ -204,6 +209,11 @@ __setup("irqfixup", irqfixup_setup);
 
 static int __init irqpoll_setup(char *str)
 {
+#ifdef CONFIG_PREEMPT_RT
+	printk(KERN_WARNING "irqpoll boot option not supported "
+		"w/ CONFIG_PREEMT_RT\n");
+	return 1;
+#endif
 	irqfixup = 2;
 	printk(KERN_WARNING "Misrouted IRQ fixup and polling support "
 				"enabled\n");


