Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946029AbWBORJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946029AbWBORJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946030AbWBORJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:09:25 -0500
Received: from jade.aracnet.com ([216.99.193.136]:2525 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S1946029AbWBORJZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:09:25 -0500
Message-ID: <43F3603D.6060200@BitWagon.com>
Date: Wed, 15 Feb 2006 09:09:17 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] i386 rt_sigframe flexibility to virtualize signal delivery
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On i386, struct rt_sigframe and its entourage can be tweaked
to give user code more flexibility to virtualize the delivery of signals.
My existing virtualizations stopped working during the test releases
of Fedora Core 5 (kernel 2.6.15 with glibc-2.3.90.)  When I initiated
discussion on fedora-devel-list the response was, "Take this upstream."

The heart of the tweak can be seen in the prototype for a signal handler
when SA_SIGINFO is specified.  The current ["man 2 sigaction"]

   void handler(int signum, siginfo_t *pinfo, void *puc);

becomes

   void handler(int signum, siginfo_t *pinfo, struct ucontext *const puc);

where the third parameter puc is more strongly typed, and is both an input
to the handler, and an output from the handler.  This is similar to
"value result" as a parameter type in Pascal.  The full logical
extension would be:

   struct ucontext *handler(int, siginfo_t *, struct ucontext *puc);

where the required default would be "return puc;" which tells rt_sigreturn
where to get the register state.  However, that would break all existing
signal handlers.  Instead, using "struct ucontext *const puc" maintains
compatibility with "void *puc" by happy accident, taking advantage of
the calling convention, compiler implementation, and prevalent usage.

Naming the target type of the third parameter increases the documentation.
The existing "void *" hides information from implementors.  I believe
that "void *" was used by spec writers to mean, "pointer to architecture-
specific or ABI-specific structure containing machine state."  Naming
"struct ucontext *" is type-compatible with "void *".

Thus the changes to declarations only (against 2.6.15):

--- ./arch/i386/kernel/sigframe.h.orig	2006-01-02 19:21:10.000000000 -0800
+++ ./arch/i386/kernel/sigframe.h	2006-02-05 13:28:21.000000000 -0800
@@ -13,7 +13,9 @@
 	char __user *pretcode;
 	int sig;
 	struct siginfo __user *pinfo;
-	void __user *puc;
+	struct ucontext __user * /*const*/ puc;
+/* Use the pointers above (including puc->uc_mcontext.fpstate)
+   to access the data below.  */
 	struct siginfo info;
 	struct ucontext uc;
 	struct _fpstate fpstate;
--- ./include/asm-i386/signal.h.orig	2006-01-02 19:21:10.000000000 -0800
+++ ./include/asm-i386/signal.h	2006-02-09 10:40:20.000000000 -0800
@@ -136,7 +136,7 @@
 struct sigaction {
 	union {
 	  __sighandler_t _sa_handler;
-	  void (*_sa_sigaction)(int, struct siginfo *, void *);
+	  void (*_sa_sigaction)(int, struct siginfo *, void *const );
 	} _u;
 	sigset_t sa_mask;
 	unsigned long sa_flags;
--- ./arch/i386/kernel/asm-offsets.c.orig	2006-02-04 20:06:10.000000000 -0800
+++ ./arch/i386/kernel/asm-offsets.c	2006-02-05 13:22:34.000000000 -0800
@@ -57,6 +57,7 @@

 	OFFSET(EXEC_DOMAIN_handler, exec_domain, handler);
 	OFFSET(RT_SIGFRAME_sigcontext, rt_sigframe, uc.uc_mcontext);
+	OFFSET(UCONTEXT_sigcontext, ucontext, uc_mcontext);
 	BLANK();

 	OFFSET(pbe_address, pbe, address);


The change to the underlying runtime bits is:

--- ./arch/i386/kernel/vsyscall-sigreturn.S.orig	2006-01-02 19:21:10.000000000 -0800
+++ ./arch/i386/kernel/vsyscall-sigreturn.S	2006-02-05 16:13:37.000000000 -0800
@@ -128,15 +128,37 @@
 	   slightly less complicated than the above, since we don't
 	   modify the stack pointer in the process.  */

-	do_cfa_expr(RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_esp)
-	do_expr(0, RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_eax)
-	do_expr(1, RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_ecx)
-	do_expr(2, RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_edx)
-	do_expr(3, RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_ebx)
-	do_expr(5, RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_ebp)
-	do_expr(6, RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_esi)
-	do_expr(7, RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_edi)
-	do_expr(8, RT_SIGFRAME_sigcontext-4 + SIGCONTEXT_eip)
+#define do_rt_cfa_expr(offset)						\
+	.byte 0x0f;			/* DW_CFA_def_cfa_expression */	\
+	.uleb128 1f-0f;			/*   length */			\
+0:	.byte 0x74;			/*     DW_OP_breg4 (%esp) */	\
+	.sleb128 4*3 -4;		/*       offset to puc */	\
+	.byte 0x06;			/*     DW_OP_deref */		\
+	.byte 0x23;			/*     DW_OP_plus_uconst */	\
+	.uleb128 offset;		/*      offset */		\
+	.byte 0x06;			/*     DW_OP_deref */		\
+1:
+
+#define do_rt_expr(regno, offset)					\
+	.byte 0x10;			/* DW_CFA_expression */		\
+	.uleb128 regno;			/*   regno */			\
+	.uleb128 1f-0f;			/*   length */			\
+0:	.byte 0x74;			/*     DW_OP_breg4 (%esp) */	\
+	.sleb128 4*3 -4;		/*       offset to puc */	\
+	.byte 0x06;			/*     DW_OP_deref */		\
+	.byte 0x23;			/*     DW_OP_plus_uconst */	\
+	.uleb128 offset;		/*       offset */		\
+1:
+
+	do_rt_cfa_expr(UCONTEXT_sigcontext + SIGCONTEXT_esp)
+	do_rt_expr(0, UCONTEXT_sigcontext + SIGCONTEXT_eax)
+	do_rt_expr(1, UCONTEXT_sigcontext + SIGCONTEXT_ecx)
+	do_rt_expr(2, UCONTEXT_sigcontext + SIGCONTEXT_edx)
+	do_rt_expr(3, UCONTEXT_sigcontext + SIGCONTEXT_ebx)
+	do_rt_expr(5, UCONTEXT_sigcontext + SIGCONTEXT_ebp)
+	do_rt_expr(6, UCONTEXT_sigcontext + SIGCONTEXT_esi)
+	do_rt_expr(7, UCONTEXT_sigcontext + SIGCONTEXT_edi)
+	do_rt_expr(8, UCONTEXT_sigcontext + SIGCONTEXT_eip)

 	.align 4
 .LENDFDEDLSI2:


Here the dwarf2 unwind information for the signal handling frame has an
additional indirection for each item.  The state in struct ucontext is
accessed through the third parameter to the handler, instead of by
reckoning the offset to the hidden struct from the beginning of the frame.
This allows a virtualizer to move the handler-visible part of the frame yet
still allow unwinding to work when thread kill cancels pthread_cond_wait().

The change allows a virtualizer to store state info in the middle
of struct rt_sigframe:
	struct rt_sigframe {
		void *pretcode;
		int signum;
		siginfo_t *pinfo;
		struct ucontext *const puc;
	    /* any amount of additional space >here< */
		siginfo_t info;
		struct ucontext uc;
		fpstate_t fpstate;
	};
because the pointers at the beginning, the ones in the prototype for
the handler interface, still are valid.  Moving the initial pointers
is simpler and faster than moving the structs and updating
all the pointers (including those inside uc.)

The above changes to the vDSO allow signal unwinding to work in the
presence of virtualization that splits rt_sigframe.  My virtualizations
unsplit rt_sigframe on return, so the kernel's rt_sigreturn from
the top-level handler currently sees no difference.  In order to allow
rt_sigreturn from somewhere other than the top-level handler, then
rt_sigreturn itself must also retrieve state information indirectly
through the result parameter:

--- ./arch/i386/kernel/signal.c.orig	2006-02-06 08:06:44.000000000 -0800
+++ ./arch/i386/kernel/signal.c	2006-02-06 08:06:45.000000000 -0800
@@ -240,12 +240,15 @@
 {
 	struct pt_regs *regs = (struct pt_regs *) &__unused;
 	struct rt_sigframe __user *frame = (struct rt_sigframe __user *)(regs->esp - 4);
+	struct ucontext __user *puc;
 	sigset_t set;
 	int eax;

-	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
+	if (__get_user(puc, &frame->puc))
 		goto badframe;
-	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
+	if (!access_ok(VERIFY_READ, puc, sizeof(*puc)))
+		goto badframe;
+	if (__copy_from_user(&set, &puc->uc_sigmask, sizeof(set)))
 		goto badframe;

 	sigdelsetmask(&set, ~_BLOCKABLE);
@@ -254,10 +257,10 @@
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 	
-	if (restore_sigcontext(regs, &frame->uc.uc_mcontext, &eax))
+	if (restore_sigcontext(regs, &puc->uc_mcontext, &eax))
 		goto badframe;

-	if (do_sigaltstack(&frame->uc.uc_stack, NULL, regs->esp) == -EFAULT)
+	if (do_sigaltstack(&puc->uc_stack, NULL, regs->esp) == -EFAULT)
 		goto badframe;

 	return eax;


The cost of the change to vsyscall-sigreturn.S is two bytes of space
and one additional indirection when unwinding, for each of ten items.
There are hundreds of unused bytes on the vDSO page.  The indirection
is inexpensive and is on a path with very low usage.  The cost of the
change to signal.c is the additional indirection on return from signal
handler.  Some error conditions are detected in different places,
but all user-visible results are the same as before.  The change to the
prototype for a signal handler when SA_SIGINFO is specified, requires
the user to add 'const' to the declaration.  Until this is done, there is
a type mismatch that is a bug.  It happens to work in practice because
of stylized usage that already is const without the enforcing declaration.

Signed off by: John Reiser <jreiser@BitWagon.com>

-- 
