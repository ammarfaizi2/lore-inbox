Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbULNW2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbULNW2l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbULNW1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:27:48 -0500
Received: from mx2.elte.hu ([157.181.151.9]:6086 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261668AbULNWXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:23:40 -0500
Date: Tue, 14 Dec 2004 23:23:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: [patch, 2.6.10-rc3] safe_hlt() & NMIs
Message-ID: <20041214222307.GB22043@elte.hu>
References: <41BA698E.8000603@mvista.com> <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com> <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com> <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com> <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random> <41BC1BF9.70701@colorfullife.com> <20041212121546.GM16322@dualathlon.random> <1103060437.14699.27.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103060437.14699.27.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Sun, 2004-12-12 at 13:15 +0100, Andrea Arcangeli wrote:
> > Overall this is a very minor issue (unless HZ is 0), it would only
> > introduce a 1/HZ latency to the irq that get posted while the nmi
> > handler is running, and the nmi handlers never runs in production.
> 
> Ingo, couldn't this account for some of the inexplicable outliers some
> people were seeing in latency tests?

indeed, there could be a connection, and it's certainly a fun race. The
proper fix is Manfred's suggestion: check whether the EIP is a kernel
text address, and if yes, whether it's a HLT instruction - and if yes
then increase EIP by 1. I've included the fix in the -33-02 -RT patch.
Andrew, Linus: upstream fix is below - i think it's post-2.6.10 stuff.
Tested it on SMP and UP x86, using both the IO-APIC and the local-APIC
based NMI watchdog.

i think x64 needs a similar fix as well.

	Ingo

--- linux/arch/i386/kernel/traps.c.orig
+++ linux/arch/i386/kernel/traps.c
@@ -670,6 +670,17 @@ fastcall void do_nmi(struct pt_regs * re
 
 	cpu = smp_processor_id();
 
+	/*
+	 * Fix up obscure CPU behavior: if we interrupt safe_hlt() via
+	 * the NMI then we might miss a reschedule if an interrupt is
+	 * posted to the CPU and executes before the HLT instruction.
+	 *
+	 * We check whether the EIP is kernelspace, and if yes, whether
+	 * the instruction is HLT:
+	 */
+	if (__kernel_text_address(regs->eip) && *(char *)regs->eip == 0xf4)
+		regs->eip++;
+
 #ifdef CONFIG_HOTPLUG_CPU
 	if (!cpu_online(cpu)) {
 		nmi_exit();
