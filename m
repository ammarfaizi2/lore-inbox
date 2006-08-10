Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWHJUOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWHJUOc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbWHJTgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:16 -0400
Received: from ns2.suse.de ([195.135.220.15]:4843 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932271AbWHJTf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:28 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [14/145] x86_64: Add abilty to enable/disable nmi watchdog from procfs (update)
Message-Id: <20060810193526.C3ACC13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:26 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Don Zickus <dzickus@redhat.com>

Adds a new /proc/sys/kernel/nmi_watchdog call that will enable/disable the
nmi watchdog.

By entering a non-zero value here, a user can enable the nmi watchdog to
monitor the online cpus in the system.  By entering a zero value here, a
user can disable the nmi watchdog and free up a performance counter which
could then be utilized by the oprofile subsystem, otherwise oprofile may be
short a counter when in use.

Signed-off-by: Don Zickus <dzickus@redhat.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Cc: Andi Kleen <ak@muc.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 Documentation/filesystems/proc.txt |   14 +++++++++-----
 arch/i386/kernel/nmi.c             |   21 ++++-----------------
 arch/x86_64/kernel/nmi.c           |   21 ++++-----------------
 3 files changed, 17 insertions(+), 39 deletions(-)

Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -847,7 +847,7 @@ static int unknown_nmi_panic_callback(st
 }
 
 /*
- * proc handler for /proc/sys/kernel/nmi_watchdog
+ * proc handler for /proc/sys/kernel/nmi
  */
 int proc_nmi_enabled(struct ctl_table *table, int write, struct file *file,
 			void __user *buffer, size_t *length, loff_t *ppos)
@@ -861,8 +861,8 @@ int proc_nmi_enabled(struct ctl_table *t
 		return 0;
 
 	if (atomic_read(&nmi_active) < 0) {
-		printk(KERN_WARNING "NMI watchdog is permanently disabled\n");
-		return -EINVAL;
+		printk( KERN_WARNING "NMI watchdog is permanently disabled\n");
+		return -EIO;
 	}
 
 	if (nmi_watchdog == NMI_DEFAULT) {
@@ -872,24 +872,11 @@ int proc_nmi_enabled(struct ctl_table *t
 			nmi_watchdog = NMI_IO_APIC;
 	}
 
-	if (nmi_watchdog == NMI_LOCAL_APIC)
-	{
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
 		if (nmi_watchdog_enabled)
 			enable_lapic_nmi_watchdog();
 		else
 			disable_lapic_nmi_watchdog();
-	} else if (nmi_watchdog == NMI_IO_APIC) {
-		/* FIXME
-		 * for some reason these functions don't work
-		 */
-		printk("Can not enable/disable NMI on IO APIC\n");
-		return -EINVAL;
-#if 0
-		if (nmi_watchdog_enabled)
-			enable_timer_nmi_watchdog();
-		else
-			disable_timer_nmi_watchdog();
-#endif
 	} else {
 		printk( KERN_WARNING
 			"NMI watchdog doesn't know what hardware to touch\n");
Index: linux/arch/x86_64/kernel/nmi.c
===================================================================
--- linux.orig/arch/x86_64/kernel/nmi.c
+++ linux/arch/x86_64/kernel/nmi.c
@@ -167,7 +167,7 @@ static __cpuinit inline int nmi_known_cp
 }
 
 /* Run after command line and cpu_init init, but before all other checks */
-void __cpuinit nmi_watchdog_default(void)
+void nmi_watchdog_default(void)
 {
 	if (nmi_watchdog != NMI_DEFAULT)
 		return;
@@ -766,32 +766,19 @@ int proc_nmi_enabled(struct ctl_table *t
 
 	if (atomic_read(&nmi_active) < 0) {
 		printk( KERN_WARNING "NMI watchdog is permanently disabled\n");
-		return -EINVAL;
+		return -EIO;
 	}
 
 	/* if nmi_watchdog is not set yet, then set it */
 	nmi_watchdog_default();
 
-	if (nmi_watchdog == NMI_LOCAL_APIC)
-	{
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
 		if (nmi_watchdog_enabled)
 			enable_lapic_nmi_watchdog();
 		else
 			disable_lapic_nmi_watchdog();
-	} else if (nmi_watchdog == NMI_IO_APIC) {
-		/* FIXME
-		 * for some reason these functions don't work
-		 */
-		printk("Can not enable/disable NMI on IO APIC\n");
-		return -EIO;
-#if 0
-		if (nmi_watchdog_enabled)
-			enable_timer_nmi_watchdog();
-		else
-			disable_timer_nmi_watchdog();
-#endif
 	} else {
-		printk(KERN_WARNING
+		printk( KERN_WARNING
 			"NMI watchdog doesn't know what hardware to touch\n");
 		return -EIO;
 	}
Index: linux/Documentation/filesystems/proc.txt
===================================================================
--- linux.orig/Documentation/filesystems/proc.txt
+++ linux/Documentation/filesystems/proc.txt
@@ -1124,11 +1124,15 @@ debugging information is displayed on co
 NMI switch that most IA32 servers have fires unknown NMI up, for example.
 If a system hangs up, try pressing the NMI switch.
 
-[NOTE]
-   This function and oprofile share a NMI callback. Therefore this function
-   cannot be enabled when oprofile is activated.
-   And NMI watchdog will be disabled when the value in this file is set to
-   non-zero.
+nmi_watchdog
+------------
+
+Enables/Disables the NMI watchdog on x86 systems.  When the value is non-zero
+the NMI watchdog is enabled and will continuously test all online cpus to
+determine whether or not they are still functioning properly.
+
+Because the NMI watchdog shares registers with oprofile, by disabling the NMI
+watchdog, oprofile may have more registers to utilize.
 
 
 2.4 /proc/sys/vm - The virtual memory subsystem
