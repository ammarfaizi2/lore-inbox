Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWE2V1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWE2V1e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWE2V1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:27:22 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:36587 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751367AbWE2V0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:26:54 -0400
Date: Mon, 29 May 2006 23:27:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 51/61] lock validator: special locking: sock_lock_init()
Message-ID: <20060529212714.GY3155@elte.hu>
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

teach special (multi-initialized, per-address-family) locking code to the
lock validator. Has no effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 include/net/sock.h |    6 ------
 net/core/sock.c    |   27 +++++++++++++++++++++++----
 2 files changed, 23 insertions(+), 10 deletions(-)

Index: linux/include/net/sock.h
===================================================================
--- linux.orig/include/net/sock.h
+++ linux/include/net/sock.h
@@ -81,12 +81,6 @@ typedef struct {
 	wait_queue_head_t	wq;
 } socket_lock_t;
 
-#define sock_lock_init(__sk) \
-do {	spin_lock_init(&((__sk)->sk_lock.slock)); \
-	(__sk)->sk_lock.owner = NULL; \
-	init_waitqueue_head(&((__sk)->sk_lock.wq)); \
-} while(0)
-
 struct sock;
 struct proto;
 
Index: linux/net/core/sock.c
===================================================================
--- linux.orig/net/core/sock.c
+++ linux/net/core/sock.c
@@ -739,6 +739,27 @@ lenout:
   	return 0;
 }
 
+/*
+ * Each address family might have different locking rules, so we have
+ * one slock key per address family:
+ */
+static struct lockdep_type_key af_family_keys[AF_MAX];
+
+static void noinline sock_lock_init(struct sock *sk)
+{
+	spin_lock_init_key(&sk->sk_lock.slock, af_family_keys + sk->sk_family);
+	sk->sk_lock.owner = NULL;
+	init_waitqueue_head(&sk->sk_lock.wq);
+}
+
+static struct lockdep_type_key af_callback_keys[AF_MAX];
+
+static void noinline sock_rwlock_init(struct sock *sk)
+{
+	rwlock_init(&sk->sk_dst_lock);
+	rwlock_init_key(&sk->sk_callback_lock, af_callback_keys + sk->sk_family);
+}
+
 /**
  *	sk_alloc - All socket objects are allocated here
  *	@family: protocol family
@@ -833,8 +854,7 @@ struct sock *sk_clone(const struct sock 
 		skb_queue_head_init(&newsk->sk_receive_queue);
 		skb_queue_head_init(&newsk->sk_write_queue);
 
-		rwlock_init(&newsk->sk_dst_lock);
-		rwlock_init(&newsk->sk_callback_lock);
+		sock_rwlock_init(newsk);
 
 		newsk->sk_dst_cache	= NULL;
 		newsk->sk_wmem_queued	= 0;
@@ -1404,8 +1424,7 @@ void sock_init_data(struct socket *sock,
 	} else
 		sk->sk_sleep	=	NULL;
 
-	rwlock_init(&sk->sk_dst_lock);
-	rwlock_init(&sk->sk_callback_lock);
+	sock_rwlock_init(sk);
 
 	sk->sk_state_change	=	sock_def_wakeup;
 	sk->sk_data_ready	=	sock_def_readable;
