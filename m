Return-Path: <linux-kernel-owner+w=401wt.eu-S932667AbXAQTcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbXAQTcH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 14:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbXAQTcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 14:32:07 -0500
Received: from gra-lx1.iram.es ([150.214.224.41]:33149 "EHLO gra-lx1.iram.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932667AbXAQTcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 14:32:06 -0500
X-Greylist: delayed 1780 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2007 14:32:06 EST
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 17 Jan 2007 20:02:18 +0100
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>
Subject: [PATCH] nfs: Fix mismatch between encode_dent_fn and filldir_t
Message-ID: <20070117190218.GA23901@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 5th parameter of filldir_t function type used by vfs_readdir
was changed from ino_t to u64 in October. Unfortunately the patch 
missed some files in fs/nfsd where functions pointers of type 
encode_dent_fn are passed around and finally cast to filldir_t.

The effect is only visible when an NFS server is run on a 32 bit
big-endian machine (it would have been visible on all 32 bit
architectures if the 6th parameter had been used). The results
are interesting: all files have an inode of 0 (unique you say?) 
from getdents(2) and even ls(1) does not find any files.

Signed-off-by: Gabriel Paubert <paubert@iram.es>

--

P.S.: this shows that function pointer casts are evil, but I did not 
find a simpler way to fix this.

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 277df40..20c5f4a 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -991,14 +991,14 @@ encode_entry(struct readdir_cd *ccd, const char *name,
 
 int
 nfs3svc_encode_entry(struct readdir_cd *cd, const char *name,
-		     int namlen, loff_t offset, ino_t ino, unsigned int d_type)
+		     int namlen, loff_t offset, u64 ino, unsigned int d_type)
 {
 	return encode_entry(cd, name, namlen, offset, ino, d_type, 0);
 }
 
 int
 nfs3svc_encode_entry_plus(struct readdir_cd *cd, const char *name,
-			  int namlen, loff_t offset, ino_t ino, unsigned int d_type)
+			  int namlen, loff_t offset, u64 ino, unsigned int d_type)
 {
 	return encode_entry(cd, name, namlen, offset, ino, d_type, 1);
 }
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index f5243f9..244406e 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -463,7 +463,7 @@ nfssvc_encode_statfsres(struct svc_rqst *rqstp, __be32 *p,
 
 int
 nfssvc_encode_entry(struct readdir_cd *ccd, const char *name,
-		    int namlen, loff_t offset, ino_t ino, unsigned int d_type)
+		    int namlen, loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct nfsd_readdirres *cd = container_of(ccd, struct nfsd_readdirres, common);
 	__be32	*p = cd->buffer;
diff --git a/include/linux/nfsd/nfsd.h b/include/linux/nfsd/nfsd.h
index 0727774..3ba5141 100644
--- a/include/linux/nfsd/nfsd.h
+++ b/include/linux/nfsd/nfsd.h
@@ -53,7 +53,7 @@ struct readdir_cd {
 	__be32			err;	/* 0, nfserr, or nfserr_eof */
 };
 typedef int		(*encode_dent_fn)(struct readdir_cd *, const char *,
-						int, loff_t, ino_t, unsigned int);
+						int, loff_t, u64, unsigned int);
 typedef int (*nfsd_dirop_t)(struct inode *, struct dentry *, int, int);
 
 extern struct svc_program	nfsd_program;
diff --git a/include/linux/nfsd/xdr.h b/include/linux/nfsd/xdr.h
index 877192d..328520c 100644
--- a/include/linux/nfsd/xdr.h
+++ b/include/linux/nfsd/xdr.h
@@ -166,7 +166,7 @@ int nfssvc_encode_statfsres(struct svc_rqst *, __be32 *, struct nfsd_statfsres *
 int nfssvc_encode_readdirres(struct svc_rqst *, __be32 *, struct nfsd_readdirres *);
 
 int nfssvc_encode_entry(struct readdir_cd *, const char *name,
-				int namlen, loff_t offset, ino_t ino, unsigned int);
+				int namlen, loff_t offset, u64 ino, unsigned int);
 
 int nfssvc_release_fhandle(struct svc_rqst *, __be32 *, struct nfsd_fhandle *);
 
diff --git a/include/linux/nfsd/xdr3.h b/include/linux/nfsd/xdr3.h
index 7996386..bc8b171 100644
--- a/include/linux/nfsd/xdr3.h
+++ b/include/linux/nfsd/xdr3.h
@@ -332,10 +332,10 @@ int nfs3svc_release_fhandle(struct svc_rqst *, __be32 *,
 int nfs3svc_release_fhandle2(struct svc_rqst *, __be32 *,
 				struct nfsd3_fhandle_pair *);
 int nfs3svc_encode_entry(struct readdir_cd *, const char *name,
-				int namlen, loff_t offset, ino_t ino,
+				int namlen, loff_t offset, u64 ino,
 				unsigned int);
 int nfs3svc_encode_entry_plus(struct readdir_cd *, const char *name,
-				int namlen, loff_t offset, ino_t ino,
+				int namlen, loff_t offset, u64 ino,
 				unsigned int);
 /* Helper functions for NFSv3 ACL code */
 __be32 *nfs3svc_encode_post_op_attr(struct svc_rqst *rqstp, __be32 *p,
