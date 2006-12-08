Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425469AbWLHMFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425469AbWLHMFY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425453AbWLHMCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:02:50 -0500
Received: from cantor2.suse.de ([195.135.220.15]:51655 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425450AbWLHMCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:02:31 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 23:02:40 +1100
Message-Id: <1061208120240.18245@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 010 of 13] knfsd: SUNRPC: add a "generic" function to see if the peer uses a secure port
References: <20061208225655.17970.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Chuck Lever <chuck.lever@oracle.com>

The only reason svcsock.c looks at a sockaddr's port is to check whether
the remote peer is connecting from a privileged port.  Refactor this check
to hide processing that is specific to address format.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: Aurelien Charbon <aurelien.charbon@ext.bull.net>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcsock.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-12-08 13:58:10.000000000 +1100
+++ ./net/sunrpc/svcsock.c	2006-12-08 13:58:41.000000000 +1100
@@ -926,6 +926,20 @@ svc_tcp_data_ready(struct sock *sk, int 
 		wake_up_interruptible(sk->sk_sleep);
 }
 
+static inline int svc_port_is_privileged(struct sockaddr *sin)
+{
+	switch (sin->sa_family) {
+	case AF_INET:
+		return ntohs(((struct sockaddr_in *)sin)->sin_port) < 1024;
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	case AF_INET6:
+		return ntohs(((struct sockaddr_in6 *)sin)->sin6_port) < 1024;
+#endif
+	default:
+		return 0;
+	}
+}
+
 /*
  * Accept a TCP connection
  */
@@ -972,7 +986,7 @@ svc_tcp_accept(struct svc_sock *svsk)
 	 * hosts here, but when we get encryption, the IP of the host won't
 	 * tell us anything.  For now just warn about unpriv connections.
 	 */
-	if (ntohs(sin.sin_port) >= 1024) {
+	if (!svc_port_is_privileged((struct sockaddr *) &sin)) {
 		dprintk(KERN_WARNING
 			"%s: connect from unprivileged port: %s\n",
 			serv->sv_name,
@@ -1313,7 +1327,6 @@ int
 svc_recv(struct svc_rqst *rqstp, long timeout)
 {
 	struct svc_sock		*svsk = NULL;
-	struct sockaddr_in	*sin = (struct sockaddr_in *) &rqstp->rq_addr;
 	struct svc_serv		*serv = rqstp->rq_server;
 	struct svc_pool		*pool = rqstp->rq_pool;
 	int			len, i;
@@ -1408,7 +1421,8 @@ svc_recv(struct svc_rqst *rqstp, long ti
 	svsk->sk_lastrecv = get_seconds();
 	clear_bit(SK_OLD, &svsk->sk_flags);
 
-	rqstp->rq_secure = ntohs(sin->sin_port) < 1024;
+	rqstp->rq_secure =
+		svc_port_is_privileged((struct sockaddr *) &rqstp->rq_addr);
 	rqstp->rq_chandle.defer = svc_defer;
 
 	if (serv->sv_stats)
