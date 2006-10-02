Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWJBJCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWJBJCv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 05:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWJBJCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 05:02:50 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:20360 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750816AbWJBJCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 05:02:49 -0400
Date: Mon, 2 Oct 2006 10:54:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch] dynticks: core, NMI watchdog fix, #2
Message-ID: <20061002085453.GA6403@elte.hu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de> <20061001225724.985115000@cruncher.tec.linutronix.de> <20061002064127.GA20841@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002064127.GA20841@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, there's one more fallout of the dyntick queue: the fix below 
goes after (or into) dynticks-core-nmi-watchdog-fix.patch. The bug only 
affected NO_HZ kernels.

	Ingo

----------------->
Subject: dynticks: core, NMI watchdog fix, #2
From: Ingo Molnar <mingo@elte.hu>

a partial fix of the NMI watchdog bug sneaked into yesterday night's
queue - this patch removes that extra in_interrupt() condition.

(One effect of this bug is a 'slow' serial console on NO_HZ, because we 
never update jiffies and the serial console's timeouts get confused by 
it.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/softirq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/kernel/softirq.c
===================================================================
--- linux.orig/kernel/softirq.c
+++ linux/kernel/softirq.c
@@ -280,7 +280,7 @@ void irq_enter(void)
 {
 	__irq_enter();
 #ifdef CONFIG_NO_HZ
-	if (idle_cpu(smp_processor_id()) && !in_interrupt())
+	if (idle_cpu(smp_processor_id()))
 		hrtimer_update_jiffies();
 #endif
 }
