Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319206AbSHNUeD>; Wed, 14 Aug 2002 16:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319259AbSHNUeD>; Wed, 14 Aug 2002 16:34:03 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:27352 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319206AbSHNUdf>; Wed, 14 Aug 2002 16:33:35 -0400
Date: Wed, 14 Aug 2002 16:37:24 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 03/38: SUNRPC: support for GSSD client
Message-ID: <Pine.SOL.4.44.0208141636480.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a large patch containing the in-kernel GSSD client.  This
allows the kernel to communicate (via a loopback RPC) with a userspace
daemon which provides translation between named principals and uid/gid's.

The routines gss_get_name(), gss_get_num() are the only interface to
the GSSD client, and allow translation of a single id->name, or name->id,
respectively.  The results of these routines are cached by the GSSD
client, so that subsequent calls do not require an expensive upcall
to userspace.

--- old/net/sunrpc/Makefile	Thu Aug  1 16:16:04 2002
+++ new/net/sunrpc/Makefile	Sun Aug 11 19:21:50 2002
@@ -13,6 +13,8 @@ sunrpc-y := clnt.o xprt.o sched.o \
 	    sunrpc_syms.o
 sunrpc-$(CONFIG_PROC_FS) += stats.o
 sunrpc-$(CONFIG_SYSCTL) += sysctl.o
+sunrpc-$(CONFIG_SUNRPC_GSSD_CLNT) += gssd_clnt.o
+
 sunrpc-objs := $(sunrpc-y)

 include $(TOPDIR)/Rules.make
--- old/net/sunrpc/stats.c	Thu Aug  1 16:17:19 2002
+++ new/net/sunrpc/stats.c	Sun Aug 11 19:21:50 2002
@@ -187,6 +187,9 @@ rpc_proc_exit(void)
 static int __init
 init_sunrpc(void)
 {
+#ifdef CONFIG_SUNRPC_GSSD_CLNT
+	gss_cache_init();
+#endif
 #ifdef RPC_DEBUG
 	rpc_register_sysctl();
 #endif
@@ -201,6 +204,9 @@ cleanup_sunrpc(void)
 	rpc_unregister_sysctl();
 #endif
 	rpc_proc_exit();
+#ifdef CONFIG_SUNRPC_GSSD_CLNT
+	gss_cache_exit();
+#endif
 }
 MODULE_LICENSE("GPL");
 module_init(init_sunrpc);
--- old/net/sunrpc/sunrpc_syms.c	Thu Aug  1 16:16:34 2002
+++ new/net/sunrpc/sunrpc_syms.c	Sun Aug 11 19:21:50 2002
@@ -101,6 +101,13 @@ EXPORT_SYMBOL(xdr_encode_pages);
 EXPORT_SYMBOL(xdr_inline_pages);
 EXPORT_SYMBOL(xdr_shift_buf);

+/* RPCSEC_GSS name to uid mapping */
+#ifdef CONFIG_SUNRPC_GSSD_CLNT
+EXPORT_SYMBOL(gss_put);
+EXPORT_SYMBOL(gss_get_name);
+EXPORT_SYMBOL(gss_get_num);
+#endif
+
 /* Debugging symbols */
 #ifdef RPC_DEBUG
 EXPORT_SYMBOL(rpc_debug);
--- old/include/linux/sunrpc/clnt.h	Thu Aug  1 16:16:28 2002
+++ new/include/linux/sunrpc/clnt.h	Sun Aug 11 19:21:50 2002
@@ -150,5 +150,29 @@ extern void rpciod_wake_up(void);
  */
 int		rpc_getport_external(struct sockaddr_in *, __u32, __u32, int);

+#ifdef CONFIG_SUNRPC_GSSD_CLNT
+/*
+ * RPCSEC_GSS mapping between uid/gid's and named principals
+ */
+#define GSS_OWNER              0
+#define GSS_GROUP              1
+
+struct gss_cacheent {
+	uid_t id;
+	struct qstr name;
+
+	/* fields after this point are private, for use by the gss cache */
+	atomic_t refcount;
+	struct list_head name_hash;
+	struct list_head id_hash;
+};
+
+extern void gss_put(struct gss_cacheent *p);
+extern int gss_get_name(int type, uid_t id, struct gss_cacheent **pp);
+extern int gss_get_num(int type, unsigned int len, const unsigned char *name, uid_t *pp);
+extern void gss_cache_init(void);
+extern void gss_cache_exit(void);
+#endif /* CONFIG_SUNRPC_GSSD_CLNT */
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_SUNRPC_CLNT_H */
--- old/net/sunrpc/gssd_clnt.c	Wed Dec 31 18:00:00 1969
+++ new/net/sunrpc/gssd_clnt.c	Sun Aug 11 19:21:50 2002
@@ -0,0 +1,580 @@
+/*
+ *  net/sunrpc/gssd_clnt.c
+ *
+ *  GSSD client.
+ *
+ *  Copyright (c) 2000 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Dug Song       <dugsong@monkey.org>
+ *  Andy Adamson   <andros@umich.edu>
+ *  Kendrick Smith <kmsmith@umich.edu>
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/socket.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/uio.h>
+#include <linux/in.h>
+#include <linux/sunrpc/clnt.h>
+#include <linux/sunrpc/xprt.h>
+#include <linux/sunrpc/sched.h>
+
+typedef struct xdr_netobj    GSS_BUFFER_T;
+
+#ifdef RPC_DEBUG
+# define RPCDBG_FACILITY	RPCDBG_AUTH
+#endif
+
+/*
+ * GSSD gss.x definitions
+ */
+
+#define RPC_GSSD_PROGRAM	100666
+#define RPC_GSSD_VERSION	1
+
+enum gssd_proc {
+	GSSD_NAME_TO_UID	= 1,
+	GSSD_UID_TO_NAME	= 2,
+	GSSD_NAME_TO_GID	= 3,
+	GSSD_GID_TO_NAME	= 4
+};
+
+struct rpc_program	gssd_program;
+
+static struct rpc_clnt *
+gssd_create(void)
+{
+	struct sockaddr_in	sin;
+	struct rpc_xprt	       *xprt;
+	struct rpc_clnt	       *clnt;
+	uint   saved_fsuid = current->fsuid;
+	kernel_cap_t saved_cap = current->cap_effective;
+
+	dprintk("RPC: gssd_create()\n");
+	sin.sin_family = AF_INET;
+	sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	sin.sin_port = 0;
+
+	/* create rpc socket as root so we get a priv port */
+	current->fsuid = 0;
+	cap_raise(current->cap_effective, CAP_NET_BIND_SERVICE);
+	xprt = xprt_create_proto(IPPROTO_UDP, &sin, NULL);
+	current->fsuid = saved_fsuid;
+	current->cap_effective = saved_cap;
+	if(xprt == NULL)
+		return NULL;
+
+	clnt = rpc_create_client(xprt, "localhost", &gssd_program,
+				 RPC_GSSD_VERSION, RPC_AUTH_UNIX);
+	if (!clnt) {
+		xprt_destroy(xprt);
+	} else {
+		clnt->cl_softrtry = 1;
+		clnt->cl_chatty   = 1;
+		clnt->cl_oneshot  = 1;
+		clnt->cl_autobind = 1;
+	}
+	return clnt;
+}
+
+/*
+ * Convert Unix/GSS username/principal to Unix UID.
+ */
+static int
+gssd_name_to_uid(struct qstr *name, u32 *uidp)
+{
+	struct rpc_clnt		*gssd_clnt;
+	unsigned int		error = 0;
+
+	dprintk("RPC: gssd_name_to_uid \n");
+	if (!(gssd_clnt = gssd_create())) {
+		printk("RPC: couldn't create gssd client\n");
+		return -EACCES;
+	}
+
+	error = rpc_call(gssd_clnt, GSSD_NAME_TO_UID, name, uidp, RPC_TASK_ROOTCREDS);
+
+	if (error < 0) {
+		printk(KERN_WARNING
+		       "RPC: failed to contact gssd (errno %d).\n", error);
+	}
+	dprintk("RPC: gssd_name_to_uid(%.*s) = %d\n",
+		(int) name->len, name->name, *uidp);
+
+	/* Client deleted automatically because cl_oneshot == 1 */
+	return error;
+}
+
+/*
+ * Convert Unix UID to Unix username.
+ */
+static int
+gssd_uid_to_name(u32 *uid, struct qstr *name)
+{
+	struct rpc_clnt		*gssd_clnt;
+	unsigned int		error = 0;
+
+	if (!(gssd_clnt = gssd_create())) {
+		printk("RPC: couldn't create gssd client\n");
+		return -EACCES;
+	}
+	error = rpc_call(gssd_clnt, GSSD_UID_TO_NAME, uid, name, RPC_TASK_ROOTCREDS);
+
+	if (error < 0) {
+		printk(KERN_WARNING
+		       "RPC: failed to contact gssd (errno %d).\n", error);
+	}
+	dprintk("RPC: gssd_uid_to_name(%d) = %.*s\n",
+		*uid, (int) name->len, name->name);
+
+	/* Client deleted automatically because cl_oneshot == 1 */
+	return error;
+}
+
+/*
+ * Convert Unix group name to Unix GID.
+ */
+static int
+gssd_name_to_gid(struct qstr *name, u32 *gidp)
+{
+	struct rpc_clnt		*gssd_clnt;
+	unsigned int		error = 0;
+
+	if (!(gssd_clnt = gssd_create())) {
+		printk("RPC: couldn't create gssd client\n");
+		return -EACCES;
+	}
+	error = rpc_call(gssd_clnt, GSSD_NAME_TO_GID, name, gidp, RPC_TASK_ROOTCREDS);
+
+	if (error < 0) {
+		printk(KERN_WARNING
+		       "RPC: failed to contact gssd (errno %d).\n", error);
+	}
+	dprintk("RPC: gssd_name_to_gid(%.*s) = %d\n",
+		(int) name->len, name->name, *gidp);
+
+	/* Client deleted automatically because cl_oneshot == 1 */
+	return error;
+}
+
+/*
+ * Convert Unix GID to Unix name.
+ */
+static int
+gssd_gid_to_name(u32 *gid, struct qstr *name)
+{
+	struct rpc_clnt		*gssd_clnt;
+	unsigned int		error = 0;
+
+	if (!(gssd_clnt = gssd_create())) {
+		printk("RPC: couldn't create gssd client\n");
+		return -EACCES;
+	}
+	error = rpc_call(gssd_clnt, GSSD_GID_TO_NAME, gid, name, RPC_TASK_ROOTCREDS);
+
+	if (error < 0) {
+		printk(KERN_WARNING
+		       "RPC: failed to contact gssd (errno %d).\n", error);
+	}
+	dprintk("RPC: gssd_gid_to_name(%d) = %.*s\n",
+		*gid, (int) name->len, name->name);
+
+	/* Client deleted automatically because cl_oneshot == 1 */
+	return error;
+}
+
+/*
+ * XDR encode/decode functions for GSSD
+ */
+static int
+xdr_error(struct rpc_rqst *req, u32 *p, void *dummy)
+{
+	return -EIO;
+}
+
+static int
+xdr_decode_name(struct rpc_rqst *req, u32 *p, struct qstr *name)
+{
+	unsigned int len;
+
+	len = ntohl(*p++);
+	if (len > XDR_MAX_NETOBJ)
+		return -EIO;
+	if (!(name->name = kmalloc(len, GFP_KERNEL)))
+		return -ENOMEM;
+	name->len = len;
+	memcpy((char *)name->name, p, len);    /* cast is to get rid of "const" */
+
+	dprintk("RPC: xdr_decode_name() = (%.*s)\n", (int)name->len, name->name);
+	return 0;
+}
+
+static int
+xdr_encode_name(struct rpc_rqst *req, u32 *p, struct qstr *name)
+{
+	unsigned int quadlen = XDR_QUADLEN(name->len);
+
+	dprintk("RPC: xdr_encode_name(%.*s)\n", (int) name->len, name->name);
+
+	if (name->len > XDR_MAX_NETOBJ)
+		return -EINVAL;
+	p[quadlen] = 0;    /* zero trailing bytes */
+	*p++ = htonl(name->len);
+	memcpy(p, name->name, name->len);
+	p += quadlen;
+	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
+	return 0;
+}
+
+static int
+xdr_decode_id(struct rpc_rqst *req, u32 *p, u32 *idp)
+{
+	*idp = (u32) ntohl(*p);
+	dprintk("RPC: xdr_decode_id() = (%d)\n", *idp);
+	return 0;
+}
+
+static int
+xdr_encode_id(struct rpc_rqst *req, u32 *p, u32 *idp)
+{
+	dprintk("RPC: xdr_encode_id(%d)\n", *idp);
+	*p++ = (u32) htonl(*idp);
+
+	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
+	return 0;
+}
+
+static struct rpc_procinfo	gssd_procedures[] = {
+	{ "gssd_null",
+		(kxdrproc_t) xdr_error,
+		(kxdrproc_t) xdr_error,	0, 0 },
+	{ "gssd_name_to_uid",
+		(kxdrproc_t) xdr_encode_name,
+		(kxdrproc_t) xdr_decode_id, RPC_MAXNETNAMELEN >> 2, 1 },
+	{ "gssd_uid_to_name",
+		(kxdrproc_t) xdr_encode_id,
+		(kxdrproc_t) xdr_decode_name, RPC_MAXNETNAMELEN >> 2, 1 },
+	{ "gssd_name_to_gid",
+		(kxdrproc_t) xdr_encode_name,
+		(kxdrproc_t) xdr_decode_id, RPC_MAXNETNAMELEN >> 2, 1 },
+	{ "gssd_gid_to_name",
+		(kxdrproc_t) xdr_encode_id,
+		(kxdrproc_t) xdr_decode_name, RPC_MAXNETNAMELEN >> 2, 1 }
+};
+
+static struct rpc_version	gssd_version1 = {
+	1,
+	sizeof(gssd_procedures) / sizeof(gssd_procedures[0]),
+	gssd_procedures
+};
+
+static struct rpc_version *	gssd_version[] = {
+	NULL,
+	&gssd_version1
+};
+
+static struct rpc_stat		gssd_stats;
+
+struct rpc_program	gssd_program = {
+	"GSSD",
+	RPC_GSSD_PROGRAM,
+	sizeof(gssd_version) / sizeof(gssd_version[0]),
+	gssd_version,
+	&gssd_stats,
+};
+
+/*
+ * The rest of this file is concerned with a cache for
+ * name<->id conversion, so that we don't have to pay the
+ * cost of an RPC upcall every time.  There are a couple
+ * of outstanding issues here:
+ *
+ * TODO: Implement a mechanism for flushing infrequently-used
+ * entries from the cache.  As things currently stand, a
+ * cache entry is permanent(!) once added.  This might be
+ * as simple as imposing a hard limit on the number of
+ * cache entries.  Alternatively, we might try to let kswapd
+ * free some entries when it begins to feel memory pressure.
+ *
+ * TODO: When gssd is restarted, we want to inform the kernel
+ * that the cache should be cleared.  We need to create a hook
+ * somewhere (probably in /proc) that will let a userspace
+ * program clear the cache, and to modify gssd so that it will
+ * clear the cache on startup.
+ */
+
+#define GSS_HASH_BITS		8
+#define GSS_HASH_SIZE		(1 << GSS_HASH_BITS)
+#define GSS_HASH_MASK		(GSS_HASH_SIZE - 1)
+
+#define GSS_ID_HASH(id)		((id) & GSS_HASH_MASK)
+#define GSS_NAME_HASH(name, len) (full_name_hash((name), (len)) & GSS_HASH_MASK)
+
+struct gss_mapping {
+	rwlock_t		lock;
+	struct list_head	id_hash[GSS_HASH_SIZE];
+	struct list_head	name_hash[GSS_HASH_SIZE];
+};
+
+static struct gss_mapping	owner_map;
+static struct gss_mapping	group_map;
+
+static void
+gss_mapping_init(struct gss_mapping *map)
+{
+	int i;
+
+	rwlock_init(&map->lock);
+	for (i = 0; i < GSS_HASH_SIZE; i++) {
+		INIT_LIST_HEAD(&map->id_hash[i]);
+		INIT_LIST_HEAD(&map->name_hash[i]);
+	}
+}
+
+static void
+gss_mapping_destroy(struct gss_mapping *map)
+{
+	int i;
+	struct list_head *l;
+	struct gss_cacheent *p;
+
+	for (i = 0; i < GSS_HASH_SIZE; i++) {
+		l = &map->id_hash[i];
+		while (!list_empty(l)) {
+			p = list_entry(l->next, struct gss_cacheent, id_hash);
+			list_del_init(&p->id_hash);
+			list_del_init(&p->name_hash);
+			gss_put(p);
+		}
+	}
+}
+
+/*
+ * I didn't bother putting these in a slab cache, since whenever
+ * one is allocated, we already incur the overhead of an RPC call
+ * to userspace...
+ */
+static struct gss_cacheent *
+gss_alloc(unsigned int namelen)
+{
+	struct gss_cacheent *p;
+
+	BUG_ON(namelen > XDR_MAX_NETOBJ);
+
+	if (!(p = kmalloc(sizeof(*p), GFP_KERNEL)))
+		return NULL;
+	atomic_set(&p->refcount, 1);
+	INIT_LIST_HEAD(&p->name_hash);
+	INIT_LIST_HEAD(&p->id_hash);
+
+	if (!namelen) {
+		p->name.name = NULL;
+		return p;
+	}
+	if (!(p->name.name = kmalloc(namelen, GFP_KERNEL))) {
+		kfree(p);
+		return NULL;
+	}
+	return p;
+}
+
+void
+gss_put(struct gss_cacheent *p)
+{
+	BUG_ON(atomic_read(&p->refcount) == 0);
+
+	if (!atomic_dec_and_test(&p->refcount))
+		return;
+	BUG_ON(!list_empty(&p->name_hash) || !list_empty(&p->id_hash));
+
+	if (p->name.name) {
+		kfree((char *)p->name.name);  /* cast is to get rid of "const" */
+		p->name.name = NULL;
+	}
+	kfree(p);
+
+}
+
+/* caller must hold writelock */
+static inline void
+gss_insert(struct gss_cacheent *p, struct gss_mapping *map)
+{
+	unsigned int id_hashval = GSS_ID_HASH(p->id);
+	unsigned int name_hashval = p->name.hash;
+
+	list_add(&p->id_hash, &map->id_hash[id_hashval]);
+	list_add(&p->name_hash, &map->name_hash[name_hashval]);
+}
+
+/* caller must hold readlock */
+static inline struct gss_cacheent *
+gss_searchbyid(struct gss_mapping *map, uid_t id)
+{
+	unsigned int hashval = GSS_ID_HASH(id);
+	struct list_head *l;
+	struct gss_cacheent *p;
+
+	list_for_each(l, &map->id_hash[hashval]) {
+		p = list_entry(l, struct gss_cacheent, id_hash);
+		if (p->id == id)
+			return p;
+	}
+	return NULL;
+}
+
+/* caller must hold readlock */
+static inline struct gss_cacheent *
+gss_searchbyname(struct gss_mapping *map, unsigned int len, const unsigned char *name,
+		 unsigned int hash)
+{
+	unsigned int hashval = hash & GSS_HASH_MASK;
+	struct list_head *l;
+	struct gss_cacheent *p;
+
+	list_for_each(l, &map->name_hash[hashval]) {
+		p = list_entry(l, struct gss_cacheent, name_hash);
+		if ((p->name.len == len) && !memcmp(p->name.name, name, len))
+			return p;
+	}
+	return NULL;
+}
+
+int
+gss_get_name(int type, uid_t id, struct gss_cacheent **pp)
+{
+	struct gss_mapping *map;
+	struct gss_cacheent *p, *q;
+	int status;
+
+	switch (type) {
+	case GSS_OWNER:
+		map = &owner_map;
+		break;
+	case GSS_GROUP:
+		map = &group_map;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	read_lock(&map->lock);
+	if ((p = gss_searchbyid(map, id))) {
+		atomic_inc(&p->refcount);
+		read_unlock(&map->lock);
+		*pp = p;
+		return 0;
+	}
+	read_unlock(&map->lock);
+
+	if (!(p = gss_alloc(0)))
+		return -ENOMEM;
+	p->id = id;
+
+	if (type == GSS_OWNER)
+		status = gssd_uid_to_name(&id, &p->name);
+	else     /* GSS_GROUP */
+		status = gssd_gid_to_name(&id, &p->name);
+	if (status < 0) {
+		gss_put(p);
+		return status;
+	}
+	p->name.hash = GSS_NAME_HASH(p->name.name, p->name.len);
+
+	write_lock(&map->lock);
+	if ((q = gss_searchbyid(map, id))) {  /* retry the search, since we slept */
+		*pp = q;
+		atomic_inc(&q->refcount);
+		write_unlock(&map->lock);
+		gss_put(p);
+		return 0;
+	}
+	gss_insert(p, map);
+	atomic_inc(&p->refcount);
+	write_unlock(&map->lock);
+	*pp = p;
+	return 0;
+}
+
+int
+gss_get_num(int type, unsigned int len, const unsigned char *name, uid_t *pp)
+{
+	unsigned int hash;
+	struct gss_mapping *map;
+	struct gss_cacheent *p, *q;
+	int status;
+
+	if (len > XDR_MAX_NETOBJ)
+		return -EINVAL;
+
+	hash = GSS_NAME_HASH(name, len);
+
+	switch (type) {
+	case GSS_OWNER:
+		map = &owner_map;
+		break;
+	case GSS_GROUP:
+		map = &group_map;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	read_lock(&map->lock);
+	if ((p = gss_searchbyname(map, len, name, hash))) {
+		read_unlock(&map->lock);
+		*pp = p->id;
+		return 0;
+	}
+	read_unlock(&map->lock);
+
+	if (!(p = gss_alloc(len)))
+		return -ENOMEM;
+	p->name.len = len;
+	memcpy((char *)p->name.name, name, len);    /* cast is to get rid of "const" */
+	p->name.hash = hash;
+
+	if (type == GSS_OWNER)
+		status = gssd_name_to_uid(&p->name, &p->id);
+	else     /* GSS_GROUP */
+		status = gssd_name_to_gid(&p->name, &p->id);
+	if (status < 0) {
+		gss_put(p);
+		return status;
+	}
+
+	write_lock(&map->lock);
+	if ((q = gss_searchbyname(map, len, name, hash))) {
+		*pp = q->id;
+		write_unlock(&map->lock);
+		gss_put(p);
+		return 0;
+	}
+	*pp = p->id;
+	gss_insert(p, map);
+	write_unlock(&map->lock);
+	return 0;
+}
+
+void
+gss_cache_init(void)
+{
+	gss_mapping_init(&owner_map);
+	gss_mapping_init(&group_map);
+}
+
+void
+gss_cache_exit(void)
+{
+	gss_mapping_destroy(&group_map);
+	gss_mapping_destroy(&owner_map);
+}
+
+/*
+ * Local variables:
+ *  c-basic-offset: 8
+ * End:
+ */

