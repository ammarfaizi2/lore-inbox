Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbULNWul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbULNWul (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbULNWtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:49:15 -0500
Received: from mx2.elte.hu ([157.181.151.9]:17865 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261711AbULNWri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:47:38 -0500
Date: Tue, 14 Dec 2004 23:47:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
Message-ID: <20041214224706.GA26853@elte.hu>
References: <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com> <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com> <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com> <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random> <41BC1BF9.70701@colorfullife.com> <20041212121546.GM16322@dualathlon.random> <1103060437.14699.27.camel@krustophenia.net> <20041214222307.GB22043@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214222307.GB22043@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> indeed, there could be a connection, and it's certainly a fun race.
> The proper fix is Manfred's suggestion: check whether the EIP is a
> kernel text address, and if yes, whether it's a HLT instruction - and
> if yes then increase EIP by 1. I've included the fix in the -33-02 -RT
> patch. Andrew, Linus: upstream fix is below - i think it's post-2.6.10
> stuff. Tested it on SMP and UP x86, using both the IO-APIC and the
> local-APIC based NMI watchdog.
> 
> i think x64 needs a similar fix as well.

find the correct patch below. I've tested it with an NMI watchdog
frequency artificially increased to 10 KHz, and i've instrumented the
new branch in the NMI handler, but even under heavy IRQ load i was not
able to trigger the branch. Maybe newer CPUs handle this case somehow
and make sti;hlt truly atomic? I tried this on an old Celeron
(Mendocino) and on an Athlon64.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/kernel/traps.c.orig
+++ linux/arch/i386/kernel/traps.c
@@ -670,6 +670,18 @@ fastcall void do_nmi(struct pt_regs * re
 
 	cpu = smp_processor_id();
 
+	/*
+	 * Fix up obscure CPU behavior: if we interrupt safe_hlt() via
+	 * the NMI then we might miss a reschedule if an interrupt is
+	 * posted to the CPU and executes before the HLT instruction.
+	 *
+	 * We check whether the EIP is kernelspace, and if yes, whether
+	 * the instruction is HLT:
+	 */
+	if (__kernel_text_address(regs->eip) &&
+					*(unsigned char *)regs->eip == 0xf4)
+		regs->eip++;
+
 #ifdef CONFIG_HOTPLUG_CPU
 	if (!cpu_online(cpu)) {
 		nmi_exit();
