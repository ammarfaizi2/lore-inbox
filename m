Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbRHMTr4>; Mon, 13 Aug 2001 15:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266586AbRHMTrr>; Mon, 13 Aug 2001 15:47:47 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:57354 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266917AbRHMTrl>; Mon, 13 Aug 2001 15:47:41 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Mon, 13 Aug 2001 12:33:45 -0700
Message-Id: <200108131933.f7DJXjX20270@penguin.transmeta.com>
To: maxk@chinook.stanford.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-pre1 NFS problem
Newsgroups: linux.dev.kernel
In-Reply-To: <20010813114636.A4641@chinook.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010813114636.A4641@chinook.stanford.edu> you write:
>
>It looks like 2.4.9-pre1 breaks the NFS server.  Directories still get
>exported and clients can mount them fine, but the ls command on the
>client fails to report any files.  Filename completion also doesn't
>work.  However, files can still be viewed if you know the exact file
>name.

Yes, there's a missing off_t -> loff_t change in pre1, and the compile
will even warn about it...

>The same problem happens with 2.4.9-pre2.

..but I thought I fixed it in pre2. 

HOWEVER - there are a few others that I missed because the NFSD layer is
doing ugly casts of function pointers (don't ask me why - it should have
the right type in 'filldir_t' already but wants to use its own type), so
the compiler can't warn about it. 

Let's hear it for type safety and avoiding ugly casts.

Anyway, here's the patch - does this fix it for you?

		Linus

-----
diff -u --recursive --new-file pre2/linux/fs/nfsd/nfs3xdr.c linux/fs/nfsd/nfs3xdr.c
--- pre2/linux/fs/nfsd/nfs3xdr.c	Sun Aug 12 23:12:33 2001
+++ linux/fs/nfsd/nfs3xdr.c	Mon Aug 13 12:22:57 2001
@@ -730,14 +730,14 @@
 
 int
 nfs3svc_encode_entry(struct readdir_cd *cd, const char *name,
-		     int namlen, off_t offset, ino_t ino, unsigned int d_type)
+		     int namlen, loff_t offset, ino_t ino, unsigned int d_type)
 {
 	return encode_entry(cd, name, namlen, offset, ino, d_type, 0);
 }
 
 int
 nfs3svc_encode_entry_plus(struct readdir_cd *cd, const char *name,
-			  int namlen, off_t offset, ino_t ino, unsigned int d_type)
+			  int namlen, loff_t offset, ino_t ino, unsigned int d_type)
 {
 	return encode_entry(cd, name, namlen, offset, ino, d_type, 1);
 }
diff -u --recursive --new-file pre2/linux/fs/nfsd/nfsxdr.c linux/fs/nfsd/nfsxdr.c
--- pre2/linux/fs/nfsd/nfsxdr.c	Sun Aug 12 23:12:33 2001
+++ linux/fs/nfsd/nfsxdr.c	Mon Aug 13 12:23:49 2001
@@ -391,7 +391,7 @@
 
 int
 nfssvc_encode_entry(struct readdir_cd *cd, const char *name,
-		    int namlen, off_t offset, ino_t ino, unsigned int d_type)
+		    int namlen, loff_t offset, ino_t ino, unsigned int d_type)
 {
 	u32	*p = cd->buffer;
 	int	buflen, slen;
diff -u --recursive --new-file pre2/linux/include/linux/nfsd/nfsd.h linux/include/linux/nfsd/nfsd.h
--- pre2/linux/include/linux/nfsd/nfsd.h	Fri Aug 10 18:14:31 2001
+++ linux/include/linux/nfsd/nfsd.h	Mon Aug 13 12:30:35 2001
@@ -57,7 +57,7 @@
 	char			dotonly;
 };
 typedef int		(*encode_dent_fn)(struct readdir_cd *, const char *,
-						int, off_t, ino_t, unsigned int);
+						int, loff_t, ino_t, unsigned int);
 typedef int (*nfsd_dirop_t)(struct inode *, struct dentry *, int, int);
 
 /*
diff -u --recursive --new-file pre2/linux/include/linux/nfsd/xdr.h linux/include/linux/nfsd/xdr.h
--- pre2/linux/include/linux/nfsd/xdr.h	Fri Aug 10 18:15:05 2001
+++ linux/include/linux/nfsd/xdr.h	Mon Aug 13 12:28:54 2001
@@ -151,7 +151,7 @@
 int nfssvc_encode_readdirres(struct svc_rqst *, u32 *, struct nfsd_readdirres *);
 
 int nfssvc_encode_entry(struct readdir_cd *, const char *name,
-				int namlen, off_t offset, ino_t ino, unsigned int);
+				int namlen, loff_t offset, ino_t ino, unsigned int);
 
 int nfssvc_release_fhandle(struct svc_rqst *, u32 *, struct nfsd_fhandle *);
 
diff -u --recursive --new-file pre2/linux/include/linux/nfsd/xdr3.h linux/include/linux/nfsd/xdr3.h
--- pre2/linux/include/linux/nfsd/xdr3.h	Fri Aug 10 18:15:17 2001
+++ linux/include/linux/nfsd/xdr3.h	Mon Aug 13 12:28:54 2001
@@ -292,10 +292,10 @@
 int nfs3svc_release_fhandle2(struct svc_rqst *, u32 *,
 				struct nfsd3_fhandle_pair *);
 int nfs3svc_encode_entry(struct readdir_cd *, const char *name,
-				int namlen, off_t offset, ino_t ino,
+				int namlen, loff_t offset, ino_t ino,
 				unsigned int);
 int nfs3svc_encode_entry_plus(struct readdir_cd *, const char *name,
-				int namlen, off_t offset, ino_t ino,
+				int namlen, loff_t offset, ino_t ino,
 				unsigned int);
 
 
