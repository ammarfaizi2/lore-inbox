Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262948AbVGMPao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbVGMPao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 11:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVGMPan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 11:30:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:45791 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262948AbVGMPaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 11:30:12 -0400
Date: Wed, 13 Jul 2005 17:30:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050713153003.GA30917@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507111538.22551.s0348365@sms.ed.ac.uk> <20050711144328.GA18244@elte.hu> <200507111650.33187.s0348365@sms.ed.ac.uk> <20050713144551.GA26067@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713144551.GA26067@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> it worked upon the first try, and indeed my testbox crashed within 10 
> seconds:
> 
>  BUG: Unable to handle kernel NULL pointer dereference
>  BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000006

a couple of crashes later i got an important clue:

 BUG: bad soft irq-flag value 00000f64, openvpn/3386!
  [<c0104052>] dump_stack+0x1f/0x21 (20)
  [<c013b883>] check_soft_flags+0x73/0xc9 (24)
  [<00000f78>] 0xf78 (1066836133)

it turns out that a small portion of the softirq processing path was 
still using the soft IRQ-flag, instead of the raw IRQ-flag! Given enough 
irq and softirq workload, we were interrupted in a piece of code where 
the data structure was inconsistent. (tinfo.task was already changed, 
but %esp not yet) Since interrupts were enabled during the crash 
printout, it would crash again and again as it got more interrupts. The 
backtrace printout crashed too due to the inconsistency. That's why you 
got those repeat ============= lines.

the patch below should fix this bug and i've uploaded the -51-30 patch 
with this fix included. Could you check whether 4K stacks are now stable 
for you under PREEMPT_RT?

so your intuitition about this being related to 4K stacks was completely 
right.

	Ingo

Index: linux/arch/i386/kernel/irq.c
===================================================================
--- linux.orig/arch/i386/kernel/irq.c
+++ linux/arch/i386/kernel/irq.c
@@ -169,7 +169,7 @@ asmlinkage void do_softirq(void)
 	if (in_interrupt())
 		return;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 
 	if (local_softirq_pending()) {
 		curctx = current_thread_info();
@@ -190,7 +190,7 @@ asmlinkage void do_softirq(void)
 		);
 	}
 
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 
 EXPORT_SYMBOL(do_softirq);
