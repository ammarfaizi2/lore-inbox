Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbSLURim>; Sat, 21 Dec 2002 12:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbSLURim>; Sat, 21 Dec 2002 12:38:42 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:46530 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262425AbSLURii>; Sat, 21 Dec 2002 12:38:38 -0500
Date: Sat, 21 Dec 2002 18:47:13 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5] cpufreq: x86 per-CPU loops_per_jiffy notifier
Message-ID: <20021221174713.GC1149@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The per-CPU loops_per_jiffy value should be adjusted on frequency transitions.
To get rid of accumulating rounding errors, some reference values are
stored.

	Dominik

diff -ruN linux-original/arch/i386/kernel/cpu/common.c linux/arch/i386/kernel/cpu/common.c
--- linux-original/arch/i386/kernel/cpu/common.c	2002-12-21 14:53:44.000000000 +0100
+++ linux/arch/i386/kernel/cpu/common.c	2002-12-21 18:34:34.000000000 +0100
@@ -1,5 +1,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
+#include <linux/cpufreq.h>
+#include <linux/notifier.h>
 #include <linux/delay.h>
 #include <linux/smp.h>
 #include <asm/semaphore.h>
@@ -61,6 +63,41 @@
 #endif
 __setup("notsc", tsc_setup);
 
+#ifdef CONFIG_CPU_FREQ
+static unsigned long loops_per_jiffy_ref = 0;
+static unsigned int  ref_freq = 0;
+
+static int
+loops_per_jiffy_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
+				       void *data)
+{
+	struct cpufreq_freqs *freq = data;
+
+	if (!loops_per_jiffy_ref) {
+		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
+		ref_freq = freq->old;
+	}
+
+	switch (val) {
+	case CPUFREQ_PRECHANGE:
+		if (freq->old < freq->new)
+		        cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
+		break;
+	case CPUFREQ_POSTCHANGE:
+		if (freq->new < freq->old)
+		        cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block loops_per_jiffy_cpufreq_notifier_block = {
+	.notifier_call	= loops_per_jiffy_cpufreq_notifier
+};
+#endif
+
+
 int __init get_model_name(struct cpuinfo_x86 *c)
 {
 	unsigned int *v;
@@ -350,6 +387,9 @@
 		for ( i = 0 ; i < NCAPINTS ; i++ )
 			boot_cpu_data.x86_capability[i] &= c->x86_capability[i];
 	}
+	if (c == &boot_cpu_data) {
+			cpufreq_register_notifier(&loops_per_jiffy_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
+	}
 
 	printk(KERN_DEBUG "CPU:             Common caps: %08lx %08lx %08lx %08lx\n",
 	       boot_cpu_data.x86_capability[0],
