Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbRFRAy0>; Sun, 17 Jun 2001 20:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263288AbRFRAyR>; Sun, 17 Jun 2001 20:54:17 -0400
Received: from ugw.utcc.utoronto.ca ([128.100.100.3]:55793 "HELO
	ugw.utcc.utoronto.ca") by vger.kernel.org with SMTP
	id <S263257AbRFRAyH>; Sun, 17 Jun 2001 20:54:07 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] allow getdents64() to return 64-bit d_off values
Date: Sun, 17 Jun 2001 20:53:42 -0400
From: Chris Siebenmann <cks@utcc.utoronto.ca>
Message-Id: <01Jun17.205350edt.230371@ugw.utcc.utoronto.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Currently getdents64() returns d_off values that have been truncated
to 32 bits and then sign extended for all but the last directory entry
it returns. This is because the filldir functions have been typedef'd
and declared as taking an 'off_t offset' instead of a 'loff_t offset'.

 This patch fixes the main code. It is relative to 2.4.5, but applies
cleanly to 2.4.5-ac13. The resulting kernel boots and works fine on 
an x86 machine, and I've checked that it introduces no new compile
time warning messages.

 Remaining work: several architectures have their own filldir routines
used to implement system call compatability layers. I have not included
patches for them because I am not sure how I should handle it: include
all of the architectures in this patch? Make separate patches for
each architecture and send them to each maintainer? Just notify each
maintainer?

 The spots I have been able to find that have this are:
- arch/alpha/kernel/osf_sys.c:	osf_filldir()
- arch/sparc/kernel/sys_sunos.c:	sunos_filldir() sunos_filldirentry()
- arch/mips/kernel/sysirix.c:	irix_filldir32() irix_filldir64()
- arch/sparc64/kernel/sys_sparc32.c:	fillonedir() filldir()
- arch/sparc64/kernel/sys_sunos32.c:	sunos_filldir() sunos_filldirentry()
- arch/ia64/ia32/sys_ia32.c:	filldir32() fillonedir32()
- arch/s390x/kernel/linux32.c:	fillonedir() filldir()
- arch/parisc/hpux/fs.c:	filldir()

 The changes are all obvious: change 'off_t' to 'loff_t'. I believe
any missed places should provoke compile-time warnings.

diff -u -N -r linux-2.4.5/fs/fat/dir.c linux-2.4.5-patched/fs/fat/dir.c
--- linux-2.4.5/fs/fat/dir.c	Wed Apr 18 14:49:12 2001
+++ linux-2.4.5-patched/fs/fat/dir.c	Sun Jun 17 20:13:43 2001
@@ -590,7 +590,7 @@
 	void * buf,
 	const char * name,
 	int name_len,
-	off_t offset,
+	loff_t offset,
 	ino_t ino,
 	unsigned int d_type)
 {
diff -u -N -r linux-2.4.5/fs/nfsd/nfs3xdr.c linux-2.4.5-patched/fs/nfsd/nfs3xdr.c
--- linux-2.4.5/fs/nfsd/nfs3xdr.c	Sat May 19 21:02:45 2001
+++ linux-2.4.5-patched/fs/nfsd/nfs3xdr.c	Mon Jun 11 02:36:56 2001
@@ -661,7 +661,7 @@
 #define NFS3_ENTRYPLUS_BAGGAGE	(1 + 21 + 1 + (NFS3_FHSIZE >> 2))
 static int
 encode_entry(struct readdir_cd *cd, const char *name,
-	     int namlen, off_t offset, ino_t ino, unsigned int d_type, int plus)
+	     int namlen, loff_t offset, ino_t ino, unsigned int d_type, int plus)
 {
 	u32		*p = cd->buffer;
 	int		buflen, slen, elen;
@@ -737,14 +737,14 @@
 
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
diff -u -N -r linux-2.4.5/fs/nfsd/nfsfh.c linux-2.4.5-patched/fs/nfsd/nfsfh.c
--- linux-2.4.5/fs/nfsd/nfsfh.c	Sat May 19 20:47:55 2001
+++ linux-2.4.5-patched/fs/nfsd/nfsfh.c	Mon Jun 11 01:41:57 2001
@@ -41,7 +41,7 @@
  * the name matching the specified inode number.
  */
 static int filldir_one(void * __buf, const char * name, int len,
-			off_t pos, ino_t ino, unsigned int d_type)
+			loff_t pos, ino_t ino, unsigned int d_type)
 {
 	struct nfsd_getdents_callback *buf = __buf;
 	struct qstr *qs = buf->name;
diff -u -N -r linux-2.4.5/fs/nfsd/nfsxdr.c linux-2.4.5-patched/fs/nfsd/nfsxdr.c
--- linux-2.4.5/fs/nfsd/nfsxdr.c	Thu Feb  8 22:38:38 2001
+++ linux-2.4.5-patched/fs/nfsd/nfsxdr.c	Mon Jun 11 02:37:39 2001
@@ -395,7 +395,7 @@
 
 int
 nfssvc_encode_entry(struct readdir_cd *cd, const char *name,
-		    int namlen, off_t offset, ino_t ino, unsigned int d_type)
+		    int namlen, loff_t offset, ino_t ino, unsigned int d_type)
 {
 	u32	*p = cd->buffer;
 	int	buflen, slen;
diff -u -N -r linux-2.4.5/fs/readdir.c linux-2.4.5-patched/fs/readdir.c
--- linux-2.4.5/fs/readdir.c	Mon Dec 11 16:45:42 2000
+++ linux-2.4.5-patched/fs/readdir.c	Mon Jun 11 01:42:28 2001
@@ -122,7 +122,7 @@
 	int count;
 };
 
-static int fillonedir(void * __buf, const char * name, int namlen, off_t offset,
+static int fillonedir(void * __buf, const char * name, int namlen, loff_t offset,
 		      ino_t ino, unsigned int d_type)
 {
 	struct readdir_callback * buf = (struct readdir_callback *) __buf;
@@ -183,7 +183,7 @@
 	int error;
 };
 
-static int filldir(void * __buf, const char * name, int namlen, off_t offset,
+static int filldir(void * __buf, const char * name, int namlen, loff_t offset,
 		   ino_t ino, unsigned int d_type)
 {
 	struct linux_dirent * dirent;
@@ -261,7 +261,7 @@
 	int error;
 };
 
-static int filldir64(void * __buf, const char * name, int namlen, off_t offset,
+static int filldir64(void * __buf, const char * name, int namlen, loff_t offset,
 		     ino_t ino, unsigned int d_type)
 {
 	struct linux_dirent64 * dirent, d;
diff -u -N -r linux-2.4.5/fs/umsdos/dir.c linux-2.4.5-patched/fs/umsdos/dir.c
--- linux-2.4.5/fs/umsdos/dir.c	Fri Feb  9 14:29:44 2001
+++ linux-2.4.5-patched/fs/umsdos/dir.c	Mon Jun 11 03:02:29 2001
@@ -67,7 +67,7 @@
 static int umsdos_dir_once (	void *buf,
 				const char *name,
 				int len,
-				off_t offset,
+				loff_t offset,
 				ino_t ino,
 				unsigned type)
 {
diff -u -N -r linux-2.4.5/fs/umsdos/rdir.c linux-2.4.5-patched/fs/umsdos/rdir.c
--- linux-2.4.5/fs/umsdos/rdir.c	Fri Feb  9 14:29:44 2001
+++ linux-2.4.5-patched/fs/umsdos/rdir.c	Mon Jun 11 03:04:15 2001
@@ -32,7 +32,7 @@
 static int rdir_filldir (	void *buf,
 				const char *name,
 				int name_len,
-				off_t offset,
+				loff_t offset,
 				ino_t ino,
 				unsigned int d_type)
 {
diff -u -N -r linux-2.4.5/include/linux/fs.h linux-2.4.5-patched/include/linux/fs.h
--- linux-2.4.5/include/linux/fs.h	Fri May 25 21:01:28 2001
+++ linux-2.4.5-patched/include/linux/fs.h	Sun Jun 17 20:13:43 2001
@@ -753,7 +753,7 @@
  * This allows the kernel to read directories into kernel space or
  * to have different dirent layouts depending on the binary type.
  */
-typedef int (*filldir_t)(void *, const char *, int, off_t, ino_t, unsigned);
+typedef int (*filldir_t)(void *, const char *, int, loff_t, ino_t, unsigned);
 
 struct block_device_operations {
 	int (*open) (struct inode *, struct file *);
diff -u -N -r linux-2.4.5/include/linux/nfsd/nfsd.h linux-2.4.5-patched/include/linux/nfsd/nfsd.h
--- linux-2.4.5/include/linux/nfsd/nfsd.h	Fri May 25 21:02:17 2001
+++ linux-2.4.5-patched/include/linux/nfsd/nfsd.h	Mon Jun 11 16:18:56 2001
@@ -57,7 +57,7 @@
 	char			dotonly;
 };
 typedef int		(*encode_dent_fn)(struct readdir_cd *, const char *,
-						int, off_t, ino_t, unsigned int);
+						int, loff_t, ino_t, unsigned int);
 typedef int (*nfsd_dirop_t)(struct inode *, struct dentry *, int, int);
 
 /*
diff -u -N -r linux-2.4.5/include/linux/nfsd/xdr.h linux-2.4.5-patched/include/linux/nfsd/xdr.h
--- linux-2.4.5/include/linux/nfsd/xdr.h	Fri May 25 21:02:40 2001
+++ linux-2.4.5-patched/include/linux/nfsd/xdr.h	Mon Jun 11 16:19:44 2001
@@ -151,7 +151,7 @@
 int nfssvc_encode_readdirres(struct svc_rqst *, u32 *, struct nfsd_readdirres *);
 
 int nfssvc_encode_entry(struct readdir_cd *, const char *name,
-				int namlen, off_t offset, ino_t ino, unsigned int);
+				int namlen, loff_t offset, ino_t ino, unsigned int);
 
 int nfssvc_release_fhandle(struct svc_rqst *, u32 *, struct nfsd_fhandle *);
 
diff -u -N -r linux-2.4.5/include/linux/nfsd/xdr3.h linux-2.4.5-patched/include/linux/nfsd/xdr3.h
--- linux-2.4.5/include/linux/nfsd/xdr3.h	Fri May 25 21:02:42 2001
+++ linux-2.4.5-patched/include/linux/nfsd/xdr3.h	Mon Jun 11 16:19:48 2001
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
 
 
	- cks
