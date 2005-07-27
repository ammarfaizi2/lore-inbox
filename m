Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVG0Rnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVG0Rnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 13:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVG0Rnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 13:43:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19928 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262293AbVG0RmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 13:42:25 -0400
Date: Wed, 27 Jul 2005 10:41:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/23] reboot-fixes
Message-Id: <20050727104123.7938477a.akpm@osdl.org>
In-Reply-To: <m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<20050727025923.7baa38c9.akpm@osdl.org>
	<m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
>  > My fairly ordinary x86 test box gets stuck during reboot on the
>  > wait_for_completion() in ide_do_drive_cmd():
> 
>  Hmm. The only thing I can think of is someone started adding calls
>  to device_suspend() before device_shutdown().  Not understanding
>  where it was a good idea I made certain the calls were in there
>  consistently.  
> 
>  Andrew can you remove the call to device_suspend from kernel_restart
>  and see if this still happens?

yup, that fixes it.

--- devel/kernel/sys.c~a	2005-07-27 10:36:06.000000000 -0700
+++ devel-akpm/kernel/sys.c	2005-07-27 10:36:26.000000000 -0700
@@ -371,7 +371,6 @@ void kernel_restart(char *cmd)
 {
 	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
 	system_state = SYSTEM_RESTART;
-	device_suspend(PMSG_FREEZE);
 	device_shutdown();
 	if (!cmd) {
 		printk(KERN_EMERG "Restarting system.\n");
_


Presumably it unfixes Pavel's patch?


From: Pavel Machek <pavel@ucw.cz>

Without this patch, Linux provokes emergency disk shutdowns and
similar nastiness. It was in SuSE kernels for some time, IIRC.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/pm.h |   33 +++++++++++++++++++++------------
 kernel/sys.c       |    3 +++
 2 files changed, 24 insertions(+), 12 deletions(-)

diff -puN kernel/sys.c~properly-stop-devices-before-poweroff kernel/sys.c
--- 25/kernel/sys.c~properly-stop-devices-before-poweroff	2005-06-25 14:47:00.000000000 -0700
+++ 25-akpm/kernel/sys.c	2005-06-25 14:50:53.000000000 -0700
@@ -405,6 +405,7 @@ asmlinkage long sys_reboot(int magic1, i
 	case LINUX_REBOOT_CMD_HALT:
 		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
 		system_state = SYSTEM_HALT;
+		device_suspend(PMSG_SUSPEND);
 		device_shutdown();
 		printk(KERN_EMERG "System halted.\n");
 		machine_halt();
@@ -415,6 +416,7 @@ asmlinkage long sys_reboot(int magic1, i
 	case LINUX_REBOOT_CMD_POWER_OFF:
 		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 		system_state = SYSTEM_POWER_OFF;
+		device_suspend(PMSG_SUSPEND);
 		device_shutdown();
 		printk(KERN_EMERG "Power down.\n");
 		machine_power_off();
@@ -431,6 +433,7 @@ asmlinkage long sys_reboot(int magic1, i
 
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, buffer);
 		system_state = SYSTEM_RESTART;
+		device_suspend(PMSG_FREEZE);
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
 		machine_restart(buffer);
diff -puN include/linux/pm.h~properly-stop-devices-before-poweroff include/linux/pm.h
--- 25/include/linux/pm.h~properly-stop-devices-before-poweroff	2005-06-25 14:47:00.000000000 -0700
+++ 25-akpm/include/linux/pm.h	2005-06-25 14:47:00.000000000 -0700
@@ -103,7 +103,8 @@ extern int pm_active;
 /*
  * Register a device with power management
  */
-struct pm_dev __deprecated *pm_register(pm_dev_t type, unsigned long id, pm_callback callback);
+struct pm_dev __deprecated *
+pm_register(pm_dev_t type, unsigned long id, pm_callback callback);
 
 /*
  * Unregister a device with power management
@@ -190,17 +191,18 @@ typedef u32 __bitwise pm_message_t;
 /*
  * There are 4 important states driver can be in:
  * ON     -- driver is working
- * FREEZE -- stop operations and apply whatever policy is applicable to a suspended driver
- *           of that class, freeze queues for block like IDE does, drop packets for
- *           ethernet, etc... stop DMA engine too etc... so a consistent image can be
- *           saved; but do not power any hardware down.
- * SUSPEND - like FREEZE, but hardware is doing as much powersaving as possible. Roughly
- *           pci D3.
+ * FREEZE -- stop operations and apply whatever policy is applicable to a
+ *           suspended driver of that class, freeze queues for block like IDE
+ *           does, drop packets for ethernet, etc... stop DMA engine too etc...
+ *           so a consistent image can be saved; but do not power any hardware
+ *           down.
+ * SUSPEND - like FREEZE, but hardware is doing as much powersaving as
+ *           possible. Roughly pci D3.
  *
- * Unfortunately, current drivers only recognize numeric values 0 (ON) and 3 (SUSPEND).
- * We'll need to fix the drivers. So yes, putting 3 to all diferent defines is intentional,
- * and will go away as soon as drivers are fixed. Also note that typedef is neccessary,
- * we'll probably want to switch to
+ * Unfortunately, current drivers only recognize numeric values 0 (ON) and 3
+ * (SUSPEND).  We'll need to fix the drivers. So yes, putting 3 to all different
+ * defines is intentional, and will go away as soon as drivers are fixed.  Also
+ * note that typedef is neccessary, we'll probably want to switch to
  *   typedef struct pm_message_t { int event; int flags; } pm_message_t
  * or something similar soon.
  */
@@ -222,11 +224,18 @@ struct dev_pm_info {
 
 extern void device_pm_set_parent(struct device * dev, struct device * parent);
 
-extern int device_suspend(pm_message_t state);
 extern int device_power_down(pm_message_t state);
 extern void device_power_up(void);
 extern void device_resume(void);
 
+#ifdef CONFIG_PM
+extern int device_suspend(pm_message_t state);
+#else
+static inline int device_suspend(pm_message_t state)
+{
+	return 0;
+}
+#endif
 
 #endif /* __KERNEL__ */
 
_

