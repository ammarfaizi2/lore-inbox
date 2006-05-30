Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWE3MeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWE3MeA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWE3MeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:34:00 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:54704 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751477AbWE3Md7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:33:59 -0400
Date: Tue, 30 May 2006 14:34:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm1] lock validator: fix NMI-disabling on x86_64
Message-ID: <20060530123415.GA10344@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <20060530111138.GA5078@elte.hu> <1148990326.7599.4.camel@homer> <1148990725.8610.1.camel@homer> <20060530120641.GA8263@elte.hu> <1148991422.8610.8.camel@homer> <20060530121952.GA9625@elte.hu> <1148992098.8700.2.camel@homer> <20060530122950.GA10216@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530122950.GA10216@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


and NMI disabling wasnt perfect on x86_64 either. (we did it too late, 
which allowed a few NMI ticks to still occur.)

---------------
Subject: lock validator: fix NMI-disabling on x86_64
From: Ingo Molnar <mingo@elte.hu>

this does the NMI-watchdog disabling at the right place on x86_64.

should probably be folded into:
   
   lock-validator-disable-nmi-watchdog-if-config_lockdep.patch

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86_64/kernel/nmi.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

Index: linux/arch/x86_64/kernel/nmi.c
===================================================================
--- linux.orig/arch/x86_64/kernel/nmi.c
+++ linux/arch/x86_64/kernel/nmi.c
@@ -215,18 +215,6 @@ int __init check_nmi_watchdog (void)
 	int *counts;
 	int cpu;
 
-#ifdef CONFIG_LOCKDEP
-	/*
-	 * The NMI watchdog uses spinlocks (notifier chains, etc.),
-	 * so it's not lockdep-safe:
-	 */
-	nmi_watchdog = 0;
-	for_each_online_cpu(cpu)
-		per_cpu(nmi_watchdog_ctlblk.enabled, cpu) = 0;
-
-	printk("lockdep: disabled NMI watchdog.\n");
-	return 0;
-#endif
 	if ((nmi_watchdog == NMI_NONE) || (nmi_watchdog == NMI_DEFAULT))
 		return 0;
 
@@ -680,6 +668,17 @@ static void stop_intel_arch_watchdog(voi
 
 void setup_apic_nmi_watchdog(void *unused)
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
