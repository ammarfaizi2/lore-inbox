Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319322AbSHNUx5>; Wed, 14 Aug 2002 16:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319338AbSHNUxZ>; Wed, 14 Aug 2002 16:53:25 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:28120 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319322AbSHNUur>; Wed, 14 Aug 2002 16:50:47 -0400
Date: Wed, 14 Aug 2002 16:54:36 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 37/38: SERVER: giant patch importing NFSv4 server
 functionality
Message-ID: <Pine.SOL.4.44.0208141654110.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that all the hooks are in place, this large patch imports all
of the new code for the NFSv4 server.

This patch makes almost no changes to the existing nfsd codebase
(these have been taken care of by the preceding patches).

One aspect of the NFSv4 code deserves comment.  The most natural scheme
for processing a COMPOUND request would seem to be:
  1a. XDR decode phase, decode args of all operations
  2a. processing phase, process all operations
  3a. XDR encode phase, encode results of all operations

However, we use a scheme which works as follows:
  1b. XDR decode phase, decode args of all operations
  2b. For each operation,
        process the operation
        encode the result

To see what is wrong with the first scheme, consider a COMPOUND
of the form READ REMOVE.  Since the last bit of processing for
the READ request occurs in XDR encode, we might discover in step
3a that the READ request should return an error.  Therefore, the
REMOVE request should not be processed at all.  This is a fatal
problem, since the REMOVE was already been done in step 2a!

Another type of problem would occur in a COMPOUND of the form
READ WRITE.  Assume that both operations succeed.  Under scheme
(a), the WRITE is actually performed _before_ the READ (since
the "real" READ is really done during XDR encode).  This is
certainly incorrect if the READ and WRITE ranges overlap.

These examples might seem a little artificial, but nevertheless
it does seem that in order to process a COMPOUND correctly in
all cases, we need to use scheme (b) instead of scheme (a).

(To construct less artificial examples, just substitute GETATTR
 for READ in the examples above.  This works because the "real"
 GETATTR is done during XDR encode: one would really have to
 bend over backwards in order to arrange things otherwise.)

--- old/fs/nfsd/Makefile	Thu Aug  1 16:16:20 2002
+++ new/fs/nfsd/Makefile	Sun Aug 11 23:16:01 2002
@@ -7,6 +7,7 @@ obj-$(CONFIG_NFSD)	+= nfsd.o
 nfsd-y 			:= nfssvc.o nfsctl.o nfsproc.o nfsfh.o vfs.o \
 			   export.o auth.o lockd.o nfscache.o nfsxdr.o stats.o
 nfsd-$(CONFIG_NFSD_V3)	+= nfs3proc.o nfs3xdr.o
+nfsd-$(CONFIG_NFSD_V4)	+= nfs4proc.o nfs4xdr.o
 nfsd-objs		:= $(nfsd-y)

 include $(TOPDIR)/Rules.make
--- old/fs/nfsd/nfssvc.c	Sun Aug 11 23:15:15 2002
+++ new/fs/nfsd/nfssvc.c	Sun Aug 11 23:16:01 2002
@@ -338,10 +338,23 @@ static struct svc_version	nfsd_version3
 		.vs_dispatch	= nfsd_dispatch
 };
 #endif
+#ifdef CONFIG_NFSD_V4
+static struct svc_version	nfsd_version4 = {
+		.vs_vers	= 4,
+		.vs_nproc	= 2,
+		.vs_proc	= nfsd_procedures4,
+		.vs_dispatch	= nfsd_dispatch
+};
+#endif
 static struct svc_version *	nfsd_version[] = {
 	[2] = &nfsd_version2,
-#ifdef CONFIG_NFSD_V3
+#if defined(CONFIG_NFSD_V3)
 	[3] = &nfsd_version3,
+#elif defined(CONFIG_NFSD_V4)
+	[3] = NULL,
+#endif
+#if defined(CONFIG_NFSD_V4)
+	[4] = &nfsd_version4,
 #endif
 };

--- old/include/linux/nfsd/nfsd.h	Sun Aug 11 23:10:33 2002
+++ new/include/linux/nfsd/nfsd.h	Sun Aug 11 23:16:01 2002
@@ -26,6 +26,7 @@
  * nfsd version
  */
 #define NFSD_VERSION		"0.5"
+#define NFSD_SUPPORTED_MINOR_VERSION	0

 #ifdef __KERNEL__
 /*
@@ -69,6 +70,9 @@ extern struct svc_procedure	nfsd_procedu
 #ifdef CONFIG_NFSD_V3
 extern struct svc_procedure	nfsd_procedures3[];
 #endif /* CONFIG_NFSD_V3 */
+#ifdef CONFIG_NFSD_V4
+extern struct svc_procedure	nfsd_procedures4[];
+#endif /* CONFIG_NFSD_V4 */
 extern struct svc_program	nfsd_program;

 /*
@@ -197,6 +201,73 @@ void		nfsd_lockd_unexport(struct svc_cli
  */
 extern struct timeval	nfssvc_boot;

+
+#ifdef CONFIG_NFSD_V4
+
+/* before processing a COMPOUND operation, we have to check that there
+ * is enough space in the buffer for XDR encode to succeed.  otherwise,
+ * we might process an operation with side effects, and be unable to
+ * tell the client that the operation succeeded.
+ *
+ * COMPOUND_SLACK_SPACE - this is the minimum amount of buffer space
+ * needed to encode an "ordinary" _successful_ operation.  (GETATTR,
+ * READ, READDIR, and READLINK have their own buffer checks.)  if we
+ * fall below this level, we fail the next operation with NFS4ERR_RESOURCE.
+ *
+ * COMPOUND_ERR_SLACK_SPACE - this is the minimum amount of buffer space
+ * needed to encode an operation which has failed with NFS4ERR_RESOURCE.
+ * care is taken to ensure that we never fall below this level for any
+ * reason.
+ */
+#define	COMPOUND_SLACK_SPACE		140    /* OP_GETFH */
+#define COMPOUND_ERR_SLACK_SPACE	12     /* OP_SETATTR */
+
+#define NFSD_LEASE_TIME			60  /* seconds */
+
+/*
+ * The following attributes are currently not supported by the NFSv4 server:
+ *    ACL           (will be supported in a forthcoming patch)
+ *    ARCHIVE       (deprecated anyway)
+ *    FS_LOCATIONS  (will be supported eventually)
+ *    HIDDEN        (unlikely to be supported any time soon)
+ *    MIMETYPE      (unlikely to be supported any time soon)
+ *    QUOTA_*       (will be supported in a forthcoming patch)
+ *    SYSTEM        (unlikely to be supported any time soon)
+ *    TIME_BACKUP   (unlikely to be supported any time soon)
+ *    TIME_CREATE   (unlikely to be supported any time soon)
+ */
+#define NFSD_SUPPORTED_ATTRS_WORD0                                                          \
+(FATTR4_WORD0_SUPPORTED_ATTRS   | FATTR4_WORD0_TYPE         | FATTR4_WORD0_FH_EXPIRE_TYPE   \
+ | FATTR4_WORD0_CHANGE          | FATTR4_WORD0_SIZE         | FATTR4_WORD0_LINK_SUPPORT     \
+ | FATTR4_WORD0_SYMLINK_SUPPORT | FATTR4_WORD0_NAMED_ATTR   | FATTR4_WORD0_FSID             \
+ | FATTR4_WORD0_UNIQUE_HANDLES  | FATTR4_WORD0_LEASE_TIME   | FATTR4_WORD0_RDATTR_ERROR     \
+ | FATTR4_WORD0_ACLSUPPORT      | FATTR4_WORD0_CANSETTIME   | FATTR4_WORD0_CASE_INSENSITIVE \
+ | FATTR4_WORD0_CASE_PRESERVING | FATTR4_WORD0_CHOWN_RESTRICTED                             \
+ | FATTR4_WORD0_FILEHANDLE      | FATTR4_WORD0_FILEID       | FATTR4_WORD0_FILES_AVAIL      \
+ | FATTR4_WORD0_FILES_FREE      | FATTR4_WORD0_FILES_TOTAL  | FATTR4_WORD0_HOMOGENEOUS      \
+ | FATTR4_WORD0_MAXFILESIZE     | FATTR4_WORD0_MAXLINK      | FATTR4_WORD0_MAXNAME          \
+ | FATTR4_WORD0_MAXREAD         | FATTR4_WORD0_MAXWRITE)
+
+#define NFSD_SUPPORTED_ATTRS_WORD1                                                          \
+(FATTR4_WORD1_MODE              | FATTR4_WORD1_NO_TRUNC     | FATTR4_WORD1_NUMLINKS         \
+ | FATTR4_WORD1_OWNER	        | FATTR4_WORD1_OWNER_GROUP  | FATTR4_WORD1_RAWDEV           \
+ | FATTR4_WORD1_SPACE_AVAIL     | FATTR4_WORD1_SPACE_FREE   | FATTR4_WORD1_SPACE_TOTAL      \
+ | FATTR4_WORD1_SPACE_USED      | FATTR4_WORD1_TIME_ACCESS  | FATTR4_WORD1_TIME_ACCESS_SET  \
+ | FATTR4_WORD1_TIME_CREATE     | FATTR4_WORD1_TIME_DELTA   | FATTR4_WORD1_TIME_METADATA    \
+ | FATTR4_WORD1_TIME_MODIFY     | FATTR4_WORD1_TIME_MODIFY_SET)
+
+/* These will return ERR_INVAL if specified in GETATTR or READDIR. */
+#define NFSD_WRITEONLY_ATTRS_WORD1							    \
+(FATTR4_WORD1_TIME_ACCESS_SET   | FATTR4_WORD1_TIME_MODIFY_SET)
+
+/* These are the only attrs allowed in CREATE/OPEN/SETATTR. */
+#define NFSD_WRITEABLE_ATTRS_WORD0                            FATTR4_WORD0_SIZE
+#define NFSD_WRITEABLE_ATTRS_WORD1                                                          \
+(FATTR4_WORD1_MODE              | FATTR4_WORD1_OWNER         | FATTR4_WORD1_OWNER_GROUP     \
+ | FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY_SET)
+
+#endif /* CONFIG_NFSD_V4 */
+
 #endif /* __KERNEL__ */

 #endif /* LINUX_NFSD_NFSD_H */
--- old/fs/nfsd/nfs4proc.c	Wed Dec 31 18:00:00 1969
+++ new/fs/nfsd/nfs4proc.c	Sun Aug 11 23:16:40 2002
@@ -0,0 +1,744 @@
+/*
+ *  fs/nfsd/nfs4proc.c
+ *
+ *  Server-side procedures for NFSv4.
+ *
+ *  Copyright (c) 2002 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Kendrick Smith <kmsmith@umich.edu>
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
+ * Note: some routines in this file are just trivial wrappers
+ * (e.g. nfsd4_lookup()) defined solely for the sake of consistent
+ * naming.  Since all such routines have been declared "inline",
+ * there shouldn't be any associated overhead.  At some point in
+ * the future, I might inline these "by hand" to clean up a
+ * little.
+ */
+
+#include <linux/param.h>
+#include <linux/major.h>
+#include <linux/slab.h>
+
+#include <linux/sunrpc/svc.h>
+#include <linux/nfsd/nfsd.h>
+#include <linux/nfsd/cache.h>
+#include <linux/nfs4.h>
+#include <linux/nfsd/xdr4.h>
+
+#define NFSDDBG_FACILITY		NFSDDBG_PROC
+
+static inline int
+nfsd4_close(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_close *close)
+{
+	return nfs_ok;
+}
+
+/* Note: The organization of the OPEN code seems a little strange; it
+ * has been superfluously split into three routines, one of which is named
+ * nfsd4_process_open2() even though there is no nfsd4_process_open1()!
+ * This is because the code has been organized in anticipation of a
+ * subsequent patch which will implement more of the NFSv4 state model.
+ */
+static int
+do_open_lookup(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
+{
+	struct svc_fh resfh;
+	int accmode, status;
+
+	fh_init(&resfh, NFS4_FHSIZE);
+	open->op_truncate = 0;
+
+	if (open->op_create) {
+		/*
+		 * Note: create modes (UNCHECKED,GUARDED...) are the same
+		 * in NFSv4 as in v3.
+		 */
+		status = nfsd_create_v3(rqstp, current_fh, open->op_name,
+					open->op_namelen, &open->op_iattr,
+					&resfh, open->op_createmode,
+					(u32 *)open->op_verf, &open->op_truncate);
+	}
+	else {
+		status = nfsd_lookup(rqstp, current_fh,
+				     open->op_name, open->op_namelen, &resfh);
+		fh_unlock(current_fh);
+	}
+
+	if (!status) {
+		set_change_info(&open->op_cinfo, current_fh);
+		fh_dup2(current_fh, &resfh);
+
+		accmode = MAY_NOP;
+		if (open->op_share_access & NFS4_SHARE_ACCESS_READ)
+			accmode = MAY_READ;
+		if (open->op_share_deny & NFS4_SHARE_ACCESS_WRITE)
+			accmode |= (MAY_WRITE | MAY_TRUNC);
+		status = fh_verify(rqstp, current_fh, S_IFREG, accmode);
+	}
+
+	fh_put(&resfh);
+	return status;
+}
+
+static int
+nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
+{
+	struct iattr iattr;
+	int status;
+
+	if (open->op_truncate) {
+		iattr.ia_valid = ATTR_SIZE;
+		iattr.ia_size = 0;
+		status = nfsd_setattr(rqstp, current_fh, &iattr, 0, (time_t)0);
+		if (status)
+			return status;
+	}
+
+	memset(&open->op_stateid, 0xff, sizeof(stateid_t));
+	open->op_delegate_type = NFS4_OPEN_DELEGATE_NONE;
+	return 0;
+}
+
+static inline int
+nfsd4_open(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
+{
+	int status;
+
+	/* This check required by spec. */
+	if (open->op_create && open->op_claim_type != NFS4_OPEN_CLAIM_NULL)
+		return nfserr_inval;
+
+	/*
+	 * For now, we have no state, so we may as well implement an
+	 * even stronger check...
+	 */
+	if (open->op_claim_type != NFS4_OPEN_CLAIM_NULL)
+		return nfserr_notsupp;
+
+	/*
+	 * This block of code will (1) set CURRENT_FH to the file being opened,
+	 * creating it if necessary, (2) set open->op_cinfo, (3) set open->op_truncate
+	 * if the file is to be truncated after opening, (4) do permission checking.
+	 */
+	status = do_open_lookup(rqstp, current_fh, open);
+	if (status)
+		return status;
+
+	/*
+	 * nfsd4_process_open2() does the actual opening of the file.  If
+	 * successful, it (1) truncates the file if open->op_truncate was
+	 * set, (2) sets open->op_stateid, (3) sets open->op_delegation.
+	 */
+	status = nfsd4_process_open2(rqstp, current_fh, open);
+	if (status)
+		return status;
+
+	/*
+	 * To finish the open response, we just need to set the rflags.
+	 */
+	open->op_rflags = 0;
+	return 0;
+}
+
+static inline int
+nfsd4_renew(clientid_t *clientid)
+{
+	return nfs_ok;
+}
+
+static inline int
+nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_setclientid *setclientid)
+{
+	memset(&setclientid->se_clientid, 0, sizeof(clientid_t));
+	return nfs_ok;
+}
+
+static inline int
+nfsd4_setclientid_confirm(struct svc_rqst *rqstp, clientid_t *clientid)
+{
+	return nfs_ok;
+}
+
+/*
+ * filehandle-manipulating ops.
+ */
+static inline int
+nfsd4_getfh(struct svc_fh *current_fh, struct svc_fh **getfh)
+{
+	if (!current_fh->fh_dentry)
+		return nfserr_nofilehandle;
+
+	*getfh = current_fh;
+	return nfs_ok;
+}
+
+static inline int
+nfsd4_putfh(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_putfh *putfh)
+{
+	fh_put(current_fh);
+	current_fh->fh_handle.fh_size = putfh->pf_fhlen;
+	memcpy(&current_fh->fh_handle.fh_base, putfh->pf_fhval, putfh->pf_fhlen);
+	return fh_verify(rqstp, current_fh, 0, MAY_NOP);
+}
+
+static inline int
+nfsd4_putrootfh(struct svc_rqst *rqstp, struct svc_fh *current_fh)
+{
+	fh_put(current_fh);
+	return exp_pseudoroot(rqstp->rq_client, current_fh);
+}
+
+static inline int
+nfsd4_restorefh(struct svc_fh *current_fh, struct svc_fh *save_fh)
+{
+	if (!save_fh->fh_dentry)
+		return nfserr_nofilehandle;
+
+	fh_dup2(current_fh, save_fh);
+	return nfs_ok;
+}
+
+static inline int
+nfsd4_savefh(struct svc_fh *current_fh, struct svc_fh *save_fh)
+{
+	if (!current_fh->fh_dentry)
+		return nfserr_nofilehandle;
+
+	fh_dup2(save_fh, current_fh);
+	return nfs_ok;
+}
+
+/*
+ * misc nfsv4 ops
+ */
+static inline int
+nfsd4_access(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_access *access)
+{
+	if (access->ac_req_access & ~NFS3_ACCESS_FULL)
+		return nfserr_inval;
+
+	access->ac_resp_access = access->ac_req_access;
+	return nfsd_access(rqstp, current_fh, &access->ac_resp_access, &access->ac_supported);
+}
+
+static inline int
+nfsd4_commit(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_commit *commit)
+{
+	u32 *p = (u32 *)commit->co_verf;
+	*p++ = nfssvc_boot.tv_sec;
+	*p++ = nfssvc_boot.tv_usec;
+
+	return nfsd_commit(rqstp, current_fh, commit->co_offset, commit->co_count);
+}
+
+static inline int
+nfsd4_create(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_create *create)
+{
+	struct svc_fh resfh;
+	int status;
+
+	fh_init(&resfh, NFS4_FHSIZE);
+
+	status = fh_verify(rqstp, current_fh, S_IFDIR, MAY_CREATE);
+	if (status)
+		return status;
+
+	switch (create->cr_type) {
+	case NF4LNK:
+		/* ugh! we have to null-terminate the linktext, or
+		 * vfs_symlink() will choke.  it is always safe to
+		 * null-terminate by brute force, since at worst we
+		 * will overwrite the first byte of the create namelen
+		 * in the XDR buffer, which has already been extracted
+		 * during XDR decode.
+		 */
+		create->cr_linkname[create->cr_linklen] = 0;
+
+		status = nfsd_symlink(rqstp, current_fh, create->cr_name,
+				      create->cr_namelen, create->cr_linkname,
+				      create->cr_linklen, &resfh, &create->cr_iattr);
+		break;
+
+	case NF4BLK:
+		if (create->cr_specdata1 >= MAX_BLKDEV || create->cr_specdata2 > 0xFF)
+			return nfserr_inval;
+		status = nfsd_create(rqstp, current_fh, create->cr_name,
+				     create->cr_namelen, &create->cr_iattr, S_IFBLK,
+				     MKDEV(create->cr_specdata1, create->cr_specdata2),
+				     &resfh);
+		break;
+
+	case NF4CHR:
+		if (create->cr_specdata1 >= MAX_CHRDEV || create->cr_specdata2 > 0xFF)
+			return nfserr_inval;
+		status = nfsd_create(rqstp, current_fh, create->cr_name,
+				     create->cr_namelen, &create->cr_iattr, S_IFCHR,
+				     MKDEV(create->cr_specdata1, create->cr_specdata2),
+				     &resfh);
+		break;
+
+	case NF4SOCK:
+		status = nfsd_create(rqstp, current_fh, create->cr_name,
+				     create->cr_namelen, &create->cr_iattr,
+				     S_IFSOCK, 0, &resfh);
+		break;
+
+	case NF4FIFO:
+		status = nfsd_create(rqstp, current_fh, create->cr_name,
+				     create->cr_namelen, &create->cr_iattr,
+				     S_IFIFO, 0, &resfh);
+		break;
+
+	case NF4DIR:
+		create->cr_iattr.ia_valid &= ~ATTR_SIZE;
+		status = nfsd_create(rqstp, current_fh, create->cr_name,
+				     create->cr_namelen, &create->cr_iattr,
+				     S_IFDIR, 0, &resfh);
+		break;
+
+	default:
+		BUG();
+	}
+
+	if (!status) {
+		fh_unlock(current_fh);
+		set_change_info(&create->cr_cinfo, current_fh);
+		fh_dup2(current_fh, &resfh);
+	}
+
+	fh_put(&resfh);
+	return status;
+}
+
+static inline int
+nfsd4_getattr(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_getattr *getattr)
+{
+	int status;
+
+	status = fh_verify(rqstp, current_fh, 0, MAY_NOP);
+	if (status)
+		return status;
+
+	if (getattr->ga_bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1)
+		return nfserr_inval;
+
+	getattr->ga_bmval[0] &= NFSD_SUPPORTED_ATTRS_WORD0;
+	getattr->ga_bmval[1] &= NFSD_SUPPORTED_ATTRS_WORD1;
+
+	getattr->ga_fhp = current_fh;
+	return nfs_ok;
+}
+
+static inline int
+nfsd4_link(struct svc_rqst *rqstp, struct svc_fh *current_fh,
+	   struct svc_fh *save_fh, struct nfsd4_link *link)
+{
+	int status;
+
+	status = nfsd_link(rqstp, current_fh, link->li_name, link->li_namelen, save_fh);
+	if (!status)
+		set_change_info(&link->li_cinfo, current_fh);
+	return status;
+}
+
+static inline int
+nfsd4_lookupp(struct svc_rqst *rqstp, struct svc_fh *current_fh)
+{
+	/*
+	 * XXX: We currently violate the spec in one small respect
+	 * here.  If LOOKUPP is done at the root of the pseudofs,
+	 * the spec requires us to return NFSERR_NOENT.  Personally,
+	 * I think that leaving the filehandle unchanged is more
+	 * logical, but this is an academic question anyway, since
+	 * no clients actually use LOOKUPP.
+	 */
+	return nfsd_lookup(rqstp, current_fh, "..", 2, current_fh);
+}
+
+static inline int
+nfsd4_lookup(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_lookup *lookup)
+{
+	return nfsd_lookup(rqstp, current_fh, lookup->lo_name, lookup->lo_len, current_fh);
+}
+
+static inline int
+nfsd4_read(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_read *read)
+{
+	/* no need to check permission - this will be done in nfsd_read() */
+
+	if (read->rd_offset >= OFFSET_MAX)
+		return nfserr_inval;
+
+	read->rd_rqstp = rqstp;
+	read->rd_fhp = current_fh;
+	return nfs_ok;
+}
+
+static inline int
+nfsd4_readdir(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_readdir *readdir)
+{
+	/* no need to check permission - this will be done in nfsd_readdir() */
+
+	if (readdir->rd_bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1)
+		return nfserr_inval;
+
+	readdir->rd_bmval[0] &= NFSD_SUPPORTED_ATTRS_WORD0;
+	readdir->rd_bmval[1] &= NFSD_SUPPORTED_ATTRS_WORD1;
+
+	if (readdir->rd_cookie > ~(u32)0)
+		return nfserr_bad_cookie;
+
+	readdir->rd_rqstp = rqstp;
+	readdir->rd_fhp = current_fh;
+	return nfs_ok;
+}
+
+static inline int
+nfsd4_readlink(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_readlink *readlink)
+{
+	readlink->rl_rqstp = rqstp;
+	readlink->rl_fhp = current_fh;
+	return nfs_ok;
+}
+
+static inline int
+nfsd4_remove(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_remove *remove)
+{
+	int status;
+
+	status = nfsd_unlink(rqstp, current_fh, 0, remove->rm_name, remove->rm_namelen);
+	if (!status) {
+		fh_unlock(current_fh);
+		set_change_info(&remove->rm_cinfo, current_fh);
+	}
+	return status;
+}
+
+static inline int
+nfsd4_rename(struct svc_rqst *rqstp, struct svc_fh *current_fh,
+	     struct svc_fh *save_fh, struct nfsd4_rename *rename)
+{
+	int status;
+
+	status = nfsd_rename(rqstp, save_fh, rename->rn_sname,
+			     rename->rn_snamelen, current_fh,
+			     rename->rn_tname, rename->rn_tnamelen);
+	if (!status) {
+		set_change_info(&rename->rn_sinfo, current_fh);
+		set_change_info(&rename->rn_tinfo, save_fh);
+	}
+	return status;
+}
+
+static inline int
+nfsd4_setattr(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_setattr *setattr)
+{
+	return nfsd_setattr(rqstp, current_fh, &setattr->sa_iattr, 0, (time_t)0);
+}
+
+static inline int
+nfsd4_write(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_write *write)
+{
+	u32 *p;
+
+	/* no need to check permission - this will be done in nfsd_write() */
+
+	if (write->wr_offset >= OFFSET_MAX)
+		return nfserr_inval;
+
+	write->wr_bytes_written = write->wr_buflen;
+	write->wr_how_written = write->wr_stable_how;
+	p = (u32 *)write->wr_verifier;
+	*p++ = nfssvc_boot.tv_sec;
+	*p++ = nfssvc_boot.tv_usec;
+
+	return nfsd_write(rqstp, current_fh, write->wr_offset,
+			  write->wr_buf, write->wr_buflen, &write->wr_how_written);
+}
+
+/* This routine never returns NFS_OK!  If there are no other errors, it
+ * will return NFSERR_SAME or NFSERR_NOT_SAME depending on whether the
+ * attributes matched.  VERIFY is implemented by mapping NFSERR_SAME
+ * to NFS_OK after the call; NVERIFY by mapping NFSERR_NOT_SAME to NFS_OK.
+ */
+static int
+nfsd4_verify(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_verify *verify)
+{
+	u32 *buf, *p;
+	int count;
+	int status;
+
+	status = fh_verify(rqstp, current_fh, 0, MAY_NOP);
+	if (status)
+		return status;
+
+	if ((verify->ve_bmval[0] & ~NFSD_SUPPORTED_ATTRS_WORD0)
+	    || (verify->ve_bmval[1] & ~NFSD_SUPPORTED_ATTRS_WORD1))
+		return nfserr_notsupp;
+	if (verify->ve_bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1)
+		return nfserr_inval;
+	if (verify->ve_attrlen & 3)
+		return nfserr_inval;
+
+	/* count in words:
+	 *   bitmap_len(1) + bitmap(2) + attr_len(1) = 4
+	 */
+	count = 4 + (verify->ve_attrlen >> 2);
+	buf = kmalloc(count << 2, GFP_KERNEL);
+	if (!buf)
+		return nfserr_resource;
+
+	status = nfsd4_encode_fattr(current_fh, current_fh->fh_export,
+				    current_fh->fh_dentry, buf,
+				    &count, verify->ve_bmval);
+
+	/* this means that nfsd4_encode_fattr() ran out of space */
+	if (status == nfserr_resource && count == 0)
+		status = nfserr_not_same;
+	if (status)
+		goto out_kfree;
+
+	p = buf + 3;
+	status = nfserr_not_same;
+	if (ntohl(*p++) != verify->ve_attrlen)
+		goto out_kfree;
+	if (!memcmp(p, verify->ve_attrval, verify->ve_attrlen))
+		status = nfserr_same;
+
+out_kfree:
+	kfree(buf);
+	return status;
+}
+
+/*
+ * NULL call.
+ */
+static int
+nfsd4_proc_null(struct svc_rqst *rqstp, void *argp, void *resp)
+{
+	return nfs_ok;
+}
+
+
+/*
+ * COMPOUND call.
+ */
+static int
+nfsd4_proc_compound(struct svc_rqst *rqstp,
+		    struct nfsd4_compoundargs *args,
+		    struct nfsd4_compoundres *resp)
+{
+	struct nfsd4_op	*op;
+	struct svc_fh	current_fh;
+	struct svc_fh	save_fh;
+	int		slack_space;    /* in words, not bytes! */
+	int		status;
+
+	fh_init(&current_fh, NFS4_FHSIZE);
+	fh_init(&save_fh, NFS4_FHSIZE);
+
+	resp->p = rqstp->rq_resbuf.buf + 3 + XDR_QUADLEN(args->taglen);
+	resp->end = rqstp->rq_resbuf.base + rqstp->rq_resbuf.buflen;
+	resp->taglen = args->taglen;
+	resp->tag = args->tag;
+	resp->opcnt = 0;
+
+	/*
+	 * According to RFC3010, this takes precedence over all other errors.
+	 */
+	status = nfserr_minor_vers_mismatch;
+	if (args->minorversion > NFSD_SUPPORTED_MINOR_VERSION)
+		goto out;
+
+	status = nfs_ok;
+	while (!status && resp->opcnt < args->opcnt) {
+		op = &args->ops[resp->opcnt++];
+
+		/*
+		 * The XDR decode routines may have pre-set op->status;
+		 * for example, if there is a miscellaneous XDR error
+		 * it will be set to nfserr_bad_xdr.
+		 */
+		if (op->status)
+			goto encode_op;
+
+		/* We must be able to encode a successful response to
+		 * this operation, with enough room left over to encode a
+		 * failed response to the next operation.  If we don't
+		 * have enough room, fail with ERR_RESOURCE.
+		 */
+		slack_space = (char *)resp->end - (char *)resp->p;
+		if (slack_space < COMPOUND_SLACK_SPACE + COMPOUND_ERR_SLACK_SPACE) {
+			BUG_ON(slack_space < COMPOUND_ERR_SLACK_SPACE);
+			op->status = nfserr_resource;
+			goto encode_op;
+		}
+
+		switch (op->opnum) {
+		case OP_ACCESS:
+			op->status = nfsd4_access(rqstp, &current_fh, &op->u.access);
+			break;
+		case OP_CLOSE:
+			op->status = nfsd4_close(rqstp, &current_fh, &op->u.close);
+			break;
+		case OP_COMMIT:
+			op->status = nfsd4_commit(rqstp, &current_fh, &op->u.commit);
+			break;
+		case OP_CREATE:
+			op->status = nfsd4_create(rqstp, &current_fh, &op->u.create);
+			break;
+		case OP_GETATTR:
+			op->status = nfsd4_getattr(rqstp, &current_fh, &op->u.getattr);
+			break;
+		case OP_GETFH:
+			op->status = nfsd4_getfh(&current_fh, &op->u.getfh);
+			break;
+		case OP_LINK:
+			op->status = nfsd4_link(rqstp, &current_fh, &save_fh, &op->u.link);
+			break;
+		case OP_LOOKUP:
+			op->status = nfsd4_lookup(rqstp, &current_fh, &op->u.lookup);
+			break;
+		case OP_LOOKUPP:
+			op->status = nfsd4_lookupp(rqstp, &current_fh);
+			break;
+		case OP_NVERIFY:
+			op->status = nfsd4_verify(rqstp, &current_fh, &op->u.nverify);
+			if (op->status == nfserr_not_same)
+				op->status = nfs_ok;
+			break;
+		case OP_OPEN:
+			op->status = nfsd4_open(rqstp, &current_fh, &op->u.open);
+			break;
+		case OP_PUTFH:
+			op->status = nfsd4_putfh(rqstp, &current_fh, &op->u.putfh);
+			break;
+		case OP_PUTROOTFH:
+			op->status = nfsd4_putrootfh(rqstp, &current_fh);
+			break;
+		case OP_READ:
+			op->status = nfsd4_read(rqstp, &current_fh, &op->u.read);
+			break;
+		case OP_READDIR:
+			op->status = nfsd4_readdir(rqstp, &current_fh, &op->u.readdir);
+			break;
+		case OP_READLINK:
+			op->status = nfsd4_readlink(rqstp, &current_fh, &op->u.readlink);
+			break;
+		case OP_REMOVE:
+			op->status = nfsd4_remove(rqstp, &current_fh, &op->u.remove);
+			break;
+		case OP_RENAME:
+			op->status = nfsd4_rename(rqstp, &current_fh, &save_fh, &op->u.rename);
+			break;
+		case OP_RENEW:
+			op->status = nfsd4_renew(&op->u.renew);
+			break;
+		case OP_RESTOREFH:
+			op->status = nfsd4_restorefh(&current_fh, &save_fh);
+			break;
+		case OP_SAVEFH:
+			op->status = nfsd4_savefh(&current_fh, &save_fh);
+			break;
+		case OP_SETATTR:
+			op->status = nfsd4_setattr(rqstp, &current_fh, &op->u.setattr);
+			break;
+		case OP_SETCLIENTID:
+			op->status = nfsd4_setclientid(rqstp, &op->u.setclientid);
+			break;
+		case OP_SETCLIENTID_CONFIRM:
+			op->status = nfsd4_setclientid_confirm(rqstp, &op->u.setclientid_confirm);
+			break;
+		case OP_VERIFY:
+			op->status = nfsd4_verify(rqstp, &current_fh, &op->u.verify);
+			if (op->status == nfserr_same)
+				op->status = nfs_ok;
+			break;
+		case OP_WRITE:
+			op->status = nfsd4_write(rqstp, &current_fh, &op->u.write);
+			break;
+		default:
+			BUG_ON(op->status == nfs_ok);
+			break;
+		}
+
+encode_op:
+		nfsd4_encode_operation(resp, op);
+		status = op->status;
+	}
+
+out:
+	if (args->ops != args->iops) {
+		kfree(args->ops);
+		args->ops = args->iops;
+	}
+	fh_put(&current_fh);
+	fh_put(&save_fh);
+	return status;
+}
+
+#define nfs4svc_decode_voidargs		NULL
+#define nfs4svc_release_void		NULL
+#define nfsd4_voidres			nfsd4_voidargs
+#define nfs4svc_release_compound	NULL
+struct nfsd4_voidargs { int dummy; };
+
+#define PROC(name, argt, rest, relt, cache, respsize)	\
+ { (svc_procfunc) nfsd4_proc_##name,		\
+   (kxdrproc_t) nfs4svc_decode_##argt##args,	\
+   (kxdrproc_t) nfs4svc_encode_##rest##res,	\
+   (kxdrproc_t) nfs4svc_release_##relt,		\
+   sizeof(struct nfsd4_##argt##args),		\
+   sizeof(struct nfsd4_##rest##res),		\
+   0,						\
+   cache,					\
+   respsize,					\
+ }
+
+/*
+ * TODO: At the present time, the NFSv4 server does not do XID caching
+ * of requests.  Implementing XID caching would not be a serious problem,
+ * although it would require a mild change in interfaces since one
+ * doesn't know whether an NFSv4 request is idempotent until after the
+ * XDR decode.  However, XID caching totally confuses pynfs (Peter
+ * Astrand's regression testsuite for NFSv4 servers), which reuses
+ * XID's liberally, so I've left it unimplemented until pynfs generates
+ * better XID's.
+ */
+struct svc_procedure		nfsd_procedures4[2] = {
+  PROC(null,	 void,		void,		void,	  RC_NOCACHE, 1),
+  PROC(compound, compound,	compound,	compound, RC_NOCACHE, NFSD_BUFSIZE)
+};
+
+/*
+ * Local variables:
+ *  c-basic-offset: 8
+ * End:
+ */
--- old/fs/nfsd/nfs4xdr.c	Wed Dec 31 18:00:00 1969
+++ new/fs/nfsd/nfs4xdr.c	Sun Aug 11 23:16:48 2002
@@ -0,0 +1,1910 @@
+/*
+ *  fs/nfs/nfs4xdr.c
+ *
+ *  Server-side XDR for NFSv4
+ *
+ *  Copyright (c) 2002 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Kendrick Smith <kmsmith@umich.edu>
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
+ * TODO: Neil Brown made the following observation:  We currently
+ * initially reserve NFSD_BUFSIZE space on the transmit queue and
+ * never release any of that until the request is complete.
+ * It would be good to calculate a new maximum response size while
+ * decoding the COMPOUND, and call svc_reserve with this number
+ * at the end of nfs4svc_decode_compoundargs.
+ */
+
+#include <linux/param.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/compatmac.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+
+#include <linux/sunrpc/xdr.h>
+#include <linux/sunrpc/svc.h>
+#include <linux/sunrpc/clnt.h>
+#include <linux/nfsd/nfsd.h>
+#include <linux/nfsd/xdr4.h>
+
+#define NFSDDBG_FACILITY		NFSDDBG_XDR
+
+/*
+ * From Peter Astrand <peter@cendio.se>: The following routines check
+ * whether a filename supplied by the client is valid.
+ */
+static const char trailing_bytes_for_utf8[256] = {
+	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
+	2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2, 3,3,3,3,3,3,3,3,4,4,4,4,5,5,5,5
+};
+
+static inline int
+is_legal_iso_utf8_sequence(unsigned char *source, int length)
+{
+	unsigned char a;
+	unsigned char *srcptr;
+
+	srcptr = source + length;
+
+	switch (length) {
+		/* Everything else falls through when "1"... */
+	default:
+		/* Sequences with more than 6 bytes are invalid */
+		return 0;
+
+		/*
+		   Byte 3-6 must be 80..BF
+		*/
+	case 6:
+		if ((a = (*--srcptr)) < 0x80 || a > 0xBF) return 0;
+	case 5:
+		if ((a = (*--srcptr)) < 0x80 || a > 0xBF) return 0;
+	case 4:
+		if ((a = (*--srcptr)) < 0x80 || a > 0xBF) return 0;
+	case 3:
+		if ((a = (*--srcptr)) < 0x80 || a > 0xBF) return 0;
+
+	case 2:
+		a = *--srcptr;
+
+		/* Upper limit */
+		if (a > 0xBF)
+			/* 2nd byte may never be > 0xBF */
+			return 0;
+
+		/*
+		   Lower limits checks, to detect non-shortest forms.
+		   No fall-through in this inner switch.
+		*/
+		switch (*source) {
+		case 0xE0: /* 3 bytes */
+			if (a < 0xA0) return 0;
+			break;
+		case 0xF0: /* 4 bytes */
+			if (a < 0x90) return 0;
+			break;
+		case 0xF8: /* 5 bytes */
+			if (a < 0xC8) return 0;
+			break;
+		case 0xFC: /* 6 bytes */
+			if (a < 0x84) return 0;
+			break;
+		default:
+			/* In all cases, 2nd byte must be >= 0x80 (because leading
+			   10...) */
+			if (a < 0x80) return 0;
+		}
+
+	case 1:
+		/* Invalid ranges */
+		if (*source >= 0x80 && *source < 0xC2)
+			/* Multibyte char with value < 0xC2, non-shortest */
+			return 0;
+		if (*source > 0xFD)
+			/* Leading byte starting with 11111110 is illegal */
+			return 0;
+		if (!*source)
+			return 0;
+	}
+
+	return 1;
+}
+
+static int
+check_utf8(char *str, int len)
+{
+	unsigned char *chunk, *sourceend;
+	int chunklen;
+
+	chunk = str;
+	sourceend = str + len;
+
+	while (chunk < sourceend) {
+		chunklen = trailing_bytes_for_utf8[*chunk]+1;
+		if (chunk + chunklen > sourceend)
+			return nfserr_inval;
+		if (!is_legal_iso_utf8_sequence(chunk, chunklen))
+			return nfserr_inval;
+		chunk += chunklen;
+	}
+
+	return 0;
+}
+
+static int
+check_filename(char *str, int len, int err)
+{
+	int i;
+
+	if (len == 0)
+		return nfserr_inval;
+	if (isdotent(str, len))
+		return err;
+	for (i = 0; i < len; i++)
+		if (str[i] == '/')
+			return err;
+	return check_utf8(str, len);
+}
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
+	printk(KERN_NOTICE "xdr error! (%s:%d)\n", __FILE__, __LINE__);	\
+	status = nfserr_bad_xdr;		\
+	goto out
+
+#define READ32(x)         (x) = ntohl(*p++)
+#define READ64(x)         do {			\
+	(x) = (u64)ntohl(*p++) << 32;		\
+	(x) |= ntohl(*p++);			\
+} while (0)
+#define READTIME(x)       do {			\
+	p++;					\
+	(x) = ntohl(*p++);			\
+	p++;					\
+} while (0)
+#define READMEM(x,nbytes) do {			\
+	x = (char *)p;				\
+	p += XDR_QUADLEN(nbytes);		\
+} while (0)
+#define COPYMEM(x,nbytes) do {			\
+	memcpy((x), p, nbytes);			\
+	p += XDR_QUADLEN(nbytes);		\
+} while (0)
+
+#define READ_BUF(nbytes)  do {			\
+	if (nbytes > (u32)((char *)argp->end - (char *)argp->p)) {	\
+		printk(KERN_NOTICE "xdr error! (%s:%d)\n", __FILE__, __LINE__); \
+		goto xdr_error;			\
+	}					\
+	p = argp->p;				\
+	argp->p += XDR_QUADLEN(nbytes);		\
+} while (0)
+
+static int
+nfsd4_decode_bitmap(struct nfsd4_compoundargs *argp, u32 *bmval)
+{
+	u32 bmlen;
+	DECODE_HEAD;
+
+	bmval[0] = 0;
+	bmval[1] = 0;
+
+	READ_BUF(4);
+	READ32(bmlen);
+	if (bmlen > 1000)
+		goto xdr_error;
+
+	READ_BUF(bmlen << 2);
+	if (bmlen > 0)
+		READ32(bmval[0]);
+	if (bmlen > 1)
+		READ32(bmval[1]);
+
+	DECODE_TAIL;
+}
+
+static int
+nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval, struct iattr *iattr)
+{
+	int expected_len, len = 0;
+	u32 dummy32;
+	char *buf;
+
+	DECODE_HEAD;
+	iattr->ia_valid = 0;
+	if ((status = nfsd4_decode_bitmap(argp, bmval)))
+		return status;
+
+	/*
+	 * According to spec, unsupported attributes return ERR_NOTSUPP;
+	 * read-only attributes return ERR_INVAL.
+	 */
+	if ((bmval[0] & ~NFSD_SUPPORTED_ATTRS_WORD0) || (bmval[1] & ~NFSD_SUPPORTED_ATTRS_WORD1))
+		return nfserr_notsupp;
+	if ((bmval[0] & ~NFSD_WRITEABLE_ATTRS_WORD0) || (bmval[1] & ~NFSD_WRITEABLE_ATTRS_WORD1))
+		return nfserr_inval;
+
+	READ_BUF(4);
+	READ32(expected_len);
+
+	if (bmval[0] & FATTR4_WORD0_SIZE) {
+		READ_BUF(8);
+		len += 8;
+		READ64(iattr->ia_size);
+		iattr->ia_valid |= ATTR_SIZE;
+	}
+	if (bmval[1] & FATTR4_WORD1_MODE) {
+		READ_BUF(4);
+		len += 4;
+		READ32(iattr->ia_mode);
+		iattr->ia_mode &= (S_IFMT | S_IALLUGO);
+		iattr->ia_valid |= ATTR_MODE;
+	}
+	if (bmval[1] & FATTR4_WORD1_OWNER) {
+		READ_BUF(4);
+		len += 4;
+		READ32(dummy32);
+		READ_BUF(dummy32);
+		len += (XDR_QUADLEN(dummy32) << 2);
+		READMEM(buf, dummy32);
+		if (check_utf8(buf, dummy32))
+			return nfserr_inval;
+		if ((status = gss_get_num(GSS_OWNER, dummy32, buf, &iattr->ia_uid)))
+			goto out_nfserr;
+		iattr->ia_valid |= ATTR_UID;
+	}
+	if (bmval[1] & FATTR4_WORD1_OWNER_GROUP) {
+		READ_BUF(4);
+		len += 4;
+		READ32(dummy32);
+		READ_BUF(dummy32);
+		len += (XDR_QUADLEN(dummy32) << 2);
+		READMEM(buf, dummy32);
+		if (check_utf8(buf, dummy32))
+			return nfserr_inval;
+		if ((status = gss_get_num(GSS_GROUP, dummy32, buf, &iattr->ia_gid)))
+			goto out_nfserr;
+		iattr->ia_valid |= ATTR_GID;
+	}
+	if (bmval[1] & FATTR4_WORD1_TIME_ACCESS_SET) {
+		READ_BUF(4);
+		len += 4;
+		READ32(dummy32);
+		switch (dummy32) {
+		case NFS4_SET_TO_CLIENT_TIME:
+			/* We require the high 32 bits of 'seconds' to be 0, and we ignore
+			   all 32 bits of 'nseconds'. */
+			READ_BUF(12);
+			len += 12;
+			READ32(dummy32);
+			if (dummy32)
+				return nfserr_inval;
+			READ32(iattr->ia_atime);
+			READ32(dummy32);
+			if (dummy32 >= (u32)1000000000)
+				return nfserr_inval;
+			iattr->ia_valid |= (ATTR_ATIME | ATTR_ATIME_SET);
+			break;
+		case NFS4_SET_TO_SERVER_TIME:
+			iattr->ia_valid |= ATTR_ATIME;
+			break;
+		default:
+			goto xdr_error;
+		}
+	}
+	if (bmval[1] & FATTR4_WORD1_TIME_METADATA) {
+		/* We require the high 32 bits of 'seconds' to be 0, and we ignore
+		   all 32 bits of 'nseconds'. */
+		READ_BUF(12);
+		len += 12;
+		READ32(dummy32);
+		if (dummy32)
+			return nfserr_inval;
+		READ32(iattr->ia_ctime);
+		READ32(dummy32);
+		if (dummy32 >= (u32)1000000000)
+			return nfserr_inval;
+		iattr->ia_valid |= ATTR_CTIME;
+	}
+	if (bmval[1] & FATTR4_WORD1_TIME_MODIFY_SET) {
+		READ_BUF(4);
+		len += 4;
+		READ32(dummy32);
+		switch (dummy32) {
+		case NFS4_SET_TO_CLIENT_TIME:
+			/* We require the high 32 bits of 'seconds' to be 0, and we ignore
+			   all 32 bits of 'nseconds'. */
+			READ_BUF(12);
+			len += 12;
+			READ32(dummy32);
+			if (dummy32)
+				return nfserr_inval;
+			READ32(iattr->ia_mtime);
+			READ32(dummy32);
+			if (dummy32 >= (u32)1000000000)
+				return nfserr_inval;
+			iattr->ia_valid |= (ATTR_MTIME | ATTR_MTIME_SET);
+			break;
+		case NFS4_SET_TO_SERVER_TIME:
+			iattr->ia_valid |= ATTR_MTIME;
+			break;
+		default:
+			goto xdr_error;
+		}
+	}
+	if (len != expected_len)
+		goto xdr_error;
+
+	DECODE_TAIL;
+
+out_nfserr:
+	status = nfserrno(status);
+	goto out;
+}
+
+static int
+nfsd4_decode_access(struct nfsd4_compoundargs *argp, struct nfsd4_access *access)
+{
+	DECODE_HEAD;
+
+	READ_BUF(4);
+	READ32(access->ac_req_access);
+
+	DECODE_TAIL;
+}
+
+static int
+nfsd4_decode_close(struct nfsd4_compoundargs *argp, struct nfsd4_close *close)
+{
+	DECODE_HEAD;
+
+	READ_BUF(4 + sizeof(stateid_t));
+	READ32(close->cl_seqid);
+	READ32(close->cl_stateid.st_generation);
+	COPYMEM(&close->cl_stateid.st_other, sizeof(stateid_other_t));
+
+	DECODE_TAIL;
+}
+
+
+static int
+nfsd4_decode_commit(struct nfsd4_compoundargs *argp, struct nfsd4_commit *commit)
+{
+	DECODE_HEAD;
+
+	READ_BUF(12);
+	READ64(commit->co_offset);
+	READ32(commit->co_count);
+
+	DECODE_TAIL;
+}
+
+static int
+nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create)
+{
+	DECODE_HEAD;
+
+	READ_BUF(4);
+	READ32(create->cr_type);
+	switch (create->cr_type) {
+	case NF4LNK:
+		READ_BUF(4);
+		READ32(create->cr_linklen);
+		READ_BUF(create->cr_linklen);
+		READMEM(create->cr_linkname, create->cr_linklen);
+		if (check_utf8(create->cr_linkname, create->cr_linklen))
+			return nfserr_inval;
+		break;
+	case NF4BLK:
+	case NF4CHR:
+		READ_BUF(8);
+		READ32(create->cr_specdata1);
+		READ32(create->cr_specdata2);
+		break;
+	case NF4SOCK:
+	case NF4FIFO:
+	case NF4DIR:
+		break;
+	default:
+		goto xdr_error;
+	}
+
+	READ_BUF(4);
+	READ32(create->cr_namelen);
+	READ_BUF(create->cr_namelen);
+	READMEM(create->cr_name, create->cr_namelen);
+	if ((status = check_filename(create->cr_name, create->cr_namelen, nfserr_inval)))
+		return status;
+
+	if ((status = nfsd4_decode_fattr(argp, create->cr_bmval, &create->cr_iattr)))
+		goto out;
+
+	DECODE_TAIL;
+}
+
+static inline int
+nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, struct nfsd4_getattr *getattr)
+{
+	return nfsd4_decode_bitmap(argp, getattr->ga_bmval);
+}
+
+static int
+nfsd4_decode_link(struct nfsd4_compoundargs *argp, struct nfsd4_link *link)
+{
+	DECODE_HEAD;
+
+	READ_BUF(4);
+	READ32(link->li_namelen);
+	READ_BUF(link->li_namelen);
+	READMEM(link->li_name, link->li_namelen);
+	if ((status = check_filename(link->li_name, link->li_namelen, nfserr_inval)))
+		return status;
+
+	DECODE_TAIL;
+}
+
+static int
+nfsd4_decode_lookup(struct nfsd4_compoundargs *argp, struct nfsd4_lookup *lookup)
+{
+	DECODE_HEAD;
+
+	READ_BUF(4);
+	READ32(lookup->lo_len);
+	READ_BUF(lookup->lo_len);
+	READMEM(lookup->lo_name, lookup->lo_len);
+	if ((status = check_filename(lookup->lo_name, lookup->lo_len, nfserr_noent)))
+		return status;
+
+	DECODE_TAIL;
+}
+
+static int
+nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
+{
+	DECODE_HEAD;
+
+	memset(open->op_bmval, 0, sizeof(open->op_bmval));
+	open->op_iattr.ia_valid = 0;
+
+	/* seqid, share_access, share_deny, clientid, ownerlen */
+	READ_BUF(16 + sizeof(clientid_t));
+	READ32(open->op_seqid);
+	READ32(open->op_share_access);
+	READ32(open->op_share_deny);
+	COPYMEM(&open->op_clientid, sizeof(clientid_t));
+	READ32(open->op_ownerlen);
+
+	/* owner, open_flag */
+	READ_BUF(open->op_ownerlen + 4);
+	READMEM(open->op_owner, open->op_ownerlen);
+	READ32(open->op_create);
+	switch (open->op_create) {
+	case NFS4_OPEN_NOCREATE:
+		break;
+	case NFS4_OPEN_CREATE:
+		READ_BUF(4);
+		READ32(open->op_createmode);
+		switch (open->op_createmode) {
+		case NFS4_CREATE_UNCHECKED:
+		case NFS4_CREATE_GUARDED:
+			if ((status = nfsd4_decode_fattr(argp, open->op_bmval, &open->op_iattr)))
+				goto out;
+			break;
+		case NFS4_CREATE_EXCLUSIVE:
+			READ_BUF(8);
+			COPYMEM(open->op_verf, 8);
+			break;
+		default:
+			goto xdr_error;
+		}
+		break;
+	default:
+		goto xdr_error;
+	}
+
+	/* open_claim */
+	READ_BUF(4);
+	READ32(open->op_claim_type);
+	switch (open->op_claim_type) {
+	case NFS4_OPEN_CLAIM_NULL:
+	case NFS4_OPEN_CLAIM_DELEGATE_PREV:
+		READ_BUF(4);
+		READ32(open->op_namelen);
+		READ_BUF(open->op_namelen);
+		READMEM(open->op_name, open->op_namelen);
+		if ((status = check_filename(open->op_name, open->op_namelen, nfserr_inval)))
+			return status;
+		break;
+	case NFS4_OPEN_CLAIM_PREVIOUS:
+		READ_BUF(4);
+		READ32(open->op_delegate_type);
+		break;
+	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
+		READ_BUF(sizeof(delegation_stateid_t) + 4);
+		COPYMEM(&open->op_delegate_stateid, sizeof(delegation_stateid_t));
+		READ32(open->op_namelen);
+		READ_BUF(open->op_namelen);
+		READMEM(open->op_name, open->op_namelen);
+		if ((status = check_filename(open->op_name, open->op_namelen, nfserr_inval)))
+			return status;
+		break;
+	default:
+		goto xdr_error;
+	}
+
+	DECODE_TAIL;
+}
+
+static int
+nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, struct nfsd4_putfh *putfh)
+{
+	DECODE_HEAD;
+
+	READ_BUF(4);
+	READ32(putfh->pf_fhlen);
+	if (putfh->pf_fhlen > NFS4_FHSIZE)
+		goto xdr_error;
+	READ_BUF(putfh->pf_fhlen);
+	READMEM(putfh->pf_fhval, putfh->pf_fhlen);
+
+	DECODE_TAIL;
+}
+
+static int
+nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
+{
+	DECODE_HEAD;
+
+	READ_BUF(sizeof(stateid_t) + 12);
+	READ32(read->rd_stateid.st_generation);
+	COPYMEM(&read->rd_stateid.st_other, sizeof(stateid_other_t));
+	READ64(read->rd_offset);
+	READ32(read->rd_length);
+
+	DECODE_TAIL;
+}
+
+static int
+nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readdir *readdir)
+{
+	DECODE_HEAD;
+
+	READ_BUF(24);
+	READ64(readdir->rd_cookie);
+	COPYMEM(readdir->rd_verf, sizeof(nfs4_verifier));
+	READ32(readdir->rd_dircount);    /* just in case you needed a useless field... */
+	READ32(readdir->rd_maxcount);
+	if ((status = nfsd4_decode_bitmap(argp, readdir->rd_bmval)))
+		goto out;
+
+	DECODE_TAIL;
+}
+
+static int
+nfsd4_decode_remove(struct nfsd4_compoundargs *argp, struct nfsd4_remove *remove)
+{
+	DECODE_HEAD;
+
+	READ_BUF(4);
+	READ32(remove->rm_namelen);
+	READ_BUF(remove->rm_namelen);
+	READMEM(remove->rm_name, remove->rm_namelen);
+	if ((status = check_filename(remove->rm_name, remove->rm_namelen, nfserr_noent)))
+		return status;
+
+	DECODE_TAIL;
+}
+
+static int
+nfsd4_decode_rename(struct nfsd4_compoundargs *argp, struct nfsd4_rename *rename)
+{
+	DECODE_HEAD;
+
+	READ_BUF(4);
+	READ32(rename->rn_snamelen);
+	READ_BUF(rename->rn_snamelen + 4);
+	READMEM(rename->rn_sname, rename->rn_snamelen);
+	READ32(rename->rn_tnamelen);
+	READ_BUF(rename->rn_tnamelen);
+	READMEM(rename->rn_tname, rename->rn_tnamelen);
+	if ((status = check_filename(rename->rn_sname, rename->rn_snamelen, nfserr_noent)))
+		return status;
+	if ((status = check_filename(rename->rn_tname, rename->rn_tnamelen, nfserr_inval)))
+		return status;
+
+	DECODE_TAIL;
+}
+
+static int
+nfsd4_decode_renew(struct nfsd4_compoundargs *argp, clientid_t *clientid)
+{
+	DECODE_HEAD;
+
+	READ_BUF(sizeof(clientid_t));
+	COPYMEM(clientid, sizeof(clientid_t));
+
+	DECODE_TAIL;
+}
+
+static int
+nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *setattr)
+{
+	DECODE_HEAD;
+
+	READ_BUF(sizeof(stateid_t));
+	READ32(setattr->sa_stateid.st_generation);
+	COPYMEM(&setattr->sa_stateid.st_other, sizeof(stateid_other_t));
+	if ((status = nfsd4_decode_fattr(argp, setattr->sa_bmval, &setattr->sa_iattr)))
+		goto out;
+
+	DECODE_TAIL;
+}
+
+static int
+nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, struct nfsd4_setclientid *setclientid)
+{
+	DECODE_HEAD;
+
+	READ_BUF(12);
+	COPYMEM(setclientid->se_verf, 8);
+	READ32(setclientid->se_namelen);
+
+	READ_BUF(setclientid->se_namelen + 8);
+	READMEM(setclientid->se_name, setclientid->se_namelen);
+	READ32(setclientid->se_callback_prog);
+	READ32(setclientid->se_callback_netid_len);
+
+	READ_BUF(setclientid->se_callback_netid_len + 4);
+	READMEM(setclientid->se_callback_netid_val, setclientid->se_callback_netid_len);
+	READ32(setclientid->se_callback_addr_len);
+
+	READ_BUF(setclientid->se_callback_addr_len + 4);
+	READMEM(setclientid->se_callback_addr_val, setclientid->se_callback_addr_len);
+	READ32(setclientid->se_callback_ident);
+
+	DECODE_TAIL;
+}
+
+static int
+nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp, clientid_t *clientid)
+{
+	DECODE_HEAD;
+
+	READ_BUF(8);
+	COPYMEM(clientid, 8);
+
+	DECODE_TAIL;
+}
+
+/* Also used for NVERIFY */
+static int
+nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify)
+{
+	DECODE_HEAD;
+
+	if ((status = nfsd4_decode_bitmap(argp, verify->ve_bmval)))
+		goto out;
+	READ_BUF(4);
+	READ32(verify->ve_attrlen);
+	READ_BUF(verify->ve_attrlen);
+	READMEM(verify->ve_attrval, verify->ve_attrlen);
+
+	DECODE_TAIL;
+}
+
+static int
+nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
+{
+	DECODE_HEAD;
+
+	READ_BUF(sizeof(stateid_t) + 16);
+	READ32(write->wr_stateid.st_generation);
+	COPYMEM(&write->wr_stateid.st_other, sizeof(stateid_other_t));
+	READ64(write->wr_offset);
+	READ32(write->wr_stable_how);
+	if (write->wr_stable_how > 2)
+		goto xdr_error;
+	READ32(write->wr_buflen);
+
+	READ_BUF(write->wr_buflen);
+	READMEM(write->wr_buf, write->wr_buflen);
+
+	DECODE_TAIL;
+}
+
+static int
+nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
+{
+	DECODE_HEAD;
+	struct nfsd4_op *op;
+	int i;
+
+	/*
+	 * XXX: According to spec, we should check the tag
+	 * for UTF-8 compliance.  I'm postponing this for
+	 * now because it seems that some clients do use
+	 * binary tags.
+	 */
+	READ_BUF(4);
+	READ32(argp->taglen);
+	READ_BUF(argp->taglen + 8);
+	READMEM(argp->tag, argp->taglen);
+	READ32(argp->minorversion);
+	READ32(argp->opcnt);
+
+	if (argp->taglen > NFSD4_MAX_TAGLEN)
+		goto xdr_error;
+	if (argp->opcnt > 100)
+		goto xdr_error;
+
+	if (argp->opcnt > sizeof(argp->iops)/sizeof(argp->iops[0])) {
+		argp->ops = kmalloc(argp->opcnt * sizeof(*argp->ops), GFP_KERNEL);
+		if (!argp->ops) {
+			argp->ops = argp->iops;
+			printk(KERN_INFO "nfsd: couldn't allocate room for COMPOUND\n");
+			goto xdr_error;
+		}
+	}
+
+	for (i = 0; i < argp->opcnt; i++) {
+		op = &argp->ops[i];
+
+		/*
+		 * Before reading the opcode, we test for the 4-byte buffer
+		 * overrun explicitly, instead of using READ_BUF().  This is
+		 * because we want a missing opcode to be treated as opcode
+		 * OP_WRITE+1, instead of a failed XDR.
+		 */
+		if (argp->p == argp->end) {
+			op->opnum = OP_WRITE + 1;
+			op->status = nfserr_bad_xdr;
+			argp->opcnt = i+1;
+			break;
+		}
+		op->opnum = ntohl(*argp->p++);
+
+		switch (op->opnum) {
+		case OP_ACCESS:
+			op->status = nfsd4_decode_access(argp, &op->u.access);
+			break;
+		case OP_CLOSE:
+			op->status = nfsd4_decode_close(argp, &op->u.close);
+			break;
+		case OP_COMMIT:
+			op->status = nfsd4_decode_commit(argp, &op->u.commit);
+			break;
+		case OP_CREATE:
+			op->status = nfsd4_decode_create(argp, &op->u.create);
+			break;
+		case OP_GETATTR:
+			op->status = nfsd4_decode_getattr(argp, &op->u.getattr);
+			break;
+		case OP_GETFH:
+			op->status = nfs_ok;
+			break;
+		case OP_LINK:
+			op->status = nfsd4_decode_link(argp, &op->u.link);
+			break;
+		case OP_LOOKUP:
+			op->status = nfsd4_decode_lookup(argp, &op->u.lookup);
+			break;
+		case OP_LOOKUPP:
+			op->status = nfs_ok;
+			break;
+		case OP_NVERIFY:
+			op->status = nfsd4_decode_verify(argp, &op->u.nverify);
+			break;
+		case OP_OPEN:
+			op->status = nfsd4_decode_open(argp, &op->u.open);
+			break;
+		case OP_PUTFH:
+			op->status = nfsd4_decode_putfh(argp, &op->u.putfh);
+			break;
+		case OP_PUTROOTFH:
+			op->status = nfs_ok;
+			break;
+		case OP_READ:
+			op->status = nfsd4_decode_read(argp, &op->u.read);
+			break;
+		case OP_READDIR:
+			op->status = nfsd4_decode_readdir(argp, &op->u.readdir);
+			break;
+		case OP_READLINK:
+			op->status = nfs_ok;
+			break;
+		case OP_REMOVE:
+			op->status = nfsd4_decode_remove(argp, &op->u.remove);
+			break;
+		case OP_RENAME:
+			op->status = nfsd4_decode_rename(argp, &op->u.rename);
+			break;
+		case OP_RESTOREFH:
+			op->status = nfs_ok;
+			break;
+		case OP_RENEW:
+			op->status = nfsd4_decode_renew(argp, &op->u.renew);
+			break;
+		case OP_SAVEFH:
+			op->status = nfs_ok;
+			break;
+		case OP_SETATTR:
+			op->status = nfsd4_decode_setattr(argp, &op->u.setattr);
+			break;
+		case OP_SETCLIENTID:
+			op->status = nfsd4_decode_setclientid(argp, &op->u.setclientid);
+			break;
+		case OP_SETCLIENTID_CONFIRM:
+			op->status = nfsd4_decode_setclientid_confirm(argp, &op->u.setclientid_confirm);
+			break;
+		case OP_VERIFY:
+			op->status = nfsd4_decode_verify(argp, &op->u.verify);
+			break;
+		case OP_WRITE:
+			op->status = nfsd4_decode_write(argp, &op->u.write);
+			break;
+		default:
+			/*
+			 * According to spec, anything greater than OP_WRITE
+			 * is treated as OP_WRITE+1 in the response.
+			 */
+			if (op->opnum > OP_WRITE)
+			op->opnum = OP_WRITE + 1;
+			op->status = nfserr_notsupp;
+			break;
+		}
+
+		if (op->status) {
+			argp->opcnt = i+1;
+			break;
+		}
+	}
+
+	DECODE_TAIL;
+}
+/*
+ * END OF "GENERIC" DECODE ROUTINES.
+ */
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
+#define ENCODE_HEAD              u32 *p
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
+#define WRITECINFO(c)		do {				\
+	*p++ = htonl(c.atomic);					\
+	*p++ = htonl(c.before_size);				\
+	*p++ = htonl(c.before_ctime);				\
+	*p++ = htonl(c.after_size);				\
+	*p++ = htonl(c.after_ctime);				\
+} while (0)
+
+#define RESERVE_SPACE(nbytes)	do {				\
+	p = resp->p;						\
+	BUG_ON(p + XDR_QUADLEN(nbytes) > resp->end);		\
+} while (0)
+#define ADJUST_ARGS()		resp->p = p
+
+static u32 nfs4_ftypes[16] = {
+        NF4BAD,  NF4FIFO, NF4CHR, NF4BAD,
+        NF4DIR,  NF4BAD,  NF4BLK, NF4BAD,
+        NF4REG,  NF4BAD,  NF4LNK, NF4BAD,
+        NF4SOCK, NF4BAD,  NF4LNK, NF4BAD,
+};
+
+/*
+ * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
+ * ourselves.
+ *
+ * @countp is the buffer size in _words_; upon successful return this becomes
+ * replaced with the number of words written.
+ */
+int
+nfsd4_encode_fattr(struct svc_fh *fhp, struct svc_export *exp,
+		   struct dentry *dentry, u32 *buffer, int *countp, u32 *bmval)
+{
+	u32 bmval0 = bmval[0];
+	u32 bmval1 = bmval[1];
+	struct kstat stat;
+	struct gss_cacheent *owner = NULL;
+	struct gss_cacheent *group = NULL;
+	struct svc_fh tempfh;
+	struct statfs statfs;
+	int buflen = *countp << 2;
+	u32 *attrlenp;
+	u32 dummy;
+	u64 dummy64;
+	u32 *p = buffer;
+	int status;
+
+	BUG_ON(bmval1 & NFSD_WRITEONLY_ATTRS_WORD1);
+	BUG_ON(bmval0 & ~NFSD_SUPPORTED_ATTRS_WORD0);
+	BUG_ON(bmval1 & ~NFSD_SUPPORTED_ATTRS_WORD1);
+
+	status = vfs_getattr(exp->ex_mnt, dentry, &stat);
+	if (status)
+		goto out_nfserr;
+	if ((bmval0 & (FATTR4_WORD0_FILES_FREE | FATTR4_WORD0_FILES_TOTAL)) ||
+	    (bmval1 & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
+		       FATTR4_WORD1_SPACE_TOTAL))) {
+		status = vfs_statfs(dentry->d_inode->i_sb, &statfs);
+		if (status)
+			goto out_nfserr;
+	}
+	if ((bmval0 & FATTR4_WORD0_FILEHANDLE) && !fhp) {
+		fh_init(&tempfh, NFS4_FHSIZE);
+		status = fh_compose(&tempfh, exp, dentry, NULL);
+		if (status)
+			goto out;
+		fhp = &tempfh;
+	}
+	if (bmval1 & FATTR4_WORD1_OWNER) {
+		status = gss_get_name(GSS_OWNER, stat.uid, &owner);
+		if (status)
+			goto out_nfserr;
+	}
+	if (bmval1 & FATTR4_WORD1_OWNER_GROUP) {
+		status = gss_get_name(GSS_GROUP, stat.gid, &group);
+		if (status)
+			goto out_nfserr;
+	}
+
+	if ((buflen -= 16) < 0)
+		goto out_resource;
+
+	WRITE32(2);
+	WRITE32(bmval0);
+	WRITE32(bmval1);
+	attrlenp = p++;                /* to be backfilled later */
+
+	if (bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
+		if ((buflen -= 12) < 0)
+			goto out_resource;
+		WRITE32(2);
+		WRITE32(NFSD_SUPPORTED_ATTRS_WORD0);
+		WRITE32(NFSD_SUPPORTED_ATTRS_WORD1);
+	}
+	if (bmval0 & FATTR4_WORD0_TYPE) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		dummy = nfs4_ftypes[(stat.mode & S_IFMT) >> 12];
+		if (dummy == NF4BAD)
+			goto out_serverfault;
+		WRITE32(dummy);
+	}
+	if (bmval0 & FATTR4_WORD0_FH_EXPIRE_TYPE) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32( NFS4_FH_NOEXPIRE_WITH_OPEN | NFS4_FH_VOL_RENAME );
+	}
+	if (bmval0 & FATTR4_WORD0_CHANGE) {
+		/*
+		 * XXX: We currently use the inode ctime as the nfsv4 "changeid"
+		 * attribute.  This violates the spec, which says
+		 *
+		 *    The server may return the object's time_modify attribute
+		 *    for this attribute, but only if the file system object
+		 *    can not be updated more frequently than the resolution
+		 *    of time_modify.
+		 *
+		 * Since we only have 1-second ctime resolution, this is a pretty
+		 * serious violation.  Indeed, 1-second ctime resolution is known
+		 * to be a problem in practice in the NFSv3 world.
+		 *
+		 * The real solution to this problem is probably to work on
+		 * adding high-resolution mtimes to the VFS layer.
+		 *
+		 * Note: Started using i_size for the high 32 bits of the changeid.
+		 *
+		 * Note 2: This _must_ be consistent with the scheme for writing
+		 * change_info, so any changes made here must be reflected there
+		 * as well.  (See xdr4.h:set_change_info() and the WRITECINFO()
+		 * macro above.)
+		 */
+		if ((buflen -= 8) < 0)
+			goto out_resource;
+		WRITE32(stat.size);
+		WRITE32(stat.mtime);
+	}
+	if (bmval0 & FATTR4_WORD0_SIZE) {
+		if ((buflen -= 8) < 0)
+			goto out_resource;
+		WRITE64(stat.size);
+	}
+	if (bmval0 & FATTR4_WORD0_LINK_SUPPORT) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(1);
+	}
+	if (bmval0 & FATTR4_WORD0_SYMLINK_SUPPORT) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(1);
+	}
+	if (bmval0 & FATTR4_WORD0_NAMED_ATTR) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(0);
+	}
+	if (bmval0 & FATTR4_WORD0_FSID) {
+		if ((buflen -= 16) < 0)
+			goto out_resource;
+		WRITE32(0);
+		WRITE32(MAJOR(stat.dev));
+		WRITE32(0);
+		WRITE32(MINOR(stat.dev));
+	}
+	if (bmval0 & FATTR4_WORD0_UNIQUE_HANDLES) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(0);
+	}
+	if (bmval0 & FATTR4_WORD0_LEASE_TIME) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(NFSD_LEASE_TIME);
+	}
+	if (bmval0 & FATTR4_WORD0_RDATTR_ERROR) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(0);
+	}
+	if (bmval0 & FATTR4_WORD0_ACLSUPPORT) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(0);
+	}
+	if (bmval0 & FATTR4_WORD0_CANSETTIME) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(1);
+	}
+	if (bmval0 & FATTR4_WORD0_CASE_INSENSITIVE) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(1);
+	}
+	if (bmval0 & FATTR4_WORD0_CASE_PRESERVING) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(1);
+	}
+	if (bmval0 & FATTR4_WORD0_CHOWN_RESTRICTED) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(1);
+	}
+	if (bmval0 & FATTR4_WORD0_FILEHANDLE) {
+		buflen -= (XDR_QUADLEN(fhp->fh_handle.fh_size) << 2) + 4;
+		if (buflen < 0)
+			goto out_resource;
+		WRITE32(fhp->fh_handle.fh_size);
+		WRITEMEM(&fhp->fh_handle.fh_base, fhp->fh_handle.fh_size);
+	}
+	if (bmval0 & FATTR4_WORD0_FILEID) {
+		if ((buflen -= 8) < 0)
+			goto out_resource;
+		WRITE64((u64) stat.ino);
+	}
+	if (bmval0 & FATTR4_WORD0_FILES_AVAIL) {
+		if ((buflen -= 8) < 0)
+			goto out_resource;
+		WRITE64((u64) statfs.f_ffree);
+	}
+	if (bmval0 & FATTR4_WORD0_FILES_FREE) {
+		if ((buflen -= 8) < 0)
+			goto out_resource;
+		WRITE64((u64) statfs.f_ffree);
+	}
+	if (bmval0 & FATTR4_WORD0_FILES_TOTAL) {
+		if ((buflen -= 8) < 0)
+			goto out_resource;
+		WRITE64((u64) statfs.f_files);
+	}
+	if (bmval0 & FATTR4_WORD0_HOMOGENEOUS) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(1);
+	}
+	if (bmval0 & FATTR4_WORD0_MAXFILESIZE) {
+		if ((buflen -= 8) < 0)
+			goto out_resource;
+		WRITE64(~(u64)0);
+	}
+	if (bmval0 & FATTR4_WORD0_MAXLINK) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(255);
+	}
+	if (bmval0 & FATTR4_WORD0_MAXNAME) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(~(u32) 0);
+	}
+	if (bmval0 & FATTR4_WORD0_MAXREAD) {
+		if ((buflen -= 8) < 0)
+			goto out_resource;
+		WRITE64((u64) NFSSVC_MAXBLKSIZE);
+	}
+	if (bmval0 & FATTR4_WORD0_MAXWRITE) {
+		if ((buflen -= 8) < 0)
+			goto out_resource;
+		WRITE64((u64) NFSSVC_MAXBLKSIZE);
+	}
+	if (bmval1 & FATTR4_WORD1_MODE) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(stat.mode & S_IALLUGO);
+	}
+	if (bmval1 & FATTR4_WORD1_NO_TRUNC) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(1);
+	}
+	if (bmval1 & FATTR4_WORD1_NUMLINKS) {
+		if ((buflen -= 4) < 0)
+			goto out_resource;
+		WRITE32(stat.nlink);
+	}
+	if (bmval1 & FATTR4_WORD1_OWNER) {
+		buflen -= (XDR_QUADLEN(owner->name.len) << 2) + 4;
+		if (buflen < 0)
+			goto out_resource;
+		WRITE32(owner->name.len);
+		WRITEMEM(owner->name.name, owner->name.len);
+	}
+	if (bmval1 & FATTR4_WORD1_OWNER_GROUP) {
+		buflen -= (XDR_QUADLEN(owner->name.len) << 2) + 4;
+		if (buflen < 0)
+			goto out_resource;
+		WRITE32(group->name.len);
+		WRITEMEM(group->name.name, group->name.len);
+	}
+	if (bmval1 & FATTR4_WORD1_RAWDEV) {
+		if ((buflen -= 8) < 0)
+			goto out_resource;
+		WRITE32((u32) MAJOR(stat.rdev));
+		WRITE32((u32) MINOR(stat.rdev));
+	}
+	if (bmval1 & FATTR4_WORD1_SPACE_AVAIL) {
+		if ((buflen -= 8) < 0)
+			goto out_resource;
+		dummy64 = (u64)statfs.f_bavail * (u64)statfs.f_bsize;
+		WRITE64(dummy64);
+	}
+	if (bmval1 & FATTR4_WORD1_SPACE_FREE) {
+		if ((buflen -= 8) < 0)
+			goto out_resource;
+		dummy64 = (u64)statfs.f_bfree * (u64)statfs.f_bsize;
+		WRITE64(dummy64);
+	}
+	if (bmval1 & FATTR4_WORD1_SPACE_TOTAL) {
+		if ((buflen -= 8) < 0)
+			goto out_resource;
+		dummy64 = (u64)statfs.f_blocks * (u64)statfs.f_bsize;
+		WRITE64(dummy64);
+	}
+	if (bmval1 & FATTR4_WORD1_SPACE_USED) {
+		if ((buflen -= 8) < 0)
+			goto out_resource;
+		dummy64 = (u64)stat.blocks << 9;
+		WRITE64(dummy64);
+	}
+	if (bmval1 & FATTR4_WORD1_TIME_ACCESS) {
+		if ((buflen -= 12) < 0)
+			goto out_resource;
+		WRITE32(0);
+		WRITE32(stat.atime);
+		WRITE32(0);
+	}
+	if (bmval1 & FATTR4_WORD1_TIME_DELTA) {
+		if ((buflen -= 12) < 0)
+			goto out_resource;
+		WRITE32(0);
+		WRITE32(1);
+		WRITE32(0);
+	}
+	if (bmval1 & FATTR4_WORD1_TIME_METADATA) {
+		if ((buflen -= 12) < 0)
+			goto out_resource;
+		WRITE32(0);
+		WRITE32(stat.ctime);
+		WRITE32(0);
+	}
+	if (bmval1 & FATTR4_WORD1_TIME_MODIFY) {
+		if ((buflen -= 12) < 0)
+			goto out_resource;
+		WRITE32(0);
+		WRITE32(stat.mtime);
+		WRITE32(0);
+	}
+
+	*attrlenp = htonl((char *)p - (char *)attrlenp - 4);
+	*countp = p - buffer;
+	status = nfs_ok;
+
+out:
+	if (fhp == &tempfh)
+		fh_put(&tempfh);
+	if (owner)
+		gss_put(owner);
+	if (group)
+		gss_put(group);
+	return status;
+out_nfserr:
+	status = nfserrno(status);
+	goto out;
+out_resource:
+	*countp = 0;
+	status = nfserr_resource;
+	goto out;
+out_serverfault:
+	status = nfserr_serverfault;
+	goto out;
+}
+
+static int
+nfsd4_encode_dirent(struct readdir_cd *cd, const char *name, int namlen,
+		    loff_t offset, ino_t ino, unsigned int d_type)
+{
+	int buflen;
+	u32 *p = cd->buffer;
+	u32 *attrlenp;
+	struct dentry *dentry;
+	u32 bmval0, bmval1;
+	int nfserr = 0;
+
+	/* In nfsv4, "." and ".." never make it onto the wire.. */
+	if (name && isdotent(name, namlen))
+		return 0;
+
+	if (cd->offset)
+		xdr_encode_hyper(cd->offset, (u64) offset);
+
+	/* nfsd_readdir calls us with name == 0 when it wants us to
+	 * set the last offset entry. */
+	if (name == 0)
+		return 0;
+
+	buflen = cd->buflen - 4 - XDR_QUADLEN(namlen);
+	if (buflen < 0)
+		goto nospc;
+
+	*p++ = xdr_one;                             /* mark entry present */
+	cd->offset = p;                             /* remember pointer */
+	p = xdr_encode_hyper(p, NFS_OFFSET_MAX);    /* offset of next entry */
+	p = xdr_encode_array(p, name, namlen);      /* name length & name */
+
+	/*
+	 * Now we come to the ugly part: writing the fattr for this entry.
+	 */
+	bmval0 = cd->bmval[0];
+	bmval1 = cd->bmval[1];
+	if ((bmval0 & ~(FATTR4_WORD0_RDATTR_ERROR | FATTR4_WORD0_FILEID)) || bmval1)  {
+		/*
+		 * "Heavyweight" case: we have no choice except to
+		 * call nfsd4_encode_fattr().  As far as I know,
+		 * only Windows clients will trigger this code
+		 * path.
+		 */
+		dentry = lookup_one_len(name, cd->dirfh->fh_dentry, namlen);
+		if (IS_ERR(dentry)) {
+			nfserr = nfserrno(PTR_ERR(dentry));
+			goto error;
+		}
+
+		nfserr = nfsd4_encode_fattr(NULL, cd->dirfh->fh_export,
+					    dentry, p, &buflen, cd->bmval);
+		dput(dentry);
+
+		if (!nfserr) {
+			p += buflen;
+			goto out;
+		}
+		if (nfserr == nfserr_resource)
+			goto nospc;
+
+error:
+		/*
+		 * If we get here, we experienced a miscellaneous
+		 * failure while writing the attributes.  If the
+		 * client requested the RDATTR_ERROR attribute,
+		 * we stuff the error code into this attribute
+		 * and continue.  If this attribute was not requested,
+		 * then in accordance with the spec, we fail the
+		 * entire READDIR operation(!)
+		 */
+		if (!(bmval0 & FATTR4_WORD0_RDATTR_ERROR)) {
+			cd->nfserr = nfserr;
+			return -EINVAL;
+		}
+
+		bmval0 = FATTR4_WORD0_RDATTR_ERROR;
+		bmval1 = 0;
+		/* falling through here will do the right thing... */
+	}
+
+	/*
+	 * In the common "lightweight" case, we avoid
+	 * the overhead of nfsd4_encode_fattr() by assembling
+	 * a small fattr by hand.
+	 */
+	if (buflen < 6)
+		goto nospc;
+	*p++ = htonl(2);
+	*p++ = htonl(bmval0);
+	*p++ = htonl(bmval1);
+
+	attrlenp = p++;
+	if (bmval0 & FATTR4_WORD0_RDATTR_ERROR)
+		*p++ = nfserr;       /* no htonl */
+	if (bmval0 & FATTR4_WORD0_FILEID)
+		p = xdr_encode_hyper(p, (u64)ino);
+	*attrlenp = htonl((char *)p - (char *)attrlenp - 4);
+
+out:
+	cd->buflen -= (p - cd->buffer);
+	cd->buffer = p;
+	return 0;
+
+nospc:
+	cd->eob = 1;
+	return -EINVAL;
+}
+
+static void
+nfsd4_encode_access(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_access *access)
+{
+	ENCODE_HEAD;
+
+	if (!nfserr) {
+		RESERVE_SPACE(8);
+		WRITE32(access->ac_supported);
+		WRITE32(access->ac_resp_access);
+		ADJUST_ARGS();
+	}
+}
+
+static void
+nfsd4_encode_close(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_close *close)
+{
+	ENCODE_HEAD;
+
+	if (!nfserr) {
+		RESERVE_SPACE(sizeof(stateid_t));
+		WRITE32(close->cl_stateid.st_generation);
+		WRITEMEM(&close->cl_stateid.st_other, sizeof(stateid_other_t));
+		ADJUST_ARGS();
+	}
+}
+
+
+static void
+nfsd4_encode_commit(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_commit *commit)
+{
+	ENCODE_HEAD;
+
+	if (!nfserr) {
+		RESERVE_SPACE(8);
+		WRITEMEM(commit->co_verf, 8);
+		ADJUST_ARGS();
+	}
+}
+
+static void
+nfsd4_encode_create(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_create *create)
+{
+	ENCODE_HEAD;
+
+	if (!nfserr) {
+		RESERVE_SPACE(32);
+		WRITECINFO(create->cr_cinfo);
+		WRITE32(2);
+		WRITE32(create->cr_bmval[0]);
+		WRITE32(create->cr_bmval[1]);
+		ADJUST_ARGS();
+	}
+}
+
+static int
+nfsd4_encode_getattr(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_getattr *getattr)
+{
+	struct svc_fh *fhp = getattr->ga_fhp;
+	int buflen;
+
+	if (nfserr)
+		return nfserr;
+
+	buflen = resp->end - resp->p - (COMPOUND_ERR_SLACK_SPACE >> 2);
+	nfserr = nfsd4_encode_fattr(fhp, fhp->fh_export, fhp->fh_dentry,
+				    resp->p, &buflen, getattr->ga_bmval);
+
+	if (!nfserr)
+		resp->p += buflen;
+	return nfserr;
+}
+
+static void
+nfsd4_encode_getfh(struct nfsd4_compoundres *resp, int nfserr, struct svc_fh *fhp)
+{
+	unsigned int len;
+	ENCODE_HEAD;
+
+	if (!nfserr) {
+		len = fhp->fh_handle.fh_size;
+		RESERVE_SPACE(len + 4);
+		WRITE32(len);
+		WRITEMEM(&fhp->fh_handle.fh_base, len);
+		ADJUST_ARGS();
+	}
+}
+
+static void
+nfsd4_encode_link(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_link *link)
+{
+	ENCODE_HEAD;
+
+	if (!nfserr) {
+		RESERVE_SPACE(20);
+		WRITECINFO(link->li_cinfo);
+		ADJUST_ARGS();
+	}
+}
+
+
+static void
+nfsd4_encode_open(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_open *open)
+{
+	ENCODE_HEAD;
+
+	if (nfserr)
+		return;
+
+	RESERVE_SPACE(36 + sizeof(stateid_t));
+	WRITE32(open->op_stateid.st_generation);
+	WRITEMEM(&open->op_stateid.st_other, sizeof(stateid_other_t));
+	WRITECINFO(open->op_cinfo);
+	WRITE32(open->op_rflags);
+	WRITE32(2);
+	WRITE32(open->op_bmval[0]);
+	WRITE32(open->op_bmval[1]);
+	WRITE32(open->op_delegate_type);
+	ADJUST_ARGS();
+
+	switch (open->op_delegate_type) {
+	case NFS4_OPEN_DELEGATE_NONE:
+		break;
+	case NFS4_OPEN_DELEGATE_READ:
+		RESERVE_SPACE(20 + sizeof(delegation_stateid_t));
+		WRITEMEM(&open->op_delegate_stateid, sizeof(delegation_stateid_t));
+		WRITE32(0);
+
+		/*
+		 * TODO: ACE's in delegations
+		 */
+		WRITE32(NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE);
+		WRITE32(0);
+		WRITE32(0);
+		WRITE32(0);   /* XXX: is NULL principal ok? */
+		ADJUST_ARGS();
+		break;
+	case NFS4_OPEN_DELEGATE_WRITE:
+		RESERVE_SPACE(32 + sizeof(delegation_stateid_t));
+		WRITEMEM(&open->op_delegate_stateid, sizeof(delegation_stateid_t));
+		WRITE32(0);
+
+		/*
+		 * TODO: space_limit's in delegations
+		 */
+		WRITE32(NFS4_LIMIT_SIZE);
+		WRITE32(~(u32)0);
+		WRITE32(~(u32)0);
+
+		/*
+		 * TODO: ACE's in delegations
+		 */
+		WRITE32(NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE);
+		WRITE32(0);
+		WRITE32(0);
+		WRITE32(0);   /* XXX: is NULL principal ok? */
+		ADJUST_ARGS();
+		break;
+	default:
+		BUG();
+	}
+}
+
+static int
+nfsd4_encode_read(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_read *read)
+{
+	u32 eof;
+	unsigned long maxcount;
+	ENCODE_HEAD;
+
+	if (nfserr)
+		return nfserr;
+
+	maxcount = (char *)resp->end - (char *)resp->p - COMPOUND_ERR_SLACK_SPACE - 8;
+	if (maxcount > read->rd_length)
+		maxcount = read->rd_length;
+	RESERVE_SPACE(maxcount + 8);
+
+	nfserr = nfsd_read(read->rd_rqstp, read->rd_fhp,
+			   read->rd_offset, (char *)p + 8, &maxcount);
+	if (nfserr)
+		return nfserr;
+	eof = (read->rd_offset + maxcount >= read->rd_fhp->fh_dentry->d_inode->i_size);
+
+	WRITE32(eof);
+	WRITE32(maxcount);
+	p += XDR_QUADLEN(maxcount);
+	ADJUST_ARGS();
+	return 0;
+}
+
+static int
+nfsd4_encode_readlink(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_readlink *readlink)
+{
+	int maxcount;
+	ENCODE_HEAD;
+
+	if (nfserr)
+		return nfserr;
+
+	maxcount = (char *)resp->end - (char *)resp->p - COMPOUND_ERR_SLACK_SPACE - 4;
+	RESERVE_SPACE(maxcount + 4);
+
+	/*
+	 * XXX: By default, the ->readlink() VFS op will truncate symlinks
+	 * if they would overflow the buffer.  Is this kosher in NFSv4?  If
+	 * not, one easy fix is: if ->readlink() precisely fills the buffer,
+	 * assume that truncation occured, and return NFS4ERR_RESOURCE.
+	 */
+	nfserr = nfsd_readlink(readlink->rl_rqstp, readlink->rl_fhp, (char *)p + 4, &maxcount);
+	if (nfserr)
+		return nfserr;
+
+	WRITE32(maxcount);
+	p += XDR_QUADLEN(maxcount);
+	ADJUST_ARGS();
+	return 0;
+}
+
+static int
+nfsd4_encode_readdir(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_readdir *readdir)
+{
+	int maxcount;
+	ENCODE_HEAD;
+
+	if (nfserr)
+		return nfserr;
+
+	RESERVE_SPACE(16);
+
+	maxcount = (char *)resp->end - (char *)p - COMPOUND_ERR_SLACK_SPACE;
+	if (maxcount > readdir->rd_maxcount)
+		maxcount = readdir->rd_maxcount;
+
+	/*
+	 * Convert from bytes to words, account for the two words already
+	 * written, make sure to leave two words at the end for the next
+	 * pointer and eof field.
+	 */
+	maxcount = (maxcount >> 2) - 4;
+	if (maxcount < 0)
+		return nfserr_readdir_nospc;
+
+	/* XXX: Following NFSv3, we ignore the READDIR verifier for now. */
+	WRITE32(0);
+	WRITE32(0);
+
+	nfserr = nfsd_readdir(readdir->rd_rqstp, readdir->rd_fhp,
+			      readdir->rd_cookie, nfsd4_encode_dirent,
+			      p, &maxcount, NULL, readdir->rd_bmval);
+	if (!nfserr) {
+		/*
+		 * nfsd_readdir() expects 'maxcount' to be a count of
+		 * words, but fills it in with a count of bytes at the
+		 * end!
+		 */
+		BUG_ON(maxcount & 3);
+		p += (maxcount >> 2);
+		ADJUST_ARGS();
+	}
+	return nfserr;
+}
+
+static void
+nfsd4_encode_remove(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_remove *remove)
+{
+	ENCODE_HEAD;
+
+	if (!nfserr) {
+		RESERVE_SPACE(20);
+		WRITECINFO(remove->rm_cinfo);
+		ADJUST_ARGS();
+	}
+}
+
+static void
+nfsd4_encode_rename(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_rename *rename)
+{
+	ENCODE_HEAD;
+
+	if (!nfserr) {
+		RESERVE_SPACE(40);
+		WRITECINFO(rename->rn_sinfo);
+		WRITECINFO(rename->rn_tinfo);
+		ADJUST_ARGS();
+	}
+}
+
+/*
+ * The SETATTR encode routine is special -- it always encodes a bitmap,
+ * regardless of the error status.
+ */
+static void
+nfsd4_encode_setattr(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_setattr *setattr)
+{
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(12);
+	if (nfserr) {
+		WRITE32(2);
+		WRITE32(0);
+		WRITE32(0);
+	}
+	else {
+		WRITE32(2);
+		WRITE32(setattr->sa_bmval[0]);
+		WRITE32(setattr->sa_bmval[1]);
+	}
+	ADJUST_ARGS();
+}
+
+static void
+nfsd4_encode_setclientid(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_setclientid *scd)
+{
+	ENCODE_HEAD;
+
+	if (!nfserr) {
+		RESERVE_SPACE(8);
+		WRITEMEM(&scd->se_clientid, 8);
+		ADJUST_ARGS();
+	}
+	else if (nfserr == nfserr_clid_inuse) {
+		RESERVE_SPACE(8);
+		WRITE32(0);
+		WRITE32(0);
+		ADJUST_ARGS();
+	}
+}
+
+static void
+nfsd4_encode_write(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_write *write)
+{
+	ENCODE_HEAD;
+
+	if (!nfserr) {
+		RESERVE_SPACE(16);
+		WRITE32(write->wr_bytes_written);
+		WRITE32(write->wr_how_written);
+		WRITEMEM(write->wr_verifier, 8);
+		ADJUST_ARGS();
+	}
+}
+
+void
+nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
+{
+	u32 *statp;
+	ENCODE_HEAD;
+
+	RESERVE_SPACE(8);
+	WRITE32(op->opnum);
+	statp = p++;                  /* to be backfilled at the end */
+	ADJUST_ARGS();
+
+	switch (op->opnum) {
+	case OP_ACCESS:
+		nfsd4_encode_access(resp, op->status, &op->u.access);
+		break;
+	case OP_CLOSE:
+		nfsd4_encode_close(resp, op->status, &op->u.close);
+		break;
+	case OP_COMMIT:
+		nfsd4_encode_commit(resp, op->status, &op->u.commit);
+		break;
+	case OP_CREATE:
+		nfsd4_encode_create(resp, op->status, &op->u.create);
+		break;
+	case OP_GETATTR:
+		op->status = nfsd4_encode_getattr(resp, op->status, &op->u.getattr);
+		break;
+	case OP_GETFH:
+		nfsd4_encode_getfh(resp, op->status, op->u.getfh);
+		break;
+	case OP_LINK:
+		nfsd4_encode_link(resp, op->status, &op->u.link);
+		break;
+	case OP_LOOKUP:
+		break;
+	case OP_LOOKUPP:
+		break;
+	case OP_NVERIFY:
+		break;
+	case OP_OPEN:
+		nfsd4_encode_open(resp, op->status, &op->u.open);
+		break;
+	case OP_PUTFH:
+		break;
+	case OP_PUTROOTFH:
+		break;
+	case OP_READ:
+		op->status = nfsd4_encode_read(resp, op->status, &op->u.read);
+		break;
+	case OP_READDIR:
+		op->status = nfsd4_encode_readdir(resp, op->status, &op->u.readdir);
+		break;
+	case OP_READLINK:
+		op->status = nfsd4_encode_readlink(resp, op->status, &op->u.readlink);
+		break;
+	case OP_REMOVE:
+		nfsd4_encode_remove(resp, op->status, &op->u.remove);
+		break;
+	case OP_RENAME:
+		nfsd4_encode_rename(resp, op->status, &op->u.rename);
+		break;
+	case OP_RENEW:
+		break;
+	case OP_RESTOREFH:
+		break;
+	case OP_SAVEFH:
+		break;
+	case OP_SETATTR:
+		nfsd4_encode_setattr(resp, op->status, &op->u.setattr);
+		break;
+	case OP_SETCLIENTID:
+		nfsd4_encode_setclientid(resp, op->status, &op->u.setclientid);
+		break;
+	case OP_SETCLIENTID_CONFIRM:
+		break;
+	case OP_VERIFY:
+		break;
+	case OP_WRITE:
+		nfsd4_encode_write(resp, op->status, &op->u.write);
+		break;
+	default:
+		break;
+	}
+
+	/*
+	 * Note: We write the status directly, instead of using WRITE32(),
+	 * since it is already in network byte order.
+	 */
+	*statp = op->status;
+}
+
+/*
+ * END OF "GENERIC" ENCODE ROUTINES.
+ */
+
+static inline int
+xdr_ressize_check(struct svc_rqst *rqstp, u32 *p)
+{
+	struct svc_buf	*buf = &rqstp->rq_resbuf;
+
+	buf->len = p - buf->base;
+	dprintk("nfsd: ressize_check p %p base %p len %d\n",
+			p, buf->base, buf->buflen);
+	return (buf->len <= buf->buflen);
+}
+
+int
+nfs4svc_encode_voidres(struct svc_rqst *rqstp, u32 *p, void *dummy)
+{
+        return xdr_ressize_check(rqstp, p);
+}
+
+int
+nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, u32 *p, struct nfsd4_compoundargs *args)
+{
+	int status;
+
+	args->p = p;
+	args->end = rqstp->rq_argbuf.base + rqstp->rq_argbuf.buflen;
+	args->ops = args->iops;
+
+	status = nfsd4_decode_compound(args);
+	if (status && args->ops != args->iops) {
+		kfree(args->ops);
+		args->ops = args->iops;
+	}
+	return !status;
+}
+
+int
+nfs4svc_encode_compoundres(struct svc_rqst *rqstp, u32 *p, struct nfsd4_compoundres *resp)
+{
+	/*
+	 * All that remains is to write the tag and operation count...
+	 */
+	*p++ = htonl(resp->taglen);
+	memcpy(p, resp->tag, resp->taglen);
+	p += XDR_QUADLEN(resp->taglen);
+	*p++ = htonl(resp->opcnt);
+
+	BUG_ON(!xdr_ressize_check(rqstp, resp->p));
+	return 1;
+}
+
+/*
+ * Local variables:
+ *  c-basic-offset: 8
+ * End:
+ */

