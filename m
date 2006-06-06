Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWFFN6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWFFN6V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWFFN6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:58:21 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:55760 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932176AbWFFN6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:58:20 -0400
Date: Tue, 6 Jun 2006 22:59:43 +0900
From: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
To: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
Cc: Preben.Trarup@ericsson.com, fastboot@lists.osdl.org, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
Message-Id: <20060606225943.32445633.akiyama.nobuyuk@jp.fujitsu.com>
In-Reply-To: <20060606200837.3ad723c0.akiyama.nobuyuk@jp.fujitsu.com>
References: <20060530183359.a8d5d736.akiyama.nobuyuk@jp.fujitsu.com>
	<20060530145658.GC6536@in.ibm.com>
	<20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com>
	<20060531154322.GA8475@in.ibm.com>
	<20060601213730.dc9f1ec4.akiyama.nobuyuk@jp.fujitsu.com>
	<20060601151605.GA7380@in.ibm.com>
	<20060602141301.cdecf0e1.akiyama.nobuyuk@jp.fujitsu.com>
	<44800E1A.1080306@ericsson.com>
	<m1fyin6agv.fsf@ebiederm.dsl.xmission.com>
	<44803B1F.8070302@ericsson.com>
	<m13ben60tn.fsf@ebiederm.dsl.xmission.com>
	<44854C8D.6040707@ericsson.com>
	<20060606200837.3ad723c0.akiyama.nobuyuk@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006 20:08:37 +0900
"Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com> wrote:

> > To handle the contradiction of adding crash notifier to kexec and 
> > maintaining kexec reliability
> > I suggest adding a flag to Kconfig
> > ENABLE_CRASH_NOTIFIER
> > 
> > This removes any code in the critical path for people not needing crash 
> > notification.
> 
> I am just thinking same thing, but one point is different.
> To select policy by Kconfig is not flexible. If we want to change policy,
> we have to rebuild the kernel. I don't think that distributors release
> the kernels for each policy.
> 
> Instead of Kconfig, how about using proc filesystem. e.g. kdump_safe.
> If kdump_safe is 1, crash notifier will not be called.
> If kdump_safe is 0, crash notifier will be called.  

I attach a sample patch for help to discuss.


diff -Nurp linux-2.6.17-rc6/arch/i386/kernel/traps.c linux-2.6.17-rc6.mod/arch/i386/kernel/traps.c
--- linux-2.6.17-rc6/arch/i386/kernel/traps.c	2006-06-06 22:47:38.000000000 +0900
+++ linux-2.6.17-rc6.mod/arch/i386/kernel/traps.c	2006-06-06 22:51:01.000000000 +0900
@@ -414,7 +414,7 @@ void die(const char * str, struct pt_reg
 		return;
 
 	if (kexec_should_crash(current))
-		crash_kexec(regs);
+		crash_kexec(CRASH_ON_DIE, regs, NULL);
 
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
@@ -665,7 +665,7 @@ void die_nmi (struct pt_regs *regs, cons
 	*/
 	if (!user_mode_vm(regs)) {
 		current->thread.trap_no = 2;
-		crash_kexec(regs);
+		crash_kexec(CRASH_ON_DIE, regs, NULL);
 	}
 
 	do_exit(SIGSEGV);
diff -Nurp linux-2.6.17-rc6/arch/powerpc/kernel/traps.c linux-2.6.17-rc6.mod/arch/powerpc/kernel/traps.c
--- linux-2.6.17-rc6/arch/powerpc/kernel/traps.c	2006-06-06 22:47:39.000000000 +0900
+++ linux-2.6.17-rc6.mod/arch/powerpc/kernel/traps.c	2006-06-06 22:51:01.000000000 +0900
@@ -132,7 +132,7 @@ int die(const char *str, struct pt_regs 
 	if (!crash_dump_start && kexec_should_crash(current)) {
 		crash_dump_start = 1;
 		spin_unlock_irq(&die_lock);
-		crash_kexec(regs);
+		crash_kexec(CRASH_ON_DIE, regs, NULL);
 		/* NOTREACHED */
 	}
 	spin_unlock_irq(&die_lock);
diff -Nurp linux-2.6.17-rc6/arch/x86_64/kernel/traps.c linux-2.6.17-rc6.mod/arch/x86_64/kernel/traps.c
--- linux-2.6.17-rc6/arch/x86_64/kernel/traps.c	2006-06-06 22:47:40.000000000 +0900
+++ linux-2.6.17-rc6.mod/arch/x86_64/kernel/traps.c	2006-06-06 22:51:01.000000000 +0900
@@ -445,7 +445,7 @@ void __kprobes __die(const char * str, s
 	printk_address(regs->rip); 
 	printk(" RSP <%016lx>\n", regs->rsp); 
 	if (kexec_should_crash(current))
-		crash_kexec(regs);
+		crash_kexec(CRASH_ON_DIE, regs, NULL);
 }
 
 void die(const char * str, struct pt_regs * regs, long err)
@@ -469,7 +469,7 @@ void __kprobes die_nmi(char *str, struct
 	printk(str, safe_smp_processor_id());
 	show_registers(regs);
 	if (kexec_should_crash(current))
-		crash_kexec(regs);
+		crash_kexec(CRASH_ON_DIE, regs, NULL);
 	if (panic_on_timeout || panic_on_oops)
 		panic("nmi watchdog");
 	printk("console shuts up ...\n");
diff -Nurp linux-2.6.17-rc6/drivers/char/sysrq.c linux-2.6.17-rc6.mod/drivers/char/sysrq.c
--- linux-2.6.17-rc6/drivers/char/sysrq.c	2006-06-06 22:47:40.000000000 +0900
+++ linux-2.6.17-rc6.mod/drivers/char/sysrq.c	2006-06-06 22:51:01.000000000 +0900
@@ -99,7 +99,7 @@ static struct sysrq_key_op sysrq_unraw_o
 static void sysrq_handle_crashdump(int key, struct pt_regs *pt_regs,
 				struct tty_struct *tty)
 {
-	crash_kexec(pt_regs);
+	crash_kexec(CRASH_ON_SYSRQ, pt_regs, NULL);
 }
 static struct sysrq_key_op sysrq_crashdump_op = {
 	.handler	= sysrq_handle_crashdump,
diff -Nurp linux-2.6.17-rc6/include/linux/kexec.h linux-2.6.17-rc6.mod/include/linux/kexec.h
--- linux-2.6.17-rc6/include/linux/kexec.h	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.17-rc6.mod/include/linux/kexec.h	2006-06-06 22:51:01.000000000 +0900
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
@@ -103,9 +109,11 @@ extern asmlinkage long compat_sys_kexec_
 #endif
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
-extern void crash_kexec(struct pt_regs *);
+extern void crash_kexec(int, struct pt_regs *, void *);
 int kexec_should_crash(struct task_struct *);
 extern struct kimage *kexec_image;
+extern struct raw_notifier_head crash_notifier_list;
+extern int kdump_safe;
 
 #define KEXEC_ON_CRASH  0x00000001
 #define KEXEC_ARCH_MASK 0xffff0000
@@ -133,7 +141,7 @@ extern note_buf_t *crash_notes;
 #else /* !CONFIG_KEXEC */
 struct pt_regs;
 struct task_struct;
-static inline void crash_kexec(struct pt_regs *regs) { }
+static inline void crash_kexec(int type, struct pt_regs *regs, void *v) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 #endif /* CONFIG_KEXEC */
 #endif /* LINUX_KEXEC_H */
diff -Nurp linux-2.6.17-rc6/include/linux/sysctl.h linux-2.6.17-rc6.mod/include/linux/sysctl.h
--- linux-2.6.17-rc6/include/linux/sysctl.h	2006-06-06 22:47:54.000000000 +0900
+++ linux-2.6.17-rc6.mod/include/linux/sysctl.h	2006-06-06 22:51:01.000000000 +0900
@@ -148,6 +148,7 @@ enum
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
+	KERN_KDUMP_SAFE=73,	/* int: crash notifier flag */
 };
 
 
diff -Nurp linux-2.6.17-rc6/kernel/kexec.c linux-2.6.17-rc6.mod/kernel/kexec.c
--- linux-2.6.17-rc6/kernel/kexec.c	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.17-rc6.mod/kernel/kexec.c	2006-06-06 22:51:17.000000000 +0900
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
 	struct kimage *image;
 	int locked;
@@ -1061,6 +1076,7 @@ void crash_kexec(struct pt_regs *regs)
 			struct pt_regs fixed_regs;
 			crash_setup_regs(&fixed_regs, regs);
 			machine_crash_shutdown(&fixed_regs);
+			notify_crash(type, v);
 			machine_kexec(image);
 		}
 		xchg(&kexec_lock, 0);
diff -Nurp linux-2.6.17-rc6/kernel/panic.c linux-2.6.17-rc6.mod/kernel/panic.c
--- linux-2.6.17-rc6/kernel/panic.c	2006-06-06 22:47:54.000000000 +0900
+++ linux-2.6.17-rc6.mod/kernel/panic.c	2006-06-06 22:51:01.000000000 +0900
@@ -85,7 +85,7 @@ NORET_TYPE void panic(const char * fmt, 
 	 * everything else.
 	 * Do we want to call this before we try to display a message?
 	 */
-	crash_kexec(NULL);
+	crash_kexec(CRASH_ON_PANIC, NULL, buf);
 
 #ifdef CONFIG_SMP
 	/*
diff -Nurp linux-2.6.17-rc6/kernel/sysctl.c linux-2.6.17-rc6.mod/kernel/sysctl.c
--- linux-2.6.17-rc6/kernel/sysctl.c	2006-06-06 22:47:54.000000000 +0900
+++ linux-2.6.17-rc6.mod/kernel/sysctl.c	2006-06-06 22:51:01.000000000 +0900
@@ -46,6 +46,7 @@
 #include <linux/syscalls.h>
 #include <linux/nfs_fs.h>
 #include <linux/acpi.h>
+#include <linux/kexec.h>
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
@@ -683,6 +684,16 @@ static ctl_table kern_table[] = {
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
 

