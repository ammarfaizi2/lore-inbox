Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288981AbSAITwO>; Wed, 9 Jan 2002 14:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288983AbSAITwA>; Wed, 9 Jan 2002 14:52:00 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:43272 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S288981AbSAITu0>;
	Wed, 9 Jan 2002 14:50:26 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200201091949.WAA21218@ms2.inr.ac.ru>
Subject: Re: [PATCH] removed socket buffer in unix domain socket
To: alan@lxorguk.UKuu.ORG.UK (Alan Cox)
Date: Wed, 9 Jan 2002 22:49:35 +0300 (MSK)
Cc: yasuma@miraclelinux.COM, viro@math.psu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <E16NaD0-0001Hs-00@the-village.bc.nu> from "Alan Cox" at Jan 8, 2 12:45:24 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The bug may be real

Yes, it is... There is window when socket is already in hash table
(and visible by gc) but still not referenced by listening socket.
It is nice for everything, but GC fairly concludes that such socket
is orphan. Damn. It is even no related to SMP, the problem is present
in 2.2 as well if we sleep in sock_wmalloc...

Well, the following ugly patch is supposed to cure this. (Please, check)

To explain: embrion while it is in flight can be marked for GC to see
that it is not orphan. Deflated inflight counter is ugly but valid marker.

In 2.2 interning to hash table can be moved to point after enqueueing
to listening socket or to an area protected by kernel lock.
This is impossible in 2.4, and I see no solution but marking.

Alexey


diff -ur ../t/vger3-011229+local/linux/net/unix/af_unix.c linux/net/unix/af_unix.c
--- ../t/vger3-011229+local/linux/net/unix/af_unix.c	Sat Jan  5 04:30:19 2002
+++ linux/net/unix/af_unix.c	Wed Jan  9 03:28:44 2002
@@ -484,7 +484,7 @@
 	sk->protinfo.af_unix.dentry=NULL;
 	sk->protinfo.af_unix.mnt=NULL;
 	sk->protinfo.af_unix.lock = RW_LOCK_UNLOCKED;
-	atomic_set(&sk->protinfo.af_unix.inflight, 0);
+	atomic_set(&sk->protinfo.af_unix.inflight, sock ? 0 : -1);
 	init_MUTEX(&sk->protinfo.af_unix.readsem);/* single task reading lock */
 	init_waitqueue_head(&sk->protinfo.af_unix.peer_wait);
 	sk->protinfo.af_unix.list=NULL;
@@ -991,7 +991,12 @@
 	unix_state_wunlock(sk);
 
 	/* take ten and and send info to listening sock */
-	skb_queue_tail(&other->receive_queue,skb);
+	spin_lock(&other->receive_queue.lock);
+	__skb_queue_tail(&other->receive_queue,skb);
+	/* Undo artificially decreased inflight after embrion
+	 * is installed to listening socket. */
+	atomic_inc(&newsk->protinfo.af_unix.inflight);
+	spin_unlock(&other->receive_queue.lock);
 	unix_state_runlock(other);
 	other->data_ready(other, 0);
 	sock_put(other);
diff -ur ../t/vger3-011229+local/linux/net/unix/garbage.c linux/net/unix/garbage.c
--- ../t/vger3-011229+local/linux/net/unix/garbage.c	Fri Jul 20 22:12:11 2001
+++ linux/net/unix/garbage.c	Wed Jan  9 03:27:49 2002
@@ -205,12 +205,21 @@
 
 	forall_unix_sockets(i, s)
 	{
+		int open_count = 0;
+
 		/*
 		 *	If all instances of the descriptor are not
 		 *	in flight we are in use.
+		 *
+		 *	Special case: when socket s is embrion, it may be
+		 *	hashed but still not in queue of listening socket.
+		 *	In this case (see unix_create1()) we set artificial
+		 *	negative inflight counter to close race window.
+		 *	It is trick of course and dirty one.
 		 */
-		if(s->socket && s->socket->file &&
-		   file_count(s->socket->file) > atomic_read(&s->protinfo.af_unix.inflight))
+		if(s->socket && s->socket->file)
+			open_count = file_count(s->socket->file);
+		if (open_count > atomic_read(&s->protinfo.af_unix.inflight))
 			maybe_unmark_and_push(s);
 	}
 
