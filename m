Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVGGO6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVGGO6j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 10:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVGGMm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:42:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22145 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261366AbVGGMkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:40:12 -0400
Date: Thu, 7 Jul 2005 14:29:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050707122959.GA4962@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507071237.42470.s0348365@sms.ed.ac.uk> <20050707114223.GA29825@elte.hu> <200507071315.24669.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507071315.24669.s0348365@sms.ed.ac.uk>
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


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> http://devzero.co.uk/~alistair/oops1.jpeg
> 
> I disabled the trace and the STACKOVERFLOW option seems to help; I've 
> got a (slightly truncated) oops from the kernel. What happens is that 
> I get an oops, then I get a BUG: warning me about the softlock, then I 
> get another oops. I'm about to reboot to confirm whether the second 
> oops is identical to the first (I suspect that it is).

unfortunately the EIP is at 0xedc, which is a corrupted value. The stack 
trace portion that is visible on the screen is the usual pagefault trace 
- without any information about the crash site itself. What the oops 
tells us is that it's the openvpn process that crashed (if this was the 
first oops). The preempt_count is 0x20010004, which shows us that this 
was a section that had soft-IRQ-flags disabled and was in a hardirq 
context.  (see the meaning of the preempt bits at the top of 
include/linux/hardirq.h) That it's a hardirq handler that crashed is 
further corroborated by the esp, which points into a kernel data area 
(hardirq_ctx[], the 4K irq stacks), not into the process's kernel stack 
(which is at threadinfo).

the stack pointer itself looks healthy, it's near the end of a 4K page, 
i.e. far from overflowing. So it would be really useful to get the full 
oops output. (that way you can also be sure it's the first crash you are 
seeing.)

(i doubt netconsole debugging will work, given that we are in a hardirq 
context. Serial logging will work.)

one thing you could try is to apply the attached patch and reproduce the 
crash. It should print a pure backtrace and lock the box up afterwards, 
so that you can take a picture.

	Ingo

--- linux/arch/i386/kernel/traps.c.orig
+++ linux/arch/i386/kernel/traps.c
@@ -323,6 +323,8 @@ void die(const char * str, struct pt_reg
 
 	if (++die.lock_owner_depth < 3) {
 		int nl = 0;
+		dump_stack();
+		for (;;) raw_local_irq_disable(); // freeze the box
 		handle_BUG(regs);
 		printk(KERN_ALERT "%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
 #ifdef CONFIG_PREEMPT
