Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbWF0OtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbWF0OtU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 10:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030643AbWF0OtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 10:49:19 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:7105 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030207AbWF0OtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 10:49:19 -0400
Subject: Re: the creation of boot_cpu_init() is wrong and accessing
	uninitialised data
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: stsp@aknet.ru, linux-kernel@vger.kernel.org
In-Reply-To: <20060626220337.06014184.akpm@osdl.org>
References: <1151376313.3443.12.camel@mulgrave.il.steeleye.com>
	 <20060626200433.bf0292af.akpm@osdl.org>
	 <1151379392.3443.20.camel@mulgrave.il.steeleye.com>
	 <20060626220337.06014184.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 09:49:06 -0500
Message-Id: <1151419746.3340.13.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 22:03 -0700, Andrew Morton wrote:
> Well.  It's the assembly code which chose to call start_kernel().  It could
> call something else.

arch_start_kernel maybe?  I still think that's a bit of a non-obvious
alteration to a very well ingrained existing procedure.

> > > A less wholesome but perhaps simpler solution would be to call the new
> > > setup_smp_processor_id() on entry to start_kernel().
> > 
> > I was wondering about simply replacing boot_cpu_init() with
> > smp_prepare_boot_cpu().  By and large they do the same thing on most
> > archs, and mostly they don't seem to depend on setup_arch() having been
> > called.
> 
> That won't fix the other bugs - we're presently calling printk() prior to
> setup_arch(), and printk uses smp_procesor_id().

No, I mean call smp_prepare_boot_cpu() where boot_cpu_init() is now
(i.e. *before* setup_arch).  On all the arch's I know (parisc, i386 and
voyager) this function does nothing but set up the cpu map as
boot_cpu_init() does.  Of course, this change would break any arch that
relied on setup_arch() being called before smp_prepare_boot_cpu() ...

> > However, introducing setup_smp_processor_id() will also work ... I'll
> > see if I can do it in an easy way.
> 
> It's a bit odd - I think non-zero BSPs happen a bit more often than
> only-on-voyager.

OK, here's the patch that adds this API then.

James

Index: voyager-init-2.6/include/linux/smp.h
===================================================================
--- voyager-init-2.6.orig/include/linux/smp.h	2006-06-27 09:20:42.000000000 -0500
+++ voyager-init-2.6/include/linux/smp.h	2006-06-27 09:23:23.000000000 -0500
@@ -74,6 +74,15 @@
  */
 void smp_prepare_boot_cpu(void);
 
+/*
+ * Some architectures use current_thread_info()->cpu to get the
+ * CPU, so for the boot CPU this has to be set up really early.  Thus
+ * this hook is used to initialise the value if necessary
+ */
+#ifndef ARCH_HAS_SMP_SETUP_PROCESSOR_ID
+void smp_setup_processor_id(void) { }
+#endif
+
 #else /* !SMP */
 
 /*
@@ -96,6 +105,7 @@
 static inline void smp_send_reschedule(int cpu) { }
 #define num_booting_cpus()			1
 #define smp_prepare_boot_cpu()			do {} while (0)
+#define smp_setup_processor_id()		do {} while (0)
 
 #endif /* !SMP */
 
Index: voyager-init-2.6/init/main.c
===================================================================
--- voyager-init-2.6.orig/init/main.c	2006-06-27 09:19:12.000000000 -0500
+++ voyager-init-2.6/init/main.c	2006-06-27 09:20:30.000000000 -0500
@@ -455,6 +455,7 @@
  * enable them
  */
 	lock_kernel();
+	smp_setup_processor_id();
 	boot_cpu_init();
 	page_address_init();
 	printk(KERN_NOTICE);
Index: voyager-init-2.6/include/asm-i386/smp.h
===================================================================
--- voyager-init-2.6.orig/include/asm-i386/smp.h	2006-06-27 09:23:38.000000000 -0500
+++ voyager-init-2.6/include/asm-i386/smp.h	2006-06-27 09:24:29.000000000 -0500
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/cpumask.h>
+#include "mach_smp.h"
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
Index: voyager-init-2.6/include/asm-i386/mach-default/mach_smp.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ voyager-init-2.6/include/asm-i386/mach-default/mach_smp.h	2006-06-27 09:42:16.000000000 -0500
@@ -0,0 +1,13 @@
+/*
+ * include/asm-i386/mach-default/mach_smp.h
+ *
+ * Machine specific SMP definitions
+ */
+#ifndef _MACH_SMP_H
+/*
+ * The boot CPU is always zero for apic based systems
+ */
+#define ARCH_HAS_SMP_SETUP_PROCESSOR_ID
+#define smp_setup_processor_id() \
+	do { current_thread_info()->cpu = 0; } while (0)
+#endif
Index: voyager-init-2.6/include/asm-i386/mach-voyager/mach_smp.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ voyager-init-2.6/include/asm-i386/mach-voyager/mach_smp.h	2006-06-27 09:30:30.000000000 -0500
@@ -0,0 +1,9 @@
+/*
+ * include/asm-i386/mach-voyager/mach_smp.h
+ *
+ * Machine specific SMP definitions
+ */
+#ifndef _MACH_SMP_H
+#define ARCH_HAS_SMP_SETUP_PROCESSOR_ID
+extern void smp_setup_processor_id(void);
+#endif
Index: voyager-init-2.6/arch/i386/mach-voyager/voyager_smp.c
===================================================================
--- voyager-init-2.6.orig/arch/i386/mach-voyager/voyager_smp.c	2006-06-27 09:30:46.000000000 -0500
+++ voyager-init-2.6/arch/i386/mach-voyager/voyager_smp.c	2006-06-27 09:31:44.000000000 -0500
@@ -1916,6 +1916,12 @@
 	cpu_set(smp_processor_id(), cpu_present_map);
 }
 
+void __init
+smp_setup_processor_id(void)
+{
+	current_thread_info()->cpu = hard_smp_processor_id();
+}
+
 int __devinit
 __cpu_up(unsigned int cpu)
 {


