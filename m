Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWF3JXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWF3JXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 05:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWF3JXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 05:23:43 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:36303 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751603AbWF3JXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 05:23:42 -0400
Date: Fri, 30 Jun 2006 11:18:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] lockdep, annotate slocks: turn lockdep off for them
Message-ID: <20060630091850.GA10713@elte.hu>
References: <a44ae5cd0606291201v659b4235sfa9941aa3b18e766@mail.gmail.com> <20060630065041.GB6572@elte.hu> <20060630072231.GB7057@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20060630072231.GB7057@elte.hu>
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


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Ingo Molnar <mingo@elte.hu> wrote:

> temporary solution to turn off slock related false positives: the 
> slock is pretty much the only lock type in the kernel that is half 
> spinlock, half waitqueue. "Process level" and "softirq level" uses of 
> slock are excluded - albeit the spinlock itself is not permanently 
> held in process context.
> 
> The right solution will be to annotate slock uses with 
> acquire()/release(). (i.e. to treat sock_owned_by_user() flagged areas 
> as an exclusion area too)

i've got the right solution coded up too - it was a fairly 
straightforward process of teaching a new lock type (sk_lock) to the 
validator.

Miles, do the two attached patches (ontop of -mm4) fix your problem too? 
[you should unapply the previous lockdep_off()/on() patch i sent)

Andrew, i'd suggest to not apply the two attached patches yet - while 
they work fine for me we first should see whether they fix Miles' 
problem too.

Herbert, do the acquire/release semantics as expressed in the 
lockdep-annotate-slock.patch match sk_lock semantics?

the patch also makes the slock names more readable:

 neptune:/home/mingo> cat /proc/lockdep | grep AF
 c07f7088 OPS:    4125 FD:    1 BD:    2 -...: slock-AF_UNIX
 c07f7188 OPS:    1375 FD:    2 BD:    1 --..: sk_lock-AF_UNIX
 c07f7100 OPS:     252 FD:    1 BD:    2 -...: slock-AF_NETLINK
 c07f7200 OPS:      84 FD:    2 BD:    1 --..: sk_lock-AF_NETLINK
 c07f7090 OPS:    2641 FD:   20 BD:    4 -+..: slock-AF_INET
 c07f7190 OPS:     851 FD:   64 BD:    1 --..: sk_lock-AF_INET
 c07f7108 OPS:      27 FD:    1 BD:    2 -...: slock-AF_PACKET
 c07f7208 OPS:       9 FD:    4 BD:    1 --..: sk_lock-AF_PACKET
 c07f7091 OPS:     285 FD:   44 BD:    2 -+..: slock-AF_INET/1

(that should make it easier to tell which sk_lock class is mentioned in 
a validator message, instead of the current slock#2/slock#3 
enumeration.)

	Ingo


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lockdep-core-add-set-class-and-name.patch"

Subject: lockdep: core, add set_class_and_name()
From: Ingo Molnar <mingo@elte.hu>

add set_class_and_name() API, to allow lock initialization places
to beautify the naming of their lock classes.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/lockdep.h |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux/include/linux/lockdep.h
===================================================================
--- linux.orig/include/linux/lockdep.h
+++ linux/include/linux/lockdep.h
@@ -212,6 +212,8 @@ extern void lockdep_init_map(struct lock
  */
 #define lockdep_set_class(lock, key) \
 		lockdep_init_map(&(lock)->dep_map, #key, key)
+#define lockdep_set_class_and_name(lock, key, name) \
+		lockdep_init_map(&(lock)->dep_map, name, key)
 
 /*
  * Acquire a lock.
@@ -257,6 +259,8 @@ static inline int lockdep_internal(void)
 # define lockdep_info()				do { } while (0)
 # define lockdep_init_map(lock, name, key)	do { } while (0)
 # define lockdep_set_class(lock, key)		do { (void)(key); } while (0)
+# define lockdep_set_class_and_name(lock, key, name) \
+		do { (void)(key); (void)(name); } while (0)
 # define INIT_LOCKDEP
 # define lockdep_reset()		do { debug_locks = 1; } while (0)
 # define lockdep_free_key_range(start, size)	do { } while (0)

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lockdep-annotate-slock.patch"

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
 net/core/sock.c    |   93 +++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 94 insertions(+), 19 deletions(-)

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
@@ -250,9 +283,18 @@ int sk_receive_skb(struct sock *sk, stru
 	skb->dev = NULL;
 
 	bh_lock_sock(sk);
-	if (!sock_owned_by_user(sk))
+	if (!sock_owned_by_user(sk)) {
+		/*
+		 * trylock + unlock semantics:
+		 */
+		spin_release(&sk->sk_lock.slock.dep_map, 1, _RET_IP_);
+		mutex_acquire(&sk->sk_lock.dep_map, 0, 1, _RET_IP_);
+
 		rc = sk->sk_backlog_rcv(sk, skb);
-	else
+
+		mutex_release(&sk->sk_lock.dep_map, 1, _RET_IP_);
+		spin_acquire(&sk->sk_lock.slock.dep_map, 0, 0, _RET_IP_);
+	} else
 		sk_add_backlog(sk, skb);
 	bh_unlock_sock(sk);
 out:
@@ -762,6 +804,30 @@ lenout:
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
@@ -1466,24 +1532,33 @@ void sock_init_data(struct socket *sock,
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
+	spin_lock_bh(&sk->sk_lock.slock);
 	if (sk->sk_backlog.tail)
 		__release_sock(sk);
+	/*
+	 * The sk_lock has mutex_unlock() semantics:
+	 */
+	mutex_release(&sk->sk_lock.dep_map, 1, _RET_IP_);
 	sk->sk_lock.owner = NULL;
-        if (waitqueue_active(&(sk->sk_lock.wq)))
-		wake_up(&(sk->sk_lock.wq));
-	spin_unlock_bh(&(sk->sk_lock.slock));
+        if (waitqueue_active(&sk->sk_lock.wq))
+		wake_up(&sk->sk_lock.wq);
+	spin_unlock_bh(&sk->sk_lock.slock);
 }
 EXPORT_SYMBOL(release_sock);
 

--C7zPtVaVf+AK4Oqc--
