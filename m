Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVFUWah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVFUWah (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbVFUWaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:30:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:29918 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262548AbVFUVjZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:39:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/11] ppc64: consolidate calibrate_decr implementations
Date: Tue, 21 Jun 2005 23:11:35 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <200506212310.54156.arnd@arndb.de>
In-Reply-To: <200506212310.54156.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506212311.36010.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pSeries and maple have almost the same code for calibrate_decr,
and BPA would need yet another copy. Instead, I'm moving the
code to arch/ppc64/kernel/time.c.

Some of the related declarations were missing from header
files, so I'm moving those as well.

It makes sense to merge this with the pmac function of the
same name, so we end up having just one implemetation for
iSeries and one for Open Firmware based machines.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---

 arch/ppc64/kernel/iSeries_setup.c |    5 --
 arch/ppc64/kernel/maple_setup.c   |    2 -
 arch/ppc64/kernel/maple_time.c    |   51 ----------------------------
 arch/ppc64/kernel/pSeries_setup.c |   69 --------------------------------------
 arch/ppc64/kernel/pmac_time.c     |    8 ----
 arch/ppc64/kernel/setup.c         |    5 --
 arch/ppc64/kernel/time.c          |   63 ++++++++++++++++++++++++++++++++++
 include/asm-ppc64/time.h          |    9 ++++
 8 files changed, 76 insertions(+), 136 deletions(-)

--- linux-cg.orig/arch/ppc64/kernel/iSeries_setup.c	2005-06-21 02:10:53.631907448 -0400
+++ linux-cg/arch/ppc64/kernel/iSeries_setup.c	2005-06-21 02:22:45.822002600 -0400
@@ -665,9 +665,6 @@ static void __init iSeries_bolt_kernel(u
 	}
 }
 
-extern unsigned long ppc_proc_freq;
-extern unsigned long ppc_tb_freq;
-
 /*
  * Document me.
  */
@@ -766,8 +763,6 @@ static void iSeries_halt(void)
 	mf_power_off();
 }
 
-extern void setup_default_decr(void);
-
 /*
  * void __init iSeries_calibrate_decr()
  *
--- linux-cg.orig/arch/ppc64/kernel/maple_setup.c	2005-06-21 02:10:21.420014872 -0400
+++ linux-cg/arch/ppc64/kernel/maple_setup.c	2005-06-21 02:22:26.403897552 -0400
@@ -235,6 +235,6 @@ struct machdep_calls __initdata maple_md
        	.get_boot_time		= maple_get_boot_time,
        	.set_rtc_time		= maple_set_rtc_time,
        	.get_rtc_time		= maple_get_rtc_time,
-      	.calibrate_decr		= maple_calibrate_decr,
+      	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= maple_progress,
 };
--- linux-cg.orig/arch/ppc64/kernel/maple_time.c	2005-06-21 02:10:53.633907144 -0400
+++ linux-cg/arch/ppc64/kernel/maple_time.c	2005-06-21 02:22:26.412896184 -0400
@@ -42,11 +42,8 @@
 #define DBG(x...)
 #endif
 
-extern void setup_default_decr(void);
 extern void GregorianDay(struct rtc_time * tm);
 
-extern unsigned long ppc_tb_freq;
-extern unsigned long ppc_proc_freq;
 static int maple_rtc_addr;
 
 static int maple_clock_read(int addr)
@@ -176,51 +173,3 @@ void __init maple_get_boot_time(struct r
 	maple_get_rtc_time(tm);
 }
 
-/* XXX FIXME: Some sane defaults: 125 MHz timebase, 1GHz processor */
-#define DEFAULT_TB_FREQ		125000000UL
-#define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)
-
-void __init maple_calibrate_decr(void)
-{
-	struct device_node *cpu;
-	struct div_result divres;
-	unsigned int *fp = NULL;
-
-	/*
-	 * The cpu node should have a timebase-frequency property
-	 * to tell us the rate at which the decrementer counts.
-	 */
-	cpu = of_find_node_by_type(NULL, "cpu");
-
-	ppc_tb_freq = DEFAULT_TB_FREQ;
-	if (cpu != 0)
-		fp = (unsigned int *)get_property(cpu, "timebase-frequency", NULL);
-	if (fp != NULL)
-		ppc_tb_freq = *fp;
-	else
-		printk(KERN_ERR "WARNING: Estimating decrementer frequency (not found)\n");
-	fp = NULL;
-	ppc_proc_freq = DEFAULT_PROC_FREQ;
-	if (cpu != 0)
-		fp = (unsigned int *)get_property(cpu, "clock-frequency", NULL);
-	if (fp != NULL)
-		ppc_proc_freq = *fp;
-	else
-		printk(KERN_ERR "WARNING: Estimating processor frequency (not found)\n");
-
-	of_node_put(cpu);
-
-	printk(KERN_INFO "time_init: decrementer frequency = %lu.%.6lu MHz\n",
-	       ppc_tb_freq/1000000, ppc_tb_freq%1000000);
-	printk(KERN_INFO "time_init: processor frequency   = %lu.%.6lu MHz\n",
-	       ppc_proc_freq/1000000, ppc_proc_freq%1000000);
-
-	tb_ticks_per_jiffy = ppc_tb_freq / HZ;
-	tb_ticks_per_sec = tb_ticks_per_jiffy * HZ;
-	tb_ticks_per_usec = ppc_tb_freq / 1000000;
-	tb_to_us = mulhwu_scale_factor(ppc_tb_freq, 1000000);
-	div128_by_32(1024*1024, 0, tb_ticks_per_sec, &divres);
-	tb_to_xs = divres.result_low;
-
-	setup_default_decr();
-}
--- linux-cg.orig/arch/ppc64/kernel/pSeries_setup.c	2005-06-21 02:10:53.635906840 -0400
+++ linux-cg/arch/ppc64/kernel/pSeries_setup.c	2005-06-21 02:22:26.415895728 -0400
@@ -84,9 +84,6 @@ extern void generic_find_legacy_serial_p
 
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
 
-extern unsigned long ppc_proc_freq;
-extern unsigned long ppc_tb_freq;
-
 extern void pSeries_system_reset_exception(struct pt_regs *regs);
 extern int pSeries_machine_check_exception(struct pt_regs *regs);
 
@@ -482,70 +479,6 @@ static void pSeries_progress(char *s, un
 	spin_unlock(&progress_lock);
 }
 
-extern void setup_default_decr(void);
-
-/* Some sane defaults: 125 MHz timebase, 1GHz processor */
-#define DEFAULT_TB_FREQ		125000000UL
-#define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)
-
-static void __init pSeries_calibrate_decr(void)
-{
-	struct device_node *cpu;
-	struct div_result divres;
-	unsigned int *fp;
-	int node_found;
-
-	/*
-	 * The cpu node should have a timebase-frequency property
-	 * to tell us the rate at which the decrementer counts.
-	 */
-	cpu = of_find_node_by_type(NULL, "cpu");
-
-	ppc_tb_freq = DEFAULT_TB_FREQ;		/* hardcoded default */
-	node_found = 0;
-	if (cpu != 0) {
-		fp = (unsigned int *)get_property(cpu, "timebase-frequency",
-						  NULL);
-		if (fp != 0) {
-			node_found = 1;
-			ppc_tb_freq = *fp;
-		}
-	}
-	if (!node_found)
-		printk(KERN_ERR "WARNING: Estimating decrementer frequency "
-				"(not found)\n");
-
-	ppc_proc_freq = DEFAULT_PROC_FREQ;
-	node_found = 0;
-	if (cpu != 0) {
-		fp = (unsigned int *)get_property(cpu, "clock-frequency",
-						  NULL);
-		if (fp != 0) {
-			node_found = 1;
-			ppc_proc_freq = *fp;
-		}
-	}
-	if (!node_found)
-		printk(KERN_ERR "WARNING: Estimating processor frequency "
-				"(not found)\n");
-
-	of_node_put(cpu);
-
-	printk(KERN_INFO "time_init: decrementer frequency = %lu.%.6lu MHz\n",
-	       ppc_tb_freq/1000000, ppc_tb_freq%1000000);
-	printk(KERN_INFO "time_init: processor frequency   = %lu.%.6lu MHz\n",
-	       ppc_proc_freq/1000000, ppc_proc_freq%1000000);
-
-	tb_ticks_per_jiffy = ppc_tb_freq / HZ;
-	tb_ticks_per_sec = tb_ticks_per_jiffy * HZ;
-	tb_ticks_per_usec = ppc_tb_freq / 1000000;
-	tb_to_us = mulhwu_scale_factor(ppc_tb_freq, 1000000);
-	div128_by_32(1024*1024, 0, tb_ticks_per_sec, &divres);
-	tb_to_xs = divres.result_low;
-
-	setup_default_decr();
-}
-
 static int pSeries_check_legacy_ioport(unsigned int baseport)
 {
 	struct device_node *np;
@@ -604,7 +537,7 @@ struct machdep_calls __initdata pSeries_
 	.get_boot_time		= pSeries_get_boot_time,
 	.get_rtc_time		= pSeries_get_rtc_time,
 	.set_rtc_time		= pSeries_set_rtc_time,
-	.calibrate_decr		= pSeries_calibrate_decr,
+	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= pSeries_progress,
 	.check_legacy_ioport	= pSeries_check_legacy_ioport,
 	.system_reset_exception = pSeries_system_reset_exception,
--- linux-cg.orig/arch/ppc64/kernel/pmac_time.c	2005-06-21 02:10:53.638906384 -0400
+++ linux-cg/arch/ppc64/kernel/pmac_time.c	2005-06-21 02:22:26.417895424 -0400
@@ -40,11 +40,6 @@
 #define DBG(x...)
 #endif
 
-extern void setup_default_decr(void);
-
-extern unsigned long ppc_tb_freq;
-extern unsigned long ppc_proc_freq;
-
 /* Apparently the RTC stores seconds since 1 Jan 1904 */
 #define RTC_OFFSET	2082844800
 
@@ -161,8 +156,7 @@ void __init pmac_get_boot_time(struct rt
 
 /*
  * Query the OF and get the decr frequency.
- * This was taken from the pmac time_init() when merging the prep/pmac
- * time functions.
+ * FIXME: merge this with generic_calibrate_decr
  */
 void __init pmac_calibrate_decr(void)
 {
--- linux-cg.orig/arch/ppc64/kernel/setup.c	2005-06-21 02:10:21.423014416 -0400
+++ linux-cg/arch/ppc64/kernel/setup.c	2005-06-21 02:22:45.823002448 -0400
@@ -700,9 +700,6 @@ void machine_halt(void)
 
 EXPORT_SYMBOL(machine_halt);
 
-unsigned long ppc_proc_freq;
-unsigned long ppc_tb_freq;
-
 static int ppc64_panic_event(struct notifier_block *this,
                              unsigned long event, void *ptr)
 {
@@ -1116,7 +1113,7 @@ void ppc64_dump_msg(unsigned int src, co
 }
 
 /* This should only be called on processor 0 during calibrate decr */
-void setup_default_decr(void)
+void __init setup_default_decr(void)
 {
 	struct paca_struct *lpaca = get_paca();
 
--- linux-cg.orig/arch/ppc64/kernel/time.c	2005-06-21 02:10:21.425014112 -0400
+++ linux-cg/arch/ppc64/kernel/time.c	2005-06-21 02:22:26.408896792 -0400
@@ -107,6 +107,9 @@ void ppc_adjtimex(void);
 
 static unsigned adjusting_time = 0;
 
+unsigned long ppc_proc_freq;
+unsigned long ppc_tb_freq;
+
 static __inline__ void timer_check_rtc(void)
 {
         /*
@@ -472,6 +475,66 @@ int do_settimeofday(struct timespec *tv)
 
 EXPORT_SYMBOL(do_settimeofday);
 
+#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_MAPLE) || defined(CONFIG_PPC_BPA)
+void __init generic_calibrate_decr(void)
+{
+	struct device_node *cpu;
+	struct div_result divres;
+	unsigned int *fp;
+	int node_found;
+
+	/*
+	 * The cpu node should have a timebase-frequency property
+	 * to tell us the rate at which the decrementer counts.
+	 */
+	cpu = of_find_node_by_type(NULL, "cpu");
+
+	ppc_tb_freq = DEFAULT_TB_FREQ;		/* hardcoded default */
+	node_found = 0;
+	if (cpu != 0) {
+		fp = (unsigned int *)get_property(cpu, "timebase-frequency",
+						  NULL);
+		if (fp != 0) {
+			node_found = 1;
+			ppc_tb_freq = *fp;
+		}
+	}
+	if (!node_found)
+		printk(KERN_ERR "WARNING: Estimating decrementer frequency "
+				"(not found)\n");
+
+	ppc_proc_freq = DEFAULT_PROC_FREQ;
+	node_found = 0;
+	if (cpu != 0) {
+		fp = (unsigned int *)get_property(cpu, "clock-frequency",
+						  NULL);
+		if (fp != 0) {
+			node_found = 1;
+			ppc_proc_freq = *fp;
+		}
+	}
+	if (!node_found)
+		printk(KERN_ERR "WARNING: Estimating processor frequency "
+				"(not found)\n");
+
+	of_node_put(cpu);
+
+	printk(KERN_INFO "time_init: decrementer frequency = %lu.%.6lu MHz\n",
+	       ppc_tb_freq/1000000, ppc_tb_freq%1000000);
+	printk(KERN_INFO "time_init: processor frequency   = %lu.%.6lu MHz\n",
+	       ppc_proc_freq/1000000, ppc_proc_freq%1000000);
+
+	tb_ticks_per_jiffy = ppc_tb_freq / HZ;
+	tb_ticks_per_sec = tb_ticks_per_jiffy * HZ;
+	tb_ticks_per_usec = ppc_tb_freq / 1000000;
+	tb_to_us = mulhwu_scale_factor(ppc_tb_freq, 1000000);
+	div128_by_32(1024*1024, 0, tb_ticks_per_sec, &divres);
+	tb_to_xs = divres.result_low;
+
+	setup_default_decr();
+}
+#endif
+
 void __init time_init(void)
 {
 	/* This function is only called on the boot processor */
--- linux-cg.orig/include/asm-ppc64/time.h	2005-06-21 02:10:21.427013808 -0400
+++ linux-cg/include/asm-ppc64/time.h	2005-06-21 02:22:26.419895120 -0400
@@ -34,6 +34,15 @@ struct rtc_time;
 extern void to_tm(int tim, struct rtc_time * tm);
 extern time_t last_rtc_update;
 
+void generic_calibrate_decr(void);
+void setup_default_decr(void);
+
+/* Some sane defaults: 125 MHz timebase, 1GHz processor */
+extern unsigned long ppc_proc_freq;
+#define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)
+extern unsigned long ppc_tb_freq;
+#define DEFAULT_TB_FREQ		125000000UL
+
 /*
  * By putting all of this stuff into a single struct we 
  * reduce the number of cache lines touched by do_gettimeofday.

