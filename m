Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267666AbTAMAMa>; Sun, 12 Jan 2003 19:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267677AbTAMAMa>; Sun, 12 Jan 2003 19:12:30 -0500
Received: from mons.uio.no ([129.240.130.14]:37002 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267666AbTAMAF7>;
	Sun, 12 Jan 2003 19:05:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15906.1263.469159.723137@charged.uio.no>
Date: Mon, 13 Jan 2003 01:14:39 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Secure user authentication for NFS using RPCSEC_GSS [4/6]
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch provides the basic framework for RPCSEC_GSS authentication
in the RPC client. The protocol is fully described in RFC-2203.
Sun has supported it in their commercial NFSv3 and v2 implementations
for quite some time, and it has been specified in RFC3010 as being
mandatory for NFSv4.

  - Update the mount_data struct for NFSv2 and v3 in order to allow them
    to pass an RPCSEC_GSS security flavour. Compatibility with existing
    versions of the 'mount' program is ensured by requiring that RPCSEC
    support be enabled using the new flag NFS_MOUNT_SECFLAVOUR.
  - Provide secure authentication, and later data encryption on
    a per-user basis. A later patch will an provide an implementation
    of the Kerberos 5 security mechanism. SPKM and LIPKEY are still
    being planned.
  - Security context negotiation and initialization are all assumed
    to be done in userland. A later patch will provide the actual upcall
    mechanisms to allow for this.

diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/fs/Kconfig linux-2.5.56-05-rpc_gss/fs/Kconfig
--- linux-2.5.56-04-auth_upcall/fs/Kconfig	2002-11-19 12:39:39.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/fs/Kconfig	2003-01-12 22:40:13.000000000 +0100
@@ -1339,6 +1339,17 @@
 	default m if NFS_FS!=y && NFSD!=y && (NFS_FS=m || NFSD=m)
 	default y if NFS_FS=y || NFSD=y
 
+config SUNRPC_GSS
+	tristate "Provide RPCSEC_GSS authentication (EXPERIMENTAL)"
+	depends on SUNRPC && EXPERIMENTAL
+	default SUNRPC if NFS_V4=y
+	help
+	  Provides cryptographic authentication for NFS rpc requests.  To
+	  make this useful, you also need support for a gss-api mechanism
+	  (such as Kerberos).
+	  Note: You should always select this option if you wish to use
+	  NFSv4.
+
 config LOCKD
 	tristate
 	default m if NFS_FS!=y && NFSD!=y && (NFS_FS=m || NFSD=m)
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/fs/nfs/inode.c linux-2.5.56-05-rpc_gss/fs/nfs/inode.c
--- linux-2.5.56-04-auth_upcall/fs/nfs/inode.c	2003-01-08 12:10:42.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/fs/nfs/inode.c	2003-01-12 22:40:13.000000000 +0100
@@ -346,6 +346,7 @@
 	struct rpc_clnt		*clnt = NULL;
 	struct rpc_timeout	timeparms;
 	int			tcp, err = -EIO;
+	u32			authflavor;
 
 	server           = NFS_SB(sb);
 	sb->s_blocksize_bits = 0;
@@ -408,8 +409,14 @@
 		printk(KERN_WARNING "NFS: cannot create RPC transport.\n");
 		goto out_fail;
 	}
+
+	if (data->flags & NFS_MOUNT_SECFLAVOUR)
+		authflavor = data->pseudoflavor;
+	else
+		authflavor = RPC_AUTH_UNIX;
+
 	clnt = rpc_create_client(xprt, server->hostname, &nfs_program,
-				 server->rpc_ops->version, RPC_AUTH_UNIX);
+				 server->rpc_ops->version, authflavor);
 	if (clnt == NULL) {
 		printk(KERN_WARNING "NFS: cannot create RPC client.\n");
 		xprt_destroy(xprt);
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/include/linux/nfs_mount.h linux-2.5.56-05-rpc_gss/include/linux/nfs_mount.h
--- linux-2.5.56-04-auth_upcall/include/linux/nfs_mount.h	2002-10-14 16:03:25.000000000 +0200
+++ linux-2.5.56-05-rpc_gss/include/linux/nfs_mount.h	2003-01-12 22:40:13.000000000 +0100
@@ -40,6 +40,7 @@
 	int		namlen;			/* 2 */
 	unsigned int	bsize;			/* 3 */
 	struct nfs3_fh	root;			/* 4 */
+	int		pseudoflavor;		/* 4 */
 };
 
 /* bits in the flags field */
@@ -55,10 +56,8 @@
 #define NFS_MOUNT_KERBEROS	0x0100	/* 3 */
 #define NFS_MOUNT_NONLM		0x0200	/* 3 */
 #define NFS_MOUNT_BROKEN_SUID	0x0400	/* 4 */
-#if 0
 #define NFS_MOUNT_STRICTLOCK	0x1000	/* reserved for NFSv4 */
 #define NFS_MOUNT_SECFLAVOUR	0x2000	/* reserved */
-#endif
 #define NFS_MOUNT_FLAGMASK	0xFFFF
 
 #endif
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/include/linux/sunrpc/auth_gss.h linux-2.5.56-05-rpc_gss/include/linux/sunrpc/auth_gss.h
--- linux-2.5.56-04-auth_upcall/include/linux/sunrpc/auth_gss.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/include/linux/sunrpc/auth_gss.h	2003-01-12 22:40:13.000000000 +0100
@@ -0,0 +1,97 @@
+/*
+ * linux/include/linux/auth_gss.h
+ *
+ * Declarations for RPCSEC_GSS
+ *
+ * Dug Song <dugsong@monkey.org>
+ * Andy Adamson <andros@umich.edu>
+ * Bruce Fields <bfields@umich.edu>
+ * Copyright (c) 2000 The Regents of the University of Michigan
+ *
+ * $Id$
+ */
+
+#ifndef _LINUX_SUNRPC_AUTH_GSS_H
+#define _LINUX_SUNRPC_AUTH_GSS_H
+
+#ifdef __KERNEL__
+#ifdef __linux__
+#include <linux/sunrpc/auth.h>
+#include <linux/sunrpc/svc.h>
+#include <linux/sunrpc/gss_api.h>
+#endif
+
+#define RPC_GSS_VERSION		1
+
+#define MAXSEQ 0x80000000 /* maximum legal sequence number, from rfc 2203 */
+
+enum rpc_gss_proc {
+	RPC_GSS_PROC_DATA = 0,
+	RPC_GSS_PROC_INIT = 1,
+	RPC_GSS_PROC_CONTINUE_INIT = 2,
+	RPC_GSS_PROC_DESTROY = 3
+};
+
+enum rpc_gss_svc {
+	RPC_GSS_SVC_NONE = 1,
+	RPC_GSS_SVC_INTEGRITY = 2,
+	RPC_GSS_SVC_PRIVACY = 3
+};
+
+/* on-the-wire gss cred: */
+struct rpc_gss_wire_cred {
+	u32			gc_v;		/* version */
+	u32			gc_proc;	/* control procedure */
+	u32			gc_seq;		/* sequence number */
+	u32			gc_svc;		/* service */
+	struct xdr_netobj	gc_ctx;		/* context handle */
+};
+
+/* on-the-wire gss verifier: */
+struct rpc_gss_wire_verf {
+	u32			gv_flavor;
+	struct xdr_netobj	gv_verf;
+};
+
+/* return from gss NULL PROC init sec context */
+struct rpc_gss_init_res {
+	struct xdr_netobj	gr_ctx;		/* context handle */
+	u32			gr_major;	/* major status */
+	u32			gr_minor;	/* minor status */
+	u32			gr_win;		/* sequence window */
+	struct xdr_netobj	gr_token;	/* token */
+};
+
+#define GSS_SEQ_WIN	5
+
+/* The gss_cl_ctx struct holds all the information the rpcsec_gss client
+ * code needs to know about a single security context.  In particular,
+ * gc_gss_ctx is the context handle that is used to do gss-api calls, while
+ * gc_wire_ctx is the context handle that is used to identify the context on
+ * the wire when communicating with a server. */
+
+struct gss_cl_ctx {
+	u32			gc_proc;
+	u32			gc_seq;
+	spinlock_t		gc_seq_lock;
+	struct gss_ctx		*gc_gss_ctx;
+	struct xdr_netobj	gc_wire_ctx;
+	u32			gc_win;
+};
+
+struct gss_cred {
+	struct rpc_cred		gc_base;
+	u32			gc_flavor;
+	struct gss_cl_ctx	*gc_ctx;
+};
+
+#define gc_uid			gc_base.cr_uid
+#define gc_count		gc_base.cr_count
+#define gc_flags		gc_base.cr_flags
+#define gc_expire		gc_base.cr_expire
+
+void print_hexl(u32 *p, u_int length, u_int offset);
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_SUNRPC_AUTH_GSS_H */
+
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/include/linux/sunrpc/auth.h linux-2.5.56-05-rpc_gss/include/linux/sunrpc/auth.h
--- linux-2.5.56-04-auth_upcall/include/linux/sunrpc/auth.h	2003-01-12 22:39:26.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/include/linux/sunrpc/auth.h	2003-01-12 22:40:13.000000000 +0100
@@ -13,12 +13,17 @@
 
 #include <linux/config.h>
 #include <linux/sunrpc/sched.h>
+#include <linux/sunrpc/msg_prot.h>
+#include <linux/sunrpc/xdr.h>
 
 #include <asm/atomic.h>
 
 /* size of the nodename buffer */
 #define UNX_MAXNODENAME	32
 
+/* Maximum size (in bytes) of an rpc credential or verifier */
+#define RPC_MAX_AUTH_SIZE (400)
+
 /* Work around the lack of a VFS credential */
 struct auth_cred {
 	uid_t	uid;
@@ -64,6 +69,10 @@
 	unsigned int		au_rslack;	/* reply verf size guess */
 	unsigned int		au_flags;	/* various flags */
 	struct rpc_authops *	au_ops;		/* operations */
+	rpc_authflavor_t	au_flavor;	/* pseudoflavor (note may
+						 * differ from the flavor in
+						 * au_ops->au_flavor in gss
+						 * case) */
 
 	/* per-flavor data */
 };
@@ -79,10 +88,10 @@
 #ifdef RPC_DEBUG
 	char *			au_name;
 #endif
-	struct rpc_auth *	(*create)(struct rpc_clnt *);
+	struct rpc_auth *	(*create)(struct rpc_clnt *, rpc_authflavor_t);
 	void			(*destroy)(struct rpc_auth *);
 
-	struct rpc_cred *	(*crcreate)(struct auth_cred *, int);
+	struct rpc_cred *	(*crcreate)(struct rpc_auth*, struct auth_cred *, int);
 };
 
 struct rpc_credops {
@@ -100,6 +109,8 @@
 extern struct rpc_authops	authdes_ops;
 #endif
 
+u32			pseudoflavor_to_flavor(rpc_authflavor_t);
+
 int			rpcauth_register(struct rpc_authops *);
 int			rpcauth_unregister(struct rpc_authops *);
 struct rpc_auth *	rpcauth_create(rpc_authflavor_t, struct rpc_clnt *);
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/include/linux/sunrpc/gss_api.h linux-2.5.56-05-rpc_gss/include/linux/sunrpc/gss_api.h
--- linux-2.5.56-04-auth_upcall/include/linux/sunrpc/gss_api.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/include/linux/sunrpc/gss_api.h	2003-01-12 22:40:13.000000000 +0100
@@ -0,0 +1,132 @@
+/*
+ * linux/include/linux/gss_api.h
+ *
+ * Somewhat simplified version of the gss api.
+ *
+ * Dug Song <dugsong@monkey.org>
+ * Andy Adamson <andros@umich.edu>
+ * Bruce Fields <bfields@umich.edu>
+ * Copyright (c) 2000 The Regents of the University of Michigan
+ *
+ * $Id$
+ */
+
+#ifndef _LINUX_SUNRPC_GSS_API_H
+#define _LINUX_SUNRPC_GSS_API_H
+
+#ifdef __KERNEL__
+#include <linux/sunrpc/xdr.h>
+
+/* The mechanism-independent gss-api context: */
+struct gss_ctx {
+	struct gss_api_mech	*mech_type;
+	void			*internal_ctx_id;
+};
+
+#define GSS_C_NO_BUFFER		((struct xdr_netobj) 0)
+#define GSS_C_NO_CONTEXT	((struct gss_ctx *) 0)
+#define GSS_C_NULL_OID		((struct xdr_netobj) 0)
+
+/*XXX  arbitrary length - is this set somewhere? */
+#define GSS_OID_MAX_LEN 32
+
+/* gss-api prototypes; note that these are somewhat simplified versions of
+ * the prototypes specified in RFC 2744. */
+u32 gss_import_sec_context(
+		struct xdr_netobj	*input_token,
+		struct gss_api_mech	*mech,
+		struct gss_ctx		**ctx_id);
+u32 gss_get_mic(
+		struct gss_ctx		*ctx_id,
+		u32			qop,
+		struct xdr_netobj	*message_buffer,
+		struct xdr_netobj	*message_token);
+u32 gss_verify_mic(
+		struct gss_ctx		*ctx_id,
+		struct xdr_netobj	*signbuf,
+		struct xdr_netobj	*checksum,
+		u32			*qstate);
+u32 gss_delete_sec_context(
+		struct gss_ctx		**ctx_id);
+
+/* We maintain a list of the pseudoflavors (equivalently, mechanism-qop-service
+ * triples) that we currently support: */
+
+struct sup_sec_triple {
+	struct list_head	triples;
+	u32			pseudoflavor;
+	struct gss_api_mech	*mech;
+	u32			qop;
+	u32			service;
+};
+
+int gss_register_triple(u32 pseudoflavor, struct gss_api_mech *mech, u32 qop,
+			u32 service);
+int gss_unregister_triple(u32 pseudoflavor);
+int gss_pseudoflavor_supported(u32 pseudoflavor);
+u32 gss_cmp_triples(u32 oid_len, char *oid_data, u32 qop, u32 service);
+u32 gss_get_pseudoflavor(struct gss_ctx *ctx_id, u32 qop, u32 service);
+u32 gss_pseudoflavor_to_service(u32 pseudoflavor);
+/* Both return NULL on failure: */
+struct gss_api_mech * gss_pseudoflavor_to_mech(u32 pseudoflavor);
+int gss_pseudoflavor_to_mechOID(u32 pseudoflavor, struct xdr_netobj *mech);
+
+/* Different mechanisms (e.g., krb5 or spkm3) may implement gss-api, and
+ * mechanisms may be dynamically registered or unregistered by modules.
+ * Our only built-in mechanism is a trivial debugging mechanism that provides
+ * no actual security; the following function registers that mechanism: */
+
+void gss_mech_register_debug(void);
+
+/* Each mechanism is described by the following struct: */
+struct gss_api_mech {
+	struct xdr_netobj	gm_oid;
+	struct list_head	gm_list;
+	atomic_t		gm_count;
+	struct gss_api_ops	*gm_ops;
+};
+
+/* and must provide the following operations: */
+struct gss_api_ops {
+	char *name;
+	u32 (*gss_import_sec_context)(
+			struct xdr_netobj	*input_token,
+			struct gss_ctx		*ctx_id);
+	u32 (*gss_get_mic)(
+			struct gss_ctx		*ctx_id,
+			u32			qop, 
+			struct xdr_netobj	*message_buffer,
+			struct xdr_netobj	*message_token);
+	u32 (*gss_verify_mic)(
+			struct gss_ctx		*ctx_id,
+			struct xdr_netobj	*signbuf,
+			struct xdr_netobj	*checksum,
+			u32			*qstate);
+	void (*gss_delete_sec_context)(
+			void			*internal_ctx_id);
+};
+
+/* Returns nonzero on failure. */
+int gss_mech_register(struct xdr_netobj *, struct gss_api_ops *);
+
+/* Returns nonzero iff someone still has a reference to this mech. */
+int gss_mech_unregister(struct gss_api_mech *);
+
+/* Returns nonzer iff someone still has a reference to some mech. */
+int gss_mech_unregister_all(void);
+
+/* returns a mechanism descriptor given an OID, an increments the mechanism's
+ * reference count. */
+struct gss_api_mech * gss_mech_get_by_OID(struct xdr_netobj *);
+
+/* Just increments the mechanism's reference count and returns its input: */
+struct gss_api_mech * gss_mech_get(struct gss_api_mech *);
+
+/* Returns nonzero iff you've released the last reference to this mech.
+ * Note that for every succesful gss_get_mech call there must be exactly
+ * one corresponding call to gss_mech_put.*/
+int gss_mech_put(struct gss_api_mech *);
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_SUNRPC_GSS_API_H */
+
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/include/linux/sunrpc/gss_asn1.h linux-2.5.56-05-rpc_gss/include/linux/sunrpc/gss_asn1.h
--- linux-2.5.56-04-auth_upcall/include/linux/sunrpc/gss_asn1.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/include/linux/sunrpc/gss_asn1.h	2003-01-12 22:40:13.000000000 +0100
@@ -0,0 +1,85 @@
+/*
+ *  linux/include/linux/sunrpc/gss_asn1.h
+ *
+ *  minimal asn1 for generic encoding/decoding of gss tokens
+ *
+ *  Adapted from MIT Kerberos 5-1.2.1 lib/include/krb5.h,
+ *  lib/gssapi/krb5/gssapiP_krb5.h, and others
+ *
+ *  Copyright (c) 2000 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Andy Adamson   <andros@umich.edu>
+ */
+
+/*
+ * Copyright 1995 by the Massachusetts Institute of Technology.
+ * All Rights Reserved.
+ *
+ * Export of this software from the United States of America may
+ *   require a specific license from the United States Government.
+ *   It is the responsibility of any person or organization contemplating
+ *   export to obtain such a license before exporting.
+ *
+ * WITHIN THAT CONSTRAINT, permission to use, copy, modify, and
+ * distribute this software and its documentation for any purpose and
+ * without fee is hereby granted, provided that the above copyright
+ * notice appear in all copies and that both that copyright notice and
+ * this permission notice appear in supporting documentation, and that
+ * the name of M.I.T. not be used in advertising or publicity pertaining
+ * to distribution of the software without specific, written prior
+ * permission.  Furthermore if you modify this software you must label
+ * your software as modified software and not distribute it in such a
+ * fashion that it might be confused with the original M.I.T. software.
+ * M.I.T. makes no representations about the suitability of
+ * this software for any purpose.  It is provided "as is" without express
+ * or implied warranty.
+ *
+ */
+
+
+#include <linux/sunrpc/gss_api.h>
+
+#define SIZEOF_INT 4
+
+/* from gssapi_err_generic.h */
+#define G_BAD_SERVICE_NAME                       (-2045022976L)
+#define G_BAD_STRING_UID                         (-2045022975L)
+#define G_NOUSER                                 (-2045022974L)
+#define G_VALIDATE_FAILED                        (-2045022973L)
+#define G_BUFFER_ALLOC                           (-2045022972L)
+#define G_BAD_MSG_CTX                            (-2045022971L)
+#define G_WRONG_SIZE                             (-2045022970L)
+#define G_BAD_USAGE                              (-2045022969L)
+#define G_UNKNOWN_QOP                            (-2045022968L)
+#define G_NO_HOSTNAME                            (-2045022967L)
+#define G_BAD_HOSTNAME                           (-2045022966L)
+#define G_WRONG_MECH                             (-2045022965L)
+#define G_BAD_TOK_HEADER                         (-2045022964L)
+#define G_BAD_DIRECTION                          (-2045022963L)
+#define G_TOK_TRUNC                              (-2045022962L)
+#define G_REFLECT                                (-2045022961L)
+#define G_WRONG_TOKID                            (-2045022960L)
+
+#define g_OID_equal(o1,o2) \
+   (((o1)->len == (o2)->len) && \
+    (memcmp((o1)->data,(o2)->data,(int) (o1)->len) == 0))
+
+u32 g_verify_token_header(
+     struct xdr_netobj *mech,
+     int *body_size,
+     unsigned char **buf_in,
+     int tok_type,
+     int toksize);
+
+u32 g_get_mech_oid(struct xdr_netobj *mech, struct xdr_netobj * in_buf);
+
+int g_token_size(
+     struct xdr_netobj *mech,
+     unsigned int body_size);
+
+void g_make_token_header(
+     struct xdr_netobj *mech,
+     int body_size,
+     unsigned char **buf,
+     int tok_type);
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/include/linux/sunrpc/gss_err.h linux-2.5.56-05-rpc_gss/include/linux/sunrpc/gss_err.h
--- linux-2.5.56-04-auth_upcall/include/linux/sunrpc/gss_err.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/include/linux/sunrpc/gss_err.h	2003-01-12 22:40:13.000000000 +0100
@@ -0,0 +1,177 @@
+/*
+ *  linux/include/sunrpc/gss_err.h
+ *
+ *  Adapted from MIT Kerberos 5-1.2.1 include/gssapi/gssapi.h
+ *
+ *  Copyright (c) 2002 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Andy Adamson   <andros@umich.edu>
+ */
+
+/*
+ * Copyright 1993 by OpenVision Technologies, Inc.
+ * 
+ * Permission to use, copy, modify, distribute, and sell this software
+ * and its documentation for any purpose is hereby granted without fee,
+ * provided that the above copyright notice appears in all copies and
+ * that both that copyright notice and this permission notice appear in
+ * supporting documentation, and that the name of OpenVision not be used
+ * in advertising or publicity pertaining to distribution of the software
+ * without specific, written prior permission. OpenVision makes no
+ * representations about the suitability of this software for any
+ * purpose.  It is provided "as is" without express or implied warranty.
+ * 
+ * OPENVISION DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
+ * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
+ * EVENT SHALL OPENVISION BE LIABLE FOR ANY SPECIAL, INDIRECT OR
+ * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
+ * USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
+ * OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
+ * PERFORMANCE OF THIS SOFTWARE.
+ */
+
+#ifndef _LINUX_SUNRPC_GSS_ERR_H
+#define _LINUX_SUNRPC_GSS_ERR_H
+
+#ifdef __KERNEL__
+
+typedef unsigned int OM_uint32;
+
+/*
+ * Flag bits for context-level services.
+ */
+#define GSS_C_DELEG_FLAG 1
+#define GSS_C_MUTUAL_FLAG 2
+#define GSS_C_REPLAY_FLAG 4
+#define GSS_C_SEQUENCE_FLAG 8
+#define GSS_C_CONF_FLAG 16
+#define GSS_C_INTEG_FLAG 32
+#define	GSS_C_ANON_FLAG 64
+#define GSS_C_PROT_READY_FLAG 128
+#define GSS_C_TRANS_FLAG 256
+
+/*
+ * Credential usage options
+ */
+#define GSS_C_BOTH 0
+#define GSS_C_INITIATE 1
+#define GSS_C_ACCEPT 2
+
+/*
+ * Status code types for gss_display_status
+ */
+#define GSS_C_GSS_CODE 1
+#define GSS_C_MECH_CODE 2
+
+
+/*
+ * Define the default Quality of Protection for per-message services.  Note
+ * that an implementation that offers multiple levels of QOP may either reserve
+ * a value (for example zero, as assumed here) to mean "default protection", or
+ * alternatively may simply equate GSS_C_QOP_DEFAULT to a specific explicit
+ * QOP value.  However a value of 0 should always be interpreted by a GSSAPI
+ * implementation as a request for the default protection level.
+ */
+#define GSS_C_QOP_DEFAULT 0
+
+/*
+ * Expiration time of 2^32-1 seconds means infinite lifetime for a
+ * credential or security context
+ */
+#define GSS_C_INDEFINITE ((OM_uint32) 0xfffffffful)
+
+
+/* Major status codes */
+
+#define GSS_S_COMPLETE 0
+
+/*
+ * Some "helper" definitions to make the status code macros obvious.
+ */
+#define GSS_C_CALLING_ERROR_OFFSET 24
+#define GSS_C_ROUTINE_ERROR_OFFSET 16
+#define GSS_C_SUPPLEMENTARY_OFFSET 0
+#define GSS_C_CALLING_ERROR_MASK ((OM_uint32) 0377ul)
+#define GSS_C_ROUTINE_ERROR_MASK ((OM_uint32) 0377ul)
+#define GSS_C_SUPPLEMENTARY_MASK ((OM_uint32) 0177777ul)
+
+/*
+ * The macros that test status codes for error conditions.  Note that the
+ * GSS_ERROR() macro has changed slightly from the V1 GSSAPI so that it now
+ * evaluates its argument only once.
+ */
+#define GSS_CALLING_ERROR(x) \
+  ((x) & (GSS_C_CALLING_ERROR_MASK << GSS_C_CALLING_ERROR_OFFSET))
+#define GSS_ROUTINE_ERROR(x) \
+  ((x) & (GSS_C_ROUTINE_ERROR_MASK << GSS_C_ROUTINE_ERROR_OFFSET))
+#define GSS_SUPPLEMENTARY_INFO(x) \
+  ((x) & (GSS_C_SUPPLEMENTARY_MASK << GSS_C_SUPPLEMENTARY_OFFSET))
+#define GSS_ERROR(x) \
+  ((x) & ((GSS_C_CALLING_ERROR_MASK << GSS_C_CALLING_ERROR_OFFSET) | \
+	  (GSS_C_ROUTINE_ERROR_MASK << GSS_C_ROUTINE_ERROR_OFFSET)))
+
+/*
+ * Now the actual status code definitions
+ */
+
+/*
+ * Calling errors:
+ */
+#define GSS_S_CALL_INACCESSIBLE_READ \
+                             (((OM_uint32) 1ul) << GSS_C_CALLING_ERROR_OFFSET)
+#define GSS_S_CALL_INACCESSIBLE_WRITE \
+                             (((OM_uint32) 2ul) << GSS_C_CALLING_ERROR_OFFSET)
+#define GSS_S_CALL_BAD_STRUCTURE \
+                             (((OM_uint32) 3ul) << GSS_C_CALLING_ERROR_OFFSET)
+
+/*
+ * Routine errors:
+ */
+#define GSS_S_BAD_MECH (((OM_uint32) 1ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_BAD_NAME (((OM_uint32) 2ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_BAD_NAMETYPE (((OM_uint32) 3ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_BAD_BINDINGS (((OM_uint32) 4ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_BAD_STATUS (((OM_uint32) 5ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_BAD_SIG (((OM_uint32) 6ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_NO_CRED (((OM_uint32) 7ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_NO_CONTEXT (((OM_uint32) 8ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_DEFECTIVE_TOKEN (((OM_uint32) 9ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_DEFECTIVE_CREDENTIAL \
+     (((OM_uint32) 10ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_CREDENTIALS_EXPIRED \
+     (((OM_uint32) 11ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_CONTEXT_EXPIRED \
+     (((OM_uint32) 12ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_FAILURE (((OM_uint32) 13ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_BAD_QOP (((OM_uint32) 14ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_UNAUTHORIZED (((OM_uint32) 15ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_UNAVAILABLE (((OM_uint32) 16ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_DUPLICATE_ELEMENT \
+     (((OM_uint32) 17ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+#define GSS_S_NAME_NOT_MN \
+     (((OM_uint32) 18ul) << GSS_C_ROUTINE_ERROR_OFFSET)
+
+/*
+ * Supplementary info bits:
+ */
+#define GSS_S_CONTINUE_NEEDED (1 << (GSS_C_SUPPLEMENTARY_OFFSET + 0))
+#define GSS_S_DUPLICATE_TOKEN (1 << (GSS_C_SUPPLEMENTARY_OFFSET + 1))
+#define GSS_S_OLD_TOKEN (1 << (GSS_C_SUPPLEMENTARY_OFFSET + 2))
+#define GSS_S_UNSEQ_TOKEN (1 << (GSS_C_SUPPLEMENTARY_OFFSET + 3))
+#define GSS_S_GAP_TOKEN (1 << (GSS_C_SUPPLEMENTARY_OFFSET + 4))
+
+/* XXXX these are not part of the GSSAPI C bindings!  (but should be) */
+
+#define GSS_CALLING_ERROR_FIELD(x) \
+   (((x) >> GSS_C_CALLING_ERROR_OFFSET) & GSS_C_CALLING_ERROR_MASK)
+#define GSS_ROUTINE_ERROR_FIELD(x) \
+   (((x) >> GSS_C_ROUTINE_ERROR_OFFSET) & GSS_C_ROUTINE_ERROR_MASK)
+#define GSS_SUPPLEMENTARY_INFO_FIELD(x) \
+   (((x) >> GSS_C_SUPPLEMENTARY_OFFSET) & GSS_C_SUPPLEMENTARY_MASK)
+
+/* XXXX This is a necessary evil until the spec is fixed */
+#define GSS_S_CRED_UNAVAIL GSS_S_FAILURE
+
+#endif /* __KERNEL__ */
+#endif /* __LINUX_SUNRPC_GSS_ERR_H */
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/include/linux/sunrpc/msg_prot.h linux-2.5.56-05-rpc_gss/include/linux/sunrpc/msg_prot.h
--- linux-2.5.56-04-auth_upcall/include/linux/sunrpc/msg_prot.h	2002-09-18 12:05:34.000000000 +0200
+++ linux-2.5.56-05-rpc_gss/include/linux/sunrpc/msg_prot.h	2003-01-12 22:40:13.000000000 +0100
@@ -20,7 +20,18 @@
 	RPC_AUTH_SHORT = 2,
 	RPC_AUTH_DES   = 3,
 	RPC_AUTH_KRB   = 4,
+	RPC_AUTH_GSS   = 6,
 	RPC_AUTH_MAXFLAVOR = 8,
+	/* pseudoflavors: */
+	RPC_AUTH_GSS_KRB5  = 390003,
+	RPC_AUTH_GSS_KRB5I = 390004,
+	RPC_AUTH_GSS_KRB5P = 390005,
+	RPC_AUTH_GSS_LKEY  = 390006,
+	RPC_AUTH_GSS_LKEYI = 390007,
+	RPC_AUTH_GSS_LKEYP = 390008,
+	RPC_AUTH_GSS_SPKM  = 390009,
+	RPC_AUTH_GSS_SPKMI = 390010,
+	RPC_AUTH_GSS_SPKMP = 390011,
 };
 
 enum rpc_msg_type {
@@ -53,7 +64,10 @@
 	RPC_AUTH_REJECTEDCRED = 2,
 	RPC_AUTH_BADVERF = 3,
 	RPC_AUTH_REJECTEDVERF = 4,
-	RPC_AUTH_TOOWEAK = 5
+	RPC_AUTH_TOOWEAK = 5,
+	/* RPCSEC_GSS errors */
+	RPCSEC_GSS_CREDPROBLEM = 13,
+	RPCSEC_GSS_CTXPROBLEM = 14
 };
 
 #define RPC_PMAP_PROGRAM	100000
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/include/linux/sunrpc/sched.h linux-2.5.56-05-rpc_gss/include/linux/sunrpc/sched.h
--- linux-2.5.56-04-auth_upcall/include/linux/sunrpc/sched.h	2002-11-13 13:34:36.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/include/linux/sunrpc/sched.h	2003-01-12 22:40:13.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/timer.h>
 #include <linux/sunrpc/types.h>
 #include <linux/wait.h>
+#include <linux/sunrpc/xdr.h>
 
 /*
  * This is the actual RPC procedure call info.
@@ -47,6 +48,8 @@
 	__u8			tk_garb_retry,
 				tk_cred_retry,
 				tk_suid_retry;
+	u32			tk_gss_seqno;	/* rpcsec_gss sequence number
+						   used on this request */
 
 	/*
 	 * timeout_fn   to be executed by timer bottom half
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/include/linux/sunrpc/xdr.h linux-2.5.56-05-rpc_gss/include/linux/sunrpc/xdr.h
--- linux-2.5.56-04-auth_upcall/include/linux/sunrpc/xdr.h	2002-12-10 11:04:42.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/include/linux/sunrpc/xdr.h	2003-01-12 22:40:13.000000000 +0100
@@ -80,7 +80,9 @@
 #define	rpc_autherr_badverf	__constant_htonl(RPC_AUTH_BADVERF)
 #define	rpc_autherr_rejectedverf __constant_htonl(RPC_AUTH_REJECTEDVERF)
 #define	rpc_autherr_tooweak	__constant_htonl(RPC_AUTH_TOOWEAK)
-
+#define	rpcsec_gsserr_credproblem	__constant_htonl(RPCSEC_GSS_CREDPROBLEM)
+#define	rpcsec_gsserr_ctxproblem	__constant_htonl(RPCSEC_GSS_CTXPROBLEM)
+#define	rpc_autherr_oldseqnum	__constant_htonl(101)
 
 /*
  * Miscellaneous XDR helper functions
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/net/sunrpc/auth.c linux-2.5.56-05-rpc_gss/net/sunrpc/auth.c
--- linux-2.5.56-04-auth_upcall/net/sunrpc/auth.c	2003-01-12 22:39:26.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/net/sunrpc/auth.c	2003-01-12 22:40:13.000000000 +0100
@@ -24,6 +24,13 @@
 	NULL,			/* others can be loadable modules */
 };
 
+u32
+pseudoflavor_to_flavor(u32 flavor) {
+	if (flavor >= RPC_AUTH_MAXFLAVOR)
+		return RPC_AUTH_GSS;
+	return flavor;
+}
+
 int
 rpcauth_register(struct rpc_authops *ops)
 {
@@ -51,13 +58,14 @@
 }
 
 struct rpc_auth *
-rpcauth_create(rpc_authflavor_t flavor, struct rpc_clnt *clnt)
+rpcauth_create(rpc_authflavor_t pseudoflavor, struct rpc_clnt *clnt)
 {
 	struct rpc_authops	*ops;
+	u32			flavor = pseudoflavor_to_flavor(pseudoflavor);
 
 	if (flavor >= RPC_AUTH_MAXFLAVOR || !(ops = auth_flavors[flavor]))
 		return NULL;
-	clnt->cl_auth = ops->create(clnt);
+	clnt->cl_auth = ops->create(clnt, pseudoflavor);
 	return clnt->cl_auth;
 }
 
@@ -218,7 +226,7 @@
 	rpcauth_destroy_credlist(&free);
 
 	if (!cred) {
-		new = auth->au_ops->crcreate(acred, taskflags);
+		new = auth->au_ops->crcreate(auth, acred, taskflags);
 		if (new) {
 #ifdef RPC_DEBUG
 			new->cr_magic = RPCAUTH_CRED_MAGIC;
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/net/sunrpc/auth_gss/auth_gss.c linux-2.5.56-05-rpc_gss/net/sunrpc/auth_gss/auth_gss.c
--- linux-2.5.56-04-auth_upcall/net/sunrpc/auth_gss/auth_gss.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/net/sunrpc/auth_gss/auth_gss.c	2003-01-12 22:40:13.000000000 +0100
@@ -0,0 +1,378 @@
+/*
+ * linux/net/sunrpc/auth_gss.c
+ *
+ * RPCSEC_GSS client authentication.
+ * 
+ *  Copyright (c) 2000 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Dug Song       <dugsong@monkey.org>
+ *  Andy Adamson   <andros@umich.edu>
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *  1. Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *  2. Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in the
+ *     documentation and/or other materials provided with the distribution.
+ *  3. Neither the name of the University nor the names of its
+ *     contributors may be used to endorse or promote products derived
+ *     from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ *  DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ *  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ *  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ *  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ *  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
+ *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * $Id$
+ */
+
+
+#define __NO_VERSION__
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/socket.h>
+#include <linux/in.h>
+#include <linux/sched.h>
+#include <linux/sunrpc/clnt.h>
+#include <linux/sunrpc/auth.h>
+#include <linux/sunrpc/auth_gss.h>
+#include <linux/sunrpc/gss_err.h>
+
+static struct rpc_authops authgss_ops;
+
+static struct rpc_credops gss_credops;
+
+#ifdef RPC_DEBUG
+# define RPCDBG_FACILITY	RPCDBG_AUTH
+#endif
+
+#define NFS_NGROUPS	16
+
+#define GSS_CRED_EXPIRE		(60 * HZ)	/* XXX: reasonable? */
+#define GSS_CRED_SLACK		1024		/* XXX: unused */
+#define GSS_VERF_SLACK		48		/* length of a krb5 verifier.*/
+
+/* XXX this define must match the gssd define
+* as it is passed to gssd to signal the use of
+* machine creds should be part of the shared rpc interface */
+
+#define CA_RUN_AS_MACHINE  0x00000200 
+
+/* dump the buffer in `emacs-hexl' style */
+#define isprint(c)      ((c > 0x1f) && (c < 0x7f))
+
+void
+print_hexl(u32 *p, u_int length, u_int offset)
+{
+	u_int i, j, jm;
+	u8 c, *cp;
+	
+	dprintk("RPC: print_hexl: length %d\n",length);
+	dprintk("\n");
+	cp = (u8 *) p;
+	
+	for (i = 0; i < length; i += 0x10) {
+		dprintk("  %04x: ", (u_int)(i + offset));
+		jm = length - i;
+		jm = jm > 16 ? 16 : jm;
+		
+		for (j = 0; j < jm; j++) {
+			if ((j % 2) == 1)
+				dprintk("%02x ", (u_int)cp[i+j]);
+			else
+				dprintk("%02x", (u_int)cp[i+j]);
+		}
+		for (; j < 16; j++) {
+			if ((j % 2) == 1)
+				dprintk("   ");
+			else
+				dprintk("  ");
+		}
+		dprintk(" ");
+		
+		for (j = 0; j < jm; j++) {
+			c = cp[i+j];
+			c = isprint(c) ? c : '.';
+			dprintk("%c", c);
+		}
+		dprintk("\n");
+	}
+}
+
+
+/* 
+ * NOTE: we have the opportunity to use different 
+ * parameters based on the input flavor (which must be a pseudoflavor)
+ */
+static struct rpc_auth *
+gss_create(struct rpc_clnt *clnt, rpc_authflavor_t flavor)
+{
+	struct rpc_auth * auth;
+
+	dprintk("RPC: creating GSS authenticator for client %p\n",clnt);
+	if (!try_module_get(THIS_MODULE))
+		return NULL;
+	if (!(auth = kmalloc(sizeof(*auth), GFP_KERNEL)))
+		goto out_dec;
+	auth->au_cslack = GSS_CRED_SLACK >> 2;
+	auth->au_rslack = GSS_VERF_SLACK >> 2;
+	auth->au_expire = GSS_CRED_EXPIRE;
+	auth->au_ops = &authgss_ops;
+	auth->au_flavor = flavor;
+
+	rpcauth_init_credcache(auth);
+
+	return auth;
+out_dec:
+	module_put(THIS_MODULE);
+	return NULL;
+}
+
+static void
+gss_destroy(struct rpc_auth *auth)
+{
+	dprintk("RPC: destroying GSS authenticator %p flavor %d\n",
+		auth, auth->au_flavor);
+
+	rpcauth_free_credcache(auth);
+
+	kfree(auth);
+	module_put(THIS_MODULE);
+}
+
+/* gss_destroy_cred (and gss_destroy_ctx) are used to clean up after failure
+ * to create a new cred or context, so they check that things have been
+ * allocated before freeing them. */
+void
+gss_destroy_ctx(struct gss_cl_ctx *ctx)
+{
+
+	dprintk("RPC: gss_destroy_ctx\n");
+
+	if (ctx->gc_gss_ctx)
+		gss_delete_sec_context(&ctx->gc_gss_ctx);
+
+	if (ctx->gc_wire_ctx.len > 0) {
+		kfree(ctx->gc_wire_ctx.data);
+		ctx->gc_wire_ctx.len = 0;
+	}
+
+	kfree(ctx);
+
+}
+
+static void
+gss_destroy_cred(struct rpc_cred *rc)
+{
+	struct gss_cred *cred = (struct gss_cred *)rc;
+
+	dprintk("RPC: gss_destroy_cred \n");
+
+	if (cred->gc_ctx)
+		gss_destroy_ctx(cred->gc_ctx);
+	kfree(cred);
+}
+
+static struct rpc_cred *
+gss_create_cred(struct rpc_auth *auth, struct auth_cred *acred, int taskflags)
+{
+	struct gss_cred	*cred = NULL;
+
+	dprintk("RPC: gss_create_cred for uid %d, flavor %d\n",
+		acred->uid, auth->au_flavor);
+
+	if (!(cred = kmalloc(sizeof(*cred), GFP_KERNEL)))
+		goto out_err;
+
+	memset(cred, 0, sizeof(*cred));
+	atomic_set(&cred->gc_count, 0);
+	cred->gc_uid = acred->uid;
+	/*
+	 * Note: in order to force a call to call_refresh(), we deliberately
+	 * fail to flag the credential as RPCAUTH_CRED_UPTODATE.
+	 */
+	cred->gc_flags = 0;
+	cred->gc_base.cr_ops = &gss_credops;
+	cred->gc_flavor = auth->au_flavor;
+
+	return (struct rpc_cred *) cred;
+
+out_err:
+	dprintk("RPC: gss_create_cred failed\n");
+	if (cred) gss_destroy_cred((struct rpc_cred *)cred);
+	return NULL;
+}
+
+static int
+gss_match(struct auth_cred *acred, struct rpc_cred *rc, int taskflags)
+{
+	return (rc->cr_uid == acred->uid);
+}
+
+/*
+* Marshal credentials.
+* Maybe we should keep a cached credential for performance reasons.
+*/
+static u32 *
+gss_marshal(struct rpc_task *task, u32 *p, int ruid)
+{
+	struct gss_cred	*cred = (struct gss_cred *) task->tk_msg.rpc_cred;
+	struct gss_cl_ctx	*ctx = cred->gc_ctx;
+	u32		*cred_len;
+	struct rpc_rqst *req = task->tk_rqstp;
+	struct rpc_clnt *clnt = task->tk_client;
+	struct rpc_xprt *xprt = clnt->cl_xprt;
+	u32             *verfbase = req->rq_svec[0].iov_base; 
+	u32             maj_stat = 0;
+	struct xdr_netobj bufin,bufout;
+	u32		service;
+
+	dprintk("RPC: gss_marshal\n");
+
+	/* We compute the checksum for the verifier over the xdr-encoded bytes
+	 * starting with the xid (which verfbase points to) and ending at
+	 * the end of the credential. */
+	if (xprt->stream)
+		verfbase++; /* See clnt.c:call_header() */
+
+	*p++ = htonl(RPC_AUTH_GSS);
+	cred_len = p++;
+
+	service = gss_pseudoflavor_to_service(cred->gc_flavor);
+	if (service == 0) {
+		dprintk("Bad pseudoflavor %d in gss_marshal\n",
+			cred->gc_flavor);
+		return NULL;
+	}
+	spin_lock(&ctx->gc_seq_lock);
+	task->tk_gss_seqno = ctx->gc_seq++;
+	spin_unlock(&ctx->gc_seq_lock);
+
+	*p++ = htonl((u32) RPC_GSS_VERSION);
+	*p++ = htonl((u32) ctx->gc_proc);
+	*p++ = htonl((u32) task->tk_gss_seqno);
+	*p++ = htonl((u32) service);
+	p = xdr_encode_netobj(p, &ctx->gc_wire_ctx);
+	*cred_len = htonl((p - (cred_len + 1)) << 2);
+
+	/* Marshal verifier. */
+	bufin.data = (u8 *)verfbase;
+	bufin.len = (p - verfbase) << 2;
+
+	/* set verifier flavor*/
+	*p++ = htonl(RPC_AUTH_GSS);
+
+	maj_stat = gss_get_mic(ctx->gc_gss_ctx,
+			       GSS_C_QOP_DEFAULT, 
+			       &bufin, &bufout);
+	if(maj_stat != 0){
+		printk("gss_marshal: gss_get_mic FAILED (%d)\n",
+		       maj_stat);
+		return(NULL);
+	}
+	p = xdr_encode_netobj(p, &bufout);
+	return p;
+}
+
+/*
+* Refresh credentials. XXX - finish
+*/
+static int
+gss_refresh(struct rpc_task *task)
+{
+	/* Insert upcall here ! */
+	task->tk_msg.rpc_cred->cr_flags |= RPCAUTH_CRED_UPTODATE;
+	return task->tk_status = -EACCES;
+}
+
+static u32 *
+gss_validate(struct rpc_task *task, u32 *p)
+{
+	struct gss_cred *cred = (struct gss_cred *)task->tk_msg.rpc_cred; 
+	struct gss_cl_ctx	*ctx = cred->gc_ctx;
+	u32		seq, qop_state;
+	struct xdr_netobj bufin;
+	struct xdr_netobj bufout;
+	u32		flav,len;
+	int             code = 0;
+
+	dprintk("RPC: gss_validate\n");
+
+	flav = ntohl(*p++);
+	if ((len = ntohl(*p++)) > RPC_MAX_AUTH_SIZE) {
+                printk("RPC: giant verf size: %ld\n", (unsigned long) len);
+                return NULL;
+	}
+	dprintk("RPC: gss_validate: verifier flavor %d, len %d\n", flav, len);
+
+	if (flav != RPC_AUTH_GSS) {
+		printk("RPC: bad verf flavor: %ld\n", (unsigned long)flav);
+		return NULL;
+	}
+	seq = htonl(task->tk_gss_seqno);
+	bufin.data = (u8 *) &seq;
+	bufin.len = sizeof(seq);
+	bufout.data = (u8 *) p;
+	bufout.len = len;
+
+	if ((code = gss_verify_mic(ctx->gc_gss_ctx, 
+				   &bufin, &bufout, &qop_state) < 0))
+		return NULL;
+	task->tk_auth->au_rslack = XDR_QUADLEN(len) + 2;
+	dprintk("RPC: GSS gss_validate: gss_verify_mic succeeded.\n");
+	return p + XDR_QUADLEN(len);
+}
+
+static struct rpc_authops authgss_ops = {
+	.au_flavor	= RPC_AUTH_GSS,
+#ifdef RPC_DEBUG
+	.au_name	= "RPCSEC_GSS",
+#endif
+	.create		= gss_create,
+	.destroy	= gss_destroy,
+	.crcreate	= gss_create_cred
+};
+
+static struct rpc_credops gss_credops = {
+	.crdestroy	= gss_destroy_cred,
+	.crmatch	= gss_match,
+	.crmarshal	= gss_marshal,
+	.crrefresh	= gss_refresh,
+	.crvalidate	= gss_validate,
+};
+
+extern void gss_svc_ctx_init(void);
+
+/*
+ * Initialize RPCSEC_GSS module
+ */
+static int __init init_rpcsec_gss(void)
+{
+	int err = 0;
+
+	err = rpcauth_register(&authgss_ops);
+	return err;
+}
+
+static void __exit exit_rpcsec_gss(void)
+{
+	gss_mech_unregister_all();
+	rpcauth_unregister(&authgss_ops);
+}
+
+MODULE_LICENSE("GPL");
+module_init(init_rpcsec_gss)
+module_exit(exit_rpcsec_gss)
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/net/sunrpc/auth_gss/gss_generic_token.c linux-2.5.56-05-rpc_gss/net/sunrpc/auth_gss/gss_generic_token.c
--- linux-2.5.56-04-auth_upcall/net/sunrpc/auth_gss/gss_generic_token.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/net/sunrpc/auth_gss/gss_generic_token.c	2003-01-12 22:40:13.000000000 +0100
@@ -0,0 +1,269 @@
+/*
+ *  linux/net/sunrpc/gss_generic_token.c
+ *
+ *  Adapted from MIT Kerberos 5-1.2.1 lib/gssapi/generic/util_token.c
+ *
+ *  Copyright (c) 2000 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Andy Adamson   <andros@umich.edu>
+ */
+
+/*
+ * Copyright 1993 by OpenVision Technologies, Inc.
+ * 
+ * Permission to use, copy, modify, distribute, and sell this software
+ * and its documentation for any purpose is hereby granted without fee,
+ * provided that the above copyright notice appears in all copies and
+ * that both that copyright notice and this permission notice appear in
+ * supporting documentation, and that the name of OpenVision not be used
+ * in advertising or publicity pertaining to distribution of the software
+ * without specific, written prior permission. OpenVision makes no
+ * representations about the suitability of this software for any
+ * purpose.  It is provided "as is" without express or implied warranty.
+ * 
+ * OPENVISION DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
+ * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
+ * EVENT SHALL OPENVISION BE LIABLE FOR ANY SPECIAL, INDIRECT OR
+ * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
+ * USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
+ * OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
+ * PERFORMANCE OF THIS SOFTWARE.
+ */
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sunrpc/sched.h>
+#include <linux/sunrpc/gss_asn1.h>
+
+
+#ifdef RPC_DEBUG
+# define RPCDBG_FACILITY        RPCDBG_AUTH
+#endif
+
+
+/* TWRITE_STR from gssapiP_generic.h */
+#define TWRITE_STR(ptr, str, len) \
+	memcpy((ptr), (char *) (str), (len)); \
+	(ptr) += (len);
+
+/* XXXX this code currently makes the assumption that a mech oid will
+   never be longer than 127 bytes.  This assumption is not inherent in
+   the interfaces, so the code can be fixed if the OSI namespace
+   balloons unexpectedly. */
+
+/* Each token looks like this:
+
+0x60				tag for APPLICATION 0, SEQUENCE
+					(constructed, definite-length)
+	<length>		possible multiple bytes, need to parse/generate
+	0x06			tag for OBJECT IDENTIFIER
+		<moid_length>	compile-time constant string (assume 1 byte)
+		<moid_bytes>	compile-time constant string
+	<inner_bytes>		the ANY containing the application token
+					bytes 0,1 are the token type
+					bytes 2,n are the token data
+
+For the purposes of this abstraction, the token "header" consists of
+the sequence tag and length octets, the mech OID DER encoding, and the
+first two inner bytes, which indicate the token type.  The token
+"body" consists of everything else.
+
+*/
+
+static int
+der_length_size( int length)
+{
+	if (length < (1<<7))
+		return(1);
+	else if (length < (1<<8))
+		return(2);
+#if (SIZEOF_INT == 2)
+	else
+		return(3);
+#else
+	else if (length < (1<<16))
+		return(3);
+	else if (length < (1<<24))
+		return(4);
+	else
+		return(5);
+#endif
+}
+
+static void
+der_write_length(unsigned char **buf, int length)
+{
+	if (length < (1<<7)) {
+		*(*buf)++ = (unsigned char) length;
+	} else {
+		*(*buf)++ = (unsigned char) (der_length_size(length)+127);
+#if (SIZEOF_INT > 2)
+		if (length >= (1<<24))
+			*(*buf)++ = (unsigned char) (length>>24);
+		if (length >= (1<<16))
+			*(*buf)++ = (unsigned char) ((length>>16)&0xff);
+#endif
+		if (length >= (1<<8))
+			*(*buf)++ = (unsigned char) ((length>>8)&0xff);
+		*(*buf)++ = (unsigned char) (length&0xff);
+	}
+}
+
+/* returns decoded length, or < 0 on failure.  Advances buf and
+   decrements bufsize */
+
+static int
+der_read_length(unsigned char **buf, int *bufsize)
+{
+	unsigned char sf;
+	int ret;
+
+	if (*bufsize < 1)
+		return(-1);
+	sf = *(*buf)++;
+	(*bufsize)--;
+	if (sf & 0x80) {
+		if ((sf &= 0x7f) > ((*bufsize)-1))
+			return(-1);
+		if (sf > SIZEOF_INT)
+			return (-1);
+		ret = 0;
+		for (; sf; sf--) {
+			ret = (ret<<8) + (*(*buf)++);
+			(*bufsize)--;
+		}
+	} else {
+		ret = sf;
+	}
+
+	return(ret);
+}
+
+/* returns the length of a token, given the mech oid and the body size */
+
+int
+g_token_size(struct xdr_netobj *mech, unsigned int body_size)
+{
+	/* set body_size to sequence contents size */
+	body_size += 4 + (int) mech->len;         /* NEED overflow check */
+	return(1 + der_length_size(body_size) + body_size);
+}
+
+/* fills in a buffer with the token header.  The buffer is assumed to
+   be the right size.  buf is advanced past the token header */
+
+void
+g_make_token_header(struct xdr_netobj *mech, int body_size, unsigned char **buf,
+		int tok_type)
+{
+	*(*buf)++ = 0x60;
+	der_write_length(buf, 4 + mech->len + body_size);
+	*(*buf)++ = 0x06;
+	*(*buf)++ = (unsigned char) mech->len;
+	TWRITE_STR(*buf, mech->data, ((int) mech->len));
+	*(*buf)++ = (unsigned char) ((tok_type>>8)&0xff);
+	*(*buf)++ = (unsigned char) (tok_type&0xff);
+}
+
+/*
+ * Given a buffer containing a token, reads and verifies the token,
+ * leaving buf advanced past the token header, and setting body_size
+ * to the number of remaining bytes.  Returns 0 on success,
+ * G_BAD_TOK_HEADER for a variety of errors, and G_WRONG_MECH if the
+ * mechanism in the token does not match the mech argument.  buf and
+ * *body_size are left unmodified on error.
+ */
+u32
+g_verify_token_header(struct xdr_netobj *mech, int *body_size,
+		      unsigned char **buf_in, int tok_type, int toksize)
+{
+	unsigned char *buf = *buf_in;
+	int seqsize;
+	struct xdr_netobj toid;
+	int ret = 0;
+
+	if ((toksize-=1) < 0)
+		return(G_BAD_TOK_HEADER);
+	if (*buf++ != 0x60)
+		return(G_BAD_TOK_HEADER);
+
+	if ((seqsize = der_read_length(&buf, &toksize)) < 0)
+		return(G_BAD_TOK_HEADER);
+
+	if (seqsize != toksize)
+		return(G_BAD_TOK_HEADER);
+
+	if ((toksize-=1) < 0)
+		return(G_BAD_TOK_HEADER);
+	if (*buf++ != 0x06)
+		return(G_BAD_TOK_HEADER);
+ 
+	if ((toksize-=1) < 0)
+		return(G_BAD_TOK_HEADER);
+	toid.len = *buf++;
+
+	if ((toksize-=toid.len) < 0)
+		return(G_BAD_TOK_HEADER);
+	toid.data = buf;
+	buf+=toid.len;
+
+	if (! g_OID_equal(&toid, mech)) 
+		ret = G_WRONG_MECH;
+ 
+   /* G_WRONG_MECH is not returned immediately because it's more important
+      to return G_BAD_TOK_HEADER if the token header is in fact bad */
+
+	if ((toksize-=2) < 0)
+		return(G_BAD_TOK_HEADER);
+
+	if (ret)
+		return(ret);
+
+	if ((*buf++ != ((tok_type>>8)&0xff)) || (*buf++ != (tok_type&0xff))) 
+		return(G_WRONG_TOKID);
+
+	if (!ret) {
+		*buf_in = buf;
+		*body_size = toksize;
+	}
+
+	return(ret);
+}
+
+/* Given a buffer containing a token, returns a copy of the mech oid in
+ * the parameter mech. */
+u32
+g_get_mech_oid(struct xdr_netobj *mech, struct xdr_netobj * in_buf)
+{
+	unsigned char *buf = in_buf->data;
+	int len = in_buf->len;
+	int ret=0;
+	int seqsize;
+
+	if ((len-=1) < 0)
+		return(G_BAD_TOK_HEADER);
+	if (*buf++ != 0x60)
+		return(G_BAD_TOK_HEADER);
+
+	if ((seqsize = der_read_length(&buf, &len)) < 0)
+		return(G_BAD_TOK_HEADER);
+
+	if ((len-=1) < 0)
+		return(G_BAD_TOK_HEADER);
+	if (*buf++ != 0x06)
+		return(G_BAD_TOK_HEADER);
+
+	if ((len-=1) < 0)
+		return(G_BAD_TOK_HEADER);
+	mech->len = *buf++;
+
+	if ((len-=mech->len) < 0)
+		return(G_BAD_TOK_HEADER);
+	if (!(mech->data = kmalloc(mech->len, GFP_KERNEL))) 
+		return(G_BUFFER_ALLOC);
+	memcpy(mech->data, buf, mech->len);
+
+	return ret;
+}
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/net/sunrpc/auth_gss/gss_mech_switch.c linux-2.5.56-05-rpc_gss/net/sunrpc/auth_gss/gss_mech_switch.c
--- linux-2.5.56-04-auth_upcall/net/sunrpc/auth_gss/gss_mech_switch.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/net/sunrpc/auth_gss/gss_mech_switch.c	2003-01-12 22:40:13.000000000 +0100
@@ -0,0 +1,243 @@
+/*
+ *  linux/net/sunrpc/gss_mech_switch.c
+ *
+ *  Copyright (c) 2001 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  J. Bruce Fields   <bfields@umich.edu>
+ *
+ *  Redistribution and use in source and binary forms, with or without 
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *  1. Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *  2. Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in the 
+ *     documentation and/or other materials provided with the distribution.
+ *  3. Neither the name of the University nor the names of its
+ *     contributors may be used to endorse or promote products derived
+ *     from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ *  DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ *  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ *  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ *  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ *  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
+ *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/socket.h>
+#include <linux/sunrpc/msg_prot.h>
+#include <linux/sunrpc/gss_asn1.h>
+#include <linux/sunrpc/auth_gss.h>
+#include <linux/sunrpc/gss_err.h>
+#include <linux/sunrpc/sched.h>
+#include <linux/sunrpc/gss_api.h>
+#include <linux/sunrpc/clnt.h>
+#include <linux/sunrpc/name_lookup.h>
+
+#ifdef RPC_DEBUG
+# define RPCDBG_FACILITY        RPCDBG_AUTH
+#endif
+
+static LIST_HEAD(registered_mechs);
+static spinlock_t registered_mechs_lock = SPIN_LOCK_UNLOCKED;
+
+/* Reference counting: The reference count includes the reference in the
+ * global registered_mechs list.  That reference will never diseappear
+ * (so the reference count will never go below 1) until after the mech
+ * is removed from the list.  Nothing can be removed from the list without
+ * first getting the registered_mechs_lock, so a gss_api_mech won't diseappear
+ * from underneath us while we hold the registered_mech_lock.  */
+
+int
+gss_mech_register(struct xdr_netobj * mech_type, struct gss_api_ops * ops)
+{
+	struct gss_api_mech *gm;
+
+	if (!(gm = kmalloc(sizeof(*gm), GFP_KERNEL))) {
+		printk("Failed to allocate memory in gss_mech_register");
+		return -1;
+	}
+	gm->gm_oid.len = mech_type->len;
+	if (!(gm->gm_oid.data = kmalloc(mech_type->len, GFP_KERNEL))) {
+		printk("Failed to allocate memory in gss_mech_register");
+		return -1;
+	}
+	memcpy(gm->gm_oid.data, mech_type->data, mech_type->len);
+	/* We're counting the reference in the registered_mechs list: */
+	atomic_set(&gm->gm_count, 1);
+	gm->gm_ops = ops;
+	
+	spin_lock(&registered_mechs_lock);
+	list_add(&gm->gm_list, &registered_mechs);
+	spin_unlock(&registered_mechs_lock);
+	dprintk("RPC: gss_mech_register: registered mechanism with oid:\n");
+	print_hexl((u32 *)mech_type->data, mech_type->len, 0);
+	return 0;
+}
+
+/* The following must be called with spinlock held: */
+int
+do_gss_mech_unregister(struct gss_api_mech *gm)
+{
+
+	list_del(&gm->gm_list);
+
+	dprintk("RPC: unregistered mechanism with oid:\n");
+	print_hexl((u32 *)gm->gm_oid.data, gm->gm_oid.len, 0);
+	if (!gss_mech_put(gm)) {
+		dprintk("RPC: We just unregistered a gss_mechanism which"
+				" someone is still using.\n");
+		return -1;
+	} else {
+		return 0;
+	}
+}
+
+int
+gss_mech_unregister(struct gss_api_mech *gm)
+{
+	int status;
+
+	spin_lock(&registered_mechs_lock);
+	status = do_gss_mech_unregister(gm);
+	spin_unlock(&registered_mechs_lock);
+	return status;
+}
+
+int
+gss_mech_unregister_all(void)
+{
+	struct list_head	*pos;
+	struct gss_api_mech	*gm;
+	int			status = 0;
+
+	spin_lock(&registered_mechs_lock);
+	while (!list_empty(&registered_mechs)) {
+		pos = registered_mechs.next;
+		gm = list_entry(pos, struct gss_api_mech, gm_list);
+		if (do_gss_mech_unregister(gm))
+			status = -1;
+	}
+	spin_unlock(&registered_mechs_lock);
+	return status;
+}
+
+struct gss_api_mech *
+gss_mech_get(struct gss_api_mech *gm)
+{
+	atomic_inc(&gm->gm_count);
+	return gm;
+}
+
+struct gss_api_mech *
+gss_mech_get_by_OID(struct xdr_netobj *mech_type)
+{
+	struct gss_api_mech 	*pos, *gm = NULL;
+
+	dprintk("RPC: gss_mech_get_by_OID searching for mechanism with OID:\n");
+	print_hexl((u32 *)mech_type->data, mech_type->len, 0);
+	spin_lock(&registered_mechs_lock);
+	list_for_each_entry(pos, &registered_mechs, gm_list) {
+		if ((pos->gm_oid.len == mech_type->len)
+			&& !memcmp(pos->gm_oid.data, mech_type->data,
+							mech_type->len)) {
+			gm = gss_mech_get(pos);
+			break;
+		}
+	}
+	spin_unlock(&registered_mechs_lock);
+	dprintk("RPC: gss_mech_get_by_OID %s it\n", gm ? "found" : "didn't find");
+	return gm;
+}
+
+int
+gss_mech_put(struct gss_api_mech * gm)
+{
+	if (atomic_dec_and_test(&gm->gm_count)) {
+		if (gm->gm_oid.len >0)
+			kfree(gm->gm_oid.data);
+		kfree(gm);
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+/* The mech could probably be determined from the token instead, but it's just
+ * as easy for now to pass it in. */
+u32
+gss_import_sec_context(struct xdr_netobj	*input_token,
+		       struct gss_api_mech	*mech,
+		       struct gss_ctx		**ctx_id)
+{
+	if (!(*ctx_id = kmalloc(sizeof(**ctx_id), GFP_KERNEL)))
+		return GSS_S_FAILURE;
+	memset(*ctx_id, 0, sizeof(**ctx_id));
+	(*ctx_id)->mech_type = gss_mech_get(mech);
+
+	return mech->gm_ops
+		->gss_import_sec_context(input_token, *ctx_id);
+}
+
+/* gss_verify_mic: hash messages_buffer and return gss verify token. */
+
+u32
+gss_get_mic(struct gss_ctx	*context_handle,
+	    u32			qop,
+	    struct xdr_netobj	*message_buffer,
+	    struct xdr_netobj	*message_token)
+{
+	 return context_handle->mech_type->gm_ops
+		->gss_get_mic(context_handle,
+			      qop,
+			      message_buffer,
+			      message_token);
+}
+
+/* gss_verify_mic: hash messages_buffer and return gss verify token. */
+
+u32
+gss_verify_mic(struct gss_ctx		*context_handle,
+		struct xdr_netobj	*signbuf,
+		struct xdr_netobj	*checksum,
+		u32			*qstate)
+{
+	return context_handle->mech_type->gm_ops
+		->gss_verify_mic(context_handle,
+				 signbuf,
+				 checksum,
+				 qstate);
+}
+
+/* gss_delete_sec_context: free all resources associated with context_handle.
+ * Note this differs from the RFC 2744-specified prototype in that we don't
+ * bother returning an output token, since it would never be used anyway. */
+
+u32
+gss_delete_sec_context(struct gss_ctx	**context_handle)
+{
+	dprintk("gss_delete_sec_context deleting %p\n",*context_handle);
+
+	if (!*context_handle)
+		return(GSS_S_NO_CONTEXT);
+	if ((*context_handle)->internal_ctx_id != 0)
+		(*context_handle)->mech_type->gm_ops
+			->gss_delete_sec_context((*context_handle)
+							->internal_ctx_id);
+	if ((*context_handle)->mech_type)
+		gss_mech_put((*context_handle)->mech_type);
+	kfree(*context_handle);
+	*context_handle=NULL;
+	return GSS_S_COMPLETE;
+}
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/net/sunrpc/auth_gss/gss_pseudoflavors.c linux-2.5.56-05-rpc_gss/net/sunrpc/auth_gss/gss_pseudoflavors.c
--- linux-2.5.56-04-auth_upcall/net/sunrpc/auth_gss/gss_pseudoflavors.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/net/sunrpc/auth_gss/gss_pseudoflavors.c	2003-01-12 22:40:13.000000000 +0100
@@ -0,0 +1,235 @@
+/*
+ *  linux/net/sunrpc/gss_union.c
+ *
+ *  Adapted from MIT Kerberos 5-1.2.1 lib/gssapi/generic code
+ *
+ *  Copyright (c) 2001 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Andy Adamson   <andros@umich.edu>
+ *
+ */
+
+/*
+ * Copyright 1993 by OpenVision Technologies, Inc.
+ *
+ * Permission to use, copy, modify, distribute, and sell this software
+ * and its documentation for any purpose is hereby granted without fee,
+ * provided that the above copyright notice appears in all copies and
+ * that both that copyright notice and this permission notice appear in
+ * supporting documentation, and that the name of OpenVision not be used
+ * in advertising or publicity pertaining to distribution of the software
+ * without specific, written prior permission. OpenVision makes no
+ * representations about the suitability of this software for any
+ * purpose.  It is provided "as is" without express or implied warranty.
+ *
+ * OPENVISION DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
+ * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
+ * EVENT SHALL OPENVISION BE LIABLE FOR ANY SPECIAL, INDIRECT OR
+ * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
+ * USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
+ * OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
+ * PERFORMANCE OF THIS SOFTWARE.
+ */ 
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/socket.h>
+#include <linux/sunrpc/gss_asn1.h>
+#include <linux/sunrpc/auth_gss.h>
+
+#ifdef RPC_DEBUG
+# define RPCDBG_FACILITY        RPCDBG_AUTH
+#endif
+
+static LIST_HEAD(registered_triples);
+static spinlock_t registered_triples_lock = SPIN_LOCK_UNLOCKED;
+
+/* The following must be called with spinlock held: */
+static struct sup_sec_triple *
+do_lookup_triple_by_pseudoflavor(u32 pseudoflavor)
+{
+	struct sup_sec_triple *pos, *triple = NULL;
+
+	list_for_each_entry(pos, &registered_triples, triples) {
+		if (pos->pseudoflavor == pseudoflavor) {
+			triple = pos;
+			break;
+		}
+	}
+	return triple;
+}
+
+/* XXX Need to think about reference counting of triples and of mechs.
+ * Currently we do no reference counting of triples, and I think that's
+ * probably OK given the reference counting on mechs, but there's probably
+ * a better way to do all this. */
+
+int
+gss_register_triple(u32 pseudoflavor, struct gss_api_mech *mech,
+			  u32 qop, u32 service)
+{
+	struct sup_sec_triple *triple;
+
+	if (!(triple = kmalloc(sizeof(*triple), GFP_KERNEL))) {
+		printk("Alloc failed in gss_register_triple");
+		goto err;
+	}
+	triple->pseudoflavor = pseudoflavor;
+	triple->mech = gss_mech_get_by_OID(&mech->gm_oid);
+	triple->qop = qop;
+	triple->service = service;
+
+	spin_lock(&registered_triples_lock);
+	if (do_lookup_triple_by_pseudoflavor(pseudoflavor)) {
+		printk("Registered pseudoflavor %d again\n", pseudoflavor);
+		goto err_unlock;
+	}
+	list_add(&triple->triples, &registered_triples);
+	spin_unlock(&registered_triples_lock);
+	dprintk("RPC: registered pseudoflavor %d\n", pseudoflavor);
+
+	return 0;
+
+err_unlock:
+	spin_unlock(&registered_triples_lock);
+err:
+	return -1;
+}
+
+int
+gss_unregister_triple(u32 pseudoflavor)
+{
+	struct sup_sec_triple *triple;
+
+	spin_lock(&registered_triples_lock);
+	if (!(triple = do_lookup_triple_by_pseudoflavor(pseudoflavor))) {
+		spin_unlock(&registered_triples_lock);
+		printk("Can't unregister unregistered pseudoflavor %d\n",
+		       pseudoflavor);
+		return -1;
+	}
+	list_del(&triple->triples);
+	spin_unlock(&registered_triples_lock);
+	gss_mech_put(triple->mech);
+	kfree(triple);
+	return 0;
+
+}
+
+void
+print_sec_triple(struct xdr_netobj *oid,u32 qop,u32 service)
+{
+	dprintk("RPC: print_sec_triple:\n");
+	dprintk("                     oid_len %d\n  oid :\n",oid->len);
+	print_hexl((u32 *)oid->data,oid->len,0);
+	dprintk("                     qop %d\n",qop);
+	dprintk("                     service %d\n",service);
+}
+
+/* Function: gss_get_cmp_triples
+ *
+ * Description: search sec_triples for a matching security triple
+ * return pseudoflavor if match, else 0
+ * (Note that 0 is a valid pseudoflavor, but not for any gss pseudoflavor
+ * (0 means auth_null), so this shouldn't cause confusion.)
+ */
+u32
+gss_cmp_triples(u32 oid_len, char *oid_data, u32 qop, u32 service)
+{
+	struct sup_sec_triple *triple;
+	u32 pseudoflavor = 0;
+	struct xdr_netobj oid;
+
+	oid.len = oid_len;
+	oid.data = oid_data;
+
+	dprintk("RPC: gss_cmp_triples \n");
+	print_sec_triple(&oid,qop,service);
+
+	spin_lock(&registered_triples_lock);
+	list_for_each_entry(triple, &registered_triples, triples) {
+		if((g_OID_equal(&oid, &triple->mech->gm_oid))
+		    && (qop == triple->qop)
+		    && (service == triple->service)) {
+			pseudoflavor = triple->pseudoflavor;
+			break;
+		}
+	}
+	spin_unlock(&registered_triples_lock);
+	dprintk("RPC: gss_cmp_triples return %d\n", pseudoflavor);
+	return pseudoflavor;
+}
+
+u32
+gss_get_pseudoflavor(struct gss_ctx *ctx, u32 qop, u32 service)
+{
+	return gss_cmp_triples(ctx->mech_type->gm_oid.len,
+			       ctx->mech_type->gm_oid.data,
+			       qop, service);
+}
+
+/* Returns nonzero iff the given pseudoflavor is in the supported list.
+ * (Note that without incrementing a reference count or anything, this
+ * doesn't give any guarantees.) */
+int
+gss_pseudoflavor_supported(u32 pseudoflavor)
+{
+	struct sup_sec_triple *triple;
+
+	spin_lock(&registered_triples_lock);
+	triple = do_lookup_triple_by_pseudoflavor(pseudoflavor);
+	spin_unlock(&registered_triples_lock);
+	return (triple ? 1 : 0);
+}
+
+u32
+gss_pseudoflavor_to_service(u32 pseudoflavor)
+{
+	struct sup_sec_triple *triple;
+
+	spin_lock(&registered_triples_lock);
+	triple = do_lookup_triple_by_pseudoflavor(pseudoflavor);
+	spin_unlock(&registered_triples_lock);
+	if (!triple) {
+		dprintk("RPC: gss_pseudoflavor_to_service called with"
+			" unsupported pseudoflavor %d\n", pseudoflavor);
+		return 0;
+	}
+	return triple->service;
+}
+
+struct gss_api_mech *
+gss_pseudoflavor_to_mech(u32 pseudoflavor) {
+	struct sup_sec_triple *triple;
+	struct gss_api_mech *mech = NULL;
+
+	spin_lock(&registered_triples_lock);
+	triple = do_lookup_triple_by_pseudoflavor(pseudoflavor);
+	spin_unlock(&registered_triples_lock);
+	if (triple)
+		mech = gss_mech_get(triple->mech);
+	else
+		dprintk("RPC: gss_pseudoflavor_to_mech called with"
+			" unsupported pseudoflavor %d\n", pseudoflavor);
+	return mech;
+}
+
+int
+gss_pseudoflavor_to_mechOID(u32 pseudoflavor, struct xdr_netobj * oid)
+{
+	struct gss_api_mech *mech;
+
+	mech = gss_pseudoflavor_to_mech(pseudoflavor);
+	if (!mech)  {
+		dprintk("RPC: gss_pseudoflavor_to_mechOID called with"
+			" unsupported pseudoflavor %d\n", pseudoflavor);
+		        return -1;
+	}
+	oid->len = mech->gm_oid.len;
+	if (!(oid->data = kmalloc(oid->len, GFP_KERNEL)))
+		return -1;
+	memcpy(oid->data, mech->gm_oid.data, oid->len);
+	gss_mech_put(mech);
+	return 0;
+}
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/net/sunrpc/auth_gss/Makefile linux-2.5.56-05-rpc_gss/net/sunrpc/auth_gss/Makefile
--- linux-2.5.56-04-auth_upcall/net/sunrpc/auth_gss/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/net/sunrpc/auth_gss/Makefile	2003-01-12 22:40:13.000000000 +0100
@@ -0,0 +1,11 @@
+#
+# Makefile for Linux kernel rpcsec_gss implementation
+#
+
+obj-$(CONFIG_SUNRPC_GSS) += auth_rpcgss.o
+
+export-objs := sunrpcgss_syms.o
+
+auth_rpcgss-objs := auth_gss.o gss_pseudoflavors.o gss_generic_token.o \
+	sunrpcgss_syms.o gss_mech_switch.o
+
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/net/sunrpc/auth_gss/sunrpcgss_syms.c linux-2.5.56-05-rpc_gss/net/sunrpc/auth_gss/sunrpcgss_syms.c
--- linux-2.5.56-04-auth_upcall/net/sunrpc/auth_gss/sunrpcgss_syms.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/net/sunrpc/auth_gss/sunrpcgss_syms.c	2003-01-12 22:40:13.000000000 +0100
@@ -0,0 +1,34 @@
+#define __NO_VERSION__
+#include <linux/config.h>
+#include <linux/module.h>
+
+#include <linux/types.h>
+#include <linux/socket.h>
+#include <linux/sched.h>
+#include <linux/uio.h>
+#include <linux/unistd.h>
+
+#include <linux/sunrpc/auth_gss.h>
+#include <linux/sunrpc/gss_asn1.h>
+
+/* sec_triples: */
+EXPORT_SYMBOL(gss_register_triple);
+EXPORT_SYMBOL(gss_unregister_triple);
+EXPORT_SYMBOL(gss_cmp_triples);
+EXPORT_SYMBOL(gss_pseudoflavor_to_mechOID);
+EXPORT_SYMBOL(gss_pseudoflavor_supported);
+EXPORT_SYMBOL(gss_pseudoflavor_to_service);
+
+/* registering gss mechanisms to the mech switching code: */
+EXPORT_SYMBOL(gss_mech_register);
+EXPORT_SYMBOL(gss_mech_get);
+EXPORT_SYMBOL(gss_mech_get_by_OID);
+EXPORT_SYMBOL(gss_mech_put);
+
+/* generic functionality in gss code: */
+EXPORT_SYMBOL(g_make_token_header);
+EXPORT_SYMBOL(g_verify_token_header);
+EXPORT_SYMBOL(g_token_size);
+
+/* debug */
+EXPORT_SYMBOL(print_hexl);
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/net/sunrpc/auth_null.c linux-2.5.56-05-rpc_gss/net/sunrpc/auth_null.c
--- linux-2.5.56-04-auth_upcall/net/sunrpc/auth_null.c	2003-01-12 22:39:26.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/net/sunrpc/auth_null.c	2003-01-12 22:40:13.000000000 +0100
@@ -20,7 +20,7 @@
 static struct rpc_credops	null_credops;
 
 static struct rpc_auth *
-nul_create(struct rpc_clnt *clnt)
+nul_create(struct rpc_clnt *clnt, rpc_authflavor_t flavor)
 {
 	struct rpc_auth	*auth;
 
@@ -48,7 +48,7 @@
  * Create NULL creds for current process
  */
 static struct rpc_cred *
-nul_create_cred(struct auth_cred *acred, int flags)
+nul_create_cred(struct rpc_auth *auth, struct auth_cred *acred, int flags)
 {
 	struct rpc_cred	*cred;
 
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/net/sunrpc/auth_unix.c linux-2.5.56-05-rpc_gss/net/sunrpc/auth_unix.c
--- linux-2.5.56-04-auth_upcall/net/sunrpc/auth_unix.c	2003-01-12 22:39:26.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/net/sunrpc/auth_unix.c	2003-01-12 22:40:13.000000000 +0100
@@ -38,7 +38,7 @@
 static struct rpc_credops	unix_credops;
 
 static struct rpc_auth *
-unx_create(struct rpc_clnt *clnt)
+unx_create(struct rpc_clnt *clnt, rpc_authflavor_t flavor)
 {
 	struct rpc_auth	*auth;
 
@@ -64,7 +64,7 @@
 }
 
 static struct rpc_cred *
-unx_create_cred(struct auth_cred *acred, int flags)
+unx_create_cred(struct rpc_auth *auth, struct auth_cred *acred, int flags)
 {
 	struct unx_cred	*cred;
 	int		i;
@@ -208,7 +208,7 @@
 	}
 
 	size = ntohl(*p++);
-	if (size > 400) {
+	if (size > RPC_MAX_AUTH_SIZE) {
 		printk("RPC: giant verf size: %u\n", size);
 		return NULL;
 	}
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/net/sunrpc/clnt.c linux-2.5.56-05-rpc_gss/net/sunrpc/clnt.c
--- linux-2.5.56-04-auth_upcall/net/sunrpc/clnt.c	2003-01-12 22:39:49.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/net/sunrpc/clnt.c	2003-01-12 22:40:13.000000000 +0100
@@ -35,7 +35,7 @@
 #include <linux/nfs.h>
 
 
-#define RPC_SLACK_SPACE		512	/* total overkill */
+#define RPC_SLACK_SPACE		(1024)	/* total overkill */
 
 #ifdef RPC_DEBUG
 # define RPCDBG_FACILITY	RPCDBG_CALL
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/net/sunrpc/Makefile linux-2.5.56-05-rpc_gss/net/sunrpc/Makefile
--- linux-2.5.56-04-auth_upcall/net/sunrpc/Makefile	2003-01-12 22:39:49.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/net/sunrpc/Makefile	2003-01-12 22:40:13.000000000 +0100
@@ -2,6 +2,8 @@
 # Makefile for Linux kernel SUN RPC
 #
 
+obj-$(CONFIG_SUNRPC_GSS) += auth_gss/
+
 obj-$(CONFIG_SUNRPC) += sunrpc.o
 
 export-objs := sunrpc_syms.o
diff -u --recursive --new-file linux-2.5.56-04-auth_upcall/net/sunrpc/sunrpc_syms.c linux-2.5.56-05-rpc_gss/net/sunrpc/sunrpc_syms.c
--- linux-2.5.56-04-auth_upcall/net/sunrpc/sunrpc_syms.c	2003-01-12 22:39:49.000000000 +0100
+++ linux-2.5.56-05-rpc_gss/net/sunrpc/sunrpc_syms.c	2003-01-12 22:40:13.000000000 +0100
@@ -68,6 +68,8 @@
 EXPORT_SYMBOL(rpcauth_register);
 EXPORT_SYMBOL(rpcauth_unregister);
 EXPORT_SYMBOL(rpcauth_lookupcred);
+EXPORT_SYMBOL(rpcauth_free_credcache);
+EXPORT_SYMBOL(rpcauth_init_credcache);
 EXPORT_SYMBOL(put_rpccred);
 
 /* RPC server stuff */
