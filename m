Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVFGNl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVFGNl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 09:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVFGNl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 09:41:56 -0400
Received: from pat.uio.no ([129.240.130.16]:37517 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261865AbVFGNl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 09:41:27 -0400
Subject: Re: NFS: NFS3 lookup fails if creating a file with O_EXCL &
	multiple mountpoints in pathname
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: linda.dunaphant@ccur.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1118111348.13894.29.camel@lindad>
References: <1112921570.6182.16.camel@lindad>
	 <1112965872.15565.34.camel@lade.trondhjem.org>
	 <1112993686.7459.4.camel@lindad>  <1113009804.7459.9.camel@lindad>
	 <1118104107.13894.20.camel@lindad>  <1118111348.13894.29.camel@lindad>
Content-Type: multipart/mixed; boundary="=-NXi1CCX9PqOs9Zpp76pd"
Date: Tue, 07 Jun 2005 09:41:14 -0400
Message-Id: <1118151674.11440.39.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.545, required 12,
	autolearn=disabled, AWL 1.27, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NXi1CCX9PqOs9Zpp76pd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

m=C3=A5 den 06.06.2005 Klokka 22:29 (-0400) skreiv Linda Dunaphant:
> I changed the nfs_is_exclusive_create() to use the LOOKUP_PARENT
> flag instead of the LOOKUP_CONTINUE flag. I found that LOOKUP_PARENT
> stays set until you get to the very last pathname level, which is
> the correct point for it to check whether it is an exclusive create.

The intent information as it stands today should really only be applied
if we're looking up the very last path component of an open()/create()
or access() call. When we're walking the path doing lookups, that rule
basically boils down to: never apply the intent if either
LOOKUP_CONTINUE or LOOKUP_PARENT are set.

It therefore turns out that your patch is in fact a valid fix in the
case of nfs_is_exclusive_create() since the VFS is guaranteed to always
call LOOKUP_PARENT first (my apologies).
However, when hunting through the NFS lookup code, I found several other
cases where we check for an intent and where we do need the more general
test. To avoid confusion, I'd therefore prefer to introduce a helper
that _always_ returns the correct intent information for the component
that is being looked up.

Could you therefore check if this patch works for you?

Cheers,
  Trond


--=-NXi1CCX9PqOs9Zpp76pd
Content-Disposition: inline; filename=linux-2.6.12-00-fix_O_EXCL.dif
Content-Type: text/plain; name=linux-2.6.12-00-fix_O_EXCL.dif; charset=UTF-8
Content-Transfer-Encoding: 7bit

[NFS] Fix lookup intent handling

 We should never apply a lookup intent to the path component of a
 LOOKUP_PARENT call.
 Introduce nd_lookup_intent() which always returns zero if LOOKUP_CONTINUE
 or LOOKUP_PARENT is set, and otherwise returns the intent flags.

 Problem noticed by Linda Dunaphant <linda.dunaphant@ccur.com>
 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---
 dir.c |   49 +++++++++++++++++++++++++++++++++++--------------
 1 files changed, 35 insertions(+), 14 deletions(-)

Index: linux-2.6.12-rc6/fs/nfs/dir.c
===================================================================
--- linux-2.6.12-rc6.orig/fs/nfs/dir.c
+++ linux-2.6.12-rc6/fs/nfs/dir.c
@@ -528,19 +528,39 @@ static inline void nfs_renew_times(struc
 	dentry->d_time = jiffies;
 }
 
+/*
+ * Return the intent data that applies to this particular path component
+ *
+ * Note that the current set of intents only apply to the very last
+ * component of the path.
+ * We check for this using LOOKUP_CONTINUE and LOOKUP_PARENT.
+ */
+static inline unsigned int lookup_check_intent(struct nameidata *nd, unsigned int mask)
+{
+	if (nd->flags & (LOOKUP_CONTINUE|LOOKUP_PARENT))
+		return 0;
+	return nd->flags & mask;
+}
+
+/*
+ * Inode and filehandle revalidation for lookups.
+ *
+ * We force revalidation in the cases where the VFS sets LOOKUP_REVAL,
+ * or if the intent information indicates that we're about to open this
+ * particular file and the "nocto" mount flag is not set.
+ *
+ */
 static inline
 int nfs_lookup_verify_inode(struct inode *inode, struct nameidata *nd)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
 
 	if (nd != NULL) {
-		int ndflags = nd->flags;
 		/* VFS wants an on-the-wire revalidation */
-		if (ndflags & LOOKUP_REVAL)
+		if (nd->flags & LOOKUP_REVAL)
 			goto out_force;
 		/* This is an open(2) */
-		if ((ndflags & LOOKUP_OPEN) &&
-				!(ndflags & LOOKUP_CONTINUE) &&
+		if (lookup_check_intent(nd, LOOKUP_OPEN) != 0 &&
 				!(server->flags & NFS_MOUNT_NOCTO))
 			goto out_force;
 	}
@@ -560,12 +580,8 @@ static inline
 int nfs_neg_need_reval(struct inode *dir, struct dentry *dentry,
 		       struct nameidata *nd)
 {
-	int ndflags = 0;
-
-	if (nd)
-		ndflags = nd->flags;
 	/* Don't revalidate a negative dentry if we're creating a new file */
-	if ((ndflags & LOOKUP_CREATE) && !(ndflags & LOOKUP_CONTINUE))
+	if (nd != NULL && lookup_check_intent(nd, LOOKUP_CREATE) != 0)
 		return 0;
 	return !nfs_check_verifier(dir, dentry);
 }
@@ -700,12 +716,16 @@ struct dentry_operations nfs_dentry_oper
 	.d_iput		= nfs_dentry_iput,
 };
 
+/*
+ * Use intent information to check whether or not we're going to do
+ * an O_EXCL create using this path component.
+ */
 static inline
 int nfs_is_exclusive_create(struct inode *dir, struct nameidata *nd)
 {
 	if (NFS_PROTO(dir)->version == 2)
 		return 0;
-	if (!nd || (nd->flags & LOOKUP_CONTINUE) || !(nd->flags & LOOKUP_CREATE))
+	if (nd == NULL || lookup_check_intent(nd, LOOKUP_CREATE) == 0)
 		return 0;
 	return (nd->intent.open.flags & O_EXCL) != 0;
 }
@@ -772,12 +792,13 @@ struct dentry_operations nfs4_dentry_ope
 	.d_iput		= nfs_dentry_iput,
 };
 
+/*
+ * Use intent information to determine whether we need to substitute
+ * the NFSv4-style stateful OPEN for the LOOKUP call
+ */
 static int is_atomic_open(struct inode *dir, struct nameidata *nd)
 {
-	if (!nd)
-		return 0;
-	/* Check that we are indeed trying to open this file */
-	if ((nd->flags & LOOKUP_CONTINUE) || !(nd->flags & LOOKUP_OPEN))
+	if (nd == NULL || lookup_check_intent(nd, LOOKUP_OPEN) == 0)
 		return 0;
 	/* NFS does not (yet) have a stateful open for directories */
 	if (nd->flags & LOOKUP_DIRECTORY)

--=-NXi1CCX9PqOs9Zpp76pd--

