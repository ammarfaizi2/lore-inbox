Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261962AbSI3IVa>; Mon, 30 Sep 2002 04:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261965AbSI3IVa>; Mon, 30 Sep 2002 04:21:30 -0400
Received: from angband.namesys.com ([212.16.7.85]:23684 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261962AbSI3IV3>; Mon, 30 Sep 2002 04:21:29 -0400
Date: Mon, 30 Sep 2002 12:26:48 +0400
From: Oleg Drokin <green@namesys.com>
To: jdike@karaya.com, user-mode-linux-user@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: make UML to compile in 2.5 bk-curr
Message-ID: <20020930122648.A14360@namesys.com>
References: <20020930121248.A14194@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020930121248.A14194@namesys.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Sep 30, 2002 at 12:12:48PM +0400, Oleg Drokin wrote:
>    After MIngo's patches named "atomic-thread-signals" and "tq_struct removal
>    fixups.." were merged into bk current, patch below is necessary for
>    UML to compile.

And here is forgotten patch.


===== arch/um/drivers/chan_kern.c 1.1 vs edited =====
--- 1.1/arch/um/drivers/chan_kern.c	Fri Sep  6 21:29:28 2002
+++ edited/arch/um/drivers/chan_kern.c	Mon Sep 30 11:49:05 2002
@@ -409,7 +409,7 @@
 		do {
 			if((tty != NULL) && 
 			   (tty->flip.count >= TTY_FLIPBUF_SIZE)){
-				queue_task(task, &tq_timer);
+				schedule_task(task);
 				goto out;
 			}
 			err = chan->ops->read(chan->fd, &c, chan->data);
===== arch/um/kernel/signal_kern.c 1.1 vs edited =====
--- 1.1/arch/um/kernel/signal_kern.c	Thu Sep 12 16:22:53 2002
+++ edited/arch/um/kernel/signal_kern.c	Mon Sep 30 11:56:06 2002
@@ -101,12 +101,12 @@
 		ka->sa.sa_handler = SIG_DFL;
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sigmask_lock);
+		spin_lock_irq(&current->sig->siglock);
 		sigorsets(&current->blocked, &current->blocked, 
 			  &ka->sa.sa_mask);
 		sigaddset(&current->blocked, signr);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sigmask_lock);
+		spin_unlock_irq(&current->sig->siglock);
 	}
 
 	sp = PT_REGS_SP(regs);
@@ -188,11 +188,11 @@
 	sigset_t saveset;
 
 	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	saveset = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
@@ -214,11 +214,11 @@
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	saveset = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
@@ -234,13 +234,13 @@
 	void *mask = sp_to_mask(PT_REGS_SP(&regs));
 	int sig_size = (_NSIG_WORDS - 1) * sizeof(unsigned long);
 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	copy_from_user(&current->blocked.sig[0], sc_sigmask(sc), 
 		       sizeof(current->blocked.sig[0]));
 	copy_from_user(&current->blocked.sig[1], mask, sig_size);
 	sigdelsetmask(&current->blocked, ~_BLOCKABLE);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 	copy_sc_from_user(current->thread.regs.regs.sc, sc,
 			  &signal_frame_sc.arch);
 	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
@@ -252,11 +252,11 @@
 	void *mask = sp_to_rt_mask(PT_REGS_SP(&regs));
 	int sig_size = _NSIG_WORDS * sizeof(unsigned long);
 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	copy_from_user(&current->blocked, mask, sig_size);
 	sigdelsetmask(&current->blocked, ~_BLOCKABLE);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 	copy_sc_from_user(current->thread.regs.regs.sc, sc,
 			  &signal_frame_sc.arch);
 	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
