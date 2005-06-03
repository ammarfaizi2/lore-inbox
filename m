Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVFCRVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVFCRVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 13:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVFCRVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 13:21:54 -0400
Received: from mail.ccur.com ([208.248.32.212]:59639 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261402AbVFCRV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 13:21:28 -0400
Message-ID: <42A09190.8080703@ccur.com>
Date: Fri, 03 Jun 2005 13:21:20 -0400
From: John Blackwood <john.blackwood@ccur.com>
Reply-To: john.blackwood@ccur.com
Organization: Concurrent Computer Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.4) Gecko/20050318 Red Hat/1.4.4-1.3.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: roland@redhat.com, ak@suse.de, akpm@osdl.org, bugsy@ccur.com
Subject: [PATCH] ptrace(2) single-stepping into signal handlers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jun 2005 17:21:22.0797 (UTC) FILETIME=[A9FC71D0:01C56860]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The intent of this posting is to generate some discussion concerning
ptrace(2) single-step operations into user signal handlers.

When a ptraced process has done a debugger stop due to a pending signal
delivery, and this ptraced process has a corresponding signal handler,
recent linux kernels have changed the way that a subsequent single-step
operation is treated/processed.

Specifically, when a PTRACE_SINGLESTEP operation is executed at this
point, the kernel will now single-step to the first instruction in the
target process's signal handler.  Additional single-step calls will
let us single-step through the ptraced process's signal handler, and a
PTRACE_CONT call will cause the ptraced process to continue onward through
the entire signal handler and stop with a SIGTRAP signal once again
back at the original instruction where the original PTRACE_SINGLESTEP
call was made (this last stop point seems to exhibit a bug for the i386
architecture - see below for an explanation).

While being able to single-step through a ptraced process's signal
handler may be desirable sometimes, I would like to submit the notion
that usually, a user would like simply to single-step to the next
instruction in the main stream of execution.  That is to say, when the
single-step operation is issued, the user would like to execute the
signal handler, return back from the signal handler, and then stop at
the next instruction in the normal (non-signal) stream of execution.
Note that this described behavior is how previous linux kernels
handled single-step operations when the user had a signal pending with
a corresponding user signal handler.  The kernel did NOT previously step
into the signal handler, but would instead step to the next instruction
in the normal, main stream of execution.

As support for this preference, consider attempting to debug a program
that has setup a SIGALRM signal handler, and while you are attempting
to debug a stream of instructions by single-stepping through the code,
you constantly instead end up in the SIGALRM signal handler, and have
to set a breakpoint at the instruction that you actually wanted to
single-step to, and then 'continue' out of the SIGALARM signal handler.

Since some of us believe that single-stepping into a signal handler is
more of an extended feature as opposed to the usual behavior of stepping
to the next instruction in the normal stream of execution, I would like
to suggest/submit the following ideas for enhancing this particular area
of ptrace(2) support.

The enhancement ideas are:

1. Make the default behavior that we single-step to the next instruction
    in the main (non-signal handler) stream of execution, instead of
    single-stepping into the user's signal handler.

2. Add a new ptrace PTRACE_SETOPTIONS command flag,
    PTRACE_O_TRACESSTEPSIG.  When this new flag is set by the debugger,
    then execute the new behavior of single-stepping into the user's
    signal handler.  (Yes, this means that debuggers such as gdb will need
    to be taught about this new PTRACE_SETOPTIONS flag if the user wishes
    to single-step into their signal handler.)

3. When the PTRACE_O_TRACESSTEPSIG flag is set and the ptraced process
    single-steps to the first instruction in the signal handler and executes
    a SIGTRAP debugger stop, make it easier for the debugger to determine
    why the ptraced process stopped, by passing a new extended result code,
    PTRACE_EVENT_SSTEPSIG.

    This extended code will be returned in the status parameter location
    of a wait(2) style call, and the debugger can extract this additional
    information with the following pseudo code snippet:

        waitpid(-1, &wait_status, ...);
        if (WIFSTOPPED(wait_status)) {
            ret_sig = WSTOPSIG(wait_status);
            if ((wait_status >> 16) & 0xff) == PTRACE_EVENT_SSTEPSIG) {
                /* single stepped into a user signal handler */
            }
        }

In addition to the above suggestions for making the "single-step into
signal handlers" optional and easier to detect, I have also noticed a
bug in the current i386 implementation that I would like to mention.

The following sequence will cause the debugger to forever single step
the target process, even though the ptrace(2) PTRACE_CONT command is
being issued to the target process:

- The ptraced process has a pending signal and
   it stops to notify the debugger.

- The debugger then single-steps into the ptraced process's signal handler.

- On the next eventual continue (PTRACE_CONT) command, we run through the
   signal handler, and we stop once again at the next instruction before
   we changed our execution stream and single-stepped into the user's
   signal handler.

- At this point, we can no longer continue the ptraced process
   with a PTRACE_CONT command.  Instead, all ptrace(2) PTRACE_CONT calls
   are treated as if we had made a ptrace(2) PTRACE_SINGLESTEP call.


The reason for this behavior is due to the fact that:

- We saved off the eflags (with the TF bit set) in setup_sigcontext()
   before we single stepped into the user's signal handler.

- When we exit the user's signal handler via a PTRACE_CONT call,
   we restore the original eflags value (with the TF bit set) in the
   restore_sigcontext() routine.  However, at this point, the
   PT_DTRACE flag is no longer set.

- Subsequent ptrace(2) PTRACE_CONT calls will call
   clear_singlestep() to make sure that any single-step state is
   cleared out before we continue the ptrace process.

   However, since the PT_DTRACE flag is not set, we do NOT clear
   the TF bit in the eflags register stack location, and we
   instead end up doing a single-step operation.

   Also, if we do a PTRACE_SINGLESTEP operation at this point, to
   attempt to get out of this stuck state, the set_singlestep()
   routine will not set the PT_DTRACE flag since the TF flag
   is already set!

============================================================================

Below are some diffs for the changes described above.  These diffs are
only for i386 and x86_64 architectures, since these are the only ones
that I have access to, and have actually tested on.

The changes are:

- include/linux/ptrace.h
   Add the PTRACE_O_TRACESSTEPSIG, PTRACE_EVENT_SSTEPSIG, PT_TRACE_SSTEPSIG
   defines, and modify the appropriate masks.

- kernel/ptrace.c
   Process the new PTRACE_O_TRACESSTEPSIG flag in ptrace_setoptions().

- arch/i386/kernel/ptrace.c
   In clear_singlestep(), always clear TRAP_FLAG out of the eflags field,
   since PT_DTRACE will not be set if we just came out of a signal handler
   that we single-stepped into.   This particuar change is admittedly
   less than optimal, but it does work.

- arch/i386/kernel/signal.c
   In both setup_frame() and setup_rt_frame(), notify the debugger with
   a ptrace_notify() call only if the PT_TRACE_SSTEPSIG flag is set.
   Also, pass the PTRACE_EVENT_SSTEPSIG extended event/result code on
   the ptrace_notify() SIGTRAP call.  If PT_TRACE_SSTEPSIG is not set,
   then clear the TIF_SINGLESTEP flag since we do NOT want to single step
   anywhere within the signal handler.

- arch/x86_64/ia32/ia32_signal.c
   In ia32_setup_sigcontext(), do not clear the TF_MASK bit in eflags when
   saving eflags off to sigcontext.  This change lets us stop again at
   the next instruction in the normal execution stream after we continue
   out of single-stepping into the signal handler.  This change matches
   the i386 version.

   In ia32_setup_frame() and ia32_setup_rt_frame(), process the
   PT_TRACE_SSTEPSIG flag in the same fashion as the i386 version.

- arch/x86_64/kernel/signal.c
   In setup_sigcontext(), preserve the TF_MASK bit in eflags.

   In setup_rt_frame() process the PT_TRACE_SSTEPSIG flag just
   as the i386 version does.

============================================================================

diff -ru linux-2.6.11.10/include/linux/ptrace.h new/include/linux/ptrace.h
--- linux-2.6.11.10/include/linux/ptrace.h	2005-05-16 13:51:47.000000000 
-0400
+++ new/include/linux/ptrace.h	2005-06-02 16:47:46.000000000 -0400
@@ -35,8 +35,9 @@
  #define PTRACE_O_TRACEEXEC	0x00000010
  #define PTRACE_O_TRACEVFORKDONE	0x00000020
  #define PTRACE_O_TRACEEXIT	0x00000040
+#define PTRACE_O_TRACESSTEPSIG	0x00000080

-#define PTRACE_O_MASK		0x0000007f
+#define PTRACE_O_MASK		0x000000ff

  /* Wait extended result codes for the above trace options.  */
  #define PTRACE_EVENT_FORK	1
@@ -45,6 +46,7 @@
  #define PTRACE_EVENT_EXEC	4
  #define PTRACE_EVENT_VFORK_DONE	5
  #define PTRACE_EVENT_EXIT	6
+#define PTRACE_EVENT_SSTEPSIG	7

  #include <asm/ptrace.h>

@@ -64,8 +66,9 @@
  #define PT_TRACE_VFORK_DONE	0x00000100
  #define PT_TRACE_EXIT	0x00000200
  #define PT_ATTACHED	0x00000400	/* parent != real_parent */
+#define PT_TRACE_SSTEPSIG	0x00000800

-#define PT_TRACE_MASK	0x000003f4
+#define PT_TRACE_MASK	0x00000bf4

  /* single stepping state bits (used on ARM and PA-RISC) */
  #define PT_SINGLESTEP_BIT	31
diff -ru linux-2.6.11.10/kernel/ptrace.c new/kernel/ptrace.c
--- linux-2.6.11.10/kernel/ptrace.c	2005-05-16 13:51:53.000000000 -0400
+++ new/kernel/ptrace.c	2005-06-02 16:48:01.000000000 -0400
@@ -314,6 +314,9 @@
  	if (data & PTRACE_O_TRACEEXIT)
  		child->ptrace |= PT_TRACE_EXIT;

+	if (data & PTRACE_O_TRACESSTEPSIG)
+		child->ptrace |= PT_TRACE_SSTEPSIG;
+
  	return (data & ~PTRACE_O_MASK) ? -EINVAL : 0;
  }

diff -ru linux-2.6.11.10/arch/i386/kernel/ptrace.c 
new/arch/i386/kernel/ptrace.c
--- linux-2.6.11.10/arch/i386/kernel/ptrace.c	2005-05-16 
13:50:30.000000000 -0400
+++ new/arch/i386/kernel/ptrace.c	2005-06-02 16:49:12.000000000 -0400
@@ -250,15 +250,18 @@

  static void clear_singlestep(struct task_struct *child)
  {
+	struct pt_regs *regs = get_child_regs(child);
+
  	/* Always clear TIF_SINGLESTEP... */
  	clear_tsk_thread_flag(child, TIF_SINGLESTEP);

-	/* But touch TF only if it was set by us.. */
-	if (child->ptrace & PT_DTRACE) {
-		struct pt_regs *regs = get_child_regs(child);
-		regs->eflags &= ~TRAP_FLAG;
+	/* Clear PT_DTRACE if it is set.  Always clear TF
+	 * since it could be set from a restore_sigcontext()
+	 * signal handler return with PT_DTRACE not set.
+	 */
+	if (child->ptrace & PT_DTRACE)
  		child->ptrace &= ~PT_DTRACE;
-	}
+	regs->eflags &= ~TRAP_FLAG;
  }

  /*
diff -ru linux-2.6.11.10/arch/i386/kernel/signal.c 
new/arch/i386/kernel/signal.c
--- linux-2.6.11.10/arch/i386/kernel/signal.c	2005-05-16 
13:50:30.000000000 -0400
+++ new/arch/i386/kernel/signal.c	2005-06-03 11:14:40.293133119 -0400
@@ -414,15 +414,18 @@
  	regs->xss = __USER_DS;
  	regs->xcs = __USER_CS;

-	/*
-	 * Clear TF when entering the signal handler, but
-	 * notify any tracer that was single-stepping it.
-	 * The tracer may want to single-step inside the
-	 * handler too.
+	/* Clear TF when entering the signal handler, but notify any tracer
+	 * that was single-stepping if the PT_TRACE_SSTEPSIG flag is set.
+	 * Clear TIF_SINGLESTEP if PT_TRACE_SSTEPSIG is not set, since we
+	 * don't want to single-step through the signal handler in that case.
  	 */
  	regs->eflags &= ~TF_MASK;
-	if (test_thread_flag(TIF_SINGLESTEP))
-		ptrace_notify(SIGTRAP);
+	if (test_thread_flag(TIF_SINGLESTEP)) {
+	    if (current->ptrace & PT_TRACE_SSTEPSIG)
+		ptrace_notify((PTRACE_EVENT_SSTEPSIG << 8) | SIGTRAP);
+	    else
+		clear_thread_flag(TIF_SINGLESTEP);
+	}

  #if DEBUG_SIG
  	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
@@ -507,15 +510,18 @@
  	regs->xss = __USER_DS;
  	regs->xcs = __USER_CS;

-	/*
-	 * Clear TF when entering the signal handler, but
-	 * notify any tracer that was single-stepping it.
-	 * The tracer may want to single-step inside the
-	 * handler too.
+	/* Clear TF when entering the signal handler, but notify any tracer
+	 * that was single-stepping if the PT_TRACE_SSTEPSIG flag is set.
+	 * Clear TIF_SINGLESTEP if PT_TRACE_SSTEPSIG is not set, since we
+	 * don't want to single-step through the signal handler in that case.
  	 */
  	regs->eflags &= ~TF_MASK;
-	if (test_thread_flag(TIF_SINGLESTEP))
-		ptrace_notify(SIGTRAP);
+	if (test_thread_flag(TIF_SINGLESTEP)) {
+	    if (current->ptrace & PT_TRACE_SSTEPSIG)
+		ptrace_notify((PTRACE_EVENT_SSTEPSIG << 8) | SIGTRAP);
+	    else
+		clear_thread_flag(TIF_SINGLESTEP);
+	}

  #if DEBUG_SIG
  	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
diff -ru linux-2.6.11.10/arch/x86_64/ia32/ia32_signal.c 
new/arch/x86_64/ia32/ia32_signal.c
--- linux-2.6.11.10/arch/x86_64/ia32/ia32_signal.c	2005-05-16 
13:50:31.000000000 -0400
+++ new/arch/x86_64/ia32/ia32_signal.c	2005-06-03 11:08:33.728120866 -0400
@@ -351,7 +351,6 @@
  		 struct pt_regs *regs, unsigned int mask)
  {
  	int tmp, err = 0;
-	u32 eflags;

  	tmp = 0;
  	__asm__("movl %%gs,%0" : "=r"(tmp): "0"(tmp));
@@ -376,11 +375,7 @@
  	err |= __put_user(current->thread.trap_no, &sc->trapno);
  	err |= __put_user(current->thread.error_code, &sc->err);
  	err |= __put_user((u32)regs->rip, &sc->eip);
-	eflags = regs->eflags;
-	if (current->ptrace & PT_PTRACED) {
-		eflags &= ~TF_MASK;
-	}
-	err |= __put_user((u32)eflags, &sc->eflags);
+	err |= __put_user((u32)regs->eflags, &sc->eflags);
  	err |= __put_user((u32)regs->rsp, &sc->esp_at_signal);

  	tmp = save_i387_ia32(current, fpstate, regs, 0);
@@ -498,12 +493,18 @@
  	regs->ss = __USER32_DS;

  	set_fs(USER_DS);
-	if (regs->eflags & TF_MASK) {
-		if (current->ptrace & PT_PTRACED) {
-			ptrace_notify(SIGTRAP);
-		} else {
-			regs->eflags &= ~TF_MASK;
-		}
+
+	/* Clear TF when entering the signal handler, but notify any tracer
+	 * that was single-stepping if the PT_TRACE_SSTEPSIG flag is set.
+	 * Clear TIF_SINGLESTEP if PT_TRACE_SSTEPSIG is not set, since we
+	 * don't want to single-step through the signal handler in that case.
+	 */
+	regs->eflags &= ~TF_MASK;
+	if (test_thread_flag(TIF_SINGLESTEP)) {
+	    if (current->ptrace & PT_TRACE_SSTEPSIG)
+		ptrace_notify((PTRACE_EVENT_SSTEPSIG << 8) | SIGTRAP);
+	    else
+		clear_thread_flag(TIF_SINGLESTEP);
  	}

  #if DEBUG_SIG
@@ -598,12 +599,18 @@
  	regs->ss = __USER32_DS;

  	set_fs(USER_DS);
-	if (regs->eflags & TF_MASK) {
-		if (current->ptrace & PT_PTRACED) {
-			ptrace_notify(SIGTRAP);
-		} else {
-			regs->eflags &= ~TF_MASK;
-		}
+
+	/* Clear TF when entering the signal handler, but notify any tracer
+	 * that was single-stepping if the PT_TRACE_SSTEPSIG flag is set.
+	 * Clear TIF_SINGLESTEP if PT_TRACE_SSTEPSIG is not set, since we
+	 * don't want to single-step through the signal handler in that case.
+	 */
+	regs->eflags &= ~TF_MASK;
+	if (test_thread_flag(TIF_SINGLESTEP)) {
+	    if (current->ptrace & PT_TRACE_SSTEPSIG)
+		ptrace_notify((PTRACE_EVENT_SSTEPSIG << 8) | SIGTRAP);
+	    else
+		clear_thread_flag(TIF_SINGLESTEP);
  	}

  #if DEBUG_SIG
diff -ru linux-2.6.11.10/arch/x86_64/kernel/signal.c 
new/arch/x86_64/kernel/signal.c
--- linux-2.6.11.10/arch/x86_64/kernel/signal.c	2005-05-16 
13:50:31.000000000 -0400
+++ new/arch/x86_64/kernel/signal.c	2005-06-03 11:09:03.963991909 -0400
@@ -186,7 +186,6 @@
  setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs, 
unsigned long mask, struct task_struct *me)
  {
  	int err = 0;
-	unsigned long eflags;

  	err |= __put_user(0, &sc->gs);
  	err |= __put_user(0, &sc->fs);
@@ -210,11 +209,7 @@
  	err |= __put_user(me->thread.trap_no, &sc->trapno);
  	err |= __put_user(me->thread.error_code, &sc->err);
  	err |= __put_user(regs->rip, &sc->rip);
-	eflags = regs->eflags;
-	if (current->ptrace & PT_PTRACED) {
-		eflags &= ~TF_MASK;
-	}
-	err |= __put_user(eflags, &sc->eflags);
+	err |= __put_user(regs->eflags, &sc->eflags);
  	err |= __put_user(mask, &sc->oldmask);
  	err |= __put_user(me->thread.cr2, &sc->cr2);

@@ -329,12 +324,18 @@
  	regs->rsp = (unsigned long)frame;

  	set_fs(USER_DS);
-	if (regs->eflags & TF_MASK) {
-		if ((current->ptrace & (PT_PTRACED | PT_DTRACE)) == (PT_PTRACED | 
PT_DTRACE)) {
-			ptrace_notify(SIGTRAP);
-		} else {
-			regs->eflags &= ~TF_MASK;
-		}
+
+	/* Clear TF when entering the signal handler, but notify any tracer
+	 * that was single-stepping if the PT_TRACE_SSTEPSIG flag is set.
+	 * Clear TIF_SINGLESTEP if PT_TRACE_SSTEPSIG is not set, since we
+	 * don't want to single-step through the signal handler in that case.
+	 */
+	regs->eflags &= ~TF_MASK;
+	if (test_thread_flag(TIF_SINGLESTEP)) {
+	    if (current->ptrace & PT_TRACE_SSTEPSIG)
+		ptrace_notify((PTRACE_EVENT_SSTEPSIG << 8) | SIGTRAP);
+	    else
+		clear_thread_flag(TIF_SINGLESTEP);
  	}

  #ifdef DEBUG_SIG

