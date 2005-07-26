Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVGZR0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVGZR0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVGZR0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:26:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10887 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261688AbVGZRYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:24:51 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/23] Refactor sys_reboot into reusable parts
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 11:24:14 -0600
In-Reply-To: <m1iryxeb4t.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Tue, 26 Jul 2005 11:21:38 -0600")
Message-ID: <m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Because the factors of sys_reboot don't exist people calling
into the reboot path duplicate the code badly, leading to
inconsistent expectations of code in the reboot path.

This patch should is just code motion.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 include/linux/reboot.h |    9 ++++
 kernel/sys.c           |  106 +++++++++++++++++++++++++++++-------------------
 2 files changed, 73 insertions(+), 42 deletions(-)

bbc94d1109869fe5054f7cd697c978d494edeb62
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -55,6 +55,15 @@ extern void machine_shutdown(void);
 struct pt_regs;
 extern void machine_crash_shutdown(struct pt_regs *);
 
+/* 
+ * Architecture independent implemenations of sys_reboot commands.
+ */
+
+extern void kernel_restart(char *cmd);
+extern void kernel_halt(void);
+extern void kernel_power_off(void);
+extern void kernel_kexec(void);
+
 #endif
 
 #endif /* _LINUX_REBOOT_H */
diff --git a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -361,6 +361,62 @@ out_unlock:
 	return retval;
 }
 
+void kernel_restart(char *cmd)
+{
+	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
+	system_state = SYSTEM_RESTART;
+	device_suspend(PMSG_FREEZE);
+	device_shutdown();
+	if (!cmd) {
+		printk(KERN_EMERG "Restarting system.\n");
+	} else {
+		printk(KERN_EMERG "Restarting system with command '%s'.\n", cmd);
+	}
+	printk(".\n");
+	machine_restart(cmd);
+}
+EXPORT_SYMBOL_GPL(kernel_restart);
+
+void kernel_kexec(void)
+{
+#ifdef CONFIG_KEXEC
+	struct kimage *image;
+	image = xchg(&kexec_image, 0);
+	if (!image) {
+		return;
+	}
+	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
+	system_state = SYSTEM_RESTART;
+	device_suspend(PMSG_FREEZE);
+	device_shutdown();
+	printk(KERN_EMERG "Starting new kernel\n");
+	machine_shutdown();
+	machine_kexec(image);
+#endif
+}
+EXPORT_SYMBOL_GPL(kernel_kexec);
+
+void kernel_halt(void)
+{
+	notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
+	system_state = SYSTEM_HALT;
+	device_suspend(PMSG_SUSPEND);
+	device_shutdown();
+	printk(KERN_EMERG "System halted.\n");
+	machine_halt();
+}
+EXPORT_SYMBOL_GPL(kernel_halt);
+
+void kernel_power_off(void)
+{
+	notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
+	system_state = SYSTEM_POWER_OFF;
+	device_suspend(PMSG_SUSPEND);
+	device_shutdown();
+	printk(KERN_EMERG "Power down.\n");
+	machine_power_off();
+}
+EXPORT_SYMBOL_GPL(kernel_power_off);
 
 /*
  * Reboot system call: for obvious reasons only root may call it,
@@ -389,12 +445,7 @@ asmlinkage long sys_reboot(int magic1, i
 	lock_kernel();
 	switch (cmd) {
 	case LINUX_REBOOT_CMD_RESTART:
-		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
-		system_state = SYSTEM_RESTART;
-		device_suspend(PMSG_FREEZE);
-		device_shutdown();
-		printk(KERN_EMERG "Restarting system.\n");
-		machine_restart(NULL);
+		kernel_restart(NULL);
 		break;
 
 	case LINUX_REBOOT_CMD_CAD_ON:
@@ -406,23 +457,13 @@ asmlinkage long sys_reboot(int magic1, i
 		break;
 
 	case LINUX_REBOOT_CMD_HALT:
-		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
-		system_state = SYSTEM_HALT;
-		device_suspend(PMSG_SUSPEND);
-		device_shutdown();
-		printk(KERN_EMERG "System halted.\n");
-		machine_halt();
+		kernel_halt();
 		unlock_kernel();
 		do_exit(0);
 		break;
 
 	case LINUX_REBOOT_CMD_POWER_OFF:
-		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
-		system_state = SYSTEM_POWER_OFF;
-		device_suspend(PMSG_SUSPEND);
-		device_shutdown();
-		printk(KERN_EMERG "Power down.\n");
-		machine_power_off();
+		kernel_power_off();
 		unlock_kernel();
 		do_exit(0);
 		break;
@@ -434,33 +475,14 @@ asmlinkage long sys_reboot(int magic1, i
 		}
 		buffer[sizeof(buffer) - 1] = '\0';
 
-		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, buffer);
-		system_state = SYSTEM_RESTART;
-		device_suspend(PMSG_FREEZE);
-		device_shutdown();
-		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
-		machine_restart(buffer);
+		kernel_restart(buffer);
 		break;
 
-#ifdef CONFIG_KEXEC
 	case LINUX_REBOOT_CMD_KEXEC:
-	{
-		struct kimage *image;
-		image = xchg(&kexec_image, 0);
-		if (!image) {
-			unlock_kernel();
-			return -EINVAL;
-		}
-		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
-		system_state = SYSTEM_RESTART;
-		device_suspend(PMSG_FREEZE);
-		device_shutdown();
-		printk(KERN_EMERG "Starting new kernel\n");
-		machine_shutdown();
-		machine_kexec(image);
-		break;
-	}
-#endif
+		kernel_kexec();
+		unlock_kernel();
+		return -EINVAL;
+
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
 		{
