Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVE3VAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVE3VAP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 17:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVE3U7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 16:59:32 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27150 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261753AbVE3U4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:56:52 -0400
Date: Mon, 30 May 2005 22:56:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       netdev@oss.sgi.com
Subject: [RFC: 2.6 patch] net/sunrpc/: possible cleanups
Message-ID: <20050530205649.GX10441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unused global function:
  - xdr.c: xdr_decode_string
- remove the following unneeded EXPORT_SYMBOL's:
  - auth_gss/gss_mech_switch.c: gss_mech_get
  - auth_gss/gss_mech_switch.c: gss_mech_get_by_name
  - auth_gss/gss_mech_switch.c: gss_mech_get_by_pseudoflavor
  - auth_gss/gss_mech_switch.c: gss_pseudoflavor_to_service
  - auth_gss/gss_mech_switch.c: gss_service_to_auth_domain_name
  - auth_gss/gss_mech_switch.c: gss_mech_put
  - sunrpc_syms.c: rpc_wake_up_next
  - sunrpc_syms.c: rpc_new_child
  - sunrpc_syms.c: rpc_run_child
  - sunrpc_syms.c: rpc_new_task
  - sunrpc_syms.c: rpc_release_task
  - sunrpc_syms.c: rpc_release_client
  - sunrpc_syms.c: xprt_udp_slot_table_entries
  - sunrpc_syms.c: xprt_tcp_slot_table_entries
  - sunrpc_syms.c: svc_drop
  - sunrpc_syms.c: svc_authenticate
  - sunrpc_syms.c: xdr_decode_string

Please review which of these patches do make sense and which conflict 
with pending patches.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 7 May 2005

 include/linux/sunrpc/clnt.h           |    1 -
 include/linux/sunrpc/gss_api.h        |    3 ---
 include/linux/sunrpc/xdr.h            |    2 --
 net/sunrpc/auth_gss/gss_mech_switch.c |   13 +------------
 net/sunrpc/clnt.c                     |    3 ++-
 net/sunrpc/sunrpc_syms.c              |   11 -----------
 net/sunrpc/xdr.c                      |    4 +++-
 7 files changed, 6 insertions(+), 31 deletions(-)

--- linux-2.6.12-rc3-mm3-full/include/linux/sunrpc/gss_api.h.old	2005-05-05 23:05:01.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/include/linux/sunrpc/gss_api.h	2005-05-05 23:05:10.000000000 +0200
@@ -110,9 +110,6 @@
 /* Similar, but get by pseudoflavor. */
 struct gss_api_mech *gss_mech_get_by_pseudoflavor(u32);
 
-/* Just increments the mechanism's reference count and returns its input: */
-struct gss_api_mech * gss_mech_get(struct gss_api_mech *);
-
 /* For every succesful gss_mech_get or gss_mech_get_by_* call there must be a
  * corresponding call to gss_mech_put. */
 void gss_mech_put(struct gss_api_mech *);
--- linux-2.6.12-rc3-mm3-full/net/sunrpc/auth_gss/gss_mech_switch.c.old	2005-05-05 23:05:17.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/sunrpc/auth_gss/gss_mech_switch.c	2005-05-05 23:19:33.000000000 +0200
@@ -133,14 +133,13 @@
 
 EXPORT_SYMBOL(gss_mech_unregister);
 
-struct gss_api_mech *
+static struct gss_api_mech *
 gss_mech_get(struct gss_api_mech *gm)
 {
 	__module_get(gm->gm_owner);
 	return gm;
 }
 
-EXPORT_SYMBOL(gss_mech_get);
 
 struct gss_api_mech *
 gss_mech_get_by_name(const char *name)
@@ -160,8 +159,6 @@
 
 }
 
-EXPORT_SYMBOL(gss_mech_get_by_name);
-
 static inline int
 mech_supports_pseudoflavor(struct gss_api_mech *gm, u32 pseudoflavor)
 {
@@ -193,8 +190,6 @@
 	return gm;
 }
 
-EXPORT_SYMBOL(gss_mech_get_by_pseudoflavor);
-
 u32
 gss_pseudoflavor_to_service(struct gss_api_mech *gm, u32 pseudoflavor)
 {
@@ -207,8 +202,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(gss_pseudoflavor_to_service);
-
 char *
 gss_service_to_auth_domain_name(struct gss_api_mech *gm, u32 service)
 {
@@ -221,16 +214,12 @@
 	return NULL;
 }
 
-EXPORT_SYMBOL(gss_service_to_auth_domain_name);
-
 void
 gss_mech_put(struct gss_api_mech * gm)
 {
 	module_put(gm->gm_owner);
 }
 
-EXPORT_SYMBOL(gss_mech_put);
-
 /* The mech could probably be determined from the token instead, but it's just
  * as easy for now to pass it in. */
 int
--- linux-2.6.12-rc3-mm3-full/include/linux/sunrpc/clnt.h.old	2005-05-05 23:05:45.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/include/linux/sunrpc/clnt.h	2005-05-05 23:05:50.000000000 +0200
@@ -134,7 +134,6 @@
 void		rpc_clnt_sigunmask(struct rpc_clnt *clnt, sigset_t *oldset);
 void		rpc_setbufsize(struct rpc_clnt *, unsigned int, unsigned int);
 size_t		rpc_max_payload(struct rpc_clnt *);
-int		rpc_ping(struct rpc_clnt *clnt, int flags);
 
 static __inline__
 int rpc_call(struct rpc_clnt *clnt, u32 proc, void *argp, void *resp, int flags)
--- linux-2.6.12-rc3-mm3-full/net/sunrpc/clnt.c.old	2005-05-05 23:05:58.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/sunrpc/clnt.c	2005-05-05 23:06:21.000000000 +0200
@@ -63,6 +63,7 @@
 static u32 *	call_header(struct rpc_task *task);
 static u32 *	call_verify(struct rpc_task *task);
 
+static int	rpc_ping(struct rpc_clnt *clnt, int flags);
 
 static int
 rpc_setup_pipedir(struct rpc_clnt *clnt, char *dir_name)
@@ -1178,7 +1179,7 @@
 	.p_decode = rpcproc_decode_null,
 };
 
-int rpc_ping(struct rpc_clnt *clnt, int flags)
+static int rpc_ping(struct rpc_clnt *clnt, int flags)
 {
 	struct rpc_message msg = {
 		.rpc_proc = &rpcproc_null,
--- linux-2.6.12-rc3-mm3-full/include/linux/sunrpc/xdr.h.old	2005-05-05 23:06:40.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/include/linux/sunrpc/xdr.h	2005-05-05 23:07:23.000000000 +0200
@@ -91,7 +91,6 @@
 u32 *	xdr_encode_opaque_fixed(u32 *p, const void *ptr, unsigned int len);
 u32 *	xdr_encode_opaque(u32 *p, const void *ptr, unsigned int len);
 u32 *	xdr_encode_string(u32 *p, const char *s);
-u32 *	xdr_decode_string(u32 *p, char **sp, int *lenp, int maxlen);
 u32 *	xdr_decode_string_inplace(u32 *p, char **sp, int *lenp, int maxlen);
 u32 *	xdr_encode_netobj(u32 *p, const struct xdr_netobj *);
 u32 *	xdr_decode_netobj(u32 *p, struct xdr_netobj *);
@@ -147,7 +146,6 @@
 extern int xdr_buf_subsegment(struct xdr_buf *, struct xdr_buf *, int, int);
 extern int xdr_buf_read_netobj(struct xdr_buf *, struct xdr_netobj *, int);
 extern int read_bytes_from_xdr_buf(struct xdr_buf *, int, void *, int);
-extern int write_bytes_to_xdr_buf(struct xdr_buf *, int, void *, int);
 
 /*
  * Helper structure for copying from an sk_buff.
--- linux-2.6.12-rc3-mm3-full/net/sunrpc/xdr.c.old	2005-05-05 23:06:52.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/sunrpc/xdr.c	2005-05-05 23:07:56.000000000 +0200
@@ -95,6 +95,7 @@
 	return xdr_encode_array(p, string, strlen(string));
 }
 
+#if 0
 u32 *
 xdr_decode_string(u32 *p, char **sp, int *lenp, int maxlen)
 {
@@ -115,6 +116,7 @@
 	*sp = string;
 	return p + XDR_QUADLEN(len);
 }
+#endif  /*  0  */
 
 u32 *
 xdr_decode_string_inplace(u32 *p, char **sp, int *lenp, int maxlen)
@@ -882,7 +884,7 @@
 }
 
 /* obj is assumed to point to allocated memory of size at least len: */
-int
+static int
 write_bytes_to_xdr_buf(struct xdr_buf *buf, int base, void *obj, int len)
 {
 	struct xdr_buf subbuf;
--- linux-2.6.12-rc3-mm3-full/net/sunrpc/sunrpc_syms.c.old	2005-05-05 23:07:30.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/sunrpc/sunrpc_syms.c	2005-05-05 23:36:43.000000000 +0200
@@ -29,15 +29,10 @@
 EXPORT_SYMBOL(rpc_execute);
 EXPORT_SYMBOL(rpc_init_task);
 EXPORT_SYMBOL(rpc_sleep_on);
-EXPORT_SYMBOL(rpc_wake_up_next);
 EXPORT_SYMBOL(rpc_wake_up_task);
-EXPORT_SYMBOL(rpc_new_child);
-EXPORT_SYMBOL(rpc_run_child);
 EXPORT_SYMBOL(rpciod_down);
 EXPORT_SYMBOL(rpciod_up);
-EXPORT_SYMBOL(rpc_new_task);
 EXPORT_SYMBOL(rpc_wake_up_status);
-EXPORT_SYMBOL(rpc_release_task);
 
 /* RPC client functions */
 EXPORT_SYMBOL(rpc_create_client);
@@ -45,7 +40,6 @@
 EXPORT_SYMBOL(rpc_bind_new_program);
 EXPORT_SYMBOL(rpc_destroy_client);
 EXPORT_SYMBOL(rpc_shutdown_client);
-EXPORT_SYMBOL(rpc_release_client);
 EXPORT_SYMBOL(rpc_killall_tasks);
 EXPORT_SYMBOL(rpc_call_sync);
 EXPORT_SYMBOL(rpc_call_async);
@@ -63,8 +57,6 @@
 /* Client transport */
 EXPORT_SYMBOL(xprt_create_proto);
 EXPORT_SYMBOL(xprt_set_timeout);
-EXPORT_SYMBOL(xprt_udp_slot_table_entries);
-EXPORT_SYMBOL(xprt_tcp_slot_table_entries);
 
 /* Client credential cache */
 EXPORT_SYMBOL(rpcauth_register);
@@ -81,7 +73,6 @@
 EXPORT_SYMBOL(svc_create_thread);
 EXPORT_SYMBOL(svc_exit_thread);
 EXPORT_SYMBOL(svc_destroy);
-EXPORT_SYMBOL(svc_drop);
 EXPORT_SYMBOL(svc_process);
 EXPORT_SYMBOL(svc_recv);
 EXPORT_SYMBOL(svc_wake_up);
@@ -89,7 +80,6 @@
 EXPORT_SYMBOL(svc_reserve);
 EXPORT_SYMBOL(svc_auth_register);
 EXPORT_SYMBOL(auth_domain_lookup);
-EXPORT_SYMBOL(svc_authenticate);
 EXPORT_SYMBOL(svc_set_client);
 
 /* RPC statistics */
@@ -122,7 +112,6 @@
 
 /* Generic XDR */
 EXPORT_SYMBOL(xdr_encode_string);
-EXPORT_SYMBOL(xdr_decode_string);
 EXPORT_SYMBOL(xdr_decode_string_inplace);
 EXPORT_SYMBOL(xdr_decode_netobj);
 EXPORT_SYMBOL(xdr_encode_netobj);

