Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVDGTKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVDGTKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 15:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbVDGTJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 15:09:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:44247 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262557AbVDGTIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 15:08:06 -0400
Date: Thu, 7 Apr 2005 12:07:12 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Cc: stable@kernel.org
Subject: Re: Linux 2.6.11.7
Message-ID: <20050407190712.GB4044@kroah.com>
References: <20050407190642.GA4044@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407190642.GA4044@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Nru a/Makefile b/Makefile
--- a/Makefile	2005-04-07 11:59:01 -07:00
+++ b/Makefile	2005-04-07 11:59:01 -07:00
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 11
-EXTRAVERSION = .6
+EXTRAVERSION = .7
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff -Nru a/arch/ia64/kernel/fsys.S b/arch/ia64/kernel/fsys.S
--- a/arch/ia64/kernel/fsys.S	2005-04-07 11:59:01 -07:00
+++ b/arch/ia64/kernel/fsys.S	2005-04-07 11:59:01 -07:00
@@ -611,8 +611,10 @@
 	movl r2=ia64_ret_from_syscall
 	;;
 	mov rp=r2				// set the real return addr
-	tbit.z p8,p0=r3,TIF_SYSCALL_TRACE
+	and r3=_TIF_SYSCALL_TRACEAUDIT,r3
 	;;
+	cmp.eq p8,p0=r3,r0
+
 (p10)	br.cond.spnt.many ia64_ret_from_syscall	// p10==true means out registers are more than 8
 (p8)	br.call.sptk.many b6=b6		// ignore this return addr
 	br.cond.sptk ia64_trace_syscall
diff -Nru a/arch/ia64/kernel/signal.c b/arch/ia64/kernel/signal.c
--- a/arch/ia64/kernel/signal.c	2005-04-07 11:59:01 -07:00
+++ b/arch/ia64/kernel/signal.c	2005-04-07 11:59:01 -07:00
@@ -224,7 +224,8 @@
 	 * could be corrupted.
 	 */
 	retval = (long) &ia64_leave_kernel;
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
+	if (test_thread_flag(TIF_SYSCALL_TRACE)
+	    || test_thread_flag(TIF_SYSCALL_AUDIT))
 		/*
 		 * strace expects to be notified after sigreturn returns even though the
 		 * context to which we return may not be in the middle of a syscall.
diff -Nru a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
--- a/arch/um/kernel/skas/uaccess.c	2005-04-07 11:59:01 -07:00
+++ b/arch/um/kernel/skas/uaccess.c	2005-04-07 11:59:01 -07:00
@@ -61,7 +61,8 @@
 	void *arg;
 	int *res;
 
-	va_copy(args, *(va_list *)arg_ptr);
+	/* Some old gccs recognize __va_copy, but not va_copy */
+	__va_copy(args, *(va_list *)arg_ptr);
 	addr = va_arg(args, unsigned long);
 	len = va_arg(args, int);
 	is_write = va_arg(args, int);
diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	2005-04-07 11:59:01 -07:00
+++ b/drivers/i2c/chips/eeprom.c	2005-04-07 11:59:01 -07:00
@@ -130,7 +130,8 @@
 
 	/* Hide Vaio security settings to regular users (16 first bytes) */
 	if (data->nature == VAIO && off < 16 && !capable(CAP_SYS_ADMIN)) {
-		int in_row1 = 16 - off;
+		size_t in_row1 = 16 - off;
+		in_row1 = min(in_row1, count);
 		memset(buf, 0, in_row1);
 		if (count - in_row1 > 0)
 			memcpy(buf + in_row1, &data->data[16], count - in_row1);
diff -Nru a/fs/jbd/transaction.c b/fs/jbd/transaction.c
--- a/fs/jbd/transaction.c	2005-04-07 11:59:01 -07:00
+++ b/fs/jbd/transaction.c	2005-04-07 11:59:01 -07:00
@@ -1775,10 +1775,10 @@
 			JBUFFER_TRACE(jh, "checkpointed: add to BJ_Forget");
 			ret = __dispose_buffer(jh,
 					journal->j_running_transaction);
+			journal_put_journal_head(jh);
 			spin_unlock(&journal->j_list_lock);
 			jbd_unlock_bh_state(bh);
 			spin_unlock(&journal->j_state_lock);
-			journal_put_journal_head(jh);
 			return ret;
 		} else {
 			/* There is no currently-running transaction. So the
@@ -1789,10 +1789,10 @@
 				JBUFFER_TRACE(jh, "give to committing trans");
 				ret = __dispose_buffer(jh,
 					journal->j_committing_transaction);
+				journal_put_journal_head(jh);
 				spin_unlock(&journal->j_list_lock);
 				jbd_unlock_bh_state(bh);
 				spin_unlock(&journal->j_state_lock);
-				journal_put_journal_head(jh);
 				return ret;
 			} else {
 				/* The orphan record's transaction has
@@ -1813,10 +1813,10 @@
 					journal->j_running_transaction);
 			jh->b_next_transaction = NULL;
 		}
+		journal_put_journal_head(jh);
 		spin_unlock(&journal->j_list_lock);
 		jbd_unlock_bh_state(bh);
 		spin_unlock(&journal->j_state_lock);
-		journal_put_journal_head(jh);
 		return 0;
 	} else {
 		/* Good, the buffer belongs to the running transaction.
diff -Nru a/lib/rwsem-spinlock.c b/lib/rwsem-spinlock.c
--- a/lib/rwsem-spinlock.c	2005-04-07 11:59:01 -07:00
+++ b/lib/rwsem-spinlock.c	2005-04-07 11:59:01 -07:00
@@ -140,12 +140,12 @@
 
 	rwsemtrace(sem, "Entering __down_read");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irq(&sem->wait_lock);
 
 	if (sem->activity >= 0 && list_empty(&sem->wait_list)) {
 		/* granted */
 		sem->activity++;
-		spin_unlock(&sem->wait_lock);
+		spin_unlock_irq(&sem->wait_lock);
 		goto out;
 	}
 
@@ -160,7 +160,7 @@
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we don't need to touch the semaphore struct anymore */
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irq(&sem->wait_lock);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -181,10 +181,12 @@
  */
 int fastcall __down_read_trylock(struct rw_semaphore *sem)
 {
+	unsigned long flags;
 	int ret = 0;
+
 	rwsemtrace(sem, "Entering __down_read_trylock");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	if (sem->activity >= 0 && list_empty(&sem->wait_list)) {
 		/* granted */
@@ -192,7 +194,7 @@
 		ret = 1;
 	}
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving __down_read_trylock");
 	return ret;
@@ -209,12 +211,12 @@
 
 	rwsemtrace(sem, "Entering __down_write");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irq(&sem->wait_lock);
 
 	if (sem->activity == 0 && list_empty(&sem->wait_list)) {
 		/* granted */
 		sem->activity = -1;
-		spin_unlock(&sem->wait_lock);
+		spin_unlock_irq(&sem->wait_lock);
 		goto out;
 	}
 
@@ -229,7 +231,7 @@
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we don't need to touch the semaphore struct anymore */
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irq(&sem->wait_lock);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -250,10 +252,12 @@
  */
 int fastcall __down_write_trylock(struct rw_semaphore *sem)
 {
+	unsigned long flags;
 	int ret = 0;
+
 	rwsemtrace(sem, "Entering __down_write_trylock");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	if (sem->activity == 0 && list_empty(&sem->wait_list)) {
 		/* granted */
@@ -261,7 +265,7 @@
 		ret = 1;
 	}
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving __down_write_trylock");
 	return ret;
@@ -272,14 +276,16 @@
  */
 void fastcall __up_read(struct rw_semaphore *sem)
 {
+	unsigned long flags;
+
 	rwsemtrace(sem, "Entering __up_read");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	if (--sem->activity == 0 && !list_empty(&sem->wait_list))
 		sem = __rwsem_wake_one_writer(sem);
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving __up_read");
 }
@@ -289,15 +295,17 @@
  */
 void fastcall __up_write(struct rw_semaphore *sem)
 {
+	unsigned long flags;
+
 	rwsemtrace(sem, "Entering __up_write");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	sem->activity = 0;
 	if (!list_empty(&sem->wait_list))
 		sem = __rwsem_do_wake(sem, 1);
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving __up_write");
 }
@@ -308,15 +316,17 @@
  */
 void fastcall __downgrade_write(struct rw_semaphore *sem)
 {
+	unsigned long flags;
+
 	rwsemtrace(sem, "Entering __downgrade_write");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	sem->activity = 1;
 	if (!list_empty(&sem->wait_list))
 		sem = __rwsem_do_wake(sem, 0);
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving __downgrade_write");
 }
diff -Nru a/lib/rwsem.c b/lib/rwsem.c
--- a/lib/rwsem.c	2005-04-07 11:59:01 -07:00
+++ b/lib/rwsem.c	2005-04-07 11:59:01 -07:00
@@ -150,7 +150,7 @@
 	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 
 	/* set up my own style of waitqueue */
-	spin_lock(&sem->wait_lock);
+	spin_lock_irq(&sem->wait_lock);
 	waiter->task = tsk;
 	get_task_struct(tsk);
 
@@ -163,7 +163,7 @@
 	if (!(count & RWSEM_ACTIVE_MASK))
 		sem = __rwsem_do_wake(sem, 0);
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irq(&sem->wait_lock);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -219,15 +219,17 @@
  */
 struct rw_semaphore fastcall *rwsem_wake(struct rw_semaphore *sem)
 {
+	unsigned long flags;
+
 	rwsemtrace(sem, "Entering rwsem_wake");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	/* do nothing if list empty */
 	if (!list_empty(&sem->wait_list))
 		sem = __rwsem_do_wake(sem, 0);
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving rwsem_wake");
 
@@ -241,15 +243,17 @@
  */
 struct rw_semaphore fastcall *rwsem_downgrade_wake(struct rw_semaphore *sem)
 {
+	unsigned long flags;
+
 	rwsemtrace(sem, "Entering rwsem_downgrade_wake");
 
-	spin_lock(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	/* do nothing if list empty */
 	if (!list_empty(&sem->wait_list))
 		sem = __rwsem_do_wake(sem, 1);
 
-	spin_unlock(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving rwsem_downgrade_wake");
 	return sem;
diff -Nru a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
--- a/net/ipv4/tcp_input.c	2005-04-07 11:59:01 -07:00
+++ b/net/ipv4/tcp_input.c	2005-04-07 11:59:01 -07:00
@@ -1653,7 +1653,10 @@
 static void tcp_undo_cwr(struct tcp_sock *tp, int undo)
 {
 	if (tp->prior_ssthresh) {
-		tp->snd_cwnd = max(tp->snd_cwnd, tp->snd_ssthresh<<1);
+		if (tcp_is_bic(tp))
+			tp->snd_cwnd = max(tp->snd_cwnd, tp->bictcp.last_max_cwnd);
+		else
+			tp->snd_cwnd = max(tp->snd_cwnd, tp->snd_ssthresh<<1);
 
 		if (undo && tp->prior_ssthresh > tp->snd_ssthresh) {
 			tp->snd_ssthresh = tp->prior_ssthresh;
diff -Nru a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
--- a/net/ipv4/xfrm4_output.c	2005-04-07 11:59:01 -07:00
+++ b/net/ipv4/xfrm4_output.c	2005-04-07 11:59:01 -07:00
@@ -103,16 +103,16 @@
 			goto error_nolock;
 	}
 
-	spin_lock_bh(&x->lock);
-	err = xfrm_state_check(x, skb);
-	if (err)
-		goto error;
-
 	if (x->props.mode) {
 		err = xfrm4_tunnel_check_size(skb);
 		if (err)
-			goto error;
+			goto error_nolock;
 	}
+
+	spin_lock_bh(&x->lock);
+	err = xfrm_state_check(x, skb);
+	if (err)
+		goto error;
 
 	xfrm4_encap(skb);
 
diff -Nru a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
--- a/net/ipv6/xfrm6_output.c	2005-04-07 11:59:01 -07:00
+++ b/net/ipv6/xfrm6_output.c	2005-04-07 11:59:01 -07:00
@@ -103,16 +103,16 @@
 			goto error_nolock;
 	}
 
-	spin_lock_bh(&x->lock);
-	err = xfrm_state_check(x, skb);
-	if (err)
-		goto error;
-
 	if (x->props.mode) {
 		err = xfrm6_tunnel_check_size(skb);
 		if (err)
-			goto error;
+			goto error_nolock;
 	}
+
+	spin_lock_bh(&x->lock);
+	err = xfrm_state_check(x, skb);
+	if (err)
+		goto error;
 
 	xfrm6_encap(skb);
 
diff -Nru a/sound/core/timer.c b/sound/core/timer.c
--- a/sound/core/timer.c	2005-04-07 11:59:01 -07:00
+++ b/sound/core/timer.c	2005-04-07 11:59:01 -07:00
@@ -1117,7 +1117,8 @@
 	if (tu->qused >= tu->queue_size) {
 		tu->overrun++;
 	} else {
-		memcpy(&tu->queue[tu->qtail++], tread, sizeof(*tread));
+		memcpy(&tu->tqueue[tu->qtail++], tread, sizeof(*tread));
+		tu->qtail %= tu->queue_size;
 		tu->qused++;
 	}
 }
@@ -1140,6 +1141,8 @@
 	spin_lock(&tu->qlock);
 	snd_timer_user_append_to_tqueue(tu, &r1);
 	spin_unlock(&tu->qlock);
+	kill_fasync(&tu->fasync, SIGIO, POLL_IN);
+	wake_up(&tu->qchange_sleep);
 }
 
 static void snd_timer_user_tinterrupt(snd_timer_instance_t *timeri,
