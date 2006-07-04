Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWGDMdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWGDMdT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWGDMdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:33:19 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:43194 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932245AbWGDMdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 08:33:18 -0400
Date: Tue, 4 Jul 2006 21:33:01 +0900
From: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
To: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kdump: add a missing notifier before crashing
Message-Id: <20060704213301.4701055e.akiyama.nobuyuk@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The attached patch adds a missing notifier before crashing.
This patch is remade for 2.6.17-git22.
I tested this patch on a i386-box.

Please refer to the previous discussions for details:
http://lists.osdl.org/pipermail/fastboot/2006-May/003018.html
http://lists.osdl.org/pipermail/fastboot/2006-June/003113.html

Description:
We don't have a simple and light weight way to know the
kernel dies. The panic notifier does not be called if kdump
is activated because crash_kexec() does not return,
and there is no mechanism to notify of a crash before
crashing by SysRq-c.
Although notify_die() exists, but the function depends on
architecture. If notify_die() is added in panic and SysRq
respectively like existing implementation, the code will be
very ugly. I think that adding a generic hook in crash_kexec()
is better to simplify the code.

For example, the clustering system can take advantage of this
notifier. On a mission critical system, failover needs to start
within a few milli-second. The notifier could be called on
2nd kernel, but it is no use because it takes the time of
second order to boot up.

On an actual system, the notifier turns off HBA's power to
stop accessing shared disk, and then notifies standby node
that the current node died. 

Thanks,
--
Akiyama, Nobuyuki


Signed-off-by: Akiyama, Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com>
---

 Documentation/filesystems/proc.txt |   11 +++++++++++
 arch/i386/kernel/traps.c           |    4 ++--
 arch/powerpc/kernel/traps.c        |    2 +-
 arch/x86_64/kernel/traps.c         |    4 ++--
 drivers/char/sysrq.c               |    2 +-
 include/linux/kexec.h              |   12 ++++++++++--
 include/linux/sysctl.h             |    1 +
 kernel/kexec.c                     |   18 +++++++++++++++++-
 kernel/panic.c                     |    2 +-
 kernel/sysctl.c                    |   11 +++++++++++
 10 files changed, 57 insertions(+), 10 deletions(-)

diff -Nurp linux-2.6.17-git22/Documentation/filesystems/proc.txt linux-2.6.17-git22.mod/Documentation/filesystems/proc.txt
--- linux-2.6.17-git22/Documentation/filesystems/proc.txt	2006-07-04 17:35:00.000000000 +0900
+++ linux-2.6.17-git22.mod/Documentation/filesystems/proc.txt	2006-07-04 19:43:32.000000000 +0900
@@ -1130,6 +1130,17 @@ If a system hangs up, try pressing the N
    And NMI watchdog will be disabled when the value in this file is set to
    non-zero.
 
+kdump_safe
+----------
+
+The value in this file affects behavior of a notifier before kdump. When the
+value is non-zero(default), the notifier is not called before crashing. If the
+notifier is expected to be called before crashing, set zero.
+
+[NOTE]
+   The notifier may be hung and kdump may be stalled because the notifier is
+   usually called under panic state. The value of this file should be decided
+   by the policy of system usage.  
 
 2.4 /proc/sys/vm - The virtual memory subsystem
 -----------------------------------------------
diff -Nurp linux-2.6.17-git22/arch/i386/kernel/traps.c linux-2.6.17-git22.mod/arch/i386/kernel/traps.c
--- linux-2.6.17-git22/arch/i386/kernel/traps.c	2006-07-04 17:34:59.000000000 +0900
+++ linux-2.6.17-git22.mod/arch/i386/kernel/traps.c	2006-07-04 19:43:32.000000000 +0900
@@ -437,7 +437,7 @@ void die(const char * str, struct pt_reg
 		return;
 
 	if (kexec_should_crash(current))
-		crash_kexec(regs);
+		crash_kexec(CRASH_ON_DIE, regs, NULL);
 
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
@@ -688,7 +688,7 @@ void die_nmi (struct pt_regs *regs, cons
 	*/
 	if (!user_mode_vm(regs)) {
 		current->thread.trap_no = 2;
-		crash_kexec(regs);
+		crash_kexec(CRASH_ON_DIE, regs, NULL);
 	}
 
 	do_exit(SIGSEGV);
diff -Nurp linux-2.6.17-git22/arch/powerpc/kernel/traps.c linux-2.6.17-git22.mod/arch/powerpc/kernel/traps.c
--- linux-2.6.17-git22/arch/powerpc/kernel/traps.c	2006-07-04 17:34:59.000000000 +0900
+++ linux-2.6.17-git22.mod/arch/powerpc/kernel/traps.c	2006-07-04 19:43:32.000000000 +0900
@@ -144,7 +144,7 @@ int die(const char *str, struct pt_regs 
 
 	if (kexec_should_crash(current) ||
 		kexec_sr_activated(smp_processor_id()))
-		crash_kexec(regs);
+		crash_kexec(CRASH_ON_DIE, regs, NULL);
 	crash_kexec_secondary(regs);
 
 	if (in_interrupt())
diff -Nurp linux-2.6.17-git22/arch/x86_64/kernel/traps.c linux-2.6.17-git22.mod/arch/x86_64/kernel/traps.c
--- linux-2.6.17-git22/arch/x86_64/kernel/traps.c	2006-07-04 17:34:59.000000000 +0900
+++ linux-2.6.17-git22.mod/arch/x86_64/kernel/traps.c	2006-07-04 19:43:32.000000000 +0900
@@ -545,7 +545,7 @@ void __kprobes __die(const char * str, s
 	printk_address(regs->rip); 
 	printk(" RSP <%016lx>\n", regs->rsp); 
 	if (kexec_should_crash(current))
-		crash_kexec(regs);
+		crash_kexec(CRASH_ON_DIE, regs, NULL);
 }
 
 void die(const char * str, struct pt_regs * regs, long err)
@@ -569,7 +569,7 @@ void __kprobes die_nmi(char *str, struct
 	printk(str, safe_smp_processor_id());
 	show_registers(regs);
 	if (kexec_should_crash(current))
-		crash_kexec(regs);
+		crash_kexec(CRASH_ON_DIE, regs, NULL);
 	if (panic_on_timeout || panic_on_oops)
 		panic("nmi watchdog");
 	printk("console shuts up ...\n");
diff -Nurp linux-2.6.17-git22/drivers/char/sysrq.c linux-2.6.17-git22.mod/drivers/char/sysrq.c
--- linux-2.6.17-git22/drivers/char/sysrq.c	2006-07-04 17:34:58.000000000 +0900
+++ linux-2.6.17-git22.mod/drivers/char/sysrq.c	2006-07-04 19:43:32.000000000 +0900
@@ -98,7 +98,7 @@ static struct sysrq_key_op sysrq_unraw_o
 static void sysrq_handle_crashdump(int key, struct pt_regs *pt_regs,
 				struct tty_struct *tty)
 {
-	crash_kexec(pt_regs);
+	crash_kexec(CRASH_ON_SYSRQ, pt_regs, NULL);
 }
 static struct sysrq_key_op sysrq_crashdump_op = {
 	.handler	= sysrq_handle_crashdump,
diff -Nurp linux-2.6.17-git22/include/linux/kexec.h linux-2.6.17-git22.mod/include/linux/kexec.h
--- linux-2.6.17-git22/include/linux/kexec.h	2006-07-04 17:35:01.000000000 +0900
+++ linux-2.6.17-git22.mod/include/linux/kexec.h	2006-07-04 19:43:32.000000000 +0900
@@ -1,12 +1,18 @@
 #ifndef LINUX_KEXEC_H
 #define LINUX_KEXEC_H
 
+/* crash type for notifier */
+#define CRASH_ON_PANIC		1
+#define CRASH_ON_DIE		2
+#define CRASH_ON_SYSRQ		3
+
 #ifdef CONFIG_KEXEC
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/linkage.h>
 #include <linux/compat.h>
 #include <linux/ioport.h>
+#include <linux/notifier.h>
 #include <asm/kexec.h>
 
 /* Verify architecture specific macros are defined */
@@ -103,10 +109,12 @@ extern asmlinkage long compat_sys_kexec_
 #endif
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
-extern void crash_kexec(struct pt_regs *);
+extern void crash_kexec(int, struct pt_regs *, void *);
 int kexec_should_crash(struct task_struct *);
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
+extern struct raw_notifier_head crash_notifier_list;
+extern int kdump_safe;
 
 #define KEXEC_ON_CRASH  0x00000001
 #define KEXEC_ARCH_MASK 0xffff0000
@@ -134,7 +142,7 @@ extern note_buf_t *crash_notes;
 #else /* !CONFIG_KEXEC */
 struct pt_regs;
 struct task_struct;
-static inline void crash_kexec(struct pt_regs *regs) { }
+static inline void crash_kexec(int type, struct pt_regs *regs, void *v) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 #endif /* CONFIG_KEXEC */
 #endif /* LINUX_KEXEC_H */
diff -Nurp linux-2.6.17-git22/include/linux/sysctl.h linux-2.6.17-git22.mod/include/linux/sysctl.h
--- linux-2.6.17-git22/include/linux/sysctl.h	2006-07-04 17:35:00.000000000 +0900
+++ linux-2.6.17-git22.mod/include/linux/sysctl.h	2006-07-04 19:43:32.000000000 +0900
@@ -150,6 +150,7 @@ enum
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
 	KERN_COMPAT_LOG=73,	/* int: print compat layer  messages */
 	KERN_MAX_LOCK_DEPTH=74,
+	KERN_KDUMP_SAFE=75,	/* int: crash notifier flag */
 };
 
 
diff -Nurp linux-2.6.17-git22/kernel/kexec.c linux-2.6.17-git22.mod/kernel/kexec.c
--- linux-2.6.17-git22/kernel/kexec.c	2006-07-04 17:35:04.000000000 +0900
+++ linux-2.6.17-git22.mod/kernel/kexec.c	2006-07-04 19:43:32.000000000 +0900
@@ -20,6 +20,8 @@
 #include <linux/syscalls.h>
 #include <linux/ioport.h>
 #include <linux/hardirq.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
 
 #include <asm/page.h>
 #include <asm/uaccess.h>
@@ -27,6 +29,11 @@
 #include <asm/system.h>
 #include <asm/semaphore.h>
 
+
+RAW_NOTIFIER_HEAD(crash_notifier_list);
+EXPORT_SYMBOL(crash_notifier_list);
+int kdump_safe = 1;
+
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t* crash_notes;
 
@@ -1040,7 +1047,15 @@ asmlinkage long compat_sys_kexec_load(un
 }
 #endif
 
-void crash_kexec(struct pt_regs *regs)
+static inline void notify_crash(int type, void *v)
+{
+#ifdef CONFIG_SYSCTL
+	if (!kdump_safe)
+		raw_notifier_call_chain(&crash_notifier_list, type, v);
+#endif
+}
+
+void crash_kexec(int type, struct pt_regs *regs, void *v)
 {
 	int locked;
 
@@ -1059,6 +1074,7 @@ void crash_kexec(struct pt_regs *regs)
 			struct pt_regs fixed_regs;
 			crash_setup_regs(&fixed_regs, regs);
 			machine_crash_shutdown(&fixed_regs);
+			notify_crash(type, v);
 			machine_kexec(kexec_crash_image);
 		}
 		xchg(&kexec_lock, 0);
diff -Nurp linux-2.6.17-git22/kernel/panic.c linux-2.6.17-git22.mod/kernel/panic.c
--- linux-2.6.17-git22/kernel/panic.c	2006-07-04 17:35:04.000000000 +0900
+++ linux-2.6.17-git22.mod/kernel/panic.c	2006-07-04 19:43:32.000000000 +0900
@@ -84,7 +84,7 @@ NORET_TYPE void panic(const char * fmt, 
 	 * everything else.
 	 * Do we want to call this before we try to display a message?
 	 */
-	crash_kexec(NULL);
+	crash_kexec(CRASH_ON_PANIC, NULL, buf);
 
 #ifdef CONFIG_SMP
 	/*
diff -Nurp linux-2.6.17-git22/kernel/sysctl.c linux-2.6.17-git22.mod/kernel/sysctl.c
--- linux-2.6.17-git22/kernel/sysctl.c	2006-07-04 17:35:04.000000000 +0900
+++ linux-2.6.17-git22.mod/kernel/sysctl.c	2006-07-04 19:45:08.000000000 +0900
@@ -45,6 +45,7 @@
 #include <linux/syscalls.h>
 #include <linux/nfs_fs.h>
 #include <linux/acpi.h>
+#include <linux/kexec.h>
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
@@ -701,6 +702,16 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#if defined(CONFIG_KEXEC)
+	{
+		.ctl_name       = KERN_KDUMP_SAFE,
+		.procname       = "kdump_safe",
+		.data           = &kdump_safe,
+		.maxlen         = sizeof (int),
+		.mode           = 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
 
 	{ .ctl_name = 0 }
 };

