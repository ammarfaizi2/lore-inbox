Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbVA1X27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbVA1X27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 18:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbVA1X27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 18:28:59 -0500
Received: from mx1.elte.hu ([157.181.1.137]:62877 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262830AbVA1X2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 18:28:49 -0500
Date: Sat, 29 Jan 2005 00:28:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Olaf Hering <olh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] idle thread preemption fix
Message-ID: <20050128232816.GA12586@elte.hu>
References: <200501082318.j08NI6Kg027877@hera.kernel.org> <20050128224317.GA6197@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128224317.GA6197@suse.de>
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


* Olaf Hering <olh@suse.de> wrote:

> Whats the purpose of local_irq_disable() here? Locks up my toys in
> atkbd_init or IP hash foo functions.

fix already posted a couple of days ago, see:

--
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
