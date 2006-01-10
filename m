Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWAJUSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWAJUSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWAJUSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:18:37 -0500
Received: from canuck.infradead.org ([205.233.218.70]:55481 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932568AbWAJUSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:18:35 -0500
Subject: [PATCH] [2/6] TIF_RESTORE_SIGMASK support for arch/powerpc
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com
In-Reply-To: <1136923488.3435.78.camel@localhost.localdomain>
References: <1136923488.3435.78.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 20:18:35 +0000
Message-Id: <1136924316.3435.104.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.2 (/)
X-Spam-Report: SpamAssassin version 3.0.4 on canuck.infradead.org summary:
	Content analysis details:   (0.2 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.2 UPPERCASE_25_50        message body is 25-50% uppercase
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the TIF_RESTORE_SIGMASK flag in the new
arch/powerpc kernel, for both 32-bit and 64-bit system call paths.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

 arch/powerpc/kernel/entry_32.S    |    8 ++++----
 arch/powerpc/kernel/entry_64.S    |    2 +-
 arch/powerpc/kernel/signal_32.c   |   20 +++++++++++++++-----
 arch/powerpc/kernel/signal_64.c   |   20 ++++++++++++++++++--
 arch/powerpc/kernel/systbl.S      |    2 ++
 include/asm-powerpc/thread_info.h |    5 ++++-
 include/asm-powerpc/unistd.h      |    4 +++-
 7 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 036b71d..6aa7386 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -227,7 +227,7 @@ ret_from_syscall:
 	MTMSRD(r10)
 	lwz	r9,TI_FLAGS(r12)
 	li	r8,-_LAST_ERRNO
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL)
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL|_TIF_RESTORE_SIGMASK)
 	bne-	syscall_exit_work
 	cmplw	0,r3,r8
 	blt+	syscall_exit_cont
@@ -357,7 +357,7 @@ save_user_nvgprs_cont:
 	lwz	r5,_MSR(r1)
 	andi.	r5,r5,MSR_PR
 	beq	ret_from_except
-	andi.	r0,r9,_TIF_SIGPENDING
+	andi.	r0,r9,_TIF_SIGPENDING|_TIF_RESTORE_SIGMASK
 	beq	ret_from_except
 	b	do_user_signal
 8:
@@ -683,7 +683,7 @@ user_exc_return:		/* r10 contains MSR_KE
 	/* Check current_thread_info()->flags */
 	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
 	lwz	r9,TI_FLAGS(r9)
-	andi.	r0,r9,(_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL)
+	andi.	r0,r9,(_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL|_TIF_RESTORE_SIGMASK)
 	bne	do_work
 
 restore_user:
@@ -917,7 +917,7 @@ recheck:
 	lwz	r9,TI_FLAGS(r9)
 	andi.	r0,r9,_TIF_NEED_RESCHED
 	bne-	do_resched
-	andi.	r0,r9,_TIF_SIGPENDING
+	andi.	r0,r9,_TIF_SIGPENDING|_TIF_RESTORE_SIGMASK
 	beq	restore_user
 do_user_signal:			/* r10 contains MSR_KERNEL here */
 	ori	r10,r10,MSR_EE
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index aacebb3..b267045 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -160,7 +160,7 @@ syscall_exit:
 	mtmsrd	r10,1
 	ld	r9,TI_FLAGS(r12)
 	li	r11,-_LAST_ERRNO
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL|_TIF_SAVE_NVGPRS|_TIF_NOERROR)
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL|_TIF_SAVE_NVGPRS|_TIF_NOERROR|_TIF_RESTORE_SIGMASK)
 	bne-	syscall_exit_work
 	cmpld	r3,r11
 	ld	r5,_CCR(r1)
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index d3f0b6d..784a4c2 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1177,7 +1177,7 @@ int do_signal(sigset_t *oldset, struct p
 {
 	siginfo_t info;
 	struct k_sigaction ka;
-	unsigned int frame, newsp;
+	unsigned int newsp;
 	int signr, ret;
 
 #ifdef CONFIG_PPC32
@@ -1188,11 +1188,11 @@ int do_signal(sigset_t *oldset, struct p
 	}
 #endif
 
-	if (!oldset)
+	if (test_thread_flag(TIF_RESTORE_SIGMASK))
+		oldset = &current->saved_sigmask;
+	else if (!oldset)
 		oldset = &current->blocked;
 
-	newsp = frame = 0;
-
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 #ifdef CONFIG_PPC32
 no_signal:
@@ -1222,8 +1222,14 @@ no_signal:
 		}
 	}
 
-	if (signr == 0)
+	if (signr == 0) {
+		/* No signal to deliver -- put the saved sigmask back */
+		if (test_thread_flag(TIF_RESTORE_SIGMASK)) {
+			clear_thread_flag(TIF_RESTORE_SIGMASK);
+			sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
+		}
 		return 0;		/* no signals delivered */
+	}
 
 	if ((ka.sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
 	    && !on_sig_stack(regs->gpr[1]))
@@ -1256,6 +1262,10 @@ no_signal:
 			sigaddset(&current->blocked, signr);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
+		/* A signal was successfully delivered; the saved sigmask is in
+		   its frame, and we can clear the TIF_RESTORE_SIGMASK flag */
+		if (test_thread_flag(TIF_RESTORE_SIGMASK))
+			clear_thread_flag(TIF_RESTORE_SIGMASK);
 	}
 
 	return ret;
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 5462bef..2903e11 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -554,11 +554,15 @@ int do_signal(sigset_t *oldset, struct p
 	if (test_thread_flag(TIF_32BIT))
 		return do_signal32(oldset, regs);
 
-	if (!oldset)
+	if (test_thread_flag(TIF_RESTORE_SIGMASK))
+		oldset = &current->saved_sigmask;
+	else if (!oldset)
 		oldset = &current->blocked;
 
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
+		int ret;
+
 		/* Whee!  Actually deliver the signal.  */
 		if (TRAP(regs) == 0x0C00)
 			syscall_restart(regs, &ka);
@@ -571,7 +575,14 @@ int do_signal(sigset_t *oldset, struct p
 		if (current->thread.dabr)
 			set_dabr(current->thread.dabr);
 
-		return handle_signal(signr, &ka, &info, oldset, regs);
+		ret = handle_signal(signr, &ka, &info, oldset, regs);
+
+		/* If a signal was successfully delivered, the saved sigmask is in
+		   its frame, and we can clear the TIF_RESTORE_SIGMASK flag */
+		if (ret && test_thread_flag(TIF_RESTORE_SIGMASK))
+			clear_thread_flag(TIF_RESTORE_SIGMASK);
+
+		return ret;
 	}
 
 	if (TRAP(regs) == 0x0C00) {	/* System Call! */
@@ -587,6 +598,11 @@ int do_signal(sigset_t *oldset, struct p
 			regs->result = 0;
 		}
 	}
+	/* No signal to deliver -- put the saved sigmask back */
+	if (test_thread_flag(TIF_RESTORE_SIGMASK)) {
+		clear_thread_flag(TIF_RESTORE_SIGMASK);
+		sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
+	}
 
 	return 0;
 }
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 6801317..007b15e 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -321,3 +321,5 @@ SYSCALL(inotify_add_watch)
 SYSCALL(inotify_rm_watch)
 SYSCALL(spu_run)
 SYSCALL(spu_create)
+COMPAT_SYS(pselect6)
+COMPAT_SYS(ppoll)
diff --git a/include/asm-powerpc/thread_info.h b/include/asm-powerpc/thread_info.h
index ac1e80e..27f1312 100644
--- a/include/asm-powerpc/thread_info.h
+++ b/include/asm-powerpc/thread_info.h
@@ -125,6 +125,7 @@ static inline struct thread_info *curren
 #define TIF_RESTOREALL		12	/* Restore all regs (implies NOERROR) */
 #define TIF_SAVE_NVGPRS		13	/* Save r14-r31 in signal frame */
 #define TIF_NOERROR		14	/* Force successful syscall return */
+#define TIF_RESTORE_SIGMASK	15	/* Restore signal mask in do_signal */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -141,10 +142,12 @@ static inline struct thread_info *curren
 #define _TIF_RESTOREALL		(1<<TIF_RESTOREALL)
 #define _TIF_SAVE_NVGPRS	(1<<TIF_SAVE_NVGPRS)
 #define _TIF_NOERROR		(1<<TIF_NOERROR)
+#define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
 #define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP)
 
 #define _TIF_USER_WORK_MASK	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | \
-				 _TIF_NEED_RESCHED | _TIF_RESTOREALL)
+				 _TIF_NEED_RESCHED | _TIF_RESTOREALL | \
+				 _TIF_RESTORE_SIGMASK)
 #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR|_TIF_SAVE_NVGPRS)
 
 #endif /* __KERNEL__ */
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index 19eaac3..e9cb713 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -298,8 +298,10 @@
 #define __NR_inotify_rm_watch	277
 #define __NR_spu_run		278
 #define __NR_spu_create		279
+#define __NR_pselect6		280
+#define __NR_ppoll		281
 
-#define __NR_syscalls		280
+#define __NR_syscalls		282
 
 #ifdef __KERNEL__
 #define __NR__exit __NR_exit

-- 
dwmw2

