Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbTGCLD2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 07:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbTGCLD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 07:03:28 -0400
Received: from MailBox.iNES.RO ([80.86.96.21]:42418 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id S265043AbTGCLD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 07:03:26 -0400
Subject: Re: 2.5.74-mm1 (p4-clockmod does not compile)
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <20030703110713.GN26348@holomorphy.com>
References: <20030703023714.55d13934.akpm@osdl.org>
	 <1057229141.1479.16.camel@LNX.iNES.RO>
	 <20030703110713.GN26348@holomorphy.com>
Content-Type: text/plain
Organization: iNES Group SRL
Message-Id: <1057231068.1479.18.camel@LNX.iNES.RO>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-3) 
Date: 03 Jul 2003 14:17:48 +0300
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (MailBox.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had to mannually change the file (the patch was giving rejects), but
it compiles now.

Thanks

//Cioby



On Thu, 2003-07-03 at 14:07, William Lee Irwin III wrote:
> On Thu, Jul 03, 2003 at 01:45:41PM +0300, Dumitru Ciobarcianu wrote:
> > Here are the errors:
> >   CC      arch/i386/kernel/cpu/cpufreq/p4-clockmod.o
> > arch/i386/kernel/cpu/cpufreq/p4-clockmod.c: In function `cpufreq_p4_setdc':
> > arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:67: error: incompatible types in assignment
> > arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:78: error: incompatible type for argument 2 of `set_cpus_allowed'
> > arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:90: error: incompatible type for argument 2 of `set_cpus_allowed'
> > arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:131: error: incompatible type for argument 2 of `set_cpus_allowed'
> > make[3]: *** [arch/i386/kernel/cpu/cpufreq/p4-clockmod.o] Error 1
> > make[2]: *** [arch/i386/kernel/cpu/cpufreq] Error 2
> > make[1]: *** [arch/i386/kernel/cpu] Error 2
> > make: *** [arch/i386/kernel] Error 2
> 
> Would something like this help?
> 
> -- wli
> 
> ===== arch/i386/kernel/cpu/cpufreq/p4-clockmod.c 1.16 vs edited =====
> --- 1.16/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Mon May 12 21:23:13 2003
> +++ edited/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Thu Jul  3 04:07:01 2003
> @@ -53,10 +53,9 @@
>  static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
>  {
>  	u32 l, h;
> -	unsigned long cpus_allowed;
> +	cpumask_t cpus_allowed, affected_cpu_map;
>  	struct cpufreq_freqs freqs;
>  	int hyperthreading = 0;
> -	int affected_cpu_map = 0;
>  	int sibling = 0;
>  
>  	if (!cpu_online(cpu) || (newstate > DC_DISABLE) || 
> @@ -67,16 +66,17 @@
>  	cpus_allowed = current->cpus_allowed;
>  
>  	/* only run on CPU to be set, or on its sibling */
> -	affected_cpu_map = 1 << cpu;
> +	affected_cpu_map = cpumask_of_cpu(cpu);
>  #ifdef CONFIG_X86_HT
>  	hyperthreading = ((cpu_has_ht) && (smp_num_siblings == 2));
>  	if (hyperthreading) {
>  		sibling = cpu_sibling_map[cpu];
> -		affected_cpu_map |= (1 << sibling);
> +		cpu_set(sibling, affected_cpu_map);
>  	}
>  #endif
>  	set_cpus_allowed(current, affected_cpu_map);
>  	BUG_ON(!(affected_cpu_map & (1 << smp_processor_id())));
> +	BUG_ON(!cpu_isset(smp_processor_id(), affected_cpu_map));
>  
>  	/* get current state */
>  	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
-- 
Cioby

