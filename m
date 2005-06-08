Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVFHDOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVFHDOg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 23:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVFHDOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 23:14:25 -0400
Received: from fmr17.intel.com ([134.134.136.16]:47038 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262079AbVFHDN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 23:13:58 -0400
Message-Id: <20050608031217.385798000@araj-em64t>
References: <20050608030901.001736000@araj-em64t>
Date: Tue, 07 Jun 2005 20:09:02 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>,
       Shaohua Li <shaohua.li@intel.com>,
       Rusty Russell <rusty@rustycorp.com.au>, Ashok Raj <ashok.raj@intel.com>
Subject: [patch 1/2] i386: Dont use IPI broadcast when using cpu hotplug.
Content-Disposition: inline; filename=i386-dont-use-ipi-broadcast.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a startup parameter no_broadcast. When we 
enable CONFIG_HOTPLUG_CPU, we dont want to use broadcast shortcut as it
has ill effects on a offline cpu. If we issue broadcast, the IPI is also
delivered to offline cpus, or partially up cpu causing stale IPI's to be
handled, which is a problem and can cause undesirable effects.

Introduces a new startup cmdline option no_ipi_broadcast, that can be
switched at cmdline if necessary.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Acked-by: Shaohua Li <shaohua.li@intel.com>
----------------------------------------------------
 arch/i386/mach-default/setup.c           |   27 +++++++++++++++++++++++++++
 include/asm-i386/mach-default/mach_ipi.h |   27 +++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc6-mm1/include/asm-i386/mach-default/mach_ipi.h
===================================================================
--- linux-2.6.12-rc6-mm1.orig/include/asm-i386/mach-default/mach_ipi.h
+++ linux-2.6.12-rc6-mm1/include/asm-i386/mach-default/mach_ipi.h
@@ -4,11 +4,34 @@
 void send_IPI_mask_bitmask(cpumask_t mask, int vector);
 void __send_IPI_shortcut(unsigned int shortcut, int vector);
 
+extern int no_broadcast;
+
 static inline void send_IPI_mask(cpumask_t mask, int vector)
 {
 	send_IPI_mask_bitmask(mask, vector);
 }
 
+static inline void __local_send_IPI_allbutself(int vector)
+{
+	if (no_broadcast) {
+		cpumask_t mask = cpu_online_map;
+		int this_cpu = get_cpu();
+
+		cpu_clear(this_cpu, mask);
+		send_IPI_mask(mask, vector);
+		put_cpu();
+	} else
+		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
+}
+
+static inline void __local_send_IPI_all(int vector)
+{
+	if (no_broadcast)
+		send_IPI_mask(cpu_online_map, vector);
+	else
+		__send_IPI_shortcut(APIC_DEST_ALLINC, vector);
+}
+
 static inline void send_IPI_allbutself(int vector)
 {
 	/*
@@ -18,13 +41,13 @@ static inline void send_IPI_allbutself(i
 	if (!(num_online_cpus() > 1))
 		return;
 
-	__send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
+	__local_send_IPI_allbutself(vector);
 	return;
 }
 
 static inline void send_IPI_all(int vector)
 {
-	__send_IPI_shortcut(APIC_DEST_ALLINC, vector);
+	__local_send_IPI_all(vector);
 }
 
 #endif /* __ASM_MACH_IPI_H */
Index: linux-2.6.12-rc6-mm1/arch/i386/mach-default/setup.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/i386/mach-default/setup.c
+++ linux-2.6.12-rc6-mm1/arch/i386/mach-default/setup.c
@@ -10,6 +10,14 @@
 #include <asm/acpi.h>
 #include <asm/arch_hooks.h>
 
+#ifdef CONFIG_HOTPLUG_CPU
+#define DEFAULT_SEND_IPI	(1)
+#else
+#define DEFAULT_SEND_IPI	(0)
+#endif
+
+int no_broadcast=DEFAULT_SEND_IPI;
+
 /**
  * pre_intr_init_hook - initialisation prior to setting up interrupt vectors
  *
@@ -104,3 +112,22 @@ void __init mca_nmi_hook(void)
 	printk("NMI generated from unknown source!\n");
 }
 #endif
+
+static __init int no_ipi_broadcast(char *str)
+{
+	get_option(&str, &no_broadcast);
+	printk ("Using %s mode\n", no_broadcast ? "No IPI Broadcast" :
+											"IPI Broadcast");
+	return 1;
+}
+
+__setup("no_ipi_broadcast", no_ipi_broadcast);
+
+static int __init print_ipi_mode(void)
+{
+	printk ("Using IPI %s mode\n", no_broadcast ? "No-Shortcut" :
+											"Shortcut");
+	return 0;
+}
+
+late_initcall(print_ipi_mode);

--

