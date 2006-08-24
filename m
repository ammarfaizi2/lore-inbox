Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWHXGhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWHXGhz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWHXGhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:37:32 -0400
Received: from mx1.suse.de ([195.135.220.2]:37574 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030340AbWHXGhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:37:10 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Aug 2006 16:37:11 +1000
Message-Id: <1060824063711.5008@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 008 of 11] knfsd: Prepare knfsd for support of rsize/wsize of up to 1MB, over TCP.
References: <20060824162917.3600.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The limit over UDP remains at 32K.  Also, make some of
the apparently arbitrary sizing constants clearer.

The biggest change here involves replacing NFSSVC_MAXBLKSIZE
by a function of the rqstp.  This allows it to be different
for different protocols (udp/tcp) and also allows it
to depend on the servers declared sv_bufsiz.

Note that we don't actually increase sv_bufsz for nfs yet.
That comes next.

From: Greg Banks <gnb@melbourne.sgi.com>
Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs3proc.c              |   14 +++++++------
 ./fs/nfsd/nfs3xdr.c               |   13 +++++++-----
 ./fs/nfsd/nfs4xdr.c               |    6 ++---
 ./fs/nfsd/nfsproc.c               |    6 ++---
 ./fs/nfsd/nfsxdr.c                |   10 ++++-----
 ./include/linux/nfsd/const.h      |   15 +++++++++++++-
 ./include/linux/sunrpc/auth.h     |    3 --
 ./include/linux/sunrpc/msg_prot.h |   40 ++++++++++++++++++++++++++++++++++++++
 ./include/linux/sunrpc/svc.h      |   25 +++++++++++++++++++++--
 ./include/linux/sunrpc/xprt.h     |    8 -------
 ./net/sunrpc/svc.c                |   15 ++++++++++++++
 11 files changed, 120 insertions(+), 35 deletions(-)

diff .prev/fs/nfsd/nfs3proc.c ./fs/nfsd/nfs3proc.c
--- .prev/fs/nfsd/nfs3proc.c	2006-08-24 16:25:41.000000000 +1000
+++ ./fs/nfsd/nfs3proc.c	2006-08-24 16:25:56.000000000 +1000
@@ -160,6 +160,7 @@ nfsd3_proc_read(struct svc_rqst *rqstp, 
 				        struct nfsd3_readres  *resp)
 {
 	int	nfserr;
+	u32	max_blocksize = svc_max_payload(rqstp);
 
 	dprintk("nfsd: READ(3) %s %lu bytes at %lu\n",
 				SVCFH_fmt(&argp->fh),
@@ -172,8 +173,8 @@ nfsd3_proc_read(struct svc_rqst *rqstp, 
 	 */
 
 	resp->count = argp->count;
-	if (NFSSVC_MAXBLKSIZE < resp->count)
-		resp->count = NFSSVC_MAXBLKSIZE;
+	if (max_blocksize < resp->count)
+		resp->count = max_blocksize;
 
 	svc_reserve(rqstp, ((1 + NFS3_POST_OP_ATTR_WORDS + 3)<<2) + resp->count +4);
 
@@ -538,15 +539,16 @@ nfsd3_proc_fsinfo(struct svc_rqst * rqst
 					   struct nfsd3_fsinfores *resp)
 {
 	int	nfserr;
+	u32	max_blocksize = svc_max_payload(rqstp);
 
 	dprintk("nfsd: FSINFO(3)   %s\n",
 				SVCFH_fmt(&argp->fh));
 
-	resp->f_rtmax  = NFSSVC_MAXBLKSIZE;
-	resp->f_rtpref = NFSSVC_MAXBLKSIZE;
+	resp->f_rtmax  = max_blocksize;
+	resp->f_rtpref = max_blocksize;
 	resp->f_rtmult = PAGE_SIZE;
-	resp->f_wtmax  = NFSSVC_MAXBLKSIZE;
-	resp->f_wtpref = NFSSVC_MAXBLKSIZE;
+	resp->f_wtmax  = max_blocksize;
+	resp->f_wtpref = max_blocksize;
 	resp->f_wtmult = PAGE_SIZE;
 	resp->f_dtpref = PAGE_SIZE;
 	resp->f_maxfilesize = ~(u32) 0;

diff .prev/fs/nfsd/nfs3xdr.c ./fs/nfsd/nfs3xdr.c
--- .prev/fs/nfsd/nfs3xdr.c	2006-08-24 16:25:41.000000000 +1000
+++ ./fs/nfsd/nfs3xdr.c	2006-08-24 16:25:56.000000000 +1000
@@ -330,6 +330,7 @@ nfs3svc_decode_readargs(struct svc_rqst 
 {
 	unsigned int len;
 	int v,pn;
+	u32 max_blocksize = svc_max_payload(rqstp);
 
 	if (!(p = decode_fh(p, &args->fh))
 	 || !(p = xdr_decode_hyper(p, &args->offset)))
@@ -337,8 +338,8 @@ nfs3svc_decode_readargs(struct svc_rqst 
 
 	len = args->count = ntohl(*p++);
 
-	if (len > NFSSVC_MAXBLKSIZE)
-		len = NFSSVC_MAXBLKSIZE;
+	if (len > max_blocksize)
+		len = max_blocksize;
 
 	/* set up the kvec */
 	v=0;
@@ -358,6 +359,7 @@ nfs3svc_decode_writeargs(struct svc_rqst
 					struct nfsd3_writeargs *args)
 {
 	unsigned int len, v, hdr;
+	u32 max_blocksize = svc_max_payload(rqstp);
 
 	if (!(p = decode_fh(p, &args->fh))
 	 || !(p = xdr_decode_hyper(p, &args->offset)))
@@ -375,8 +377,8 @@ nfs3svc_decode_writeargs(struct svc_rqst
 	rqstp->rq_vec[0].iov_base = (void*)p;
 	rqstp->rq_vec[0].iov_len = rqstp->rq_arg.head[0].iov_len - hdr;
 
-	if (len > NFSSVC_MAXBLKSIZE)
-		len = NFSSVC_MAXBLKSIZE;
+	if (len > max_blocksize)
+		len = max_blocksize;
 	v=  0;
 	while (len > rqstp->rq_vec[v].iov_len) {
 		len -= rqstp->rq_vec[v].iov_len;
@@ -564,6 +566,7 @@ nfs3svc_decode_readdirplusargs(struct sv
 					struct nfsd3_readdirargs *args)
 {
 	int len, pn;
+	u32 max_blocksize = svc_max_payload(rqstp);
 
 	if (!(p = decode_fh(p, &args->fh)))
 		return 0;
@@ -572,7 +575,7 @@ nfs3svc_decode_readdirplusargs(struct sv
 	args->dircount = ntohl(*p++);
 	args->count    = ntohl(*p++);
 
-	len = (args->count > NFSSVC_MAXBLKSIZE) ? NFSSVC_MAXBLKSIZE :
+	len = (args->count > max_blocksize) ? max_blocksize :
 						  args->count;
 	args->count = len;
 

diff .prev/fs/nfsd/nfs4xdr.c ./fs/nfsd/nfs4xdr.c
--- .prev/fs/nfsd/nfs4xdr.c	2006-08-24 16:25:41.000000000 +1000
+++ ./fs/nfsd/nfs4xdr.c	2006-08-24 16:25:56.000000000 +1000
@@ -1537,12 +1537,12 @@ out_acl:
 	if (bmval0 & FATTR4_WORD0_MAXREAD) {
 		if ((buflen -= 8) < 0)
 			goto out_resource;
-		WRITE64((u64) NFSSVC_MAXBLKSIZE);
+		WRITE64((u64) svc_max_payload(rqstp));
 	}
 	if (bmval0 & FATTR4_WORD0_MAXWRITE) {
 		if ((buflen -= 8) < 0)
 			goto out_resource;
-		WRITE64((u64) NFSSVC_MAXBLKSIZE);
+		WRITE64((u64) svc_max_payload(rqstp));
 	}
 	if (bmval1 & FATTR4_WORD1_MODE) {
 		if ((buflen -= 4) < 0)
@@ -2056,7 +2056,7 @@ nfsd4_encode_read(struct nfsd4_compoundr
 
 	RESERVE_SPACE(8); /* eof flag and byte count */
 
-	maxcount = NFSSVC_MAXBLKSIZE;
+	maxcount = svc_max_payload(resp->rqstp);
 	if (maxcount > read->rd_length)
 		maxcount = read->rd_length;
 

diff .prev/fs/nfsd/nfsproc.c ./fs/nfsd/nfsproc.c
--- .prev/fs/nfsd/nfsproc.c	2006-08-24 16:25:41.000000000 +1000
+++ ./fs/nfsd/nfsproc.c	2006-08-24 16:25:56.000000000 +1000
@@ -146,13 +146,13 @@ nfsd_proc_read(struct svc_rqst *rqstp, s
 	 * status, 17 words for fattr, and 1 word for the byte count.
 	 */
 
-	if (NFSSVC_MAXBLKSIZE < argp->count) {
+	if (NFSSVC_MAXBLKSIZE_V2 < argp->count) {
 		printk(KERN_NOTICE
 			"oversized read request from %u.%u.%u.%u:%d (%d bytes)\n",
 				NIPQUAD(rqstp->rq_addr.sin_addr.s_addr),
 				ntohs(rqstp->rq_addr.sin_port),
 				argp->count);
-		argp->count = NFSSVC_MAXBLKSIZE;
+		argp->count = NFSSVC_MAXBLKSIZE_V2;
 	}
 	svc_reserve(rqstp, (19<<2) + argp->count + 4);
 
@@ -553,7 +553,7 @@ static struct svc_procedure		nfsd_proced
   PROC(none,	 void,		void,		none,		RC_NOCACHE, ST),
   PROC(lookup,	 diropargs,	diropres,	fhandle,	RC_NOCACHE, ST+FH+AT),
   PROC(readlink, readlinkargs,	readlinkres,	none,		RC_NOCACHE, ST+1+NFS_MAXPATHLEN/4),
-  PROC(read,	 readargs,	readres,	fhandle,	RC_NOCACHE, ST+AT+1+NFSSVC_MAXBLKSIZE/4),
+  PROC(read,	 readargs,	readres,	fhandle,	RC_NOCACHE, ST+AT+1+NFSSVC_MAXBLKSIZE_V2/4),
   PROC(none,	 void,		void,		none,		RC_NOCACHE, ST),
   PROC(write,	 writeargs,	attrstat,	fhandle,	RC_REPLBUFF, ST+AT),
   PROC(create,	 createargs,	diropres,	fhandle,	RC_REPLBUFF, ST+FH+AT),

diff .prev/fs/nfsd/nfsxdr.c ./fs/nfsd/nfsxdr.c
--- .prev/fs/nfsd/nfsxdr.c	2006-08-24 16:25:41.000000000 +1000
+++ ./fs/nfsd/nfsxdr.c	2006-08-24 16:25:56.000000000 +1000
@@ -254,8 +254,8 @@ nfssvc_decode_readargs(struct svc_rqst *
 	len = args->count     = ntohl(*p++);
 	p++; /* totalcount - unused */
 
-	if (len > NFSSVC_MAXBLKSIZE)
-		len = NFSSVC_MAXBLKSIZE;
+	if (len > NFSSVC_MAXBLKSIZE_V2)
+		len = NFSSVC_MAXBLKSIZE_V2;
 
 	/* set up somewhere to store response.
 	 * We take pages, put them on reslist and include in iovec
@@ -288,8 +288,8 @@ nfssvc_decode_writeargs(struct svc_rqst 
 	rqstp->rq_vec[0].iov_base = (void*)p;
 	rqstp->rq_vec[0].iov_len = rqstp->rq_arg.head[0].iov_len -
 				(((void*)p) - rqstp->rq_arg.head[0].iov_base);
-	if (len > NFSSVC_MAXBLKSIZE)
-		len = NFSSVC_MAXBLKSIZE;
+	if (len > NFSSVC_MAXBLKSIZE_V2)
+		len = NFSSVC_MAXBLKSIZE_V2;
 	v = 0;
 	while (len > rqstp->rq_vec[v].iov_len) {
 		len -= rqstp->rq_vec[v].iov_len;
@@ -458,7 +458,7 @@ nfssvc_encode_statfsres(struct svc_rqst 
 {
 	struct kstatfs	*stat = &resp->stats;
 
-	*p++ = htonl(NFSSVC_MAXBLKSIZE);	/* max transfer size */
+	*p++ = htonl(NFSSVC_MAXBLKSIZE_V2);	/* max transfer size */
 	*p++ = htonl(stat->f_bsize);
 	*p++ = htonl(stat->f_blocks);
 	*p++ = htonl(stat->f_bfree);

diff .prev/include/linux/nfsd/const.h ./include/linux/nfsd/const.h
--- .prev/include/linux/nfsd/const.h	2006-08-24 16:25:56.000000000 +1000
+++ ./include/linux/nfsd/const.h	2006-08-24 16:25:56.000000000 +1000
@@ -13,6 +13,7 @@
 #include <linux/nfs2.h>
 #include <linux/nfs3.h>
 #include <linux/nfs4.h>
+#include <linux/sunrpc/msg_prot.h>
 
 /*
  * Maximum protocol version supported by knfsd
@@ -23,6 +24,8 @@
  * Maximum blocksize supported by daemon currently at 32K
  */
 #define NFSSVC_MAXBLKSIZE	(32*1024)
+/* NFSv2 is limited by the protocol specification, see RFC 1094 */
+#define NFSSVC_MAXBLKSIZE_V2	(8*1024)
 
 #ifdef __KERNEL__
 
@@ -30,7 +33,17 @@
 # define NFS_SUPER_MAGIC	0x6969
 #endif
 
-#define NFSD_BUFSIZE		(1024 + NFSSVC_MAXBLKSIZE)
+/*
+ * Largest number of bytes we need to allocate for an NFS
+ * call or reply.  Used to control buffer sizes.  We use
+ * the length of v3 WRITE, READDIR and READDIR replies
+ * which are an RPC header, up to 26 XDR units of reply
+ * data, and some page data.
+ *
+ * Note that accuracy here doesn't matter too much as the
+ * size is rounded up to a page size when allocating space.
+ */
+#define NFSD_BUFSIZE		((RPC_MAX_HEADER_WITH_AUTH+26)*XDR_UNIT + NFSSVC_MAXBLKSIZE)
 
 #ifdef CONFIG_NFSD_V4
 # define NFSSVC_XDRSIZE		NFS4_SVC_XDRSIZE

diff .prev/include/linux/sunrpc/auth.h ./include/linux/sunrpc/auth.h
--- .prev/include/linux/sunrpc/auth.h	2006-08-24 16:25:56.000000000 +1000
+++ ./include/linux/sunrpc/auth.h	2006-08-24 16:25:56.000000000 +1000
@@ -20,9 +20,6 @@
 /* size of the nodename buffer */
 #define UNX_MAXNODENAME	32
 
-/* Maximum size (in bytes) of an rpc credential or verifier */
-#define RPC_MAX_AUTH_SIZE (400)
-
 /* Work around the lack of a VFS credential */
 struct auth_cred {
 	uid_t	uid;

diff .prev/include/linux/sunrpc/msg_prot.h ./include/linux/sunrpc/msg_prot.h
--- .prev/include/linux/sunrpc/msg_prot.h	2006-08-24 16:25:56.000000000 +1000
+++ ./include/linux/sunrpc/msg_prot.h	2006-08-24 16:25:56.000000000 +1000
@@ -11,6 +11,9 @@
 
 #define RPC_VERSION 2
 
+/* size of an XDR encoding unit in bytes, i.e. 32bit */
+#define XDR_UNIT	(4)
+
 /* spec defines authentication flavor as an unsigned 32 bit integer */
 typedef u32	rpc_authflavor_t;
 
@@ -34,6 +37,9 @@ enum rpc_auth_flavors {
 	RPC_AUTH_GSS_SPKMP = 390011,
 };
 
+/* Maximum size (in bytes) of an rpc credential or verifier */
+#define RPC_MAX_AUTH_SIZE (400)
+
 enum rpc_msg_type {
 	RPC_CALL = 0,
 	RPC_REPLY = 1
@@ -101,5 +107,39 @@ typedef u32	rpc_fraghdr;
 #define	RPC_FRAGMENT_SIZE_MASK		(~RPC_LAST_STREAM_FRAGMENT)
 #define	RPC_MAX_FRAGMENT_SIZE		((1U << 31) - 1)
 
+/*
+ * RPC call and reply header size as number of 32bit words (verifier
+ * size computed separately, see below)
+ */
+#define RPC_CALLHDRSIZE		(6)
+#define RPC_REPHDRSIZE		(4)
+
+
+/*
+ * Maximum RPC header size, including authentication,
+ * as number of 32bit words (see RFCs 1831, 1832).
+ *
+ *	xid			    1 xdr unit = 4 bytes
+ *	mtype			    1
+ *	rpc_version		    1
+ *	program			    1
+ *	prog_version		    1
+ *	procedure		    1
+ *	cred {
+ *	    flavor		    1
+ *	    length		    1
+ *	    body<RPC_MAX_AUTH_SIZE> 100 xdr units = 400 bytes
+ *	}
+ *	verf {
+ *	    flavor		    1
+ *	    length		    1
+ *	    body<RPC_MAX_AUTH_SIZE> 100 xdr units = 400 bytes
+ *	}
+ *	TOTAL			    210 xdr units = 840 bytes
+ */
+#define RPC_MAX_HEADER_WITH_AUTH \
+	(RPC_CALLHDRSIZE + 2*(2+RPC_MAX_AUTH_SIZE/4))
+
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_SUNRPC_MSGPROT_H_ */

diff .prev/include/linux/sunrpc/svc.h ./include/linux/sunrpc/svc.h
--- .prev/include/linux/sunrpc/svc.h	2006-08-24 16:25:41.000000000 +1000
+++ ./include/linux/sunrpc/svc.h	2006-08-24 16:25:56.000000000 +1000
@@ -13,6 +13,7 @@
 #include <linux/in.h>
 #include <linux/sunrpc/types.h>
 #include <linux/sunrpc/xdr.h>
+#include <linux/sunrpc/auth.h>
 #include <linux/sunrpc/svcauth.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
@@ -95,8 +96,28 @@ static inline void svc_get(struct svc_se
  * Maximum payload size supported by a kernel RPC server.
  * This is use to determine the max number of pages nfsd is
  * willing to return in a single READ operation.
- */
-#define RPCSVC_MAXPAYLOAD	(64*1024u)
+ *
+ * These happen to all be powers of 2, which is not strictly
+ * necessary but helps enforce the real limitation, which is
+ * that they should be multiples of PAGE_CACHE_SIZE.
+ *
+ * For UDP transports, a block plus NFS,RPC, and UDP headers
+ * has to fit into the IP datagram limit of 64K.  The largest
+ * feasible number for all known page sizes is probably 48K,
+ * but we choose 32K here.  This is the same as the historical
+ * Linux limit; someone who cares more about NFS/UDP performance
+ * can test a larger number.
+ *
+ * For TCP transports we have more freedom.  A size of 1MB is
+ * chosen to match the client limit.  Other OSes are known to
+ * have larger limits, but those numbers are probably beyond
+ * the point of diminishing returns.
+ */
+#define RPCSVC_MAXPAYLOAD	(1*1024*1024u)
+#define RPCSVC_MAXPAYLOAD_TCP	RPCSVC_MAXPAYLOAD
+#define RPCSVC_MAXPAYLOAD_UDP	(32*1024u)
+
+extern u32 svc_max_payload(const struct svc_rqst *rqstp);
 
 /*
  * RPC Requsts and replies are stored in one or more pages.

diff .prev/include/linux/sunrpc/xprt.h ./include/linux/sunrpc/xprt.h
--- .prev/include/linux/sunrpc/xprt.h	2006-08-24 16:25:56.000000000 +1000
+++ ./include/linux/sunrpc/xprt.h	2006-08-24 16:25:56.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/in.h>
 #include <linux/sunrpc/sched.h>
 #include <linux/sunrpc/xdr.h>
+#include <linux/sunrpc/msg_prot.h>
 
 extern unsigned int xprt_udp_slot_table_entries;
 extern unsigned int xprt_tcp_slot_table_entries;
@@ -23,13 +24,6 @@ extern unsigned int xprt_tcp_slot_table_
 #define RPC_MAX_SLOT_TABLE	(128U)
 
 /*
- * RPC call and reply header size as number of 32bit words (verifier
- * size computed separately)
- */
-#define RPC_CALLHDRSIZE		6
-#define RPC_REPHDRSIZE		4
-
-/*
  * Parameters for choosing a free port
  */
 extern unsigned int xprt_min_resvport;

diff .prev/net/sunrpc/svc.c ./net/sunrpc/svc.c
--- .prev/net/sunrpc/svc.c	2006-08-24 16:25:13.000000000 +1000
+++ ./net/sunrpc/svc.c	2006-08-24 16:25:56.000000000 +1000
@@ -919,3 +919,18 @@ err_bad:
 	svc_putu32(resv, rpc_stat);
 	goto sendit;
 }
+
+/*
+ * Return (transport-specific) limit on the rpc payload.
+ */
+u32 svc_max_payload(const struct svc_rqst *rqstp)
+{
+	int max = RPCSVC_MAXPAYLOAD_TCP;
+
+	if (rqstp->rq_sock->sk_sock->type == SOCK_DGRAM)
+		max = RPCSVC_MAXPAYLOAD_UDP;
+	if (rqstp->rq_server->sv_bufsz < max)
+		max = rqstp->rq_server->sv_bufsz;
+	return max;
+}
+EXPORT_SYMBOL_GPL(svc_max_payload);
