Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbULLVX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbULLVX6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 16:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbULLVX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 16:23:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8199 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262140AbULLVTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 16:19:18 -0500
Date: Sun, 12 Dec 2004 22:19:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/sunrpc/: some cleanups
Message-ID: <20041212211907.GZ22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following cleanups:
- make some needlessly global code static
- remove the following unused global functions:
  - net/sunrpc/auth_gss/gss_generic_token.c: g_get_mech_oid
  - net/sunrpc/cache.c: cache_find
  - net/sunrpc/cache.c: cache_drop
  - net/sunrpc/xdr.c: xdr_decode_netobj_fixed
  - net/sunrpc/xdr.c: xdr_shift_iovec
  - net/sunrpc/xdr.c: xdr_kmap
  - net/sunrpc/xdr.c: xdr_kunmap
- remove the following unused global structs:
  - net/sunrpc/auth_gss/gss_krb5_mech.c: gss_mech_krb5_oid
  - net/sunrpc/auth_gss/gss_spkm3_mech.c: gss_mech_spkm3_oid
  - net/sunrpc/rpc_pipe.c: rpc_pipe_iops
- remove the EXPORT_SYMBOL(cache_clean)

Please review this patch.


diffstat output:
 include/linux/sunrpc/auth.h             |    2 
 include/linux/sunrpc/cache.h            |    5 
 include/linux/sunrpc/gss_asn1.h         |    2 
 include/linux/sunrpc/sched.h            |    1 
 include/linux/sunrpc/xdr.h              |    6 -
 include/linux/sunrpc/xprt.h             |    3 
 net/sunrpc/auth.c                       |    2 
 net/sunrpc/auth_gss/auth_gss.c          |    2 
 net/sunrpc/auth_gss/gss_generic_token.c |   35 ------
 net/sunrpc/auth_gss/gss_krb5_crypto.c   |    2 
 net/sunrpc/auth_gss/gss_krb5_mech.c     |    3 
 net/sunrpc/auth_gss/gss_spkm3_mech.c    |    9 -
 net/sunrpc/auth_gss/svcauth_gss.c       |    4 
 net/sunrpc/cache.c                      |   41 +------
 net/sunrpc/pmap_clnt.c                  |    4 
 net/sunrpc/rpc_pipe.c                   |    9 -
 net/sunrpc/sched.c                      |    5 
 net/sunrpc/sunrpc_syms.c                |    1 
 net/sunrpc/svcauth.c                    |    3 
 net/sunrpc/svcauth_unix.c               |    6 -
 net/sunrpc/xdr.c                        |  133 ------------------------
 net/sunrpc/xprt.c                       |    8 -
 22 files changed, 38 insertions(+), 248 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/linux/sunrpc/auth.h.old	2004-12-12 19:05:25.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/sunrpc/auth.h	2004-12-12 19:05:34.000000000 +0100
@@ -114,8 +114,6 @@
 extern struct rpc_authops	authdes_ops;
 #endif
 
-u32			pseudoflavor_to_flavor(rpc_authflavor_t);
-
 int			rpcauth_register(struct rpc_authops *);
 int			rpcauth_unregister(struct rpc_authops *);
 struct rpc_auth *	rpcauth_create(rpc_authflavor_t, struct rpc_clnt *);
--- linux-2.6.10-rc2-mm4-full/net/sunrpc/auth.c.old	2004-12-12 19:05:41.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/sunrpc/auth.c	2004-12-12 19:05:55.000000000 +0100
@@ -25,7 +25,7 @@
 	NULL,			/* others can be loadable modules */
 };
 
-u32
+static u32
 pseudoflavor_to_flavor(u32 flavor) {
 	if (flavor >= RPC_AUTH_MAXFLAVOR)
 		return RPC_AUTH_GSS;
--- linux-2.6.10-rc2-mm4-full/net/sunrpc/auth_gss/auth_gss.c.old	2004-12-12 19:06:10.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/sunrpc/auth_gss/auth_gss.c	2004-12-12 19:06:17.000000000 +0100
@@ -532,7 +532,7 @@
 	spin_unlock(&gss_auth->lock);
 }
 
-void
+static void
 gss_pipe_destroy_msg(struct rpc_pipe_msg *msg)
 {
 	struct gss_upcall_msg *gss_msg = container_of(msg, struct gss_upcall_msg, msg);
--- linux-2.6.10-rc2-mm4-full/include/linux/sunrpc/gss_asn1.h.old	2004-12-12 19:06:37.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/sunrpc/gss_asn1.h	2004-12-12 19:06:43.000000000 +0100
@@ -71,8 +71,6 @@
      unsigned char **buf_in,
      int toksize);
 
-u32 g_get_mech_oid(struct xdr_netobj *mech, struct xdr_netobj * in_buf);
-
 int g_token_size(
      struct xdr_netobj *mech,
      unsigned int body_size);
--- linux-2.6.10-rc2-mm4-full/net/sunrpc/auth_gss/gss_generic_token.c.old	2004-12-12 19:06:50.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/sunrpc/auth_gss/gss_generic_token.c	2004-12-12 19:06:58.000000000 +0100
@@ -233,38 +233,3 @@
 
 EXPORT_SYMBOL(g_verify_token_header);
 
-/* Given a buffer containing a token, returns a copy of the mech oid in
- * the parameter mech. */
-u32
-g_get_mech_oid(struct xdr_netobj *mech, struct xdr_netobj * in_buf)
-{
-	unsigned char *buf = in_buf->data;
-	int len = in_buf->len;
-	int ret=0;
-	int seqsize;
-
-	if ((len-=1) < 0)
-		return(G_BAD_TOK_HEADER);
-	if (*buf++ != 0x60)
-		return(G_BAD_TOK_HEADER);
-
-	if ((seqsize = der_read_length(&buf, &len)) < 0)
-		return(G_BAD_TOK_HEADER);
-
-	if ((len-=1) < 0)
-		return(G_BAD_TOK_HEADER);
-	if (*buf++ != 0x06)
-		return(G_BAD_TOK_HEADER);
-
-	if ((len-=1) < 0)
-		return(G_BAD_TOK_HEADER);
-	mech->len = *buf++;
-
-	if ((len-=mech->len) < 0)
-		return(G_BAD_TOK_HEADER);
-	if (!(mech->data = kmalloc(mech->len, GFP_KERNEL))) 
-		return(G_BUFFER_ALLOC);
-	memcpy(mech->data, buf, mech->len);
-
-	return ret;
-}
--- linux-2.6.10-rc2-mm4-full/net/sunrpc/auth_gss/gss_krb5_crypto.c.old	2004-12-12 19:07:19.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/sunrpc/auth_gss/gss_krb5_crypto.c	2004-12-12 19:07:44.000000000 +0100
@@ -132,7 +132,7 @@
 
 EXPORT_SYMBOL(krb5_decrypt);
 
-void
+static void
 buf_to_sg(struct scatterlist *sg, char *ptr, int len) {
 	sg->page = virt_to_page(ptr);
 	sg->offset = offset_in_page(ptr);
--- linux-2.6.10-rc2-mm4-full/net/sunrpc/auth_gss/gss_krb5_mech.c.old	2004-12-12 19:07:57.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/sunrpc/auth_gss/gss_krb5_mech.c	2004-12-12 19:08:05.000000000 +0100
@@ -48,9 +48,6 @@
 # define RPCDBG_FACILITY	RPCDBG_AUTH
 #endif
 
-struct xdr_netobj gss_mech_krb5_oid =
-   {9, "\052\206\110\206\367\022\001\002\002"};
-
 static inline int
 get_bytes(char **ptr, const char *end, void *res, int len)
 {
--- linux-2.6.10-rc2-mm4-full/net/sunrpc/auth_gss/gss_spkm3_mech.c.old	2004-12-12 19:11:01.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/sunrpc/auth_gss/gss_spkm3_mech.c	2004-12-12 19:11:51.000000000 +0100
@@ -49,9 +49,6 @@
 # define RPCDBG_FACILITY	RPCDBG_AUTH
 #endif
 
-struct xdr_netobj gss_mech_spkm3_oid =
-   {7, "\053\006\001\005\005\001\003"};
-
 static inline int
 get_bytes(char **ptr, const char *end, void *res, int len)
 {
@@ -206,7 +203,7 @@
 	return GSS_S_FAILURE;
 }
 
-void
+static void
 gss_delete_sec_context_spkm3(void *internal_ctx) {
 	struct spkm3_ctx *sctx = internal_ctx;
 
@@ -221,7 +218,7 @@
 	kfree(sctx);
 }
 
-u32
+static u32
 gss_verify_mic_spkm3(struct gss_ctx		*ctx,
 			struct xdr_buf		*signbuf,
 			struct xdr_netobj	*checksum,
@@ -241,7 +238,7 @@
 	return maj_stat;
 }
 
-u32
+static u32
 gss_get_mic_spkm3(struct gss_ctx	*ctx,
 		     u32		qop,
 		     struct xdr_buf	*message_buffer,
--- linux-2.6.10-rc2-mm4-full/net/sunrpc/auth_gss/svcauth_gss.c.old	2004-12-12 19:12:04.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/sunrpc/auth_gss/svcauth_gss.c	2004-12-12 19:12:24.000000000 +0100
@@ -447,7 +447,7 @@
 
 static DefineSimpleCacheLookup(rsc, 0);
 
-struct rsc *
+static struct rsc *
 gss_svc_searchbyctx(struct xdr_netobj *handle)
 {
 	struct rsc rsci;
@@ -1044,7 +1044,7 @@
 	kfree(gd);
 }
 
-struct auth_ops svcauthops_gss = {
+static struct auth_ops svcauthops_gss = {
 	.name		= "rpcsec_gss",
 	.owner		= THIS_MODULE,
 	.flavour	= RPC_AUTH_GSS,
--- linux-2.6.10-rc2-mm4-full/include/linux/sunrpc/cache.h.old	2004-12-12 19:15:13.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/sunrpc/cache.h	2004-12-12 19:57:27.000000000 +0100
@@ -257,8 +257,6 @@
 
 	     
 
-extern void cache_defer_req(struct cache_req *req, struct cache_head *item);
-extern void cache_revisit_request(struct cache_head *item);
 extern void cache_clean_deferred(void *owner);
 
 static inline struct cache_head  *cache_get(struct cache_head *h)
@@ -286,14 +284,11 @@
 			struct cache_head *head, time_t expiry);
 extern int cache_check(struct cache_detail *detail,
 		       struct cache_head *h, struct cache_req *rqstp);
-extern int cache_clean(void);
 extern void cache_flush(void);
 extern void cache_purge(struct cache_detail *detail);
 #define NEVER (0x7FFFFFFF)
 extern void cache_register(struct cache_detail *cd);
 extern int cache_unregister(struct cache_detail *cd);
-extern struct cache_detail *cache_find(char *name);
-extern void cache_drop(struct cache_detail *detail);
 
 extern void qword_add(char **bpp, int *lp, char *str);
 extern void qword_addhex(char **bpp, int *lp, char *buf, int blen);
--- linux-2.6.10-rc2-mm4-full/net/sunrpc/cache.c.old	2004-12-12 19:14:03.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/sunrpc/cache.c	2004-12-12 19:17:34.000000000 +0100
@@ -33,6 +33,9 @@
 
 #define	 RPCDBG_FACILITY RPCDBG_CACHE
 
+static void cache_defer_req(struct cache_req *req, struct cache_head *item);
+static void cache_revisit_request(struct cache_head *item);
+
 void cache_init(struct cache_head *h)
 {
 	time_t now = get_seconds();
@@ -256,39 +259,13 @@
 	return 0;
 }
 
-struct cache_detail *cache_find(char *name)
-{
-	struct list_head *l;
-
-	spin_lock(&cache_list_lock);
-	list_for_each(l, &cache_list) {
-		struct cache_detail *cd = list_entry(l, struct cache_detail, others);
-		
-		if (strcmp(cd->name, name)==0) {
-			atomic_inc(&cd->inuse);
-			spin_unlock(&cache_list_lock);
-			return cd;
-		}
-	}
-	spin_unlock(&cache_list_lock);
-	return NULL;
-}
-
-/* cache_drop must be called on any cache returned by
- * cache_find, after it has been used
- */
-void cache_drop(struct cache_detail *detail)
-{
-	atomic_dec(&detail->inuse);
-}
-
 /* clean cache tries to find something to clean
  * and cleans it.
  * It returns 1 if it cleaned something,
  *            0 if it didn't find anything this time
  *           -1 if it fell off the end of the list.
  */
-int cache_clean(void)
+static int cache_clean(void)
 {
 	int rv = 0;
 	struct list_head *next;
@@ -428,12 +405,12 @@
 
 #define	DFR_MAX	300	/* ??? */
 
-spinlock_t cache_defer_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t cache_defer_lock = SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(cache_defer_list);
 static struct list_head cache_defer_hash[DFR_HASHSIZE];
 static int cache_defer_cnt;
 
-void cache_defer_req(struct cache_req *req, struct cache_head *item)
+static void cache_defer_req(struct cache_req *req, struct cache_head *item)
 {
 	struct cache_deferred_req *dreq;
 	int hash = DFR_HASH(item);
@@ -483,7 +460,7 @@
 	}
 }
 
-void cache_revisit_request(struct cache_head *item)
+static void cache_revisit_request(struct cache_head *item)
 {
 	struct cache_deferred_req *dreq;
 	struct list_head pending;
@@ -902,7 +879,7 @@
 	*lp = len;
 }
 
-void warn_no_listener(struct cache_detail *detail)
+static void warn_no_listener(struct cache_detail *detail)
 {
 	if (detail->last_warn != detail->last_close) {
 		detail->last_warn = detail->last_close;
@@ -1119,7 +1096,7 @@
 	return cd->cache_show(m, cd, cp);
 }
 
-struct seq_operations cache_content_op = {
+static struct seq_operations cache_content_op = {
 	.start	= c_start,
 	.next	= c_next,
 	.stop	= c_stop,
--- linux-2.6.10-rc2-mm4-full/net/sunrpc/pmap_clnt.c.old	2004-12-12 19:17:51.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/sunrpc/pmap_clnt.c	2004-12-12 19:18:10.000000000 +0100
@@ -31,7 +31,7 @@
 static struct rpc_procinfo	pmap_procedures[];
 static struct rpc_clnt *	pmap_create(char *, struct sockaddr_in *, int);
 static void			pmap_getport_done(struct rpc_task *);
-extern struct rpc_program	pmap_program;
+static struct rpc_program	pmap_program;
 static spinlock_t		pmap_lock = SPIN_LOCK_UNLOCKED;
 
 /*
@@ -292,7 +292,7 @@
 
 static struct rpc_stat		pmap_stats;
 
-struct rpc_program	pmap_program = {
+static struct rpc_program	pmap_program = {
 	.name		= "portmap",
 	.number		= RPC_PMAP_PROGRAM,
 	.nrvers		= ARRAY_SIZE(pmap_version),
--- linux-2.6.10-rc2-mm4-full/net/sunrpc/rpc_pipe.c.old	2004-12-12 19:18:25.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/sunrpc/rpc_pipe.c	2004-12-12 19:19:08.000000000 +0100
@@ -276,12 +276,7 @@
 	}
 }
 
-struct inode_operations rpc_pipe_iops = {
-	.lookup		= simple_lookup,
-};
-
-
-struct file_operations rpc_pipe_fops = {
+static struct file_operations rpc_pipe_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= rpc_pipe_read,
@@ -595,7 +590,7 @@
 	return 0;
 }
 
-struct dentry *
+static struct dentry *
 rpc_lookup_negative(char *path, struct nameidata *nd)
 {
 	struct dentry *dentry;
--- linux-2.6.10-rc2-mm4-full/include/linux/sunrpc/sched.h.old	2004-12-12 19:19:29.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/sunrpc/sched.h	2004-12-12 19:19:35.000000000 +0100
@@ -251,7 +251,6 @@
 void		rpc_wake_up_status(struct rpc_wait_queue *, int);
 void		rpc_delay(struct rpc_task *, unsigned long);
 void *		rpc_malloc(struct rpc_task *, size_t);
-void		rpc_free(struct rpc_task *);
 int		rpciod_up(void);
 void		rpciod_down(void);
 void		rpciod_wake_up(void);
--- linux-2.6.10-rc2-mm4-full/net/sunrpc/sched.c.old	2004-12-12 19:19:42.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/sunrpc/sched.c	2004-12-12 19:20:13.000000000 +0100
@@ -43,6 +43,9 @@
 static void			rpciod_killall(void);
 static void			rpc_async_schedule(void *);
 
+static void			rpc_free(struct rpc_task *task);
+
+
 /*
  * RPC tasks that create another task (e.g. for contacting the portmapper)
  * will wait on this queue for their child's completion
@@ -719,7 +722,7 @@
 	return task->tk_buffer;
 }
 
-void
+static void
 rpc_free(struct rpc_task *task)
 {
 	if (task->tk_buffer) {
--- linux-2.6.10-rc2-mm4-full/net/sunrpc/svcauth.c.old	2004-12-12 19:20:28.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/sunrpc/svcauth.c	2004-12-12 19:20:39.000000000 +0100
@@ -128,7 +128,8 @@
 #define	DN_HASHMASK	(DN_HASHMAX-1)
 
 static struct cache_head	*auth_domain_table[DN_HASHMAX];
-void auth_domain_drop(struct cache_head *item, struct cache_detail *cd)
+
+static void auth_domain_drop(struct cache_head *item, struct cache_detail *cd)
 {
 	struct auth_domain *dom = container_of(item, struct auth_domain, h);
 	if (cache_put(item,cd))
--- linux-2.6.10-rc2-mm4-full/net/sunrpc/svcauth_unix.c.old	2004-12-12 19:20:54.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/sunrpc/svcauth_unix.c	2004-12-12 19:21:30.000000000 +0100
@@ -97,7 +97,7 @@
 };
 static struct cache_head	*ip_table[IP_HASHMAX];
 
-void ip_map_put(struct cache_head *item, struct cache_detail *cd)
+static void ip_map_put(struct cache_head *item, struct cache_detail *cd)
 {
 	struct ip_map *im = container_of(item, struct ip_map,h);
 	if (cache_put(item, cd)) {
@@ -432,7 +432,7 @@
 };
 
 
-int
+static int
 svcauth_unix_accept(struct svc_rqst *rqstp, u32 *authp)
 {
 	struct kvec	*argv = &rqstp->rq_arg.head[0];
@@ -487,7 +487,7 @@
 	return SVC_DENIED;
 }
 
-int
+static int
 svcauth_unix_release(struct svc_rqst *rqstp)
 {
 	/* Verifier (such as it is) is already in place.
--- linux-2.6.10-rc2-mm4-full/include/linux/sunrpc/xdr.h.old	2004-12-12 19:22:17.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/sunrpc/xdr.h	2004-12-12 19:26:11.000000000 +0100
@@ -95,7 +95,6 @@
 u32 *	xdr_decode_string_inplace(u32 *p, char **sp, int *lenp, int maxlen);
 u32 *	xdr_encode_netobj(u32 *p, const struct xdr_netobj *);
 u32 *	xdr_decode_netobj(u32 *p, struct xdr_netobj *);
-u32 *	xdr_decode_netobj_fixed(u32 *p, void *obj, unsigned int len);
 
 void	xdr_encode_pages(struct xdr_buf *, struct page **, unsigned int,
 			 unsigned int);
@@ -135,8 +134,6 @@
 	return iov->iov_len = ((u8 *) p - (u8 *) iov->iov_base);
 }
 
-void xdr_shift_iovec(struct kvec *, int, size_t);
-
 /*
  * Maximum number of iov's we use.
  */
@@ -145,10 +142,7 @@
 /*
  * XDR buffer helper functions
  */
-extern int xdr_kmap(struct kvec *, struct xdr_buf *, size_t);
-extern void xdr_kunmap(struct xdr_buf *, size_t);
 extern void xdr_shift_buf(struct xdr_buf *, size_t);
-extern void _copy_from_pages(char *, struct page **, size_t, size_t);
 extern void xdr_buf_from_iov(struct kvec *, struct xdr_buf *);
 extern int xdr_buf_subsegment(struct xdr_buf *, struct xdr_buf *, int, int);
 extern int xdr_buf_read_netobj(struct xdr_buf *, struct xdr_netobj *, int);
--- linux-2.6.10-rc2-mm4-full/net/sunrpc/xdr.c.old	2004-12-12 19:21:55.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/sunrpc/xdr.c	2004-12-12 19:26:44.000000000 +0100
@@ -33,15 +33,6 @@
 }
 
 u32 *
-xdr_decode_netobj_fixed(u32 *p, void *obj, unsigned int len)
-{
-	if (ntohl(*p++) != len)
-		return NULL;
-	memcpy(obj, p, len);
-	return p + XDR_QUADLEN(len);
-}
-
-u32 *
 xdr_decode_netobj(u32 *p, struct xdr_netobj *obj)
 {
 	unsigned int	len;
@@ -185,124 +176,6 @@
 	xdr->buflen += len;
 }
 
-/*
- * Realign the kvec if the server missed out some reply elements
- * (such as post-op attributes,...)
- * Note: This is a simple implementation that assumes that
- *            len <= iov->iov_len !!!
- *       The RPC header (assumed to be the 1st element in the iov array)
- *            is not shifted.
- */
-void xdr_shift_iovec(struct kvec *iov, int nr, size_t len)
-{
-	struct kvec *pvec;
-
-	for (pvec = iov + nr - 1; nr > 1; nr--, pvec--) {
-		struct kvec *svec = pvec - 1;
-
-		if (len > pvec->iov_len) {
-			printk(KERN_DEBUG "RPC: Urk! Large shift of short iovec.\n");
-			return;
-		}
-		memmove((char *)pvec->iov_base + len, pvec->iov_base,
-			pvec->iov_len - len);
-
-		if (len > svec->iov_len) {
-			printk(KERN_DEBUG "RPC: Urk! Large shift of short iovec.\n");
-			return;
-		}
-		memcpy(pvec->iov_base,
-		       (char *)svec->iov_base + svec->iov_len - len, len);
-	}
-}
-
-/*
- * Map a struct xdr_buf into an kvec array.
- */
-int xdr_kmap(struct kvec *iov_base, struct xdr_buf *xdr, size_t base)
-{
-	struct kvec	*iov = iov_base;
-	struct page	**ppage = xdr->pages;
-	unsigned int	len, pglen = xdr->page_len;
-
-	len = xdr->head[0].iov_len;
-	if (base < len) {
-		iov->iov_len = len - base;
-		iov->iov_base = (char *)xdr->head[0].iov_base + base;
-		iov++;
-		base = 0;
-	} else
-		base -= len;
-
-	if (pglen == 0)
-		goto map_tail;
-	if (base >= pglen) {
-		base -= pglen;
-		goto map_tail;
-	}
-	if (base || xdr->page_base) {
-		pglen -= base;
-		base  += xdr->page_base;
-		ppage += base >> PAGE_CACHE_SHIFT;
-		base &= ~PAGE_CACHE_MASK;
-	}
-	do {
-		len = PAGE_CACHE_SIZE;
-		iov->iov_base = kmap(*ppage);
-		if (base) {
-			iov->iov_base += base;
-			len -= base;
-			base = 0;
-		}
-		if (pglen < len)
-			len = pglen;
-		iov->iov_len = len;
-		iov++;
-		ppage++;
-	} while ((pglen -= len) != 0);
-map_tail:
-	if (xdr->tail[0].iov_len) {
-		iov->iov_len = xdr->tail[0].iov_len - base;
-		iov->iov_base = (char *)xdr->tail[0].iov_base + base;
-		iov++;
-	}
-	return (iov - iov_base);
-}
-
-void xdr_kunmap(struct xdr_buf *xdr, size_t base)
-{
-	struct page	**ppage = xdr->pages;
-	unsigned int	pglen = xdr->page_len;
-
-	if (!pglen)
-		return;
-	if (base > xdr->head[0].iov_len)
-		base -= xdr->head[0].iov_len;
-	else
-		base = 0;
-
-	if (base >= pglen)
-		return;
-	if (base || xdr->page_base) {
-		pglen -= base;
-		base  += xdr->page_base;
-		ppage += base >> PAGE_CACHE_SHIFT;
-		/* Note: The offset means that the length of the first
-		 * page is really (PAGE_CACHE_SIZE - (base & ~PAGE_CACHE_MASK)).
-		 * In order to avoid an extra test inside the loop,
-		 * we bump pglen here, and just subtract PAGE_CACHE_SIZE... */
-		pglen += base & ~PAGE_CACHE_MASK;
-	}
-	for (;;) {
-		flush_dcache_page(*ppage);
-		kunmap(*ppage);
-		if (pglen <= PAGE_CACHE_SIZE)
-			break;
-		pglen -= PAGE_CACHE_SIZE;
-		ppage++;
-	}
-}
-
 void
 xdr_partial_copy_from_skb(struct xdr_buf *xdr, unsigned int base,
 			  skb_reader_t *desc,
@@ -572,7 +445,7 @@
  * Copies data into an arbitrary memory location from an array of pages
  * The copy is assumed to be non-overlapping.
  */
-void
+static void
 _copy_from_pages(char *p, struct page **pages, size_t pgbase, size_t len)
 {
 	struct page **pgfrom;
@@ -610,7 +483,7 @@
  * 'len' bytes. The extra data is not lost, but is instead
  * moved into the inlined pages and/or the tail.
  */
-void
+static void
 xdr_shrink_bufhead(struct xdr_buf *buf, size_t len)
 {
 	struct kvec *head, *tail;
@@ -683,7 +556,7 @@
  * 'len' bytes. The extra data is not lost, but is instead
  * moved into the tail.
  */
-void
+static void
 xdr_shrink_pagelen(struct xdr_buf *buf, size_t len)
 {
 	struct kvec *tail;
--- linux-2.6.10-rc2-mm4-full/include/linux/sunrpc/xprt.h.old	2004-12-12 19:27:24.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/sunrpc/xprt.h	2004-12-12 19:29:18.000000000 +0100
@@ -201,8 +201,6 @@
 struct rpc_xprt *	xprt_create_proto(int proto, struct sockaddr_in *addr,
 					struct rpc_timeout *toparms);
 int			xprt_destroy(struct rpc_xprt *);
-void			xprt_shutdown(struct rpc_xprt *);
-void			xprt_default_timeout(struct rpc_timeout *, int);
 void			xprt_set_timeout(struct rpc_timeout *, unsigned int,
 					unsigned long);
 
@@ -213,7 +211,6 @@
 int			xprt_adjust_timeout(struct rpc_rqst *req);
 void			xprt_release(struct rpc_task *);
 void			xprt_connect(struct rpc_task *);
-int			xprt_clear_backlog(struct rpc_xprt *);
 void			xprt_sock_setbufsize(struct rpc_xprt *);
 
 #define XPRT_LOCKED	0
--- linux-2.6.10-rc2-mm4-full/net/sunrpc/xprt.c.old	2004-12-12 19:27:37.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/sunrpc/xprt.c	2004-12-12 19:29:23.000000000 +0100
@@ -90,6 +90,8 @@
 static void	xprt_bind_socket(struct rpc_xprt *, struct socket *);
 static int      __xprt_get_cong(struct rpc_xprt *, struct rpc_task *);
 
+static int	xprt_clear_backlog(struct rpc_xprt *xprt);
+
 #ifdef RPC_DEBUG_DATA
 /*
  * Print the buffer contents (first 128 bytes only--just enough for
@@ -1397,7 +1399,7 @@
 /*
  * Set default timeout parameters
  */
-void
+static void
 xprt_default_timeout(struct rpc_timeout *to, int proto)
 {
 	if (proto == IPPROTO_UDP)
@@ -1633,7 +1635,7 @@
 /*
  * Prepare for transport shutdown.
  */
-void
+static void
 xprt_shutdown(struct rpc_xprt *xprt)
 {
 	xprt->shutdown = 1;
@@ -1648,7 +1650,7 @@
 /*
  * Clear the xprt backlog queue
  */
-int
+static int
 xprt_clear_backlog(struct rpc_xprt *xprt) {
 	rpc_wake_up_next(&xprt->backlog);
 	wake_up(&xprt->cong_wait);
--- linux-2.6.10-rc2-mm4-full/net/sunrpc/sunrpc_syms.c.old	2004-12-12 19:23:19.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/sunrpc/sunrpc_syms.c	2004-12-12 20:19:39.000000000 +0100
@@ -107,7 +107,6 @@
 EXPORT_SYMBOL(auth_unix_forget_old);
 EXPORT_SYMBOL(auth_unix_lookup);
 EXPORT_SYMBOL(cache_check);
-EXPORT_SYMBOL(cache_clean);
 EXPORT_SYMBOL(cache_flush);
 EXPORT_SYMBOL(cache_purge);
 EXPORT_SYMBOL(cache_fresh);

