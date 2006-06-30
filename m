Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWF3Lmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWF3Lmy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbWF3Lmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:42:54 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:3020 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750894AbWF3Lmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:42:53 -0400
Date: Fri, 30 Jun 2006 13:37:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] lockdep, annotate slocks: turn lockdep off for them
Message-ID: <20060630113758.GA18504@elte.hu>
References: <a44ae5cd0606291201v659b4235sfa9941aa3b18e766@mail.gmail.com> <20060630065041.GB6572@elte.hu> <20060630072231.GB7057@elte.hu> <20060630091850.GA10713@elte.hu> <20060630111734.GA22202@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630111734.GA22202@gondor.apana.org.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Herbert Xu <herbert@gondor.apana.org.au> wrote:

> >  	bh_lock_sock(sk);
> > -	if (!sock_owned_by_user(sk))
> > +	if (!sock_owned_by_user(sk)) {
> > +		/*
> > +		 * trylock + unlock semantics:
> > +		 */
> > +		spin_release(&sk->sk_lock.slock.dep_map, 1, _RET_IP_);
> > +		mutex_acquire(&sk->sk_lock.dep_map, 0, 1, _RET_IP_);
> 
> Although it would seem that keeping the spin lock would fit the actual 
> semantics better. I suppose there must be a technical reason why this 
> wouldn't work.

good point. The basic issue is the 'virtual lock inversion' that occurs 
in the lock vs. release paths. [between taking the slock and taking the 
new sk_lock type]

The situation is like this: we construct 'complex' lock types [mutex, 
rwsem, sk_lock] out of 'primitive' lock types [spinlock, rwlock]. Both 
the complex type and the primite types exist separately, and might have 
lock-validator acquire/release operations. These locks can interact and 
if we do the complex lock acquire/release while holding the primitive 
lock, the validator sees inverse ordering between them.

For the mutex code i solved the inversion problem by using a 
raw_spinlock for the primitive type (which has no lockdep operations), 
hence the complex lock type.

But in this particular sk_lock case we can do it even more cleanly i 
think and can preserve the lockdep awareness of the primitive type too: 
by releasing the complex lock before taking the primitive lock in the 
release_sock() unlock path. The updated patch below does this - and thus 
i was able to remove the dropping of the primitive spinlock type.

it is not a problem that the release of the complex lock type does not 
happen inside the critical section: from the point where we release the 
complex lock-type _this_ context cannot take any other locks, so there 
are no dependencies missed.

As you can see, the lock validator can easily cover completely new lock 
types like sk_lock too, as long as the new lock type has some 
minimalistic "works like a lock" properties. (such as owner-does-unlock)

later on i'll try the same cleanup for the mutex code too - it should be 
possible. (that way the implementation of complex lock types can be 
lock-validator checked too)

	Ingo

--------------->
Subject: lockdep, annotate sk_locks
From: Ingo Molnar <mingo@elte.hu>

Teach sk_lock semantics to the lock validator. In the softirq path
the slock has mutex_trylock()+mutex_unlock() semantics, in the
process context sock_lock() case it has mutex_lock()/mutex_unlock()
semantics.

Thus we treat sock_owned_by_user() flagged areas as an exclusion
area too, not just those areas covered by a held sk_lock.slock.

Effect on non-lockdep kernels: minimal, sk_lock_sock_init() has
been turned into an inline function.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/net/sock.h |   20 +++++------
 net/core/sock.c    |   92 +++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 93 insertions(+), 19 deletions(-)

Index: linux/include/net/sock.h
===================================================================
--- linux.orig/include/net/sock.h
+++ linux/include/net/sock.h
@@ -44,6 +44,7 @@
 #include <linux/timer.h>
 #include <linux/cache.h>
 #include <linux/module.h>
+#include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>	/* struct sk_buff */
 #include <linux/security.h>
@@ -78,18 +79,17 @@ typedef struct {
 	spinlock_t		slock;
 	struct sock_iocb	*owner;
 	wait_queue_head_t	wq;
+	/*
+	 * We express the mutex-alike socket_lock semantics
+	 * to the lock validator by explicitly managing
+	 * the slock as a lock variant (in addition to
+	 * the slock itself):
+	 */
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map dep_map;
+#endif
 } socket_lock_t;
 
-extern struct lock_class_key af_family_keys[AF_MAX];
-
-#define sock_lock_init(__sk) \
-do {	spin_lock_init(&((__sk)->sk_lock.slock)); \
-	lockdep_set_class(&(__sk)->sk_lock.slock, \
-			  af_family_keys + (__sk)->sk_family); \
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
@@ -134,7 +134,40 @@
  * Each address family might have different locking rules, so we have
  * one slock key per address family:
  */
-struct lock_class_key af_family_keys[AF_MAX];
+static struct lock_class_key af_family_keys[AF_MAX];
+static struct lock_class_key af_family_slock_keys[AF_MAX];
+
+#ifdef CONFIG_LOCKDEP
+/*
+ * Make lock validator output more readable:
+ */
+static const char *af_family_key_strings[AF_MAX+1] = {
+  "sk_lock-AF_UNSPEC", "sk_lock-AF_UNIX"     , "sk_lock-AF_INET"     ,
+  "sk_lock-AF_AX25"  , "sk_lock-AF_IPX"      , "sk_lock-AF_APPLETALK",
+  "sk_lock-AF_NETROM", "sk_lock-AF_BRIDGE"   , "sk_lock-AF_ATMPVC"   ,
+  "sk_lock-AF_X25"   , "sk_lock-AF_INET6"    , "sk_lock-AF_ROSE"     ,
+  "sk_lock-AF_DECnet", "sk_lock-AF_NETBEUI"  , "sk_lock-AF_SECURITY" ,
+  "sk_lock-AF_KEY"   , "sk_lock-AF_NETLINK"  , "sk_lock-AF_PACKET"   ,
+  "sk_lock-AF_ASH"   , "sk_lock-AF_ECONET"   , "sk_lock-AF_ATMSVC"   ,
+  "sk_lock-21"       , "sk_lock-AF_SNA"      , "sk_lock-AF_IRDA"     ,
+  "sk_lock-AF_PPPOX" , "sk_lock-AF_WANPIPE"  , "sk_lock-AF_LLC"      ,
+  "sk_lock-27"       , "sk_lock-28"          , "sk_lock-29"          ,
+  "sk_lock-AF_TIPC"  , "sk_lock-AF_BLUETOOTH", "sk_lock-AF_MAX"
+};
+static const char *af_family_slock_key_strings[AF_MAX+1] = {
+  "slock-AF_UNSPEC", "slock-AF_UNIX"     , "slock-AF_INET"     ,
+  "slock-AF_AX25"  , "slock-AF_IPX"      , "slock-AF_APPLETALK",
+  "slock-AF_NETROM", "slock-AF_BRIDGE"   , "slock-AF_ATMPVC"   ,
+  "slock-AF_X25"   , "slock-AF_INET6"    , "slock-AF_ROSE"     ,
+  "slock-AF_DECnet", "slock-AF_NETBEUI"  , "slock-AF_SECURITY" ,
+  "slock-AF_KEY"   , "slock-AF_NETLINK"  , "slock-AF_PACKET"   ,
+  "slock-AF_ASH"   , "slock-AF_ECONET"   , "slock-AF_ATMSVC"   ,
+  "slock-21"       , "slock-AF_SNA"      , "slock-AF_IRDA"     ,
+  "slock-AF_PPPOX" , "slock-AF_WANPIPE"  , "slock-AF_LLC"      ,
+  "slock-27"       , "slock-28"          , "slock-29"          ,
+  "slock-AF_TIPC"  , "slock-AF_BLUETOOTH", "slock-AF_MAX"
+};
+#endif
 
 /*
  * sk_callback_lock locking rules are per-address-family,
@@ -250,9 +283,16 @@ int sk_receive_skb(struct sock *sk, stru
 	skb->dev = NULL;
 
 	bh_lock_sock(sk);
-	if (!sock_owned_by_user(sk))
+	if (!sock_owned_by_user(sk)) {
+		/*
+		 * trylock + unlock semantics:
+		 */
+		mutex_acquire(&sk->sk_lock.dep_map, 0, 1, _RET_IP_);
+
 		rc = sk->sk_backlog_rcv(sk, skb);
-	else
+
+		mutex_release(&sk->sk_lock.dep_map, 1, _RET_IP_);
+	} else
 		sk_add_backlog(sk, skb);
 	bh_unlock_sock(sk);
 out:
@@ -762,6 +802,30 @@ lenout:
   	return 0;
 }
 
+/*
+ * Initialize an sk_lock.
+ *
+ * (We also register the sk_lock with the lock validator.)
+ */
+static void inline sock_lock_init(struct sock *sk)
+{
+	spin_lock_init(&sk->sk_lock.slock);
+	lockdep_set_class_and_name(&sk->sk_lock.slock,
+				   af_family_slock_keys + sk->sk_family,
+				   af_family_slock_key_strings[sk->sk_family]);
+	sk->sk_lock.owner = NULL;
+	init_waitqueue_head(&sk->sk_lock.wq);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	/*
+	 * Make sure we are not reinitializing a held lock:
+	 */
+	debug_check_no_locks_freed((void *)&sk->sk_lock, sizeof(sk->sk_lock));
+	lockdep_init_map(&sk->sk_lock.dep_map,
+			 af_family_key_strings[sk->sk_family],
+			 af_family_keys + sk->sk_family);
+#endif
+}
+
 /**
  *	sk_alloc - All socket objects are allocated here
  *	@family: protocol family
@@ -1466,24 +1530,34 @@ void sock_init_data(struct socket *sock,
 void fastcall lock_sock(struct sock *sk)
 {
 	might_sleep();
-	spin_lock_bh(&(sk->sk_lock.slock));
+	spin_lock_bh(&sk->sk_lock.slock);
 	if (sk->sk_lock.owner)
 		__lock_sock(sk);
 	sk->sk_lock.owner = (void *)1;
-	spin_unlock_bh(&(sk->sk_lock.slock));
+	spin_unlock(&sk->sk_lock.slock);
+	/*
+	 * The sk_lock has mutex_lock() semantics here:
+	 */
+	mutex_acquire(&sk->sk_lock.dep_map, 0, 0, _RET_IP_);
+	local_bh_enable();
 }
 
 EXPORT_SYMBOL(lock_sock);
 
 void fastcall release_sock(struct sock *sk)
 {
-	spin_lock_bh(&(sk->sk_lock.slock));
+	/*
+	 * The sk_lock has mutex_unlock() semantics:
+	 */
+	mutex_release(&sk->sk_lock.dep_map, 1, _RET_IP_);
+
+	spin_lock_bh(&sk->sk_lock.slock);
 	if (sk->sk_backlog.tail)
 		__release_sock(sk);
 	sk->sk_lock.owner = NULL;
-        if (waitqueue_active(&(sk->sk_lock.wq)))
-		wake_up(&(sk->sk_lock.wq));
-	spin_unlock_bh(&(sk->sk_lock.slock));
+	if (waitqueue_active(&sk->sk_lock.wq))
+		wake_up(&sk->sk_lock.wq);
+	spin_unlock_bh(&sk->sk_lock.slock);
 }
 EXPORT_SYMBOL(release_sock);
 
