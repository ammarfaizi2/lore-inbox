Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262765AbSI1J2J>; Sat, 28 Sep 2002 05:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262761AbSI1J10>; Sat, 28 Sep 2002 05:27:26 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:29066 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262760AbSI1J04>; Sat, 28 Sep 2002 05:26:56 -0400
Date: Sat, 28 Sep 2002 11:23:15 +0200
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, cpufreq@www.linux.org.uk
Subject: [2.5.39] (2/5) CPUfreq i386 core
Message-ID: <20020928112315.C1217@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CPUFreq i386 core for 2.5.39:
arch/i386/kernel/i386_ksyms.c	export cpu_khz
arch/i386/kernel/time.c		update various i386 values on frequency
				changes
include/asm-i386/msr.h		add Transmeta MSR defines


diff -ruN linux-2539original/arch/i386/kernel/i386_ksyms.c linux/arch/i386/kernel/i386_ksyms.c
--- linux-2539original/arch/i386/kernel/i386_ksyms.c	Sun Sep 22 09:00:00 2002
+++ linux/arch/i386/kernel/i386_ksyms.c	Sat Sep 28 09:30:00 2002
@@ -50,6 +50,7 @@
 EXPORT_SYMBOL(drive_info);
 #endif
 
+extern unsigned long cpu_khz;
 extern unsigned long get_cmos_time(void);
 
 /* platform dependent support */
@@ -80,6 +81,7 @@
 EXPORT_SYMBOL(pm_idle);
 EXPORT_SYMBOL(pm_power_off);
 EXPORT_SYMBOL(get_cmos_time);
+EXPORT_SYMBOL(cpu_khz);
 EXPORT_SYMBOL(apm_info);
 
 #ifdef CONFIG_DEBUG_IOVIRT
diff -ruN linux-2539original/arch/i386/kernel/time.c linux/arch/i386/kernel/time.c
--- linux-2539original/arch/i386/kernel/time.c	Sun Sep 22 09:00:00 2002
+++ linux/arch/i386/kernel/time.c	Sat Sep 28 09:30:00 2002
@@ -43,6 +43,7 @@
 #include <linux/smp.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/cpufreq.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -603,6 +604,52 @@
 
 device_initcall(time_init_device);
 
+
+#ifdef CONFIG_CPU_FREQ
+
+static int
+time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
+		       void *data)
+{
+	struct cpufreq_freqs *freq = data;
+	unsigned int i;
+
+	if (!cpu_has_tsc)
+		return 0;
+
+	switch (val) {
+	case CPUFREQ_PRECHANGE:
+		if ((freq->old < freq->new) &&
+		((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == 0)))  {
+			cpu_khz = cpufreq_scale(cpu_khz, freq->old, freq->new);
+		        fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_quotient, freq->new, freq->old);
+		}
+		for (i=0; i<NR_CPUS; i++)
+			if ((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == i))
+				cpu_data[i].loops_per_jiffy = cpufreq_scale(loops_per_jiffy, freq->old, freq->new);
+		break;
+
+	case CPUFREQ_POSTCHANGE:
+		if ((freq->new < freq->old) &&
+		((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == 0)))  {
+			cpu_khz = cpufreq_scale(cpu_khz, freq->old, freq->new);
+		        fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_quotient, freq->new, freq->old);
+		}
+		for (i=0; i<NR_CPUS; i++)
+			if ((freq->cpu == CPUFREQ_ALL_CPUS) || (freq->cpu == i))
+				cpu_data[i].loops_per_jiffy = cpufreq_scale(loops_per_jiffy, freq->old, freq->new);
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block time_cpufreq_notifier_block = {
+	notifier_call:	time_cpufreq_notifier
+};
+#endif
+
+
 void __init time_init(void)
 {
 #ifdef CONFIG_X86_TSC
@@ -665,6 +712,9 @@
 	                	"0" (eax), "1" (edx));
 				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
 			}
+#ifdef CONFIG_CPU_FREQ
+			cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
+#endif
 		}
 	}
 #endif /* CONFIG_X86_TSC */
diff -ruN linux-2539original/include/asm-i386/msr.h linux/include/asm-i386/msr.h
--- linux-2539original/include/asm-i386/msr.h	Sun Sep 22 09:00:00 2002
+++ linux/include/asm-i386/msr.h	Sat Sep 28 09:30:00 2002
@@ -125,4 +125,10 @@
 #define MSR_VIA_LONGHAUL		0x110a
 #define MSR_VIA_BCR2			0x1147
 
+/* Transmeta defined MSRs */
+#define MSR_TMTA_LONGRUN_CTRL		0x80868010
+#define MSR_TMTA_LONGRUN_FLAGS		0x80868011
+#define MSR_TMTA_LRTI_READOUT		0x80868018
+#define MSR_TMTA_LRTI_VOLT_MHZ		0x8086801a
+
 #endif /* __ASM_MSR_H */


