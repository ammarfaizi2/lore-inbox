Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424454AbWKPUmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424454AbWKPUmx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 15:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424462AbWKPUmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 15:42:53 -0500
Received: from mail.timesys.com ([65.117.135.102]:13806 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP
	id S1424454AbWKPUmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 15:42:53 -0500
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
In-Reply-To: <20061116201531.GA31469@elte.hu>
References: <1163707250.10333.24.camel@localhost.localdomain>
	 <20061116201531.GA31469@elte.hu>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 21:45:36 +0100
Message-Id: <1163709936.10333.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-16 at 21:15 +0100, Ingo Molnar wrote:
> From: Ingo Molnar <mingo@elte.hu>
> Subject: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
> 
> init_cpufreq_transition_notifier_list() should execute first, which is a 
> core_initcall, so mark cpufreq_tsc() core_initcall_sync.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> --- linux.orig/arch/x86_64/kernel/tsc.c
> +++ linux/arch/x86_64/kernel/tsc.c
> @@ -138,7 +138,11 @@ static int __init cpufreq_tsc(void)
>  	return 0;
>  }

Here is the i386/sparc fixup

--------------->

From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch] cpufreq: register notifiers after the head init

init_cpufreq_transition_notifier_list() must execute first, which is a
core_initcall, so move the registration to core_initcall_sync.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
index fbc9582..4ebd903 100644
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -315,7 +315,7 @@ static int __init cpufreq_tsc(void)
 	return ret;
 }
 
-core_initcall(cpufreq_tsc);
+core_initcall_sync(cpufreq_tsc);
 
 #endif
 
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index 061e1b1..c6eadcc 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -973,6 +973,13 @@ static struct notifier_block sparc64_cpu
 	.notifier_call	= sparc64_cpufreq_notifier
 };
 
+static int __init sparc64_cpu_freq_init(void)
+{
+	return cpufreq_register_notifier(&sparc64_cpufreq_notifier_block,
+					 CPUFREQ_TRANSITION_NOTIFIER);
+}
+core_initcall_sync(sparc64_cpu_freq_init);
+
 #endif /* CONFIG_CPU_FREQ */
 
 static struct time_interpolator sparc64_cpu_interpolator = {
@@ -999,10 +1006,6 @@ void __init time_init(void)
 		(((NSEC_PER_SEC << SPARC64_NSEC_PER_CYC_SHIFT) +
 		  (clock / 2)) / clock);
 
-#ifdef CONFIG_CPU_FREQ
-	cpufreq_register_notifier(&sparc64_cpufreq_notifier_block,
-				  CPUFREQ_TRANSITION_NOTIFIER);
-#endif
 }
 
 unsigned long long sched_clock(void)


