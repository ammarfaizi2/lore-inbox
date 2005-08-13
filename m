Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVHMCkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVHMCkw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 22:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbVHMCkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 22:40:52 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:56265 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750836AbVHMCkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 22:40:51 -0400
Subject: [PATCH] Convert sigaction to act like other unices
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: rmk@arm.linux.org.uk, ak@suse.de, gerg@uclinux.org, jdike@karaya.com,
       sammy@sammy.net, lethal@linux-sh.org, wli@holomorphy.com,
       davem@davemloft.net, matthew@wil.cx, geert@linux-m68k.org,
       paulus@samba.org, davej@codemonkey.org.uk, tony.luck@intel.com,
       dev-etrax@axis.com, rpurdie@rpsys.net, spyro@f2s.com,
       Robert Wilkens <robw@optonline.net>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 12 Aug 2005 22:40:02 -0400
Message-Id: <1123900802.5296.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch that converts all architectures to behave like other unix
boxes signal handling.  It's funny that I didn't need to change the m68k
architecture, since it was the only one that already behaves this way!
(the m68knommu does not!)

Also, I noticed that not all check the return value of setting up the
signal frame (not that the signal frame setup functions have return
values).  So this probably needs to be fixed in each architecture that
doesn't already do it.  Since that is a little more advanced change, I
don't feel comfortable with changing that without even having the
ability to compile it.

Also note, that these changes were done without compling (since I don't
happen to have a compiler for every arch that Linux supports).  So these
are all untested, but I did go over them three times to make sure it
looks good. I recommend those that support these archs to check these as
well. (I tried to CC all the arch maintainers, but I might have missed
some).

I did this against 2.6.13-rc6-git4, but it is best to throw this into
-mm or early 2.6.14-rc's.

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


