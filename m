Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290718AbSARPYu>; Fri, 18 Jan 2002 10:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290720AbSARPYj>; Fri, 18 Jan 2002 10:24:39 -0500
Received: from pat.uio.no ([129.240.130.16]:37612 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S290718AbSARPYY>;
	Fri, 18 Jan 2002 10:24:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15432.15891.937634.771191@charged.uio.no>
Date: Fri, 18 Jan 2002 16:24:03 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Viro <viro@math.psu.edu>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.3-pre1] Fix NFS dentry lookup behaviour
In-Reply-To: <Pine.LNX.4.33.0201171414220.3114-100000@penguin.transmeta.com>
In-Reply-To: <15430.14576.445228.537714@charged.uio.no>
	<Pine.LNX.4.33.0201171414220.3114-100000@penguin.transmeta.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

     > What's wrong with using the existing "revalidate" approach? I
     > hate the notion of adding a special VFS layer call for
     > something like this.

The following patch to path_walk() is the alternative that I presented
to Linux Fsdevel last summer as part of the first draft patch. It uses
the standard d_revalidate() & friends.

As I said, the reaction at the time was not too positive, but perhaps
opinions have changed?

Cheers,
   Trond

diff -u --recursive --new-file linux-2.5.3-pre1/fs/namei.c linux-2.5.3-cto/fs/namei.c
--- linux-2.5.3-pre1/fs/namei.c	Mon Jan 14 18:41:57 2002
+++ linux-2.5.3-cto/fs/namei.c	Fri Jan 18 15:13:00 2002
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
