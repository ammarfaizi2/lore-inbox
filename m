Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261313AbSJCWQR>; Thu, 3 Oct 2002 18:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbSJCWQQ>; Thu, 3 Oct 2002 18:16:16 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:30960 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261313AbSJCWQM>; Thu, 3 Oct 2002 18:16:12 -0400
Date: Thu, 3 Oct 2002 18:21:44 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] improve wchan reporting
Message-ID: <20021003182144.G16875@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch attempts to fix up the way that wchan is reported on x86 by 
allowing functions out side of schedule.c to be skipped over when reading 
the stack.  I'm not entirely happy with this technique, as it still results 
in some inaccuracies and forces additional files to be compiled with a 
frame pointer.  Another option is to make wchan an actual file in the task, 
which has the added bonus of being somewhat more useful with aio.  In any 
case, I'd like to hear what other people think about the problem, as having 
95% of tasks show up in __down or schedule_timeout makes tracking down some 
problems a lot harder.  The patch is against bk-cur.

		-ben

:r ~/patches/v2.5/v2.5.40-wchan.diff
diff -urN linus-2.5/arch/i386/kernel/Makefile test/arch/i386/kernel/Makefile
--- linus-2.5/arch/i386/kernel/Makefile	Thu Oct  3 15:30:12 2002
+++ test/arch/i386/kernel/Makefile	Thu Oct  3 18:05:13 2002
@@ -10,6 +10,7 @@
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o \
 		bootflag.o
+CFLAGS_semaphore.o := $(PROFILING) -fno-omit-frame-pointer
 
 obj-y				+= cpu/
 obj-$(CONFIG_X86_BIOS_REBOOT)	+= reboot.o
diff -urN linus-2.5/arch/i386/kernel/process.c test/arch/i386/kernel/process.c
--- linus-2.5/arch/i386/kernel/process.c	Thu Oct  3 15:30:12 2002
+++ test/arch/i386/kernel/process.c	Thu Oct  3 18:05:13 2002
@@ -544,12 +544,15 @@
  */
 extern void scheduling_functions_start_here(void);
 extern void scheduling_functions_end_here(void);
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long) &scheduling_functions_start_here)
+#define last_sched	((unsigned long) &scheduling_functions_end_here)
+
+#define text_start	((unsigned long) &_stext)
+#define text_end	((unsigned long) &_etext)
 
 unsigned long get_wchan(struct task_struct *p)
 {
-	unsigned long ebp, esp, eip;
+	unsigned long ebp, esp, eip = 0;
 	unsigned long stack_page;
 	int count = 0;
 	if (!p || p == current || p->state == TASK_RUNNING)
@@ -560,13 +563,33 @@
 		return 0;
 	/* include/asm-i386/system.h:switch_to() pushes ebp last. */
 	ebp = *(unsigned long *) esp;
+
+	/* Our first attempt is to walk the chain of frame pointers. */
 	do {
-		if (ebp < stack_page || ebp > 8184+stack_page)
-			return 0;
+		if (ebp < stack_page || ebp > 8188+stack_page)
+			break;
 		eip = *(unsigned long *) (ebp+4);
+		if (eip < text_start || eip > text_end)
+			break;
 		if (eip < first_sched || eip >= last_sched)
 			return eip;
+
+		esp = ebp;
 		ebp = *(unsigned long *) ebp;
+		if (ebp <= esp || (ebp & 3))
+			break;
+	} while (count++ < 16);
+
+	/* Now try looking for a return address the hard way. */
+	do {
+		if (esp > 8188+stack_page)
+			break;
+		eip = *(unsigned long *)esp;
+
+		if (eip >= text_start && eip < text_end &&
+		    (eip < first_sched || eip >= last_sched))
+			return eip;
+		esp += 4;
 	} while (count++ < 16);
 	return 0;
 }
diff -urN linus-2.5/arch/i386/kernel/semaphore.c test/arch/i386/kernel/semaphore.c
--- linus-2.5/arch/i386/kernel/semaphore.c	Thu Oct  3 15:30:12 2002
+++ test/arch/i386/kernel/semaphore.c	Thu Oct  3 18:05:13 2002
@@ -53,6 +53,7 @@
 	wake_up(&sem->wait);
 }
 
+void __down(struct semaphore * sem) ATTRIB_NOWCHAN;
 void __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
@@ -90,6 +91,7 @@
 	tsk->state = TASK_RUNNING;
 }
 
+int __down_interruptible(struct semaphore * sem) ATTRIB_NOWCHAN;
 int __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
@@ -187,10 +189,12 @@
  * value..
  */
 asm(
-".text\n"
+".section .text.scheduler, \"ax\"\n"
 ".align 4\n"
 ".globl __down_failed\n"
 "__down_failed:\n\t"
+	"pushl %ebp\n\t"
+	"movl %esp,%ebp\n\t"
 	"pushl %eax\n\t"
 	"pushl %edx\n\t"
 	"pushl %ecx\n\t"
@@ -198,20 +202,26 @@
 	"popl %ecx\n\t"
 	"popl %edx\n\t"
 	"popl %eax\n\t"
-	"ret"
+	"popl %ebp\n\t"
+	"ret\n"
+".previous"
 );
 
 asm(
-".text\n"
+".section .text.scheduler, \"ax\"\n"
 ".align 4\n"
 ".globl __down_failed_interruptible\n"
 "__down_failed_interruptible:\n\t"
+	"pushl %ebp\n\t"
+	"movl %esp,%ebp\n\t"
 	"pushl %edx\n\t"
 	"pushl %ecx\n\t"
 	"call __down_interruptible\n\t"
 	"popl %ecx\n\t"
 	"popl %edx\n\t"
-	"ret"
+	"popl %ebp\n\t"
+	"ret\n"
+".previous"
 );
 
 asm(
diff -urN linus-2.5/arch/i386/vmlinux.lds.S test/arch/i386/vmlinux.lds.S
--- linus-2.5/arch/i386/vmlinux.lds.S	Thu Oct  3 15:30:12 2002
+++ test/arch/i386/vmlinux.lds.S	Thu Oct  3 18:05:13 2002
@@ -11,8 +11,17 @@
   _text = .;			/* Text and read-only data */
   .text : {
 	*(.text)
+
+	scheduling_functions_start_here = .;
+	. += 0x10;
+	*(.text.scheduler)
+
+	scheduling_functions_end_here = .;
+	. += 0x10;
+
 	*(.fixup)
 	*(.gnu.warning)
+
 	} = 0x9090
 
   _etext = .;			/* End of text section */
diff -urN linus-2.5/include/linux/linkage.h test/include/linux/linkage.h
--- linus-2.5/include/linux/linkage.h	Thu Oct  3 15:30:24 2002
+++ test/include/linux/linkage.h	Thu Oct  3 18:05:13 2002
@@ -35,6 +35,9 @@
 #define ATTRIB_NORET  __attribute__((noreturn))
 #define NORET_AND     noreturn,
 
+/* For use by functions that we do not want showing up in the wchan listing */
+#define ATTRIB_NOWCHAN        __attribute__((section(".text.scheduler")))
+
 #ifndef FASTCALL
 #define FASTCALL(x)	x
 #endif
diff -urN linus-2.5/kernel/sched.c test/kernel/sched.c
--- linus-2.5/kernel/sched.c	Thu Oct  3 15:30:25 2002
+++ test/kernel/sched.c	Thu Oct  3 18:05:13 2002
@@ -931,11 +931,10 @@
 	spin_unlock(&rq->lock);
 }
 
-void scheduling_functions_start_here(void) { }
-
 /*
  * schedule() is the main scheduler function.
  */
+asmlinkage void schedule(void) ATTRIB_NOWCHAN;
 asmlinkage void schedule(void)
 {
 	task_t *prev, *next;
@@ -1041,6 +1040,7 @@
  * off of preempt_enable.  Kernel preemptions off return from interrupt
  * occur there and call schedule directly.
  */
+asmlinkage void preempt_schedule(void) ATTRIB_NOWCHAN;
 asmlinkage void preempt_schedule(void)
 {
 	struct thread_info *ti = current_thread_info();
@@ -1161,6 +1161,7 @@
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
+void wait_for_completion(struct completion *x) ATTRIB_NOWCHAN;
 void wait_for_completion(struct completion *x)
 {
 	might_sleep();
@@ -1197,6 +1198,7 @@
 	__remove_wait_queue(q, &wait);				\
 	spin_unlock_irqrestore(&q->lock, flags);
 
+void interruptible_sleep_on(wait_queue_head_t *q) ATTRIB_NOWCHAN;
 void interruptible_sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
@@ -1208,6 +1210,7 @@
 	SLEEP_ON_TAIL
 }
 
+long interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout) ATTRIB_NOWCHAN;
 long interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
@@ -1221,6 +1224,7 @@
 	return timeout;
 }
 
+void sleep_on(wait_queue_head_t *q) ATTRIB_NOWCHAN;
 void sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
@@ -1232,6 +1236,7 @@
 	SLEEP_ON_TAIL
 }
 
+long sleep_on_timeout(wait_queue_head_t *q, long timeout) ATTRIB_NOWCHAN;
 long sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
@@ -1245,8 +1250,6 @@
 	return timeout;
 }
 
-void scheduling_functions_end_here(void) { }
-
 void set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
diff -urN linus-2.5/kernel/timer.c test/kernel/timer.c
--- linus-2.5/kernel/timer.c	Thu Oct  3 15:30:25 2002
+++ test/kernel/timer.c	Thu Oct  3 18:05:13 2002
@@ -853,6 +853,7 @@
  *
  * In all cases the return value is guaranteed to be non-negative.
  */
+signed long schedule_timeout(signed long timeout) ATTRIB_NOWCHAN;
 signed long schedule_timeout(signed long timeout)
 {
 	timer_t timer;
