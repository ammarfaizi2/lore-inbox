Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267365AbSLRWK6>; Wed, 18 Dec 2002 17:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267361AbSLRWG6>; Wed, 18 Dec 2002 17:06:58 -0500
Received: from air-2.osdl.org ([65.172.181.6]:58521 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267365AbSLRWGW>;
	Wed, 18 Dec 2002 17:06:22 -0500
Subject: [PATCH] (2/5) improved notifier callback mechanism -
	register_panic_notifier
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1040249647.14363.188.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 14:14:07 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the interface to panic_notifier_list by creating
register and unregister functions. This interface is used mainly on
platforms that I don't have ability to test.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.981   -> 1.982  
#	include/linux/kernel.h	1.29    -> 1.30   
#	      kernel/ksyms.c	1.170   -> 1.171  
#	arch/um/drivers/mconsole_kern.c	1.4     -> 1.5    
#	drivers/parisc/power.c	1.2     -> 1.3    
#	include/linux/notifier.h	1.4     -> 1.5    
#	arch/alpha/kernel/setup.c	1.23    -> 1.24   
#	arch/mips/sgi/kernel/reset.c	1.2     -> 1.3    
#	arch/parisc/kernel/pdc_chassis.c	1.2     -> 1.3    
#	arch/mips64/sgi-ip22/ip22-reset.c	1.2     -> 1.3    
#	arch/um/kernel/um_arch.c	1.4     -> 1.5    
#	      kernel/panic.c	1.8     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/17	shemminger@osdl.org	1.982
# Add register_panic_notifier
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
--- a/arch/alpha/kernel/setup.c	Tue Dec 17 16:23:02 2002
+++ b/arch/alpha/kernel/setup.c	Tue Dec 17 16:23:02 2002
@@ -43,12 +43,10 @@
 #endif
 
 #include <linux/notifier.h>
-extern struct notifier_block *panic_notifier_list;
 static int alpha_panic_event(struct notifier_block *, unsigned long,
void *);
 static struct notifier_block alpha_panic_block = {
-	alpha_panic_event,
-        NULL,
-        INT_MAX /* try to do it first */
+	.notifier_call = alpha_panic_event,
+        .priority = INT_MAX, /* try to do it first */
 };
 
 #include <asm/uaccess.h>
@@ -507,7 +505,7 @@
 	boot_cpuid = hard_smp_processor_id();
 
 	/* Register a call for panic conditions. */
-	notifier_chain_register(&panic_notifier_list, &alpha_panic_block);
+	register_panic_notifier(&alpha_panic_block);
 
 #ifdef CONFIG_ALPHA_GENERIC
 	/* Assume that we've booted from SRM if we havn't booted from MILO.
diff -Nru a/arch/mips/sgi/kernel/reset.c b/arch/mips/sgi/kernel/reset.c
--- a/arch/mips/sgi/kernel/reset.c	Tue Dec 17 16:23:02 2002
+++ b/arch/mips/sgi/kernel/reset.c	Tue Dec 17 16:23:03 2002
@@ -217,9 +217,7 @@
 }
 
 static struct notifier_block panic_block = {
-	panic_event,
-	NULL,
-	0
+	.notifier_call = panic_event,
 };
 
 void indy_reboot_setup(void)
@@ -237,5 +235,5 @@
 	request_irq(SGI_PANEL_IRQ, panel_int, 0, "Front Panel", NULL);
 	init_timer(&blink_timer);
 	blink_timer.function = blink_timeout;
-	notifier_chain_register(&panic_notifier_list, &panic_block);
+	register_panic_notifier(&panic_block);
 }
diff -Nru a/arch/mips64/sgi-ip22/ip22-reset.c
b/arch/mips64/sgi-ip22/ip22-reset.c
--- a/arch/mips64/sgi-ip22/ip22-reset.c	Tue Dec 17 16:23:03 2002
+++ b/arch/mips64/sgi-ip22/ip22-reset.c	Tue Dec 17 16:23:03 2002
@@ -218,9 +218,7 @@
 }
 
 static struct notifier_block panic_block = {
-	panic_event,
-	NULL,
-	0
+	.notifier_call = panic_event,
 };
 
 void ip22_reboot_setup(void)
@@ -234,5 +232,5 @@
 	request_irq(9, panel_int, 0, "Front Panel", NULL);
 	init_timer(&blink_timer);
 	blink_timer.function = blink_timeout;
-	notifier_chain_register(&panic_notifier_list, &panic_block);
+	register_panic_notifier(&panic_block);
 }
diff -Nru a/arch/parisc/kernel/pdc_chassis.c
b/arch/parisc/kernel/pdc_chassis.c
--- a/arch/parisc/kernel/pdc_chassis.c	Tue Dec 17 16:23:03 2002
+++ b/arch/parisc/kernel/pdc_chassis.c	Tue Dec 17 16:23:03 2002
@@ -113,7 +113,7 @@
 	DPRINTK(KERN_DEBUG "%s: parisc_pdc_chassis_init()\n", __FILE__);
 
 	/* initialize panic notifier chain */
-	notifier_chain_register(&panic_notifier_list,
&pdc_chassis_panic_block);
+	register_panic_notifier(&pdc_chassis_panic_block);
 
 	/* initialize reboot notifier chain */
 	register_reboot_notifier(&pdc_chassis_reboot_block);
diff -Nru a/arch/um/drivers/mconsole_kern.c
b/arch/um/drivers/mconsole_kern.c
--- a/arch/um/drivers/mconsole_kern.c	Tue Dec 17 16:23:02 2002
+++ b/arch/um/drivers/mconsole_kern.c	Tue Dec 17 16:23:02 2002
@@ -362,14 +362,13 @@
 }
 
 static struct notifier_block panic_exit_notifier = {
-	notifier_call :		notify_panic,
-	next :			NULL,
-	priority :		1
+	.notifier_call =	notify_panic,
+	.priority =		1,
 };
 
 static int add_notifier(void)
 {
-	notifier_chain_register(&panic_notifier_list, &panic_exit_notifier);
+	register_panic_notifier(&panic_exit_notifier);
 	return(0);
 }
 
diff -Nru a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
--- a/arch/um/kernel/um_arch.c	Tue Dec 17 16:23:03 2002
+++ b/arch/um/kernel/um_arch.c	Tue Dec 17 16:23:03 2002
@@ -356,14 +356,12 @@
 }
 
 static struct notifier_block panic_exit_notifier = {
-	notifier_call :		panic_exit,
-	next :			NULL,
-	priority :		0
+	.notifier_call = panic_exit,
 };
 
 void __init setup_arch(char **cmdline_p)
 {
-	notifier_chain_register(&panic_notifier_list, &panic_exit_notifier);
+	register_panic_notifier(&panic_exit_notifier);
 	paging_init();
  	strcpy(command_line, saved_command_line);
  	*cmdline_p = command_line;
diff -Nru a/drivers/parisc/power.c b/drivers/parisc/power.c
--- a/drivers/parisc/power.c	Tue Dec 17 16:23:02 2002
+++ b/drivers/parisc/power.c	Tue Dec 17 16:23:02 2002
@@ -342,7 +342,7 @@
 	}
 
 	/* Register a call for panic conditions. */
-	notifier_chain_register(&panic_notifier_list, &parisc_panic_block);
+	register_panic_notifier(&parisc_panic_block);
 
 	power_create_procfs();
 	tasklet_enable(&power_tasklet);
@@ -356,7 +356,7 @@
 		return;
 
 	tasklet_disable(&power_tasklet);
-	notifier_chain_unregister(&panic_notifier_list, &parisc_panic_block);
+	register_panic_notifier(&parisc_panic_block);
 	power_remove_procfs();
 	power_tasklet.func = NULL;
 	pdc_soft_power_button(0);
diff -Nru a/include/linux/kernel.h b/include/linux/kernel.h
--- a/include/linux/kernel.h	Tue Dec 17 16:23:02 2002
+++ b/include/linux/kernel.h	Tue Dec 17 16:23:02 2002
@@ -54,7 +54,6 @@
 #define might_sleep() do {} while(0)
 #endif
 
-extern struct notifier_block *panic_notifier_list;
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
 asmlinkage NORET_TYPE void do_exit(long error_code)
diff -Nru a/include/linux/notifier.h b/include/linux/notifier.h
--- a/include/linux/notifier.h	Tue Dec 17 16:23:02 2002
+++ b/include/linux/notifier.h	Tue Dec 17 16:23:02 2002
@@ -25,6 +25,9 @@
 extern int notifier_chain_unregister(struct notifier_block **nl, struct
notifier_block *n);
 extern int notifier_call_chain(struct notifier_block **n, unsigned long
val, void *v);
 
+extern int register_panic_notifier(struct notifier_block *);
+extern int unregister_panic_notifier(struct notifier_block *);
+
 #define NOTIFY_DONE		0x0000		/* Don't care */
 #define NOTIFY_OK		0x0001		/* Suits me */
 #define NOTIFY_STOP_MASK	0x8000		/* Don't call further */
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Tue Dec 17 16:23:02 2002
+++ b/kernel/ksyms.c	Tue Dec 17 16:23:02 2002
@@ -55,6 +55,7 @@
 #include <linux/dnotify.h>
 #include <linux/mount.h>
 #include <linux/ptrace.h>
+#include <linux/notifier.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -521,6 +522,8 @@
 EXPORT_SYMBOL(seq_lseek);
 EXPORT_SYMBOL(single_open);
 EXPORT_SYMBOL(single_release);
+EXPORT_SYMBOL(register_panic_notifier);
+EXPORT_SYMBOL(unregister_panic_notifier);
 
 /* Program loader interfaces */
 EXPORT_SYMBOL(setup_arg_pages);
diff -Nru a/kernel/panic.c b/kernel/panic.c
--- a/kernel/panic.c	Tue Dec 17 16:23:03 2002
+++ b/kernel/panic.c	Tue Dec 17 16:23:03 2002
@@ -21,7 +21,19 @@
 
 int panic_timeout;
 
-struct notifier_block *panic_notifier_list;
+static struct notifier_block *panic_notifier_list;
+
+int register_panic_notifier(struct notifier_block * nb)
+{
+	return notifier_chain_register(&panic_notifier_list, nb);
+}
+
+
+int unregister_panic_notifier(struct notifier_block * nb)
+{
+	return notifier_chain_unregister(&panic_notifier_list, nb);
+}
+
 
 static int __init panic_setup(char *str)
 {



