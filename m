Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751737AbWF3Oxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbWF3Oxc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 10:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWF3Oxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 10:53:31 -0400
Received: from dee.erg.abdn.ac.uk ([139.133.204.82]:61177 "EHLO erg.abdn.ac.uk")
	by vger.kernel.org with ESMTP id S932359AbWF3OxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 10:53:00 -0400
From: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Organization: Electronics Research Group, UoA
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de
Subject: [PATCH  2.6  2/3]  net/ipv4|v6: RFC 3828-compliant UDP-Lite support
Date: Fri, 30 Jun 2006 15:52:04 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606301552.04917@strip-the-willow>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ERG-MailScanner: Found to be clean
X-ERG-MailScanner-From: gerrit@erg.abdn.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The IPv4 part of the UDP-Lite extension.


Signed-off-by: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Signed-off-by: William Stanislaus <william@erg.abdn.ac.uk>
---

 core/sock.c    |    7
 ipv4/Makefile  |    1
 ipv4/af_inet.c |   95 +++
 ipv4/proc.c    |   37 +
 ipv4/udplite.c | 1651 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1783 insertions(+), 8 deletions(-)


diff -Nurp  a/net/ipv4/udplite.c b/net/ipv4/udplite.c
--- a/net/ipv4/udplite.c	1970-01-01 01:00:00.000000000 +0100
+++ b/net/ipv4/udplite.c	2006-06-30 14:18:00.000000000 +0100
@@ -0,0 +1,1651 @@
+/*
+ *  UDPLITE     An implementation of the UDP-Lite protocol as standardised in
+ *              RFC 3828. UDP-Lite is based on UDP: this code is a revision of
+ *              the original udp.c code with regard to all those aspects in
+ *              which UDP-Lite differs from UDP.
+ *
+ *  Version:    $Id: udplite.c,v 1.19 2006/06/30 07:09:51 gerrit Exp gerrit $
+ *
+ *  Authors:    William Stanislaus  <william@erg.abdn.ac.uk>
+ *              Gerrit Renker       <gerrit@erg.abdn.ac.uk>
+ *
+ *              based on original code from udp.c, by Ross Biro, Fred N. van
+ *              Kempen, Arnt Gulbrandsen, Alan Cox, and Hirokazu Takahashi
+ *
+ *  Changes:
+ *  Fixes:
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ */
+#include <asm/system.h>
+#include <asm/uaccess.h>
+#include <asm/ioctls.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <linux/module.h>
+#include <linux/socket.h>
+#include <linux/sockios.h>
+#include <linux/igmp.h>
+#include <linux/in.h>
+#include <linux/errno.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/config.h>
+#include <linux/inet.h>
+#include <linux/ipv6.h>
+#include <linux/netdevice.h>
+#include <net/snmp.h>
+#include <net/ip.h>
+#include <net/tcp_states.h>
+#include <net/protocol.h>
+#include <linux/skbuff.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <net/sock.h>
+#include <net/udplite.h>
+#include <net/icmp.h>
+#include <net/route.h>
+#include <net/inet_common.h>
+#include <net/checksum.h>
+#include <net/xfrm.h>
+
+/*
+ *   SNMP MIB for the UDP-Lite layer
+ */
+DEFINE_SNMP_STAT(struct udplite_mib, udplite_statistics) __read_mostly;
+
+struct hlist_head udplite_hash[UDP_HTABLE_SIZE];
+DEFINE_RWLOCK(udplite_hash_lock);
+
+/* Shared by v4/v6 UDP-Lite. */
+int    udplite_port_rover;
+
+static int udplite_v4_get_port(struct sock *sk, unsigned short snum)
+{
+	struct hlist_node *node;
+	struct sock *sk2;
+	struct inet_sock *inet = inet_sk(sk);
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
+			struct hlist_head *list;
+			int size;
+
+			list = &udplite_hash[result & (UDP_HTABLE_SIZE - 1)];
+			if (hlist_empty(list)) {
+				if (result > sysctl_local_port_range[1])
+					result = sysctl_local_port_range[0] +
+					((result - sysctl_local_port_range[0]) &
+						         (UDP_HTABLE_SIZE - 1));
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
+		for (i = 0; i < (1 << 16) / UDP_HTABLE_SIZE;
+		            i++, result += UDP_HTABLE_SIZE)  {
+			if (result > sysctl_local_port_range[1])
+				result = sysctl_local_port_range[0] +
+					((result - sysctl_local_port_range[0]) &
+					                 (UDP_HTABLE_SIZE - 1));
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
+			struct inet_sock *inet2 = inet_sk(sk2);
+
+			if (inet2->num == snum &&
+			    sk2 != sk &&
+			    !ipv6_only_sock(sk2) &&
+			    (!sk2->sk_bound_dev_if ||
+			     !sk->sk_bound_dev_if ||
+			     sk2->sk_bound_dev_if == sk->sk_bound_dev_if) &&
+			    (!inet2->rcv_saddr ||
+			     !inet->rcv_saddr ||
+			     inet2->rcv_saddr == inet->rcv_saddr) &&
+			    (!sk2->sk_reuse || !sk->sk_reuse))
+				goto fail;
+		}
+	}
+	inet->num = snum;
+	if (sk_unhashed(sk)) {
+		struct hlist_head *h= &udplite_hash[snum & (UDP_HTABLE_SIZE-1)];
+
+		sk_add_node(sk, h);
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
+static void udplite_v4_hash(struct sock *sk)
+{
+	BUG();
+}
+
+static void udplite_v4_unhash(struct sock *sk)
+{
+	write_lock_bh(&udplite_hash_lock);
+	if (sk_del_node_init(sk)) {
+		inet_sk(sk)->num = 0;
+		sock_prot_dec_use(sk->sk_prot);
+	}
+	write_unlock_bh(&udplite_hash_lock);
+}
+
+
+/* UDP nearly always wildcards out the wazoo, it makes no sense to try
+ * harder than this. -DaveM
+ */
+static struct sock *udplite_v4_lookup_longway(u32 saddr, u16 sport,
+					      u32 daddr, u16 dport, int dif)
+{
+	struct sock *sk, *result = NULL;
+	struct hlist_node *node;
+	unsigned short hnum = ntohs(dport);
+	int badness = -1;
+
+	sk_for_each(sk, node, &udplite_hash[hnum & (UDP_HTABLE_SIZE - 1)]) {
+		struct inet_sock *inet = inet_sk(sk);
+
+		if (inet->num == hnum && !ipv6_only_sock(sk)) {
+			int score = (sk->sk_family == PF_INET ? 1 : 0);
+			if (inet->rcv_saddr) {
+				if (inet->rcv_saddr != daddr)
+					continue;
+				score += 2;
+			}
+			if (inet->daddr) {
+				if (inet->daddr != saddr)
+					continue;
+				score += 2;
+			}
+			if (inet->dport) {
+				if (inet->dport != sport)
+					continue;
+				score += 2;
+			}
+			if (sk->sk_bound_dev_if) {
+				if (sk->sk_bound_dev_if != dif)
+					continue;
+				score += 2;
+			}
+			if (score == 9) {
+				result = sk;
+				break;
+			} else if (score > badness) {
+				result = sk;
+				badness = score;
+			}
+		}
+	}
+	return result;
+}
+
+static __inline__ struct sock *udplite_v4_lookup(u32 saddr, u16 sport,
+						 u32 daddr, u16 dport, int dif)
+{
+	struct sock *sk;
+
+	read_lock(&udplite_hash_lock);
+	sk = udplite_v4_lookup_longway(saddr, sport, daddr, dport, dif);
+	if (sk)
+		sock_hold(sk);
+	read_unlock(&udplite_hash_lock);
+	return sk;
+}
+
+static inline struct sock *udplite_v4_mcast_next(struct sock *sk,
+						 u16 loc_port, u32 loc_addr,
+						 u16 rmt_port, u32 rmt_addr,
+						 int dif)
+{
+	struct hlist_node *node;
+	struct sock *s = sk;
+	unsigned short hnum = ntohs(loc_port);
+
+	sk_for_each_from(s, node) {
+		struct inet_sock *inet = inet_sk(s);
+
+		if (inet->num != hnum					||
+		    (inet->daddr && inet->daddr != rmt_addr)		||
+		    (inet->dport != rmt_port && inet->dport)		||
+		    (inet->rcv_saddr && inet->rcv_saddr != loc_addr)	||
+		    ipv6_only_sock(s)					||
+		    (s->sk_bound_dev_if && s->sk_bound_dev_if != dif))
+			continue;
+		if (!ip_mc_sf_allow(s, loc_addr, rmt_addr, dif))
+			continue;
+		goto found;
+	}
+	s = NULL;
+found:
+	return s;
+}
+
+/*
+ * This routine is called by the ICMP module when it gets some
+ * sort of error condition.  If err < 0 then the socket should
+ * be closed and the error returned to the user.  If err > 0
+ * it's just the icmp type << 8 | icmp code.
+ * Header points to the ip header of the error packet. We move
+ * on past this. Then (as it used to claim before adjustment)
+ * header points to the first 8 bytes of the udp-lite header.  We need
+ * to find the appropriate port.
+ */
+
+void udplite_err(struct sk_buff *skb, u32 info)
+{
+	struct inet_sock *inet;
+	struct iphdr *iph  = (struct iphdr *)skb->data;
+	struct udplitehdr *uh  = (struct udplitehdr *)
+	                         (skb->data + (iph->ihl << 2));
+	int type = skb->h.icmph->type;
+	int code = skb->h.icmph->code;
+	struct sock *sk;
+	int harderr;
+	int err;
+
+	sk = udplite_v4_lookup(iph->daddr, uh->dest, iph->saddr,
+	                                   uh->source, skb->dev->ifindex);
+	if (sk == NULL) {
+		ICMP_INC_STATS_BH(ICMP_MIB_INERRORS);
+    	  	return;	/* No socket for error */
+	}
+
+	err = 0;
+	harderr = 0;
+	inet = inet_sk(sk);
+
+	switch (type) {
+	default:
+	case ICMP_TIME_EXCEEDED:
+		err = EHOSTUNREACH;
+		break;
+	case ICMP_SOURCE_QUENCH:
+		goto out;
+	case ICMP_PARAMETERPROB:
+		err = EPROTO;
+		harderr = 1;
+		break;
+	case ICMP_DEST_UNREACH:
+		if (code == ICMP_FRAG_NEEDED) {	 /* Path MTU discovery */
+			if (inet->pmtudisc != IP_PMTUDISC_DONT) {
+				err = EMSGSIZE;
+				harderr = 1;
+				break;
+			}
+			goto out;
+		}
+		err = EHOSTUNREACH;
+		if (code <= NR_ICMP_UNREACH) {
+			harderr = icmp_err_convert[code].fatal;
+			err = icmp_err_convert[code].errno;
+		}
+		break;
+	}
+
+	/*
+	 *      RFC1122: OK.  Passes ICMP errors back to application, as per
+	 *	4.1.3.3.
+	 */
+	if (!inet->recverr) {
+		if (!harderr || sk->sk_state != TCP_ESTABLISHED)
+			goto out;
+	} else {
+		ip_icmp_error(sk, skb, err, uh->dest, info, (u8 *) (uh + 1));
+	}
+	sk->sk_err = err;
+	sk->sk_error_report(sk);
+out:
+	sock_put(sk);
+}
+
+/*
+ * Throw away all pending data and cancel the corking. Socket is locked.
+ */
+static void udplite_flush_pending_frames(struct sock *sk)
+{
+	struct udplite_sock *up = udplite_sk(sk);
+
+	if (up->pending) {
+		up->len = 0;
+		up->pending = 0;
+		ip_flush_pending_frames(sk);
+	}
+}
+
+/**
+ *   udplite_push_pending_frames  -  send pending data
+ *
+ *   Push out all pending data as one UDP-Lite datagram. Socket is locked.
+ *   This code is modelled after the original in udp.c, but has been heavily
+ *   modified in all parts that relate to (partial) checksum computation.
+ */
+static int udplite_push_pending_frames(struct sock *sk, struct udplite_sock *up)
+{
+	struct inet_sock  *inet = inet_sk(sk);
+	struct flowi      *fl   = &inet->cork.fl;
+	struct sk_buff    *skb;
+	struct udplitehdr *ulh;
+	int                err   = 0;
+	unsigned short     cscov = 0,	      /* checksum coverage length     */
+	                   len;
+	u32	           csum  = 0;      /* Intermediate checksum value. */
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
+	        /* Sender has requested partial coverage via sockopts. */
+		if (up->pcslen < up->len) {
+			if (up->pcslen == 0)	 /* Full coverage (RFC 3828)  */
+			       cscov = up->len;
+			else {	                 /* Genuine partial coverage  */
+			       cscov = up->pcslen;
+			       UDPLITE_INC_STATS_BH(UDPLITE_MIB_OUT_PARTIALCOV);
+			}
+			ulh->checklen = htons(up->pcslen);
+
+		} else {
+			/*
+			 * Causes for up->pcslen > up->len (error):
+			 * (i)  Sender error (will not be penalized).
+			 * (ii) Payload too big for send buffer: data is split
+			 * into several packets, each with its own header. In
+			 * this case (e.g. last fragment), coverage length may
+			 * exceed packet length.
+			 * Since packets with coverage length > packet length
+			 * are illegal, we adjust in both cases to the maximum
+			 * upper bound.
+			 */
+			cscov = up->len;
+			ulh->checklen = htons(cscov);
+		}
+	} else {              /* No flag: emulate UDP.  */
+		cscov = up->len;
+		ulh->checklen = htons(cscov);
+	}
+
+	skb->ip_summed = CHECKSUM_NONE;    /* no HW support for checksumming */
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
+						 (cscov > len) ? len : cscov, 0);
+			csum = csum_add(csum, skb->csum);
+
+			if (cscov < len)      /* Enough seen. */
+				break;
+			cscov -= len;
+		}
+	}
+	/* Finalise the checksum by adding the pseudo-header. */
+	ulh->check = csum_tcpudp_magic(fl->fl4_src, fl->fl4_dst, up->len,
+				       IPPROTO_UDPLITE, csum);
+
+        /* RFC 3828: if computed checksum is 0, transmit it as all ones.
+         * The transmitted checksum MUST NOT be all zeroes (sec. 3.1).    */
+	if (ulh->check == 0)
+		ulh->check = -1;
+
+	err = ip_push_pending_frames(sk);
+out:
+	up->len = 0;
+	up->pending = 0;
+	return err;
+}
+
+/*
+ * 	UDP-Lite checksum computation is all in software, hence simpler getfrag
+ */
+inline int udplite_getfrag(void *from, char *to,
+			   int   offset, int len, int odd, struct sk_buff *skb)
+{
+	return memcpy_fromiovecend(to, (struct iovec *) from, offset, len);
+}
+
+int udplite_sendmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
+		    size_t len)
+{
+	struct inet_sock *inet = inet_sk(sk);
+	struct udplite_sock *up = udplite_sk(sk);
+	int ulen = len;
+	struct ipcm_cookie ipc;
+	struct rtable *rt = NULL;
+	int free = 0;
+	int connected = 0;
+	u32 daddr, faddr, saddr;
+	u16 dport;
+	u8  tos;
+	int err;
+	int corkreq = up->corkflag || msg->msg_flags&MSG_MORE;
+
+	if (len > 0xFFFF)
+		return -EMSGSIZE;
+
+	/*
+	 *	Check the flags.
+	 */
+
+	if (msg->msg_flags&MSG_OOB) /* Mirror BSD error message compatibility */
+		return -EOPNOTSUPP;
+
+	ipc.opt = NULL;
+
+	if (up->pending) {
+		/*
+		 * There are pending frames.
+		 * The socket lock must be held while it's corked.
+		 */
+		lock_sock(sk);
+		if (likely(up->pending)) {
+			if (unlikely(up->pending != AF_INET)) {
+				release_sock(sk);
+				return -EINVAL;
+			}
+			goto do_append_data;
+		}
+		release_sock(sk);
+	}
+	ulen += sizeof(struct udplitehdr);
+
+	/*
+	 *	Get and verify the address.
+	 */
+	if (msg->msg_name) {
+		struct sockaddr_in *usin = (struct sockaddr_in *)msg->msg_name;
+		if (msg->msg_namelen < sizeof(*usin))
+			return -EINVAL;
+		if (usin->sin_family != AF_INET) {
+			if (usin->sin_family != AF_UNSPEC)
+				return -EAFNOSUPPORT;
+		}
+
+		daddr = usin->sin_addr.s_addr;
+		dport = usin->sin_port;
+		if (dport == 0)
+			return -EINVAL;
+	} else {
+		if (sk->sk_state != TCP_ESTABLISHED)
+			return -EDESTADDRREQ;
+		daddr = inet->daddr;
+		dport = inet->dport;
+		/* Open fast path for connected socket.
+		   Route will not be used, if at least one option is set.
+		 */
+		connected = 1;
+	}
+	ipc.addr = inet->saddr;
+
+	ipc.oif = sk->sk_bound_dev_if;
+	if (msg->msg_controllen) {
+		err = ip_cmsg_send(msg, &ipc);
+		if (err)
+			return err;
+		if (ipc.opt)
+			free = 1;
+		connected = 0;
+	}
+	if (!ipc.opt)
+		ipc.opt = inet->opt;
+
+	saddr = ipc.addr;
+	ipc.addr = faddr = daddr;
+
+	if (ipc.opt && ipc.opt->srr) {
+		if (!daddr)
+			return -EINVAL;
+		faddr = ipc.opt->faddr;
+		connected = 0;
+	}
+	tos = RT_TOS(inet->tos);
+	if (sock_flag(sk, SOCK_LOCALROUTE) ||
+	    (msg->msg_flags & MSG_DONTROUTE) ||
+	    (ipc.opt && ipc.opt->is_strictroute)) {
+		tos |= RTO_ONLINK;
+		connected = 0;
+	}
+
+	if (MULTICAST(daddr)) {
+		if (!ipc.oif)
+			ipc.oif = inet->mc_index;
+		if (!saddr)
+			saddr = inet->mc_addr;
+		connected = 0;
+	}
+
+	if (connected)
+		rt = (struct rtable *)sk_dst_check(sk, 0);
+
+	if (rt == NULL) {
+		struct flowi fl = { .oif = ipc.oif,
+				    .nl_u = { .ip4_u =
+					      { .daddr = faddr,
+						.saddr = saddr,
+						.tos = tos } },
+				    .proto = IPPROTO_UDPLITE,
+				    .uli_u = { .ports =
+					       { .sport = inet->sport,
+						 .dport = dport } } };
+		err = ip_route_output_flow(&rt, &fl, sk,
+		                           !(msg->msg_flags&MSG_DONTWAIT));
+		if (err)
+			goto out;
+
+		err = -EACCES;
+		if ((rt->rt_flags & RTCF_BROADCAST) &&
+		    !sock_flag(sk, SOCK_BROADCAST))
+			goto out;
+		if (connected)
+			sk_dst_set(sk, dst_clone(&rt->u.dst));
+	}
+
+	if (msg->msg_flags&MSG_CONFIRM)
+		goto do_confirm;
+back_from_confirm:
+
+	saddr = rt->rt_src;
+	if (!ipc.addr)
+		daddr = ipc.addr = rt->rt_dst;
+
+	lock_sock(sk);
+	if (unlikely(up->pending)) {
+		/* The socket is already corked while preparing it. */
+		/* ... which is an evident application bug. --ANK   */
+		release_sock(sk);
+
+		LIMIT_NETDEBUG(KERN_WARNING "UDPLITE: cork app bug 2\n");
+		err = -EINVAL;
+		goto out;
+	}
+	/*
+	 *	Now cork the socket to pend data.
+	 */
+	inet->cork.fl.fl4_dst = daddr;
+	inet->cork.fl.fl_ip_dport = dport;
+	inet->cork.fl.fl4_src = saddr;
+	inet->cork.fl.fl_ip_sport = inet->sport;
+	up->pending = AF_INET;
+
+do_append_data:
+	up->len += ulen;
+	err = ip_append_data(sk, udplite_getfrag, msg->msg_iov, ulen,
+			sizeof(struct udplitehdr), &ipc, rt,
+			corkreq ? msg->msg_flags|MSG_MORE : msg->msg_flags);
+	if (err)
+		udplite_flush_pending_frames(sk);
+	else if (!corkreq)
+		err = udplite_push_pending_frames(sk, up);
+	release_sock(sk);
+
+out:
+	ip_rt_put(rt);
+	if (free)
+		kfree(ipc.opt);
+	if (!err) {
+		UDPLITE_INC_STATS_USER(UDPLITE_MIB_OUTDATAGRAMS);
+		return len;
+	}
+	return err;
+
+do_confirm:
+	dst_confirm(&rt->u.dst);
+	if (!(msg->msg_flags&MSG_PROBE) || len)
+		goto back_from_confirm;
+	err = 0;
+	goto out;
+}
+
+static int udplite_sendpage(struct sock *sk, struct page *page, int offset,
+			    size_t size, int flags)
+{
+	struct udplite_sock *up = udplite_sk(sk);
+	int ret;
+
+	if (!up->pending) {
+		struct msghdr msg = {	.msg_flags = flags|MSG_MORE };
+
+		/* Call udplite_sendmsg to specify destination address which
+		 * sendpage interface can't pass.
+		 * This will succeed only when the socket is connected.
+		 */
+		ret = udplite_sendmsg(NULL, sk, &msg, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	lock_sock(sk);
+
+	if (unlikely(!up->pending)) {
+		release_sock(sk);
+
+		LIMIT_NETDEBUG(KERN_WARNING "UDPLITE: cork app bug 3\n");
+		return -EINVAL;
+	}
+
+	ret = ip_append_page(sk, page, offset, size, flags);
+	if (ret == -EOPNOTSUPP) {
+		release_sock(sk);
+		return sock_no_sendpage(sk->sk_socket, page, offset,
+					size, flags);
+	}
+	if (ret < 0) {
+		udplite_flush_pending_frames(sk);
+		goto out;
+	}
+
+	up->len += size;
+	if (!(up->corkflag || (flags&MSG_MORE)))
+		ret = udplite_push_pending_frames(sk, up);
+	if (!ret)
+		ret = size;
+out:
+	release_sock(sk);
+	return ret;
+}
+
+/*
+ *	IOCTL requests applicable to the UDP-Lite protocol
+ */
+
+int udplite_ioctl(struct sock *sk, int cmd, unsigned long arg)
+{
+	switch (cmd)
+	{
+		case SIOCOUTQ:
+		{
+			int amount = atomic_read(&sk->sk_wmem_alloc);
+			return put_user(amount, (int __user *)arg);
+		}
+
+		case SIOCINQ:
+		{
+			struct sk_buff *skb;
+			unsigned long amount;
+
+			amount = 0;
+			spin_lock_bh(&sk->sk_receive_queue.lock);
+			skb = skb_peek(&sk->sk_receive_queue);
+			if (skb != NULL) {
+				/*
+				 * We will only return the amount
+				 * of this packet since that is all
+				 * that will be read.
+				 */
+				amount = skb->len - sizeof(struct udplitehdr);
+			}
+			spin_unlock_bh(&sk->sk_receive_queue.lock);
+			return put_user(amount, (int __user *)arg);
+		}
+
+		default:
+			return -ENOIOCTLCMD;
+	}
+	return (0);
+}
+
+
+/*
+ * 	This should be easy, if there is something there we
+ * 	return it, otherwise we block.
+ */
+
+static int udplite_recvmsg(struct kiocb *iocb,
+                           struct sock *sk, struct msghdr *msg,
+			   size_t len, int noblock, int flags, int *addr_len)
+{
+	struct inet_sock *inet = inet_sk(sk);
+	struct sockaddr_in *sin = (struct sockaddr_in *)msg->msg_name;
+	struct sk_buff *skb;
+	int copied, err;
+
+	/*
+	 *	Check any passed addresses
+	 */
+	if (addr_len)
+		*addr_len = sizeof(*sin);
+
+	if (flags & MSG_ERRQUEUE)
+		return ip_recv_error(sk, msg, len);
+
+try_again:
+	skb = skb_recv_datagram(sk, flags, noblock, &err);
+	if (!skb)
+		goto out;
+
+	copied = skb->len - sizeof(struct udplitehdr);
+	if (copied > len) {
+		copied = len;
+		msg->msg_flags |= MSG_TRUNC;
+	}
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
+	 * been de facto received by a  application (this is unlike udp.c
+	 * which counts erroneous InDatagrams as well).
+	 * FIXME: This may need revision if in-kernel applications use
+	 * data_ready handler.  */
+	UDPLITE_INC_STATS_BH(UDPLITE_MIB_INDATAGRAMS);
+        if(UDPLITE_SKB_CB(skb)->partial)
+		UDPLITE_INC_STATS_BH(UDPLITE_MIB_IN_PARTIALCOV);
+
+	/* Copy the address. */
+	if (sin)
+	{
+		sin->sin_family      = AF_INET;
+		sin->sin_port        = skb->h.ulh->source;
+		sin->sin_addr.s_addr = skb->nh.iph->saddr;
+		memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
+	}
+	if (inet->cmsg_flags)
+		ip_cmsg_recv(msg, skb);
+
+	err = copied;
+	if (flags & MSG_TRUNC)
+		err = skb->len - sizeof(struct udplitehdr);
+
+out_free:
+  	skb_free_datagram(sk, skb);
+out:
+  	return err;
+
+csum_copy_err:
+	LIMIT_NETDEBUG(KERN_DEBUG "UDPLITE: csum error "
+                "(%d.%d.%d.%d:%d -> %d.%d.%d.%d:%d)\n",
+		NIPQUAD(skb->nh.iph->saddr), ntohs(skb->h.ulh->source),
+		NIPQUAD(skb->nh.iph->daddr), ntohs(skb->h.ulh->dest));
+	UDPLITE_INC_STATS_BH(UDPLITE_MIB_IN_BAD_CSUM);
+	UDPLITE_INC_STATS_BH(UDPLITE_MIB_INERRORS);
+
+	skb_kill_datagram(sk, skb, flags);
+
+	if (noblock)
+		return -EAGAIN;
+	goto try_again;
+}
+
+
+int udplite_disconnect(struct sock *sk, int flags)
+{
+	struct inet_sock *inet = inet_sk(sk);
+	/*
+	 *	1003.1g - break association.
+	 */
+
+	sk->sk_state = TCP_CLOSE;
+	sk->sk_bound_dev_if = 0;
+	inet->daddr = 0;
+	inet->dport = 0;
+	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK))
+		inet_reset_saddr(sk);
+
+	if (!(sk->sk_userlocks & SOCK_BINDPORT_LOCK)) {
+		sk->sk_prot->unhash(sk);
+		inet->sport = 0;
+	}
+	sk_dst_reset(sk);
+	return 0;
+}
+
+static void udplite_close(struct sock *sk, long timeout)
+{
+	sk_common_release(sk);
+}
+
+/* return:
+ * 	1  if the the UDP-Lite system should process it
+ *	0  if we should drop this packet
+ * 	-1 if it should get processed by xfrm4_rcv_encap
+ */
+static int udplite_encap_rcv(struct sock *sk, struct sk_buff *skb)
+{
+#ifndef CONFIG_XFRM
+	return 1;
+#else
+	struct udplite_sock *up  = udplite_sk(sk);
+	struct udplitehdr *ulh = skb->h.ulh;
+	struct iphdr *iph;
+	int iphlen, len;
+
+	__u8  *udpdata  = (__u8 *) ulh + sizeof(struct udplitehdr);
+	__u32 *udpdata32 = (__u32 *)udpdata;
+	__u16 encap_type = up->encap_type;
+
+	/* if we're overly short, let UDP-Lite handle it */
+	if (udpdata > skb->tail)
+		return 1;
+
+	/* if this is not encapsulated socket, then just return now */
+	if (!encap_type)
+		return 1;
+
+	len = skb->tail - udpdata;
+
+	switch (encap_type) {
+	default:
+	case UDP_ENCAP_ESPINUDP:
+		/* Check if this is a keepalive packet.  If so, eat it. */
+		if (len == 1 && udpdata[0] == 0xff) {
+			return 0;
+		} else if (   len > sizeof(struct ip_esp_hdr) &&
+			      udpdata32[0] != 0                  )  {
+			/* ESP Packet without Non-ESP header */
+			len = sizeof(struct udplitehdr);
+		} else
+			/* Must be an IKE packet.. pass it through */
+			return 1;
+		break;
+	case UDP_ENCAP_ESPINUDP_NON_IKE:
+		/* Check if this is a keepalive packet.  If so, eat it. */
+		if (len == 1 && udpdata[0] == 0xff) {
+			return 0;
+		} else if (len > 2 * sizeof(u32) + sizeof(struct ip_esp_hdr) &&
+			   udpdata32[0] == 0 && udpdata32[1] == 0) {
+
+			/* ESP Packet with Non-IKE marker */
+			len = sizeof(struct udplitehdr) + 2 * sizeof(u32);
+		} else
+			/* Must be an IKE packet.. pass it through */
+			return 1;
+		break;
+	}
+
+	/* At this point we are sure that this is an ESP-in-UDP-Lite packet,
+	 * so we need to remove 'len' bytes from the packet (the UDP-Lite
+	 * header and optional ESP marker bytes) and then modify the
+	 * protocol to ESP, and then call into the transform receiver.
+	 */
+	if (skb_cloned(skb) && pskb_expand_head(skb, 0, 0, GFP_ATOMIC))
+		return 0;
+
+	/* Now we can update and verify the packet length... */
+	iph = skb->nh.iph;
+	iphlen = iph->ihl << 2;
+	iph->tot_len = htons(ntohs(iph->tot_len) - len);
+	if (skb->len < iphlen + len) {
+		/* packet is too small!?! */
+		return 0;
+	}
+
+	/* pull the data buffer up to the ESP header and set the
+	 * transport header to point to ESP.  Keep UDP-Lite on the stack
+	 * for later.
+	 */
+	skb->h.raw = skb_pull(skb, len);
+
+	/* modify the protocol (it's ESP!) */
+	iph->protocol = IPPROTO_ESP;
+
+	/* and let the caller know to send this into the ESP processor... */
+	return -1;
+#endif
+}
+
+/**
+ *   udplite_queue_rcv_skb  -  check and enqueue a UDP-Lite packet
+ *
+ *   Returns:
+ *    -1: error
+ *     0: success
+ *    >0: "UDP-Lite encap" protocol resubmission
+ *
+ *   Note that in the success and error cases, the skb is assumed to
+ *   have either been requeued or freed.
+ */
+
+static int udplite_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	struct udplite_sock *up = udplite_sk(sk);
+
+	/*
+	 *    Charge it to the socket, dropping if the queue is full.
+	 */
+	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb))
+		goto drop;
+	nf_reset(skb);
+
+	/*
+	 * 	FIXME: The use of encapsulated packets has not yet been tested.
+	 */
+	if (up->encap_type) {
+		/*
+		 * This is an encapsulation socket, so let's see if this is
+		 * an encapsulated packet.
+		 * If it's a keepalive packet, then just eat it.
+		 * If it's an encapsulateed packet, then pass it to the
+		 * IPsec xfrm input and return the response
+		 * appropriately.  Otherwise, just fall through and
+		 * pass this up the UDP-Lite socket.
+		 */
+		int ret;
+
+		ret = udplite_encap_rcv(sk, skb);
+		if (ret == 0) {
+			/* Eat the packet .. */
+			kfree_skb(skb);
+			return 0;
+		}
+		if (ret < 0) {
+			/* process the ESP packet */
+			ret = xfrm4_rcv_encap(skb, up->encap_type);
+			return -ret;
+		}
+		/* FALLTHROUGH -- it's a UDP-Lite Packet */
+	}
+
+
+	if ((up->pcflag & UDPLITE_RECV_CC) && UDPLITE_SKB_CB(skb)->partial) {
+
+		/*
+		 * MIB statistics other than incrementing the error count are
+		 * disabled for the following two types of errors: these depend
+		 * on the application settings, not on the functioning of the
+		 * protocol stack as such.
+		 *
+		 *
+		 * RFC 3828 here recommends (sec 3.3): "There should also be a
+		 * way ... to ... at least let the receiving application block
+		 * delivery of packets with coverage values less than a value
+		 * provided by the application."
+		 */
+		if (up->pcrlen == 0) {          /* full coverage was set  */
+			LIMIT_NETDEBUG(KERN_WARNING "UDPLITE: partial coverage "
+				"%d while full coverage %d requested\n",
+				UDPLITE_SKB_CB(skb)->cscov, skb->len);
+			goto drop;
+		}
+		/* The next case involves violating the min. coverage requested
+		 * by the receiver. This is subtle: if receiver wants x and x is
+		 * greater than the buffersize/MTU then receiver will complain
+		 * that it wants x while sender emits packets of smaller size y.
+		 * Therefore the above ...()->partial statement is essential.
+		 */
+		if (UDPLITE_SKB_CB(skb)->cscov  <  up->pcrlen) {
+			LIMIT_NETDEBUG(KERN_WARNING
+				"UDPLITE: coverage %d too small, need min %d\n",
+				UDPLITE_SKB_CB(skb)->cscov, up->pcrlen);
+			goto drop;
+		}
+	}
+
+	if (sk->sk_filter && likely(skb->ip_summed != CHECKSUM_UNNECESSARY)) {
+		if (__udplite_checksum_complete(skb)) {
+			UDPLITE_INC_STATS_BH(UDPLITE_MIB_IN_BAD_CSUM);
+			goto drop;
+		}
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	}
+
+	if (sock_queue_rcv_skb(sk, skb) >= 0)
+		return 0;
+drop:
+	UDPLITE_INC_STATS_BH(UDPLITE_MIB_INERRORS);
+	kfree_skb(skb);
+	return -1;
+}
+
+/*
+ *	Multicasts and broadcasts go to each listener.
+ *
+ *	Note: called only from the BH handler context,
+ *	so we don't need to lock the hashes.
+ */
+static int udplite_v4_mcast_deliver(struct sk_buff *skb, struct udplitehdr *uh,
+				    u32 saddr, u32 daddr)
+{
+	struct sock *sk;
+	int dif;
+
+	read_lock(&udplite_hash_lock);
+	sk = sk_head(&udplite_hash[ntohs(uh->dest) & (UDP_HTABLE_SIZE - 1)]);
+	dif = skb->dev->ifindex;
+	sk = udplite_v4_mcast_next(sk, uh->dest, daddr, uh->source, saddr, dif);
+	if (sk) {
+		struct sock *sknext = NULL;
+
+		do {
+			struct sk_buff *skb1 = skb;
+
+			sknext = udplite_v4_mcast_next(sk_next(sk),
+						       uh->dest, daddr,
+						       uh->source, saddr, dif);
+			if (sknext)
+				skb1 = skb_clone(skb, GFP_ATOMIC);
+
+			if (skb1) {
+				int ret = udplite_queue_rcv_skb(sk, skb1);
+				if (ret > 0)
+					/* we should probably re-process instead
+					 * of dropping packets here. */
+					kfree_skb(skb1);
+			}
+			sk = sknext;
+		} while (sknext);
+	} else
+		kfree_skb(skb);
+	read_unlock(&udplite_hash_lock);
+	return 0;
+}
+
+/**
+ *   udplite_checksum_init  -  Pre-compute UDP-Lite pseudo-header
+ *
+ *   CHECKSUM_UNNECESSARY means that no more checks are required. Otherwise,
+ *   csum completion requires to checksum packet body plus UDP-Lite header,
+ *   and folding it to skb->csum.
+ */
+static void udplite_checksum_init(struct sk_buff *skb, struct udplitehdr *ulh,
+				  unsigned short len, u32 saddr, u32 daddr)
+{
+	if (unlikely(skb->ip_summed == CHECKSUM_HW)) {
+		if (csum_tcpudp_magic(saddr, daddr, len,
+				      IPPROTO_UDPLITE, skb->csum) == 0)
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+	}
+	if (likely(skb->ip_summed != CHECKSUM_UNNECESSARY))
+		skb->csum = csum_tcpudp_nofold(saddr, daddr, len,
+				               IPPROTO_UDPLITE, 0);
+}
+
+/**
+ *   udplite_rcv  -  handle UDP-Lite datagrams
+ *
+ *   This handler is a modified variant of udp_rcv, integrating the
+ *   changes required to work with variable-length checksum coverages.
+ */
+int udplite_rcv(struct sk_buff *skb)
+{
+  	struct sock *sk;
+	struct udplitehdr *ulh = skb->h.ulh;
+	struct rtable *rt = (struct rtable*)skb->dst;
+	u32 saddr = skb->nh.iph->saddr;
+	u32 daddr = skb->nh.iph->daddr;
+	int len   = skb->len;		  /* total packet length  */
+	u16 cscov;    	        	  /* csum coverage length */
+
+	/*
+	 *    Perform sanity checks on the UDP-Lite packet.
+	 */
+	if (!pskb_may_pull(skb, sizeof(struct udplitehdr)))
+		goto drop;	          /* No space for header.             */
+
+	if (len < sizeof(*ulh))	          /* Unlike udp.c, we must not trim   */
+		goto short_packet;
+
+
+        /* In UDPv4 a zero checksum means that the transmitter generated no
+         * checksum. UDP-Lite (like IPv6) mandates checksums, hence packets
+         * with a zero checksum field are illegal.                            */
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
+
+	/* Compute initial checksum, including pseudo-header.
+	 * Note the difference: udp.c uses ulen while UDP-Lite uses skb->len  */
+	udplite_checksum_init(skb, ulh, len, saddr, daddr);
+
+	if (rt->rt_flags & (RTCF_BROADCAST|RTCF_MULTICAST))
+		return udplite_v4_mcast_deliver(skb, ulh, saddr, daddr);
+
+
+	sk = udplite_v4_lookup(saddr, ulh->source, daddr,
+				      ulh->dest, skb->dev->ifindex);
+
+	if (sk != NULL) {
+		int ret = udplite_queue_rcv_skb(sk, skb);
+		sock_put(sk);
+
+		/* a return value > 0 means to resubmit the input, but
+		 * it it wants the return to be -protocol, or 0
+		 */
+		if (ret > 0)
+			return -ret;
+		return 0;
+	}
+
+	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
+		goto drop;
+	nf_reset(skb);
+
+	/* No socket. Drop packet silently, if checksum is wrong */
+	if (udplite_checksum_complete(skb))
+		goto csum_error;
+
+	UDPLITE_INC_STATS_BH(UDPLITE_MIB_NOPORTS);
+	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PORT_UNREACH, 0);
+
+	/*
+	 * Hmm.  We got a UDP-Lite packet to a port to which we
+	 * don't wanna listen.  Ignore it.
+	 */
+	kfree_skb(skb);
+	return (0);
+
+short_packet:
+	LIMIT_NETDEBUG(KERN_INFO "UDPLITE: short packet of %d bytes "
+               "(%u.%u.%u.%u:%u -> %u.%u.%u.%u:%u\n)\n", len, NIPQUAD(saddr),
+	       ntohs(ulh->source), NIPQUAD(daddr), ntohs(ulh->dest)          );
+	goto drop;
+
+csumlen_error:
+	/*
+	 * Coverage length violates RFC 3828: log and discard silently.
+	 */
+	LIMIT_NETDEBUG(KERN_DEBUG "UDPLITE: bad csum coverage %d/%d "
+               "(%d.%d.%d.%d:%d -> %d.%d.%d.%d:%d)\n",
+	       cscov, len, NIPQUAD(saddr), ntohs(ulh->source),
+                           NIPQUAD(daddr), ntohs(ulh->dest)   );
+	UDPLITE_INC_STATS_BH(UDPLITE_MIB_IN_BAD_COV);
+	goto drop;
+
+csum_error:
+	LIMIT_NETDEBUG(KERN_DEBUG "UDPLITE: bad csum "
+                "(%d.%d.%d.%d:%d -> %d.%d.%d.%d:%d)\n", NIPQUAD(saddr),
+                     ntohs(ulh->source), NIPQUAD(daddr), ntohs(ulh->dest));
+	UDPLITE_INC_STATS_BH(UDPLITE_MIB_IN_BAD_CSUM);
+
+drop:
+	UDPLITE_INC_STATS_BH(UDPLITE_MIB_INERRORS);
+	kfree_skb(skb);
+	return (0);
+}
+
+static int udplite_destroy_sock(struct sock *sk)
+{
+	lock_sock(sk);
+	udplite_flush_pending_frames(sk);
+	release_sock(sk);
+	return 0;
+}
+
+/*
+ *	Socket option code for UDP-Lite
+ */
+static int do_udplite_setsockopt(struct sock *sk, int level, int optname,
+			      char __user *optval, int optlen)
+{
+	struct udplite_sock *up = udplite_sk(sk);
+	int val;
+	int err = 0;
+
+	if (optlen<sizeof(int))
+		return -EINVAL;
+
+	if (get_user(val, (int __user *)optval))
+		return -EFAULT;
+
+	switch (optname) {
+	case UDP_CORK:
+		if (val != 0) {
+			up->corkflag = 1;
+		} else {
+			up->corkflag = 0;
+			lock_sock(sk);
+			udplite_push_pending_frames(sk, up);
+			release_sock(sk);
+		}
+		break;
+
+	case UDP_ENCAP:
+		switch (val) {
+		case 0:
+		case UDP_ENCAP_ESPINUDP:
+		case UDP_ENCAP_ESPINUDP_NON_IKE:
+			up->encap_type = val;
+			break;
+		default:
+			err = -ENOPROTOOPT;
+			break;
+		}
+		break;
+	/* Sender sets actual checksum coverage length via this option.
+	   The case coverage > packet length is handled by send module. */
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
+static int udplite_setsockopt(struct sock *sk, int level, int optname,
+			      char __user *optval, int optlen)
+{
+	if (level != SOL_UDPLITE)
+		return ip_setsockopt(sk, level, optname, optval, optlen);
+	return do_udplite_setsockopt(sk, level, optname, optval, optlen);
+}
+
+#ifdef CONFIG_COMPAT
+static int compat_udplite_setsockopt(struct sock *sk, int level, int optname,
+				     char __user *optval, int optlen)
+{
+	if (level != SOL_UDPLITE)
+		return compat_ip_setsockopt(sk, level, optname, optval, optlen);
+	return do_udplite_setsockopt(sk, level, optname, optval, optlen);
+}
+#endif
+
+static int do_udplite_getsockopt(struct sock *sk, int level, int optname,
+		  	         char __user *optval, int __user *optlen)
+{
+	struct udplite_sock *up = udplite_sk(sk);
+	int val, len;
+
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	len = min_t(unsigned int, len, sizeof(int));
+
+	if (len < 0)
+		return -EINVAL;
+
+	switch (optname) {
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
+	if (put_user(len, optlen))
+		return -EFAULT;
+	if (copy_to_user(optval, &val, len))
+		return -EFAULT;
+	return 0;
+}
+
+static int udplite_getsockopt(struct sock *sk, int level, int optname,
+		   	      char __user *optval, int __user *optlen)
+{
+	if (level != SOL_UDPLITE)
+		return ip_getsockopt(sk, level, optname, optval, optlen);
+	return do_udplite_getsockopt(sk, level, optname, optval, optlen);
+}
+
+#ifdef CONFIG_COMPAT
+static int compat_udplite_getsockopt(struct sock *sk, int level, int optname,
+				     char __user *optval, int __user *optlen)
+{
+	if (level != SOL_UDPLITE)
+		return compat_ip_getsockopt(sk, level, optname, optval, optlen);
+	return do_udplite_getsockopt(sk, level, optname, optval, optlen);
+}
+#endif
+/**
+ * 	udplite_poll - wait for a UDP-Lite event.
+ *	@file - file struct
+ *	@sock - socket
+ *	@wait - poll table
+ *
+ *	This is same as datagram poll, except for the special case of
+ *	blocking sockets. If application is using a blocking fd
+ *	and a packet with checksum error is in the queue;
+ *	then it could get return from select indicating data available
+ *	but then block when reading it. Add special case code
+ *	to work around these arguably broken applications.
+ */
+unsigned int udplite_poll(struct file *file,
+			  struct socket *sock, poll_table  *wait)
+{
+	unsigned int  mask = datagram_poll(file, sock, wait);
+	struct sock *sk = sock->sk;
+
+	/* Check for false positives due to checksum errors */
+	if ((mask & POLLRDNORM) &&
+	    !(file->f_flags & O_NONBLOCK) &&
+	    !(sk->sk_shutdown & RCV_SHUTDOWN)) {
+		struct sk_buff_head *rcvq = &sk->sk_receive_queue;
+		struct sk_buff *skb;
+
+		spin_lock_bh(&rcvq->lock);
+		while ((skb = skb_peek(rcvq)) != NULL) {
+			if (udplite_checksum_complete(skb)) {
+				UDPLITE_INC_STATS_BH(UDPLITE_MIB_IN_BAD_CSUM);
+				UDPLITE_INC_STATS_BH(UDPLITE_MIB_INERRORS);
+				__skb_unlink(skb, rcvq);
+				kfree_skb(skb);
+			} else {
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+				break;
+			}
+		}
+		spin_unlock_bh(&rcvq->lock);
+
+		/* nothing to see, move along */
+		if (skb == NULL)
+			mask &= ~(POLLIN | POLLRDNORM);
+	}
+
+	return mask;
+
+}
+
+
+struct proto udplite_prot = {
+	.name		   = "UDPLITE",
+	.owner		   = THIS_MODULE,
+	.close		   = udplite_close,
+	.connect	   = ip4_datagram_connect,
+	.disconnect	   = udplite_disconnect,
+	.ioctl		   = udplite_ioctl,
+	.destroy	   = udplite_destroy_sock,
+	.setsockopt	   = udplite_setsockopt,
+	.getsockopt	   = udplite_getsockopt,
+	.sendmsg 	   = udplite_sendmsg,
+	.recvmsg 	   = udplite_recvmsg,
+	.sendpage	   = udplite_sendpage,
+	.backlog_rcv	   = udplite_queue_rcv_skb,
+	.hash		   = udplite_v4_hash,
+	.unhash		   = udplite_v4_unhash,
+	.get_port	   = udplite_v4_get_port,
+	.obj_size	   = sizeof(struct udplite_sock),
+#ifdef CONFIG_COMPAT
+	.compat_setsockopt = compat_udplite_setsockopt,
+	.compat_getsockopt = compat_udplite_getsockopt,
+#endif
+};
+
+/* ------------------------------------------------------------------------ */
+#ifdef CONFIG_PROC_FS
+
+static struct sock *udplite_get_first(struct seq_file *seq)
+{
+	struct sock *sk;
+	struct udp_iter_state *state = seq->private;
+
+	for (state->bucket=0;state->bucket < UDP_HTABLE_SIZE; ++state->bucket) {
+		struct hlist_node *node;
+		sk_for_each(sk, node, &udplite_hash[state->bucket]) {
+			if (sk->sk_family == state->family)
+				goto found;
+		}
+	}
+	sk = NULL;
+found:
+	return sk;
+}
+
+static struct sock *udplite_get_next(struct seq_file *seq, struct sock *sk)
+{
+	struct udp_iter_state *state = seq->private;
+
+	do {
+		sk = sk_next(sk);
+try_again:
+		;
+	} while (sk && sk->sk_family != state->family);
+
+	if (!sk && ++state->bucket < UDP_HTABLE_SIZE) {
+		sk = sk_head(&udplite_hash[state->bucket]);
+		goto try_again;
+	}
+	return sk;
+}
+
+static struct sock *udplite_get_idx(struct seq_file *seq, loff_t pos)
+{
+	struct sock *sk = udplite_get_first(seq);
+
+	if (sk)
+		while (pos && (sk = udplite_get_next(seq, sk)) != NULL)
+			--pos;
+	return pos? NULL : sk;
+}
+
+static void *udplite_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	read_lock(&udplite_hash_lock);
+	return *pos ? udplite_get_idx(seq, *pos-1) : (void *)1;
+}
+
+static void *udplite_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct sock *sk;
+
+	if (v == (void *)1)
+		sk = udplite_get_idx(seq, 0);
+	else
+		sk = udplite_get_next(seq, v);
+
+	++*pos;
+	return sk;
+}
+
+static void udplite_seq_stop(struct seq_file *seq, void *v)
+{
+	read_unlock(&udplite_hash_lock);
+}
+
+static int udplite_seq_open(struct inode *inode, struct file *file)
+{
+	struct udp_seq_afinfo *afinfo = PDE(inode)->data;
+	struct seq_file *seq;
+	int rc = -ENOMEM;
+	struct udp_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+
+	if (!s)
+		goto out;
+	memset(s, 0, sizeof(*s));
+	s->family		= afinfo->family;
+	s->seq_ops.start	= udplite_seq_start;
+	s->seq_ops.next		= udplite_seq_next;
+	s->seq_ops.show		= afinfo->seq_show;
+	s->seq_ops.stop		= udplite_seq_stop;
+
+	rc = seq_open(file, &s->seq_ops);
+	if (rc)
+		goto out_kfree;
+
+	seq	     = file->private_data;
+	seq->private = s;
+out:
+	return rc;
+out_kfree:
+	kfree(s);
+	goto out;
+}
+
+/* ------------------------------------------------------------------------ */
+int udplite_proc_register(struct udp_seq_afinfo *afinfo)
+{
+	struct proc_dir_entry *p;
+	int rc = 0;
+
+	if (!afinfo)
+		return -EINVAL;
+	afinfo->seq_fops->owner		= afinfo->owner;
+	afinfo->seq_fops->open		= udplite_seq_open;
+	afinfo->seq_fops->read		= seq_read;
+	afinfo->seq_fops->llseek	= seq_lseek;
+	afinfo->seq_fops->release	= seq_release_private;
+
+	p = proc_net_fops_create(afinfo->name, S_IRUGO, afinfo->seq_fops);
+	if (p)
+		p->data = afinfo;
+	else
+		rc = -ENOMEM;
+	return rc;
+}
+
+void udplite_proc_unregister(struct udp_seq_afinfo *afinfo)
+{
+	if (!afinfo)
+		return;
+	proc_net_remove(afinfo->name);
+	memset(afinfo->seq_fops, 0, sizeof(*afinfo->seq_fops));
+}
+
+/* ------------------------------------------------------------------------ */
+static void udplite4_format_sock(struct sock *sp, char *tmpbuf, int bucket)
+{
+	struct inet_sock *inet = inet_sk(sp);
+	unsigned int dest = inet->daddr;
+	unsigned int src  = inet->rcv_saddr;
+	__u16 destp	  = ntohs(inet->dport);
+	__u16 srcp	  = ntohs(inet->sport);
+
+	sprintf(tmpbuf, "%4d: %08X:%04X %08X:%04X"
+		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %lu %d %p",
+		bucket, src, srcp, dest, destp, sp->sk_state,
+		atomic_read(&sp->sk_wmem_alloc),
+		atomic_read(&sp->sk_rmem_alloc),
+		0, 0L, 0, sock_i_uid(sp), 0, sock_i_ino(sp),
+		atomic_read(&sp->sk_refcnt), sp);
+}
+
+static int udplite4_seq_show(struct seq_file *seq, void *v)
+{
+	if (v == SEQ_START_TOKEN)
+		seq_printf(seq, "%-127s\n",
+			   "  sl  local_address rem_address   st tx_queue "
+			   "rx_queue tr tm->when retrnsmt   uid  timeout "
+			   "inode");
+	else {
+		char tmpbuf[129];
+		struct udp_iter_state *state = seq->private;
+
+		udplite4_format_sock(v, tmpbuf, state->bucket);
+		seq_printf(seq, "%-127s\n", tmpbuf);
+	}
+	return 0;
+}
+
+/* ------------------------------------------------------------------------ */
+static struct file_operations udplite4_seq_fops;
+static struct udp_seq_afinfo  udplite4_seq_afinfo = {
+	.owner		= THIS_MODULE,
+	.name		= "udplite",
+	.family		= AF_INET,
+	.seq_show	= udplite4_seq_show,
+	.seq_fops	= &udplite4_seq_fops,
+};
+
+
+int __init udplite4_proc_init(void)
+{
+	return udplite_proc_register(&udplite4_seq_afinfo);
+}
+
+void udplite4_proc_exit(void)
+{
+	udplite_proc_unregister(&udplite4_seq_afinfo);
+}
+#endif /* CONFIG_PROC_FS */
+
+EXPORT_SYMBOL(udplite_disconnect);
+EXPORT_SYMBOL(udplite_hash);
+EXPORT_SYMBOL(udplite_hash_lock);
+EXPORT_SYMBOL(udplite_ioctl);
+EXPORT_SYMBOL(udplite_port_rover);
+EXPORT_SYMBOL(udplite_prot);
+EXPORT_SYMBOL(udplite_sendmsg);
+EXPORT_SYMBOL(udplite_poll);
+
+#ifdef CONFIG_PROC_FS
+EXPORT_SYMBOL(udplite_proc_register);
+EXPORT_SYMBOL(udplite_proc_unregister);
+#endif
diff -Nurp  a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	2006-06-29 16:49:08.000000000 +0100
+++ b/net/ipv4/af_inet.c	2006-06-29 18:02:43.000000000 +0100
@@ -15,6 +15,8 @@
  * Changes (see also sock.c)
  *
  *		piggy,
+ *		W. Stanislaus	:	Added the UDP-Lite protocol (RFC 3828),
+ *					(maintainer: gerrit@erg.abdn.ac.uk)
  *		Karl Knutson	:	Socket protocol table
  *		A.N.Kuznetsov	:	Socket death error in accept().
  *		John Richardson :	Fix non blocking error in connect()
@@ -105,6 +107,9 @@
 #include <net/inet_connection_sock.h>
 #include <net/tcp.h>
 #include <net/udp.h>
+#ifdef CONFIG_IP_UDPLITE
+#include <net/udplite.h>
+#endif
 #include <linux/skbuff.h>
 #include <net/sock.h>
 #include <net/raw.h>
@@ -838,6 +843,36 @@ const struct proto_ops inet_dgram_ops = 
 #endif
 };
 
+#ifdef CONFIG_IP_UDPLITE
+/*
+ * UDP-Lite (connectionless, unreliable, variable-coverage, RFC 3828)
+ */
+const struct proto_ops inet_ldgram_ops = {
+	.family		   =	PF_INET,
+	.owner		   =	THIS_MODULE,
+	.release	   =	inet_release,
+	.bind		   =	inet_bind,
+	.connect	   =	inet_dgram_connect,
+	.socketpair	   =	sock_no_socketpair,
+	.accept		   =	sock_no_accept,
+	.getname	   =	inet_getname,
+	.poll		   =	udplite_poll,
+	.ioctl		   =	inet_ioctl,
+	.listen		   =	sock_no_listen,
+	.shutdown	   =	inet_shutdown,
+	.setsockopt	   =	sock_common_setsockopt,
+	.getsockopt	   =	sock_common_getsockopt,
+	.sendmsg	   =	inet_sendmsg,
+	.recvmsg	   =	sock_common_recvmsg,
+	.mmap		   =	sock_no_mmap,
+	.sendpage	   =	inet_sendpage,
+#ifdef CONFIG_COMPAT       /* XXX not yet fully tested -- GR */
+	.compat_setsockopt = compat_sock_common_setsockopt,
+	.compat_getsockopt = compat_sock_common_getsockopt,
+#endif
+};
+#endif /* CONFIG_IP_UDPLITE */
+
 /*
  * For SOCK_RAW sockets; should be the same as inet_dgram_ops but without
  * udp_poll
@@ -898,8 +933,17 @@ static struct inet_protosw inetsw_array[
                 .no_check =   UDP_CSUM_DEFAULT,
                 .flags =      INET_PROTOSW_PERMANENT,
        },
-        
-
+#ifdef CONFIG_IP_UDPLITE
+       {
+                .type       =  SOCK_DGRAM,
+                .protocol   =  IPPROTO_UDPLITE,
+                .prot       =  &udplite_prot,
+                .ops        =  &inet_ldgram_ops,
+                .capability = -1,
+                .no_check   =  0,               /* must checksum (RFC 3828) */
+                .flags      =  INET_PROTOSW_PERMANENT,
+       },
+#endif
        {
                .type =       SOCK_RAW,
                .protocol =   IPPROTO_IP,	/* wild card */
@@ -1164,6 +1208,14 @@ static struct net_protocol udp_protocol 
 	.no_policy =	1,
 };
 
+#ifdef CONFIG_IP_UDPLITE
+static struct net_protocol udplite_protocol = {
+	.handler     =	udplite_rcv,
+	.err_handler =	udplite_err,
+	.no_policy   =	1,
+};
+#endif
+
 static struct net_protocol icmp_protocol = {
 	.handler =	icmp_rcv,
 };
@@ -1180,11 +1232,22 @@ static int __init init_ipv4_mibs(void)
 	tcp_statistics[1] = alloc_percpu(struct tcp_mib);
 	udp_statistics[0] = alloc_percpu(struct udp_mib);
 	udp_statistics[1] = alloc_percpu(struct udp_mib);
+#ifdef CONFIG_IP_UDPLITE
+	udplite_statistics[0] = alloc_percpu(struct udplite_mib);
+	udplite_statistics[1] = alloc_percpu(struct udplite_mib);
+	if (! (  net_statistics[0]     && net_statistics[1]
+	      && ip_statistics[0]      && ip_statistics[1]
+	      && tcp_statistics[0]     && tcp_statistics[1]
+	      && udp_statistics[0]     && udp_statistics[1]
+	      && udplite_statistics[0] && udplite_statistics[1]) )
+			return -ENOMEM;
+#else
 	if (!
 	    (net_statistics[0] && net_statistics[1] && ip_statistics[0]
 	     && ip_statistics[1] && tcp_statistics[0] && tcp_statistics[1]
 	     && udp_statistics[0] && udp_statistics[1]))
-		return -ENOMEM;
+			return -ENOMEM;
+#endif /* CONFIG_IP_UDPLITE */
 
 	(void) tcp_mib_init();
 
@@ -1223,6 +1286,12 @@ static int __init inet_init(void)
 	if (rc)
 		goto out_unregister_tcp_proto;
 
+#ifdef CONFIG_IP_UDPLITE	/* tcp -> udp -> udplite -> raw */
+	rc = proto_register(&udplite_prot, 1);
+	if (rc)
+		goto out_unregister_udplite_proto;
+#endif
+
 	rc = proto_register(&raw_prot, 1);
 	if (rc)
 		goto out_unregister_udp_proto;
@@ -1241,6 +1310,10 @@ static int __init inet_init(void)
 		printk(KERN_CRIT "inet_init: Cannot add ICMP protocol\n");
 	if (inet_add_protocol(&udp_protocol, IPPROTO_UDP) < 0)
 		printk(KERN_CRIT "inet_init: Cannot add UDP protocol\n");
+#ifdef CONFIG_IP_UDPLITE
+	if (inet_add_protocol(&udplite_protocol, IPPROTO_UDPLITE) < 0)
+		printk(KERN_CRIT "inet_init: Cannot add UDP-Lite protocol\n");
+#endif
 	if (inet_add_protocol(&tcp_protocol, IPPROTO_TCP) < 0)
 		printk(KERN_CRIT "inet_init: Cannot add TCP protocol\n");
 #ifdef CONFIG_IP_MULTICAST
@@ -1301,10 +1374,14 @@ static int __init inet_init(void)
 	rc = 0;
 out:
 	return rc;
-out_unregister_tcp_proto:
-	proto_unregister(&tcp_prot);
 out_unregister_udp_proto:
+#ifdef CONFIG_IP_UDPLITE		/* raw -> udplite -> udp -> tcp */
+	proto_unregister(&udplite_prot);
+out_unregister_udplite_proto:
+#endif
 	proto_unregister(&udp_prot);
+out_unregister_tcp_proto:
+	proto_unregister(&tcp_prot);
 	goto out;
 }
 
@@ -1323,6 +1400,10 @@ static int __init ipv4_proc_init(void)
 		goto out_tcp;
 	if (udp4_proc_init())
 		goto out_udp;
+#ifdef CONFIG_IP_UDPLITE	/* raw -> tcp -> udp -> udplite -> fib */
+	if (udplite4_proc_init())
+		goto out_udplite;
+#endif
 	if (fib_proc_init())
 		goto out_fib;
 	if (ip_misc_proc_init())
@@ -1332,6 +1413,10 @@ out:
 out_misc:
 	fib_proc_exit();
 out_fib:
+#ifdef CONFIG_IP_UDPLITE	/* fib -> udplite -> udp -> tcp -> raw */
+	udplite4_proc_exit();
+out_udplite:
+#endif
 	udp4_proc_exit();
 out_udp:
 	tcp4_proc_exit();
diff -Nurp  a/net/ipv4/proc.c b/net/ipv4/proc.c
--- a/net/ipv4/proc.c	2006-06-19 08:45:26.000000000 +0100
+++ b/net/ipv4/proc.c	2006-06-29 18:02:43.000000000 +0100
@@ -14,6 +14,8 @@
  *		Fred Baumgarten, <dc6iq@insu1.etec.uni-karlsruhe.de>
  *		Erik Schoenfelder, <schoenfr@ibr.cs.tu-bs.de>
  *
+ * Changes:
+ *
  * Fixes:
  *		Alan Cox	:	UDP sockets show the rxqueue/txqueue
  *					using hint flag for the netinfo.
@@ -38,6 +40,9 @@
 #include <net/protocol.h>
 #include <net/tcp.h>
 #include <net/udp.h>
+#ifdef CONFIG_IP_UDPLITE
+#include <net/udplite.h>
+#endif
 #include <linux/inetdevice.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -66,9 +71,12 @@ static int sockstat_seq_show(struct seq_
 		   tcp_death_row.tw_count, atomic_read(&tcp_sockets_allocated),
 		   atomic_read(&tcp_memory_allocated));
 	seq_printf(seq, "UDP: inuse %d\n", fold_prot_inuse(&udp_prot));
+#ifdef CONFIG_IP_UDPLITE
+	seq_printf(seq, "UDPLITE: inuse %d\n", fold_prot_inuse(&udplite_prot));
+#endif
 	seq_printf(seq, "RAW: inuse %d\n", fold_prot_inuse(&raw_prot));
-	seq_printf(seq,  "FRAG: inuse %d memory %d\n", ip_frag_nqueues,
-		   atomic_read(&ip_frag_mem));
+	seq_printf(seq, "FRAG: inuse %d memory %d\n", ip_frag_nqueues,
+		             atomic_read(&ip_frag_mem));
 	return 0;
 }
 
@@ -176,6 +184,20 @@ static const struct snmp_mib snmp4_udp_l
 	SNMP_MIB_SENTINEL
 };
 
+#ifdef CONFIG_IP_UDPLITE
+static struct snmp_mib snmp4_udplite_list[] = {
+	SNMP_MIB_ITEM("InDatagrams",   UDPLITE_MIB_INDATAGRAMS),
+	SNMP_MIB_ITEM("InPartialCov",  UDPLITE_MIB_IN_PARTIALCOV),
+	SNMP_MIB_ITEM("NoPorts",       UDPLITE_MIB_NOPORTS),
+	SNMP_MIB_ITEM("InErrors",      UDPLITE_MIB_INERRORS),
+	SNMP_MIB_ITEM("InBadCoverage", UDPLITE_MIB_IN_BAD_COV),
+	SNMP_MIB_ITEM("InBadChecksum", UDPLITE_MIB_IN_BAD_CSUM),
+	SNMP_MIB_ITEM("OutDatagrams",  UDPLITE_MIB_OUTDATAGRAMS),
+	SNMP_MIB_ITEM("OutPartialCov", UDPLITE_MIB_OUT_PARTIALCOV),
+	SNMP_MIB_SENTINEL
+};
+#endif
+
 static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("SyncookiesSent", LINUX_MIB_SYNCOOKIESSENT),
 	SNMP_MIB_ITEM("SyncookiesRecv", LINUX_MIB_SYNCOOKIESRECV),
@@ -302,6 +324,17 @@ static int snmp_seq_show(struct seq_file
 			   fold_field((void **) udp_statistics, 
 				      snmp4_udp_list[i].entry));
 
+#ifdef CONFIG_IP_UDPLITE
+	seq_puts(seq, "\nUdpLite:");
+	for (i = 0; snmp4_udplite_list[i].name != NULL; i++)
+		seq_printf(seq, " %s", snmp4_udplite_list[i].name);
+
+	seq_puts(seq, "\nUdpLite:");
+	for (i = 0; snmp4_udplite_list[i].name != NULL; i++)
+		seq_printf(seq, " %lu",
+			   fold_field((void **) udplite_statistics,
+				      snmp4_udplite_list[i].entry));
+#endif
 	seq_putc(seq, '\n');
 	return 0;
 }
diff -Nurp  a/net/core/sock.c b/net/core/sock.c
--- a/net/core/sock.c	2006-06-29 16:49:08.000000000 +0100
+++ b/net/core/sock.c	2006-06-29 18:02:43.000000000 +0100
@@ -438,7 +438,12 @@ set_rcvbuf:
 			break;
 
 	 	case SO_NO_CHECK:
-			sk->sk_no_check = valbool;
+			/* UDP-Lite (RFC 3828) mandates checksumming,
+			 * hence user must not enable this option.   */
+			if (sk->sk_protocol == IPPROTO_UDPLITE)
+				ret = -EOPNOTSUPP;
+			else
+ 			    sk->sk_no_check = valbool;
 			break;
 
 		case SO_PRIORITY:
diff -Nurp  a/net/ipv4/Makefile b/net/ipv4/Makefile
--- a/net/ipv4/Makefile	2006-06-29 16:49:08.000000000 +0100
+++ b/net/ipv4/Makefile	2006-06-29 18:02:43.000000000 +0100
@@ -16,6 +16,7 @@ obj-$(CONFIG_IP_FIB_TRIE) += fib_trie.o
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_IP_MULTIPLE_TABLES) += fib_rules.o
 obj-$(CONFIG_IP_MROUTE) += ipmr.o
+obj-$(CONFIG_IP_UDPLITE) += udplite.o
 obj-$(CONFIG_NET_IPIP) += ipip.o
 obj-$(CONFIG_NET_IPGRE) += ip_gre.o
 obj-$(CONFIG_SYN_COOKIES) += syncookies.o

