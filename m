Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261903AbRESR1X>; Sat, 19 May 2001 13:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261905AbRESR1N>; Sat, 19 May 2001 13:27:13 -0400
Received: from mons.uio.no ([129.240.130.14]:33982 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S261903AbRESR1A>;
	Sat, 19 May 2001 13:27:00 -0400
MIME-Version: 1.0
Message-ID: <15110.44238.305564.656129@charged.uio.no>
Date: Sat, 19 May 2001 19:26:38 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] 2.4.4 fix bug in nfs_refresh_inode() and cleanup...
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

  A bug was recently found in which nfs_refresh_inode() was returning
EIO when servers, such as the Hummingbird, don't return the optional
attributes on calls such as the setattr() call. This error was then
being passed back to userland.

  When investigating the bug, I also found a load of `debugging' code
at the start of nfs_refresh_inode() that would actually mask serious
bugs for us (returning EIO again, instead of Oopsing).

  The following patch fixes the bug, and gets rid of the bogus
debugging stuff.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.4-fixes/fs/nfs/inode.c linux-2.4.4-refresh/fs/nfs/inode.c
--- linux-2.4.4-fixes/fs/nfs/inode.c	Wed Apr 25 23:58:17 2001
+++ linux-2.4.4-refresh/fs/nfs/inode.c	Mon May 14 15:02:14 2001
@@ -887,40 +887,23 @@
  * A very similar scenario holds for the dir cache.
  */
 int
-nfs_refresh_inode(struct inode *inode, struct nfs_fattr *fattr)
+__nfs_refresh_inode(struct inode *inode, struct nfs_fattr *fattr)
 {
 	__u64		new_size, new_mtime;
 	loff_t		new_isize;
 	int		invalid = 0;
-	int		error = -EIO;
-
-	if (!inode || !fattr) {
-		printk(KERN_ERR "nfs_refresh_inode: inode or fattr is NULL\n");
-		goto out;
-	}
-	if (inode->i_mode == 0) {
-		printk(KERN_ERR "nfs_refresh_inode: empty inode\n");
-		goto out;
-	}
-
-	if ((fattr->valid & NFS_ATTR_FATTR) == 0)
-		goto out;
-
-	if (is_bad_inode(inode))
-		goto out;
 
 	dfprintk(VFS, "NFS: refresh_inode(%x/%ld ct=%d info=0x%x)\n",
 			inode->i_dev, inode->i_ino,
 			atomic_read(&inode->i_count), fattr->valid);
 
-
 	if (NFS_FSID(inode) != fattr->fsid ||
 	    NFS_FILEID(inode) != fattr->fileid) {
 		printk(KERN_ERR "nfs_refresh_inode: inode number mismatch\n"
 		       "expected (0x%Lx/0x%Lx), got (0x%Lx/0x%Lx)\n",
 		       (long long)NFS_FSID(inode), (long long)NFS_FILEID(inode),
 		       (long long)fattr->fsid, (long long)fattr->fileid);
-		goto out;
+		goto out_err;
 	}
 
 	/*
@@ -933,8 +916,6 @@
 	new_size = fattr->size;
  	new_isize = nfs_size_to_loff_t(fattr->size);
 
-	error = 0;
-
 	/*
 	 * Update the read time so we don't revalidate too often.
 	 */
@@ -1024,11 +1005,9 @@
 
 	if (invalid)
 		nfs_zap_caches(inode);
+	return 0;
 
-out:
-	return error;
-
-out_changed:
+ out_changed:
 	/*
 	 * Big trouble! The inode has become a different object.
 	 */
@@ -1042,7 +1021,8 @@
 	 * (But we fall through to invalidate the caches.)
 	 */
 	nfs_invalidate_inode(inode);
-	goto out;
+ out_err:
+	return -EIO;
 }
 
 /*
diff -u --recursive --new-file linux-2.4.4-fixes/include/linux/nfs_fs.h linux-2.4.4-refresh/include/linux/nfs_fs.h
--- linux-2.4.4-fixes/include/linux/nfs_fs.h	Sat Apr 28 00:49:37 2001
+++ linux-2.4.4-refresh/include/linux/nfs_fs.h	Mon May 14 15:00:18 2001
@@ -142,7 +142,7 @@
 				struct nfs_fattr *);
 extern struct inode *nfs_fhget(struct dentry *, struct nfs_fh *,
 				struct nfs_fattr *);
-extern int nfs_refresh_inode(struct inode *, struct nfs_fattr *);
+extern int __nfs_refresh_inode(struct inode *, struct nfs_fattr *);
 extern int nfs_revalidate(struct dentry *);
 extern int nfs_permission(struct inode *, int);
 extern int nfs_open(struct inode *, struct file *);
@@ -271,6 +271,14 @@
 	if (time_before(jiffies, NFS_READTIME(inode)+NFS_ATTRTIMEO(inode)))
 		return NFS_STALE(inode) ? -ESTALE : 0;
 	return __nfs_revalidate_inode(server, inode);
+}
+
+static inline int
+nfs_refresh_inode(struct inode *inode, struct nfs_fattr *fattr)
+{
+	if ((fattr->valid & NFS_ATTR_FATTR) == 0)
+		return 0;
+	return __nfs_refresh_inode(inode,fattr);
 }
 
 static inline loff_t
