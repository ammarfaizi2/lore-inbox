Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285180AbRLFVYx>; Thu, 6 Dec 2001 16:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285210AbRLFVYo>; Thu, 6 Dec 2001 16:24:44 -0500
Received: from pat.uio.no ([129.240.130.16]:5579 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S285180AbRLFVYa>;
	Thu, 6 Dec 2001 16:24:30 -0500
To: Xeno <xeno@overture.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4: NFS client race causes data loss when appending
In-Reply-To: <3C0ED156.2F327B0F@overture.com> <shsher4776s.fsf@charged.uio.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 06 Dec 2001 22:24:24 +0100
In-Reply-To: <shsher4776s.fsf@charged.uio.no>
Message-ID: <shsg06odotz.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

     >  What we really want is to prevent nfs_refresh_inode() from
     > overwriting newer attribute information with older
     > information. How therefore about something like the appended
     > patch, that uses the ctime field to determine which attribute
     > information is obsolete?  I'm afraid it's not going to work too
     > well for Linux servers because of the shitty 1 second
     > resolution we have on (a|m|c)time, but it will help against
     > most non-Linux servers.

Hah... I of course managed to get the sign wrong on the last
patch. The following should work better, including with Linux servers.

Cheers,
  Trond

--- linux-2.4.17-pre4/fs/nfs/inode.c.orig	Thu Dec  6 02:27:46 2001
+++ linux-2.4.17-pre4/fs/nfs/inode.c	Thu Dec  6 21:45:29 2001
@@ -655,20 +655,8 @@
 			inode->i_op = &nfs_symlink_inode_operations;
 		else
 			init_special_inode(inode, inode->i_mode, fattr->rdev);
-		/*
-		 * Preset the size and mtime, as there's no need
-		 * to invalidate the caches.
-		 */ 
-		inode->i_size  = nfs_size_to_loff_t(fattr->size);
-		inode->i_mtime = nfs_time_to_secs(fattr->mtime);
-		inode->i_atime = nfs_time_to_secs(fattr->atime);
-		inode->i_ctime = nfs_time_to_secs(fattr->ctime);
-		NFS_CACHE_CTIME(inode) = fattr->ctime;
-		NFS_CACHE_MTIME(inode) = fattr->mtime;
-		NFS_CACHE_ISIZE(inode) = fattr->size;
-		NFS_ATTRTIMEO(inode) = NFS_MINATTRTIMEO(inode);
-		NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
 		memcpy(&inode->u.nfs_i.fh, fh, sizeof(inode->u.nfs_i.fh));
+		NFS_CACHEINV(inode);
 	}
 	nfs_refresh_inode(inode, fattr);
 }
@@ -966,6 +954,37 @@
 }
 
 /*
+ * nfs_fattr_obsolete - Test if attribute data is newer than cached data
+ * @inode: inode
+ * @fattr: attributes to test
+ *
+ * Avoid stuffing the attribute cache with obsolete information.
+ * We always accept updates if the attribute cache timed out, or if
+ * fattr->ctime is newer than our cached value.
+ * If fattr->ctime matches the cached value, we still accept the update
+ * if there also is a reasonable match for the Weak Cache Consistency
+ * data. This is in order to cope with NFS servers with crap time
+ * resolution...
+ */
+static inline
+int nfs_fattr_obsolete(struct inode *inode, struct nfs_fattr *fattr)
+{
+	s64 cdif;
+
+	if (time_after(jiffies, NFS_READTIME(inode)+NFS_ATTRTIMEO(inode)))
+		goto out_valid;
+	if ((cdif = (s64)fattr->ctime - (s64)NFS_CACHE_CTIME(inode)) > 0)
+		goto out_valid;
+	/* Ugh... */
+	if (cdif == 0 && (fattr->valid & NFS_ATTR_WCC)
+	    && (s64)fattr->pre_ctime - (s64)NFS_CACHE_CTIME(inode) >= 0)
+		goto out_valid;
+	return -1;
+ out_valid:
+	return 0;
+}
+
+/*
  * Many nfs protocol calls return the new file attributes after
  * an operation.  Here we update the inode to reflect the state
  * of the server's inode.
@@ -1003,6 +1022,10 @@
 	if ((inode->i_mode & S_IFMT) != (fattr->mode & S_IFMT))
 		goto out_changed;
 
+	/* Avoid races */
+	if (nfs_fattr_obsolete(inode, fattr))
+		return 0;
+
  	new_mtime = fattr->mtime;
 	new_size = fattr->size;
  	new_isize = nfs_size_to_loff_t(fattr->size);

