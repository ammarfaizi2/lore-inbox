Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVKJAa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVKJAa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVKJAa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:30:26 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:32173 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751118AbVKJAaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:30:25 -0500
Date: Thu, 10 Nov 2005 00:30:24 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] handling 64bit values for st_ino]
Message-ID: <20051110003024.GD7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[My apologies, forgot to Cc the first half...]

Date: Thu, 10 Nov 2005 00:27:29 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/2] handling 64bit values for st_ino
User-Agent: Mutt/1.4.1i

	We certainly do not want 64bit kernel ino_t, since that would
screw icache lookups for no good reason; fs with 64bit keys used to
identify inodes can just use iget5().
	*However*, there's an area where we have a problem: stat64() and
getdents64() _could_ return 64bit st_ino/d_ino just fine, if not for having
too narrow field in kstat and argument of filldir_t.  As it is, we have
->getattr() fill struct kstat and the syscall proper copy the contents of
that struct kstat into user buffer.  stat64 has 64bit st_ino; kstat
field used to set it is only unsigned long.
	Note that it's not just a theory - there are filesystems that
want 64bit values in st_ino (AFS, for one).  There are consumers of
these values ready to deal with 64bit values - aside of aforementioned
syscalls, e.g. NFSv3 and NFSv4 are happy with those.

	Fix is pretty cheap and consists of two parts:
1) widen struct kstat ->ino to u64, add a macro (check_inumber()) to
be used in callers of ->getattr() that want to store ->ino in possibly
narrower fields and care about overflows (stuff like sys_old_stat() with
its 16bit st_ino clearly doesn't ;-)

2) widen ino argument of filldir_t to u64, update prototypes of instances.

Below is the first part (kstat), filldir_t one goes in the next patch.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----

 arch/ia64/ia32/sys_ia32.c         |    3 ++-
 arch/mips/kernel/linux32.c        |    3 +++
 arch/mips/kernel/sysirix.c        |    2 ++
 arch/parisc/hpux/fs.c             |    2 ++
 arch/parisc/kernel/sys_parisc32.c |    3 ++-
 arch/powerpc/kernel/sys_ppc32.c   |    3 ++-
 arch/s390/kernel/compat_linux.c   |    2 ++
 arch/sparc64/kernel/sys_sparc32.c |    3 ++-
 arch/sparc64/solaris/fs.c         |    3 ++-
 arch/x86_64/ia32/sys_ia32.c       |    2 ++
 fs/stat.c                         |    2 ++
 include/linux/stat.h              |   23 ++++++++++++++++++++++-
 12 files changed, 45 insertions(+), 6 deletions(-)

0a5cfa057c7f56cf55cc1611f60b680643e1636b
diff --git a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
--- a/arch/ia64/ia32/sys_ia32.c
+++ b/arch/ia64/ia32/sys_ia32.c
@@ -130,7 +130,8 @@ int cp_compat_stat(struct kstat *stat, s
 
 	if ((u64) stat->size > MAX_NON_LFS ||
 	    !old_valid_dev(stat->dev) ||
-	    !old_valid_dev(stat->rdev))
+	    !old_valid_dev(stat->rdev) ||
+	    !check_inumber(stat->ino, &ubuf->st_ino))
 		return -EOVERFLOW;
 
 	if (clear_user(ubuf, sizeof(*ubuf)))
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -76,6 +76,9 @@ int cp_compat_stat(struct kstat *stat, s
 	if (!new_valid_dev(stat->dev) || !new_valid_dev(stat->rdev))
 		return -EOVERFLOW;
 
+	if (!check_inumber(stat->ino, &tmp.st_ino))
+		return -EOVERFLOW;
+
 	memset(&tmp, 0, sizeof(tmp));
 	tmp.st_dev = new_encode_dev(stat->dev);
 	tmp.st_ino = stat->ino;
diff --git a/arch/mips/kernel/sysirix.c b/arch/mips/kernel/sysirix.c
--- a/arch/mips/kernel/sysirix.c
+++ b/arch/mips/kernel/sysirix.c
@@ -1175,6 +1175,8 @@ static int irix_xstat32_xlate(struct kst
 
 	if (!sysv_valid_dev(stat->dev) || !sysv_valid_dev(stat->rdev))
 		return -EOVERFLOW;
+	if (!check_inumber(stat->ino, &ub.st_ino))
+		return -EOVERFLOW;
 	ub.st_dev     = sysv_encode_dev(stat->dev);
 	ub.st_ino     = stat->ino;
 	ub.st_mode    = stat->mode;
diff --git a/arch/parisc/hpux/fs.c b/arch/parisc/hpux/fs.c
--- a/arch/parisc/hpux/fs.c
+++ b/arch/parisc/hpux/fs.c
@@ -147,6 +147,8 @@ static int cp_hpux_stat(struct kstat *st
 
 	if (!new_valid_dev(stat->dev) || !new_valid_dev(stat->rdev))
 		return -EOVERFLOW;
+	if (!check_inumber(stat->ino, &tmp.st_ino))
+		return -EOVERFLOW;
 
 	memset(&tmp, 0, sizeof(tmp));
 	tmp.st_dev = new_encode_dev(stat->dev);
diff --git a/arch/parisc/kernel/sys_parisc32.c b/arch/parisc/kernel/sys_parisc32.c
--- a/arch/parisc/kernel/sys_parisc32.c
+++ b/arch/parisc/kernel/sys_parisc32.c
@@ -242,7 +242,8 @@ int cp_compat_stat(struct kstat *stat, s
 	int err;
 
 	if (stat->size > MAX_NON_LFS || !new_valid_dev(stat->dev) ||
-	    !new_valid_dev(stat->rdev))
+	    !new_valid_dev(stat->rdev) ||
+	    !check_inumber(stat->ino, &statbuf->st_ino))
 		return -EOVERFLOW;
 
 	err  = put_user(new_encode_dev(stat->dev), &statbuf->st_dev);
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -126,7 +126,8 @@ int cp_compat_stat(struct kstat *stat, s
 	long err;
 
 	if (stat->size > MAX_NON_LFS || !new_valid_dev(stat->dev) ||
-	    !new_valid_dev(stat->rdev))
+	    !new_valid_dev(stat->rdev) ||
+	    !check_inumber(stat->ino, &statbuf->st_ino))
 		return -EOVERFLOW;
 
 	err  = access_ok(VERIFY_WRITE, statbuf, sizeof(*statbuf)) ? 0 : -EFAULT;
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -362,6 +362,8 @@ int cp_compat_stat(struct kstat *stat, s
 
 	if (!old_valid_dev(stat->dev) || !old_valid_dev(stat->rdev))
 		return -EOVERFLOW;
+	if (!check_inumber(stat->ino, &statbuf->st_ino))
+		return -EOVERFLOW;
 
 	err = put_user(old_encode_dev(stat->dev), &statbuf->st_dev);
 	err |= put_user(stat->ino, &statbuf->st_ino);
diff --git a/arch/sparc64/kernel/sys_sparc32.c b/arch/sparc64/kernel/sys_sparc32.c
--- a/arch/sparc64/kernel/sys_sparc32.c
+++ b/arch/sparc64/kernel/sys_sparc32.c
@@ -340,7 +340,8 @@ int cp_compat_stat(struct kstat *stat, s
 	int err;
 
 	if (stat->size > MAX_NON_LFS || !old_valid_dev(stat->dev) ||
-	    !old_valid_dev(stat->rdev))
+	    !old_valid_dev(stat->rdev) ||
+	    !check_inumber(stat->ino, &statbuf->st_ino))
 		return -EOVERFLOW;
 
 	err  = put_user(old_encode_dev(stat->dev), &statbuf->st_dev);
diff --git a/arch/sparc64/solaris/fs.c b/arch/sparc64/solaris/fs.c
--- a/arch/sparc64/solaris/fs.c
+++ b/arch/sparc64/solaris/fs.c
@@ -83,7 +83,8 @@ static inline int putstat(struct sol_sta
 {
 	if (kbuf->size > MAX_NON_LFS ||
 	    !sysv_valid_dev(kbuf->dev) ||
-	    !sysv_valid_dev(kbuf->rdev))
+	    !sysv_valid_dev(kbuf->rdev) ||
+	    !check_inumber(kbuf->ino, &ubuf->st_ino))
 		return -EOVERFLOW;
 	if (put_user (sysv_encode_dev(kbuf->dev), &ubuf->st_dev)	||
 	    __put_user (kbuf->ino, &ubuf->st_ino)		||
diff --git a/arch/x86_64/ia32/sys_ia32.c b/arch/x86_64/ia32/sys_ia32.c
--- a/arch/x86_64/ia32/sys_ia32.c
+++ b/arch/x86_64/ia32/sys_ia32.c
@@ -85,6 +85,8 @@ int cp_compat_stat(struct kstat *kbuf, s
 		return -EOVERFLOW;
 	if (kbuf->size >= 0x7fffffff)
 		return -EOVERFLOW;
+	if (!check_inumber(kbuf->ino, &ubuf->st_ino))
+		return -EOVERFLOW;
 	if (!access_ok(VERIFY_WRITE, ubuf, sizeof(struct compat_stat)) ||
 	    __put_user (old_encode_dev(kbuf->dev), &ubuf->st_dev) ||
 	    __put_user (kbuf->ino, &ubuf->st_ino) ||
diff --git a/fs/stat.c b/fs/stat.c
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -199,6 +199,8 @@ static int cp_new_stat(struct kstat *sta
 #else
 	tmp.st_dev = new_encode_dev(stat->dev);
 #endif
+	if (!check_inumber(stat->ino, &tmp.st_ino))
+		return -EOVERFLOW;
 	tmp.st_ino = stat->ino;
 	tmp.st_mode = stat->mode;
 	tmp.st_nlink = stat->nlink;
diff --git a/include/linux/stat.h b/include/linux/stat.h
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -57,7 +57,7 @@
 #include <linux/time.h>
 
 struct kstat {
-	unsigned long	ino;
+	u64		ino;
 	dev_t		dev;
 	umode_t		mode;
 	unsigned int	nlink;
@@ -72,6 +72,27 @@ struct kstat {
 	unsigned long	blocks;
 };
 
+extern void __check_inumber_with_bogus_size(void);
+#define check_inumber(ino, to)					\
+({								\
+	int res = 1;						\
+	switch (sizeof(*to)) {					\
+		case 2:						\
+			if (ino > 0xffff)			\
+				res = 0;			\
+			break;					\
+		case 4:						\
+			if (ino > 0xffffffff)			\
+				res = 0;			\
+			break;					\
+		case 8:						\
+			break;					\
+		default:					\
+			__check_inumber_with_bogus_size();	\
+	}							\
+	res;							\
+})
+
 #endif
 
 #endif

----- End forwarded message -----
