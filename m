Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVB0QSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVB0QSB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 11:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVB0QR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 11:17:26 -0500
Received: from cantor.suse.de ([195.135.220.2]:27604 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261430AbVB0P44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 10:56:56 -0500
Message-Id: <20050227152353.191399000@blunzn.suse.de>
References: <20050227152243.083308000@blunzn.suse.de>
Date: Sun, 27 Feb 2005 16:22:53 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch 10/16] Infrastructure and server side of nfsacl
Content-Disposition: inline; filename=nfsacl-infrastructure-and-server-side-of-nfsacl.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds functions for encoding and decoding POSIX ACLs for the NFSACL
protocol extension, and the GETACL and SETACL RPCs.  The implementation is
compatible with NFSACL in Solaris.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Acked-by: Olaf Kirch <okir@suse.de>

Index: linux-2.6.11-rc5/fs/Kconfig
===================================================================
--- linux-2.6.11-rc5.orig/fs/Kconfig
+++ linux-2.6.11-rc5/fs/Kconfig
@@ -1531,6 +1531,20 @@ config NFSD_V3
 	  If you would like to include the NFSv3 server as well as the NFSv2
 	  server, say Y here.  If unsure, say Y.
 
+config NFSD_ACL
+	bool "NFS_ACL protocol extension"
+	depends on NFSD_V3
+	select NFS_ACL_SUPPORT
+	help
+	  Implement the NFS_ACL protocol extension for manipulating POSIX
+	  Access Control Lists on exported file systems.  The clients must
+	  also implement the NFS_ACL protocol extension; see the
+	  CONFIG_NFS_ACL option.  If unsure, say N.
+
+config NFS_ACL_SUPPORT
+	bool
+	select FS_POSIX_ACL
+
 config NFSD_V4
 	bool "Provide NFSv4 server support (EXPERIMENTAL)"
 	depends on NFSD_V3 && EXPERIMENTAL
Index: linux-2.6.11-rc5/fs/Makefile
===================================================================
--- linux-2.6.11-rc5.orig/fs/Makefile
+++ linux-2.6.11-rc5/fs/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_BINFMT_FLAT)	+= binfmt_flat
 
 obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
 obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o xattr_acl.o
+obj-$(CONFIG_NFS_ACL_SUPPORT)	+= nfsacl.o
 
 obj-$(CONFIG_QUOTA)		+= dquot.o
 obj-$(CONFIG_QFMT_V1)		+= quota_v1.o
Index: linux-2.6.11-rc5/fs/nfsacl.c
===================================================================
--- /dev/null
+++ linux-2.6.11-rc5/fs/nfsacl.c
@@ -0,0 +1,254 @@
+/*
+ * fs/nfsacl.c
+ *
+ *  Copyright (C) 2002-2003 Andreas Gruenbacher <agruen@suse.de>
+ */
+
+/*
+ * The Solaris nfsacl protocol represents some ACLs slightly differently
+ * than POSIX 1003.1e draft 17 does (and we do):
+ *
+ *  - Minimal ACLs always have an ACL_MASK entry, so they have
+ *    four instead of three entries.
+ *  - The ACL_MASK entry in such minimal ACLs always has the same
+ *    permissions as the ACL_GROUP_OBJ entry. (In extended ACLs
+ *    the ACL_MASK and ACL_GROUP_OBJ entries may differ.)
+ *  - The identifier fields of the ACL_USER_OBJ and ACL_GROUP_OBJ
+ *    entries contain the identifiers of the owner and owning group.
+ *    (In POSIX ACLs we always set them to ACL_UNDEFINED_ID).
+ *  - ACL entries in the kernel are kept sorted in ascending order
+ *    of (e_tag, e_id). Solaris ACLs are unsorted.
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/sunrpc/xdr.h>
+#include <linux/nfsacl.h>
+#include <linux/nfs3.h>
+
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(nfsacl_encode);
+EXPORT_SYMBOL(nfsacl_decode);
+
+struct nfsacl_encode_desc {
+	struct xdr_array2_desc desc;
+	unsigned int count;
+	struct posix_acl *acl;
+	int typeflag;
+	uid_t uid;
+	gid_t gid;
+};
+
+static int
+xdr_nfsace_encode(struct xdr_array2_desc *desc, void *elem)
+{
+	struct nfsacl_encode_desc *nfsacl_desc =
+		(struct nfsacl_encode_desc *) desc;
+	u32 *p = (u32 *) elem;
+
+	if (nfsacl_desc->count < nfsacl_desc->acl->a_count) {
+		struct posix_acl_entry *entry =
+			&nfsacl_desc->acl->a_entries[nfsacl_desc->count++];
+
+		*p++ = htonl(entry->e_tag | nfsacl_desc->typeflag);
+		switch(entry->e_tag) {
+			case ACL_USER_OBJ:
+				*p++ = htonl(nfsacl_desc->uid);
+				break;
+			case ACL_GROUP_OBJ:
+				*p++ = htonl(nfsacl_desc->gid);
+				break;
+			case ACL_USER:
+			case ACL_GROUP:
+				*p++ = htonl(entry->e_id);
+				break;
+			default:  /* Solaris depends on that! */
+				*p++ = 0;
+				break;
+		}
+		*p++ = htonl(entry->e_perm & S_IRWXO);
+	} else {
+		const struct posix_acl_entry *pa, *pe;
+		int group_obj_perm = ACL_READ|ACL_WRITE|ACL_EXECUTE;
+
+		FOREACH_ACL_ENTRY(pa, nfsacl_desc->acl, pe) {
+			if (pa->e_tag == ACL_GROUP_OBJ) {
+				group_obj_perm = pa->e_perm & S_IRWXO;
+				break;
+			}
+		}
+		/* fake up ACL_MASK entry */
+		*p++ = htonl(ACL_MASK | nfsacl_desc->typeflag);
+		*p++ = htonl(0);
+		*p++ = htonl(group_obj_perm);
+	}
+
+	return 0;
+}
+
+unsigned int
+nfsacl_encode(struct xdr_buf *buf, unsigned int base, struct inode *inode,
+	      struct posix_acl *acl, int encode_entries, int typeflag)
+{
+	int entries = (acl && acl->a_count) ? max_t(int, acl->a_count, 4) : 0;
+	struct nfsacl_encode_desc nfsacl_desc = {
+		.desc = {
+			.elem_size = 12,
+			.array_len = encode_entries ? entries : 0,
+			.xcode = xdr_nfsace_encode,
+		},
+		.acl = acl,
+		.typeflag = typeflag,
+		.uid = inode->i_uid,
+		.gid = inode->i_gid,
+	};
+	int err;
+
+	if (entries > NFS3_ACL_MAX_ENTRIES ||
+	    xdr_encode_word(buf, base, entries))
+		return -EINVAL;
+	err = xdr_encode_array2(buf, base + 4, &nfsacl_desc.desc);
+	if (!err)
+		err = 8 + nfsacl_desc.desc.elem_size *
+			  nfsacl_desc.desc.array_len;
+	return err;
+}
+
+struct nfsacl_decode_desc {
+	struct xdr_array2_desc desc;
+	unsigned int count;
+	struct posix_acl *acl;
+};
+
+static int
+xdr_nfsace_decode(struct xdr_array2_desc *desc, void *elem)
+{
+	struct nfsacl_decode_desc *nfsacl_desc =
+		(struct nfsacl_decode_desc *) desc;
+	u32 *p = (u32 *) elem;
+	struct posix_acl_entry *entry;
+
+	if (!nfsacl_desc->acl) {
+		if (desc->array_len > NFS3_ACL_MAX_ENTRIES)
+			return -EINVAL;
+		nfsacl_desc->acl = posix_acl_alloc(desc->array_len, GFP_KERNEL);
+		if (!nfsacl_desc->acl)
+			return -ENOMEM;
+		nfsacl_desc->count = 0;
+	}
+
+	entry = &nfsacl_desc->acl->a_entries[nfsacl_desc->count++];
+	entry->e_tag = ntohl(*p++) & ~NFS3_ACL_DEFAULT;
+	entry->e_id = ntohl(*p++);
+	entry->e_perm = ntohl(*p++);
+
+	switch(entry->e_tag) {
+		case ACL_USER_OBJ:
+		case ACL_USER:
+		case ACL_GROUP_OBJ:
+		case ACL_GROUP:
+		case ACL_OTHER:
+			if (entry->e_perm & ~S_IRWXO)
+				return -EINVAL;
+			break;
+		case ACL_MASK:
+			/* Solaris sometimes sets additonal bits in the mask */
+			entry->e_perm &= S_IRWXO;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+cmp_acl_entry(const struct posix_acl_entry *a, const struct posix_acl_entry *b)
+{
+	if (a->e_tag != b->e_tag)
+		return a->e_tag - b->e_tag;
+	else if (a->e_id > b->e_id)
+		return 1;
+	else if (a->e_id < b->e_id)
+		return -1;
+	else
+		return 0;
+}
+
+/*
+ * Convert from a Solaris ACL to a POSIX 1003.1e draft 17 ACL.
+ */
+static int
+posix_acl_from_nfsacl(struct posix_acl *acl)
+{
+	struct posix_acl_entry *pa, *pe,
+	       *group_obj = NULL, *mask = NULL;
+
+	if (!acl)
+		return 0;
+
+	qsort(acl->a_entries, acl->a_count, sizeof(struct posix_acl_entry),
+	      (int(*)(const void *,const void *))cmp_acl_entry);
+
+	/* Clear undefined identifier fields and find the ACL_GROUP_OBJ
+	   and ACL_MASK entries. */
+	FOREACH_ACL_ENTRY(pa, acl, pe) {
+		switch(pa->e_tag) {
+			case ACL_USER_OBJ:
+				pa->e_id = ACL_UNDEFINED_ID;
+				break;
+			case ACL_GROUP_OBJ:
+				pa->e_id = ACL_UNDEFINED_ID;
+				group_obj = pa;
+				break;
+			case ACL_MASK:
+				mask = pa;
+				/* fall through */
+			case ACL_OTHER:
+				pa->e_id = ACL_UNDEFINED_ID;
+				break;
+		}
+	}
+	if (acl->a_count == 4 && group_obj && mask &&
+	    mask->e_perm == group_obj->e_perm) {
+		/* remove bogus ACL_MASK entry */
+		memmove(mask, mask+1, (3 - (mask - acl->a_entries)) *
+				      sizeof(struct posix_acl_entry));
+		acl->a_count = 3;
+	}
+	return 0;
+}
+
+unsigned int
+nfsacl_decode(struct xdr_buf *buf, unsigned int base, unsigned int *aclcnt,
+	      struct posix_acl **pacl)
+{
+	struct nfsacl_decode_desc nfsacl_desc = {
+		.desc = {
+			.elem_size = 12,
+			.xcode = pacl ? xdr_nfsace_decode : NULL,
+		},
+	};
+	u32 entries;
+	int err;
+
+	if (xdr_decode_word(buf, base, &entries) ||
+	    entries > NFS3_ACL_MAX_ENTRIES)
+		return -EINVAL;
+	err = xdr_decode_array2(buf, base + 4, &nfsacl_desc.desc);
+	if (err)
+		return err;
+	if (pacl) {
+		if (entries != nfsacl_desc.desc.array_len ||
+		    posix_acl_from_nfsacl(nfsacl_desc.acl) != 0) {
+			posix_acl_release(nfsacl_desc.acl);
+			return -EINVAL;
+		}
+		*pacl = nfsacl_desc.acl;
+	}
+	if (aclcnt)
+		*aclcnt = entries;
+	return 8 + nfsacl_desc.desc.elem_size *
+		   nfsacl_desc.desc.array_len;
+}
Index: linux-2.6.11-rc5/fs/nfsd/nfs3proc.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfsd/nfs3proc.c
+++ linux-2.6.11-rc5/fs/nfsd/nfs3proc.c
@@ -24,6 +24,7 @@
 #include <linux/nfsd/cache.h>
 #include <linux/nfsd/xdr3.h>
 #include <linux/nfs3.h>
+#include <linux/nfsacl.h>
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
@@ -630,6 +631,105 @@ nfsd3_proc_commit(struct svc_rqst * rqst
 	RETURN_STATUS(nfserr);
 }
 
+#ifdef CONFIG_NFSD_ACL
+/*
+ * Get the Access and/or Default ACL of a file.
+ */
+static int
+nfsd3_proc_getacl(struct svc_rqst * rqstp, struct nfsd3_getaclargs *argp,
+					   struct nfsd3_getaclres *resp)
+{
+	svc_fh *fh;
+	struct posix_acl *acl;
+	int nfserr = 0;
+
+	fh = fh_copy(&resp->fh, &argp->fh);
+	if ((nfserr = fh_verify(rqstp, &resp->fh, 0, MAY_NOP)))
+		RETURN_STATUS(nfserr_inval);
+
+	if (argp->mask & ~(NFS3_ACL|NFS3_ACLCNT|NFS3_DFACL|NFS3_DFACLCNT))
+		RETURN_STATUS(nfserr_inval);
+	resp->mask = argp->mask;
+
+	if (resp->mask & (NFS3_ACL|NFS3_ACLCNT)) {
+		acl = nfsd_get_posix_acl(fh, ACL_TYPE_ACCESS);
+		if (IS_ERR(acl)) {
+			int err = PTR_ERR(acl);
+
+			if (err == -ENODATA || err == -EOPNOTSUPP)
+				acl = NULL;
+			else {
+				nfserr = nfserrno(err);
+				goto fail;
+			}
+		}
+		if (acl == NULL) {
+			/* Solaris returns the inode's minimum ACL. */
+
+			struct inode *inode = fh->fh_dentry->d_inode;
+			acl = posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
+		}
+		resp->acl_access = acl;
+	}
+	if (resp->mask & (NFS3_DFACL|NFS3_DFACLCNT)) {
+		/* Check how Solaris handles requests for the Default ACL
+		   of a non-directory! */
+
+		acl = nfsd_get_posix_acl(fh, ACL_TYPE_DEFAULT);
+		if (IS_ERR(acl)) {
+			int err = PTR_ERR(acl);
+
+			if (err == -ENODATA || err == -EOPNOTSUPP)
+				acl = NULL;
+			else {
+				nfserr = nfserrno(err);
+				goto fail;
+			}
+		}
+		resp->acl_default = acl;
+	}
+
+	/* resp->acl_{access,default} are released in nfs3svc_release_getacl. */
+	RETURN_STATUS(0);
+
+fail:
+	posix_acl_release(resp->acl_access);
+	posix_acl_release(resp->acl_default);
+	RETURN_STATUS(nfserr);
+}
+#endif  /* CONFIG_NFSD_ACL */
+
+#ifdef CONFIG_NFSD_ACL
+/*
+ * Set the Access and/or Default ACL of a file.
+ */
+static int
+nfsd3_proc_setacl(struct svc_rqst * rqstp, struct nfsd3_setaclargs *argp,
+					   struct nfsd3_attrstat *resp)
+{
+	svc_fh *fh;
+	int nfserr = 0;
+
+	fh = fh_copy(&resp->fh, &argp->fh);
+	nfserr = fh_verify(rqstp, &resp->fh, 0, MAY_NOP);
+
+	if (!nfserr) {
+		nfserr = nfserrno( nfsd_set_posix_acl(
+			fh, ACL_TYPE_ACCESS, argp->acl_access) );
+	}
+	if (!nfserr) {
+		nfserr = nfserrno( nfsd_set_posix_acl(
+			fh, ACL_TYPE_DEFAULT, argp->acl_default) );
+	}
+
+	/* argp->acl_{access,default} may have been allocated in
+	   nfs3svc_decode_setaclargs. */
+	posix_acl_release(argp->acl_access);
+	posix_acl_release(argp->acl_default);
+	RETURN_STATUS(nfserr);
+}
+#endif  /* CONFIG_NFSD_ACL */
+
 
 /*
  * NFSv3 Server procedures.
@@ -647,6 +747,7 @@ nfsd3_proc_commit(struct svc_rqst * rqst
 #define nfsd3_attrstatres		nfsd3_attrstat
 #define nfsd3_wccstatres		nfsd3_attrstat
 #define nfsd3_createres			nfsd3_diropres
+#define nfsd3_setaclres			nfsd3_attrstat
 #define nfsd3_voidres			nfsd3_voidargs
 struct nfsd3_voidargs { int dummy; };
 
@@ -667,6 +768,7 @@ struct nfsd3_voidargs { int dummy; };
 #define AT 21		/* attributes */
 #define pAT (1+AT)	/* post attributes - conditional */
 #define WC (7+pAT)	/* WCC attributes */
+#define ACL (1+NFS3_ACL_MAX_ENTRIES*3)  /* Access Control List */
 
 static struct svc_procedure		nfsd_procedures3[22] = {
   PROC(null,	 void,		void,		void,	  RC_NOCACHE, ST),
@@ -700,3 +802,19 @@ struct svc_version	nfsd_version3 = {
 		.vs_dispatch	= nfsd_dispatch,
 		.vs_xdrsize	= NFS3_SVC_XDRSIZE,
 };
+
+#ifdef CONFIG_NFSD_ACL
+struct svc_procedure		nfsd_acl_procedures3[] = {
+  PROC(null,	void,		void,		void,	  RC_NOCACHE, ST),
+  PROC(getacl,	getacl,		getacl,		getacl,	  RC_NOCACHE, ST+1+2*(1+ACL)),
+  PROC(setacl,	setacl,		setacl,		fhandle,  RC_NOCACHE, ST+pAT),
+};
+
+struct svc_version	nfsd_acl_version3 = {
+		.vs_vers	= 3,
+		.vs_nproc	= 3,
+		.vs_proc	= nfsd_acl_procedures3,
+		.vs_dispatch	= nfsd_dispatch,
+		.vs_xdrsize	= NFS3_SVC_XDRSIZE,
+};
+#endif  /* CONFIG_NFSD_ACL */
Index: linux-2.6.11-rc5/fs/nfsd/nfs3xdr.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfsd/nfs3xdr.c
+++ linux-2.6.11-rc5/fs/nfsd/nfs3xdr.c
@@ -21,6 +21,7 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
 #include <linux/nfsd/xdr3.h>
+#include <linux/nfsacl.h>
 
 #define NFSDDBG_FACILITY		NFSDDBG_XDR
 
@@ -599,6 +600,47 @@ nfs3svc_decode_commitargs(struct svc_rqs
 	return xdr_argsize_check(rqstp, p);
 }
 
+#ifdef CONFIG_NFSD_ACL
+int
+nfs3svc_decode_getaclargs(struct svc_rqst *rqstp, u32 *p,
+			  struct nfsd3_getaclargs *args)
+{
+	if (!(p = decode_fh(p, &args->fh)))
+		return 0;
+	args->mask = ntohl(*p); p++;
+
+	return xdr_argsize_check(rqstp, p);
+}
+#endif  /* CONFIG_NFSD_ACL */
+
+#ifdef CONFIG_NFSD_ACL
+int
+nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, u32 *p,
+			  struct nfsd3_setaclargs *args)
+{
+	struct kvec *head = rqstp->rq_arg.head;
+	unsigned int base;
+	int n;
+
+	if (!(p = decode_fh(p, &args->fh)))
+		return 0;
+	args->mask = ntohl(*p++);
+	if (args->mask & ~(NFS3_ACL|NFS3_ACLCNT|NFS3_DFACL|NFS3_DFACLCNT) ||
+	    !xdr_argsize_check(rqstp, p))
+		return 0;
+
+	base = (char *)p - (char *)head->iov_base;
+	n = nfsacl_decode(&rqstp->rq_arg, base, NULL,
+			  (args->mask & NFS3_ACL) ?
+			  &args->acl_access : NULL);
+	if (n > 0)
+		n = nfsacl_decode(&rqstp->rq_arg, base + n, NULL,
+				  (args->mask & NFS3_DFACL) ?
+				  &args->acl_default : NULL);
+	return (n > 0);
+}
+#endif  /* CONFIG_NFSD_ACL */
+
 /*
  * XDR encode functions
  */
@@ -1082,6 +1124,66 @@ nfs3svc_encode_commitres(struct svc_rqst
 	return xdr_ressize_check(rqstp, p);
 }
 
+#ifdef CONFIG_NFSD_ACL
+/* GETACL */
+int
+nfs3svc_encode_getaclres(struct svc_rqst *rqstp, u32 *p,
+			 struct nfsd3_getaclres *resp)
+{
+	struct dentry *dentry = resp->fh.fh_dentry;
+
+	p = encode_post_op_attr(rqstp, p, &resp->fh);
+	if (resp->status == 0 && dentry && dentry->d_inode) {
+		struct inode *inode = dentry->d_inode;
+		int w = nfsacl_size(
+			(resp->mask & NFS3_ACL)   ? resp->acl_access  : NULL,
+			(resp->mask & NFS3_DFACL) ? resp->acl_default : NULL);
+		struct kvec *head = rqstp->rq_res.head;
+		unsigned int base;
+		int n;
+
+		*p++ = htonl(resp->mask);
+		if (!xdr_ressize_check(rqstp, p))
+			return 0;
+		base = (char *)p - (char *)head->iov_base;
+
+		rqstp->rq_res.page_len = w;
+		while (w > 0) {
+			if (!svc_take_res_page(rqstp))
+				return 0;
+			w -= PAGE_SIZE;
+		}
+
+		n = nfsacl_encode(&rqstp->rq_res, base, inode,
+				  resp->acl_access,
+				  resp->mask & NFS3_ACL, 0);
+		if (n > 0)
+			n = nfsacl_encode(&rqstp->rq_res, base + n, inode,
+					  resp->acl_default,
+					  resp->mask & NFS3_DFACL,
+					  NFS3_ACL_DEFAULT);
+		if (n <= 0)
+			return 0;
+	} else
+		if (!xdr_ressize_check(rqstp, p))
+			return 0;
+
+	return 1;
+}
+#endif  /* CONFIG_NFSD_ACL */
+
+#ifdef CONFIG_NFSD_ACL
+/* SETACL */
+int
+nfs3svc_encode_setaclres(struct svc_rqst *rqstp, u32 *p,
+			 struct nfsd3_attrstat *resp)
+{
+	p = encode_post_op_attr(rqstp, p, &resp->fh);
+
+	return xdr_ressize_check(rqstp, p);
+}
+#endif  /* CONFIG_NFSD_ACL */
+
 /*
  * XDR release functions
  */
@@ -1101,3 +1203,15 @@ nfs3svc_release_fhandle2(struct svc_rqst
 	fh_put(&resp->fh2);
 	return 1;
 }
+
+#ifdef CONFIG_NFSD_ACL
+int
+nfs3svc_release_getacl(struct svc_rqst *rqstp, u32 *p,
+		       struct nfsd3_getaclres *resp)
+{
+	fh_put(&resp->fh);
+	posix_acl_release(resp->acl_access);
+	posix_acl_release(resp->acl_default);
+	return 1;
+}
+#endif  /* CONFIG_NFSD_ACL */
Index: linux-2.6.11-rc5/fs/nfsd/nfssvc.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfsd/nfssvc.c
+++ linux-2.6.11-rc5/fs/nfsd/nfssvc.c
@@ -49,6 +49,9 @@
 #define	SIG_NOCLEAN	SIGHUP
 
 extern struct svc_program	nfsd_program;
+#ifdef CONFIG_NFSD_ACL
+extern struct svc_program	nfsd_acl_program;
+#endif
 static void			nfsd(struct svc_rqst *rqstp);
 struct timeval			nfssvc_boot;
 static struct svc_serv 		*nfsd_serv;
@@ -370,8 +373,29 @@ static struct svc_version *	nfsd_version
 #endif
 };
 
+#ifdef CONFIG_NFSD_ACL
+extern struct svc_version nfsd_acl_version3;
+
+static struct svc_version *	nfsd_acl_version[] = {
+	[3] = &nfsd_acl_version3,
+};
+
+#define NFSD_ACL_NRVERS		(sizeof(nfsd_acl_version)/sizeof(nfsd_acl_version[0]))
+struct svc_program		nfsd_acl_program = {
+	.pg_prog		= NFS3_ACL_PROGRAM,
+	.pg_nvers		= NFSD_ACL_NRVERS,
+	.pg_vers		= nfsd_acl_version,
+	.pg_name		= "nfsd",
+	.pg_stats		= &nfsd_acl_svcstats,
+};
+# define nfsd_acl_program_p &nfsd_acl_program
+#else
+# define nfsd_acl_program_p NULL
+#endif
+
 #define NFSD_NRVERS		(sizeof(nfsd_version)/sizeof(nfsd_version[0]))
 struct svc_program		nfsd_program = {
+	.pg_next		= nfsd_acl_program_p,
 	.pg_prog		= NFS_PROGRAM,		/* program number */
 	.pg_nvers		= NFSD_NRVERS,		/* nr of entries in nfsd_version */
 	.pg_vers		= nfsd_version,		/* version table */
Index: linux-2.6.11-rc5/fs/nfsd/stats.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfsd/stats.c
+++ linux-2.6.11-rc5/fs/nfsd/stats.c
@@ -40,6 +40,12 @@ struct svc_stat		nfsd_svcstats = {
 	.program	= &nfsd_program,
 };
 
+#ifdef CONFIG_NFSD_ACL
+struct svc_stat	nfsd_acl_svcstats = {
+	.program	= &nfsd_acl_program,
+};
+#endif
+
 static int nfsd_proc_show(struct seq_file *seq, void *v)
 {
 	int i;
Index: linux-2.6.11-rc5/fs/nfsd/vfs.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfsd/vfs.c
+++ linux-2.6.11-rc5/fs/nfsd/vfs.c
@@ -45,6 +45,7 @@
 #include <linux/nfsd/nfsfh.h>
 #include <linux/quotaops.h>
 #include <linux/dnotify.h>
+#include <linux/xattr_acl.h>
 #ifdef CONFIG_NFSD_V4
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
@@ -1810,3 +1811,109 @@ nfsd_racache_init(int cache_size)
 	nfsdstats.ra_size = cache_size;
 	return 0;
 }
+
+#ifdef CONFIG_NFSD_ACL
+struct posix_acl *
+nfsd_get_posix_acl(struct svc_fh *fhp, int type)
+{
+	struct inode *inode = fhp->fh_dentry->d_inode;
+	char *name;
+	void *value = NULL;
+	ssize_t size;
+	struct posix_acl *acl;
+
+	if (!IS_POSIXACL(inode) || !inode->i_op || !inode->i_op->getxattr)
+		return ERR_PTR(-EOPNOTSUPP);
+	switch(type) {
+		case ACL_TYPE_ACCESS:
+			name = XATTR_NAME_ACL_ACCESS;
+			break;
+		case ACL_TYPE_DEFAULT:
+			name = XATTR_NAME_ACL_DEFAULT;
+			break;
+		default:
+			return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	size = inode->i_op->getxattr(fhp->fh_dentry, name, NULL, 0);
+
+	if (size < 0) {
+		acl = ERR_PTR(size);
+		goto getout;
+	} else if (size > 0) {
+		value = kmalloc(size, GFP_KERNEL);
+		if (!value) {
+			acl = ERR_PTR(-ENOMEM);
+			goto getout;
+		}
+		size = inode->i_op->getxattr(fhp->fh_dentry, name, value, size);
+		if (size < 0) {
+			acl = ERR_PTR(size);
+			goto getout;
+		}
+	}
+	acl = posix_acl_from_xattr(value, size);
+
+getout:
+	kfree(value);
+	return acl;
+}
+#endif  /* CONFIG_NFSD_ACL */
+
+#ifdef CONFIG_NFSD_ACL
+int
+nfsd_set_posix_acl(struct svc_fh *fhp, int type, struct posix_acl *acl)
+{
+	struct inode *inode = fhp->fh_dentry->d_inode;
+	char *name;
+	void *value = NULL;
+	size_t size;
+	int error;
+
+	if (!IS_POSIXACL(inode) || !inode->i_op ||
+	    !inode->i_op->setxattr || !inode->i_op->removexattr)
+		return -EOPNOTSUPP;
+	switch(type) {
+		case ACL_TYPE_ACCESS:
+			name = XATTR_NAME_ACL_ACCESS;
+			break;
+		case ACL_TYPE_DEFAULT:
+			name = XATTR_NAME_ACL_DEFAULT;
+			break;
+		default:
+			return -EOPNOTSUPP;
+	}
+
+	if (acl && acl->a_count) {
+		size = xattr_acl_size(acl->a_count);
+		value = kmalloc(size, GFP_KERNEL);
+		if (!value)
+			return -ENOMEM;
+		size = posix_acl_to_xattr(acl, value, size);
+		if (size < 0) {
+			error = size;
+			goto getout;
+		}
+	} else
+		size = 0;
+
+	if (!fhp->fh_locked)
+		fh_lock(fhp);  /* unlocking is done automatically */
+	if (size)
+		error = inode->i_op->setxattr(fhp->fh_dentry, name,
+					      value, size, 0);
+	else {
+		if (!S_ISDIR(inode->i_mode) && type == ACL_TYPE_DEFAULT)
+			error = 0;
+		else {
+			error = inode->i_op->removexattr(fhp->fh_dentry, name);
+			if (error == -ENODATA)
+				error = 0;
+		}
+	}
+
+getout:
+	kfree(value);
+	return error;
+}
+#endif  /* CONFIG_NFSD_ACL */
Index: linux-2.6.11-rc5/include/linux/nfs3.h
===================================================================
--- linux-2.6.11-rc5.orig/include/linux/nfs3.h
+++ linux-2.6.11-rc5/include/linux/nfs3.h
@@ -37,6 +37,15 @@ enum nfs3_createmode {
 	NFS3_CREATE_EXCLUSIVE = 2
 };
 
+/* Flags for the getacl/setacl mode */
+#define NFS3_ACL		0x0001
+#define NFS3_ACLCNT		0x0002
+#define NFS3_DFACL		0x0004
+#define NFS3_DFACLCNT		0x0008
+
+/* Flag for Default ACL entries */
+#define NFS3_ACL_DEFAULT	0x1000
+
 /* NFSv3 file system properties */
 #define NFS3_FSF_LINK		0x0001
 #define NFS3_FSF_SYMLINK	0x0002
@@ -88,6 +97,10 @@ struct nfs3_fh {
 #define NFS3PROC_PATHCONF	20
 #define NFS3PROC_COMMIT		21
 
+#define NFS3_ACL_PROGRAM		100227
+#define NFS3PROC_GETACL		1
+#define NFS3PROC_SETACL		2
+
 #define NFS_MNT3_PROGRAM	100005
 #define NFS_MNT3_VERSION	3
 #define MOUNTPROC3_NULL		0
Index: linux-2.6.11-rc5/include/linux/nfsacl.h
===================================================================
--- /dev/null
+++ linux-2.6.11-rc5/include/linux/nfsacl.h
@@ -0,0 +1,37 @@
+/*
+ * File: linux/nfsacl.h
+ *
+ * (C) 2003 Andreas Gruenbacher <agruen@suse.de>
+ */
+
+
+#ifndef __LINUX_NFSACL_H
+#define __LINUX_NFSACL_H
+
+#include <linux/posix_acl.h>
+
+/* Maximum number of ACL entries over NFS */
+#define NFS3_ACL_MAX_ENTRIES	1024
+
+#define NFSACL_MAXWORDS		(2*(2+3*NFS3_ACL_MAX_ENTRIES))
+#define NFSACL_MAXPAGES		((2*(8+12*NFS3_ACL_MAX_ENTRIES) + PAGE_SIZE-1) \
+				 >> PAGE_SHIFT)
+
+static inline unsigned int
+nfsacl_size(struct posix_acl *acl_access, struct posix_acl *acl_default)
+{
+	unsigned int w = 16;
+	w += max(acl_access ? (int)acl_access->a_count : 3, 4) * 12;
+	if (acl_default)
+		w += max((int)acl_default->a_count, 4) * 12;
+	return w;
+}
+
+extern unsigned int
+nfsacl_encode(struct xdr_buf *buf, unsigned int base, struct inode *inode,
+	      struct posix_acl *acl, int encode_entries, int typeflag);
+extern unsigned int
+nfsacl_decode(struct xdr_buf *buf, unsigned int base, unsigned int *aclcnt,
+	      struct posix_acl **pacl);
+
+#endif  /* __LINUX_NFSACL_H */
Index: linux-2.6.11-rc5/include/linux/nfsd/nfsd.h
===================================================================
--- linux-2.6.11-rc5.orig/include/linux/nfsd/nfsd.h
+++ linux-2.6.11-rc5/include/linux/nfsd/nfsd.h
@@ -15,6 +15,7 @@
 #include <linux/unistd.h>
 #include <linux/dirent.h>
 #include <linux/fs.h>
+#include <linux/posix_acl.h>
 #include <linux/mount.h>
 
 #include <linux/nfsd/debug.h>
@@ -60,6 +61,8 @@ extern struct svc_program	nfsd_program;
 extern struct svc_version	nfsd_version2, nfsd_version3,
 				nfsd_version4;
 
+extern struct svc_program	nfsd_acl_program;
+extern struct svc_version	nfsd_acl_version3;
 /*
  * Function prototypes.
  */
@@ -124,6 +127,22 @@ int		nfsd_statfs(struct svc_rqst *, stru
 int		nfsd_notify_change(struct inode *, struct iattr *);
 int		nfsd_permission(struct svc_export *, struct dentry *, int);
 
+#ifdef CONFIG_NFSD_ACL
+struct posix_acl *nfsd_get_posix_acl(struct svc_fh *, int);
+int nfsd_set_posix_acl(struct svc_fh *, int, struct posix_acl *);
+#else
+static inline struct posix_acl *
+nfsd_get_posix_acl(struct svc_fh *fhp, int acl_type)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline int
+nfsd_set_posix_acl(struct svc_fh *fhp, int type, struct posix_acl *acl)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 
 /* 
  * NFSv4 State
Index: linux-2.6.11-rc5/include/linux/nfsd/stats.h
===================================================================
--- linux-2.6.11-rc5.orig/include/linux/nfsd/stats.h
+++ linux-2.6.11-rc5/include/linux/nfsd/stats.h
@@ -36,6 +36,7 @@ struct nfsd_stats {
 
 extern struct nfsd_stats	nfsdstats;
 extern struct svc_stat		nfsd_svcstats;
+extern struct svc_stat		nfsd_acl_svcstats;
 
 void	nfsd_stat_init(void);
 void	nfsd_stat_shutdown(void);
Index: linux-2.6.11-rc5/include/linux/nfsd/xdr3.h
===================================================================
--- linux-2.6.11-rc5.orig/include/linux/nfsd/xdr3.h
+++ linux-2.6.11-rc5/include/linux/nfsd/xdr3.h
@@ -10,6 +10,7 @@
 #define _LINUX_NFSD_XDR3_H
 
 #include <linux/nfsd/xdr.h>
+#include <linux/posix_acl.h>
 
 struct nfsd3_sattrargs {
 	struct svc_fh		fh;
@@ -110,6 +111,18 @@ struct nfsd3_commitargs {
 	__u32			count;
 };
 
+struct nfsd3_getaclargs {
+	struct svc_fh		fh;
+	int			mask;
+};
+
+struct nfsd3_setaclargs {
+	struct svc_fh		fh;
+	int			mask;
+	struct posix_acl	*acl_access;
+	struct posix_acl	*acl_default;
+};
+
 struct nfsd3_attrstat {
 	__u32			status;
 	struct svc_fh		fh;
@@ -209,6 +222,14 @@ struct nfsd3_commitres {
 	struct svc_fh		fh;
 };
 
+struct nfsd3_getaclres {
+	__u32			status;
+	struct svc_fh		fh;
+	int			mask;
+	struct posix_acl	*acl_access;
+	struct posix_acl	*acl_default;
+};
+
 /* dummy type for release */
 struct nfsd3_fhandle_pair {
 	__u32			dummy;
@@ -241,6 +262,7 @@ union nfsd3_xdrstore {
 	struct nfsd3_fsinfores		fsinfores;
 	struct nfsd3_pathconfres	pathconfres;
 	struct nfsd3_commitres		commitres;
+	struct nfsd3_getaclres		getaclres;
 };
 
 #define NFS3_SVC_XDRSIZE		sizeof(union nfsd3_xdrstore)
@@ -276,6 +298,10 @@ int nfs3svc_decode_readdirplusargs(struc
 				struct nfsd3_readdirargs *);
 int nfs3svc_decode_commitargs(struct svc_rqst *, u32 *,
 				struct nfsd3_commitargs *);
+int nfs3svc_decode_getaclargs(struct svc_rqst *, u32 *,
+			      struct nfsd3_getaclargs *);
+int nfs3svc_decode_setaclargs(struct svc_rqst *, u32 *,
+			      struct nfsd3_setaclargs *);
 int nfs3svc_encode_voidres(struct svc_rqst *, u32 *, void *);
 int nfs3svc_encode_attrstat(struct svc_rqst *, u32 *,
 				struct nfsd3_attrstat *);
@@ -305,11 +331,17 @@ int nfs3svc_encode_pathconfres(struct sv
 				struct nfsd3_pathconfres *);
 int nfs3svc_encode_commitres(struct svc_rqst *, u32 *,
 				struct nfsd3_commitres *);
+int nfs3svc_encode_getaclres(struct svc_rqst *, u32 *,
+			     struct nfsd3_getaclres *);
+int nfs3svc_encode_setaclres(struct svc_rqst *, u32 *,
+			     struct nfsd3_attrstat *);
 
 int nfs3svc_release_fhandle(struct svc_rqst *, u32 *,
 				struct nfsd3_attrstat *);
 int nfs3svc_release_fhandle2(struct svc_rqst *, u32 *,
 				struct nfsd3_fhandle_pair *);
+int nfs3svc_release_getacl(struct svc_rqst *rqstp, u32 *p,
+			   struct nfsd3_getaclres *resp);
 int nfs3svc_encode_entry(struct readdir_cd *, const char *name,
 				int namlen, loff_t offset, ino_t ino,
 				unsigned int);
Index: linux-2.6.11-rc5/include/linux/sunrpc/svc.h
===================================================================
--- linux-2.6.11-rc5.orig/include/linux/sunrpc/svc.h
+++ linux-2.6.11-rc5/include/linux/sunrpc/svc.h
@@ -185,6 +185,27 @@ xdr_ressize_check(struct svc_rqst *rqstp
 	return vec->iov_len <= PAGE_SIZE;
 }
 
+#if 0
+static inline struct page *
+svc_take_arg_page(struct svc_rqst *rqstp)
+{
+	if (rqstp->rq_arghi <= rqstp->rq_argused)
+		return NULL;
+	return rqstp->rq_argpages[rqstp->rq_argused++];
+}
+#endif
+
+static inline struct page *
+svc_take_res_page(struct svc_rqst *rqstp)
+{
+	if (rqstp->rq_arghi <= rqstp->rq_argused)
+		return NULL;
+	rqstp->rq_arghi--;
+	rqstp->rq_respages[rqstp->rq_resused] =
+		rqstp->rq_argpages[rqstp->rq_arghi];
+	return rqstp->rq_respages[rqstp->rq_resused++];
+}
+
 static inline int svc_take_page(struct svc_rqst *rqstp)
 {
 	if (rqstp->rq_arghi <= rqstp->rq_argused)

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

