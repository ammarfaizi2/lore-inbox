Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130411AbQKILgL>; Thu, 9 Nov 2000 06:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130408AbQKILfv>; Thu, 9 Nov 2000 06:35:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:30354 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130254AbQKILfk>;
	Thu, 9 Nov 2000 06:35:40 -0500
Date: Thu, 9 Nov 2000 03:20:57 -0800
Message-Id: <200011091120.DAA27190@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: andrewm@uow.edu.au
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3A0A8236.2166E00@uow.edu.au> (message from Andrew Morton on Thu,
	09 Nov 2000 21:53:42 +1100)
Subject: Re: [patch] NE2000
In-Reply-To: <200011082031.XAA20453@ms2.inr.ac.ru> (kuznet@ms2.inr.ac.ru),
		<200011082031.XAA20453@ms2.inr.ac.ru> <200011090127.RAA17691@pizda.ninka.net> <3A0A8236.2166E00@uow.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Thu, 09 Nov 2000 21:53:42 +1100
   From: Andrew Morton <andrewm@uow.edu.au>

   "David S. Miller" wrote:
   > I will compose a patch to fix all this.

   I've quickly been through just about all of the kernel wrt
   waitqueues.

My analysis was in error, BEWARE!

Being on multiple wait queues at once is just fine.  I verified this
with Linus tonight.

The problem case is in mixing TASK_EXCLUSIVE and non-TASK_EXCLUSIVE
sleeps, that is what can actually cause problems.

Everything else is fine.  Anyways, the (untested) patch below should
cure the lock_sock() cases.

--- ./net/ipv4/af_inet.c.~1~	Tue Oct 24 14:26:18 2000
+++ ./net/ipv4/af_inet.c	Wed Nov  8 17:28:47 2000
@@ -543,24 +543,27 @@
 {
 	DECLARE_WAITQUEUE(wait, current);
 
-	__set_current_state(TASK_INTERRUPTIBLE);
-	add_wait_queue(sk->sleep, &wait);
-
 	/* Basic assumption: if someone sets sk->err, he _must_
 	 * change state of the socket from TCP_SYN_*.
 	 * Connect() does not allow to get error notifications
 	 * without closing the socket.
 	 */
 	while ((1<<sk->state)&(TCPF_SYN_SENT|TCPF_SYN_RECV)) {
+		__set_current_state(TASK_INTERRUPTIBLE);
+		add_wait_queue(sk->sleep, &wait);
+
 		release_sock(sk);
-		timeo = schedule_timeout(timeo);
+
+		if ((1<<sk->state)&(TCPF_SYN_SENT|TCPF_SYN_RECV))
+			timeo = schedule_timeout(timeo);
+
+		__set_current_state(TASK_RUNNING);
+		remove_wait_queue(sk->sleep, &wait);
+
 		lock_sock(sk);
 		if (signal_pending(current) || !timeo)
 			break;
-		set_current_state(TASK_INTERRUPTIBLE);
 	}
-	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(sk->sleep, &wait);
 	return timeo;
 }
 
--- ./net/ipv4/tcp.c.~1~	Fri Oct  6 15:45:41 2000
+++ ./net/ipv4/tcp.c	Wed Nov  8 17:35:31 2000
@@ -826,10 +826,12 @@
 
 		release_sock(sk);
 		*timeo_p = schedule_timeout(*timeo_p);
-		lock_sock(sk);
 
 		__set_task_state(tsk, TASK_RUNNING);
 		remove_wait_queue(sk->sleep, &wait);
+
+		lock_sock(sk);
+
 		sk->tp_pinfo.af_tcp.write_pending--;
 	}
 	return 0;
@@ -854,24 +856,31 @@
 
 	clear_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);
 
-	add_wait_queue(sk->sleep, &wait);
 	for (;;) {
 		set_bit(SOCK_NOSPACE, &sk->socket->flags);
 
+		add_wait_queue(sk->sleep, &wait);
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (signal_pending(current))
-			break;
-		if (tcp_memory_free(sk) && !vm_wait)
-			break;
-		if (sk->shutdown & SEND_SHUTDOWN)
-			break;
-		if (sk->err)
+		if (signal_pending(current) ||
+		    (tcp_memory_free(sk) && !vm_wait) ||
+		    (sk->shutdown & SEND_SHUTDOWN) ||
+		    sk->err) {
+			current->state = TASK_RUNNING;
+			remove_wait_queue(sk->sleep, &wait);
 			break;
+		}
+
 		release_sock(sk);
+
 		if (!tcp_memory_free(sk) || vm_wait)
 			current_timeo = schedule_timeout(current_timeo);
+
+		current->state = TASK_RUNNING;
+		remove_wait_queue(sk->sleep, &wait);
+
 		lock_sock(sk);
+
 		if (vm_wait) {
 			if (timeo != MAX_SCHEDULE_TIMEOUT &&
 			    (timeo -= vm_wait-current_timeo) < 0)
@@ -881,8 +890,6 @@
 			timeo = current_timeo;
 		}
 	}
-	current->state = TASK_RUNNING;
-	remove_wait_queue(sk->sleep, &wait);
 	return timeo;
 }
 
@@ -1266,7 +1273,6 @@
 	DECLARE_WAITQUEUE(wait, current);
 
 	add_wait_queue(sk->sleep, &wait);
-
 	__set_current_state(TASK_INTERRUPTIBLE);
 
 	set_bit(SOCK_ASYNC_WAITDATA, &sk->socket->flags);
@@ -1275,11 +1281,12 @@
 	if (skb_queue_empty(&sk->receive_queue))
 		timeo = schedule_timeout(timeo);
 
+	remove_wait_queue(sk->sleep, &wait);
+	__set_current_state(TASK_RUNNING);
+
 	lock_sock(sk);
 	clear_bit(SOCK_ASYNC_WAITDATA, &sk->socket->flags);
 
-	remove_wait_queue(sk->sleep, &wait);
-	__set_current_state(TASK_RUNNING);
 	return timeo;
 }
 
@@ -1826,19 +1833,23 @@
 		struct task_struct *tsk = current;
 		DECLARE_WAITQUEUE(wait, current);
 
-		add_wait_queue(sk->sleep, &wait);
-
 		do {
+			add_wait_queue(sk->sleep, &wait);
 			set_current_state(TASK_INTERRUPTIBLE);
-			if (!closing(sk))
+			if (!closing(sk)) {
+				tsk->state = TASK_RUNNING;
+				remove_wait_queue(sk->sleep, &wait);
 				break;
+			}
 			release_sock(sk);
+
 			timeout = schedule_timeout(timeout);
+
+			tsk->state = TASK_RUNNING;
+			remove_wait_queue(sk->sleep, &wait);
+
 			lock_sock(sk);
 		} while (!signal_pending(tsk) && timeout);
-
-		tsk->state = TASK_RUNNING;
-		remove_wait_queue(sk->sleep, &wait);
 	}
 
 adjudge_to_death:
@@ -2009,12 +2020,17 @@
 	 * our exclusiveness temporarily when we get woken up without
 	 * having to remove and re-insert us on the wait queue.
 	 */
-	add_wait_queue_exclusive(sk->sleep, &wait);
 	for (;;) {
+		add_wait_queue_exclusive(sk->sleep, &wait);
 		current->state = TASK_EXCLUSIVE | TASK_INTERRUPTIBLE;
+
 		release_sock(sk);
 		if (sk->tp_pinfo.af_tcp.accept_queue == NULL)
 			timeo = schedule_timeout(timeo);
+
+		current->state = TASK_RUNNING;
+		remove_wait_queue(sk->sleep, &wait);
+
 		lock_sock(sk);
 		err = 0;
 		if (sk->tp_pinfo.af_tcp.accept_queue)
@@ -2029,8 +2045,6 @@
 		if (!timeo)
 			break;
 	}
-	current->state = TASK_RUNNING;
-	remove_wait_queue(sk->sleep, &wait);
 	return err;
 }
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
