Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSG1PYU>; Sun, 28 Jul 2002 11:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316878AbSG1PXo>; Sun, 28 Jul 2002 11:23:44 -0400
Received: from pat.uio.no ([129.240.130.16]:58515 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S316906AbSG1PXS>;
	Sun, 28 Jul 2002 11:23:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15684.3367.337559.979006@charged.uio.no>
Date: Sun, 28 Jul 2002 17:26:31 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Support for cached lookups via readdirplus [5/6]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Enable lookups of negative dentries using READDIRPLUS.

If we find that the entire READDIR cache has been read, and we've seen
that no pages are missing, and that the EOF has been reached, then we
assume that the file does not exist.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.29-rdplus4/fs/nfs/dir.c linux-2.5.29-rdplus5/fs/nfs/dir.c
--- linux-2.5.29-rdplus4/fs/nfs/dir.c	Sat Jul 27 19:15:50 2002
+++ linux-2.5.29-rdplus5/fs/nfs/dir.c	Sat Jul 27 19:15:41 2002
@@ -614,9 +614,11 @@
 			d_add(dentry, inode);
 			nfs_renew_times(dentry);
 			error = 0;
+			goto out;
 		}
-		goto out;
-	}
+		nfs_zap_caches(dir);
+	} else if (error == -ENOENT)
+		goto no_entry;
 
 	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, &fhandle, &fattr);
 	if (error == -ENOENT)
@@ -674,10 +676,10 @@
 	int res;
 
 	if (!NFS_USE_READDIRPLUS(dir))
-		return -ENOENT;
+		return -ENOTSUPP;
 	server = NFS_SERVER(dir);
 	if (server->flags & NFS_MOUNT_NOAC)
-		return -ENOENT;
+		return -EIO;
 	nfs_revalidate_inode(server, dir);
 
 	entry.fh = fh;
@@ -698,15 +700,19 @@
 		}
 		page_cache_release(page);
 
-		if (res == 0)
-			goto out_found;
-		if (res != -EAGAIN)
-			break;
+		switch (res) {
+		case 0:
+			fattr->timestamp = timestamp;
+			return 0;
+		case -ENOENT:
+			return -ENOENT;
+		case -EAGAIN:
+			continue;
+		default:
+		}
+		break;
 	}
-	return -ENOENT;
- out_found:
-	fattr->timestamp = timestamp;
-	return 0;
+	return -EIO;
 }
 
 /*
