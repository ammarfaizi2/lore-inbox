Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWDFQ50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWDFQ50 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 12:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWDFQ50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 12:57:26 -0400
Received: from mailserv.trstone.com ([12.109.59.11]:44742 "EHLO
	mailserv.trstone.com") by vger.kernel.org with ESMTP
	id S932201AbWDFQ5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 12:57:25 -0400
Message-ID: <44354866.3030200@rosettastone.com>
Date: Thu, 06 Apr 2006 17:57:10 +0100
From: Brian Uhrain <buhrain@rosettastone.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060302)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: rth@twiddle.net, Alan Cox <alan@redhat.com>
Subject: [PATCH] Small fixes for Alpha architecture
Content-Type: multipart/mixed;
 boundary="------------040408010107000403060708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040408010107000403060708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've encountered two problems with 2.6.16 and newer kernels on my API 
CS20 (dual 833MHz Alpha 21264b processors).  The first is the kernel 
OOPSing because of a NULL pointer dereference while trying to populate 
SysFS with the CPU information.  The other is that only one processor 
was being brought up.  I've included a small Alpha-specific patch that 
fixes both problems.

The first problem was caused by the CPUs never being properly registered 
using register_cpu(), the way it's done on other architectures.  I've 
added an arch_initcall called alpha_init that is modelled after the 
ppc_init arch_initcall.

The second problem has to do with the removal of hwrpb_cpu_present_mask 
in arch/alpha/kernel/smp.c.  In setup_smp() in the 2.6.15 kernel 
sources, hwrpb_cpu_present_mask has a bit set for each processor that is 
probed, and afterwards cpu_present_mask is set to the cpumask for the 
boot CPU.  In the same function of the same file in the 2.6.16 sources, 
instead of hwrpb_cpu_present_mask being set, cpu_possible_map is updated 
for each probed CPU.  cpu_present_mask is still set to the cpumask of 
the boot CPU afterwards.  The problem lies in include/asm-alpha/smp.h, 
where cpu_possible_map is #define'd to be cpu_present_mask.  My patch 
just replaces the #define with an actual cpumask_t declaration for 
cpu_possible_map since it is used separately from cpu_present_mask in 
the Alpha SMP code.

Regards,
Brian Uhrain

--------------040408010107000403060708
Content-Type: text/plain;
 name="alpha-fixes-2.6.16.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alpha-fixes-2.6.16.diff"

diff -rudp linux-2.6.16/arch/alpha/kernel/setup.c linux-2.6.16.new/arch/alpha/kernel/setup.c
--- linux-2.6.16/arch/alpha/kernel/setup.c	2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16.new/arch/alpha/kernel/setup.c	2006-04-06 17:45:04.009752787 +0100
@@ -24,6 +24,7 @@
 #include <linux/config.h>	/* CONFIG_ALPHA_LCA etc */
 #include <linux/mc146818rtc.h>
 #include <linux/console.h>
+#include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/string.h>
@@ -477,6 +478,22 @@ page_is_ram(unsigned long pfn)
 #undef PFN_PHYS
 #undef PFN_MAX
 
+static struct cpu cpu_devices[NR_CPUS];
+
+int __init alpha_init(void)
+{
+	int i;
+
+	/* register CPU devices */
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i))
+			register_cpu(&cpu_devices[i], i, NULL);
+
+	return 0;
+}
+
+arch_initcall(alpha_init);
+
 void __init
 setup_arch(char **cmdline_p)
 {
diff -rudp linux-2.6.16/arch/alpha/kernel/smp.c linux-2.6.16.new/arch/alpha/kernel/smp.c
--- linux-2.6.16/arch/alpha/kernel/smp.c	2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16.new/arch/alpha/kernel/smp.c	2006-04-06 17:45:08.810533978 +0100
@@ -69,6 +69,7 @@ static int smp_secondary_alive __initdat
 
 /* Which cpus ids came online.  */
 cpumask_t cpu_present_mask;
+cpumask_t cpu_possible_map;
 cpumask_t cpu_online_map;
 
 EXPORT_SYMBOL(cpu_online_map);
diff -rudp linux-2.6.16/include/asm-alpha/smp.h linux-2.6.16.new/include/asm-alpha/smp.h
--- linux-2.6.16/include/asm-alpha/smp.h	2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16.new/include/asm-alpha/smp.h	2006-04-06 17:45:08.812487103 +0100
@@ -46,9 +46,9 @@ extern struct cpuinfo_alpha cpu_data[NR_
 #define raw_smp_processor_id()	(current_thread_info()->cpu)
 
 extern cpumask_t cpu_present_mask;
+extern cpumask_t cpu_possible_map;
 extern cpumask_t cpu_online_map;
 extern int smp_num_cpus;
-#define cpu_possible_map	cpu_present_mask
 
 int smp_call_function_on_cpu(void (*func) (void *info), void *info,int retry, int wait, cpumask_t cpu);
 

--------------040408010107000403060708--
