Return-Path: <linux-kernel-owner+w=401wt.eu-S1751400AbXAFOjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbXAFOjM (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 09:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbXAFOjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 09:39:12 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:59977 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbXAFOjL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 09:39:11 -0500
Message-ID: <20070106093907.pu7mzlzeo0c4ck8s@imap.linux.ibm.com>
Date: Sat,  6 Jan 2007 09:39:07 -0500
From: Gautham R Shenoy <ego@in.ibm.com>
To: akpm@osdl.org
Cc: vgoyal@in.ibm.com, vatsa@in.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Change cpu_up and co from __devinit to __cpuinit
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) H3 (4.1.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling the kernel with CONFIG_HOTPLUG = y and CONFIG_HOTPLUG_CPU = n
with CONFIG_RELOCATABLE = y generates the following modpost warnings

WARNING: vmlinux - Section mismatch: reference to .init.data: from
.text between '_cpu_up' (at offset 0xc0141b7d) and 'cpu_up'
WARNING: vmlinux - Section mismatch: reference to .init.data: from
.text between '_cpu_up' (at offset 0xc0141b9c) and 'cpu_up'
WARNING: vmlinux - Section mismatch: reference to .init.text:__cpu_up
from .text between '_cpu_up' (at offset 0xc0141bd8) and 'cpu_up'
WARNING: vmlinux - Section mismatch: reference to .init.data: from
.text between '_cpu_up' (at offset 0xc0141c05) and 'cpu_up'
WARNING: vmlinux - Section mismatch: reference to .init.data: from
.text between '_cpu_up' (at offset 0xc0141c26) and 'cpu_up'
WARNING: vmlinux - Section mismatch: reference to .init.data: from
.text between '_cpu_up' (at offset 0xc0141c37) and 'cpu_up'

This is because cpu_up, _cpu_up and __cpu_up (in some architectures) are
defined as __devinit
AND
__cpu_up calls some __cpuinit functions.

Since __cpuinit would map to __init with this kind of a configuration,
we get a .text refering .init.data warning.

This patch solves the problem by converting all of __cpu_up, _cpu_up
and cpu_up from __devinit to __cpuinit. The approach is justified since
the callers of cpu_up are either dependent on CONFIG_HOTPLUG_CPU or
are of __init type.

Thus when CONFIG_HOTPLUG_CPU=y, all these cpu up functions would land up
in .text section, and when CONFIG_HOTPLUG_CPU=n, all these functions would
land up in .init section.

Tested on a i386 SMP machine running linux-2.6.20-rc3-mm1.

Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>
Cc: Vivek Goyal <vgoyal@in.ibm.com>
-- 
   arch/cris/arch-v32/kernel/smp.c |    2 +-
   arch/m32r/kernel/smpboot.c      |    2 +-
   arch/mips/kernel/smp.c          |    2 +-
   arch/parisc/kernel/smp.c        |    2 +-
   arch/powerpc/kernel/smp.c       |    2 +-
   arch/sparc64/kernel/smp.c       |    2 +-
   kernel/cpu.c                    |    4 ++--
   7 files changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6.20-rc3/kernel/cpu.c
===================================================================
--- linux-2.6.20-rc3.orig/kernel/cpu.c
+++ linux-2.6.20-rc3/kernel/cpu.c
@@ -210,7 +210,7 @@ int cpu_down(unsigned int cpu)
   #endif /*CONFIG_HOTPLUG_CPU*/

   /* Requires cpu_add_remove_lock to be held */
-static int __devinit _cpu_up(unsigned int cpu)
+static int __cpuinit _cpu_up(unsigned int cpu)
   {
   	int ret, nr_calls = 0;
   	void *hcpu = (void *)(long)cpu;
@@ -248,7 +248,7 @@ out_notify:
   	return ret;
   }

-int __devinit cpu_up(unsigned int cpu)
+int __cpuinit cpu_up(unsigned int cpu)
   {
   	int err = 0;

Index: linux-2.6.20-rc3/arch/cris/arch-v32/kernel/smp.c
===================================================================
--- linux-2.6.20-rc3.orig/arch/cris/arch-v32/kernel/smp.c
+++ linux-2.6.20-rc3/arch/cris/arch-v32/kernel/smp.c
@@ -195,7 +195,7 @@ int setup_profiling_timer(unsigned int m
    */
   unsigned long cache_decay_ticks = 1;

-int __devinit __cpu_up(unsigned int cpu)
+int __cpuinit __cpu_up(unsigned int cpu)
   {
   	smp_boot_one_cpu(cpu);
   	return cpu_online(cpu) ? 0 : -ENOSYS;
Index: linux-2.6.20-rc3/arch/powerpc/kernel/smp.c
===================================================================
--- linux-2.6.20-rc3.orig/arch/powerpc/kernel/smp.c
+++ linux-2.6.20-rc3/arch/powerpc/kernel/smp.c
@@ -468,7 +468,7 @@ static int __devinit cpu_enable(unsigned
   	return -ENOSYS;
   }

-int __devinit __cpu_up(unsigned int cpu)
+int __cpuinit __cpu_up(unsigned int cpu)
   {
   	int c;

Index: linux-2.6.20-rc3/arch/m32r/kernel/smpboot.c
===================================================================
--- linux-2.6.20-rc3.orig/arch/m32r/kernel/smpboot.c
+++ linux-2.6.20-rc3/arch/m32r/kernel/smpboot.c
@@ -351,7 +351,7 @@ static void __init do_boot_cpu(int phys_
   	}
   }

-int __devinit __cpu_up(unsigned int cpu_id)
+int __cpuinit __cpu_up(unsigned int cpu_id)
   {
   	int timeout;

Index: linux-2.6.20-rc3/arch/mips/kernel/smp.c
===================================================================
--- linux-2.6.20-rc3.orig/arch/mips/kernel/smp.c
+++ linux-2.6.20-rc3/arch/mips/kernel/smp.c
@@ -271,7 +271,7 @@ void __devinit smp_prepare_boot_cpu(void
    * and keep control until "cpu_online(cpu)" is set.  Note: cpu is
    * physical, not logical.
    */
-int __devinit __cpu_up(unsigned int cpu)
+int __cpuinit __cpu_up(unsigned int cpu)
   {
   	struct task_struct *idle;

Index: linux-2.6.20-rc3/arch/parisc/kernel/smp.c
===================================================================
--- linux-2.6.20-rc3.orig/arch/parisc/kernel/smp.c
+++ linux-2.6.20-rc3/arch/parisc/kernel/smp.c
@@ -608,7 +608,7 @@ void smp_cpus_done(unsigned int cpu_max)
   }


-int __devinit __cpu_up(unsigned int cpu)
+int __cpuinit __cpu_up(unsigned int cpu)
   {
   	if (cpu != 0 && cpu < parisc_max_cpus)
   		smp_boot_one_cpu(cpu);
Index: linux-2.6.20-rc3/arch/sparc64/kernel/smp.c
===================================================================
--- linux-2.6.20-rc3.orig/arch/sparc64/kernel/smp.c
+++ linux-2.6.20-rc3/arch/sparc64/kernel/smp.c
@@ -1388,7 +1388,7 @@ void __devinit smp_prepare_boot_cpu(void
   {
   }

-int __devinit __cpu_up(unsigned int cpu)
+int __cpuinit __cpu_up(unsigned int cpu)
   {
   	int ret = smp_boot_one_cpu(cpu);



