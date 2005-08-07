Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbVHGMbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVHGMbt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 08:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVHGMbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 08:31:48 -0400
Received: from modeemi.modeemi.cs.tut.fi ([130.230.72.134]:30139 "EHLO
	modeemi.modeemi.cs.tut.fi") by vger.kernel.org with ESMTP
	id S1751292AbVHGMbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 08:31:48 -0400
Date: Sun, 7 Aug 2005 15:31:45 +0300
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] net/ipv4 debug cleanup, kernel 2.6.13-rc5
Message-ID: <20050807123145.GJ27323@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: shd@modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small patch to cleanup NETDEBUG() use in net/ipv4/ for Linux 
kernel 2.6.13-rc5. Also weird use of indentation is changed in some
places.

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>

---
diff -urp linux-2.6.13-rc5-org/net/ipv4/icmp.c linux-2.6.13-rc5/net/ipv4/icmp.c
--- linux-2.6.13-rc5-org/net/ipv4/icmp.c	2005-08-02 07:45:48.000000000 +0300
+++ linux-2.6.13-rc5/net/ipv4/icmp.c	2005-08-07 15:10:42.000000000 +0300
@@ -936,8 +936,7 @@ int icmp_rcv(struct sk_buff *skb)
 	case CHECKSUM_HW:
 		if (!(u16)csum_fold(skb->csum))
 			break;
-		NETDEBUG(if (net_ratelimit())
-				printk(KERN_DEBUG "icmp v4 hw csum failure\n"));
+		LIMIT_NETDEBUG(printk(KERN_DEBUG "icmp v4 hw csum failure\n"));
 	case CHECKSUM_NONE:
 		if ((u16)csum_fold(skb_checksum(skb, 0, skb->len, 0)))
 			goto error;
diff -urp linux-2.6.13-rc5-org/net/ipv4/ip_fragment.c linux-2.6.13-rc5/net/ipv4/ip_fragment.c
--- linux-2.6.13-rc5-org/net/ipv4/ip_fragment.c	2005-08-02 07:45:48.000000000 +0300
+++ linux-2.6.13-rc5/net/ipv4/ip_fragment.c	2005-08-07 15:15:05.000000000 +0300
@@ -377,7 +377,7 @@ static struct ipq *ip_frag_create(unsign
 	return ip_frag_intern(hash, qp);
 
 out_nomem:
-	NETDEBUG(if (net_ratelimit()) printk(KERN_ERR "ip_frag_create: no memory left !\n"));
+	LIMIT_NETDEBUG(printk(KERN_ERR "ip_frag_create: no memory left !\n"));
 	return NULL;
 }
 
@@ -625,10 +625,8 @@ static struct sk_buff *ip_frag_reasm(str
 	return head;
 
 out_nomem:
- 	NETDEBUG(if (net_ratelimit())
-	         printk(KERN_ERR 
-			"IP: queue_glue: no memory for gluing queue %p\n",
-			qp));
+ 	LIMIT_NETDEBUG(printk(KERN_ERR "IP: queue_glue: no memory for gluing "
+			      "queue %p\n", qp));
 	goto out_fail;
 out_oversize:
 	if (net_ratelimit())
diff -urp linux-2.6.13-rc5-org/net/ipv4/tcp_ipv4.c linux-2.6.13-rc5/net/ipv4/tcp_ipv4.c
--- linux-2.6.13-rc5-org/net/ipv4/tcp_ipv4.c	2005-08-02 07:45:48.000000000 +0300
+++ linux-2.6.13-rc5/net/ipv4/tcp_ipv4.c	2005-08-07 15:03:28.000000000 +0300
@@ -1494,12 +1494,11 @@ int tcp_v4_conn_request(struct sock *sk,
 			 * to destinations, already remembered
 			 * to the moment of synflood.
 			 */
-			NETDEBUG(if (net_ratelimit()) \
-					printk(KERN_DEBUG "TCP: drop open "
-							  "request from %u.%u."
-							  "%u.%u/%u\n", \
-					       NIPQUAD(saddr),
-					       ntohs(skb->h.th->source)));
+			LIMIT_NETDEBUG(printk(KERN_DEBUG "TCP: drop open "
+					      "request from %u.%u."
+					      "%u.%u/%u\n",
+					      NIPQUAD(saddr),
+					      ntohs(skb->h.th->source)));
 			dst_release(dst);
 			goto drop_and_free;
 		}
@@ -1627,8 +1626,7 @@ static int tcp_v4_checksum_init(struct s
 				  skb->nh.iph->daddr, skb->csum))
 			return 0;
 
-		NETDEBUG(if (net_ratelimit())
-				printk(KERN_DEBUG "hw tcp v4 csum failed\n"));
+		LIMIT_NETDEBUG(printk(KERN_DEBUG "hw tcp v4 csum failed\n"));
 		skb->ip_summed = CHECKSUM_NONE;
 	}
 	if (skb->len <= 76) {
diff -urp linux-2.6.13-rc5-org/net/ipv4/udp.c linux-2.6.13-rc5/net/ipv4/udp.c
--- linux-2.6.13-rc5-org/net/ipv4/udp.c	2005-08-02 07:45:48.000000000 +0300
+++ linux-2.6.13-rc5/net/ipv4/udp.c	2005-08-07 15:16:57.000000000 +0300
@@ -628,7 +628,7 @@ back_from_confirm:
 		/* ... which is an evident application bug. --ANK */
 		release_sock(sk);
 
-		NETDEBUG(if (net_ratelimit()) printk(KERN_DEBUG "udp cork app bug 2\n"));
+		LIMIT_NETDEBUG(printk(KERN_DEBUG "udp cork app bug 2\n"));
 		err = -EINVAL;
 		goto out;
 	}
@@ -693,7 +693,7 @@ static int udp_sendpage(struct sock *sk,
 	if (unlikely(!up->pending)) {
 		release_sock(sk);
 
-		NETDEBUG(if (net_ratelimit()) printk(KERN_DEBUG "udp cork app bug 3\n"));
+		LIMIT_NETDEBUG(printk(KERN_DEBUG "udp cork app bug 3\n"));
 		return -EINVAL;
 	}
 
@@ -1102,7 +1102,7 @@ static int udp_checksum_init(struct sk_b
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 		if (!udp_check(uh, ulen, saddr, daddr, skb->csum))
 			return 0;
-		NETDEBUG(if (net_ratelimit()) printk(KERN_DEBUG "udp v4 hw csum failure.\n"));
+		LIMIT_NETDEBUG(printk(KERN_DEBUG "udp v4 hw csum failure.\n"));
 		skb->ip_summed = CHECKSUM_NONE;
 	}
 	if (skb->ip_summed != CHECKSUM_UNNECESSARY)
@@ -1181,14 +1181,13 @@ int udp_rcv(struct sk_buff *skb)
 	return(0);
 
 short_packet:
-	NETDEBUG(if (net_ratelimit())
-		printk(KERN_DEBUG "UDP: short packet: From %u.%u.%u.%u:%u %d/%d to %u.%u.%u.%u:%u\n",
-			NIPQUAD(saddr),
-			ntohs(uh->source),
-			ulen,
-			len,
-			NIPQUAD(daddr),
-			ntohs(uh->dest)));
+	LIMIT_NETDEBUG(printk(KERN_DEBUG "UDP: short packet: From %u.%u.%u.%u:%u %d/%d to %u.%u.%u.%u:%u\n",
+			      NIPQUAD(saddr),
+			      ntohs(uh->source),
+			      ulen,
+			      len,
+			      NIPQUAD(daddr),
+			      ntohs(uh->dest)));
 no_header:
 	UDP_INC_STATS_BH(UDP_MIB_INERRORS);
 	kfree_skb(skb);
@@ -1199,13 +1198,12 @@ csum_error:
 	 * RFC1122: OK.  Discards the bad packet silently (as far as 
 	 * the network is concerned, anyway) as per 4.1.3.4 (MUST). 
 	 */
-	NETDEBUG(if (net_ratelimit())
-		 printk(KERN_DEBUG "UDP: bad checksum. From %d.%d.%d.%d:%d to %d.%d.%d.%d:%d ulen %d\n",
-			NIPQUAD(saddr),
-			ntohs(uh->source),
-			NIPQUAD(daddr),
-			ntohs(uh->dest),
-			ulen));
+	LIMIT_NETDEBUG(printk(KERN_DEBUG "UDP: bad checksum. From %d.%d.%d.%d:%d to %d.%d.%d.%d:%d ulen %d\n",
+			      NIPQUAD(saddr),
+			      ntohs(uh->source),
+			      NIPQUAD(daddr),
+			      ntohs(uh->dest),
+			      ulen));
 drop:
 	UDP_INC_STATS_BH(UDP_MIB_INERRORS);
 	kfree_skb(skb);


