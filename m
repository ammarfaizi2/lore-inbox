Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbRBAAZE>; Wed, 31 Jan 2001 19:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129365AbRBAAYy>; Wed, 31 Jan 2001 19:24:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2566 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129345AbRBAAYg>;
	Wed, 31 Jan 2001 19:24:36 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102010003.f1103ll11665@flint.arm.linux.org.uk>
Subject: NFS root mounting in 2.4.1...
To: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Date: Thu, 1 Feb 2001 00:03:47 +0000 (GMT)
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...fails on ARM with ESTALE (116):

Looking up port of RPC 100003/2 on 192.168.0.4
Looking up port of RPC 100005/2 on 192.168.0.4
nfs_get_root: getattr error = 116
nfs_read_super: get root inode failed
VFS: Unable to mount root fs via NFS, trying floppy.


It seems to be related to these two compiler warnings:

gcc -D__KERNEL__ -I/usr/src/v2.4/linux-ebsa110/include -Wall
 -Wstrict-prototypes -O2  -fno-strict-aliasing -fno-common
 -pipe -mapcs-32 -march=armv4 -mtune=strongarm110 -mshort-load-bytes
 -msoft-float -c -o nfsroot.o nfsroot.c
nfsroot.c: In function `root_nfs_get_handle':
nfsroot.c:444: warning: passing arg 3 of `nfs3_mount' from incompatible pointer type
nfsroot.c:446: warning: passing arg 3 of `nfs_mount' from incompatible pointer type

The following patch changes every instance of nfs_fh in nfs_mount to
be nfs3_fh.  This makes NFS root mounting again a possibility on ARM.

diff -ur -x .* -x *.[oas] orig/fs/nfs/mount_clnt.c linux/fs/nfs/mount_clnt.c
--- orig/fs/nfs/mount_clnt.c	Thu Apr 27 20:44:34 2000
+++ linux/fs/nfs/mount_clnt.c	Wed Jan 31 23:53:21 2001
@@ -31,32 +31,32 @@
  */
 
 static int			nfs_gen_mount(struct sockaddr_in *,
-					      char *, struct nfs_fh *, int);
+					      char *, struct nfs3_fh *, int);
 static struct rpc_clnt *	mnt_create(char *, struct sockaddr_in *, int);
 extern struct rpc_program	mnt_program;
 
 struct mnt_fhstatus {
 	unsigned int		status;
-	struct nfs_fh *		fh;
+	struct nfs3_fh *	fh;
 };
 
 /*
  * Obtain an NFS file handle for the given host and path
  */
 int
-nfs_mount(struct sockaddr_in *addr, char *path, struct nfs_fh *fh)
+nfs_mount(struct sockaddr_in *addr, char *path, struct nfs3_fh *fh)
 {
 	return nfs_gen_mount(addr, path, fh, NFS_MNT_VERSION);
 }
 
 int
-nfs3_mount(struct sockaddr_in *addr, char *path, struct nfs_fh *fh)
+nfs3_mount(struct sockaddr_in *addr, char *path, struct nfs3_fh *fh)
 {
 	return nfs_gen_mount(addr, path, fh, NFS_MNT3_VERSION);
 }
 
 static int
-nfs_gen_mount(struct sockaddr_in *addr, char *path, struct nfs_fh *fh, int version)
+nfs_gen_mount(struct sockaddr_in *addr, char *path, struct nfs3_fh *fh, int version)
 {
 	struct rpc_clnt		*mnt_clnt;
 	struct mnt_fhstatus	result = { 0, fh };
@@ -120,7 +120,7 @@
 static int
 xdr_decode_fhstatus(struct rpc_rqst *req, u32 *p, struct mnt_fhstatus *res)
 {
-	struct nfs_fh *fh = res->fh;
+	struct nfs3_fh *fh = res->fh;
 
 	memset((void *)fh, 0, sizeof(*fh));
 	if ((res->status = ntohl(*p++)) == 0) {
@@ -133,7 +133,7 @@
 static int
 xdr_decode_fhstatus3(struct rpc_rqst *req, u32 *p, struct mnt_fhstatus *res)
 {
-	struct nfs_fh *fh = res->fh;
+	struct nfs3_fh *fh = res->fh;
 
 	memset((void *)fh, 0, sizeof(*fh));
 	if ((res->status = ntohl(*p++)) == 0) {
diff -ur -x .* -x *.[oas] orig/include/linux/nfs_fs.h linux/include/linux/nfs_fs.h
--- orig/include/linux/nfs_fs.h	Tue Jan 30 16:11:15 2001
+++ linux/include/linux/nfs_fs.h	Wed Jan 31 23:53:56 2001
@@ -260,8 +260,8 @@
  * linux/fs/mount_clnt.c
  * (Used only by nfsroot module)
  */
-extern int  nfs_mount(struct sockaddr_in *, char *, struct nfs_fh *);
-extern int  nfs3_mount(struct sockaddr_in *, char *, struct nfs_fh *);
+extern int  nfs_mount(struct sockaddr_in *, char *, struct nfs3_fh *);
+extern int  nfs3_mount(struct sockaddr_in *, char *, struct nfs3_fh *);
 
 /*
  * inline functions

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
