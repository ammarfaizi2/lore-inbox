Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261889AbSIYDWw>; Tue, 24 Sep 2002 23:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261886AbSIYDWv>; Tue, 24 Sep 2002 23:22:51 -0400
Received: from dp.samba.org ([66.70.73.150]:43904 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261889AbSIYDQq>;
	Tue, 24 Sep 2002 23:16:46 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module rewrite 11/20: Parameter Support for Modules
Date: Wed, 25 Sep 2002 13:02:45 +1000
Message-Id: <20020925032201.9854F2C10F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Linus, I chose to not to leave a "#define __setup()" stub in init.h
  to break compile on unconverted code.  You might want to add it. ]

Name: Parameter __setup Removal Stage 1
Author: Rusty Russell
Status: Tested on 2.5.38
Depends: Module/param.patch.gz

D: This patch replaces some of the __setup calls (it is not
D: exhaustive), so my kernel compiles again.  It heavily uses
D: __PARAM_CALL where I thought backwards compatibility was vital, but
D: some of these places really need a big renaming (esp. where module
D: parameters are different).
D:
D: This patch is reasonably large because the PARAM_CALL callbacks have
D: a slightly different prototype, and return 0 on success or -errno

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/arch/i386/kernel/apm.c .26895-linux-2.5.38.updated/arch/i386/kernel/apm.c
--- .26895-linux-2.5.38/arch/i386/kernel/apm.c	2002-08-28 09:29:40.000000000 +1000
+++ .26895-linux-2.5.38.updated/arch/i386/kernel/apm.c	2002-09-25 07:17:08.000000000 +1000
@@ -1792,53 +1792,6 @@ static int apm(void *unused)
 	return 0;
 }
 
-#ifndef MODULE
-static int __init apm_setup(char *str)
-{
-	int	invert;
-
-	while ((str != NULL) && (*str != '\0')) {
-		if (strncmp(str, "off", 3) == 0)
-			apm_disabled = 1;
-		if (strncmp(str, "on", 2) == 0)
-			apm_disabled = 0;
-		if ((strncmp(str, "bounce-interval=", 16) == 0) ||
-		    (strncmp(str, "bounce_interval=", 16) == 0))
-			bounce_interval = simple_strtol(str + 16, NULL, 0);
-		if ((strncmp(str, "idle-threshold=", 15) == 0) ||
-		    (strncmp(str, "idle_threshold=", 15) == 0))
-			idle_threshold = simple_strtol(str + 15, NULL, 0);
-		if ((strncmp(str, "idle-period=", 12) == 0) ||
-		    (strncmp(str, "idle_period=", 12) == 0))
-			idle_period = simple_strtol(str + 12, NULL, 0);
-		invert = (strncmp(str, "no-", 3) == 0) ||
-			(strncmp(str, "no_", 3) == 0);
-		if (invert)
-			str += 3;
-		if (strncmp(str, "debug", 5) == 0)
-			debug = !invert;
-		if ((strncmp(str, "power-off", 9) == 0) ||
-		    (strncmp(str, "power_off", 9) == 0))
-			power_off = !invert;
-		if ((strncmp(str, "allow-ints", 10) == 0) ||
-		    (strncmp(str, "allow_ints", 10) == 0))
- 			apm_info.allow_ints = !invert;
-		if ((strncmp(str, "broken-psr", 10) == 0) ||
-		    (strncmp(str, "broken_psr", 10) == 0))
-			apm_info.get_power_status_broken = !invert;
-		if ((strncmp(str, "realmode-power-off", 18) == 0) ||
-		    (strncmp(str, "realmode_power_off", 18) == 0))
-			apm_info.realmode_power_off = !invert;
-		str = strchr(str, ',');
-		if (str != NULL)
-			str += strspn(str, ", \t");
-	}
-	return 1;
-}
-
-__setup("apm=", apm_setup);
-#endif
-
 static struct file_operations apm_bios_fops = {
 	.owner		= THIS_MODULE,
 	.read		= do_read,
@@ -2029,23 +1982,22 @@ module_exit(apm_exit);
 MODULE_AUTHOR("Stephen Rothwell");
 MODULE_DESCRIPTION("Advanced Power Management");
 MODULE_LICENSE("GPL");
-MODULE_PARM(debug, "i");
+PARAM(debug, bool, S_IWUSR|S_IRUGO);
 MODULE_PARM_DESC(debug, "Enable debug mode");
-MODULE_PARM(power_off, "i");
+PARAM(power_off, bool, S_IWUSR|S_IRUGO);
 MODULE_PARM_DESC(power_off, "Enable power off");
-MODULE_PARM(bounce_interval, "i");
-MODULE_PARM_DESC(bounce_interval,
-		"Set the number of ticks to ignore suspend bounces");
-MODULE_PARM(allow_ints, "i");
+PARAM(bounce_interval, int, S_IWUSR|S_IRUGO);
+MODULE_PARM_DESC(bounce_interval, "Set the number of ticks to ignore suspend bounces");
+PARAM(allow_ints, bool, S_IWUSR|S_IRUGO);
 MODULE_PARM_DESC(allow_ints, "Allow interrupts during BIOS calls");
-MODULE_PARM(broken_psr, "i");
+PARAM(broken_psr, bool, S_IWUSR|S_IRUGO);
 MODULE_PARM_DESC(broken_psr, "BIOS has a broken GetPowerStatus call");
-MODULE_PARM(realmode_power_off, "i");
+PARAM(realmode_power_off, bool, S_IWUSR|S_IRUGO);
 MODULE_PARM_DESC(realmode_power_off,
 		"Switch to real mode before powering off");
-MODULE_PARM(idle_threshold, "i");
+PARAM(idle_threshold, int, S_IWUSR|S_IRUGO);
 MODULE_PARM_DESC(idle_threshold,
 	"System idle percentage above which to make APM BIOS idle calls");
-MODULE_PARM(idle_period, "i");
+PARAM(idle_period, int, S_IWUSR|S_IRUGO);
 MODULE_PARM_DESC(idle_period,
 	"Period (in sec/100) over which to caculate the idle percentage");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/arch/i386/kernel/bluesmoke.c .26895-linux-2.5.38.updated/arch/i386/kernel/bluesmoke.c
--- .26895-linux-2.5.38/arch/i386/kernel/bluesmoke.c	2002-08-28 09:29:40.000000000 +1000
+++ .26895-linux-2.5.38.updated/arch/i386/kernel/bluesmoke.c	2002-09-25 07:17:08.000000000 +1000
@@ -11,6 +11,7 @@
 #include <linux/irq.h>
 #include <linux/tqueue.h>
 #include <linux/interrupt.h>
+#include <linux/params.h>
 
 #include <asm/processor.h> 
 #include <asm/system.h>
@@ -488,20 +489,17 @@ void __init mcheck_init(struct cpuinfo_x
 	}
 }
 
-static int __init mcheck_disable(char *str)
-{
-	mce_disabled = 1;
-	return 0;
-}
-
-static int __init mcheck_enable(char *str)
+static int __init mcheck_enable(const char *str, struct kernel_param *kp)
 {
 	mce_disabled = -1;
 	return 0;
 }
 
-__setup("nomce", mcheck_disable);
-__setup("mce", mcheck_enable);
+#undef PARAM_PREFIX
+#define PARAM_PREFIX ""
+
+PARAM_NAMED(nomce, mce_disabled, bool, 000);
+PARAM_CALL(mce, mcheck_enable, NULL, NULL, 000);
 
 #else
 asmlinkage void do_machine_check(struct pt_regs * regs, long error_code) {}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/arch/i386/kernel/cpu/common.c .26895-linux-2.5.38.updated/arch/i386/kernel/cpu/common.c
--- .26895-linux-2.5.38/arch/i386/kernel/cpu/common.c	2002-09-18 16:04:37.000000000 +1000
+++ .26895-linux-2.5.38.updated/arch/i386/kernel/cpu/common.c	2002-09-25 07:17:08.000000000 +1000
@@ -2,6 +2,7 @@
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/smp.h>
+#include <linux/params.h>
 #include <asm/semaphore.h>
 #include <asm/processor.h>
 #include <asm/msr.h>
@@ -10,6 +11,9 @@
 
 #include "cpu.h"
 
+#undef PARAM_PREFIX
+#define PARAM_PREFIX ""
+
 static int cachesize_override __initdata = -1;
 static int disable_x86_fxsr __initdata = 0;
 
@@ -35,23 +39,12 @@ static struct cpu_dev default_cpu = {
 };
 static struct cpu_dev * this_cpu = &default_cpu;
 
-static int __init cachesize_setup(char *str)
-{
-	get_option (&str, &cachesize_override);
-	return 1;
-}
-__setup("cachesize=", cachesize_setup);
+PARAM_NAMED(cachesize, cachesize_override, int, 000);
 
 #ifndef CONFIG_X86_TSC
 static int tsc_disable __initdata = 0;
 
-static int __init tsc_setup(char *str)
-{
-	tsc_disable = 1;
-	return 1;
-}
-
-__setup("notsc", tsc_setup);
+PARAM_NAMED(notsc, tsc_disable, bool, 000);
 #endif
 
 int __init get_model_name(struct cpuinfo_x86 *c)
@@ -165,14 +158,7 @@ void __init get_cpu_vendor(struct cpuinf
 	}
 }
 
-
-static int __init x86_fxsr_setup(char * s)
-{
-	disable_x86_fxsr = 1;
-	return 1;
-}
-__setup("nofxsr", x86_fxsr_setup);
-
+PARAM_NAMED(nofxsr, disable_x86_fxsr, bool, 000);
 
 /* Standard macro to see if a specific flag is changeable */
 static inline int flag_is_changeable_p(u32 flag)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/arch/i386/kernel/cpu/intel.c .26895-linux-2.5.38.updated/arch/i386/kernel/cpu/intel.c
--- .26895-linux-2.5.38/arch/i386/kernel/cpu/intel.c	2002-09-21 13:55:07.000000000 +1000
+++ .26895-linux-2.5.38.updated/arch/i386/kernel/cpu/intel.c	2002-09-25 07:17:08.000000000 +1000
@@ -3,6 +3,7 @@
 #include <linux/string.h>
 #include <linux/bitops.h>
 #include <linux/smp.h>
+#include <linux/params.h>
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 #include <asm/msr.h>
@@ -77,19 +78,8 @@ static void __init squash_the_stupid_ser
 	}
 }
 
-static int __init x86_serial_nr_setup(char *s)
-{
-	disable_x86_serial_nr = 0;
-	return 1;
-}
-__setup("serialnumber", x86_serial_nr_setup);
-
-static int __init P4_disable_ht(char *s)
-{
-	disable_P4_HT = 1;
-	return 1;
-}
-__setup("noht", P4_disable_ht);
+PARAM_NAMED(serialnumber, disable_x86_serial_nr, invbool, 000);
+PARAM_NAMED(noht, disable_P4_HT, bool, 000);
 
 #define LVL_1_INST	1
 #define LVL_1_DATA	2
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/arch/i386/kernel/io_apic.c .26895-linux-2.5.38.updated/arch/i386/kernel/io_apic.c
--- .26895-linux-2.5.38/arch/i386/kernel/io_apic.c	2002-09-21 13:55:07.000000000 +1000
+++ .26895-linux-2.5.38.updated/arch/i386/kernel/io_apic.c	2002-09-25 07:17:08.000000000 +1000
@@ -31,6 +31,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/compiler.h>
 #include <linux/acpi.h>
+#include <linux/params.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -288,15 +289,9 @@ int pirq_entries [MAX_PIRQS];
 int pirqs_enabled;
 int skip_ioapic_setup;
 
-static int __init ioapic_setup(char *str)
-{
-	skip_ioapic_setup = 1;
-	return 1;
-}
-
-__setup("noapic", ioapic_setup);
+PARAM_NAMED(noapic, skip_ioapic_setup, bool, 000);
 
-static int __init ioapic_pirq_setup(char *str)
+static int __init ioapic_pirq_setup(const char *str, struct kernel_param *kp)
 {
 	int i, max;
 	int ints[MAX_PIRQS+1];
@@ -319,10 +314,10 @@ static int __init ioapic_pirq_setup(char
 		 */
 		pirq_entries[MAX_PIRQS-i-1] = ints[i+1];
 	}
-	return 1;
+	return 0;
 }
 
-__setup("pirq=", ioapic_pirq_setup);
+PARAM_CALL(pirq, ioapic_pirq_setup, NULL, NULL, 000);
 
 /*
  * Find the IRQ entry number of a certain pin.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/arch/i386/kernel/nmi.c .26895-linux-2.5.38.updated/arch/i386/kernel/nmi.c
--- .26895-linux-2.5.38/arch/i386/kernel/nmi.c	2002-07-27 15:24:35.000000000 +1000
+++ .26895-linux-2.5.38.updated/arch/i386/kernel/nmi.c	2002-09-25 07:17:08.000000000 +1000
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/params.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -102,7 +103,7 @@ int __init check_nmi_watchdog (void)
 	return 0;
 }
 
-static int __init setup_nmi_watchdog(char *str)
+static int __init setup_nmi_watchdog(const char *str, struct kernel_param *kp)
 {
 	int nmi;
 
@@ -131,10 +132,10 @@ static int __init setup_nmi_watchdog(cha
 	 */
 	if (nmi == NMI_IO_APIC)
 		nmi_watchdog = nmi;
-	return 1;
+	return 0;
 }
 
-__setup("nmi_watchdog=", setup_nmi_watchdog);
+PARAM_CALL(nmi_watchdog, setup_nmi_watchdog, NULL, NULL, 000);
 
 #ifdef CONFIG_PM
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/arch/i386/kernel/process.c .26895-linux-2.5.38.updated/arch/i386/kernel/process.c
--- .26895-linux-2.5.38/arch/i386/kernel/process.c	2002-09-21 13:55:07.000000000 +1000
+++ .26895-linux-2.5.38.updated/arch/i386/kernel/process.c	2002-09-25 07:17:08.000000000 +1000
@@ -33,6 +33,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/mc146818rtc.h>
+#include <linux/params.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -143,17 +144,17 @@ void cpu_idle (void)
 	}
 }
 
-static int __init idle_setup (char *str)
+static int __init idle_setup (const char *str, struct kernel_param *kp)
 {
 	if (!strncmp(str, "poll", 4)) {
 		printk("using polling idle threads.\n");
 		pm_idle = poll_idle;
 	}
 
-	return 1;
+	return 0;
 }
 
-__setup("idle=", idle_setup);
+__PARAM_CALL("", idle, idle_setup, NULL, NULL, 000);
 
 extern void show_trace(unsigned long* esp);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/arch/i386/kernel/reboot.c .26895-linux-2.5.38.updated/arch/i386/kernel/reboot.c
--- .26895-linux-2.5.38/arch/i386/kernel/reboot.c	2002-09-21 13:55:07.000000000 +1000
+++ .26895-linux-2.5.38.updated/arch/i386/kernel/reboot.c	2002-09-25 07:17:08.000000000 +1000
@@ -25,6 +25,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/mc146818rtc.h>
+#include <linux/params.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -56,7 +57,7 @@ static int reboot_cpu = -1;
 /* shamelessly grabbed from lib/vsprintf.c for readability */
 #define is_digit(c)	((c) >= '0' && (c) <= '9')
 #endif
-static int __init reboot_setup(char *str)
+static int __init reboot_setup(const char *str, struct kernel_param *kp)
 {
 	while(1) {
 		switch (*str) {
@@ -91,10 +92,10 @@ static int __init reboot_setup(char *str
 		else
 			break;
 	}
-	return 1;
+	return 0;
 }
 
-__setup("reboot=", reboot_setup);
+__PARAM_CALL("", reboot, reboot_setup, NULL, NULL, 000);
 
 /* The following code and data reboots the machine by switching to real
    mode and jumping to the BIOS reset entry point, as if the CPU has
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/arch/i386/kernel/setup.c .26895-linux-2.5.38.updated/arch/i386/kernel/setup.c
--- .26895-linux-2.5.38/arch/i386/kernel/setup.c	2002-09-21 13:55:07.000000000 +1000
+++ .26895-linux-2.5.38.updated/arch/i386/kernel/setup.c	2002-09-25 07:17:08.000000000 +1000
@@ -34,6 +34,7 @@
 #include <linux/console.h>
 #include <linux/root_dev.h>
 #include <linux/highmem.h>
+#include <linux/params.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
 #include <asm/setup.h>
@@ -893,13 +894,14 @@ void __init setup_arch(char **cmdline_p)
 	dmi_scan_machine();
 }
 
-static int __init highio_setup(char *str)
+static int __init highio_setup(const char *str, struct kernel_param *kp)
 {
 	printk("i386: disabling HIGHMEM block I/O\n");
 	blk_nohighio = 1;
-	return 1;
+	return 0;
 }
-__setup("nohighio", highio_setup);
+
+__PARAM_CALL("", nohighio, highio_setup, NULL, NULL, 000);
  
 
 #include "setup_arch_post.h"
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/arch/i386/pci/common.c .26895-linux-2.5.38.updated/arch/i386/pci/common.c
--- .26895-linux-2.5.38/arch/i386/pci/common.c	2002-09-18 16:03:55.000000000 +1000
+++ .26895-linux-2.5.38.updated/arch/i386/pci/common.c	2002-09-25 07:17:08.000000000 +1000
@@ -138,7 +138,7 @@ static int __init pcibios_init(void)
 
 subsys_initcall(pcibios_init);
 
-char * __devinit  pcibios_setup(char *str)
+char * __devinit  pcibios_setup(const char *str)
 {
 	if (!strcmp(str, "off")) {
 		pci_probe = 0;
@@ -191,7 +191,7 @@ char * __devinit  pcibios_setup(char *st
 		pcibios_last_bus = simple_strtol(str+8, NULL, 0);
 		return NULL;
 	}
-	return str;
+	return (char *)str;
 }
 
 unsigned int pcibios_assign_all_busses(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/drivers/block/loop.c .26895-linux-2.5.38.updated/drivers/block/loop.c
--- .26895-linux-2.5.38/drivers/block/loop.c	2002-09-23 08:54:51.000000000 +1000
+++ .26895-linux-2.5.38.updated/drivers/block/loop.c	2002-09-25 07:17:08.000000000 +1000
@@ -76,6 +76,7 @@
 #include <linux/suspend.h>
 #include <linux/writeback.h>
 #include <linux/buffer_head.h>		/* for invalidate_bdev() */
+#include <linux/params.h>
 
 #include <asm/uaccess.h>
 
@@ -964,9 +965,6 @@ static struct block_device_operations lo
 /*
  * And now the modules code and kernel interface.
  */
-MODULE_PARM(max_loop, "i");
-MODULE_PARM_DESC(max_loop, "Maximum number of loop devices (1-256)");
-MODULE_LICENSE("GPL");
 
 int loop_register_transfer(struct loop_func_table *funcs)
 {
@@ -1078,12 +1076,6 @@ void loop_exit(void) 
 module_init(loop_init);
 module_exit(loop_exit);
 
-#ifndef MODULE
-static int __init max_loop_setup(char *str)
-{
-	max_loop = simple_strtol(str, NULL, 0);
-	return 1;
-}
-
-__setup("max_loop=", max_loop_setup);
-#endif
+PARAM(max_loop, int, 000);
+MODULE_PARM_DESC(max_loop, "Maximum number of loop devices (1-256)");
+MODULE_LICENSE("GPL");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/drivers/char/lp.c .26895-linux-2.5.38.updated/drivers/char/lp.c
--- .26895-linux-2.5.38/drivers/char/lp.c	2002-09-18 16:03:59.000000000 +1000
+++ .26895-linux-2.5.38.updated/drivers/char/lp.c	2002-09-25 07:17:08.000000000 +1000
@@ -126,6 +126,7 @@
 #include <linux/delay.h>
 #include <linux/poll.h>
 #include <linux/console.h>
+#include <linux/params.h>
 
 #include <linux/parport.h>
 #undef LP_STATS
@@ -759,7 +760,7 @@ MODULE_PARM(parport, "1-" __MODULE_STRIN
 MODULE_PARM(reset, "i");
 
 #ifndef MODULE
-static int __init lp_setup (char *str)
+static int __init lp_setup (const char *str, struct kernel_param *kp)
 {
 	static int parport_ptr; // initially zero
 	int x;
@@ -770,7 +771,7 @@ static int __init lp_setup (char *str)
 			parport_nr[0] = LP_PARPORT_OFF;
 		} else {
 			printk(KERN_WARNING "warning: 'lp=0x%x' is deprecated, ignored\n", x);
-			return 0;
+			return -EINVAL;
 		}
 	} else if (!strncmp(str, "parport", 7)) {
 		int n = simple_strtoul(str+7, NULL, 10);
@@ -786,8 +787,11 @@ static int __init lp_setup (char *str)
 	} else if (!strcmp(str, "reset")) {
 		reset = 1;
 	}
-	return 1;
+	return 0;
 }
+
+/* just "lp=" for backwards compat. */
+__PARAM_CALL("", lp, lp_setup, NULL, NULL, 000);
 #endif
 
 static int lp_register(int nr, struct parport *port)
@@ -973,7 +977,6 @@ static void lp_cleanup_module (void)
 	}
 }
 
-__setup("lp=", lp_setup);
 module_init(lp_init_module);
 module_exit(lp_cleanup_module);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/drivers/ide/ide.c .26895-linux-2.5.38.updated/drivers/ide/ide.c
--- .26895-linux-2.5.38/drivers/ide/ide.c	2002-09-23 08:54:52.000000000 +1000
+++ .26895-linux-2.5.38.updated/drivers/ide/ide.c	2002-09-25 07:17:08.000000000 +1000
@@ -153,6 +153,7 @@
 #include <linux/cdrom.h>
 #include <linux/seq_file.h>
 #include <linux/device.h>
+#include <linux/params.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -2673,54 +2674,51 @@ static int __init stridx (const char *s,
 /*
  * match_parm() does parsing for ide_setup():
  *
- * 1. the first char of s must be '='.
- * 2. if the remainder matches one of the supplied keywords,
+ * 1. if the string matches one of the supplied keywords,
  *     the index (1 based) of the keyword is negated and returned.
- * 3. if the remainder is a series of no more than max_vals numbers
+ * 2. if the string is a series of no more than max_vals numbers
  *     separated by commas, the numbers are saved in vals[] and a
  *     count of how many were saved is returned.  Base10 is assumed,
  *     and base16 is allowed when prefixed with "0x".
- * 4. otherwise, zero is returned.
+ * 3. otherwise, zero is returned.
  */
-static int __init match_parm (char *s, const char *keywords[], int vals[], int max_vals)
+static int __init match_parm (const char *s, const char *keywords[], int vals[], int max_vals)
 {
 	static const char *decimal = "0123456789";
 	static const char *hex = "0123456789abcdef";
 	int i, n;
 
-	if (*s++ == '=') {
-		/*
-		 * Try matching against the supplied keywords,
-		 * and return -(index+1) if we match one
-		 */
-		if (keywords != NULL) {
-			for (i = 0; *keywords != NULL; ++i) {
-				if (!strcmp(s, *keywords++))
-					return -(i+1);
-			}
+	/*
+	 * Try matching against the supplied keywords,
+	 * and return -(index+1) if we match one
+	 */
+	if (keywords != NULL) {
+		for (i = 0; *keywords != NULL; ++i) {
+			if (!strcmp(s, *keywords++))
+				return -(i+1);
 		}
-		/*
-		 * Look for a series of no more than "max_vals"
-		 * numeric values separated by commas, in base10,
-		 * or base16 when prefixed with "0x".
-		 * Return a count of how many were found.
-		 */
-		for (n = 0; (i = stridx(decimal, *s)) >= 0;) {
-			vals[n] = i;
-			while ((i = stridx(decimal, *++s)) >= 0)
-				vals[n] = (vals[n] * 10) + i;
-			if (*s == 'x' && !vals[n]) {
-				while ((i = stridx(hex, *++s)) >= 0)
-					vals[n] = (vals[n] * 0x10) + i;
-			}
-			if (++n == max_vals)
-				break;
-			if (*s == ',' || *s == ';')
-				++s;
+	}
+	/*
+	 * Look for a series of no more than "max_vals"
+	 * numeric values separated by commas, in base10,
+	 * or base16 when prefixed with "0x".
+	 * Return a count of how many were found.
+	 */
+	for (n = 0; (i = stridx(decimal, *s)) >= 0;) {
+		vals[n] = i;
+		while ((i = stridx(decimal, *++s)) >= 0)
+			vals[n] = (vals[n] * 10) + i;
+		if (*s == 'x' && !vals[n]) {
+			while ((i = stridx(hex, *++s)) >= 0)
+				vals[n] = (vals[n] * 0x10) + i;
 		}
-		if (!*s)
-			return n;
+		if (++n == max_vals)
+			break;
+		if (*s == ',' || *s == ';')
+			++s;
 	}
+	if (!*s)
+		return n;
 	return 0;	/* zero = nothing matched */
 }
 
@@ -2804,7 +2802,7 @@ static int __init match_parm (char *s, c
  * "idex=dc4030"	: probe/support Promise DC4030VL interface
  * "ide=doubler"	: probe/support IDE doublers on Amiga
  */
-int __init ide_setup (char *s)
+int __init ide_setup (const char *s, struct kernel_param *kp)
 {
 	int i, vals[3];
 	ide_hwif_t *hwif;
@@ -2813,64 +2811,59 @@ int __init ide_setup (char *s)
 	const char max_drive = 'a' + ((MAX_HWIFS * MAX_DRIVES) - 1);
 	const char max_hwif  = '0' + (MAX_HWIFS - 1);
 
-	
-	if (strncmp(s,"hd",2) == 0 && s[2] == '=')	/* hd= is for hd.c   */
-		return 0;				/* driver and not us */
-
-	if (strncmp(s,"ide",3) &&
-	    strncmp(s,"idebus",6) &&
-	    strncmp(s,"hd",2))		/* hdx= & hdxlun= */
-		return 0;
+	if (!s)
+		return -EINVAL;
 
 	printk("ide_setup: %s", s);
 	init_ide_data ();
 
 #ifdef CONFIG_BLK_DEV_IDEDOUBLER
-	if (!strcmp(s, "ide=doubler")) {
+	if (!strcmp(kp->name, "ide") && !strcmp(s, "doubler")) {
 		extern int ide_doubler;
 
 		printk(" : Enabled support for IDE doublers\n");
 		ide_doubler = 1;
-		return 1;
+		return 0;
 	}
 #endif /* CONFIG_BLK_DEV_IDEDOUBLER */
 
-	if (!strcmp(s, "ide=nodma")) {
+	if (!strcmp(kp->name, "ide") && !strcmp(s, "nodma")) {
 		printk("IDE: Prevented DMA\n");
 		noautodma = 1;
-		return 1;
+		return 0;
 	}
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
-	if (!strcmp(s, "ide=reverse")) {
+	if (!strcmp(kp->name, "ide") && !strcmp(s, "reverse")) {
 		ide_scan_direction = 1;
 		printk(" : Enabled support for IDE inverse scan order.\n");
-		return 1;
+		return 0;
 	}
 #endif /* CONFIG_BLK_DEV_IDEPCI */
 
 	/*
 	 * Look for drive options:  "hdx="
 	 */
-	if (s[0] == 'h' && s[1] == 'd' && s[2] >= 'a' && s[2] <= max_drive) {
+	if (kp->name[0] == 'h' && kp->name[1] == 'd'
+	    && kp->name[2] >= 'a' && kp->name[2] <= max_drive) {
 		const char *hd_words[] = {"none", "noprobe", "nowerr", "cdrom",
 				"serialize", "autotune", "noautotune",
 				"slow", "swapdata", "bswap", "flash",
 				"remap", "noremap", "scsi", NULL};
-		unit = s[2] - 'a';
+		unit = kp->name[2] - 'a';
 		hw   = unit / MAX_DRIVES;
 		unit = unit % MAX_DRIVES;
 		hwif = &ide_hwifs[hw];
 		drive = &hwif->drives[unit];
-		if (strncmp(s + 4, "ide-", 4) == 0) {
-			strncpy(drive->driver_req, s + 4, 9);
+		if (strncmp(s, "ide-", 4) == 0) {
+			strncpy(drive->driver_req, s, 9);
 			goto done;
 		}
 		/*
 		 * Look for last lun option:  "hdxlun="
 		 */
-		if (s[3] == 'l' && s[4] == 'u' && s[5] == 'n') {
-			if (match_parm(&s[6], NULL, vals, 1) != 1)
+		if (!strcmp(kp->name, "hdxlun")) {
+			if (match_parm(s, NULL, vals, 1) != 1)
 				goto bad_option;
 			if (vals[0] >= 0 && vals[0] <= 7) {
 				drive->last_lun = vals[0];
@@ -2879,7 +2872,7 @@ int __init ide_setup (char *s)
 				printk(" -- BAD LAST LUN! Expected value from 0 to 7");
 			goto done;
 		}
-		switch (match_parm(&s[3], hd_words, vals, 3)) {
+		switch (match_parm(s, hd_words, vals, 3)) {
 			case -1: /* "none" */
 				drive->nobios = 1;  /* drop into "noprobe" */
 			case -2: /* "noprobe" */
@@ -2941,13 +2934,13 @@ int __init ide_setup (char *s)
 		}
 	}
 
-	if (s[0] != 'i' || s[1] != 'd' || s[2] != 'e')
+	if (kp->name[0] != 'i' || kp->name[1] != 'd' || kp->name[2] != 'e')
 		goto bad_option;
 	/*
 	 * Look for bus speed option:  "idebus="
 	 */
-	if (s[3] == 'b' && s[4] == 'u' && s[5] == 's') {
-		if (match_parm(&s[6], NULL, vals, 1) != 1)
+	if (!strcmp(kp->name, "idebus")) {
+		if (match_parm(s, NULL, vals, 1) != 1)
 			goto bad_option;
 		if (vals[0] >= 20 && vals[0] <= 66) {
 			idebus_parameter = vals[0];
@@ -2958,7 +2951,7 @@ int __init ide_setup (char *s)
 	/*
 	 * Look for interface options:  "idex="
 	 */
-	if (s[3] >= '0' && s[3] <= max_hwif) {
+	if (kp->name[3] >= '0' && kp->name[3] <= max_hwif) {
 		/*
 		 * Be VERY CAREFUL changing this: note hardcoded indexes below
 		 * -8,-9,-10 : are reserved for future idex calls to ease the hardcoding.
@@ -2967,9 +2960,9 @@ int __init ide_setup (char *s)
 			"noprobe", "serialize", "autotune", "noautotune", "reset", "dma", "ata66",
 			"minus8", "minus9", "minus10",
 			"four", "qd65xx", "ht6560b", "cmd640_vlb", "dtc2278", "umc8672", "ali14xx", "dc4030", NULL };
-		hw = s[3] - '0';
+		hw = kp->name[3] - '0';
 		hwif = &ide_hwifs[hw];
-		i = match_parm(&s[4], ide_words, vals, 3);
+		i = match_parm(s, ide_words, vals, 3);
 
 		/*
 		 * Cryptic check to ensure chipset not already set for hwif:
@@ -3106,17 +3099,17 @@ int __init ide_setup (char *s)
 			case 0: goto bad_option;
 			default:
 				printk(" -- SUPPORT NOT CONFIGURED IN THIS KERNEL\n");
-				return 1;
+				return -ENOSYS;
 		}
 	}
 bad_option:
 	printk(" -- BAD OPTION\n");
-	return 1;
+	return -EINVAL;
 bad_hwif:
 	printk("-- NOT SUPPORTED ON ide%d", hw);
 done:
 	printk("\n");
-	return 1;
+	return -ENOSYS;
 }
 
 /*
@@ -3557,27 +3550,10 @@ int __init ide_init (void)
 module_init(ide_init);
 
 #ifdef MODULE
-char *options = NULL;
-MODULE_PARM(options,"s");
 MODULE_LICENSE("GPL");
 
-static void __init parse_options (char *line)
-{
-	char *next = line;
-
-	if (line == NULL || !*line)
-		return;
-	while ((line = next) != NULL) {
- 		if ((next = strchr(line,' ')) != NULL)
-			*next++ = 0;
-		if (!ide_setup(line))
-			printk ("Unknown option '%s'\n", line);
-	}
-}
-
 int init_module (void)
 {
-	parse_options(options);
 	return ide_init();
 }
 
@@ -3601,9 +3577,22 @@ void cleanup_module (void)
 
 	bus_unregister(&ide_bus_type);
 }
+#endif /* !MODULE */
 
-#else /* !MODULE */
-
-__setup("", ide_setup);
-
-#endif /* MODULE */
+/* Messy, but explicit */
+#undef PARAM_PREFIX
+#define PARAM_PREFIX ""
+PARAM_CALL(hda, ide_setup, NULL, NULL, 000);
+PARAM_CALL(hdb, ide_setup, NULL, NULL, 000);
+PARAM_CALL(hdc, ide_setup, NULL, NULL, 000);
+PARAM_CALL(hdd, ide_setup, NULL, NULL, 000);
+PARAM_CALL(hde, ide_setup, NULL, NULL, 000);
+PARAM_CALL(hdf, ide_setup, NULL, NULL, 000);
+PARAM_CALL(hdg, ide_setup, NULL, NULL, 000);
+PARAM_CALL(hdh, ide_setup, NULL, NULL, 000);
+PARAM_CALL(ide0, ide_setup, NULL, NULL, 000);
+PARAM_CALL(ide1, ide_setup, NULL, NULL, 000);
+PARAM_CALL(ide2, ide_setup, NULL, NULL, 000);
+PARAM_CALL(ide3, ide_setup, NULL, NULL, 000);
+PARAM_CALL(ide, ide_setup, NULL, NULL, 000);
+PARAM_CALL(idebus, ide_setup, NULL, NULL, 000);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/drivers/parport/init.c .26895-linux-2.5.38.updated/drivers/parport/init.c
--- .26895-linux-2.5.38/drivers/parport/init.c	2002-07-25 10:13:08.000000000 +1000
+++ .26895-linux-2.5.38.updated/drivers/parport/init.c	2002-09-25 07:17:08.000000000 +1000
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/params.h>
 
 #ifndef MODULE
 static int io[PARPORT_MAX+1] __initdata = { [0 ... PARPORT_MAX] = 0 };
@@ -44,7 +45,7 @@ static int parport_setup_ptr __initdata 
  *
  * IRQ/DMA may be numeric or 'auto' or 'none'
  */
-static int __init parport_setup (char *str)
+static int __init parport_setup(const char *str, struct kernel_param *kp)
 {
 	char *endptr;
 	char *sep;
@@ -53,24 +54,24 @@ static int __init parport_setup (char *s
 	if (!str || !*str || (*str == '0' && !*(str+1))) {
 		/* Disable parport if "parport=0" in cmdline */
 		io[0] = PARPORT_DISABLE;
-		return 1;
+		return 0;
 	}
 
 	if (!strncmp (str, "auto", 4)) {
 		irq[0] = PARPORT_IRQ_AUTO;
 		dma[0] = PARPORT_DMA_AUTO;
-		return 1;
+		return 0;
 	}
 
 	val = simple_strtoul (str, &endptr, 0);
 	if (endptr == str) {
 		printk (KERN_WARNING "parport=%s not understood\n", str);
-		return 1;
+		return 0;
 	}
 
 	if (parport_setup_ptr == PARPORT_MAX) {
 		printk(KERN_ERR "parport=%s ignored, too many ports\n", str);
-		return 1;
+		return 0;
 	}
 	
 	io[parport_setup_ptr] = val;
@@ -87,7 +88,7 @@ static int __init parport_setup (char *s
 				printk (KERN_WARNING
 					"parport=%s: irq not understood\n",
 					str);
-				return 1;
+				return 0;
 			}
 			irq[parport_setup_ptr] = val;
 		}
@@ -105,17 +106,17 @@ static int __init parport_setup (char *s
 				printk (KERN_WARNING
 					"parport=%s: dma not understood\n",
 					str);
-				return 1;
+				return -EINVAL;
 			}
 			dma[parport_setup_ptr] = val;
 		}
 	}
 
 	parport_setup_ptr++;
-	return 1;
+	return 0;
 }
 
-__setup ("parport=", parport_setup);
+PARAM_CALL(parport, parport_setup, NULL, NULL, 0);
 
 #endif
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/drivers/pci/pci.c .26895-linux-2.5.38.updated/drivers/pci/pci.c
--- .26895-linux-2.5.38/drivers/pci/pci.c	2002-09-18 16:04:01.000000000 +1000
+++ .26895-linux-2.5.38.updated/drivers/pci/pci.c	2002-09-25 07:17:08.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/params.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 
 #undef DEBUG
@@ -623,7 +624,7 @@ static int __devinit pci_init(void)
 	return 0;
 }
 
-static int __devinit pci_setup(char *str)
+static int __devinit pci_setup(const char *str, struct kernel_param *kp)
 {
 	while (str) {
 		char *k = strchr(str, ',');
@@ -635,12 +636,12 @@ static int __devinit pci_setup(char *str
 		}
 		str = k;
 	}
-	return 1;
+	return 0;
 }
 
 device_initcall(pci_init);
 
-__setup("pci=", pci_setup);
+__PARAM_CALL("", pci, pci_setup, NULL, NULL, 000);
 
 EXPORT_SYMBOL(pci_enable_device);
 EXPORT_SYMBOL(pci_disable_device);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/drivers/video/vgacon.c .26895-linux-2.5.38.updated/drivers/video/vgacon.c
--- .26895-linux-2.5.38/drivers/video/vgacon.c	2002-08-28 09:29:49.000000000 +1000
+++ .26895-linux-2.5.38.updated/drivers/video/vgacon.c	2002-09-25 07:17:08.000000000 +1000
@@ -50,6 +50,7 @@
 #include <linux/spinlock.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/params.h>
 
 #include <asm/io.h>
 
@@ -119,18 +120,18 @@ static int	       vga_video_font_height;
 static unsigned int    vga_rolled_over = 0;
 
 
-static int __init no_scroll(char *str)
+static int __init no_scroll(const char *str, struct kernel_param *kp)
 {
 	/*
 	 * Disabling scrollback is required for the Braillex ib80-piezo
 	 * Braille reader made by F.H. Papenmeier (Germany).
-	 * Use the "no-scroll" bootflag.
+	 * Use the "vgacon.no-scroll" bootflag.
 	 */
 	vga_hardscroll_user_enable = vga_hardscroll_enabled = 0;
-	return 1;
+	return 0;
 }
 
-__setup("no-scroll", no_scroll);
+PARAM_CALL(no_scroll, no_scroll, NULL, NULL, 000);
 
 /*
  * By replacing the four outb_p with two back to back outw, we can reduce
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/fs/devfs/base.c .26895-linux-2.5.38.updated/fs/devfs/base.c
--- .26895-linux-2.5.38/fs/devfs/base.c	2002-09-01 12:23:04.000000000 +1000
+++ .26895-linux-2.5.38.updated/fs/devfs/base.c	2002-09-25 07:17:08.000000000 +1000
@@ -671,6 +671,7 @@
 #include <linux/smp.h>
 #include <linux/version.h>
 #include <linux/rwsem.h>
+#include <linux/params.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -2247,7 +2248,7 @@ int devfs_only (void)
  *	@str: The boot options after the "devfs=".
  */
 
-static int __init devfs_setup (char *str)
+static int __init devfs_setup (const char *str, struct kernel_param *kp)
 {
     static struct
     {
@@ -2303,10 +2304,10 @@ static int __init devfs_setup (char *str
 	if (*str != ',') return 0;  /*  No more options  */
 	++str;
     }
-    return 1;
+    return 0;
 }   /*  End Function devfs_setup  */
 
-__setup("devfs=", devfs_setup);
+__PARAM_CALL("", devfs, devfs_setup, NULL, NULL, 000);
 
 EXPORT_SYMBOL(devfs_put);
 EXPORT_SYMBOL(devfs_register);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/fs/lockd/svc.c .26895-linux-2.5.38.updated/fs/lockd/svc.c
--- .26895-linux-2.5.38/fs/lockd/svc.c	2002-09-18 16:04:02.000000000 +1000
+++ .26895-linux-2.5.38.updated/fs/lockd/svc.c	2002-09-25 07:17:08.000000000 +1000
@@ -332,22 +332,9 @@ cleanup_module(void)
 	nlm_shutdown_hosts();
 }
 #else
-/* not a module, so process bootargs
- * lockd.udpport and lockd.tcpport
- */
 
-static int __init udpport_set(char *str)
-{
-	nlm_udpport = simple_strtoul(str, NULL, 0);
-	return 1;
-}
-static int __init tcpport_set(char *str)
-{
-	nlm_tcpport = simple_strtoul(str, NULL, 0);
-	return 1;
-}
-__setup("lockd.udpport=", udpport_set);
-__setup("lockd.tcpport=", tcpport_set);
+PARAM_NAMED(udpport, nlm_udpport, long, 000);
+PARAM_NAMED(tcpport, nlm_tcpport, long, 000);
 
 #endif
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/fs/nfs/nfsroot.c .26895-linux-2.5.38.updated/fs/nfs/nfsroot.c
--- .26895-linux-2.5.38/fs/nfs/nfsroot.c	2002-06-12 22:38:32.000000000 +1000
+++ .26895-linux-2.5.38.updated/fs/nfs/nfsroot.c	2002-09-25 07:17:08.000000000 +1000
@@ -334,7 +334,7 @@ int __init root_nfs_init(void)
  *  Parse NFS server and directory information passed on the kernel
  *  command line.
  */
-int __init nfs_root_setup(char *line)
+int __init nfs_root_setup(char *line, struct kernel_param *kp)
 {
 	ROOT_DEV = Root_NFS;
 	if (line[0] == '/' || line[0] == ',' || (line[0] >= '0' && line[0] <= '9')) {
@@ -347,10 +347,10 @@ int __init nfs_root_setup(char *line)
 		sprintf(nfs_root_name, NFS_ROOT, line);
 	}
 	root_nfs_parse_addr(nfs_root_name);
-	return 1;
+	return 0;
 }
 
-__setup("nfsroot=", nfs_root_setup);
+__PARAM_CALL("", nfsroot, nfs_root_setup, NULL, NULL, 000);
 
 /***************************************************************************
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/fs/partitions/efi.c .26895-linux-2.5.38.updated/fs/partitions/efi.c
--- .26895-linux-2.5.38/fs/partitions/efi.c	2002-07-25 10:13:15.000000000 +1000
+++ .26895-linux-2.5.38.updated/fs/partitions/efi.c	2002-09-25 07:17:08.000000000 +1000
@@ -113,14 +113,7 @@
  * the partition tables happens after init too.
  */
 static int force_gpt;
-static int __init
-force_gpt_fn(char *str)
-{
-	force_gpt = 1;
-	return 1;
-}
-__setup("gpt", force_gpt_fn);
-
+PARAM_NAMED(gpt, force_gpt, bool, 000);
 
 /**
  * efi_crc32() - EFI version of crc32 function
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/include/asm-i386/bugs.h .26895-linux-2.5.38.updated/include/asm-i386/bugs.h
--- .26895-linux-2.5.38/include/asm-i386/bugs.h	2002-06-06 12:33:24.000000000 +1000
+++ .26895-linux-2.5.38.updated/include/asm-i386/bugs.h	2002-09-25 07:17:08.000000000 +1000
@@ -22,34 +22,30 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/params.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/msr.h>
 
-static int __init no_halt(char *s)
+/* We want top level for backwards compat. */
+#undef PARAM_PREFIX
+#define PARAM_PREFIX ""
+static int __init no_halt(const char *s, struct kernel_param *kp)
 {
 	boot_cpu_data.hlt_works_ok = 0;
-	return 1;
-}
-
-__setup("no-hlt", no_halt);
-
-static int __init mca_pentium(char *s)
-{
-	mca_pentium_flag = 1;
-	return 1;
+	return 0;
 }
+PARAM_CALL(no_hlt, no_halt, NULL, NULL, 000);
+PARAM_NAMED(mca_pentium, mca_pentium_flag, bool, 000);
 
-__setup("mca-pentium", mca_pentium);
-
-static int __init no_387(char *s)
+static int __init no_387(const char *s, struct kernel_param *kp)
 {
 	boot_cpu_data.hard_math = 0;
 	write_cr0(0xE | read_cr0());
-	return 1;
+	return 0;
 }
 
-__setup("no387", no_387);
+PARAM_CALL(no387, no_387, NULL, NULL, 000);
 
 static double __initdata x = 4195835.0;
 static double __initdata y = 3145727.0;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/include/linux/init.h .26895-linux-2.5.38.updated/include/linux/init.h
--- .26895-linux-2.5.38/include/linux/init.h	2002-09-25 07:16:46.000000000 +1000
+++ .26895-linux-2.5.38.updated/include/linux/init.h	2002-09-25 07:17:08.000000000 +1000
@@ -73,20 +73,6 @@ extern initcall_t __initcall_start, __in
 #define __exitcall(fn)								\
 	static exitcall_t __exitcall_##fn __exit_call = fn
 
-/*
- * Used for kernel command line parameter setup
- */
-struct kernel_param {
-	const char *str;
-	int (*setup_func)(char *);
-};
-
-extern struct kernel_param __setup_start, __setup_end;
-
-#define __setup(str, fn)								\
-	static char __setup_str_##fn[] __initdata = str;				\
-	static struct kernel_param __setup_##fn __attribute__((unused)) __initsetup = { __setup_str_##fn, fn }
-
 #endif /* __ASSEMBLY__ */
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/include/linux/netdevice.h .26895-linux-2.5.38.updated/include/linux/netdevice.h
--- .26895-linux-2.5.38/include/linux/netdevice.h	2002-09-21 13:55:19.000000000 +1000
+++ .26895-linux-2.5.38.updated/include/linux/netdevice.h	2002-09-25 07:17:08.000000000 +1000
@@ -458,7 +458,7 @@ extern struct net_device		loopback_dev;	
 extern struct net_device		*dev_base;		/* All devices */
 extern rwlock_t				dev_base_lock;		/* Device list lock */
 
-extern int			netdev_boot_setup_add(char *name, struct ifmap *map);
+extern int			netdev_boot_setup_add(const char *name, struct ifmap *map);
 extern int 			netdev_boot_setup_check(struct net_device *dev);
 extern struct net_device    *dev_getbyhwaddr(unsigned short type, char *hwaddr);
 extern void		dev_add_pack(struct packet_type *pt);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/include/linux/pci.h .26895-linux-2.5.38.updated/include/linux/pci.h
--- .26895-linux-2.5.38/include/linux/pci.h	2002-09-18 16:04:06.000000000 +1000
+++ .26895-linux-2.5.38.updated/include/linux/pci.h	2002-09-25 07:17:08.000000000 +1000
@@ -508,7 +508,7 @@ struct pci_driver {
 
 void pcibios_fixup_bus(struct pci_bus *);
 int pcibios_enable_device(struct pci_dev *, int mask);
-char *pcibios_setup (char *str);
+char *pcibios_setup (const char *str);
 
 /* Used only when drivers/pci/setup.c is used */
 void pcibios_align_resource(void *, struct resource *,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/include/linux/security.h .26895-linux-2.5.38.updated/include/linux/security.h
--- .26895-linux-2.5.38/include/linux/security.h	2002-08-02 11:15:10.000000000 +1000
+++ .26895-linux-2.5.38.updated/include/linux/security.h	2002-09-25 07:17:08.000000000 +1000
@@ -655,6 +655,7 @@ struct swap_info_struct;
  * This is the main security structure.
  */
 struct security_operations {
+	struct module *owner;
 	int (*ptrace) (struct task_struct * parent, struct task_struct * child);
 	int (*capget) (struct task_struct * target,
 		       kernel_cap_t * effective,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/init/do_mounts.c .26895-linux-2.5.38.updated/init/do_mounts.c
--- .26895-linux-2.5.38/init/do_mounts.c	2002-09-18 16:03:31.000000000 +1000
+++ .26895-linux-2.5.38.updated/init/do_mounts.c	2002-09-25 07:17:08.000000000 +1000
@@ -19,6 +19,7 @@
 #include <linux/minix_fs.h>
 #include <linux/ext2_fs.h>
 #include <linux/romfs_fs.h>
+#include <linux/params.h>
 
 #define BUILD_CRAMDISK
 
@@ -36,17 +37,14 @@ extern asmlinkage long sys_mknod(const c
 extern asmlinkage long sys_umount(char *name, int flags);
 extern asmlinkage long sys_ioctl(int fd, int cmd, unsigned long arg);
 
+/* We want top level for backwards compatibility. */
+#undef PARAM_PREFIX
+#define PARAM_PREFIX ""
+
 #ifdef CONFIG_BLK_DEV_INITRD
 unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 static int __initdata mount_initrd = 1;
-
-static int __init no_initrd(char *str)
-{
-	mount_initrd = 0;
-	return 1;
-}
-
-__setup("noinitrd", no_initrd);
+PARAM_NAMED(noinitrd, mount_initrd, invbool, 000);
 #else
 static int __initdata mount_initrd = 0;
 #endif
@@ -61,31 +59,29 @@ dev_t ROOT_DEV;
 
 static int do_devfs = 0;
 
-static int __init load_ramdisk(char *str)
+static int __init load_ramdisk(const char *str, struct kernel_param *kp)
 {
 	rd_doload = simple_strtol(str,NULL,0) & 3;
-	return 1;
+	return 0;
 }
-__setup("load_ramdisk=", load_ramdisk);
+PARAM_CALL(load_ramdisk, load_ramdisk, NULL, NULL, 000);
 
-static int __init readonly(char *str)
+static int __init readonly(const char *str, struct kernel_param *kp)
 {
-	if (*str)
-		return 0;
+	if (str) return -EINVAL;
 	root_mountflags |= MS_RDONLY;
-	return 1;
+	return 0;
 }
 
-static int __init readwrite(char *str)
+static int __init readwrite(const char *str, struct kernel_param *kp)
 {
-	if (*str)
-		return 0;
+	if (str) return -EINVAL;
 	root_mountflags &= ~MS_RDONLY;
-	return 1;
+	return 0;
 }
 
-__setup("ro", readonly);
-__setup("rw", readwrite);
+PARAM_CALL(ro, readonly, NULL, NULL, 000);
+PARAM_CALL(rw, readwrite, NULL, NULL, 000);
 
 static struct dev_name_struct {
 	const char *name;
@@ -236,7 +232,7 @@ kdev_t __init name_to_kdev_t(char *line)
 	return to_kdev_t(base + simple_strtoul(line,NULL,base?10:16));
 }
 
-static int __init root_dev_setup(char *line)
+static int __init root_dev_setup(const char *line, struct kernel_param *kp)
 {
 	int i;
 	char ch;
@@ -250,27 +246,17 @@ static int __init root_dev_setup(char *l
 	    if ( isspace (ch) || (ch == ',') || (ch == '\0') ) break;
 	    root_device_name[i] = ch;
 	}
-	return 1;
+	return 0;
 }
 
-__setup("root=", root_dev_setup);
-
 static char * __initdata root_mount_data;
-static int __init root_data_setup(char *str)
-{
-	root_mount_data = str;
-	return 1;
-}
-
 static char * __initdata root_fs_names;
-static int __init fs_names_setup(char *str)
-{
-	root_fs_names = str;
-	return 1;
-}
 
-__setup("rootflags=", root_data_setup);
-__setup("rootfstype=", fs_names_setup);
+#undef PARAM_PREFIX
+#define PARAM_PREFIX ""
+PARAM_CALL(root, root_dev_setup, NULL, NULL, 000);
+PARAM_NAMED(rootflags, root_mount_data, charp, 000);
+PARAM_NAMED(rootfstype, root_fs_names, charp, 000);
 
 static void __init get_fs_names(char *page)
 {
@@ -402,21 +388,11 @@ static void __init change_floppy(char *f
 
 int __initdata rd_prompt = 1;	/* 1 = prompt for RAM disk, 0 = don't prompt */
 
-static int __init prompt_ramdisk(char *str)
-{
-	rd_prompt = simple_strtol(str,NULL,0) & 1;
-	return 1;
-}
-__setup("prompt_ramdisk=", prompt_ramdisk);
+PARAM_NAMED(prompt_ramdisk, rd_prompt, bool, 000);
 
 int __initdata rd_image_start;		/* starting block # of image */
 
-static int __init ramdisk_start_setup(char *str)
-{
-	rd_image_start = simple_strtol(str,NULL,0);
-	return 1;
-}
-__setup("ramdisk_start=", ramdisk_start_setup);
+PARAM_NAMED(ramdisk_start, rd_image_start, int, 000);
 
 static int __init crd_load(int in_fd, int out_fd);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/init/main.c .26895-linux-2.5.38.updated/init/main.c
--- .26895-linux-2.5.38/init/main.c	2002-09-25 07:16:46.000000000 +1000
+++ .26895-linux-2.5.38.updated/init/main.c	2002-09-25 07:17:08.000000000 +1000
@@ -43,6 +43,10 @@
 #include <asm/smp.h>
 #endif
 
+/* We don't want prefix for this file (our args are special) */
+#undef PARAM_PREFIX
+#define PARAM_PREFIX ""
+
 /*
  * Versions of gcc older than that listed below may actually compile
  * and link okay, but the end product can have subtle run time bugs.
@@ -112,50 +116,21 @@ static unsigned int max_cpus = UINT_MAX;
  * greater than 0, limits the maximum number of CPUs activated in
  * SMP mode to <NUM>.
  */
-static int __init nosmp(char *str)
+static int __init nosmp(const char *str, struct kernel_param *kp)
 {
 	max_cpus = 0;
-	return 1;
-}
-
-__setup("nosmp", nosmp);
-
-static int __init maxcpus(char *str)
-{
-	get_option(&str, &max_cpus);
-	return 1;
+	return 0;
 }
-
-__setup("maxcpus=", maxcpus);
+PARAM_CALL(nosmp, nosmp, NULL, NULL, 000);
+PARAM_NAMED(maxcpus, max_cpus, uint, 000);
+PARAM_NAMED(profile, prof_shift, ulong, 000);
 
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
 
-static int __init profile_setup(char *str)
-{
-    int par;
-    if (get_option(&str,&par)) prof_shift = par;
-	return 1;
-}
-
-__setup("profile=", profile_setup);
-
-static int __init checksetup(char *line)
-{
-	struct kernel_param *p;
-
-	p = &__setup_start;
-	do {
-		int n = strlen(p->str);
-		if (!strncmp(line,p->str,n)) {
-			if (p->setup_func(line+n))
-				return 1;
-		}
-		p++;
-	} while (p < &__setup_end);
-	return 0;
-}
-
+/* Created by linker magic */
+extern struct kernel_param __setup_start, __setup_end;
+ 
 /* this should be approx 2 Bo*oMips to start (note initial shift), and will
    still work even if initially too large, it will just take slightly longer */
 unsigned long loops_per_jiffy = (1<<12);
@@ -206,24 +181,21 @@ void __init calibrate_delay(void)
 		(loops_per_jiffy/(5000/HZ)) % 100);
 }
 
-static int __init debug_kernel(char *str)
+static int __init debug_kernel(const char *str, struct kernel_param *kp)
 {
-	if (*str)
-		return 0;
 	console_loglevel = 10;
-	return 1;
+	return 0;
 }
 
-static int __init quiet_kernel(char *str)
+static int __init quiet_kernel(const char *str, struct kernel_param *kp)
 {
-	if (*str)
-		return 0;
 	console_loglevel = 4;
-	return 1;
+	return 0;
 }
 
-__setup("debug", debug_kernel);
-__setup("quiet", quiet_kernel);
+PARAM_CALL(debug, debug_kernel, NULL, NULL, 000);
+PARAM_CALL(quiet, quiet_kernel, NULL, NULL, 000);
+PARAM_NAMED(init, execute_command, charp, 000);
 
 /* Unknown boot options get handed to init, unless they look like
    failed parameters */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/kernel/panic.c .26895-linux-2.5.38.updated/kernel/panic.c
--- .26895-linux-2.5.38/kernel/panic.c	2002-08-11 15:31:43.000000000 +1000
+++ .26895-linux-2.5.38.updated/kernel/panic.c	2002-09-25 07:17:08.000000000 +1000
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
+#include <linux/params.h>
 
 asmlinkage void sys_sync(void);	/* it's really int */
 
@@ -23,13 +24,7 @@ int panic_timeout;
 
 struct notifier_block *panic_notifier_list;
 
-static int __init panic_setup(char *str)
-{
-	panic_timeout = simple_strtoul(str, NULL, 0);
-	return 1;
-}
-
-__setup("panic=", panic_setup);
+PARAM_NAMED(timeout, panic_timeout, int, 0640);
 
 /**
  *	panic - halt the system
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/kernel/printk.c .26895-linux-2.5.38.updated/kernel/printk.c
--- .26895-linux-2.5.38/kernel/printk.c	2002-09-21 13:55:19.000000000 +1000
+++ .26895-linux-2.5.38.updated/kernel/printk.c	2002-09-25 07:17:08.000000000 +1000
@@ -27,6 +27,7 @@
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/params.h>
 
 #include <asm/uaccess.h>
 
@@ -99,7 +100,7 @@ static int console_may_schedule;
 /*
  *	Setup a list of consoles. Called from init/main.c
  */
-static int __init console_setup(char *str)
+static int __init console_setup(const char *str, struct kernel_param *kp)
 {
 	struct console_cmdline *c;
 	char name[sizeof(c->name)];
@@ -140,16 +141,16 @@ static int __init console_setup(char *st
 				return 1;
 		}
 	if (i == MAX_CMDLINECONSOLES)
-		return 1;
+		return 0;
 	preferred_console = i;
 	c = &console_cmdline[i];
 	memcpy(c->name, name, sizeof(c->name));
 	c->options = options;
 	c->index = idx;
-	return 1;
+	return 0;
 }
 
-__setup("console=", console_setup);
+__PARAM_CALL("", console, console_setup, NULL, NULL, 000);
 
 /*
  * Commands to do_syslog:
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/kernel/resource.c .26895-linux-2.5.38.updated/kernel/resource.c
--- .26895-linux-2.5.38/kernel/resource.c	2002-08-11 15:31:43.000000000 +1000
+++ .26895-linux-2.5.38.updated/kernel/resource.c	2002-09-25 07:17:08.000000000 +1000
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/params.h>
 #include <asm/io.h>
 
 struct resource ioport_resource = { "PCI IO", 0x0000, IO_SPACE_LIMIT, IORESOURCE_IO };
@@ -297,7 +298,7 @@ void __release_region(struct resource *p
  * Called from init/main.c to reserve IO ports.
  */
 #define MAXRESERVE 4
-static int __init reserve_setup(char *str)
+static int __init reserve_setup(const char *str, struct kernel_param *kp)
 {
 	static int reserved = 0;
 	static struct resource reserve[MAXRESERVE];
@@ -321,7 +322,9 @@ static int __init reserve_setup(char *st
 				reserved = x+1;
 		}
 	}
-	return 1;
+	return 0;
 }
 
-__setup("reserve=", reserve_setup);
+#undef PARAM_PREFIX
+#define PARAM_PREFIX ""
+PARAM_CALL(reserve, reserve_setup, NULL, NULL, 000);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/kernel/suspend.c .26895-linux-2.5.38.updated/kernel/suspend.c
--- .26895-linux-2.5.38/kernel/suspend.c	2002-09-21 13:55:19.000000000 +1000
+++ .26895-linux-2.5.38.updated/kernel/suspend.c	2002-09-25 07:17:08.000000000 +1000
@@ -1221,28 +1221,28 @@ read_failure:
 	return;
 }
 
-static int __init resume_setup(char *str)
+static int __init resume_setup(char *str, struct kernel_param *kp)
 {
 	if(resume_status)
-		return 1;
+		return 0;
 
 	strncpy( resume_file, str, 255 );
 	resume_status = RESUME_SPECIFIED;
 
-	return 1;
+	return 0;
 }
 
-static int __init software_noresume(char *str)
+static int __init software_noresume(char *str, struct kernel_param *kp)
 {
 	if(!resume_status)
 		printk(KERN_WARNING "noresume option lacks a resume= option\n");
 	resume_status = NORESUME;
 	
-	return 1;
+	return 0;
 }
 
-__setup("noresume", software_noresume);
-__setup("resume=", resume_setup);
+PARAM_CALL(noresume, software_noresume, NULL, NULL, 000);
+PARAM_CALL(resume, resume_setup, NULL, NULL, 000);
 
 EXPORT_SYMBOL(software_suspend);
 EXPORT_SYMBOL(software_suspend_enabled);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/mm/page_alloc.c .26895-linux-2.5.38.updated/mm/page_alloc.c
--- .26895-linux-2.5.38/mm/page_alloc.c	2002-09-21 13:55:19.000000000 +1000
+++ .26895-linux-2.5.38.updated/mm/page_alloc.c	2002-09-25 07:17:08.000000000 +1000
@@ -24,6 +24,7 @@
 #include <linux/suspend.h>
 #include <linux/pagevec.h>
 #include <linux/blkdev.h>
+#include <linux/params.h>
 
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
@@ -949,7 +950,7 @@ void __init free_area_init(unsigned long
 }
 #endif
 
-static int __init setup_mem_frac(char *str)
+static int __init setup_mem_frac(const char *str, struct kernel_param *kp)
 {
 	int j = 0;
 
@@ -957,7 +958,7 @@ static int __init setup_mem_frac(char *s
 	printk("setup_mem_frac: ");
 	for (j = 0; j < MAX_NR_ZONES; j++) printk("%d  ", zone_balance_ratio[j]);
 	printk("\n");
-	return 1;
+	return 0;
 }
 
-__setup("memfrac=", setup_mem_frac);
+__PARAM_CALL("", memfrac, setup_mem_frac, NULL, NULL, 000);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/net/core/dev.c .26895-linux-2.5.38.updated/net/core/dev.c
--- .26895-linux-2.5.38/net/core/dev.c	2002-09-21 13:55:20.000000000 +1000
+++ .26895-linux-2.5.38.updated/net/core/dev.c	2002-09-25 07:17:08.000000000 +1000
@@ -105,6 +105,7 @@
 #include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/module.h>
+#include <linux/params.h>
 #if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
 #include <net/iw_handler.h>
@@ -316,7 +317,7 @@ static struct netdev_boot_setup dev_boot
  *	returns 0 on error and 1 on success.  This is a generic routine to
  *	all netdevices.
  */
-int netdev_boot_setup_add(char *name, struct ifmap *map)
+int netdev_boot_setup_add(const char *name, struct ifmap *map)
 {
 	struct netdev_boot_setup *s;
 	int i;
@@ -331,7 +332,7 @@ int netdev_boot_setup_add(char *name, st
 		}
 	}
 
-	return i >= NETDEV_BOOT_SETUP_MAX ? 0 : 1;
+	return i >= NETDEV_BOOT_SETUP_MAX ? -ENOSPC : 0;
 }
 
 /**
@@ -364,7 +365,7 @@ int netdev_boot_setup_check(struct net_d
 /*
  * Saves at boot time configured settings for any netdevice.
  */
-int __init netdev_boot_setup(char *str)
+int __init netdev_boot_setup(const char *str, struct kernel_param *kp)
 {
 	int ints[5];
 	struct ifmap map;
@@ -388,7 +389,8 @@ int __init netdev_boot_setup(char *str)
 	return netdev_boot_setup_add(str, &map);
 }
 
-__setup("netdev=", netdev_boot_setup);
+/* We want top level for backwards compat. */
+__PARAM_CALL("", netdev, netdev_boot_setup, NULL, NULL, 000);
 
 /*******************************************************************************
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/net/ethernet/eth.c .26895-linux-2.5.38.updated/net/ethernet/eth.c
--- .26895-linux-2.5.38/net/ethernet/eth.c	2001-03-03 11:02:48.000000000 +1100
+++ .26895-linux-2.5.38.updated/net/ethernet/eth.c	2002-09-25 07:17:08.000000000 +1000
@@ -52,6 +52,7 @@
 #include <linux/errno.h>
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/params.h>
 #include <net/dst.h>
 #include <net/arp.h>
 #include <net/sock.h>
@@ -61,9 +62,10 @@
 #include <asm/system.h>
 #include <asm/checksum.h>
 
-extern int __init netdev_boot_setup(char *str);
+extern int __init netdev_boot_setup(const char *str, struct kernel_param *kp);
 
-__setup("ether=", netdev_boot_setup);
+/* We want top level for backwards compat. */
+__PARAM_CALL("", ether, netdev_boot_setup, NULL, NULL, 000);
 
 /*
  *	 Create the Ethernet MAC header for an arbitrary protocol layer 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26895-linux-2.5.38/net/ipv4/ipconfig.c .26895-linux-2.5.38.updated/net/ipv4/ipconfig.c
--- .26895-linux-2.5.38/net/ipv4/ipconfig.c	2002-08-28 09:29:54.000000000 +1000
+++ .26895-linux-2.5.38.updated/net/ipv4/ipconfig.c	2002-09-25 07:17:08.000000000 +1000
@@ -1320,7 +1320,7 @@ static int __init ic_proto_name(char *na
 	return 0;
 }
 
-static int __init ip_auto_config_setup(char *addrs)
+static int __init ip_auto_config_setup(char *addrs, struct kernel_param *kp)
 {
 	char *cp, *ip, *dp;
 	int num = 0;
@@ -1331,10 +1331,10 @@ static int __init ip_auto_config_setup(c
 		(strcmp(addrs, "off") != 0) && 
 		(strcmp(addrs, "none") != 0));
 	if (!ic_enable)
-		return 1;
+		return 0;
 
 	if (ic_proto_name(addrs))
-		return 1;
+		return 0;
 
 	/* Parse the whole string */
 	ip = addrs;
@@ -1383,7 +1383,7 @@ static int __init ip_auto_config_setup(c
 		num++;
 	}
 
-	return 1;
+	return 0;
 }
 
 static int __init nfsaddrs_config_setup(char *addrs)
@@ -1391,5 +1391,9 @@ static int __init nfsaddrs_config_setup(
 	return ip_auto_config_setup(addrs);
 }
 
-__setup("ip=", ip_auto_config_setup);
-__setup("nfsaddrs=", nfsaddrs_config_setup);
+/* We want top level for backwards compat. */
+#undef PARAM_PREFIX
+#define PARAM_PREFIX ""
+
+PARAM_CALL(ip, ip_auto_config_setup, NULL, NULL, 000);
+PARAM_CALL(nfsaddrs, nfsaddrs_config_setup, NULL, NULL, 000);
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
