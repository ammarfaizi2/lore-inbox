Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267092AbSKSFkR>; Tue, 19 Nov 2002 00:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbSKSFkR>; Tue, 19 Nov 2002 00:40:17 -0500
Received: from mons.uio.no ([129.240.130.14]:64684 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267092AbSKSFkK>;
	Tue, 19 Nov 2002 00:40:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15833.53337.94225.434381@charged.uio.no>
Date: Tue, 19 Nov 2002 06:47:05 +0100
To: Linus Torvalds <torvalds@transmeta.com>
cc: NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Support for micro/nanosecond [acm]time in the NFS client
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Given Andi Kleen's patch that introduces of VFS-level support for
nanosecond time resolutions, we should finally be able to export the
existing NFS client level support to userland.

In order to do so, the following patch will convert all NFS private
'raw u64' values into the kernel-supported struct timespec directly in
the xdr_encode/xdr_decode routines.
It adds support for the nanosecond field in NFS 'setattr' calls, and
in nfs_refresh_inode().

Finally, there are a few cleanups in the nfs_refresh_inode code that
convert multiple use of the NFS_*(inode) macros into a single
dereference of NFS_I(inode).

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.48/fs/nfs/inode.c linux-2.5.48-01-fix_time/fs/nfs/inode.c
--- linux-2.5.48/fs/nfs/inode.c	2002-11-17 20:12:25.000000000 -0500
+++ linux-2.5.48-01-fix_time/fs/nfs/inode.c	2002-11-18 09:29:11.000000000 -0500
@@ -656,9 +656,7 @@
 		goto out_no_inode;
 
 	if (inode->i_state & I_NEW) {
-		__u64		new_size, new_mtime;
-		loff_t		new_isize;
-		time_t		new_atime;
+		struct nfs_inode *nfsi = NFS_I(inode);
 
 		/* We set i_ino for the few things that still rely on it,
 		 * such as stat(2) */
@@ -686,24 +684,17 @@
 		else
 			init_special_inode(inode, inode->i_mode, fattr->rdev);
 
-		new_mtime = fattr->mtime;
-		new_size = fattr->size;
-		new_isize = nfs_size_to_loff_t(fattr->size);
-		new_atime = nfs_time_to_secs(fattr->atime);
-
-		NFS_READTIME(inode) = fattr->timestamp;
-		NFS_CACHE_CTIME(inode) = fattr->ctime;
-		inode->i_ctime.tv_sec = nfs_time_to_secs(fattr->ctime);
-		inode->i_ctime.tv_nsec = nfs_time_to_nsecs(fattr->ctime);
-		inode->i_atime.tv_sec = new_atime;
-		NFS_CACHE_MTIME(inode) = new_mtime;
-		inode->i_mtime.tv_sec = nfs_time_to_secs(new_mtime);
-		inode->i_mtime.tv_nsec = nfs_time_to_nsecs(new_mtime);
-		NFS_MTIME_UPDATE(inode) = fattr->timestamp;
-		NFS_CACHE_ISIZE(inode) = new_size;
+		nfsi->read_cache_jiffies = fattr->timestamp;
+		inode->i_atime = fattr->atime;
+		inode->i_mtime = fattr->mtime;
+		inode->i_ctime = fattr->ctime;
+		nfsi->read_cache_ctime = fattr->ctime;
+		nfsi->read_cache_mtime = fattr->mtime;
+		nfsi->cache_mtime_jiffies = fattr->timestamp;
+		nfsi->read_cache_isize = fattr->size;
 		if (fattr->valid & NFS_ATTR_FATTR_V4)
-			NFS_CHANGE_ATTR(inode) = fattr->change_attr;
-		inode->i_size = new_isize;
+			nfsi->change_attr = fattr->change_attr;
+		inode->i_size = nfs_size_to_loff_t(fattr->size);
 		inode->i_mode = fattr->mode;
 		inode->i_nlink = fattr->nlink;
 		inode->i_uid = fattr->uid;
@@ -718,10 +709,10 @@
 			inode->i_blocks = fattr->du.nfs2.blocks;
 			inode->i_blksize = fattr->du.nfs2.blocksize;
 		}
-		NFS_ATTRTIMEO(inode) = NFS_MINATTRTIMEO(inode);
-		NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
-		memset(NFS_COOKIEVERF(inode), 0, sizeof(NFS_COOKIEVERF(inode)));
-		NFS_I(inode)->cache_access.cred = NULL;
+		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
+		nfsi->attrtimeo_timestamp = jiffies;
+		memset(nfsi->cookieverf, 0, sizeof(nfsi->cookieverf));
+		nfsi->cache_access.cred = NULL;
 
 		unlock_new_inode(inode);
 	} else
@@ -787,9 +778,10 @@
 	 * now to avoid invalidating the page cache.
 	 */
 	if (!(fattr.valid & NFS_ATTR_WCC)) {
-		fattr.pre_size = NFS_CACHE_ISIZE(inode);
-		fattr.pre_mtime = NFS_CACHE_MTIME(inode);
-		fattr.pre_ctime = NFS_CACHE_CTIME(inode);
+		struct nfs_inode *nfsi = NFS_I(inode);
+		fattr.pre_size = nfsi->read_cache_isize;
+		fattr.pre_mtime = nfsi->read_cache_mtime;
+		fattr.pre_ctime = nfsi->read_cache_ctime;
 		fattr.valid |= NFS_ATTR_WCC;
 	}
 	/* Force an attribute cache update */
@@ -962,14 +954,18 @@
 static inline
 int nfs_fattr_obsolete(struct inode *inode, struct nfs_fattr *fattr)
 {
-	s64 cdif;
+	struct nfs_inode *nfsi = NFS_I(inode);
+	long cdif;
 
-	if (time_after(jiffies, NFS_READTIME(inode)+NFS_ATTRTIMEO(inode)))
+	if (time_after(jiffies, nfsi->read_cache_jiffies + nfsi->attrtimeo))
 		goto out_valid;
-	if ((cdif = (s64)fattr->ctime - (s64)NFS_CACHE_CTIME(inode)) > 0)
+	cdif = fattr->ctime.tv_sec - nfsi->read_cache_ctime.tv_sec;
+	if (cdif == 0)
+		cdif = fattr->ctime.tv_nsec - nfsi->read_cache_ctime.tv_nsec;
+	if (cdif > 0)
 		goto out_valid;
 	/* Ugh... */
-	if (cdif == 0 && fattr->size > NFS_CACHE_ISIZE(inode))
+	if (cdif == 0 && fattr->size > nfsi->read_cache_isize)
 		goto out_valid;
 	return -1;
  out_valid:
@@ -991,19 +987,20 @@
 int
 __nfs_refresh_inode(struct inode *inode, struct nfs_fattr *fattr)
 {
-	__u64		new_size, new_mtime;
+	struct nfs_inode *nfsi = NFS_I(inode);
+	__u64		new_size;
 	loff_t		new_isize;
-	struct timespec	new_atime;
 	int		invalid = 0;
+	int		mtime_update = 0;
 
 	dfprintk(VFS, "NFS: refresh_inode(%s/%ld ct=%d info=0x%x)\n",
 			inode->i_sb->s_id, inode->i_ino,
 			atomic_read(&inode->i_count), fattr->valid);
 
-	if (NFS_FILEID(inode) != fattr->fileid) {
+	if (nfsi->fileid != fattr->fileid) {
 		printk(KERN_ERR "nfs_refresh_inode: inode number mismatch\n"
 		       "expected (%s/0x%Lx), got (%s/0x%Lx)\n",
-		       inode->i_sb->s_id, (long long)NFS_FILEID(inode),
+		       inode->i_sb->s_id, (long long)nfsi->fileid,
 		       inode->i_sb->s_id, (long long)fattr->fileid);
 		goto out_err;
 	}
@@ -1017,12 +1014,9 @@
 	if ((inode->i_mode & S_IFMT) != (fattr->mode & S_IFMT))
 		goto out_changed;
 
- 	new_mtime = fattr->mtime;
 	new_size = fattr->size;
  	new_isize = nfs_size_to_loff_t(fattr->size);
 
-	new_atime.tv_sec = nfs_time_to_secs(fattr->atime);
-	new_atime.tv_nsec = nfs_time_to_nsecs(fattr->atime);
 	/* Avoid races */
 	if (nfs_fattr_obsolete(inode, fattr))
 		goto out_nochange;
@@ -1030,13 +1024,13 @@
 	/*
 	 * Update the read time so we don't revalidate too often.
 	 */
-	NFS_READTIME(inode) = fattr->timestamp;
+	nfsi->read_cache_jiffies = fattr->timestamp;
 
 	/*
 	 * Note: NFS_CACHE_ISIZE(inode) reflects the state of the cache.
 	 *       NOT inode->i_size!!!
 	 */
-	if (NFS_CACHE_ISIZE(inode) != new_size) {
+	if (nfsi->read_cache_isize != new_size) {
 #ifdef NFS_DEBUG_VERBOSE
 		printk(KERN_DEBUG "NFS: isize change on %s/%ld\n", inode->i_sb->s_id, inode->i_ino);
 #endif
@@ -1048,15 +1042,16 @@
 	 *       can change this value in VFS without requiring a
 	 *	 cache revalidation.
 	 */
-	if (NFS_CACHE_MTIME(inode) != new_mtime) {
+	if (!timespec_equal(&nfsi->read_cache_mtime, &fattr->mtime)) {
 #ifdef NFS_DEBUG_VERBOSE
 		printk(KERN_DEBUG "NFS: mtime change on %s/%ld\n", inode->i_sb->s_id, inode->i_ino);
 #endif
 		invalid = 1;
+		mtime_update = 1;
 	}
 
 	if ((fattr->valid & NFS_ATTR_FATTR_V4)
-	    && NFS_CHANGE_ATTR(inode) != fattr->change_attr) {
+	    && nfsi->change_attr != fattr->change_attr) {
 #ifdef NFS_DEBUG_VERBOSE
 		printk(KERN_DEBUG "NFS: change_attr change on %s/%ld\n",
 		       inode->i_sb->s_id, inode->i_ino);
@@ -1070,12 +1065,12 @@
          * operation, so there's no need to invalidate the caches.
          */
 	if ((fattr->valid & NFS_ATTR_PRE_CHANGE)
-	    && NFS_CHANGE_ATTR(inode) == fattr->pre_change_attr) {
+	    && nfsi->change_attr == fattr->pre_change_attr) {
 		invalid = 0;
 	}
 	else if ((fattr->valid & NFS_ATTR_WCC)
-	    && NFS_CACHE_ISIZE(inode) == fattr->pre_size
-	    && NFS_CACHE_MTIME(inode) == fattr->pre_mtime) {
+	    && nfsi->read_cache_isize == fattr->pre_size
+	    && timespec_equal(&nfsi->read_cache_mtime, &fattr->pre_mtime)) {
 		invalid = 0;
 	}
 
@@ -1086,21 +1081,18 @@
 	if (nfs_have_writebacks(inode) && new_isize < inode->i_size)
 		new_isize = inode->i_size;
 
-	NFS_CACHE_CTIME(inode) = fattr->ctime;
-	inode->i_ctime.tv_sec = nfs_time_to_secs(fattr->ctime);
-	inode->i_ctime.tv_nsec = nfs_time_to_nsecs(fattr->ctime);
-
-	inode->i_atime = new_atime;
+	nfsi->read_cache_ctime = fattr->ctime;
+	inode->i_ctime = fattr->ctime;
+	inode->i_atime = fattr->atime;
 
-	if (NFS_CACHE_MTIME(inode) != new_mtime) {
+	if (mtime_update) {
 		if (invalid)
-			NFS_MTIME_UPDATE(inode) = fattr->timestamp;
-		NFS_CACHE_MTIME(inode) = new_mtime;
-		inode->i_mtime.tv_sec = nfs_time_to_secs(new_mtime);
-		inode->i_mtime.tv_nsec = nfs_time_to_nsecs(new_mtime);
+			nfsi->cache_mtime_jiffies = fattr->timestamp;
+		nfsi->read_cache_mtime = fattr->mtime;
+		inode->i_mtime = fattr->mtime;
 	}
 
-	NFS_CACHE_ISIZE(inode) = new_size;
+	nfsi->read_cache_isize = new_size;
 	inode->i_size = new_isize;
 
 	if (inode->i_mode != fattr->mode ||
@@ -1114,7 +1106,7 @@
 	}
 
 	if (fattr->valid & NFS_ATTR_FATTR_V4)
-		NFS_CHANGE_ATTR(inode) = fattr->change_attr;
+		nfsi->change_attr = fattr->change_attr;
 
 	inode->i_mode = fattr->mode;
 	inode->i_nlink = fattr->nlink;
@@ -1134,20 +1126,20 @@
  
 	/* Update attrtimeo value */
 	if (invalid) {
-		NFS_ATTRTIMEO(inode) = NFS_MINATTRTIMEO(inode);
-		NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
+		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
+		nfsi->attrtimeo_timestamp = jiffies;
 		invalidate_inode_pages(inode->i_mapping);
 		memset(NFS_COOKIEVERF(inode), 0, sizeof(NFS_COOKIEVERF(inode)));
-	} else if (time_after(jiffies, NFS_ATTRTIMEO_UPDATE(inode)+NFS_ATTRTIMEO(inode))) {
-		if ((NFS_ATTRTIMEO(inode) <<= 1) > NFS_MAXATTRTIMEO(inode))
-			NFS_ATTRTIMEO(inode) = NFS_MAXATTRTIMEO(inode);
-		NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
+	} else if (time_after(jiffies, nfsi->attrtimeo_timestamp+nfsi->attrtimeo)) {
+		if ((nfsi->attrtimeo <<= 1) > NFS_MAXATTRTIMEO(inode))
+			nfsi->attrtimeo = NFS_MAXATTRTIMEO(inode);
+		nfsi->attrtimeo_timestamp = jiffies;
 	}
 
 	return 0;
  out_nochange:
-	if (!timespec_equal(&new_atime, &inode->i_atime))
-		inode->i_atime = new_atime;
+	if (!timespec_equal(&fattr->atime, &inode->i_atime))
+		inode->i_atime = fattr->atime;
 	return 0;
  out_changed:
 	/*
diff -u --recursive --new-file linux-2.5.48/fs/nfs/nfs2xdr.c linux-2.5.48-01-fix_time/fs/nfs/nfs2xdr.c
--- linux-2.5.48/fs/nfs/nfs2xdr.c	2002-11-17 20:12:25.000000000 -0500
+++ linux-2.5.48-01-fix_time/fs/nfs/nfs2xdr.c	2002-11-18 09:46:43.000000000 -0500
@@ -86,10 +86,20 @@
 }
 
 static inline u32*
-xdr_decode_time(u32 *p, u64 *timep)
+xdr_encode_time(u32 *p, struct timespec *timep)
 {
-	u64 tmp = (u64)ntohl(*p++) << 32;
-	*timep = tmp + (u64)ntohl(*p++);
+	*p++ = htonl(timep->tv_sec);
+	/* Convert nanoseconds into microseconds */
+	*p++ = htonl(timep->tv_nsec / 1000);
+	return p;
+}
+
+static inline u32*
+xdr_decode_time(u32 *p, struct timespec *timep)
+{
+	timep->tv_sec = ntohl(*p++);
+	/* Convert microseconds into nanoseconds */
+	timep->tv_nsec = ntohl(*p++) * 1000;
 	return p;
 }
 
@@ -131,16 +141,14 @@
 	SATTR(p, attr, ATTR_SIZE, ia_size);
 
 	if (attr->ia_valid & (ATTR_ATIME|ATTR_ATIME_SET)) {
-		*p++ = htonl(attr->ia_atime.tv_sec);
-		*p++ = 0;
+		p = xdr_encode_time(p, &attr->ia_atime);
 	} else {
 		*p++ = ~(u32) 0;
 		*p++ = ~(u32) 0;
 	}
 
 	if (attr->ia_valid & (ATTR_MTIME|ATTR_MTIME_SET)) {
-		*p++ = htonl(attr->ia_mtime.tv_sec);
-		*p++ = 0;
+		p = xdr_encode_time(p, &attr->ia_mtime);
 	} else {
 		*p++ = ~(u32) 0;	
 		*p++ = ~(u32) 0;
diff -u --recursive --new-file linux-2.5.48/fs/nfs/nfs3xdr.c linux-2.5.48-01-fix_time/fs/nfs/nfs3xdr.c
--- linux-2.5.48/fs/nfs/nfs3xdr.c	2002-11-17 20:12:25.000000000 -0500
+++ linux-2.5.48-01-fix_time/fs/nfs/nfs3xdr.c	2002-11-18 09:47:22.000000000 -0500
@@ -128,26 +128,18 @@
  * nanosecond field.
  */
 static inline u32 *
-xdr_encode_time(u32 *p, time_t time)
+xdr_encode_time3(u32 *p, struct timespec *timep)
 {
-	*p++ = htonl(time);
-	*p++ = 0;
+	*p++ = htonl(timep->tv_sec);
+	*p++ = htonl(timep->tv_nsec);
 	return p;
 }
 
 static inline u32 *
-xdr_decode_time3(u32 *p, u64 *timep)
+xdr_decode_time3(u32 *p, struct timespec *timep)
 {
-	u64 tmp = (u64)ntohl(*p++) << 32;
-	*timep = tmp + (u64)ntohl(*p++);
-	return p;
-}
-
-static inline u32 *
-xdr_encode_time3(u32 *p, u64 time)
-{
-	*p++ = htonl(time >> 32);
-	*p++ = htonl(time & 0xFFFFFFFF);
+	timep->tv_sec = ntohl(*p++);
+	timep->tv_nsec = ntohl(*p++);
 	return p;
 }
 
@@ -212,7 +204,7 @@
 	}
 	if (attr->ia_valid & ATTR_ATIME_SET) {
 		*p++ = xdr_two;
-		p = xdr_encode_time(p, attr->ia_atime.tv_sec);
+		p = xdr_encode_time3(p, &attr->ia_atime);
 	} else if (attr->ia_valid & ATTR_ATIME) {
 		*p++ = xdr_one;
 	} else {
@@ -220,7 +212,7 @@
 	}
 	if (attr->ia_valid & ATTR_MTIME_SET) {
 		*p++ = xdr_two;
-		p = xdr_encode_time(p, attr->ia_mtime.tv_sec);
+		p = xdr_encode_time3(p, &attr->ia_mtime);
 	} else if (attr->ia_valid & ATTR_MTIME) {
 		*p++ = xdr_one;
 	} else {
@@ -288,7 +280,7 @@
 	p = xdr_encode_sattr(p, args->sattr);
 	*p++ = htonl(args->guard);
 	if (args->guard)
-		p = xdr_encode_time3(p, args->guardtime);
+		p = xdr_encode_time3(p, &args->guardtime);
 	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
 	return 0;
 }
diff -u --recursive --new-file linux-2.5.48/fs/nfs/nfs4proc.c linux-2.5.48-01-fix_time/fs/nfs/nfs4proc.c
--- linux-2.5.48/fs/nfs/nfs4proc.c	2002-11-13 09:58:44.000000000 -0500
+++ linux-2.5.48-01-fix_time/fs/nfs/nfs4proc.c	2002-11-18 09:26:57.000000000 -0500
@@ -563,13 +563,13 @@
 {
 	struct nfs4_setclientid *setclientid = GET_OP(cp, setclientid);
 	struct nfs_server *server = cp->server;
-	struct timeval tv;
+	struct timespec tv;
 	u32 *p;
 
-	do_gettimeofday(&tv);
-	p = (u32 *)setclientid->sc_verifier;
+	tv = CURRENT_TIME;
+ 	p = (u32 *)setclientid->sc_verifier;
 	*p++ = tv.tv_sec;
-	*p++ = tv.tv_usec;
+	*p++ = tv.tv_nsec;
 	setclientid->sc_name = server->ip_addr;
 	sprintf(setclientid->sc_netid, "udp");
 	sprintf(setclientid->sc_uaddr, "%s.%d.%d", server->ip_addr, port >> 8, port & 255);
diff -u --recursive --new-file linux-2.5.48/fs/nfs/nfs4xdr.c linux-2.5.48-01-fix_time/fs/nfs/nfs4xdr.c
--- linux-2.5.48/fs/nfs/nfs4xdr.c	2002-11-17 20:12:25.000000000 -0500
+++ linux-2.5.48-01-fix_time/fs/nfs/nfs4xdr.c	2002-11-18 09:49:48.000000000 -0500
@@ -873,8 +873,8 @@
 } while (0)
 #define READTIME(x)       do {			\
 	p++;					\
-	(x) = (u64)ntohl(*p++) << 32;		\
-	(x) |= ntohl(*p++);			\
+	(x.tv_sec) = ntohl(*p++);		\
+	(x.tv_nsec) = ntohl(*p++);		\
 } while (0)
 #define COPYMEM(x,nbytes) do {			\
 	memcpy((x), p, nbytes);			\
@@ -1228,19 +1228,19 @@
                 READ_BUF(12);
                 len += 12;
                 READTIME(nfp->atime);
-                dprintk("read_attrs: atime=%d\n", (int)nfp->atime);
+                dprintk("read_attrs: atime=%ld\n", (long)nfp->atime.tv_sec);
         }
         if (bmval1 & FATTR4_WORD1_TIME_METADATA) {
                 READ_BUF(12);
                 len += 12;
                 READTIME(nfp->ctime);
-                dprintk("read_attrs: ctime=%d\n", (int)nfp->ctime);
+                dprintk("read_attrs: ctime=%ld\n", (long)nfp->ctime.tv_sec);
         }
         if (bmval1 & FATTR4_WORD1_TIME_MODIFY) {
                 READ_BUF(12);
                 len += 12;
                 READTIME(nfp->mtime);
-                dprintk("read_attrs: mtime=%d\n", (int)nfp->mtime);
+                dprintk("read_attrs: mtime=%ld\n", (long)nfp->mtime.tv_sec);
         }
         if (len != attrlen)
                 goto xdr_error;
diff -u --recursive --new-file linux-2.5.48/include/linux/nfs_fs.h linux-2.5.48-01-fix_time/include/linux/nfs_fs.h
--- linux-2.5.48/include/linux/nfs_fs.h	2002-11-17 14:53:57.000000000 -0500
+++ linux-2.5.48-01-fix_time/include/linux/nfs_fs.h	2002-11-18 09:18:08.000000000 -0500
@@ -118,8 +118,8 @@
 	 *	mtime != read_cache_mtime
 	 */
 	unsigned long		read_cache_jiffies;
-	__u64			read_cache_ctime;
-	__u64			read_cache_mtime;
+	struct timespec		read_cache_ctime;
+	struct timespec		read_cache_mtime;
 	__u64			read_cache_isize;
 	unsigned long		attrtimeo;
 	unsigned long		attrtimeo_timestamp;
@@ -416,20 +416,6 @@
 	return ino;
 }
 
-static inline time_t
-nfs_time_to_secs(__u64 time)
-{
-	return (time_t)(time >> 32);
-}
-
-
-static inline u32
-nfs_time_to_nsecs(__u64 time)
-{
-	return time & 0xffffffff;
-}
-
-
 /* NFS root */
 
 extern void * nfs_root_data(void);
diff -u --recursive --new-file linux-2.5.48/include/linux/nfs_xdr.h linux-2.5.48-01-fix_time/include/linux/nfs_xdr.h
--- linux-2.5.48/include/linux/nfs_xdr.h	2002-10-14 10:03:48.000000000 -0400
+++ linux-2.5.48-01-fix_time/include/linux/nfs_xdr.h	2002-11-18 08:16:31.000000000 -0500
@@ -6,8 +6,8 @@
 struct nfs_fattr {
 	unsigned short		valid;		/* which fields are valid */
 	__u64			pre_size;	/* pre_op_attr.size	  */
-	__u64			pre_mtime;	/* pre_op_attr.mtime	  */
-	__u64			pre_ctime;	/* pre_op_attr.ctime	  */
+	struct timespec		pre_mtime;	/* pre_op_attr.mtime	  */
+	struct timespec		pre_ctime;	/* pre_op_attr.ctime	  */
 	enum nfs_ftype		type;		/* always use NFSv2 types */
 	__u32			mode;
 	__u32			nlink;
@@ -32,9 +32,9 @@
 		} nfs4;
 	} fsid_u;
 	__u64			fileid;
-	__u64			atime;
-	__u64			mtime;
-	__u64			ctime;
+	struct timespec		atime;
+	struct timespec		mtime;
+	struct timespec		ctime;
 	__u64			change_attr;	/* NFSv4 change attribute */
 	__u64			pre_change_attr;/* pre-op NFSv4 change attribute */
 	unsigned long		timestamp;
@@ -219,7 +219,7 @@
 	struct nfs_fh *		fh;
 	struct iattr *		sattr;
 	unsigned int		guard;
-	__u64			guardtime;
+	struct timespec		guardtime;
 };
 
 struct nfs3_diropargs {
