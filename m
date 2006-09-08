Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751929AbWIHALr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbWIHALr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 20:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbWIHALr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 20:11:47 -0400
Received: from mailfe09.tele2.fr ([212.247.155.12]:65436 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751924AbWIHALo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 20:11:44 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Fri, 8 Sep 2006 02:10:42 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: clean SA_NOMASK usage
Message-ID: <20060908001042.GK8569@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060908000602.GJ8569@bouh.residence.ens-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908000602.GJ8569@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given that my previous patch gets applied, here is a patch for removing
uses of linuxish SA_NOMASK.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/arch/ia64/ia32/ia32_signal.c b/arch/ia64/ia32/ia32_signal.c
index b3355a9..0753ab4 100644
--- a/arch/ia64/ia32/ia32_signal.c
+++ b/arch/ia64/ia32/ia32_signal.c
@@ -514,7 +514,7 @@ sys32_signal (int sig, unsigned int hand
 	int ret;
 
 	sigact_set_handler(&new_sa, handler, 0);
-	new_sa.sa.sa_flags = SA_ONESHOT | SA_NOMASK;
+	new_sa.sa.sa_flags = SA_ONESHOT | SA_NODEFER;
 	sigemptyset(&new_sa.sa.sa_mask);
 
 	ret = do_sigaction(sig, &new_sa, &old_sa);
diff --git a/arch/sparc/kernel/signal.c b/arch/sparc/kernel/signal.c
index c9301b9..2aa8fe6 100644
--- a/arch/sparc/kernel/signal.c
+++ b/arch/sparc/kernel/signal.c
@@ -964,7 +964,7 @@ handle_signal(unsigned long signr, struc
 	}
 	spin_lock_irq(&current->sighand->siglock);
 	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
-	if (!(ka->sa.sa_flags & SA_NOMASK))
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked, signr);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
diff --git a/arch/sparc64/kernel/signal.c b/arch/sparc64/kernel/signal.c
index 96d56a8..63b579d 100644
--- a/arch/sparc64/kernel/signal.c
+++ b/arch/sparc64/kernel/signal.c
@@ -487,7 +487,7 @@ static inline void handle_signal(unsigne
 		       (ka->sa.sa_flags & SA_SIGINFO) ? info : NULL);
 	spin_lock_irq(&current->sighand->siglock);
 	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
-	if (!(ka->sa.sa_flags & SA_NOMASK))
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,signr);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
diff --git a/arch/sparc64/kernel/signal32.c b/arch/sparc64/kernel/signal32.c
index 708ba9b..fb2d82c 100644
--- a/arch/sparc64/kernel/signal32.c
+++ b/arch/sparc64/kernel/signal32.c
@@ -1232,7 +1232,7 @@ static inline void handle_signal32(unsig
 	}
 	spin_lock_irq(&current->sighand->siglock);
 	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
-	if (!(ka->sa.sa_flags & SA_NOMASK))
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,signr);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
diff --git a/arch/sparc64/solaris/signal.c b/arch/sparc64/solaris/signal.c
index 7fa2634..21edcf0 100644
--- a/arch/sparc64/solaris/signal.c
+++ b/arch/sparc64/solaris/signal.c
@@ -83,7 +83,7 @@ static long sig_handler(int sig, u32 arg
 	sa.sa_restorer = NULL;
 	sa.sa_handler = (__sighandler_t)A(arg);
 	sa.sa_flags = 0;
-	if (one_shot) sa.sa_flags = SA_ONESHOT | SA_NOMASK;
+	if (one_shot) sa.sa_flags = SA_ONESHOT | SA_NODEFER;
 	set_fs (KERNEL_DS);
 	ret = sys_sigaction(sig, (void __user *)&sa, (void __user *)&old);
 	set_fs (old_fs);
@@ -277,7 +277,7 @@ asmlinkage int solaris_sigaction(int sig
 		s.sa_flags = 0;
 		if (tmp & SOLARIS_SA_ONSTACK) s.sa_flags |= SA_STACK;
 		if (tmp & SOLARIS_SA_RESTART) s.sa_flags |= SA_RESTART;
-		if (tmp & SOLARIS_SA_NODEFER) s.sa_flags |= SA_NOMASK;
+		if (tmp & SOLARIS_SA_NODEFER) s.sa_flags |= SA_NODEFER;
 		if (tmp & SOLARIS_SA_RESETHAND) s.sa_flags |= SA_ONESHOT;
 		if (tmp & SOLARIS_SA_NOCLDSTOP) s.sa_flags |= SA_NOCLDSTOP;
 		if (get_user (tmp, &p->sa_handler) ||
@@ -297,7 +297,7 @@ asmlinkage int solaris_sigaction(int sig
 		tmp = 0; tmp2[2] = 0; tmp2[3] = 0;
 		if (s2.sa_flags & SA_STACK) tmp |= SOLARIS_SA_ONSTACK;
 		if (s2.sa_flags & SA_RESTART) tmp |= SOLARIS_SA_RESTART;
-		if (s2.sa_flags & SA_NOMASK) tmp |= SOLARIS_SA_NODEFER;
+		if (s2.sa_flags & SA_NODEFER) tmp |= SOLARIS_SA_NODEFER;
 		if (s2.sa_flags & SA_ONESHOT) tmp |= SOLARIS_SA_RESETHAND;
 		if (s2.sa_flags & SA_NOCLDSTOP) tmp |= SOLARIS_SA_NOCLDSTOP;
 		if (put_user (tmp, &p->sa_flags) ||
diff --git a/kernel/signal.c b/kernel/signal.c
index bfdb568..8a3b3a5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2530,7 +2530,7 @@ sys_signal(int sig, __sighandler_t handl
 	int ret;
 
 	new_sa.sa.sa_handler = handler;
-	new_sa.sa.sa_flags = SA_ONESHOT | SA_NOMASK;
+	new_sa.sa.sa_flags = SA_ONESHOT | SA_NODEFER;
 	sigemptyset(&new_sa.sa.sa_mask);
 
 	ret = do_sigaction(sig, &new_sa, &old_sa);
