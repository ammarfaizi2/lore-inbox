Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWFLIuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWFLIuq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWFLIuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:50:46 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:34700 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751127AbWFLIup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:50:45 -0400
Date: Mon, 12 Jun 2006 10:49:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, Valdis.Kletnieks@vt.edu,
       Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       arjan@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch] undo AF_UNIX _bh locking changes and split lock-type instead
Message-ID: <20060612084936.GA29516@elte.hu>
References: <200606060250.k562oCrA004583@turing-police.cc.vt.edu> <44852819.2080503@gmail.com> <4485798B.4030007@s5r6.in-berlin.de> <4485AFB9.3040005@s5r6.in-berlin.de> <20060607071208.GA1951@gondor.apana.org.au> <20060612063807.GA23939@elte.hu> <20060612064122.GA1101@gondor.apana.org.au> <20060612065701.GA24213@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060612065701.GA24213@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> (the #ifdef LOCKDEP should probably be converted to some sort of 
> lockdep_split_lock_key(&sk->sk_receive_queue.lock) op - i'll do that 
> later)

i've added such an op, lockdep_reinit_lock_key() - this makes the patch 
cleaner:

----------------------
Subject: undo AF_UNIX _bh locking changes and split lock-type
From: Ingo Molnar <mingo@elte.hu>

this cleans up lock-validator-special-locking-af_unix.patch: instead
of adding _bh locking to AF_UNIX, this patch splits their
sk_receive_queue.lock type from the other networking skb-queue locks.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 net/unix/af_unix.c |   18 ++++++++++++++----
 net/unix/garbage.c |    8 ++++----
 2 files changed, 18 insertions(+), 8 deletions(-)

Index: linux/net/unix/af_unix.c
===================================================================
--- linux.orig/net/unix/af_unix.c
+++ linux/net/unix/af_unix.c
@@ -542,6 +542,14 @@ static struct proto unix_proto = {
 	.obj_size = sizeof(struct unix_sock),
 };
 
+/*
+ * AF_UNIX sockets do not interact with hardware, hence they
+ * dont trigger interrupts - so it's safe for them to have
+ * bh-unsafe locking for their sk_receive_queue.lock. Split off
+ * this special lock-type by reinitializing the spinlock key:
+ */
+static struct lockdep_type_key af_unix_sk_receive_queue_lock_key;
+
 static struct sock * unix_create1(struct socket *sock)
 {
 	struct sock *sk = NULL;
@@ -557,6 +565,8 @@ static struct sock * unix_create1(struct
 	atomic_inc(&unix_nr_socks);
 
 	sock_init_data(sock,sk);
+	lockdep_reinit_lock_key(&sk->sk_receive_queue.lock,
+				&af_unix_sk_receive_queue_lock_key);
 
 	sk->sk_write_space	= unix_write_space;
 	sk->sk_max_ack_backlog	= sysctl_unix_max_dgram_qlen;
@@ -1073,12 +1083,12 @@ restart:
 	unix_state_wunlock(sk);
 
 	/* take ten and and send info to listening sock */
-	spin_lock_bh(&other->sk_receive_queue.lock);
+	spin_lock(&other->sk_receive_queue.lock);
 	__skb_queue_tail(&other->sk_receive_queue, skb);
 	/* Undo artificially decreased inflight after embrion
 	 * is installed to listening socket. */
 	atomic_inc(&newu->inflight);
-	spin_unlock_bh(&other->sk_receive_queue.lock);
+	spin_unlock(&other->sk_receive_queue.lock);
 	unix_state_runlock(other);
 	other->sk_data_ready(other, 0);
 	sock_put(other);
@@ -1843,7 +1853,7 @@ static int unix_ioctl(struct socket *soc
 				break;
 			}
 
-			spin_lock_bh(&sk->sk_receive_queue.lock);
+			spin_lock(&sk->sk_receive_queue.lock);
 			if (sk->sk_type == SOCK_STREAM ||
 			    sk->sk_type == SOCK_SEQPACKET) {
 				skb_queue_walk(&sk->sk_receive_queue, skb)
@@ -1853,7 +1863,7 @@ static int unix_ioctl(struct socket *soc
 				if (skb)
 					amount=skb->len;
 			}
-			spin_unlock_bh(&sk->sk_receive_queue.lock);
+			spin_unlock(&sk->sk_receive_queue.lock);
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
 
-		spin_lock_bh(&x->sk_receive_queue.lock);
+		spin_lock(&x->sk_receive_queue.lock);
 		skb = skb_peek(&x->sk_receive_queue);
 		
 		/*
@@ -270,7 +270,7 @@ void unix_gc(void)
 				maybe_unmark_and_push(skb->sk);
 			skb=skb->next;
 		}
-		spin_unlock_bh(&x->sk_receive_queue.lock);
+		spin_unlock(&x->sk_receive_queue.lock);
 		sock_put(x);
 	}
 
@@ -283,7 +283,7 @@ void unix_gc(void)
 		if (u->gc_tree == GC_ORPHAN) {
 			struct sk_buff *nextsk;
 
-			spin_lock_bh(&s->sk_receive_queue.lock);
+			spin_lock(&s->sk_receive_queue.lock);
 			skb = skb_peek(&s->sk_receive_queue);
 			while (skb &&
 			       skb != (struct sk_buff *)&s->sk_receive_queue) {
@@ -298,7 +298,7 @@ void unix_gc(void)
 				}
 				skb = nextsk;
 			}
-			spin_unlock_bh(&s->sk_receive_queue.lock);
+			spin_unlock(&s->sk_receive_queue.lock);
 		}
 		u->gc_tree = GC_ORPHAN;
 	}

