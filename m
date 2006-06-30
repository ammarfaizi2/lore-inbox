Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932716AbWF3Owx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbWF3Owx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 10:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbWF3Owx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 10:52:53 -0400
Received: from dee.erg.abdn.ac.uk ([139.133.204.82]:58873 "EHLO erg.abdn.ac.uk")
	by vger.kernel.org with ESMTP id S1751273AbWF3Owv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 10:52:51 -0400
From: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Organization: Electronics Research Group, UoA
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de
Subject: [PATCH  2.6  3/3]  net/ipv4|v6: RFC 3828-compliant UDP-Lite support
Date: Fri, 30 Jun 2006 15:52:14 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606301552.15058@strip-the-willow>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ERG-MailScanner: Found to be clean
X-ERG-MailScanner-From: gerrit@erg.abdn.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The IPv6 part of the UDP-Lite extension.


Signed-off-by: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Signed-off-by: William Stanislaus <william@erg.abdn.ac.uk>
--- 

 include/net/ipv6.h      |   11
 include/net/transp_v6.h |    4
 net/ipv6/Makefile       |    1
 net/ipv6/af_inet6.c     |   36 +
 net/ipv6/proc.c         |   21
 net/ipv6/udplite.c      | 1239 ++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1311 insertions(+), 1 deletion(-)


diff -Nurp  a/net/ipv6/udplite.c b/net/ipv6/udplite.c
--- a/net/ipv6/udplite.c	1970-01-01 01:00:00.000000000 +0100
+++ b/net/ipv6/udplite.c	2006-06-30 14:20:53.000000000 +0100
@@ -0,0 +1,1239 @@
+/*
+ *  UDPLITEv6   An implementation of the UDP-Lite protocol over IPv6.
+ *              UDP-Lite is standardised in RFC 3828.
+ *              See also net/ipv4/udplite.c
+ *
+ *  Version:    $Id: udplite.c,v 1.7 2006/06/30 07:10:06 gerrit Exp gerrit $
+ *
+ *  Authors:    Gerrit Renker       <gerrit@erg.abdn.ac.uk>
+ *
+ *		Based on original net/ipv6/udp.c code by Pedro Roque
+ *
+ *  Changes:
+ *
+ *
+ *  Fixes:
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ */
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/socket.h>
+#include <linux/sockios.h>
+#include <linux/sched.h>
+#include <linux/net.h>
+#include <linux/in6.h>
+#include <linux/netdevice.h>
+#include <linux/if_arp.h>
+#include <linux/ipv6.h>
+#include <linux/icmpv6.h>
+#include <linux/init.h>
+#include <linux/skbuff.h>
+#include <asm/uaccess.h>
+
+#include <net/sock.h>
+#include <net/snmp.h>
+
+#include <net/ipv6.h>
+#include <net/ndisc.h>
+#include <net/protocol.h>
+#include <net/transp_v6.h>
+#include <net/ip6_route.h>
+#include <net/addrconf.h>
+#include <net/ip.h>
+#include <net/udplite.h>
+#include <net/raw.h>
+#include <net/inet_common.h>
+#include <net/tcp_states.h>
+
+#include <net/ip6_checksum.h>
+#include <net/xfrm.h>
+
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+
+DEFINE_SNMP_STAT(struct udplite_mib, udplite_stats_in6) __read_mostly;
+
+/* Grrr, addr_type already calculated by caller, but I don't want
+ * to add some silly "cookie" argument to this method just for that.
+ */
+static int udplite_v6_get_port(struct sock *sk, unsigned short snum)
+{
+	struct sock *sk2;
+	struct hlist_node *node;
+
+	write_lock_bh(&udplite_hash_lock);
+	if (snum == 0) {
+		int best_size_so_far, best, result, i;
+
+		if (udplite_port_rover > sysctl_local_port_range[1] ||
+		    udplite_port_rover < sysctl_local_port_range[0])
+			udplite_port_rover = sysctl_local_port_range[0];
+		best_size_so_far = 32767;
+		best = result = udplite_port_rover;
+		for (i = 0; i < UDP_HTABLE_SIZE; i++, result++) {
+			int size;
+			struct hlist_head *list;
+
+			list = &udplite_hash[result & (UDP_HTABLE_SIZE - 1)];
+			if (hlist_empty(list)) {
+				if (result > sysctl_local_port_range[1])
+					result = sysctl_local_port_range[0] +
+					((result - sysctl_local_port_range[0]) &
+						 (UDP_HTABLE_SIZE - 1));
+				goto gotit;
+			}
+			size = 0;
+			sk_for_each(sk2, node, list)
+				if (++size >= best_size_so_far)
+					goto next;
+			best_size_so_far = size;
+			best = result;
+		next:;
+		}
+		result = best;
+		for(i = 0; i < (1 << 16) / UDP_HTABLE_SIZE;
+				i++, result += UDP_HTABLE_SIZE) {
+			if (result > sysctl_local_port_range[1])
+				result = sysctl_local_port_range[0] +
+					((result - sysctl_local_port_range[0]) &
+					   (UDP_HTABLE_SIZE - 1));
+			if (!udplite_lport_inuse(result))
+				break;
+		}
+		if (i >= (1 << 16) / UDP_HTABLE_SIZE)
+			goto fail;
+gotit:
+		udplite_port_rover = snum = result;
+	} else {
+		sk_for_each(sk2, node,
+			    &udplite_hash[snum & (UDP_HTABLE_SIZE - 1)]) {
+			if (inet_sk(sk2)->num == snum &&
+			    sk2 != sk &&
+			    (!sk2->sk_bound_dev_if ||
+			     !sk->sk_bound_dev_if ||
+			     sk2->sk_bound_dev_if == sk->sk_bound_dev_if) &&
+			    (!sk2->sk_reuse || !sk->sk_reuse) &&
+			    ipv6_rcv_saddr_equal(sk, sk2))
+				goto fail;
+		}
+	}
+
+	inet_sk(sk)->num = snum;
+	if (sk_unhashed(sk)) {
+		sk_add_node(sk, &udplite_hash[snum & (UDP_HTABLE_SIZE - 1)]);
+		sock_prot_inc_use(sk->sk_prot);
+	}
+	write_unlock_bh(&udplite_hash_lock);
+	return 0;
+
+fail:
+	write_unlock_bh(&udplite_hash_lock);
+	return 1;
+}
+
+static void udplite_v6_hash(struct sock *sk)
+{
+	BUG();
+}
+
+static void udplite_v6_unhash(struct sock *sk)
+{
+ 	write_lock_bh(&udplite_hash_lock);
+	if (sk_del_node_init(sk)) {
+		inet_sk(sk)->num = 0;
+		sock_prot_dec_use(sk->sk_prot);
+	}
+	write_unlock_bh(&udplite_hash_lock);
+}
+
+static struct sock *udplite_v6_lookup(struct in6_addr *saddr, u16 sport,
+				  struct in6_addr *daddr, u16 dport, int dif)
+{
+	struct sock *sk, *result = NULL;
+	struct hlist_node *node;
+	unsigned short hnum = ntohs(dport);
+	int badness = -1;
+
+ 	read_lock(&udplite_hash_lock);
+	sk_for_each(sk, node, &udplite_hash[hnum & (UDP_HTABLE_SIZE - 1)]) {
+		struct inet_sock *inet = inet_sk(sk);
+
+		if (inet->num == hnum && sk->sk_family == PF_INET6) {
+			struct ipv6_pinfo *np = inet6_sk(sk);
+			int score = 0;
+			if (inet->dport) {
+				if (inet->dport != sport)
+					continue;
+				score++;
+			}
+			if (!ipv6_addr_any(&np->rcv_saddr)) {
+				if (!ipv6_addr_equal(&np->rcv_saddr, daddr))
+					continue;
+				score++;
+			}
+			if (!ipv6_addr_any(&np->daddr)) {
+				if (!ipv6_addr_equal(&np->daddr, saddr))
+					continue;
+				score++;
+			}
+			if (sk->sk_bound_dev_if) {
+				if (sk->sk_bound_dev_if != dif)
+					continue;
+				score++;
+			}
+			if(score == 4) {
+				result = sk;
+				break;
+			} else if(score > badness) {
+				result = sk;
+				badness = score;
+			}
+		}
+	}
+	if (result)
+		sock_hold(result);
+ 	read_unlock(&udplite_hash_lock);
+	return result;
+}
+
+/*
+ *
+ */
+
+static void udplitev6_close(struct sock *sk, long timeout)
+{
+	sk_common_release(sk);
+}
+
+/*
+ * 	This should be easy, if there is something there we
+ * 	return it, otherwise we block.
+ */
+
+static int udplitev6_recvmsg(struct kiocb *iocb, struct sock *sk,
+		  struct msghdr *msg, size_t len,
+		  int noblock, int flags, int *addr_len)
+{
+	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct inet_sock *inet = inet_sk(sk);
+  	struct sk_buff *skb;
+	size_t copied;
+  	int err;
+
+  	if (addr_len)
+  		*addr_len=sizeof(struct sockaddr_in6);
+
+	if (flags & MSG_ERRQUEUE)
+		return ipv6_recv_error(sk, msg, len);
+
+try_again:
+	skb = skb_recv_datagram(sk, flags, noblock, &err);
+	if (!skb)
+		goto out;
+
+ 	copied = skb->len - sizeof(struct udplitehdr);
+  	if (copied > len) {
+  		copied = len;
+  		msg->msg_flags |= MSG_TRUNC;
+  	}
+
+	/* Checksum validation. Unlike udp.c, there is no test here if the
+	 * checksum has been computed in hardware already: at present, not
+	 * a single hardware manufacturer is known who supports offloading
+	 * of UDP-Lite variable-length checksums.    */
+	if (udplite_checksum_complete(skb))
+		goto csum_copy_err;
+
+	err = skb_copy_datagram_iovec(skb, sizeof(struct udplitehdr),
+				      msg->msg_iov, copied);
+
+	if (err)
+		goto out_free;
+
+	sock_recv_timestamp(msg, sk, skb);
+	/* Increment the InDatagrams counter only if the datagram has
+	 * been received by a  application.
+	 * FIXME: This may need revision if in-kernel applications use
+	 * data_ready handler.  */
+	UDPLITE6_INC_STATS_BH(UDPLITE_MIB_INDATAGRAMS);
+        if(UDPLITE_SKB_CB(skb)->partial)
+		UDPLITE6_INC_STATS_BH(UDPLITE_MIB_IN_PARTIALCOV);
+
+	/* Copy the address. */
+	if (msg->msg_name) {
+		struct sockaddr_in6 *sin6;
+
+		sin6 = (struct sockaddr_in6 *) msg->msg_name;
+		sin6->sin6_family = AF_INET6;
+		sin6->sin6_port = skb->h.ulh->source;
+		sin6->sin6_flowinfo = 0;
+		sin6->sin6_scope_id = 0;
+
+		if (skb->protocol == htons(ETH_P_IP))
+			ipv6_addr_set(&sin6->sin6_addr, 0, 0,
+				      htonl(0xffff), skb->nh.iph->saddr);
+		else {
+			ipv6_addr_copy(&sin6->sin6_addr, &skb->nh.ipv6h->saddr);
+			if(ipv6_addr_type(&sin6->sin6_addr)&IPV6_ADDR_LINKLOCAL)
+				sin6->sin6_scope_id = IP6CB(skb)->iif;
+		}
+
+	}
+	if (skb->protocol == htons(ETH_P_IP)) {
+		if (inet->cmsg_flags)
+			ip_cmsg_recv(msg, skb);
+	} else {
+		if (np->rxopt.all)
+			datagram_recv_ctl(sk, msg, skb);
+  	}
+
+	err = copied;
+	if (flags & MSG_TRUNC)
+		err = skb->len - sizeof(struct udplitehdr);
+
+out_free:
+	skb_free_datagram(sk, skb);
+out:
+	return err;
+
+csum_copy_err:
+	LIMIT_NETDEBUG(KERN_DEBUG "UDPLITE: csum error \n");
+	UDPLITE6_INC_STATS_USER(UDPLITE_MIB_IN_BAD_CSUM);
+	UDPLITE6_INC_STATS_USER(UDPLITE_MIB_INERRORS);
+
+	skb_kill_datagram(sk, skb, flags);
+
+	if (flags & MSG_DONTWAIT)  /* FIXME: v4 uses noblock */
+		return -EAGAIN;
+	goto try_again;
+}
+
+static void udplitev6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
+	       int type, int code, int offset, __u32 info)
+{
+	struct ipv6_pinfo *np;
+	struct ipv6hdr *hdr = (struct ipv6hdr*)skb->data;
+	struct net_device *dev = skb->dev;
+	struct in6_addr *saddr = &hdr->saddr;
+	struct in6_addr *daddr = &hdr->daddr;
+	struct udplitehdr *uh = (struct udplitehdr*)(skb->data+offset);
+	struct sock *sk;
+	int err;
+
+	sk = udplite_v6_lookup(daddr,uh->dest, saddr, uh->source, dev->ifindex);
+
+	if (sk == NULL)
+		return;
+
+	np = inet6_sk(sk);
+
+	if (!icmpv6_err_convert(type, code, &err) && !np->recverr)
+		goto out;
+
+	if (sk->sk_state != TCP_ESTABLISHED && !np->recverr)
+		goto out;
+
+	if (np->recverr)
+		ipv6_icmp_error(sk, skb,err,uh->dest,ntohl(info), (u8 *)(uh+1));
+
+	sk->sk_err = err;
+	sk->sk_error_report(sk);
+out:
+	sock_put(sk);
+}
+
+static int udplitev6_queue_rcv_skb(struct sock * sk, struct sk_buff *skb)
+{
+	struct udplite_sock *up = udplite_sk(sk);
+	int rc = 0;
+
+	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb)) {
+		rc = -1;
+		goto drop;
+	}
+
+	if ((up->pcflag & UDPLITE_RECV_CC) && UDPLITE_SKB_CB(skb)->partial) {
+		/*
+		 * see net/ipv4/udplite.c for detailed comments/justifications
+		 */
+		if (up->pcrlen == 0) {          /* full coverage was set  */
+			LIMIT_NETDEBUG(KERN_WARNING "UDPLITE: partial coverage "
+				"%d while full coverage %d requested\n",
+				UDPLITE_SKB_CB(skb)->cscov, skb->len);
+			goto drop;
+		}
+		if (UDPLITE_SKB_CB(skb)->cscov  <  up->pcrlen) {
+			LIMIT_NETDEBUG(KERN_WARNING
+				"UDPLITE: coverage %d too small, need min %d\n",
+				UDPLITE_SKB_CB(skb)->cscov, up->pcrlen);
+			goto drop;
+		}
+	}
+
+	if (udplite_checksum_complete(skb)) {
+		UDPLITE6_INC_STATS_BH(UDPLITE_MIB_IN_BAD_CSUM);
+		goto drop;
+	}
+
+	if (sock_queue_rcv_skb(sk,skb)<0)
+		goto drop;
+
+	return 0;
+drop:
+	UDPLITE6_INC_STATS_BH(UDPLITE_MIB_INERRORS);
+	kfree_skb(skb);
+	return rc;
+}
+
+static struct sock *udplite_v6_mcast_next(struct sock *sk,
+				      u16 loc_port, struct in6_addr *loc_addr,
+				      u16 rmt_port, struct in6_addr *rmt_addr,
+				      int dif)
+{
+	struct hlist_node *node;
+	struct sock *s = sk;
+	unsigned short num = ntohs(loc_port);
+
+	sk_for_each_from(s, node) {
+		struct inet_sock *inet = inet_sk(s);
+
+		if (inet->num == num && s->sk_family == PF_INET6) {
+			struct ipv6_pinfo *np = inet6_sk(s);
+			if (inet->dport) {
+				if (inet->dport != rmt_port)
+					continue;
+			}
+			if (!ipv6_addr_any(&np->daddr) &&
+			    !ipv6_addr_equal(&np->daddr, rmt_addr))
+				continue;
+
+			if (s->sk_bound_dev_if && s->sk_bound_dev_if != dif)
+				continue;
+
+			if (!ipv6_addr_any(&np->rcv_saddr)) {
+				if (!ipv6_addr_equal(&np->rcv_saddr, loc_addr))
+					continue;
+			}
+			if(!inet6_mc_check(s, loc_addr, rmt_addr))
+				continue;
+			return s;
+		}
+	}
+	return NULL;
+}
+
+/*
+ * Note: called only from the BH handler context,
+ * so we don't need to lock the hashes.
+ */
+static void udplitev6_mcast_deliver(struct udplitehdr *uh,
+				struct in6_addr *saddr, struct in6_addr *daddr,
+				struct sk_buff *skb)
+{
+	struct sock *sk, *sk2;
+	int dif;
+
+	read_lock(&udplite_hash_lock);
+	sk = sk_head(&udplite_hash[ntohs(uh->dest) & (UDP_HTABLE_SIZE - 1)]);
+	dif = skb->dev->ifindex;
+	sk = udplite_v6_mcast_next(sk, uh->dest, daddr, uh->source, saddr, dif);
+	if (!sk) {
+		kfree_skb(skb);
+		goto out;
+	}
+
+	sk2 = sk;
+	while ((sk2 = udplite_v6_mcast_next(sk_next(sk2), uh->dest, daddr,
+					uh->source, saddr, dif))) {
+		struct sk_buff *buff = skb_clone(skb, GFP_ATOMIC);
+		if (buff)
+			udplitev6_queue_rcv_skb(sk2, buff);
+	}
+	udplitev6_queue_rcv_skb(sk, skb);
+out:
+	read_unlock(&udplite_hash_lock);
+}
+
+static int udplitev6_rcv(struct sk_buff **pskb)
+{
+	struct sk_buff *skb = *pskb;
+	struct sock *sk;
+  	struct udplitehdr *ulh;
+	struct net_device *dev = skb->dev;
+	struct in6_addr *saddr, *daddr;
+	u32 len   = skb->len;		  /* total packet length  */
+	u16 cscov;	            	  /* csum coverage length */
+
+	saddr = &skb->nh.ipv6h->saddr;
+	daddr = &skb->nh.ipv6h->daddr;
+
+	if (!pskb_may_pull(skb, sizeof(struct udplitehdr)))
+		goto short_packet;
+
+	/* There is currently no support for UDP-Lite jumbograms (RFC 2675) */
+	ulh = skb->h.ulh;
+
+	if (len < sizeof(*ulh))	          /* Unlike udp.c, we must not trim */
+		goto short_packet;
+
+        /* In UDPv4 a zero checksum means that the transmitter generated no
+         * checksum. UDP-Lite (like IPv6) mandates checksums, hence packets
+         * with a zero checksum field are illegal. (cf. RFC 2460, sec. 8.1)
+	 * These cases are treated as error since the packet may have been
+	 * corrupted in transit. */
+	if (ulh->check == 0)
+		goto csum_error;
+
+	cscov = ntohs(ulh->checklen);
+
+	/* Save checksum coverage information for later use.  */
+        UDPLITE_SKB_CB(skb)->cscov   = cscov;
+        UDPLITE_SKB_CB(skb)->partial = 0;
+
+	if (cscov == 0)		 /* Indicates that full coverage is required. */
+		cscov = len;
+	else if (cscov < 8  ||	 /* Illegal coverage length, 8 is minimum.    */
+		 cscov > len  )	 /* Coverage length exceeds datagram length.  */
+		goto csumlen_error;
+	else if (cscov < len)	 /* Normal: partial coverage required.        */
+        	UDPLITE_SKB_CB(skb)->partial = 1;
+
+	/* Compute initial checksum including pseudo-header. */
+	if (unlikely(skb->ip_summed == CHECKSUM_HW)) {
+		if (csum_ipv6_magic(saddr, daddr, len,
+			            IPPROTO_UDPLITE, skb->csum) == 0)
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+	}
+	if (likely(skb->ip_summed != CHECKSUM_UNNECESSARY))
+		skb->csum = ~csum_ipv6_magic(saddr, daddr,
+					     len, IPPROTO_UDPLITE, 0);
+
+	/*
+	 *	Multicast receive code
+	 */
+	if (ipv6_addr_is_multicast(daddr)) {
+		udplitev6_mcast_deliver(ulh, saddr, daddr, skb);
+		return 0;
+	}
+
+	/* Unicast */
+
+	/*
+	 * check socket cache ... must talk to Alan about his plans
+	 * for sock caches... i'll skip this for now.
+	 */
+	sk = udplite_v6_lookup(saddr, ulh->source,
+			       daddr, ulh->dest, dev->ifindex);
+
+	if (sk == NULL) {
+		if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb))
+			goto discard;
+
+		/* No socket. Drop packet silently, if checksum is wrong */
+		if (udplite_checksum_complete(skb))
+			goto csum_error;
+
+		UDPLITE6_INC_STATS_BH(UDPLITE_MIB_NOPORTS);
+
+		icmpv6_send(skb,ICMPV6_DEST_UNREACH, ICMPV6_PORT_UNREACH,0,dev);
+
+		kfree_skb(skb);
+		return(0);
+	}
+
+	/* deliver */
+
+	udplitev6_queue_rcv_skb(sk, skb);
+	sock_put(sk);
+	return(0);
+
+short_packet:
+	LIMIT_NETDEBUG(KERN_INFO  "UDPLITE: short packet of %d bytes "
+                                  "[" NIP6_FMT " > " NIP6_FMT "]\n",
+		       		  len, NIP6(*saddr), NIP6(*daddr));
+	goto discard;
+
+csumlen_error:
+	/*
+	 * Coverage length violates RFC 3828: log and discard it.
+	 */
+	LIMIT_NETDEBUG(KERN_DEBUG "UDPLITE: bad csum coverage %d/%d "
+                                  "[" NIP6_FMT " > " NIP6_FMT "]\n",
+	      			  cscov, len, NIP6(*saddr), NIP6(*daddr));
+	UDPLITE6_INC_STATS_BH(UDPLITE_MIB_IN_BAD_COV);
+	goto discard;
+
+csum_error:
+	LIMIT_NETDEBUG(KERN_DEBUG "UDPLITE: bad csum "
+                                  "[" NIP6_FMT " > " NIP6_FMT "]\n",
+	      			   NIP6(*saddr), NIP6(*daddr));
+	UDPLITE6_INC_STATS_BH(UDPLITE_MIB_IN_BAD_CSUM);
+
+discard:
+	UDPLITE6_INC_STATS_BH(UDPLITE_MIB_INERRORS);
+	kfree_skb(skb);
+	return(0);
+}
+/*
+ * Throw away all pending data and cancel the corking. Socket is locked.
+ */
+static void udplite_v6_flush_pending_frames(struct sock *sk)
+{
+	struct udplite_sock *up = udplite_sk(sk);
+
+	if (up->pending) {
+		up->len = 0;
+		up->pending = 0;
+		ip6_flush_pending_frames(sk);
+        }
+}
+
+/*
+ *	Sending
+ */
+
+static int udplite_v6_push_pending_frames(struct sock *sk,
+					  struct udplite_sock *up)
+{
+	struct sk_buff *skb;
+	struct udplitehdr *ulh;
+	struct inet_sock *inet = inet_sk(sk);
+	struct flowi *fl = &inet->cork.fl;
+        int                err   = 0,
+			   len;
+	unsigned short     cscov = 0;	/* checksum coverage length     */
+	u32 		   csum  = 0;	/* intermediate checksum value. */
+
+	/* Grab the skbuff where UDP-Lite header space exists. */
+	if ((skb = skb_peek(&sk->sk_write_queue)) == NULL)
+		goto out;
+
+	/*
+	 * Create a UDP-Lite header
+	 */
+	ulh         = skb->h.ulh;
+	ulh->source = fl->fl_ip_sport;
+	ulh->dest   = fl->fl_ip_dport;
+	ulh->check  = 0;
+
+	if (up->pcflag & UDPLITE_SEND_CC) {
+	        /* Sender has requested partial coverage via sockopts.       */
+		if (up->pcslen < up->len) {
+			if (up->pcslen == 0)	/* Full coverage (RFC 3828)  */
+			      cscov = up->len;
+			else {	                /* Genuine partial coverage  */
+			      cscov = up->pcslen;
+			      UDPLITE6_INC_STATS_BH(UDPLITE_MIB_OUT_PARTIALCOV);
+			}
+			ulh->checklen = htons(up->pcslen);
+
+		} else {
+			/*  see ipv4/udplite.c for comments   */
+			cscov = up->len;
+			ulh->checklen = htons(cscov);
+		}
+	} else {        /* No flag: emulate UDP.              */
+		cscov = up->len;
+		ulh->checklen = htons(cscov);
+	}
+
+
+	skb->ip_summed = CHECKSUM_NONE;     /* no HW support for checksumming */
+
+	if (skb_queue_len(&sk->sk_write_queue) == 1) {
+		/*
+		 * Only one fragment on the socket.
+		 */
+		csum = skb_checksum(skb, skb->h.raw - skb->data, cscov, 0);
+
+	} else {
+		skb_queue_walk(&sk->sk_write_queue, skb) {
+			len = skb->tail - skb->h.raw;
+
+			skb->csum = skb_checksum(skb, skb->h.raw - skb->data,
+						(cscov > len) ? len : cscov, 0);
+			csum = csum_add(csum, skb->csum);
+
+			if (cscov < len)	   /* Enough seen. */
+				break;
+			cscov -= len;
+		}
+	}
+	ulh->check = csum_ipv6_magic(&fl->fl6_src, &fl->fl6_dst, up->len,
+			             IPPROTO_UDPLITE, csum);
+
+	if (ulh->check == 0)
+		ulh->check = -1;
+
+	err = ip6_push_pending_frames(sk);
+out:
+	up->len = 0;
+	up->pending = 0;
+	return err;
+}
+
+static int udplitev6_sendmsg(struct kiocb *iocb, struct sock *sk,
+		  struct msghdr *msg, size_t len)
+{
+	struct ipv6_txoptions opt_space;
+	struct udplite_sock *up = udplite_sk(sk);
+	struct inet_sock *inet = inet_sk(sk);
+	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *) msg->msg_name;
+	struct in6_addr *daddr, *final_p = NULL, final;
+	struct ipv6_txoptions *opt = NULL;
+	struct ip6_flowlabel *flowlabel = NULL;
+	struct flowi *fl = &inet->cork.fl;
+	struct dst_entry *dst;
+	int addr_len = msg->msg_namelen;
+	int ulen = len;
+	int hlimit = -1;
+	int tclass = -1;
+	int corkreq = up->corkflag || msg->msg_flags&MSG_MORE;
+	int err;
+	int connected = 0;
+
+	/* destination address check */
+	if (sin6) {
+		if (addr_len < offsetof(struct sockaddr, sa_data))
+			return -EINVAL;
+
+		switch (sin6->sin6_family) {
+		case AF_INET6:
+			if (addr_len < SIN6_LEN_RFC2133)
+				return -EINVAL;
+			daddr = &sin6->sin6_addr;
+			break;
+		case AF_INET:
+			goto do_udplite_sendmsg;
+		case AF_UNSPEC:
+			msg->msg_name = sin6 = NULL;
+			msg->msg_namelen = addr_len = 0;
+			daddr = NULL;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else if (!up->pending) {
+		if (sk->sk_state != TCP_ESTABLISHED)
+			return -EDESTADDRREQ;
+		daddr = &np->daddr;
+	} else
+		daddr = NULL;
+
+	if (daddr) {
+		if (ipv6_addr_type(daddr) == IPV6_ADDR_MAPPED) {
+			struct sockaddr_in sin;
+			sin.sin_family = AF_INET;
+			sin.sin_port = sin6 ? sin6->sin6_port : inet->dport;
+			sin.sin_addr.s_addr = daddr->s6_addr32[3];
+			msg->msg_name = &sin;
+			msg->msg_namelen = sizeof(sin);
+do_udplite_sendmsg:
+			if (__ipv6_only_sock(sk))
+				return -ENETUNREACH;
+			return udplite_sendmsg(iocb, sk, msg, len);
+		}
+	}
+
+	if (up->pending == AF_INET)
+		return udplite_sendmsg(iocb, sk, msg, len);
+
+	/* Rough check on arithmetic overflow,
+	   better check is made in ip6_build_xmit
+	   */
+	if (len > INT_MAX - sizeof(struct udplitehdr))
+		return -EMSGSIZE;
+
+	if (up->pending) {
+		/*
+		 * There are pending frames.
+		 * The socket lock must be held while it's corked.
+		 */
+		lock_sock(sk);
+		if (likely(up->pending)) {
+			if (unlikely(up->pending != AF_INET6)) {
+				release_sock(sk);
+				return -EAFNOSUPPORT;
+			}
+			dst = NULL;
+			goto do_append_data;
+		}
+		release_sock(sk);
+	}
+	ulen += sizeof(struct udplitehdr);
+
+	memset(fl, 0, sizeof(*fl));
+
+	if (sin6) {
+		if (sin6->sin6_port == 0)
+			return -EINVAL;
+
+		fl->fl_ip_dport = sin6->sin6_port;
+		daddr = &sin6->sin6_addr;
+
+		if (np->sndflow) {
+			fl->fl6_flowlabel = sin6->sin6_flowinfo &
+					    IPV6_FLOWINFO_MASK;
+			if (fl->fl6_flowlabel&IPV6_FLOWLABEL_MASK) {
+				flowlabel=fl6_sock_lookup(sk,fl->fl6_flowlabel);
+				if (flowlabel == NULL)
+					return -EINVAL;
+				daddr = &flowlabel->dst;
+			}
+		}
+
+		/*
+		 * Otherwise it will be difficult to maintain
+		 * sk->sk_dst_cache.
+		 */
+		if (sk->sk_state == TCP_ESTABLISHED &&
+		    ipv6_addr_equal(daddr, &np->daddr))
+			daddr = &np->daddr;
+
+		if (addr_len >= sizeof(struct sockaddr_in6) &&
+		    sin6->sin6_scope_id &&
+		    ipv6_addr_type(daddr)&IPV6_ADDR_LINKLOCAL)
+			fl->oif = sin6->sin6_scope_id;
+	} else {
+		if (sk->sk_state != TCP_ESTABLISHED)
+			return -EDESTADDRREQ;
+
+		fl->fl_ip_dport = inet->dport;
+		daddr = &np->daddr;
+		fl->fl6_flowlabel = np->flow_label;
+		connected = 1;
+	}
+
+	if (!fl->oif)
+		fl->oif = sk->sk_bound_dev_if;
+
+	if (msg->msg_controllen) {
+		opt = &opt_space;
+		memset(opt, 0, sizeof(struct ipv6_txoptions));
+		opt->tot_len = sizeof(*opt);
+
+		err = datagram_send_ctl(msg, fl, opt, &hlimit, &tclass);
+		if (err < 0) {
+			fl6_sock_release(flowlabel);
+			return err;
+		}
+		if ((fl->fl6_flowlabel&IPV6_FLOWLABEL_MASK) && !flowlabel) {
+			flowlabel = fl6_sock_lookup(sk, fl->fl6_flowlabel);
+			if (flowlabel == NULL)
+				return -EINVAL;
+		}
+		if (!(opt->opt_nflen|opt->opt_flen))
+			opt = NULL;
+		connected = 0;
+	}
+	if (opt == NULL)
+		opt = np->opt;
+	if (flowlabel)
+		opt = fl6_merge_options(&opt_space, flowlabel, opt);
+	opt = ipv6_fixup_options(&opt_space, opt);
+
+	fl->proto = IPPROTO_UDPLITE;
+	ipv6_addr_copy(&fl->fl6_dst, daddr);
+	if (ipv6_addr_any(&fl->fl6_src) && !ipv6_addr_any(&np->saddr))
+		ipv6_addr_copy(&fl->fl6_src, &np->saddr);
+	fl->fl_ip_sport = inet->sport;
+
+	/* merge ip6_build_xmit from ip6_output */
+	if (opt && opt->srcrt) {
+		struct rt0_hdr *rt0 = (struct rt0_hdr *) opt->srcrt;
+		ipv6_addr_copy(&final, &fl->fl6_dst);
+		ipv6_addr_copy(&fl->fl6_dst, rt0->addr);
+		final_p = &final;
+		connected = 0;
+	}
+
+	if (!fl->oif && ipv6_addr_is_multicast(&fl->fl6_dst)) {
+		fl->oif = np->mcast_oif;
+		connected = 0;
+	}
+
+	err = ip6_dst_lookup(sk, &dst, fl);
+	if (err)
+		goto out;
+	if (final_p)
+		ipv6_addr_copy(&fl->fl6_dst, final_p);
+
+	if ((err = xfrm_lookup(&dst, fl, sk, 0)) < 0)
+		goto out;
+
+	if (hlimit < 0) {
+		if (ipv6_addr_is_multicast(&fl->fl6_dst))
+			hlimit = np->mcast_hops;
+		else
+			hlimit = np->hop_limit;
+		if (hlimit < 0)
+			hlimit = dst_metric(dst, RTAX_HOPLIMIT);
+		if (hlimit < 0)
+			hlimit = ipv6_get_hoplimit(dst->dev);
+	}
+
+	if (tclass < 0) {
+		tclass = np->tclass;
+		if (tclass < 0)
+			tclass = 0;
+	}
+
+	if (msg->msg_flags&MSG_CONFIRM)
+		goto do_confirm;
+back_from_confirm:
+
+	lock_sock(sk);
+	if (unlikely(up->pending)) {
+		/* The socket is already corked while preparing it. */
+		/* ... which is an evident application bug. --ANK */
+		release_sock(sk);
+
+		LIMIT_NETDEBUG(KERN_DEBUG "udp cork app bug 2\n");
+		err = -EINVAL;
+		goto out;
+	}
+
+	up->pending = AF_INET6;
+
+do_append_data:
+	up->len += ulen;
+	err = ip6_append_data(sk, udplite_getfrag, msg->msg_iov, ulen,
+		sizeof(struct udplitehdr), hlimit, tclass, opt, fl,
+		(struct rt6_info*)dst,
+		corkreq ? msg->msg_flags|MSG_MORE : msg->msg_flags);
+	if (err)
+		udplite_v6_flush_pending_frames(sk);
+	else if (!corkreq)
+		err = udplite_v6_push_pending_frames(sk, up);
+
+	if (dst) {
+		if (connected) {
+			ip6_dst_store(sk, dst,
+				      ipv6_addr_equal(&fl->fl6_dst, &np->daddr)?
+				      &np->daddr : NULL);
+		} else {
+			dst_release(dst);
+		}
+	}
+
+	if (err > 0)
+		err = np->recverr ? net_xmit_errno(err) : 0;
+	release_sock(sk);
+out:
+	fl6_sock_release(flowlabel);
+	if (!err) {
+		UDPLITE6_INC_STATS_USER(UDPLITE_MIB_OUTDATAGRAMS);
+		return len;
+	}
+	return err;
+
+do_confirm:
+	dst_confirm(dst);
+	if (!(msg->msg_flags&MSG_PROBE) || len)
+		goto back_from_confirm;
+	err = 0;
+	goto out;
+}
+
+static int udplitev6_destroy_sock(struct sock *sk)
+{
+	lock_sock(sk);
+	udplite_v6_flush_pending_frames(sk);
+	release_sock(sk);
+
+	inet6_destroy_sock(sk);
+
+	return 0;
+}
+
+/*
+ *	Socket option code for UDP
+ */
+static int do_udplitev6_setsockopt(struct sock *sk, int level, int optname,
+			  char __user *optval, int optlen)
+{
+	struct udplite_sock *up = udplite_sk(sk);
+	int val;
+	int err = 0;
+
+	if(optlen<sizeof(int))
+		return -EINVAL;
+
+	if (get_user(val, (int __user *)optval))
+		return -EFAULT;
+
+	switch(optname) {
+	case UDP_CORK:
+		if (val != 0) {
+			up->corkflag = 1;
+		} else {
+			up->corkflag = 0;
+			lock_sock(sk);
+			udplite_v6_push_pending_frames(sk, up);
+			release_sock(sk);
+		}
+		break;
+
+	case UDP_ENCAP:
+		switch (val) {
+		case 0:
+			up->encap_type = val;
+			break;
+		default:
+			err = -ENOPROTOOPT;
+			break;
+		}
+		break;
+	/* Sender sets actual checksum coverage length via this option.
+	   The case coverage > packet length is handled by send module.       */
+	case UDPLITE_SEND_CSCOV:
+		if (val != 0 && val < 8) /* Illegal coverage: use default (8) */
+			val = 8;
+		up->pcslen = val;
+		up->pcflag |= UDPLITE_SEND_CC;
+		break;
+
+        /* The receiver specifies a minimum checksum coverage value. To make
+         * sense, this should be set to at least 8 (as done below). If zero is
+	 * used, this again means full checksum coverage.                     */
+	case UDPLITE_RECV_CSCOV:
+		if (val != 0 && val < 8)    /* Disable silly minimal values.  */
+			val = 8;
+		up->pcrlen = val;
+		up->pcflag |= UDPLITE_RECV_CC;
+		break;
+
+	default:
+		err = -ENOPROTOOPT;
+		break;
+	};
+
+	return err;
+}
+
+static int udplitev6_setsockopt(struct sock *sk, int level, int optname,
+			  char __user *optval, int optlen)
+{
+	if (level != SOL_UDPLITE)
+		return ipv6_setsockopt(sk, level, optname, optval, optlen);
+	return do_udplitev6_setsockopt(sk, level, optname, optval, optlen);
+}
+
+#ifdef CONFIG_COMPAT
+static int compat_udplitev6_setsockopt(struct sock *sk, int level, int optname,
+				   char __user *optval, int optlen)
+{
+	if (level != SOL_UDPLITE)
+		return compat_ipv6_setsockopt(sk, level, optname,
+					      optval, optlen);
+	return do_udplitev6_setsockopt(sk, level, optname, optval, optlen);
+}
+#endif
+
+static int do_udplitev6_getsockopt(struct sock *sk, int level, int optname,
+			  char __user *optval, int __user *optlen)
+{
+	struct udplite_sock *up = udplite_sk(sk);
+	int val, len;
+
+	if(get_user(len,optlen))
+		return -EFAULT;
+
+	len = min_t(unsigned int, len, sizeof(int));
+
+	if(len < 0)
+		return -EINVAL;
+
+	switch(optname) {
+	case UDP_CORK:
+		val = up->corkflag;
+		break;
+
+	case UDP_ENCAP:
+		val = up->encap_type;
+		break;
+
+	case UDPLITE_SEND_CSCOV:
+		val = up->pcslen;
+		break;
+
+	case UDPLITE_RECV_CSCOV:
+		val = up->pcrlen;
+		break;
+
+	default:
+		return -ENOPROTOOPT;
+	};
+
+  	if(put_user(len, optlen))
+  		return -EFAULT;
+	if(copy_to_user(optval, &val,len))
+		return -EFAULT;
+  	return 0;
+}
+
+static int udplitev6_getsockopt(struct sock *sk, int level, int optname,
+			  char __user *optval, int __user *optlen)
+{
+	if (level != SOL_UDPLITE)
+		return ipv6_getsockopt(sk, level, optname, optval, optlen);
+	return do_udplitev6_getsockopt(sk, level, optname, optval, optlen);
+}
+
+#ifdef CONFIG_COMPAT
+static int compat_udplitev6_getsockopt(struct sock *sk, int level, int optname,
+				   char __user *optval, int __user *optlen)
+{
+	if (level != SOL_UDPLITE)
+		return compat_ipv6_getsockopt(sk, level, optname,
+					      optval, optlen);
+	return do_udplitev6_getsockopt(sk, level, optname, optval, optlen);
+}
+#endif
+
+static struct inet6_protocol udplitev6_protocol = {
+	.handler	=	udplitev6_rcv,
+	.err_handler	=	udplitev6_err,
+	.flags		=	INET6_PROTO_NOPOLICY|INET6_PROTO_FINAL,
+};
+
+/* ------------------------------------------------------------------------ */
+#ifdef CONFIG_PROC_FS
+
+static void udplite6_sock_seq_show(struct seq_file *seq, struct sock *sp,
+				   int bucket)
+{
+	struct inet_sock *inet = inet_sk(sp);
+	struct ipv6_pinfo *np = inet6_sk(sp);
+	struct in6_addr *dest, *src;
+	__u16 destp, srcp;
+
+	dest  = &np->daddr;
+	src   = &np->rcv_saddr;
+	destp = ntohs(inet->dport);
+	srcp  = ntohs(inet->sport);
+	seq_printf(seq,
+		   "%4d: %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X "
+		   "%02X %08X:%08X %02X:%08lX %08X %5d %8d %lu %d %p\n",
+		   bucket,
+		   src->s6_addr32[0], src->s6_addr32[1],
+		   src->s6_addr32[2], src->s6_addr32[3], srcp,
+		   dest->s6_addr32[0], dest->s6_addr32[1],
+		   dest->s6_addr32[2], dest->s6_addr32[3], destp,
+		   sp->sk_state,
+		   atomic_read(&sp->sk_wmem_alloc),
+		   atomic_read(&sp->sk_rmem_alloc),
+		   0, 0L, 0,
+		   sock_i_uid(sp), 0,
+		   sock_i_ino(sp),
+		   atomic_read(&sp->sk_refcnt), sp);
+}
+
+static int udplite6_seq_show(struct seq_file *seq, void *v)
+{
+	if (v == SEQ_START_TOKEN)
+		seq_printf(seq,
+			   "  sl  "
+			   "local_address                         "
+			   "remote_address                        "
+			   "st tx_queue rx_queue tr tm->when retrnsmt"
+			   "   uid  timeout inode\n");
+	else
+		udplite6_sock_seq_show(seq, v, ((struct udp_iter_state *)
+						 	seq->private)->bucket);
+	return 0;
+}
+
+static struct file_operations udplite6_seq_fops;
+static struct udp_seq_afinfo udplite6_seq_afinfo = {
+	.owner		= THIS_MODULE,
+	.name		= "udplite6",
+	.family		= AF_INET6,
+	.seq_show	= udplite6_seq_show,
+	.seq_fops	= &udplite6_seq_fops,
+};
+
+int __init udplite6_proc_init(void)
+{
+	return udplite_proc_register(&udplite6_seq_afinfo);
+}
+
+void udplite6_proc_exit(void) {
+	udplite_proc_unregister(&udplite6_seq_afinfo);
+}
+#endif /* CONFIG_PROC_FS */
+
+/* ------------------------------------------------------------------------ */
+
+struct proto udplitev6_prot = {
+	.name		   = "UDPLITEv6",
+	.owner		   = THIS_MODULE,
+	.close		   = udplitev6_close,
+	.connect	   = ip6_datagram_connect,
+	.disconnect	   = udplite_disconnect,
+	.ioctl		   = udplite_ioctl,
+	.destroy	   = udplitev6_destroy_sock,
+	.setsockopt	   = udplitev6_setsockopt,
+	.getsockopt	   = udplitev6_getsockopt,
+	.sendmsg	   = udplitev6_sendmsg,
+	.recvmsg	   = udplitev6_recvmsg,
+	.backlog_rcv	   = udplitev6_queue_rcv_skb,
+	.hash		   = udplite_v6_hash,
+	.unhash		   = udplite_v6_unhash,
+	.get_port	   = udplite_v6_get_port,
+	.obj_size	   = sizeof(struct udplite6_sock),
+#ifdef CONFIG_COMPAT
+	.compat_setsockopt = compat_udplitev6_setsockopt,
+	.compat_getsockopt = compat_udplitev6_getsockopt,
+#endif
+};
+
+/* identical with inet6_dgram_ops: udp_poll is the only exception */
+const struct proto_ops inet6_ldgram_ops = {
+	.family		   = PF_INET6,
+	.owner		   = THIS_MODULE,
+	.release	   = inet6_release,
+	.bind		   = inet6_bind,
+	.connect	   = inet_dgram_connect,	/* ok		*/
+	.socketpair	   = sock_no_socketpair,	/* a do nothing	*/
+	.accept		   = sock_no_accept,		/* a do nothing	*/
+	.getname	   = inet6_getname,
+	.poll		   = udplite_poll,		/* must use this */
+	.ioctl		   = inet6_ioctl,		/* must change  */
+	.listen		   = sock_no_listen,		/* ok		*/
+	.shutdown	   = inet_shutdown,		/* ok		*/
+	.setsockopt	   = sock_common_setsockopt,	/* ok		*/
+	.getsockopt	   = sock_common_getsockopt,	/* ok		*/
+	.sendmsg	   = inet_sendmsg,		/* ok		*/
+	.recvmsg	   = sock_common_recvmsg,	/* ok		*/
+	.mmap		   = sock_no_mmap,
+	.sendpage	   = sock_no_sendpage,
+#ifdef CONFIG_COMPAT
+	.compat_setsockopt = compat_sock_common_setsockopt,
+	.compat_getsockopt = compat_sock_common_getsockopt,
+#endif
+};
+
+static struct inet_protosw udplitev6_protosw = {
+	.type =      SOCK_DGRAM,
+	.protocol =  IPPROTO_UDPLITE,
+	.prot =      &udplitev6_prot,
+	.ops =       &inet6_ldgram_ops,
+	.capability =-1,
+	.no_check   = 0,               /* must checksum (RFC 3828) */
+	.flags =     INET_PROTOSW_PERMANENT,
+};
+
+
+void __init udplitev6_init(void)
+{
+	if (inet6_add_protocol(&udplitev6_protocol, IPPROTO_UDPLITE) < 0)
+		printk(KERN_ERR "udplitev6_init: Could not register.\n");
+	inet6_register_protosw(&udplitev6_protosw);
+}
diff -Nurp  a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
--- a/net/ipv6/af_inet6.c	2006-06-28 17:04:41.000000000 +0100
+++ b/net/ipv6/af_inet6.c	2006-06-29 19:02:27.000000000 +0100
@@ -736,6 +736,13 @@ static int __init init_ipv6_mibs(void)
 	if (snmp6_mib_init((void **)udp_stats_in6, sizeof (struct udp_mib),
 			   __alignof__(struct udp_mib)) < 0)
 		goto err_udp_mib;
+#ifdef CONFIG_IP_UDPLITE
+	if (snmp6_mib_init((void **)udplite_stats_in6, sizeof (struct udplite_mib),
+			   __alignof__(struct udplite_mib)) < 0) {
+		snmp6_mib_free((void **)udp_stats_in6);
+		goto err_udp_mib;
+	}
+#endif
 	return 0;
 
 err_udp_mib:
@@ -782,6 +789,12 @@ static int __init inet6_init(void)
 	if (err)
 		goto out_unregister_tcp_proto;
 
+#ifdef CONFIG_IP_UDPLITE	/* tcp -> udp -> udplite -> raw */
+	err = proto_register(&udplitev6_prot, 1);
+	if (err)
+		goto out_unregister_udplite_proto;
+#endif
+
 	err = proto_register(&rawv6_prot, 1);
 	if (err)
 		goto out_unregister_udp_proto;
@@ -839,6 +852,10 @@ static int __init inet6_init(void)
 		goto proc_tcp6_fail;
 	if (udp6_proc_init())
 		goto proc_udp6_fail;
+#ifdef CONFIG_IP_UDPLITE	/* raw -> tcp -> udp -> udplite -> ipv6_misc */
+	if (udplite6_proc_init())
+		goto proc_udplite6_fail;
+#endif /* CONFIG_IP_UDPLITE */
 	if (ipv6_misc_proc_init())
 		goto proc_misc6_fail;
 
@@ -862,6 +879,9 @@ static int __init inet6_init(void)
 
 	/* Init v6 transport protocols. */
 	udpv6_init();
+#ifdef CONFIG_IP_UDPLITE
+	udplitev6_init();
+#endif
 	tcpv6_init();
 
 	ipv6_packet_init();
@@ -879,13 +899,17 @@ proc_if6_fail:
 proc_anycast6_fail:
 	ipv6_misc_proc_exit();
 proc_misc6_fail:
+#ifdef CONFIG_IP_UDPLITE	/* ipv6_misc -> udplite -> udp -> tcp -> raw */
+	udplite6_proc_exit();
+proc_udplite6_fail:
+#endif
 	udp6_proc_exit();
 proc_udp6_fail:
 	tcp6_proc_exit();
 proc_tcp6_fail:
 	raw6_proc_exit();
 proc_raw6_fail:
-#endif
+#endif	/* CONFIG_PROC_FS */
 	ipv6_netfilter_fini();
 netfilter_fail:
 	igmp6_cleanup();
@@ -903,6 +927,10 @@ out_unregister_sock:
 out_unregister_raw_proto:
 	proto_unregister(&rawv6_prot);
 out_unregister_udp_proto:
+#ifdef CONFIG_IP_UDPLITE		/* raw -> udplite -> udp -> tcp */
+	proto_unregister(&udplitev6_prot);
+out_unregister_udplite_proto:
+#endif
 	proto_unregister(&udpv6_prot);
 out_unregister_tcp_proto:
 	proto_unregister(&tcpv6_prot);
@@ -918,6 +946,9 @@ static void __exit inet6_exit(void)
 	if6_proc_exit();
 	ac6_proc_exit();
  	ipv6_misc_proc_exit();
+#ifdef CONFIG_IP_UDPLITE
+	udplite6_proc_exit();
+#endif /* CONFIG_IP_UDPLITE */
  	udp6_proc_exit();
  	tcp6_proc_exit();
  	raw6_proc_exit();
@@ -937,6 +968,9 @@ static void __exit inet6_exit(void)
 #endif
 	cleanup_ipv6_mibs();
 	proto_unregister(&rawv6_prot);
+#ifdef CONFIG_IP_UDPLITE
+	proto_unregister(&udplitev6_prot);
+#endif /* CONFIG_IP_UDPLITE */
 	proto_unregister(&udpv6_prot);
 	proto_unregister(&tcpv6_prot);
 }
diff -Nurp  a/include/net/ipv6.h b/include/net/ipv6.h
--- a/include/net/ipv6.h	2006-06-29 16:49:03.000000000 +0100
+++ b/include/net/ipv6.h	2006-06-29 19:03:14.000000000 +0100
@@ -146,6 +146,13 @@ DECLARE_SNMP_STAT(struct udp_mib, udp_st
 #define UDP6_INC_STATS_BH(field)	SNMP_INC_STATS_BH(udp_stats_in6, field)
 #define UDP6_INC_STATS_USER(field) 	SNMP_INC_STATS_USER(udp_stats_in6, field)
 
+#ifdef CONFIG_IP_UDPLITE
+DECLARE_SNMP_STAT(struct udplite_mib, udplite_stats_in6);
+#define UDPLITE6_INC_STATS(field)	SNMP_INC_STATS(udplite_stats_in6, field)
+#define UDPLITE6_INC_STATS_BH(field)	SNMP_INC_STATS_BH(udplite_stats_in6, field)
+#define UDPLITE6_INC_STATS_USER(field) 	SNMP_INC_STATS_USER(udplite_stats_in6, field)
+#endif /* CONFIG_IP_UDPLITE */
+
 int snmp6_register_dev(struct inet6_dev *idev);
 int snmp6_unregister_dev(struct inet6_dev *idev);
 int snmp6_alloc_dev(struct inet6_dev *idev);
@@ -583,6 +590,10 @@ extern int  tcp6_proc_init(void);
 extern void tcp6_proc_exit(void);
 extern int  udp6_proc_init(void);
 extern void udp6_proc_exit(void);
+#ifdef CONFIG_IP_UDPLITE
+extern int  udplite6_proc_init(void);
+extern void udplite6_proc_exit(void);
+#endif
 extern int  ipv6_misc_proc_init(void);
 extern void ipv6_misc_proc_exit(void);
 
diff -Nurp  a/include/net/transp_v6.h b/include/net/transp_v6.h
--- a/include/net/transp_v6.h	2006-06-22 09:34:19.000000000 +0100
+++ b/include/net/transp_v6.h	2006-06-29 19:02:27.000000000 +0100
@@ -25,6 +25,10 @@ extern void				ipv6_destopt_init(void);
 extern void				rawv6_init(void);
 extern void				udpv6_init(void);
 extern void				tcpv6_init(void);
+#ifdef CONFIG_IP_UDPLITE
+extern struct proto udplitev6_prot;
+extern void 				udplitev6_init(void);
+#endif
 
 extern int				udpv6_connect(struct sock *sk,
 						      struct sockaddr *uaddr,
diff -Nurp  a/net/ipv6/proc.c b/net/ipv6/proc.c
--- a/net/ipv6/proc.c	2006-06-19 08:45:26.000000000 +0100
+++ b/net/ipv6/proc.c	2006-06-29 19:02:27.000000000 +0100
@@ -50,6 +50,10 @@ static int sockstat6_seq_show(struct seq
 		       fold_prot_inuse(&tcpv6_prot));
 	seq_printf(seq, "UDP6: inuse %d\n",
 		       fold_prot_inuse(&udpv6_prot));
+#ifdef CONFIG_IP_UDPLITE
+	seq_printf(seq, "UDPLITE6: inuse %d\n",
+		        fold_prot_inuse(&udplitev6_prot));
+#endif /* CONFIG_IP_UDPLITE */
 	seq_printf(seq, "RAW6: inuse %d\n",
 		       fold_prot_inuse(&rawv6_prot));
 	seq_printf(seq, "FRAG6: inuse %d memory %d\n",
@@ -134,6 +138,20 @@ static struct snmp_mib snmp6_udp6_list[]
 	SNMP_MIB_SENTINEL
 };
 
+#ifdef CONFIG_IP_UDPLITE
+static struct snmp_mib snmp6_udplite_list[] = {
+	SNMP_MIB_ITEM("UdpLite6InDatagrams",   UDPLITE_MIB_INDATAGRAMS),
+	SNMP_MIB_ITEM("UdpLite6InPartialCov",  UDPLITE_MIB_IN_PARTIALCOV),
+	SNMP_MIB_ITEM("UdpLite6NoPorts",       UDPLITE_MIB_NOPORTS),
+	SNMP_MIB_ITEM("UdpLite6InErrors",      UDPLITE_MIB_INERRORS),
+	SNMP_MIB_ITEM("UdpLite6InBadCoverage", UDPLITE_MIB_IN_BAD_COV),
+	SNMP_MIB_ITEM("UdpLite6InBadChecksum", UDPLITE_MIB_IN_BAD_CSUM),
+	SNMP_MIB_ITEM("UdpLite6OutDatagrams",  UDPLITE_MIB_OUTDATAGRAMS),
+	SNMP_MIB_ITEM("UdpLite6OutPartialCov", UDPLITE_MIB_OUT_PARTIALCOV),
+	SNMP_MIB_SENTINEL
+};
+#endif
+
 static unsigned long
 fold_field(void *mib[], int offt)
 {
@@ -167,6 +185,9 @@ static int snmp6_seq_show(struct seq_fil
 		snmp6_seq_show_item(seq, (void **)ipv6_statistics, snmp6_ipstats_list);
 		snmp6_seq_show_item(seq, (void **)icmpv6_statistics, snmp6_icmp6_list);
 		snmp6_seq_show_item(seq, (void **)udp_stats_in6, snmp6_udp6_list);
+#ifdef CONFIG_IP_UDPLITE
+		snmp6_seq_show_item(seq, (void **)udplite_stats_in6, snmp6_udplite_list);
+#endif
 	}
 	return 0;
 }
diff -Nurp  a/net/ipv6/Makefile b/net/ipv6/Makefile
--- a/net/ipv6/Makefile	2006-06-29 16:49:09.000000000 +0100
+++ b/net/ipv6/Makefile	2006-06-29 19:02:27.000000000 +0100
@@ -13,6 +13,7 @@ ipv6-objs :=	af_inet6.o anycast.o ip6_ou
 ipv6-$(CONFIG_XFRM) += xfrm6_policy.o xfrm6_state.o xfrm6_input.o \
 	xfrm6_output.o
 ipv6-$(CONFIG_NETFILTER) += netfilter.o
+ipv6-$(CONFIG_IP_UDPLITE) += udplite.o
 ipv6-objs += $(ipv6-y)
 
 obj-$(CONFIG_INET6_AH) += ah6.o
