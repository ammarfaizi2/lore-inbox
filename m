Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSJPVJg>; Wed, 16 Oct 2002 17:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261393AbSJPVJg>; Wed, 16 Oct 2002 17:09:36 -0400
Received: from ns.suse.de ([213.95.15.193]:15368 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261375AbSJPVJf>;
	Wed, 16 Oct 2002 17:09:35 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Andrew Morton <akpm@digeo.com>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] linux-2.5.43-mm1: Further xattr/acl cleanups
Date: Wed, 16 Oct 2002 23:15:32 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <E181a3S-0006Nq-00@snap.thunk.org> <3DAD8D5E.31E177BA@digeo.com> <200210162232.00441.agruen@suse.de>
In-Reply-To: <200210162232.00441.agruen@suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_W1F3L2U4VCJ19TX1DXJ6"
Message-Id: <200210162315.32574.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_W1F3L2U4VCJ19TX1DXJ6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This should do for now as a replacement for nfsd_get_posix_acl(), the onl=
y=20
caller of ->[gs]et_posix_acl(). Please add along with the other NFS patch=
es.=20
(Did Ted port them already?)

--Andreas.
--------------Boundary-00=_W1F3L2U4VCJ19TX1DXJ6
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="mm1-incr2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mm1-incr2.diff"

This version of nfsd_get_posix_acl uses getxattr instead of the
discarded get_posix_acl inode operation.

diff -Nur linux-2.5.43-mm1+/fs/nfsd/vfs.c linux-2.5.43-mm1++/fs/nfsd/vfs.c
--- linux-2.5.43-mm1+/fs/nfsd/vfs.c	2002-10-16 05:27:53.000000000 +0200
+++ linux-2.5.43-mm1++/fs/nfsd/vfs.c	2002-10-16 23:02:39.000000000 +0200
@@ -42,6 +42,7 @@
 #endif /* CONFIG_NFSD_V3 */
 #include <linux/nfsd/nfsfh.h>
 #include <linux/quotaops.h>
+#include <linux/xattr_acl.h>
 
 #include <asm/uaccess.h>
 
@@ -1609,3 +1610,29 @@
 	nfsdstats.ra_size = cache_size;
 	return 0;
 }
+
+#ifdef CONFIG_FS_POSIX_ACL
+struct posix_acl *
+nfsd_get_posix_acl(struct svc_fh *fhp, int type)
+{
+	struct inode *inode = fhp->fh_dentry->d_inode;
+	struct posix_acl *acl = NULL;
+
+	if (IS_POSIXACL(inode)) {
+		int err, size = xattr_acl_size(64);  /* reasonable max.size */
+		void *buffer = kmalloc(size, GFP_KERNEL);
+		if (!buffer)
+			return ERR_PTR(-ENOMEM);
+		if (!fhp->fh_locked)
+			fh_lock(fhp);  /* automatic unlocking */
+		err = inode->i_op->getxattr(fhp->fh_dentry,
+					    XATTR_NAME_ACL_ACCESS,
+					    buffer, size);
+		acl = ERR_PTR(err);
+		if (err >= 0)
+			acl = posix_acl_from_xattr(buffer, err);
+		kfree(buffer);
+	}
+	return acl;
+}
+#endif

--------------Boundary-00=_W1F3L2U4VCJ19TX1DXJ6--

