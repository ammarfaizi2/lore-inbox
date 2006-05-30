Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWE3M3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWE3M3b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWE3M3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:29:30 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:53426 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751472AbWE3M32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:29:28 -0400
Date: Tue, 30 May 2006 14:29:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm1] lock validator: disable NMI watchdog if CONFIG_LOCKDEP, i386
Message-ID: <20060530122950.GA10216@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <20060530111138.GA5078@elte.hu> <1148990326.7599.4.camel@homer> <1148990725.8610.1.camel@homer> <20060530120641.GA8263@elte.hu> <1148991422.8610.8.camel@homer> <20060530121952.GA9625@elte.hu> <1148992098.8700.2.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148992098.8700.2.camel@homer>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> > > BUG: warning at kernel/lockdep.c:2398/check_flags()
> > 
> > this one could be related to NMI. We are already disabling NMI on 
> > x86_64, but i thought i had it fixed up for i386 - apparently not.
> 
> Booted with nmi_watchdog=0, no warning and no deadlock.

ok, great. The patch below turns off NMI on i386 automatically.

-------------------
Subject: lock validator: disable NMI watchdog if CONFIG_LOCKDEP, i386
From: Ingo Molnar <mingo@elte.hu>

The NMI watchdog uses spinlocks (notifier chains, etc.),
so it's not lockdep-safe at the moment.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/kernel/nmi.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -741,6 +741,17 @@ static void stop_intel_arch_watchdog(voi
 
 void setup_apic_nmi_watchdog (void *unused)
 {
+#ifdef CONFIG_LOCKDEP
+	/*
+	 * The NMI watchdog uses spinlocks (notifier chains, etc.),
+	 * so it's not lockdep-safe:
+	 */
+	nmi_watchdog = NMI_NONE;
+	printk("lockdep: disabled NMI watchdog.\n");
+
+	return;
+#endif
+
 	/* only support LOCAL and IO APICs for now */
 	if ((nmi_watchdog != NMI_LOCAL_APIC) &&
 	    (nmi_watchdog != NMI_IO_APIC))
