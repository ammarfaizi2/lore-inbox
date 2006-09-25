Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWIYSg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWIYSg6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWIYSge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:36:34 -0400
Received: from [198.99.130.12] ([198.99.130.12]:52372 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751332AbWIYSgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:36:04 -0400
Message-Id: <200609251834.k8PIYlnt005057@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 8/8] UML - Thread creation tidying
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Sep 2006 14:34:47 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fork on UML has always somewhat subtle.  The underlying cause has
been the need to initialize a stack for the new process.  The only
portable way to initialize a new stack is to set it as the alternate
signal stack and take a signal.  The signal handler does whatever
initialization is needed and jumps back to the original stack, where
the fork processing is finished.
The basic context switching mechanism is a jmp_buf for each
process.  You switch to a new process by longjmping to its jmp_buf.

Now that UML has its own implementation of setjmp and longjmp, and I
can poke around inside a jmp_buf without fear that libc will change
the structure, a much simpler mechanism is possible.  The jmpbuf can
simply be initialized by hand.

This eliminates -
	the need to set up and remove the alternate signal stack
	sending and handling a signal
	the signal blocking needed around the stack switching, since
there is no stack switching
	setting up the jmp_buf needed to jump back to the original
stack after the new one is set up

In addition, since jmp_buf is now defined by UML, and not by libc,
it can be embedded in the thread struct.  This makes it unnecessary
to have it exist on the stack, where it used to be.  It also
simplifies interfaces, since the switch jmp_buf used to be a void *
inside the thread struct, and functions which took it as an argument
needed to define a jmp_buf variable and assign it from the void *.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/skas/process.c	2006-09-22 09:16:03.000000000 -0400
+++ linux-2.6.18-mm/arch/um/os-Linux/skas/process.c	2006-09-22 09:51:26.000000000 -0400
@@ -444,56 +444,22 @@ void map_stub_pages(int fd, unsigned lon
 	}
 }
 
-void new_thread(void *stack, void **switch_buf_ptr, void **fork_buf_ptr,
-		void (*handler)(int))
+void new_thread(void *stack, jmp_buf *buf, void (*handler)(void))
 {
-	unsigned long flags;
-	jmp_buf switch_buf, fork_buf;
-
-	*switch_buf_ptr = &switch_buf;
-	*fork_buf_ptr = &fork_buf;
-
-	/* Somewhat subtle - siglongjmp restores the signal mask before doing
-	 * the longjmp.  This means that when jumping from one stack to another
-	 * when the target stack has interrupts enabled, an interrupt may occur
-	 * on the source stack.  This is bad when starting up a process because
-	 * it's not supposed to get timer ticks until it has been scheduled.
-	 * So, we disable interrupts around the sigsetjmp to ensure that
-	 * they can't happen until we get back here where they are safe.
-	 */
-	flags = get_signals();
-	block_signals();
-	if(UML_SETJMP(&fork_buf) == 0)
-		new_thread_proc(stack, handler);
-
-	remove_sigstack();
-
-	set_signals(flags);
+	(*buf)[0].JB_IP = (unsigned long) handler;
+	(*buf)[0].JB_SP = (unsigned long) stack +
+		(PAGE_SIZE << UML_CONFIG_KERNEL_STACK_ORDER) - sizeof(void *);
 }
 
 #define INIT_JMP_NEW_THREAD 0
-#define INIT_JMP_REMOVE_SIGSTACK 1
-#define INIT_JMP_CALLBACK 2
-#define INIT_JMP_HALT 3
-#define INIT_JMP_REBOOT 4
+#define INIT_JMP_CALLBACK 1
+#define INIT_JMP_HALT 2
+#define INIT_JMP_REBOOT 3
 
-void thread_wait(void *sw, void *fb)
+void switch_threads(jmp_buf *me, jmp_buf *you)
 {
-	jmp_buf buf, **switch_buf = sw, *fork_buf;
-
-	*switch_buf = &buf;
-	fork_buf = fb;
-	if(UML_SETJMP(&buf) == 0)
-		UML_LONGJMP(fork_buf, INIT_JMP_REMOVE_SIGSTACK);
-}
-
-void switch_threads(void *me, void *next)
-{
-	jmp_buf my_buf, **me_ptr = me, *next_buf = next;
-
-	*me_ptr = &my_buf;
-	if(UML_SETJMP(&my_buf) == 0)
-		UML_LONGJMP(next_buf, 1);
+	if(UML_SETJMP(me) == 0)
+		UML_LONGJMP(you, 1);
 }
 
 static jmp_buf initial_jmpbuf;
@@ -503,23 +469,21 @@ static void (*cb_proc)(void *arg);
 static void *cb_arg;
 static jmp_buf *cb_back;
 
-int start_idle_thread(void *stack, void *switch_buf_ptr, void **fork_buf_ptr)
+int start_idle_thread(void *stack, jmp_buf *switch_buf)
 {
-	jmp_buf **switch_buf = switch_buf_ptr;
 	int n;
 
 	set_handler(SIGWINCH, (__sighandler_t) sig_handler,
 		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGALRM,
 		    SIGVTALRM, -1);
 
-	*fork_buf_ptr = &initial_jmpbuf;
 	n = UML_SETJMP(&initial_jmpbuf);
 	switch(n){
 	case INIT_JMP_NEW_THREAD:
-		new_thread_proc((void *) stack, new_thread_handler);
-		break;
-	case INIT_JMP_REMOVE_SIGSTACK:
-		remove_sigstack();
+		(*switch_buf)[0].JB_IP = (unsigned long) new_thread_handler;
+		(*switch_buf)[0].JB_SP = (unsigned long) stack +
+			(PAGE_SIZE << UML_CONFIG_KERNEL_STACK_ORDER) -
+			sizeof(void *);
 		break;
 	case INIT_JMP_CALLBACK:
 		(*cb_proc)(cb_arg);
@@ -534,7 +498,7 @@ int start_idle_thread(void *stack, void 
 	default:
 		panic("Bad sigsetjmp return in start_idle_thread - %d\n", n);
 	}
-	UML_LONGJMP(*switch_buf, 1);
+	UML_LONGJMP(switch_buf, 1);
 }
 
 void initial_thread_cb_skas(void (*proc)(void *), void *arg)
Index: linux-2.6.18-mm/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/skas/process_kern.c	2006-09-22 09:16:00.000000000 -0400
+++ linux-2.6.18-mm/arch/um/kernel/skas/process_kern.c	2006-09-22 09:51:26.000000000 -0400
@@ -33,7 +33,7 @@ void switch_to_skas(void *prev, void *ne
 		switch_timers(0);
 
 	switch_threads(&from->thread.mode.skas.switch_buf,
-		       to->thread.mode.skas.switch_buf);
+		       &to->thread.mode.skas.switch_buf);
 
 	arch_switch_to_skas(current->thread.prev_sched, current);
 
@@ -43,21 +43,21 @@ void switch_to_skas(void *prev, void *ne
 
 extern void schedule_tail(struct task_struct *prev);
 
-void new_thread_handler(int sig)
+/* This is called magically, by its address being stuffed in a jmp_buf
+ * and being longjmp-d to.
+ */
+void new_thread_handler(void)
 {
 	int (*fn)(void *), n;
 	void *arg;
 
-	fn = current->thread.request.u.thread.proc;
-	arg = current->thread.request.u.thread.arg;
-	os_usr1_signal(1);
-	thread_wait(&current->thread.mode.skas.switch_buf,
-		    current->thread.mode.skas.fork_buf);
-
 	if(current->thread.prev_sched != NULL)
 		schedule_tail(current->thread.prev_sched);
 	current->thread.prev_sched = NULL;
 
+	fn = current->thread.request.u.thread.proc;
+	arg = current->thread.request.u.thread.arg;
+
 	/* The return value is 1 if the kernel thread execs a process,
 	 * 0 if it just exits
 	 */
@@ -70,22 +70,13 @@ void new_thread_handler(int sig)
 	else do_exit(0);
 }
 
-void new_thread_proc(void *stack, void (*handler)(int sig))
-{
-	init_new_thread_stack(stack, handler);
-	os_usr1_process(os_getpid());
-}
-
 void release_thread_skas(struct task_struct *task)
 {
 }
 
-void fork_handler(int sig)
+/* Called magically, see new_thread_handler above */
+void fork_handler(void)
 {
-	os_usr1_signal(1);
-	thread_wait(&current->thread.mode.skas.switch_buf,
-		    current->thread.mode.skas.fork_buf);
-  	
 	force_flush_all();
 	if(current->thread.prev_sched == NULL)
 		panic("blech");
@@ -109,7 +100,7 @@ int copy_thread_skas(int nr, unsigned lo
 		     unsigned long stack_top, struct task_struct * p,
 		     struct pt_regs *regs)
 {
-  	void (*handler)(int);
+  	void (*handler)(void);
 
 	if(current->thread.forking){
 	  	memcpy(&p->thread.regs.regs.skas, &regs->regs.skas,
@@ -128,7 +119,7 @@ int copy_thread_skas(int nr, unsigned lo
 	}
 
 	new_thread(task_stack_page(p), &p->thread.mode.skas.switch_buf,
-		   &p->thread.mode.skas.fork_buf, handler);
+		   handler);
 	return(0);
 }
 
@@ -182,8 +173,7 @@ int start_uml_skas(void)
 	init_task.thread.request.u.thread.proc = start_kernel_proc;
 	init_task.thread.request.u.thread.arg = NULL;
 	return(start_idle_thread(task_stack_page(&init_task),
-				 &init_task.thread.mode.skas.switch_buf,
-				 &init_task.thread.mode.skas.fork_buf));
+				 &init_task.thread.mode.skas.switch_buf));
 }
 
 int external_pid_skas(struct task_struct *task)
Index: linux-2.6.18-mm/arch/um/include/os.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/os.h	2006-09-22 09:51:13.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/os.h	2006-09-22 09:51:26.000000000 -0400
@@ -14,6 +14,7 @@
 #include "skas/mm_id.h"
 #include "irq_user.h"
 #include "sysdep/tls.h"
+#include "sysdep/archsetjmp.h"
 
 #define OS_TYPE_FILE 1
 #define OS_TYPE_DIR 2
@@ -308,12 +309,9 @@ extern int copy_context_skas0(unsigned l
 extern void userspace(union uml_pt_regs *regs);
 extern void map_stub_pages(int fd, unsigned long code,
 			   unsigned long data, unsigned long stack);
-extern void new_thread(void *stack, void **switch_buf_ptr,
-			 void **fork_buf_ptr, void (*handler)(int));
-extern void thread_wait(void *sw, void *fb);
-extern void switch_threads(void *me, void *next);
-extern int start_idle_thread(void *stack, void *switch_buf_ptr,
-			     void **fork_buf_ptr);
+extern void new_thread(void *stack, jmp_buf *buf, void (*handler)(void));
+extern void switch_threads(jmp_buf *me, jmp_buf *you);
+extern int start_idle_thread(void *stack, jmp_buf *switch_buf);
 extern void initial_thread_cb_skas(void (*proc)(void *),
 				 void *arg);
 extern void halt_skas(void);
Index: linux-2.6.18-mm/include/asm-um/processor-generic.h
===================================================================
--- linux-2.6.18-mm.orig/include/asm-um/processor-generic.h	2006-09-22 09:16:00.000000000 -0400
+++ linux-2.6.18-mm/include/asm-um/processor-generic.h	2006-09-22 09:51:26.000000000 -0400
@@ -13,6 +13,7 @@ struct task_struct;
 #include "asm/ptrace.h"
 #include "choose-mode.h"
 #include "registers.h"
+#include "sysdep/archsetjmp.h"
 
 struct mm_struct;
 
@@ -43,8 +44,7 @@ struct thread_struct {
 #endif
 #ifdef CONFIG_MODE_SKAS
 		struct {
-			void *switch_buf;
-			void *fork_buf;
+			jmp_buf switch_buf;
 			int mm_count;
 		} skas;
 #endif
@@ -138,7 +138,7 @@ extern struct cpuinfo_um cpu_data[];
 
 #ifdef CONFIG_MODE_SKAS
 #define KSTK_REG(tsk, reg) \
-	get_thread_reg(reg, tsk->thread.mode.skas.switch_buf)
+	get_thread_reg(reg, &tsk->thread.mode.skas.switch_buf)
 #else
 #define KSTK_REG(tsk, reg) (0xbadbabe)
 #endif
Index: linux-2.6.18-mm/arch/um/include/skas/skas.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/skas/skas.h	2006-09-22 09:16:00.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/skas/skas.h	2006-09-22 09:51:26.000000000 -0400
@@ -14,8 +14,7 @@ extern int proc_mm, ptrace_faultinfo, pt
 extern int skas_needs_stub;
 
 extern int user_thread(unsigned long stack, int flags);
-extern void new_thread_proc(void *stack, void (*handler)(int sig));
-extern void new_thread_handler(int sig);
+extern void new_thread_handler(void);
 extern void handle_syscall(union uml_pt_regs *regs);
 extern int new_mm(unsigned long stack);
 extern void get_skas_faultinfo(int pid, struct faultinfo * fi);
Index: linux-2.6.18-mm/arch/um/include/sysdep-i386/archsetjmp.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/sysdep-i386/archsetjmp.h	2006-09-12 10:43:38.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/sysdep-i386/archsetjmp.h	2006-09-22 09:51:26.000000000 -0400
@@ -16,4 +16,7 @@ struct __jmp_buf {
 
 typedef struct __jmp_buf jmp_buf[1];
 
+#define JB_IP __eip
+#define JB_SP __esp
+
 #endif				/* _SETJMP_H */
Index: linux-2.6.18-mm/arch/um/include/sysdep-x86_64/archsetjmp.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/sysdep-x86_64/archsetjmp.h	2006-09-12 10:43:38.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/sysdep-x86_64/archsetjmp.h	2006-09-22 09:51:26.000000000 -0400
@@ -18,4 +18,7 @@ struct __jmp_buf {
 
 typedef struct __jmp_buf jmp_buf[1];
 
+#define JB_IP __rip
+#define JB_SP __rsp
+
 #endif				/* _SETJMP_H */

