Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWEIItJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWEIItJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWEIItF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:49:05 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:55171 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751485AbWEIIsv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:48:51 -0400
Message-Id: <20060509085158.282993000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:26 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 26/35] Add Xen subarch reboot support
Content-Disposition: inline; filename=reboot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add remote reboot capability, so that a virtual machine can be
rebooted, halted or 'powered off' by external management tools.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
TODO:
 - move poweroff and halt to generic similar to c_a_d

 arch/i386/kernel/Makefile |    1
 drivers/xen/core/reboot.c |  232 ++++++++++++++++++++++++++++++++++++++++++++++ 2 files changed, 233 insertions(+)

 arch/i386/kernel/Makefile |    1 
 drivers/xen/core/reboot.c |  232 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 233 insertions(+)

--- linus-2.6.orig/arch/i386/kernel/Makefile
+++ linus-2.6/arch/i386/kernel/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_SCx200)		+= scx200.o
 hw_irq-y			:= i8259.o
 
 hw_irq-$(CONFIG_XEN)		:= ../../../drivers/xen/core/evtchn.o
+reboot-$(CONFIG_XEN)		:= ../../../drivers/xen/core/reboot.o
 time-$(CONFIG_XEN)		:= ../../../drivers/xen/core/time.o
 
 # vsyscall.o contains the vsyscall DSO images as __initdata.
--- /dev/null
+++ linus-2.6/drivers/xen/core/reboot.c
@@ -0,0 +1,232 @@
+#define __KERNEL_SYSCALLS__
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/unistd.h>
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/sysrq.h>
+#include <linux/stringify.h>
+#include <linux/syscalls.h>
+#include <linux/cpu.h>
+#include <linux/kthread.h>
+
+#include <xen/evtchn.h>
+#include <xen/xenbus.h>
+#include <xen/xencons.h>
+
+#include <asm/irq.h>
+#include <asm/mmu_context.h>
+#include <asm/hypervisor.h>
+
+#if defined(__i386__) || defined(__x86_64__)
+/*
+ * Power off function, if any
+ */
+void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
+#endif
+
+extern void ctrl_alt_del(void);
+
+#define SHUTDOWN_INVALID  -1
+#define SHUTDOWN_POWEROFF  0
+#define SHUTDOWN_SUSPEND   2
+/* Code 3 is SHUTDOWN_CRASH, which we don't use because the domain can only
+ * report a crash, not be instructed to crash!
+ * HALT is the same as POWEROFF, as far as we're concerned.  The tools use
+ * the distinction when we return the reason code to them.
+ */
+#define SHUTDOWN_HALT      4
+
+void machine_emergency_restart(void)
+{
+	/* We really want to get pending console data out before we die. */
+	xencons_force_flush();
+	HYPERVISOR_sched_op(SCHEDOP_shutdown, SHUTDOWN_reboot);
+}
+
+void machine_restart(char * __unused)
+{
+	machine_emergency_restart();
+}
+
+void machine_halt(void)
+{
+	machine_power_off();
+}
+
+void machine_power_off(void)
+{
+	/* We really want to get pending console data out before we die. */
+	xencons_force_flush();
+	HYPERVISOR_sched_op(SCHEDOP_shutdown, SHUTDOWN_poweroff);
+}
+
+int reboot_thru_bios = 0;	/* for dmi_scan.c */
+EXPORT_SYMBOL(machine_restart);
+EXPORT_SYMBOL(machine_halt);
+EXPORT_SYMBOL(machine_power_off);
+
+
+/******************************************************************************
+ * Stop/pickle callback handling.
+ */
+
+/* Ignore multiple shutdown requests. */
+static int shutting_down = SHUTDOWN_INVALID;
+static void __shutdown_handler(void *unused);
+static DECLARE_WORK(shutdown_work, __shutdown_handler, NULL);
+
+static int shutdown_process(void *__unused)
+{
+	static char *envp[] = { "HOME=/", "TERM=linux",
+				"PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
+	static char *poweroff_argv[] = { "/sbin/poweroff", NULL };
+
+	if ((shutting_down == SHUTDOWN_POWEROFF) ||
+	    (shutting_down == SHUTDOWN_HALT)) {
+		if (execve(poweroff_argv[0], poweroff_argv, envp) < 0) {
+			sys_reboot(LINUX_REBOOT_MAGIC1,
+				   LINUX_REBOOT_MAGIC2,
+				   LINUX_REBOOT_CMD_POWER_OFF,
+				   NULL);
+		}
+	}
+
+	shutting_down = SHUTDOWN_INVALID; /* could try again */
+
+	return 0;
+}
+
+static void __shutdown_handler(void *unused)
+{
+	int err = 0;
+
+	if (shutting_down != SHUTDOWN_SUSPEND)
+		err = kernel_thread(shutdown_process, NULL,
+				    CLONE_FS | CLONE_FILES);
+
+	if (err < 0) {
+		printk(KERN_WARNING "Error creating shutdown process (%d): "
+		       "retrying...\n", -err);
+		schedule_delayed_work(&shutdown_work, HZ/2);
+	}
+}
+
+static void shutdown_handler(struct xenbus_watch *watch,
+			     const char **vec, unsigned int len)
+{
+	char *str;
+	xenbus_transaction_t xbt;
+	int err;
+
+	if (shutting_down != SHUTDOWN_INVALID)
+		return;
+
+ again:
+	err = xenbus_transaction_start(&xbt);
+	if (err)
+		return;
+	str = (char *)xenbus_read(xbt, "control", "shutdown", NULL);
+	/* Ignore read errors and empty reads. */
+	if (XENBUS_IS_ERR_READ(str)) {
+		xenbus_transaction_end(xbt, 1);
+		return;
+	}
+
+	xenbus_write(xbt, "control", "shutdown", "");
+
+	err = xenbus_transaction_end(xbt, 0);
+	if (err == -EAGAIN) {
+		kfree(str);
+		goto again;
+	}
+
+	if (strcmp(str, "poweroff") == 0)
+		shutting_down = SHUTDOWN_POWEROFF;
+	else if (strcmp(str, "reboot") == 0)
+		ctrl_alt_del();
+	else if (strcmp(str, "suspend") == 0)
+		shutting_down = SHUTDOWN_SUSPEND;
+	else if (strcmp(str, "halt") == 0)
+		shutting_down = SHUTDOWN_HALT;
+	else {
+		printk("Ignoring shutdown request: %s\n", str);
+		shutting_down = SHUTDOWN_INVALID;
+	}
+
+	if (shutting_down != SHUTDOWN_INVALID)
+		schedule_work(&shutdown_work);
+
+	kfree(str);
+}
+
+static void sysrq_handler(struct xenbus_watch *watch, const char **vec,
+			  unsigned int len)
+{
+	char sysrq_key = '\0';
+	xenbus_transaction_t xbt;
+	int err;
+
+ again:
+	err = xenbus_transaction_start(&xbt);
+	if (err)
+		return;
+	if (!xenbus_scanf(xbt, "control", "sysrq", "%c", &sysrq_key)) {
+		printk(KERN_ERR "Unable to read sysrq code in "
+		       "control/sysrq\n");
+		xenbus_transaction_end(xbt, 1);
+		return;
+	}
+
+	if (sysrq_key != '\0')
+		xenbus_printf(xbt, "control", "sysrq", "%c", '\0');
+
+	err = xenbus_transaction_end(xbt, 0);
+	if (err == -EAGAIN)
+		goto again;
+
+#ifdef CONFIG_MAGIC_SYSRQ
+	if (sysrq_key != '\0')
+		handle_sysrq(sysrq_key, NULL, NULL);
+#endif
+}
+
+static struct xenbus_watch shutdown_watch = {
+	.node = "control/shutdown",
+	.callback = shutdown_handler
+};
+
+static struct xenbus_watch sysrq_watch = {
+	.node ="control/sysrq",
+	.callback = sysrq_handler
+};
+
+static int setup_shutdown_watcher(struct notifier_block *notifier,
+                                  unsigned long event,
+                                  void *data)
+{
+	int err;
+
+	err = register_xenbus_watch(&shutdown_watch);
+	if (err)
+		printk(KERN_ERR "Failed to set shutdown watcher\n");
+
+	err = register_xenbus_watch(&sysrq_watch);
+	if (err)
+		printk(KERN_ERR "Failed to set sysrq watcher\n");
+
+	return NOTIFY_DONE;
+}
+
+static int __init setup_shutdown_event(void)
+{
+	static struct notifier_block xenstore_notifier = {
+		.notifier_call = setup_shutdown_watcher
+	};
+	register_xenstore_notifier(&xenstore_notifier);
+	return 0;
+}
+
+subsys_initcall(setup_shutdown_event);

--
