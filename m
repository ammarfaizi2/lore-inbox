Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311245AbSCLPhI>; Tue, 12 Mar 2002 10:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311243AbSCLPg5>; Tue, 12 Mar 2002 10:36:57 -0500
Received: from pat.uio.no ([129.240.130.16]:1990 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S311244AbSCLPgg>;
	Tue, 12 Mar 2002 10:36:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15502.8314.512126.988749@charged.uio.no>
Date: Tue, 12 Mar 2002 16:36:26 +0100
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] 2.4.19-pre3 NFS close-to-open fix part 2 (VFS change)
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  The following patch fixes the one remaining hole in the
NFS close-to-open checking. It is due to the VFS assuming that it
doesn't have to revalidate the dentry when one does open("."), or
open(".."). This means that the NFS layer is never notified that it
needs to check the data cache integrity for this case.


Al has said he plans to plug this hole in 2.5.x as part of his unionfs
changes, however we also need a fix in 2.4.x. Other networked
filesystems (Alan has mentioned OpenGFS) are also having the same
problem...
Unless Al has a different suggestion (Al?), the following patch
inserts the necessary lines into link_path_walk().

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.19-fix_put/fs/namei.c linux-2.4.19-cto/fs/namei.c
--- linux-2.4.19-fix_put/fs/namei.c	Tue Mar 12 14:58:54 2002
+++ linux-2.4.19-cto/fs/namei.c	Tue Mar 12 15:35:02 2002
@@ -457,7 +457,7 @@
 	while (*name=='/')
 		name++;
 	if (!*name)
-		goto return_base;
+		goto return_reval;
 
 	inode = nd->dentry->d_inode;
 	if (current->link_count)
@@ -576,7 +576,7 @@
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
 			case 1:
-				goto return_base;
+				goto return_reval;
 		}
 		if (nd->dentry->d_op && nd->dentry->d_op->d_hash) {
 			err = nd->dentry->d_op->d_hash(nd->dentry, &this);
@@ -627,6 +627,19 @@
 			nd->last_type = LAST_DOT;
 		else if (this.len == 2 && this.name[1] == '.')
 			nd->last_type = LAST_DOTDOT;
+return_reval:
+		/*
+		 * We bypassed the ordinary revalidation routines.
+		 * Check the cached dentry for staleness.
+		 */
+		dentry = nd->dentry;
+		if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
+			err = -ESTALE;
+			if (!dentry->d_op->d_revalidate(dentry, 0)) {
+				d_invalidate(dentry);
+				break;
+			}
+		}
 return_base:
 		return 0;
 out_dput:
