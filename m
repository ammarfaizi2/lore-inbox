Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbULGBSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbULGBSF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 20:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbULGBSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 20:18:05 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:64668 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261534AbULGBRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 20:17:34 -0500
Message-ID: <41B504AC.9090308@acm.org>
Date: Mon, 06 Dec 2004 19:17:32 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch] PPC debug setcontext syscall implementation.
Content-Type: multipart/mixed;
 boundary="------------020500040008040901030305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020500040008040901030305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

A syscall has been reserved for a debug setcontext for PPC, but it has 
not yet been added.  This patch adds that function.  This syscall allows 
signal handlers to perform debug functions.  It allows the signal 
handler to turn on single-stepping, for instance, and the thread will 
get a trap after executing the next instruction.  It can also (on 
supported PPC processors) turn on branch tracing and get a trap after 
the next branch instruction is executed.  This is useful for 
in-application debugging.

A patch and a small demonstration program is attached.

This has been posted on linux-ppc and it seems to be ok with them.  I 
have tested gdb with this patch and it was not broken (any more than 
before), both on classic and Book E PowerPC.

-Corey

--------------020500040008040901030305
Content-Type: text/plain;
 name="ppc_debug_setcontext"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc_debug_setcontext"

Add a debugging interface for PowerPC that allows signal handlers (or any
jump to a context, really) to perform debug functions.  It allows the
a user program to turn on single-stepping, for instance, and the thread
will get a trap after executing the next instruction.  It can also
(on supported PPC processors) turn on branch tracing and get a trap after
the next branch instruction is executed.  This is useful for in-application
debugging.

Note that you can enable single-stepping on x86 processors directly
from signal handlers.  Newer x86 processors have the equivalent of
a branch-trace bit in the IA32_DEBUGCTL MSR and could have similar
function to this syscall.  Most other processors could benefit from
a similar interface, except for ARM which is extraordinarily broken
for debugging.

Future uses of this could be adding the ability to set the hardware
breakpoint registers from a signal handler.

Signed-off-by: Corey Minyard <minyard@mvista.com>

Index: arch/ppc/kernel/entry.S
===================================================================
--- arch/ppc/kernel/entry.S.orig	2004-10-25 08:08:32.000000000 -0500
+++ arch/ppc/kernel/entry.S	2004-12-01 09:04:40.000000000 -0600
@@ -111,8 +111,10 @@
 	addi	r11,r1,STACK_FRAME_OVERHEAD
 	stw	r11,PT_REGS(r12)
 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
-	lwz	r12,PTRACE-THREAD(r12)
-	andi.	r12,r12,PT_PTRACED
+	/* Check to see if the dbcr0 register is set up to debug.  Use the
+	   single-step bit to do this. */
+	lwz	r12,THREAD_DBCR0(r12)
+	andis.	r12,r12,DBCR0_IC@h
 	beq+	3f
 	/* From user and task is ptraced - load up global dbcr0 */
 	li	r12,-1			/* clear all pending debug events */
@@ -242,9 +244,10 @@
 	bne-	syscall_exit_work
 syscall_exit_cont:
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-	/* If the process has its own DBCR0 value, load it up */
-	lwz	r0,PTRACE(r2)
-	andi.	r0,r0,PT_PTRACED
+	/* If the process has its own DBCR0 value, load it up.  The single
+	   step bit tells us that dbcr0 should be loaded. */
+	lwz	r0,THREAD+THREAD_DBCR0(r2)
+	andis.	r10,r0,DBCR0_IC@h
 	bnel-	load_dbcr0
 #endif
 	stwcx.	r0,0,r1			/* to clear the reservation */
@@ -599,9 +602,10 @@
 
 restore_user:
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-	/* Check whether this process has its own DBCR0 value */
-	lwz	r0,PTRACE(r2)
-	andi.	r0,r0,PT_PTRACED
+	/* Check whether this process has its own DBCR0 value.  The single
+	   step bit tells us that dbcr0 should be loaded. */
+	lwz	r0,THREAD+THREAD_DBCR0(r2)
+	andis.	r10,r0,DBCR0_IC@h
 	bnel-	load_dbcr0
 #endif
 
@@ -876,17 +880,17 @@
 
 /*
  * Load the DBCR0 value for a task that is being ptraced,
- * having first saved away the global DBCR0.
+ * having first saved away the global DBCR0.  Note that r0
+ * has the dbcr0 value to set upon entry to this.
  */
 load_dbcr0:
-	mfmsr	r0		/* first disable debug exceptions */
-	rlwinm	r0,r0,0,~MSR_DE
-	mtmsr	r0
+	mfmsr	r10		/* first disable debug exceptions */
+	rlwinm	r10,r10,0,~MSR_DE
+	mtmsr	r10
 	isync
 	mfspr	r10,SPRN_DBCR0
 	lis	r11,global_dbcr0@ha
 	addi	r11,r11,global_dbcr0@l
-	lwz	r0,THREAD+THREAD_DBCR0(r2)
 	stw	r10,0(r11)
 	mtspr	SPRN_DBCR0,r0
 	lwz	r10,4(r11)
Index: arch/ppc/kernel/misc.S
===================================================================
--- arch/ppc/kernel/misc.S.orig	2004-12-01 08:59:37.000000000 -0600
+++ arch/ppc/kernel/misc.S	2004-12-01 09:04:40.000000000 -0600
@@ -1434,7 +1434,7 @@
 	.long sys_fstatfs64
 	.long ppc_fadvise64_64
 	.long sys_ni_syscall		/* 255 - rtas (used on ppc64) */
-	.long sys_ni_syscall		/* 256 reserved for sys_debug_setcontext */
+	.long sys_debug_setcontext
 	.long sys_ni_syscall		/* 257 reserved for vserver */
 	.long sys_ni_syscall		/* 258 reserved for new sys_remap_file_pages */
 	.long sys_ni_syscall		/* 259 reserved for new sys_mbind */
Index: arch/ppc/kernel/signal.c
===================================================================
--- arch/ppc/kernel/signal.c.orig	2004-12-01 08:49:25.000000000 -0600
+++ arch/ppc/kernel/signal.c	2004-12-01 09:04:40.000000000 -0600
@@ -509,6 +509,96 @@
 	return 0;
 }
 
+int sys_debug_setcontext(struct ucontext __user *ctx,
+			 int ndbg, struct sig_dbg_op *dbg,
+			 int r6, int r7, int r8,
+			 struct pt_regs *regs)
+{
+	struct sig_dbg_op op;
+	int i;
+	unsigned long new_msr = regs->msr;
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+	unsigned long new_dbcr0 = current->thread.dbcr0;
+#endif
+
+	for (i=0; i<ndbg; i++) {
+		if (__copy_from_user(&op, dbg, sizeof(op)))
+			return -EFAULT;
+		switch (op.dbg_type) {
+		case SIG_DBG_SINGLE_STEPPING:
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+			if (op.dbg_value) {
+				new_msr |= MSR_DE;
+				new_dbcr0 |= (DBCR0_IDM | DBCR0_IC);
+			} else {
+				new_msr &= ~MSR_DE;
+				new_dbcr0 &= ~(DBCR0_IDM | DBCR0_IC);
+			}
+#else
+			if (op.dbg_value)
+				new_msr |= MSR_SE;
+			else
+				new_msr &= ~MSR_SE;
+#endif
+			break;
+		case SIG_DBG_BRANCH_TRACING:
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+			return -EINVAL;
+#else
+			if (op.dbg_value)
+				new_msr |= MSR_BE;
+			else
+				new_msr &= ~MSR_BE;
+#endif
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	}
+
+	/* We wait until here to actually install the values in the
+	   registers so if we fail in the above loop, it will not
+	   affect the contents of these registers.  After this point,
+	   failure is a problem, anyway, and it's very unlikely unless
+	   the user is really doing something wrong. */
+	regs->msr = new_msr;
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+	current->thread.dbcr0 = new_dbcr0;
+#endif
+
+	/*
+	 * If we get a fault copying the context into the kernel's
+	 * image of the user's registers, we can't just return -EFAULT
+	 * because the user's registers will be corrupted.  For instance
+	 * the NIP value may have been updated but not some of the
+	 * other registers.  Given that we have done the verify_area
+	 * and successfully read the first and last bytes of the region
+	 * above, this should only happen in an out-of-memory situation
+	 * or if another thread unmaps the region containing the context.
+	 * We kill the task with a SIGSEGV in this situation.
+	 */
+	if (do_setcontext(ctx, regs, 1)) {
+		force_sig(SIGSEGV, current);
+		goto out;
+	}
+
+	/*
+	 * It's not clear whether or why it is desirable to save the
+	 * sigaltstack setting on signal delivery and restore it on
+	 * signal return.  But other architectures do this and we have
+	 * always done it up until now so it is probably better not to
+	 * change it.  -- paulus
+	 */
+	do_sigaltstack(&ctx->uc_stack, NULL, regs->gpr[1]);
+
+	sigreturn_exit(regs);
+	/* doesn't actually return back to here */
+
+ out:
+	return 0;
+}
+
 /*
  * OK, we're invoking a handler
  */
Index: arch/ppc/kernel/traps.c
===================================================================
--- arch/ppc/kernel/traps.c.orig	2004-12-01 08:49:25.000000000 -0600
+++ arch/ppc/kernel/traps.c	2004-12-01 09:04:40.000000000 -0600
@@ -566,7 +566,7 @@
 
 void SingleStepException(struct pt_regs *regs)
 {
-	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
+	regs->msr &= ~(MSR_SE | MSR_BE);  /* Turn off 'trace' bits */
 	if (debugger_sstep(regs))
 		return;
 	_exception(SIGTRAP, regs, TRAP_TRACE, 0);
Index: include/asm-ppc/signal.h
===================================================================
--- include/asm-ppc/signal.h.orig	2004-08-18 08:40:22.000000000 -0500
+++ include/asm-ppc/signal.h	2004-12-01 09:04:40.000000000 -0600
@@ -157,4 +157,23 @@
 #define ptrace_signal_deliver(regs, cookie) do { } while (0)
 #endif /* __KERNEL__ */
 
+/*
+ * These are parameters to dbg_sigreturn syscall.  They enable or
+ * disable certain debugging things that can be done from signal
+ * handlers.  The dbg_sigreturn syscall *must* be called from a
+ * SA_SIGINFO signal so the ucontext can be passed to it.  It takes an
+ * array of struct sig_dbg_op, which has the debug operations to
+ * perform before returning from the signal.
+ */
+struct sig_dbg_op {
+	int dbg_type;
+	unsigned long dbg_value;
+};
+
+/* Enable or disable single-stepping.  The value sets the state. */
+#define SIG_DBG_SINGLE_STEPPING		1
+
+/* Enable or disable branch tracing.  The value sets the state. */
+#define SIG_DBG_BRANCH_TRACING		2
+
 #endif
Index: include/asm-ppc/unistd.h
===================================================================
--- include/asm-ppc/unistd.h.orig	2004-12-01 08:59:57.000000000 -0600
+++ include/asm-ppc/unistd.h	2004-12-01 09:04:40.000000000 -0600
@@ -260,7 +260,7 @@
 #define __NR_fstatfs64		253
 #define __NR_fadvise64_64	254
 #define __NR_rtas		255
-/* Number 256 is reserved for sys_debug_setcontext */
+#define __NR_sys_debug_setcontext 256
 /* Number 257 is reserved for vserver */
 /* Number 258 is reserved for new sys_remap_file_pages */
 /* Number 259 is reserved for new sys_mbind */

--------------020500040008040901030305
Content-Type: text/plain;
 name="test_dbg_setcontext.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_dbg_setcontext.c"


#include <signal.h>
#include <stdio.h>
#include <errno.h>
#include <sys/mman.h>
#include <asm/unistd.h>

struct my_sig_dbg_op {
	int dbg_type;
	unsigned long dbg_value;
};

/* Enable or disable single-stepping.  The value sets the state. */
#define MY_SIG_DBG_SINGLE_STEPPING		1

/* Enable or disable branch tracing.  The value sets the state. */
#define MY_SIG_DBG_BRANCH_TRACING		2

#ifndef __NR_dbg_sigreturn
#define __NR_dbg_sigreturn 256
#endif

/* Create the debug return syscall. */
_syscall3(int, dbg_sigreturn,
	  void *, ucontext,
	  int,    ndbg,
	  struct my_sig_dbg_op *, op);


volatile int called = 0;
volatile int called2 = 0;
volatile int called3 = 0;
volatile int trap_called = 0;

void sighand(int sig, siginfo_t *info, void *ucontext)
{
	struct my_sig_dbg_op op;

	called++;

	kill(getpid(), SIGUSR2);

	op.dbg_type = MY_SIG_DBG_SINGLE_STEPPING;
	op.dbg_value = 1;
	dbg_sigreturn(ucontext, 1, &op);
}

void sighand2(int sig, siginfo_t *info, void *ucontext)
{
	kill(getpid(), SIGPWR);
	called2++;
}

void sighand3(int sig, siginfo_t *info, void *ucontext)
{
	struct my_sig_dbg_op op;
	called3++;

	op.dbg_type = MY_SIG_DBG_SINGLE_STEPPING;
	op.dbg_value = 1;
	dbg_sigreturn(ucontext, 1, &op);
}

#define PAGE_SIZE 4096
#define TO_PAGEBASE(a) (((unsigned int) (a)) & (~(PAGE_SIZE-1)))
#define TRAP_INSTRUCTION  0x0ce00097

static int
write_instruction(unsigned char *address,
		  unsigned long new_instr,
		  unsigned long *old_instr)
{
	char         *pagebase = (char *) TO_PAGEBASE(address);

	/* FIXME - currently assuming read-only executable memory, need a
	   way to fetch the old memory protection. */
	if (mprotect(pagebase,
		     PAGE_SIZE,
		     PROT_READ | PROT_WRITE | PROT_EXEC) != 0) {
		/* Couldn't change memory protection, return an error */
		return -1;
	}

	if (old_instr)
		*old_instr = *((volatile unsigned long *) address);

	*((volatile unsigned long *) address) = new_instr;

	mprotect(pagebase, PAGE_SIZE, PROT_READ | PROT_EXEC);

	/* Flush the cache for the instruction. */
	__asm__ ("dcbst 0,%0\n\ticbi 0,%0" : : "r" (address));

	return 0;
}

unsigned char *instr_addr;
unsigned long old_instr;
int restore = 0;
int tracing = 0;

/* The "old" ucontext. */
struct old_sigcontext_struct {
	unsigned long	_unused[4];
	int		signal;
	unsigned long	handler;
	unsigned long	oldmask;
	struct pt_regs 	*regs;
};
struct old_ucontext {
	unsigned long	  uc_flags;
	struct ucontext  *uc_link;
	stack_t		  uc_stack;
	struct sigcontext_struct uc_mcontext;
	sigset_t	  uc_sigmask;	/* mask last for extensibility */
};

unsigned long
dbg_get_instruction_ptr_from_ucontext(void *ucontext)
{
    struct old_ucontext *uc = ucontext;
    struct pt_regs      *regs = uc->uc_mcontext.regs;
    return regs->nip;
}

void sigtrap(int sig, siginfo_t *info, void *ucontext)
{
	int old_errno = errno;
	trap_called++;
	if (restore) {
		write_instruction(instr_addr, old_instr, NULL);
		restore = 0;
	}
	if (tracing) {
		char buf[100];
		sprintf(buf, "Trap at %8.8x\n", dbg_get_instruction_ptr_from_ucontext(ucontext));
		write(2, buf, strlen(buf));
		if (trap_called > 20)
			tracing = 0;
		else {
			struct my_sig_dbg_op op;
			errno = old_errno;

			op.dbg_type = MY_SIG_DBG_BRANCH_TRACING;
			op.dbg_value = 1;
			dbg_sigreturn(ucontext, 1, &op);
		}
	}
	errno = old_errno;
}

void call_printf(void)
{
	printf("test\n");
}

int main(int argc, char *argv)
{
	struct sigaction act;
	int rv;

	act.sa_sigaction = sighand;
	act.sa_flags = SA_SIGINFO;
	sigemptyset(&act.sa_mask);
	sigaddset(&act.sa_mask, SIGUSR2);
	rv = sigaction(SIGUSR1, &act, NULL);
	if (rv == -1) {
		perror("sigaction");
		exit(1);
	}

	act.sa_sigaction = sighand2;
	rv = sigaction(SIGUSR2, &act, NULL);
	if (rv == -1) {
		perror("sigaction");
		exit(1);
	}

	act.sa_sigaction = sighand3;
	rv = sigaction(SIGPWR, &act, NULL);
	if (rv == -1) {
		perror("sigaction");
		exit(1);
	}

	act.sa_sigaction = sigtrap;
	rv = sigaction(SIGTRAP, &act, NULL);
	if (rv == -1) {
		perror("sigaction");
		exit(1);
	}

	kill(getpid(), SIGUSR1);

	if (!called)
		printf("Didn't get called\n");
	else
		printf("Got called %d times\n", called);

	if (!called2)
		printf("Didn't get called 2\n");
	else
		printf("Got called 2 %d times\n", called2);

	if (!called3)
		printf("Didn't get called 3\n");
	else
		printf("Got called 3 %d times\n", called3);

	if (!trap_called) {
		printf("ERROR: Didn't get trapped\n");
		exit(1);
	} else
		printf("Got trapped %d times\n", trap_called);

	instr_addr = (unsigned char *) call_printf;

	write_instruction(instr_addr, TRAP_INSTRUCTION, &old_instr);
	restore = 1;
	tracing = 1;
	call_printf();

	exit(0);
}

--------------020500040008040901030305--
