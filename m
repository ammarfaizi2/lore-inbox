Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVAYJCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVAYJCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 04:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVAYJCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 04:02:11 -0500
Received: from mx1.elte.hu ([157.181.1.137]:27869 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261726AbVAYJCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 04:02:03 -0500
Date: Tue, 25 Jan 2005 10:01:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Problem with cpu_rest() change
Message-ID: <20050125090131.GA4986@elte.hu>
References: <1106534442.5272.10.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106534442.5272.10.camel@gaston>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Hi Ingo !
> 
> Could you explain me precisely what is the race you are fixing by
> adding local_irq_disable() to rest_init() ?

it can be bad for the idle task to hold the BKL and to have preemption
enabled - in such a situation the scheduler will get confused if an
interrupt triggers a forced preemption in that small window. But it's
not necessary to keep IRQs disabled after the BKL has been dropped. In
fact i think IRQ-disabling doesnt have to be done at all, the patch
below ought to solve this scenario equally well, and should solve the
PPC side-effects too.

Tested ontop of 2.6.11-rc2 on x86 PREEMPT+SMP and PREEMPT+!SMP (which
IIRC were the config variants that triggered the original problem), on
an SMP and on a UP system.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/init/main.c.orig
+++ linux/init/main.c
@@ -373,14 +373,9 @@ static void noinline rest_init(void)
 {
 	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
 	numa_default_policy();
-	/*
-	 * Re-enable preemption but disable interrupts to make sure
-	 * we dont get preempted until we schedule() in cpu_idle().
-	 */
-	local_irq_disable();
-	preempt_enable_no_resched();
 	unlock_kernel();
- 	cpu_idle();
+	preempt_enable_no_resched();
+	cpu_idle();
 } 
 
 /* Check for early params. */
