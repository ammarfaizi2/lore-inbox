Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319150AbSHMXJ0>; Tue, 13 Aug 2002 19:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319106AbSHMXIJ>; Tue, 13 Aug 2002 19:08:09 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:16381 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319101AbSHMXHx>; Tue, 13 Aug 2002 19:07:53 -0400
Date: Tue, 13 Aug 2002 19:11:42 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 35/38: SERVER: new routine exp_pseudoroot() [trivial for now]
Message-ID: <Pine.SOL.4.44.0208131911200.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch defines exp_pseudoroot(), which is used to set the filehandle
for the root of the pseudofs.  Right now, we just use the root of an
arbitrarily-selected export.  This is just a placeholder until the
pseudofs is properly implemented in 2.5.

--- old/include/linux/nfsd/export.h	Wed Jul 24 16:03:17 2002
+++ new/include/linux/nfsd/export.h	Mon Jul 29 11:50:09 2002
@@ -101,6 +101,7 @@ struct svc_export *	exp_get_by_name(stru
 					struct dentry *dentry);
 int			exp_rootfh(struct svc_client *,
 					char *path, struct knfsd_fh *, int maxsize);
+int			exp_pseudoroot(struct svc_client *, struct svc_fh *fhp);
 int			nfserrno(int errno);
 void			exp_nlmdetach(void);

--- old/fs/nfsd/export.c	Wed Jul 24 16:03:29 2002
+++ new/fs/nfsd/export.c	Mon Jul 29 11:50:09 2002
@@ -498,6 +498,24 @@ out:
 	return err;
 }

+/*
+ * Called when we need the filehandle for the root of the pseudofs,
+ * for a given NFSv4 client.  XXX: For the moment, we just use the
+ * root dentry of an arbitarily-selected export.  A real implementation
+ * of the NFSv4 pseudofs will come in a subsequent patch.
+ */
+int
+exp_pseudoroot(struct svc_client *clp, struct svc_fh *fhp)
+{
+	struct svc_export *exp;
+
+	if (!clp || list_empty(&clp->cl_list))
+		return nfserr_perm;
+
+	exp = list_entry(clp->cl_list.next, struct svc_export, ex_list);
+	dget(exp->ex_dentry);
+	return fh_compose(fhp, exp, exp->ex_dentry, NULL);
+}

 /*
  * Find a valid client given an inet address. We always move the most

