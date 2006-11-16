Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424413AbWKPUQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424413AbWKPUQg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 15:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424404AbWKPUQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 15:16:36 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:5541 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1424413AbWKPUQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 15:16:35 -0500
Date: Thu, 16 Nov 2006 21:15:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@timesys.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061116201531.GA31469@elte.hu>
References: <1163707250.10333.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163707250.10333.24.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0006]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@timesys.com> wrote:

> [PATCH] cpufreq: make the transition_notifier chain use SRCU
> (b4dfdbb3c707474a2254c5b4d7e62be31a4b7da9)
> 
> breaks cpu frequency notification users, which register the callback 
> on core_init level. Interestingly enough the registration survives the 
> uninitialized head, but the registered user is lost by:

i have hit this bug in -rt (it caused a lockup) and have fixed it - 
forgot to send it upstream. Find the patch below.

	Ingo

---------------->
From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync

init_cpufreq_transition_notifier_list() should execute first, which is a 
core_initcall, so mark cpufreq_tsc() core_initcall_sync.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux.orig/arch/x86_64/kernel/tsc.c
+++ linux/arch/x86_64/kernel/tsc.c
@@ -138,7 +138,11 @@ static int __init cpufreq_tsc(void)
 	return 0;
 }
 
-core_initcall(cpufreq_tsc);
+/*
+ * init_cpufreq_transition_notifier_list() should execute first,
+ * which is a core_initcall, so mark this one core_initcall_sync:
+ */
+core_initcall_sync(cpufreq_tsc);
 
 #endif
 /*
