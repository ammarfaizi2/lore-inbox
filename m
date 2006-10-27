Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946145AbWJ0Dnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946145AbWJ0Dnp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 23:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946149AbWJ0Dnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 23:43:45 -0400
Received: from ozlabs.org ([203.10.76.45]:44204 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1946145AbWJ0Dno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 23:43:44 -0400
Subject: [PATCH 2/4] Prep for paravirt: cpu_detect extraction
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
In-Reply-To: <1161920535.17807.33.camel@localhost.localdomain>
References: <1161920325.17807.29.camel@localhost.localdomain>
	 <1161920535.17807.33.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 13:43:41 +1000
Message-Id: <1161920622.17807.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both lhype and Xen want to call the core of the x86 cpu detect code
before calling start_kernel.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (extracted from larger patch)

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal tmp1/arch/i386/kernel/cpu/common.c tmp2/arch/i386/kernel/cpu/common.c
--- tmp1/arch/i386/kernel/cpu/common.c	2006-10-27 13:16:53.000000000 +1000
+++ tmp2/arch/i386/kernel/cpu/common.c	2006-10-27 13:34:36.000000000 +1000
@@ -236,29 +236,14 @@ static int __cpuinit have_cpuid_p(void)
 	return flag_is_changeable_p(X86_EFLAGS_ID);
 }
 
-/* Do minimum CPU detection early.
-   Fields really needed: vendor, cpuid_level, family, model, mask, cache alignment.
-   The others are not touched to avoid unwanted side effects.
-
-   WARNING: this function is only called on the BP.  Don't add code here
-   that is supposed to run on all CPUs. */
-static void __init early_cpu_detect(void)
+void __init cpu_detect(struct cpuinfo_x86 *c)
 {
-	struct cpuinfo_x86 *c = &boot_cpu_data;
-
-	c->x86_cache_alignment = 32;
-
-	if (!have_cpuid_p())
-		return;
-
 	/* Get vendor name */
 	cpuid(0x00000000, &c->cpuid_level,
 	      (int *)&c->x86_vendor_id[0],
 	      (int *)&c->x86_vendor_id[8],
 	      (int *)&c->x86_vendor_id[4]);
 
-	get_cpu_vendor(c, 1);
-
 	c->x86 = 4;
 	if (c->cpuid_level >= 0x00000001) {
 		u32 junk, tfms, cap0, misc;
@@ -275,6 +260,26 @@ static void __init early_cpu_detect(void
 	}
 }
 
+/* Do minimum CPU detection early.
+   Fields really needed: vendor, cpuid_level, family, model, mask, cache alignment.
+   The others are not touched to avoid unwanted side effects.
+
+   WARNING: this function is only called on the BP.  Don't add code here
+   that is supposed to run on all CPUs. */
+static void __init early_cpu_detect(void)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+
+	c->x86_cache_alignment = 32;
+
+	if (!have_cpuid_p())
+		return;
+
+	cpu_detect(c);
+
+	get_cpu_vendor(c, 1);
+}
+
 static void __cpuinit generic_identify(struct cpuinfo_x86 * c)
 {
 	u32 tfms, xlvl;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal tmp1/include/asm-i386/processor.h tmp2/include/asm-i386/processor.h
--- tmp1/include/asm-i386/processor.h	2006-10-27 13:17:22.000000000 +1000
+++ tmp2/include/asm-i386/processor.h	2006-10-27 13:34:36.000000000 +1000
@@ -20,6 +20,7 @@
 #include <linux/threads.h>
 #include <asm/percpu.h>
 #include <linux/cpumask.h>
+#include <linux/init.h>
 
 /* flag for disabling the tsc */
 extern int tsc_disable;
@@ -111,6 +112,8 @@ extern struct cpuinfo_x86 cpu_data[];
 extern	int cpu_llc_id[NR_CPUS];
 extern char ignore_fpu_irq;
 
+void __init cpu_detect(struct cpuinfo_x86 *c);
+
 extern void identify_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal tmp1/include/linux/start_kernel.h tmp2/include/linux/start_kernel.h
--- tmp1/include/linux/start_kernel.h	1970-01-01 10:00:00.000000000 +1000
+++ tmp2/include/linux/start_kernel.h	2006-10-27 13:34:36.000000000 +1000
@@ -0,0 +1,12 @@
+#ifndef _LINUX_START_KERNEL_H
+#define _LINUX_START_KERNEL_H
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+/* Define the prototype for start_kernel here, rather than cluttering
+   up something else. */
+
+extern asmlinkage void __init start_kernel(void);
+
+#endif /* _LINUX_START_KERNEL_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal tmp1/init/main.c tmp2/init/main.c
--- tmp1/init/main.c	2006-10-27 13:17:26.000000000 +1000
+++ tmp2/init/main.c	2006-10-27 13:35:08.000000000 +1000
@@ -51,6 +51,7 @@
 #include <linux/debug_locks.h>
 #include <linux/lockdep.h>
 #include <linux/pid_namespace.h>
+#include <linux/start_kernel.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>


