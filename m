Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSG1PWW>; Sun, 28 Jul 2002 11:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316887AbSG1PWW>; Sun, 28 Jul 2002 11:22:22 -0400
Received: from pat.uio.no ([129.240.130.16]:55955 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S316883AbSG1PWS>;
	Sun, 28 Jul 2002 11:22:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15684.3308.652954.340629@charged.uio.no>
Date: Sun, 28 Jul 2002 17:25:32 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Support for cached lookups via readdirplus [2/6]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cleanup for readdirplus. Allow the file attribute struct to set the
NFS_READTIME(inode) to some value other than 'jiffies'.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.29-rdplus1/fs/nfs/inode.c linux-2.5.29-rdplus2/fs/nfs/inode.c
--- linux-2.5.29-rdplus1/fs/nfs/inode.c	Fri Jul 26 23:09:24 2002
+++ linux-2.5.29-rdplus2/fs/nfs/inode.c	Sat Jul 27 18:06:09 2002
@@ -700,13 +700,13 @@
 		new_isize = nfs_size_to_loff_t(fattr->size);
 		new_atime = nfs_time_to_secs(fattr->atime);
 
-		NFS_READTIME(inode) = jiffies;
+		NFS_READTIME(inode) = fattr->timestamp;
 		NFS_CACHE_CTIME(inode) = fattr->ctime;
 		inode->i_ctime = nfs_time_to_secs(fattr->ctime);
 		inode->i_atime = new_atime;
 		NFS_CACHE_MTIME(inode) = new_mtime;
 		inode->i_mtime = nfs_time_to_secs(new_mtime);
-		NFS_MTIME_UPDATE(inode) = jiffies;
+		NFS_MTIME_UPDATE(inode) = fattr->timestamp;
 		NFS_CACHE_ISIZE(inode) = new_size;
 		inode->i_size = new_isize;
 		inode->i_mode = fattr->mode;
@@ -1014,6 +1014,9 @@
 		goto out_err;
 	}
 
+	/* Throw out obsolete READDIRPLUS attributes */
+	if (time_before(fattr->timestamp, NFS_READTIME(inode)))
+		return 0;
 	/*
 	 * Make sure the inode's type hasn't changed.
 	 */
@@ -1032,7 +1035,7 @@
 	/*
 	 * Update the read time so we don't revalidate too often.
 	 */
-	NFS_READTIME(inode) = jiffies;
+	NFS_READTIME(inode) = fattr->timestamp;
 
 	/*
 	 * Note: NFS_CACHE_ISIZE(inode) reflects the state of the cache.
@@ -1082,7 +1085,7 @@
 
 	if (NFS_CACHE_MTIME(inode) != new_mtime) {
 		if (invalid)
-			NFS_MTIME_UPDATE(inode) = jiffies;
+			NFS_MTIME_UPDATE(inode) = fattr->timestamp;
 		NFS_CACHE_MTIME(inode) = new_mtime;
 		inode->i_mtime = nfs_time_to_secs(new_mtime);
 	}
diff -u --recursive --new-file linux-2.5.29-rdplus1/fs/nfs/nfs2xdr.c linux-2.5.29-rdplus2/fs/nfs/nfs2xdr.c
--- linux-2.5.29-rdplus1/fs/nfs/nfs2xdr.c	Tue Jul 16 13:43:08 2002
+++ linux-2.5.29-rdplus2/fs/nfs/nfs2xdr.c	Sat Jul 27 18:01:53 2002
@@ -118,6 +118,7 @@
 		fattr->mode = (fattr->mode & ~S_IFMT) | S_IFIFO;
 		fattr->rdev = 0;
 	}
+	fattr->timestamp = jiffies;
 	return p;
 }
 
diff -u --recursive --new-file linux-2.5.29-rdplus1/fs/nfs/nfs3xdr.c linux-2.5.29-rdplus2/fs/nfs/nfs3xdr.c
--- linux-2.5.29-rdplus1/fs/nfs/nfs3xdr.c	Sat Jul 27 17:56:10 2002
+++ linux-2.5.29-rdplus2/fs/nfs/nfs3xdr.c	Sat Jul 27 18:02:17 2002
@@ -181,6 +181,7 @@
 
 	/* Update the mode bits */
 	fattr->valid |= (NFS_ATTR_FATTR | NFS_ATTR_FATTR_V3);
+	fattr->timestamp = jiffies;
 	return p;
 }
 
diff -u --recursive --new-file linux-2.5.29-rdplus1/include/linux/nfs_xdr.h linux-2.5.29-rdplus2/include/linux/nfs_xdr.h
--- linux-2.5.29-rdplus1/include/linux/nfs_xdr.h	Sat Jul 27 17:56:10 2002
+++ linux-2.5.29-rdplus2/include/linux/nfs_xdr.h	Sat Jul 27 17:58:08 2002
@@ -27,6 +27,7 @@
 	__u64			atime;
 	__u64			mtime;
 	__u64			ctime;
+	unsigned long		timestamp;
 };
 
 #define NFS_ATTR_WCC		0x0001		/* pre-op WCC data    */
