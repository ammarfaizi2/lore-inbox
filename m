Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265762AbSJTEZp>; Sun, 20 Oct 2002 00:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265764AbSJTEZp>; Sun, 20 Oct 2002 00:25:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56077 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265762AbSJTEZn>;
	Sun, 20 Oct 2002 00:25:43 -0400
Date: Sun, 20 Oct 2002 05:31:47 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: [PATCH] work around duff ABIs
Message-ID: <20021020053147.C5285@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


*sigh*.  i hate this kind of bullshit.  please, don't anyone ever try
to pass 64-bit args through the syscall interface again.

Index: fs/read_write.c
===================================================================
RCS file: /var/cvs/linux-2.5/fs/read_write.c,v
retrieving revision 1.5
diff -u -p -r1.5 read_write.c
--- fs/read_write.c	17 Oct 2002 20:43:22 -0000	1.5
+++ fs/read_write.c	20 Oct 2002 04:22:15 -0000
@@ -14,6 +14,7 @@
 #include <linux/security.h>
 #include <linux/module.h>
 
+#include <asm/byteorder.h>
 #include <asm/uaccess.h>
 
 struct file_operations generic_ro_fops = {
@@ -285,9 +286,15 @@ asmlinkage ssize_t sys_write(unsigned in
 	return ret;
 }
 
-asmlinkage ssize_t sys_pread64(unsigned int fd, char *buf,
-			     size_t count, loff_t pos)
+#ifdef __BIG_ENDIAN
+asmlinkage ssize_t sys_pread64(unsigned int fd, char *buf, size_t count,
+				unsigned int high, unsigned int low)
+#else
+asmlinkage ssize_t sys_pread64(unsigned int fd, char *buf, size_t count,
+				unsigned int low, unsigned int high)
+#endif
 {
+	loff_t pos = (loff_t)high << 32 | low;
 	struct file *file;
 	ssize_t ret = -EBADF;
 
@@ -303,9 +310,15 @@ asmlinkage ssize_t sys_pread64(unsigned 
 	return ret;
 }
 
-asmlinkage ssize_t sys_pwrite64(unsigned int fd, const char *buf,
-			      size_t count, loff_t pos)
+#ifdef __BIG_ENDIAN
+asmlinkage ssize_t sys_pwrite64(unsigned int fd, const char *buf, size_t count,
+				unsigned int high, unsigned int low)
+#else
+asmlinkage ssize_t sys_pwrite64(unsigned int fd, const char *buf, size_t count,
+				unsigned int low, unsigned int high)
+#endif
 {
+	loff_t pos = (loff_t)high << 32 | low;
 	struct file *file;
 	ssize_t ret = -EBADF;
 
Index: fs/open.c
===================================================================
RCS file: /var/cvs/linux-2.5/fs/open.c,v
retrieving revision 1.4
diff -u -p -r1.4 open.c
--- fs/open.c	17 Oct 2002 20:43:22 -0000	1.4
+++ fs/open.c	20 Oct 2002 04:22:16 -0000
@@ -18,6 +18,7 @@
 #include <linux/backing-dev.h>
 #include <linux/security.h>
 
+#include <asm/byteorder.h>
 #include <asm/uaccess.h>
 
 #define special_file(m) (S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))
@@ -205,18 +206,34 @@ asmlinkage long sys_ftruncate(unsigned i
 	return do_sys_ftruncate(fd, length, 1);
 }
 
-/* LFS versions of truncate are only needed on 32 bit machines */
+/*
+ * LFS versions of truncate are only needed on 32 bit machines.  PA-RISC
+ * and MIPS ABIs specify 64-bit alignment for 64-bit quantities, but glibc
+ * ignores this and passes 64-bit quantities in misaligned registers.
+ */
 #if BITS_PER_LONG == 32
-asmlinkage long sys_truncate64(const char * path, loff_t length)
+#ifdef __BIG_ENDIAN
+asmlinkage long sys_truncate64(const char * path, unsigned int high, unsigned int low)
 {
-	return do_sys_truncate(path, length);
+	return do_sys_truncate(path, (loff_t)high << 32 | low);
 }
 
-asmlinkage long sys_ftruncate64(unsigned int fd, loff_t length)
+asmlinkage long sys_ftruncate64(unsigned int fd, unsigned int high, unsigned int low)
 {
-	return do_sys_ftruncate(fd, length, 0);
+	return do_sys_ftruncate(fd, (loff_t)high << 32 | low, 0);
 }
-#endif
+#else	/* !__BIG_ENDIAN */
+asmlinkage long sys_truncate64(const char * path, unsigned int low, unsigned int high)
+{
+	return do_sys_truncate(path, (loff_t)high << 32 | low);
+}
+
+asmlinkage long sys_ftruncate64(unsigned int fd, unsigned int low, unsigned int high)
+{
+	return do_sys_ftruncate(fd, (loff_t)high << 32 | low, 0);
+}
+#endif	/* !__BIG_ENDIAN */
+#endif	/* BITS_PER_LONG == 32 */
 
 #if !(defined(__alpha__) || defined(__ia64__))
 

-- 
Revolutions do not require corporate support.
