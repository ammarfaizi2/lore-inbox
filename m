Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268306AbUJOSvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268306AbUJOSvr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 14:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268312AbUJOSvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 14:51:47 -0400
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:49540 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S268306AbUJOSvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 14:51:23 -0400
Date: Fri, 15 Oct 2004 14:51:07 -0400
From: Jim Paris <jim@jtan.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI IRQ problems: "nobody cared!"
Message-ID: <20041015185107.GA1828@jim.sh>
References: <20041015083722.GA3315@jim.sh> <1097846385.9857.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097846385.9857.18.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I posted a patch to poll when we find IRQ's have gone astray. It needs
> redoing versus Ingo's new 2.6.9 IRQ code but should apply cleanly to
> 2.6.8. You can the boot with "irqpoll" as a boot option and the box
> should survive.

You rock!  irqpoll works like a charm.  I get the same error in the
same place, but now all of my devices still work.  I don't see any
obvious performance impact (although I haven't tested it much).

I applied this irqpoll patch:
  http://groups.google.com/groups?selm=2BunT-6Be-15%40gated-at.bofh.it
and then some minor fixes (see below).

The log for this boot are at
  https://jim.sh/svn/jim/devl/toughbook/log/irqpoll.txt
in case anyone is interested.

-jim


diff -urN ac/arch/i386/kernel/irq.c jim/arch/i386/kernel/irq.c
--- ac/arch/i386/kernel/irq.c	2004-10-15 13:18:46.000000000 -0400
+++ jim/arch/i386/kernel/irq.c	2004-10-15 13:18:26.000000000 -0400
@@ -391,11 +391,11 @@
 	{
 		if((irqfixup == 2 && irq == 0) || action_ret == IRQ_NONE)
 		{
+			int ok;
 #ifdef CONFIG_4KSTACKS
 			u32 *isp;
 			union irq_ctx * curctx;
 			union irq_ctx * irqctx;
-			int ok;
 
 			curctx = (union irq_ctx *) current_thread_info();
 			irqctx = hardirq_ctx[smp_processor_id()];
@@ -435,7 +435,7 @@
 #else
 			spin_unlock(&desc->lock);
 
-			ok = misrouted_irq(irq, desc, regs);
+			ok = misrouted_irq(irq, regs);
 
 			spin_lock(&desc->lock);
 #endif

