Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268084AbTBWJSh>; Sun, 23 Feb 2003 04:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268081AbTBWJSh>; Sun, 23 Feb 2003 04:18:37 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41949 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268078AbTBWJS0>;
	Sun, 23 Feb 2003 04:18:26 -0500
Date: Sun, 23 Feb 2003 01:12:17 -0800 (PST)
Message-Id: <20030223.011217.04700323.davem@redhat.com>
To: ak@suse.de
Cc: sim@netnation.com, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Longstanding networking / SMP issue? (duplextest)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030221104541.GA18417@wotan.suse.de>
References: <20030221102257.GA10108@wotan.suse.de>
	<20030221.021125.66547838.davem@redhat.com>
	<20030221104541.GA18417@wotan.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Fri, 21 Feb 2003 11:45:41 +0100
   
   at least ipip.c will send icmps from process context (ipip_tunnel_xmit)
   
   netfilter will probably do too.

We can easily make them all run in BH (protected) context :-)

This makes the locking much simpler.  Add to this the per-cpu socket
idea I proposed and we arrive at the patch below (against 2.5.x,
easily ported to 2.4.x just remove the cpu_possible() stuff).

Comments?

--- net/ipv4/icmp.c.~1~	Sat Feb 22 23:41:53 2003
+++ net/ipv4/icmp.c	Sun Feb 23 01:25:43 2003
@@ -223,57 +223,29 @@
 static struct icmp_control icmp_pointers[NR_ICMP_TYPES+1];
 
 /*
- *	The ICMP socket. This is the most convenient way to flow control
+ *	The ICMP socket(s). This is the most convenient way to flow control
  *	our ICMP output as well as maintain a clean interface throughout
  *	all layers. All Socketless IP sends will soon be gone.
+ *
+ *	On SMP we have one ICMP socket per-cpu.
  */
-struct socket *icmp_socket;
-
-/* ICMPv4 socket is only a bit non-reenterable (unlike ICMPv6,
-   which is strongly non-reenterable). A bit later it will be made
-   reenterable and the lock may be removed then.
- */
-
-static int icmp_xmit_holder = -1;
-
-static int icmp_xmit_lock_bh(void)
-{
-	int rc;
-	if (!spin_trylock(&icmp_socket->sk->lock.slock)) {
-		rc = -EAGAIN;
-		if (icmp_xmit_holder == smp_processor_id())
-			goto out;
-		spin_lock(&icmp_socket->sk->lock.slock);
-	}
-	rc = 0;
-	icmp_xmit_holder = smp_processor_id();
-out:
-	return rc;
-}
+static struct socket *__icmp_socket[NR_CPUS];
+#define icmp_socket	__icmp_socket[smp_processor_id()]
 
-static __inline__ int icmp_xmit_lock(void)
+static __inline__ void icmp_xmit_lock(void)
 {
-	int ret;
 	local_bh_disable();
-	ret = icmp_xmit_lock_bh();
-	if (ret)
-		local_bh_enable();
-	return ret;
-}
 
-static void icmp_xmit_unlock_bh(void)
-{
-	icmp_xmit_holder = -1;
-	spin_unlock(&icmp_socket->sk->lock.slock);
+	if (!spin_trylock(&icmp_socket->sk->lock.slock))
+		BUG();
 }
 
-static __inline__ void icmp_xmit_unlock(void)
+static void icmp_xmit_unlock(void)
 {
-	icmp_xmit_unlock_bh();
+	spin_unlock(&icmp_socket->sk->lock.slock);
 	local_bh_enable();
 }
 
-
 /*
  *	Send an ICMP frame.
  */
@@ -404,10 +376,11 @@
 	struct rtable *rt = (struct rtable *)skb->dst;
 	u32 daddr;
 
-	if (ip_options_echo(&icmp_param->replyopts, skb) ||
-	    icmp_xmit_lock_bh())
+	if (ip_options_echo(&icmp_param->replyopts, skb))
 		goto out;
 
+	icmp_xmit_lock();
+
 	icmp_param->data.icmph.checksum = 0;
 	icmp_out_count(icmp_param->data.icmph.type);
 
@@ -434,7 +407,7 @@
 		icmp_push_reply(icmp_param, &ipc, rt);
 	ip_rt_put(rt);
 out_unlock:
-	icmp_xmit_unlock_bh();
+	icmp_xmit_unlock();
 out:;
 }
 
@@ -519,8 +492,7 @@
 		}
 	}
 
-	if (icmp_xmit_lock())
-		goto out;
+	icmp_xmit_lock();
 
 	/*
 	 *	Construct source address and options.
@@ -1141,19 +1113,30 @@
 void __init icmp_init(struct net_proto_family *ops)
 {
 	struct inet_opt *inet;
-	int err = sock_create(PF_INET, SOCK_RAW, IPPROTO_ICMP, &icmp_socket);
+	int i;
 
-	if (err < 0)
-		panic("Failed to create the ICMP control socket.\n");
-	icmp_socket->sk->allocation = GFP_ATOMIC;
-	icmp_socket->sk->sndbuf	    = SK_WMEM_MAX * 2;
-	inet	       = inet_sk(icmp_socket->sk);
-	inet->ttl      = MAXTTL;
-	inet->pmtudisc = IP_PMTUDISC_DONT;
-
-	/* Unhash it so that IP input processing does not even
-	 * see it, we do not wish this socket to see incoming
-	 * packets.
-	 */
-	icmp_socket->sk->prot->unhash(icmp_socket->sk);
+	for (i = 0; i < NR_CPUS; i++) {
+		int err;
+
+		if (!cpu_possible(i))
+			continue;
+
+		err = sock_create(PF_INET, SOCK_RAW, IPPROTO_ICMP,
+				  &__icmp_socket[i]);
+
+		if (err < 0)
+			panic("Failed to create the ICMP control socket.\n");
+
+		__icmp_socket[i]->sk->allocation = GFP_ATOMIC;
+		__icmp_socket[i]->sk->sndbuf = SK_WMEM_MAX * 2;
+		inet = inet_sk(__icmp_socket[i]->sk);
+		inet->ttl = MAXTTL;
+		inet->pmtudisc = IP_PMTUDISC_DONT;
+
+		/* Unhash it so that IP input processing does not even
+		 * see it, we do not wish this socket to see incoming
+		 * packets.
+		 */
+		__icmp_socket[i]->sk->prot->unhash(__icmp_socket[i]->sk);
+	}
 }
--- net/ipv6/icmp.c.~1~	Sat Feb 22 23:48:49 2003
+++ net/ipv6/icmp.c	Sun Feb 23 01:27:09 2003
@@ -67,10 +67,11 @@
 DEFINE_SNMP_STAT(struct icmpv6_mib, icmpv6_statistics);
 
 /*
- *	ICMP socket for flow control.
+ *	ICMP socket(s) for flow control.
  */
 
-struct socket *icmpv6_socket;
+static struct socket *__icmpv6_socket[NR_CPUS];
+#define icmpv6_socket	__icmpv6_socket[smp_processor_id()]
 
 static int icmpv6_rcv(struct sk_buff *skb);
 
@@ -87,39 +88,16 @@
 	__u32			csum;
 };
 
-
-static int icmpv6_xmit_holder = -1;
-
-static int icmpv6_xmit_lock_bh(void)
+static __inline__ void icmpv6_xmit_lock(void)
 {
-	if (!spin_trylock(&icmpv6_socket->sk->lock.slock)) {
-		if (icmpv6_xmit_holder == smp_processor_id())
-			return -EAGAIN;
-		spin_lock(&icmpv6_socket->sk->lock.slock);
-	}
-	icmpv6_xmit_holder = smp_processor_id();
-	return 0;
-}
-
-static __inline__ int icmpv6_xmit_lock(void)
-{
-	int ret;
 	local_bh_disable();
-	ret = icmpv6_xmit_lock_bh();
-	if (ret)
-		local_bh_enable();
-	return ret;
-}
-
-static void icmpv6_xmit_unlock_bh(void)
-{
-	icmpv6_xmit_holder = -1;
-	spin_unlock(&icmpv6_socket->sk->lock.slock);
+	if (!spin_trylock(&icmpv6_socket->sk->lock.slock))
+		BUG();
 }
 
 static __inline__ void icmpv6_xmit_unlock(void)
 {
-	icmpv6_xmit_unlock_bh();
+	spin_unlock(&icmpv6_socket->sk->lock.slock);
 	local_bh_enable();
 }
 
@@ -341,8 +319,7 @@
 	fl.uli_u.icmpt.type = type;
 	fl.uli_u.icmpt.code = code;
 
-	if (icmpv6_xmit_lock())
-		return;
+	icmpv6_xmit_lock();
 
 	if (!icmpv6_xrlim_allow(sk, type, &fl))
 		goto out;
@@ -415,15 +392,14 @@
 	fl.uli_u.icmpt.type = ICMPV6_ECHO_REPLY;
 	fl.uli_u.icmpt.code = 0;
 
-	if (icmpv6_xmit_lock_bh())
-		return;
+	icmpv6_xmit_lock();
 
 	ip6_build_xmit(sk, icmpv6_getfrag, &msg, &fl, msg.len, NULL, -1,
 		       MSG_DONTWAIT);
 	ICMP6_INC_STATS_BH(Icmp6OutEchoReplies);
 	ICMP6_INC_STATS_BH(Icmp6OutMsgs);
 
-	icmpv6_xmit_unlock_bh();
+	icmpv6_xmit_unlock();
 }
 
 static void icmpv6_notify(struct sk_buff *skb, int type, int code, u32 info)
@@ -626,26 +602,47 @@
 int __init icmpv6_init(struct net_proto_family *ops)
 {
 	struct sock *sk;
-	int err;
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		int err;
+
+		if (!cpu_possible(i))
+			continue;
 
-	err = sock_create(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6, &icmpv6_socket);
-	if (err < 0) {
-		printk(KERN_ERR
-		       "Failed to initialize the ICMP6 control socket (err %d).\n",
-		       err);
-		icmpv6_socket = NULL; /* for safety */
-		return err;
+		err = sock_create(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6,
+				  &__icmpv6_socket[i]);
+		if (err < 0) {
+			int j;
+
+			printk(KERN_ERR
+			       "Failed to initialize the ICMP6 control socket "
+			       "(err %d).\n",
+			       err);
+			for (j = 0; j < i; j++) {
+				if (!cpu_possible(j))
+					continue;
+				sock_release(__icmpv6_socket[j]);
+				__icmpv6_socket[j] = NULL; /* for safety */
+			}
+			return err;
+		}
+
+		sk = __icmpv6_socket[i]->sk;
+		sk->allocation = GFP_ATOMIC;
+		sk->sndbuf = SK_WMEM_MAX*2;
+		sk->prot->unhash(sk);
 	}
 
-	sk = icmpv6_socket->sk;
-	sk->allocation = GFP_ATOMIC;
-	sk->sndbuf = SK_WMEM_MAX*2;
-	sk->prot->unhash(sk);
 
 	if (inet6_add_protocol(&icmpv6_protocol, IPPROTO_ICMPV6) < 0) {
 		printk(KERN_ERR "Failed to register ICMP6 protocol\n");
-		sock_release(icmpv6_socket);
-		icmpv6_socket = NULL;
+		for (i = 0; i < NR_CPUS; i++) {
+			if (!cpu_possible(i))
+				continue;
+			sock_release(__icmpv6_socket[i]);
+			__icmpv6_socket[i] = NULL;
+		}
 		return -EAGAIN;
 	}
 
@@ -654,8 +651,14 @@
 
 void icmpv6_cleanup(void)
 {
-	sock_release(icmpv6_socket);
-	icmpv6_socket = NULL; /* For safety. */
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
+		sock_release(__icmpv6_socket[i]);
+		__icmpv6_socket[i] = NULL; /* For safety. */
+	}
 	inet6_del_protocol(&icmpv6_protocol, IPPROTO_ICMPV6);
 }
 
