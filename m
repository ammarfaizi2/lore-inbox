Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425439AbWLHMCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425439AbWLHMCr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425455AbWLHMCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:02:46 -0500
Received: from cantor.suse.de ([195.135.220.2]:40854 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425443AbWLHMCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:02:41 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 23:02:53 +1100
Message-Id: <1061208120253.18269@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 012 of 13] knfsd: SUNRPC: support IPv6 addresses in RPC server's UDP receive path
References: <20061208225655.17970.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Chuck Lever <chuck.lever@oracle.com>

Add support for IPv6 addresses in the RPC server's UDP receive path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: Aurelien Charbon <aurelien.charbon@ext.bull.net>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcsock.c |   51 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-12-08 13:59:06.000000000 +1100
+++ ./net/sunrpc/svcsock.c	2006-12-08 13:59:22.000000000 +1100
@@ -717,13 +717,53 @@ svc_write_space(struct sock *sk)
 	}
 }
 
+static void svc_udp_get_sender_address(struct svc_rqst *rqstp,
+					struct sk_buff *skb)
+{
+	switch (rqstp->rq_sock->sk_sk->sk_family) {
+	case AF_INET:
+		/* this seems to come from net/ipv4/udp.c:udp_recvmsg */
+		do {
+			struct sockaddr_in *sin =
+				(struct sockaddr_in *) &rqstp->rq_addr;
+
+			sin->sin_family = AF_INET;
+			sin->sin_port = skb->h.uh->source;
+			sin->sin_addr.s_addr = skb->nh.iph->saddr;
+			rqstp->rq_daddr.addr.s_addr = skb->nh.iph->daddr;
+		} while (0);
+		break;
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	case AF_INET6:
+		/* this is derived from net/ipv6/udp.c:udpv6_recvmesg */
+		do {
+			struct sockaddr_in6 *sin6 =
+				(struct sockaddr_in6 *) &rqstp->rq_addr;
+
+			sin6->sin6_family = AF_INET6;
+			sin6->sin6_port = skb->h.uh->source;
+			sin6->sin6_flowinfo = 0;
+			sin6->sin6_scope_id = 0;
+			if (ipv6_addr_type(&sin6->sin6_addr) &
+							IPV6_ADDR_LINKLOCAL)
+				sin6->sin6_scope_id = IP6CB(skb)->iif;
+			ipv6_addr_copy(&sin6->sin6_addr,
+							&skb->nh.ipv6h->saddr);
+			ipv6_addr_copy(&rqstp->rq_daddr.addr6,
+							&skb->nh.ipv6h->saddr);
+		} while (0);
+		break;
+#endif
+	}
+	return;
+}
+
 /*
  * Receive a datagram from a UDP socket.
  */
 static int
 svc_udp_recvfrom(struct svc_rqst *rqstp)
 {
-	struct sockaddr_in *sin = (struct sockaddr_in *) &rqstp->rq_addr;
 	struct svc_sock	*svsk = rqstp->rq_sock;
 	struct svc_serv	*serv = svsk->sk_server;
 	struct sk_buff	*skb;
@@ -775,14 +815,9 @@ svc_udp_recvfrom(struct svc_rqst *rqstp)
 
 	len  = skb->len - sizeof(struct udphdr);
 	rqstp->rq_arg.len = len;
+	rqstp->rq_prot = IPPROTO_UDP;
 
-	rqstp->rq_prot        = IPPROTO_UDP;
-
-	/* Get sender address */
-	sin->sin_family = AF_INET;
-	sin->sin_port = skb->h.uh->source;
-	sin->sin_addr.s_addr = skb->nh.iph->saddr;
-	rqstp->rq_daddr.addr.s_addr = skb->nh.iph->daddr;
+	svc_udp_get_sender_address(rqstp, skb);
 
 	if (skb_is_nonlinear(skb)) {
 		/* we have to copy */
