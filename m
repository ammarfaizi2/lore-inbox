Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbWBNUwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbWBNUwc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 15:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbWBNUwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 15:52:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63658 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030428AbWBNUwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 15:52:32 -0500
Date: Tue, 14 Feb 2006 12:52:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paulo Marques <pmarques@grupopie.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Trap flag handling change in 2.6.10-bk5 broke Kylix debugger
In-Reply-To: <43F23BB4.8070703@grupopie.com>
Message-ID: <Pine.LNX.4.64.0602141243020.3691@g5.osdl.org>
References: <43F23BB4.8070703@grupopie.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Feb 2006, Paulo Marques wrote:
> 
> Anyway, using the awesome magical power of blind "hand patching", I tried to
> revert this from the 2.6.16-rc3 kernel, but my powers have let me down this
> time :(
> 
> Alas, the current kernel is very different from the 2.6.10 version and I don't
> understand this code enough to be able to modify it. (I did try it anyway,
> without success: the debugger still hung).

It does sound like the Kylix debugger depended very tightly on some very 
specific old implementation issue. I don't see quite what it could be (gdb 
didn't really care, for example), but yes, semantics _did_ change.

With the new semantics, the process doesn't see that it's being debugged 
any more because the TF flag change is now hidden from the signal stack. 
That indirectly also means that the debugger itself only sees TF change in 
the register state if the process itself set it (not if the TF bit was set 
implicitly by the debugger asking for a singlestep event).

The new semantics are really bug-fixes, and actually made it possible to 
debug things that weren't really possible to debug before. And you had to 
do some pretty strange things for them to matter to the debugger, but 
apparently Kylix does exactly that ;(

> Before I start moving in that direction is there someone who can give me an
> hint about what might be happening and suggest patches to test, etc.?

Hmm. You could try variations on the appended patch. Try changing the 
"#if 0" to "#if 1" in various combinations, to see which one Kylix seems 
to care about.

		Linus

---
diff --git a/arch/i386/kernel/signal.c b/arch/i386/kernel/signal.c
index 963616d..8f403bd 100644
--- a/arch/i386/kernel/signal.c
+++ b/arch/i386/kernel/signal.c
@@ -384,6 +384,7 @@ static int setup_frame(int sig, struct k
 	regs->xss = __USER_DS;
 	regs->xcs = __USER_CS;
 
+#if 0
 	/*
 	 * Clear TF when entering the signal handler, but
 	 * notify any tracer that was single-stepping it.
@@ -393,6 +394,7 @@ static int setup_frame(int sig, struct k
 	regs->eflags &= ~TF_MASK;
 	if (test_thread_flag(TIF_SINGLESTEP))
 		ptrace_notify(SIGTRAP);
+#endif
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
@@ -478,6 +480,7 @@ static int setup_rt_frame(int sig, struc
 	regs->xss = __USER_DS;
 	regs->xcs = __USER_CS;
 
+#if 0
 	/*
 	 * Clear TF when entering the signal handler, but
 	 * notify any tracer that was single-stepping it.
@@ -487,6 +490,7 @@ static int setup_rt_frame(int sig, struc
 	regs->eflags &= ~TF_MASK;
 	if (test_thread_flag(TIF_SINGLESTEP))
 		ptrace_notify(SIGTRAP);
+#endif
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
@@ -531,6 +535,7 @@ handle_signal(unsigned long sig, siginfo
 		}
 	}
 
+#if 0
 	/*
 	 * If TF is set due to a debugger (PT_DTRACE), clear the TF flag so
 	 * that register information in the sigcontext is correct.
@@ -540,6 +545,7 @@ handle_signal(unsigned long sig, siginfo
 		current->ptrace &= ~PT_DTRACE;
 		regs->eflags &= ~TF_MASK;
 	}
+#endif
 
 	/* Set up the stack frame */
 	if (ka->sa.sa_flags & SA_SIGINFO)
