Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270083AbUJSScH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270083AbUJSScH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 14:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269583AbUJSS3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:29:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:65217 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S270041AbUJSSZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:25:29 -0400
Date: Tue, 19 Oct 2004 20:26:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
Message-ID: <20041019182605.GA24749@elte.hu>
References: <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019144642.GA6512@elte.hu> <28172.195.245.190.93.1098199429.squirrel@195.245.190.93> <1098200660.12223.923.camel@thomas> <20041019155722.GA9711@elte.hu> <1098204276.12223.992.camel@thomas> <1098208730.12223.1002.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098208730.12223.1002.camel@thomas>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> The IPV6 code triggers the irqs_disabled() check in schedule. dmesg
> output attached.

ok, does the patch below, ontop of -U7, fix them?

	Ingo

--- linux.old/include/net/protocol.h	
+++ linux.new/include/net/protocol.h	
@@ -83,6 +83,7 @@ extern spinlock_t inet_proto_lock;
 
 #if defined(CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
 extern struct inet6_protocol *inet6_protos[MAX_INET_PROTOS];
+extern rwlock_t inet6_proto_lock;
 #endif
 
 extern int	inet_add_protocol(struct net_protocol *prot, unsigned char num);
--- linux.old/net/ipv6/af_inet6.c	
+++ linux.new/net/ipv6/af_inet6.c	
@@ -94,7 +94,7 @@ atomic_t inet6_sock_nr;
  * build a new socket.
  */
 static struct list_head inetsw6[SOCK_MAX];
-static spinlock_t inetsw6_lock = SPIN_LOCK_UNLOCKED;
+static rwlock_t inetsw6_lock = RW_LOCK_UNLOCKED;
 
 static void inet6_sock_destruct(struct sock *sk)
 {
@@ -127,7 +127,7 @@ static int inet6_create(struct socket *s
 
 	/* Look for the requested type/protocol pair. */
 	answer = NULL;
-	rcu_read_lock();
+	rcu_read_lock_read(&inetsw6_lock);
 	list_for_each_rcu(p, &inetsw6[sock->type]) {
 		answer = list_entry(p, struct inet_protosw, list);
 
@@ -162,7 +162,7 @@ static int inet6_create(struct socket *s
 	answer_prot = answer->prot;
 	answer_no_check = answer->no_check;
 	answer_flags = answer->flags;
-	rcu_read_unlock();
+	rcu_read_unlock_read(&inetsw6_lock);
 
 	BUG_TRAP(answer_prot->slab != NULL);
 
@@ -242,7 +242,7 @@ static int inet6_create(struct socket *s
 out:
 	return rc;
 out_rcu_unlock:
-	rcu_read_unlock();
+	rcu_read_unlock_read(&inetsw6_lock);
 	goto out;
 }
 
@@ -542,7 +542,7 @@ inet6_register_protosw(struct inet_proto
 	int protocol = p->protocol;
 	struct list_head *last_perm;
 
-	spin_lock_bh(&inetsw6_lock);
+	write_lock_bh(&inetsw6_lock);
 
 	if (p->type >= SOCK_MAX)
 		goto out_illegal;
@@ -573,7 +573,7 @@ inet6_register_protosw(struct inet_proto
 	 */
 	list_add_rcu(&p->list, last_perm);
 out:
-	spin_unlock_bh(&inetsw6_lock);
+	write_unlock_bh(&inetsw6_lock);
 	return;
 
 out_permanent:
@@ -596,9 +596,9 @@ inet6_unregister_protosw(struct inet_pro
 		       "Attempt to unregister permanent protocol %d.\n",
 		       p->protocol);
 	} else {
-		spin_lock_bh(&inetsw6_lock);
+		write_lock_bh(&inetsw6_lock);
 		list_del_rcu(&p->list);
-		spin_unlock_bh(&inetsw6_lock);
+		write_unlock_bh(&inetsw6_lock);
 
 		synchronize_net();
 	}
--- linux.old/net/ipv6/icmp.c	
+++ linux.new/net/ipv6/icmp.c	
@@ -537,11 +537,11 @@ static void icmpv6_notify(struct sk_buff
 
 	hash = nexthdr & (MAX_INET_PROTOS - 1);
 
-	rcu_read_lock();
+	rcu_read_lock_read(&inet6_proto_lock);
 	ipprot = rcu_dereference(inet6_protos[hash]);
 	if (ipprot && ipprot->err_handler)
 		ipprot->err_handler(skb, NULL, type, code, inner_offset, info);
-	rcu_read_unlock();
+	rcu_read_unlock_read(&inet6_proto_lock);
 
 	read_lock(&raw_v6_lock);
 	if ((sk = sk_head(&raw_v6_htable[hash])) != NULL) {
--- linux.old/net/ipv6/ip6_input.c	
+++ linux.new/net/ipv6/ip6_input.c	
@@ -156,7 +156,7 @@ static inline int ip6_input_finish(struc
 		skb->h.raw += (skb->h.raw[1]+1)<<3;
 	}
 
-	rcu_read_lock();
+	rcu_read_lock_read(&raw_v6_lock);
 resubmit:
 	if (!pskb_pull(skb, skb->h.raw - skb->data))
 		goto discard;
@@ -205,12 +205,12 @@ resubmit:
 			kfree_skb(skb);
 		}
 	}
-	rcu_read_unlock();
+	rcu_read_unlock_read(&raw_v6_lock);
 	return 0;
 
 discard:
 	IP6_INC_STATS_BH(IPSTATS_MIB_INDISCARDS);
-	rcu_read_unlock();
+	rcu_read_unlock_read(&raw_v6_lock);
 	kfree_skb(skb);
 	return 0;
 }
--- linux.old/net/ipv6/ndisc.c	
+++ linux.new/net/ipv6/ndisc.c	
@@ -289,17 +289,17 @@ static int ndisc_constructor(struct neig
 	struct neigh_parms *parms;
 	int is_multicast = ipv6_addr_is_multicast(addr);
 
-	rcu_read_lock();
+	rcu_read_lock_read(&addrconf_lock);
 	in6_dev = in6_dev_get(dev);
 	if (in6_dev == NULL) {
-		rcu_read_unlock();
+		rcu_read_unlock_read(&addrconf_lock);
 		return -EINVAL;
 	}
 
 	parms = in6_dev->nd_parms;
 	__neigh_parms_put(neigh->parms);
 	neigh->parms = neigh_parms_clone(parms);
-	rcu_read_unlock();
+	rcu_read_unlock_read(&addrconf_lock);
 
 	neigh->type = is_multicast ? RTN_MULTICAST : RTN_UNICAST;
 	if (dev->hard_header == NULL) {
--- linux.old/net/ipv6/protocol.c	
+++ linux.new/net/ipv6/protocol.c	
@@ -40,14 +40,14 @@
 #include <net/protocol.h>
 
 struct inet6_protocol *inet6_protos[MAX_INET_PROTOS];
-static spinlock_t inet6_proto_lock = SPIN_LOCK_UNLOCKED;
+rwlock_t inet6_proto_lock = RW_LOCK_UNLOCKED;
 
 
 int inet6_add_protocol(struct inet6_protocol *prot, unsigned char protocol)
 {
 	int ret, hash = protocol & (MAX_INET_PROTOS - 1);
 
-	spin_lock_bh(&inet6_proto_lock);
+	write_lock_bh(&inet6_proto_lock);
 
 	if (inet6_protos[hash]) {
 		ret = -1;
@@ -56,7 +56,7 @@ int inet6_add_protocol(struct inet6_prot
 		ret = 0;
 	}
 
-	spin_unlock_bh(&inet6_proto_lock);
+	write_unlock_bh(&inet6_proto_lock);
 
 	return ret;
 }
@@ -69,7 +69,7 @@ int inet6_del_protocol(struct inet6_prot
 {
 	int ret, hash = protocol & (MAX_INET_PROTOS - 1);
 
-	spin_lock_bh(&inet6_proto_lock);
+	write_lock_bh(&inet6_proto_lock);
 
 	if (inet6_protos[hash] != prot) {
 		ret = -1;
@@ -78,7 +78,7 @@ int inet6_del_protocol(struct inet6_prot
 		ret = 0;
 	}
 
-	spin_unlock_bh(&inet6_proto_lock);
+	write_unlock_bh(&inet6_proto_lock);
 
 	synchronize_net();
 
