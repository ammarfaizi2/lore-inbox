Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319174AbSHMXNS>; Tue, 13 Aug 2002 19:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319106AbSHMXMh>; Tue, 13 Aug 2002 19:12:37 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:19197 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319101AbSHMXIN>; Tue, 13 Aug 2002 19:08:13 -0400
Date: Tue, 13 Aug 2002 19:12:02 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 36/38: SERVER: header file for NFSv4 XDR
Message-ID: <Pine.SOL.4.44.0208131911440.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Instantiate a new file include/linux/nfsd/xdr4.h (server-side XDR for
NFSv4).

--- old/include/linux/nfsd/xdr4.h	Fri Aug  9 11:08:16 2002
+++ new/include/linux/nfsd/xdr4.h	Mon Aug  5 16:20:05 2002
@@ -0,0 +1,300 @@
+/*
+ *  include/linux/nfsd/xdr4.h
+ *
+ *  Server-side types for NFSv4.
+ *
+ *  Copyright (c) 2002 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Kendrick Smith <kmsmith@umich.edu>
+ *  Andy Adamson   <andros@umich.edu>
+ */
+
+#ifndef _LINUX_NFSD_XDR4_H
+#define _LINUX_NFSD_XDR4_H
+
+#define NFSD4_MAX_TAGLEN	128
+
+typedef struct {
+	u32		cl_boot;
+	u32		cl_id;
+} clientid_t;
+
+typedef u32 stateid_boot_t;        /* used to detect stale stateids */
+typedef u32 stateid_lockowner_t;   /* lockowner id - used in various places */
+typedef u32 stateid_file_t;        /* identifies a unique file per lockowner */
+typedef u32 stateid_generation_t;  /* used to update stateids */
+
+typedef struct {
+	stateid_boot_t		so_boot;
+	stateid_lockowner_t	so_lockowner;
+	stateid_file_t		so_file;
+} stateid_other_t;
+
+typedef struct {
+	stateid_generation_t	st_generation;
+	stateid_other_t		st_other;
+} stateid_t;
+
+typedef u32 delegation_zero_t;
+typedef u32 delegation_boot_t;
+typedef u64 delegation_id_t;
+
+typedef struct {
+	delegation_zero_t	ds_zero;
+	delegation_boot_t	ds_boot;
+	delegation_id_t		ds_id;
+} delegation_stateid_t;
+
+struct nfsd4_change_info {
+	u32		atomic;
+	u32		before_size;
+	u32		before_ctime;
+	u32		after_size;
+	u32		after_ctime;
+};
+
+struct nfsd4_access {
+	u32		ac_req_access;      /* request */
+	u32		ac_supported;       /* response */
+	u32		ac_resp_access;     /* response */
+};
+
+struct nfsd4_close {
+	u32		cl_seqid;           /* request */
+	stateid_t	cl_stateid;         /* request+response */
+};
+
+struct nfsd4_commit {
+	u64		co_offset;          /* request */
+	u32		co_count;           /* request */
+	nfs4_verifier	co_verf;            /* response */
+};
+
+struct nfsd4_create {
+	u32		cr_namelen;         /* request */
+	char *		cr_name;            /* request */
+	u32		cr_type;            /* request */
+	union {                             /* request */
+		struct {
+			u32 namelen;
+			char *name;
+		} link;   /* NF4LNK */
+		struct {
+			u32 specdata1;
+			u32 specdata2;
+		} dev;    /* NF4BLK, NF4CHR */
+	} u;
+	u32		cr_bmval[2];        /* request */
+	struct iattr	cr_iattr;           /* request */
+	struct nfsd4_change_info  cr_cinfo; /* response */
+};
+#define cr_linklen	u.link.namelen
+#define cr_linkname	u.link.name
+#define cr_specdata1	u.dev.specdata1
+#define cr_specdata2	u.dev.specdata2
+
+struct nfsd4_getattr {
+	u32		ga_bmval[2];        /* request */
+	struct svc_fh	*ga_fhp;            /* response */
+};
+
+struct nfsd4_link {
+	u32		li_namelen;         /* request */
+	char *		li_name;            /* request */
+	struct nfsd4_change_info  li_cinfo; /* response */
+};
+
+struct nfsd4_lookup {
+	u32		lo_len;             /* request */
+	char *		lo_name;            /* request */
+};
+
+struct nfsd4_putfh {
+	u32		pf_fhlen;           /* request */
+	char		*pf_fhval;          /* request */
+};
+
+struct nfsd4_open {
+	u32		op_claim_type;      /* request */
+	u32		op_namelen;	    /* request - everything but CLAIM_PREV */
+	char *		op_name;	    /* request - everything but CLAIM_PREV */
+	u32		op_delegate_type;   /* request - CLAIM_PREV only */
+	delegation_stateid_t	op_delegate_stateid; /* request - CLAIM_DELEGATE_CUR only */
+	u32		op_create;     	    /* request */
+	u32		op_createmode;      /* request */
+	u32		op_bmval[2];        /* request */
+	union {                             /* request */
+		struct iattr	iattr;		            /* UNCHECKED4,GUARDED4 */
+		nfs4_verifier	verf;		                     /* EXCLUSIVE4 */
+	} u;
+	clientid_t	op_clientid;        /* request */
+	u32		op_ownerlen;        /* request */
+	char *		op_owner;           /* request */
+	u32		op_seqid;           /* request */
+	u32		op_share_access;    /* request */
+	u32		op_share_deny;      /* request */
+	stateid_t	op_stateid;         /* response */
+	struct nfsd4_change_info  op_cinfo; /* response */
+	u32		op_rflags;          /* response */
+	int		op_truncate;        /* used during processing */
+
+};
+#define op_iattr	u.iattr
+#define op_verf		u.verf
+
+struct nfsd4_read {
+	stateid_t	rd_stateid;         /* request */
+	u64		rd_offset;          /* request */
+	u32		rd_length;          /* request */
+	struct svc_rqst *rd_rqstp;          /* response */
+	struct svc_fh * rd_fhp;             /* response */
+};
+
+struct nfsd4_readdir {
+	u64		rd_cookie;          /* request */
+	nfs4_verifier	rd_verf;            /* request */
+	u32		rd_dircount;        /* request */
+	u32		rd_maxcount;        /* request */
+	u32		rd_bmval[2];        /* request */
+	struct svc_rqst *rd_rqstp;          /* response */
+	struct svc_fh * rd_fhp;             /* response */
+};
+
+struct nfsd4_readlink {
+	struct svc_rqst *rl_rqstp;          /* request */
+	struct svc_fh *	rl_fhp;             /* request */
+};
+
+struct nfsd4_remove {
+	u32		rm_namelen;         /* request */
+	char *		rm_name;            /* request */
+	struct nfsd4_change_info  rm_cinfo; /* response */
+};
+
+struct nfsd4_rename {
+	u32		rn_snamelen;        /* request */
+	char *		rn_sname;           /* request */
+	u32		rn_tnamelen;        /* request */
+	char *		rn_tname;           /* request */
+	struct nfsd4_change_info  rn_sinfo; /* response */
+	struct nfsd4_change_info  rn_tinfo; /* response */
+};
+
+struct nfsd4_setattr {
+	stateid_t	sa_stateid;         /* request */
+	u32		sa_bmval[2];        /* request */
+	struct iattr	sa_iattr;           /* request */
+};
+
+struct nfsd4_setclientid {
+	nfs4_verifier	se_verf;            /* request */
+	u32		se_namelen;         /* request */
+	char *		se_name;            /* request */
+	u32		se_callback_prog;   /* request */
+	u32		se_callback_netid_len;  /* request */
+	char *		se_callback_netid_val;  /* request */
+	u32		se_callback_addr_len;   /* request */
+	char *		se_callback_addr_val;   /* request */
+	u32		se_callback_ident;  /* request */
+	clientid_t	se_clientid;        /* response */
+};
+
+/* also used for NVERIFY */
+struct nfsd4_verify {
+	u32		ve_bmval[2];        /* request */
+	u32		ve_attrlen;         /* request */
+	char *		ve_attrval;         /* request */
+};
+
+struct nfsd4_write {
+	stateid_t	wr_stateid;         /* request */
+	u64		wr_offset;          /* request */
+	u32		wr_stable_how;      /* request */
+	u32		wr_buflen;          /* request */
+	char *		wr_buf;             /* request */
+	u32		wr_bytes_written;   /* response */
+	u32		wr_how_written;     /* response */
+	nfs4_verifier	wr_verifier;        /* response */
+};
+
+struct nfsd4_op {
+	int					opnum;
+	int					status;
+	union {
+		struct nfsd4_access		access;
+		struct nfsd4_close		close;
+		struct nfsd4_commit		commit;
+		struct nfsd4_create		create;
+		struct nfsd4_getattr		getattr;
+		struct svc_fh *			getfh;
+		struct nfsd4_link		link;
+		struct nfsd4_lookup		lookup;
+		struct nfsd4_verify		nverify;
+		struct nfsd4_open		open;
+		struct nfsd4_putfh		putfh;
+		struct nfsd4_read		read;
+		struct nfsd4_readdir		readdir;
+		struct nfsd4_readlink		readlink;
+		struct nfsd4_remove		remove;
+		struct nfsd4_rename		rename;
+		clientid_t			renew;
+		struct nfsd4_setattr		setattr;
+		struct nfsd4_setclientid	setclientid;
+		clientid_t			setclientid_confirm;
+		struct nfsd4_verify		verify;
+		struct nfsd4_write		write;
+	} u;
+};
+
+struct nfsd4_compoundargs {
+	/* scratch variables for XDR decode */
+	u32 *				p;
+	u32 *				end;
+
+	u32				taglen;
+	char *				tag;
+	u32				minorversion;
+	u32				opcnt;
+	struct nfsd4_op			*ops;
+	struct nfsd4_op			iops[8];
+};
+
+struct nfsd4_compoundres {
+	/* scratch variables for XDR encode */
+	u32 *				p;
+	u32 *				end;
+
+	u32				taglen;
+	char *				tag;
+	u32				opcnt;
+};
+
+#define NFS4_SVC_XDRSIZE		sizeof(struct nfsd4_compoundargs)
+
+static inline void
+set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
+{
+	BUG_ON(!fhp->fh_pre_saved || !fhp->fh_post_saved);
+	cinfo->atomic = 1;
+	cinfo->before_size = fhp->fh_pre_size;
+	cinfo->before_ctime = fhp->fh_pre_ctime;
+	cinfo->after_size = fhp->fh_post_size;
+	cinfo->after_ctime = fhp->fh_post_ctime;
+}
+
+int nfs4svc_encode_voidres(struct svc_rqst *, u32 *, void *);
+int nfs4svc_decode_compoundargs(struct svc_rqst *, u32 *, struct nfsd4_compoundargs *);
+int nfs4svc_encode_compoundres(struct svc_rqst *, u32 *, struct nfsd4_compoundres *);
+
+void nfsd4_encode_operation(struct nfsd4_compoundres *, struct nfsd4_op *);
+int nfsd4_encode_fattr(struct svc_fh *fhp, struct svc_export *exp,
+		       struct dentry *dentry, u32 *buffer, int *countp, u32 *bmval);
+
+#endif
+
+/*
+ * Local variables:
+ *  c-basic-offset: 8
+ * End:
+ */

