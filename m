Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263004AbUKXXgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbUKXXgc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbUKXXeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:34:20 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:26116
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262942AbUKXXUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:20:34 -0500
Message-Id: <200411242306.iAON67bn005393@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: [PATCH] UML - Redo the signal delivery mechanism
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Nov 2004 18:06:07 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch rips out the old signal delivery mechanism and replaces
it with a sane one.
Specifically, UML used to capture a host signal frame and use it as a template
for its own signal frames.  This was a worthy idea, because it promised a degree
of architecture-independence for this part of UML, but impractical.  There
are some environments, notably 32 bit emulation on a 64 bit box, where you
can't use the host signal frame as a template for your own.  Plus, this code
is as complicated, even to someone who understands what it's doing, as the
standard fill-in-a-structure-and-write-it-to-the-stack.  For everyone else,
it is incomprehensible.
So, this reimplements signal handling in the way that everyone else does.
It gives up on architecture independence, and moves this code into the 
x86-specific stuff.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/include/frame.h
===================================================================
--- 2.6.9.orig/arch/um/include/frame.h	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/include/frame.h	2003-09-15 09:40:47.000000000 -0400
@@ -1,53 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __FRAME_H_
-#define __FRAME_H_
-
-#include "sysdep/frame.h"
-
-struct frame_common {
-	void *data;
-	int len;
-	int sig_index;
-	int sr_index;
-	int sr_relative;
-	int sp_index;
-	struct arch_frame_data arch;
-};
-
-struct sc_frame {
-	struct frame_common common;
-	int sc_index;
-};
-
-extern struct sc_frame signal_frame_sc;
-
-extern struct sc_frame signal_frame_sc_sr;
-
-struct si_frame {
-	struct frame_common common;
-	int sip_index;
-	int si_index;
-	int ucp_index;
-	int uc_index;
-};
-
-extern struct si_frame signal_frame_si;
-
-extern void capture_signal_stack(void);
-
-#endif
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
Index: 2.6.9/arch/um/include/frame_kern.h
===================================================================
--- 2.6.9.orig/arch/um/include/frame_kern.h	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/include/frame_kern.h	2004-11-24 12:23:49.000000000 -0500
@@ -6,8 +6,8 @@
 #ifndef __FRAME_KERN_H_
 #define __FRAME_KERN_H_
 
-#include "frame.h"
-#include "sysdep/frame_kern.h"
+#define _S(nr) (1<<((nr)-1))
+#define _BLOCKABLE (~(_S(SIGKILL) | _S(SIGSTOP)))
 
 extern int setup_signal_stack_sc(unsigned long stack_top, int sig, 
 				 struct k_sigaction *ka,
Index: 2.6.9/arch/um/include/frame_user.h
===================================================================
--- 2.6.9.orig/arch/um/include/frame_user.h	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/include/frame_user.h	2003-09-15 09:40:47.000000000 -0400
@@ -1,23 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __FRAME_USER_H_
-#define __FRAME_USER_H_
-
-#include "sysdep/frame_user.h"
-#include "frame.h"
-
-#endif
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
Index: 2.6.9/arch/um/include/sysdep-i386/frame.h
===================================================================
--- 2.6.9.orig/arch/um/include/sysdep-i386/frame.h	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/include/sysdep-i386/frame.h	2003-09-15 09:40:47.000000000 -0400
@@ -1,29 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __FRAME_I386_H
-#define __FRAME_I386_H
-
-struct arch_frame_data_raw {
-	unsigned long fp_start;
-	unsigned long sr;
-};
-
-struct arch_frame_data {
-	int fpstate_size;
-};
-
-#endif
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
Index: 2.6.9/arch/um/include/sysdep-i386/frame_kern.h
===================================================================
--- 2.6.9.orig/arch/um/include/sysdep-i386/frame_kern.h	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/include/sysdep-i386/frame_kern.h	2003-09-15 09:40:47.000000000 -0400
@@ -1,69 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __FRAME_KERN_I386_H
-#define __FRAME_KERN_I386_H
-
-/* This is called from sys_sigreturn.  It takes the sp at the point of the
- * sigreturn system call and returns the address of the sigcontext struct
- * on the stack.
- */
-
-static inline void *sp_to_sc(unsigned long sp)
-{
-	return((void *) sp);
-}
-
-static inline void *sp_to_uc(unsigned long sp)
-{
-	unsigned long uc;
-
-	uc = sp + signal_frame_si.uc_index - 
-		signal_frame_si.common.sp_index - 4;
-	return((void *) uc);
-}
-
-static inline void *sp_to_rt_sc(unsigned long sp)
-{
-	unsigned long sc;
-
-	sc = sp - signal_frame_si.common.sp_index + 
-		signal_frame_si.common.len - 4;
-	return((void *) sc);
-}
-
-static inline void *sp_to_mask(unsigned long sp)
-{
-	unsigned long mask;
-
-	mask = sp - signal_frame_sc.common.sp_index + 
-		signal_frame_sc.common.len - 8;
-	return((void *) mask);
-}
-
-extern int sc_size(void *data);
-
-static inline void *sp_to_rt_mask(unsigned long sp)
-{
-	unsigned long mask;
-
-	mask = sp - signal_frame_si.common.sp_index + 
-		signal_frame_si.common.len + 
-		sc_size(&signal_frame_si.common.arch) - 4;
-	return((void *) mask);
-}
-
-#endif
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
Index: 2.6.9/arch/um/include/sysdep-i386/frame_user.h
===================================================================
--- 2.6.9.orig/arch/um/include/sysdep-i386/frame_user.h	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/include/sysdep-i386/frame_user.h	2003-09-15 09:40:47.000000000 -0400
@@ -1,91 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __FRAME_USER_I386_H
-#define __FRAME_USER_I386_H
-
-#include <asm/page.h>
-#include "sysdep/frame.h"
-
-/* This stuff is to calculate the size of the fp state struct at runtime
- * because it has changed between 2.2 and 2.4 and it would be good for a
- * UML compiled on one to work on the other.
- * So, setup_arch_frame_raw fills in the arch struct with the raw data, which
- * just contains the address of the end of the sigcontext.  This is invoked
- * from the signal handler.
- * setup_arch_frame uses that data to figure out what 
- * arch_frame_data.fpstate_size should be.  It really has no idea, since it's
- * not allowed to do sizeof(struct fpstate) but it's safe to consider that it's
- * everything from the end of the sigcontext up to the top of the stack.  So,
- * it masks off the page number to get the offset within the page and subtracts
- * that from the page size, and that's how big the fpstate struct will be
- * considered to be.
- */
-
-static inline void setup_arch_frame_raw(struct arch_frame_data_raw *data,
-					void *end, unsigned long srp)
-{
-	unsigned long sr = *((unsigned long *) srp);
-
-	data->fp_start = (unsigned long) end;
-	if((sr & PAGE_MASK) == ((unsigned long) end & PAGE_MASK))
-		data->sr = sr;
-	else data->sr = 0;
-}
-
-static inline void setup_arch_frame(struct arch_frame_data_raw *in, 
-				    struct arch_frame_data *out)
-{
-	unsigned long fpstate_start = in->fp_start;
-
-	if(in->sr == 0){
-		fpstate_start &= ~PAGE_MASK;
-		out->fpstate_size = PAGE_SIZE - fpstate_start;
-	}
-	else {
-		out->fpstate_size = in->sr - fpstate_start;
-	}
-}
-
-/* This figures out where on the stack the SA_RESTORER function address
- * is stored.  For i386, it's the signal handler return address, so it's
- * located next to the frame pointer.
- * This is inlined, so __builtin_frame_address(0) is correct.  Otherwise,
- * it would have to be __builtin_frame_address(1).
- */
-
-#define frame_restorer() \
-({ \
-	unsigned long *fp; \
-\
-	fp = __builtin_frame_address(0); \
-	((unsigned long) (fp + 1)); \
-})
-
-/* Similarly, this returns the value of sp when the handler was first
- * entered.  This is used to calculate the proper sp when delivering
- * signals.
- */
-
-#define frame_sp() \
-({ \
-	unsigned long *fp; \
-\
-	fp = __builtin_frame_address(0); \
-	((unsigned long) (fp + 1)); \
-})
-
-#endif
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
Index: 2.6.9/arch/um/kernel/Makefile
===================================================================
--- 2.6.9.orig/arch/um/kernel/Makefile	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/Makefile	2004-11-24 12:23:49.000000000 -0500
@@ -6,7 +6,7 @@
 extra-y := vmlinux.lds
 clean-files := vmlinux.lds.S
 
-obj-y = checksum.o config.o exec_kern.o exitcode.o frame_kern.o frame.o \
+obj-y = checksum.o config.o exec_kern.o exitcode.o \
 	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
 	physmem.o process.o process_kern.o ptrace.o reboot.o resource.o \
 	sigio_user.o sigio_kern.o signal_kern.o signal_user.o smp.o \
Index: 2.6.9/arch/um/kernel/frame.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/frame.c	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/frame.c	2003-09-15 09:40:47.000000000 -0400
@@ -1,343 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <signal.h>
-#include <wait.h>
-#include <sched.h>
-#include <errno.h>
-#include <sys/ptrace.h>
-#include <sys/syscall.h>
-#include <sys/mman.h>
-#include <asm/page.h>
-#include <asm/ptrace.h>
-#include <asm/sigcontext.h>
-#include "sysdep/ptrace.h"
-#include "sysdep/sigcontext.h"
-#include "frame_user.h"
-#include "kern_util.h"
-#include "user_util.h"
-#include "ptrace_user.h"
-#include "os.h"
-
-static int capture_stack(int (*child)(void *arg), void *arg, void *sp,
-			 unsigned long top, void **data_out)
-{
-	unsigned long regs[FRAME_SIZE];
-	int pid, status, n, len;
-
-	/* Start the child as a thread */
-	pid = clone(child, sp, CLONE_VM | SIGCHLD, arg);
-	if(pid < 0){
-		printf("capture_stack : clone failed - errno = %d\n", errno);
-		exit(1);
-	}
-
-	/* Wait for it to stop itself and continue it with a SIGUSR1 to force 
-	 * it into the signal handler.
-	 */
-	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
-	if(n < 0){
-		printf("capture_stack : waitpid failed - errno = %d\n", errno);
-		exit(1);
-	}
-	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)){
-		fprintf(stderr, "capture_stack : Expected SIGSTOP, "
-			"got status = 0x%x\n", status);
-		exit(1);
-	}
-	if(ptrace(PTRACE_CONT, pid, 0, SIGUSR1) < 0){
-		printf("capture_stack : PTRACE_CONT failed - errno = %d\n", 
-		       errno);
-		exit(1);
-	}
-
-	/* Wait for it to stop itself again and grab its registers again.  
-	 * At this point, the handler has stuffed the addresses of
-	 * sig, sc, and SA_RESTORER in raw.
-	 */
-	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
-	if(n < 0){
-		printf("capture_stack : waitpid failed - errno = %d\n", errno);
-		exit(1);
-	}
-	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)){
-		fprintf(stderr, "capture_stack : Expected SIGSTOP, "
-			"got status = 0x%x\n", status);
-		exit(1);
-	}
-	if(ptrace(PTRACE_GETREGS, pid, 0, regs) < 0){
-		printf("capture_stack : PTRACE_GETREGS failed - errno = %d\n", 
-		       errno);
-		exit(1);
-	}
-
-	/* It has outlived its usefulness, so continue it so it can exit */
-	if(ptrace(PTRACE_CONT, pid, 0, 0) < 0){
-		printf("capture_stack : PTRACE_CONT failed - errno = %d\n", 
-		       errno);
-		exit(1);
-	}
-	CATCH_EINTR(n = waitpid(pid, &status, 0));
-	if(n < 0){
-		printf("capture_stack : waitpid failed - errno = %d\n", errno);
-		exit(1);
-	}
-	if(!WIFSIGNALED(status) || (WTERMSIG(status) != 9)){
-		printf("capture_stack : Expected exit signal 9, "
-		       "got status = 0x%x\n", status);
-		exit(1);
-	}
-
-	/* The frame that we want is the top of the signal stack */
-
-	len = top - PT_SP(regs);
-	*data_out = malloc(len);
-	if(*data_out == NULL){
-		printf("capture_stack : malloc failed - errno = %d\n", errno);
-		exit(1);
-	}
-	memcpy(*data_out, (void *) PT_SP(regs), len);
-
-	return(len);
-}
-
-struct common_raw {
-	void *stack;
-	int size;
-	unsigned long sig;
-	unsigned long sr;
-	unsigned long sp;	
-	struct arch_frame_data_raw arch;
-};
-
-#define SA_RESTORER (0x04000000)
-
-typedef unsigned long old_sigset_t;
-
-struct old_sigaction {
-	__sighandler_t handler;
-	old_sigset_t sa_mask;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-};
-
-static void child_common(struct common_raw *common, sighandler_t handler,
-			 int restorer, int flags)
-{
-	stack_t ss = ((stack_t) { .ss_sp	= common->stack,
-				  .ss_flags	= 0,
-				  .ss_size	= common->size });
-	int err;
-
-	if(ptrace(PTRACE_TRACEME, 0, 0, 0) < 0){
-		printf("PTRACE_TRACEME failed, errno = %d\n", errno);
-	}
-	if(sigaltstack(&ss, NULL) < 0){
-		printf("sigaltstack failed - errno = %d\n", errno);
-		kill(os_getpid(), SIGKILL);
-	}
-
-	if(restorer){
-		struct sigaction sa;
-
-		sa.sa_handler = handler;
-		sigemptyset(&sa.sa_mask);
-		sa.sa_flags = SA_ONSTACK | flags;
-		err = sigaction(SIGUSR1, &sa, NULL);
-	}
-	else {
-		struct old_sigaction sa;
-
-		sa.handler = handler;
-		sa.sa_mask = 0;
-		sa.sa_flags = (SA_ONSTACK | flags) & ~SA_RESTORER;
-		err = syscall(__NR_sigaction, SIGUSR1, &sa, NULL);
-	}
-	
-	if(err < 0){
-		printf("sigaction failed - errno = %d\n", errno);
-		kill(os_getpid(), SIGKILL);
-	}
-
-	os_stop_process(os_getpid());
-}
-
-/* Changed only during early boot */
-struct sc_frame signal_frame_sc;
-
-struct sc_frame signal_frame_sc_sr;
-
-struct sc_frame_raw {
-	struct common_raw common;
-	unsigned long sc;
-	int restorer;
-};
-
-/* Changed only during early boot */
-static struct sc_frame_raw *raw_sc = NULL;
-
-static void sc_handler(int sig, struct sigcontext sc)
-{
-	raw_sc->common.sig = (unsigned long) &sig;
-	raw_sc->common.sr = frame_restorer();
-	raw_sc->common.sp = frame_sp();
-	raw_sc->sc = (unsigned long) &sc;
-	setup_arch_frame_raw(&raw_sc->common.arch, &sc + 1, raw_sc->common.sr);
-
-	os_stop_process(os_getpid());
-	kill(os_getpid(), SIGKILL);
-}
-
-static int sc_child(void *arg)
-{
-	raw_sc = arg;
-	child_common(&raw_sc->common, (sighandler_t) sc_handler, 
-		     raw_sc->restorer, 0);
-	return(-1);
-}
-
-/* Changed only during early boot */
-struct si_frame signal_frame_si;
-
-struct si_frame_raw {
-	struct common_raw common;
-	unsigned long sip;
-	unsigned long si;
-	unsigned long ucp;
-	unsigned long uc;
-};
-
-/* Changed only during early boot */
-static struct si_frame_raw *raw_si = NULL;
-
-static void si_handler(int sig, siginfo_t *si, struct ucontext *ucontext)
-{
-	raw_si->common.sig = (unsigned long) &sig;
-	raw_si->common.sr = frame_restorer();
-	raw_si->common.sp = frame_sp();
-	raw_si->sip = (unsigned long) &si;
-	raw_si->si = (unsigned long) si;
-	raw_si->ucp = (unsigned long) &ucontext;
-	raw_si->uc = (unsigned long) ucontext;
-	setup_arch_frame_raw(&raw_si->common.arch, 
-			     ucontext->uc_mcontext.fpregs, raw_si->common.sr);
-	
-	os_stop_process(os_getpid());
-	kill(os_getpid(), SIGKILL);
-}
-
-static int si_child(void *arg)
-{
-	raw_si = arg;
-	child_common(&raw_si->common, (sighandler_t) si_handler, 1, 
- 		     SA_SIGINFO);
-	return(-1);
-}
-
-static int relative_sr(unsigned long sr, int sr_index, void *stack, 
-		       void *framep)
-{
-	unsigned long *srp = (unsigned long *) sr;
-	unsigned long frame = (unsigned long) framep;
-
-	if((*srp & PAGE_MASK) == (unsigned long) stack){
-		*srp -= sr;
-		*((unsigned long *) (frame + sr_index)) = *srp;
-		return(1);
-	}
-	else return(0);
-}
-
-static unsigned long capture_stack_common(int (*proc)(void *), void *arg, 
-					  struct common_raw *common_in, 
-					  void *top, void *sigstack, 
-					  int stack_len, 
-					  struct frame_common *common_out)
-{
-	unsigned long sig_top = (unsigned long) sigstack + stack_len, base;
-
-	common_in->stack = (void *) sigstack;
-	common_in->size = stack_len;
-	common_out->len = capture_stack(proc, arg, top, sig_top, 
-					&common_out->data);
-	base = sig_top - common_out->len;
-	common_out->sig_index = common_in->sig - base;
-	common_out->sp_index = common_in->sp - base;
-	common_out->sr_index = common_in->sr - base;
-	common_out->sr_relative = relative_sr(common_in->sr, 
-					      common_out->sr_index, sigstack, 
-					      common_out->data);
-	return(base);
-}
-
-void capture_signal_stack(void)
-{
-	struct sc_frame_raw raw_sc;
-	struct si_frame_raw raw_si;
-	void *stack, *sigstack;
-	unsigned long top, base;
-
-	stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
-		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-	sigstack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
-			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-	if((stack == MAP_FAILED) || (sigstack == MAP_FAILED)){
-		printf("capture_signal_stack : mmap failed - errno = %d\n", 
-		       errno);
-		exit(1);
-	}
-
-	top = (unsigned long) stack + PAGE_SIZE - sizeof(void *);
-
-	/* Get the sigcontext, no sigrestorer layout */
-	raw_sc.restorer = 0;
-	base = capture_stack_common(sc_child, &raw_sc, &raw_sc.common, 
-				    (void *) top, sigstack, PAGE_SIZE, 
-				    &signal_frame_sc.common);
-
-	signal_frame_sc.sc_index = raw_sc.sc - base;
-	setup_arch_frame(&raw_sc.common.arch, &signal_frame_sc.common.arch);
-
-	/* Ditto for the sigcontext, sigrestorer layout */
-	raw_sc.restorer = 1;
-	base = capture_stack_common(sc_child, &raw_sc, &raw_sc.common, 
-				    (void *) top, sigstack, PAGE_SIZE, 
-				    &signal_frame_sc_sr.common);
-	signal_frame_sc_sr.sc_index = raw_sc.sc - base;
-	setup_arch_frame(&raw_sc.common.arch, &signal_frame_sc_sr.common.arch);
-
-	/* And the siginfo layout */
-
-	base = capture_stack_common(si_child, &raw_si, &raw_si.common, 
-				    (void *) top, sigstack, PAGE_SIZE, 
-				    &signal_frame_si.common);
-	signal_frame_si.sip_index = raw_si.sip - base;
-	signal_frame_si.si_index = raw_si.si - base;
-	signal_frame_si.ucp_index = raw_si.ucp - base;
-	signal_frame_si.uc_index = raw_si.uc - base;
-	setup_arch_frame(&raw_si.common.arch, &signal_frame_si.common.arch);
-
-	if((munmap(stack, PAGE_SIZE) < 0) || 
-	   (munmap(sigstack, PAGE_SIZE) < 0)){
-		printf("capture_signal_stack : munmap failed - errno = %d\n", 
-		       errno);
-		exit(1);
-	}
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
Index: 2.6.9/arch/um/kernel/frame_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/frame_kern.c	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/frame_kern.c	2003-09-15 09:40:47.000000000 -0400
@@ -1,148 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include "asm/ptrace.h"
-#include "asm/uaccess.h"
-#include "asm/signal.h"
-#include "asm/ucontext.h"
-#include "frame_kern.h"
-#include "sigcontext.h"
-#include "sysdep/ptrace.h"
-#include "choose-mode.h"
-#include "mode.h"
-
-static int copy_restorer(void (*restorer)(void), unsigned long start, 
-			 unsigned long sr_index, int sr_relative)
-{
-	unsigned long sr;
-
-	if(sr_relative){
-		sr = (unsigned long) restorer;
-		sr += start + sr_index;
-		restorer = (void (*)(void)) sr;
-	}
-
-	return(copy_to_user((void *) (start + sr_index), &restorer, 
-			    sizeof(restorer)));
-}
-
-extern int userspace_pid[];
-
-static int copy_sc_to_user(void *to, void *fp, struct pt_regs *from, 
-			   struct arch_frame_data *arch)
-{
-	return(CHOOSE_MODE(copy_sc_to_user_tt(to, fp, UPT_SC(&from->regs), 
-					      arch),
-			   copy_sc_to_user_skas(userspace_pid[0], to, fp,
-						&from->regs,
-						current->thread.cr2,
-						current->thread.err)));
-}
-
-static int copy_ucontext_to_user(struct ucontext *uc, void *fp, sigset_t *set,
-				 unsigned long sp)
-{
-	int err = 0;
-
-	err |= put_user(current->sas_ss_sp, &uc->uc_stack.ss_sp);
-	err |= put_user(sas_ss_flags(sp), &uc->uc_stack.ss_flags);
-	err |= put_user(current->sas_ss_size, &uc->uc_stack.ss_size);
-	err |= copy_sc_to_user(&uc->uc_mcontext, fp, &current->thread.regs,
-			       &signal_frame_si.common.arch);
-	err |= copy_to_user(&uc->uc_sigmask, set, sizeof(*set));
-	return(err);
-}
-
-int setup_signal_stack_si(unsigned long stack_top, int sig, 
-			  struct k_sigaction *ka, struct pt_regs *regs,
-			  siginfo_t *info, sigset_t *mask)
-{
-	unsigned long start;
-	void *restorer;
-	void *sip, *ucp, *fp;
-
-	start = stack_top - signal_frame_si.common.len;
-	sip = (void *) (start + signal_frame_si.si_index);
-	ucp = (void *) (start + signal_frame_si.uc_index);
-	fp = (void *) (((unsigned long) ucp) + sizeof(struct ucontext));
-
-	restorer = NULL;
-	if(ka->sa.sa_flags & SA_RESTORER)
-		restorer = ka->sa.sa_restorer;
-
-	if(restorer == NULL)
-		panic("setup_signal_stack_si - no restorer");
-
-	if(copy_to_user((void *) start, signal_frame_si.common.data,
-			signal_frame_si.common.len) ||
-	   copy_to_user((void *) (start + signal_frame_si.common.sig_index), 
-			&sig, sizeof(sig)) ||
-	   copy_siginfo_to_user(sip, info) ||
-	   copy_to_user((void *) (start + signal_frame_si.sip_index), &sip,
-			sizeof(sip)) ||
-	   copy_ucontext_to_user(ucp, fp, mask, PT_REGS_SP(regs)) ||
-	   copy_to_user((void *) (start + signal_frame_si.ucp_index), &ucp,
-			sizeof(ucp)) ||
-	   copy_restorer(restorer, start, signal_frame_si.common.sr_index,
-			 signal_frame_si.common.sr_relative))
-		return(1);
-	
-	PT_REGS_IP(regs) = (unsigned long) ka->sa.sa_handler;
-	PT_REGS_SP(regs) = start + signal_frame_si.common.sp_index;
-	return(0);
-}
-
-int setup_signal_stack_sc(unsigned long stack_top, int sig, 
-			  struct k_sigaction *ka, struct pt_regs *regs,
-			  sigset_t *mask)
-{
-	struct frame_common *frame = &signal_frame_sc_sr.common;
-	void *restorer;
-	void *user_sc;
-	int sig_size = (_NSIG_WORDS - 1) * sizeof(unsigned long);
-	unsigned long sigs, sr;
-	unsigned long start = stack_top - frame->len - sig_size;
-
-	restorer = NULL;
-	if(ka->sa.sa_flags & SA_RESTORER)
-		restorer = ka->sa.sa_restorer;
-
-	user_sc = (void *) (start + signal_frame_sc_sr.sc_index);
-	if(restorer == NULL){
-		frame = &signal_frame_sc.common;
-		user_sc = (void *) (start + signal_frame_sc.sc_index);
-		sr = (unsigned long) frame->data;
-		sr += frame->sr_index;
-		sr = *((unsigned long *) sr);
-		restorer = ((void (*)(void)) sr);
-	}
-
-	sigs = start + frame->len;
-	if(copy_to_user((void *) start, frame->data, frame->len) ||
-	   copy_to_user((void *) (start + frame->sig_index), &sig, 
-			sizeof(sig)) ||
-	   copy_sc_to_user(user_sc, NULL, regs, 
-			   &signal_frame_sc.common.arch) ||
-	   copy_to_user(sc_sigmask(user_sc), mask, sizeof(mask->sig[0])) ||
-	   copy_to_user((void *) sigs, &mask->sig[1], sig_size) ||
-	   copy_restorer(restorer, start, frame->sr_index, frame->sr_relative))
-		return(1);
-
-	PT_REGS_IP(regs) = (unsigned long) ka->sa.sa_handler;
-	PT_REGS_SP(regs) = start + frame->sp_index;
-
-	return(0);
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
Index: 2.6.9/arch/um/kernel/process_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/process_kern.c	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/process_kern.c	2004-11-24 12:23:49.000000000 -0500
@@ -291,8 +291,6 @@
 
 EXPORT_SYMBOL(disable_hlt);
 
-extern int signal_frame_size;
-
 void *um_kmalloc(int size)
 {
 	return(kmalloc(size, GFP_KERNEL));
Index: 2.6.9/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/signal_kern.c	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/signal_kern.c	2004-11-24 12:23:49.000000000 -0500
@@ -230,53 +230,6 @@
 	return(do_sigaltstack(uss, uoss, PT_REGS_SP(&current->thread.regs)));
 }
 
-extern int userspace_pid[];
-
-static int copy_sc_from_user(struct pt_regs *to, void *from, 
-			     struct arch_frame_data *arch)
-{
-	int ret;
-
-	ret = CHOOSE_MODE(copy_sc_from_user_tt(UPT_SC(&to->regs), from, arch),
-			  copy_sc_from_user_skas(userspace_pid[0],
-						 &to->regs, from));
-	return(ret);
-}
-
-long sys_sigreturn(struct pt_regs regs)
-{
-	void __user *sc = sp_to_sc(PT_REGS_SP(&current->thread.regs));
-	void __user *mask = sp_to_mask(PT_REGS_SP(&current->thread.regs));
-	int sig_size = (_NSIG_WORDS - 1) * sizeof(unsigned long);
-
-	spin_lock_irq(&current->sighand->siglock);
-	copy_from_user(&current->blocked.sig[0], sc_sigmask(sc), 
-		       sizeof(current->blocked.sig[0]));
-	copy_from_user(&current->blocked.sig[1], mask, sig_size);
-	sigdelsetmask(&current->blocked, ~_BLOCKABLE);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-	copy_sc_from_user(&current->thread.regs, sc, 
-			  &signal_frame_sc.common.arch);
-	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
-}
-
-long sys_rt_sigreturn(struct pt_regs regs)
-{
-	unsigned long sp = PT_REGS_SP(&current->thread.regs);
-	struct ucontext __user *uc = sp_to_uc(sp);
-	int sig_size = _NSIG_WORDS * sizeof(unsigned long);
-
-	spin_lock_irq(&current->sighand->siglock);
-	copy_from_user(&current->blocked, &uc->uc_sigmask, sig_size);
-	sigdelsetmask(&current->blocked, ~_BLOCKABLE);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-	copy_sc_from_user(&current->thread.regs, &uc->uc_mcontext,
-			  &signal_frame_si.common.arch);
-	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
-}
-
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: 2.6.9/arch/um/kernel/skas/Makefile
===================================================================
--- 2.6.9.orig/arch/um/kernel/skas/Makefile	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/skas/Makefile	2004-11-24 12:23:49.000000000 -0500
@@ -5,7 +5,6 @@
 
 obj-y := exec_kern.o mem.o mem_user.o mmu.o process.o process_kern.o \
 	syscall_kern.o syscall_user.o time.o tlb.o trap_user.o uaccess.o \
-	sys-$(SUBARCH)/
 
 subdir-y := util
 
Index: 2.6.9/arch/um/kernel/skas/include/mode-skas.h
===================================================================
--- 2.6.9.orig/arch/um/kernel/skas/include/mode-skas.h	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/skas/include/mode-skas.h	2004-11-24 12:23:49.000000000 -0500
@@ -14,11 +14,6 @@
 extern int have_fpx_regs;
 
 extern void user_time_init_skas(void);
-extern int copy_sc_from_user_skas(int pid, union uml_pt_regs *regs,
-				  void *from_ptr);
-extern int copy_sc_to_user_skas(int pid, void *to_ptr, void *fp,
-				union uml_pt_regs *regs,
-				unsigned long fault_addr, int fault_type);
 extern void sig_handler_common_skas(int sig, void *sc_ptr);
 extern void halt_skas(void);
 extern void reboot_skas(void);
Index: 2.6.9/arch/um/kernel/skas/process_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/skas/process_kern.c	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/skas/process_kern.c	2004-11-24 12:23:49.000000000 -0500
@@ -19,7 +19,6 @@
 #include "os.h"
 #include "user_util.h"
 #include "tlb.h"
-#include "frame.h"
 #include "kern.h"
 #include "mode.h"
 #include "proc_mm.h"
@@ -183,7 +182,6 @@
 int start_uml_skas(void)
 {
 	start_userspace(0);
-	capture_signal_stack();
 
 	init_new_thread_signals(1);
 	uml_idle_timer();
Index: 2.6.9/arch/um/kernel/skas/sys-i386/Makefile
===================================================================
--- 2.6.9.orig/arch/um/kernel/skas/sys-i386/Makefile	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/skas/sys-i386/Makefile	2003-09-15 09:40:47.000000000 -0400
@@ -1,12 +0,0 @@
-# 
-# Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
-# Licensed under the GPL
-#
-
-obj-y = sigcontext.o
-
-USER_OBJS = sigcontext.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
-
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
Index: 2.6.9/arch/um/kernel/skas/sys-i386/sigcontext.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/skas/sys-i386/sigcontext.c	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/skas/sys-i386/sigcontext.c	2003-09-15 09:40:47.000000000 -0400
@@ -1,114 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <errno.h>
-#include <asm/sigcontext.h>
-#include <sys/ptrace.h>
-#include <linux/ptrace.h>
-#include "sysdep/ptrace.h"
-#include "sysdep/ptrace_user.h"
-#include "kern_util.h"
-#include "user.h"
-#include "sigcontext.h"
-#include "mode.h"
-
-int copy_sc_from_user_skas(int pid, union uml_pt_regs *regs, void *from_ptr)
-{
-  	struct sigcontext sc, *from = from_ptr;
-	unsigned long fpregs[FP_FRAME_SIZE];
-	int err;
-
-	err = copy_from_user_proc(&sc, from, sizeof(sc));
-	err |= copy_from_user_proc(fpregs, sc.fpstate, sizeof(fpregs));
-	if(err)
-		return(err);
-
-	regs->skas.regs[GS] = sc.gs;
-	regs->skas.regs[FS] = sc.fs;
-	regs->skas.regs[ES] = sc.es;
-	regs->skas.regs[DS] = sc.ds;
-	regs->skas.regs[EDI] = sc.edi;
-	regs->skas.regs[ESI] = sc.esi;
-	regs->skas.regs[EBP] = sc.ebp;
-	regs->skas.regs[UESP] = sc.esp;
-	regs->skas.regs[EBX] = sc.ebx;
-	regs->skas.regs[EDX] = sc.edx;
-	regs->skas.regs[ECX] = sc.ecx;
-	regs->skas.regs[EAX] = sc.eax;
-	regs->skas.regs[EIP] = sc.eip;
-	regs->skas.regs[CS] = sc.cs;
-	regs->skas.regs[EFL] = sc.eflags;
-	regs->skas.regs[SS] = sc.ss;
-	regs->skas.fault_addr = sc.cr2;
-	regs->skas.fault_type = FAULT_WRITE(sc.err);
-	regs->skas.trap_type = sc.trapno;
-
-	err = ptrace(PTRACE_SETFPREGS, pid, 0, fpregs);
-	if(err < 0){
-	  	printk("copy_sc_to_user - PTRACE_SETFPREGS failed, "
-		       "errno = %d\n", errno);
-		return(1);
-	}
-
-	return(0);
-}
-
-int copy_sc_to_user_skas(int pid, void *to_ptr, void *fp,
-			 union uml_pt_regs *regs, unsigned long fault_addr,
-			 int fault_type)
-{
-  	struct sigcontext sc, *to = to_ptr;
-	struct _fpstate *to_fp;
-	unsigned long fpregs[FP_FRAME_SIZE];
-	int err;
-
-	sc.gs = regs->skas.regs[GS];
-	sc.fs = regs->skas.regs[FS];
-	sc.es = regs->skas.regs[ES];
-	sc.ds = regs->skas.regs[DS];
-	sc.edi = regs->skas.regs[EDI];
-	sc.esi = regs->skas.regs[ESI];
-	sc.ebp = regs->skas.regs[EBP];
-	sc.esp = regs->skas.regs[UESP];
-	sc.ebx = regs->skas.regs[EBX];
-	sc.edx = regs->skas.regs[EDX];
-	sc.ecx = regs->skas.regs[ECX];
-	sc.eax = regs->skas.regs[EAX];
-	sc.eip = regs->skas.regs[EIP];
-	sc.cs = regs->skas.regs[CS];
-	sc.eflags = regs->skas.regs[EFL];
-	sc.esp_at_signal = regs->skas.regs[UESP];
-	sc.ss = regs->skas.regs[SS];
-	sc.cr2 = fault_addr;
-	sc.err = TO_SC_ERR(fault_type);
-	sc.trapno = regs->skas.trap_type;
-
-	err = ptrace(PTRACE_GETFPREGS, pid, 0, fpregs);
-	if(err < 0){
-	  	printk("copy_sc_to_user - PTRACE_GETFPREGS failed, "
-		       "errno = %d\n", errno);
-		return(1);
-	}
-	to_fp = (struct _fpstate *) 
-		(fp ? (unsigned long) fp : ((unsigned long) to + sizeof(*to)));
-	sc.fpstate = to_fp;
-
-	if(err)
-	  	return(err);
-
-	return(copy_to_user_proc(to, &sc, sizeof(sc)) ||
-	       copy_to_user_proc(to_fp, fpregs, sizeof(fpregs)));
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
Index: 2.6.9/arch/um/kernel/trap_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/trap_user.c	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/trap_user.c	2004-11-24 12:23:49.000000000 -0500
@@ -18,7 +18,6 @@
 #include "sigcontext.h"
 #include "sysdep/sigcontext.h"
 #include "irq_user.h"
-#include "frame_user.h"
 #include "signal_user.h"
 #include "time_user.h"
 #include "task.h"
Index: 2.6.9/arch/um/kernel/tt/Makefile
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/Makefile	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/Makefile	2004-11-24 12:23:49.000000000 -0500
@@ -8,7 +8,7 @@
 
 obj-y = exec_kern.o exec_user.o gdb.o ksyms.o mem.o mem_user.o process_kern.o \
 	syscall_kern.o syscall_user.o time.o tlb.o tracer.o trap_user.o \
-	uaccess.o uaccess_user.o sys-$(SUBARCH)/
+	uaccess.o uaccess_user.o
 
 obj-$(CONFIG_PT_PROXY) += gdb_kern.o ptproxy/
 
Index: 2.6.9/arch/um/kernel/tt/include/mode-tt.h
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/include/mode-tt.h	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/include/mode-tt.h	2004-11-24 12:23:49.000000000 -0500
@@ -14,9 +14,6 @@
 
 extern int tracer(int (*init_proc)(void *), void *sp);
 extern void user_time_init_tt(void);
-extern int copy_sc_from_user_tt(void *to_ptr, void *from_ptr, void *data);
-extern int copy_sc_to_user_tt(void *to_ptr, void *fp, void *from_ptr,
-			      void *data);
 extern void sig_handler_common_tt(int sig, void *sc);
 extern void syscall_handler_tt(int sig, union uml_pt_regs *regs);
 extern void reboot_tt(void);
Index: 2.6.9/arch/um/kernel/tt/sys-i386/Makefile
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/sys-i386/Makefile	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/sys-i386/Makefile	2003-09-15 09:40:47.000000000 -0400
@@ -1,12 +0,0 @@
-# 
-# Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
-# Licensed under the GPL
-#
-
-obj-y = sigcontext.o
-
-USER_OBJS = sigcontext.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
-
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
Index: 2.6.9/arch/um/kernel/tt/sys-i386/sigcontext.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/sys-i386/sigcontext.c	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/sys-i386/sigcontext.c	2003-09-15 09:40:47.000000000 -0400
@@ -1,60 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdlib.h>
-#include <asm/sigcontext.h>
-#include "kern_util.h"
-#include "sysdep/frame.h"
-
-int copy_sc_from_user_tt(void *to_ptr, void *from_ptr, void *data)
-{
-	struct arch_frame_data *arch = data;
-	struct sigcontext *to = to_ptr, *from = from_ptr;
-	struct _fpstate *to_fp, *from_fp;
-	unsigned long sigs;
-	int err;
-
-	to_fp = to->fpstate;
-	from_fp = from->fpstate;
-	sigs = to->oldmask;
-	err = copy_from_user_proc(to, from, sizeof(*to));
-	to->oldmask = sigs;
-	if(to_fp != NULL){
-		err |= copy_from_user_proc(&to->fpstate, &to_fp,
-					   sizeof(to->fpstate));
-		err |= copy_from_user_proc(to_fp, from_fp, arch->fpstate_size);
-	}
-	return(err);
-}
-
-int copy_sc_to_user_tt(void *to_ptr, void *fp, void *from_ptr, void *data)
-{
-	struct arch_frame_data *arch = data;
-	struct sigcontext *to = to_ptr, *from = from_ptr;
-	struct _fpstate *to_fp, *from_fp;
-	int err;
-
-	to_fp = (struct _fpstate *) 
-		(fp ? (unsigned long) fp : ((unsigned long) to + sizeof(*to)));
-	from_fp = from->fpstate;
-	err = copy_to_user_proc(to, from, sizeof(*to));
-	if(from_fp != NULL){
-		err |= copy_to_user_proc(&to->fpstate, &to_fp,
-					 sizeof(to->fpstate));
-		err |= copy_to_user_proc(to_fp, from_fp, arch->fpstate_size);
-	}
-	return(err);
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
Index: 2.6.9/arch/um/kernel/tt/tracer.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/tracer.c	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/tracer.c	2004-11-24 12:23:49.000000000 -0500
@@ -25,7 +25,6 @@
 #include "mem_user.h"
 #include "process.h"
 #include "kern_util.h"
-#include "frame.h"
 #include "chan_user.h"
 #include "ptrace_user.h"
 #include "mode.h"
@@ -186,7 +185,6 @@
 	int last_index, proc_id = 0, n, err, old_tracing = 0, strace = 0;
 	int pt_syscall_parm, local_using_sysemu;
 
-	capture_signal_stack();
 	signal(SIGPIPE, SIG_IGN);
 	setup_tracer_winch();
 	tracing_pid = os_getpid();
Index: 2.6.9/arch/um/sys-i386/Makefile
===================================================================
--- 2.6.9.orig/arch/um/sys-i386/Makefile	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/sys-i386/Makefile	2004-11-24 12:23:49.000000000 -0500
@@ -1,5 +1,5 @@
 obj-y = bitops.o bugs.o checksum.o fault.o ksyms.o ldt.o ptrace.o \
-	ptrace_user.o semaphore.o sigcontext.o syscalls.o sysrq.o
+	ptrace_user.o semaphore.o signal.o sigcontext.o syscalls.o sysrq.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
Index: 2.6.9/arch/um/sys-i386/sigcontext.c
===================================================================
--- 2.6.9.orig/arch/um/sys-i386/sigcontext.c	2004-11-24 12:23:13.000000000 -0500
+++ 2.6.9/arch/um/sys-i386/sigcontext.c	2004-11-24 12:23:49.000000000 -0500
@@ -9,22 +9,14 @@
 #include <asm/sigcontext.h>
 #include "sysdep/ptrace.h"
 #include "kern_util.h"
-#include "frame_user.h"
-
-int sc_size(void *data)
-{
-	struct arch_frame_data *arch = data;
-
-	return(sizeof(struct sigcontext) + arch->fpstate_size);
-}
 
 void sc_to_sc(void *to_ptr, void *from_ptr)
 {
 	struct sigcontext *to = to_ptr, *from = from_ptr;
-	int size = sizeof(*to) + signal_frame_sc.common.arch.fpstate_size;
 
-	memcpy(to, from, size);
-	if(from->fpstate != NULL) to->fpstate = (struct _fpstate *) (to + 1);
+	memcpy(to, from, sizeof(*to) + sizeof(struct _fpstate));
+	if(from->fpstate != NULL)
+		to->fpstate = (struct _fpstate *) (to + 1);
 }
 
 unsigned long *sc_sigmask(void *sc_ptr)
Index: 2.6.9/arch/um/sys-i386/signal.c
===================================================================
--- 2.6.9.orig/arch/um/sys-i386/signal.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.9/arch/um/sys-i386/signal.c	2004-11-24 12:23:49.000000000 -0500
@@ -0,0 +1,348 @@
+/* 
+ * Copyright (C) 2004 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
+#include "linux/signal.h"
+#include "linux/ptrace.h"
+#include "asm/current.h"
+#include "asm/ucontext.h"
+#include "asm/uaccess.h"
+#include "asm/unistd.h"
+#include "frame_kern.h"
+#include "signal_user.h"
+#include "ptrace_user.h"
+#include "sigcontext.h"
+#include "mode.h"
+
+#ifdef CONFIG_MODE_SKAS
+
+#include "skas.h"
+
+static int copy_sc_from_user_skas(struct pt_regs *regs, 
+				  struct sigcontext *from)
+{
+  	struct sigcontext sc;
+	unsigned long fpregs[HOST_FP_SIZE];
+	int err;
+
+	err = copy_from_user(&sc, from, sizeof(sc));
+	err |= copy_from_user(fpregs, sc.fpstate, sizeof(fpregs));
+	if(err)
+		return(err);
+
+	REGS_GS(regs->regs.skas.regs) = sc.gs;
+	REGS_FS(regs->regs.skas.regs) = sc.fs;
+	REGS_ES(regs->regs.skas.regs) = sc.es;
+	REGS_DS(regs->regs.skas.regs) = sc.ds;
+	REGS_EDI(regs->regs.skas.regs) = sc.edi;
+	REGS_ESI(regs->regs.skas.regs) = sc.esi;
+	REGS_EBP(regs->regs.skas.regs) = sc.ebp;
+	REGS_SP(regs->regs.skas.regs) = sc.esp;
+	REGS_EBX(regs->regs.skas.regs) = sc.ebx;
+	REGS_EDX(regs->regs.skas.regs) = sc.edx;
+	REGS_ECX(regs->regs.skas.regs) = sc.ecx;
+	REGS_EAX(regs->regs.skas.regs) = sc.eax;
+	REGS_IP(regs->regs.skas.regs) = sc.eip;
+	REGS_CS(regs->regs.skas.regs) = sc.cs;
+	REGS_EFLAGS(regs->regs.skas.regs) = sc.eflags;
+	REGS_SS(regs->regs.skas.regs) = sc.ss;
+	regs->regs.skas.fault_addr = sc.cr2;
+	regs->regs.skas.fault_type = FAULT_WRITE(sc.err);
+	regs->regs.skas.trap_type = sc.trapno;
+
+	err = ptrace_setfpregs(userspace_pid[0], fpregs);
+	if(err < 0){
+	  	printk("copy_sc_from_user_skas - PTRACE_SETFPREGS failed, "
+		       "errno = %d\n", err);
+		return(1);
+	}
+
+	return(0);
+}
+
+int copy_sc_to_user_skas(struct sigcontext *to, struct _fpstate *to_fp, 
+			 struct pt_regs *regs, unsigned long fault_addr, 
+			 int fault_type)
+{
+  	struct sigcontext sc;
+	unsigned long fpregs[HOST_FP_SIZE];
+	int err;
+
+	sc.gs = REGS_GS(regs->regs.skas.regs);
+	sc.fs = REGS_FS(regs->regs.skas.regs);
+	sc.es = REGS_ES(regs->regs.skas.regs);
+	sc.ds = REGS_DS(regs->regs.skas.regs);
+	sc.edi = REGS_EDI(regs->regs.skas.regs);
+	sc.esi = REGS_ESI(regs->regs.skas.regs);
+	sc.ebp = REGS_EBP(regs->regs.skas.regs);
+	sc.esp = REGS_SP(regs->regs.skas.regs);
+	sc.ebx = REGS_EBX(regs->regs.skas.regs);
+	sc.edx = REGS_EDX(regs->regs.skas.regs);
+	sc.ecx = REGS_ECX(regs->regs.skas.regs);
+	sc.eax = REGS_EAX(regs->regs.skas.regs);
+	sc.eip = REGS_IP(regs->regs.skas.regs);
+	sc.cs = REGS_CS(regs->regs.skas.regs);
+	sc.eflags = REGS_EFLAGS(regs->regs.skas.regs);
+	sc.esp_at_signal = regs->regs.skas.regs[UESP];
+	sc.ss = regs->regs.skas.regs[SS];
+	sc.cr2 = fault_addr;
+	sc.err = TO_SC_ERR(fault_type);
+	sc.trapno = regs->regs.skas.trap_type;
+
+	err = ptrace_getfpregs(userspace_pid[0], fpregs);
+	if(err < 0){
+	  	printk("copy_sc_to_user_skas - PTRACE_GETFPREGS failed, "
+		       "errno = %d\n", err);
+		return(1);
+	}
+	to_fp = (to_fp ? to_fp : (struct _fpstate *) (to + 1));
+	sc.fpstate = to_fp;
+
+	if(err)
+	  	return(err);
+
+	return(copy_to_user(to, &sc, sizeof(sc)) ||
+	       copy_to_user(to_fp, fpregs, sizeof(fpregs)));
+}
+#endif
+
+#ifdef CONFIG_MODE_TT
+int copy_sc_from_user_tt(struct sigcontext *to, struct sigcontext *from, 
+			 int fpsize)
+{
+	struct _fpstate *to_fp, *from_fp;
+	unsigned long sigs;
+	int err;
+
+	to_fp = to->fpstate;
+	from_fp = from->fpstate;
+	sigs = to->oldmask;
+	err = copy_from_user(to, from, sizeof(*to));
+	to->oldmask = sigs;
+	if(to_fp != NULL){
+		err |= copy_from_user(&to->fpstate, &to_fp,
+				      sizeof(to->fpstate));
+		err |= copy_from_user(to_fp, from_fp, fpsize);
+	}
+	return(err);
+}
+
+int copy_sc_to_user_tt(struct sigcontext *to, struct _fpstate *fp, 
+		       struct sigcontext *from, int fpsize)
+{
+	struct _fpstate *to_fp, *from_fp;
+	int err;
+
+	to_fp =	(fp ? fp : (struct _fpstate *) (to + 1));
+	from_fp = from->fpstate;
+	err = copy_to_user(to, from, sizeof(*to));
+	if(from_fp != NULL){
+		err |= copy_to_user(&to->fpstate, &to_fp,
+					 sizeof(to->fpstate));
+		err |= copy_to_user(to_fp, from_fp, fpsize);
+	}
+	return(err);
+}
+#endif
+
+static int copy_sc_from_user(struct pt_regs *to, void *from)
+{
+	int ret;
+
+	ret = CHOOSE_MODE(copy_sc_from_user_tt(UPT_SC(&to->regs), from,
+					       sizeof(struct _fpstate)),
+			  copy_sc_from_user_skas(to, from));
+	return(ret);
+}
+
+static int copy_sc_to_user(struct sigcontext *to, struct _fpstate *fp, 
+			   struct pt_regs *from)
+{
+	return(CHOOSE_MODE(copy_sc_to_user_tt(to, fp, UPT_SC(&from->regs),
+					      sizeof(*fp)),
+			   copy_sc_to_user_skas(to, fp, from, 
+						current->thread.cr2,
+						current->thread.err)));
+}
+
+static int copy_ucontext_to_user(struct ucontext *uc, struct _fpstate *fp, 
+				 sigset_t *set, unsigned long sp)
+{
+	int err = 0;
+
+	err |= put_user(current->sas_ss_sp, &uc->uc_stack.ss_sp);
+	err |= put_user(sas_ss_flags(sp), &uc->uc_stack.ss_flags);
+	err |= put_user(current->sas_ss_size, &uc->uc_stack.ss_size);
+	err |= copy_sc_to_user(&uc->uc_mcontext, fp, &current->thread.regs);
+	err |= copy_to_user(&uc->uc_sigmask, set, sizeof(*set));
+	return(err);
+}
+
+struct sigframe
+{
+	char *pretcode;
+	int sig;
+	struct sigcontext sc;
+	struct _fpstate fpstate;
+	unsigned long extramask[_NSIG_WORDS-1];
+	char retcode[8];
+};
+
+struct rt_sigframe
+{
+	char *pretcode;
+	int sig;
+	struct siginfo *pinfo;
+	void *puc;
+	struct siginfo info;
+	struct ucontext uc;
+	struct _fpstate fpstate;
+	char retcode[8];
+};
+
+int setup_signal_stack_sc(unsigned long stack_top, int sig, 
+			  struct k_sigaction *ka, struct pt_regs *regs, 
+			  sigset_t *mask)
+{
+	struct sigframe __user *frame;
+	void *restorer;
+	int err = 0;
+
+	stack_top &= -8UL;
+	frame = (struct sigframe *) stack_top - 1;
+	if(verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
+		return(1);
+	
+	restorer = (void *) frame->retcode;
+	if(ka->sa.sa_flags & SA_RESTORER)
+		restorer = ka->sa.sa_restorer;
+
+	err |= __put_user(restorer, &frame->pretcode);
+	err |= __put_user(sig, &frame->sig);
+	err |= copy_sc_to_user(&frame->sc, NULL, regs);
+	err |= __put_user(mask->sig[0], &frame->sc.oldmask);
+	if (_NSIG_WORDS > 1)
+		err |= __copy_to_user(&frame->extramask, &mask->sig[1],
+				      sizeof(frame->extramask));
+
+	/*
+	 * This is movl $,%eax ; int $0x80
+	 *
+	 * WE DO NOT USE IT ANY MORE! It's only left here for historical
+	 * reasons and because gdb uses it as a signature to notice
+	 * signal handler stack frames.
+	 */
+	err |= __put_user(0xb8, (char __user *)(frame->retcode+0));
+	err |= __put_user(__NR_rt_sigreturn, (int __user *)(frame->retcode+1));
+	err |= __put_user(0x80cd, (short __user *)(frame->retcode+5));
+
+	if(err)
+		return(err);
+
+	PT_REGS_SP(regs) = (unsigned long) frame;
+	PT_REGS_IP(regs) = (unsigned long) ka->sa.sa_handler;
+	PT_REGS_EAX(regs) = (unsigned long) sig;
+	PT_REGS_EDX(regs) = (unsigned long) 0;
+	PT_REGS_ECX(regs) = (unsigned long) 0;
+	
+	if ((current->ptrace & PT_DTRACE) && (current->ptrace & PT_PTRACED))
+		ptrace_notify(SIGTRAP);
+	return(0);
+}
+
+int setup_signal_stack_si(unsigned long stack_top, int sig, 
+			  struct k_sigaction *ka, struct pt_regs *regs, 
+			  siginfo_t *info, sigset_t *mask)
+{
+	struct rt_sigframe __user *frame;
+	void *restorer;
+	int err = 0;
+
+	stack_top &= -8UL;
+	frame = (struct rt_sigframe *) stack_top - 1;
+	if(verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
+		return(1);
+	
+	restorer = (void *) frame->retcode;
+	if(ka->sa.sa_flags & SA_RESTORER)
+		restorer = ka->sa.sa_restorer;
+
+	err |= __put_user(restorer, &frame->pretcode);
+	err |= __put_user(sig, &frame->sig);
+	err |= __put_user(&frame->info, &frame->pinfo);
+	err |= __put_user(&frame->uc, &frame->puc);
+	err |= copy_siginfo_to_user(&frame->info, info);
+	err |= copy_ucontext_to_user(&frame->uc, &frame->fpstate, mask,
+				     PT_REGS_SP(regs));
+
+	/*
+	 * This is movl $,%eax ; int $0x80
+	 *
+	 * WE DO NOT USE IT ANY MORE! It's only left here for historical
+	 * reasons and because gdb uses it as a signature to notice
+	 * signal handler stack frames.
+	 */
+	err |= __put_user(0xb8, (char __user *)(frame->retcode+0));
+	err |= __put_user(__NR_rt_sigreturn, (int __user *)(frame->retcode+1));
+	err |= __put_user(0x80cd, (short __user *)(frame->retcode+5));
+
+	if(err)
+		return(err);
+
+	PT_REGS_SP(regs) = (unsigned long) frame;
+	PT_REGS_IP(regs) = (unsigned long) ka->sa.sa_handler;
+	PT_REGS_EAX(regs) = (unsigned long) sig;
+	PT_REGS_EDX(regs) = (unsigned long) &frame->info;
+	PT_REGS_ECX(regs) = (unsigned long) &frame->uc;
+
+	if ((current->ptrace & PT_DTRACE) && (current->ptrace & PT_PTRACED))
+		ptrace_notify(SIGTRAP);
+	return(0);
+}
+
+long sys_sigreturn(struct pt_regs regs)
+{
+	unsigned long __user sp = PT_REGS_SP(&current->thread.regs);
+	struct sigframe __user *frame = (struct sigframe *)(sp - 8);
+	struct sigcontext __user *sc = &frame->sc;
+	unsigned long __user *mask = &sc->oldmask;
+	int sig_size = (_NSIG_WORDS - 1) * sizeof(unsigned long);
+
+	spin_lock_irq(&current->sighand->siglock);
+	copy_from_user(&current->blocked.sig[0], mask,
+		       sizeof(current->blocked.sig[0]));
+	copy_from_user(&current->blocked.sig[1], mask, sig_size);
+	sigdelsetmask(&current->blocked, ~_BLOCKABLE);
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+	copy_sc_from_user(&current->thread.regs, sc);
+	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
+}
+
+long sys_rt_sigreturn(struct pt_regs regs)
+{
+	unsigned long __user sp = PT_REGS_SP(&current->thread.regs);
+	struct rt_sigframe __user *frame = (struct rt_sigframe *) (sp - 4);
+	struct ucontext __user *uc = &frame->uc;
+	int sig_size = _NSIG_WORDS * sizeof(unsigned long);
+
+	spin_lock_irq(&current->sighand->siglock);
+	copy_from_user(&current->blocked, &uc->uc_sigmask, sig_size);
+	sigdelsetmask(&current->blocked, ~_BLOCKABLE);
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+	copy_sc_from_user(&current->thread.regs, &uc->uc_mcontext);
+	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
+}
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */

