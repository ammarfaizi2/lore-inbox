Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317360AbSFLE0T>; Wed, 12 Jun 2002 00:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317364AbSFLE0S>; Wed, 12 Jun 2002 00:26:18 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:52745 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S317360AbSFLE0O>; Wed, 12 Jun 2002 00:26:14 -0400
Date: Wed, 12 Jun 2002 14:25:56 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: kuznet@ms2.inr.ac.ru
cc: linux-kernel@vger.kernel.org
Subject: Re: Multicast netlink for non-root process
In-Reply-To: <200206112140.BAA14401@sex.inr.ac.ru>
Message-ID: <Mutt.LNX.4.44.0206121417060.31953-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002 kuznet@ms2.inr.ac.ru wrote:

> Some time ago, patch doing something sort of this was discussed
> on netdev or here. Unfortunately, it was forgotten. So, we still have
> the thing which we have.

Hi Alexey,

Are you referring to a netlink security model which we discussed in March 
(off-list), where security is be implemented on a per-message basis?

I've attached the patch below which implements this, preserving existing 
behaviour where possible.

The main change is that the kernel module may now implement any capability 
check (including none) for both send and reception of netlink, depending 
on what is required for a specific purpose.  It also allows security to be 
implemented for unicast transmission to userspace, which is currently not 
possible.  There are no restrictions on binding to netlink broadcast 
sockets, so it is now possible for any unprivileged process to do this.  
All access permission checks are now done via send/recvmsg.

No security restrictions have been implemented for the ethertap driver 
(now that CAP_NET_ADMIN is not required to open the device), as this can 
be managed via file access permissions for /dev/tapX.  


- James
-- 
James Morris
<jmorris@intercode.com.au>


diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/drivers/net/ethertap.c linux-2.4.19-pre3-w1/drivers/net/ethertap.c
--- linux-2.4.19-pre3.orig/drivers/net/ethertap.c	Thu Oct 11 19:17:56 2001
+++ linux-2.4.19-pre3-w1/drivers/net/ethertap.c	Sun Mar 24 01:39:02 2002
@@ -204,6 +204,8 @@
 	lp->stats.tx_bytes+=skb->len;
 	lp->stats.tx_packets++;
 
+	cap_clear(NETLINK_CB(skb).req_cap);
+
 #ifndef CONFIG_ETHERTAP_MC
 	netlink_broadcast(lp->nl, skb, 0, ~0, GFP_ATOMIC);
 #else
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/include/linux/netlink.h linux-2.4.19-pre3-w1/include/linux/netlink.h
--- linux-2.4.19-pre3.orig/include/linux/netlink.h	Tue Mar 12 12:59:31 2002
+++ linux-2.4.19-pre3-w1/include/linux/netlink.h	Tue Mar 12 14:38:51 2002
@@ -94,6 +94,7 @@
 	__u32			dst_pid;
 	__u32			dst_groups;
 	kernel_cap_t		eff_cap;
+	kernel_cap_t		req_cap;
 };
 
 #define NETLINK_CB(skb)		(*(struct netlink_skb_parms*)&((skb)->cb))
@@ -118,6 +119,15 @@
  */
 #define NLMSG_GOODSIZE (PAGE_SIZE - ((sizeof(struct sk_buff)+0xF)&~0xF))
 
+#define netlink_alloc_skb(size, gfpmask)			\
+({								\
+	struct sk_buff *__skb = alloc_skb((size), (gfpmask));	\
+								\
+	if (__skb != NULL)					\
+		cap_clear(NETLINK_CB(__skb).req_cap);		\
+								\
+	__skb;							\
+})
 
 struct netlink_callback
 {
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/core/neighbour.c linux-2.4.19-pre3-w1/net/core/neighbour.c
--- linux-2.4.19-pre3.orig/net/core/neighbour.c	Sat Feb  9 00:38:25 2002
+++ linux-2.4.19-pre3-w1/net/core/neighbour.c	Wed Mar 20 00:14:09 2002
@@ -1402,7 +1402,7 @@
 	struct nlmsghdr  *nlh;
 	int size = NLMSG_SPACE(sizeof(struct ndmsg)+256);
 
-	skb = alloc_skb(size, GFP_ATOMIC);
+	skb = netlink_alloc_skb(size, GFP_ATOMIC);
 	if (!skb)
 		return;
 
@@ -1413,6 +1413,7 @@
 	nlh = (struct nlmsghdr*)skb->data;
 	nlh->nlmsg_flags = NLM_F_REQUEST;
 	NETLINK_CB(skb).dst_groups = RTMGRP_NEIGH;
+	cap_raise(NETLINK_CB(skb).req_cap, CAP_NET_ADMIN);
 	netlink_broadcast(rtnl, skb, 0, RTMGRP_NEIGH, GFP_ATOMIC);
 }
 
@@ -1422,7 +1423,7 @@
 	struct nlmsghdr  *nlh;
 	int size = NLMSG_SPACE(sizeof(struct ndmsg)+256);
 
-	skb = alloc_skb(size, GFP_ATOMIC);
+	skb = netlink_alloc_skb(size, GFP_ATOMIC);
 	if (!skb)
 		return;
 
@@ -1432,6 +1433,7 @@
 	}
 	nlh = (struct nlmsghdr*)skb->data;
 	NETLINK_CB(skb).dst_groups = RTMGRP_NEIGH;
+	cap_raise(NETLINK_CB(skb).req_cap, CAP_NET_ADMIN);
 	netlink_broadcast(rtnl, skb, 0, RTMGRP_NEIGH, GFP_ATOMIC);
 }
 
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/core/rtnetlink.c linux-2.4.19-pre3-w1/net/core/rtnetlink.c
--- linux-2.4.19-pre3.orig/net/core/rtnetlink.c	Tue Mar 12 12:59:31 2002
+++ linux-2.4.19-pre3-w1/net/core/rtnetlink.c	Sat Mar 23 20:07:16 2002
@@ -249,7 +249,7 @@
 	struct sk_buff *skb;
 	int size = NLMSG_GOODSIZE;
 
-	skb = alloc_skb(size, GFP_KERNEL);
+	skb = netlink_alloc_skb(size, GFP_KERNEL);
 	if (!skb)
 		return;
 
@@ -258,6 +258,7 @@
 		return;
 	}
 	NETLINK_CB(skb).dst_groups = RTMGRP_LINK;
+	cap_raise(NETLINK_CB(skb).req_cap, CAP_NET_ADMIN);
 	netlink_broadcast(rtnl, skb, 0, RTMGRP_LINK, GFP_KERNEL);
 }
 
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/decnet/dn_dev.c linux-2.4.19-pre3-w1/net/decnet/dn_dev.c
--- linux-2.4.19-pre3.orig/net/decnet/dn_dev.c	Sat Feb  9 00:38:25 2002
+++ linux-2.4.19-pre3-w1/net/decnet/dn_dev.c	Wed Mar 20 00:17:49 2002
@@ -599,7 +599,7 @@
 	struct sk_buff *skb;
 	int size = NLMSG_SPACE(sizeof(struct ifaddrmsg)+128);
 
-	skb = alloc_skb(size, GFP_KERNEL);
+	skb = netlink_alloc_skb(size, GFP_KERNEL);
 	if (!skb) {
 		netlink_set_err(rtnl, 0, RTMGRP_DECnet_IFADDR, ENOBUFS);
 		return;
@@ -610,6 +610,7 @@
 		return;
 	}
 	NETLINK_CB(skb).dst_groups = RTMGRP_DECnet_IFADDR;
+	cap_raise(NETLINK_CB(skb).req_cap, CAP_NET_ADMIN);
 	netlink_broadcast(rtnl, skb, 0, RTMGRP_DECnet_IFADDR, GFP_KERNEL);
 }
 
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/decnet/dn_route.c linux-2.4.19-pre3-w1/net/decnet/dn_route.c
--- linux-2.4.19-pre3.orig/net/decnet/dn_route.c	Sat Feb  9 00:38:25 2002
+++ linux-2.4.19-pre3-w1/net/decnet/dn_route.c	Sun Mar 24 01:59:35 2002
@@ -1071,7 +1071,7 @@
 	int err;
 	struct sk_buff *skb;
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
+	skb = netlink_alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (skb == NULL)
 		return -ENOBUFS;
 	skb->mac.raw = skb->data;
@@ -1103,6 +1103,7 @@
 		err = dn_route_input(skb);
 		local_bh_enable();
 		memset(cb, 0, sizeof(struct dn_skb_cb));
+		cap_clear(NETLINK_CB(skb).req_cap);
 		rt = (struct dn_route *)skb->dst;
 	} else {
 		err = dn_route_output((struct dst_entry **)&rt, dst, src, 0);
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/decnet/dn_table.c linux-2.4.19-pre3-w1/net/decnet/dn_table.c
--- linux-2.4.19-pre3.orig/net/decnet/dn_table.c	Sat Feb  9 00:38:25 2002
+++ linux-2.4.19-pre3-w1/net/decnet/dn_table.c	Wed Mar 20 00:18:09 2002
@@ -336,7 +336,7 @@
         u32 pid = req ? req->pid : 0;
         int size = NLMSG_SPACE(sizeof(struct rtmsg) + 256);
 
-        skb = alloc_skb(size, GFP_KERNEL);
+        skb = netlink_alloc_skb(size, GFP_KERNEL);
         if (!skb)
                 return;
 
@@ -349,9 +349,12 @@
         NETLINK_CB(skb).dst_groups = RTMGRP_DECnet_ROUTE;
         if (nlh->nlmsg_flags & NLM_F_ECHO)
                 atomic_inc(&skb->users);
+	cap_raise(NETLINK_CB(skb).req_cap, CAP_NET_ADMIN);
         netlink_broadcast(rtnl, skb, pid, RTMGRP_DECnet_ROUTE, GFP_KERNEL);
-        if (nlh->nlmsg_flags & NLM_F_ECHO)
+        if (nlh->nlmsg_flags & NLM_F_ECHO) {
+		cap_clear(NETLINK_CB(skb).req_cap);
                 netlink_unicast(rtnl, skb, pid, MSG_DONTWAIT);
+	}	
 }
 
 static __inline__ int dn_hash_dump_bucket(struct sk_buff *skb, 
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/ipv4/devinet.c linux-2.4.19-pre3-w1/net/ipv4/devinet.c
--- linux-2.4.19-pre3.orig/net/ipv4/devinet.c	Sat Feb  9 00:38:25 2002
+++ linux-2.4.19-pre3-w1/net/ipv4/devinet.c	Wed Mar 20 00:23:58 2002
@@ -934,7 +934,7 @@
 	struct sk_buff *skb;
 	int size = NLMSG_SPACE(sizeof(struct ifaddrmsg)+128);
 
-	skb = alloc_skb(size, GFP_KERNEL);
+	skb = netlink_alloc_skb(size, GFP_KERNEL);
 	if (!skb) {
 		netlink_set_err(rtnl, 0, RTMGRP_IPV4_IFADDR, ENOBUFS);
 		return;
@@ -945,6 +945,7 @@
 		return;
 	}
 	NETLINK_CB(skb).dst_groups = RTMGRP_IPV4_IFADDR;
+	cap_raise(NETLINK_CB(skb).req_cap, CAP_NET_ADMIN);
 	netlink_broadcast(rtnl, skb, 0, RTMGRP_IPV4_IFADDR, GFP_KERNEL);
 }
 
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/ipv4/fib_hash.c linux-2.4.19-pre3-w1/net/ipv4/fib_hash.c
--- linux-2.4.19-pre3.orig/net/ipv4/fib_hash.c	Sat Feb  9 00:38:25 2002
+++ linux-2.4.19-pre3-w1/net/ipv4/fib_hash.c	Sat Mar 16 12:29:31 2002
@@ -869,7 +869,7 @@
 	u32 pid = req ? req->pid : 0;
 	int size = NLMSG_SPACE(sizeof(struct rtmsg)+256);
 
-	skb = alloc_skb(size, GFP_KERNEL);
+	skb = netlink_alloc_skb(size, GFP_KERNEL);
 	if (!skb)
 		return;
 
@@ -882,9 +882,12 @@
 	NETLINK_CB(skb).dst_groups = RTMGRP_IPV4_ROUTE;
 	if (n->nlmsg_flags&NLM_F_ECHO)
 		atomic_inc(&skb->users);
+	cap_raise(NETLINK_CB(skb).req_cap, CAP_NET_ADMIN);
 	netlink_broadcast(rtnl, skb, pid, RTMGRP_IPV4_ROUTE, GFP_KERNEL);
-	if (n->nlmsg_flags&NLM_F_ECHO)
+	if (n->nlmsg_flags&NLM_F_ECHO) {
+		cap_clear(NETLINK_CB(skb).req_cap);
 		netlink_unicast(rtnl, skb, pid, MSG_DONTWAIT);
+	}	
 }
 
 #ifdef CONFIG_IP_MULTIPLE_TABLES
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/ipv4/ipmr.c linux-2.4.19-pre3-w1/net/ipv4/ipmr.c
--- linux-2.4.19-pre3.orig/net/ipv4/ipmr.c	Sat Feb  9 00:38:25 2002
+++ linux-2.4.19-pre3-w1/net/ipv4/ipmr.c	Tue Mar 19 23:34:37 2002
@@ -300,6 +300,7 @@
 			nlh->nlmsg_len = NLMSG_LENGTH(sizeof(struct nlmsgerr));
 			skb_trim(skb, nlh->nlmsg_len);
 			((struct nlmsgerr*)NLMSG_DATA(nlh))->error = -ETIMEDOUT;
+			cap_clear(NETLINK_CB(skb).req_cap);
 			netlink_unicast(rtnl, skb, NETLINK_CB(skb).dst_pid, MSG_DONTWAIT);
 		} else
 			kfree_skb(skb);
@@ -511,6 +512,7 @@
 				skb_trim(skb, nlh->nlmsg_len);
 				((struct nlmsgerr*)NLMSG_DATA(nlh))->error = -EMSGSIZE;
 			}
+			cap_clear(NETLINK_CB(skb).req_cap);
 			err = netlink_unicast(rtnl, skb, NETLINK_CB(skb).dst_pid, MSG_DONTWAIT);
 		} else
 			ip_mr_forward(skb, c, 0);
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/ipv4/netfilter/ip_queue.c linux-2.4.19-pre3-w1/net/ipv4/netfilter/ip_queue.c
--- linux-2.4.19-pre3.orig/net/ipv4/netfilter/ip_queue.c	Tue Mar 12 12:59:58 2002
+++ linux-2.4.19-pre3-w1/net/ipv4/netfilter/ip_queue.c	Sat Mar 16 12:25:31 2002
@@ -415,7 +415,7 @@
 			*errp = -EINVAL;
 			return NULL;
 	}
-	skb = alloc_skb(size, GFP_ATOMIC);
+	skb = netlink_alloc_skb(size, GFP_ATOMIC);
 	if (!skb)
 		goto nlmsg_failure;
 	old_tail = skb->tail;
@@ -461,6 +461,8 @@
 	skb = netlink_build_message(e, &status);
 	if (skb == NULL)
 		return status;
+
+	cap_raise(NETLINK_CB(skb).req_cap, CAP_NET_ADMIN);
 	return netlink_unicast(nfnl, skb, nlq->peer.pid, MSG_DONTWAIT);
 }
 
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/ipv4/netfilter/ipchains_core.c linux-2.4.19-pre3-w1/net/ipv4/netfilter/ipchains_core.c
--- linux-2.4.19-pre3.orig/net/ipv4/netfilter/ipchains_core.c	Tue Mar 12 12:59:31 2002
+++ linux-2.4.19-pre3-w1/net/ipv4/netfilter/ipchains_core.c	Wed Mar 20 00:19:43 2002
@@ -537,7 +537,7 @@
 #if defined(CONFIG_NETLINK_DEV) || defined(CONFIG_NETLINK_DEV_MODULE)
 		size_t len = min_t(unsigned int, f->ipfw.fw_outputsize, ntohs(ip->tot_len))
 			+ sizeof(__u32) + sizeof(skb->nfmark) + IFNAMSIZ;
-		struct sk_buff *outskb=alloc_skb(len, GFP_ATOMIC);
+		struct sk_buff *outskb=netlink_alloc_skb(len, GFP_ATOMIC);
 
 		duprintf("Sending packet out NETLINK (length = %u).\n",
 			 (unsigned int)len);
@@ -549,6 +549,7 @@
 			strcpy(outskb->data+sizeof(__u32)*2, rif);
 			memcpy(outskb->data+sizeof(__u32)*2+IFNAMSIZ, ip,
 			       len-(sizeof(__u32)*2+IFNAMSIZ));
+			cap_raise(NETLINK_CB(outskb).req_cap, CAP_NET_ADMIN);       
 			netlink_broadcast(ipfwsk, outskb, 0, ~0, GFP_KERNEL);
 		}
 		else {
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/ipv4/netfilter/ipfwadm_core.c linux-2.4.19-pre3-w1/net/ipv4/netfilter/ipfwadm_core.c
--- linux-2.4.19-pre3.orig/net/ipv4/netfilter/ipfwadm_core.c	Tue Mar 12 12:59:31 2002
+++ linux-2.4.19-pre3-w1/net/ipv4/netfilter/ipfwadm_core.c	Wed Mar 20 00:33:39 2002
@@ -646,7 +646,7 @@
 #ifdef CONFIG_IP_FIREWALL_NETLINK
 		if((policy&IP_FW_F_PRN) && (answer == FW_REJECT || answer == FW_BLOCK))
 		{
-			struct sk_buff *skb=alloc_skb(128, GFP_ATOMIC);
+			struct sk_buff *skb=netlink_alloc_skb(128, GFP_ATOMIC);
 			if(skb)
 			{
 				int len = min_t(unsigned int,
@@ -654,6 +654,7 @@
 
 				skb_put(skb,len);
 				memcpy(skb->data,ip,len);
+				cap_raise(NETLINK_CB(skb).req_cap, CAP_NET_ADMIN);
 				if(netlink_post(NETLINK_FIREWALL, skb))
 					kfree_skb(skb);
 			}
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/ipv4/netfilter/ipt_ULOG.c linux-2.4.19-pre3-w1/net/ipv4/netfilter/ipt_ULOG.c
--- linux-2.4.19-pre3.orig/net/ipv4/netfilter/ipt_ULOG.c	Tue Mar 12 12:59:58 2002
+++ linux-2.4.19-pre3-w1/net/ipv4/netfilter/ipt_ULOG.c	Wed Mar 20 00:41:17 2002
@@ -107,6 +107,8 @@
 	NETLINK_CB(ub->skb).dst_groups = nlgroup;
 	DEBUGP("ipt_ULOG: throwing %d packets to netlink mask %u\n",
 		ub->qlen, nlgroup);
+	cap_clear(NETLINK_CB(ub->skb).req_cap);
+	cap_raise(NETLINK_CB(ub->skb).req_cap, CAP_NET_ADMIN);	
 	netlink_broadcast(nflognl, ub->skb, 0, nlgroup, GFP_ATOMIC);
 
 	ub->qlen = 0;
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/ipv4/route.c linux-2.4.19-pre3-w1/net/ipv4/route.c
--- linux-2.4.19-pre3.orig/net/ipv4/route.c	Tue Mar 12 12:59:31 2002
+++ linux-2.4.19-pre3-w1/net/ipv4/route.c	Tue Mar 19 23:43:41 2002
@@ -2120,7 +2120,7 @@
 	int err = -ENOBUFS;
 	struct sk_buff *skb;
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
+	skb = netlink_alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		goto out;
 
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/ipv4/tcp_diag.c linux-2.4.19-pre3-w1/net/ipv4/tcp_diag.c
--- linux-2.4.19-pre3.orig/net/ipv4/tcp_diag.c	Sat Feb  9 00:38:25 2002
+++ linux-2.4.19-pre3-w1/net/ipv4/tcp_diag.c	Tue Mar 19 23:46:55 2002
@@ -233,9 +233,9 @@
 		goto out;
 
 	err = -ENOMEM;
-	rep = alloc_skb(NLMSG_SPACE(sizeof(struct tcpdiagmsg)+
-				    sizeof(struct tcpdiag_meminfo)+
-				    sizeof(struct tcp_info)+64), GFP_KERNEL);
+	rep = netlink_alloc_skb(NLMSG_SPACE(sizeof(struct tcpdiagmsg)+
+				            sizeof(struct tcpdiag_meminfo)+
+				            sizeof(struct tcp_info)+64), GFP_KERNEL);
 	if (!rep)
 		goto out;
 
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/ipv6/addrconf.c linux-2.4.19-pre3-w1/net/ipv6/addrconf.c
--- linux-2.4.19-pre3.orig/net/ipv6/addrconf.c	Sat Feb  9 00:38:25 2002
+++ linux-2.4.19-pre3-w1/net/ipv6/addrconf.c	Wed Mar 20 00:25:39 2002
@@ -1773,7 +1773,7 @@
 	struct sk_buff *skb;
 	int size = NLMSG_SPACE(sizeof(struct ifaddrmsg)+128);
 
-	skb = alloc_skb(size, GFP_ATOMIC);
+	skb = netlink_alloc_skb(size, GFP_ATOMIC);
 	if (!skb) {
 		netlink_set_err(rtnl, 0, RTMGRP_IPV6_IFADDR, ENOBUFS);
 		return;
@@ -1784,6 +1784,7 @@
 		return;
 	}
 	NETLINK_CB(skb).dst_groups = RTMGRP_IPV6_IFADDR;
+	cap_raise(NETLINK_CB(skb).req_cap, CAP_NET_ADMIN);
 	netlink_broadcast(rtnl, skb, 0, RTMGRP_IPV6_IFADDR, GFP_ATOMIC);
 }
 
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/ipv6/netfilter/ip6_queue.c linux-2.4.19-pre3-w1/net/ipv6/netfilter/ip6_queue.c
--- linux-2.4.19-pre3.orig/net/ipv6/netfilter/ip6_queue.c	Tue Mar 12 12:59:58 2002
+++ linux-2.4.19-pre3-w1/net/ipv6/netfilter/ip6_queue.c	Wed Mar 20 00:01:52 2002
@@ -469,7 +469,7 @@
 			*errp = -EINVAL;
 			return NULL;
 	}
-	skb = alloc_skb(size, GFP_ATOMIC);
+	skb = netlink_alloc_skb(size, GFP_ATOMIC);
 	if (!skb)
 		goto nlmsg_failure;
 	old_tail = skb->tail;
@@ -515,6 +515,8 @@
 	skb = netlink_build_message(e, &status);
 	if (skb == NULL)
 		return status;
+
+	cap_raise(NETLINK_CB(skb).req_cap, CAP_NET_ADMIN);
 	return netlink_unicast(nfnl, skb, nlq6->peer.pid, MSG_DONTWAIT);
 }
 
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/ipv6/route.c linux-2.4.19-pre3-w1/net/ipv6/route.c
--- linux-2.4.19-pre3.orig/net/ipv6/route.c	Sat Feb  9 00:38:25 2002
+++ linux-2.4.19-pre3-w1/net/ipv6/route.c	Wed Mar 20 00:27:09 2002
@@ -1667,7 +1667,7 @@
 	struct flowi fl;
 	struct rt6_info *rt;
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
+	skb = netlink_alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (skb == NULL)
 		return -ENOBUFS;
 
@@ -1725,7 +1725,7 @@
 	struct sk_buff *skb;
 	int size = NLMSG_SPACE(sizeof(struct rtmsg)+256);
 
-	skb = alloc_skb(size, gfp_any());
+	skb = netlink_alloc_skb(size, gfp_any());
 	if (!skb) {
 		netlink_set_err(rtnl, 0, RTMGRP_IPV6_ROUTE, ENOBUFS);
 		return;
@@ -1736,6 +1736,7 @@
 		return;
 	}
 	NETLINK_CB(skb).dst_groups = RTMGRP_IPV6_ROUTE;
+	cap_raise(NETLINK_CB(skb).req_cap, CAP_NET_ADMIN);
 	netlink_broadcast(rtnl, skb, 0, RTMGRP_IPV6_ROUTE, gfp_any());
 }
 
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/netlink/af_netlink.c linux-2.4.19-pre3-w1/net/netlink/af_netlink.c
--- linux-2.4.19-pre3.orig/net/netlink/af_netlink.c	Tue Mar 12 12:59:31 2002
+++ linux-2.4.19-pre3-w1/net/netlink/af_netlink.c	Sun Mar 24 02:04:39 2002
@@ -310,10 +310,6 @@
 	if (nladdr->nl_family != AF_NETLINK)
 		return -EINVAL;
 
-	/* Only superuser is allowed to listen multicasts */
-	if (nladdr->nl_groups && !capable(CAP_NET_ADMIN))
-		return -EPERM;
-
 	if (sk->protinfo.af_netlink->pid) {
 		if (nladdr->nl_pid != sk->protinfo.af_netlink->pid)
 			return -EINVAL;
@@ -582,7 +578,7 @@
 	if ((unsigned)len > sk->sndbuf-32)
 		goto out;
 	err = -ENOBUFS;
-	skb = alloc_skb(len, GFP_KERNEL);
+	skb = netlink_alloc_skb(len, GFP_KERNEL);
 	if (skb==NULL)
 		goto out;
 
@@ -607,6 +603,7 @@
 
 	if (dst_groups) {
 		atomic_inc(&skb->users);
+		cap_raise(NETLINK_CB(skb).req_cap, CAP_NET_ADMIN);
 		netlink_broadcast(sk, skb, dst_pid, dst_groups, GFP_KERNEL);
 	}
 	err = netlink_unicast(sk, skb, dst_pid, msg->msg_flags&MSG_DONTWAIT);
@@ -633,6 +630,11 @@
 	if (skb==NULL)
 		goto out;
 
+	if (!cap_issubset(NETLINK_CB(skb).req_cap, current->cap_effective)) {
+		skb_free_datagram(sk, skb);
+		return -EPERM;
+	}
+	
 	msg->msg_namelen = 0;
 
 	copied = skb->len;
@@ -822,7 +824,7 @@
 	else
 		size = NLMSG_SPACE(4 + NLMSG_ALIGN(nlh->nlmsg_len));
 
-	skb = alloc_skb(size, GFP_KERNEL);
+	skb = netlink_alloc_skb(size, GFP_KERNEL);
 	if (!skb)
 		return;
 
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/sched/cls_api.c linux-2.4.19-pre3-w1/net/sched/cls_api.c
--- linux-2.4.19-pre3.orig/net/sched/cls_api.c	Sat Feb  9 00:38:26 2002
+++ linux-2.4.19-pre3-w1/net/sched/cls_api.c	Sat Mar 16 12:18:13 2002
@@ -319,7 +319,7 @@
 	struct sk_buff *skb;
 	u32 pid = oskb ? NETLINK_CB(oskb).pid : 0;
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
+	skb = netlink_alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
 
@@ -328,6 +328,7 @@
 		return -EINVAL;
 	}
 
+	cap_raise(NETLINK_CB(skb).req_cap, CAP_NET_ADMIN);
 	return rtnetlink_send(skb, pid, RTMGRP_TC, n->nlmsg_flags&NLM_F_ECHO);
 }
 
diff -urN -X /usr/src/misc/xkdiff linux-2.4.19-pre3.orig/net/sched/sch_api.c linux-2.4.19-pre3-w1/net/sched/sch_api.c
--- linux-2.4.19-pre3.orig/net/sched/sch_api.c	Sat Feb  9 00:38:26 2002
+++ linux-2.4.19-pre3-w1/net/sched/sch_api.c	Sat Mar 16 12:19:29 2002
@@ -768,7 +768,7 @@
 	struct sk_buff *skb;
 	u32 pid = oskb ? NETLINK_CB(oskb).pid : 0;
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
+	skb = netlink_alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
 
@@ -781,8 +781,10 @@
 			goto err_out;
 	}
 
-	if (skb->len)
+	if (skb->len) {
+		cap_raise(NETLINK_CB(skb).req_cap, CAP_NET_ADMIN);
 		return rtnetlink_send(skb, pid, RTMGRP_TC, n->nlmsg_flags&NLM_F_ECHO);
+	}	
 
 err_out:
 	kfree_skb(skb);
@@ -982,7 +984,7 @@
 	struct sk_buff *skb;
 	u32 pid = oskb ? NETLINK_CB(oskb).pid : 0;
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
+	skb = netlink_alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
 
@@ -991,6 +993,7 @@
 		return -EINVAL;
 	}
 
+	cap_raise(NETLINK_CB(skb).req_cap, CAP_NET_ADMIN);
 	return rtnetlink_send(skb, pid, RTMGRP_TC, n->nlmsg_flags&NLM_F_ECHO);
 }
 

