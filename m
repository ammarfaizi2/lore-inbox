Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425452AbWLHMCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425452AbWLHMCJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425449AbWLHMCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:02:08 -0500
Received: from ns.suse.de ([195.135.220.2]:40790 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425442AbWLHMB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:01:56 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 23:02:08 +1100
Message-Id: <1061208120208.18172@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 13] knfsd: SUNRPC: Don't set msg_name and msg_namelen when calling sock_recvmsg
References: <20061208225655.17970.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Chuck Lever <chuck.lever@oracle.com>

Clean-up: msg_name and msg_namelen are not used by sock_recvmsg, so
don't bother to set them in svc_recvfrom.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcsock.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-12-08 13:42:26.000000000 +1100
+++ ./net/sunrpc/svcsock.c	2006-12-08 13:43:30.000000000 +1100
@@ -560,21 +560,14 @@ svc_recv_available(struct svc_sock *svsk
 static int
 svc_recvfrom(struct svc_rqst *rqstp, struct kvec *iov, int nr, int buflen)
 {
-	struct msghdr	msg;
-	struct socket	*sock;
-	int		len, alen;
-
-	rqstp->rq_addrlen = sizeof(rqstp->rq_addr);
-	sock = rqstp->rq_sock->sk_sock;
-
-	msg.msg_name    = &rqstp->rq_addr;
-	msg.msg_namelen = sizeof(rqstp->rq_addr);
-	msg.msg_control = NULL;
-	msg.msg_controllen = 0;
-
-	msg.msg_flags	= MSG_DONTWAIT;
+	struct svc_sock	*svsk = rqstp->rq_sock;
+	struct msghdr msg = {
+		.msg_flags	= MSG_DONTWAIT,
+	};
+	int len;
 
-	len = kernel_recvmsg(sock, &msg, iov, nr, buflen, MSG_DONTWAIT);
+	len = kernel_recvmsg(svsk->sk_sock, &msg, iov, nr, buflen,
+				msg.msg_flags);
 
 	/* sock_recvmsg doesn't fill in the name/namelen, so we must..
 	 */
@@ -582,7 +575,7 @@ svc_recvfrom(struct svc_rqst *rqstp, str
 	rqstp->rq_addrlen = svsk->sk_remotelen;
 
 	dprintk("svc: socket %p recvfrom(%p, %Zu) = %d\n",
-		rqstp->rq_sock, iov[0].iov_base, iov[0].iov_len, len);
+		svsk, iov[0].iov_base, iov[0].iov_len, len);
 
 	return len;
 }
