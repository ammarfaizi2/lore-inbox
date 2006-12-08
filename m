Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425443AbWLHMDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425443AbWLHMDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425447AbWLHMCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:02:54 -0500
Received: from ns.suse.de ([195.135.220.2]:40823 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425448AbWLHMCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:02:24 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 23:02:35 +1100
Message-Id: <1061208120235.18233@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 009 of 13] knfsd: SUNRPC: teach svc_sendto() to deal with IPv6 addresses
References: <20061208225655.17970.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Chuck Lever <chuck.lever@oracle.com>

CMSG_DATA comes in different sizes, depending on address family.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: Aurelien Charbon <aurelien.charbon@ext.bull.net>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcsock.c |   69 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 17 deletions(-)

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-12-08 13:57:20.000000000 +1100
+++ ./net/sunrpc/svcsock.c	2006-12-08 13:58:10.000000000 +1100
@@ -36,6 +36,7 @@
 #include <net/sock.h>
 #include <net/checksum.h>
 #include <net/ip.h>
+#include <net/ipv6.h>
 #include <net/tcp_states.h>
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
@@ -438,6 +439,47 @@ svc_wake_up(struct svc_serv *serv)
 	}
 }
 
+union svc_pktinfo_u {
+	struct in_pktinfo pkti;
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	struct in6_pktinfo pkti6;
+#endif
+};
+
+static void svc_set_cmsg_data(struct svc_rqst *rqstp, struct cmsghdr *cmh)
+{
+	switch (rqstp->rq_sock->sk_sk->sk_family) {
+	case AF_INET:
+		do {
+			struct in_pktinfo *pki =
+					(struct in_pktinfo *) CMSG_DATA(cmh);
+
+			cmh->cmsg_level = SOL_IP;
+			cmh->cmsg_type = IP_PKTINFO;
+			pki->ipi_ifindex = 0;
+			pki->ipi_spec_dst.s_addr = rqstp->rq_daddr.addr.s_addr;
+			cmh->cmsg_len = CMSG_LEN(sizeof(*pki));
+		} while (0);
+		break;
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	case AF_INET6:
+		do {
+			struct in6_pktinfo *pki =
+					(struct in6_pktinfo *) CMSG_DATA(cmh);
+
+			cmh->cmsg_level = SOL_IPV6;
+			cmh->cmsg_type = IPV6_PKTINFO;
+			pki->ipi6_ifindex = 0;
+			ipv6_addr_copy(&pki->ipi6_addr,
+					&rqstp->rq_daddr.addr6);
+			cmh->cmsg_len = CMSG_LEN(sizeof(*pki));
+		} while (0);
+		break;
+#endif
+	}
+	return;
+}
+
 /*
  * Generic sendto routine
  */
@@ -447,9 +489,8 @@ svc_sendto(struct svc_rqst *rqstp, struc
 	struct svc_sock	*svsk = rqstp->rq_sock;
 	struct socket	*sock = svsk->sk_sock;
 	int		slen;
-	char 		buffer[CMSG_SPACE(sizeof(struct in_pktinfo))];
+	char 		buffer[CMSG_SPACE(sizeof(union svc_pktinfo_u))];
 	struct cmsghdr *cmh = (struct cmsghdr *)buffer;
-	struct in_pktinfo *pki = (struct in_pktinfo *)CMSG_DATA(cmh);
 	int		len = 0;
 	int		result;
 	int		size;
@@ -462,21 +503,15 @@ svc_sendto(struct svc_rqst *rqstp, struc
 	slen = xdr->len;
 
 	if (rqstp->rq_prot == IPPROTO_UDP) {
-		/* set the source and destination */
-		struct msghdr	msg;
-		msg.msg_name    = &rqstp->rq_addr;
-		msg.msg_namelen = rqstp->rq_addrlen;
-		msg.msg_iov     = NULL;
-		msg.msg_iovlen  = 0;
-		msg.msg_flags	= MSG_MORE;
-
-		msg.msg_control = cmh;
-		msg.msg_controllen = sizeof(buffer);
-		cmh->cmsg_len = CMSG_LEN(sizeof(*pki));
-		cmh->cmsg_level = SOL_IP;
-		cmh->cmsg_type = IP_PKTINFO;
-		pki->ipi_ifindex = 0;
-		pki->ipi_spec_dst.s_addr = rqstp->rq_daddr.addr.s_addr;
+		struct msghdr msg = {
+			.msg_name	= &rqstp->rq_addr,
+			.msg_namelen	= rqstp->rq_addrlen,
+			.msg_control	= cmh,
+			.msg_controllen	= sizeof(buffer),
+			.msg_flags	= MSG_MORE,
+		};
+
+		svc_set_cmsg_data(rqstp, cmh);
 
 		if (sock_sendmsg(sock, &msg, 0) < 0)
 			goto out;
