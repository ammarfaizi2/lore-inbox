Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752110AbWHOP1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbWHOP1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbWHOP1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:27:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45513 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752112AbWHOP0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:26:50 -0400
From: David Howells <dhowells@redhat.com>
Subject: [RHEL5 PATCH 1/2] VFS: Make filldir_t and struct kstat deal in 64-bit inode numbers [try #2]
Date: Tue, 15 Aug 2006 16:26:30 +0100
To: torvalds@osdl.org, akpm@osdl.org, trond.myklebust@fys.uio.no,
       aviro@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@linux-nfs.org, dhowells@redhat.com
Message-Id: <20060815152630.29222.29226.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060815152627.29222.71414.stgit@warthog.cambridge.redhat.com>
References: <20060815152627.29222.71414.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make filldir_t take a 64-bit inode number and struct kstat carry a 64-bit inode
number so that 64-bit inode numbers can be passed back to userspace.

The stat functions then returns the full 64-bit inode number where available
and where possible.  If it is not possible to represent the inode number
supplied by the filesystem in the field provided by userspace, then error
EOVERFLOW will be issued.

Similarly, the getdents/readdir functions now pass the full 64-bit inode number
to userspace where possible, returning EOVERFLOW instead when a directory entry
is encountered that can't be properly represented.

Note that this means that some inodes will not be stat'able on a 32-bit system
with old libraries where they were before - but it does mean that there will be
no ambiguity over what a 32-bit inode number refers to.

Note similarly that directory scans may be cut short with an error on a 32-bit
system with old libraries where the scan would work before for the same
reasons.

It is judged unlikely that this situation will occur because modern glibc uses
64-bit capable versions of stat and getdents class functions exclusively, and
that older systems are unlikely to encounter unrepresentable inode numbers
anyway.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/alpha/kernel/osf_sys.c       |    6 +++++-
 arch/ia64/ia32/sys_ia32.c         |   23 ++++++++++++++++++-----
 arch/mips/kernel/linux32.c        |    2 ++
 arch/mips/kernel/sysirix.c        |   10 +++++++---
 arch/parisc/hpux/fs.c             |    6 +++++-
 arch/parisc/kernel/sys_parisc32.c |   19 ++++++++++++++++---
 arch/powerpc/kernel/sys_ppc32.c   |   15 ++++++++++++---
 arch/s390/kernel/compat_linux.c   |    5 +++++
 arch/sparc/kernel/sys_sunos.c     |   16 ++++++++++++----
 arch/sparc64/kernel/sys_sparc32.c |    5 +++++
 arch/sparc64/kernel/sys_sunos32.c |   12 ++++++++++--
 arch/sparc64/solaris/fs.c         |    7 ++++++-
 arch/x86_64/ia32/sys_ia32.c       |    7 ++++++-
 fs/afs/dir.c                      |    4 ++--
 fs/compat.c                       |   18 +++++++++++++-----
 fs/exportfs/expfs.c               |    2 +-
 fs/fat/dir.c                      |    2 +-
 fs/nfsd/nfs4recover.c             |    2 +-
 fs/readdir.c                      |   18 +++++++++++++-----
 fs/reiserfs/xattr.c               |    6 +++---
 fs/stat.c                         |    6 ++++++
 include/linux/fs.h                |    2 +-
 include/linux/stat.h              |    2 +-
 23 files changed, 151 insertions(+), 44 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 73c7622..ff094cd 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -116,17 +116,21 @@ osf_filldir(void *__buf, const char *nam
 	struct osf_dirent __user *dirent;
 	struct osf_dirent_callback *buf = (struct osf_dirent_callback *) __buf;
 	unsigned int reclen = ROUND_UP(NAME_OFFSET + namlen + 1);
+	unsigned int d_ino;
 
 	buf->error = -EINVAL;	/* only used if we fail */
 	if (reclen > buf->count)
 		return -EINVAL;
+	d_ino = ino;
+	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
+		return -EOVERFLOW;
 	if (buf->basep) {
 		if (put_user(offset, buf->basep))
 			return -EFAULT;
 		buf->basep = NULL;
 	}
 	dirent = buf->dirent;
-	put_user(ino, &dirent->d_ino);
+	put_user(d_ino, &dirent->d_ino);
 	put_user(namlen, &dirent->d_namlen);
 	put_user(reclen, &dirent->d_reclen);
 	if (copy_to_user(dirent->d_name, name, namlen) ||
diff --git a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
index 6aa3c51..bb86b8a 100644
--- a/arch/ia64/ia32/sys_ia32.c
+++ b/arch/ia64/ia32/sys_ia32.c
@@ -125,6 +125,7 @@ sys32_execve (char __user *name, compat_
 
 int cp_compat_stat(struct kstat *stat, struct compat_stat __user *ubuf)
 {
+	compat_ino_t ino;
 	int err;
 
 	if ((u64) stat->size > MAX_NON_LFS ||
@@ -132,11 +133,15 @@ int cp_compat_stat(struct kstat *stat, s
 	    !old_valid_dev(stat->rdev))
 		return -EOVERFLOW;
 
+	ino = stat->ino;
+	if (sizeof(ino) < sizeof(stat->ino) && ino != stat->ino)
+		return -EOVERFLOW;
+
 	if (clear_user(ubuf, sizeof(*ubuf)))
 		return -EFAULT;
 
 	err  = __put_user(old_encode_dev(stat->dev), &ubuf->st_dev);
-	err |= __put_user(stat->ino, &ubuf->st_ino);
+	err |= __put_user(ino, &ubuf->st_ino);
 	err |= __put_user(stat->mode, &ubuf->st_mode);
 	err |= __put_user(stat->nlink, &ubuf->st_nlink);
 	err |= __put_user(high2lowuid(stat->uid), &ubuf->st_uid);
@@ -1222,16 +1227,20 @@ struct readdir32_callback {
 };
 
 static int
-filldir32 (void *__buf, const char *name, int namlen, loff_t offset, ino_t ino,
+filldir32 (void *__buf, const char *name, int namlen, loff_t offset, u64 ino,
 	   unsigned int d_type)
 {
 	struct compat_dirent __user * dirent;
 	struct getdents32_callback * buf = (struct getdents32_callback *) __buf;
 	int reclen = ROUND_UP(offsetof(struct compat_dirent, d_name) + namlen + 1, 4);
+	u32 d_ino;
 
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
+	d_ino = ino;
+	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
+		return -EOVERFLOW;
 	buf->error = -EFAULT;	/* only used if we fail.. */
 	dirent = buf->previous;
 	if (dirent)
@@ -1239,7 +1248,7 @@ filldir32 (void *__buf, const char *name
 			return -EFAULT;
 	dirent = buf->current_dir;
 	buf->previous = dirent;
-	if (put_user(ino, &dirent->d_ino)
+	if (put_user(d_ino, &dirent->d_ino)
 	    || put_user(reclen, &dirent->d_reclen)
 	    || copy_to_user(dirent->d_name, name, namlen)
 	    || put_user(0, dirent->d_name + namlen))
@@ -1287,17 +1296,21 @@ out:
 }
 
 static int
-fillonedir32 (void * __buf, const char * name, int namlen, loff_t offset, ino_t ino,
+fillonedir32 (void * __buf, const char * name, int namlen, loff_t offset, u64 ino,
 	      unsigned int d_type)
 {
 	struct readdir32_callback * buf = (struct readdir32_callback *) __buf;
 	struct old_linux32_dirent __user * dirent;
+	u32 d_ino;
 
 	if (buf->count)
 		return -EINVAL;
+	d_ino = ino;
+	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
+		return -EOVERFLOW;
 	buf->count++;
 	dirent = buf->dirent;
-	if (put_user(ino, &dirent->d_ino)
+	if (put_user(d_ino, &dirent->d_ino)
 	    || put_user(offset, &dirent->d_offset)
 	    || put_user(namlen, &dirent->d_namlen)
 	    || copy_to_user(dirent->d_name, name, namlen)
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 450ac59..048e98c 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -77,6 +77,8 @@ int cp_compat_stat(struct kstat *stat, s
 	memset(&tmp, 0, sizeof(tmp));
 	tmp.st_dev = new_encode_dev(stat->dev);
 	tmp.st_ino = stat->ino;
+	if (sizeof(tmp.st_ino) < sizeof(stat->ino) && tmp.st_ino != stat->ino)
+		return -EOVERFLOW;
 	tmp.st_mode = stat->mode;
 	tmp.st_nlink = stat->nlink;
 	SET_UID(tmp.st_uid, stat->uid);
diff --git a/arch/mips/kernel/sysirix.c b/arch/mips/kernel/sysirix.c
index 1137dd6..8d4bd0a 100644
--- a/arch/mips/kernel/sysirix.c
+++ b/arch/mips/kernel/sysirix.c
@@ -1739,12 +1739,13 @@ #define NAME_OFFSET32(de) ((int) ((de)->
 #define ROUND_UP32(x) (((x)+sizeof(u32)-1) & ~(sizeof(u32)-1))
 
 static int irix_filldir32(void *__buf, const char *name,
-	int namlen, loff_t offset, ino_t ino, unsigned int d_type)
+	int namlen, loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct irix_dirent32 __user *dirent;
 	struct irix_dirent32_callback *buf = __buf;
 	unsigned short reclen = ROUND_UP32(NAME_OFFSET32(dirent) + namlen + 1);
 	int err = 0;
+	u32 d_ino;
 
 #ifdef DEBUG_GETDENTS
 	printk("\nirix_filldir32[reclen<%d>namlen<%d>count<%d>]",
@@ -1753,12 +1754,15 @@ #endif
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
+	d_ino = ino;
+	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
+		return -EOVERFLOW;
 	dirent = buf->previous;
 	if (dirent)
 		err = __put_user(offset, &dirent->d_off);
 	dirent = buf->current_dir;
 	err |= __put_user(dirent, &buf->previous);
-	err |= __put_user(ino, &dirent->d_ino);
+	err |= __put_user(d_ino, &dirent->d_ino);
 	err |= __put_user(reclen, &dirent->d_reclen);
 	err |= copy_to_user((char __user *)dirent->d_name, name, namlen) ? -EFAULT : 0;
 	err |= __put_user(0, &dirent->d_name[namlen]);
@@ -1837,7 +1841,7 @@ #define NAME_OFFSET64(de) ((int) ((de)->
 #define ROUND_UP64(x) (((x)+sizeof(u64)-1) & ~(sizeof(u64)-1))
 
 static int irix_filldir64(void *__buf, const char *name,
-	int namlen, loff_t offset, ino_t ino, unsigned int d_type)
+	int namlen, loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct irix_dirent64 __user *dirent;
 	struct irix_dirent64_callback * buf = __buf;
diff --git a/arch/parisc/hpux/fs.c b/arch/parisc/hpux/fs.c
index d7c80ed..6e79dbf 100644
--- a/arch/parisc/hpux/fs.c
+++ b/arch/parisc/hpux/fs.c
@@ -77,17 +77,21 @@ static int filldir(void * __buf, const c
 {
 	struct hpux_dirent * dirent;
 	struct getdents_callback * buf = (struct getdents_callback *) __buf;
+	ino_t d_ino;
 	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1);
 
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
+	d_ino = ino;
+	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
+		return -EOVERFLOW;
 	dirent = buf->previous;
 	if (dirent)
 		put_user(offset, &dirent->d_off);
 	dirent = buf->current_dir;
 	buf->previous = dirent;
-	put_user(ino, &dirent->d_ino);
+	put_user(d_ino, &dirent->d_ino);
 	put_user(reclen, &dirent->d_reclen);
 	put_user(namlen, &dirent->d_namlen);
 	copy_to_user(dirent->d_name, name, namlen);
diff --git a/arch/parisc/kernel/sys_parisc32.c b/arch/parisc/kernel/sys_parisc32.c
index b748698..e3b30bc 100644
--- a/arch/parisc/kernel/sys_parisc32.c
+++ b/arch/parisc/kernel/sys_parisc32.c
@@ -237,14 +237,19 @@ int sys32_settimeofday(struct compat_tim
 
 int cp_compat_stat(struct kstat *stat, struct compat_stat __user *statbuf)
 {
+	compat_ino_t ino;
 	int err;
 
 	if (stat->size > MAX_NON_LFS || !new_valid_dev(stat->dev) ||
 	    !new_valid_dev(stat->rdev))
 		return -EOVERFLOW;
 
+	ino = stat->ino;
+	if (sizeof(ino) < sizeof(stat->ino) && ino != stat->ino)
+		return -EOVERFLOW;
+
 	err  = put_user(new_encode_dev(stat->dev), &statbuf->st_dev);
-	err |= put_user(stat->ino, &statbuf->st_ino);
+	err |= put_user(ino, &statbuf->st_ino);
 	err |= put_user(stat->mode, &statbuf->st_mode);
 	err |= put_user(stat->nlink, &statbuf->st_nlink);
 	err |= put_user(0, &statbuf->st_reserved1);
@@ -312,16 +317,20 @@ filldir32 (void *__buf, const char *name
 	struct linux32_dirent __user * dirent;
 	struct getdents32_callback * buf = (struct getdents32_callback *) __buf;
 	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1, 4);
+	u32 d_ino;
 
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
+	d_ino = ino;
+	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
+		return -EOVERFLOW;
 	dirent = buf->previous;
 	if (dirent)
 		put_user(offset, &dirent->d_off);
 	dirent = buf->current_dir;
 	buf->previous = dirent;
-	put_user(ino, &dirent->d_ino);
+	put_user(d_ino, &dirent->d_ino);
 	put_user(reclen, &dirent->d_reclen);
 	copy_to_user(dirent->d_name, name, namlen);
 	put_user(0, dirent->d_name + namlen);
@@ -371,12 +380,16 @@ fillonedir32 (void * __buf, const char *
 {
 	struct readdir32_callback * buf = (struct readdir32_callback *) __buf;
 	struct old_linux32_dirent __user * dirent;
+	u32 d_ino;
 
 	if (buf->count)
 		return -EINVAL;
+	d_ino = ino;
+	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
+		return -EOVERFLOW;
 	buf->count++;
 	dirent = buf->dirent;
-	put_user(ino, &dirent->d_ino);
+	put_user(d_ino, &dirent->d_ino);
 	put_user(offset, &dirent->d_offset);
 	put_user(namlen, &dirent->d_namlen);
 	copy_to_user(dirent->d_name, name, namlen);
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 2e29286..2457178 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -69,16 +69,20 @@ struct readdir_callback32 {
 };
 
 static int fillonedir(void * __buf, const char * name, int namlen,
-		                  off_t offset, ino_t ino, unsigned int d_type)
+		                  off_t offset, u64 ino, unsigned int d_type)
 {
 	struct readdir_callback32 * buf = (struct readdir_callback32 *) __buf;
 	struct old_linux_dirent32 __user * dirent;
+	ino_t d_ino;
 
 	if (buf->count)
 		return -EINVAL;
+	d_ino = ino;
+	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
+		return -EOVERFLOW;
 	buf->count++;
 	dirent = buf->dirent;
-	put_user(ino, &dirent->d_ino);
+	put_user(d_ino, &dirent->d_ino);
 	put_user(offset, &dirent->d_offset);
 	put_user(namlen, &dirent->d_namlen);
 	copy_to_user(dirent->d_name, name, namlen);
@@ -120,15 +124,20 @@ asmlinkage long ppc32_select(u32 n, comp
 
 int cp_compat_stat(struct kstat *stat, struct compat_stat __user *statbuf)
 {
+	compat_ino_t ino;
 	long err;
 
 	if (stat->size > MAX_NON_LFS || !new_valid_dev(stat->dev) ||
 	    !new_valid_dev(stat->rdev))
 		return -EOVERFLOW;
 
+	ino = stat->ino;
+	if (sizeof(ino) < sizeof(stat->ino) && ino != stat->ino)
+		return -EOVERFLOW;
+
 	err  = access_ok(VERIFY_WRITE, statbuf, sizeof(*statbuf)) ? 0 : -EFAULT;
 	err |= __put_user(new_encode_dev(stat->dev), &statbuf->st_dev);
-	err |= __put_user(stat->ino, &statbuf->st_ino);
+	err |= __put_user(ino, &statbuf->st_ino);
 	err |= __put_user(stat->mode, &statbuf->st_mode);
 	err |= __put_user(stat->nlink, &statbuf->st_nlink);
 	err |= __put_user(stat->uid, &statbuf->st_uid);
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 785c9f7..86e5f99 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -357,11 +357,16 @@ asmlinkage long sys32_ftruncate64(unsign
 
 int cp_compat_stat(struct kstat *stat, struct compat_stat __user *statbuf)
 {
+	compat_ino_t ino;
 	int err;
 
 	if (!old_valid_dev(stat->dev) || !old_valid_dev(stat->rdev))
 		return -EOVERFLOW;
 
+	ino = stat->ino;
+	if (sizeof(ino) < sizeof(stat->ino) && ino != stat->ino)
+		return -EOVERFLOW;
+
 	err = put_user(old_encode_dev(stat->dev), &statbuf->st_dev);
 	err |= put_user(stat->ino, &statbuf->st_ino);
 	err |= put_user(stat->mode, &statbuf->st_mode);
diff --git a/arch/sparc/kernel/sys_sunos.c b/arch/sparc/kernel/sys_sunos.c
index aa0fb2e..5bb15bf 100644
--- a/arch/sparc/kernel/sys_sunos.c
+++ b/arch/sparc/kernel/sys_sunos.c
@@ -325,21 +325,25 @@ #define NAME_OFFSET(de) ((int) ((de)->d_
 #define ROUND_UP(x) (((x)+sizeof(long)-1) & ~(sizeof(long)-1))
 
 static int sunos_filldir(void * __buf, const char * name, int namlen,
-			 loff_t offset, ino_t ino, unsigned int d_type)
+			 loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct sunos_dirent __user *dirent;
 	struct sunos_dirent_callback * buf = __buf;
+	unsigned long d_ino;
 	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1);
 
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
+	d_ino = ino;
+	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
+		return -EOVERFLOW;
 	dirent = buf->previous;
 	if (dirent)
 		put_user(offset, &dirent->d_off);
 	dirent = buf->curr;
 	buf->previous = dirent;
-	put_user(ino, &dirent->d_ino);
+	put_user(d_ino, &dirent->d_ino);
 	put_user(namlen, &dirent->d_namlen);
 	put_user(reclen, &dirent->d_reclen);
 	copy_to_user(dirent->d_name, name, namlen);
@@ -406,19 +410,23 @@ struct sunos_direntry_callback {
 };
 
 static int sunos_filldirentry(void * __buf, const char * name, int namlen,
-			      loff_t offset, ino_t ino, unsigned int d_type)
+			      loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct sunos_direntry __user *dirent;
 	struct sunos_direntry_callback *buf = __buf;
+	unsigned long d_ino;
 	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1);
 
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
+	d_ino = ino;
+	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
+		return -EOVERFLOW;
 	dirent = buf->previous;
 	dirent = buf->curr;
 	buf->previous = dirent;
-	put_user(ino, &dirent->d_ino);
+	put_user(d_ino, &dirent->d_ino);
 	put_user(namlen, &dirent->d_namlen);
 	put_user(reclen, &dirent->d_reclen);
 	copy_to_user(dirent->d_name, name, namlen);
diff --git a/arch/sparc64/kernel/sys_sparc32.c b/arch/sparc64/kernel/sys_sparc32.c
index c88ae23..b4967df 100644
--- a/arch/sparc64/kernel/sys_sparc32.c
+++ b/arch/sparc64/kernel/sys_sparc32.c
@@ -337,12 +337,17 @@ asmlinkage long sys32_ftruncate64(unsign
 
 int cp_compat_stat(struct kstat *stat, struct compat_stat __user *statbuf)
 {
+	compat_ino_t ino;
 	int err;
 
 	if (stat->size > MAX_NON_LFS || !old_valid_dev(stat->dev) ||
 	    !old_valid_dev(stat->rdev))
 		return -EOVERFLOW;
 
+	ino = stat->ino;
+	if (sizeof(ino) < sizeof(stat->ino) && ino != stat->ino)
+		return -EOVERFLOW;
+
 	err  = put_user(old_encode_dev(stat->dev), &statbuf->st_dev);
 	err |= put_user(stat->ino, &statbuf->st_ino);
 	err |= put_user(stat->mode, &statbuf->st_mode);
diff --git a/arch/sparc64/kernel/sys_sunos32.c b/arch/sparc64/kernel/sys_sunos32.c
index 87ebdf8..6cf00c3 100644
--- a/arch/sparc64/kernel/sys_sunos32.c
+++ b/arch/sparc64/kernel/sys_sunos32.c
@@ -280,16 +280,20 @@ static int sunos_filldir(void * __buf, c
 	struct sunos_dirent __user *dirent;
 	struct sunos_dirent_callback * buf = (struct sunos_dirent_callback *) __buf;
 	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1);
+	u32 d_ino;
 
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
+	d_ino = ino;
+	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
+		return -EOVERFLOW;
 	dirent = buf->previous;
 	if (dirent)
 		put_user(offset, &dirent->d_off);
 	dirent = buf->curr;
 	buf->previous = dirent;
-	put_user(ino, &dirent->d_ino);
+	put_user(d_ino, &dirent->d_ino);
 	put_user(namlen, &dirent->d_namlen);
 	put_user(reclen, &dirent->d_reclen);
 	if (copy_to_user(dirent->d_name, name, namlen))
@@ -363,14 +367,18 @@ static int sunos_filldirentry(void * __b
 	struct sunos_direntry_callback * buf =
 		(struct sunos_direntry_callback *) __buf;
 	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1);
+	u32 d_ino;
 
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
+	d_ino = ino;
+	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
+		return -EOVERFLOW;
 	dirent = buf->previous;
 	dirent = buf->curr;
 	buf->previous = dirent;
-	put_user(ino, &dirent->d_ino);
+	put_user(d_ino, &dirent->d_ino);
 	put_user(namlen, &dirent->d_namlen);
 	put_user(reclen, &dirent->d_reclen);
 	if (copy_to_user(dirent->d_name, name, namlen))
diff --git a/arch/sparc64/solaris/fs.c b/arch/sparc64/solaris/fs.c
index 0f0eb6a..12a940c 100644
--- a/arch/sparc64/solaris/fs.c
+++ b/arch/sparc64/solaris/fs.c
@@ -82,12 +82,17 @@ #define UFSMAGIC (((unsigned)'u'<<24)||(
 
 static inline int putstat(struct sol_stat __user *ubuf, struct kstat *kbuf)
 {
+	u32 ino;
+
 	if (kbuf->size > MAX_NON_LFS ||
 	    !sysv_valid_dev(kbuf->dev) ||
 	    !sysv_valid_dev(kbuf->rdev))
 		return -EOVERFLOW;
+	ino = kbuf->ino;
+	if (sizeof(ino) < sizeof(kbuf->ino) && ino != kbuf->ino)
+		return -EOVERFLOW;
 	if (put_user (sysv_encode_dev(kbuf->dev), &ubuf->st_dev)	||
-	    __put_user (kbuf->ino, &ubuf->st_ino)		||
+	    __put_user (ino, &ubuf->st_ino)				||
 	    __put_user (kbuf->mode, &ubuf->st_mode)		||
 	    __put_user (kbuf->nlink, &ubuf->st_nlink)	||
 	    __put_user (kbuf->uid, &ubuf->st_uid)		||
diff --git a/arch/x86_64/ia32/sys_ia32.c b/arch/x86_64/ia32/sys_ia32.c
index 9c13099..8669f7e 100644
--- a/arch/x86_64/ia32/sys_ia32.c
+++ b/arch/x86_64/ia32/sys_ia32.c
@@ -75,6 +75,8 @@ #define AA(__x)		((unsigned long)(__x))
 
 int cp_compat_stat(struct kstat *kbuf, struct compat_stat __user *ubuf)
 {
+	compat_ino_t ino;
+
 	typeof(ubuf->st_uid) uid = 0;
 	typeof(ubuf->st_gid) gid = 0;
 	SET_UID(uid, kbuf->uid);
@@ -83,9 +85,12 @@ int cp_compat_stat(struct kstat *kbuf, s
 		return -EOVERFLOW;
 	if (kbuf->size >= 0x7fffffff)
 		return -EOVERFLOW;
+	ino = kbuf->ino;
+	if (sizeof(ino) < sizeof(kbuf->ino) && ino != kbuf->ino)
+		return -EOVERFLOW;
 	if (!access_ok(VERIFY_WRITE, ubuf, sizeof(struct compat_stat)) ||
 	    __put_user (old_encode_dev(kbuf->dev), &ubuf->st_dev) ||
-	    __put_user (kbuf->ino, &ubuf->st_ino) ||
+	    __put_user (ino, &ubuf->st_ino) ||
 	    __put_user (kbuf->mode, &ubuf->st_mode) ||
 	    __put_user (kbuf->nlink, &ubuf->st_nlink) ||
 	    __put_user (uid, &ubuf->st_uid) ||
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 9800a07..94afb75 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -30,7 +30,7 @@ static int afs_dir_readdir(struct file *
 static int afs_d_revalidate(struct dentry *dentry, struct nameidata *nd);
 static int afs_d_delete(struct dentry *dentry);
 static int afs_dir_lookup_filldir(void *_cookie, const char *name, int nlen,
-				  loff_t fpos, ino_t ino, unsigned dtype);
+				  loff_t fpos, u64 ino, unsigned dtype);
 
 const struct file_operations afs_dir_file_operations = {
 	.open		= afs_dir_open,
@@ -408,7 +408,7 @@ static int afs_dir_readdir(struct file *
  *   uniquifier through dtype
  */
 static int afs_dir_lookup_filldir(void *_cookie, const char *name, int nlen,
-				  loff_t fpos, ino_t ino, unsigned dtype)
+				  loff_t fpos, u64 ino, unsigned dtype)
 {
 	struct afs_dir_lookup_cookie *cookie = _cookie;
 
diff --git a/fs/compat.c b/fs/compat.c
index e31e9cf..55cf405 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -918,20 +918,24 @@ struct compat_readdir_callback {
 };
 
 static int compat_fillonedir(void *__buf, const char *name, int namlen,
-			loff_t offset, ino_t ino, unsigned int d_type)
+			loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct compat_readdir_callback *buf = __buf;
 	struct compat_old_linux_dirent __user *dirent;
+	compat_ulong_t d_ino;
 
 	if (buf->result)
 		return -EINVAL;
+	d_ino = ino;
+	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
+		return -EOVERFLOW;
 	buf->result++;
 	dirent = buf->dirent;
 	if (!access_ok(VERIFY_WRITE, dirent,
 			(unsigned long)(dirent->d_name + namlen + 1) -
 				(unsigned long)dirent))
 		goto efault;
-	if (	__put_user(ino, &dirent->d_ino) ||
+	if (	__put_user(d_ino, &dirent->d_ino) ||
 		__put_user(offset, &dirent->d_offset) ||
 		__put_user(namlen, &dirent->d_namlen) ||
 		__copy_to_user(dirent->d_name, name, namlen) ||
@@ -982,22 +986,26 @@ struct compat_getdents_callback {
 };
 
 static int compat_filldir(void *__buf, const char *name, int namlen,
-		loff_t offset, ino_t ino, unsigned int d_type)
+		loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct compat_linux_dirent __user * dirent;
 	struct compat_getdents_callback *buf = __buf;
+	compat_ulong_t d_ino;
 	int reclen = COMPAT_ROUND_UP(NAME_OFFSET(dirent) + namlen + 2);
 
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
+	d_ino = ino;
+	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
+		return -EOVERFLOW;
 	dirent = buf->previous;
 	if (dirent) {
 		if (__put_user(offset, &dirent->d_off))
 			goto efault;
 	}
 	dirent = buf->current_dir;
-	if (__put_user(ino, &dirent->d_ino))
+	if (__put_user(d_ino, &dirent->d_ino))
 		goto efault;
 	if (__put_user(reclen, &dirent->d_reclen))
 		goto efault;
@@ -1068,7 +1076,7 @@ struct compat_getdents_callback64 {
 };
 
 static int compat_filldir64(void * __buf, const char * name, int namlen, loff_t offset,
-		     ino_t ino, unsigned int d_type)
+		     u64 ino, unsigned int d_type)
 {
 	struct linux_dirent64 __user *dirent;
 	struct compat_getdents_callback64 *buf = __buf;
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 4c39009..93e77c3 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -315,7 +315,7 @@ struct getdents_callback {
  * the name matching the specified inode number.
  */
 static int filldir_one(void * __buf, const char * name, int len,
-			loff_t pos, ino_t ino, unsigned int d_type)
+			loff_t pos, u64 ino, unsigned int d_type)
 {
 	struct getdents_callback *buf = __buf;
 	int result = 0;
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 698b85b..9e6eae9 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -647,7 +647,7 @@ static int fat_readdir(struct file *filp
 }
 
 static int fat_ioctl_filldir(void *__buf, const char *name, int name_len,
-			     loff_t offset, ino_t ino, unsigned int d_type)
+			     loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct fat_ioctl_filldir_callback *buf = __buf;
 	struct dirent __user *d1 = buf->dirent;
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 06da750..ae50364 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -183,7 +183,7 @@ struct dentry_list_arg {
 
 static int
 nfsd4_build_dentrylist(void *arg, const char *name, int namlen,
-		loff_t offset, ino_t ino, unsigned int d_type)
+		loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct dentry_list_arg *dla = arg;
 	struct list_head *dentries = &dla->dentries;
diff --git a/fs/readdir.c b/fs/readdir.c
index b610932..bff3ee5 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -69,20 +69,24 @@ struct readdir_callback {
 };
 
 static int fillonedir(void * __buf, const char * name, int namlen, loff_t offset,
-		      ino_t ino, unsigned int d_type)
+		      u64 ino, unsigned int d_type)
 {
 	struct readdir_callback * buf = (struct readdir_callback *) __buf;
 	struct old_linux_dirent __user * dirent;
+	unsigned long d_ino;
 
 	if (buf->result)
 		return -EINVAL;
+	d_ino = ino;
+	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
+		return -EOVERFLOW;
 	buf->result++;
 	dirent = buf->dirent;
 	if (!access_ok(VERIFY_WRITE, dirent,
 			(unsigned long)(dirent->d_name + namlen + 1) -
 				(unsigned long)dirent))
 		goto efault;
-	if (	__put_user(ino, &dirent->d_ino) ||
+	if (	__put_user(d_ino, &dirent->d_ino) ||
 		__put_user(offset, &dirent->d_offset) ||
 		__put_user(namlen, &dirent->d_namlen) ||
 		__copy_to_user(dirent->d_name, name, namlen) ||
@@ -138,22 +142,26 @@ struct getdents_callback {
 };
 
 static int filldir(void * __buf, const char * name, int namlen, loff_t offset,
-		   ino_t ino, unsigned int d_type)
+		   u64 ino, unsigned int d_type)
 {
 	struct linux_dirent __user * dirent;
 	struct getdents_callback * buf = (struct getdents_callback *) __buf;
+	unsigned long d_ino;
 	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 2);
 
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
+	d_ino = ino;
+	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
+		return -EOVERFLOW;
 	dirent = buf->previous;
 	if (dirent) {
 		if (__put_user(offset, &dirent->d_off))
 			goto efault;
 	}
 	dirent = buf->current_dir;
-	if (__put_user(ino, &dirent->d_ino))
+	if (__put_user(d_ino, &dirent->d_ino))
 		goto efault;
 	if (__put_user(reclen, &dirent->d_reclen))
 		goto efault;
@@ -222,7 +230,7 @@ struct getdents_callback64 {
 };
 
 static int filldir64(void * __buf, const char * name, int namlen, loff_t offset,
-		     ino_t ino, unsigned int d_type)
+		     u64 ino, unsigned int d_type)
 {
 	struct linux_dirent64 __user *dirent;
 	struct getdents_callback64 * buf = (struct getdents_callback64 *) __buf;
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 39fedaa..b41942d 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -773,7 +773,7 @@ int reiserfs_xattr_del(struct inode *ino
 
 static int
 reiserfs_delete_xattrs_filler(void *buf, const char *name, int namelen,
-			      loff_t offset, ino_t ino, unsigned int d_type)
+			      loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct dentry *xadir = (struct dentry *)buf;
 
@@ -851,7 +851,7 @@ struct reiserfs_chown_buf {
 /* XXX: If there is a better way to do this, I'd love to hear about it */
 static int
 reiserfs_chown_xattrs_filler(void *buf, const char *name, int namelen,
-			     loff_t offset, ino_t ino, unsigned int d_type)
+			     loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct reiserfs_chown_buf *chown_buf = (struct reiserfs_chown_buf *)buf;
 	struct dentry *xafile, *xadir = chown_buf->xadir;
@@ -1036,7 +1036,7 @@ struct reiserfs_listxattr_buf {
 
 static int
 reiserfs_listxattr_filler(void *buf, const char *name, int namelen,
-			  loff_t offset, ino_t ino, unsigned int d_type)
+			  loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct reiserfs_listxattr_buf *b = (struct reiserfs_listxattr_buf *)buf;
 	int len = 0;
diff --git a/fs/stat.c b/fs/stat.c
index 3a44dcf..9abc1ab 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -139,6 +139,8 @@ static int cp_old_stat(struct kstat *sta
 	memset(&tmp, 0, sizeof(struct __old_kernel_stat));
 	tmp.st_dev = old_encode_dev(stat->dev);
 	tmp.st_ino = stat->ino;
+	if (sizeof(tmp.st_ino) < sizeof(stat->ino) && tmp.st_ino != stat->ino)
+		return -EOVERFLOW;
 	tmp.st_mode = stat->mode;
 	tmp.st_nlink = stat->nlink;
 	if (tmp.st_nlink != stat->nlink)
@@ -209,6 +211,8 @@ #else
 	tmp.st_dev = new_encode_dev(stat->dev);
 #endif
 	tmp.st_ino = stat->ino;
+	if (sizeof(tmp.st_ino) < sizeof(stat->ino) && tmp.st_ino != stat->ino)
+		return -EOVERFLOW;
 	tmp.st_mode = stat->mode;
 	tmp.st_nlink = stat->nlink;
 	if (tmp.st_nlink != stat->nlink)
@@ -346,6 +350,8 @@ #else
 	tmp.st_rdev = huge_encode_dev(stat->rdev);
 #endif
 	tmp.st_ino = stat->ino;
+	if (sizeof(tmp.st_ino) < sizeof(stat->ino) && tmp.st_ino != stat->ino)
+		return -EOVERFLOW;
 #ifdef STAT64_HAS_BROKEN_ST_INO
 	tmp.__st_ino = stat->ino;
 #endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3cc9657..91248d3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1003,7 +1003,7 @@ int generic_osync_inode(struct inode *, 
  * This allows the kernel to read directories into kernel space or
  * to have different dirent layouts depending on the binary type.
  */
-typedef int (*filldir_t)(void *, const char *, int, loff_t, ino_t, unsigned);
+typedef int (*filldir_t)(void *, const char *, int, loff_t, u64, unsigned);
 
 struct block_device_operations {
 	int (*open) (struct inode *, struct file *);
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 8669291..679ef0d 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -57,7 +57,7 @@ #include <linux/types.h>
 #include <linux/time.h>
 
 struct kstat {
-	unsigned long	ino;
+	u64		ino;
 	dev_t		dev;
 	umode_t		mode;
 	unsigned int	nlink;
