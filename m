Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935293AbWK2HAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935293AbWK2HAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 02:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935303AbWK2HAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 02:00:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:30680 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935293AbWK2HAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 02:00:37 -0500
Date: Wed, 29 Nov 2006 07:57:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.19-rc6-rt8
Message-ID: <20061129065734.GB28258@elte.hu>
References: <20061127094927.GA7339@elte.hu> <200611282340.21317.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611282340.21317.fzu@wemgehoertderstaat.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:

> Am Montag, 27. November 2006 10:49 schrieb Ingo Molnar:
> > i have released the 2.6.19-rc6-rt8 tree, which can be downloaded from 
> 
> I saw usb transport errors here before rebooting with
> 	nmi_watchdog=0
> contained in kernel command line.

so nmi_watchdog=1 (or was it nmi_watchdog=2 ?) caused these problems - 
and then nmi_watchdog=0 fixed them? i686? Extremely weird. Does the 
patch below fix the issue perhaps?

	Ingo

Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -932,12 +932,14 @@ notrace __kprobes int nmi_watchdog_tick(
 
 	__profile_tick(CPU_PROFILING, regs);
 
+#if 0
 	/* check for other users first */
 	if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT)
 			== NOTIFY_STOP) {
 		rc = 1;
 		touched = 1;
 	}
+#endif
 
 	/*
 	 * Take the local apic timer and PIT/HPET into account. We don't
Index: linux/arch/x86_64/kernel/nmi.c
===================================================================
--- linux.orig/arch/x86_64/kernel/nmi.c
+++ linux/arch/x86_64/kernel/nmi.c
@@ -814,12 +814,14 @@ int __kprobes nmi_watchdog_tick(struct p
 
 	__profile_tick(CPU_PROFILING, regs);
 
+#if 0
 	/* check for other users first */
 	if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT)
 			== NOTIFY_STOP) {
 		rc = 1;
 		touched = 1;
 	}
+#endif
 
 	sum = read_pda(apic_timer_irqs);
 	if (nmi_show_regs[cpu]) {
