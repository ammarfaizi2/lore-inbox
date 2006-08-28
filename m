Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWH1LBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWH1LBT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 07:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWH1LBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 07:01:19 -0400
Received: from dee.erg.abdn.ac.uk ([139.133.204.82]:47838 "EHLO erg.abdn.ac.uk")
	by vger.kernel.org with ESMTP id S964802AbWH1LBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 07:01:14 -0400
From: gerrit@erg.abdn.ac.uk
To: davem@davemloft.net
Subject: Re: [RFC][PATCH 0/3] net: a lighter UDP-Lite (RFC 3828)
Date: Mon, 28 Aug 2006 11:59:21 +0100
User-Agent: KMail/1.8.3
Cc: jmorris@namei.org, alan@lxorguk.ukuu.org.uk, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, kaber@coreworks.de, yoshfuji@linux-ipv6.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200608231150.37895@strip-the-willow>
In-Reply-To: <200608231150.37895@strip-the-willow>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608281159.21583@strip-the-willow>
X-ERG-MailScanner: Found to be clean
X-ERG-MailScanner-From: gerrit@erg.abdn.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[NET/IPv4]: update for udp.c only, to match 2.6.18-rc4-mm3

This is an update only, as the previous patch can not cope
with recent changes to udp.c (all other files remain the same).

Up-to-date, complete patches can always be taken from 
http://www.erg.abdn.ac.uk/users/gerrit/udp-lite/files/udplite_linux.tar.gz

Signed-off-by: Gerrit Renker <gerrit@erg.abdn.ac.uk>
---
  udp.c |  606 ++++++++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 410 insertions(+), 196 deletions(-)


diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 514c1e9..4ddd8e6 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -92,10 +92,8 @@ #include <linux/errno.h>
 #include <linux/timer.h>
 #include <linux/mm.h>
 #include <linux/inet.h>
-#include <linux/ipv6.h>
 #include <linux/netdevice.h>
 #include <net/snmp.h>
-#include <net/ip.h>
 #include <net/tcp_states.h>
 #include <net/protocol.h>
 #include <linux/skbuff.h>
@@ -121,7 +119,19 @@ DEFINE_RWLOCK(udp_hash_lock);
 /* Shared by v4/v6 udp. */
 int udp_port_rover;
 
-static int udp_v4_get_port(struct sock *sk, unsigned short snum)
+/* the extensions for UDP-Lite (RFC 3828) */
+#include "udplite.c"
+
+/**
+ * 	__udp_get_port  -  find an unbound UDP(-Lite) port
+ *
+ * 	@sk:         udp_sock
+ * 	@snum:       port number to look up
+ * 	@udptable:   hash list table, must be of UDP_HTABLE_SIZE
+ * 	@port_rover: pointer to record of last unallocated port
+ */
+int __udp_get_port(struct sock *sk, unsigned short snum,
+		  struct hlist_head udptable[], int *port_rover)
 {
 	struct hlist_node *node;
 	struct sock *sk2;
@@ -131,16 +141,16 @@ static int udp_v4_get_port(struct sock *
 	if (snum == 0) {
 		int best_size_so_far, best, result, i;
 
-		if (udp_port_rover > sysctl_local_port_range[1] ||
-		    udp_port_rover < sysctl_local_port_range[0])
-			udp_port_rover = sysctl_local_port_range[0];
+		if (*port_rover > sysctl_local_port_range[1] ||
+		    *port_rover < sysctl_local_port_range[0])
+			*port_rover = sysctl_local_port_range[0];
 		best_size_so_far = 32767;
-		best = result = udp_port_rover;
+		best = result = *port_rover;
 		for (i = 0; i < UDP_HTABLE_SIZE; i++, result++) {
 			struct hlist_head *list;
 			int size;
 
-			list = &udp_hash[result & (UDP_HTABLE_SIZE - 1)];
+			list = &udptable[result & (UDP_HTABLE_SIZE - 1)];
 			if (hlist_empty(list)) {
 				if (result > sysctl_local_port_range[1])
 					result = sysctl_local_port_range[0] +
@@ -162,16 +172,16 @@ static int udp_v4_get_port(struct sock *
 				result = sysctl_local_port_range[0]
 					+ ((result - sysctl_local_port_range[0]) &
 					   (UDP_HTABLE_SIZE - 1));
-			if (!udp_lport_inuse(result))
+			if (! __udp_lport_inuse(result, udptable))
 				break;
 		}
 		if (i >= (1 << 16) / UDP_HTABLE_SIZE)
 			goto fail;
 gotit:
-		udp_port_rover = snum = result;
+		*port_rover = snum = result;
 	} else {
 		sk_for_each(sk2, node,
-			    &udp_hash[snum & (UDP_HTABLE_SIZE - 1)]) {
+			    &udptable[snum & (UDP_HTABLE_SIZE - 1)]) {
 			struct inet_sock *inet2 = inet_sk(sk2);
 
 			if (inet2->num == snum &&
@@ -189,7 +199,7 @@ gotit:
 	}
 	inet->num = snum;
 	if (sk_unhashed(sk)) {
-		struct hlist_head *h = &udp_hash[snum & (UDP_HTABLE_SIZE - 1)];
+		struct hlist_head *h = &udptable[snum & (UDP_HTABLE_SIZE - 1)];
 
 		sk_add_node(sk, h);
 		sock_prot_inc_use(sk->sk_prot);
@@ -202,6 +212,11 @@ fail:
 	return 1;
 }
 
+static __inline__ int udp_v4_get_port(struct sock *sk, unsigned short snum)
+{
+	return	__udp_get_port(sk, snum, udp_hash, &udp_port_rover);
+}
+
 static void udp_v4_hash(struct sock *sk)
 {
 	BUG();
@@ -217,18 +232,24 @@ static void udp_v4_unhash(struct sock *s
 	write_unlock_bh(&udp_hash_lock);
 }
 
-/* UDP is nearly always wildcards out the wazoo, it makes no sense to try
- * harder than this. -DaveM
+/**
+ * 	__udp_lookup  -  find UDP(-Lite) socket
+ *
+ * 	@udptable:   hash list table, must be of UDP_HTABLE_SIZE
+ *
+ * 	UDP nearly always wildcards out the wazoo, it makes no sense to try
+ * 	harder than this. -DaveM
  */
-static struct sock *udp_v4_lookup_longway(u32 saddr, u16 sport,
-					  u32 daddr, u16 dport, int dif)
+struct sock *__udp_lookup(u32 saddr, u16 sport, u32 daddr, u16 dport, int dif,
+			  struct hlist_head udptable[]                        )
 {
 	struct sock *sk, *result = NULL;
 	struct hlist_node *node;
 	unsigned short hnum = ntohs(dport);
 	int badness = -1;
 
-	sk_for_each(sk, node, &udp_hash[hnum & (UDP_HTABLE_SIZE - 1)]) {
+	read_lock(&udp_hash_lock);
+	sk_for_each(sk, node, &udptable[hnum & (UDP_HTABLE_SIZE - 1)]) {
 		struct inet_sock *inet = inet_sk(sk);
 
 		if (inet->num == hnum && !ipv6_only_sock(sk)) {
@@ -262,20 +283,17 @@ static struct sock *udp_v4_lookup_longwa
 			}
 		}
 	}
+	if (result)
+		sock_hold(result);
+	read_unlock(&udp_hash_lock);
+
 	return result;
 }
 
 static __inline__ struct sock *udp_v4_lookup(u32 saddr, u16 sport,
 					     u32 daddr, u16 dport, int dif)
 {
-	struct sock *sk;
-
-	read_lock(&udp_hash_lock);
-	sk = udp_v4_lookup_longway(saddr, sport, daddr, dport, dif);
-	if (sk)
-		sock_hold(sk);
-	read_unlock(&udp_hash_lock);
-	return sk;
+	return __udp_lookup(saddr, sport, daddr, dport, dif, udp_hash);
 }
 
 static inline struct sock *udp_v4_mcast_next(struct sock *sk,
@@ -306,7 +324,11 @@ found:
   	return s;
 }
 
-/*
+/**
+ * 	__udp_err  -  generic UDP/-Lite error routine
+ *
+ * 	@udptable:   hash list table, must be of UDP_HTABLE_SIZE
+ *
  * This routine is called by the ICMP module when it gets some
  * sort of error condition.  If err < 0 then the socket should
  * be closed and the error returned to the user.  If err > 0
@@ -316,8 +338,7 @@ found:
  * header points to the first 8 bytes of the udp header.  We need
  * to find the appropriate port.
  */
-
-void udp_err(struct sk_buff *skb, u32 info)
+void __udp_err(struct sk_buff *skb, u32 info, struct hlist_head udptable[])
 {
 	struct inet_sock *inet;
 	struct iphdr *iph = (struct iphdr*)skb->data;
@@ -328,7 +349,8 @@ void udp_err(struct sk_buff *skb, u32 in
 	int harderr;
 	int err;
 
-	sk = udp_v4_lookup(iph->daddr, uh->dest, iph->saddr, uh->source, skb->dev->ifindex);
+	sk = __udp_lookup(iph->daddr, uh->dest, iph->saddr, uh->source,
+			  skb->dev->ifindex, udptable                   );
 	if (sk == NULL) {
 		ICMP_INC_STATS_BH(ICMP_MIB_INERRORS);
     	  	return;	/* No socket for error */
@@ -382,6 +404,11 @@ out:
 	sock_put(sk);
 }
 
+__inline__ void udp_err(struct sk_buff *skb, u32 info)
+{
+	return __udp_err(skb, info, udp_hash);
+}
+
 /*
  * Throw away all pending data and cancel the corking. Socket is locked.
  */
@@ -396,33 +423,17 @@ static void udp_flush_pending_frames(str
 	}
 }
 
-/*
- * Push out all pending data as one UDP datagram. Socket is locked.
- */
-static int udp_push_pending_frames(struct sock *sk, struct udp_sock *up)
+static void udp_csum_outgoing(struct sock *sk, struct sk_buff *skb,
+			      int totlen, u32 src, u32 dst         )
 {
-	struct inet_sock *inet = inet_sk(sk);
-	struct flowi *fl = &inet->cork.fl;
-	struct sk_buff *skb;
-	struct udphdr *uh;
-	int err = 0;
+	unsigned int csum = 0;
+	struct udphdr *uh = skb->h.uh;
 
-	/* Grab the skbuff where UDP header space exists. */
-	if ((skb = skb_peek(&sk->sk_write_queue)) == NULL)
-		goto out;
-
-	/*
-	 * Create a UDP header
-	 */
-	uh = skb->h.uh;
-	uh->source = fl->fl_ip_sport;
-	uh->dest = fl->fl_ip_dport;
-	uh->len = htons(up->len);
 	uh->check = 0;
 
 	if (sk->sk_no_check == UDP_CSUM_NOXMIT) {
 		skb->ip_summed = CHECKSUM_NONE;
-		goto send;
+		return;
 	}
 
 	if (skb_queue_len(&sk->sk_write_queue) == 1) {
@@ -431,42 +442,95 @@ static int udp_push_pending_frames(struc
 		 */
 		if (skb->ip_summed == CHECKSUM_PARTIAL) {
 			skb->csum = offsetof(struct udphdr, check);
-			uh->check = ~csum_tcpudp_magic(fl->fl4_src, fl->fl4_dst,
-					up->len, IPPROTO_UDP, 0);
+			uh->check = ~csum_tcpudp_magic(src, dst, totlen,
+						       IPPROTO_UDP, 0   );
+			return;
 		} else {
-			skb->csum = csum_partial((char *)uh,
-					sizeof(struct udphdr), skb->csum);
-			uh->check = csum_tcpudp_magic(fl->fl4_src, fl->fl4_dst,
-					up->len, IPPROTO_UDP, skb->csum);
-			if (uh->check == 0)
-				uh->check = -1;
+			csum = csum_partial(skb->h.raw, sizeof(struct udphdr),
+					    skb->csum                        );
 		}
 	} else {
-		unsigned int csum = 0;
 		/*
-		 * HW-checksum won't work as there are two or more 
+		 * HW-checksum won't work as there are two or more
 		 * fragments on the socket so that all csums of sk_buffs
-		 * should be together.
+		 * should be together
 		 */
 		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			int offset = (unsigned char *)uh - skb->data;
+			int offset = skb->h.raw - skb->data;
 			skb->csum = skb_checksum(skb, offset, skb->len - offset, 0);
 
 			skb->ip_summed = CHECKSUM_NONE;
 		} else {
-			skb->csum = csum_partial((char *)uh,
+			skb->csum = csum_partial(skb->h.raw,
 					sizeof(struct udphdr), skb->csum);
 		}
 
 		skb_queue_walk(&sk->sk_write_queue, skb) {
 			csum = csum_add(csum, skb->csum);
 		}
-		uh->check = csum_tcpudp_magic(fl->fl4_src, fl->fl4_dst,
-				up->len, IPPROTO_UDP, csum);
-		if (uh->check == 0)
-			uh->check = -1;
 	}
-send:
+
+	uh->check = csum_tcpudp_magic(src, dst, totlen, IPPROTO_UDP, csum);
+	if (uh->check == 0)
+		uh->check = -1;
+}
+
+/*
+ * Push out all pending data as one UDP/-Lite datagram. Socket is locked.
+ */
+static int udp_push_pending_frames(struct sock *sk, struct udp_sock *up)
+{
+	struct inet_sock *inet = inet_sk(sk);
+	struct flowi *fl = &inet->cork.fl;
+	struct sk_buff *skb;
+	struct udphdr *uh;
+	int err = 0;
+	u16 cscov = up->len;
+
+	/* Grab the skbuff where UDP header space exists. */
+	if ((skb = skb_peek(&sk->sk_write_queue)) == NULL)
+		goto out;
+
+	/*
+	 * Create a UDP header
+	 */
+	uh = skb->h.uh;
+	uh->source = fl->fl_ip_sport;
+	uh->dest = fl->fl_ip_dport;
+	uh->len = htons(up->len);
+
+	/*
+	 * 	If sender has set `partial coverage' socket option on a
+	 * 	UDP-Lite socket, adjust coverage length accordingly.
+	 * 	All other cases default to traditional UDP checksum mode.
+	 */
+	if (up->pcflag & UDPLITE_SEND_CC)    {
+		if (up->pcslen < up->len) {
+			/* up->pcslen == 0 means that full coverage is required,
+			 * partial coverage only if  0 < up->pcslen < up->len */
+			if (0 < up->pcslen) {
+			       cscov = up->pcslen;
+			}
+			uh->len = htons(up->pcslen);
+		}
+		/*
+		 * NOTE: Causes for the error case  `up->pcslen > up->len':
+		 *        (i)  Application error (will not be penalized).
+		 *       (ii)  Payload too big for send buffer: data is split
+		 *             into several packets, each with its own header.
+		 *             In this case (e.g. last segment), coverage may
+		 *             exceed packet length.
+		 *       Since packets with coverage length > packet length are
+		 *       illegal, we fall back to the defaults here.
+		 */
+	}
+
+	if(up->pcflag)
+		udplite_csum_outgoing(sk, skb, up->len, cscov,
+				      fl->fl4_src, fl->fl4_dst);
+	else
+		udp_csum_outgoing(sk, skb, up->len, fl->fl4_src, fl->fl4_dst);
+
 	err = ip_push_pending_frames(sk);
 out:
 	up->len = 0;
@@ -474,12 +538,11 @@ out:
 	return err;
 }
 
-
-static unsigned short udp_check(struct udphdr *uh, int len, unsigned long saddr, unsigned long daddr, unsigned long base)
-{
-	return(csum_tcpudp_magic(saddr, daddr, len, IPPROTO_UDP, base));
-}
-
+/**
+ * 	udp_sendmsg  -  generic UDP/-Lite send routine
+ *
+ * 	This function is udplite-aware and works for both protocols.
+ */
 int udp_sendmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
 		size_t len)
 {
@@ -493,8 +556,9 @@ int udp_sendmsg(struct kiocb *iocb, stru
 	u32 daddr, faddr, saddr;
 	u16 dport;
 	u8  tos;
-	int err;
+	int err, is_udplite = up->pcflag;
 	int corkreq = up->corkflag || msg->msg_flags&MSG_MORE;
+	int (*getfrag)(void *, char *, int, int, int, struct sk_buff *);
 
 	if (len > 0xFFFF)
 		return -EMSGSIZE;
@@ -599,7 +663,7 @@ int udp_sendmsg(struct kiocb *iocb, stru
 					      { .daddr = faddr,
 						.saddr = saddr,
 						.tos = tos } },
-				    .proto = IPPROTO_UDP,
+				    .proto = sk->sk_protocol,
 				    .uli_u = { .ports =
 					       { .sport = inet->sport,
 						 .dport = dport } } };
@@ -645,8 +709,9 @@ back_from_confirm:
 
 do_append_data:
 	up->len += ulen;
-	err = ip_append_data(sk, ip_generic_getfrag, msg->msg_iov, ulen, 
-			sizeof(struct udphdr), &ipc, rt, 
+	getfrag  =  is_udplite?  udplite_getfrag : ip_generic_getfrag;
+	err = ip_append_data(sk, getfrag, msg->msg_iov, ulen,
+			sizeof(struct udphdr), &ipc, rt,
 			corkreq ? msg->msg_flags|MSG_MORE : msg->msg_flags);
 	if (err)
 		udp_flush_pending_frames(sk);
@@ -659,7 +724,7 @@ out:
 	if (free)
 		kfree(ipc.opt);
 	if (!err) {
-		UDP_INC_STATS_USER(UDP_MIB_OUTDATAGRAMS);
+		UDP_INC_STATS_USER(UDP_MIB_OUTDATAGRAMS, is_udplite);
 		return len;
 	}
 	/*
@@ -670,7 +735,7 @@ out:
 	 * seems like overkill.
 	 */
 	if (err == -ENOBUFS || test_bit(SOCK_NOSPACE, &sk->sk_socket->flags)) {
-		UDP_INC_STATS_USER(UDP_MIB_SNDBUFERRORS);
+		UDP_INC_STATS_USER(UDP_MIB_SNDBUFERRORS, is_udplite);
 	}
 	return err;
 
@@ -682,8 +747,13 @@ do_confirm:
 	goto out;
 }
 
-static int udp_sendpage(struct sock *sk, struct page *page, int offset,
-			size_t size, int flags)
+/**
+ * 	udp_sendpage  -  generic UDP/-Lite sendpage routine
+ *
+ * 	This function is udplite-aware and can be used on both sockets.
+ */
+int udp_sendpage(struct sock *sk, struct page *page, int offset,
+		 size_t size, int flags)
 {
 	struct udp_sock *up = udp_sk(sk);
 	int ret;
@@ -731,12 +801,12 @@ out:
 }
 
 /*
- *	IOCTL requests applicable to the UDP protocol
+ *	IOCTL requests applicable to the UDP(-Lite) protocol
  */
- 
+
 int udp_ioctl(struct sock *sk, int cmd, unsigned long arg)
 {
-	switch(cmd) 
+	switch(cmd)
 	{
 		case SIOCOUTQ:
 		{
@@ -770,29 +840,21 @@ int udp_ioctl(struct sock *sk, int cmd, 
 	return(0);
 }
 
-static __inline__ int __udp_checksum_complete(struct sk_buff *skb)
-{
-	return __skb_checksum_complete(skb);
-}
-
-static __inline__ int udp_checksum_complete(struct sk_buff *skb)
-{
-	return skb->ip_summed != CHECKSUM_UNNECESSARY &&
-		__udp_checksum_complete(skb);
-}
 
-/*
- * 	This should be easy, if there is something there we
- * 	return it, otherwise we block.
+/**
+ * 	udp_recvmsg  -  generic UDP/-Lite receive processing
+ *
+ * 	This routine is udplite-aware and works for both protocols.
+ * 	Principle: if there is something there we return it, otherwise we block.
  */
 
-static int udp_recvmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
-		       size_t len, int noblock, int flags, int *addr_len)
+int udp_recvmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
+	        size_t len, int noblock, int flags, int *addr_len)
 {
 	struct inet_sock *inet = inet_sk(sk);
   	struct sockaddr_in *sin = (struct sockaddr_in *)msg->msg_name;
   	struct sk_buff *skb;
-  	int copied, err;
+	int copied, err, copy_only, is_udplite = IS_UDPLITE(sk);
 
 	/*
 	 *	Check any passed addresses
@@ -814,21 +876,30 @@ try_again:
 		msg->msg_flags |= MSG_TRUNC;
 	}
 
-	if (skb->ip_summed==CHECKSUM_UNNECESSARY) {
-		err = skb_copy_datagram_iovec(skb, sizeof(struct udphdr), msg->msg_iov,
-					      copied);
-	} else if (msg->msg_flags&MSG_TRUNC) {
+	/*
+	 * 	Decide whether to checksum and/or copy data.
+	 *
+	 * 	UDP:      checksum may have been computed in HW,
+	 * 	          (re-)compute it if message is truncated.
+	 * 	UDP-Lite: always needs to checksum, no HW support.
+	 */
+	copy_only = (skb->ip_summed == CHECKSUM_UNNECESSARY);
+
+	if (is_udplite  ||  (!copy_only  &&  msg->msg_flags&MSG_TRUNC)) {
 		if (__udp_checksum_complete(skb))
 			goto csum_copy_err;
-		err = skb_copy_datagram_iovec(skb, sizeof(struct udphdr), msg->msg_iov,
-					      copied);
-	} else {
-		err = skb_copy_and_csum_datagram_iovec(skb, sizeof(struct udphdr), msg->msg_iov);
+		copy_only = 1;
+	}
 
+	if (copy_only)
+		err = skb_copy_datagram_iovec(skb, sizeof(struct udphdr),
+					      msg->msg_iov, copied       );
+	else {
+		err = skb_copy_and_csum_datagram_iovec(skb,
+					   sizeof(struct udphdr), msg->msg_iov);
 		if (err == -EINVAL)
 			goto csum_copy_err;
 	}
-
 	if (err)
 		goto out_free;
 
@@ -855,7 +926,8 @@ out:
   	return err;
 
 csum_copy_err:
-	UDP_INC_STATS_BH(UDP_MIB_INERRORS);
+	UDP_DEC_STATS_BH(UDP_MIB_INDATAGRAMS, is_udplite);
+	UDP_INC_STATS_BH(UDP_MIB_INERRORS, is_udplite);
 
 	skb_kill_datagram(sk, skb, flags);
 
@@ -864,7 +936,6 @@ csum_copy_err:
 	goto try_again;
 }
 
-
 int udp_disconnect(struct sock *sk, int flags)
 {
 	struct inet_sock *inet = inet_sk(sk);
@@ -892,8 +963,12 @@ static void udp_close(struct sock *sk, l
 	sk_common_release(sk);
 }
 
-/* return:
- * 	1  if the the UDP system should process it
+/**
+ * 	udp_encap_rcv  -  handle encapsulated packets
+ *
+ * This routine is udplite-aware and works on both sockets.
+ * return:
+ * 	1  if the the UDP(-Lite) system should process it
  *	0  if we should drop this packet
  * 	-1 if it should get processed by xfrm4_rcv_encap
  */
@@ -980,7 +1055,11 @@ #else
 #endif
 }
 
-/* returns:
+/**
+ * 	udp_queue_rcv_skb  -  receive queue processing
+ *
+ * This routine is udplite-aware and works on both sockets.
+ * returns:
  *  -1: error
  *   0: success
  *  >0: "udp encap" protocol resubmission
@@ -988,7 +1067,7 @@ #endif
  * Note that in the success and error cases, the skb is assumed to
  * have either been requeued or freed.
  */
-static int udp_queue_rcv_skb(struct sock * sk, struct sk_buff *skb)
+int udp_queue_rcv_skb(struct sock * sk, struct sk_buff *skb)
 {
 	struct udp_sock *up = udp_sk(sk);
 	int rc;
@@ -996,10 +1075,8 @@ static int udp_queue_rcv_skb(struct sock
 	/*
 	 *	Charge it to the socket, dropping if the queue is full.
 	 */
-	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb)) {
-		kfree_skb(skb);
-		return -1;
-	}
+	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb))
+		goto drop;
 	nf_reset(skb);
 
 	if (up->encap_type) {
@@ -1010,7 +1087,7 @@ static int udp_queue_rcv_skb(struct sock
 		 * If it's an encapsulateed packet, then pass it to the
 		 * IPsec xfrm input and return the response
 		 * appropriately.  Otherwise, just fall through and
-		 * pass this up the UDP socket.
+		 * pass this up the UDP/-Lite socket.
 		 */
 		int ret;
 
@@ -1023,47 +1100,94 @@ static int udp_queue_rcv_skb(struct sock
 		if (ret < 0) {
 			/* process the ESP packet */
 			ret = xfrm4_rcv_encap(skb, up->encap_type);
-			UDP_INC_STATS_BH(UDP_MIB_INDATAGRAMS);
+			UDP_INC_STATS_BH(UDP_MIB_INDATAGRAMS, up->pcflag);
 			return -ret;
 		}
-		/* FALLTHROUGH -- it's a UDP Packet */
+		/* FALLTHROUGH -- it's a UDP/-Lite Packet */
 	}
 
-	if (sk->sk_filter && skb->ip_summed != CHECKSUM_UNNECESSARY) {
-		if (__udp_checksum_complete(skb)) {
-			UDP_INC_STATS_BH(UDP_MIB_INERRORS);
-			kfree_skb(skb);
-			return -1;
+	/*
+	 * 	UDP-Lite specific tests, ignored on UDP sockets
+	 */
+	if ((up->pcflag & UDPLITE_RECV_CC)  &&  UDP_SKB_CB(skb)->partial_cov) {
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
+				UDP_SKB_CB(skb)->cscov, skb->len);
+			goto drop;
+		}
+		/* The next case involves violating the min. coverage requested
+		 * by the receiver. This is subtle: if receiver wants x and x is
+		 * greater than the buffersize/MTU then receiver will complain
+		 * that it wants x while sender emits packets of smaller size y.
+		 * Therefore the above ...()->partial_cov statement is essential.
+		 */
+		if (UDP_SKB_CB(skb)->cscov  <  up->pcrlen) {
+			LIMIT_NETDEBUG(KERN_WARNING
+				"UDPLITE: coverage %d too small, need min %d\n",
+				UDP_SKB_CB(skb)->cscov, up->pcrlen);
+			goto drop;
 		}
+	}
+
+	if (sk->sk_filter && skb->ip_summed != CHECKSUM_UNNECESSARY) {
+		if (__udp_checksum_complete(skb))
+			goto drop;
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	}
 
 	if ((rc = sock_queue_rcv_skb(sk,skb)) < 0) {
 		/* Note that an ENOMEM error is charged twice */
 		if (rc == -ENOMEM)
-			UDP_INC_STATS_BH(UDP_MIB_RCVBUFERRORS);
-		UDP_INC_STATS_BH(UDP_MIB_INERRORS);
-		kfree_skb(skb);
-		return -1;
+			UDP_INC_STATS_BH(UDP_MIB_RCVBUFERRORS, up->pcflag);
+		goto drop;
 	}
-	UDP_INC_STATS_BH(UDP_MIB_INDATAGRAMS);
+
+	/*
+	 * XXX Incrementing this counter when the datagram is later taken off
+	 * the queue due to receive failure is problematic, cf.
+	 * http://bugzilla.kernel.org/show_bug.cgi?id=6660
+	 * This module counts correctly by decrementing InDatagrams whenever
+	 * the datagram is popped off a queue without being actually delivered,
+	 * see udp_recvmsg() and udp_poll().
+	 */
+	UDP_INC_STATS_BH(UDP_MIB_INDATAGRAMS, up->pcflag);
 	return 0;
+
+drop:
+	UDP_INC_STATS_BH(UDP_MIB_INERRORS, up->pcflag);
+	kfree_skb(skb);
+	return -1;
 }
 
-/*
- *	Multicasts and broadcasts go to each listener.
+/**
+ * 	__udp_mcast_deliver  -   generic multicast delivery
  *
+ *	UDP(-Lite) multicasts and broadcasts go to each listener.
  *	Note: called only from the BH handler context,
  *	so we don't need to lock the hashes.
  */
-static int udp_v4_mcast_deliver(struct sk_buff *skb, struct udphdr *uh,
-				 u32 saddr, u32 daddr)
+int __udp_mcast_deliver(struct sk_buff *skb, struct udphdr *uh,
+		        u32 saddr, u32 daddr, struct hlist_head udptable[])
 {
 	struct sock *sk;
 	int dif;
 
 	read_lock(&udp_hash_lock);
-	sk = sk_head(&udp_hash[ntohs(uh->dest) & (UDP_HTABLE_SIZE - 1)]);
+	sk = sk_head(&udptable[ntohs(uh->dest) & (UDP_HTABLE_SIZE - 1)]);
 	dif = skb->dev->ifindex;
 	sk = udp_v4_mcast_next(sk, uh->dest, daddr, uh->source, saddr, dif);
 	if (sk) {
@@ -1092,10 +1216,16 @@ static int udp_v4_mcast_deliver(struct s
 	return 0;
 }
 
-/* Initialize UDP checksum. If exited with zero value (success),
- * CHECKSUM_UNNECESSARY means, that no more checks are required.
- * Otherwise, csum completion requires chacksumming packet body,
- * including udp header and folding it to skb->csum.
+static __inline__ int udp_v4_mcast_deliver(struct sk_buff *skb,
+					struct udphdr *uh, u32 saddr, u32 daddr)
+{
+	return __udp_mcast_deliver(skb, uh, saddr, daddr, udp_hash);
+}
+
+/* Initialize UDP checksum.
+ * CHECKSUM_UNNECESSARY means that no more checks are required.
+ * Otherwise, csum completion requires checksumming packet body,
+ * including udp header, and folding it to skb->csum.
  */
 static void udp_checksum_init(struct sk_buff *skb, struct udphdr *uh,
 			     unsigned short ulen, u32 saddr, u32 daddr)
@@ -1103,7 +1233,7 @@ static void udp_checksum_init(struct sk_
 	if (uh->check == 0) {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	} else if (skb->ip_summed == CHECKSUM_COMPLETE) {
-		if (!udp_check(uh, ulen, saddr, daddr, skb->csum))
+	       if (!csum_tcpudp_magic(saddr,daddr,ulen, IPPROTO_UDP, skb->csum))
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 	}
 	if (skb->ip_summed != CHECKSUM_UNNECESSARY)
@@ -1111,51 +1241,61 @@ static void udp_checksum_init(struct sk_
 	/* Probably, we should checksum udp header (it should be in cache
 	 * in any case) and data in tiny packets (< rx copybreak).
 	 */
+
+	/* UDP = UDP-Lite with a non-partial checksum coverage */
+	UDP_SKB_CB(skb)->partial_cov = 0;
 }
 
 /*
- *	All we need to do is get the socket, and then do a checksum. 
+ *	All we need to do is get the socket, and then do a checksum.
  */
- 
-int udp_rcv(struct sk_buff *skb)
+int __udp_common_rcv(struct sk_buff *skb, int is_udplite)
 {
   	struct sock *sk;
-  	struct udphdr *uh;
+  	struct udphdr *uh = skb->h.uh;
 	unsigned short ulen;
 	struct rtable *rt = (struct rtable*)skb->dst;
 	u32 saddr = skb->nh.iph->saddr;
 	u32 daddr = skb->nh.iph->daddr;
 	int len = skb->len;
+	struct hlist_head *ht = is_udplite? udplite_hash : udp_hash;
 
 	/*
-	 *	Validate the packet and the UDP length.
+	 *  Validate the packet.
 	 */
 	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
-		goto no_header;
-
-	uh = skb->h.uh;
+		goto drop;	          /* No space for header. */
 
 	ulen = ntohs(uh->len);
 
-	if (ulen > len || ulen < sizeof(*uh))
-		goto short_packet;
+	if (! is_udplite) {
+		if (ulen > len || ulen < sizeof(*uh))
+			goto short_packet;
 
-	if (pskb_trim_rcsum(skb, ulen))
-		goto short_packet;
+		if (pskb_trim_rcsum(skb, ulen))
+			goto short_packet;
 
-	udp_checksum_init(skb, uh, ulen, saddr, daddr);
+		udp_checksum_init(skb, uh, ulen, saddr, daddr);
+
+	} else { /* UDP-Lite: we must not trim here */
+		if (len < sizeof(*uh))
+			goto short_packet;
+
+		if (! udplite_checksum_init(skb, uh, len, saddr, daddr))
+			goto csum_error;
+	}
 
 	if(rt->rt_flags & (RTCF_BROADCAST|RTCF_MULTICAST))
-		return udp_v4_mcast_deliver(skb, uh, saddr, daddr);
+		return __udp_mcast_deliver(skb, uh, saddr, daddr, ht);
 
-	sk = udp_v4_lookup(saddr, uh->source, daddr, uh->dest, skb->dev->ifindex);
+	sk = __udp_lookup(saddr, uh->source, daddr, uh->dest, skb->dev->ifindex, ht);
 
 	if (sk != NULL) {
 		int ret = udp_queue_rcv_skb(sk, skb);
 		sock_put(sk);
 
 		/* a return value > 0 means to resubmit the input, but
-		 * it it wants the return to be -protocol, or 0
+		 * it wants the return to be -protocol, or 0
 		 */
 		if (ret > 0)
 			return -ret;
@@ -1170,7 +1310,7 @@ int udp_rcv(struct sk_buff *skb)
 	if (udp_checksum_complete(skb))
 		goto csum_error;
 
-	UDP_INC_STATS_BH(UDP_MIB_NOPORTS);
+	UDP_INC_STATS_BH(UDP_MIB_NOPORTS, is_udplite);
 	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PORT_UNREACH, 0);
 
 	/*
@@ -1181,35 +1321,39 @@ int udp_rcv(struct sk_buff *skb)
 	return(0);
 
 short_packet:
-	LIMIT_NETDEBUG(KERN_DEBUG "UDP: short packet: From %u.%u.%u.%u:%u %d/%d to %u.%u.%u.%u:%u\n",
+	LIMIT_NETDEBUG(KERN_DEBUG "UDP%s: short packet: From %u.%u.%u.%u:%u %d/%d to %u.%u.%u.%u:%u\n",
+		       is_udplite? "-Lite" : "",
 		       NIPQUAD(saddr),
 		       ntohs(uh->source),
 		       ulen,
 		       len,
 		       NIPQUAD(daddr),
 		       ntohs(uh->dest));
-no_header:
-	UDP_INC_STATS_BH(UDP_MIB_INERRORS);
-	kfree_skb(skb);
-	return(0);
+	goto drop;
 
 csum_error:
-	/* 
-	 * RFC1122: OK.  Discards the bad packet silently (as far as 
-	 * the network is concerned, anyway) as per 4.1.3.4 (MUST). 
+	/*
+	 * RFC1122: OK.  Discards the bad packet silently (as far as
+	 * the network is concerned, anyway) as per 4.1.3.4 (MUST).
 	 */
-	LIMIT_NETDEBUG(KERN_DEBUG "UDP: bad checksum. From %d.%d.%d.%d:%d to %d.%d.%d.%d:%d ulen %d\n",
+	LIMIT_NETDEBUG(KERN_DEBUG "UDP%s: bad checksum. From %d.%d.%d.%d:%d to %d.%d.%d.%d:%d ulen %d\n",
+		       is_udplite? "-Lite" : "",
 		       NIPQUAD(saddr),
 		       ntohs(uh->source),
 		       NIPQUAD(daddr),
 		       ntohs(uh->dest),
 		       ulen);
 drop:
-	UDP_INC_STATS_BH(UDP_MIB_INERRORS);
+	UDP_INC_STATS_BH(UDP_MIB_INERRORS, is_udplite);
 	kfree_skb(skb);
 	return(0);
 }
 
+__inline__ int udp_rcv(struct sk_buff *skb)
+{
+	return __udp_common_rcv(skb, 0);
+}
+
 static int udp_destroy_sock(struct sock *sk)
 {
 	lock_sock(sk);
@@ -1219,7 +1363,7 @@ static int udp_destroy_sock(struct sock 
 }
 
 /*
- *	Socket option code for UDP
+ *	Socket option code for UDP and UDP-Lite (shared).
  */
 static int do_udp_setsockopt(struct sock *sk, int level, int optname,
 			  char __user *optval, int optlen)
@@ -1259,6 +1403,32 @@ static int do_udp_setsockopt(struct sock
 		}
 		break;
 
+	/*
+	 * 	UDP-Lite's partial checksum coverage (RFC 3828).
+	 */
+	/* The sender sets actual checksum coverage length via this option.
+	 * The case coverage > packet length is handled by send module. */
+	case UDPLITE_SEND_CSCOV:
+		if (!up->pcflag)         /* Disable the option on UDP sockets */
+			return -ENOPROTOOPT;
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
+		if (!up->pcflag)         /* Disable the option on UDP sockets */
+			return -ENOPROTOOPT;
+		if (val != 0 && val < 8) /* Avoid silly minimal values.       */
+			val = 8;
+		up->pcrlen = val;
+		up->pcflag |= UDPLITE_RECV_CC;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -1267,21 +1437,21 @@ static int do_udp_setsockopt(struct sock
 	return err;
 }
 
-static int udp_setsockopt(struct sock *sk, int level, int optname,
-			  char __user *optval, int optlen)
+int udp_setsockopt(struct sock *sk, int level, int optname,
+		   char __user *optval, int optlen)
 {
-	if (level != SOL_UDP)
-		return ip_setsockopt(sk, level, optname, optval, optlen);
-	return do_udp_setsockopt(sk, level, optname, optval, optlen);
+	if (level == SOL_UDP  ||  level == SOL_UDPLITE)
+		return do_udp_setsockopt(sk, level, optname, optval, optlen);
+	return ip_setsockopt(sk, level, optname, optval, optlen);
 }
 
 #ifdef CONFIG_COMPAT
-static int compat_udp_setsockopt(struct sock *sk, int level, int optname,
-				 char __user *optval, int optlen)
+int compat_udp_setsockopt(struct sock *sk, int level, int optname,
+			  char __user *optval, int optlen)
 {
-	if (level != SOL_UDP)
-		return compat_ip_setsockopt(sk, level, optname, optval, optlen);
-	return do_udp_setsockopt(sk, level, optname, optval, optlen);
+	if (level == SOL_UDP  ||  level == SOL_UDPLITE)
+		return do_udp_setsockopt(sk, level, optname, optval, optlen);
+	return compat_ip_setsockopt(sk, level, optname, optval, optlen);
 }
 #endif
 
@@ -1308,6 +1478,15 @@ static int do_udp_getsockopt(struct sock
 		val = up->encap_type;
 		break;
 
+	/* the following two always return 0 on UDP sockets */
+	case UDPLITE_SEND_CSCOV:
+		val = up->pcslen;
+		break;
+
+	case UDPLITE_RECV_CSCOV:
+		val = up->pcrlen;
+		break;
+
 	default:
 		return -ENOPROTOOPT;
 	};
@@ -1319,25 +1498,26 @@ static int do_udp_getsockopt(struct sock
   	return 0;
 }
 
-static int udp_getsockopt(struct sock *sk, int level, int optname,
-			  char __user *optval, int __user *optlen)
+int udp_getsockopt(struct sock *sk, int level, int optname,
+		   char __user *optval, int __user *optlen )
 {
-	if (level != SOL_UDP)
-		return ip_getsockopt(sk, level, optname, optval, optlen);
-	return do_udp_getsockopt(sk, level, optname, optval, optlen);
+	if (level == SOL_UDP  ||  level == SOL_UDPLITE)
+		return do_udp_getsockopt(sk, level, optname, optval, optlen);
+	return ip_getsockopt(sk, level, optname, optval, optlen);
 }
 
 #ifdef CONFIG_COMPAT
-static int compat_udp_getsockopt(struct sock *sk, int level, int optname,
-				 char __user *optval, int __user *optlen)
+int compat_udp_getsockopt(struct sock *sk, int level, int optname,
+			  char __user *optval, int __user *optlen)
 {
-	if (level != SOL_UDP)
-		return compat_ip_getsockopt(sk, level, optname, optval, optlen);
-	return do_udp_getsockopt(sk, level, optname, optval, optlen);
+	if (level == SOL_UDP  ||  level == SOL_UDPLITE)
+		return do_udp_getsockopt(sk, level, optname, optval, optlen);
+	return compat_ip_getsockopt(sk, level, optname, optval, optlen);
 }
 #endif
+
 /**
- * 	udp_poll - wait for a UDP event.
+ * 	udp_poll  -  wait for a UDP(-Lite) event.
  *	@file - file struct
  *	@sock - socket
  *	@wait - poll table
@@ -1348,11 +1528,14 @@ #endif
  *	then it could get return from select indicating data available
  *	but then block when reading it. Add special case code
  *	to work around these arguably broken applications.
+ *
+ *	The routine is udplite-aware and works for both protocols.
  */
 unsigned int udp_poll(struct file *file, struct socket *sock, poll_table *wait)
 {
 	unsigned int mask = datagram_poll(file, sock, wait);
 	struct sock *sk = sock->sk;
+	int 	is_lite = IS_UDPLITE(sk);
 	
 	/* Check for false positives due to checksum errors */
 	if ( (mask & POLLRDNORM) &&
@@ -1364,7 +1547,11 @@ unsigned int udp_poll(struct file *file,
 		spin_lock_bh(&rcvq->lock);
 		while ((skb = skb_peek(rcvq)) != NULL) {
 			if (udp_checksum_complete(skb)) {
-				UDP_INC_STATS_BH(UDP_MIB_INERRORS);
+				/* The datagram has already been counted as
+				 * InDatagram when earlier it was enqueued.
+				 * Update count of really received datagrams. */
+				UDP_DEC_STATS_BH(UDP_MIB_INDATAGRAMS, is_lite);
+				UDP_INC_STATS_BH(UDP_MIB_INERRORS, is_lite);
 				__skb_unlink(skb, rcvq);
 				kfree_skb(skb);
 			} else {
@@ -1407,6 +1594,31 @@ #ifdef CONFIG_COMPAT
 #endif
 };
 
+struct proto 	udplite_prot = {
+	.name		   = "UDP-Lite",
+	.owner		   = THIS_MODULE,
+	.close		   = udp_close,
+	.connect	   = ip4_datagram_connect,
+	.disconnect	   = udp_disconnect,
+	.ioctl		   = udp_ioctl,
+	.init		   = udplite_sk_init,
+	.destroy	   = udp_destroy_sock,
+	.setsockopt	   = udp_setsockopt,
+	.getsockopt	   = udp_getsockopt,
+	.sendmsg	   = udp_sendmsg,
+	.recvmsg	   = udp_recvmsg,
+	.sendpage	   = udp_sendpage,
+	.backlog_rcv	   = udp_queue_rcv_skb,
+	.hash		   = udp_v4_hash,
+	.unhash		   = udp_v4_unhash,
+	.get_port	   = udplite_v4_get_port,
+	.obj_size	   = sizeof(struct udp_sock),
+#ifdef CONFIG_COMPAT
+	.compat_setsockopt = compat_udp_setsockopt,
+	.compat_getsockopt = compat_udp_getsockopt,
+#endif
+};
+
 /* ------------------------------------------------------------------------ */
 #ifdef CONFIG_PROC_FS
 
@@ -1417,7 +1629,7 @@ static struct sock *udp_get_first(struct
 
 	for (state->bucket = 0; state->bucket < UDP_HTABLE_SIZE; ++state->bucket) {
 		struct hlist_node *node;
-		sk_for_each(sk, node, &udp_hash[state->bucket]) {
+		sk_for_each(sk, node, state->hashtable + state->bucket) {
 			if (sk->sk_family == state->family)
 				goto found;
 		}
@@ -1438,7 +1650,7 @@ try_again:
 	} while (sk && sk->sk_family != state->family);
 
 	if (!sk && ++state->bucket < UDP_HTABLE_SIZE) {
-		sk = sk_head(&udp_hash[state->bucket]);
+		sk = sk_head(state->hashtable + state->bucket);
 		goto try_again;
 	}
 	return sk;
@@ -1488,6 +1700,7 @@ static int udp_seq_open(struct inode *in
 	if (!s)
 		goto out;
 	s->family		= afinfo->family;
+	s->hashtable		= afinfo->hashtable;
 	s->seq_ops.start	= udp_seq_start;
 	s->seq_ops.next		= udp_seq_next;
 	s->seq_ops.show		= afinfo->seq_show;
@@ -1554,7 +1767,7 @@ static void udp4_format_sock(struct sock
 		atomic_read(&sp->sk_refcnt), sp);
 }
 
-static int udp4_seq_show(struct seq_file *seq, void *v)
+int udp4_seq_show(struct seq_file *seq, void *v)
 {
 	if (v == SEQ_START_TOKEN)
 		seq_printf(seq, "%-127s\n",
@@ -1577,6 +1790,7 @@ static struct udp_seq_afinfo udp4_seq_af
 	.owner		= THIS_MODULE,
 	.name		= "udp",
 	.family		= AF_INET,
+	.hashtable	= udp_hash,
 	.seq_show	= udp4_seq_show,
 	.seq_fops	= &udp4_seq_fops,
 };
