Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319121AbSHMX0J>; Tue, 13 Aug 2002 19:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319131AbSHMXE7>; Tue, 13 Aug 2002 19:04:59 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:8956 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319121AbSHMXBG>; Tue, 13 Aug 2002 19:01:06 -0400
Date: Tue, 13 Aug 2002 19:04:55 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 21/38: CLIENT: giant patch importing NFSv4 client functionality
Message-ID: <Pine.SOL.4.44.0208131904330.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that all the hooks are in place, this large patch imports all
of the new code for the NFSv4 client.
  nfs4proc.c   - procedure vectors
  nfs4xdr.c    - XDR
  nfs4state.c  - state bookkeeping (very minimal for now)
  nfs4renewd.c - a daemon (implemented as an rpc_task) to keep
                 state from expiring on the server

This patch makes almost no changes to the existing NFS codebase
(these have been taken care of by the preceding patches).

--- old/fs/nfs/Makefile	Wed Jul 24 16:03:22 2002
+++ new/fs/nfs/Makefile	Mon Jul 29 11:50:09 2002
@@ -8,6 +8,7 @@ nfs-y 			:= dir.o file.o flushd.o inode.
 			   proc.o read.o symlink.o unlink.o write.o
 nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o mount_clnt.o
 nfs-$(CONFIG_NFS_V3)	+= nfs3proc.o nfs3xdr.o
+nfs-$(CONFIG_NFS_V4)	+= nfs4proc.o nfs4xdr.o nfs4state.o nfs4renewd.o
 nfs-objs		:= $(nfs-y)

 include $(TOPDIR)/Rules.make
--- old/fs/nfs/file.c	Wed Jul 24 16:03:29 2002
+++ new/fs/nfs/file.c	Mon Jul 29 11:50:09 2002
@@ -254,6 +254,12 @@ nfs_lock(struct file *filp, int cmd, str
 	if (!inode)
 		return -EINVAL;

+	/* This will be in a forthcoming patch. */
+	if (NFS_PROTO(inode)->version == 4) {
+		printk(KERN_INFO "NFS: file locking over NFSv4 is not yet supported\n");
+		return -EIO;
+	}
+
 	/* No mandatory locks over NFS */
 	if ((inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
 		return -ENOLCK;
--- old/fs/nfs/inode.c	Thu Aug  8 18:23:31 2002
+++ new/fs/nfs/inode.c	Thu Aug  8 09:34:16 2002
@@ -76,8 +76,13 @@ static struct rpc_version *	nfs_version[
 	NULL,
 	NULL,
 	&nfs_version2,
-#ifdef CONFIG_NFS_V3
+#if defined(CONFIG_NFS_V3)
 	&nfs_version3,
+#elif defined(CONFIG_NFS_V4)
+	NULL,
+#endif
+#if defined(CONFIG_NFS_V4)
+	&nfs_version4,
 #endif
 };

@@ -284,7 +289,20 @@ int nfs_fill_super(struct super_block *s
  nfsv3_try_again:
 	/* Check NFS protocol revision and initialize RPC op vector
 	 * and file handle pool. */
-	if (data->flags & NFS_MOUNT_VER3) {
+	if (data->flags & NFS_MOUNT_VER4) {
+#ifdef CONFIG_NFS_V4
+		server->rpc_ops = &nfs_v4_clientops;
+		version = 4;
+		if (data->version < 5) {
+			printk(KERN_NOTICE "NFS: NFSv4 not supported by mount program.\n");
+			goto out_unlock;
+		}
+#else
+		printk(KERN_NOTICE "NFS: NFSv4 not supported.\n");
+		goto out_unlock;
+#endif
+	}
+	else if (data->flags & NFS_MOUNT_VER3) {
 #ifdef CONFIG_NFS_V3
 		server->rpc_ops = &nfs_v3_clientops;
 		version = 3;
--- old/include/linux/nfs_fs.h	Sat Aug 10 23:58:26 2002
+++ new/include/linux/nfs_fs.h	Thu Aug  8 18:10:03 2002
@@ -446,6 +446,24 @@ extern void * nfs_root_data(void);
 #define NFS_JUKEBOX_RETRY_TIME (5 * HZ)

 #ifdef CONFIG_NFS_V4
+struct nfs4_client {
+        atomic_t                cl_count;       /* refcount */
+        u64                     cl_clientid;    /* constant */
+
+        /*
+         * Starts a list of lockowners, linked through lo_list.
+	 */
+        struct list_head        cl_lockowners;  /* protected by state_spinlock */
+};
+
+/* nfs4proc.c */
+extern int nfs4_proc_renew(struct nfs_server *server);
+
+/* nfs4renewd.c */
+extern int nfs4_init_renewd(struct nfs_server *server);
+#endif /* CONFIG_NFS_V4 */
+
+#ifdef CONFIG_NFS_V4

 extern struct nfs4_client *nfs4_get_client(void);
 extern void nfs4_put_client(struct nfs4_client *clp);
--- old/include/linux/nfs_xdr.h	Sat Aug 10 23:57:02 2002
+++ new/include/linux/nfs_xdr.h	Tue Aug  6 10:16:09 2002
@@ -299,6 +299,216 @@ struct nfs3_readdirres {
 	int			plus;
 };

+#ifdef CONFIG_NFS_V4
+
+typedef u64 clientid4;
+
+struct nfs4_change_info {
+	u32				atomic;
+	u64				before;
+	u64				after;
+};
+
+struct nfs4_access {
+	u32				ac_req_access;     /* request */
+	u32 *				ac_resp_supported; /* response */
+	u32 *				ac_resp_access;    /* response */
+};
+
+struct nfs4_close {
+	char *				cl_stateid;        /* request */
+	u32				cl_seqid;          /* request */
+};
+
+struct nfs4_commit {
+	u64				co_start;          /* request */
+	u32				co_len;            /* request */
+	struct nfs_writeverf *		co_verifier;       /* response */
+};
+
+struct nfs4_create {
+	u32				cr_ftype;          /* request */
+	union {                                            /* request */
+		struct {
+			u32		textlen;
+			const char *	text;
+		} symlink;   /* NF4LNK */
+		struct {
+			u32		specdata1;
+			u32		specdata2;
+		} device;    /* NF4BLK, NF4CHR */
+	} u;
+	u32				cr_namelen;        /* request */
+	const char *			cr_name;           /* request */
+	struct iattr *			cr_attrs;          /* request */
+	struct nfs4_change_info	*	cr_cinfo;          /* response */
+};
+#define cr_textlen			u.symlink.textlen
+#define cr_text				u.symlink.text
+#define cr_specdata1			u.device.specdata1
+#define cr_specdata2			u.device.specdata2
+
+struct nfs4_getattr {
+        u32 *				gt_bmval;          /* request */
+        struct nfs_fattr *		gt_attrs;          /* response */
+	struct nfs_fsinfo *		gt_fsinfo;         /* response */
+};
+
+struct nfs4_getfh {
+	struct nfs_fh *			gf_fhandle;       /* response */
+};
+
+struct nfs4_link {
+	u32				ln_namelen;       /* request */
+	const char *			ln_name;          /* request */
+	struct nfs4_change_info *	ln_cinfo;         /* response */
+};
+
+struct nfs4_lookup {
+	struct qstr *			lo_name;          /* request */
+};
+
+struct nfs4_open {
+	u32				op_share_access;  /* request */
+	u32				op_opentype;      /* request */
+	u32				op_createmode;    /* request */
+	union {                                           /* request */
+		struct iattr *		attrs;    /* UNCHECKED, GUARDED */
+		nfs4_verifier		verifier; /* EXCLUSIVE */
+	} u;
+	struct qstr *			op_name;          /* request */
+	char *				op_stateid;       /* response */
+	struct nfs4_change_info	*	op_cinfo;         /* response */
+	u32 *				op_rflags;        /* response */
+};
+#define op_attrs     u.attrs
+#define op_verifier  u.verifier
+
+struct nfs4_open_confirm {
+	char *				oc_stateid;       /* request */
+};
+
+struct nfs4_putfh {
+	struct nfs_fh *			pf_fhandle;       /* request */
+};
+
+struct nfs4_read {
+	u64				rd_offset;        /* request */
+	u32				rd_length;        /* request */
+	u32				*rd_eof;          /* response */
+	u32				*rd_bytes_read;   /* response */
+	struct page **			rd_pages;   /* zero-copy data */
+	unsigned int			rd_pgbase;  /* zero-copy data */
+};
+
+struct nfs4_readdir {
+	u64				rd_cookie;        /* request */
+	nfs4_verifier			rd_req_verifier;  /* request */
+	u32				rd_count;         /* request */
+	u32				rd_bmval[2];      /* request */
+	nfs4_verifier			rd_resp_verifier; /* response */
+	struct page **			rd_pages;   /* zero-copy data */
+	unsigned int			rd_pgbase;  /* zero-copy data */
+};
+
+struct nfs4_readlink {
+	u32				rl_count;   /* zero-copy data */
+	struct page **			rl_pages;   /* zero-copy data */
+};
+
+struct nfs4_remove {
+	u32				rm_namelen;       /* request */
+	const char *			rm_name;          /* request */
+	struct nfs4_change_info *	rm_cinfo;         /* response */
+};
+
+struct nfs4_rename {
+	u32				rn_oldnamelen;    /* request */
+	const char *			rn_oldname;       /* request */
+	u32				rn_newnamelen;    /* request */
+	const char *			rn_newname;       /* request */
+	struct nfs4_change_info	*	rn_src_cinfo;     /* response */
+	struct nfs4_change_info *	rn_dst_cinfo;     /* response */
+};
+
+struct nfs4_setattr {
+	char *				st_stateid;       /* request */
+	struct iattr *			st_iap;           /* request */
+};
+
+struct nfs4_setclientid {
+	nfs4_verifier			sc_verifier;      /* request */
+	char *				sc_name;	  /* request */
+	u32				sc_prog;          /* request */
+	char				sc_netid[4];	  /* request */
+	char				sc_uaddr[24];     /* request */
+	u32				sc_cb_ident;      /* request */
+};
+
+struct nfs4_write {
+	u64				wr_offset;        /* request */
+	u32				wr_stable_how;    /* request */
+	u32				wr_len;           /* request */
+	u32 *				wr_bytes_written; /* response */
+	struct nfs_writeverf *		wr_verf;          /* response */
+	struct page **			wr_pages;   /* zero-copy data */
+	unsigned int			wr_pgbase;  /* zero-copy data */
+};
+
+struct nfs4_op {
+	u32				opnum;
+	u32				nfserr;
+	union {
+		struct nfs4_access	access;
+		struct nfs4_close	close;
+		struct nfs4_commit	commit;
+		struct nfs4_create	create;
+		struct nfs4_getattr	getattr;
+		struct nfs4_getfh	getfh;
+		struct nfs4_link	link;
+		struct nfs4_lookup	lookup;
+		struct nfs4_open	open;
+		struct nfs4_open_confirm open_confirm;
+		struct nfs4_putfh	putfh;
+		struct nfs4_read	read;
+		struct nfs4_readdir	readdir;
+		struct nfs4_readlink	readlink;
+		struct nfs4_remove	remove;
+		struct nfs4_rename	rename;
+		struct nfs4_setattr	setattr;
+		struct nfs4_setclientid	setclientid;
+		struct nfs4_write	write;
+	} u;
+};
+
+struct nfs4_compound {
+	unsigned int		flags;   /* defined below */
+	struct nfs_server *	server;
+
+	/* RENEW information */
+	int			renew_index;
+	unsigned long		timestamp;
+
+	/* scratch variables for XDR encode/decode */
+	int			nops;
+	u32 *			p;
+	u32 *			end;
+
+	/* the individual COMPOUND operations */
+	struct nfs4_op		*ops;
+
+	/* request */
+	int			req_nops;
+	u32			taglen;
+	char *			tag;
+
+	/* response */
+	int			resp_nops;
+	int			toplevel_status;
+};
+
+#endif /* CONFIG_NFS_V4 */
+
 struct nfs_read_data {
 	struct rpc_task		task;
 	struct inode		*inode;
@@ -312,7 +522,11 @@ struct nfs_read_data {
 			struct nfs_readres  res;
 		} v3;   /* also v2 */
 #ifdef CONFIG_NFS_V4
-		/* NFSv4 data will come here... */
+		struct {
+			struct nfs4_compound  compound;
+			struct nfs4_op        ops[3];
+			u32                   res_count;
+		} v4;
 #endif
 	} u;
 };
@@ -327,11 +541,17 @@ struct nfs_write_data {
 	struct page		*pagevec[NFS_WRITE_MAXIOV];
 	union {
 		struct {
-			struct nfs_writeargs args;
-			struct nfs_writeres  res;
+			struct nfs_writeargs	args;		/* argument struct */
+			struct nfs_writeres	res;		/* result struct */
 		} v3;
 #ifdef CONFIG_NFS_V4
-		/* NFSv4 data to come here... */
+		struct {
+			struct nfs4_compound  compound;
+			struct nfs4_op        ops[3];
+			u32                   arg_count;
+			u32                   arg_stable;
+			u32                   res_count;
+		} v4;
 #endif
 	} u;
 };
@@ -400,8 +620,10 @@ struct nfs_rpc_ops {
  */
 extern struct nfs_rpc_ops	nfs_v2_clientops;
 extern struct nfs_rpc_ops	nfs_v3_clientops;
+extern struct nfs_rpc_ops	nfs_v4_clientops;
 extern struct rpc_version	nfs_version2;
 extern struct rpc_version	nfs_version3;
+extern struct rpc_version	nfs_version4;
 extern struct rpc_program	nfs_program;
 extern struct rpc_stat		nfs_rpcstat;

--- old/fs/nfs/nfs4proc.c	Wed Dec 31 18:00:00 1969
+++ new/fs/nfs/nfs4proc.c	Tue Aug  6 10:16:02 2002
@@ -0,0 +1,1452 @@
+/*
+ *  fs/nfs/nfs4proc.c
+ *
+ *  Client-side procedure declarations for NFSv4.
+ *
+ *  Copyright (c) 2002 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Kendrick Smith <kmsmith@umich.edu>
+ *  Andy Adamson   <andros@umich.edu>
+ */
+
+#include <linux/mm.h>
+#include <linux/utsname.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/sunrpc/clnt.h>
+#include <linux/nfs.h>
+#include <linux/nfs4.h>
+#include <linux/nfs_fs.h>
+#include <linux/nfs_page.h>
+#include <linux/smp_lock.h>
+
+#define NFSDBG_FACILITY		NFSDBG_PROC
+
+#define GET_OP(cp,name)		&cp->ops[cp->req_nops].u.name
+#define OPNUM(cp)		cp->ops[cp->req_nops].opnum
+
+extern u32 *nfs4_decode_dirent(u32 *p, struct nfs_entry *entry, int plus);
+
+static nfs4_stateid zero_stateid =
+  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
+static spinlock_t renew_lock = SPIN_LOCK_UNLOCKED;
+
+static void
+nfs4_setup_compound(struct nfs4_compound *cp, struct nfs4_op *ops,
+		    struct nfs_server *server, char *tag)
+{
+	memset(cp, 0, sizeof(*cp));
+	cp->ops = ops;
+	cp->server = server;
+
+#if NFS4_DEBUG
+	cp->taglen = strlen(tag);
+	cp->tag = tag;
+#endif
+}
+
+static void
+nfs4_setup_access(struct nfs4_compound *cp, u32 req_access, u32 *resp_supported, u32 *resp_access)
+{
+	struct nfs4_access *access = GET_OP(cp, access);
+
+	access->ac_req_access = req_access;
+	access->ac_resp_supported = resp_supported;
+	access->ac_resp_access = resp_access;
+
+	OPNUM(cp) = OP_ACCESS;
+	cp->req_nops++;
+}
+
+static void
+nfs4_setup_close(struct nfs4_compound *cp, nfs4_stateid stateid, u32 seqid)
+{
+	struct nfs4_close *close = GET_OP(cp, close);
+
+	close->cl_stateid = stateid;
+	close->cl_seqid = seqid;
+
+	OPNUM(cp) = OP_CLOSE;
+	cp->req_nops++;
+	cp->renew_index = cp->req_nops;
+}
+
+static void
+nfs4_setup_commit(struct nfs4_compound *cp, u64 start, u32 len, struct nfs_writeverf *verf)
+{
+	struct nfs4_commit *commit = GET_OP(cp, commit);
+
+	commit->co_start = start;
+	commit->co_len = len;
+	commit->co_verifier = verf;
+
+	OPNUM(cp) = OP_COMMIT;
+	cp->req_nops++;
+}
+
+static void
+nfs4_setup_create_dir(struct nfs4_compound *cp, struct qstr *name,
+		      struct iattr *sattr, struct nfs4_change_info *info)
+{
+	struct nfs4_create *create = GET_OP(cp, create);
+
+	create->cr_ftype = NF4DIR;
+	create->cr_namelen = name->len;
+	create->cr_name = name->name;
+	create->cr_attrs = sattr;
+	create->cr_cinfo = info;
+
+	OPNUM(cp) = OP_CREATE;
+	cp->req_nops++;
+}
+
+static void
+nfs4_setup_create_symlink(struct nfs4_compound *cp, struct qstr *name,
+			  struct qstr *linktext, struct iattr *sattr,
+			  struct nfs4_change_info *info)
+{
+	struct nfs4_create *create = GET_OP(cp, create);
+
+	create->cr_ftype = NF4LNK;
+	create->cr_textlen = linktext->len;
+	create->cr_text = linktext->name;
+	create->cr_namelen = name->len;
+	create->cr_name = name->name;
+	create->cr_attrs = sattr;
+	create->cr_cinfo = info;
+
+	OPNUM(cp) = OP_CREATE;
+	cp->req_nops++;
+}
+
+static void
+nfs4_setup_create_special(struct nfs4_compound *cp, struct qstr *name,
+			    dev_t dev, struct iattr *sattr,
+			    struct nfs4_change_info *info)
+{
+	int mode = sattr->ia_mode;
+	struct nfs4_create *create = GET_OP(cp, create);
+
+	BUG_ON(!(sattr->ia_valid & ATTR_MODE));
+	BUG_ON(!S_ISFIFO(mode) && !S_ISBLK(mode) && !S_ISCHR(mode) && !S_ISSOCK(mode));
+
+	if (S_ISFIFO(mode))
+		create->cr_ftype = NF4FIFO;
+	else if (S_ISBLK(mode)) {
+		create->cr_ftype = NF4BLK;
+		create->cr_specdata1 = MAJOR(dev);
+		create->cr_specdata2 = MINOR(dev);
+	}
+	else if (S_ISCHR(mode)) {
+		create->cr_ftype = NF4CHR;
+		create->cr_specdata1 = MAJOR(dev);
+		create->cr_specdata2 = MINOR(dev);
+	}
+	else
+		create->cr_ftype = NF4SOCK;
+
+	create->cr_namelen = name->len;
+	create->cr_name = name->name;
+	create->cr_attrs = sattr;
+	create->cr_cinfo = info;
+
+	OPNUM(cp) = OP_CREATE;
+	cp->req_nops++;
+}
+
+/*
+ * This is our standard bitmap for GETATTR requests.
+ */
+u32 nfs4_standard_bitmap[2] = {
+	FATTR4_WORD0_TYPE
+	| FATTR4_WORD0_CHANGE
+	| FATTR4_WORD0_SIZE
+	| FATTR4_WORD0_FSID
+	| FATTR4_WORD0_FILEID,
+	FATTR4_WORD1_MODE
+	| FATTR4_WORD1_NUMLINKS
+	| FATTR4_WORD1_OWNER
+	| FATTR4_WORD1_OWNER_GROUP
+	| FATTR4_WORD1_RAWDEV
+	| FATTR4_WORD1_SPACE_USED
+	| FATTR4_WORD1_TIME_ACCESS
+	| FATTR4_WORD1_TIME_METADATA
+	| FATTR4_WORD1_TIME_MODIFY
+};
+
+u32 nfs4_statfs_bitmap[2] = {
+	FATTR4_WORD0_FILES_AVAIL
+	| FATTR4_WORD0_FILES_FREE
+	| FATTR4_WORD0_FILES_TOTAL
+	| FATTR4_WORD0_MAXFILESIZE
+	| FATTR4_WORD0_MAXLINK
+	| FATTR4_WORD0_MAXNAME
+	| FATTR4_WORD0_MAXREAD
+        | FATTR4_WORD0_MAXWRITE,
+	FATTR4_WORD1_SPACE_AVAIL
+	| FATTR4_WORD1_SPACE_FREE
+	| FATTR4_WORD1_SPACE_TOTAL
+};
+
+/* mount bitmap: standard bitmap + statfs bitmap + lease time */
+u32 nfs4_mount_bitmap[2] = {
+	FATTR4_WORD0_TYPE
+	| FATTR4_WORD0_CHANGE
+	| FATTR4_WORD0_SIZE
+	| FATTR4_WORD0_FSID
+	| FATTR4_WORD0_LEASE_TIME
+	| FATTR4_WORD0_FILEID
+	| FATTR4_WORD0_FILES_AVAIL
+	| FATTR4_WORD0_FILES_TOTAL
+	| FATTR4_WORD0_MAXFILESIZE
+	| FATTR4_WORD0_MAXLINK
+	| FATTR4_WORD0_MAXNAME
+	| FATTR4_WORD0_MAXREAD
+	| FATTR4_WORD0_MAXWRITE,
+	FATTR4_WORD1_MODE
+	| FATTR4_WORD1_NUMLINKS
+	| FATTR4_WORD1_OWNER
+	| FATTR4_WORD1_OWNER_GROUP
+	| FATTR4_WORD1_RAWDEV
+	| FATTR4_WORD1_SPACE_AVAIL
+	| FATTR4_WORD1_SPACE_FREE
+	| FATTR4_WORD1_SPACE_TOTAL
+	| FATTR4_WORD1_SPACE_USED
+	| FATTR4_WORD1_TIME_ACCESS
+	| FATTR4_WORD1_TIME_METADATA
+	| FATTR4_WORD1_TIME_MODIFY
+};
+
+static void
+nfs4_setup_getattr(struct nfs4_compound *cp, u32 *bitmap,
+		   struct nfs_fattr *fattr, struct nfs_fsinfo *fsinfo)
+{
+        struct nfs4_getattr *getattr = GET_OP(cp, getattr);
+
+        getattr->gt_bmval = bitmap;
+        getattr->gt_attrs = fattr;
+	getattr->gt_fsinfo = fsinfo;
+
+        OPNUM(cp) = OP_GETATTR;
+        cp->req_nops++;
+}
+
+static void
+nfs4_setup_getfh(struct nfs4_compound *cp, struct nfs_fh *fhandle)
+{
+	struct nfs4_getfh *getfh = GET_OP(cp, getfh);
+
+	getfh->gf_fhandle = fhandle;
+
+	OPNUM(cp) = OP_GETFH;
+	cp->req_nops++;
+}
+
+static void
+nfs4_setup_link(struct nfs4_compound *cp, struct qstr *name,
+		struct nfs4_change_info *info)
+{
+	struct nfs4_link *link = GET_OP(cp, link);
+
+	link->ln_namelen = name->len;
+	link->ln_name = name->name;
+	link->ln_cinfo = info;
+
+	OPNUM(cp) = OP_LINK;
+	cp->req_nops++;
+}
+
+static void
+nfs4_setup_lookup(struct nfs4_compound *cp, struct qstr *q)
+{
+	struct nfs4_lookup *lookup = GET_OP(cp, lookup);
+
+	lookup->lo_name = q;
+
+	OPNUM(cp) = OP_LOOKUP;
+	cp->req_nops++;
+}
+
+static void
+nfs4_setup_putfh(struct nfs4_compound *cp, struct nfs_fh *fhandle)
+{
+	struct nfs4_putfh *putfh = GET_OP(cp, putfh);
+
+	putfh->pf_fhandle = fhandle;
+
+	OPNUM(cp) = OP_PUTFH;
+	cp->req_nops++;
+}
+
+static void
+nfs4_setup_putrootfh(struct nfs4_compound *cp)
+{
+        OPNUM(cp) = OP_PUTROOTFH;
+        cp->req_nops++;
+}
+
+static void
+nfs4_setup_open(struct nfs4_compound *cp, int flags, struct qstr *name,
+		struct iattr *sattr, char *stateid, struct nfs4_change_info *cinfo,
+		u32 *rflags)
+{
+	struct nfs4_open *open = GET_OP(cp, open);
+
+	BUG_ON(cp->flags);
+
+	open->op_share_access = flags & 3;
+	open->op_opentype = (flags & O_CREAT) ? NFS4_OPEN_CREATE : NFS4_OPEN_NOCREATE;
+	open->op_createmode = NFS4_CREATE_UNCHECKED;
+	open->op_attrs = sattr;
+	if (flags & O_EXCL) {
+		u32 *p = (u32 *) open->op_verifier;
+		p[0] = jiffies;
+		p[1] = current->pid;
+		open->op_createmode = NFS4_CREATE_EXCLUSIVE;
+	}
+	open->op_name = name;
+	open->op_stateid = stateid;
+	open->op_cinfo = cinfo;
+	open->op_rflags = rflags;
+
+	OPNUM(cp) = OP_OPEN;
+	cp->req_nops++;
+	cp->renew_index = cp->req_nops;
+}
+
+static void
+nfs4_setup_open_confirm(struct nfs4_compound *cp, char *stateid)
+{
+	struct nfs4_open_confirm *open_confirm = GET_OP(cp, open_confirm);
+
+	open_confirm->oc_stateid = stateid;
+
+	OPNUM(cp) = OP_OPEN_CONFIRM;
+	cp->req_nops++;
+	cp->renew_index = cp->req_nops;
+}
+
+static void
+nfs4_setup_read(struct nfs4_compound *cp, u64 offset, u32 length,
+		struct page **pages, unsigned int pgbase, u32 *eofp, u32 *bytes_read)
+{
+	struct nfs4_read *read = GET_OP(cp, read);
+
+	read->rd_offset = offset;
+	read->rd_length = length;
+	read->rd_pages = pages;
+	read->rd_pgbase = pgbase;
+	read->rd_eof = eofp;
+	read->rd_bytes_read = bytes_read;
+
+	OPNUM(cp) = OP_READ;
+	cp->req_nops++;
+}
+
+static void
+nfs4_setup_readdir(struct nfs4_compound *cp, u64 cookie, u32 *verifier,
+		     struct page **pages, unsigned int bufsize, struct dentry *dentry)
+{
+	u32 *start, *p;
+	struct nfs4_readdir *readdir = GET_OP(cp, readdir);
+
+	BUG_ON(bufsize < 80);
+	readdir->rd_cookie = (cookie > 2) ? cookie : 0;
+	memcpy(readdir->rd_req_verifier, verifier, sizeof(nfs4_verifier));
+	readdir->rd_count = bufsize;
+	readdir->rd_bmval[0] = FATTR4_WORD0_FILEID;
+	readdir->rd_bmval[1] = 0;
+	readdir->rd_pages = pages;
+	readdir->rd_pgbase = 0;
+
+	OPNUM(cp) = OP_READDIR;
+	cp->req_nops++;
+
+	if (cookie >= 2)
+		return;
+
+	/*
+	 * NFSv4 servers do not return entries for '.' and '..'
+	 * Therefore, we fake these entries here.  We let '.'
+	 * have cookie 0 and '..' have cookie 1.  Note that
+	 * when talking to the server, we always send cookie 0
+	 * instead of 1 or 2.
+	 */
+	start = p = (u32 *)kmap(*pages);
+
+	if (cookie == 0) {
+		*p++ = xdr_one;                                  /* next */
+		*p++ = xdr_zero;                   /* cookie, first word */
+		*p++ = xdr_one;                   /* cookie, second word */
+		*p++ = xdr_one;                             /* entry len */
+		memcpy(p, ".\0\0\0", 4);                        /* entry */
+		p++;
+		*p++ = xdr_one;                         /* bitmap length */
+		*p++ = htonl(FATTR4_WORD0_FILEID);             /* bitmap */
+		*p++ = htonl(8);              /* attribute buffer length */
+		p = xdr_encode_hyper(p, NFS_FILEID(dentry->d_inode));
+	}
+
+	*p++ = xdr_one;                                  /* next */
+	*p++ = xdr_zero;                   /* cookie, first word */
+	*p++ = xdr_two;                   /* cookie, second word */
+	*p++ = xdr_two;                             /* entry len */
+	memcpy(p, "..\0\0", 4);                         /* entry */
+	p++;
+	*p++ = xdr_one;                         /* bitmap length */
+	*p++ = htonl(FATTR4_WORD0_FILEID);             /* bitmap */
+	*p++ = htonl(8);              /* attribute buffer length */
+	p = xdr_encode_hyper(p, NFS_FILEID(dentry->d_parent->d_inode));
+
+	readdir->rd_pgbase = (char *)p - (char *)start;
+	readdir->rd_count -= readdir->rd_pgbase;
+	kunmap(*pages);
+}
+
+static void
+nfs4_setup_readlink(struct nfs4_compound *cp, int count, struct page **pages)
+{
+	struct nfs4_readlink *readlink = GET_OP(cp, readlink);
+
+	readlink->rl_count = count;
+	readlink->rl_pages = pages;
+
+	OPNUM(cp) = OP_READLINK;
+	cp->req_nops++;
+}
+
+static void
+nfs4_setup_remove(struct nfs4_compound *cp, struct qstr *name, struct nfs4_change_info *cinfo)
+{
+	struct nfs4_remove *remove = GET_OP(cp, remove);
+
+	remove->rm_namelen = name->len;
+	remove->rm_name = name->name;
+	remove->rm_cinfo = cinfo;
+
+	OPNUM(cp) = OP_REMOVE;
+	cp->req_nops++;
+}
+
+static void
+nfs4_setup_rename(struct nfs4_compound *cp, struct qstr *old, struct qstr *new,
+		  struct nfs4_change_info *old_cinfo, struct nfs4_change_info *new_cinfo)
+{
+	struct nfs4_rename *rename = GET_OP(cp, rename);
+
+	rename->rn_oldnamelen = old->len;
+	rename->rn_oldname = old->name;
+	rename->rn_newnamelen = new->len;
+	rename->rn_newname = new->name;
+	rename->rn_src_cinfo = old_cinfo;
+	rename->rn_dst_cinfo = new_cinfo;
+
+	OPNUM(cp) = OP_RENAME;
+	cp->req_nops++;
+}
+
+static void
+nfs4_setup_renew(struct nfs4_compound *cp)
+{
+	OPNUM(cp) = OP_RENEW;
+	cp->req_nops++;
+	cp->renew_index = cp->req_nops;
+}
+
+static void
+nfs4_setup_restorefh(struct nfs4_compound *cp)
+{
+        OPNUM(cp) = OP_RESTOREFH;
+        cp->req_nops++;
+}
+
+static void
+nfs4_setup_savefh(struct nfs4_compound *cp)
+{
+        OPNUM(cp) = OP_SAVEFH;
+        cp->req_nops++;
+}
+
+static void
+nfs4_setup_setattr(struct nfs4_compound *cp, char *stateid, struct iattr *iap)
+{
+	struct nfs4_setattr *setattr = GET_OP(cp, setattr);
+
+	setattr->st_stateid = stateid;
+	setattr->st_iap = iap;
+
+	OPNUM(cp) = OP_SETATTR;
+	cp->req_nops++;
+}
+
+static void
+nfs4_setup_setclientid(struct nfs4_compound *cp, u32 program, unsigned short port)
+{
+	struct nfs4_setclientid *setclientid = GET_OP(cp, setclientid);
+	struct nfs_server *server = cp->server;
+	struct timeval tv;
+	u32 *p;
+
+	do_gettimeofday(&tv);
+	p = (u32 *)setclientid->sc_verifier;
+	*p++ = tv.tv_sec;
+	*p++ = tv.tv_usec;
+	setclientid->sc_name = server->ip_addr;
+	sprintf(setclientid->sc_netid, "udp");
+	sprintf(setclientid->sc_uaddr, "%s.%d.%d", server->ip_addr, port >> 8, port & 255);
+	setclientid->sc_prog = program;
+	setclientid->sc_cb_ident = 0;
+
+	OPNUM(cp) = OP_SETCLIENTID;
+	cp->req_nops++;
+}
+
+static void
+nfs4_setup_setclientid_confirm(struct nfs4_compound *cp)
+{
+	OPNUM(cp) = OP_SETCLIENTID_CONFIRM;
+	cp->req_nops++;
+	cp->renew_index = cp->req_nops;
+}
+
+static void
+nfs4_setup_write(struct nfs4_compound *cp, u64 offset, u32 length, int stable,
+		 struct page **pages, unsigned int pgbase, u32 *bytes_written,
+		 struct nfs_writeverf *verf)
+{
+	struct nfs4_write *write = GET_OP(cp, write);
+
+	write->wr_offset = offset;
+	write->wr_stable_how = stable;
+	write->wr_len = length;
+	write->wr_bytes_written = bytes_written;
+	write->wr_verf = verf;
+
+	write->wr_pages = pages;
+	write->wr_pgbase = pgbase;
+
+	OPNUM(cp) = OP_WRITE;
+	cp->req_nops++;
+}
+
+static inline void
+process_lease(struct nfs4_compound *cp)
+{
+	struct nfs_server *server;
+
+        /*
+         * Generic lease processing: If this operation contains a
+	 * lease-renewing operation, and it succeeded, update the RENEW time
+	 * in the superblock.  Instead of the current time, we use the time
+	 * when the request was sent out.  (All we know is that the lease was
+	 * renewed sometime between then and now, and we have to assume the
+	 * worst case.)
+	 *
+	 * Notes:
+	 *   (1) renewd doesn't acquire the spinlock when messing with
+	 *     server->last_renewal; this is OK since rpciod always runs
+	 *     under the BKL.
+	 *   (2) cp->timestamp was set at the end of XDR encode.
+         */
+	if (!cp->renew_index)
+		return;
+	if (!cp->toplevel_status || cp->resp_nops > cp->renew_index) {
+		server = cp->server;
+		spin_lock(&renew_lock);
+		if (server->last_renewal < cp->timestamp)
+			server->last_renewal = cp->timestamp;
+		printk("AAA updating last=%ld, tag=\"%.*s\"\n", cp->timestamp, (int)cp->taglen, cp->tag);
+		spin_unlock(&renew_lock);
+	}
+}
+
+static int
+nfs4_call_compound(struct nfs4_compound *cp, struct rpc_cred *cred, int flags)
+{
+	int status;
+	struct rpc_message msg = {
+		rpc_proc: NFSPROC4_COMPOUND,
+		rpc_argp: cp,
+		rpc_resp: cp,
+		rpc_cred: cred,
+	};
+
+	status = rpc_call_sync(cp->server->client, &msg, flags);
+	if (!status)
+		process_lease(cp);
+
+	return status;
+}
+
+static inline void
+process_cinfo(struct nfs4_change_info *info, struct nfs_fattr *fattr)
+{
+	BUG_ON((fattr->valid & NFS_ATTR_FATTR) == 0);
+	BUG_ON((fattr->valid & NFS_ATTR_FATTR_V4) == 0);
+
+	if (fattr->change_attr == info->after) {
+		fattr->pre_change_attr = info->before;
+		fattr->valid |= NFS_ATTR_PRE_CHANGE;
+	}
+}
+
+static int
+do_open(struct inode *dir, struct qstr *name, int flags, struct iattr *sattr,
+	struct nfs_fattr *fattr, struct nfs_fh *fhandle, u32 *seqid, char *stateid)
+{
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[7];
+	struct nfs4_change_info	dir_cinfo;
+	struct nfs_fattr	dir_attr;
+	u32			rflags;
+	int			status;
+
+	dir_attr.valid = 0;
+	fattr->valid = 0;
+	nfs4_setup_compound(&compound, ops, NFS_SERVER(dir), "open");
+	nfs4_setup_putfh(&compound, NFS_FH(dir));
+	nfs4_setup_savefh(&compound);
+	nfs4_setup_open(&compound, flags, name, sattr, stateid, &dir_cinfo, &rflags);
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, fattr, NULL);
+	nfs4_setup_getfh(&compound, fhandle);
+	nfs4_setup_restorefh(&compound);
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, &dir_attr, NULL);
+	if ((status = nfs4_call_compound(&compound, NULL, 0)))
+		return status;
+
+	process_cinfo(&dir_cinfo, &dir_attr);
+	nfs_refresh_inode(dir, &dir_attr);
+	if (!(rflags & NFS4_OPEN_RESULT_CONFIRM)) {
+		*seqid = 1;
+		return 0;
+	}
+	*seqid = 2;
+
+	nfs4_setup_compound(&compound, ops, NFS_SERVER(dir), "open_confirm");
+	nfs4_setup_putfh(&compound, fhandle);
+	nfs4_setup_open_confirm(&compound, stateid);
+	return nfs4_call_compound(&compound, NULL, 0);
+}
+
+static int
+do_setattr(struct nfs_server *server, struct nfs_fattr *fattr,
+	   struct nfs_fh *fhandle, struct iattr *sattr, char *stateid)
+{
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[3];
+
+	fattr->valid = 0;
+	nfs4_setup_compound(&compound, ops, server, "setattr");
+	nfs4_setup_putfh(&compound, fhandle);
+	nfs4_setup_setattr(&compound, stateid, sattr);
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, fattr, NULL);
+	return nfs4_call_compound(&compound, NULL, 0);
+}
+
+static int
+do_close(struct nfs_server *server, struct nfs_fh *fhandle, u32 seqid, char *stateid)
+{
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[2];
+
+	nfs4_setup_compound(&compound, ops, server, "close");
+	nfs4_setup_putfh(&compound, fhandle);
+	nfs4_setup_close(&compound, stateid, seqid);
+	return nfs4_call_compound(&compound, NULL, 0);
+}
+
+static int
+nfs4_proc_get_root(struct nfs_server *server, struct nfs_fh *fhandle,
+		   struct nfs_fattr *fattr)
+{
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[4];
+	struct nfs_fsinfo	fsinfo;
+	unsigned char *		p;
+	struct qstr		q;
+	int			status;
+
+	fattr->valid = 0;
+
+	if (!(server->nfs4_state = nfs4_get_client()))
+		return -ENOMEM;
+
+	/*
+	 * SETCLIENTID.
+	 * Until delegations are imported, we don't bother setting the program
+	 * number and port to anything meaningful.
+	 */
+	nfs4_setup_compound(&compound, ops, server, "setclientid");
+	nfs4_setup_setclientid(&compound, 0, 0);
+	if ((status = nfs4_call_compound(&compound, NULL, 0)))
+		goto out;
+
+	/*
+	 * SETCLIENTID_CONFIRM, plus root filehandle.
+	 * We also get the lease time here.
+	 */
+	nfs4_setup_compound(&compound, ops, server, "setclientid_confirm");
+	nfs4_setup_setclientid_confirm(&compound);
+	nfs4_setup_putrootfh(&compound);
+	nfs4_setup_getattr(&compound, nfs4_mount_bitmap, fattr, &fsinfo);
+	nfs4_setup_getfh(&compound, fhandle);
+	if ((status = nfs4_call_compound(&compound, NULL, 0)))
+		goto out;
+
+	/*
+	 * Now that we have instantiated the clientid and determined
+	 * the lease time, we can initialize the renew daemon for this
+	 * server.
+	 */
+	server->lease_time = fsinfo.lease_time * HZ;
+	if ((status = nfs4_init_renewd(server)))
+		goto out;
+
+	/*
+	 * Now we do a seperate LOOKUP for each component of the mount path.
+	 * The LOOKUPs are done seperately so that we can conveniently
+	 * catch an ERR_WRONGSEC if it occurs along the way...
+	 */
+	p = server->mnt_path;
+	for (;;) {
+		while (*p == '/')
+			p++;
+		if (!*p)
+			break;
+		q.name = p;
+		while (*p && (*p != '/'))
+			p++;
+		q.len = p - q.name;
+
+		nfs4_setup_compound(&compound, ops, server, "mount");
+		nfs4_setup_putfh(&compound, fhandle);
+		nfs4_setup_lookup(&compound, &q);
+		nfs4_setup_getattr(&compound, nfs4_standard_bitmap, fattr, NULL);
+		nfs4_setup_getfh(&compound, fhandle);
+		status = nfs4_call_compound(&compound, NULL, 0);
+		if (!status)
+			continue;
+		if (status == -ENOENT) {
+			printk(KERN_NOTICE "NFS: mount path %s does not exist!\n", server->mnt_path);
+			printk(KERN_NOTICE "NFS: suggestion: try mounting '/' instead.\n");
+		}
+		break;
+	}
+
+out:
+	return status;
+}
+
+static int
+nfs4_proc_getattr(struct inode *inode, struct nfs_fattr *fattr)
+{
+	struct nfs4_compound compound;
+	struct nfs4_op ops[2];
+
+	fattr->valid = 0;
+
+	nfs4_setup_compound(&compound, ops, NFS_SERVER(inode), "getattr");
+	nfs4_setup_putfh(&compound, NFS_FH(inode));
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, fattr, NULL);
+	return nfs4_call_compound(&compound, NULL, 0);
+}
+
+static int
+nfs4_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
+		  struct iattr *sattr)
+{
+	struct inode *		inode = dentry->d_inode;
+	int			size_change = sattr->ia_valid & ATTR_SIZE;
+	struct nfs_fh		throwaway_fh;
+	u32			seqid;
+	nfs4_stateid		stateid;
+	int			status;
+
+	fattr->valid = 0;
+
+	if (size_change) {
+		status = do_open(dentry->d_parent->d_inode, &dentry->d_name,
+				 NFS4_SHARE_ACCESS_WRITE, NULL, fattr,
+				 &throwaway_fh, &seqid, stateid);
+		if (status)
+			return status;
+
+		/*
+		 * Because OPEN is always done by name in nfsv4, it is
+		 * possible that we opened a different file by the same
+		 * name.  We can recognize this race condition, but we
+		 * can't do anything about it besides returning an error.
+		 *
+		 * XXX: Should we compare filehandles too, as in
+		 * nfs_find_actor()?
+		 */
+		if (fattr->fileid != NFS_FILEID(inode)) {
+			printk(KERN_WARNING "nfs: raced in setattr, returning -EIO\n");
+			do_close(NFS_SERVER(inode), NFS_FH(inode), seqid, stateid);
+			return -EIO;
+		}
+	}
+	else
+		memcpy(stateid, zero_stateid, sizeof(nfs4_stateid));
+
+	status = do_setattr(NFS_SERVER(inode), fattr, NFS_FH(inode), sattr, stateid);
+	if (size_change)
+		do_close(NFS_SERVER(inode), NFS_FH(inode), seqid, stateid);
+	return status;
+}
+
+static int
+nfs4_proc_lookup(struct inode *dir, struct qstr *name,
+		 struct nfs_fh *fhandle, struct nfs_fattr *fattr)
+{
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[5];
+	struct nfs_fattr	dir_attr;
+	int			status;
+
+	dir_attr.valid = 0;
+	fattr->valid = 0;
+
+	dprintk("NFS call  lookup %s\n", name->name);
+	nfs4_setup_compound(&compound, ops, NFS_SERVER(dir), "lookup");
+	nfs4_setup_putfh(&compound, NFS_FH(dir));
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, &dir_attr, NULL);
+	nfs4_setup_lookup(&compound, name);
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, fattr, NULL);
+	nfs4_setup_getfh(&compound, fhandle);
+	status = nfs4_call_compound(&compound, NULL, 0);
+	dprintk("NFS reply lookup: %d\n", status);
+
+	if (status >= 0)
+		status = nfs_refresh_inode(dir, &dir_attr);
+	return status;
+}
+
+static int
+nfs4_proc_access(struct inode *inode, int mode, int ruid)
+{
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[3];
+	struct nfs_fattr	fattr;
+	u32			req_access = 0, resp_supported, resp_access;
+	int			flags = ruid ? RPC_CALL_REALUID : 0;
+	int			status;
+
+	fattr.valid = 0;
+
+	/*
+	 * Determine which access bits we want to ask for...
+	 */
+	if (mode & MAY_READ)
+		req_access |= NFS4_ACCESS_READ;
+	if (S_ISDIR(inode->i_mode)) {
+		if (mode & MAY_WRITE)
+			req_access |= NFS4_ACCESS_MODIFY | NFS4_ACCESS_EXTEND | NFS4_ACCESS_DELETE;
+		if (mode & MAY_EXEC)
+			req_access |= NFS4_ACCESS_LOOKUP;
+	}
+	else {
+		if (mode & MAY_WRITE)
+			req_access |= NFS4_ACCESS_MODIFY | NFS4_ACCESS_EXTEND;
+		if (mode & MAY_EXEC)
+			req_access |= NFS4_ACCESS_EXECUTE;
+	}
+
+	nfs4_setup_compound(&compound, ops, NFS_SERVER(inode), "access");
+	nfs4_setup_putfh(&compound, NFS_FH(inode));
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, &fattr, NULL);
+	nfs4_setup_access(&compound, req_access, &resp_supported, &resp_access);
+	status = nfs4_call_compound(&compound, NULL, flags);
+	nfs_refresh_inode(inode, &fattr);
+
+	if (!status) {
+		if (req_access != resp_supported) {
+			printk(KERN_NOTICE "NFS: server didn't support all access bits!\n");
+			status = -ENOTSUPP;
+		}
+		else if (req_access != resp_access)
+			status = -EACCES;
+	}
+	return status;
+}
+
+/*
+ * TODO: For the time being, we don't try to get any attributes
+ * along with any of the zero-copy operations READ, READDIR,
+ * READLINK, WRITE.
+ *
+ * In the case of the first three, we want to put the GETATTR
+ * after the read-type operation -- this is because it is hard
+ * to predict the length of a GETATTR response in v4, and thus
+ * align the READ data correctly.  This means that the GETATTR
+ * may end up partially falling into the page cache, and we should
+ * shift it into the 'tail' of the xdr_buf before processing.
+ * To do this efficiently, we need to know the total length
+ * of data received, which doesn't seem to be available outside
+ * of the RPC layer.
+ *
+ * In the case of WRITE, we also want to put the GETATTR after
+ * the operation -- in this case because we want to make sure
+ * we get the post-operation mtime and size.  This means that
+ * we can't use xdr_encode_pages() as written: we need a variant
+ * of it which would leave room in the 'tail' iovec.
+ *
+ * Both of these changes to the XDR layer would in fact be quite
+ * minor, but I decided to leave them for a subsequent patch.
+ */
+static int
+nfs4_proc_readlink(struct inode *inode, struct page *page)
+{
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[2];
+
+	nfs4_setup_compound(&compound, ops, NFS_SERVER(inode), "readlink");
+	nfs4_setup_putfh(&compound, NFS_FH(inode));
+	nfs4_setup_readlink(&compound, PAGE_CACHE_SIZE, &page);
+	return nfs4_call_compound(&compound, NULL, 0);
+}
+
+static int
+nfs4_proc_read(struct inode *inode, struct rpc_cred *cred,
+	       struct nfs_fattr *fattr, int flags,
+	       unsigned int base, unsigned int count,
+	       struct page *page, int *eofp)
+{
+	u64			offset = page_offset(page) + base;
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[2];
+	u32			bytes_read;
+	int			status;
+
+	fattr->valid = 0;
+	nfs4_setup_compound(&compound, ops, NFS_SERVER(inode), "read [sync]");
+	nfs4_setup_putfh(&compound, NFS_FH(inode));
+	nfs4_setup_read(&compound, offset, count, &page, base, eofp, &bytes_read);
+	status = nfs4_call_compound(&compound, cred, 0);
+
+	if (status >= 0)
+		status = bytes_read;
+	return status;
+}
+
+static int
+nfs4_proc_write(struct inode *inode, struct rpc_cred *cred,
+		struct nfs_fattr *fattr, int flags,
+		unsigned int base, unsigned int count,
+		struct page *page, struct nfs_writeverf *verf)
+{
+	u64			offset = page_offset(page) + base;
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[2];
+	u32			bytes_written;
+	int			stable = (flags & NFS_RW_SYNC) ? NFS_FILE_SYNC : NFS_UNSTABLE;
+	int			rpcflags = (flags & NFS_RW_SWAP) ? NFS_RPC_SWAPFLAGS : 0;
+	int			status;
+
+	fattr->valid = 0;
+	nfs4_setup_compound(&compound, ops, NFS_SERVER(inode), "write [sync]");
+	nfs4_setup_putfh(&compound, NFS_FH(inode));
+	nfs4_setup_write(&compound, offset, count, stable, &page, base, &bytes_written, verf);
+	status = nfs4_call_compound(&compound, cred, rpcflags);
+
+	if (status >= 0)
+		status = bytes_written;
+	return status;
+}
+
+static int
+nfs4_proc_create(struct inode *dir, struct qstr *name, struct iattr *sattr,
+		 int flags, struct nfs_fh *fhandle, struct nfs_fattr *fattr)
+{
+	int			oflags;
+	u32			seqid;
+	nfs4_stateid		stateid;
+	int 			status;
+
+	oflags = NFS4_SHARE_ACCESS_READ | O_CREAT | (flags & O_EXCL);
+	status = do_open(dir, name, oflags, sattr, fattr, fhandle, &seqid, stateid);
+	if (!status) {
+		if (flags & O_EXCL)
+			status = do_setattr(NFS_SERVER(dir), fattr, fhandle, sattr, stateid);
+		do_close(NFS_SERVER(dir), fhandle, seqid, stateid);
+	}
+	return status;
+}
+
+static int
+nfs4_proc_remove(struct inode *dir, struct qstr *name)
+{
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[3];
+	struct nfs4_change_info	dir_cinfo;
+	struct nfs_fattr	dir_attr;
+	int			status;
+
+	dir_attr.valid = 0;
+	nfs4_setup_compound(&compound, ops, NFS_SERVER(dir), "remove");
+	nfs4_setup_putfh(&compound, NFS_FH(dir));
+	nfs4_setup_remove(&compound, name, &dir_cinfo);
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, &dir_attr, NULL);
+	status = nfs4_call_compound(&compound, NULL, 0);
+
+	if (!status) {
+		process_cinfo(&dir_cinfo, &dir_attr);
+		nfs_refresh_inode(dir, &dir_attr);
+	}
+	return status;
+}
+
+struct unlink_desc {
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[3];
+	struct nfs4_change_info	cinfo;
+	struct nfs_fattr	attrs;
+};
+
+static int
+nfs4_proc_unlink_setup(struct rpc_message *msg, struct dentry *dir, struct qstr *name)
+{
+	struct unlink_desc *	up;
+	struct nfs4_compound *	cp;
+
+	up = (struct unlink_desc *) kmalloc(sizeof(*up), GFP_KERNEL);
+	if (!up)
+		return -ENOMEM;
+	cp = &up->compound;
+
+	nfs4_setup_compound(cp, up->ops, NFS_SERVER(dir->d_inode), "unlink_setup");
+	nfs4_setup_putfh(cp, NFS_FH(dir->d_inode));
+	nfs4_setup_remove(cp, name, &up->cinfo);
+	nfs4_setup_getattr(cp, nfs4_standard_bitmap, &up->attrs, NULL);
+
+	msg->rpc_proc = NFSPROC4_COMPOUND;
+	msg->rpc_argp = cp;
+	msg->rpc_resp = cp;
+	return 0;
+}
+
+static int
+nfs4_proc_unlink_done(struct dentry *dir, struct rpc_task *task)
+{
+	struct rpc_message *msg = &task->tk_msg;
+	struct unlink_desc *up;
+
+	if (msg->rpc_argp) {
+		up = (struct unlink_desc *) msg->rpc_argp;
+		process_lease(&up->compound);
+		process_cinfo(&up->cinfo, &up->attrs);
+		nfs_refresh_inode(dir->d_inode, &up->attrs);
+		kfree(up);
+		msg->rpc_argp = NULL;
+	}
+	return 0;
+}
+
+static int
+nfs4_proc_rename(struct inode *old_dir, struct qstr *old_name,
+		 struct inode *new_dir, struct qstr *new_name)
+{
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[7];
+	struct nfs4_change_info	old_cinfo, new_cinfo;
+	struct nfs_fattr	old_dir_attr, new_dir_attr;
+	int			status;
+
+	old_dir_attr.valid = 0;
+	new_dir_attr.valid = 0;
+
+	nfs4_setup_compound(&compound, ops, NFS_SERVER(old_dir), "rename");
+	nfs4_setup_putfh(&compound, NFS_FH(old_dir));
+	nfs4_setup_savefh(&compound);
+	nfs4_setup_putfh(&compound, NFS_FH(new_dir));
+	nfs4_setup_rename(&compound, old_name, new_name, &old_cinfo, &new_cinfo);
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, &new_dir_attr, NULL);
+	nfs4_setup_restorefh(&compound);
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, &old_dir_attr, NULL);
+	status = nfs4_call_compound(&compound, NULL, 0);
+
+	if (!status) {
+		process_cinfo(&old_cinfo, &old_dir_attr);
+		process_cinfo(&new_cinfo, &new_dir_attr);
+		nfs_refresh_inode(old_dir, &old_dir_attr);
+		nfs_refresh_inode(new_dir, &new_dir_attr);
+	}
+	return status;
+}
+
+static int
+nfs4_proc_link(struct inode *inode, struct inode *dir, struct qstr *name)
+{
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[7];
+	struct nfs4_change_info	dir_cinfo;
+	struct nfs_fattr	dir_attr, fattr;
+	int			status;
+
+	dir_attr.valid = 0;
+	fattr.valid = 0;
+
+	nfs4_setup_compound(&compound, ops, NFS_SERVER(inode), "link");
+	nfs4_setup_putfh(&compound, NFS_FH(inode));
+	nfs4_setup_savefh(&compound);
+	nfs4_setup_putfh(&compound, NFS_FH(dir));
+	nfs4_setup_link(&compound, name, &dir_cinfo);
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, &dir_attr, NULL);
+	nfs4_setup_restorefh(&compound);
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, &fattr, NULL);
+	status = nfs4_call_compound(&compound, NULL, 0);
+
+	if (!status) {
+		process_cinfo(&dir_cinfo, &dir_attr);
+		nfs_refresh_inode(dir, &dir_attr);
+		nfs_refresh_inode(inode, &fattr);
+	}
+	return status;
+}
+
+static int
+nfs4_proc_symlink(struct inode *dir, struct qstr *name, struct qstr *path,
+		  struct iattr *sattr, struct nfs_fh *fhandle,
+		  struct nfs_fattr *fattr)
+{
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[7];
+	struct nfs_fattr	dir_attr;
+	struct nfs4_change_info	dir_cinfo;
+	int			status;
+
+	dir_attr.valid = 0;
+	fattr->valid = 0;
+
+	nfs4_setup_compound(&compound, ops, NFS_SERVER(dir), "symlink");
+	nfs4_setup_putfh(&compound, NFS_FH(dir));
+	nfs4_setup_savefh(&compound);
+	nfs4_setup_create_symlink(&compound, name, path, sattr, &dir_cinfo);
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, fattr, NULL);
+	nfs4_setup_getfh(&compound, fhandle);
+	nfs4_setup_restorefh(&compound);
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, &dir_attr, NULL);
+	status = nfs4_call_compound(&compound, NULL, 0);
+
+	if (!status) {
+		process_cinfo(&dir_cinfo, &dir_attr);
+		nfs_refresh_inode(dir, &dir_attr);
+	}
+	return status;
+}
+
+static int
+nfs4_proc_mkdir(struct inode *dir, struct qstr *name, struct iattr *sattr,
+		struct nfs_fh *fhandle, struct nfs_fattr *fattr)
+{
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[7];
+	struct nfs_fattr	dir_attr;
+	struct nfs4_change_info	dir_cinfo;
+	int			status;
+
+	dir_attr.valid = 0;
+	fattr->valid = 0;
+
+	nfs4_setup_compound(&compound, ops, NFS_SERVER(dir), "mkdir");
+	nfs4_setup_putfh(&compound, NFS_FH(dir));
+	nfs4_setup_savefh(&compound);
+	nfs4_setup_create_dir(&compound, name, sattr, &dir_cinfo);
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, fattr, NULL);
+	nfs4_setup_getfh(&compound, fhandle);
+	nfs4_setup_restorefh(&compound);
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, &dir_attr, NULL);
+	status = nfs4_call_compound(&compound, NULL, 0);
+
+	if (!status) {
+		process_cinfo(&dir_cinfo, &dir_attr);
+		nfs_refresh_inode(dir, &dir_attr);
+	}
+	return status;
+}
+
+static int
+nfs4_proc_readdir(struct dentry *dentry, struct rpc_cred *cred,
+                  u64 cookie, struct page *page, unsigned int count, int plus)
+{
+	struct inode		*dir = dentry->d_inode;
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[2];
+	int			status;
+
+	lock_kernel();
+
+	nfs4_setup_compound(&compound, ops, NFS_SERVER(dir), "readdir");
+	nfs4_setup_putfh(&compound, NFS_FH(dir));
+	nfs4_setup_readdir(&compound, cookie, NFS_COOKIEVERF(dir), &page, count, dentry);
+	status = nfs4_call_compound(&compound, cred, 0);
+
+	unlock_kernel();
+	return status;
+}
+
+static int
+nfs4_proc_mknod(struct inode *dir, struct qstr *name, struct iattr *sattr,
+		dev_t rdev, struct nfs_fh *fh, struct nfs_fattr *fattr)
+{
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[7];
+	struct nfs_fattr	dir_attr;
+	struct nfs4_change_info	dir_cinfo;
+	int			status;
+
+	dir_attr.valid = 0;
+	fattr->valid = 0;
+
+	nfs4_setup_compound(&compound, ops, NFS_SERVER(dir), "mknod");
+	nfs4_setup_putfh(&compound, NFS_FH(dir));
+	nfs4_setup_savefh(&compound);
+	nfs4_setup_create_special(&compound, name, rdev,sattr, &dir_cinfo);
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, fattr, NULL);
+	nfs4_setup_getfh(&compound, fh);
+	nfs4_setup_restorefh(&compound);
+	nfs4_setup_getattr(&compound, nfs4_standard_bitmap, &dir_attr, NULL);
+	status = nfs4_call_compound(&compound, NULL, 0);
+
+	if (!status) {
+		process_cinfo(&dir_cinfo, &dir_attr);
+		nfs_refresh_inode(dir, &dir_attr);
+	}
+	return status;
+}
+
+static int
+nfs4_proc_statfs(struct nfs_server *server, struct nfs_fh *fhandle,
+		 struct nfs_fsinfo *info)
+{
+	struct nfs4_compound compound;
+	struct nfs4_op ops[2];
+
+	memset(info, 0, sizeof(*info));
+	nfs4_setup_compound(&compound, ops, server, "statfs");
+	nfs4_setup_putfh(&compound, fhandle);
+	nfs4_setup_getattr(&compound, nfs4_statfs_bitmap, NULL, info);
+	return nfs4_call_compound(&compound, NULL, 0);
+}
+
+static void
+nfs4_read_done(struct rpc_task *task)
+{
+	struct nfs_read_data *data = (struct nfs_read_data *) task->tk_calldata;
+
+	process_lease(&data->u.v4.compound);
+	nfs_readpage_result(task, data->u.v4.res_count);
+}
+
+static void
+nfs4_proc_read_setup(struct nfs_read_data *data, unsigned int count)
+{
+	struct rpc_task	*task = &data->task;
+	struct nfs4_compound *cp = &data->u.v4.compound;
+	struct rpc_message msg = {
+		rpc_proc: NFSPROC4_COMPOUND,
+		rpc_argp: cp,
+		rpc_resp: cp,
+		rpc_cred: data->cred,
+	};
+	struct inode *inode = data->inode;
+	struct nfs_page *req = nfs_list_entry(data->pages.next);
+	int flags;
+
+	nfs4_setup_compound(cp, data->u.v4.ops, NFS_SERVER(inode), "read [async]");
+	nfs4_setup_putfh(cp, NFS_FH(inode));
+	nfs4_setup_read(cp, page_offset(req->wb_page) + req->wb_offset,
+			count, data->pagevec, req->wb_offset, NULL,
+			&data->u.v4.res_count);
+
+	/* N.B. Do we need to test? Never called for swapfile inode */
+	flags = RPC_TASK_ASYNC | (IS_SWAPFILE(inode)? NFS_RPC_SWAPFLAGS : 0);
+
+	/* Finalize the task. */
+	rpc_init_task(task, NFS_CLIENT(inode), nfs4_read_done, flags);
+	task->tk_calldata = data;
+	/* Release requests */
+	task->tk_release = nfs_readdata_release;
+
+	rpc_call_setup(task, &msg, 0);
+}
+
+static void
+nfs4_write_done(struct rpc_task *task)
+{
+	struct nfs_write_data *data = (struct nfs_write_data *) task->tk_calldata;
+
+	process_lease(&data->u.v4.compound);
+	nfs_writeback_done(task, data->u.v4.arg_stable,
+			   data->u.v4.arg_count, data->u.v4.res_count);
+}
+
+static void
+nfs4_proc_write_setup(struct nfs_write_data *data, unsigned int count, int how)
+{
+	struct rpc_task	*task = &data->task;
+	struct nfs4_compound *cp = &data->u.v4.compound;
+	struct rpc_message msg = {
+		rpc_proc: NFSPROC4_COMPOUND,
+		rpc_argp: cp,
+		rpc_resp: cp,
+		rpc_cred: data->cred,
+	};
+	struct inode *inode = data->inode;
+	struct nfs_page *req = nfs_list_entry(data->pages.next);
+	int stable;
+	int flags;
+
+	if (how & FLUSH_STABLE) {
+		if (!NFS_I(inode)->ncommit)
+			stable = NFS_FILE_SYNC;
+		else
+			stable = NFS_DATA_SYNC;
+	} else
+		stable = NFS_UNSTABLE;
+
+	nfs4_setup_compound(cp, data->u.v4.ops, NFS_SERVER(inode), "write [async]");
+	nfs4_setup_putfh(cp, NFS_FH(inode));
+	nfs4_setup_write(cp, page_offset(req->wb_page) + req->wb_offset,
+			 count, stable, data->pagevec, req->wb_offset,
+			 &data->u.v4.res_count, &data->verf);
+
+	/* Set the initial flags for the task.  */
+	flags = (how & FLUSH_SYNC) ? 0 : RPC_TASK_ASYNC;
+
+	/* Finalize the task. */
+	rpc_init_task(task, NFS_CLIENT(inode), nfs4_write_done, flags);
+	task->tk_calldata = data;
+	/* Release requests */
+	task->tk_release = nfs_writedata_release;
+
+	rpc_call_setup(task, &msg, 0);
+}
+
+static void
+nfs4_commit_done(struct rpc_task *task)
+{
+	struct nfs_write_data *data = (struct nfs_write_data *) task->tk_calldata;
+
+	process_lease(&data->u.v4.compound);
+	nfs_commit_done(task);
+}
+
+static void
+nfs4_proc_commit_setup(struct nfs_write_data *data, u64 start, u32 len, int how)
+{
+	struct rpc_task	*task = &data->task;
+	struct nfs4_compound *cp = &data->u.v4.compound;
+	struct rpc_message msg = {
+		rpc_proc: NFSPROC4_COMPOUND,
+		rpc_argp: cp,
+		rpc_resp: cp,
+		rpc_cred: data->cred,
+	};
+	struct inode *inode = data->inode;
+	int flags;
+
+	nfs4_setup_compound(cp, data->u.v4.ops, NFS_SERVER(inode), "commit [async]");
+	nfs4_setup_putfh(cp, NFS_FH(inode));
+	nfs4_setup_commit(cp, start, len, &data->verf);
+
+	/* Set the initial flags for the task.  */
+	flags = (how & FLUSH_SYNC) ? 0 : RPC_TASK_ASYNC;
+
+	/* Finalize the task. */
+	rpc_init_task(task, NFS_CLIENT(inode), nfs4_commit_done, flags);
+	task->tk_calldata = data;
+	/* Release requests */
+	task->tk_release = nfs_writedata_release;
+
+	rpc_call_setup(task, &msg, 0);
+}
+
+/*
+ * nfs4_proc_renew(): This is not one of the nfs_rpc_ops; it is a special
+ * standalone procedure for queueing an asynchronous RENEW.
+ */
+struct renew_desc {
+	struct rpc_task		task;
+	struct nfs4_compound	compound;
+	struct nfs4_op		ops[1];
+};
+
+static void
+renew_done(struct rpc_task *task)
+{
+	struct nfs4_compound *cp = (struct nfs4_compound *) task->tk_msg.rpc_argp;
+	process_lease(cp);
+}
+
+static void
+renew_release(struct rpc_task *task)
+{
+	kfree(task->tk_calldata);
+	task->tk_calldata = NULL;
+}
+
+int
+nfs4_proc_renew(struct nfs_server *server)
+{
+	struct renew_desc *rp;
+	struct rpc_task *task;
+	struct nfs4_compound *cp;
+	struct rpc_message msg;
+
+	rp = (struct renew_desc *) kmalloc(sizeof(*rp), GFP_KERNEL);
+	if (!rp)
+		return -ENOMEM;
+	cp = &rp->compound;
+	task = &rp->task;
+
+	nfs4_setup_compound(cp, rp->ops, server, "renew");
+	nfs4_setup_renew(cp);
+
+	msg.rpc_proc = NFSPROC4_COMPOUND;
+	msg.rpc_argp = cp;
+	msg.rpc_resp = cp;
+	msg.rpc_cred = NULL;
+	rpc_init_task(task, server->client, renew_done, RPC_TASK_ASYNC);
+	rpc_call_setup(task, &msg, 0);
+	task->tk_calldata = rp;
+	task->tk_release = renew_release;
+
+	return rpc_execute(task);
+}
+
+struct nfs_rpc_ops	nfs_v4_clientops = {
+	version:	4,			/* protocol version */
+	getroot:	nfs4_proc_get_root,
+	getattr:	nfs4_proc_getattr,
+	setattr:	nfs4_proc_setattr,
+	lookup:		nfs4_proc_lookup,
+	access:		nfs4_proc_access,
+	readlink:	nfs4_proc_readlink,
+	read:		nfs4_proc_read,
+	write:		nfs4_proc_write,
+	commit:		NULL,
+	create:		nfs4_proc_create,
+	remove:		nfs4_proc_remove,
+	unlink_setup:	nfs4_proc_unlink_setup,
+	unlink_done:	nfs4_proc_unlink_done,
+	rename:		nfs4_proc_rename,
+	link:		nfs4_proc_link,
+	symlink:	nfs4_proc_symlink,
+	mkdir:		nfs4_proc_mkdir,
+	rmdir:		nfs4_proc_remove,
+	readdir:	nfs4_proc_readdir,
+	mknod:		nfs4_proc_mknod,
+	statfs:		nfs4_proc_statfs,
+	decode_dirent:	nfs4_decode_dirent,
+	read_setup:	nfs4_proc_read_setup,
+	write_setup:	nfs4_proc_write_setup,
+	commit_setup:	nfs4_proc_commit_setup,
+};
+
+/*
+ * Local variables:
+ *  c-basic-offset: 8
+ * End:
+ */
--- old/fs/nfs/nfs4renewd.c	Wed Dec 31 18:00:00 1969
+++ new/fs/nfs/nfs4renewd.c	Tue Aug  6 07:19:28 2002
@@ -0,0 +1,88 @@
+/*
+ *  fs/nfs/nfs4renewd.c
+ *
+ *  Copyright (c) 2002 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Kendrick Smith <kmsmith@umich.edu>
+ *
+ * Implementation of the NFSv4 "renew daemon", which wakes up periodically to
+ * send a RENEW, to keep state alive on the server.  The daemon is implemented
+ * as an rpc_task, not a real kernel thread, so it always runs in rpciod's
+ * context.  There is one renewd per nfs_server.
+ *
+ * TODO: If the send queue gets backlogged (e.g., if the server goes down),
+ * we will keep filling the queue with periodic RENEW requests.  We need a
+ * mechanism for ensuring that if renewd successfully sends off a request,
+ * then it only wakes up when the request is finished.  Maybe use the
+ * child task framework of the RPC layer?
+ */
+
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/sunrpc/sched.h>
+#include <linux/sunrpc/clnt.h>
+
+#include <linux/nfs.h>
+#include <linux/nfs4.h>
+#include <linux/nfs_fs.h>
+
+static RPC_WAITQ(nfs4_renewd_queue, "nfs4_renewd_queue");
+
+static void
+renewd(struct rpc_task *task)
+{
+	struct nfs_server *server = (struct nfs_server *)task->tk_calldata;
+	unsigned long lease = server->lease_time;
+	unsigned long last = server->last_renewal;
+	unsigned long timeout;
+
+	printk("AAA renewd start lease=%ld last=%ld jiffies=%ld\n", lease, last, jiffies);
+	if (!server->nfs4_state)
+		timeout = (2 * lease) / 3;
+	else if (jiffies < last + lease/3)
+		timeout = (2 * lease) / 3 + last - jiffies;
+	else {
+		/* Queue an asynchronous RENEW. */
+		printk("AAA renewd queueing RENEW\n");
+		nfs4_proc_renew(server);
+		timeout = (2 * lease) / 3;
+	}
+
+	if (timeout < 5 * HZ)    /* safeguard */
+		timeout = 5 * HZ;
+	printk("AAA renewd set timeout=%ld\n", timeout);
+	task->tk_timeout = timeout;
+	task->tk_action = renewd;
+	task->tk_exit = NULL;
+	rpc_sleep_on(&nfs4_renewd_queue, task, NULL, NULL);
+	return;
+}
+
+int
+nfs4_init_renewd(struct nfs_server *server)
+{
+	struct rpc_task *task;
+	int status;
+
+	lock_kernel();
+	status = -ENOMEM;
+	task = rpc_new_task(server->client, NULL, RPC_TASK_ASYNC);
+	if (!task)
+		goto out;
+	task->tk_calldata = server;
+	task->tk_action = renewd;
+	status = rpc_execute(task);
+
+out:
+	unlock_kernel();
+	return status;
+}
+
+/*
+ * Local variables:
+ *   c-basic-offset: 8
+ * End:
+ */
--- old/fs/nfs/nfs4state.c	Wed Dec 31 18:00:00 1969
+++ new/fs/nfs/nfs4state.c	Mon Jul 29 14:52:02 2002
@@ -0,0 +1,56 @@
+/*
+ *  fs/nfs/nfs4state.c
+ *
+ *  Client-side XDR for NFSv4.
+ *
+ *  Copyright (c) 2002 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Kendrick Smith <kmsmith@umich.edu>
+ *
+ * Implementation of the NFSv4 state model.  For the time being,
+ * this is minimal, but will be made much more complex in a
+ * subsequent patch.
+ */
+
+#include <linux/config.h>
+#include <linux/slab.h>
+#include <linux/nfs_fs.h>
+
+/*
+ * nfs4_get_client(): returns an empty client structure
+ * nfs4_put_client(): drops reference to client structure
+ *
+ * Since these are allocated/deallocated very rarely, we don't
+ * bother putting them in a slab cache...
+ */
+struct nfs4_client *
+nfs4_get_client(void)
+{
+        struct nfs4_client *clp;
+
+        if ((clp = kmalloc(sizeof(*clp), GFP_KERNEL))) {
+                atomic_set(&clp->cl_count, 1);
+                clp->cl_clientid = 0;
+                INIT_LIST_HEAD(&clp->cl_lockowners);
+        }
+        return clp;
+}
+
+void
+nfs4_put_client(struct nfs4_client *clp)
+{
+        BUG_ON(!clp);
+        BUG_ON(!atomic_read(&clp->cl_count));
+
+        if (atomic_dec_and_test(&clp->cl_count)) {
+                BUG_ON(!list_empty(&clp->cl_lockowners));
+                kfree(clp);
+        }
+}
+
+/*
+ * Local variables:
+ *  c-basic-offset: 8
+ * End:
+ */
--- old/fs/nfs/nfs4xdr.c	Wed Dec 31 18:00:00 1969
+++ new/fs/nfs/nfs4xdr.c	Wed Aug  7 10:24:05 2002
@@ -0,0 +1,1682 @@
+/*
+ *  fs/nfs/nfs4xdr.c
+ *
+ *  Client-side XDR for NFSv4.
+ *
+ *  Copyright (c) 2002 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Kendrick Smith <kmsmith@umich.edu>
+ *  Andy Adamson   <andros@umich.edu>
+ */
+
+#include <linux/param.h>
+#include <linux/time.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/utsname.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/in.h>
+#include <linux/pagemap.h>
+#include <linux/proc_fs.h>
+#include <linux/kdev_t.h>
+#include <linux/sunrpc/clnt.h>
+#include <linux/nfs.h>
+#include <linux/nfs4.h>
+#include <linux/nfs_fs.h>
+
+/* Emperically, it seems that the NFS client gets confused if
+ * cookies larger than this are returned -- presumably a
+ * signedness issue?
+ */
+#define COOKIE_MAX		0x7fffffff
+
+#define NFS4_CLIENTID(server)	((server)->nfs4_state->cl_clientid)
+
+#define NFSDBG_FACILITY		NFSDBG_XDR
+
+/* Mapping from NFS error code to "errno" error code. */
+#define errno_NFSERR_IO		EIO
+
+extern int			nfs_stat_to_errno(int);
+
+#define NFS4_enc_void_sz	0
+#define NFS4_dec_void_sz	0
+#define NFS4_enc_compound_sz	1024  /* XXX: large enough? */
+#define NFS4_dec_compound_sz	1024  /* XXX: large enough? */
+
+static struct {
+	unsigned int	mode;
+	unsigned int	nfs2type;
+} nfs_type2fmt[] = {
+	{ 0,		NFNON	     },
+	{ S_IFREG,	NFREG	     },
+	{ S_IFDIR,	NFDIR	     },
+	{ S_IFBLK,	NFBLK	     },
+	{ S_IFCHR,	NFCHR	     },
+	{ S_IFLNK,	NFLNK	     },
+	{ S_IFSOCK,	NFSOCK	     },
+	{ S_IFIFO,	NFFIFO	     },
+	{ 0,		NFNON	     },
+	{ 0,		NFNON	     },
+};
+
+/*
+ * START OF "GENERIC" ENCODE ROUTINES.
+ *   These may look a little ugly since they are imported from a "generic"
+ * set of XDR encode/decode routines which are intended to be shared by
+ * all of our NFSv4 implementations (OpenBSD, MacOS X...).
+ *
+ * If the pain of reading these is too great, it should be a straightforward
+ * task to translate them into Linux-specific versions which are more
+ * consistent with the style used in NFSv2/v3...
+ */
+#define ENCODE_HEAD						\
+	u32 *p;
+#define ENCODE_TAIL						\
+	return 0
+
+#define WRITE32(n)               *p++ = htonl(n)
+#define WRITE64(n)               do {				\
+	*p++ = htonl((u32)((n) >> 32));				\
+	*p++ = htonl((u32)(n));					\
+} while (0)
+#define WRITEMEM(ptr,nbytes)     do {				\
+	memcpy(p, ptr, nbytes);					\
+	p += XDR_QUADLEN(nbytes);				\
+} while (0)
+
+#define RESERVE_SPACE(nbytes)	do { BUG_ON(cp->p + XDR_QUADLEN(nbytes) > cp->end); p = cp->p; } while (0)
+#define ADJUST_ARGS()           cp->p = p
+
+static int
+encode_attrs(struct nfs4_compound *cp, struct iattr *iap)
+{
+	u32 *q;
+	int len;
+	u32 bmval0 = 0;
+	u32 bmval1 = 0;
+	struct gss_cacheent *owner = NULL;
+	struct gss_cacheent *group = NULL;
+	int status;
+	ENCODE_HEAD;
+
+	/*
+	 * We reserve enough space to write the entire attribute buffer at once.
+	 * In the worst-case, this would be
+	 *   12(bitmap) + 4(attrlen) + 8(size) + 4(mode) + 4(atime) + 4(mtime)
+	 *          = 36 bytes, plus any contribution from variable-length fields
+	 *            such as owner/group/acl's.
+	 */
+	len = 36;
+	if (iap->ia_valid & ATTR_UID) {
+		if ((status = gss_get_name(GSS_OWNER, iap->ia_uid, &owner))) {
+			printk(KERN_WARNING "nfs: couldn't resolve uid %d to string\n",
+			       iap->ia_uid);
+			goto out;
+		}
+		len += (XDR_QUADLEN(owner->name.len) << 2) + 4;
+	}
+	if (iap->ia_valid & ATTR_GID) {
+		if ((status = gss_get_name(GSS_GROUP, iap->ia_gid, &group))) {
+			printk(KERN_WARNING "nfs4: couldn't resolve uid %d to string\n",
+			       iap->ia_gid);
+			goto out;
+		}
+		len += (XDR_QUADLEN(group->name.len) << 2) + 4;
+	}
+	RESERVE_SPACE(len);
+
+	/*
+	 * We write the bitmap length now, but leave the bitmap and the attribute
+	 * buffer length to be backfilled at the end of this routine.
+	 */
+	WRITE32(2);
+	q = p;
+	p += 3;
+
+	if (iap->ia_valid & ATTR_SIZE) {
+		bmval0 |= FATTR4_WORD0_SIZE;
+		WRITE64(iap->ia_size);
+	}
+	if (iap->ia_valid & ATTR_MODE) {
+		bmval1 |= FATTR4_WORD1_MODE;
+		WRITE32(iap->ia_mode);
+	}
+	if (iap->ia_valid & ATTR_UID) {
+		bmval1 |= FATTR4_WORD1_OWNER;
+		WRITE32(owner->name.len);
+		WRITEMEM(owner->name.name, owner->name.len);
+	}
+	if (iap->ia_valid & ATTR_GID) {
+		bmval1 |= FATTR4_WORD1_OWNER_GROUP;
+		WRITE32(group->name.len);
+		WRITEMEM(group->name.name, group->name.len);
+	}
+	if (iap->ia_valid & ATTR_ATIME_SET) {
+		bmval1 |= FATTR4_WORD1_TIME_ACCESS_SET;
+		WRITE32(NFS4_SET_TO_CLIENT_TIME);
+		WRITE32(0);
+		WRITE32(iap->ia_mtime);
+		WRITE32(0);
+	}
+	else if (iap->ia_valid & ATTR_ATIME) {
+		bmval1 |= FATTR4_WORD1_TIME_ACCESS_SET;
+		WRITE32(NFS4_SET_TO_SERVER_TIME);
+	}
+	if (iap->ia_valid & ATTR_MTIME_SET) {
+		bmval1 |= FATTR4_WORD1_TIME_MODIFY_SET;
+		WRITE32(NFS4_SET_TO_CLIENT_TIME);
+		WRITE32(0);
+		WRITE32(iap->ia_mtime);
+		WRITE32(0);
+	}
+	else if (iap->ia_valid & ATTR_MTIME) {
+		bmval1 |= FATTR4_WORD1_TIME_MODIFY_SET;
+		WRITE32(NFS4_SET_TO_SERVER_TIME);
+	}
+
+	ADJUST_ARGS();
+
+	/*
+	 * Now we backfill the bitmap and the attribute buffer length.
+	 */
+	len = (char *)p - (char *)q - 12;
+	*q++ = htonl(bmval0);
+	*q++ = htonl(bmval1);
+	*q++ = htonl(len);
+
+	status = 0;
+out:
+	if (owner)
+		gss_put(owner);
+	if (group)
+		gss_put(group);
+	return status;
+}
+
+static int
+encode_access(struct nfs4_compound *cp, struct nfs4_access *access)
+{
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(8);
+	WRITE32(OP_ACCESS);
+	WRITE32(access->ac_req_access);
+	ADJUST_ARGS();
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_close(struct nfs4_compound *cp, struct nfs4_close *close)
+{
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(20);
+	WRITE32(OP_CLOSE);
+	WRITE32(close->cl_seqid);
+	WRITEMEM(close->cl_stateid, sizeof(nfs4_stateid));
+	ADJUST_ARGS();
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_commit(struct nfs4_compound *cp, struct nfs4_commit *commit)
+{
+        ENCODE_HEAD;
+
+        RESERVE_SPACE(16);
+        WRITE32(OP_COMMIT);
+        WRITE64(commit->co_start);
+        WRITE32(commit->co_len);
+        ADJUST_ARGS();
+
+        ENCODE_TAIL;
+}
+
+static int
+encode_create(struct nfs4_compound *cp, struct nfs4_create *create)
+{
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(8);
+	WRITE32(OP_CREATE);
+	WRITE32(create->cr_ftype);
+	ADJUST_ARGS();
+
+	switch (create->cr_ftype) {
+	case NF4LNK:
+		RESERVE_SPACE(4 + create->cr_textlen);
+		WRITE32(create->cr_textlen);
+		WRITEMEM(create->cr_text, create->cr_textlen);
+		ADJUST_ARGS();
+		break;
+
+	case NF4BLK: case NF4CHR:
+		RESERVE_SPACE(8);
+		WRITE32(create->cr_specdata1);
+		WRITE32(create->cr_specdata2);
+		ADJUST_ARGS();
+		break;
+
+	default:
+		break;
+	}
+
+	RESERVE_SPACE(4 + create->cr_namelen);
+	WRITE32(create->cr_namelen);
+	WRITEMEM(create->cr_name, create->cr_namelen);
+	ADJUST_ARGS();
+
+	return encode_attrs(cp, create->cr_attrs);
+}
+
+static int
+encode_getattr(struct nfs4_compound *cp, struct nfs4_getattr *getattr)
+{
+        ENCODE_HEAD;
+
+        RESERVE_SPACE(16);
+        WRITE32(OP_GETATTR);
+        WRITE32(2);
+        WRITE32(getattr->gt_bmval[0]);
+        WRITE32(getattr->gt_bmval[1]);
+        ADJUST_ARGS();
+
+        ENCODE_TAIL;
+}
+
+static int
+encode_getfh(struct nfs4_compound *cp)
+{
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(4);
+	WRITE32(OP_GETFH);
+	ADJUST_ARGS();
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_link(struct nfs4_compound *cp, struct nfs4_link *link)
+{
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(8 + link->ln_namelen);
+	WRITE32(OP_LINK);
+	WRITE32(link->ln_namelen);
+	WRITEMEM(link->ln_name, link->ln_namelen);
+	ADJUST_ARGS();
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_lookup(struct nfs4_compound *cp, struct nfs4_lookup *lookup)
+{
+	int len = lookup->lo_name->len;
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(8 + len);
+	WRITE32(OP_LOOKUP);
+	WRITE32(len);
+	WRITEMEM(lookup->lo_name->name, len);
+	ADJUST_ARGS();
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_open(struct nfs4_compound *cp, struct nfs4_open *open)
+{
+	static int global_id = 0;
+	int id = global_id++;
+	int status;
+	ENCODE_HEAD;
+
+	/* seqid, share_access, share_deny, clientid, ownerlen, owner, opentype */
+	RESERVE_SPACE(52);
+	WRITE32(OP_OPEN);
+	WRITE32(0);                       /* seqid */
+	WRITE32(open->op_share_access);
+	WRITE32(0);                       /* for us, share_deny== 0 always */
+	WRITE64(NFS4_CLIENTID(cp->server));
+	WRITE32(4);
+	WRITE32(id);
+	WRITE32(open->op_opentype);
+	ADJUST_ARGS();
+
+	if (open->op_opentype == NFS4_OPEN_CREATE) {
+		if (open->op_createmode == NFS4_CREATE_EXCLUSIVE) {
+			RESERVE_SPACE(12);
+			WRITE32(open->op_createmode);
+			WRITEMEM(open->op_verifier, sizeof(nfs4_verifier));
+			ADJUST_ARGS();
+		}
+		else if (open->op_attrs) {
+			RESERVE_SPACE(4);
+			WRITE32(open->op_createmode);
+			ADJUST_ARGS();
+			if ((status = encode_attrs(cp, open->op_attrs)))
+				return status;
+		}
+		else {
+			RESERVE_SPACE(12);
+			WRITE32(open->op_createmode);
+			WRITE32(0);
+			WRITE32(0);
+			ADJUST_ARGS();
+		}
+	}
+
+	RESERVE_SPACE(8 + open->op_name->len);
+	WRITE32(NFS4_OPEN_CLAIM_NULL);
+	WRITE32(open->op_name->len);
+	WRITEMEM(open->op_name->name, open->op_name->len);
+	ADJUST_ARGS();
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_open_confirm(struct nfs4_compound *cp, struct nfs4_open_confirm *open_confirm)
+{
+	ENCODE_HEAD;
+
+	/*
+	 * Note: In this "stateless" implementation, the OPEN_CONFIRM
+	 * seqid is always equal to 1.
+	 */
+	RESERVE_SPACE(24);
+	WRITE32(OP_OPEN_CONFIRM);
+	WRITEMEM(open_confirm->oc_stateid, sizeof(nfs4_stateid));
+	WRITE32(1);
+	ADJUST_ARGS();
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_putfh(struct nfs4_compound *cp, struct nfs4_putfh *putfh)
+{
+	int len = putfh->pf_fhandle->size;
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(8 + len);
+	WRITE32(OP_PUTFH);
+	WRITE32(len);
+	WRITEMEM(putfh->pf_fhandle->data, len);
+	ADJUST_ARGS();
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_putrootfh(struct nfs4_compound *cp)
+{
+        ENCODE_HEAD;
+
+        RESERVE_SPACE(4);
+        WRITE32(OP_PUTROOTFH);
+        ADJUST_ARGS();
+
+        ENCODE_TAIL;
+}
+
+static int
+encode_read(struct nfs4_compound *cp, struct nfs4_read *read, struct rpc_rqst *req)
+{
+	struct rpc_auth	*auth = req->rq_task->tk_auth;
+	int		replen;
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(32);
+	WRITE32(OP_READ);
+	WRITE32(0);   /* all-zero stateid! */
+	WRITE32(0);
+	WRITE32(0);
+	WRITE32(0);
+	WRITE64(read->rd_offset);
+	WRITE32(read->rd_length);
+	ADJUST_ARGS();
+
+	/* set up reply iovec
+	 *    toplevel status + taglen + rescount + OP_PUTFH + status
+	 *       + OP_READ + status + eof + datalen = 9
+	 */
+	replen = (RPC_REPHDRSIZE + auth->au_rslack + 9 + XDR_QUADLEN(cp->taglen)) << 2;
+	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
+	xdr_inline_pages(&req->rq_rcv_buf, replen,
+			 read->rd_pages, read->rd_pgbase, read->rd_length);
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_readdir(struct nfs4_compound *cp, struct nfs4_readdir *readdir, struct rpc_rqst *req)
+{
+	struct rpc_auth *auth = req->rq_task->tk_auth;
+	int replen;
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(40);
+	WRITE32(OP_READDIR);
+	WRITE64(readdir->rd_cookie);
+	WRITEMEM(readdir->rd_req_verifier, sizeof(nfs4_verifier));
+	WRITE32(readdir->rd_count >> 5);  /* meaningless "dircount" field */
+	WRITE32(readdir->rd_count);
+	WRITE32(2);
+	WRITE32(readdir->rd_bmval[0]);
+	WRITE32(readdir->rd_bmval[1]);
+	ADJUST_ARGS();
+
+	/* set up reply iovec
+	 *    toplevel_status + taglen + rescount + OP_PUTFH + status
+	 *      + OP_READDIR + status + verifer(2)  = 9
+	 */
+	replen = (RPC_REPHDRSIZE + auth->au_rslack + 9 + XDR_QUADLEN(cp->taglen)) << 2;
+	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
+	xdr_inline_pages(&req->rq_rcv_buf, replen, readdir->rd_pages,
+			 readdir->rd_pgbase, readdir->rd_count);
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_readlink(struct nfs4_compound *cp, struct nfs4_readlink *readlink, struct rpc_rqst *req)
+{
+	struct rpc_auth *auth = req->rq_task->tk_auth;
+	int replen;
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(4);
+	WRITE32(OP_READLINK);
+	ADJUST_ARGS();
+
+	/* set up reply iovec
+	 *    toplevel_status + taglen + rescount + OP_PUTFH + status
+	 *      + OP_READLINK + status  = 7
+	 */
+	replen = (RPC_REPHDRSIZE + auth->au_rslack + 7 + XDR_QUADLEN(cp->taglen)) << 2;
+	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
+	xdr_inline_pages(&req->rq_rcv_buf, replen, readlink->rl_pages, 0, readlink->rl_count);
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_remove(struct nfs4_compound *cp, struct nfs4_remove *remove)
+{
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(8 + remove->rm_namelen);
+	WRITE32(OP_REMOVE);
+	WRITE32(remove->rm_namelen);
+	WRITEMEM(remove->rm_name, remove->rm_namelen);
+	ADJUST_ARGS();
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_rename(struct nfs4_compound *cp, struct nfs4_rename *rename)
+{
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(8 + rename->rn_oldnamelen);
+	WRITE32(OP_RENAME);
+	WRITE32(rename->rn_oldnamelen);
+	WRITEMEM(rename->rn_oldname, rename->rn_oldnamelen);
+	ADJUST_ARGS();
+
+	RESERVE_SPACE(8 + rename->rn_newnamelen);
+	WRITE32(rename->rn_newnamelen);
+	WRITEMEM(rename->rn_newname, rename->rn_newnamelen);
+	ADJUST_ARGS();
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_renew(struct nfs4_compound *cp)
+{
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(12);
+	WRITE32(OP_RENEW);
+	WRITE64(NFS4_CLIENTID(cp->server));
+	ADJUST_ARGS();
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_restorefh(struct nfs4_compound *cp)
+{
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(4);
+	WRITE32(OP_RESTOREFH);
+	ADJUST_ARGS();
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_savefh(struct nfs4_compound *cp)
+{
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(4);
+	WRITE32(OP_SAVEFH);
+	ADJUST_ARGS();
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_setattr(struct nfs4_compound *cp, struct nfs4_setattr *setattr)
+{
+	int status;
+	ENCODE_HEAD;
+
+        RESERVE_SPACE(20);
+        WRITE32(OP_SETATTR);
+	WRITEMEM(setattr->st_stateid, sizeof(nfs4_stateid));
+        ADJUST_ARGS();
+
+        if ((status = encode_attrs(cp, setattr->st_iap)))
+		return status;
+
+        ENCODE_TAIL;
+}
+
+static int
+encode_setclientid(struct nfs4_compound *cp, struct nfs4_setclientid *setclientid)
+{
+	u32 total_len;
+	u32 len1, len2, len3;
+	ENCODE_HEAD;
+
+	len1 = strlen(setclientid->sc_name);
+	len2 = strlen(setclientid->sc_netid);
+	len3 = strlen(setclientid->sc_uaddr);
+	total_len = XDR_QUADLEN(len1) + XDR_QUADLEN(len2) + XDR_QUADLEN(len3);
+	total_len = (total_len << 2) + 32;
+
+	RESERVE_SPACE(total_len);
+	WRITE32(OP_SETCLIENTID);
+	WRITEMEM(setclientid->sc_verifier, sizeof(nfs4_verifier));
+	WRITE32(len1);
+	WRITEMEM(setclientid->sc_name, len1);
+	WRITE32(setclientid->sc_prog);
+	WRITE32(len2);
+	WRITEMEM(setclientid->sc_netid, len2);
+	WRITE32(len3);
+	WRITEMEM(setclientid->sc_uaddr, len3);
+	WRITE32(setclientid->sc_cb_ident);
+	ADJUST_ARGS();
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_setclientid_confirm(struct nfs4_compound *cp)
+{
+        ENCODE_HEAD;
+
+        RESERVE_SPACE(12);
+        WRITE32(OP_SETCLIENTID_CONFIRM);
+        WRITE64(cp->server->nfs4_state->cl_clientid);
+        ADJUST_ARGS();
+
+        ENCODE_TAIL;
+}
+
+static int
+encode_write(struct nfs4_compound *cp, struct nfs4_write *write, struct rpc_rqst *req)
+{
+	struct xdr_buf *sndbuf = &req->rq_snd_buf;
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(36);
+	WRITE32(OP_WRITE);
+	WRITE32(0xffffffff);     /* magic stateid -1 */
+	WRITE32(0xffffffff);
+	WRITE32(0xffffffff);
+	WRITE32(0xffffffff);
+	WRITE64(write->wr_offset);
+	WRITE32(write->wr_stable_how);
+	WRITE32(write->wr_len);
+	ADJUST_ARGS();
+
+	sndbuf->len = xdr_adjust_iovec(sndbuf->head, p);
+	xdr_encode_pages(sndbuf, write->wr_pages, write->wr_pgbase, write->wr_len);
+
+	ENCODE_TAIL;
+}
+
+static int
+encode_compound(struct nfs4_compound *cp, struct rpc_rqst *req)
+{
+	int i, status = 0;
+	ENCODE_HEAD;
+
+	dprintk("encode_compound: tag=%.*s\n", (int)cp->taglen, cp->tag);
+
+	RESERVE_SPACE(12 + cp->taglen);
+	WRITE32(cp->taglen);
+	WRITEMEM(cp->tag, cp->taglen);
+	WRITE32(NFS4_MINOR_VERSION);
+	WRITE32(cp->req_nops);
+	ADJUST_ARGS();
+
+	for (i = 0; i < cp->req_nops; i++) {
+		switch (cp->ops[i].opnum) {
+		case OP_ACCESS:
+			status = encode_access(cp, &cp->ops[i].u.access);
+			break;
+		case OP_CLOSE:
+			status = encode_close(cp, &cp->ops[i].u.close);
+			break;
+		case OP_COMMIT:
+			status = encode_commit(cp, &cp->ops[i].u.commit);
+			break;
+		case OP_CREATE:
+			status = encode_create(cp, &cp->ops[i].u.create);
+			break;
+		case OP_GETATTR:
+			status = encode_getattr(cp, &cp->ops[i].u.getattr);
+			break;
+		case OP_GETFH:
+			status = encode_getfh(cp);
+			break;
+		case OP_LINK:
+			status = encode_link(cp, &cp->ops[i].u.link);
+			break;
+		case OP_LOOKUP:
+			status = encode_lookup(cp, &cp->ops[i].u.lookup);
+			break;
+		case OP_OPEN:
+			status = encode_open(cp, &cp->ops[i].u.open);
+			break;
+		case OP_OPEN_CONFIRM:
+			status = encode_open_confirm(cp, &cp->ops[i].u.open_confirm);
+			break;
+		case OP_PUTFH:
+			status = encode_putfh(cp, &cp->ops[i].u.putfh);
+			break;
+		case OP_PUTROOTFH:
+			status = encode_putrootfh(cp);
+			break;
+		case OP_READ:
+			status = encode_read(cp, &cp->ops[i].u.read, req);
+			break;
+		case OP_READDIR:
+			status = encode_readdir(cp, &cp->ops[i].u.readdir, req);
+			break;
+		case OP_READLINK:
+			status = encode_readlink(cp, &cp->ops[i].u.readlink, req);
+			break;
+		case OP_REMOVE:
+			status = encode_remove(cp, &cp->ops[i].u.remove);
+			break;
+		case OP_RENAME:
+			status = encode_rename(cp, &cp->ops[i].u.rename);
+			break;
+		case OP_RENEW:
+			status = encode_renew(cp);
+			break;
+		case OP_RESTOREFH:
+			status = encode_restorefh(cp);
+			break;
+		case OP_SAVEFH:
+			status = encode_savefh(cp);
+			break;
+		case OP_SETATTR:
+			status = encode_setattr(cp, &cp->ops[i].u.setattr);
+			break;
+		case OP_SETCLIENTID:
+			status = encode_setclientid(cp, &cp->ops[i].u.setclientid);
+			break;
+		case OP_SETCLIENTID_CONFIRM:
+			status = encode_setclientid_confirm(cp);
+			break;
+		case OP_WRITE:
+			status = encode_write(cp, &cp->ops[i].u.write, req);
+			break;
+		default:
+			BUG();
+		}
+		if (status)
+			return status;
+	}
+
+	ENCODE_TAIL;
+}
+/*
+ * END OF "GENERIC" ENCODE ROUTINES.
+ */
+
+
+/*
+ * Encode void argument
+ */
+static int
+nfs4_xdr_enc_void(struct rpc_rqst *req, u32 *p, void *dummy)
+{
+	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
+	return 0;
+}
+
+/*
+ * Encode COMPOUND argument
+ */
+static int
+nfs4_xdr_enc_compound(struct rpc_rqst *req, u32 *p, struct nfs4_compound *cp)
+{
+	int status;
+	struct xdr_buf *sndbuf = &req->rq_snd_buf;
+
+	cp->p = p;
+	cp->end = (u32 *) ((char *)req->rq_svec[0].iov_base + req->rq_svec[0].iov_len);
+	status = encode_compound(cp, req);
+	cp->timestamp = jiffies;
+
+	if (!status && !sndbuf->page_len)
+		req->rq_slen = xdr_adjust_iovec(sndbuf->head, cp->p);
+	return status;
+}
+
+
+/*
+ * START OF "GENERIC" DECODE ROUTINES.
+ *   These may look a little ugly since they are imported from a "generic"
+ * set of XDR encode/decode routines which are intended to be shared by
+ * all of our NFSv4 implementations (OpenBSD, MacOS X...).
+ *
+ * If the pain of reading these is too great, it should be a straightforward
+ * task to translate them into Linux-specific versions which are more
+ * consistent with the style used in NFSv2/v3...
+ */
+#define DECODE_HEAD				\
+	u32 *p;					\
+	int status
+#define DECODE_TAIL				\
+	status = 0;				\
+out:						\
+	return status;				\
+xdr_error:					\
+	printk(KERN_NOTICE "xdr error! (%s:%d)\n", __FILE__, __LINE__); \
+	status = -EIO;				\
+	goto out
+
+#define READ32(x)         (x) = ntohl(*p++)
+#define READ64(x)         do {			\
+	(x) = (u64)ntohl(*p++) << 32;		\
+	(x) |= ntohl(*p++);			\
+} while (0)
+#define READTIME(x)       do {			\
+	p++;					\
+	(x) = (u64)ntohl(*p++) << 32;		\
+	(x) |= ntohl(*p++);			\
+} while (0)
+#define COPYMEM(x,nbytes) do {			\
+	memcpy((x), p, nbytes);			\
+	p += XDR_QUADLEN(nbytes);		\
+} while (0)
+
+#define READ_BUF(nbytes)  do {			\
+	if (nbytes > (u32)((char *)cp->end - (char *)cp->p))  \
+		goto xdr_error;			\
+	p = cp->p;				\
+	cp->p += XDR_QUADLEN(nbytes);		\
+} while (0)
+
+static int
+decode_change_info(struct nfs4_compound *cp, struct nfs4_change_info *cinfo)
+{
+	DECODE_HEAD;
+
+	READ_BUF(20);
+	READ32(cinfo->atomic);
+	READ64(cinfo->before);
+	READ64(cinfo->after);
+
+	DECODE_TAIL;
+}
+
+static int
+decode_access(struct nfs4_compound *cp, int nfserr, struct nfs4_access *access)
+{
+	u32 supp, acc;
+	DECODE_HEAD;
+
+	if (!nfserr) {
+		READ_BUF(8);
+		READ32(supp);
+		READ32(acc);
+
+		status = -EIO;
+		if ((supp & ~access->ac_req_access) || (acc & ~supp)) {
+			printk(KERN_NOTICE "NFS: server returned bad bits in access call!\n");
+			goto out;
+		}
+		*access->ac_resp_supported = supp;
+		*access->ac_resp_access = acc;
+	}
+
+	DECODE_TAIL;
+}
+
+static int
+decode_close(struct nfs4_compound *cp, int nfserr, struct nfs4_close *close)
+{
+	DECODE_HEAD;
+
+	if (!nfserr) {
+		READ_BUF(sizeof(nfs4_stateid));
+		COPYMEM(close->cl_stateid, sizeof(nfs4_stateid));
+	}
+
+	DECODE_TAIL;
+}
+
+static int
+decode_commit(struct nfs4_compound *cp, int nfserr, struct nfs4_commit *commit)
+{
+        DECODE_HEAD;
+
+        if (!nfserr) {
+                READ_BUF(8);
+                COPYMEM(commit->co_verifier->verifier, 8);
+        }
+
+        DECODE_TAIL;
+}
+
+static int
+decode_create(struct nfs4_compound *cp, int nfserr, struct nfs4_create *create)
+{
+	u32 bmlen;
+	DECODE_HEAD;
+
+	if (!nfserr) {
+		if ((status = decode_change_info(cp, create->cr_cinfo)))
+			goto out;
+		READ_BUF(4);
+		READ32(bmlen);
+		if (bmlen > 2)
+			goto xdr_error;
+		READ_BUF(bmlen << 2);
+	}
+
+	DECODE_TAIL;
+}
+
+static int
+decode_getattr(struct nfs4_compound *cp, int nfserr, struct nfs4_getattr *getattr)
+{
+        struct nfs_fattr *nfp = getattr->gt_attrs;
+	struct nfs_fsinfo *fsinfo = getattr->gt_fsinfo;
+        u32 bmlen;
+        u32 bmval0 = 0;
+        u32 bmval1 = 0;
+        u32 attrlen;
+        u32 dummy32;
+        u32 len = 0;
+	unsigned int type;
+	int fmode = 0;
+        DECODE_HEAD;
+
+        if (nfserr)
+                goto success;
+
+        READ_BUF(4);
+        READ32(bmlen);
+        if (bmlen > 2)
+                goto xdr_error;
+
+        READ_BUF((bmlen << 2) + 4);
+        if (bmlen > 0)
+                READ32(bmval0);
+        if (bmlen > 1)
+                READ32(bmval1);
+        READ32(attrlen);
+
+	if ((bmval0 & ~getattr->gt_bmval[0]) ||
+	    (bmval1 & ~getattr->gt_bmval[1])) {
+		dprintk("read_attrs: server returned bad attributes!\n");
+		goto xdr_error;
+	}
+
+	/*
+	 * In case the server doesn't return some attributes,
+	 * we initialize them here to some nominal values..
+	 */
+	if (nfp) {
+		memset(nfp, 0, sizeof(*nfp));
+		nfp->valid = NFS_ATTR_FATTR | NFS_ATTR_FATTR_V3 | NFS_ATTR_FATTR_V4;
+		nfp->nlink = 1;
+	}
+	if (fsinfo) {
+		memset(fsinfo, 0, sizeof(*fsinfo));
+		fsinfo->bsize = fsinfo->rtmult = fsinfo->wtmult = 512;  /* ??? */
+		fsinfo->lease_time = 60;
+	}
+
+        if (bmval0 & FATTR4_WORD0_TYPE) {
+                READ_BUF(4);
+                len += 4;
+                READ32(type);
+                if (type < NF4REG || type > NF4NAMEDATTR) {
+                        dprintk("read_attrs: bad type %d\n", type);
+                        goto xdr_error;
+                }
+		nfp->type = nfs_type2fmt[type].nfs2type;
+		fmode = nfs_type2fmt[type].mode;
+                dprintk("read_attrs: type=%d\n", (u32)nfp->type);
+        }
+        if (bmval0 & FATTR4_WORD0_CHANGE) {
+                READ_BUF(8);
+                len += 8;
+                READ64(nfp->change_attr);
+                dprintk("read_attrs: changeid=%Ld\n", (u64)nfp->change_attr);
+        }
+        if (bmval0 & FATTR4_WORD0_SIZE) {
+                READ_BUF(8);
+                len += 8;
+                READ64(nfp->size);
+                dprintk("read_attrs: size=%Ld\n", (u64)nfp->size);
+        }
+        if (bmval0 & FATTR4_WORD0_FSID) {
+                READ_BUF(16);
+                len += 16;
+                READ64(nfp->fsid_u.nfs4.major);
+                READ64(nfp->fsid_u.nfs4.minor);
+                dprintk("read_attrs: fsid=0x%Lx/0x%Lx\n",
+			nfp->fsid_u.nfs4.major, nfp->fsid_u.nfs4.minor);
+        }
+        if (bmval0 & FATTR4_WORD0_LEASE_TIME) {
+                READ_BUF(4);
+                len += 4;
+                READ32(fsinfo->lease_time);
+                dprintk("read_attrs: lease_time=%d\n", fsinfo->lease_time);
+        }
+        if (bmval0 & FATTR4_WORD0_FILEID) {
+                READ_BUF(8);
+                len += 8;
+                READ64(nfp->fileid);
+                dprintk("read_attrs: fileid=%Ld\n", nfp->fileid);
+        }
+	if (bmval0 & FATTR4_WORD0_FILES_AVAIL) {
+		READ_BUF(8);
+		len += 8;
+		READ64(fsinfo->afiles);
+		dprintk("read_attrs: files_avail=0x%Lx\n", fsinfo->afiles);
+	}
+        if (bmval0 & FATTR4_WORD0_FILES_FREE) {
+                READ_BUF(8);
+                len += 8;
+                READ64(fsinfo->ffiles);
+                dprintk("read_attrs: files_free=0x%Lx\n", fsinfo->ffiles);
+        }
+        if (bmval0 & FATTR4_WORD0_FILES_TOTAL) {
+                READ_BUF(8);
+                len += 8;
+                READ64(fsinfo->tfiles);
+                dprintk("read_attrs: files_tot=0x%Lx\n", fsinfo->tfiles);
+        }
+        if (bmval0 & FATTR4_WORD0_MAXFILESIZE) {
+                READ_BUF(8);
+                len += 8;
+                READ64(fsinfo->maxfilesize);
+                dprintk("read_attrs: maxfilesize=0x%Lx\n", fsinfo->maxfilesize);
+        }
+	if (bmval0 & FATTR4_WORD0_MAXLINK) {
+		READ_BUF(4);
+		len += 4;
+		READ32(fsinfo->linkmax);
+		dprintk("read_attrs: maxlink=%d\n", fsinfo->linkmax);
+	}
+        if (bmval0 & FATTR4_WORD0_MAXNAME) {
+                READ_BUF(4);
+                len += 4;
+                READ32(fsinfo->namelen);
+                dprintk("read_attrs: maxname=%d\n", fsinfo->namelen);
+        }
+        if (bmval0 & FATTR4_WORD0_MAXREAD) {
+                READ_BUF(8);
+                len += 8;
+                READ64(fsinfo->rtmax);
+		fsinfo->rtpref = fsinfo->dtpref = fsinfo->rtmax;
+                dprintk("read_attrs: maxread=%d\n", fsinfo->rtmax);
+        }
+        if (bmval0 & FATTR4_WORD0_MAXWRITE) {
+                READ_BUF(8);
+                len += 8;
+                READ64(fsinfo->wtmax);
+		fsinfo->wtpref = fsinfo->wtmax;
+                dprintk("read_attrs: maxwrite=%d\n", fsinfo->wtmax);
+        }
+
+        if (bmval1 & FATTR4_WORD1_MODE) {
+                READ_BUF(4);
+                len += 4;
+                READ32(dummy32);
+		nfp->mode = (dummy32 & ~S_IFMT) | fmode;
+                dprintk("read_attrs: mode=0%o\n", nfp->mode);
+        }
+        if (bmval1 & FATTR4_WORD1_NUMLINKS) {
+                READ_BUF(4);
+                len += 4;
+                READ32(nfp->nlink);
+                dprintk("read_attrs: nlinks=0%o\n", nfp->nlink);
+        }
+        if (bmval1 & FATTR4_WORD1_OWNER) {
+                READ_BUF(4);
+                len += 4;
+                READ32(dummy32);    /* name length */
+                if (dummy32 > XDR_MAX_NETOBJ) {
+			dprintk("read_attrs: name too long!\n");
+                        goto xdr_error;
+                }
+                READ_BUF(dummy32);
+                len += (XDR_QUADLEN(dummy32) << 2);
+                if ((status = gss_get_num(GSS_OWNER, dummy32, (char *)p, &nfp->uid))) {
+                        dprintk("read_attrs: gss_get_num failed!\n");
+                        goto out;
+                }
+                dprintk("read_attrs: uid=%d\n", (int)nfp->uid);
+        }
+        if (bmval1 & FATTR4_WORD1_OWNER_GROUP) {
+                READ_BUF(4);
+                len += 4;
+                READ32(dummy32);
+                if (dummy32 > XDR_MAX_NETOBJ) {
+                        dprintk("read_attrs: name too long!\n");
+                        goto xdr_error;
+                }
+                READ_BUF(dummy32);
+                len += (XDR_QUADLEN(dummy32) << 2);
+                if ((status = gss_get_num(GSS_GROUP, dummy32, (char *)p, &nfp->gid))) {
+                        dprintk("read_attrs: gss_get_num failed!\n");
+                        goto out;
+                }
+                dprintk("read_attrs: gid=%d\n", (int)nfp->gid);
+        }
+        if (bmval1 & FATTR4_WORD1_RAWDEV) {
+                READ_BUF(8);
+                len += 8;
+                READ32(dummy32);
+		nfp->rdev = (dummy32 << MINORBITS);
+                READ32(dummy32);
+		nfp->rdev |= (dummy32 & MINORMASK);
+                dprintk("read_attrs: rdev=%d\n", nfp->rdev);
+        }
+        if (bmval1 & FATTR4_WORD1_SPACE_AVAIL) {
+                READ_BUF(8);
+                len += 8;
+                READ64(fsinfo->abytes);
+                dprintk("read_attrs: savail=0x%Lx\n", fsinfo->abytes);
+        }
+	if (bmval1 & FATTR4_WORD1_SPACE_FREE) {
+                READ_BUF(8);
+                len += 8;
+                READ64(fsinfo->fbytes);
+                dprintk("read_attrs: sfree=0x%Lx\n", fsinfo->fbytes);
+        }
+        if (bmval1 & FATTR4_WORD1_SPACE_TOTAL) {
+                READ_BUF(8);
+                len += 8;
+                READ64(fsinfo->tbytes);
+                dprintk("read_attrs: stotal=0x%Lx\n", fsinfo->tbytes);
+        }
+        if (bmval1 & FATTR4_WORD1_SPACE_USED) {
+                READ_BUF(8);
+                len += 8;
+                READ64(nfp->du.nfs3.used);
+                dprintk("read_attrs: sused=0x%Lx\n", nfp->du.nfs3.used);
+        }
+        if (bmval1 & FATTR4_WORD1_TIME_ACCESS) {
+                READ_BUF(12);
+                len += 12;
+                READTIME(nfp->atime);
+                dprintk("read_attrs: atime=%d\n", (int)nfp->atime);
+        }
+        if (bmval1 & FATTR4_WORD1_TIME_METADATA) {
+                READ_BUF(12);
+                len += 12;
+                READTIME(nfp->ctime);
+                dprintk("read_attrs: ctime=%d\n", (int)nfp->ctime);
+        }
+        if (bmval1 & FATTR4_WORD1_TIME_MODIFY) {
+                READ_BUF(12);
+                len += 12;
+                READTIME(nfp->mtime);
+                dprintk("read_attrs: mtime=%d\n", (int)nfp->mtime);
+        }
+        if (len != attrlen)
+                goto xdr_error;
+
+success:
+        DECODE_TAIL;
+}
+
+static int
+decode_getfh(struct nfs4_compound *cp, int nfserr, struct nfs4_getfh *getfh)
+{
+	int len;
+        DECODE_HEAD;
+
+        if (!nfserr) {
+                READ_BUF(4);
+		READ32(len);
+		if (len > NFS_MAXFHSIZE)
+			goto xdr_error;
+		getfh->gf_fhandle->size = len;
+                READ_BUF(len);
+                COPYMEM(getfh->gf_fhandle->data, len);
+        }
+
+        DECODE_TAIL;
+}
+
+static int
+decode_link(struct nfs4_compound *cp, int nfserr, struct nfs4_link *link)
+{
+	int status = 0;
+
+	if (!nfserr)
+		status = decode_change_info(cp, link->ln_cinfo);
+	return status;
+}
+
+static int
+decode_open(struct nfs4_compound *cp, int nfserr, struct nfs4_open *open)
+{
+	u32 bmlen, delegation_type;
+	DECODE_HEAD;
+
+	if (!nfserr) {
+		READ_BUF(sizeof(nfs4_stateid));
+		COPYMEM(open->op_stateid, sizeof(nfs4_stateid));
+
+		decode_change_info(cp, open->op_cinfo);
+
+		READ_BUF(8);
+		READ32(*open->op_rflags);
+		READ32(bmlen);
+		if (bmlen > 10)
+			goto xdr_error;
+
+		READ_BUF((bmlen << 2) + 4);
+		p += bmlen;
+		READ32(delegation_type);
+		if (delegation_type != NFS4_OPEN_DELEGATE_NONE)
+			goto xdr_error;
+	}
+
+	DECODE_TAIL;
+}
+
+static int
+decode_open_confirm(struct nfs4_compound *cp, int nfserr, struct nfs4_open_confirm *open_confirm)
+{
+	DECODE_HEAD;
+
+	if (!nfserr) {
+		READ_BUF(sizeof(nfs4_stateid));
+		COPYMEM(open_confirm->oc_stateid, sizeof(nfs4_stateid));
+	}
+
+	DECODE_TAIL;
+}
+
+static int
+decode_read(struct nfs4_compound *cp, int nfserr, struct nfs4_read *read)
+{
+	u32 throwaway;
+	DECODE_HEAD;
+
+	if (!nfserr) {
+		READ_BUF(8);
+		if (read->rd_eof)
+			READ32(*read->rd_eof);
+		else
+			READ32(throwaway);
+		READ32(*read->rd_bytes_read);
+		if (*read->rd_bytes_read > read->rd_length)
+			goto xdr_error;
+	}
+
+	DECODE_TAIL;
+}
+
+static int
+decode_readdir(struct nfs4_compound *cp, int nfserr, struct rpc_rqst *req, struct nfs4_readdir *readdir)
+{
+	struct xdr_buf	*rcvbuf = &req->rq_rcv_buf;
+	struct page	*page = *rcvbuf->pages;
+	unsigned int	pglen = rcvbuf->page_len;
+	u32		*end, *entry;
+	u32		len, attrlen, word;
+	int 		i;
+	DECODE_HEAD;
+
+	if (!nfserr) {
+		READ_BUF(8);
+		COPYMEM(readdir->rd_resp_verifier, 8);
+
+		BUG_ON(pglen > PAGE_CACHE_SIZE);
+		p   = (u32 *) kmap(page);
+		end = (u32 *) ((char *)p + pglen + readdir->rd_pgbase);
+
+		while (*p++) {
+			entry = p - 1;
+			if (p + 3 > end)
+				goto short_pkt;
+			p += 2;     /* cookie */
+			len = ntohl(*p++);  /* filename length */
+			if (len > NFS4_MAXNAMLEN) {
+				printk(KERN_WARNING "NFS: giant filename in readdir (len 0x%x)\n", len);
+				goto err_unmap;
+			}
+
+			p += XDR_QUADLEN(len);
+			if (p + 1 > end)
+				goto short_pkt;
+			len = ntohl(*p++);  /* bitmap length */
+			if (len > 10) {
+				printk(KERN_WARNING "NFS: giant bitmap in readdir (len 0x%x)\n", len);
+				goto err_unmap;
+			}
+			if (p + len + 1 > end)
+				goto short_pkt;
+			attrlen = 0;
+			for (i = 0; i < len; i++) {
+				word = ntohl(*p++);
+				if (!word)
+					continue;
+				else if (i == 0 && word == FATTR4_WORD0_FILEID) {
+					attrlen = 8;
+					continue;
+				}
+				printk(KERN_WARNING "NFS: unexpected bitmap word in readdir (0x%x)\n", word);
+				goto err_unmap;
+			}
+			if (ntohl(*p++) != attrlen) {
+				printk(KERN_WARNING "NFS: unexpected attrlen in readdir\n");
+				goto err_unmap;
+			}
+			p += XDR_QUADLEN(attrlen);
+			if (p + 1 > end)
+				goto short_pkt;
+		}
+		kunmap(page);
+	}
+
+	DECODE_TAIL;
+short_pkt:
+	printk(KERN_NOTICE "NFS: short packet in readdir reply!\n");
+	/* truncate listing */
+	entry[0] = entry[1] = 0;
+	kunmap(page);
+	return 0;
+err_unmap:
+	kunmap(page);
+	return -errno_NFSERR_IO;
+}
+
+static int
+decode_readlink(struct nfs4_compound *cp, int nfserr, struct rpc_rqst *req, struct nfs4_readlink *readlink)
+{
+	struct xdr_buf *rcvbuf = &req->rq_rcv_buf;
+	u32 *strlen;
+	u32 len;
+	char *string;
+
+	if (!nfserr) {
+		/*
+		 * The XDR encode routine has set things up so that
+		 * the link text will be copied directly into the
+		 * buffer.  We just have to do overflow-checking,
+		 * and and null-terminate the text (the VFS expects
+		 * null-termination).
+		 */
+		strlen = (u32 *) kmap(rcvbuf->pages[0]);
+		len = ntohl(*strlen);
+		if (len > PAGE_CACHE_SIZE - 5) {
+			printk(KERN_WARNING "nfs: server returned giant symlink!\n");
+			kunmap(rcvbuf->pages[0]);
+			return -EIO;
+		}
+		*strlen = len;
+
+		string = (char *)(strlen + 1);
+		string[len] = '\0';
+		kunmap(rcvbuf->pages[0]);
+	}
+	return 0;
+}
+
+static int
+decode_remove(struct nfs4_compound *cp, int nfserr, struct nfs4_remove *remove)
+{
+	int status;
+
+	status = 0;
+	if (!nfserr)
+		status = decode_change_info(cp, remove->rm_cinfo);
+	return status;
+}
+
+static int
+decode_rename(struct nfs4_compound *cp, int nfserr, struct nfs4_rename *rename)
+{
+	int status = 0;
+
+	if (!nfserr) {
+		if ((status = decode_change_info(cp, rename->rn_src_cinfo)))
+			goto out;
+		if ((status = decode_change_info(cp, rename->rn_dst_cinfo)))
+			goto out;
+	}
+out:
+	return status;
+}
+
+static int
+decode_setattr(struct nfs4_compound *cp)
+{
+        u32 bmlen;
+        DECODE_HEAD;
+
+        READ_BUF(4);
+        READ32(bmlen);
+        if (bmlen > 10)
+                goto xdr_error;
+        READ_BUF(bmlen << 2);
+
+        DECODE_TAIL;
+}
+
+static int
+decode_setclientid(struct nfs4_compound *cp, int nfserr)
+{
+	DECODE_HEAD;
+
+	if (!nfserr) {
+		READ_BUF(8);
+		READ64(cp->server->nfs4_state->cl_clientid);
+	}
+	else if (nfserr == NFSERR_CLID_INUSE) {
+		u32 len;
+
+		/* skip netid string */
+		READ_BUF(4);
+		READ32(len);
+		READ_BUF(len);
+
+		/* skip uaddr string */
+		READ_BUF(4);
+		READ32(len);
+		READ_BUF(len);
+	}
+
+	DECODE_TAIL;
+}
+
+static int
+decode_write(struct nfs4_compound *cp, int nfserr, struct nfs4_write *write)
+{
+	DECODE_HEAD;
+
+	if (!nfserr) {
+		READ_BUF(16);
+		READ32(*write->wr_bytes_written);
+		if (*write->wr_bytes_written > write->wr_len)
+			goto xdr_error;
+		READ32(write->wr_verf->committed);
+		COPYMEM(write->wr_verf->verifier, 8);
+	}
+
+	DECODE_TAIL;
+}
+
+static int
+decode_compound(struct nfs4_compound *cp, struct rpc_rqst *req)
+{
+	u32 taglen;
+	u32 opnum, nfserr;
+	DECODE_HEAD;
+
+	READ_BUF(8);
+	READ32(cp->toplevel_status);
+	READ32(taglen);
+
+	/*
+	 * We need this if our zero-copy I/O is going to work.  Rumor has
+	 * it that the spec will soon mandate it...
+	 */
+	if (taglen != cp->taglen) {
+		dprintk("nfs4: tag length mismatch!\n");
+		goto xdr_error;
+	}
+
+	READ_BUF(taglen + 4);
+	p += XDR_QUADLEN(taglen);
+	READ32(cp->resp_nops);
+	if (cp->resp_nops > cp->req_nops) {
+		dprintk("nfs4: resp_nops > req_nops!\n");
+		goto xdr_error;
+	}
+
+	for (cp->nops = 0; cp->nops < cp->resp_nops; cp->nops++) {
+		READ_BUF(8);
+		READ32(opnum);
+		if (opnum != cp->ops[cp->nops].opnum) {
+			dprintk("nfs4: operation mismatch!\n");
+			goto xdr_error;
+		}
+		READ32(nfserr);
+		if (cp->nops == cp->resp_nops - 1) {
+			if (nfserr != cp->toplevel_status) {
+				dprintk("nfs4: status mismatch!\n");
+				goto xdr_error;
+			}
+		}
+		else if (nfserr) {
+			dprintk("nfs4: intermediate status nonzero!\n");
+			goto xdr_error;
+		}
+		cp->ops[cp->nops].nfserr = nfserr;
+
+		switch (opnum) {
+		case OP_ACCESS:
+			status = decode_access(cp, nfserr, &cp->ops[cp->nops].u.access);
+			break;
+		case OP_CLOSE:
+			status = decode_close(cp, nfserr, &cp->ops[cp->nops].u.close);
+			break;
+		case OP_COMMIT:
+			status = decode_commit(cp, nfserr, &cp->ops[cp->nops].u.commit);
+			break;
+		case OP_CREATE:
+			status = decode_create(cp, nfserr, &cp->ops[cp->nops].u.create);
+			break;
+		case OP_GETATTR:
+			status = decode_getattr(cp, nfserr, &cp->ops[cp->nops].u.getattr);
+			break;
+		case OP_GETFH:
+			status = decode_getfh(cp, nfserr, &cp->ops[cp->nops].u.getfh);
+			break;
+		case OP_LINK:
+			status = decode_link(cp, nfserr, &cp->ops[cp->nops].u.link);
+			break;
+		case OP_LOOKUP:
+			status = 0;
+			break;
+		case OP_OPEN:
+			status = decode_open(cp, nfserr, &cp->ops[cp->nops].u.open);
+			break;
+		case OP_OPEN_CONFIRM:
+			status = decode_open_confirm(cp, nfserr, &cp->ops[cp->nops].u.open_confirm);
+			break;
+		case OP_PUTFH:
+			status = 0;
+			break;
+		case OP_PUTROOTFH:
+			status = 0;
+			break;
+		case OP_READ:
+			status = decode_read(cp, nfserr, &cp->ops[cp->nops].u.read);
+			break;
+		case OP_READDIR:
+			status = decode_readdir(cp, nfserr, req, &cp->ops[cp->nops].u.readdir);
+			break;
+		case OP_READLINK:
+			status = decode_readlink(cp, nfserr, req, &cp->ops[cp->nops].u.readlink);
+			break;
+		case OP_RESTOREFH:
+			status = 0;
+			break;
+		case OP_REMOVE:
+			status = decode_remove(cp, nfserr, &cp->ops[cp->nops].u.remove);
+			break;
+		case OP_RENAME:
+			status = decode_rename(cp, nfserr, &cp->ops[cp->nops].u.rename);
+			break;
+		case OP_RENEW:
+			status = 0;
+			break;
+		case OP_SAVEFH:
+			status = 0;
+			break;
+		case OP_SETATTR:
+			status = decode_setattr(cp);
+			break;
+		case OP_SETCLIENTID:
+			status = decode_setclientid(cp, nfserr);
+			break;
+		case OP_SETCLIENTID_CONFIRM:
+			status = 0;
+			break;
+		case OP_WRITE:
+			status = decode_write(cp, nfserr, &cp->ops[cp->nops].u.write);
+			break;
+		default:
+			BUG();
+			return -EIO;
+		}
+		if (status)
+			goto xdr_error;
+	}
+
+	DECODE_TAIL;
+}
+/*
+ * END OF "GENERIC" DECODE ROUTINES.
+ */
+
+/*
+ * Decode void reply
+ */
+static int
+nfs4_xdr_dec_void(struct rpc_rqst *req, u32 *p, void *dummy)
+{
+	return 0;
+}
+
+/*
+ * Decode COMPOUND response
+ */
+static int
+nfs4_xdr_dec_compound(struct rpc_rqst *rqstp, u32 *p, struct nfs4_compound *cp)
+{
+	int status;
+
+	cp->p = p;
+	cp->end = (u32 *) ((u8 *) rqstp->rq_rvec->iov_base + rqstp->rq_rvec->iov_len);
+
+	if ((status = decode_compound(cp, rqstp)))
+		goto out;
+
+	status = 0;
+	if (cp->toplevel_status)
+		status = -nfs_stat_to_errno(cp->toplevel_status);
+
+out:
+	return status;
+}
+
+u32 *
+nfs4_decode_dirent(u32 *p, struct nfs_entry *entry, int plus)
+{
+	u32 len;
+
+	if (!*p++) {
+		if (!*p)
+			return ERR_PTR(-EAGAIN);
+		entry->eof = 1;
+		return ERR_PTR(-EBADCOOKIE);
+	}
+
+	entry->prev_cookie = entry->cookie;
+	p = xdr_decode_hyper(p, &entry->cookie);
+	entry->len = ntohl(*p++);
+	entry->name = (const char *) p;
+	p += XDR_QUADLEN(entry->len);
+
+	if (entry->cookie > COOKIE_MAX)
+		entry->cookie = COOKIE_MAX;
+
+	/*
+	 * In case the server doesn't return an inode number,
+	 * we fake one here.  (We don't use inode number 0,
+	 * since glibc seems to choke on it...)
+	 */
+	entry->ino = 1;
+
+	len = ntohl(*p++);             /* bitmap length */
+	p += len;
+	len = ntohl(*p++);             /* attribute buffer length */
+	if (len)
+		p = xdr_decode_hyper(p, &entry->ino);
+
+	entry->eof = !p[0] && p[1];
+	return p;
+}
+
+#ifndef MAX
+# define MAX(a, b)	(((a) > (b))? (a) : (b))
+#endif
+
+#define PROC(proc, argtype, restype)				\
+    { "nfs4_" #proc,						\
+      (kxdrproc_t) nfs4_xdr_##argtype,				\
+      (kxdrproc_t) nfs4_xdr_##restype,				\
+      MAX(NFS4_##argtype##_sz,NFS4_##restype##_sz) << 2,	\
+      0							\
+    }
+
+static struct rpc_procinfo	nfs4_procedures[] = {
+  PROC(null,		enc_void,	dec_void),
+  PROC(compound,	enc_compound,	dec_compound)
+};
+
+struct rpc_version		nfs_version4 = {
+	number:			4,
+	nrprocs:		sizeof(nfs4_procedures)/sizeof(nfs4_procedures[0]),
+	procs:			nfs4_procedures
+};
+
+/*
+ * Local variables:
+ *  c-basic-offset: 8
+ * End:
+ */

