Return-Path: <linux-kernel-owner+w=401wt.eu-S932591AbWLMASZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbWLMASZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWLMARx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:17:53 -0500
Received: from cantor2.suse.de ([195.135.220.15]:52836 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932587AbWLMARs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:17:48 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 13 Dec 2006 10:59:32 +1100
Message-Id: <1061212235932.21501@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 011 of 14] knfsd: SUNRPC: Support IPv6 addresses in svc_tcp_accept
References: <20061213105528.21128.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Chuck Lever <chuck.lever@oracle.com>
Modify svc_tcp_accept to support connecting on IPv6 sockets.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: Aurelien Charbon <aurelien.charbon@ext.bull.net>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcsock.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-12-13 10:32:17.000000000 +1100
+++ ./net/sunrpc/svcsock.c	2006-12-13 10:32:19.000000000 +1100
@@ -946,7 +946,8 @@ static inline int svc_port_is_privileged
 static void
 svc_tcp_accept(struct svc_sock *svsk)
 {
-	struct sockaddr_in sin;
+	struct sockaddr_storage addr;
+	struct sockaddr	*sin = (struct sockaddr *) &addr;
 	struct svc_serv	*serv = svsk->sk_server;
 	struct socket	*sock = svsk->sk_sock;
 	struct socket	*newsock;
@@ -973,8 +974,7 @@ svc_tcp_accept(struct svc_sock *svsk)
 	set_bit(SK_CONN, &svsk->sk_flags);
 	svc_sock_enqueue(svsk);
 
-	slen = sizeof(sin);
-	err = kernel_getpeername(newsock, (struct sockaddr *) &sin, &slen);
+	err = kernel_getpeername(newsock, sin, &slen);
 	if (err < 0) {
 		if (net_ratelimit())
 			printk(KERN_WARNING "%s: peername failed (err %d)!\n",
@@ -986,12 +986,11 @@ svc_tcp_accept(struct svc_sock *svsk)
 	 * hosts here, but when we get encryption, the IP of the host won't
 	 * tell us anything.  For now just warn about unpriv connections.
 	 */
-	if (!svc_port_is_privileged((struct sockaddr *) &sin)) {
+	if (!svc_port_is_privileged(sin)) {
 		dprintk(KERN_WARNING
 			"%s: connect from unprivileged port: %s\n",
 			serv->sv_name,
-			__svc_print_addr((struct sockaddr *) &sin, buf,
-								sizeof(buf)));
+			__svc_print_addr(sin, buf, sizeof(buf)));
 	}
 	dprintk("%s: connect from %s\n", serv->sv_name, buf);
 
