Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbWHJUMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbWHJUMg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbWHJTgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:3819 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932140AbWHJTf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:27 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [13/145] x86_64: Add abilty to enable/disable nmi watchdog with sysctl
Message-Id: <20060810193525.B5A4813B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:25 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: dzickus <dzickus@redhat.com>

Adds a new /proc/sys/kernel/nmi call that will enable/disable the nmi
watchdog.

Signed-off-by:  Don Zickus <dzickus@redhat.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/nmi.c   |   52 +++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86_64/kernel/nmi.c |   48 +++++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/nmi.h   |    1 
 include/asm-x86_64/nmi.h |    1 
 include/linux/sysctl.h   |    1 
 kernel/sysctl.c          |   11 +++++++++
 6 files changed, 114 insertions(+)

Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -846,6 +846,58 @@ static int unknown_nmi_panic_callback(st
 	return 0;
 }
 
+/*
+ * proc handler for /proc/sys/kernel/nmi_watchdog
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
+		printk(KERN_WARNING "NMI watchdog is permanently disabled\n");
+		return -EINVAL;
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
+		return -EINVAL;
+#if 0
+		if (nmi_watchdog_enabled)
+			enable_timer_nmi_watchdog();
+		else
+			disable_timer_nmi_watchdog();
+#endif
+	} else {
+		printk( KERN_WARNING
+			"NMI watchdog doesn't know what hardware to touch\n");
+		return -EIO;
+	}
+	return 0;
+}
+
 #endif
 
 EXPORT_SYMBOL(nmi_active);
Index: linux/arch/x86_64/kernel/nmi.c
===================================================================
--- linux.orig/arch/x86_64/kernel/nmi.c
+++ linux/arch/x86_64/kernel/nmi.c
@@ -750,6 +750,54 @@ static int unknown_nmi_panic_callback(st
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
+		return -EINVAL;
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
+		return -EIO;
+#if 0
+		if (nmi_watchdog_enabled)
+			enable_timer_nmi_watchdog();
+		else
+			disable_timer_nmi_watchdog();
+#endif
+	} else {
+		printk(KERN_WARNING
+			"NMI watchdog doesn't know what hardware to touch\n");
+		return -EIO;
+	}
+	return 0;
+}
+
 #endif
 
 EXPORT_SYMBOL(nmi_active);
Index: linux/include/asm-i386/nmi.h
===================================================================
--- linux.orig/include/asm-i386/nmi.h
+++ linux/include/asm-i386/nmi.h
@@ -14,6 +14,7 @@
  */
 int do_nmi_callback(struct pt_regs *regs, int cpu);
 
+extern int nmi_watchdog_enabled;
 extern int avail_to_resrv_perfctr_nmi_bit(unsigned int);
 extern int avail_to_resrv_perfctr_nmi(unsigned int);
 extern int reserve_perfctr_nmi(unsigned int);
Index: linux/include/asm-x86_64/nmi.h
===================================================================
--- linux.orig/include/asm-x86_64/nmi.h
+++ linux/include/asm-x86_64/nmi.h
@@ -43,6 +43,7 @@ extern void die_nmi(char *str, struct pt
 
 extern int panic_on_timeout;
 extern int unknown_nmi_panic;
+extern int nmi_watchdog_enabled;
 
 extern int check_nmi_watchdog(void);
 extern int avail_to_resrv_perfctr_nmi_bit(unsigned int);
Index: linux/include/linux/sysctl.h
===================================================================
--- linux.orig/include/linux/sysctl.h
+++ linux/include/linux/sysctl.h
@@ -150,6 +150,7 @@ enum
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
 	KERN_COMPAT_LOG=73,	/* int: print compat layer  messages */
 	KERN_MAX_LOCK_DEPTH=74,
+	KERN_NMI_WATCHDOG=75, /* int: enable/disable nmi watchdog */
 };
 
 
Index: linux/kernel/sysctl.c
===================================================================
--- linux.orig/kernel/sysctl.c
+++ linux/kernel/sysctl.c
@@ -76,6 +76,9 @@ extern int compat_log;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
+int nmi_watchdog_enabled;
+extern int proc_nmi_enabled(struct ctl_table *, int , struct file *,
+			void __user *, size_t *, loff_t *);
 #endif
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
@@ -628,6 +631,14 @@ static ctl_table kern_table[] = {
 		.mode           = 0644,
 		.proc_handler   = &proc_dointvec,
 	},
+	{
+		.ctl_name       = KERN_NMI_WATCHDOG,
+		.procname       = "nmi_watchdog",
+		.data           = &nmi_watchdog_enabled,
+		.maxlen         = sizeof (int),
+		.mode           = 0644,
+		.proc_handler   = &proc_nmi_enabled,
+	},
 #endif
 #if defined(CONFIG_X86)
 	{
