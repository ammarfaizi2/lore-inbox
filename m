Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbVH2SEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVH2SEu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVH2SEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:04:50 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:48796 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751218AbVH2SEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:04:48 -0400
Subject: [PATCH] convert signal handling of NODEFER to act like other Unix
	boxes. [take2]
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508290744460.3243@g5.osdl.org>
References: <Pine.LNX.4.58.0508281708040.3243@g5.osdl.org>
	 <1125313050.5611.11.camel@localhost.localdomain>
	 <1125317850.6496.7.camel@localhost> <43131AE9.7010802@gmail.com>
	 <Pine.LNX.4.58.0508290744460.3243@g5.osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 29 Aug 2005 14:04:31 -0400
Message-Id: <1125338671.5611.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for the repost, I forgot those magic words above the patch]

Linus,

This is the patch I sent earlier, and you said to send it soon after
2.6.13 is released. I just applied it on 2.6.13 and it it applies fine.
Again, I only tested this on the i386 since that is the only computer I
currently have.

If someone else would like to submit this patch too, and take full
credit for it feel free.  Keeps the blame from me ;-)

Description:

It has been reported that the way Linux handles NODEFER for signals is
not consistent with the way other Unix boxes handle it.  I've written a
program to test the behavior of how this flag affects signals and had
several reports from people who ran this on various Unix boxes,
confirming that Linux seems to be unique on the way this is handled.

The way NODEFER affects signals on other Unix boxes is as follows:

1) If NODEFER is set, other signals in sa_mask are still blocked.

2) If NODEFER is set and the signal is in sa_mask, then the signal is
still blocked. (Note: this is the behavior of all tested but Linux _and_
NetBSD 2.0 *).

The way NODEFER affects signals on Linux:

1) If NODEFER is set, other signals are _not_ blocked regardless of
sa_mask (Even NetBSD doesn't do this).

2) If NODEFER is set and the signal is in sa_mask, then the signal being
handled is not blocked.

The patch converts signal handling in all current Linux architectures to
the way most Unix boxes work.

Unix boxes that were tested:  DU4, AIX 5.2, Irix 6.5, NetBSD 2.0, SFU
3.5 on WinXP, AIX 5.3, Mac OSX, and of course Linux 2.6.13-rcX.

* NetBSD was the only other Unix to behave like Linux on point #2. The
main concern was brought up by point #1 which even NetBSD isn't like
Linux.  So with this patch, we leave NetBSD as the lonely one that
behaves differently here with #2.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff -urp linux-2.6.13-rc6-git4.orig/arch/alpha/kernel/signal.c linux-2.6.13-rc6-git4/arch/alpha/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/alpha/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/alpha/kernel/signal.c	2005-08-12 21:49:55.000000000 -0400
@@ -566,13 +566,12 @@ handle_signal(int sig, struct k_sigactio
 	if (ka->sa.sa_flags & SA_RESETHAND)
 		ka->sa.sa_handler = SIG_DFL;
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER)) 
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 static inline void
diff -urp linux-2.6.13-rc6-git4.orig/arch/arm/kernel/signal.c linux-2.6.13-rc6-git4/arch/arm/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/arm/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/arm/kernel/signal.c	2005-08-12 21:50:46.000000000 -0400
@@ -658,11 +658,12 @@ handle_signal(unsigned long sig, struct 
 	/*
 	 * Block the signal if we were unsuccessful.
 	 */
-	if (ret != 0 || !(ka->sa.sa_flags & SA_NODEFER)) {
+	if (ret != 0) {
 		spin_lock_irq(&tsk->sighand->siglock);
 		sigorsets(&tsk->blocked, &tsk->blocked,
 			  &ka->sa.sa_mask);
-		sigaddset(&tsk->blocked, sig);
+		if (!(ka->sa.sa_flags & SA_NODEFER))
+			sigaddset(&tsk->blocked, sig);
 		recalc_sigpending();
 		spin_unlock_irq(&tsk->sighand->siglock);
 	}
diff -urp linux-2.6.13-rc6-git4.orig/arch/arm26/kernel/signal.c linux-2.6.13-rc6-git4/arch/arm26/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/arm26/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/arm26/kernel/signal.c	2005-08-12 22:08:56.000000000 -0400
@@ -454,14 +454,13 @@ handle_signal(unsigned long sig, siginfo
 		if (ka->sa.sa_flags & SA_ONESHOT)
 			ka->sa.sa_handler = SIG_DFL;
 
-		if (!(ka->sa.sa_flags & SA_NODEFER)) {
-			spin_lock_irq(&tsk->sighand->siglock);
-			sigorsets(&tsk->blocked, &tsk->blocked,
-				  &ka->sa.sa_mask);
+		spin_lock_irq(&tsk->sighand->siglock);
+		sigorsets(&tsk->blocked, &tsk->blocked,
+			  &ka->sa.sa_mask);
+		if (!(ka->sa.sa_flags & SA_NODEFER))
 			sigaddset(&tsk->blocked, sig);
-			recalc_sigpending();
-			spin_unlock_irq(&tsk->sighand->siglock);
-		}
+		recalc_sigpending();
+		spin_unlock_irq(&tsk->sighand->siglock);
 		return;
 	}
 
diff -urp linux-2.6.13-rc6-git4.orig/arch/cris/arch-v10/kernel/signal.c linux-2.6.13-rc6-git4/arch/cris/arch-v10/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/cris/arch-v10/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/cris/arch-v10/kernel/signal.c	2005-08-12 21:51:53.000000000 -0400
@@ -517,13 +517,12 @@ handle_signal(int canrestart, unsigned l
 	if (ka->sa.sa_flags & SA_ONESHOT)
 		ka->sa.sa_handler = SIG_DFL;
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 /*
diff -urp linux-2.6.13-rc6-git4.orig/arch/cris/arch-v32/kernel/signal.c linux-2.6.13-rc6-git4/arch/cris/arch-v32/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/cris/arch-v32/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/cris/arch-v32/kernel/signal.c	2005-08-12 21:53:01.000000000 -0400
@@ -568,13 +568,12 @@ handle_signal(int canrestart, unsigned l
 	if (ka->sa.sa_flags & SA_ONESHOT)
 		ka->sa.sa_handler = SIG_DFL;
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 /*
diff -urp linux-2.6.13-rc6-git4.orig/arch/frv/kernel/signal.c linux-2.6.13-rc6-git4/arch/frv/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/frv/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/frv/kernel/signal.c	2005-08-12 21:53:19.000000000 -0400
@@ -506,13 +506,12 @@ static void handle_signal(unsigned long 
 	else
 		setup_frame(sig, ka, oldset, regs);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked, &current->blocked, &ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked, &current->blocked, &ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked, sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 } /* end handle_signal() */
 
 /*****************************************************************************/
diff -urp linux-2.6.13-rc6-git4.orig/arch/h8300/kernel/signal.c linux-2.6.13-rc6-git4/arch/h8300/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/h8300/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/h8300/kernel/signal.c	2005-08-12 21:53:43.000000000 -0400
@@ -488,13 +488,12 @@ handle_signal(unsigned long sig, siginfo
 	else
 		setup_frame(sig, ka, oldset, regs);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 /*
diff -urp linux-2.6.13-rc6-git4.orig/arch/i386/kernel/signal.c linux-2.6.13-rc6-git4/arch/i386/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/i386/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/i386/kernel/signal.c	2005-08-12 21:55:22.000000000 -0400
@@ -577,10 +577,11 @@ handle_signal(unsigned long sig, siginfo
 	else
 		ret = setup_frame(sig, ka, oldset, regs);
 
-	if (ret && !(ka->sa.sa_flags & SA_NODEFER)) {
+	if (ret) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
-		sigaddset(&current->blocked,sig);
+		if (!(ka->sa.sa_flags & SA_NODEFER))
+			sigaddset(&current->blocked,sig);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}
diff -urp linux-2.6.13-rc6-git4.orig/arch/ia64/kernel/signal.c linux-2.6.13-rc6-git4/arch/ia64/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/ia64/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/ia64/kernel/signal.c	2005-08-12 21:56:20.000000000 -0400
@@ -467,15 +467,12 @@ handle_signal (unsigned long sig, struct
 		if (!setup_frame(sig, ka, info, oldset, scr))
 			return 0;
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		{
-			sigorsets(&current->blocked, &current->blocked, &ka->sa.sa_mask);
-			sigaddset(&current->blocked, sig);
-			recalc_sigpending();
-		}
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked, &current->blocked, &ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
+		sigaddset(&current->blocked, sig);
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 	return 1;
 }
 
diff -urp linux-2.6.13-rc6-git4.orig/arch/m32r/kernel/signal.c linux-2.6.13-rc6-git4/arch/m32r/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/m32r/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/m32r/kernel/signal.c	2005-08-12 21:56:35.000000000 -0400
@@ -341,13 +341,12 @@ handle_signal(unsigned long sig, struct 
 	/* Set up the stack frame */
 	setup_rt_frame(sig, ka, info, oldset, regs);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 /*
diff -urp linux-2.6.13-rc6-git4.orig/arch/m68knommu/kernel/signal.c linux-2.6.13-rc6-git4/arch/m68knommu/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/m68knommu/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/m68knommu/kernel/signal.c	2005-08-12 21:59:41.000000000 -0400
@@ -732,13 +732,12 @@ handle_signal(int sig, struct k_sigactio
 	if (ka->sa.sa_flags & SA_ONESHOT)
 		ka->sa.sa_handler = SIG_DFL;
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 /*
diff -urp linux-2.6.13-rc6-git4.orig/arch/mips/kernel/irixsig.c linux-2.6.13-rc6-git4/arch/mips/kernel/irixsig.c
--- linux-2.6.13-rc6-git4.orig/arch/mips/kernel/irixsig.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/mips/kernel/irixsig.c	2005-08-12 22:00:09.000000000 -0400
@@ -155,13 +155,12 @@ static inline void handle_signal(unsigne
 	else
 		setup_irix_frame(ka, regs, sig, oldset);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 asmlinkage int do_irix_signal(sigset_t *oldset, struct pt_regs *regs)
diff -urp linux-2.6.13-rc6-git4.orig/arch/mips/kernel/signal32.c linux-2.6.13-rc6-git4/arch/mips/kernel/signal32.c
--- linux-2.6.13-rc6-git4.orig/arch/mips/kernel/signal32.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/mips/kernel/signal32.c	2005-08-12 22:00:40.000000000 -0400
@@ -751,13 +751,12 @@ static inline void handle_signal(unsigne
 	else
 		setup_frame(ka, regs, sig, oldset);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 int do_signal32(sigset_t *oldset, struct pt_regs *regs)
diff -urp linux-2.6.13-rc6-git4.orig/arch/mips/kernel/signal.c linux-2.6.13-rc6-git4/arch/mips/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/mips/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/mips/kernel/signal.c	2005-08-12 22:00:23.000000000 -0400
@@ -425,13 +425,12 @@ static inline void handle_signal(unsigne
 		setup_frame(ka, regs, sig, oldset);
 #endif
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 extern int do_signal32(sigset_t *oldset, struct pt_regs *regs);
diff -urp linux-2.6.13-rc6-git4.orig/arch/parisc/kernel/signal.c linux-2.6.13-rc6-git4/arch/parisc/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/parisc/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/parisc/kernel/signal.c	2005-08-12 22:01:00.000000000 -0400
@@ -517,13 +517,12 @@ handle_signal(unsigned long sig, siginfo
 	if (!setup_rt_frame(sig, ka, info, oldset, regs, in_syscall))
 		return 0;
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 	return 1;
 }
 
diff -urp linux-2.6.13-rc6-git4.orig/arch/ppc/kernel/signal.c linux-2.6.13-rc6-git4/arch/ppc/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/ppc/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/ppc/kernel/signal.c	2005-08-12 22:01:23.000000000 -0400
@@ -759,13 +759,12 @@ int do_signal(sigset_t *oldset, struct p
 	else
 		handle_signal(signr, &ka, &info, oldset, regs, newsp);
 
-	if (!(ka.sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka.sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka.sa.sa_mask);
+	if (!(ka.sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked, signr);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 
 	return 1;
 }
diff -urp linux-2.6.13-rc6-git4.orig/arch/ppc64/kernel/signal32.c linux-2.6.13-rc6-git4/arch/ppc64/kernel/signal32.c
--- linux-2.6.13-rc6-git4.orig/arch/ppc64/kernel/signal32.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/ppc64/kernel/signal32.c	2005-08-12 22:02:45.000000000 -0400
@@ -976,11 +976,12 @@ int do_signal32(sigset_t *oldset, struct
 	else
 		ret = handle_signal32(signr, &ka, &info, oldset, regs, newsp);
 
-	if (ret && !(ka.sa.sa_flags & SA_NODEFER)) {
+	if (ret) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked, &current->blocked,
 			  &ka.sa.sa_mask);
-		sigaddset(&current->blocked, signr);
+		if (!(ka.sa.sa_flags & SA_NODEFER))
+			sigaddset(&current->blocked, signr);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}
diff -urp linux-2.6.13-rc6-git4.orig/arch/ppc64/kernel/signal.c linux-2.6.13-rc6-git4/arch/ppc64/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/ppc64/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/ppc64/kernel/signal.c	2005-08-12 22:02:13.000000000 -0400
@@ -481,10 +481,11 @@ static int handle_signal(unsigned long s
 	/* Set up Signal Frame */
 	ret = setup_rt_frame(sig, ka, info, oldset, regs);
 
-	if (ret && !(ka->sa.sa_flags & SA_NODEFER)) {
+	if (ret) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked, &current->blocked, &ka->sa.sa_mask);
-		sigaddset(&current->blocked,sig);
+		if (!(ka->sa.sa_flags & SA_NODEFER))
+			sigaddset(&current->blocked,sig);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}
diff -urp linux-2.6.13-rc6-git4.orig/arch/s390/kernel/compat_signal.c linux-2.6.13-rc6-git4/arch/s390/kernel/compat_signal.c
--- linux-2.6.13-rc6-git4.orig/arch/s390/kernel/compat_signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/s390/kernel/compat_signal.c	2005-08-12 22:03:42.000000000 -0400
@@ -637,12 +637,11 @@ handle_signal32(unsigned long sig, struc
 	else
 		setup_frame32(sig, ka, oldset, regs);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
diff -urp linux-2.6.13-rc6-git4.orig/arch/s390/kernel/signal.c linux-2.6.13-rc6-git4/arch/s390/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/s390/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/s390/kernel/signal.c	2005-08-12 22:03:59.000000000 -0400
@@ -429,13 +429,12 @@ handle_signal(unsigned long sig, struct 
 	else
 		setup_frame(sig, ka, oldset, regs);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 /*
diff -urp linux-2.6.13-rc6-git4.orig/arch/sh/kernel/signal.c linux-2.6.13-rc6-git4/arch/sh/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/sh/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/sh/kernel/signal.c	2005-08-12 22:04:10.000000000 -0400
@@ -546,13 +546,12 @@ handle_signal(unsigned long sig, struct 
 	if (ka->sa.sa_flags & SA_ONESHOT)
 		ka->sa.sa_handler = SIG_DFL;
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 /*
diff -urp linux-2.6.13-rc6-git4.orig/arch/sh64/kernel/signal.c linux-2.6.13-rc6-git4/arch/sh64/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/sh64/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/sh64/kernel/signal.c	2005-08-12 22:04:47.000000000 -0400
@@ -664,13 +664,12 @@ handle_signal(unsigned long sig, siginfo
 	else
 		setup_frame(sig, ka, oldset, regs);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 /*
diff -urp linux-2.6.13-rc6-git4.orig/arch/sparc/kernel/signal.c linux-2.6.13-rc6-git4/arch/sparc/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/sparc/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/sparc/kernel/signal.c	2005-08-12 22:04:59.000000000 -0400
@@ -1034,13 +1034,12 @@ handle_signal(unsigned long signr, struc
 		else
 			setup_frame(&ka->sa, regs, signr, oldset, info);
 	}
-	if (!(ka->sa.sa_flags & SA_NOMASK)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NOMASK))
 		sigaddset(&current->blocked, signr);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 static inline void syscall_restart(unsigned long orig_i0, struct pt_regs *regs,
diff -urp linux-2.6.13-rc6-git4.orig/arch/sparc64/kernel/signal32.c linux-2.6.13-rc6-git4/arch/sparc64/kernel/signal32.c
--- linux-2.6.13-rc6-git4.orig/arch/sparc64/kernel/signal32.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/sparc64/kernel/signal32.c	2005-08-12 22:05:28.000000000 -0400
@@ -1325,13 +1325,12 @@ static inline void handle_signal32(unsig
 		else
 			setup_frame32(&ka->sa, regs, signr, oldset, info);
 	}
-	if (!(ka->sa.sa_flags & SA_NOMASK)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NOMASK))
 		sigaddset(&current->blocked,signr);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 static inline void syscall_restart32(unsigned long orig_i0, struct pt_regs *regs,
diff -urp linux-2.6.13-rc6-git4.orig/arch/sparc64/kernel/signal.c linux-2.6.13-rc6-git4/arch/sparc64/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/sparc64/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/sparc64/kernel/signal.c	2005-08-12 22:05:10.000000000 -0400
@@ -574,13 +574,12 @@ static inline void handle_signal(unsigne
 {
 	setup_rt_frame(ka, regs, signr, oldset,
 		       (ka->sa.sa_flags & SA_SIGINFO) ? info : NULL);
-	if (!(ka->sa.sa_flags & SA_NOMASK)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NOMASK))
 		sigaddset(&current->blocked,signr);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 static inline void syscall_restart(unsigned long orig_i0, struct pt_regs *regs,
diff -urp linux-2.6.13-rc6-git4.orig/arch/um/kernel/signal_kern.c linux-2.6.13-rc6-git4/arch/um/kernel/signal_kern.c
--- linux-2.6.13-rc6-git4.orig/arch/um/kernel/signal_kern.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/um/kernel/signal_kern.c	2005-08-12 22:06:31.000000000 -0400
@@ -87,12 +87,12 @@ static int handle_signal(struct pt_regs 
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 		force_sigsegv(signr, current);
-	}
-	else if(!(ka->sa.sa_flags & SA_NODEFER)){
+	} else {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked, &current->blocked, 
 			  &ka->sa.sa_mask);
-		sigaddset(&current->blocked, signr);
+		 if(!(ka->sa.sa_flags & SA_NODEFER))
+			sigaddset(&current->blocked, signr);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}
diff -urp linux-2.6.13-rc6-git4.orig/arch/v850/kernel/signal.c linux-2.6.13-rc6-git4/arch/v850/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/v850/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/v850/kernel/signal.c	2005-08-12 22:06:47.000000000 -0400
@@ -462,13 +462,12 @@ handle_signal(unsigned long sig, siginfo
 	else
 		setup_frame(sig, ka, oldset, regs);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 /*
diff -urp linux-2.6.13-rc6-git4.orig/arch/x86_64/kernel/signal.c linux-2.6.13-rc6-git4/arch/x86_64/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/x86_64/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/x86_64/kernel/signal.c	2005-08-12 22:07:44.000000000 -0400
@@ -394,10 +394,11 @@ handle_signal(unsigned long sig, siginfo
 #endif
 	ret = setup_rt_frame(sig, ka, info, oldset, regs);
 
-	if (ret && !(ka->sa.sa_flags & SA_NODEFER)) {
+	if (ret) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
-		sigaddset(&current->blocked,sig);
+		if (!(ka->sa.sa_flags & SA_NODEFER))
+			sigaddset(&current->blocked,sig);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}
diff -urp linux-2.6.13-rc6-git4.orig/arch/xtensa/kernel/signal.c linux-2.6.13-rc6-git4/arch/xtensa/kernel/signal.c
--- linux-2.6.13-rc6-git4.orig/arch/xtensa/kernel/signal.c	2005-08-12 21:28:32.000000000 -0400
+++ linux-2.6.13-rc6-git4/arch/xtensa/kernel/signal.c	2005-08-12 22:08:02.000000000 -0400
@@ -702,12 +702,11 @@ int do_signal(struct pt_regs *regs, sigs
 	if (ka.sa.sa_flags & SA_ONESHOT)
 		ka.sa.sa_handler = SIG_DFL;
 
-	if (!(ka.sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked, &current->blocked, &ka.sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked, &current->blocked, &ka.sa.sa_mask);
+	if (!(ka.sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked, signr);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 	return 1;
 }


