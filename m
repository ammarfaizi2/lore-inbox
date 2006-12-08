Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425437AbWLHMDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425437AbWLHMDU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425448AbWLHMC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:02:59 -0500
Received: from cantor.suse.de ([195.135.220.2]:40863 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425443AbWLHMCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:02:46 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 23:02:58 +1100
Message-Id: <1061208120258.18281@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 013 of 13] knfsd: SUNRPC: fix up svc_create_socket() to take a sockaddr struct + length
References: <20061208225655.17970.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Chuck Lever <chuck.lever@oracle.com>

Replace existing svc_create_socket() API to allow callers to pass addresses
larger than a sockaddr_in.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: Aurelien Charbon <aurelien.charbon@ext.bull.net>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcsock.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-12-08 13:59:22.000000000 +1100
+++ ./net/sunrpc/svcsock.c	2006-12-08 14:00:31.000000000 +1100
@@ -1680,7 +1680,7 @@ EXPORT_SYMBOL_GPL(svc_addsock);
  * Create socket for RPC service.
  */
 static int svc_create_socket(struct svc_serv *serv, int protocol,
-				struct sockaddr_in *sin, int flags)
+				struct sockaddr *sin, int len, int flags)
 {
 	struct svc_sock	*svsk;
 	struct socket	*sock;
@@ -1690,8 +1690,7 @@ static int svc_create_socket(struct svc_
 
 	dprintk("svc: svc_create_socket(%s, %d, %s)\n",
 			serv->sv_program->pg_name, protocol,
-			__svc_print_addr((struct sockaddr *) sin, buf,
-								sizeof(buf)));
+			__svc_print_addr(sin, buf, sizeof(buf)));
 
 	if (protocol != IPPROTO_UDP && protocol != IPPROTO_TCP) {
 		printk(KERN_WARNING "svc: only UDP and TCP "
@@ -1700,15 +1699,15 @@ static int svc_create_socket(struct svc_
 	}
 	type = (protocol == IPPROTO_UDP)? SOCK_DGRAM : SOCK_STREAM;
 
-	if ((error = sock_create_kern(PF_INET, type, protocol, &sock)) < 0)
+	error = sock_create_kern(sin->sa_family, type, protocol, &sock);
+	if (error < 0)
 		return error;
 
 	svc_reclassify_socket(sock);
 
 	if (type == SOCK_STREAM)
-		sock->sk->sk_reuse = 1; /* allow address reuse */
-	error = kernel_bind(sock, (struct sockaddr *) sin,
-					sizeof(*sin));
+		sock->sk->sk_reuse = 1;		/* allow address reuse */
+	error = kernel_bind(sock, sin, len);
 	if (error < 0)
 		goto bummer;
 
@@ -1786,7 +1785,8 @@ int svc_makesock(struct svc_serv *serv, 
 	};
 
 	dprintk("svc: creating socket proto = %d\n", protocol);
-	return svc_create_socket(serv, protocol, &sin, flags);
+	return svc_create_socket(serv, protocol, (struct sockaddr *) &sin,
+							sizeof(sin), flags);
 }
 
 /*
