Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264061AbRFERvO>; Tue, 5 Jun 2001 13:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264063AbRFERvE>; Tue, 5 Jun 2001 13:51:04 -0400
Received: from mons.uio.no ([129.240.130.14]:48615 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S264061AbRFERuy>;
	Tue, 5 Jun 2001 13:50:54 -0400
MIME-Version: 1.0
Message-ID: <15133.7158.481243.538585@charged.uio.no>
Date: Tue, 5 Jun 2001 19:50:46 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.5] Fix NFS Oops w.r.t. unhashed inodes
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

  One consequence of the removal of the 'put_inode: force_delete' made for
2.4.5 mmap() is that we now use the 'magic nfs' codepath in
iput(). The result is that when we unhash inodes due to staleness in
nfs_revalidate_inode(), we now end up calling clear_inode() in iput
without first calling truncate_inode_pages(), and thus trigger the
BUG() on line 486 in fs/inode.c.

  After discussion with Al, I think the minimal solution would be to
add a call to truncate_inode_pages() to the magic nfs code. To do the
call in nfs_revalidate_inode() itself (Al's suggestion) would be racy
w.r.t. adding pages in read or write itself.

  A second consequence of the removal of force_delete was the fact
that file or directory deletion no longer results in the inode getting
thrown out of the icache upon last iput(). This gave problems due to
inode number reuse on the userland nfsd. The solution is to update
i_nlink when we delete or rmdir.

Cheers,
  Trond

--- linux-2.4.5-pre6/fs/inode.c.orig	Fri May 25 14:15:38 2001
+++ linux-2.4.5-pre6/fs/inode.c	Wed May 30 12:17:29 2001
@@ -1044,6 +1044,8 @@
 				inode->i_state|=I_FREEING;
 				inodes_stat.nr_inodes--;
 				spin_unlock(&inode_lock);
+				if (inode->i_data.nrpages)
+					truncate_inode_pages(&inode->i_data, 0);
 				clear_inode(inode);
 			}
 		}
--- linux-2.4.5-pre6/fs/nfs/dir.c.orig	Fri May 25 14:15:38 2001
+++ linux-2.4.5-pre6/fs/nfs/dir.c	Thu May 31 14:53:32 2001
@@ -753,6 +753,8 @@
 
 	nfs_zap_caches(dir);
 	error = NFS_PROTO(dir)->rmdir(dir, &dentry->d_name);
+	if (!error)
+		dentry->d_inode->i_nlink = 0;
 
 	return error;
 }
@@ -870,6 +872,8 @@
 	error = NFS_PROTO(dir)->remove(dir, &dentry->d_name);
 	if (error < 0)
 		goto out;
+	if (inode)
+		inode->i_nlink--;
 
  out_delete:
 	/*
