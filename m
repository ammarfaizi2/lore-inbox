Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbWDMXMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWDMXMP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWDMXLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:11:04 -0400
Received: from mail.suse.de ([195.135.220.2]:6854 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965012AbWDMXKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:10:11 -0400
Date: Thu, 13 Apr 2006 16:08:53 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, buhrain@rosettastone.com,
       ink@jurassic.park.msu.ru, Richard Henderson <rth@twiddle.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 15/22] alpha: SMP boot fixes
Message-ID: <20060413230853.GP5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="alpha-smp-boot-fixes.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Brian Uhrain <buhrain@rosettastone.com> says:

I've encountered two problems with 2.6.16 and newer kernels on my API CS20
(dual 833MHz Alpha 21264b processors).  The first is the kernel OOPSing
because of a NULL pointer dereference while trying to populate SysFS with the
CPU information.  The other is that only one processor was being brought up. 
I've included a small Alpha-specific patch that fixes both problems.

The first problem was caused by the CPUs never being properly registered using
register_cpu(), the way it's done on other architectures.

The second problem has to do with the removal of hwrpb_cpu_present_mask in
arch/alpha/kernel/smp.c.  In setup_smp() in the 2.6.15 kernel sources,
hwrpb_cpu_present_mask has a bit set for each processor that is probed, and
afterwards cpu_present_mask is set to the cpumask for the boot CPU.  In the
same function of the same file in the 2.6.16 sources, instead of
hwrpb_cpu_present_mask being set, cpu_possible_map is updated for each probed
CPU.  cpu_present_mask is still set to the cpumask of the boot CPU afterwards.
 The problem lies in include/asm-alpha/smp.h, where cpu_possible_map is
#define'd to be cpu_present_mask.

Cleanups from: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

 - cpu_present_mask and cpu_possible_map are essentially the same thing
   on alpha, as it doesn't support CPU hotplug;
 - allocate "struct cpu" only for present CPUs, like sparc64 does.
   Static array of "struct cpu" is just a waste of memory.

Signed-off-by: Brian Uhrain <buhrain@rosettastone.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/alpha/kernel/setup.c |   17 +++++++++++++++++
 arch/alpha/kernel/smp.c   |    8 +++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

--- linux-2.6.16.5.orig/arch/alpha/kernel/setup.c
+++ linux-2.6.16.5/arch/alpha/kernel/setup.c
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
 
+static int __init
+register_cpus(void)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		struct cpu *p = kzalloc(sizeof(*p), GFP_KERNEL);
+		if (!p)
+			return -ENOMEM;
+		register_cpu(p, i, NULL);
+	}
+	return 0;
+}
+
+arch_initcall(register_cpus);
+
 void __init
 setup_arch(char **cmdline_p)
 {
--- linux-2.6.16.5.orig/arch/alpha/kernel/smp.c
+++ linux-2.6.16.5/arch/alpha/kernel/smp.c
@@ -439,7 +439,7 @@ setup_smp(void)
 			if ((cpu->flags & 0x1cc) == 0x1cc) {
 				smp_num_probed++;
 				/* Assume here that "whami" == index */
-				cpu_set(i, cpu_possible_map);
+				cpu_set(i, cpu_present_mask);
 				cpu->pal_revision = boot_cpu_palrev;
 			}
 
@@ -450,9 +450,8 @@ setup_smp(void)
 		}
 	} else {
 		smp_num_probed = 1;
-		cpu_set(boot_cpuid, cpu_possible_map);
+		cpu_set(boot_cpuid, cpu_present_mask);
 	}
-	cpu_present_mask = cpumask_of_cpu(boot_cpuid);
 
 	printk(KERN_INFO "SMP: %d CPUs probed -- cpu_present_mask = %lx\n",
 	       smp_num_probed, cpu_possible_map.bits[0]);
@@ -488,9 +487,8 @@ void __devinit
 smp_prepare_boot_cpu(void)
 {
 	/*
-	 * Mark the boot cpu (current cpu) as both present and online
+	 * Mark the boot cpu (current cpu) as online
 	 */ 
-	cpu_set(smp_processor_id(), cpu_present_mask);
 	cpu_set(smp_processor_id(), cpu_online_map);
 }
 

--
