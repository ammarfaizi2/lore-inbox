Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265541AbUGDLuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265541AbUGDLuI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 07:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265542AbUGDLuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 07:50:08 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:3214 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265541AbUGDLtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 07:49:49 -0400
Message-ID: <40E7EEB5.5050502@colorfullife.com>
Date: Sun, 04 Jul 2004 13:49:09 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup of ipc/msg.c
References: <40E72EAE.2060806@colorfullife.com>
In-Reply-To: <40E72EAE.2060806@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------050303000206070209020400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050303000206070209020400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Now I've really attached the lockless receive patch. The previous patch 
[that I forgot to attach] was buggy, attached is an updated and tested 
patch:

Description:
- General cleanup of sys_msgrcv and sys_msgsnd: the function were too 
convoluted.
- Enable lockless receive, update comments.
- Use ipc_getref for sys_msgsnd(), it's better than rechecking that the 
msqid is still valid.

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>


--------------050303000206070209020400
Content-Type: text/plain;
 name="patch-ipc-04-msg_lockless"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ipc-04-msg_lockless"

--- 2.6/ipc/msg.c	2004-07-04 13:21:52.783832608 +0200
+++ build-2.6/ipc/msg.c	2004-07-04 11:18:53.785610848 +0200
@@ -163,8 +163,10 @@
 		
 		msr = list_entry(tmp,struct msg_receiver,r_list);
 		tmp = tmp->next;
-		msr->r_msg = ERR_PTR(res);
+		msr->r_msg = NULL;
 		wake_up_process(msr->r_tsk);
+		smp_mb();
+		msr->r_msg = ERR_PTR(res);
 	}
 }
 /* 
@@ -525,13 +527,17 @@
 		   !security_msg_queue_msgrcv(msq, msg, msr->r_tsk, msr->r_msgtype, msr->r_mode)) {
 			list_del(&msr->r_list);
 			if(msr->r_maxsize < msg->m_ts) {
-				msr->r_msg = ERR_PTR(-E2BIG);
+				msr->r_msg = NULL;
 				wake_up_process(msr->r_tsk);
+				smp_mb();
+				msr->r_msg = ERR_PTR(-E2BIG);
 			} else {
-				msr->r_msg = msg;
+				msr->r_msg = NULL;
 				msq->q_lrpid = msr->r_tsk->pid;
 				msq->q_rtime = get_seconds();
 				wake_up_process(msr->r_tsk);
+				smp_mb();
+				msr->r_msg = msg;
 				return 1;
 			}
 		}
@@ -564,43 +570,49 @@
 	err=-EINVAL;
 	if(msq==NULL)
 		goto out_free;
-retry:
+
 	err= -EIDRM;
 	if (msg_checkid(msq,msqid))
 		goto out_unlock_free;
 
-	err=-EACCES;
-	if (ipcperms(&msq->q_perm, S_IWUGO)) 
-		goto out_unlock_free;
+	for (;;) {
+		struct msg_sender s;
 
-	err = security_msg_queue_msgsnd(msq, msg, msgflg);
-	if (err)
-		goto out_unlock_free;
+		err=-EACCES;
+		if (ipcperms(&msq->q_perm, S_IWUGO)) 
+			goto out_unlock_free;
 
-	if(msgsz + msq->q_cbytes > msq->q_qbytes ||
-		1 + msq->q_qnum > msq->q_qbytes) {
-		struct msg_sender s;
+		err = security_msg_queue_msgsnd(msq, msg, msgflg);
+		if (err)
+			goto out_unlock_free;
 
+		if(msgsz + msq->q_cbytes <= msq->q_qbytes && 
+				1 + msq->q_qnum <= msq->q_qbytes) {
+			break;
+		}
+
+		/* queue full, wait: */
 		if(msgflg&IPC_NOWAIT) {
 			err=-EAGAIN;
 			goto out_unlock_free;
 		}
 		ss_add(msq, &s);
+		ipc_rcu_getref(msq);
 		msg_unlock(msq);
 		schedule();
-		current->state= TASK_RUNNING;
 
-		msq = msg_lock(msqid);
-		err = -EIDRM;
-		if(msq==NULL)
-			goto out_free;
+		ipc_lock_by_ptr(&msq->q_perm);
+		ipc_rcu_putref(msq);
+		if (msq->q_perm.deleted) {
+			err = -EIDRM;
+			goto out_unlock_free;
+		}
 		ss_del(&s);
 		
 		if (signal_pending(current)) {
-			err=-EINTR;
+			err=-ERESTARTNOHAND;
 			goto out_unlock_free;
 		}
-		goto retry;
 	}
 
 	msq->q_lspid = current->tgid;
@@ -649,10 +661,7 @@
 			    long msgtyp, int msgflg)
 {
 	struct msg_queue *msq;
-	struct msg_receiver msr_d;
-	struct list_head* tmp;
-	struct msg_msg* msg, *found_msg;
-	int err;
+	struct msg_msg *msg;
 	int mode;
 
 	if (msqid < 0 || (long) msgsz < 0)
@@ -662,62 +671,57 @@
 	msq = msg_lock(msqid);
 	if(msq==NULL)
 		return -EINVAL;
-retry:
-	err = -EIDRM;
+
+	msg = ERR_PTR(-EIDRM);
 	if (msg_checkid(msq,msqid))
 		goto out_unlock;
 
-	err=-EACCES;
-	if (ipcperms (&msq->q_perm, S_IRUGO))
-		goto out_unlock;
+	for (;;) {
+		struct msg_receiver msr_d;
+		struct list_head* tmp;
 
-	tmp = msq->q_messages.next;
-	found_msg=NULL;
-	while (tmp != &msq->q_messages) {
-		msg = list_entry(tmp,struct msg_msg,m_list);
-		if(testmsg(msg,msgtyp,mode) &&
-		   !security_msg_queue_msgrcv(msq, msg, current, msgtyp, mode)) {
-			found_msg = msg;
-			if(mode == SEARCH_LESSEQUAL && msg->m_type != 1) {
-				found_msg=msg;
-				msgtyp=msg->m_type-1;
-			} else {
-				found_msg=msg;
-				break;
-			}
-		}
-		tmp = tmp->next;
-	}
-	if(found_msg) {
-		msg=found_msg;
-		if ((msgsz < msg->m_ts) && !(msgflg & MSG_NOERROR)) {
-			err=-E2BIG;
+		msg = ERR_PTR(-EACCES);
+		if (ipcperms (&msq->q_perm, S_IRUGO))
 			goto out_unlock;
+
+		msg = ERR_PTR(-EAGAIN);
+		tmp = msq->q_messages.next;
+		while (tmp != &msq->q_messages) {
+			struct msg_msg *walk_msg;
+			walk_msg = list_entry(tmp,struct msg_msg,m_list);
+			if(testmsg(walk_msg,msgtyp,mode) &&
+			   !security_msg_queue_msgrcv(msq, walk_msg, current, msgtyp, mode)) {
+				msg = walk_msg;
+				if(mode == SEARCH_LESSEQUAL && walk_msg->m_type != 1) {
+					msg=walk_msg;
+					msgtyp=walk_msg->m_type-1;
+				} else {
+					msg=walk_msg;
+					break;
+				}
+			}
+			tmp = tmp->next;
 		}
-		list_del(&msg->m_list);
-		msq->q_qnum--;
-		msq->q_rtime = get_seconds();
-		msq->q_lrpid = current->tgid;
-		msq->q_cbytes -= msg->m_ts;
-		atomic_sub(msg->m_ts,&msg_bytes);
-		atomic_dec(&msg_hdrs);
-		ss_wakeup(&msq->q_senders,0);
-		msg_unlock(msq);
-out_success:
-		msgsz = (msgsz > msg->m_ts) ? msg->m_ts : msgsz;
-		if (put_user (msg->m_type, &msgp->mtype) ||
-		    store_msg(msgp->mtext, msg, msgsz)) {
-			    msgsz = -EFAULT;
+		if(!IS_ERR(msg)) {
+			/* Found a suitable message. Unlink it from the queue. */
+			if ((msgsz < msg->m_ts) && !(msgflg & MSG_NOERROR)) {
+				msg = ERR_PTR(-E2BIG);
+				goto out_unlock;
+			}
+			list_del(&msg->m_list);
+			msq->q_qnum--;
+			msq->q_rtime = get_seconds();
+			msq->q_lrpid = current->tgid;
+			msq->q_cbytes -= msg->m_ts;
+			atomic_sub(msg->m_ts,&msg_bytes);
+			atomic_dec(&msg_hdrs);
+			ss_wakeup(&msq->q_senders,0);
+			msg_unlock(msq);
+			break;
 		}
-		free_msg(msg);
-		return msgsz;
-	} else
-	{
-		/* no message waiting. Prepare for pipelined
-		 * receive.
-		 */
+		/* No message waiting. Wait for a message */
 		if (msgflg & IPC_NOWAIT) {
-			err=-ENOMSG;
+			msg = ERR_PTR(-ENOMSG);
 			goto out_unlock;
 		}
 		list_add_tail(&msr_d.r_list,&msq->q_receivers);
@@ -727,52 +731,76 @@
 		if(msgflg & MSG_NOERROR)
 			msr_d.r_maxsize = INT_MAX;
 		 else
-		 	msr_d.r_maxsize = msgsz;
+			msr_d.r_maxsize = msgsz;
 		msr_d.r_msg = ERR_PTR(-EAGAIN);
 		current->state = TASK_INTERRUPTIBLE;
 		msg_unlock(msq);
 
 		schedule();
 
-		/*
-		 * The below optimisation is buggy.  A sleeping thread that is
-		 * woken up checks if it got a message and if so, copies it to
-		 * userspace and just returns without taking any locks.
-		 * But this return to user space can be faster than the message
-		 * send, and if the receiver immediately exits the
-		 * wake_up_process performed by the sender will oops.
+		/* Lockless receive, part 1:
+		 * Disable preemption.  We don't hold a reference to the queue
+		 * and getting a reference would defeat the idea of a lockless
+		 * operation, thus the code relies on rcu to guarantee the
+		 * existance of msq:
+		 * Prior to destruction, expunge_all(-EIRDM) changes r_msg.
+		 * Thus if r_msg is -EAGAIN, then the queue not yet destroyed.
+		 * rcu_read_lock() prevents preemption between reading r_msg
+		 * and the spin_lock() inside ipc_lock_by_ptr().
+		 */
+		rcu_read_lock();
+
+		/* Lockless receive, part 2:
+		 * Wait until pipelined_send or expunge_all are outside of
+		 * wake_up_process(). There is a race with exit(), see
+		 * ipc/mqueue.c for the details.
 		 */
-#if 0
 		msg = (struct msg_msg*) msr_d.r_msg;
-		if(!IS_ERR(msg)) 
-			goto out_success;
-#endif
+		while (msg == NULL) {
+			cpu_relax();
+			msg = (struct msg_msg*) msr_d.r_msg;
+		}
 
-		msq = msg_lock(msqid);
+		/* Lockless receive, part 3:
+		 * If there is a message or an error then accept it without
+		 * locking.
+		 */
+		if(msg != ERR_PTR(-EAGAIN)) {
+			rcu_read_unlock();
+			break;
+		}
+
+		/* Lockless receive, part 3:
+		 * Acquire the queue spinlock.
+		 */
+		ipc_lock_by_ptr(&msq->q_perm);
+		rcu_read_unlock();
+
+		/* Lockless receive, part 4:
+		 * Repeat test after acquiring the spinlock.
+		 */
 		msg = (struct msg_msg*)msr_d.r_msg;
-		if(!IS_ERR(msg)) {
-			/* our message arived while we waited for
-			 * the spinlock. Process it.
-			 */
-			if(msq)
-				msg_unlock(msq);
-			goto out_success;
-		}
-		err = PTR_ERR(msg);
-		if(err == -EAGAIN) {
-			if(!msq)
-				BUG();
-			list_del(&msr_d.r_list);
-			if (signal_pending(current))
-				err=-EINTR;
-			 else
-				goto retry;
+		if(msg != ERR_PTR(-EAGAIN))
+			goto out_unlock;
+
+		list_del(&msr_d.r_list);
+		if (signal_pending(current)) {
+			msg = ERR_PTR(-ERESTARTNOHAND);
+out_unlock:
+			msg_unlock(msq);
+			break;
 		}
 	}
-out_unlock:
-	if(msq)
-		msg_unlock(msq);
-	return err;
+	if (IS_ERR(msg))
+       		return PTR_ERR(msg);
+
+	msgsz = (msgsz > msg->m_ts) ? msg->m_ts : msgsz;
+	if (put_user (msg->m_type, &msgp->mtype) ||
+	    store_msg(msgp->mtext, msg, msgsz)) {
+		    msgsz = -EFAULT;
+	}
+	free_msg(msg);
+	return msgsz;
 }
 
 #ifdef CONFIG_PROC_FS

--------------050303000206070209020400--
