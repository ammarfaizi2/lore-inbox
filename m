Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268751AbTGTV4W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 17:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268731AbTGTVzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 17:55:49 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:12554 "EHLO
	mwinf0604.wanadoo.fr") by vger.kernel.org with ESMTP
	id S268589AbTGTVy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 17:54:58 -0400
Date: Mon, 21 Jul 2003 00:09:47 +0200 (CEST)
From: Philippe Biondi <biondi@cartel-securite.fr>
X-X-Sender: pbi@deneb.intranet.cartel-securite.net
To: linux-kernel@vger.kernel.org, <jdike@karaya.com>
Subject: [PATCH] linux-2.6.0-test1, having ARCH=um compile
Message-ID: <Pine.LNX.4.44.0307202356550.6274-100000@deneb.intranet.cartel-securite.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

It seems ARCH=um not ready yet.
There are some #include problems (for ex: cyclic dependency between
linux/spinlock.h and linux/seqlock.h), some missing constants, some
missing functions.

Here is an ugly patch (I did that as a robot, without trying to understand
anything). Now it compiles.

It does not run (stack overflow : sigprocmask() calls spin_lock_irq(),
that expends to sth that calls block_signals(), that calls sigprocmask())

Great. Now I have to leave. If someone want to carry on, or if someone can
say me it was not worth the effort because all is already done in another
patch... please go on :)



diff -Nrup linux-2.6.0-test1-ori/arch/i386/kernel/module.c linux-2.6.0-test1/arch/i386/kernel/module.c
--- linux-2.6.0-test1-ori/arch/i386/kernel/module.c	2003-07-14 05:34:03.000000000 +0200
+++ linux-2.6.0-test1/arch/i386/kernel/module.c	2003-07-20 20:09:58.000000000 +0200
@@ -104,7 +104,7 @@ int apply_relocate_add(Elf32_Shdr *sechd
 	return -ENOEXEC;
 }

-extern void apply_alternatives(void *start, void *end);
+void apply_alternatives(void *start, void *end) {}

 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
diff -Nrup linux-2.6.0-test1-ori/arch/um/drivers/line.c linux-2.6.0-test1/arch/um/drivers/line.c
--- linux-2.6.0-test1-ori/arch/um/drivers/line.c	2003-07-14 05:37:33.000000000 +0200
+++ linux-2.6.0-test1/arch/um/drivers/line.c	2003-07-20 22:26:07.000000000 +0200
@@ -430,10 +430,10 @@ struct tty_driver *line_register_devfs(s
 	if(err) printk("Symlink creation from /dev/%s to /dev/%s "
 		       "returned %d\n", from, to, err);

-	for(i = 0; i < nlines; i++){
+/*	for(i = 0; i < nlines; i++){
 		if(!lines[i].valid)
 			tty_unregister_devfs(driver, i);
-	}
+	} */

 	mconsole_register_dev(&line_driver->mc);
 	return driver;
diff -Nrup linux-2.6.0-test1-ori/arch/um/drivers/stdio_console.c linux-2.6.0-test1/arch/um/drivers/stdio_console.c
--- linux-2.6.0-test1-ori/arch/um/drivers/stdio_console.c	2003-07-14 05:31:58.000000000 +0200
+++ linux-2.6.0-test1/arch/um/drivers/stdio_console.c	2003-07-20 18:05:27.000000000 +0200
@@ -159,6 +159,15 @@ static int chars_in_buffer(struct tty_st

 static int con_init_done = 0;

+static struct tty_operations console_ops = {
+	.open 	 		= con_open,
+	.close 	 		= con_close,
+	.write 	 		= con_write,
+	.chars_in_buffer 	= chars_in_buffer,
+	.set_termios 		= set_termios,
+	.write_room		= line_write_room,
+};
+
 int stdio_init(void)
 {
 	char *new_title;
@@ -188,15 +197,6 @@ static void console_write(struct console
 	if(con_init_done) up(&vts[console->index].sem);
 }

-static struct tty_operations console_ops = {
-	.open 	 		= con_open,
-	.close 	 		= con_close,
-	.write 	 		= con_write,
-	.chars_in_buffer 	= chars_in_buffer,
-	.set_termios 		= set_termios,
-	.write_room		= line_write_room,
-};
-
 static struct tty_driver *console_device(struct console *c, int *index)
 {
 	*index = c->index;
diff -Nrup linux-2.6.0-test1-ori/arch/um/drivers/xterm_kern.c linux-2.6.0-test1/arch/um/drivers/xterm_kern.c
--- linux-2.6.0-test1-ori/arch/um/drivers/xterm_kern.c	2003-07-14 05:36:37.000000000 +0200
+++ linux-2.6.0-test1/arch/um/drivers/xterm_kern.c	2003-07-20 18:03:39.000000000 +0200
@@ -11,6 +11,7 @@
 #include "kern_util.h"
 #include "os.h"
 #include "xterm.h"
+#include "linux/signal.h"

 struct xterm_wait {
 	struct semaphore sem;
diff -Nrup linux-2.6.0-test1-ori/arch/um/kernel/init_task.c linux-2.6.0-test1/arch/um/kernel/init_task.c
--- linux-2.6.0-test1-ori/arch/um/kernel/init_task.c	2003-07-14 05:39:31.000000000 +0200
+++ linux-2.6.0-test1/arch/um/kernel/init_task.c	2003-07-20 17:13:47.000000000 +0200
@@ -17,6 +17,8 @@ static struct fs_struct init_fs = INIT_F
 struct mm_struct init_mm = INIT_MM(init_mm);
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
+static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
+

 /*
  * Initial task structure.
diff -Nrup linux-2.6.0-test1-ori/arch/um/kernel/irq.c linux-2.6.0-test1/arch/um/kernel/irq.c
--- linux-2.6.0-test1-ori/arch/um/kernel/irq.c	2003-07-14 05:37:17.000000000 +0200
+++ linux-2.6.0-test1/arch/um/kernel/irq.c	2003-07-20 17:32:42.000000000 +0200
@@ -384,7 +384,7 @@ out:
  */

 int request_irq(unsigned int irq,
-		void (*handler)(int, void *, struct pt_regs *),
+		irqreturn_t (*handler)(int, void *, struct pt_regs *),
 		unsigned long irqflags,
 		const char * devname,
 		void *dev_id)
@@ -436,7 +436,7 @@ int um_request_irq(unsigned int irq, int
 {
 	int retval;

-	retval = request_irq(irq, handler, irqflags, devname, dev_id);
+	retval = request_irq(irq, (irqreturn_t (*)(int, void *, struct pt_regs *))handler, irqflags, devname, dev_id);
 	if(retval) return(retval);
 	return(activate_fd(irq, fd, type, dev_id));
 }
diff -Nrup linux-2.6.0-test1-ori/arch/um/kernel/process.c linux-2.6.0-test1/arch/um/kernel/process.c
--- linux-2.6.0-test1-ori/arch/um/kernel/process.c	2003-07-14 05:37:28.000000000 +0200
+++ linux-2.6.0-test1/arch/um/kernel/process.c	2003-07-20 20:51:52.000000000 +0200
@@ -42,6 +42,9 @@
 #include "skas_ptrace.h"
 #endif

+void prepare_to_copy(struct task_struct *tsk)
+{}
+
 void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int))
 {
 	int flags = 0, pages;
diff -Nrup linux-2.6.0-test1-ori/arch/um/kernel/sigio_kern.c linux-2.6.0-test1/arch/um/kernel/sigio_kern.c
--- linux-2.6.0-test1-ori/arch/um/kernel/sigio_kern.c	2003-07-14 05:32:29.000000000 +0200
+++ linux-2.6.0-test1/arch/um/kernel/sigio_kern.c	2003-07-20 17:43:58.000000000 +0200
@@ -10,6 +10,7 @@
 #include "init.h"
 #include "sigio.h"
 #include "irq_user.h"
+#include "asm/signal.h"

 /* Protected by sigio_lock() called from write_sigio_workaround */
 static int sigio_irq_fd = -1;
diff -Nrup linux-2.6.0-test1-ori/arch/um/kernel/signal_kern.c linux-2.6.0-test1/arch/um/kernel/signal_kern.c
--- linux-2.6.0-test1-ori/arch/um/kernel/signal_kern.c	2003-07-14 05:34:42.000000000 +0200
+++ linux-2.6.0-test1/arch/um/kernel/signal_kern.c	2003-07-20 17:48:53.000000000 +0200
@@ -36,7 +36,7 @@ static void force_segv(int sig)
 	if(sig == SIGSEGV){
 		struct k_sigaction *ka;

-		ka = &current->sig->action[SIGSEGV - 1];
+		ka = &current->sighand->action[SIGSEGV - 1];
 		ka->sa.sa_handler = SIG_DFL;
 	}
 	force_sig(SIGSEGV, current);
@@ -142,7 +142,7 @@ static int kern_do_signal(struct pt_regs
 		return(0);

 	/* Whee!  Actually deliver the signal.  */
-	ka = &current->sig->action[sig -1 ];
+	ka = &current->sighand->action[sig -1 ];
 	err = handle_signal(regs, sig, ka, &info, oldset, error);
 	if(!err) return(1);

diff -Nrup linux-2.6.0-test1-ori/arch/um/kernel/time.c linux-2.6.0-test1/arch/um/kernel/time.c
--- linux-2.6.0-test1-ori/arch/um/kernel/time.c	2003-07-14 05:31:50.000000000 +0200
+++ linux-2.6.0-test1/arch/um/kernel/time.c	2003-07-20 18:02:11.000000000 +0200
@@ -16,6 +16,8 @@
 #include "signal_user.h"
 #include "time_user.h"

+#define NSEC_PER_SEC (1000000000L)
+
 extern struct timeval xtime;

 void timer(void)
diff -Nrup linux-2.6.0-test1-ori/arch/um/kernel/trap_kern.c linux-2.6.0-test1/arch/um/kernel/trap_kern.c
--- linux-2.6.0-test1-ori/arch/um/kernel/trap_kern.c	2003-07-14 05:30:00.000000000 +0200
+++ linux-2.6.0-test1/arch/um/kernel/trap_kern.c	2003-07-20 20:49:52.000000000 +0200
@@ -23,6 +23,11 @@
 #include "mconsole_kern.h"
 #include "2_5compat.h"

+void show_stack(struct task_struct *task, unsigned long *sp)
+{}
+
+
+
 int handle_page_fault(unsigned long address, unsigned long ip,
 		      int is_write, int is_user, int *code_out)
 {
diff -Nrup linux-2.6.0-test1-ori/arch/um/kernel/tt/tlb.c linux-2.6.0-test1/arch/um/kernel/tt/tlb.c
--- linux-2.6.0-test1-ori/arch/um/kernel/tt/tlb.c	2003-07-14 05:30:01.000000000 +0200
+++ linux-2.6.0-test1/arch/um/kernel/tt/tlb.c	2003-07-20 19:30:34.000000000 +0200
@@ -13,6 +13,7 @@
 #include "user_util.h"
 #include "mem_user.h"
 #include "os.h"
+#include "asm/tlbflush.h"

 static void fix_range(struct mm_struct *mm, unsigned long start_addr,
 		      unsigned long end_addr, int force)
diff -Nrup linux-2.6.0-test1-ori/arch/um/vmlinux.lds.S linux-2.6.0-test1/arch/um/vmlinux.lds.S
--- linux-2.6.0-test1-ori/arch/um/vmlinux.lds.S	2003-07-14 05:28:52.000000000 +0200
+++ linux-2.6.0-test1/arch/um/vmlinux.lds.S	2003-07-20 22:03:40.000000000 +0200
@@ -8,4 +8,13 @@ jiffies = jiffies_64;
 SECTIONS
 {
 #include "asm/common.lds.S"
+  .init.text : {
+        _sinittext = .;
+        *(.init.text)
+        _einittext = .;
+  }
+  __con_initcall_start = .;
+  .con_initcall.init : { *(.con_initcall.init) }
+  __con_initcall_end = .;
+  SECURITY_INIT
 }
diff -Nrup linux-2.6.0-test1-ori/include/asm-i386/spinlock.h linux-2.6.0-test1/include/asm-i386/spinlock.h
--- linux-2.6.0-test1-ori/include/asm-i386/spinlock.h	2003-07-14 05:31:58.000000000 +0200
+++ linux-2.6.0-test1/include/asm-i386/spinlock.h	2003-07-20 16:34:11.000000000 +0200
@@ -14,12 +14,12 @@ extern int printk(const char * fmt, ...)
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  */

-typedef struct {
+struct spinlock_s {
 	volatile unsigned int lock;
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
-} spinlock_t;
+};

 #define SPINLOCK_MAGIC	0xdead4ead

diff -Nrup linux-2.6.0-test1-ori/include/asm-um/archparam-i386.h linux-2.6.0-test1/include/asm-um/archparam-i386.h
--- linux-2.6.0-test1-ori/include/asm-um/archparam-i386.h	2003-07-14 05:37:17.000000000 +0200
+++ linux-2.6.0-test1/include/asm-um/archparam-i386.h	2003-07-20 18:09:37.000000000 +0200
@@ -10,6 +10,19 @@

 #include "user.h"

+#define R_386_NONE      0
+#define R_386_32        1
+#define R_386_PC32      2
+#define R_386_GOT32     3
+#define R_386_PLT32     4
+#define R_386_COPY      5
+#define R_386_GLOB_DAT  6
+#define R_386_JMP_SLOT  7
+#define R_386_RELATIVE  8
+#define R_386_GOTOFF    9
+#define R_386_GOTPC     10
+#define R_386_NUM       11
+
 #define ELF_PLATFORM "i586"

 #define ELF_ET_DYN_BASE (2 * TASK_SIZE / 3)
diff -Nrup linux-2.6.0-test1-ori/include/asm-um/pgtable.h linux-2.6.0-test1/include/asm-um/pgtable.h
--- linux-2.6.0-test1-ori/include/asm-um/pgtable.h	2003-07-14 05:39:37.000000000 +0200
+++ linux-2.6.0-test1/include/asm-um/pgtable.h	2003-07-20 19:38:44.000000000 +0200
@@ -49,6 +49,11 @@ extern unsigned long *empty_zero_page;
 #define pgd_ERROR(e) \
         printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))

+static inline int pgd_none(pgd_t pgd)           { return 0; }
+static inline int pgd_bad(pgd_t pgd)            { return 0; }
+static inline int pgd_present(pgd_t pgd)        { return 1; }
+#define pgd_clear(xp)                           do { } while (0)
+
 /*
  * pgd entries used up by user/kernel:
  */
@@ -86,6 +91,8 @@ extern unsigned long high_physmem;
 #define _PAGE_DIRTY	0x040
 #define _PAGE_NEWPROT   0x080

+#define _PAGE_FILE      0x040   /* set:pagecache unset:swap */
+
 #define REGION_MASK	0xf0000000
 #define REGION_SHIFT	28

@@ -181,10 +188,6 @@ extern pte_t * __bad_pagetable(void);
  * setup: the pgd is never bad, and a pmd always exists (as it's folded
  * into the pgd entry)
  */
-static inline int pgd_none(pgd_t pgd)		{ return 0; }
-static inline int pgd_bad(pgd_t pgd)		{ return 0; }
-static inline int pgd_present(pgd_t pgd)	{ return 1; }
-static inline void pgd_clear(pgd_t * pgdp)	{ }


 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))
@@ -232,6 +235,21 @@ static inline void set_pte(pte_t *pteptr
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = pmdval)
 #define set_pgd(pgdptr, pgdval) (*(pgdptr) = pgdval)

+
+
+#define PTE_FILE_MAX_BITS     29
+
+#define pte_to_pgoff(pte) \
+        ((((pte).pte_low >> 1) & 0x1f ) + (((pte).pte_low >> 8) << 5 ))
+
+#define pgoff_to_pte(off) \
+	        ((pte_t) { (((off) & 0x1f) << 1) + (((off) >> 5) << 8) + _PAGE_FILE })
+
+static inline int pte_file(pte_t pte)           { return (pte).pte_low & _PAGE_FILE; }
+
+
+
+
 /*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
diff -Nrup linux-2.6.0-test1-ori/include/asm-um/processor-generic.h linux-2.6.0-test1/include/asm-um/processor-generic.h
--- linux-2.6.0-test1-ori/include/asm-um/processor-generic.h	2003-07-14 05:31:21.000000000 +0200
+++ linux-2.6.0-test1/include/asm-um/processor-generic.h	2003-07-20 17:04:24.000000000 +0200
@@ -11,7 +11,7 @@ struct pt_regs;
 struct task_struct;

 #include "linux/config.h"
-#include "linux/signal.h"
+/* #include "linux/signal.h"*/
 #include "asm/ptrace.h"
 #include "asm/siginfo.h"
 #include "choose-mode.h"
diff -Nrup linux-2.6.0-test1-ori/include/asm-um/processor-i386.h linux-2.6.0-test1/include/asm-um/processor-i386.h
--- linux-2.6.0-test1-ori/include/asm-um/processor-i386.h	2003-07-14 05:29:59.000000000 +0200
+++ linux-2.6.0-test1/include/asm-um/processor-i386.h	2003-07-20 19:43:17.000000000 +0200
@@ -6,6 +6,9 @@
 #ifndef __UM_PROCESSOR_I386_H
 #define __UM_PROCESSOR_I386_H

+#ifdef cpu_has_xmm
+#undef cpu_has_xmm
+#endif
 extern int cpu_has_xmm;
 extern int cpu_has_cmov;

diff -Nrup linux-2.6.0-test1-ori/include/asm-um/timex.h linux-2.6.0-test1/include/asm-um/timex.h
--- linux-2.6.0-test1-ori/include/asm-um/timex.h	2003-07-14 05:35:16.000000000 +0200
+++ linux-2.6.0-test1/include/asm-um/timex.h	2003-07-20 17:07:50.000000000 +0200
@@ -1,7 +1,7 @@
 #ifndef __UM_TIMEX_H
 #define __UM_TIMEX_H

-#include "linux/time.h"
+/*#include "linux/time.h"*/

 typedef unsigned long cycles_t;

diff -Nrup linux-2.6.0-test1-ori/include/linux/seqlock.h linux-2.6.0-test1/include/linux/seqlock.h
--- linux-2.6.0-test1-ori/include/linux/seqlock.h	2003-07-14 05:33:47.000000000 +0200
+++ linux-2.6.0-test1/include/linux/seqlock.h	2003-07-19 17:39:05.000000000 +0200
@@ -31,7 +31,7 @@
 #include <linux/preempt.h>

 typedef struct {
-	unsigned sequence;
+	unsigned int sequence;
 	spinlock_t lock;
 } seqlock_t;

diff -Nrup linux-2.6.0-test1-ori/usr/initramfs_data.S linux-2.6.0-test1/usr/initramfs_data.S
--- linux-2.6.0-test1-ori/usr/initramfs_data.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1/usr/initramfs_data.S	2003-07-20 17:08:06.000000000 +0200
@@ -0,0 +1,2 @@
+	.section .init.ramfs,"a"
+.incbin "usr/initramfs_data.cpio.gz"


-- 
Philippe Biondi <biondi@ cartel-securite.fr> Cartel Sécurité
Security Consultant/R&D                      http://www.cartel-securite.fr
PGP KeyID:3D9A43E2  FingerPrint:C40A772533730E39330DC0985EE8FF5F3D9A43E2


