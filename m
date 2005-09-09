Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbVIIH1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbVIIH1T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 03:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbVIIH1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 03:27:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42952 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751408AbVIIH1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 03:27:19 -0400
Date: Fri, 9 Sep 2005 00:26:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Alexander Nyberg <alexn@telia.com>
Subject: Re: [PATCH] i386 boottime for_each_cpu broken
Message-Id: <20050909002640.2b0f0d00.akpm@osdl.org>
In-Reply-To: <200509050815.j858FLxR027791@hera.kernel.org>
References: <200509050815.j858FLxR027791@hera.kernel.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:
>
> tree 090c471fdb44d8fe88c52e95be0e8e43e31fcd5a
> parent d7271b14b2e9e5905aba0fbf5c4dc4f8980c0cb2
> author Zwane Mwaikambo <zwane@arm.linux.org.uk> Sun, 04 Sep 2005 05:56:51 -0700
> committer Linus Torvalds <torvalds@evo.osdl.org> Mon, 05 Sep 2005 14:06:13 -0700
> 
> [PATCH] i386 boottime for_each_cpu broken
> 
> for_each_cpu walks through all processors in cpu_possible_map, which is
> defined as cpu_callout_map on i386 and isn't initialised until all
> processors have been booted. This breaks things which do for_each_cpu
> iterations early during boot. So, define cpu_possible_map as a bitmap with
> NR_CPUS bits populated. This was triggered by a patch i'm working on which
> does alloc_percpu before bringing up secondary processors.
> 
> From: Alexander Nyberg <alexn@telia.com>
> 
> i386-boottime-for_each_cpu-broken.patch
> i386-boottime-for_each_cpu-broken-fix.patch
> 
> The SMP version of __alloc_percpu checks the cpu_possible_map before
> allocating memory for a certain cpu.  With the above patches the BSP cpuid
> is never set in cpu_possible_map which breaks CONFIG_SMP on uniprocessor
> machines (as soon as someone tries to dereference something allocated via
> __alloc_percpu, which in fact is never allocated since the cpu is not set
> in cpu_possible_map).
> 

Kills my old 4-way Xeon.  cpu_possible_map has a value of 0x7 and
alloc_percpu() does bad things for the fourth CPU.


> diff --git a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
> --- a/arch/i386/kernel/mpparse.c
> +++ b/arch/i386/kernel/mpparse.c
> @@ -122,7 +122,7 @@ static int MP_valid_apicid(int apicid, i
>  
>  static void __init MP_processor_info (struct mpc_config_processor *m)
>  {
> - 	int ver, apicid;
> + 	int ver, apicid, cpu, found_bsp = 0;
>  	physid_mask_t tmp;
>   	
>  	if (!(m->mpc_cpuflag & CPU_ENABLED))
> @@ -181,6 +181,7 @@ static void __init MP_processor_info (st
>  	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
>  		Dprintk("    Bootup CPU\n");
>  		boot_cpu_physical_apicid = m->mpc_apicid;
> +		found_bsp = 1;
>  	}
>  
>  	if (num_processors >= NR_CPUS) {
> @@ -204,6 +205,11 @@ static void __init MP_processor_info (st
>  		return;
>  	}
>  
> +	if (found_bsp)
> +		cpu = 0;
> +	else
> +		cpu = num_processors - 1;
> +	cpu_set(cpu, cpu_possible_map);

Looky here:

akpm: found_bsp=0 cpu=0 tmp=0x0001 num_processors=1
akpm: found_bsp=0 cpu=1 tmp=0x0002 num_processors=2
akpm: found_bsp=0 cpu=2 tmp=0x0004 num_processors=3
akpm: found_bsp=1 cpu=0 tmp=0x0008 num_processors=4

On this machine, the BSP is the last one to pass through
MP_processor_info(), so the rude-looking assumption above screws things up.

I don't know what that found_bsp code is trying to do.  It wasn't
changelogged and it wasn't commented and removing it makes by box boot again.

What did I break?


diff -puN arch/i386/kernel/mpparse.c~a arch/i386/kernel/mpparse.c
--- devel/arch/i386/kernel/mpparse.c~a	2005-09-08 23:56:25.000000000 -0700
+++ devel-akpm/arch/i386/kernel/mpparse.c	2005-09-09 00:23:55.000000000 -0700
@@ -122,8 +122,8 @@ static int MP_valid_apicid(int apicid, i
 
 static void __init MP_processor_info (struct mpc_config_processor *m)
 {
- 	int ver, apicid, cpu, found_bsp = 0;
-	physid_mask_t tmp;
+ 	int ver, apicid;
+	physid_mask_t phys_cpu;
  	
 	if (!(m->mpc_cpuflag & CPU_ENABLED))
 		return;
@@ -181,7 +181,6 @@ static void __init MP_processor_info (st
 	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
 		Dprintk("    Bootup CPU\n");
 		boot_cpu_physical_apicid = m->mpc_apicid;
-		found_bsp = 1;
 	}
 
 	if (num_processors >= NR_CPUS) {
@@ -195,24 +194,19 @@ static void __init MP_processor_info (st
 			" Processor ignored.\n", maxcpus); 
 		return;
 	}
-	num_processors++;
 	ver = m->mpc_apicver;
 
 	if (!MP_valid_apicid(apicid, ver)) {
 		printk(KERN_WARNING "Processor #%d INVALID. (Max ID: %d).\n",
 			m->mpc_apicid, MAX_APICS);
-		--num_processors;
 		return;
 	}
 
-	if (found_bsp)
-		cpu = 0;
-	else
-		cpu = num_processors - 1;
-	cpu_set(cpu, cpu_possible_map);
-	tmp = apicid_to_cpu_present(apicid);
-	physids_or(phys_cpu_present_map, phys_cpu_present_map, tmp);
-	
+	cpu_set(num_processors, cpu_possible_map);
+	num_processors++;
+	phys_cpu = apicid_to_cpu_present(apicid);
+	physids_or(phys_cpu_present_map, phys_cpu_present_map, phys_cpu);
+
 	/*
 	 * Validate version
 	 */
_

