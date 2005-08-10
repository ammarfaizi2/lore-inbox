Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVHJBJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVHJBJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 21:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVHJBJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 21:09:27 -0400
Received: from [62.206.217.67] ([62.206.217.67]:59362 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S1751028AbVHJBJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 21:09:26 -0400
Message-ID: <42F953CE.305@trash.net>
Date: Wed, 10 Aug 2005 03:09:34 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050803 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Heikki Orsila <shd@modeemi.cs.tut.fi>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] net/ipv4 debug cleanup, kernel 2.6.13-rc5
References: <20050807123145.GJ27323@jolt.modeemi.cs.tut.fi>
In-Reply-To: <20050807123145.GJ27323@jolt.modeemi.cs.tut.fi>
Content-Type: multipart/mixed;
 boundary="------------000305080300080005020801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000305080300080005020801
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Heikki Orsila wrote:
> Here's a small patch to cleanup NETDEBUG() use in net/ipv4/ for Linux 
> kernel 2.6.13-rc5. Also weird use of indentation is changed in some
> places.
> 
> ---
> diff -urp linux-2.6.13-rc5-org/net/ipv4/icmp.c linux-2.6.13-rc5/net/ipv4/icmp.c
> --- linux-2.6.13-rc5-org/net/ipv4/icmp.c	2005-08-02 07:45:48.000000000 +0300
> +++ linux-2.6.13-rc5/net/ipv4/icmp.c	2005-08-07 15:10:42.000000000 +0300
> @@ -936,8 +936,7 @@ int icmp_rcv(struct sk_buff *skb)
>  	case CHECKSUM_HW:
>  		if (!(u16)csum_fold(skb->csum))
>  			break;
> -		NETDEBUG(if (net_ratelimit())
> -				printk(KERN_DEBUG "icmp v4 hw csum failure\n"));
> +		LIMIT_NETDEBUG(printk(KERN_DEBUG "icmp v4 hw csum failure\n"));
>  	case CHECKSUM_NONE:
>  		if ((u16)csum_fold(skb_checksum(skb, 0, skb->len, 0)))
>  			goto error;

These macros always looked a bit ugly to me, with your cleanup there
isn't a single spot left where we require them to accept code as
argument, so how about we change them to pure printk wrappers?


--------------000305080300080005020801
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[NET]: Make NETDEBUG pure printk wrappers

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit a2db7bcdba3678fe8f67cd7d631c01a888031753
tree 7201cec98ca35b5854daebc14e4650ff95eb8571
parent db29e85a7ece62de1899917c1ec0ffe55cf1d3a0
author Patrick McHardy <kaber@trash.net> Wed, 10 Aug 2005 03:08:01 +0200
committer Patrick McHardy <kaber@trash.net> Wed, 10 Aug 2005 03:08:01 +0200

 include/net/sock.h     |    4 ++--
 net/ipv4/esp4.c        |   12 ++++++------
 net/ipv4/icmp.c        |   12 +++++-------
 net/ipv4/igmp.c        |    2 +-
 net/ipv4/ip_fragment.c |    6 +++---
 net/ipv4/ip_output.c   |    2 +-
 net/ipv4/ipcomp.c      |    4 ++--
 net/ipv4/tcp_ipv4.c    |   11 +++++------
 net/ipv4/udp.c         |   32 ++++++++++++++++----------------
 net/ipv6/ah6.c         |   13 ++++++-------
 net/ipv6/datagram.c    |    4 ++--
 net/ipv6/esp6.c        |    3 +--
 net/ipv6/exthdrs.c     |    8 ++++----
 net/ipv6/icmp.c        |   20 +++++++-------------
 net/ipv6/ip6_output.c  |    5 ++---
 net/ipv6/raw.c         |    3 +--
 net/ipv6/tcp_ipv6.c    |    2 +-
 net/ipv6/udp.c         |    7 +++----
 18 files changed, 68 insertions(+), 82 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1260,8 +1260,8 @@ extern int sock_get_timestamp(struct soc
 #define NETDEBUG(x)	do { } while (0)
 #define LIMIT_NETDEBUG(x) do {} while(0)
 #else
-#define NETDEBUG(x)	do { x; } while (0)
-#define LIMIT_NETDEBUG(x) do { if (net_ratelimit()) { x; } } while(0)
+#define NETDEBUG(fmt, args...)	printk(fmt,##args)
+#define LIMIT_NETDEBUG(fmt, args...) do { if (net_ratelimit()) printk(fmt,##args); } while(0)
 #endif
 
 /*
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -331,8 +331,8 @@ static void esp4_err(struct sk_buff *skb
 	x = xfrm_state_lookup((xfrm_address_t *)&iph->daddr, esph->spi, IPPROTO_ESP, AF_INET);
 	if (!x)
 		return;
-	NETDEBUG(printk(KERN_DEBUG "pmtu discovery on SA ESP/%08x/%08x\n",
-			ntohl(esph->spi), ntohl(iph->daddr)));
+	NETDEBUG(KERN_DEBUG "pmtu discovery on SA ESP/%08x/%08x\n",
+		 ntohl(esph->spi), ntohl(iph->daddr));
 	xfrm_state_put(x);
 }
 
@@ -395,10 +395,10 @@ static int esp_init_state(struct xfrm_st
 
 		if (aalg_desc->uinfo.auth.icv_fullbits/8 !=
 		    crypto_tfm_alg_digestsize(esp->auth.tfm)) {
-			NETDEBUG(printk(KERN_INFO "ESP: %s digestsize %u != %hu\n",
-			       x->aalg->alg_name,
-			       crypto_tfm_alg_digestsize(esp->auth.tfm),
-			       aalg_desc->uinfo.auth.icv_fullbits/8));
+			NETDEBUG(KERN_INFO "ESP: %s digestsize %u != %hu\n",
+				 x->aalg->alg_name,
+				 crypto_tfm_alg_digestsize(esp->auth.tfm),
+				 aalg_desc->uinfo.auth.icv_fullbits/8);
 			goto error;
 		}
 
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -627,11 +627,10 @@ static void icmp_unreach(struct sk_buff 
 			break;
 		case ICMP_FRAG_NEEDED:
 			if (ipv4_config.no_pmtu_disc) {
-				LIMIT_NETDEBUG(
-					printk(KERN_INFO "ICMP: %u.%u.%u.%u: "
+				LIMIT_NETDEBUG(KERN_INFO "ICMP: %u.%u.%u.%u: "
 							 "fragmentation needed "
 							 "and DF set.\n",
-					       NIPQUAD(iph->daddr)));
+					       NIPQUAD(iph->daddr));
 			} else {
 				info = ip_rt_frag_needed(iph,
 						     ntohs(icmph->un.frag.mtu));
@@ -640,10 +639,9 @@ static void icmp_unreach(struct sk_buff 
 			}
 			break;
 		case ICMP_SR_FAILED:
-			LIMIT_NETDEBUG(
-				printk(KERN_INFO "ICMP: %u.%u.%u.%u: Source "
+			LIMIT_NETDEBUG(KERN_INFO "ICMP: %u.%u.%u.%u: Source "
 						 "Route Failed.\n",
-				       NIPQUAD(iph->daddr)));
+				       NIPQUAD(iph->daddr));
 			break;
 		default:
 			break;
@@ -936,7 +934,7 @@ int icmp_rcv(struct sk_buff *skb)
 	case CHECKSUM_HW:
 		if (!(u16)csum_fold(skb->csum))
 			break;
-		LIMIT_NETDEBUG(printk(KERN_DEBUG "icmp v4 hw csum failure\n"));
+		LIMIT_NETDEBUG(KERN_DEBUG "icmp v4 hw csum failure\n");
 	case CHECKSUM_NONE:
 		if ((u16)csum_fold(skb_checksum(skb, 0, skb->len, 0)))
 			goto error;
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -904,7 +904,7 @@ int igmp_rcv(struct sk_buff *skb)
 	case IGMP_MTRACE_RESP:
 		break;
 	default:
-		NETDEBUG(printk(KERN_DEBUG "New IGMP type=%d, why we do not know about it?\n", ih->type));
+		NETDEBUG(KERN_DEBUG "New IGMP type=%d, why we do not know about it?\n", ih->type);
 	}
 	in_dev_put(in_dev);
 	kfree_skb(skb);
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -377,7 +377,7 @@ static struct ipq *ip_frag_create(unsign
 	return ip_frag_intern(hash, qp);
 
 out_nomem:
-	LIMIT_NETDEBUG(printk(KERN_ERR "ip_frag_create: no memory left !\n"));
+	LIMIT_NETDEBUG(KERN_ERR "ip_frag_create: no memory left !\n");
 	return NULL;
 }
 
@@ -625,8 +625,8 @@ static struct sk_buff *ip_frag_reasm(str
 	return head;
 
 out_nomem:
- 	LIMIT_NETDEBUG(printk(KERN_ERR "IP: queue_glue: no memory for gluing "
-			      "queue %p\n", qp));
+ 	LIMIT_NETDEBUG(KERN_ERR "IP: queue_glue: no memory for gluing "
+			      "queue %p\n", qp);
 	goto out_fail;
 out_oversize:
 	if (net_ratelimit())
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -580,7 +580,7 @@ slow_path:
 		 */
 
 		if ((skb2 = alloc_skb(len+hlen+ll_rs, GFP_ATOMIC)) == NULL) {
-			NETDEBUG(printk(KERN_INFO "IP: frag: no memory for new fragment!\n"));
+			NETDEBUG(KERN_INFO "IP: frag: no memory for new fragment!\n");
 			err = -ENOMEM;
 			goto fail;
 		}
diff --git a/net/ipv4/ipcomp.c b/net/ipv4/ipcomp.c
--- a/net/ipv4/ipcomp.c
+++ b/net/ipv4/ipcomp.c
@@ -214,8 +214,8 @@ static void ipcomp4_err(struct sk_buff *
 	                      spi, IPPROTO_COMP, AF_INET);
 	if (!x)
 		return;
-	NETDEBUG(printk(KERN_DEBUG "pmtu discovery on SA IPCOMP/%08x/%u.%u.%u.%u\n",
-	       spi, NIPQUAD(iph->daddr)));
+	NETDEBUG(KERN_DEBUG "pmtu discovery on SA IPCOMP/%08x/%u.%u.%u.%u\n",
+		 spi, NIPQUAD(iph->daddr));
 	xfrm_state_put(x);
 }
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1494,11 +1494,10 @@ int tcp_v4_conn_request(struct sock *sk,
 			 * to destinations, already remembered
 			 * to the moment of synflood.
 			 */
-			LIMIT_NETDEBUG(printk(KERN_DEBUG "TCP: drop open "
-					      "request from %u.%u."
-					      "%u.%u/%u\n",
-					      NIPQUAD(saddr),
-					      ntohs(skb->h.th->source)));
+			LIMIT_NETDEBUG(KERN_DEBUG "TCP: drop open "
+				       "request from %u.%u.%u.%u/%u\n",
+				       NIPQUAD(saddr),
+				       ntohs(skb->h.th->source));
 			dst_release(dst);
 			goto drop_and_free;
 		}
@@ -1626,7 +1625,7 @@ static int tcp_v4_checksum_init(struct s
 				  skb->nh.iph->daddr, skb->csum))
 			return 0;
 
-		LIMIT_NETDEBUG(printk(KERN_DEBUG "hw tcp v4 csum failed\n"));
+		LIMIT_NETDEBUG(KERN_DEBUG "hw tcp v4 csum failed\n");
 		skb->ip_summed = CHECKSUM_NONE;
 	}
 	if (skb->len <= 76) {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -628,7 +628,7 @@ back_from_confirm:
 		/* ... which is an evident application bug. --ANK */
 		release_sock(sk);
 
-		LIMIT_NETDEBUG(printk(KERN_DEBUG "udp cork app bug 2\n"));
+		LIMIT_NETDEBUG(KERN_DEBUG "udp cork app bug 2\n");
 		err = -EINVAL;
 		goto out;
 	}
@@ -693,7 +693,7 @@ static int udp_sendpage(struct sock *sk,
 	if (unlikely(!up->pending)) {
 		release_sock(sk);
 
-		LIMIT_NETDEBUG(printk(KERN_DEBUG "udp cork app bug 3\n"));
+		LIMIT_NETDEBUG(KERN_DEBUG "udp cork app bug 3\n");
 		return -EINVAL;
 	}
 
@@ -1102,7 +1102,7 @@ static int udp_checksum_init(struct sk_b
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 		if (!udp_check(uh, ulen, saddr, daddr, skb->csum))
 			return 0;
-		LIMIT_NETDEBUG(printk(KERN_DEBUG "udp v4 hw csum failure.\n"));
+		LIMIT_NETDEBUG(KERN_DEBUG "udp v4 hw csum failure.\n");
 		skb->ip_summed = CHECKSUM_NONE;
 	}
 	if (skb->ip_summed != CHECKSUM_UNNECESSARY)
@@ -1181,13 +1181,13 @@ int udp_rcv(struct sk_buff *skb)
 	return(0);
 
 short_packet:
-	LIMIT_NETDEBUG(printk(KERN_DEBUG "UDP: short packet: From %u.%u.%u.%u:%u %d/%d to %u.%u.%u.%u:%u\n",
-			      NIPQUAD(saddr),
-			      ntohs(uh->source),
-			      ulen,
-			      len,
-			      NIPQUAD(daddr),
-			      ntohs(uh->dest)));
+	LIMIT_NETDEBUG(KERN_DEBUG "UDP: short packet: From %u.%u.%u.%u:%u %d/%d to %u.%u.%u.%u:%u\n",
+		       NIPQUAD(saddr),
+		       ntohs(uh->source),
+		       ulen,
+		       len,
+		       NIPQUAD(daddr),
+		       ntohs(uh->dest));
 no_header:
 	UDP_INC_STATS_BH(UDP_MIB_INERRORS);
 	kfree_skb(skb);
@@ -1198,12 +1198,12 @@ csum_error:
 	 * RFC1122: OK.  Discards the bad packet silently (as far as 
 	 * the network is concerned, anyway) as per 4.1.3.4 (MUST). 
 	 */
-	LIMIT_NETDEBUG(printk(KERN_DEBUG "UDP: bad checksum. From %d.%d.%d.%d:%d to %d.%d.%d.%d:%d ulen %d\n",
-			      NIPQUAD(saddr),
-			      ntohs(uh->source),
-			      NIPQUAD(daddr),
-			      ntohs(uh->dest),
-			      ulen));
+	LIMIT_NETDEBUG(KERN_DEBUG "UDP: bad checksum. From %d.%d.%d.%d:%d to %d.%d.%d.%d:%d ulen %d\n",
+		       NIPQUAD(saddr),
+		       ntohs(uh->source),
+		       NIPQUAD(daddr),
+		       ntohs(uh->dest),
+		       ulen);
 drop:
 	UDP_INC_STATS_BH(UDP_MIB_INERRORS);
 	kfree_skb(skb);
diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -131,10 +131,10 @@ static int ipv6_clear_mutable_options(st
 		case NEXTHDR_HOP:
 		case NEXTHDR_DEST:
 			if (!zero_out_mutable_opts(exthdr.opth)) {
-				LIMIT_NETDEBUG(printk(
+				LIMIT_NETDEBUG(
 					KERN_WARNING "overrun %sopts\n",
 					nexthdr == NEXTHDR_HOP ?
-						"hop" : "dest"));
+						"hop" : "dest");
 				return -EINVAL;
 			}
 			break;
@@ -293,8 +293,7 @@ static int ah6_input(struct xfrm_state *
 		skb_push(skb, skb->data - skb->nh.raw);
 		ahp->icv(ahp, skb, ah->auth_data);
 		if (memcmp(ah->auth_data, auth_data, ahp->icv_trunc_len)) {
-			LIMIT_NETDEBUG(
-				printk(KERN_WARNING "ipsec ah authentication error\n"));
+			LIMIT_NETDEBUG(KERN_WARNING "ipsec ah authentication error\n");
 			x->stats.integrity_failed++;
 			goto free_out;
 		}
@@ -332,9 +331,9 @@ static void ah6_err(struct sk_buff *skb,
 	if (!x)
 		return;
 
-	NETDEBUG(printk(KERN_DEBUG "pmtu discovery on SA AH/%08x/"
-			"%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
-	       ntohl(ah->spi), NIP6(iph->daddr)));
+	NETDEBUG(KERN_DEBUG "pmtu discovery on SA AH/%08x/"
+		 "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
+		 ntohl(ah->spi), NIP6(iph->daddr));
 
 	xfrm_state_put(x);
 }
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -588,8 +588,8 @@ int datagram_send_ctl(struct msghdr *msg
 			break;
 
 		default:
-			LIMIT_NETDEBUG(
-				printk(KERN_DEBUG "invalid cmsg type: %d\n", cmsg->cmsg_type));
+			LIMIT_NETDEBUG(KERN_DEBUG "invalid cmsg type: %d\n",
+			               cmsg->cmsg_type);
 			err = -EINVAL;
 			break;
 		};
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -212,8 +212,7 @@ static int esp6_input(struct xfrm_state 
 
 		padlen = nexthdr[0];
 		if (padlen+2 >= elen) {
-			LIMIT_NETDEBUG(
-				printk(KERN_WARNING "ipsec esp packet is garbage padlen=%d, elen=%d\n", padlen+2, elen));
+			LIMIT_NETDEBUG(KERN_WARNING "ipsec esp packet is garbage padlen=%d, elen=%d\n", padlen+2, elen);
 			ret = -EINVAL;
 			goto out;
 		}
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -424,8 +424,8 @@ static int ipv6_hop_ra(struct sk_buff *s
 		IP6CB(skb)->ra = optoff;
 		return 1;
 	}
-	LIMIT_NETDEBUG(
-		 printk(KERN_DEBUG "ipv6_hop_ra: wrong RA length %d\n", skb->nh.raw[optoff+1]));
+	LIMIT_NETDEBUG(KERN_DEBUG "ipv6_hop_ra: wrong RA length %d\n",
+	               skb->nh.raw[optoff+1]);
 	kfree_skb(skb);
 	return 0;
 }
@@ -437,8 +437,8 @@ static int ipv6_hop_jumbo(struct sk_buff
 	u32 pkt_len;
 
 	if (skb->nh.raw[optoff+1] != 4 || (optoff&3) != 2) {
-		LIMIT_NETDEBUG(
-			 printk(KERN_DEBUG "ipv6_hop_jumbo: wrong jumbo opt length/alignment %d\n", skb->nh.raw[optoff+1]));
+		LIMIT_NETDEBUG(KERN_DEBUG "ipv6_hop_jumbo: wrong jumbo opt length/alignment %d\n",
+		               skb->nh.raw[optoff+1]);
 		IP6_INC_STATS_BH(IPSTATS_MIB_INHDRERRORS);
 		goto drop;
 	}
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -332,8 +332,7 @@ void icmpv6_send(struct sk_buff *skb, in
 	 *	for now we don't know that.
 	 */
 	if ((addr_type == IPV6_ADDR_ANY) || (addr_type & IPV6_ADDR_MULTICAST)) {
-		LIMIT_NETDEBUG(
-			printk(KERN_DEBUG "icmpv6_send: addr_any/mcast source\n"));
+		LIMIT_NETDEBUG(KERN_DEBUG "icmpv6_send: addr_any/mcast source\n");
 		return;
 	}
 
@@ -341,8 +340,7 @@ void icmpv6_send(struct sk_buff *skb, in
 	 *	Never answer to a ICMP packet.
 	 */
 	if (is_ineligible(skb)) {
-		LIMIT_NETDEBUG(
-			printk(KERN_DEBUG "icmpv6_send: no reply to icmp error\n")); 
+		LIMIT_NETDEBUG(KERN_DEBUG "icmpv6_send: no reply to icmp error\n");
 		return;
 	}
 
@@ -393,8 +391,7 @@ void icmpv6_send(struct sk_buff *skb, in
 	len = skb->len - msg.offset;
 	len = min_t(unsigned int, len, IPV6_MIN_MTU - sizeof(struct ipv6hdr) -sizeof(struct icmp6hdr));
 	if (len < 0) {
-		LIMIT_NETDEBUG(
-			printk(KERN_DEBUG "icmp: len problem\n"));
+		LIMIT_NETDEBUG(KERN_DEBUG "icmp: len problem\n");
 		goto out_dst_release;
 	}
 
@@ -583,17 +580,15 @@ static int icmpv6_rcv(struct sk_buff **p
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 		if (csum_ipv6_magic(saddr, daddr, skb->len, IPPROTO_ICMPV6,
 				    skb->csum)) {
-			LIMIT_NETDEBUG(
-				printk(KERN_DEBUG "ICMPv6 hw checksum failed\n"));
+			LIMIT_NETDEBUG(KERN_DEBUG "ICMPv6 hw checksum failed\n");
 			skb->ip_summed = CHECKSUM_NONE;
 		}
 	}
 	if (skb->ip_summed == CHECKSUM_NONE) {
 		if (csum_ipv6_magic(saddr, daddr, skb->len, IPPROTO_ICMPV6,
 				    skb_checksum(skb, 0, skb->len, 0))) {
-			LIMIT_NETDEBUG(
-				printk(KERN_DEBUG "ICMPv6 checksum failed [%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x > %04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x]\n",
-				       NIP6(*saddr), NIP6(*daddr)));
+			LIMIT_NETDEBUG(KERN_DEBUG "ICMPv6 checksum failed [%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x > %04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x]\n",
+				       NIP6(*saddr), NIP6(*daddr));
 			goto discard_it;
 		}
 	}
@@ -669,8 +664,7 @@ static int icmpv6_rcv(struct sk_buff **p
 		break;
 
 	default:
-		LIMIT_NETDEBUG(
-			printk(KERN_DEBUG "icmpv6: msg of unknown type\n"));
+		LIMIT_NETDEBUG(KERN_DEBUG "icmpv6: msg of unknown type\n");
 
 		/* informational */
 		if (type & ICMPV6_INFOMSG_MASK)
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -171,8 +171,7 @@ int ip6_route_me_harder(struct sk_buff *
 
 	if (dst->error) {
 		IP6_INC_STATS(IPSTATS_MIB_OUTNOROUTES);
-		LIMIT_NETDEBUG(
-			printk(KERN_DEBUG "ip6_route_me_harder: No more route.\n"));
+		LIMIT_NETDEBUG(KERN_DEBUG "ip6_route_me_harder: No more route.\n");
 		dst_release(dst);
 		return -EINVAL;
 	}
@@ -667,7 +666,7 @@ slow_path:
 		 */
 
 		if ((frag = alloc_skb(len+hlen+sizeof(struct frag_hdr)+LL_RESERVED_SPACE(rt->u.dst.dev), GFP_ATOMIC)) == NULL) {
-			NETDEBUG(printk(KERN_INFO "IPv6: frag: no memory for new fragment!\n"));
+			NETDEBUG(KERN_INFO "IPv6: frag: no memory for new fragment!\n");
 			IP6_INC_STATS(IPSTATS_MIB_FRAGFAILS);
 			err = -ENOMEM;
 			goto fail;
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -332,8 +332,7 @@ int rawv6_rcv(struct sock *sk, struct sk
 			if (csum_ipv6_magic(&skb->nh.ipv6h->saddr,
 					    &skb->nh.ipv6h->daddr,
 					    skb->len, inet->num, skb->csum)) {
-				LIMIT_NETDEBUG(
-			        printk(KERN_DEBUG "raw v6 hw csum failure.\n"));
+				LIMIT_NETDEBUG(KERN_DEBUG "raw v6 hw csum failure.\n");
 				skb->ip_summed = CHECKSUM_NONE;
 			}
 		}
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1552,7 +1552,7 @@ static int tcp_v6_checksum_init(struct s
 		if (!tcp_v6_check(skb->h.th,skb->len,&skb->nh.ipv6h->saddr,
 				  &skb->nh.ipv6h->daddr,skb->csum))
 			return 0;
-		LIMIT_NETDEBUG(printk(KERN_DEBUG "hw tcp v6 csum failed\n"));
+		LIMIT_NETDEBUG(KERN_DEBUG "hw tcp v6 csum failed\n");
 	}
 	if (skb->len <= 76) {
 		if (tcp_v6_check(skb->h.th,skb->len,&skb->nh.ipv6h->saddr,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -477,8 +477,7 @@ static int udpv6_rcv(struct sk_buff **ps
 		/* RFC 2460 section 8.1 says that we SHOULD log
 		   this error. Well, it is reasonable.
 		 */
-		LIMIT_NETDEBUG(
-			printk(KERN_INFO "IPv6: udp checksum is 0\n"));
+		LIMIT_NETDEBUG(KERN_INFO "IPv6: udp checksum is 0\n");
 		goto discard;
 	}
 
@@ -493,7 +492,7 @@ static int udpv6_rcv(struct sk_buff **ps
 	if (skb->ip_summed==CHECKSUM_HW) {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 		if (csum_ipv6_magic(saddr, daddr, ulen, IPPROTO_UDP, skb->csum)) {
-			LIMIT_NETDEBUG(printk(KERN_DEBUG "udp v6 hw csum failure.\n"));
+			LIMIT_NETDEBUG(KERN_DEBUG "udp v6 hw csum failure.\n");
 			skb->ip_summed = CHECKSUM_NONE;
 		}
 	}
@@ -825,7 +824,7 @@ back_from_confirm:
 		/* ... which is an evident application bug. --ANK */
 		release_sock(sk);
 
-		LIMIT_NETDEBUG(printk(KERN_DEBUG "udp cork app bug 2\n"));
+		LIMIT_NETDEBUG(KERN_DEBUG "udp cork app bug 2\n");
 		err = -EINVAL;
 		goto out;
 	}

--------------000305080300080005020801--
