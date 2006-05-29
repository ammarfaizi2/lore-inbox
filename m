Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWE2VfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWE2VfA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWE2V0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:26:01 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:50872 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751352AbWE2VZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:25:29 -0400
Date: Mon, 29 May 2006 23:25:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 33/61] lock validator: disable NMI watchdog if CONFIG_LOCKDEP
Message-ID: <20060529212550.GG3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
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

From: Ingo Molnar <mingo@elte.hu>

The NMI watchdog uses spinlocks (notifier chains, etc.),
so it's not lockdep-safe at the moment.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86_64/kernel/nmi.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux/arch/x86_64/kernel/nmi.c
===================================================================
--- linux.orig/arch/x86_64/kernel/nmi.c
+++ linux/arch/x86_64/kernel/nmi.c
@@ -205,6 +205,18 @@ int __init check_nmi_watchdog (void)
 	int *counts;
 	int cpu;
 
+#ifdef CONFIG_LOCKDEP
+	/*
+	 * The NMI watchdog uses spinlocks (notifier chains, etc.),
+	 * so it's not lockdep-safe:
+	 */
+	nmi_watchdog = 0;
+	for_each_online_cpu(cpu)
+		per_cpu(nmi_watchdog_ctlblk.enabled, cpu) = 0;
+
+	printk("lockdep: disabled NMI watchdog.\n");
+	return 0;
+#endif
 	if ((nmi_watchdog == NMI_NONE) || (nmi_watchdog == NMI_DEFAULT))
 		return 0;
 
