Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289606AbSBEP5t>; Tue, 5 Feb 2002 10:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289621AbSBEP5l>; Tue, 5 Feb 2002 10:57:41 -0500
Received: from coruscant.franken.de ([193.174.159.226]:48874 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S289606AbSBEP51>; Tue, 5 Feb 2002 10:57:27 -0500
Date: Tue, 5 Feb 2002 16:54:22 +0100
From: Harald Welte <laforge@gnumonks.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter route_me_harder fix
Message-ID: <20020205165422.U26676@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Pungenday, the 28th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Harald Welte <laforge@gnumonks.org> -----

Date: Tue, 5 Feb 2002 16:44:19 +0100
From: Harald Welte <laforge@gnumonks.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist <netfilter-devel@lists.samba.org>
Subject: [PATCH] netfilter route_me_harder fix
Message-ID: <20020205164419.S26676@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.samba.org>,
	linux-kernel
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Pungenday, the 28th day of Chaos in the YOLD 3168
Status: RO
Content-Length: 8735
Lines: 263

Hi Dave!

I'm sorry, but it seems like the route_me_harder issue never takes an end.
We've now successfully managed to break compilation of our userspace iptables
tool.

route_me_harder is now renamed to ip_route_me_harder and moved from the include
file into net/core/netfilter.c.  As there is no IPv4 specific netfilter
source file, this is the best place to move it to.

Please apply the following patch (by Rusty & me) for 2.4.18-pre8 and 2.5.x:

diff -Nru linux-2.4.18-pre8-plain/include/linux/netfilter_ipv4.h linux-2.4.18-pre8-rmh3/include/linux/netfilter_ipv4.h
--- linux-2.4.18-pre8-plain/include/linux/netfilter_ipv4.h	Tue Feb  5 15:32:21 2002
+++ linux-2.4.18-pre8-rmh3/include/linux/netfilter_ipv4.h	Tue Feb  5 15:45:06 2002
@@ -59,95 +59,20 @@
 	NF_IP_PRI_LAST = INT_MAX,
 };
 
-#ifdef CONFIG_NETFILTER_DEBUG
-#ifdef __KERNEL__
-void nf_debug_ip_local_deliver(struct sk_buff *skb);
-void nf_debug_ip_loopback_xmit(struct sk_buff *newskb);
-void nf_debug_ip_finish_output2(struct sk_buff *skb);
-#endif /*__KERNEL__*/
-#endif /*CONFIG_NETFILTER_DEBUG*/
-
 /* Arguments for setsockopt SOL_IP: */
 /* 2.0 firewalling went from 64 through 71 (and +256, +512, etc). */
 /* 2.2 firewalling (+ masq) went from 64 through 76 */
 /* 2.4 firewalling went 64 through 67. */
 #define SO_ORIGINAL_DST 80
 
+#ifdef __KERNEL__
+#ifdef CONFIG_NETFILTER_DEBUG
+void nf_debug_ip_local_deliver(struct sk_buff *skb);
+void nf_debug_ip_loopback_xmit(struct sk_buff *newskb);
+void nf_debug_ip_finish_output2(struct sk_buff *skb);
+#endif /*CONFIG_NETFILTER_DEBUG*/
 
-/* route_me_harder function, used by iptable_nat, iptable_mangle + ip_queue 
- *
- * Ideally this would be ins some netfilter_utility module, but creating this
- * module for just one function doesn't make sense. -HW */
-
-#include <linux/netdevice.h>
-#include <linux/inetdevice.h>
-#include <linux/skbuff.h>
-#include <net/sock.h>
-#include <net/route.h>
-#include <linux/ip.h>
-
-static inline int route_me_harder(struct sk_buff **pskb)
-{
-	struct iphdr *iph = (*pskb)->nh.iph;
-	struct rtable *rt;
-	struct rt_key key = { dst:iph->daddr,
-			      src:iph->saddr,
-			      oif:(*pskb)->sk ? (*pskb)->sk->bound_dev_if : 0,
-			      tos:RT_TOS(iph->tos)|RTO_CONN,
-#ifdef CONFIG_IP_ROUTE_FWMARK
-			      fwmark:(*pskb)->nfmark
-#endif
-			    };
-	struct net_device *dev_src = NULL;
-	int err;
-
-	/* accomodate ip_route_output_slow(), which expects the key src to be
-	   0 or a local address; however some non-standard hacks like
-	   ipt_REJECT.c:send_reset() can cause packets with foreign
-           saddr to be appear on the NF_IP_LOCAL_OUT hook -MB */
-	if(key.src && !(dev_src = ip_dev_find(key.src)))
-		key.src = 0;
-
-	if ((err=ip_route_output_key(&rt, &key)) != 0) {
-		printk("route_me_harder: ip_route_output_key(dst=%u.%u.%u.%u, src=%u.%u.%u.%u, oif=%d, tos=0x%x, fwmark=0x%lx) error %d\n",
-			NIPQUAD(iph->daddr), NIPQUAD(iph->saddr),
-			(*pskb)->sk ? (*pskb)->sk->bound_dev_if : 0,
-			RT_TOS(iph->tos)|RTO_CONN,
-#ifdef CONFIG_IP_ROUTE_FWMARK
-			(*pskb)->nfmark,
-#else
-			0UL,
-#endif
-			err);
-		goto out;
-	}
-
-	/* Drop old route. */
-	dst_release((*pskb)->dst);
-
-	(*pskb)->dst = &rt->u.dst;
-
-	/* Change in oif may mean change in hh_len. */
-	if (skb_headroom(*pskb) < (*pskb)->dst->dev->hard_header_len) {
-		struct sk_buff *nskb;
-
-		nskb = skb_realloc_headroom(*pskb,
-					    (*pskb)->dst->dev->hard_header_len);
-		if (!nskb) {
-			err = -ENOMEM;
-			goto out;
-		}
-		if ((*pskb)->sk)
-			skb_set_owner_w(nskb, (*pskb)->sk);
-		kfree_skb(*pskb);
-		*pskb = nskb;
-	}
-
-out:
-	if (dev_src)
-		dev_put(dev_src);
-
-	return err;
-}
+extern int ip_route_me_harder(struct sk_buff **pskb);
+#endif /*__KERNEL__*/
 
 #endif /*__LINUX_IP_NETFILTER_H*/
diff -Nru linux-2.4.18-pre8-plain/net/core/netfilter.c linux-2.4.18-pre8-rmh3/net/core/netfilter.c
--- linux-2.4.18-pre8-plain/net/core/netfilter.c	Fri Apr 27 23:15:01 2001
+++ linux-2.4.18-pre8-rmh3/net/core/netfilter.c	Tue Feb  5 15:36:35 2002
@@ -20,6 +20,10 @@
 #include <linux/if.h>
 #include <linux/netdevice.h>
 #include <linux/brlock.h>
+#include <linux/inetdevice.h>
+#include <net/sock.h>
+#include <net/route.h>
+#include <linux/ip.h>
 
 #define __KERNEL_SYSCALLS__
 #include <linux/unistd.h>
@@ -552,6 +556,73 @@
 	kfree(info);
 	return;
 }
+
+#ifdef CONFIG_INET
+/* route_me_harder function, used by iptable_nat, iptable_mangle + ip_queue */
+int ip_route_me_harder(struct sk_buff **pskb)
+{
+	struct iphdr *iph = (*pskb)->nh.iph;
+	struct rtable *rt;
+	struct rt_key key = { dst:iph->daddr,
+			      src:iph->saddr,
+			      oif:(*pskb)->sk ? (*pskb)->sk->bound_dev_if : 0,
+			      tos:RT_TOS(iph->tos)|RTO_CONN,
+#ifdef CONFIG_IP_ROUTE_FWMARK
+			      fwmark:(*pskb)->nfmark
+#endif
+			    };
+	struct net_device *dev_src = NULL;
+	int err;
+
+	/* accomodate ip_route_output_slow(), which expects the key src to be
+	   0 or a local address; however some non-standard hacks like
+	   ipt_REJECT.c:send_reset() can cause packets with foreign
+           saddr to be appear on the NF_IP_LOCAL_OUT hook -MB */
+	if(key.src && !(dev_src = ip_dev_find(key.src)))
+		key.src = 0;
+
+	if ((err=ip_route_output_key(&rt, &key)) != 0) {
+		printk("route_me_harder: ip_route_output_key(dst=%u.%u.%u.%u, src=%u.%u.%u.%u, oif=%d, tos=0x%x, fwmark=0x%lx) error %d\n",
+			NIPQUAD(iph->daddr), NIPQUAD(iph->saddr),
+			(*pskb)->sk ? (*pskb)->sk->bound_dev_if : 0,
+			RT_TOS(iph->tos)|RTO_CONN,
+#ifdef CONFIG_IP_ROUTE_FWMARK
+			(*pskb)->nfmark,
+#else
+			0UL,
+#endif
+			err);
+		goto out;
+	}
+
+	/* Drop old route. */
+	dst_release((*pskb)->dst);
+
+	(*pskb)->dst = &rt->u.dst;
+
+	/* Change in oif may mean change in hh_len. */
+	if (skb_headroom(*pskb) < (*pskb)->dst->dev->hard_header_len) {
+		struct sk_buff *nskb;
+
+		nskb = skb_realloc_headroom(*pskb,
+					    (*pskb)->dst->dev->hard_header_len);
+		if (!nskb) {
+			err = -ENOMEM;
+			goto out;
+		}
+		if ((*pskb)->sk)
+			skb_set_owner_w(nskb, (*pskb)->sk);
+		kfree_skb(*pskb);
+		*pskb = nskb;
+	}
+
+out:
+	if (dev_src)
+		dev_put(dev_src);
+
+	return err;
+}
+#endif /*CONFIG_INET*/
 
 /* This does not belong here, but ipt_REJECT needs it if connection
    tracking in use: without this, connection may not be in hash table,
diff -Nru linux-2.4.18-pre8-plain/net/ipv4/netfilter/ip_nat_standalone.c linux-2.4.18-pre8-rmh3/net/ipv4/netfilter/ip_nat_standalone.c
--- linux-2.4.18-pre8-plain/net/ipv4/netfilter/ip_nat_standalone.c	Tue Feb  5 15:32:21 2002
+++ linux-2.4.18-pre8-rmh3/net/ipv4/netfilter/ip_nat_standalone.c	Tue Feb  5 15:36:35 2002
@@ -188,7 +188,7 @@
 	if (ret != NF_DROP && ret != NF_STOLEN
 	    && ((*pskb)->nh.iph->saddr != saddr
 		|| (*pskb)->nh.iph->daddr != daddr))
-		return route_me_harder(pskb) == 0 ? ret : NF_DROP;
+		return ip_route_me_harder(pskb) == 0 ? ret : NF_DROP;
 	return ret;
 }
 
diff -Nru linux-2.4.18-pre8-plain/net/ipv4/netfilter/ip_queue.c linux-2.4.18-pre8-rmh3/net/ipv4/netfilter/ip_queue.c
--- linux-2.4.18-pre8-plain/net/ipv4/netfilter/ip_queue.c	Tue Feb  5 15:32:21 2002
+++ linux-2.4.18-pre8-rmh3/net/ipv4/netfilter/ip_queue.c	Tue Feb  5 15:36:35 2002
@@ -261,7 +261,7 @@
 		if (!(iph->tos == e->rt_info.tos
 		      && iph->daddr == e->rt_info.daddr
 		      && iph->saddr == e->rt_info.saddr))
-			return route_me_harder(&e->skb);
+			return ip_route_me_harder(&e->skb);
 	}
 	return 0;
 }
diff -Nru linux-2.4.18-pre8-plain/net/ipv4/netfilter/iptable_mangle.c linux-2.4.18-pre8-rmh3/net/ipv4/netfilter/iptable_mangle.c
--- linux-2.4.18-pre8-plain/net/ipv4/netfilter/iptable_mangle.c	Tue Feb  5 15:32:21 2002
+++ linux-2.4.18-pre8-rmh3/net/ipv4/netfilter/iptable_mangle.c	Tue Feb  5 15:36:35 2002
@@ -162,7 +162,7 @@
 		|| (*pskb)->nh.iph->daddr != daddr
 		|| (*pskb)->nfmark != nfmark
 		|| (*pskb)->nh.iph->tos != tos))
-		return route_me_harder(pskb) == 0 ? ret : NF_DROP;
+		return ip_route_me_harder(pskb) == 0 ? ret : NF_DROP;
 
 	return ret;
 }
diff -Nru linux-2.4.18-pre8-plain/net/netsyms.c linux-2.4.18-pre8-rmh3/net/netsyms.c
--- linux-2.4.18-pre8-plain/net/netsyms.c	Tue Feb  5 15:32:21 2002
+++ linux-2.4.18-pre8-rmh3/net/netsyms.c	Tue Feb  5 15:49:26 2002
@@ -577,6 +577,10 @@
 EXPORT_SYMBOL(nf_setsockopt);
 EXPORT_SYMBOL(nf_getsockopt);
 EXPORT_SYMBOL(ip_ct_attach);
+#ifdef CONFIG_INET
+#include <linux/netfilter_ipv4.h>
+EXPORT_SYMBOL(ip_route_me_harder);
+#endif
 #endif
 
 EXPORT_SYMBOL(register_gifconf);
-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)

----- End forwarded message -----
