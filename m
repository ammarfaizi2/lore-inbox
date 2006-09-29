Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWI2DJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWI2DJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 23:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWI2DJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 23:09:50 -0400
Received: from mail.suse.de ([195.135.220.2]:50065 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161155AbWI2DJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 23:09:24 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 29 Sep 2006 13:09:18 +1000
Message-Id: <1060929030918.24120@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 007 of 8] knfsd: nfsd4: xdr encoding for fs_locations
References: <20060929130518.23919.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

Encode fs_locations attribute.

Signed-off-by: Manoj Naik <manoj@almaden.ibm.com>
Signed-off-by: Fred Isaman <iisaman@citi.umich.edu>
Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4xdr.c         |  125 ++++++++++++++++++++++++++++++++++++++++++++
 ./include/linux/nfsd/nfsd.h |    3 -
 2 files changed, 126 insertions(+), 2 deletions(-)

diff .prev/fs/nfsd/nfs4xdr.c ./fs/nfsd/nfs4xdr.c
--- .prev/fs/nfsd/nfs4xdr.c	2006-09-29 12:57:28.000000000 +1000
+++ ./fs/nfsd/nfs4xdr.c	2006-09-29 13:04:07.000000000 +1000
@@ -1224,6 +1224,119 @@ nfsd4_decode_compound(struct nfsd4_compo
  			stateowner->so_replay.rp_buflen); 	\
 	} } while (0);
 
+/* Encode as an array of strings the string given with components
+ * seperated @sep.
+ */
+static int nfsd4_encode_components(char sep, char *components,
+				   u32 **pp, int *buflen)
+{
+	u32 *p = *pp;
+	u32 *countp = p;
+	int strlen, count=0;
+	char *str, *end;
+
+	dprintk("nfsd4_encode_components(%s)\n", components);
+	if ((*buflen -= 4) < 0)
+		return nfserr_resource;
+	WRITE32(0); /* We will fill this in with @count later */
+	end = str = components;
+	while (*end) {
+		for (; *end && (*end != sep); end++)
+			; /* Point to end of component */
+		strlen = end - str;
+		if (strlen) {
+			if ((*buflen -= ((XDR_QUADLEN(strlen) << 2) + 4)) < 0)
+				return nfserr_resource;
+			WRITE32(strlen);
+			WRITEMEM(str, strlen);
+			count++;
+		}
+		else
+			end++;
+		str = end;
+	}
+	*pp = p;
+	p = countp;
+	WRITE32(count);
+	return 0;
+}
+
+/*
+ * encode a location element of a fs_locations structure
+ */
+static int nfsd4_encode_fs_location4(struct nfsd4_fs_location *location,
+				    u32 **pp, int *buflen)
+{
+	int status;
+	u32 *p = *pp;
+
+	status = nfsd4_encode_components(':', location->hosts, &p, buflen);
+	if (status)
+		return status;
+	status = nfsd4_encode_components('/', location->path, &p, buflen);
+	if (status)
+		return status;
+	*pp = p;
+	return 0;
+}
+
+/*
+ * Return the path to an export point in the pseudo filesystem namespace
+ * Returned string is safe to use as long as the caller holds a reference
+ * to @exp.
+ */
+static char *nfsd4_path(struct svc_rqst *rqstp, struct svc_export *exp)
+{
+	struct svc_fh tmp_fh;
+	char *path, *rootpath;
+	int stat;
+
+	fh_init(&tmp_fh, NFS4_FHSIZE);
+	stat = exp_pseudoroot(rqstp->rq_client, &tmp_fh, &rqstp->rq_chandle);
+	if (stat)
+		return ERR_PTR(stat);
+	rootpath = tmp_fh.fh_export->ex_path;
+
+	path = exp->ex_path;
+
+	if (strncmp(path, rootpath, strlen(rootpath))) {
+		printk("nfsd: fs_locations failed;"
+			"%s is not contained in %s\n", path, rootpath);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	return path + strlen(rootpath);
+}
+
+/*
+ *  encode a fs_locations structure
+ */
+static int nfsd4_encode_fs_locations(struct svc_rqst *rqstp,
+				     struct svc_export *exp,
+				     u32 **pp, int *buflen)
+{
+	int status, i;
+	u32 *p = *pp;
+	struct nfsd4_fs_locations *fslocs = &exp->ex_fslocs;
+	char *root = nfsd4_path(rqstp, exp);
+
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+	status = nfsd4_encode_components('/', root, &p, buflen);
+	if (status)
+		return status;
+	if ((*buflen -= 4) < 0)
+		return nfserr_resource;
+	WRITE32(fslocs->locations_count);
+	for (i=0; i<fslocs->locations_count; i++) {
+		status = nfsd4_encode_fs_location4(&fslocs->locations[i],
+						   &p, buflen);
+		if (status)
+			return status;
+	}
+	*pp = p;
+	return 0;
+}
 
 static u32 nfs4_ftypes[16] = {
         NF4BAD,  NF4FIFO, NF4CHR, NF4BAD,
@@ -1335,6 +1448,11 @@ nfsd4_encode_fattr(struct svc_fh *fhp, s
 				goto out_nfserr;
 		}
 	}
+	if (bmval0 & FATTR4_WORD0_FS_LOCATIONS) {
+		if (exp->ex_fslocs.locations == NULL) {
+			bmval0 &= ~FATTR4_WORD0_FS_LOCATIONS;
+		}
+	}
 	if ((buflen -= 16) < 0)
 		goto out_resource;
 
@@ -1514,6 +1632,13 @@ out_acl:
 			goto out_resource;
 		WRITE64((u64) statfs.f_files);
 	}
+	if (bmval0 & FATTR4_WORD0_FS_LOCATIONS) {
+		status = nfsd4_encode_fs_locations(rqstp, exp, &p, &buflen);
+		if (status == nfserr_resource)
+			goto out_resource;
+		if (status)
+			goto out;
+	}
 	if (bmval0 & FATTR4_WORD0_HOMOGENEOUS) {
 		if ((buflen -= 4) < 0)
 			goto out_resource;

diff .prev/include/linux/nfsd/nfsd.h ./include/linux/nfsd/nfsd.h
--- .prev/include/linux/nfsd/nfsd.h	2006-09-29 12:57:28.000000000 +1000
+++ ./include/linux/nfsd/nfsd.h	2006-09-29 13:04:07.000000000 +1000
@@ -292,7 +292,6 @@ static inline int is_fsid(struct svc_fh 
 /*
  * The following attributes are currently not supported by the NFSv4 server:
  *    ARCHIVE       (deprecated anyway)
- *    FS_LOCATIONS  (will be supported eventually)
  *    HIDDEN        (unlikely to be supported any time soon)
  *    MIMETYPE      (unlikely to be supported any time soon)
  *    QUOTA_*       (will be supported in a forthcoming patch)
@@ -308,7 +307,7 @@ static inline int is_fsid(struct svc_fh 
  | FATTR4_WORD0_ACLSUPPORT      | FATTR4_WORD0_CANSETTIME   | FATTR4_WORD0_CASE_INSENSITIVE \
  | FATTR4_WORD0_CASE_PRESERVING | FATTR4_WORD0_CHOWN_RESTRICTED                             \
  | FATTR4_WORD0_FILEHANDLE      | FATTR4_WORD0_FILEID       | FATTR4_WORD0_FILES_AVAIL      \
- | FATTR4_WORD0_FILES_FREE      | FATTR4_WORD0_FILES_TOTAL  | FATTR4_WORD0_HOMOGENEOUS      \
+ | FATTR4_WORD0_FILES_FREE      | FATTR4_WORD0_FILES_TOTAL  | FATTR4_WORD0_FS_LOCATIONS | FATTR4_WORD0_HOMOGENEOUS      \
  | FATTR4_WORD0_MAXFILESIZE     | FATTR4_WORD0_MAXLINK      | FATTR4_WORD0_MAXNAME          \
  | FATTR4_WORD0_MAXREAD         | FATTR4_WORD0_MAXWRITE     | FATTR4_WORD0_ACL)
 
