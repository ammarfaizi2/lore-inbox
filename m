Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWFBFM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWFBFM4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 01:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWFBFM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 01:12:56 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:14245 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751126AbWFBFMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 01:12:55 -0400
Date: Fri, 2 Jun 2006 14:13:01 +0900
From: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
To: vgoyal@in.ibm.com
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
Message-Id: <20060602141301.cdecf0e1.akiyama.nobuyuk@jp.fujitsu.com>
In-Reply-To: <20060601151605.GA7380@in.ibm.com>
References: <20060530183359.a8d5d736.akiyama.nobuyuk@jp.fujitsu.com>
	<20060530145658.GC6536@in.ibm.com>
	<20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com>
	<20060531154322.GA8475@in.ibm.com>
	<20060601213730.dc9f1ec4.akiyama.nobuyuk@jp.fujitsu.com>
	<20060601151605.GA7380@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006 11:16:05 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> On Thu, Jun 01, 2006 at 09:37:30PM +0900, Akiyama, Nobuyuki wrote:
> > On Wed, 31 May 2006 11:43:22 -0400
> > Vivek Goyal <vgoyal@in.ibm.com> wrote:
> > 
> > > On Wed, May 31, 2006 at 06:20:45PM +0900, Akiyama, Nobuyuki wrote:
> > > > Hello Vivek-san,
> > > > 
> > > > On Tue, 30 May 2006 10:56:58 -0400
> > > > Vivek Goyal <vgoyal@in.ibm.com> wrote:
> > > > 
> > > > > On Tue, May 30, 2006 at 06:33:59PM +0900, Akiyama, Nobuyuki wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > The panic notifier(i.e. panic_notifier_list) does not be called
> > > > > > if kdump is activated because crash_kexec() does not return.
> > > > > > And there is nothing to notify of crash before crashing by SysRq-c.
> > > > > > 
> > > > > > Although notify_die() exists, the function depends on architecture.
> > > > > > If notify_die() is added in panic and SysRq respectively like existing
> > > > > > implementation, the code will be ugly.
> > > > > > I think that adding a generic hook in crash_kexec() is better to simplify
> > > > > > the code. The panic_notifier_list-user will have nothing to do.
> > > > > > If you want to catch SysRq, use the crash_notifier_list.
> > > > > > 
> > > > > 
> > > > > What's the use of introducing crash_notifier_list? Who is going to use
> > > > > it for what purpose?
> > > > > 
> > > > > Probably we don't want to create any such infrastructure because carries
> > > > > the risk of hanging in between and reducing the reliability of dump 
> > > > > operation.
> > > > 
> > > > I really understand what you concern about.
> > > > But a certain program indeed needs some processing before
> > > > crashing even if panic occurs.
> > > > Now standard kernel includes some panic_notifier_list-user,
> > > > these are the familiar examples.
> > > 
> > > I see the panic_notifier_list but I am afraid that we can not afford
> > > to send the crash/panic notifications if system admin has chosen to load
> > > the kdump kernel and has decided to take a dump in case of a crash event.
> > > This might very seriously compromise the reliability of kdump. IIRC, we
> > > recently saw an issue with powerpc where we did not even start booting into
> > > the second kernel as system lost way somewhere while handling notifiers.
> > > 
> > > So far on a panic event kernel only used to display the panic string
> > > and halt the system but now it tries to do much more. That is boot
> > > into the second kernel and caputure the dump. Of course, one can argue
> > > that I want to implement a different policy in case of system crash. In
> > > that case probably we should not load the kdump kernel at all.
> > > 
> > > panic_notifier_list helps in this regard that multiple subsystem can
> > > register their own policy and policy will be excuted in the registered
> > > priority order. Given the nature of kdump, I feel it is kind of 
> > > mutually exclusive and can not co-exist with other policies. Otherwise, we 
> > > will end up calling all other policies first and trigger booting into
> > > the second kernel last. This is equivalent to giving higher priority to
> > > all other policies and least priority to kdump.
> > 
> > I think crash_kexec() is the best point to simplify notifier-call.
> > If the notifier is bad implementation, kdump reliability may
> > be decreased. But the risk depends on notifier quality.
> > I think it is not bad that we have the opportunity to call notifier.
> > As you say, current panic_notifier_list may not be suitable
> > because that was implemented before kdump merged.
> > 
> > You accept if panic_notifier_list is dropped from crash_notify()
> > like below(not complete patch)? If one want to catch panic
> > and SysRq event before crashing, crash_notifier_list can be used.
> 
> Ok. Given the fast switchover requirement, may be it makes sense to generate 
> panic events before switching to new kernel. Though it will be a compromise
> on kdump's reliability and now its success will be dependent on how well 
> behaved the notifier callback is.
> 
> Why to create a separate list crash_notifier_list? What's the difference
> between a panic_notifier and crash_notifier. To me both are same. Basically
> kernel is going down and if some subsystem wants to take some minimal
> action, he can do it now. But he got to remember that he is running from
> inside panic and he should not depend too much on kernel data structures
> as these might be corrupted.
> 
> At the same time the notifier got to remember that there are other folks
> waiting in the queue so he needs to return ASAP. I see some code in 
> powerpc where panic notifier call seems to be jumping to firmware and 
> bring the system down. We shall have to fix such calls to see if crash
> dump kernel is loaded then don't jump to firmware.

I don't think all people will use kdump(but I recommend my customer
to use kdump ;-).
The aim of panic notifier and crash notifier is a little different,
so I thought these notifier lists should be separated.
The panic notifier was not expected of kdump after notifier return!
I think the better way is to modify panic notifiers to fit with
kdump and to move into crash notifier gradually if necessary.

I attach a patch which eliminates panic nofiter.

Regards,

Akiyama, Nobuyuki

Signed-off-by: Akiyama, Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com>
---

diff -Nurp linux-2.6.17-rc5/arch/i386/kernel/traps.c linux-2.6.17-rc5.mod/arch/i386/kernel/traps.c
--- linux-2.6.17-rc5/arch/i386/kernel/traps.c	2006-05-25 22:23:21.000000000 +0900
+++ linux-2.6.17-rc5.mod/arch/i386/kernel/traps.c	2006-05-30 12:12:25.000000000 +0900
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
diff -Nurp linux-2.6.17-rc5/arch/powerpc/kernel/traps.c linux-2.6.17-rc5.mod/arch/powerpc/kernel/traps.c
--- linux-2.6.17-rc5/arch/powerpc/kernel/traps.c	2006-05-25 22:23:21.000000000 +0900
+++ linux-2.6.17-rc5.mod/arch/powerpc/kernel/traps.c	2006-05-30 12:14:07.000000000 +0900
@@ -132,7 +132,7 @@ int die(const char *str, struct pt_regs 
 	if (!crash_dump_start && kexec_should_crash(current)) {
 		crash_dump_start = 1;
 		spin_unlock_irq(&die_lock);
-		crash_kexec(regs);
+		crash_kexec(CRASH_ON_DIE, regs, NULL);
 		/* NOTREACHED */
 	}
 	spin_unlock_irq(&die_lock);
diff -Nurp linux-2.6.17-rc5/arch/x86_64/kernel/traps.c linux-2.6.17-rc5.mod/arch/x86_64/kernel/traps.c
--- linux-2.6.17-rc5/arch/x86_64/kernel/traps.c	2006-05-25 22:23:22.000000000 +0900
+++ linux-2.6.17-rc5.mod/arch/x86_64/kernel/traps.c	2006-05-30 12:13:24.000000000 +0900
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
diff -Nurp linux-2.6.17-rc5/drivers/char/sysrq.c linux-2.6.17-rc5.mod/drivers/char/sysrq.c
--- linux-2.6.17-rc5/drivers/char/sysrq.c	2006-05-25 22:23:22.000000000 +0900
+++ linux-2.6.17-rc5.mod/drivers/char/sysrq.c	2006-05-30 13:26:00.000000000 +0900
@@ -99,7 +99,7 @@ static struct sysrq_key_op sysrq_unraw_o
 static void sysrq_handle_crashdump(int key, struct pt_regs *pt_regs,
 				struct tty_struct *tty)
 {
-	crash_kexec(pt_regs);
+	crash_kexec(CRASH_ON_SYSRQ, pt_regs, NULL);
 }
 static struct sysrq_key_op sysrq_crashdump_op = {
 	.handler	= sysrq_handle_crashdump,
diff -Nurp linux-2.6.17-rc5/include/linux/kexec.h linux-2.6.17-rc5.mod/include/linux/kexec.h
--- linux-2.6.17-rc5/include/linux/kexec.h	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.17-rc5.mod/include/linux/kexec.h	2006-05-30 17:25:35.000000000 +0900
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
@@ -103,9 +109,10 @@ extern asmlinkage long compat_sys_kexec_
 #endif
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
-extern void crash_kexec(struct pt_regs *);
+extern void crash_kexec(int, struct pt_regs *, void *);
 int kexec_should_crash(struct task_struct *);
 extern struct kimage *kexec_image;
+extern struct raw_notifier_head crash_notifier_list;
 
 #define KEXEC_ON_CRASH  0x00000001
 #define KEXEC_ARCH_MASK 0xffff0000
@@ -133,7 +140,7 @@ extern note_buf_t *crash_notes;
 #else /* !CONFIG_KEXEC */
 struct pt_regs;
 struct task_struct;
-static inline void crash_kexec(struct pt_regs *regs) { }
+static inline void crash_kexec(int type, struct pt_regs *regs, void *v) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 #endif /* CONFIG_KEXEC */
 #endif /* LINUX_KEXEC_H */
diff -Nurp linux-2.6.17-rc5/kernel/kexec.c linux-2.6.17-rc5.mod/kernel/kexec.c
--- linux-2.6.17-rc5/kernel/kexec.c	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.17-rc5.mod/kernel/kexec.c	2006-06-02 11:35:42.000000000 +0900
@@ -20,6 +20,8 @@
 #include <linux/syscalls.h>
 #include <linux/ioport.h>
 #include <linux/hardirq.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
 
 #include <asm/page.h>
 #include <asm/uaccess.h>
@@ -27,6 +29,10 @@
 #include <asm/system.h>
 #include <asm/semaphore.h>
 
+
+RAW_NOTIFIER_HEAD(crash_notifier_list);
+EXPORT_SYMBOL(crash_notifier_list);
+
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t* crash_notes;
 
@@ -1040,7 +1046,12 @@ asmlinkage long compat_sys_kexec_load(un
 }
 #endif
 
-void crash_kexec(struct pt_regs *regs)
+static inline void notify_crash(int type, void *v)
+{
+	raw_notifier_call_chain(&crash_notifier_list, type, v);
+}
+
+void crash_kexec(int type, struct pt_regs *regs, void *v)
 {
 	struct kimage *image;
 	int locked;
@@ -1061,6 +1072,7 @@ void crash_kexec(struct pt_regs *regs)
 			struct pt_regs fixed_regs;
 			crash_setup_regs(&fixed_regs, regs);
 			machine_crash_shutdown(&fixed_regs);
+			notify_crash(type, v);
 			machine_kexec(image);
 		}
 		xchg(&kexec_lock, 0);
diff -Nurp linux-2.6.17-rc5/kernel/panic.c linux-2.6.17-rc5.mod/kernel/panic.c
--- linux-2.6.17-rc5/kernel/panic.c	2006-05-25 22:23:30.000000000 +0900
+++ linux-2.6.17-rc5.mod/kernel/panic.c	2006-05-30 12:15:59.000000000 +0900
@@ -85,7 +85,7 @@ NORET_TYPE void panic(const char * fmt, 
 	 * everything else.
 	 * Do we want to call this before we try to display a message?
 	 */
-	crash_kexec(NULL);
+	crash_kexec(CRASH_ON_PANIC, NULL, buf);
 
 #ifdef CONFIG_SMP
 	/*


