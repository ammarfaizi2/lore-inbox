Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbTGCKxS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 06:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTGCKxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 06:53:17 -0400
Received: from holomorphy.com ([66.224.33.161]:46269 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265089AbTGCKxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 06:53:01 -0400
Date: Thu, 3 Jul 2003 04:07:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 (p4-clockmod does not compile)
Message-ID: <20030703110713.GN26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <1057229141.1479.16.camel@LNX.iNES.RO>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057229141.1479.16.camel@LNX.iNES.RO>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 01:45:41PM +0300, Dumitru Ciobarcianu wrote:
> Here are the errors:
>   CC      arch/i386/kernel/cpu/cpufreq/p4-clockmod.o
> arch/i386/kernel/cpu/cpufreq/p4-clockmod.c: In function `cpufreq_p4_setdc':
> arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:67: error: incompatible types in assignment
> arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:78: error: incompatible type for argument 2 of `set_cpus_allowed'
> arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:90: error: incompatible type for argument 2 of `set_cpus_allowed'
> arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:131: error: incompatible type for argument 2 of `set_cpus_allowed'
> make[3]: *** [arch/i386/kernel/cpu/cpufreq/p4-clockmod.o] Error 1
> make[2]: *** [arch/i386/kernel/cpu/cpufreq] Error 2
> make[1]: *** [arch/i386/kernel/cpu] Error 2
> make: *** [arch/i386/kernel] Error 2

Would something like this help?

-- wli

===== arch/i386/kernel/cpu/cpufreq/p4-clockmod.c 1.16 vs edited =====
--- 1.16/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Mon May 12 21:23:13 2003
+++ edited/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Thu Jul  3 04:07:01 2003
@@ -53,10 +53,9 @@
 static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
 {
 	u32 l, h;
-	unsigned long cpus_allowed;
+	cpumask_t cpus_allowed, affected_cpu_map;
 	struct cpufreq_freqs freqs;
 	int hyperthreading = 0;
-	int affected_cpu_map = 0;
 	int sibling = 0;
 
 	if (!cpu_online(cpu) || (newstate > DC_DISABLE) || 
@@ -67,16 +66,17 @@
 	cpus_allowed = current->cpus_allowed;
 
 	/* only run on CPU to be set, or on its sibling */
-	affected_cpu_map = 1 << cpu;
+	affected_cpu_map = cpumask_of_cpu(cpu);
 #ifdef CONFIG_X86_HT
 	hyperthreading = ((cpu_has_ht) && (smp_num_siblings == 2));
 	if (hyperthreading) {
 		sibling = cpu_sibling_map[cpu];
-		affected_cpu_map |= (1 << sibling);
+		cpu_set(sibling, affected_cpu_map);
 	}
 #endif
 	set_cpus_allowed(current, affected_cpu_map);
 	BUG_ON(!(affected_cpu_map & (1 << smp_processor_id())));
+	BUG_ON(!cpu_isset(smp_processor_id(), affected_cpu_map));
 
 	/* get current state */
 	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
