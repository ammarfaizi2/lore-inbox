Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbTBHAM2>; Fri, 7 Feb 2003 19:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266908AbTBHAM2>; Fri, 7 Feb 2003 19:12:28 -0500
Received: from tapu.f00f.org ([202.49.232.129]:23696 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S266886AbTBHALv>;
	Fri, 7 Feb 2003 19:11:51 -0500
Date: Fri, 7 Feb 2003 16:21:30 -0800
From: Chris Wedgwood <cw@f00f.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.59 (bkbits linus tree) "sig->sighand" multi-architecture-uber-diff
Message-ID: <20030208002130.GA29758@f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Large diff for lots of things to accomodate (struct task_struct*)->sig
becoming (struct task_struct*)->sighand:

 arch/alpha/kernel/signal.c           |   24 ++++++++++++------------
 arch/arm/kernel/signal.c             |   24 ++++++++++++------------
 arch/ia64/ia32/ia32_signal.c         |   12 ++++++------
 arch/ia64/kernel/signal.c            |   12 ++++++------
 arch/m68knommu/kernel/signal.c       |   20 ++++++++++----------
 arch/parisc/kernel/signal.c          |   12 ++++++------
 arch/ppc/kernel/signal.c             |   20 ++++++++++----------
 arch/ppc64/kernel/signal.c           |   12 ++++++------
 arch/ppc64/kernel/signal32.c         |   20 ++++++++++----------
 arch/s390/kernel/signal.c            |   20 ++++++++++----------
 arch/s390x/kernel/linux32.c          |    8 ++++----
 arch/s390x/kernel/signal.c           |   20 ++++++++++----------
 arch/s390x/kernel/signal32.c         |   20 ++++++++++----------
 arch/sparc/kernel/signal.c           |   32 ++++++++++++++++----------------
 arch/sparc/kernel/sys_sunos.c        |    8 ++++----
 arch/sparc64/kernel/power.c          |    4 ++--
 arch/sparc64/kernel/signal.c         |   24 ++++++++++++------------
 arch/sparc64/kernel/signal32.c       |   32 ++++++++++++++++----------------
 arch/sparc64/kernel/sys_sparc32.c    |    8 ++++----
 arch/sparc64/kernel/sys_sunos32.c    |    8 ++++----
 arch/sparc64/solaris/signal.c        |   16 ++++++++--------
 arch/um/kernel/signal_kern.c         |   20 ++++++++++----------
 arch/v850/kernel/signal.c            |   20 ++++++++++----------
 arch/x86_64/ia32/ia32_signal.c       |   12 ++++++------
 arch/x86_64/kernel/signal.c          |   12 ++++++------
 drivers/block/nbd.c                  |   12 ++++++------
 drivers/bluetooth/bt3c_cs.c          |    8 ++++----
 drivers/char/ftape/lowlevel/fdc-io.c |    8 ++++----
 drivers/macintosh/adb.c              |    4 ++--
 drivers/md/md.c                      |    4 ++--
 drivers/media/video/saa5249.c        |    8 ++++----
 drivers/mtd/devices/blkmtd.c         |    4 ++--
 drivers/mtd/mtdblock.c               |    4 ++--
 drivers/net/8139too.c                |    8 ++++----
 drivers/net/irda/sir_kthread.c       |    4 ++--
 fs/afs/cmservice.c                   |    4 ++--
 fs/afs/internal.h                    |    4 ++--
 fs/afs/kafsasyncd.c                  |    4 ++--
 fs/afs/kafstimod.c                   |    4 ++--
 fs/jffs/intrep.c                     |    8 ++++----
 fs/jffs2/os-linux.h                  |    2 +-
 fs/jfs/jfs_logmgr.c                  |    4 ++--
 fs/jfs/jfs_txnmgr.c                  |    8 ++++----
 fs/ncpfs/sock.c                      |    8 ++++----
 fs/smbfs/smbiod.c                    |    4 ++--
 fs/xfs/pagebuf/page_buf.c            |    4 ++--
 include/linux/sched.h                |    2 +-
 kernel/suspend.c                     |    4 ++--
 net/rxrpc/internal.h                 |    4 ++--
 net/rxrpc/krxiod.c                   |    4 ++--
 net/rxrpc/krxsecd.c                  |    4 ++--
 net/rxrpc/krxtimod.c                 |    4 ++--
 52 files changed, 280 insertions(+), 280 deletions(-)

I quickly checked this works (well, builds) for me here, but it's
possible I screwed up on some other arch's.


===== arch/alpha/kernel/signal.c 1.14 vs edited =====
--- 1.14/arch/alpha/kernel/signal.c	Fri Dec  6 17:54:50 2002
+++ edited/arch/alpha/kernel/signal.c	Fri Feb  7 15:52:26 2003
@@ -63,7 +63,7 @@
 		unsigned long block, unblock;
 
 		newmask &= _BLOCKABLE;
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		oldmask = current->blocked.sig[0];
 
 		unblock = oldmask & ~newmask;
@@ -76,7 +76,7 @@
 			sigemptyset(&current->blocked);
 		current->blocked.sig[0] = newmask;
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 
 		(&regs)->r0 = 0;		/* special no error return */
 	}
@@ -150,11 +150,11 @@
 	sigset_t oldset;
 
 	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	oldset = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
@@ -177,11 +177,11 @@
 		return -EFAULT;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	oldset = current->blocked;
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
@@ -284,10 +284,10 @@
 		goto give_sigsegv;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (restore_sigcontext(&frame->sc, regs, sw))
 		goto give_sigsegv;
@@ -323,10 +323,10 @@
 		goto give_sigsegv;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (restore_sigcontext(&frame->uc.uc_mcontext, regs, sw))
 		goto give_sigsegv;
@@ -562,11 +562,11 @@
 		ka->sa.sa_handler = SIG_DFL;
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 }
 
===== arch/arm/kernel/signal.c 1.18 vs edited =====
--- 1.18/arch/arm/kernel/signal.c	Sat Dec 28 08:26:45 2002
+++ edited/arch/arm/kernel/signal.c	Fri Feb  7 15:52:26 2003
@@ -59,11 +59,11 @@
 	sigset_t saveset;
 
 	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	regs->ARM_r0 = -EINTR;
 
 	while (1) {
@@ -87,11 +87,11 @@
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	regs->ARM_r0 = -EINTR;
 
 	while (1) {
@@ -207,10 +207,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (restore_sigcontext(regs, &frame->sc))
 		goto badframe;
@@ -247,10 +247,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (restore_sigcontext(regs, &frame->uc.uc_mcontext))
 		goto badframe;
@@ -477,12 +477,12 @@
 			ka->sa.sa_handler = SIG_DFL;
 
 		if (!(ka->sa.sa_flags & SA_NODEFER)) {
-			spin_lock_irq(&tsk->sig->siglock);
+			spin_lock_irq(&tsk->sighand->siglock);
 			sigorsets(&tsk->blocked, &tsk->blocked,
 				  &ka->sa.sa_mask);
 			sigaddset(&tsk->blocked, sig);
 			recalc_sigpending();
-			spin_unlock_irq(&tsk->sig->siglock);
+			spin_unlock_irq(&tsk->sighand->siglock);
 		}
 		return;
 	}
@@ -521,9 +521,9 @@
 		unsigned long signr = 0;
 		struct k_sigaction *ka;
 
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		signr = dequeue_signal(&current->blocked, &info);
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 
 		if (!signr)
 			break;
===== arch/ia64/ia32/ia32_signal.c 1.13 vs edited =====
--- 1.13/arch/ia64/ia32/ia32_signal.c	Wed Jan 15 06:39:47 2003
+++ edited/arch/ia64/ia32/ia32_signal.c	Fri Feb  7 15:52:26 2003
@@ -479,13 +479,13 @@
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	{
 		oldset = current->blocked;
 		current->blocked = set;
 		recalc_sigpending();
 	}
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	/*
 	 * The return below usually returns to the signal handler.  We need to pre-set the
@@ -1007,10 +1007,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = (sigset_t) set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (restore_sigcontext_ia32(regs, &frame->sc, &eax))
 		goto badframe;
@@ -1038,10 +1038,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked =  set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (restore_sigcontext_ia32(regs, &frame->uc.uc_mcontext, &eax))
 		goto badframe;
===== arch/ia64/kernel/signal.c 1.18 vs edited =====
--- 1.18/arch/ia64/kernel/signal.c	Fri Dec 20 23:51:44 2002
+++ edited/arch/ia64/kernel/signal.c	Fri Feb  7 15:52:26 2003
@@ -68,13 +68,13 @@
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	{
 		oldset = current->blocked;
 		current->blocked = set;
 		recalc_sigpending();
 	}
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	/*
 	 * The return below usually returns to the signal handler.  We need to
@@ -274,12 +274,12 @@
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	{
 		current->blocked = set;
 		recalc_sigpending();
 	}
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (restore_sigcontext(sc, scr))
 		goto give_sigsegv;
@@ -465,13 +465,13 @@
 		ka->sa.sa_handler = SIG_DFL;
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		{
 			sigorsets(&current->blocked, &current->blocked, &ka->sa.sa_mask);
 			sigaddset(&current->blocked, sig);
 			recalc_sigpending();
 		}
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 	return 1;
 }
===== arch/m68knommu/kernel/signal.c 1.3 vs edited =====
--- 1.3/arch/m68knommu/kernel/signal.c	Tue Jan 14 03:33:15 2003
+++ edited/arch/m68knommu/kernel/signal.c	Fri Feb  7 15:52:26 2003
@@ -63,11 +63,11 @@
 	sigset_t saveset;
 
 	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	regs->d0 = -EINTR;
 	while (1) {
@@ -93,11 +93,11 @@
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	regs->d0 = -EINTR;
 	while (1) {
@@ -370,10 +370,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	
 	if (restore_sigcontext(regs, &frame->sc, frame + 1, &d0))
 		goto badframe;
@@ -399,10 +399,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	
 	if (rt_restore_ucontext(regs, sw, &frame->uc, &d0))
 		goto badframe;
@@ -738,11 +738,11 @@
 		ka->sa.sa_handler = SIG_DFL;
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 }
 
===== arch/parisc/kernel/signal.c 1.6 vs edited =====
--- 1.6/arch/parisc/kernel/signal.c	Thu Nov 14 02:12:52 2002
+++ edited/arch/parisc/kernel/signal.c	Fri Feb  7 15:52:26 2003
@@ -118,11 +118,11 @@
 #endif
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	regs->gr[28] = -EINTR;
 	while (1) {
@@ -177,10 +177,10 @@
 		goto give_sigsegv;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	/* Good thing we saved the old gr[30], eh? */
 	if (restore_sigcontext(&frame->uc.uc_mcontext, regs))
@@ -407,11 +407,11 @@
 		ka->sa.sa_handler = SIG_DFL;
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 	return 1;
 }
===== arch/ppc/kernel/signal.c 1.19 vs edited =====
--- 1.19/arch/ppc/kernel/signal.c	Fri Dec  6 23:35:42 2002
+++ edited/arch/ppc/kernel/signal.c	Fri Feb  7 15:52:26 2003
@@ -65,11 +65,11 @@
 	sigset_t saveset;
 
 	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	regs->result = -EINTR;
 	regs->ccr |= 0x10000000;
@@ -96,11 +96,11 @@
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	regs->result = -EINTR;
 	regs->ccr |= 0x10000000;
@@ -208,10 +208,10 @@
 	    || copy_from_user(&st, &rt_sf->uc.uc_stack, sizeof(st)))
 		goto badframe;
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
 
@@ -311,10 +311,10 @@
 	set.sig[1] = sigctx._unused[3];
 #endif
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	if (regs->msr & MSR_FP )
 		giveup_fpu(current);
 
@@ -450,11 +450,11 @@
 		ka->sa.sa_handler = SIG_DFL;
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 	return;
 
===== arch/ppc64/kernel/signal.c 1.22 vs edited =====
--- 1.22/arch/ppc64/kernel/signal.c	Wed Jan 15 18:41:44 2003
+++ edited/arch/ppc64/kernel/signal.c	Fri Feb  7 15:52:26 2003
@@ -112,11 +112,11 @@
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	regs->result = -EINTR;
 	regs->gpr[3] = EINTR;
@@ -164,10 +164,10 @@
 	    || copy_from_user(&st, &rt_sf->uc.uc_stack, sizeof(st)))
 		goto badframe;
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
 
@@ -333,11 +333,11 @@
 		ka->sa.sa_handler = SIG_DFL;
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 	return;
 
===== arch/ppc64/kernel/signal32.c 1.31 vs edited =====
--- 1.31/arch/ppc64/kernel/signal32.c	Wed Jan 15 18:41:44 2003
+++ edited/arch/ppc64/kernel/signal32.c	Fri Feb  7 15:59:17 2003
@@ -126,11 +126,11 @@
 	sigset_t saveset;
 
 	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	regs->result = -EINTR;
 	regs->gpr[3] = EINTR;
@@ -268,10 +268,10 @@
 	 */
 	set.sig[0] = sigctx.oldmask + ((long)(sigctx._unused[3]) << 32);
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	if (regs->msr & MSR_FP )
 		giveup_fpu(current);
 	/* Last stacked signal - restore registers */
@@ -487,10 +487,10 @@
 	 */
 	sigdelsetmask(&set, ~_BLOCKABLE); 
 	/* update the current based on the sigmask found in the rt_stackframe */
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	/* If currently owning the floating point - give them up */
 	if (regs->msr & MSR_FP)
@@ -863,11 +863,11 @@
 
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	regs->result = -EINTR;
 	regs->gpr[3] = EINTR;
@@ -1055,11 +1055,11 @@
 		ka->sa.sa_handler = SIG_DFL;
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 	return;
 
===== arch/s390/kernel/signal.c 1.16 vs edited =====
--- 1.16/arch/s390/kernel/signal.c	Thu Dec 12 10:27:00 2002
+++ edited/arch/s390/kernel/signal.c	Fri Feb  7 15:52:26 2003
@@ -61,11 +61,11 @@
 	sigset_t saveset;
 
 	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	regs->gprs[2] = -EINTR;
 
 	while (1) {
@@ -89,11 +89,11 @@
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	regs->gprs[2] = -EINTR;
 
 	while (1) {
@@ -194,10 +194,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (restore_sigregs(regs, &frame->sregs))
 		goto badframe;
@@ -220,10 +220,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (restore_sigregs(regs, &frame->uc.uc_mcontext))
 		goto badframe;
@@ -427,11 +427,11 @@
 		ka->sa.sa_handler = SIG_DFL;
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 }
 
===== arch/s390x/kernel/linux32.c 1.33 vs edited =====
--- 1.33/arch/s390x/kernel/linux32.c	Wed Jan 15 06:43:15 2003
+++ edited/arch/s390x/kernel/linux32.c	Fri Feb  7 15:59:17 2003
@@ -1725,7 +1725,7 @@
 			return -EINVAL;
 	}
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	sig = dequeue_signal(&these, &info);
 	if (!sig) {
 		/* None ready -- temporarily unblock those we're interested
@@ -1733,7 +1733,7 @@
 		current->real_blocked = current->blocked;
 		sigandsets(&current->blocked, &current->blocked, &these);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 
 		timeout = MAX_SCHEDULE_TIMEOUT;
 		if (uts)
@@ -1743,13 +1743,13 @@
 		current->state = TASK_INTERRUPTIBLE;
 		timeout = schedule_timeout(timeout);
 
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sig = dequeue_signal(&these, &info);
 		current->blocked = current->real_blocked;
 		siginitset(&current->real_blocked, 0);
 		recalc_sigpending();
 	}
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (sig) {
 		ret = sig;
===== arch/s390x/kernel/signal.c 1.15 vs edited =====
--- 1.15/arch/s390x/kernel/signal.c	Thu Dec 12 10:27:08 2002
+++ edited/arch/s390x/kernel/signal.c	Fri Feb  7 15:52:26 2003
@@ -60,11 +60,11 @@
 	sigset_t saveset;
 
 	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	regs->gprs[2] = -EINTR;
 
 	while (1) {
@@ -88,11 +88,11 @@
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	regs->gprs[2] = -EINTR;
 
 	while (1) {
@@ -188,10 +188,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (restore_sigregs(regs, &frame->sregs))
 		goto badframe;
@@ -214,10 +214,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (restore_sigregs(regs, &frame->uc.uc_mcontext))
 		goto badframe;
@@ -421,11 +421,11 @@
 		ka->sa.sa_handler = SIG_DFL;
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 }
 
===== arch/s390x/kernel/signal32.c 1.12 vs edited =====
--- 1.12/arch/s390x/kernel/signal32.c	Tue Jan 14 19:51:50 2003
+++ edited/arch/s390x/kernel/signal32.c	Fri Feb  7 15:59:17 2003
@@ -112,11 +112,11 @@
 	sigset_t saveset;
 
 	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	regs->gprs[2] = -EINTR;
 
 	while (1) {
@@ -147,11 +147,11 @@
 	}
         sigdelsetmask(&newset, ~_BLOCKABLE);
 
-        spin_lock_irq(&current->sig->siglock);
+        spin_lock_irq(&current->sighand->siglock);
         saveset = current->blocked;
         current->blocked = newset;
         recalc_sigpending();
-        spin_unlock_irq(&current->sig->siglock);
+        spin_unlock_irq(&current->sighand->siglock);
         regs->gprs[2] = -EINTR;
 
         while (1) {
@@ -345,10 +345,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (restore_sigregs32(regs, &frame->sregs))
 		goto badframe;
@@ -375,10 +375,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (restore_sigregs32(regs, &frame->uc.uc_mcontext))
 		goto badframe;
@@ -588,11 +588,11 @@
 		ka->sa.sa_handler = SIG_DFL;
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 }
 
===== arch/sparc/kernel/signal.c 1.18 vs edited =====
--- 1.18/arch/sparc/kernel/signal.c	Fri Dec 20 18:33:34 2002
+++ edited/arch/sparc/kernel/signal.c	Fri Feb  7 15:52:26 2003
@@ -104,11 +104,11 @@
 	sigset_t saveset;
 
 	set &= _BLOCKABLE;
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	siginitset(&current->blocked, set);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	regs->pc = regs->npc;
 	regs->npc += 4;
@@ -161,11 +161,11 @@
 	}
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	oldset = current->blocked;
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	regs->pc = regs->npc;
 	regs->npc += 4;
@@ -267,10 +267,10 @@
 		goto segv_and_exit;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	return;
 
 segv_and_exit:
@@ -314,10 +314,10 @@
 		goto segv_and_exit;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	regs->pc = pc;
 	regs->npc = npc;
@@ -384,10 +384,10 @@
 	do_sigaltstack(&st, NULL, (unsigned long)sf);
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	return;
 segv:
 	send_sig(SIGSEGV, current, 1);
@@ -967,10 +967,10 @@
 		set.sig[3] = setv.sigbits[3];
 	}
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	regs->pc = pc;
 	regs->npc = npc | 1;
 	err |= __get_user(regs->y, &((*gr) [SVR4_Y]));
@@ -1007,11 +1007,11 @@
 	if(ka->sa.sa_flags & SA_ONESHOT)
 		ka->sa.sa_handler = SIG_DFL;
 	if(!(ka->sa.sa_flags & SA_NOMASK)) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked, signr);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 }
 
@@ -1066,9 +1066,9 @@
 		sigset_t *mask = &current->blocked;
 		unsigned long signr = 0;
 
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		signr = dequeue_signal(mask, &info);
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 
 		if (!signr)
 			break;
===== arch/sparc/kernel/sys_sunos.c 1.21 vs edited =====
--- 1.21/arch/sparc/kernel/sys_sunos.c	Fri Feb  7 00:20:33 2003
+++ edited/arch/sparc/kernel/sys_sunos.c	Fri Feb  7 15:59:17 2003
@@ -281,11 +281,11 @@
 {
 	unsigned long old;
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	old = current->blocked.sig[0];
 	current->blocked.sig[0] |= (blk_mask & _BLOCKABLE);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	return old;
 }
 
@@ -293,11 +293,11 @@
 {
 	unsigned long retval;
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	retval = current->blocked.sig[0];
 	current->blocked.sig[0] = (newmask & _BLOCKABLE);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	return retval;
 }
 
===== arch/sparc64/kernel/power.c 1.8 vs edited =====
--- 1.8/arch/sparc64/kernel/power.c	Mon Nov 18 12:27:30 2002
+++ edited/arch/sparc64/kernel/power.c	Fri Feb  7 15:52:26 2003
@@ -70,9 +70,9 @@
 
 again:
 	while (button_pressed == 0) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		flush_signals(current);
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 		interruptible_sleep_on(&powerd_wait);
 	}
 
===== arch/sparc64/kernel/signal.c 1.23 vs edited =====
--- 1.23/arch/sparc64/kernel/signal.c	Fri Jan 17 02:21:48 2003
+++ edited/arch/sparc64/kernel/signal.c	Fri Feb  7 15:52:26 2003
@@ -70,10 +70,10 @@
 				goto do_sigsegv;
 		}
 		sigdelsetmask(&set, ~_BLOCKABLE);
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		current->blocked = set;
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 	if (test_thread_flag(TIF_32BIT)) {
 		pc &= 0xffffffff;
@@ -257,11 +257,11 @@
 	}
 #endif
 	set &= _BLOCKABLE;
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	siginitset(&current->blocked, set);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	
 	if (test_thread_flag(TIF_32BIT)) {
 		regs->tpc = (regs->tnpc & 0xffffffff);
@@ -317,11 +317,11 @@
 	}
                                                                 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	oldset = current->blocked;
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	
 	if (test_thread_flag(TIF_32BIT)) {
 		regs->tpc = (regs->tnpc & 0xffffffff);
@@ -428,10 +428,10 @@
 	set_fs(old_fs);
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	return;
 segv:
 	send_sig(SIGSEGV, current, 1);
@@ -564,11 +564,11 @@
 	if (ka->sa.sa_flags & SA_ONESHOT)
 		ka->sa.sa_handler = SIG_DFL;
 	if (!(ka->sa.sa_flags & SA_NOMASK)) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked,signr);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 }
 
@@ -619,9 +619,9 @@
 		sigset_t *mask = &current->blocked;
 		unsigned long signr = 0;
 
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		signr = dequeue_signal(mask, &info);
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 		
 		if (!signr)
 			break;
===== arch/sparc64/kernel/signal32.c 1.25 vs edited =====
--- 1.25/arch/sparc64/kernel/signal32.c	Fri Jan 17 02:21:48 2003
+++ edited/arch/sparc64/kernel/signal32.c	Fri Feb  7 15:52:26 2003
@@ -144,11 +144,11 @@
 	sigset_t saveset;
 
 	set &= _BLOCKABLE;
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	siginitset(&current->blocked, set);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	
 	regs->tpc = regs->tnpc;
 	regs->tnpc += 4;
@@ -199,11 +199,11 @@
 	case 1: set.sig[0] = set32.sig[0] + (((long)set32.sig[1]) << 32);
 	}
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	oldset = current->blocked;
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	
 	regs->tpc = regs->tnpc;
 	regs->tnpc += 4;
@@ -312,10 +312,10 @@
 		case 1: set.sig[0] = seta[0] + (((long)seta[1]) << 32);
 	}
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	return;
 
 segv:
@@ -359,10 +359,10 @@
 		case 1: set.sig[0] = seta[0] + (((long)seta[1]) << 32);
 	}
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	
 	if (test_thread_flag(TIF_32BIT)) {
 		pc &= 0xffffffff;
@@ -461,10 +461,10 @@
 		case 1: set.sig[0] = seta.sig[0] + (((long)seta.sig[1]) << 32);
 	}
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	return;
 segv:
 	do_exit(SIGSEGV);
@@ -1059,10 +1059,10 @@
 	set_fs(old_fs);
 	
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	regs->tpc = pc;
 	regs->tnpc = npc | 1;
 	if (test_thread_flag(TIF_32BIT)) {
@@ -1241,11 +1241,11 @@
 	if (ka->sa.sa_flags & SA_ONESHOT)
 		ka->sa.sa_handler = SIG_DFL;
 	if (!(ka->sa.sa_flags & SA_NOMASK)) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked,signr);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 }
 
@@ -1288,9 +1288,9 @@
 		sigset_t *mask = &current->blocked;
 		unsigned long signr = 0;
 
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		signr = dequeue_signal(mask, &info);
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 		
 		if (!signr)
 			break;
===== arch/sparc64/kernel/sys_sparc32.c 1.60 vs edited =====
--- 1.60/arch/sparc64/kernel/sys_sparc32.c	Fri Jan 17 02:21:48 2003
+++ edited/arch/sparc64/kernel/sys_sparc32.c	Fri Feb  7 15:52:26 2003
@@ -1812,7 +1812,7 @@
 			return -EINVAL;
 	}
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	sig = dequeue_signal(&these, &info);
 	if (!sig) {
 		timeout = MAX_SCHEDULE_TIMEOUT;
@@ -1827,19 +1827,19 @@
 			current->real_blocked = current->blocked;
 			sigandsets(&current->blocked, &current->blocked, &these);
 			recalc_sigpending();
-			spin_unlock_irq(&current->sig->siglock);
+			spin_unlock_irq(&current->sighand->siglock);
 
 			current->state = TASK_INTERRUPTIBLE;
 			timeout = schedule_timeout(timeout);
 
-			spin_lock_irq(&current->sig->siglock);
+			spin_lock_irq(&current->sighand->siglock);
 			sig = dequeue_signal(&these, &info);
 			current->blocked = current->real_blocked;
 			siginitset(&current->real_blocked, 0);
 			recalc_sigpending();
 		}
 	}
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (sig) {
 		ret = sig;
===== arch/sparc64/kernel/sys_sunos32.c 1.26 vs edited =====
--- 1.26/arch/sparc64/kernel/sys_sunos32.c	Fri Jan 17 02:21:48 2003
+++ edited/arch/sparc64/kernel/sys_sunos32.c	Fri Feb  7 15:52:26 2003
@@ -238,11 +238,11 @@
 {
 	u32 old;
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	old = (u32) current->blocked.sig[0];
 	current->blocked.sig[0] |= (blk_mask & _BLOCKABLE);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	return old;
 }
 
@@ -250,11 +250,11 @@
 {
 	u32 retval;
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	retval = (u32) current->blocked.sig[0];
 	current->blocked.sig[0] = (newmask & _BLOCKABLE);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	return retval;
 }
 
===== arch/sparc64/solaris/signal.c 1.4 vs edited =====
--- 1.4/arch/sparc64/solaris/signal.c	Sun Sep 29 23:13:50 2002
+++ edited/arch/sparc64/solaris/signal.c	Fri Feb  7 15:52:26 2003
@@ -99,16 +99,16 @@
 static long solaris_sigset(int sig, u32 arg)
 {
 	if (arg != 2) /* HOLD */ {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigdelsetmask(&current->blocked, _S(sig));
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 		return sig_handler (sig, arg, 0);
 	} else {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigaddsetmask(&current->blocked, (_S(sig) & ~_BLOCKABLE));
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 		return 0;
 	}
 }
@@ -120,10 +120,10 @@
 
 static inline long solaris_sigrelse(int sig)
 {
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	sigdelsetmask(&current->blocked, _S(sig));
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	return 0;
 }
 
@@ -311,10 +311,10 @@
 	u32 tmp[4];
 	switch (which) {
 	case 1: /* sigpending */
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigandsets(&s, &current->blocked, &current->pending.signal);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 		break;
 	case 2: /* sigfillset - I just set signals which have linux equivalents */
 		sigfillset(&s);
===== arch/um/kernel/signal_kern.c 1.11 vs edited =====
--- 1.11/arch/um/kernel/signal_kern.c	Wed Feb  5 20:16:02 2003
+++ edited/arch/um/kernel/signal_kern.c	Fri Feb  7 15:52:26 2003
@@ -95,12 +95,12 @@
 		ka->sa.sa_handler = SIG_DFL;
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked, &current->blocked, 
 			  &ka->sa.sa_mask);
 		sigaddset(&current->blocked, signr);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 
 	sp = PT_REGS_SP(regs);
@@ -186,11 +186,11 @@
 	sigset_t saveset;
 
 	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
@@ -212,11 +212,11 @@
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
@@ -242,13 +242,13 @@
 	void *mask = sp_to_mask(PT_REGS_SP(&current->thread.regs));
 	int sig_size = (_NSIG_WORDS - 1) * sizeof(unsigned long);
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	copy_from_user(&current->blocked.sig[0], sc_sigmask(sc), 
 		       sizeof(current->blocked.sig[0]));
 	copy_from_user(&current->blocked.sig[1], mask, sig_size);
 	sigdelsetmask(&current->blocked, ~_BLOCKABLE);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	copy_sc_from_user(&current->thread.regs, sc, 
 			  &signal_frame_sc.common.arch);
 	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
@@ -260,11 +260,11 @@
 	void *fp;
 	int sig_size = _NSIG_WORDS * sizeof(unsigned long);
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	copy_from_user(&current->blocked, &uc->uc_sigmask, sig_size);
 	sigdelsetmask(&current->blocked, ~_BLOCKABLE);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	fp = (void *) (((unsigned long) uc) + sizeof(struct ucontext));
 	copy_sc_from_user(&current->thread.regs, &uc->uc_mcontext,
 			  &signal_frame_si.common.arch);
===== arch/v850/kernel/signal.c 1.5 vs edited =====
--- 1.5/arch/v850/kernel/signal.c	Wed Dec 18 18:37:31 2002
+++ edited/arch/v850/kernel/signal.c	Fri Feb  7 15:52:26 2003
@@ -50,11 +50,11 @@
 	sigset_t saveset;
 
 	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	regs->gpr[GPR_RVAL] = -EINTR;
 	while (1) {
@@ -78,11 +78,11 @@
 	if (copy_from_user(&newset, unewset, sizeof(newset)))
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	regs->gpr[GPR_RVAL] = -EINTR;
 	while (1) {
@@ -188,10 +188,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (restore_sigcontext(regs, &frame->sc, &rval))
 		goto badframe;
@@ -216,10 +216,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (restore_sigcontext(regs, &frame->uc.uc_mcontext, &rval))
 		goto badframe;
@@ -472,11 +472,11 @@
 		ka->sa.sa_handler = SIG_DFL;
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 }
 
===== arch/x86_64/ia32/ia32_signal.c 1.8 vs edited =====
--- 1.8/arch/x86_64/ia32/ia32_signal.c	Wed Jan 15 10:18:02 2003
+++ edited/arch/x86_64/ia32/ia32_signal.c	Fri Feb  7 15:59:17 2003
@@ -83,11 +83,11 @@
 	sigset_t saveset;
 
 	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	regs.rax = -EINTR;
 	while (1) {
@@ -243,10 +243,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	
 	if (ia32_restore_sigcontext(&regs, &frame->sc, &eax))
 		goto badframe;
@@ -270,10 +270,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	
 	if (ia32_restore_sigcontext(&regs, &frame->uc.uc_mcontext, &eax))
 		goto badframe;
===== arch/x86_64/kernel/signal.c 1.11 vs edited =====
--- 1.11/arch/x86_64/kernel/signal.c	Fri Dec 27 15:32:16 2002
+++ edited/arch/x86_64/kernel/signal.c	Fri Feb  7 15:59:17 2003
@@ -52,11 +52,11 @@
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 #if DEBUG_SIG
 	printk("rt_sigsuspend savset(%lx) newset(%lx) regs(%p) rip(%lx)\n",
 		saveset, newset, &regs, regs.rip);
@@ -155,10 +155,10 @@
 	} 
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	
 	if (restore_sigcontext(&regs, &frame->uc.uc_mcontext, &eax)) { 
 		goto badframe;
@@ -401,11 +401,11 @@
 		ka->sa.sa_handler = SIG_DFL;
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 }
 
===== drivers/block/nbd.c 1.48 vs edited =====
--- 1.48/drivers/block/nbd.c	Fri Feb  7 00:20:35 2003
+++ edited/drivers/block/nbd.c	Fri Feb  7 15:39:57 2003
@@ -118,12 +118,12 @@
 	set_fs(get_ds());
 	/* Allow interception of SIGKILL only
 	 * Don't allow other signals to interrupt the transmission */
-	spin_lock_irqsave(&current->sig->siglock, flags);
+	spin_lock_irqsave(&current->sighand->siglock, flags);
 	oldset = current->blocked;
 	sigfillset(&current->blocked);
 	sigdelsetmask(&current->blocked, sigmask(SIGKILL));
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sig->siglock, flags);
+	spin_unlock_irqrestore(&current->sighand->siglock, flags);
 
 
 	do {
@@ -146,11 +146,11 @@
 
 		if (signal_pending(current)) {
 			siginfo_t info;
-			spin_lock_irqsave(&current->sig->siglock, flags);
+			spin_lock_irqsave(&current->sighand->siglock, flags);
 			printk(KERN_WARNING "NBD (pid %d: %s) got signal %d\n",
 				current->pid, current->comm, 
 				dequeue_signal(&current->blocked, &info));
-			spin_unlock_irqrestore(&current->sig->siglock, flags);
+			spin_unlock_irqrestore(&current->sighand->siglock, flags);
 			result = -EINTR;
 			break;
 		}
@@ -166,10 +166,10 @@
 		buf += result;
 	} while (size > 0);
 
-	spin_lock_irqsave(&current->sig->siglock, flags);
+	spin_lock_irqsave(&current->sighand->siglock, flags);
 	current->blocked = oldset;
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sig->siglock, flags);
+	spin_unlock_irqrestore(&current->sighand->siglock, flags);
 
 	set_fs(oldfs);
 	return result;
===== drivers/bluetooth/bt3c_cs.c 1.6 vs edited =====
--- 1.6/drivers/bluetooth/bt3c_cs.c	Mon Nov 11 05:58:11 2002
+++ edited/drivers/bluetooth/bt3c_cs.c	Fri Feb  7 15:59:17 2003
@@ -528,19 +528,19 @@
 	}
 
 	/* Block signals, everything but SIGKILL/SIGSTOP */
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	tmpsig = current->blocked;
 	siginitsetinv(&current->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP));
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	result = waitpid(pid, NULL, __WCLONE);
 
 	/* Allow signals again */
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = tmpsig;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	if (result != pid) {
 		printk(KERN_WARNING "bt3c_cs: Waiting for pid %d failed (errno=%d).\n", pid, -result);
===== drivers/char/ftape/lowlevel/fdc-io.c 1.6 vs edited =====
--- 1.6/drivers/char/ftape/lowlevel/fdc-io.c	Tue Jan  7 15:55:15 2003
+++ edited/drivers/char/ftape/lowlevel/fdc-io.c	Fri Feb  7 15:59:17 2003
@@ -386,11 +386,11 @@
 	/* timeout time will be up to USPT microseconds too long ! */
 	timeout = (1000 * time + FT_USPT - 1) / FT_USPT;
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	old_sigmask = current->blocked;
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	current->state = TASK_INTERRUPTIBLE;
 	add_wait_queue(&ftape_wait_intr, &wait);
@@ -398,10 +398,10 @@
 		timeout = schedule_timeout(timeout);
         }
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = old_sigmask;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	
 	remove_wait_queue(&ftape_wait_intr, &wait);
 	/*  the following IS necessary. True: as well
===== drivers/macintosh/adb.c 1.14 vs edited =====
--- 1.14/drivers/macintosh/adb.c	Mon Nov 11 05:18:24 2002
+++ edited/drivers/macintosh/adb.c	Fri Feb  7 15:59:17 2003
@@ -246,10 +246,10 @@
 {
 	strcpy(current->comm, "kadbprobe");
 	
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	sigfillset(&current->blocked);
 	flush_signals(current);
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	printk(KERN_INFO "adb: starting probe task...\n");
 	do_adb_reset_bus();
===== drivers/md/md.c 1.133 vs edited =====
--- 1.133/drivers/md/md.c	Fri Jan 10 17:00:17 2003
+++ edited/drivers/md/md.c	Fri Feb  7 15:59:17 2003
@@ -2444,9 +2444,9 @@
 
 static inline void flush_curr_signals(void)
 {
-	spin_lock(&current->sig->siglock);
+	spin_lock(&current->sighand->siglock);
 	flush_signals(current);
-	spin_unlock(&current->sig->siglock);
+	spin_unlock(&current->sighand->siglock);
 }
 
 int md_thread(void * arg)
===== drivers/media/video/saa5249.c 1.10 vs edited =====
--- 1.10/drivers/media/video/saa5249.c	Fri Nov 29 08:30:39 2002
+++ edited/drivers/media/video/saa5249.c	Fri Feb  7 15:59:17 2003
@@ -280,17 +280,17 @@
 {
 	sigset_t oldblocked = current->blocked;
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(delay);
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	current->blocked = oldblocked;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 
===== drivers/mtd/mtdblock.c 1.35 vs edited =====
--- 1.35/drivers/mtd/mtdblock.c	Mon Dec  2 15:20:17 2002
+++ edited/drivers/mtd/mtdblock.c	Fri Feb  7 15:59:17 2003
@@ -453,10 +453,10 @@
 	/* we might get involved when memory gets low, so use PF_MEMALLOC */
 	tsk->flags |= PF_MEMALLOC;
 	strcpy(tsk->comm, "mtdblockd");
-	spin_lock_irq(&tsk->sig->siglock);
+	spin_lock_irq(&tsk->sighand->siglock);
 	sigfillset(&tsk->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&tsk->sig->siglock);
+	spin_unlock_irq(&tsk->sighand->siglock);
 	daemonize();
 
 	while (!leaving) {
===== drivers/mtd/devices/blkmtd.c 1.23 vs edited =====
--- 1.23/drivers/mtd/devices/blkmtd.c	Wed Jan  8 12:37:23 2003
+++ edited/drivers/mtd/devices/blkmtd.c	Fri Feb  7 15:59:17 2003
@@ -305,10 +305,10 @@
   DEBUG(1, "blkmtd: writetask: starting (pid = %d)\n", tsk->pid);
   daemonize();
   strcpy(tsk->comm, "blkmtdd");
-  spin_lock_irq(&tsk->sig->siglock);
+  spin_lock_irq(&tsk->sighand->siglock);
   sigfillset(&tsk->blocked);
   recalc_sigpending();
-  spin_unlock_irq(&tsk->sig->siglock);
+  spin_unlock_irq(&tsk->sighand->siglock);
 
   if(alloc_kiovec(1, &iobuf)) {
     printk("blkmtd: write_queue_task cant allocate kiobuf\n");
===== drivers/net/8139too.c 1.48 vs edited =====
--- 1.48/drivers/net/8139too.c	Fri Jan 10 12:04:06 2003
+++ edited/drivers/net/8139too.c	Fri Feb  7 15:59:17 2003
@@ -1589,10 +1589,10 @@
 	unsigned long timeout;
 
 	daemonize();
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	sigemptyset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	strncpy (current->comm, dev->name, sizeof(current->comm) - 1);
 	current->comm[sizeof(current->comm) - 1] = '\0';
@@ -1604,9 +1604,9 @@
 		} while (!signal_pending (current) && (timeout > 0));
 
 		if (signal_pending (current)) {
-			spin_lock_irq(&current->sig->siglock);
+			spin_lock_irq(&current->sighand->siglock);
 			flush_signals(current);
-			spin_unlock_irq(&current->sig->siglock);
+			spin_unlock_irq(&current->sighand->siglock);
 		}
 
 		if (tp->time_to_die)
===== drivers/net/irda/sir_kthread.c 1.2 vs edited =====
--- 1.2/drivers/net/irda/sir_kthread.c	Thu Nov 21 14:06:11 2002
+++ edited/drivers/net/irda/sir_kthread.c	Fri Feb  7 15:59:17 2003
@@ -116,10 +116,10 @@
 	daemonize();
 	strcpy(current->comm, "kIrDAd");
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	set_fs(KERNEL_DS);
 
===== fs/afs/cmservice.c 1.2 vs edited =====
--- 1.2/fs/afs/cmservice.c	Fri Oct 18 00:57:44 2002
+++ edited/fs/afs/cmservice.c	Fri Feb  7 15:59:17 2003
@@ -127,10 +127,10 @@
 	complete(&kafscmd_alive);
 
 	/* only certain signals are of interest */
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	siginitsetinv(&current->blocked,0);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	/* loop around looking for things to attend to */
 	do {
===== fs/afs/internal.h 1.2 vs edited =====
--- 1.2/fs/afs/internal.h	Thu Oct 17 02:18:33 2002
+++ edited/fs/afs/internal.h	Fri Feb  7 15:59:17 2003
@@ -46,9 +46,9 @@
 	while (signal_pending(current)) {
 		siginfo_t sinfo;
 
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		dequeue_signal(&current->blocked,&sinfo);
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 }
 
===== fs/afs/kafsasyncd.c 1.2 vs edited =====
--- 1.2/fs/afs/kafsasyncd.c	Wed Oct 16 05:34:49 2002
+++ edited/fs/afs/kafsasyncd.c	Fri Feb  7 15:59:17 2003
@@ -101,10 +101,10 @@
 	complete(&kafsasyncd_alive);
 
 	/* only certain signals are of interest */
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	siginitsetinv(&current->blocked,0);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	/* loop around looking for things to attend to */
 	do {
===== fs/afs/kafstimod.c 1.2 vs edited =====
--- 1.2/fs/afs/kafstimod.c	Wed Oct 16 05:34:53 2002
+++ edited/fs/afs/kafstimod.c	Fri Feb  7 15:59:17 2003
@@ -78,10 +78,10 @@
 	complete(&kafstimod_alive);
 
 	/* only certain signals are of interest */
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	siginitsetinv(&current->blocked,0);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	/* loop around looking for things to attend to */
  loop:
===== fs/jffs/intrep.c 1.19 vs edited =====
--- 1.19/fs/jffs/intrep.c	Sun Nov 17 12:18:15 2002
+++ edited/fs/jffs/intrep.c	Fri Feb  7 15:59:17 2003
@@ -3347,10 +3347,10 @@
 	current->session = 1;
 	current->pgrp = 1;
 	init_completion(&c->gc_thread_comp); /* barrier */ 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	siginitsetinv (&current->blocked, sigmask(SIGHUP) | sigmask(SIGKILL) | sigmask(SIGSTOP) | sigmask(SIGCONT));
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	strcpy(current->comm, "jffs_gcd");
 
 	D1(printk (KERN_NOTICE "jffs_garbage_collect_thread(): Starting infinite loop.\n"));
@@ -3378,9 +3378,9 @@
 			siginfo_t info;
 			unsigned long signr = 0;
 
-			spin_lock_irq(&current->sig->siglock);
+			spin_lock_irq(&current->sighand->siglock);
 			signr = dequeue_signal(&current->blocked, &info);
-			spin_unlock_irq(&current->sig->siglock);
+			spin_unlock_irq(&current->sighand->siglock);
 
 			switch(signr) {
 			case SIGSTOP:
===== fs/jffs2/os-linux.h 1.8 vs edited =====
--- 1.8/fs/jffs2/os-linux.h	Tue Dec 31 17:25:05 2002
+++ edited/fs/jffs2/os-linux.h	Fri Feb  7 15:59:17 2003
@@ -54,7 +54,7 @@
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,40)
 #define current_sig_lock current->sigmask_lock
 #else
-#define current_sig_lock current->sig->siglock
+#define current_sig_lock current->sighand->siglock
 #endif
 
 static inline void jffs2_init_inode_info(struct jffs2_inode_info *f)
===== fs/jfs/jfs_logmgr.c 1.42 vs edited =====
--- 1.42/fs/jfs/jfs_logmgr.c	Fri Jan 17 12:17:14 2003
+++ edited/fs/jfs/jfs_logmgr.c	Fri Feb  7 15:59:17 2003
@@ -2139,10 +2139,10 @@
 
 	unlock_kernel();
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	complete(&jfsIOwait);
 
===== fs/jfs/jfs_txnmgr.c 1.36 vs edited =====
--- 1.36/fs/jfs/jfs_txnmgr.c	Thu Feb  6 07:33:39 2003
+++ edited/fs/jfs/jfs_txnmgr.c	Fri Feb  7 15:59:17 2003
@@ -2780,10 +2780,10 @@
 
 	jfsCommitTask = current;
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	LAZY_LOCK_INIT();
 	TxAnchor.unlock_queue = TxAnchor.unlock_tail = 0;
@@ -2985,10 +2985,10 @@
 
 	unlock_kernel();
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	complete(&jfsIOwait);
 
===== fs/ncpfs/sock.c 1.12 vs edited =====
--- 1.12/fs/ncpfs/sock.c	Sun Jan  5 19:08:26 2003
+++ edited/fs/ncpfs/sock.c	Fri Feb  7 15:59:17 2003
@@ -745,7 +745,7 @@
 		sigset_t old_set;
 		unsigned long mask, flags;
 
-		spin_lock_irqsave(&current->sig->siglock, flags);
+		spin_lock_irqsave(&current->sighand->siglock, flags);
 		old_set = current->blocked;
 		if (current->flags & PF_EXITING)
 			mask = 0;
@@ -764,7 +764,7 @@
 		}
 		siginitsetinv(&current->blocked, mask);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sig->siglock, flags);
+		spin_unlock_irqrestore(&current->sighand->siglock, flags);
 		
 		fs = get_fs();
 		set_fs(get_ds());
@@ -773,10 +773,10 @@
 
 		set_fs(fs);
 
-		spin_lock_irqsave(&current->sig->siglock, flags);
+		spin_lock_irqsave(&current->sighand->siglock, flags);
 		current->blocked = old_set;
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sig->siglock, flags);
+		spin_unlock_irqrestore(&current->sighand->siglock, flags);
 	}
 
 	DDPRINTK("do_ncp_rpc_call returned %d\n", result);
===== fs/smbfs/smbiod.c 1.5 vs edited =====
--- 1.5/fs/smbfs/smbiod.c	Sun Nov 17 12:38:33 2002
+++ edited/fs/smbfs/smbiod.c	Fri Feb  7 15:59:17 2003
@@ -285,10 +285,10 @@
 	MOD_INC_USE_COUNT;
 	daemonize();
 
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	siginitsetinv(&current->blocked, sigmask(SIGKILL));
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	strcpy(current->comm, "smbiod");
 
===== fs/xfs/pagebuf/page_buf.c 1.36 vs edited =====
--- 1.36/fs/xfs/pagebuf/page_buf.c	Mon Feb  3 10:24:39 2003
+++ edited/fs/xfs/pagebuf/page_buf.c	Fri Feb  7 15:38:12 2003
@@ -1581,10 +1581,10 @@
 	daemonize();
 
 	/* Avoid signals */
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	strcpy(current->comm, "pagebufd");
 	current->flags |= PF_MEMALLOC;
===== include/linux/sched.h 1.125 vs edited =====
--- 1.125/include/linux/sched.h	Fri Feb  7 13:30:24 2003
+++ edited/include/linux/sched.h	Fri Feb  7 15:59:17 2003
@@ -778,7 +778,7 @@
 
 /* Reevaluate whether the task has signals pending delivery.
    This is required every time the blocked sigset_t changes.
-   callers must hold sig->siglock.  */
+   callers must hold sighand->siglock.  */
 
 extern FASTCALL(void recalc_sigpending_tsk(struct task_struct *t));
 extern void recalc_sigpending(void);
===== kernel/suspend.c 1.31 vs edited =====
--- 1.31/kernel/suspend.c	Wed Feb  5 16:00:00 2003
+++ edited/kernel/suspend.c	Fri Feb  7 15:59:17 2003
@@ -218,9 +218,9 @@
 			/* FIXME: smp problem here: we may not access other process' flags
 			   without locking */
 			p->flags |= PF_FREEZE;
-			spin_lock_irqsave(&p->sig->siglock, flags);
+			spin_lock_irqsave(&p->sighand->siglock, flags);
 			signal_wake_up(p, 0);
-			spin_unlock_irqrestore(&p->sig->siglock, flags);
+			spin_unlock_irqrestore(&p->sighand->siglock, flags);
 			todo++;
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
===== net/rxrpc/internal.h 1.2 vs edited =====
--- 1.2/net/rxrpc/internal.h	Wed Oct 16 04:39:21 2002
+++ edited/net/rxrpc/internal.h	Fri Feb  7 15:59:17 2003
@@ -54,9 +54,9 @@
 	while (signal_pending(current)) {
 		siginfo_t sinfo;
 
-		spin_lock_irq(&current->sig->siglock);
+		spin_lock_irq(&current->sighand->siglock);
 		dequeue_signal(&current->blocked,&sinfo);
-		spin_unlock_irq(&current->sig->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
 	}
 }
 
===== net/rxrpc/krxiod.c 1.2 vs edited =====
--- 1.2/net/rxrpc/krxiod.c	Wed Oct 16 05:37:27 2002
+++ edited/net/rxrpc/krxiod.c	Fri Feb  7 15:59:17 2003
@@ -47,10 +47,10 @@
 	daemonize();
 
 	/* only certain signals are of interest */
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	siginitsetinv(&current->blocked,0);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	/* loop around waiting for work to do */
 	do {
===== net/rxrpc/krxsecd.c 1.3 vs edited =====
--- 1.3/net/rxrpc/krxsecd.c	Mon Dec 30 09:11:38 2002
+++ edited/net/rxrpc/krxsecd.c	Fri Feb  7 15:59:17 2003
@@ -59,10 +59,10 @@
 	daemonize();
 
 	/* only certain signals are of interest */
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	siginitsetinv(&current->blocked,0);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	/* loop around waiting for work to do */
 	do {
===== net/rxrpc/krxtimod.c 1.2 vs edited =====
--- 1.2/net/rxrpc/krxtimod.c	Wed Oct 16 05:37:36 2002
+++ edited/net/rxrpc/krxtimod.c	Fri Feb  7 15:59:17 2003
@@ -77,10 +77,10 @@
 	complete(&krxtimod_alive);
 
 	/* only certain signals are of interest */
-	spin_lock_irq(&current->sig->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	siginitsetinv(&current->blocked,0);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 
 	/* loop around looking for things to attend to */
  loop:


Hopefully I got 'em all,

  --cw
