Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267403AbUI0XAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267403AbUI0XAH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 19:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUI0XAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 19:00:07 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:163 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267403AbUI0W7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 18:59:42 -0400
Date: Tue, 28 Sep 2004 01:01:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Gene Heskett <gene.heskett@verizon.net>,
       Matt Heler <lkml@lpbproductions.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm4
Message-ID: <20040927230119.GA31278@elte.hu>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409270053.22911.gene.heskett@verizon.net> <20040927201928.GB19257@elte.hu> <1096317273.2523.5.camel@deimos.microgate.com> <20040927204557.GA22542@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927204557.GA22542@elte.hu>
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


could you try the patch below ontop of -mm4 and try again the .config
that failed before? Does the bootup still hang?

The early bootup stage is pretty fragile because the idle thread is not
yet functioning as such and so we need preemption disabled. Whether the
bootup fails or not seems to depend on timing details so e.g. the
presence of SCHED_SMT makes it go away.

disabling preemption explicitly has another advantage: the atomicity
check in schedule() will catch early-bootup schedule() calls from now
on.

the patch also fixes another preempt-bkl buglet: interrupt-driven
forced-preemption didnt go through preempt_schedule() so it resulted in
auto-dropping of the BKL. Now we go through preempt_schedule() which
properly deals with the BKL.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/init/main.c.orig	
+++ linux/init/main.c	
@@ -435,6 +435,12 @@ static void noinline rest_init(void)
 {
 	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
 	numa_default_policy();
+	/*
+	 * Re-enable preemption but disable interrupts to make sure
+	 * we dont get preempted until we schedule() in cpu_idle().
+	 */
+	local_irq_disable();
+	preempt_enable_no_resched();
 	unlock_kernel();
  	cpu_idle();
 } 
@@ -501,6 +507,7 @@ asmlinkage void __init start_kernel(void
 	 * time - but meanwhile we still have a functioning scheduler.
 	 */
 	sched_init();
+	preempt_disable();
 	build_all_zonelists();
 	page_alloc_init();
 	trap_init();
--- linux/arch/i386/kernel/entry.S.orig	
+++ linux/arch/i386/kernel/entry.S	
@@ -197,10 +197,8 @@ need_resched:
 	jz restore_all
 	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
 	jz restore_all
-	movl $PREEMPT_ACTIVE,TI_preempt_count(%ebp)
 	sti
-	call schedule
-	movl $0,TI_preempt_count(%ebp)
+	call preempt_schedule
 	cli
 	jmp need_resched
 #endif
