Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVGLLyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVGLLyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVGLLxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:53:01 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:6572 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261366AbVGLLwU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:52:20 -0400
Date: Tue, 12 Jul 2005 13:52:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] s390: fadvise hint values.
Message-ID: <20050712115219.GA28991@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
an ugly one. The fadvise hint values for POSIX_FADV_DONTNEED and
POSIX_FADV_NOREUSE in the kernel and the glibc differ for s390-64
(and worse the values for s390-31 and s390-64 differ as well ..).
The glibc always had 6 and 7 instead of 4 and 5 for these two values
for s390-64. My first reaction was to correct the values in the
glibc headers but as Ulrich Drepper pointed out that has some
unwanted consequences:
1) the applications build against the wrong values will get -EINVAL
   and the advice gets ignored, and
2) if the values 6 and 7 are ever used for some new advice then
   these applications might show erratic behaviour.
I can't say which and how many applications use fadvise so it might
be a better idea to fix this in the kernel.

Patch is attached, what do you think ?

blue skies,
  Martin.

---

[patch] s390: fadvise hint values.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add special case for the POSIX_FADV_DONTNEED and POSIX_FADV_NOREUSE
hint values for s390-64. The user space values in the s390-64 glibc
headers for these two defines have always been 6 and 7 instead of
4 and 5. All 64 bit applications therefore use the "wrong" values.
To get these applications working without recompiling the kernel
needs to accept the "wrong" values. Since the values for s390-31
are 4 and 5 the compat wrapper for fadvise64 and fadvise64_64
need to rewrite the values for 31 bit system calls.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/compat_linux.c   |   38 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/compat_wrapper.S |    4 ++--
 include/linux/fadvise.h           |   10 ++++++++++
 3 files changed, 50 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/compat_linux.c linux-2.6-patched/arch/s390/kernel/compat_linux.c
--- linux-2.6/arch/s390/kernel/compat_linux.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/compat_linux.c	2005-07-12 13:28:31.000000000 +0200
@@ -58,6 +58,7 @@
 #include <linux/compat.h>
 #include <linux/vfs.h>
 #include <linux/ptrace.h>
+#include <linux/fadvise.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
@@ -1043,3 +1044,40 @@ sys32_timer_create(clockid_t which_clock
 
 	return ret;
 }
+
+/*
+ * 31 bit emulation wrapper functions for sys_fadvise64/fadvise64_64.
+ * These need to rewrite the advise values for POSIX_FADV_{DONTNEED,NOREUSE}
+ * because the 31 bit values differ from the 64 bit values.
+ */
+
+asmlinkage long
+sys32_fadvise64(int fd, loff_t offset, size_t len, int advise)
+{
+	if (advise == 4)
+		advise = POSIX_FADV_DONTNEED;
+	else if (advise == 5)
+		advise = POSIX_FADV_NOREUSE;
+	return sys_fadvise64(fd, offset, len, advise);
+}
+
+struct fadvise64_64_args {
+	int fd;
+	long long offset;
+	long long len;
+	int advice;
+};
+
+asmlinkage long
+sys32_fadvise64_64(struct fadvise64_64_args __user *args)
+{
+	struct fadvise64_64_args a;
+
+	if ( copy_from_user(&a, args, sizeof(a)) )
+		return -EFAULT;
+	if (a.advice == 4)
+		a.advice = POSIX_FADV_DONTNEED;
+	else if (a.advice == 5)
+		a.advice = POSIX_FADV_NOREUSE;
+	return sys_fadvise64_64(a.fd, a.offset, a.len, a.advice);
+}
diff -urpN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-patched/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	2005-07-12 13:27:13.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/compat_wrapper.S	2005-07-12 13:28:36.000000000 +0200
@@ -1251,12 +1251,12 @@ sys32_fadvise64_wrapper:
 	or	%r3,%r4			# get low word of 64bit loff_t
 	llgfr	%r4,%r5			# size_t (unsigned long)
 	lgfr	%r5,%r6			# int
-	jg	sys_fadvise64
+	jg	sys32_fadvise64
 
 	.globl	sys32_fadvise64_64_wrapper
 sys32_fadvise64_64_wrapper:
 	llgtr	%r2,%r2			# struct fadvise64_64_args *
-	jg	s390_fadvise64_64
+	jg	sys32_fadvise64_64
 
 	.globl	sys32_clock_settime_wrapper
 sys32_clock_settime_wrapper:
diff -urpN linux-2.6/include/linux/fadvise.h linux-2.6-patched/include/linux/fadvise.h
--- linux-2.6/include/linux/fadvise.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/include/linux/fadvise.h	2005-07-12 13:28:40.000000000 +0200
@@ -5,7 +5,17 @@
 #define POSIX_FADV_RANDOM	1 /* Expect random page references.  */
 #define POSIX_FADV_SEQUENTIAL	2 /* Expect sequential page references.  */
 #define POSIX_FADV_WILLNEED	3 /* Will need these pages.  */
+
+/*
+ * The advise values for POSIX_FADV_DONTNEED and POSIX_ADV_NOREUSE
+ * for s390-64 differ from the values for the rest of the world.
+ */
+#if defined(__s390x__)
+#define POSIX_FADV_DONTNEED	6 /* Don't need these pages.  */
+#define POSIX_FADV_NOREUSE	7 /* Data will be accessed once.  */
+#else
 #define POSIX_FADV_DONTNEED	4 /* Don't need these pages.  */
 #define POSIX_FADV_NOREUSE	5 /* Data will be accessed once.  */
+#endif
 
 #endif	/* FADVISE_H_INCLUDED */
