Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWCVGsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWCVGsS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWCVGsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:48:01 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:42625 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750876AbWCVGhg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:37:36 -0500
Message-Id: <20060322063751.151430000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:30:54 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 14/35] subarch modify CPU capabilities
Content-Disposition: inline; filename=13-i386-cpu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow subarchitectures to modify CPU capabilities during bootstrap CPU
identification. Add a subarch implementation for Xen which hides
features unsupported by the hypervisor.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/cpu/common.c               |    3 +++
 include/asm-i386/mach-default/mach_cpu.h    |    5 +++++
 include/asm-i386/mach-xen/mach_cpu.h        |    2 ++
 include/asm-i386/mach-xen/setup_arch_post.h |   15 +++++++++++++++
 include/asm-i386/mach-xen/setup_arch_pre.h  |    1 +
 5 files changed, 26 insertions(+)

--- xen-subarch-2.6.orig/arch/i386/kernel/cpu/common.c
+++ xen-subarch-2.6/arch/i386/kernel/cpu/common.c
@@ -16,6 +16,7 @@
 #include <asm/apic.h>
 #include <mach_apic.h>
 #endif
+#include <mach_cpu.h>
 
 #include "cpu.h"
 
@@ -420,6 +421,8 @@ void __devinit identify_cpu(struct cpuin
 				c->x86_vendor, c->x86_model);
 	}
 
+	machine_specific_modify_cpu_capabilities(c);
+
 	/* Now the feature flags better reflect actual CPU features! */
 
 	printk(KERN_DEBUG "CPU: After all inits, caps:");
--- xen-subarch-2.6.orig/include/asm-i386/mach-xen/setup_arch_post.h
+++ xen-subarch-2.6/include/asm-i386/mach-xen/setup_arch_post.h
@@ -18,6 +18,19 @@ static char * __init machine_specific_me
 	return "Xen";
 }
 
+void __devinit machine_specific_modify_cpu_capabilities(struct cpuinfo_x86 *c)
+{
+	clear_bit(X86_FEATURE_VME, c->x86_capability);
+	clear_bit(X86_FEATURE_DE, c->x86_capability);
+	clear_bit(X86_FEATURE_PSE, c->x86_capability);
+	clear_bit(X86_FEATURE_PGE, c->x86_capability);
+	clear_bit(X86_FEATURE_SEP, c->x86_capability);
+	clear_bit(X86_FEATURE_MWAIT, c->x86_capability);
+	if (!(xen_start_info->flags & SIF_PRIVILEGED))
+		clear_bit(X86_FEATURE_MTRR, c->x86_capability);
+	c->hlt_works_ok = 0;
+}
+
 static void __init machine_specific_arch_setup(void)
 {
 	struct physdev_op op;
@@ -30,6 +43,8 @@ static void __init machine_specific_arch
 	    __KERNEL_CS, (unsigned long)hypervisor_callback,
 	    __KERNEL_CS, (unsigned long)failsafe_callback);
 
+	machine_specific_modify_cpu_capabilities(&boot_cpu_data);
+
 	init_pg_tables_end = __pa(xen_start_info->pt_base) +
 		PFN_PHYS(xen_start_info->nr_pt_frames);
 
--- xen-subarch-2.6.orig/include/asm-i386/mach-xen/setup_arch_pre.h
+++ xen-subarch-2.6/include/asm-i386/mach-xen/setup_arch_pre.h
@@ -1,6 +1,7 @@
 
 #include <xen/interface/xen.h>
 #include <asm/hypervisor.h>
+#include <mach_cpu.h>
 
 struct start_info *xen_start_info;
 EXPORT_SYMBOL(xen_start_info);
--- /dev/null
+++ xen-subarch-2.6/include/asm-i386/mach-default/mach_cpu.h
@@ -0,0 +1,5 @@
+
+static inline void
+machine_specific_modify_cpu_capabilities(struct cpuinfo_x86 *c)
+{
+}
--- /dev/null
+++ xen-subarch-2.6/include/asm-i386/mach-xen/mach_cpu.h
@@ -0,0 +1,2 @@
+
+extern void machine_specific_modify_cpu_capabilities(struct cpuinfo_x86 *);

--
