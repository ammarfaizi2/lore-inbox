Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTENM4g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTENM4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:56:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16802 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262138AbTENMzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:55:49 -0400
Date: Wed, 14 May 2003 15:08:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-net@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: 2.5 qdisc problem
Message-ID: <20030514130838.GJ15261@suse.de>
References: <20030514070600.GV17033@suse.de> <20030514122624.GA20480@babylon.d2dc.net> <20030514125941.GI15261@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514125941.GI15261@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14 2003, Jens Axboe wrote:
> On Wed, May 14 2003, Zephaniah E. Hull wrote:
> > On Wed, May 14, 2003 at 09:06:00AM +0200, Jens Axboe wrote:
> > > Hi,
> > > 
> > > I put 2.5 on my router, and now wondershaper doesn't work anymore. Am I
> > > completely out of whack, or shouldn't the below just fly:
> > > 
> > > router:~ # tc -s qdisc ls dev lo
> > > RTNETLINK answers: Invalid argument
> > > Dump terminated
> > > 
> > > I have the various QOS stuff enabled (config attached, and I don't seem
> > > to be missing anything. So what is up?
> > 
> > Good question, I've been seeing it since I moved from 2.5.68-mm2 to
> > 2.5.68-mm4, from what I can tell it was something in Linus' bk that was
> > pulled in that killed it.
> > 
> > However I have had no luck at all trying to figure out what exactly
> > broke.
> 
> Interesting, I didn't know it broke that recently. Looking at changes
> between -mm2 and -mm4 doesn't reveal a lot, really... Acme made most of
> the changes there it seems, any ideas?

This half-assed back-out from bk current makes it work here, Arnaldo
could you please fix this??

===== include/linux/net.h 1.16 vs edited =====
--- 1.16/include/linux/net.h	Mon May 12 23:35:19 2003
+++ edited/include/linux/net.h	Wed May 14 14:55:52 2003
@@ -89,11 +89,9 @@
 struct kiocb;
 struct sockaddr;
 struct msghdr;
-struct module;
 
 struct proto_ops {
 	int		family;
-	struct module	*owner;
 	int		(*release)   (struct socket *sock);
 	int		(*bind)	     (struct socket *sock,
 				      struct sockaddr *myaddr,
@@ -129,6 +127,8 @@
 				      int offset, size_t size, int flags);
 };
 
+struct module;
+
 struct net_proto_family {
 	int		family;
 	int		(*create)(struct socket *sock, int protocol);
@@ -224,7 +224,7 @@
 	      \
 static struct proto_ops name##_ops = {			\
 	.family		= fam,				\
-	.owner		= THIS_MODULE,			\
+							\
 	.release	= __lock_##name##_release,	\
 	.bind		= __lock_##name##_bind,		\
 	.connect	= __lock_##name##_connect,	\
===== include/net/sock.h 1.37 vs edited =====
--- 1.37/include/net/sock.h	Sat May  3 07:55:11 2003
+++ edited/include/net/sock.h	Wed May 14 14:54:19 2003
@@ -43,7 +43,7 @@
 #include <linux/config.h>
 #include <linux/timer.h>
 #include <linux/cache.h>
-#include <linux/module.h>
+
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>	/* struct sk_buff */
 #include <linux/security.h>
@@ -197,7 +197,6 @@
 	void			*user_data;
   
 	/* Callbacks */
-	struct module		*owner;
 	void			(*state_change)(struct sock *sk);
 	void			(*data_ready)(struct sock *sk,int bytes);
 	void			(*write_space)(struct sock *sk);
@@ -270,23 +269,6 @@
 		u8  __pad[SMP_CACHE_BYTES - sizeof(int)];
 	} stats[NR_CPUS];
 };
-
-static __inline__ void sk_set_owner(struct sock *sk, struct module *owner)
-{
-	/*
-	 * One should use sk_set_owner just once, after struct sock creation,
-	 * be it shortly after sk_alloc or after a function that returns a new
-	 * struct sock (and that down the call chain called sk_alloc), e.g. the
-	 * IPv4 and IPv6 modules share tcp_create_openreq_child, so if
-	 * tcp_create_openreq_child called sk_set_owner IPv6 would have to
-	 * change the ownership of this struct sock, with one not needed
-	 * transient sk_set_owner call.
-	 */
-	if (unlikely(sk->owner != NULL))
-		BUG();
-	sk->owner = owner;
-	__module_get(owner);
-}
 
 /* Called with local bh disabled */
 static __inline__ void sock_prot_inc_use(struct proto *prot)
===== net/socket.c 1.60 vs edited =====
--- 1.60/net/socket.c	Mon May 12 23:35:19 2003
+++ edited/net/socket.c	Wed May 14 14:57:40 2003
@@ -69,6 +69,8 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/wanrouter.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
 #include <linux/if_bridge.h>
 #include <linux/init.h>
 #include <linux/poll.h>
@@ -507,11 +509,11 @@
 void sock_release(struct socket *sock)
 {
 	if (sock->ops) {
-		struct module *owner = sock->ops->owner;
+		const int family = sock->ops->family;
 
 		sock->ops->release(sock);
 		sock->ops = NULL;
-		module_put(owner);
+		module_put(net_families[family]->owner);
 	}
 
 	if (sock->fasync_list)
@@ -1062,37 +1064,19 @@
 
 	sock->type  = type;
 
-	/*
-	 * We will call the ->create function, that possibly is in a loadable
-	 * module, so we have to bump that loadable module refcnt first.
-	 */
 	i = -EAFNOSUPPORT;
 	if (!try_module_get(net_families[family]->owner))
 		goto out_release;
 
-	if ((i = net_families[family]->create(sock, protocol)) < 0)
-		goto out_module_put;
-	/*
-	 * Now to bump the refcnt of the [loadable] module that owns this
-	 * socket at sock_release time we decrement its refcnt.
-	 */
-	if (!try_module_get(sock->ops->owner)) {
-		sock->ops = NULL;
-		goto out_module_put;
-	}
-	/*
-	 * Now that we're done with the ->create function, the [loadable]
-	 * module can have its refcnt decremented
-	 */
-	module_put(net_families[family]->owner);
+	if ((i = net_families[family]->create(sock, protocol)) < 0) 
+		goto out_release;
+
 	*res = sock;
 	security_socket_post_create(sock, family, type, protocol);
 
 out:
 	net_family_read_unlock();
 	return i;
-out_module_put:
-	module_put(net_families[family]->owner);
 out_release:
 	sock_release(sock);
 	goto out;
@@ -1277,12 +1261,7 @@
 	if (err)
 		goto out_release;
 
-	/*
-	 * We don't need try_module_get here, as the listening socket (sock)
-	 * has the protocol module (sock->ops->owner) held.
-	 */
-	__module_get(newsock->ops->owner);
-
+	err = -EAFNOSUPPORT;
 	err = sock->ops->accept(sock, newsock, sock->file->f_flags);
 	if (err < 0)
 		goto out_release;
@@ -1980,6 +1959,17 @@
 	 *  do_initcalls is run.  
 	 */
 
+
+	/*
+	 * The netlink device handler may be needed early.
+	 */
+
+#ifdef CONFIG_NET
+	rtnetlink_init();
+#endif
+#ifdef CONFIG_NETLINK_DEV
+	init_netlink();
+#endif
 #ifdef CONFIG_NETFILTER
 	netfilter_init();
 #endif
===== net/core/sock.c 1.24 vs edited =====
--- 1.24/net/core/sock.c	Sat May  3 07:55:11 2003
+++ edited/net/core/sock.c	Wed May 14 14:55:52 2003
@@ -589,8 +589,8 @@
  */
 struct sock *sk_alloc(int family, int priority, int zero_it, kmem_cache_t *slab)
 {
-	struct sock *sk = NULL;
-
+	struct sock *sk;
+       
 	if (!slab)
 		slab = sk_cachep;
 	sk = kmem_cache_alloc(slab, priority);
@@ -603,13 +603,13 @@
 		}
 		sk->slab = slab;
 	}
+
 	return sk;
 }
 
 void sk_free(struct sock *sk)
 {
 	struct sk_filter *filter;
-	struct module *owner = sk->owner;
 
 	if (sk->destruct)
 		sk->destruct(sk);
@@ -624,7 +624,6 @@
 		printk(KERN_DEBUG "sk_free: optmem leakage (%d bytes) detected.\n", atomic_read(&sk->omem_alloc));
 
 	kmem_cache_free(sk->slab, sk);
-	module_put(owner);
 }
 
 void __init sk_init(void)
@@ -1108,7 +1107,6 @@
 	sk->rcvlowat		=	1;
 	sk->rcvtimeo		=	MAX_SCHEDULE_TIMEOUT;
 	sk->sndtimeo		=	MAX_SCHEDULE_TIMEOUT;
-	sk->owner		=	NULL;
 
 	atomic_set(&sk->refcnt, 1);
 }
===== net/ipv4/af_inet.c 1.47 vs edited =====
--- 1.47/net/ipv4/af_inet.c	Mon May 12 22:25:51 2003
+++ edited/net/ipv4/af_inet.c	Wed May 14 15:00:27 2003
@@ -390,7 +390,9 @@
 	inet->id = 0;
 
 	sock_init_data(sock, sk);
+#if 0
 	sk_set_owner(sk, THIS_MODULE);
+#endif
 
 	sk->destruct = inet_sock_destruct;
 	sk->zapped	= 0;
@@ -884,7 +886,9 @@
 
 struct proto_ops inet_stream_ops = {
 	.family =	PF_INET,
+#if 0
 	.owner =	THIS_MODULE,
+#endif
 	.release =	inet_release,
 	.bind =		inet_bind,
 	.connect =	inet_stream_connect,
@@ -905,7 +909,9 @@
 
 struct proto_ops inet_dgram_ops = {
 	.family =	PF_INET,
+#if 0
 	.owner =	THIS_MODULE,
+#endif
 	.release =	inet_release,
 	.bind =		inet_bind,
 	.connect =	inet_dgram_connect,
===== net/ipv4/arp.c 1.20 vs edited =====
--- 1.20/net/ipv4/arp.c	Sat May 10 20:46:35 2003
+++ edited/net/ipv4/arp.c	Wed May 14 14:59:52 2003
@@ -1384,7 +1384,9 @@
 }
 
 static struct file_operations arp_seq_fops = {
+#if 0
 	.owner		= THIS_MODULE,
+#endif
 	.open           = arp_seq_open,
 	.read           = seq_read,
 	.llseek         = seq_lseek,
===== net/ipv4/fib_hash.c 1.12 vs edited =====
--- 1.12/net/ipv4/fib_hash.c	Sat May 10 20:46:35 2003
+++ edited/net/ipv4/fib_hash.c	Wed May 14 15:00:51 2003
@@ -1065,7 +1065,9 @@
 }
 
 static struct file_operations fib_seq_fops = {
+#if 0
 	.owner		= THIS_MODULE,
+#endif
 	.open           = fib_seq_open,
 	.read           = seq_read,
 	.llseek         = seq_lseek,
===== net/ipv4/proc.c 1.12 vs edited =====
--- 1.12/net/ipv4/proc.c	Sat May 10 20:46:35 2003
+++ edited/net/ipv4/proc.c	Wed May 14 15:01:13 2003
@@ -80,7 +80,9 @@
 }
 
 static struct file_operations sockstat_seq_fops = {
+#if 0
 	.owner	 = THIS_MODULE,
+#endif
 	.open	 = sockstat_seq_open,
 	.read	 = seq_read,
 	.llseek	 = seq_lseek,
@@ -172,7 +174,9 @@
 }
 
 static struct file_operations snmp_seq_fops = {
+#if 0
 	.owner	 = THIS_MODULE,
+#endif
 	.open	 = snmp_seq_open,
 	.read	 = seq_read,
 	.llseek	 = seq_lseek,
@@ -229,7 +233,9 @@
 }
 
 static struct file_operations netstat_seq_fops = {
+#if 0
 	.owner	 = THIS_MODULE,
+#endif
 	.open	 = netstat_seq_open,
 	.read	 = seq_read,
 	.llseek	 = seq_lseek,
===== net/ipv4/syncookies.c 1.12 vs edited =====
--- 1.12/net/ipv4/syncookies.c	Sat May  3 08:42:59 2003
+++ edited/net/ipv4/syncookies.c	Wed May 14 15:01:33 2003
@@ -102,7 +102,9 @@
 
 	child = tp->af_specific->syn_recv_sock(sk, skb, req, dst);
 	if (child) {
+#if 0
 		sk_set_owner(child, sk->owner);
+#endif
 		tcp_acceptq_queue(sk, req, child);
 	} else
 		tcp_openreq_free(req);
===== net/ipv4/tcp_minisocks.c 1.29 vs edited =====
--- 1.29/net/ipv4/tcp_minisocks.c	Sat May 10 13:21:56 2003
+++ edited/net/ipv4/tcp_minisocks.c	Wed May 14 14:59:16 2003
@@ -760,7 +760,9 @@
 			tcp_reset_keepalive_timer(newsk, keepalive_time_when(newtp));
 		newsk->socket = NULL;
 		newsk->sleep = NULL;
+#if 0
 		newsk->owner = NULL;
+#endif
 
 		newtp->tstamp_ok = req->tstamp_ok;
 		if((newtp->sack_ok = req->sack_ok) != 0) {
@@ -970,7 +972,9 @@
 	if (child == NULL)
 		goto listen_overflow;
 
+#if 0
 	sk_set_owner(child, sk->owner);
+#endif
 	tcp_synq_unlink(tp, req, prev);
 	tcp_synq_removed(sk, req);
 
===== net/netlink/af_netlink.c 1.23 vs edited =====
--- 1.23/net/netlink/af_netlink.c	Sat May  3 08:31:31 2003
+++ edited/net/netlink/af_netlink.c	Wed May 14 15:02:38 2003
@@ -235,7 +235,9 @@
 		return -ENOMEM;
 
 	sock_init_data(sock,sk);
+#if 0
 	sk_set_owner(sk, THIS_MODULE);
+#endif
 
 	nlk = nlk_sk(sk) = kmalloc(sizeof(*nlk), GFP_KERNEL);
 	if (!nlk) {
@@ -1031,7 +1033,9 @@
                 
 struct proto_ops netlink_ops = {
 	.family =	PF_NETLINK,
+#if 0
 	.owner =	THIS_MODULE,
+#endif
 	.release =	netlink_release,
 	.bind =		netlink_bind,
 	.connect =	netlink_connect,
@@ -1053,7 +1057,6 @@
 struct net_proto_family netlink_family_ops = {
 	.family = PF_NETLINK,
 	.create = netlink_create,
-	.owner	= THIS_MODULE,	/* for consistency 8) */
 };
 
 static int __init netlink_proto_init(void)
@@ -1068,11 +1071,6 @@
 #ifdef CONFIG_PROC_FS
 	create_proc_read_entry("net/netlink", 0, 0, netlink_read_proc, NULL);
 #endif
-	/* The netlink device handler may be needed early. */ 
-	rtnetlink_init();
-#ifdef CONFIG_NETLINK_DEV
-	init_netlink();
-#endif
 	return 0;
 }
 
@@ -1082,7 +1080,7 @@
        remove_proc_entry("net/netlink", NULL);
 }
 
-subsys_initcall(netlink_proto_init);
+module_init(netlink_proto_init);
 module_exit(netlink_proto_exit);
 
 MODULE_LICENSE("GPL");
===== net/packet/af_packet.c 1.24 vs edited =====
--- 1.24/net/packet/af_packet.c	Mon May 12 22:16:38 2003
+++ edited/net/packet/af_packet.c	Wed May 14 15:03:15 2003
@@ -473,7 +473,9 @@
 	if (pskb_trim(skb, snaplen))
 		goto drop_n_acct;
 
+#if 0
 	skb_set_owner_r(skb, sk);
+#endif
 	skb->dev = NULL;
 	spin_lock(&sk->receive_queue.lock);
 	po->stats.tp_packets++;
@@ -954,7 +956,9 @@
 		sock->ops = &packet_ops_spkt;
 #endif
 	sock_init_data(sock,sk);
+#if 0
 	sk_set_owner(sk, THIS_MODULE);
+#endif
 
 	po = pkt_sk(sk) = kmalloc(sizeof(*po), GFP_KERNEL);
 	if (!po)
@@ -1715,7 +1719,9 @@
 #ifdef CONFIG_SOCK_PACKET
 struct proto_ops packet_ops_spkt = {
 	.family =	PF_PACKET,
+#if 0
 	.owner =	THIS_MODULE,
+#endif
 	.release =	packet_release,
 	.bind =		packet_bind_spkt,
 	.connect =	sock_no_connect,
@@ -1737,7 +1743,7 @@
 
 struct proto_ops packet_ops = {
 	.family =	PF_PACKET,
-	.owner =	THIS_MODULE,
+	//.owner =	THIS_MODULE,
 	.release =	packet_release,
 	.bind =		packet_bind,
 	.connect =	sock_no_connect,
===== net/unix/af_unix.c 1.43 vs edited =====
--- 1.43/net/unix/af_unix.c	Mon May  5 07:49:54 2003
+++ edited/net/unix/af_unix.c	Wed May 14 15:04:04 2003
@@ -494,7 +494,9 @@
 	atomic_inc(&unix_nr_socks);
 
 	sock_init_data(sock,sk);
+#if 0
 	sk_set_owner(sk, THIS_MODULE);
+#endif
 
 	sk->write_space		=	unix_write_space;
 
@@ -1885,7 +1887,7 @@
 
 struct proto_ops unix_stream_ops = {
 	.family =	PF_UNIX,
-	.owner =	THIS_MODULE,
+	//.owner =	THIS_MODULE,
 	.release =	unix_release,
 	.bind =		unix_bind,
 	.connect =	unix_stream_connect,
@@ -1906,7 +1908,7 @@
 
 struct proto_ops unix_dgram_ops = {
 	.family =	PF_UNIX,
-	.owner =	THIS_MODULE,
+	//.owner =	THIS_MODULE,
 	.release =	unix_release,
 	.bind =		unix_bind,
 	.connect =	unix_dgram_connect,

-- 
Jens Axboe

