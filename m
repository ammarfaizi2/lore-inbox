Return-Path: <linux-kernel-owner+w=401wt.eu-S932584AbWLMASW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWLMASW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWLMASD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:18:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:52832 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932590AbWLMARt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:17:49 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 13 Dec 2006 10:59:11 +1100
Message-Id: <1061212235911.21440@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 007 of 14] knfsd: SUNRPC: Provide room in svc_rqst for larger addresses
References: <20061213105528.21128.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Chuck Lever <chuck.lever@oracle.com>
Expand the rq_addr field to allow it to contain larger addresses.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: Aurelien Charbon <aurelien.charbon@ext.bull.net>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/host.c            |    2 +-
 ./fs/lockd/svc4proc.c        |    6 ++++--
 ./fs/lockd/svcproc.c         |    6 ++++--
 ./fs/nfs/callback.c          |    2 +-
 ./fs/nfs/callback_xdr.c      |    4 ++--
 ./fs/nfsd/nfs4state.c        |   18 +++++++++---------
 ./fs/nfsd/nfscache.c         |    2 +-
 ./include/linux/sunrpc/svc.h |   15 ++++++++++++++-
 ./net/sunrpc/svcauth_unix.c  |    3 ++-
 ./net/sunrpc/svcsock.c       |   16 +++++++++-------
 10 files changed, 47 insertions(+), 27 deletions(-)

diff .prev/fs/lockd/host.c ./fs/lockd/host.c
--- .prev/fs/lockd/host.c	2006-12-13 10:28:51.000000000 +1100
+++ ./fs/lockd/host.c	2006-12-13 10:31:37.000000000 +1100
@@ -192,7 +192,7 @@ struct nlm_host *
 nlmsvc_lookup_host(struct svc_rqst *rqstp,
 			const char *hostname, int hostname_len)
 {
-	return nlm_lookup_host(1, &rqstp->rq_addr,
+	return nlm_lookup_host(1, svc_addr_in(rqstp),
 			       rqstp->rq_prot, rqstp->rq_vers,
 			       hostname, hostname_len);
 }

diff .prev/fs/lockd/svc4proc.c ./fs/lockd/svc4proc.c
--- .prev/fs/lockd/svc4proc.c	2006-12-13 10:29:44.000000000 +1100
+++ ./fs/lockd/svc4proc.c	2006-12-13 10:31:37.000000000 +1100
@@ -224,7 +224,7 @@ nlm4svc_proc_granted(struct svc_rqst *rq
 	resp->cookie = argp->cookie;
 
 	dprintk("lockd: GRANTED       called\n");
-	resp->status = nlmclnt_grant(&rqstp->rq_addr, &argp->lock);
+	resp->status = nlmclnt_grant(svc_addr_in(rqstp), &argp->lock);
 	dprintk("lockd: GRANTED       status %d\n", ntohl(resp->status));
 	return rpc_success;
 }
@@ -421,7 +421,9 @@ static __be32
 nlm4svc_proc_sm_notify(struct svc_rqst *rqstp, struct nlm_reboot *argp,
 					      void	        *resp)
 {
-	struct sockaddr_in	saddr = rqstp->rq_addr;
+	struct sockaddr_in	saddr;
+
+	memcpy(&saddr, svc_addr_in(rqstp), sizeof(saddr));
 
 	dprintk("lockd: SM_NOTIFY     called\n");
 	if (saddr.sin_addr.s_addr != htonl(INADDR_LOOPBACK)

diff .prev/fs/lockd/svcproc.c ./fs/lockd/svcproc.c
--- .prev/fs/lockd/svcproc.c	2006-12-13 10:29:21.000000000 +1100
+++ ./fs/lockd/svcproc.c	2006-12-13 10:31:37.000000000 +1100
@@ -253,7 +253,7 @@ nlmsvc_proc_granted(struct svc_rqst *rqs
 	resp->cookie = argp->cookie;
 
 	dprintk("lockd: GRANTED       called\n");
-	resp->status = nlmclnt_grant(&rqstp->rq_addr, &argp->lock);
+	resp->status = nlmclnt_grant(svc_addr_in(rqstp), &argp->lock);
 	dprintk("lockd: GRANTED       status %d\n", ntohl(resp->status));
 	return rpc_success;
 }
@@ -452,7 +452,9 @@ static __be32
 nlmsvc_proc_sm_notify(struct svc_rqst *rqstp, struct nlm_reboot *argp,
 					      void	        *resp)
 {
-	struct sockaddr_in	saddr = rqstp->rq_addr;
+	struct sockaddr_in	saddr;
+
+	memcpy(&saddr, svc_addr_in(rqstp), sizeof(saddr));
 
 	dprintk("lockd: SM_NOTIFY     called\n");
 	if (saddr.sin_addr.s_addr != htonl(INADDR_LOOPBACK)

diff .prev/fs/nfs/callback.c ./fs/nfs/callback.c
--- .prev/fs/nfs/callback.c	2006-12-13 10:29:21.000000000 +1100
+++ ./fs/nfs/callback.c	2006-12-13 10:31:37.000000000 +1100
@@ -166,7 +166,7 @@ void nfs_callback_down(void)
 
 static int nfs_callback_authenticate(struct svc_rqst *rqstp)
 {
-	struct sockaddr_in *addr = &rqstp->rq_addr;
+	struct sockaddr_in *addr = svc_addr_in(rqstp);
 	struct nfs_client *clp;
 	char buf[RPC_MAX_ADDRBUFLEN];
 

diff .prev/fs/nfs/callback_xdr.c ./fs/nfs/callback_xdr.c
--- .prev/fs/nfs/callback_xdr.c	2006-12-13 10:28:51.000000000 +1100
+++ ./fs/nfs/callback_xdr.c	2006-12-13 10:31:37.000000000 +1100
@@ -176,7 +176,7 @@ static __be32 decode_getattr_args(struct
 	status = decode_fh(xdr, &args->fh);
 	if (unlikely(status != 0))
 		goto out;
-	args->addr = &rqstp->rq_addr;
+	args->addr = svc_addr_in(rqstp);
 	status = decode_bitmap(xdr, args->bitmap);
 out:
 	dprintk("%s: exit with status = %d\n", __FUNCTION__, status);
@@ -188,7 +188,7 @@ static __be32 decode_recall_args(struct 
 	__be32 *p;
 	__be32 status;
 
-	args->addr = &rqstp->rq_addr;
+	args->addr = svc_addr_in(rqstp);
 	status = decode_stateid(xdr, &args->stateid);
 	if (unlikely(status != 0))
 		goto out;

diff .prev/fs/nfsd/nfs4state.c ./fs/nfsd/nfs4state.c
--- .prev/fs/nfsd/nfs4state.c	2006-12-13 10:28:51.000000000 +1100
+++ ./fs/nfsd/nfs4state.c	2006-12-13 10:31:37.000000000 +1100
@@ -714,7 +714,7 @@ __be32
 nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		  struct nfsd4_setclientid *setclid)
 {
-	__be32 			ip_addr = rqstp->rq_addr.sin_addr.s_addr;
+	struct sockaddr_in	*sin = svc_addr_in(rqstp);
 	struct xdr_netobj 	clname = { 
 		.len = setclid->se_namelen,
 		.data = setclid->se_name,
@@ -749,7 +749,7 @@ nfsd4_setclientid(struct svc_rqst *rqstp
 		 */
 		status = nfserr_clid_inuse;
 		if (!cmp_creds(&conf->cl_cred, &rqstp->rq_cred)
-				|| conf->cl_addr != ip_addr) {
+				|| conf->cl_addr != sin->sin_addr.s_addr) {
 			printk("NFSD: setclientid: string in use by client"
 			"(clientid %08x/%08x)\n",
 			conf->cl_clientid.cl_boot, conf->cl_clientid.cl_id);
@@ -769,7 +769,7 @@ nfsd4_setclientid(struct svc_rqst *rqstp
 		if (new == NULL)
 			goto out;
 		copy_verf(new, &clverifier);
-		new->cl_addr = ip_addr;
+		new->cl_addr = sin->sin_addr.s_addr;
 		copy_cred(&new->cl_cred,&rqstp->rq_cred);
 		gen_clid(new);
 		gen_confirm(new);
@@ -801,7 +801,7 @@ nfsd4_setclientid(struct svc_rqst *rqstp
 		if (new == NULL)
 			goto out;
 		copy_verf(new,&conf->cl_verifier);
-		new->cl_addr = ip_addr;
+		new->cl_addr = sin->sin_addr.s_addr;
 		copy_cred(&new->cl_cred,&rqstp->rq_cred);
 		copy_clid(new, conf);
 		gen_confirm(new);
@@ -820,7 +820,7 @@ nfsd4_setclientid(struct svc_rqst *rqstp
 		if (new == NULL)
 			goto out;
 		copy_verf(new,&clverifier);
-		new->cl_addr = ip_addr;
+		new->cl_addr = sin->sin_addr.s_addr;
 		copy_cred(&new->cl_cred,&rqstp->rq_cred);
 		gen_clid(new);
 		gen_confirm(new);
@@ -847,7 +847,7 @@ nfsd4_setclientid(struct svc_rqst *rqstp
 		if (new == NULL)
 			goto out;
 		copy_verf(new,&clverifier);
-		new->cl_addr = ip_addr;
+		new->cl_addr = sin->sin_addr.s_addr;
 		copy_cred(&new->cl_cred,&rqstp->rq_cred);
 		gen_clid(new);
 		gen_confirm(new);
@@ -881,7 +881,7 @@ nfsd4_setclientid_confirm(struct svc_rqs
 			 struct nfsd4_compound_state *cstate,
 			 struct nfsd4_setclientid_confirm *setclientid_confirm)
 {
-	__be32 ip_addr = rqstp->rq_addr.sin_addr.s_addr;
+	struct sockaddr_in *sin = svc_addr_in(rqstp);
 	struct nfs4_client *conf, *unconf;
 	nfs4_verifier confirm = setclientid_confirm->sc_confirm; 
 	clientid_t * clid = &setclientid_confirm->sc_clientid;
@@ -900,9 +900,9 @@ nfsd4_setclientid_confirm(struct svc_rqs
 	unconf = find_unconfirmed_client(clid);
 
 	status = nfserr_clid_inuse;
-	if (conf && conf->cl_addr != ip_addr)
+	if (conf && conf->cl_addr != sin->sin_addr.s_addr)
 		goto out;
-	if (unconf && unconf->cl_addr != ip_addr)
+	if (unconf && unconf->cl_addr != sin->sin_addr.s_addr)
 		goto out;
 
 	if ((conf && unconf) && 

diff .prev/fs/nfsd/nfscache.c ./fs/nfsd/nfscache.c
--- .prev/fs/nfsd/nfscache.c	2006-12-13 10:28:51.000000000 +1100
+++ ./fs/nfsd/nfscache.c	2006-12-13 10:31:37.000000000 +1100
@@ -186,7 +186,7 @@ nfsd_cache_lookup(struct svc_rqst *rqstp
 	rp->c_state = RC_INPROG;
 	rp->c_xid = xid;
 	rp->c_proc = proc;
-	rp->c_addr = rqstp->rq_addr;
+	memcpy(&rp->c_addr, svc_addr_in(rqstp), sizeof(rp->c_addr));
 	rp->c_prot = proto;
 	rp->c_vers = vers;
 	rp->c_timestamp = jiffies;

diff .prev/include/linux/sunrpc/svc.h ./include/linux/sunrpc/svc.h
--- .prev/include/linux/sunrpc/svc.h	2006-12-13 10:29:21.000000000 +1100
+++ ./include/linux/sunrpc/svc.h	2006-12-13 10:31:37.000000000 +1100
@@ -197,7 +197,7 @@ struct svc_rqst {
 	struct list_head	rq_list;	/* idle list */
 	struct list_head	rq_all;		/* all threads list */
 	struct svc_sock *	rq_sock;	/* socket */
-	struct sockaddr_in	rq_addr;	/* peer address */
+	struct sockaddr_storage	rq_addr;	/* peer address */
 	int			rq_addrlen;
 
 	struct svc_serv *	rq_server;	/* RPC service definition */
@@ -253,6 +253,19 @@ struct svc_rqst {
 };
 
 /*
+ * Rigorous type checking on sockaddr type conversions
+ */
+static inline struct sockaddr_in *svc_addr_in(struct svc_rqst *rqst)
+{
+	return (struct sockaddr_in *) &rqst->rq_addr;
+}
+
+static inline struct sockaddr *svc_addr(struct svc_rqst *rqst)
+{
+	return (struct sockaddr *) &rqst->rq_addr;
+}
+
+/*
  * Check buffer bounds after decoding arguments
  */
 static inline int

diff .prev/net/sunrpc/svcauth_unix.c ./net/sunrpc/svcauth_unix.c
--- .prev/net/sunrpc/svcauth_unix.c	2006-12-13 10:28:51.000000000 +1100
+++ ./net/sunrpc/svcauth_unix.c	2006-12-13 10:31:37.000000000 +1100
@@ -421,6 +421,7 @@ svcauth_unix_info_release(void *info)
 static int
 svcauth_unix_set_client(struct svc_rqst *rqstp)
 {
+	struct sockaddr_in *sin = svc_addr_in(rqstp);
 	struct ip_map *ipm;
 
 	rqstp->rq_client = NULL;
@@ -430,7 +431,7 @@ svcauth_unix_set_client(struct svc_rqst 
 	ipm = ip_map_cached_get(rqstp);
 	if (ipm == NULL)
 		ipm = ip_map_lookup(rqstp->rq_server->sv_program->pg_class,
-				    rqstp->rq_addr.sin_addr);
+				    sin->sin_addr);
 
 	if (ipm == NULL)
 		return SVC_DENIED;

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-12-13 10:31:31.000000000 +1100
+++ ./net/sunrpc/svcsock.c	2006-12-13 10:31:37.000000000 +1100
@@ -146,7 +146,7 @@ static char *__svc_print_addr(struct soc
  */
 char *svc_print_addr(struct svc_rqst *rqstp, char *buf, size_t len)
 {
-	return __svc_print_addr((struct sockaddr *) &rqstp->rq_addr, buf, len);
+	return __svc_print_addr(svc_addr(rqstp), buf, len);
 }
 EXPORT_SYMBOL_GPL(svc_print_addr);
 
@@ -465,7 +465,7 @@ svc_sendto(struct svc_rqst *rqstp, struc
 		/* set the source and destination */
 		struct msghdr	msg;
 		msg.msg_name    = &rqstp->rq_addr;
-		msg.msg_namelen = sizeof(rqstp->rq_addr);
+		msg.msg_namelen = rqstp->rq_addrlen;
 		msg.msg_iov     = NULL;
 		msg.msg_iovlen  = 0;
 		msg.msg_flags	= MSG_MORE;
@@ -688,6 +688,7 @@ svc_write_space(struct sock *sk)
 static int
 svc_udp_recvfrom(struct svc_rqst *rqstp)
 {
+	struct sockaddr_in *sin = svc_addr_in(rqstp);
 	struct svc_sock	*svsk = rqstp->rq_sock;
 	struct svc_serv	*serv = svsk->sk_server;
 	struct sk_buff	*skb;
@@ -743,9 +744,9 @@ svc_udp_recvfrom(struct svc_rqst *rqstp)
 	rqstp->rq_prot        = IPPROTO_UDP;
 
 	/* Get sender address */
-	rqstp->rq_addr.sin_family = AF_INET;
-	rqstp->rq_addr.sin_port = skb->h.uh->source;
-	rqstp->rq_addr.sin_addr.s_addr = skb->nh.iph->saddr;
+	sin->sin_family = AF_INET;
+	sin->sin_port = skb->h.uh->source;
+	sin->sin_addr.s_addr = skb->nh.iph->saddr;
 	rqstp->rq_daddr = skb->nh.iph->daddr;
 
 	if (skb_is_nonlinear(skb)) {
@@ -1276,7 +1277,8 @@ svc_sock_update_bufs(struct svc_serv *se
 int
 svc_recv(struct svc_rqst *rqstp, long timeout)
 {
-	struct svc_sock		*svsk =NULL;
+	struct svc_sock		*svsk = NULL;
+	struct sockaddr_in	*sin = svc_addr_in(rqstp);
 	struct svc_serv		*serv = rqstp->rq_server;
 	struct svc_pool		*pool = rqstp->rq_pool;
 	int			len, i;
@@ -1371,7 +1373,7 @@ svc_recv(struct svc_rqst *rqstp, long ti
 	svsk->sk_lastrecv = get_seconds();
 	clear_bit(SK_OLD, &svsk->sk_flags);
 
-	rqstp->rq_secure  = ntohs(rqstp->rq_addr.sin_port) < 1024;
+	rqstp->rq_secure = ntohs(sin->sin_port) < 1024;
 	rqstp->rq_chandle.defer = svc_defer;
 
 	if (serv->sv_stats)
