Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317031AbSFKXbQ>; Tue, 11 Jun 2002 19:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSFKXbQ>; Tue, 11 Jun 2002 19:31:16 -0400
Received: from ns.suse.de ([213.95.15.193]:31244 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317031AbSFKXbO>;
	Tue, 11 Jun 2002 19:31:14 -0400
Date: Wed, 12 Jun 2002 01:31:01 +0200
From: Andi Kleen <ak@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: jt@hpl.hp.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Multicast netlink for non-root process
Message-ID: <20020612013101.A22399@wotan.suse.de>
In-Reply-To: <20020611141330.A22927@bougret.hpl.hp.com> <200206112140.BAA14401@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 01:40:45AM +0400, A.N.Kuznetsov wrote:
> Hello!
> 
> > 	One potential reason is that some of the message may contain
> > data that is root only. But this should be handled with a finer
> > granularity.
> 
> Exactly. Taking into account that it is not handled with a finer granularity,
> it is restricted in a facsict manner.

The only problematic protocols are nf_queue and the firewall netlink I guess.

This (barely tested) patch should relax it for rtnetlink at least:

diff -X ../KDIFX -burp linux/include/linux/netlink.h linux-2.5.21-work/include/linux/netlink.h
--- linux/include/linux/netlink.h	Sun Apr 14 21:18:49 2002
+++ linux-2.5.21-work/include/linux/netlink.h	Wed Jun 12 01:21:00 2002
@@ -153,6 +153,10 @@ extern int netlink_dump_start(struct soc
 			      int (*dump)(struct sk_buff *skb, struct netlink_callback*),
 			      int (*done)(struct netlink_callback*));
 
+#define NL_NONROOT_RECV 0x1
+#define NL_NONROOT_SEND 0x2
+extern void netlink_set_nonroot(int protocol, unsigned flag);
+
 
 #endif /* __KERNEL__ */
 
diff -X ../KDIFX -burp linux/net/core/rtnetlink.c linux-2.5.21-work/net/core/rtnetlink.c
--- linux/net/core/rtnetlink.c	Sun Apr 14 21:18:53 2002
+++ linux-2.5.21-work/net/core/rtnetlink.c	Wed Jun 12 01:22:43 2002
@@ -523,6 +523,7 @@ void __init rtnetlink_init(void)
 	rtnl = netlink_kernel_create(NETLINK_ROUTE, rtnetlink_rcv);
 	if (rtnl == NULL)
 		panic("rtnetlink_init: cannot initialize rtnetlink\n");
+	netlink_set_nonroot(NETLINK_ROUTE, NL_NONROOT_RECV);
 	register_netdevice_notifier(&rtnetlink_dev_notifier);
 	rtnetlink_links[PF_UNSPEC] = link_rtnetlink_table;
 	rtnetlink_links[PF_PACKET] = link_rtnetlink_table;
diff -X ../KDIFX -burp linux/net/netlink/af_netlink.c linux-2.5.21-work/net/netlink/af_netlink.c
--- linux/net/netlink/af_netlink.c	Sun Apr 14 21:18:53 2002
+++ linux-2.5.21-work/net/netlink/af_netlink.c	Wed Jun 12 01:28:06 2002
@@ -68,6 +68,7 @@ struct netlink_opt
 
 static struct sock *nl_table[MAX_LINKS];
 static DECLARE_WAIT_QUEUE_HEAD(nl_table_wait);
+static unsigned nl_nonroot[MAX_LINKS];
 
 #ifdef NL_EMULATE_DEV
 static struct socket *netlink_kernel[MAX_LINKS];
@@ -308,6 +309,11 @@ retry:
 	return 0;
 }
 
+static inline int netlink_capable(struct socket *sock, unsigned flag) 
+{ 
+	return (nl_nonroot[sock->sk->protocol] & flag) || capable(CAP_NET_ADMIN);
+} 
+
 static int netlink_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 {
 	struct sock *sk = sock->sk;
@@ -319,7 +325,7 @@ static int netlink_bind(struct socket *s
 		return -EINVAL;
 
 	/* Only superuser is allowed to listen multicasts */
-	if (nladdr->nl_groups && !capable(CAP_NET_ADMIN))
+	if (nladdr->nl_groups && !netlink_capable(sock, NL_NONROOT_RECV))
 		return -EPERM;
 
 	if (nlk->pid) {
@@ -359,7 +365,7 @@ static int netlink_connect(struct socket
 		return -EINVAL;
 
 	/* Only superuser is allowed to send multicasts */
-	if (nladdr->nl_groups && !capable(CAP_NET_ADMIN))
+	if (nladdr->nl_groups && !netlink_capable(sock, NL_NONROOT_SEND))
 		return -EPERM;
 
 	if (!nlk->pid)
@@ -580,7 +586,7 @@ static int netlink_sendmsg(struct socket
 			return -EINVAL;
 		dst_pid = addr->nl_pid;
 		dst_groups = addr->nl_groups;
-		if (dst_groups && !capable(CAP_NET_ADMIN))
+		if (dst_groups && !netlink_capable(sock, NL_NONROOT_SEND))
 			return -EPERM;
 	} else {
 		dst_pid = nlk->dst_pid;
@@ -731,6 +737,12 @@ netlink_kernel_create(int unit, void (*i
 	netlink_insert(sk, 0);
 	return sk;
 }
+
+void netlink_set_nonroot(int protocol, unsigned flags)
+{ 
+	if ((unsigned)protocol < MAX_LINKS) 
+		nl_nonroot[protocol] = flags;
+} 
 
 static void netlink_destroy_callback(struct netlink_callback *cb)
 {
diff -X ../KDIFX -burp linux/net/netsyms.c linux-2.5.21-work/net/netsyms.c
--- linux/net/netsyms.c	Sun May 12 19:37:31 2002
+++ linux-2.5.21-work/net/netsyms.c	Wed Jun 12 01:22:15 2002
@@ -402,6 +402,7 @@ EXPORT_SYMBOL(netlink_unicast);
 EXPORT_SYMBOL(netlink_kernel_create);
 EXPORT_SYMBOL(netlink_dump_start);
 EXPORT_SYMBOL(netlink_ack);
+EXPORT_SYMBOL(netlink_set_nonroot);
 #if defined(CONFIG_NETLINK_DEV) || defined(CONFIG_NETLINK_DEV_MODULE)
 EXPORT_SYMBOL(netlink_attach);
 EXPORT_SYMBOL(netlink_detach);


