Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263256AbVCKK0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263256AbVCKK0p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 05:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbVCKK0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 05:26:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:51675 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263256AbVCKK01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 05:26:27 -0500
Date: Fri, 11 Mar 2005 11:25:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: arjan@infradead.org, pbadari@us.ibm.com, dhowells@redhat.com,
       torvalds@osdl.org, suparna@in.ibm.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rwsem: Make rwsems use interrupt disabling spinlocks
Message-ID: <20050311102548.GA24545@elte.hu>
References: <1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com> <18744.1110364438@redhat.com> <20050309110404.GA4088@in.ibm.com> <1110366469.6280.84.camel@laptopd505.fenrus.org> <4175.1110370343@redhat.com> <1110395783.24286.207.camel@dyn318077bld.beaverton.ibm.com> <20050309114234.6598f486.akpm@osdl.org> <1110399036.6280.151.camel@laptopd505.fenrus.org> <20050311094024.GC19954@elte.hu> <20050311020717.46794d94.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311020717.46794d94.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> We should arrange for touch_softlockup_watchdog() to be called
> whenever touch_nmi_watchdog() is called.

the patch below adds a touch_softlockup_watchdog() call to every
touch_nmi_watchdog() call.

[A future consolidation patch should introduce a touch_watchdogs() call
that will do both a touch_nmi_watchdog() [if available on the platform]
and a touch_softlockup_watchdog() call.]

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/x86_64/kernel/nmi.c.orig
+++ linux/arch/x86_64/kernel/nmi.c
@@ -378,6 +378,11 @@ void touch_nmi_watchdog (void)
 	 */
 	for (i = 0; i < NR_CPUS; i++)
 		alert_counter[i] = 0;
+
+	/*
+	 * Tickle the softlockup detector too:
+	 */
+	touch_softlockup_watchdog();
 }
 
 void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason)
--- linux/arch/i386/kernel/nmi.c.orig
+++ linux/arch/i386/kernel/nmi.c
@@ -469,6 +469,11 @@ void touch_nmi_watchdog (void)
 	 */
 	for (i = 0; i < NR_CPUS; i++)
 		alert_counter[i] = 0;
+
+	/*
+	 * Tickle the softlockup detector too:
+	 */
+	touch_softlockup_watchdog();
 }
 
 extern void die_nmi(struct pt_regs *, const char *msg);
