Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWE2V3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWE2V3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWE2V1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:27:20 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:37867 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751376AbWE2V06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:26:58 -0400
Date: Mon, 29 May 2006 23:27:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 52/61] lock validator: special locking: af_unix
Message-ID: <20060529212719.GZ3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (recursive) locking code to the lock validator. Has no
effect on non-lockdep kernels.

(includes workaround for sk_receive_queue.lock, which is currently
treated globally by the lock validator, but which be switched to
per-address-family locking rules.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 include/net/af_unix.h |    3 +++
 net/unix/af_unix.c    |   10 +++++-----
 net/unix/garbage.c    |    8 ++++----
 3 files changed, 12 insertions(+), 9 deletions(-)

Index: linux/include/net/af_unix.h
===================================================================
--- linux.orig/include/net/af_unix.h
+++ linux/include/net/af_unix.h
@@ -61,6 +61,9 @@ struct unix_skb_parms {
 #define unix_state_rlock(s)	spin_lock(&unix_sk(s)->lock)
 #define unix_state_runlock(s)	spin_unlock(&unix_sk(s)->lock)
 #define unix_state_wlock(s)	spin_lock(&unix_sk(s)->lock)
+#define unix_state_wlock_nested(s) \
+				spin_lock_nested(&unix_sk(s)->lock, \
+				SINGLE_DEPTH_NESTING)
 #define unix_state_wunlock(s)	spin_unlock(&unix_sk(s)->lock)
 
 #ifdef __KERNEL__
Index: linux/net/unix/af_unix.c
===================================================================
--- linux.orig/net/unix/af_unix.c
+++ linux/net/unix/af_unix.c
@@ -1022,7 +1022,7 @@ restart:
 		goto out_unlock;
 	}
 
-	unix_state_wlock(sk);
+	unix_state_wlock_nested(sk);
 
 	if (sk->sk_state != st) {
 		unix_state_wunlock(sk);
@@ -1073,12 +1073,12 @@ restart:
 	unix_state_wunlock(sk);
 
 	/* take ten and and send info to listening sock */
-	spin_lock(&other->sk_receive_queue.lock);
+	spin_lock_bh(&other->sk_receive_queue.lock);
 	__skb_queue_tail(&other->sk_receive_queue, skb);
 	/* Undo artificially decreased inflight after embrion
 	 * is installed to listening socket. */
 	atomic_inc(&newu->inflight);
-	spin_unlock(&other->sk_receive_queue.lock);
+	spin_unlock_bh(&other->sk_receive_queue.lock);
 	unix_state_runlock(other);
 	other->sk_data_ready(other, 0);
 	sock_put(other);
@@ -1843,7 +1843,7 @@ static int unix_ioctl(struct socket *soc
 				break;
 			}
 
-			spin_lock(&sk->sk_receive_queue.lock);
+			spin_lock_bh(&sk->sk_receive_queue.lock);
 			if (sk->sk_type == SOCK_STREAM ||
 			    sk->sk_type == SOCK_SEQPACKET) {
 				skb_queue_walk(&sk->sk_receive_queue, skb)
@@ -1853,7 +1853,7 @@ static int unix_ioctl(struct socket *soc
 				if (skb)
 					amount=skb->len;
 			}
-			spin_unlock(&sk->sk_receive_queue.lock);
+			spin_unlock_bh(&sk->sk_receive_queue.lock);
 			err = put_user(amount, (int __user *)arg);
 			break;
 		}
Index: linux/net/unix/garbage.c
===================================================================
--- linux.orig/net/unix/garbage.c
+++ linux/net/unix/garbage.c
@@ -235,7 +235,7 @@ void unix_gc(void)
 		struct sock *x = pop_stack();
 		struct sock *sk;
 
-		spin_lock(&x->sk_receive_queue.lock);
+		spin_lock_bh(&x->sk_receive_queue.lock);
 		skb = skb_peek(&x->sk_receive_queue);
 		
 		/*
@@ -270,7 +270,7 @@ void unix_gc(void)
 				maybe_unmark_and_push(skb->sk);
 			skb=skb->next;
 		}
-		spin_unlock(&x->sk_receive_queue.lock);
+		spin_unlock_bh(&x->sk_receive_queue.lock);
 		sock_put(x);
 	}
 
@@ -283,7 +283,7 @@ void unix_gc(void)
 		if (u->gc_tree == GC_ORPHAN) {
 			struct sk_buff *nextsk;
 
-			spin_lock(&s->sk_receive_queue.lock);
+			spin_lock_bh(&s->sk_receive_queue.lock);
 			skb = skb_peek(&s->sk_receive_queue);
 			while (skb &&
 			       skb != (struct sk_buff *)&s->sk_receive_queue) {
@@ -298,7 +298,7 @@ void unix_gc(void)
 				}
 				skb = nextsk;
 			}
-			spin_unlock(&s->sk_receive_queue.lock);
+			spin_unlock_bh(&s->sk_receive_queue.lock);
 		}
 		u->gc_tree = GC_ORPHAN;
 	}
