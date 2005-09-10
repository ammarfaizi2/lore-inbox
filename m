Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVIJVJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVIJVJU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVIJVJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:09:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1748 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932308AbVIJVJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:09:19 -0400
To: "Brown, Len" <len.brown@intel.com>
Cc: "Pierre Ossman" <drzeus-list@drzeus.cx>, acpi-devel@lists.sourceforge.net,
       <ncunningham@cyclades.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Meelis Roos" <mroos@linux.ee>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: reboot vs poweroff
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8DAF@hdsmsx401.amr.corp.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 10 Sep 2005 15:07:29 -0600
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30047B8DAF@hdsmsx401.amr.corp.intel.com> (Len
 Brown's message of "Thu, 1 Sep 2005 14:23:31 -0400")
Message-ID: <m1d5ngk4xa.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brown, Len" <len.brown@intel.com> writes:

>  
>>Patch tested and works fine here. You should probably make a 
>>note in the bugzilla so we don't get a conflicting merge
>>from the ACPI folks.
>
> One might also consider that it would be a good idea to
> send patches that break ACPI files to the ACPI maintainer
> and acpi-devel@lists.sourceforge.net before sending them
> to Linus...

OK hopefully this is my final version of this bug fix.

Eric

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -59,6 +59,10 @@ extern void machine_crash_shutdown(struc
  * Architecture independent implemenations of sys_reboot commands.
  */
 
+extern void kernel_restart_prepare(char *cmd);
+extern void kernel_halt_prepare(void);
+extern void kernel_power_off_prepare(void);
+
 extern void kernel_restart(char *cmd);
 extern void kernel_halt(void);
 extern void kernel_power_off(void);
diff --git a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -17,12 +17,12 @@
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
+#include <linux/pm.h>
 
 #include "power.h"
 
 
 extern suspend_disk_method_t pm_disk_mode;
-extern struct pm_ops * pm_ops;
 
 extern int swsusp_suspend(void);
 extern int swsusp_write(void);
@@ -49,13 +49,11 @@ dev_t swsusp_resume_device;
 
 static void power_down(suspend_disk_method_t mode)
 {
-	unsigned long flags;
 	int error = 0;
 
-	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
- 		device_shutdown();
+		kernel_power_off_prepare();
 		error = pm_ops->enter(PM_SUSPEND_DISK);
 		break;
 	case PM_DISK_SHUTDOWN:
diff --git a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -361,17 +361,35 @@ out_unlock:
 	return retval;
 }
 
+/**
+ *	emergency_restart - reboot the system
+ *
+ *	Without shutting down any hardware or taking any locks
+ *	reboot the system.  This is called when we know we are in
+ *	trouble so this is our best effort to reboot.  This is
+ *	safe to call in interrupt context.
+ */
 void emergency_restart(void)
 {
 	machine_emergency_restart();
 }
 EXPORT_SYMBOL_GPL(emergency_restart);
 
-void kernel_restart(char *cmd)
+/**
+ *	kernel_restart - reboot the system
+ *
+ *	Shutdown everything and perform a clean reboot.
+ *	This is not safe to call in interrupt context.
+ */
+void kernel_restart_prepare(char *cmd)
 {
 	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
 	system_state = SYSTEM_RESTART;
 	device_shutdown();
+}
+void kernel_restart(char *cmd)
+{
+	kernel_restart_prepare(cmd);
 	if (!cmd) {
 		printk(KERN_EMERG "Restarting system.\n");
 	} else {
@@ -382,6 +400,12 @@ void kernel_restart(char *cmd)
 }
 EXPORT_SYMBOL_GPL(kernel_restart);
 
+/**
+ *	kernel_kexec - reboot the system
+ *
+ *	Move into place and start executing a preloaded standalone
+ *	executable.  If nothing was preloaded return an error.
+ */
 void kernel_kexec(void)
 {
 #ifdef CONFIG_KEXEC
@@ -390,9 +414,7 @@ void kernel_kexec(void)
 	if (!image) {
 		return;
 	}
-	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
-	system_state = SYSTEM_RESTART;
-	device_shutdown();
+	kernel_restart_prepare(NULL);
 	printk(KERN_EMERG "Starting new kernel\n");
 	machine_shutdown();
 	machine_kexec(image);
@@ -400,21 +422,39 @@ void kernel_kexec(void)
 }
 EXPORT_SYMBOL_GPL(kernel_kexec);
 
-void kernel_halt(void)
+/**
+ *	kernel_halt - halt the system
+ *
+ *	Shutdown everything and perform a clean system halt.
+ */
+void kernel_halt_prepare(void)
 {
 	notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
 	system_state = SYSTEM_HALT;
 	device_shutdown();
+}
+void kernel_halt(void)
+{
+	kernel_halt_prepare();
 	printk(KERN_EMERG "System halted.\n");
 	machine_halt();
 }
 EXPORT_SYMBOL_GPL(kernel_halt);
 
-void kernel_power_off(void)
+/**
+ *	kernel_power_off - power_off the system
+ *
+ *	Shutdown everything and perform a clean system power_off.
+ */
+void kernel_power_off_prepare(void)
 {
 	notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 	system_state = SYSTEM_POWER_OFF;
 	device_shutdown();
+}
+void kernel_power_off(void)
+{
+	kernel_power_off_prepare();
 	printk(KERN_EMERG "Power down.\n");
 	machine_power_off();
 }
