Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbTBBA2j>; Sat, 1 Feb 2003 19:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbTBBA2j>; Sat, 1 Feb 2003 19:28:39 -0500
Received: from hera.cwi.nl ([192.16.191.8]:16602 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265066AbTBBA2i>;
	Sat, 1 Feb 2003 19:28:38 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 2 Feb 2003 01:38:03 +0100 (MET)
Message-Id: <UTC200302020038.h120c2f15668.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com, trond.myklebust@fys.uio.no
Subject: [PATCH] NFS dev_t fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NFS code knows too much about the structure of a dev_t.
Below some equivalent code that will remain correct also
for a 32-bit dev_t.

Andries


diff -u --recursive --new-file -X /linux/dontdiff a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
--- a/fs/nfs/nfs3xdr.c	Wed Jan  1 23:54:24 2003
+++ b/fs/nfs/nfs3xdr.c	Sun Feb  2 00:57:47 2003
@@ -146,7 +146,7 @@
 static u32 *
 xdr_decode_fattr(u32 *p, struct nfs_fattr *fattr)
 {
-	unsigned int	type;
+	unsigned int	type, major, minor;
 	int		fmode;
 
 	type = ntohl(*p++);
@@ -160,9 +160,12 @@
 	fattr->gid = ntohl(*p++);
 	p = xdr_decode_hyper(p, &fattr->size);
 	p = xdr_decode_hyper(p, &fattr->du.nfs3.used);
+
 	/* Turn remote device info into Linux-specific dev_t */
-	fattr->rdev = ntohl(*p++) << MINORBITS;
-	fattr->rdev |= ntohl(*p++) & MINORMASK;
+	major = ntohl(*p++);
+	minor = ntohl(*p++);
+	fattr->rdev = MKDEV(major, minor);
+
 	p = xdr_decode_hyper(p, &fattr->fsid_u.nfs3);
 	p = xdr_decode_hyper(p, &fattr->fileid);
 	p = xdr_decode_time3(p, &fattr->atime);
@@ -412,8 +415,8 @@
 	*p++ = htonl(args->type);
 	p = xdr_encode_sattr(p, args->sattr);
 	if (args->type == NF3CHR || args->type == NF3BLK) {
-		*p++ = htonl(args->rdev >> MINORBITS);
-		*p++ = htonl(args->rdev & MINORMASK);
+		*p++ = htonl(MAJOR(args->rdev));
+		*p++ = htonl(MINOR(args->rdev));
 	}
 
 	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
diff -u --recursive --new-file -X /linux/dontdiff a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
--- a/fs/nfs/nfs4xdr.c	Thu Jan  9 18:07:16 2003
+++ b/fs/nfs/nfs4xdr.c	Sun Feb  2 00:55:22 2003
@@ -1385,13 +1385,14 @@
                 dprintk("read_attrs: gid=%d\n", (int)nfp->gid);
         }
         if (bmval1 & FATTR4_WORD1_RAWDEV) {
-                READ_BUF(8);
-                len += 8;
-                READ32(dummy32);
-		nfp->rdev = (dummy32 << MINORBITS);
-                READ32(dummy32);
-		nfp->rdev |= (dummy32 & MINORMASK);
-                dprintk("read_attrs: rdev=%d\n", nfp->rdev);
+		uint32_t major, minor;
+
+		READ_BUF(8);
+		len += 8;
+		READ32(major);
+		READ32(minor);
+		nfp->rdev = MKDEV(major, minor);
+		dprintk("read_attrs: rdev=0x%x\n", nfp->rdev);
         }
         if (bmval1 & FATTR4_WORD1_SPACE_AVAIL) {
                 READ_BUF(8);
