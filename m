Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWB0UsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWB0UsU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWB0UsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:48:20 -0500
Received: from www17.your-server.de ([213.133.104.17]:35849 "EHLO
	www17.your-server.de") by vger.kernel.org with ESMTP
	id S964811AbWB0UsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:48:20 -0500
Subject: [PATCH] cpufreq: fix powernow-k7 smp kernel driver on up machines
From: Thomas Meyer <thomas@m3y3r.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 27 Feb 2006 21:47:39 +0100
Message-Id: <1141073259.9881.1.camel@hotzenplotz.treehouse>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Meyer <thomas@m3y3r.de>

This patch fixes the powernow-k7 cpufreq driver smp kernel on an up
machine.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

This patch is against branch v2.6.16-rc4. Please give me positive and/or
negativ feedback about this fixing approach!

With kind regads
Thomas

diff --git a/arch/i386/kernel/cpu/common.c
b/arch/i386/kernel/cpu/common.c
index 7eb9213..67fcee6 100644
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -336,6 +336,7 @@ void __devinit identify_cpu(struct cpuin
 	int i;
 
 	c->loops_per_jiffy = loops_per_jiffy;
+	c->cpu_khz = cpu_khz;
 	c->x86_cache_size = -1;
 	c->x86_vendor = X86_VENDOR_UNKNOWN;
 	c->cpuid_level = -1;	/* CPUID not detected */
diff --git a/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
b/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
index edcd626..2125026 100644
--- a/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
@@ -586,7 +586,7 @@ static int __init powernow_cpu_init (str
 	if (result)
 		return result;
 
-	fsb = (10 * cpu_khz) / fid_codes[fidvidstatus.bits.CFID];
+	fsb = (10 * current_cpu_data.cpu_khz) /
fid_codes[fidvidstatus.bits.CFID];
 	if (!fsb) {
 		printk(KERN_WARNING PFX "can not determine bus frequency\n");
 		return -EINVAL;
diff --git a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
diff --git a/arch/i386/kernel/timers/common.c
b/arch/i386/kernel/timers/common.c
index 8163fe0..760add2 100644
--- a/arch/i386/kernel/timers/common.c
+++ b/arch/i386/kernel/timers/common.c
@@ -148,7 +148,9 @@ unsigned long read_timer_tsc(void)
 }
 
 
-/* calculate cpu_khz */
+/* calculate cpu_khz for boot_cpu only, because timer_init ->
select_timer
+ * calls init_cpu_khz, before boot_cpu_data is transfered to
cpu_data[x]
+ */
 void init_cpu_khz(void)
 {
 	if (cpu_has_tsc) {
@@ -170,3 +172,26 @@ void init_cpu_khz(void)
 	}
 }
 
+void init_cpu_khz_smp(void)
+{
+	if (cpu_has(&(current_cpu_data), X86_FEATURE_TSC)) {
+		unsigned long tsc_quotient = calibrate_tsc();
+
+		if (tsc_quotient) {
+			/* report CPU clock rate in Hz.
+			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
+			 * clock/second. Our precision is about 100 ppm.
+			 */
+			{	unsigned long eax=0, edx=1000;
+				__asm__("divl %2"
+		       		:"=a" (current_cpu_data.cpu_khz), "=d" (edx)
+        	       		:"r" (tsc_quotient),
+	                	"0" (eax), "1" (edx));
+				printk("Detected %u.%03u MHz processor.\n",
+					current_cpu_data.cpu_khz / 1000, 
+					current_cpu_data.cpu_khz % 1000);
+			}
+		}
+	}
+}
+
diff --git a/arch/i386/kernel/timers/timer_tsc.c
b/arch/i386/kernel/timers/timer_tsc.c
index a7f5a2a..0a3e29e 100644
--- a/arch/i386/kernel/timers/timer_tsc.c
+++ b/arch/i386/kernel/timers/timer_tsc.c
@@ -341,23 +341,20 @@ static inline void cpufreq_delayed_get(v
 
 int recalibrate_cpu_khz(void)
 {
-#ifndef CONFIG_SMP
-	unsigned int cpu_khz_old = cpu_khz;
+	unsigned int cpu_khz_old = current_cpu_data.cpu_khz;
 
-	if (cpu_has_tsc) {
+	if (cpu_has(&(current_cpu_data), X86_FEATURE_TSC)) {
 		local_irq_disable();
-		init_cpu_khz();
+		init_cpu_khz_smp();
 		local_irq_enable();
-		cpu_data[0].loops_per_jiffy =
-		    cpufreq_scale(cpu_data[0].loops_per_jiffy,
+		current_cpu_data.loops_per_jiffy =
+		    cpufreq_scale(current_cpu_data.loops_per_jiffy,
 			          cpu_khz_old,
-				  cpu_khz);
+				  current_cpu_data.cpu_khz);
 		return 0;
 	} else
 		return -ENODEV;
-#else
-	return -ENODEV;
-#endif
+
 }
 EXPORT_SYMBOL(recalibrate_cpu_khz);
 
diff --git a/include/asm-i386/processor.h b/include/asm-i386/processor.h
index feca5d9..c486001 100644
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -67,6 +67,7 @@ struct cpuinfo_x86 {
 	char	pad0;
 	int	x86_power;
 	unsigned long loops_per_jiffy;
+	unsigned int  cpu_khz;
 	unsigned char x86_max_cores;	/* cpuid returned max cores value */
 	unsigned char booted_cores;	/* number of cores as seen by OS */
 	unsigned char apicid;
diff --git a/include/asm-i386/timer.h b/include/asm-i386/timer.h
index aed1643..bbec11d 100644
--- a/include/asm-i386/timer.h
+++ b/include/asm-i386/timer.h
@@ -58,6 +58,7 @@ extern struct init_timer_opts timer_cycl
 extern unsigned long calibrate_tsc(void);
 extern unsigned long read_timer_tsc(void);
 extern void init_cpu_khz(void);
+extern void init_cpu_khz_smp(void);
 extern int recalibrate_cpu_khz(void);
 #ifdef CONFIG_HPET_TIMER
 extern struct init_timer_opts timer_hpet_init;



