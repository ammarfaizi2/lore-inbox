Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVBHI11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVBHI11 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 03:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVBHI11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 03:27:27 -0500
Received: from mx2.elte.hu ([157.181.151.9]:56457 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261482AbVBHI1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 03:27:20 -0500
Date: Tue, 8 Feb 2005 09:27:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050208082708.GA24669@elte.hu>
References: <20050204100347.GA13186@elte.hu> <20050204181958.GA6073@smtp.west.cox.net> <20050207090356.GA17372@elte.hu> <20050207143513.GI7686@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207143513.GI7686@smtp.west.cox.net>
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


* Tom Rini <trini@kernel.crashing.org> wrote:

> > please send me your .config - mine builds/boots/works fine.
> 
> I don't have it handy anymore, but I just cp'd arch/x86_64/defconfig
> to .config, ran oldconfig and turned RT off (PREEMPT_NONE=y) [...]

thanks - managed to reproduce it this way. The patch below fixes the x64
build error on !PREEMPT_RT and the resulting kernel boots fine as well,
plus it fixes an x64 SMP build error as well. I have uploaded the -38-04
release with this fix.

	Ingo

--- linux/arch/x86_64/kernel/x8664_ksyms.c	
+++ linux/arch/x86_64/kernel/x8664_ksyms.c	
@@ -194,7 +194,7 @@ EXPORT_SYMBOL(rwsem_down_write_failed_th
 EXPORT_SYMBOL(empty_zero_page);
 
 #ifdef CONFIG_HAVE_DEC_LOCK
-EXPORT_SYMBOL(_atomic_dec_and_lock);
+EXPORT_SYMBOL(_atomic_dec_and_raw_spin_lock);
 #endif
 
 EXPORT_SYMBOL(die_chain);
--- linux/arch/x86_64/lib/dec_and_lock.c	
+++ linux/arch/x86_64/lib/dec_and_lock.c	
@@ -10,7 +10,7 @@
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
 
-int _atomic_dec_and_lock(atomic_t *atomic, raw_spinlock_t *lock)
+int _atomic_dec_and_raw_spin_lock(atomic_t *atomic, raw_spinlock_t *lock)
 {
 	int counter;
 	int newcount;

--- linux/arch/x86_64/kernel/smp.c	
+++ linux/arch/x86_64/kernel/smp.c	
@@ -266,6 +266,16 @@ void smp_send_reschedule(int cpu)
 }
 
 /*
+ * this function sends a 'reschedule' IPI to all other CPUs.
+ * This is used when RT tasks are starving and other CPUs
+ * might be able to run them:
+ */
+void smp_send_reschedule_allbutself(void)
+{
+	send_IPI_allbutself(RESCHEDULE_VECTOR);
+}
+
+/*
  * Structure and data for smp_call_function(). This is designed to minimise
  * static memory requirements. It also looks cleaner.
  */
