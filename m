Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268329AbUHKXcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268329AbUHKXcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268327AbUHKXHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:07:03 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:51337 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268293AbUHKWrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:47:19 -0400
Date: Wed, 11 Aug 2004 15:47:12 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com, rmk@arm.linux.org.uk
Subject: [PATCH 3/3] [ARM] Transition /proc/cpuinfo -> sysfs
Message-ID: <20040811224712.GC7095@plexity.net>
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


Russell, 

Please comment. I've moved some bits to being detected at boot time
and stuffed into a structure b/c it makes the sysfs code cleaner.
We can just have a macro handling most cases now since the values
stored as int or char* in the cpuinfo structure.

~Deepak

diff -Nru a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
--- a/arch/arm/kernel/setup.c	Wed Aug 11 14:46:15 2004
+++ b/arch/arm/kernel/setup.c	Wed Aug 11 14:46:15 2004
@@ -27,6 +27,7 @@
 #include <asm/elf.h>
 #include <asm/hardware.h>
 #include <asm/io.h>
+#include <asm/cpuinfo.h>
 #include <asm/procinfo.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -53,6 +54,13 @@
 __setup("fpe=", fpe_setup);
 #endif
 
+static struct arm_cpuinfo cpuinfo;
+static struct cpu cpu[1] = {
+	{
+		.arch_cpuinfo = &cpuinfo
+	}
+};
+
 extern unsigned int mem_fclk_21285;
 extern void paging_init(struct meminfo *, struct machine_desc *desc);
 extern void convert_to_tag_list(struct tag *tags);
@@ -219,6 +227,18 @@
 #define CACHE_M(y)	((y) & (1 << 2))
 #define CACHE_LINE(y)	((y) & 3)
 
+static const char *hwcap_str[] = {
+	"swp",
+	"half",
+	"thumb",
+	"26bit",
+	"fastmult",
+	"fpa",
+	"vfp",
+	"edsp",
+	NULL
+};
+
 static inline void dump_cache(const char *prefix, unsigned int cache)
 {
 	unsigned int mult = 2 + (CACHE_M(cache) ? 1 : 0);
@@ -264,10 +284,23 @@
 	return cpu_arch;
 }
 
+#define get_cache_info(_size, _assoc, _line_size, _sets, cache)		\
+do {									\
+	unsigned int mult = 2 + (CACHE_M(cache) ? 1 : 0);		\
+									\
+	cpuinfo._size = mult << (8 + CACHE_SIZE(cache));		\
+	cpuinfo._assoc = (mult << CACHE_ASSOC(cache)) >> 1;		\
+	cpuinfo._line_size =  8 << CACHE_LINE(cache);			\
+	cpuinfo._sets =  						\
+		1 << (6 + CACHE_SIZE(cache) - CACHE_ASSOC(cache) -	\
+			    CACHE_LINE(cache));				\
+} while(0);
+
 static void __init setup_processor(void)
 {
 	extern struct proc_info_list __proc_info_begin, __proc_info_end;
 	struct proc_info_list *list;
+	int cache_info;
 
 	/*
 	 * locate processor in the list of supported processor
@@ -314,6 +347,48 @@
 	elf_hwcap = list->elf_hwcap;
 
 	cpu_proc_init();
+
+	cpuinfo.model = cpu_name;
+	cpuinfo.revision = (int)processor_id & 15;
+	cpuinfo.elf_platform = elf_platform;
+	cpuinfo.vendor = processor_id >> 24;
+	cpuinfo.architecture = proc_arch[cpu_architecture()];
+
+	if ((processor_id & 0x0000f000) == 0x00000000) {
+		cpuinfo.part = processor_id >> 4;
+		cpuinfo.variant = 0xfffffff;
+	} else {
+		if ((processor_id & 0x0000f000) == 0x00007000) {
+			/* ARM7 */
+			cpuinfo.variant = (processor_id >> 16) & 127;
+		} else {
+			/* post-ARM7 */
+			cpuinfo.variant = (processor_id >> 20) & 15;
+		}
+		cpuinfo.part = (processor_id >> 4) & 0xfff;
+	}
+
+	cache_info = read_cpuid(CPUID_CACHETYPE);
+	if (cache_info != processor_id) {
+		cpuinfo.cache_type = cache_types[CACHE_TYPE(cache_info)];
+		cpuinfo.cache_clean = cache_clean[CACHE_TYPE(cache_info)],
+		cpuinfo.cache_lockdown = cache_lockdown[CACHE_TYPE(cache_info)];
+		cpuinfo.cache_format = 
+			CACHE_S(cache_info) ? "Harvard" : "Unified";
+
+		if (CACHE_S(cache_info)) {
+			get_cache_info(icache_size, icache_assoc, 
+					icache_line_size, icache_sets, 
+					CACHE_ISIZE(cache_info));
+			get_cache_info(dcache_size, dcache_assoc, 
+					dcache_line_size, dcache_sets, 
+					CACHE_DSIZE(cache_info));
+		} else {
+			get_cache_info(cache_size, cache_assoc, 
+					cache_line_size, cache_sets, 
+					CACHE_ISIZE(cache_info));
+		}
+	}
 }
 
 static struct machine_desc * __init setup_machine(unsigned int nr)
@@ -740,49 +815,189 @@
 #endif
 }
 
-static struct cpu cpu[1];
 
-static int __init topology_init(void)
+/*
+ * We currently can only have 1 CPU on ARM, so we theoretically
+ * don't need to touch the incoming dev and can just dereference
+ * the global cpuinfo; however, doing it right in the first place
+ * will make life easier down the road.
+ */
+#define ARM_CPU_ATTR(_field, _format)					\
+static ssize_t show_##_field(struct sys_device*dev, char *buf)		\
+{									\
+	struct cpu *cpu = 						\
+		(struct cpu*)container_of(dev, struct cpu, sysdev);	\
+	struct arm_cpuinfo *cpuinfo = 					\
+				(struct arm_cpuinfo*)cpu->arch_cpuinfo; \
+									\
+	return sprintf(buf, _format, cpuinfo->_field);			\
+}									\
+SYSDEV_ATTR(_field, 0644, show_##_field, NULL);
+
+
+ARM_CPU_ATTR(model, "%s\n");
+ARM_CPU_ATTR(part, "%07x\n");
+ARM_CPU_ATTR(variant, "%x\n");
+ARM_CPU_ATTR(revision, "%d\n");
+ARM_CPU_ATTR(elf_platform, "%s\n");
+ARM_CPU_ATTR(vendor, "%#02x\n");
+ARM_CPU_ATTR(architecture, "ARMv%s\n");
+
+ARM_CPU_ATTR(cache_type, "%s\n");
+ARM_CPU_ATTR(cache_clean, "%s\n");
+ARM_CPU_ATTR(cache_lockdown, "%s\n");
+ARM_CPU_ATTR(cache_format, "%s\n");
+
+/*
+ * Unified cache attributes
+ */
+ARM_CPU_ATTR(cache_size, "%d\n");
+ARM_CPU_ATTR(cache_assoc, "%d\n");
+ARM_CPU_ATTR(cache_line_size, "%d\n");
+ARM_CPU_ATTR(cache_sets, "%d\n");
+
+/*
+ * Harvard cache attributes
+ */
+ARM_CPU_ATTR(icache_size, "%d\n");
+ARM_CPU_ATTR(icache_assoc, "%d\n");
+ARM_CPU_ATTR(icache_line_size, "%d\n");
+ARM_CPU_ATTR(icache_sets, "%d\n");
+ARM_CPU_ATTR(dcache_size, "%d\n");
+ARM_CPU_ATTR(dcache_assoc, "%d\n");
+ARM_CPU_ATTR(dcache_line_size, "%d\n");
+ARM_CPU_ATTR(dcache_sets, "%d\n");
+
+static ssize_t show_bogomips(struct sys_device *dev, char *buf)
 {
-	return register_cpu(cpu, 0, NULL);
+	return sprintf(buf, "%lu.%02lu\n",
+		   loops_per_jiffy / (500000/HZ),
+		   (loops_per_jiffy / (5000/HZ)) % 100);
 }
+static SYSDEV_ATTR(bogomips, 0644, show_bogomips, NULL);
 
-subsys_initcall(topology_init);
+/*
+ * TODO: Should we have one file per feature with just a 1 or 0 to
+ * let userspace know specific feature exists?
+ */
+static ssize_t show_features(struct sys_device *dev, char *buf)
+{
+	ssize_t ret;
+	int i;
 
-static const char *hwcap_str[] = {
-	"swp",
-	"half",
-	"thumb",
-	"26bit",
-	"fastmult",
-	"fpa",
-	"vfp",
-	"edsp",
-	NULL
+	ret = 0;
+	for (i = 0; hwcap_str[i]; i++)
+		if (elf_hwcap & (1 << i))
+			ret += sprintf(buf + ret, "%s ", hwcap_str[i]);
+
+	ret += sprintf(buf + ret, "\n");
+
+	return ret;
+}
+static SYSDEV_ATTR(features, 0644, show_features, NULL);
+
+static ssize_t show_hardware(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf, "%s\n", machine_name);
+}
+static SYSDEV_ATTR(hardware, 0644, show_hardware, NULL);
+
+static ssize_t show_hardware_rev(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf, "%04x\n", system_rev);
+}
+static SYSDEV_ATTR(hardware_rev, 0644, show_hardware_rev, NULL);
+
+static ssize_t show_hardware_serial(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf, "%08x%08x\n", system_serial_high, system_serial_low);
+}
+static SYSDEV_ATTR(hardware_serial, 0644, show_hardware_serial, NULL);
+
+static struct attribute *standard_attrs[] = {
+	&attr_bogomips.attr,
+	&attr_features.attr,
+	&attr_model.attr,
+	&attr_part.attr,
+	&attr_variant.attr,
+	&attr_elf_platform.attr,
+	&attr_vendor.attr,
+	&attr_revision.attr,
+	&attr_architecture.attr,
+	&attr_cache_type.attr,
+	&attr_cache_clean.attr,
+	&attr_cache_lockdown.attr,
+	&attr_cache_format.attr,
+	&attr_hardware.attr,
+	&attr_hardware_rev.attr,
+	&attr_hardware_serial.attr
+};
+
+static struct attribute_group standard_group = {
+	.attrs = standard_attrs
 };
 
-static void
-c_show_cache(struct seq_file *m, const char *type, unsigned int cache)
+static struct attribute *unified_cache_attrs[] = {
+	&attr_cache_size.attr,
+	&attr_cache_assoc.attr,
+	&attr_cache_line_size.attr,
+	&attr_cache_sets.attr
+};
+
+static struct attribute_group unified_cache_group = {
+	.attrs = unified_cache_attrs
+};
+
+static struct attribute *harvard_cache_attrs[] = {
+	&attr_icache_size.attr,
+	&attr_icache_assoc.attr,
+	&attr_icache_line_size.attr,
+	&attr_icache_sets.attr,
+	&attr_dcache_size.attr,
+	&attr_dcache_assoc.attr,
+	&attr_dcache_line_size.attr,
+	&attr_dcache_sets.attr
+};
+
+static struct attribute_group harvard_cache_group = {
+	.attrs = harvard_cache_attrs
+};
+
+/*
+ * Register cpu with sysfs and fill in CPU attributes
+ */
+static int __init topology_init(void)
 {
-	unsigned int mult = 2 + (CACHE_M(cache) ? 1 : 0);
+	int ret;
+	struct sys_device *dev = &cpu->sysdev;
+	int cache_info;
+
+	ret = register_cpu(cpu, 0, NULL);
+	if (ret) return ret;
+
+	sysfs_create_group(&dev->kobj, &standard_group);
+
+	cache_info = read_cpuid(CPUID_CACHETYPE);
+	if (cache_info != processor_id) {
+		if (CACHE_S(cache_info)) {
+			sysfs_create_group(&dev->kobj, &harvard_cache_group);
+		} else {
+			sysfs_create_group(&dev->kobj, &unified_cache_group);
+		}
+	}	
 
-	seq_printf(m, "%s size\t\t: %d\n"
-		      "%s assoc\t\t: %d\n"
-		      "%s line length\t: %d\n"
-		      "%s sets\t\t: %d\n",
-		type, mult << (8 + CACHE_SIZE(cache)),
-		type, (mult << CACHE_ASSOC(cache)) >> 1,
-		type, 8 << CACHE_LINE(cache),
-		type, 1 << (6 + CACHE_SIZE(cache) - CACHE_ASSOC(cache) -
-			    CACHE_LINE(cache)));
+	return 0;
 }
 
+subsys_initcall(topology_init);
+
 static int c_show(struct seq_file *m, void *v)
 {
 	int i;
+	int cache_info;
 
 	seq_printf(m, "Processor\t: %s rev %d (%s)\n",
-		   cpu_name, (int)processor_id & 15, elf_platform);
+			cpuinfo.model, cpuinfo.revision, cpuinfo.elf_platform);
 
 	seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
 		   loops_per_jiffy / (500000/HZ),
@@ -795,45 +1010,47 @@
 		if (elf_hwcap & (1 << i))
 			seq_printf(m, "%s ", hwcap_str[i]);
 
-	seq_printf(m, "\nCPU implementer\t: 0x%02x\n", processor_id >> 24);
-	seq_printf(m, "CPU architecture: %s\n", proc_arch[cpu_architecture()]);
+	seq_printf(m, "\nCPU implementer\t: 0x%02x\n", cpuinfo.vendor);
+	seq_printf(m, "CPU architecture: %s\n", cpuinfo.architecture);
 
-	if ((processor_id & 0x0000f000) == 0x00000000) {
-		/* pre-ARM7 */
-		seq_printf(m, "CPU part\t\t: %07x\n", processor_id >> 4);
-	} else {
-		if ((processor_id & 0x0000f000) == 0x00007000) {
-			/* ARM7 */
-			seq_printf(m, "CPU variant\t: 0x%02x\n",
-				   (processor_id >> 16) & 127);
-		} else {
-			/* post-ARM7 */
-			seq_printf(m, "CPU variant\t: 0x%x\n",
-				   (processor_id >> 20) & 15);
-		}
-		seq_printf(m, "CPU part\t: 0x%03x\n",
-			   (processor_id >> 4) & 0xfff);
+	seq_printf(m, "CPU part\t\t: %07x\n", cpuinfo.part);
+	if ((processor_id & 0x0000f000) != 0x00000000) {
+		seq_printf(m, "CPU variant\t: 0x%x\n", cpuinfo.variant);
 	}
 	seq_printf(m, "CPU revision\t: %d\n", processor_id & 15);
 
-	{
-		unsigned int cache_info = read_cpuid(CPUID_CACHETYPE);
-		if (cache_info != processor_id) {
-			seq_printf(m, "Cache type\t: %s\n"
-				      "Cache clean\t: %s\n"
-				      "Cache lockdown\t: %s\n"
-				      "Cache format\t: %s\n",
-				   cache_types[CACHE_TYPE(cache_info)],
-				   cache_clean[CACHE_TYPE(cache_info)],
-				   cache_lockdown[CACHE_TYPE(cache_info)],
-				   CACHE_S(cache_info) ? "Harvard" : "Unified");
-
-			if (CACHE_S(cache_info)) {
-				c_show_cache(m, "I", CACHE_ISIZE(cache_info));
-				c_show_cache(m, "D", CACHE_DSIZE(cache_info));
-			} else {
-				c_show_cache(m, "Cache", CACHE_ISIZE(cache_info));
-			}
+	cache_info = read_cpuid(CPUID_CACHETYPE);
+	if (cache_info != processor_id) {
+		seq_printf(m, "Cache type\t: %s\n"
+			      "Cache clean\t: %s\n"
+			      "Cache lockdown\t: %s\n"
+			      "Cache format\t: %s\n",
+			   cpuinfo.cache_type, cpuinfo.cache_clean,
+			   cpuinfo.cache_lockdown, cpuinfo.cache_format);
+
+		if (CACHE_S(cache_info)) {
+			seq_printf(m, "I size\t\t: %d\n", cpuinfo.icache_size);
+			seq_printf(m, "I assoc\t\t: %d\n", 
+					cpuinfo.icache_assoc);
+			seq_printf(m, "I line length\t: %d\n", 
+					cpuinfo.icache_line_size);
+			seq_printf(m, "I sets\t\t: %d\n", cpuinfo.icache_sets);
+
+			seq_printf(m, "D size\t\t: %d\n", cpuinfo.dcache_size);
+			seq_printf(m, "D assoc\t\t: %d\n", 
+					cpuinfo.dcache_assoc);
+			seq_printf(m, "D line length\t: %d\n", 
+					cpuinfo.dcache_line_size);
+			seq_printf(m, "D sets\t\t: %d\n", cpuinfo.dcache_sets);
+		} else {
+			seq_printf(m, "Cache size\t\t: %d\n", 
+					cpuinfo.icache_size);
+			seq_printf(m, "Cache assoc\t\t: %d\n", 
+					cpuinfo.icache_assoc);
+			seq_printf(m, "Cache line length\t: %d\n", 
+					cpuinfo.icache_line_size);
+			seq_printf(m, "Cache sets\t\t: %d", 
+					cpuinfo.icache_sets);
 		}
 	}
 
@@ -868,3 +1085,4 @@
 	.stop	= c_stop,
 	.show	= c_show
 };
+
diff -Nru a/include/asm-arm/cpuinfo.h b/include/asm-arm/cpuinfo.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-arm/cpuinfo.h	Wed Aug 11 14:46:15 2004
@@ -0,0 +1,51 @@
+/*
+ * include/asm-arm/cpuinfo.h
+ *
+ * per-cpu information used for sysfs
+ *
+ * Author: Deepak Saxena <dsaxena@plexity.net>
+ *
+ * Copyright 2004 (c) MontaVista Software, Inc. 
+ * 
+ * This file is licensed under  the terms of the GNU General Public 
+ * License version 2. This program is licensed "as is" without any 
+ * warranty of any kind, whether express or implied.
+ */
+
+
+#ifndef __ASM_CPUINFO_H__
+#define __ASM_CPUINFO_H__
+
+
+struct arm_cpuinfo {
+	const char *model;
+	unsigned long part;
+	unsigned long variant;
+	const char *elf_platform;
+	unsigned char vendor;
+	unsigned short revision;
+	const char *architecture;
+
+	const char *cache_type;
+	const char *cache_clean;
+	const char *cache_lockdown;
+	const char *cache_format;
+
+	unsigned int cache_size;
+	unsigned int cache_assoc;
+	unsigned int cache_line_size;
+	unsigned int cache_sets;	
+
+	unsigned int icache_size;
+	unsigned int icache_assoc;
+	unsigned int icache_line_size;
+	unsigned int icache_sets;	
+
+	unsigned int dcache_size;
+	unsigned int dcache_assoc;
+	unsigned int dcache_line_size;
+	unsigned int dcache_sets;	
+};
+
+#endif	/* __ASM_CPUINFO_H__ */
+

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
