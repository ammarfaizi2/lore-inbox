Return-Path: <linux-kernel-owner+w=401wt.eu-S964797AbWLMAST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWLMAST (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWLMAR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:17:57 -0500
Received: from ns.suse.de ([195.135.220.2]:57800 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964793AbWLMARs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:17:48 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 13 Dec 2006 10:59:17 +1100
Message-Id: <1061212235917.21455@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 008 of 14] knfsd: SUNRPC: Make rq_daddr field address-version independent
References: <20061213105528.21128.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Chuck Lever <chuck.lever@oracle.com>
The rq_daddr field must support larger addresses.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: Aurelien Charbon <aurelien.charbon@ext.bull.net>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/sunrpc/svc.h |   15 +++++++++++----
 ./net/sunrpc/svcsock.c       |    4 ++--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff .prev/include/linux/sunrpc/svc.h ./include/linux/sunrpc/svc.h
--- .prev/include/linux/sunrpc/svc.h	2006-12-13 10:31:37.000000000 +1100
+++ ./include/linux/sunrpc/svc.h	2006-12-13 10:32:10.000000000 +1100
@@ -11,6 +11,7 @@
 #define SUNRPC_SVC_H
 
 #include <linux/in.h>
+#include <linux/in6.h>
 #include <linux/sunrpc/types.h>
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/auth.h>
@@ -188,7 +189,13 @@ static inline void svc_putu32(struct kve
 	iov->iov_len += sizeof(__be32);
 }
 
-	
+union svc_addr_u {
+    struct in_addr	addr;
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+    struct in6_addr	addr6;
+#endif
+};
+
 /*
  * The context of a single thread, including the request currently being
  * processed.
@@ -224,8 +231,8 @@ struct svc_rqst {
 	unsigned short
 				rq_secure  : 1;	/* secure port */
 
-
-	__be32			rq_daddr;	/* dest addr of request - reply from here */
+	union svc_addr_u	rq_daddr;	/* dest addr of request -
+						 * reply from here */
 
 	void *			rq_argp;	/* decoded arguments */
 	void *			rq_resp;	/* xdr'd results */
@@ -305,7 +312,7 @@ struct svc_deferred_req {
 	struct sockaddr_storage	addr;
 	int			addrlen;
 	struct svc_sock		*svsk;	/* where reply must go */
-	__be32			daddr;	/* where reply must come from */
+	union svc_addr_u	daddr;	/* where reply must come from */
 	struct cache_deferred_req handle;
 	int			argslen;
 	__be32			args[0];

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-12-13 10:31:37.000000000 +1100
+++ ./net/sunrpc/svcsock.c	2006-12-13 10:31:39.000000000 +1100
@@ -476,7 +476,7 @@ svc_sendto(struct svc_rqst *rqstp, struc
 		cmh->cmsg_level = SOL_IP;
 		cmh->cmsg_type = IP_PKTINFO;
 		pki->ipi_ifindex = 0;
-		pki->ipi_spec_dst.s_addr = rqstp->rq_daddr;
+		pki->ipi_spec_dst.s_addr = rqstp->rq_daddr.addr.s_addr;
 
 		if (sock_sendmsg(sock, &msg, 0) < 0)
 			goto out;
@@ -747,7 +747,7 @@ svc_udp_recvfrom(struct svc_rqst *rqstp)
 	sin->sin_family = AF_INET;
 	sin->sin_port = skb->h.uh->source;
 	sin->sin_addr.s_addr = skb->nh.iph->saddr;
-	rqstp->rq_daddr = skb->nh.iph->daddr;
+	rqstp->rq_daddr.addr.s_addr = skb->nh.iph->daddr;
 
 	if (skb_is_nonlinear(skb)) {
 		/* we have to copy */
