Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135819AbRDYGZd>; Wed, 25 Apr 2001 02:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135766AbRDYGZY>; Wed, 25 Apr 2001 02:25:24 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:6408 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S135819AbRDYGZL>; Wed, 25 Apr 2001 02:25:11 -0400
Date: Wed, 25 Apr 2001 16:24:46 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Martin Clausen <martin@ostenfeld.dk>
cc: <netfilter-devel@lists.samba.org>, <linux-kernel@vger.kernel.org>,
        Paul Rusty Russell <Paul.Russell@rustcorp.com.au>
Subject: Re: Kernel Oops when using the Netfilter QUEUE target
In-Reply-To: <20010425004937.A3904@ostenfeld.dk>
Message-ID: <Pine.LNX.4.31.0104251621260.329-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2001, Martin Clausen wrote:

> Hi there!
>
> I have encountered a problem (perhaps a bug)! The attached code makes my kernel oops
> in some cases when injecting new packets through Netfilter's QUEUE target. The problem
> only appears when the original packet is a TCP packet; i have tried with ICMP and UDP packets
> also but this does not trigger any oops. I have tried to code on several computers and they
> all oops. The following description regards the case when submitting new packets instead
> of TCP packets.

Please try the patch below.

- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN linux-2.4.3/net/ipv4/netfilter/ip_queue.c linux-2.4.3-fix/net/ipv4/netfilter/ip_queue.c
--- linux-2.4.3/net/ipv4/netfilter/ip_queue.c	Tue Dec 12 07:37:04 2000
+++ linux-2.4.3-fix/net/ipv4/netfilter/ip_queue.c	Wed Apr 25 16:10:24 2001
@@ -24,8 +24,10 @@
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
 #include <net/sock.h>
+#include <net/route.h>

 #include <linux/netfilter_ipv4/ip_queue.h>
+#include <linux/netfilter_ipv4/ip_tables.h>

 #define IPQ_QMAX_DEFAULT 1024
 #define IPQ_PROC_FS_NAME "ip_queue"
@@ -198,6 +200,32 @@
 	kfree(q);
 }

+/* With a chainsaw... */
+static int route_me_harder(struct sk_buff *skb)
+{
+	struct iphdr *iph = skb->nh.iph;
+	struct rtable *rt;
+
+	struct rt_key key = {
+				dst:iph->daddr, src:iph->saddr,
+				oif:skb->sk ? skb->sk->bound_dev_if : 0,
+				tos:RT_TOS(iph->tos)|RTO_CONN,
+#ifdef CONFIG_IP_ROUTE_FWMARK
+				fwmark:skb->nfmark
+#endif
+			};
+
+	if (ip_route_output_key(&rt, &key) != 0) {
+		printk("route_me_harder: No more route.\n");
+		return -EINVAL;
+	}
+
+	/* Drop old route. */
+	dst_release(skb->dst);
+	skb->dst = &rt->u.dst;
+	return 0;
+}
+
 static int ipq_mangle_ipv4(ipq_verdict_msg_t *v, ipq_queue_element_t *e)
 {
 	int diff;
@@ -223,6 +251,8 @@
 				      "in mangle, dropping packet\n");
 				return -ENOMEM;
 			}
+			if (e->skb->sk)
+				skb_set_owner_w(newskb, e->skb->sk);
 			kfree_skb(e->skb);
 			e->skb = newskb;
 		}
@@ -230,7 +260,13 @@
 	}
 	memcpy(e->skb->data, v->payload, v->data_len);
 	e->skb->nfcache |= NFC_ALTERED;
-	return 0;
+
+	/*
+	 * Extra routing needed on local out, as the QUEUE target never
+	 * returns control to the table.
+	 */
+	return ((e->info->hook == NF_IP_LOCAL_OUT) ?
+			route_me_harder(e->skb) : 0);
 }

 static inline int id_cmp(ipq_queue_element_t *e, unsigned long id)
diff -urN linux-2.4.3/net/ipv4/netfilter/iptable_mangle.c linux-2.4.3-fix/net/ipv4/netfilter/iptable_mangle.c
--- linux-2.4.3/net/ipv4/netfilter/iptable_mangle.c	Tue Jan 30 03:07:30 2001
+++ linux-2.4.3-fix/net/ipv4/netfilter/iptable_mangle.c	Wed Apr 25 16:09:02 2001
@@ -148,7 +148,7 @@

 	ret = ipt_do_table(pskb, hook, in, out, &packet_mangler, NULL);
 	/* Reroute for ANY change. */
-	if (ret != NF_DROP && ret != NF_STOLEN
+	if (ret != NF_DROP && ret != NF_STOLEN && ret != NF_QUEUE
 	    && ((*pskb)->nh.iph->saddr != saddr
 		|| (*pskb)->nh.iph->daddr != daddr
 		|| (*pskb)->nfmark != nfmark


