Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932780AbVITRou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbVITRou (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932781AbVITRot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:44:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25222 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932780AbVITRor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:44:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: <len.brown@intel.com>, Pierre Ossman <drzeus-list@drzeus.cx>,
       acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com,
       Pavel Machek <pavel@ucw.cz>, Masoud Sharbiani <masouds@masoud.ir>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] reboot:  Comment and factor the main reboot functions
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8DAF@hdsmsx401.amr.corp.intel.com>
	<m1d5ngk4xa.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0509111140550.9218@math.ut.ee>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 20 Sep 2005 11:42:21 -0600
In-Reply-To: <Pine.SOC.4.61.0509111140550.9218@math.ut.ee> (Meelis Roos's
 message of "Sun, 11 Sep 2005 11:43:04 +0300 (EEST)")
Message-ID: <m14q8fhc02.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the lead up to 2.6.13 I fixed a large number of reboot
problems by making the calling conventions consistent.  Despite
checking and double checking my work it appears I missed an
obvious one.  

This first patch simply refactors the reboot routines
so all of the preparation for various kinds of reboots
are in their own functions.  Making it very hard to
get the various kinds of reboot out of sync.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 include/linux/reboot.h |    4 ++++
 kernel/sys.c           |   52 ++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 6 deletions(-)

bc95b88c85ec3e7a0525f73f6c3ae19fa9640fbd
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
