Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291736AbSBAMTO>; Fri, 1 Feb 2002 07:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291739AbSBAMTF>; Fri, 1 Feb 2002 07:19:05 -0500
Received: from mons.uio.no ([129.240.130.14]:29899 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S291736AbSBAMSx>;
	Fri, 1 Feb 2002 07:18:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15450.34719.324396.430917@charged.uio.no>
Date: Fri, 1 Feb 2002 13:18:39 +0100
To: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.3]  VFS fix for open(".") breakage under
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

distributed filesystems
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>


The following is the fix for the open(".")/open("..") problems
that are hitting distributed file systems such as OpenGFS, and NFS.

The problem is that in the case where the final element of a path is
'.' or '..', then link_path_walk() does not actually check that the
resulting dentry is valid.

For the case of NFS, this results in 2 breakages:

  - Resulting dentry may be stale, and so the open() may succeed, but
    still results in an invalid file.

  - Attribute and data cache checking upon open(), which is normally
    done as part of the lookup process, gets circumvented, and so you
    end up with strange inconsistencies.
    Typical result is 'ls -l' returning "file 'blah' does not exist"
    errors.

Cheers,
  Trond


diff -u --recursive --new-file linux-2.5.3/fs/namei.c linux-2.5.3-cto/fs/namei.c
--- linux-2.5.3/fs/namei.c	Tue Jan 15 22:53:51 2002
+++ linux-2.5.3-cto/fs/namei.c	Fri Feb  1 13:00:39 2002
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
