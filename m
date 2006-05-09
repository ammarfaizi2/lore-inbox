Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWEIU5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWEIU5n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWEIU5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:57:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14301 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750779AbWEIU5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:57:13 -0400
From: dzickus <dzickus@redhat.com>
Message-Id: <20060509205958.578466000@drseuss.boston.redhat.com>
References: <20060509205035.446349000@drseuss.boston.redhat.com>
User-Agent: quilt/0.45-1
Date: Tue, 09 May 2006 16:50:43 -0400
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, oprofile-list@lists.sourceforge.net, dzickus@redhat.com
Subject: [patch 8/8] Add abilty to enable/disable nmi watchdog from sysfs
Content-Disposition: inline; filename=nmi-x86-sysctl-nmi-switch.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds a new /proc/sys/kernel/nmi call that will enable/disable the nmi
watchdog.

Signed-off-by:  Don Zickus <dzickus@redhat.com>

Index: linux-don/arch/i386/kernel/nmi.c
===================================================================
--- linux-don.orig/arch/i386/kernel/nmi.c
+++ linux-don/arch/i386/kernel/nmi.c
@@ -845,6 +845,56 @@ static int unknown_nmi_panic_callback(st
 	return 0;
 }
 
+/*
+ * proc handler for /proc/sys/kernel/nmi
+ */
+int proc_nmi_enabled(struct ctl_table *table, int write, struct file *file,
+			void __user *buffer, size_t *length, loff_t *ppos)
+{
+	int old_state;
+
+	nmi_watchdog_enabled = (atomic_read(&nmi_active) > 0) ? 1 : 0;
+	old_state = nmi_watchdog_enabled;
+	proc_dointvec(table, write, file, buffer, length, ppos);
+	if (!!old_state == !!nmi_watchdog_enabled)
+		return 0;
+
+	if (atomic_read(&nmi_active) < 0) {
+		printk( KERN_WARNING "NMI watchdog is permanently disabled\n");
+		return 0;
+	}
+
+	if (nmi_watchdog == NMI_DEFAULT) {
+		if (nmi_known_cpu() > 0)
+			nmi_watchdog = NMI_LOCAL_APIC;
+		else
+			nmi_watchdog = NMI_IO_APIC;
+	}
+
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+	{
+		if (nmi_watchdog_enabled)
+			enable_lapic_nmi_watchdog();
+		else
+			disable_lapic_nmi_watchdog();
+	} else if (nmi_watchdog == NMI_IO_APIC) {
+		/* FIXME
+		 * for some reason these functions don't work
+		 */
+		printk("Can not enable/disable NMI on IO APIC\n");
+		return 0;
+		/*if (nmi_watchdog_enabled)
+			enable_timer_nmi_watchdog();
+		else
+			disable_timer_nmi_watchdog();
+		*/
+	} else {
+		printk( KERN_WARNING
+			"NMI watchdog doesn't know what hardware to touch\n");
+	}
+	return 0;
+}
+
 #endif
 
 EXPORT_SYMBOL(nmi_active);
Index: linux-don/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-don.orig/arch/x86_64/kernel/nmi.c
+++ linux-don/arch/x86_64/kernel/nmi.c
@@ -751,6 +751,52 @@ static int unknown_nmi_panic_callback(st
 	return 0;
 }
 
+/*
+ * proc handler for /proc/sys/kernel/nmi
+ */
+int proc_nmi_enabled(struct ctl_table *table, int write, struct file *file,
+			void __user *buffer, size_t *length, loff_t *ppos)
+{
+	int old_state;
+
+	nmi_watchdog_enabled = (atomic_read(&nmi_active) > 0) ? 1 : 0;
+	old_state = nmi_watchdog_enabled;
+	proc_dointvec(table, write, file, buffer, length, ppos);
+	if (!!old_state == !!nmi_watchdog_enabled)
+		return 0;
+
+	if (atomic_read(&nmi_active) < 0) {
+		printk( KERN_WARNING "NMI watchdog is permanently disabled\n");
+		return 0;
+	}
+
+	/* if nmi_watchdog is not set yet, then set it */
+	nmi_watchdog_default();
+
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+	{
+		if (nmi_watchdog_enabled)
+			enable_lapic_nmi_watchdog();
+		else
+			disable_lapic_nmi_watchdog();
+	} else if (nmi_watchdog == NMI_IO_APIC) {
+		/* FIXME
+		 * for some reason these functions don't work
+		 */
+		printk("Can not enable/disable NMI on IO APIC\n");
+		return 0;
+		/*if (nmi_watchdog_enabled)
+			enable_timer_nmi_watchdog();
+		else
+			disable_timer_nmi_watchdog();
+		*/
+	} else {
+		printk( KERN_WARNING
+			"NMI watchdog doesn't know what hardware to touch\n");
+	}
+	return 0;
+}
+
 #endif
 
 EXPORT_SYMBOL(nmi_active);
Index: linux-don/include/asm-i386/nmi.h
===================================================================
--- linux-don.orig/include/asm-i386/nmi.h
+++ linux-don/include/asm-i386/nmi.h
@@ -14,6 +14,7 @@
  */
 int do_nmi_callback(struct pt_regs *regs, int cpu);
 
+extern int nmi_watchdog_enabled;
 extern int avail_to_resrv_perfctr_nmi_bit(unsigned int);
 extern int avail_to_resrv_perfctr_nmi(unsigned int);
 extern int reserve_perfctr_nmi(unsigned int);
Index: linux-don/include/asm-x86_64/nmi.h
===================================================================
--- linux-don.orig/include/asm-x86_64/nmi.h
+++ linux-don/include/asm-x86_64/nmi.h
@@ -43,6 +43,7 @@ extern void die_nmi(char *str, struct pt
 
 extern int panic_on_timeout;
 extern int unknown_nmi_panic;
+extern int nmi_watchdog_enabled;
 
 extern int check_nmi_watchdog(void);
 extern int avail_to_resrv_perfctr_nmi_bit(unsigned int);
Index: linux-don/include/linux/sysctl.h
===================================================================
--- linux-don.orig/include/linux/sysctl.h
+++ linux-don/include/linux/sysctl.h
@@ -148,6 +148,7 @@ enum
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
+	KERN_NMI_ENABLED=73, /* int: enable/disable nmi watchdog */
 };
 
 
Index: linux-don/kernel/sysctl.c
===================================================================
--- linux-don.orig/kernel/sysctl.c
+++ linux-don/kernel/sysctl.c
@@ -75,6 +75,9 @@ extern int percpu_pagelist_fraction;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
+int nmi_watchdog_enabled;
+extern int proc_nmi_enabled(struct ctl_table *, int , struct file *,
+			void __user *, size_t *, loff_t *);
 #endif
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
@@ -630,6 +633,14 @@ static ctl_table kern_table[] = {
 		.mode           = 0644,
 		.proc_handler   = &proc_dointvec,
 	},
+	{
+		.ctl_name       = KERN_NMI_ENABLED,
+		.procname       = "nmi",
+		.data           = &nmi_watchdog_enabled,
+		.maxlen         = sizeof (int),
+		.mode           = 0644,
+		.proc_handler   = &proc_nmi_enabled,
+	},
 #endif
 #if defined(CONFIG_X86)
 	{

--
