Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWAOUsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWAOUsJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWAOUsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:48:00 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:30627 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750753AbWAOUrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:47:52 -0500
Message-Id: <200601152139.k0FLdp1G027747@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 9/11] UML - Implement soft interrupts
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Jan 2006 16:39:51 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements soft interrupts.  Interrupt enabling and
disabling no longer map to sigprocmask.  Rather, a flag is set
indicating whether interrupts may be handled.  If a signal comes in
and interrupts are marked as OK, then it is handled normally.  If
interrupts are marked as off, then the signal handler simply returns
after noting that a signal needs handling.  When interrupts are enabled
later on, this pending signals flag is checked, and the IRQ handlers
are called at that point.

The point of this is to reduce the cost of local_irq_save et al,
since they are very much more common than the signals that they are
enabling and disabling.  Soft interrupts produce a speed-up of ~25%
on a kernel build.

Subtleties - 
    UML uses sigsetjmp/siglongjmp to switch contexts.
sigsetjmp has been wrapped in a save_flags-like macro which remembers
the interrupt state at setjmp time, and restores it when it is
longjmp-ed back to.
    The enable_signals function has to loop because the IRQ handler
disables interrupts before returning.  enable_signals has to return
with signals enabled, and signals may come in between the disabling
and the return to enable_signals.  So, it loops for as long as there
are pending signals, ensuring that signals are enabled when it
finally returns, and that there are no pending signals that need to
be dealt with.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/include/longjmp.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/longjmp.h	2006-01-09 11:44:53.000000000 -0500
@@ -0,0 +1,19 @@
+#ifndef __UML_LONGJMP_H
+#define __UML_LONGJMP_H
+
+#include <setjmp.h>
+#include "os.h"
+
+#define UML_SIGLONGJMP(buf, val) do { \
+	siglongjmp(*buf, val);		\
+} while(0)
+
+#define UML_SIGSETJMP(buf, enable) ({ \
+	int n; \
+	enable = get_signals(); \
+	n = sigsetjmp(*buf, 1); \
+	if(n != 0) \
+		set_signals(enable); \
+	n; })
+
+#endif
Index: linux-2.6.15-mm/arch/um/os-Linux/main.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/main.c	2006-01-09 11:26:24.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/main.c	2006-01-09 11:43:13.000000000 -0500
@@ -81,20 +81,8 @@ extern void scan_elf_aux( char **envp);
 int main(int argc, char **argv, char **envp)
 {
 	char **new_argv;
-	sigset_t mask;
 	int ret, i, err;
 
-	/* Enable all signals except SIGIO - in some environments, we can
-	 * enter with some signals blocked
-	 */
-
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGIO);
-	if(sigprocmask(SIG_SETMASK, &mask, NULL) < 0){
-		perror("sigprocmask");
-		exit(1);
-	}
-
 #ifdef UML_CONFIG_CMDLINE_ON_HOST
 	/* Allocate memory for thread command lines */
 	if(argc < 2 || strlen(argv[1]) < THREAD_NAME_LEN - 1){
Index: linux-2.6.15-mm/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/process.c	2006-01-09 10:27:19.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/process.c	2006-01-09 11:45:52.000000000 -0500
@@ -18,6 +18,7 @@
 #include "process.h"
 #include "irq_user.h"
 #include "kern_util.h"
+#include "longjmp.h"
 
 #define ARBITRARY_ADDR -1
 #define FAILURE_PID    -1
@@ -205,24 +206,13 @@ void init_new_thread_signals(int altstac
 
 int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr)
 {
-       sigjmp_buf buf;
-       int n;
+	sigjmp_buf buf;
+	int n, enable;
 
-       *jmp_ptr = &buf;
-       n = sigsetjmp(buf, 1);
-       if(n != 0)
-               return(n);
-       (*fn)(arg);
-       return(0);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+	*jmp_ptr = &buf;
+	n = UML_SIGSETJMP(&buf, enable);
+	if(n != 0)
+		return(n);
+	(*fn)(arg);
+	return(0);
+}
Index: linux-2.6.15-mm/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/signal.c	2006-01-09 11:35:10.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/signal.c	2006-01-09 11:47:54.000000000 -0500
@@ -20,23 +20,58 @@
 #include "mode.h"
 #include "os.h"
 
+/* These are the asynchronous signals.  SIGVTALRM and SIGARLM are handled
+ * together under SIGVTALRM_BIT.  SIGPROF is excluded because we want to
+ * be able to profile all of UML, not just the non-critical sections.  If
+ * profiling is not thread-safe, then that is not my problem.  We can disable
+ * profiling when SMP is enabled in that case.
+ */
+#define SIGIO_BIT 0
+#define SIGIO_MASK (1 << SIGIO_BIT)
+
+#define SIGVTALRM_BIT 1
+#define SIGVTALRM_MASK (1 << SIGVTALRM_BIT)
+
+#define SIGALRM_BIT 2
+#define SIGALRM_MASK (1 << SIGALRM_BIT)
+
+static int signals_enabled = 1;
+static int pending = 0;
+
 void sig_handler(ARCH_SIGHDLR_PARAM)
 {
 	struct sigcontext *sc;
+	int enabled;
+
+	/* Must be the first thing that this handler does - x86_64 stores
+	 * the sigcontext in %rdx, and we need to save it before it has a
+	 * chance to get trashed.
+	 */
 
 	ARCH_GET_SIGCONTEXT(sc, sig);
+
+	enabled = signals_enabled;
+	if(!enabled && (sig == SIGIO)){
+		pending |= SIGIO_MASK;
+		return;
+	}
+
+	block_signals();
+
 	CHOOSE_MODE_PROC(sig_handler_common_tt, sig_handler_common_skas,
 			 sig, sc);
+
+	set_signals(enabled);
 }
 
 extern int timer_irq_inited;
 
-void alarm_handler(ARCH_SIGHDLR_PARAM)
+static void real_alarm_handler(int sig, struct sigcontext *sc)
 {
-	struct sigcontext *sc;
-
-	ARCH_GET_SIGCONTEXT(sc, sig);
-	if(!timer_irq_inited) return;
+	if(!timer_irq_inited){
+		signals_enabled = 1;
+		return;
+	}
 
 	if(sig == SIGALRM)
 		switch_timers(0);
@@ -46,6 +81,29 @@ void alarm_handler(ARCH_SIGHDLR_PARAM)
 
 	if(sig == SIGALRM)
 		switch_timers(1);
+
+}
+
+void alarm_handler(ARCH_SIGHDLR_PARAM)
+{
+	struct sigcontext *sc;
+	int enabled;
+
+	ARCH_GET_SIGCONTEXT(sc, sig);
+
+	enabled = signals_enabled;
+	if(!signals_enabled){
+		if(sig == SIGVTALRM)
+			pending |= SIGVTALRM_MASK;
+		else pending |= SIGALRM_MASK;
+
+		return;
+	}
+
+	block_signals();
+
+	real_alarm_handler(sig, sc);
+	set_signals(enabled);
 }
 
 extern void do_boot_timer_handler(struct sigcontext * sc);
@@ -53,10 +111,22 @@ extern void do_boot_timer_handler(struct
 void boot_timer_handler(ARCH_SIGHDLR_PARAM)
 {
 	struct sigcontext *sc;
+	int enabled;
 
 	ARCH_GET_SIGCONTEXT(sc, sig);
 
+	enabled = signals_enabled;
+	if(!enabled){
+		if(sig == SIGVTALRM)
+			pending |= SIGVTALRM_MASK;
+		else pending |= SIGALRM_MASK;
+		return;
+	}
+
+	block_signals();
+
 	do_boot_timer_handler(sc);
+	set_signals(enabled);
 }
 
 void set_sigstack(void *sig_stack, int size)
@@ -83,6 +153,7 @@ void set_handler(int sig, void (*handler
 {
 	struct sigaction action;
 	va_list ap;
+	sigset_t sig_mask;
 	int mask;
 
 	va_start(ap, flags);
@@ -95,7 +166,12 @@ void set_handler(int sig, void (*handler
 	action.sa_flags = flags;
 	action.sa_restorer = NULL;
 	if(sigaction(sig, &action, NULL) < 0)
-		panic("sigaction failed");
+		panic("sigaction failed - errno = %d\n", errno);
+
+	sigemptyset(&sig_mask);
+	sigaddset(&sig_mask, sig);
+	if(sigprocmask(SIG_UNBLOCK, &sig_mask, NULL) < 0)
+		panic("sigprocmask failed - errno = %d\n", errno);
 }
 
 int change_sig(int signal, int on)
@@ -108,91 +184,74 @@ int change_sig(int signal, int on)
 	return(!sigismember(&old, signal));
 }
 
-/* Both here and in set/get_signal we don't touch SIGPROF, because we must not
- * disable profiling; it's safe because the profiling code does not interact
- * with the kernel code at all.*/
-
-static void change_signals(int type)
-{
-	sigset_t mask;
-
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGVTALRM);
-	sigaddset(&mask, SIGALRM);
-	sigaddset(&mask, SIGIO);
-	if(sigprocmask(type, &mask, NULL) < 0)
-		panic("Failed to change signal mask - errno = %d", errno);
-}
-
 void block_signals(void)
 {
-	change_signals(SIG_BLOCK);
+	signals_enabled = 0;
 }
 
 void unblock_signals(void)
 {
-	change_signals(SIG_UNBLOCK);
-}
+	int save_pending;
 
-/* These are the asynchronous signals.  SIGVTALRM and SIGARLM are handled
- * together under SIGVTALRM_BIT.  SIGPROF is excluded because we want to
- * be able to profile all of UML, not just the non-critical sections.  If
- * profiling is not thread-safe, then that is not my problem.  We can disable
- * profiling when SMP is enabled in that case.
- */
-#define SIGIO_BIT 0
-#define SIGVTALRM_BIT 1
+	if(signals_enabled == 1)
+		return;
 
-static int enable_mask(sigset_t *mask)
-{
-	int sigs;
+	/* We loop because the IRQ handler returns with interrupts off.  So,
+	 * interrupts may have arrived and we need to re-enable them and
+	 * recheck pending.
+	 */
+	while(1){
+		/* Save and reset save_pending after enabling signals.  This
+		 * way, pending won't be changed while we're reading it.
+		 */
+		signals_enabled = 1;
+
+		save_pending = pending;
+		if(save_pending == 0)
+			return;
+
+		pending = 0;
+
+		/* We have pending interrupts, so disable signals, as the
+		 * handlers expect them off when they are called.  They will
+		 * be enabled again above.
+		 */
+
+		signals_enabled = 0;
+
+		/* Deal with SIGIO first because the alarm handler might
+		 * schedule, leaving the pending SIGIO stranded until we come
+		 * back here.
+		 */
+		if(save_pending & SIGIO_MASK)
+			CHOOSE_MODE_PROC(sig_handler_common_tt,
+					 sig_handler_common_skas, SIGIO, NULL);
 
-	sigs = sigismember(mask, SIGIO) ? 0 : 1 << SIGIO_BIT;
-	sigs |= sigismember(mask, SIGVTALRM) ? 0 : 1 << SIGVTALRM_BIT;
-	sigs |= sigismember(mask, SIGALRM) ? 0 : 1 << SIGVTALRM_BIT;
-	return(sigs);
+		if(save_pending & SIGALRM_MASK)
+			real_alarm_handler(SIGALRM, NULL);
+
+		if(save_pending & SIGVTALRM_MASK)
+			real_alarm_handler(SIGVTALRM, NULL);
+	}
 }
 
 int get_signals(void)
 {
-	sigset_t mask;
-
-	if(sigprocmask(SIG_SETMASK, NULL, &mask) < 0)
-		panic("Failed to get signal mask");
-	return(enable_mask(&mask));
+	return signals_enabled;
 }
 
 int set_signals(int enable)
 {
-	sigset_t mask;
 	int ret;
+	if(signals_enabled == enable)
+		return enable;
 
-	sigemptyset(&mask);
-	if(enable & (1 << SIGIO_BIT))
-		sigaddset(&mask, SIGIO);
-	if(enable & (1 << SIGVTALRM_BIT)){
-		sigaddset(&mask, SIGVTALRM);
-		sigaddset(&mask, SIGALRM);
-	}
-
-	/* This is safe - sigprocmask is guaranteed to copy locally the
-	 * value of new_set, do his work and then, at the end, write to
-	 * old_set.
-	 */
-	if(sigprocmask(SIG_UNBLOCK, &mask, &mask) < 0)
-		panic("Failed to enable signals");
-	ret = enable_mask(&mask);
-	sigemptyset(&mask);
-	if((enable & (1 << SIGIO_BIT)) == 0)
-		sigaddset(&mask, SIGIO);
-	if((enable & (1 << SIGVTALRM_BIT)) == 0){
-		sigaddset(&mask, SIGVTALRM);
-		sigaddset(&mask, SIGALRM);
-	}
-	if(sigprocmask(SIG_BLOCK, &mask, NULL) < 0)
-		panic("Failed to block signals");
+	ret = signals_enabled;
+	if(enable)
+		unblock_signals();
+	else block_signals();
 
-	return(ret);
+	return ret;
 }
 
 void os_usr1_signal(int on)
Index: linux-2.6.15-mm/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/skas/process.c	2006-01-09 11:40:33.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/skas/process.c	2006-01-09 11:47:54.000000000 -0500
@@ -34,6 +34,7 @@
 #include "mem.h"
 #include "uml-config.h"
 #include "process.h"
+#include "longjmp.h"
 
 int is_skas_winch(int pid, int fd, void *data)
 {
@@ -433,6 +434,7 @@ void new_thread(void *stack, void **swit
 {
 	unsigned long flags;
 	sigjmp_buf switch_buf, fork_buf;
+	int enable;
 
 	*switch_buf_ptr = &switch_buf;
 	*fork_buf_ptr = &fork_buf;
@@ -447,7 +449,7 @@ void new_thread(void *stack, void **swit
 	 */
 	flags = get_signals();
 	block_signals();
-	if(sigsetjmp(fork_buf, 1) == 0)
+	if(UML_SIGSETJMP(&fork_buf, enable) == 0)
 		new_thread_proc(stack, handler);
 
 	remove_sigstack();
@@ -458,20 +460,22 @@ void new_thread(void *stack, void **swit
 void thread_wait(void *sw, void *fb)
 {
 	sigjmp_buf buf, **switch_buf = sw, *fork_buf;
+	int enable;
 
 	*switch_buf = &buf;
 	fork_buf = fb;
-	if(sigsetjmp(buf, 1) == 0)
+	if(UML_SIGSETJMP(&buf, enable) == 0)
 		siglongjmp(*fork_buf, INIT_JMP_REMOVE_SIGSTACK);
 }
 
 void switch_threads(void *me, void *next)
 {
 	sigjmp_buf my_buf, **me_ptr = me, *next_buf = next;
+	int enable;
 
 	*me_ptr = &my_buf;
-	if(sigsetjmp(my_buf, 1) == 0)
-		siglongjmp(*next_buf, 1);
+	if(UML_SIGSETJMP(&my_buf, enable) == 0)
+		UML_SIGLONGJMP(next_buf, 1);
 }
 
 static sigjmp_buf initial_jmpbuf;
@@ -484,14 +488,14 @@ static sigjmp_buf *cb_back;
 int start_idle_thread(void *stack, void *switch_buf_ptr, void **fork_buf_ptr)
 {
 	sigjmp_buf **switch_buf = switch_buf_ptr;
-	int n;
+	int n, enable;
 
 	set_handler(SIGWINCH, (__sighandler_t) sig_handler,
 		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGALRM,
 		    SIGVTALRM, -1);
 
 	*fork_buf_ptr = &initial_jmpbuf;
-	n = sigsetjmp(initial_jmpbuf, 1);
+	n = UML_SIGSETJMP(&initial_jmpbuf, enable);
 	switch(n){
 	case INIT_JMP_NEW_THREAD:
 		new_thread_proc((void *) stack, new_thread_handler);
@@ -501,7 +505,7 @@ int start_idle_thread(void *stack, void 
 		break;
 	case INIT_JMP_CALLBACK:
 		(*cb_proc)(cb_arg);
-		siglongjmp(*cb_back, 1);
+		UML_SIGLONGJMP(cb_back, 1);
 		break;
 	case INIT_JMP_HALT:
 		kmalloc_ok = 0;
@@ -512,20 +516,21 @@ int start_idle_thread(void *stack, void 
 	default:
 		panic("Bad sigsetjmp return in start_idle_thread - %d\n", n);
 	}
-	siglongjmp(**switch_buf, 1);
+	UML_SIGLONGJMP(*switch_buf, 1);
 }
 
 void initial_thread_cb_skas(void (*proc)(void *), void *arg)
 {
 	sigjmp_buf here;
+	int enable;
 
 	cb_proc = proc;
 	cb_arg = arg;
 	cb_back = &here;
 
 	block_signals();
-	if(sigsetjmp(here, 1) == 0)
-		siglongjmp(initial_jmpbuf, INIT_JMP_CALLBACK);
+	if(UML_SIGSETJMP(&here, enable) == 0)
+		UML_SIGLONGJMP(&initial_jmpbuf, INIT_JMP_CALLBACK);
 	unblock_signals();
 
 	cb_proc = NULL;
@@ -536,13 +541,13 @@ void initial_thread_cb_skas(void (*proc)
 void halt_skas(void)
 {
 	block_signals();
-	siglongjmp(initial_jmpbuf, INIT_JMP_HALT);
+	UML_SIGLONGJMP(&initial_jmpbuf, INIT_JMP_HALT);
 }
 
 void reboot_skas(void)
 {
 	block_signals();
-	siglongjmp(initial_jmpbuf, INIT_JMP_REBOOT);
+	UML_SIGLONGJMP(&initial_jmpbuf, INIT_JMP_REBOOT);
 }
 
 void switch_mm_skas(struct mm_id *mm_idp)
Index: linux-2.6.15-mm/arch/um/os-Linux/trap.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/trap.c	2006-01-09 10:27:19.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/trap.c	2006-01-09 11:43:13.000000000 -0500
@@ -10,6 +10,7 @@
 #include "user_util.h"
 #include "os.h"
 #include "mode.h"
+#include "longjmp.h"
 
 void usr2_handler(int sig, union uml_pt_regs *regs)
 {
@@ -36,5 +37,5 @@ void do_longjmp(void *b, int val)
 {
 	sigjmp_buf *buf = b;
 
-	siglongjmp(*buf, val);
+	UML_SIGLONGJMP(buf, val);
 }
Index: linux-2.6.15-mm/arch/um/os-Linux/uaccess.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/uaccess.c	2006-01-09 10:27:19.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/uaccess.c	2006-01-09 11:47:54.000000000 -0500
@@ -6,6 +6,7 @@
 
 #include <setjmp.h>
 #include <string.h>
+#include "longjmp.h"
 
 unsigned long __do_user_copy(void *to, const void *from, int n,
 			     void **fault_addr, void **fault_catcher,
@@ -13,10 +14,11 @@ unsigned long __do_user_copy(void *to, c
 					int n), int *faulted_out)
 {
 	unsigned long *faddrp = (unsigned long *) fault_addr, ret;
+	int enable;
 
 	sigjmp_buf jbuf;
 	*fault_catcher = &jbuf;
-	if(sigsetjmp(jbuf, 1) == 0){
+	if(UML_SIGSETJMP(&jbuf, enable) == 0){
 		(*op)(to, from, n);
 		ret = 0;
 		*faulted_out = 0;
Index: linux-2.6.15-mm/arch/um/os-Linux/util.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/util.c	2006-01-09 11:26:24.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/util.c	2006-01-09 11:43:13.000000000 -0500
@@ -30,6 +30,7 @@
 #include "ptrace_user.h"
 #include "uml-config.h"
 #include "os.h"
+#include "longjmp.h"
 
 void stack_protections(unsigned long address)
 {

