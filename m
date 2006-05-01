Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWEAHM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWEAHM7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 03:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWEAHLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 03:11:46 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43793 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751303AbWEAHLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 03:11:34 -0400
Date: Mon, 1 May 2006 09:11:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] kernel/sys.c: possible cleanups
Message-ID: <20060501071134.GH3570@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- proper prototypes for the following functions:
  - ctrl_alt_del()  (in include/linux/reboot.h)
  - getrusage()     (in include/linux/resource.h)
- make the following needlessly global functions static:
  - kernel_restart_prepare()
  - kernel_kexec()
- remove the following unused EXPORT_SYMBOL:
  - in_egroup_p
- remove the following unused EXPORT_SYMBOL_GPL's:
  - kernel_restart
  - kernel_halt

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 20 Apr 2006

 arch/arm/mach-ixp4xx/nas100d-power.c |    3 +--
 arch/arm/mach-ixp4xx/nslu2-power.c   |    3 +--
 arch/mips/kernel/irixsig.c           |    3 +--
 arch/mips/kernel/sysirix.c           |    2 +-
 arch/um/drivers/mconsole_kern.c      |    2 --
 drivers/char/keyboard.c              |    2 +-
 drivers/s390/char/sclp_quiesce.c     |    3 +--
 include/linux/reboot.h               |    4 ++--
 include/linux/resource.h             |    2 ++
 kernel/exit.c                        |    3 +--
 kernel/sys.c                         |   10 ++--------
 11 files changed, 13 insertions(+), 24 deletions(-)

--- linux-2.6.17-rc1-mm3-full/include/linux/reboot.h.old	2006-04-20 17:10:19.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/include/linux/reboot.h	2006-04-20 17:19:30.000000000 +0200
@@ -59,13 +59,13 @@
  * Architecture independent implemenations of sys_reboot commands.
  */
 
-extern void kernel_restart_prepare(char *cmd);
 extern void kernel_shutdown_prepare(enum system_states state);
 
 extern void kernel_restart(char *cmd);
 extern void kernel_halt(void);
 extern void kernel_power_off(void);
-extern void kernel_kexec(void);
+
+void ctrl_alt_del(void);
 
 /*
  * Emergency restart, callable from an interrupt handler.
--- linux-2.6.17-rc1-mm3-full/include/linux/resource.h.old	2006-04-20 17:24:46.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/include/linux/resource.h	2006-04-20 17:25:18.000000000 +0200
@@ -67,4 +67,6 @@
  */
 #include <asm/resource.h>
 
+int getrusage(struct task_struct *p, int who, struct rusage __user *ru);
+
 #endif
--- linux-2.6.17-rc1-mm3-full/kernel/sys.c.old	2006-04-20 17:10:32.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/kernel/sys.c	2006-04-20 17:16:57.000000000 +0200
@@ -589,7 +589,7 @@
 }
 EXPORT_SYMBOL_GPL(emergency_restart);
 
-void kernel_restart_prepare(char *cmd)
+static void kernel_restart_prepare(char *cmd)
 {
 	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
 	system_state = SYSTEM_RESTART;
@@ -615,7 +615,6 @@
 	printk(".\n");
 	machine_restart(cmd);
 }
-EXPORT_SYMBOL_GPL(kernel_restart);
 
 /**
  *	kernel_kexec - reboot the system
@@ -623,7 +622,7 @@
  *	Move into place and start executing a preloaded standalone
  *	executable.  If nothing was preloaded return an error.
  */
-void kernel_kexec(void)
+static void kernel_kexec(void)
 {
 #ifdef CONFIG_KEXEC
 	struct kimage *image;
@@ -637,7 +636,6 @@
 	machine_kexec(image);
 #endif
 }
-EXPORT_SYMBOL_GPL(kernel_kexec);
 
 void kernel_shutdown_prepare(enum system_states state)
 {
@@ -658,8 +656,6 @@
 	machine_halt();
 }
 
-EXPORT_SYMBOL_GPL(kernel_halt);
-
 /**
  *	kernel_power_off - power_off the system
  *
@@ -1666,8 +1662,6 @@
 	return retval;
 }
 
-EXPORT_SYMBOL(in_egroup_p);
-
 DECLARE_RWSEM(uts_sem);
 
 EXPORT_SYMBOL(uts_sem);
--- linux-2.6.17-rc1-mm3-full/arch/arm/mach-ixp4xx/nas100d-power.c.old	2006-04-20 17:19:48.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/arch/arm/mach-ixp4xx/nas100d-power.c	2006-04-20 17:20:09.000000000 +0200
@@ -20,11 +20,10 @@
 #include <linux/module.h>
 #include <linux/reboot.h>
 #include <linux/interrupt.h>
+#include <linux/reboot.h>
 
 #include <asm/mach-types.h>
 
-extern void ctrl_alt_del(void);
-
 static irqreturn_t nas100d_reset_handler(int irq, void *dev_id, struct pt_regs *regs)
 {
 	/* Signal init to do the ctrlaltdel action, this will bypass init if
--- linux-2.6.17-rc1-mm3-full/arch/arm/mach-ixp4xx/nslu2-power.c.old	2006-04-20 17:20:18.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/arch/arm/mach-ixp4xx/nslu2-power.c	2006-04-20 17:20:30.000000000 +0200
@@ -20,11 +20,10 @@
 #include <linux/module.h>
 #include <linux/reboot.h>
 #include <linux/interrupt.h>
+#include <linux/reboot.h>
 
 #include <asm/mach-types.h>
 
-extern void ctrl_alt_del(void);
-
 static irqreturn_t nslu2_power_handler(int irq, void *dev_id, struct pt_regs *regs)
 {
 	/* Signal init to do the ctrlaltdel action, this will bypass init if
--- linux-2.6.17-rc1-mm3-full/arch/um/drivers/mconsole_kern.c.old	2006-04-20 17:20:38.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/arch/um/drivers/mconsole_kern.c	2006-04-20 17:20:47.000000000 +0200
@@ -300,8 +300,6 @@
 	machine_restart(NULL);
 }
 
-extern void ctrl_alt_del(void);
-
 void mconsole_cad(struct mc_request *req)
 {
 	mconsole_reply(req, "", 0, 0);
--- linux-2.6.17-rc1-mm3-full/drivers/char/keyboard.c.old	2006-04-20 17:20:55.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/char/keyboard.c	2006-04-20 17:21:13.000000000 +0200
@@ -39,9 +39,9 @@
 #include <linux/vt_kern.h>
 #include <linux/sysrq.h>
 #include <linux/input.h>
+#include <linux/reboot.h>
 
 static void kbd_disconnect(struct input_handle *handle);
-extern void ctrl_alt_del(void);
 
 /*
  * Exported functions/variables
--- linux-2.6.17-rc1-mm3-full/drivers/s390/char/sclp_quiesce.c.old	2006-04-20 17:21:21.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/s390/char/sclp_quiesce.c	2006-04-20 17:21:37.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/cpumask.h>
 #include <linux/smp.h>
 #include <linux/init.h>
+#include <linux/reboot.h>
 #include <asm/atomic.h>
 #include <asm/ptrace.h>
 #include <asm/sigp.h>
@@ -66,8 +67,6 @@
 }
 #endif
 
-extern void ctrl_alt_del(void);
-
 /* Handler for quiesce event. Start shutdown procedure. */
 static void
 sclp_quiesce_handler(struct evbuf_header *evbuf)
--- linux-2.6.17-rc1-mm3-full/arch/mips/kernel/irixsig.c.old	2006-04-20 17:25:45.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/arch/mips/kernel/irixsig.c	2006-04-20 17:26:04.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/smp_lock.h>
 #include <linux/time.h>
 #include <linux/ptrace.h>
+#include <linux/resource.h>
 
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
@@ -540,8 +541,6 @@
 #define IRIX_P_PGID   2
 #define IRIX_P_ALL    7
 
-extern int getrusage(struct task_struct *, int, struct rusage __user *);
-
 #define W_EXITED     1
 #define W_TRAPPED    2
 #define W_STOPPED    4
--- linux-2.6.17-rc1-mm3-full/arch/mips/kernel/sysirix.c.old	2006-04-20 17:26:23.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/arch/mips/kernel/sysirix.c	2006-04-20 17:26:53.000000000 +0200
@@ -31,6 +31,7 @@
 #include <linux/socket.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/resource.h>
 
 #include <asm/ptrace.h>
 #include <asm/page.h>
@@ -235,7 +236,6 @@
 #undef DEBUG_PROCGRPS
 
 extern unsigned long irix_mapelf(int fd, struct elf_phdr __user *user_phdrp, int cnt);
-extern int getrusage(struct task_struct *p, int who, struct rusage __user *ru);
 extern char *prom_getenv(char *name);
 extern long prom_setenv(char *name, char *value);
 
--- linux-2.6.17-rc1-mm3-full/kernel/exit.c.old	2006-04-20 17:27:07.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/kernel/exit.c	2006-04-20 17:27:24.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/audit.h> /* for audit_free() */
+#include <linux/resource.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -46,8 +47,6 @@
 extern void sem_exit (void);
 extern struct task_struct *child_reaper;
 
-int getrusage(struct task_struct *, int, struct rusage __user *);
-
 static void exit_mm(struct task_struct * tsk);
 
 static void __unhash_process(struct task_struct *p)

