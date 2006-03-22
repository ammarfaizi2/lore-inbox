Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWCVGr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWCVGr5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWCVGr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:47:56 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:28032 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750896AbWCVGhy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:37:54 -0500
Message-Id: <20060322063801.949835000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:31:06 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 26/35] Add Xen subarch reboot support
Content-Disposition: inline; filename=25-reboot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add remote reboot capability, so that a virtual machine can be
rebooted, halted or 'powered off' by external management tools.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/Makefile   |    1 
 arch/i386/mach-xen/reboot.c |  265 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 266 insertions(+)

--- xen-subarch-2.6.orig/arch/i386/kernel/Makefile
+++ xen-subarch-2.6/arch/i386/kernel/Makefile
@@ -49,6 +49,7 @@ hw_irq-y			:= i8259.o
 
 hw_irq-$(CONFIG_XEN)		:= ../mach-xen/evtchn.o
 time-$(CONFIG_XEN)		:= ../mach-xen/time.o
+reboot-$(CONFIG_XEN)		:= ../mach-xen/reboot.o
 
 # vsyscall.o contains the vsyscall DSO images as __initdata.
 # We must build both images before we can assemble it.
--- /dev/null
+++ xen-subarch-2.6/arch/i386/mach-xen/reboot.c
@@ -0,0 +1,265 @@
+#define __KERNEL_SYSCALLS__
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/unistd.h>
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/sysrq.h>
+#include <linux/stringify.h>
+#include <asm/irq.h>
+#include <asm/mmu_context.h>
+#include <xen/evtchn.h>
+#include <asm/hypervisor.h>
+#ifdef CONFIG_XEN_XENBUS
+#include <xen/xenbus.h>
+#endif
+#include <linux/cpu.h>
+#include <linux/kthread.h>
+#include <xen/xencons.h>
+
+#if defined(__i386__) || defined(__x86_64__)
+/*
+ * Power off function, if any
+ */
+void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
+#endif
+
+#define SHUTDOWN_INVALID  -1
+#define SHUTDOWN_POWEROFF  0
+#define SHUTDOWN_REBOOT    1
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
+#ifdef CONFIG_XEN_XENBUS
+/* Ignore multiple shutdown requests. */
+static int shutting_down = SHUTDOWN_INVALID;
+static void __shutdown_handler(void *unused);
+static DECLARE_WORK(shutdown_work, __shutdown_handler, NULL);
+#endif
+
+#ifdef CONFIG_XEN_XENBUS
+static int shutdown_process(void *__unused)
+{
+	static char *envp[] = { "HOME=/", "TERM=linux",
+				"PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
+	static char *restart_argv[]  = { "/sbin/reboot", NULL };
+	static char *poweroff_argv[] = { "/sbin/poweroff", NULL };
+
+	extern asmlinkage long sys_reboot(int magic1, int magic2,
+					  unsigned int cmd, void *arg);
+
+	daemonize("shutdown");
+
+	switch (shutting_down) {
+	case SHUTDOWN_POWEROFF:
+	case SHUTDOWN_HALT:
+		if (execve("/sbin/poweroff", poweroff_argv, envp) < 0) {
+			sys_reboot(LINUX_REBOOT_MAGIC1,
+				   LINUX_REBOOT_MAGIC2,
+				   LINUX_REBOOT_CMD_POWER_OFF,
+				   NULL);
+		}
+		break;
+
+	case SHUTDOWN_REBOOT:
+		if (execve("/sbin/reboot", restart_argv, envp) < 0) {
+			sys_reboot(LINUX_REBOOT_MAGIC1,
+				   LINUX_REBOOT_MAGIC2,
+				   LINUX_REBOOT_CMD_RESTART,
+				   NULL);
+		}
+		break;
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
+		shutting_down = SHUTDOWN_REBOOT;
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
+#ifdef CONFIG_MAGIC_SYSRQ
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
+	if (sysrq_key != '\0') {
+		handle_sysrq(sysrq_key, NULL, NULL);
+	}
+}
+#endif
+
+static struct xenbus_watch shutdown_watch = {
+	.node = "control/shutdown",
+	.callback = shutdown_handler
+};
+
+#ifdef CONFIG_MAGIC_SYSRQ
+static struct xenbus_watch sysrq_watch = {
+	.node ="control/sysrq",
+	.callback = sysrq_handler
+};
+#endif
+
+static struct notifier_block xenstore_notifier;
+
+static int setup_shutdown_watcher(struct notifier_block *notifier,
+                                  unsigned long event,
+                                  void *data)
+{
+	int err1 = 0;
+#ifdef CONFIG_MAGIC_SYSRQ
+	int err2 = 0;
+#endif
+
+	err1 = register_xenbus_watch(&shutdown_watch);
+#ifdef CONFIG_MAGIC_SYSRQ
+	err2 = register_xenbus_watch(&sysrq_watch);
+#endif
+
+	if (err1)
+		printk(KERN_ERR "Failed to set shutdown watcher\n");
+
+#ifdef CONFIG_MAGIC_SYSRQ
+	if (err2)
+		printk(KERN_ERR "Failed to set sysrq watcher\n");
+#endif
+
+	return NOTIFY_DONE;
+}
+
+static int __init setup_shutdown_event(void)
+{
+
+	xenstore_notifier.notifier_call = setup_shutdown_watcher;
+
+	register_xenstore_notifier(&xenstore_notifier);
+
+	return 0;
+}
+
+subsys_initcall(setup_shutdown_event);
+#endif

--
