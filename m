Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268303AbUHKWut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268303AbUHKWut (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268302AbUHKWt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:49:27 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:12274 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268292AbUHKWoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:44:34 -0400
Date: Wed, 11 Aug 2004 15:44:30 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com
Subject: [PATCH 2/3] [i386] Transition /proc/cpuinfo -> sysfs
Message-ID: <20040811224430.GB7095@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040811224117.GA6450@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811224117.GA6450@plexity.net>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ughh..found a bug already. Should check register_cpu() return value b4 
calling create_sysfs_cpu_entries().

diff -Nru a/arch/i386/kernel/cpu/Makefile b/arch/i386/kernel/cpu/Makefile
--- a/arch/i386/kernel/cpu/Makefile	Wed Aug 11 14:46:15 2004
+++ b/arch/i386/kernel/cpu/Makefile	Wed Aug 11 14:46:15 2004
@@ -2,7 +2,7 @@
 # Makefile for x86-compatible CPU details and quirks
 #
 
-obj-y	:=	common.o proc.o
+obj-y	:=	common.o proc.o sysfs.o
 
 obj-y	+=	amd.o
 obj-y	+=	cyrix.o
diff -Nru a/arch/i386/kernel/cpu/proc.c b/arch/i386/kernel/cpu/proc.c
--- a/arch/i386/kernel/cpu/proc.c	Wed Aug 11 14:46:15 2004
+++ b/arch/i386/kernel/cpu/proc.c	Wed Aug 11 14:46:15 2004
@@ -9,55 +9,10 @@
  */
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
-	/* 
-	 * These flag bits must match the definitions in <asm/cpufeature.h>.
-	 * NULL means this bit is undefined or reserved; either way it doesn't
-	 * have meaning as far as Linux is concerned.  Note that it's important
-	 * to realize there is a difference between this table and CPUID -- if
-	 * applications want to get the raw CPUID data, they should access
-	 * /dev/cpu/<cpu_nr>/cpuid instead.
-	 */
-	static char *x86_cap_flags[] = {
-		/* Intel-defined */
-	        "fpu", "vme", "de", "pse", "tsc", "msr", "pae", "mce",
-	        "cx8", "apic", NULL, "sep", "mtrr", "pge", "mca", "cmov",
-	        "pat", "pse36", "pn", "clflush", NULL, "dts", "acpi", "mmx",
-	        "fxsr", "sse", "sse2", "ss", "ht", "tm", "ia64", "pbe",
-
-		/* AMD-defined */
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, "syscall", NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, "mp", "nx", NULL, "mmxext", NULL,
-		NULL, NULL, NULL, NULL, NULL, "lm", "3dnowext", "3dnow",
-
-		/* Transmeta-defined */
-		"recovery", "longrun", NULL, "lrti", NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-
-		/* Other (Linux-defined) */
-		"cxmmx", "k6_mtrr", "cyrix_arr", "centaur_mcr",
-		NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-
-		/* Intel-defined (#2) */
-		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "tm2",
-		"est", NULL, "cid", NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-
-		/* VIA/Cyrix/Centaur-defined */
-		NULL, NULL, "rng", "rng_en", NULL, NULL, "ace", "ace_en",
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-	};
 	struct cpuinfo_x86 *c = v;
 	int i, n = c - cpu_data;
 	int fpu_exception;
+	extern char *x86_cap_flags[];
 
 #ifdef CONFIG_SMP
 	if (!cpu_online(n))
diff -Nru a/arch/i386/kernel/cpu/sysfs.c b/arch/i386/kernel/cpu/sysfs.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/cpu/sysfs.c	Wed Aug 11 14:46:15 2004
@@ -0,0 +1,234 @@
+/*
+ * arch/i386/cpu/sysfs.c
+ *
+ * Export x86 CPU attributes to sysfs tree
+ *
+ * Author: Deepak Saxena <dsaxena@plexity.net>
+ *
+ * Copyright 2004 (c) MontaVista Software, Inc. 
+ * 
+ * This file is licensed under  the terms of the GNU General Public 
+ * License version 2. This program is licensed "as is" without any 
+ * warranty of any kind, whether express or implied.
+ *
+ *************************************************************************
+ *
+ * TODO/Questions: 
+ *   - Have link b/w HT siblings?
+ *   - Come up with generic, cross-arch set of attributes?
+ *   - Export features as 1|0 instead of "yes"|"no"?
+ *   - Export cpuid instead of "flags" attribute
+ *
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/cpu.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+
+#include <asm/cpu.h>
+#include <asm/processor.h>
+
+/* 
+ * These flag bits must match the definitions in <asm/cpufeature.h>.
+ * NULL means this bit is undefined or reserved; either way it doesn't
+ * have meaning as far as Linux is concerned.  Note that it's important
+ * to realize there is a difference between this table and CPUID -- if
+ * applications want to get the raw CPUID data, they should access
+ * /dev/cpu/<cpu_nr>/cpuid instead.
+ *
+ * TODO: Make this static when /proc/cpuinfo dies
+ */
+char *x86_cap_flags[] = {
+	/* Intel-defined */
+        "fpu", "vme", "de", "pse", "tsc", "msr", "pae", "mce",
+        "cx8", "apic", NULL, "sep", "mtrr", "pge", "mca", "cmov",
+        "pat", "pse36", "pn", "clflush", NULL, "dts", "acpi", "mmx",
+        "fxsr", "sse", "sse2", "ss", "ht", "tm", "ia64", "pbe",
+
+	/* AMD-defined */
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, "syscall", NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, "mp", "nx", NULL, "mmxext", NULL,
+	NULL, NULL, NULL, NULL, NULL, "lm", "3dnowext", "3dnow",
+
+	/* Transmeta-defined */
+	"recovery", "longrun", NULL, "lrti", NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+
+	/* Other (Linux-defined) */
+	"cxmmx", "k6_mtrr", "cyrix_arr", "centaur_mcr",
+	NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+
+	/* Intel-defined (#2) */
+	"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "tm2",
+	"est", NULL, "cid", NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+
+	/* VIA/Cyrix/Centaur-defined */
+	NULL, NULL, "rng", "rng_en", NULL, NULL, "ace", "ace_en",
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+};
+
+/*
+ * We may be building w/o sysfs support, but we still need 
+ * to include this file so the above table can be used by the
+ * /procf/cpuinfo code. This goes away when we kill /proc/cpuinfo
+ */
+#ifdef CONFIG_SYSFS
+
+/*
+ * Helper function for simple attribute definitions.
+ */
+#define	X86_CPU_ATTR(_attr, _data, _format)				\
+static ssize_t show_##_attr(struct sys_device *dev, char *buf)		\
+{									\
+	struct cpu *cpu = 						\
+		(struct cpu*)container_of(dev, struct cpu, sysdev);	\
+	struct cpuinfo_x86 *c = 					\
+			(struct cpuinfo_x86*)cpu->arch_cpuinfo; 	\
+									\
+	return sprintf(buf, _format, _data);				\
+}									\
+SYSDEV_ATTR(_attr, 0644, show_##_attr, NULL);
+
+X86_CPU_ATTR(family, c->x86, "%d\n");
+X86_CPU_ATTR(model, c->x86_model, "%d\n");
+X86_CPU_ATTR(cpuid_level, c->cpuid_level, "%d\n");
+X86_CPU_ATTR(fdiv_bug, (c->fdiv_bug ? "yes" : "no"), "%s\n");
+X86_CPU_ATTR(coma_bug, (c->coma_bug ? "yes" : "no"), "%s\n");
+X86_CPU_ATTR(f00f_bug, (c->f00f_bug ? "yes" : "no"), "%s\n");
+X86_CPU_ATTR(fpu, (c->hard_math ? "yes" : "no"), "%s\n");
+X86_CPU_ATTR(wp, (c->wp_works_ok ? "yes" : "no"), "%s\n");
+X86_CPU_ATTR(hlt_bug, (c->hlt_works_ok ? "no" : "yes"), "%s\n");
+
+X86_CPU_ATTR(cache_size, (c->x86_cache_size), "%d KB\n");
+
+X86_CPU_ATTR(fpu_exception, 
+		c->hard_math && (ignore_fpu_irq || cpu_has_fpu), 
+		"%d\n");
+
+X86_CPU_ATTR(vendor_id, 
+		(c->x86_vendor_id[0] ? c->x86_vendor_id : "unknown"),
+		"%s\n");
+
+X86_CPU_ATTR(model_id, 
+		(c->x86_model_id[0] ? c->x86_model_id : "unknown"),
+		"%s\n");
+
+static ssize_t show_stepping(struct sys_device *dev, char *buf)
+{
+	struct cpu *cpu = (struct cpu *)container_of(dev, struct cpu, sysdev);
+	struct cpuinfo_x86  *c = (struct cpuinfo_x86 *)cpu->arch_cpuinfo;
+
+	if (c->x86_mask || c->cpuid_level >= 0)
+		return sprintf(buf, "%d\n", c->x86_mask);
+	else
+		return sprintf(buf, "unknown\n");
+}
+SYSDEV_ATTR(stepping, 0644, show_stepping, NULL);
+
+static ssize_t show_mhz(struct sys_device *dev, char *buf)
+{
+	struct cpu *cpu = (struct cpu *)container_of(dev, struct cpu, sysdev);
+	struct cpuinfo_x86  *c = (struct cpuinfo_x86 *)cpu->arch_cpuinfo;
+
+	if ( cpu_has(c, X86_FEATURE_TSC) ) {
+		return sprintf(buf, "%lu.%03lu\n", 
+			cpu_khz / 1000, (cpu_khz % 1000));
+	} else {
+		return sprintf(buf, "unknown\n");
+	}
+}
+SYSDEV_ATTR(mhz, 0644, show_mhz, NULL);
+
+static ssize_t show_bogomips(struct sys_device *dev, char *buf)
+{
+	struct cpu *cpu = (struct cpu *)container_of(dev, struct cpu, sysdev);
+	struct cpuinfo_x86 *c = (struct cpuinfo_x86 *)cpu->arch_cpuinfo;
+
+	return sprintf(buf, "%lu.%02lu\n",
+			c->loops_per_jiffy/(500000/HZ),
+			(c->loops_per_jiffy/(5000/HZ)) % 100);
+}
+SYSDEV_ATTR(bogomips, 0644, show_bogomips, NULL);
+
+static ssize_t show_flags(struct sys_device *dev, char *buf)
+{
+	struct cpu *cpu = (struct cpu *)container_of(dev, struct cpu, sysdev);
+	struct cpuinfo_x86 *c = (struct cpuinfo_x86 *)cpu->arch_cpuinfo;
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < 32*NCAPINTS; i++)
+		if (test_bit(i, c->x86_capability) && x86_cap_flags[i] != NULL)
+			ret += sprintf(buf + ret, "%s ", x86_cap_flags[i]);
+
+	ret += sprintf(buf, "\n");
+
+	return ret;
+}
+SYSDEV_ATTR(flags, 0644, show_flags, NULL);
+
+#ifdef CONFIG_X86_HT
+ssize_t show_physical_id(struct sys_device *dev, char *buf)
+{
+	struct cpu *cpu = (struct cpu *)container_of(dev, struct cpu, sysdev);
+	struct cpuinfo_x86 *c = (struct cpuinfo_x86 *)cpu->arch_cpuinfo;
+	extern int phys_proc_id[NR_CPUS];
+	int n = c - cpu_data;
+
+	return sprintf(buf, "%d\n", phys_proc_id[n]);
+}
+SYSDEV_ATTR(physical_id, 0644, show_physical_id, NULL);
+
+X86_CPU_ATTR(siblings, smp_num_siblings, "%d\n");
+#endif	/* CONFIG_X86_HT */
+
+static struct attribute *x86_cpu_attrs[] = {
+	&attr_family.attr,
+	&attr_model.attr,
+	&attr_cpuid_level.attr,
+	&attr_fdiv_bug.attr,
+	&attr_coma_bug.attr,
+	&attr_f00f_bug.attr,
+	&attr_fpu.attr,
+	&attr_wp.attr,
+	&attr_hlt_bug.attr,
+	&attr_cache_size.attr,
+	&attr_mhz.attr,
+	&attr_vendor_id.attr,
+	&attr_model_id.attr,
+	&attr_stepping.attr,
+	&attr_bogomips.attr,
+	&attr_flags.attr,
+	&attr_fpu_exception.attr,
+};
+
+static struct attribute_group x86_cpu_group = {
+	.attrs	= x86_cpu_attrs
+};
+
+void create_sysfs_cpu_entries(struct cpu *cpu)
+{
+	struct sys_device *dev = &cpu->sysdev;
+
+	sysfs_create_group(&dev->kobj, &x86_cpu_group);
+
+#ifdef	CONFIG_X86_HT
+	if (cpu_has_ht) {
+		sysdev_create_file(dev, &attr_physical_id);
+		sysdev_create_file(dev, &attr_siblings);
+	}
+#endif
+}
+#endif	/* CONFIG_SYSFS */
diff -Nru a/include/asm-i386/cpu.h b/include/asm-i386/cpu.h
--- a/include/asm-i386/cpu.h	Wed Aug 11 14:46:15 2004
+++ b/include/asm-i386/cpu.h	Wed Aug 11 14:46:15 2004
@@ -12,9 +12,11 @@
 };
 extern struct i386_cpu cpu_devices[NR_CPUS];
 
+extern void create_sysfs_cpu_entries(struct cpu*);
 
 static inline int arch_register_cpu(int num){
 	struct node *parent = NULL;
+	int ret;
 	
 #ifdef CONFIG_NUMA
 	int node = cpu_to_node(num);
@@ -22,7 +24,13 @@
 		parent = &node_devices[node].node;
 #endif /* CONFIG_NUMA */
 
-	return register_cpu(&cpu_devices[num].cpu, num, parent);
+	cpu_devices[num].cpu.arch_cpuinfo = &cpu_data[num];
+
+	ret = register_cpu(&cpu_devices[num].cpu, num, parent);
+
+	create_sysfs_cpu_entries(&cpu_devices[num].cpu);
+
+	return ret;
 }
 
 #endif /* _ASM_I386_CPU_H_ */

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
