Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266144AbUFXQee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266144AbUFXQee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 12:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266148AbUFXQee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 12:34:34 -0400
Received: from outmx007.isp.belgacom.be ([195.238.3.234]:41183 "EHLO
	outmx007.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S266144AbUFXQeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 12:34:21 -0400
Subject: [PATCH 2.6.7-mm1] dirent merge
From: FabF <fabian.frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-56IjHbEeGAu30pG71vbZ"
Message-Id: <1088100200.2211.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 24 Jun 2004 20:03:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-56IjHbEeGAu30pG71vbZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

	Here's a dirent struct merge to dirent.h.
btw, I don't see any diff. between old_linux_dirent & linux_dirent (?)

Regards,
FabF

--=-56IjHbEeGAu30pG71vbZ
Content-Disposition: attachment; filename=dirent1.diff
Content-Type: text/x-patch; name=dirent1.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur orig~dirent/arch/ppc64/kernel/sys_ppc32.c edited~dirent/arch/ppc64/kernel/sys_ppc32.c
--- orig~dirent/arch/ppc64/kernel/sys_ppc32.c	2004-06-16 07:19:42.000000000 +0200
+++ edited~dirent/arch/ppc64/kernel/sys_ppc32.c	2004-06-24 19:21:53.000000000 +0200
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/fs.h> 
+#include <linux/dirent.h>
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
@@ -77,17 +78,6 @@
 
 #include "pci.h"
 
-/* readdir & getdents */
-#define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))
-#define ROUND_UP(x) (((x)+sizeof(u32)-1) & ~(sizeof(u32)-1))
-
-struct old_linux_dirent32 {
-	u32		d_ino;
-	u32		d_offset;
-	unsigned short	d_namlen;
-	char		d_name[1];
-};
-
 struct readdir_callback32 {
 	struct old_linux_dirent32 __user * dirent;
 	int count;
diff -Naur orig~dirent/arch/s390/kernel/compat_linux.c edited~dirent/arch/s390/kernel/compat_linux.c
--- orig~dirent/arch/s390/kernel/compat_linux.c	2004-06-16 07:19:51.000000000 +0200
+++ edited~dirent/arch/s390/kernel/compat_linux.c	2004-06-24 19:25:59.000000000 +0200
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/fs.h> 
+#include <linux/dirent.h>
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
@@ -355,18 +356,6 @@
 		return sys_ftruncate(fd, (high << 32) | low);
 }
 
-/* readdir & getdents */
-
-#define NAME_OFFSET(de) ((int) ((de)->d_name - (char *) (de)))
-#define ROUND_UP(x) (((x)+sizeof(u32)-1) & ~(sizeof(u32)-1))
-
-struct old_linux_dirent32 {
-	u32		d_ino;
-	u32		d_offset;
-	unsigned short	d_namlen;
-	char		d_name[1];
-};
-
 struct readdir_callback32 {
 	struct old_linux_dirent32 * dirent;
 	int count;
@@ -414,13 +403,6 @@
 	return error;
 }
 
-struct linux_dirent32 {
-	u32		d_ino;
-	u32		d_off;
-	unsigned short	d_reclen;
-	char		d_name[1];
-};
-
 struct getdents_callback32 {
 	struct linux_dirent32 * current_dir;
 	struct linux_dirent32 * previous;
diff -Naur orig~dirent/fs/readdir.c edited~dirent/fs/readdir.c
--- orig~dirent/fs/readdir.c	2004-06-16 07:19:22.000000000 +0200
+++ edited~dirent/fs/readdir.c	2004-06-24 19:29:49.000000000 +0200
@@ -50,18 +50,9 @@
  * anyway. Thus the special "fillonedir()" function for that
  * case (the low-level handlers don't need to care about this).
  */
-#define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))
-#define ROUND_UP(x) (((x)+sizeof(long)-1) & ~(sizeof(long)-1))
 
 #ifdef __ARCH_WANT_OLD_READDIR
 
-struct old_linux_dirent {
-	unsigned long	d_ino;
-	unsigned long	d_offset;
-	unsigned short	d_namlen;
-	char		d_name[1];
-};
-
 struct readdir_callback {
 	struct old_linux_dirent __user * dirent;
 	int result;
@@ -122,12 +113,6 @@
  * New, all-improved, singing, dancing, iBCS2-compliant getdents()
  * interface. 
  */
-struct linux_dirent {
-	unsigned long	d_ino;
-	unsigned long	d_off;
-	unsigned short	d_reclen;
-	char		d_name[1];
-};
 
 struct getdents_callback {
 	struct linux_dirent __user * current_dir;
@@ -141,7 +126,7 @@
 {
 	struct linux_dirent __user * dirent;
 	struct getdents_callback * buf = (struct getdents_callback *) __buf;
-	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 2);
+	int reclen = ROUND_UPL(NAME_OFFSET(dirent) + namlen + 2);
 
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
@@ -211,8 +196,6 @@
 	return error;
 }
 
-#define ROUND_UP64(x) (((x)+sizeof(u64)-1) & ~(sizeof(u64)-1))
-
 struct getdents_callback64 {
 	struct linux_dirent64 __user * current_dir;
 	struct linux_dirent64 __user * previous;
diff -Naur orig~dirent/include/linux/dirent.h edited~dirent/include/linux/dirent.h
--- orig~dirent/include/linux/dirent.h	2004-06-16 07:19:44.000000000 +0200
+++ edited~dirent/include/linux/dirent.h	2004-06-24 19:32:51.000000000 +0200
@@ -1,11 +1,17 @@
 #ifndef _LINUX_DIRENT_H
 #define _LINUX_DIRENT_H
 
+/* readdir & getdents */
+#define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))
+#define ROUND_UP(x) (((x)+sizeof(u32)-1) & ~(sizeof(u32)-1))
+#define ROUND_UPL(x) (((x)+sizeof(long)-1) & ~(sizeof(long)-1))
+#define ROUND_UP64(x) (((x)+sizeof(u64)-1) & ~(sizeof(u64)-1))
+
 struct dirent {
 	long		d_ino;
 	__kernel_off_t	d_off;
 	unsigned short	d_reclen;
-	char		d_name[256]; /* We must not include limits.h! */
+	char		d_name[256];
 };
 
 struct dirent64 {
@@ -16,6 +22,34 @@
 	char		d_name[256];
 };
 
+struct old_linux_dirent {
+	unsigned long	d_ino;
+	unsigned long	d_offset;
+	unsigned short	d_namlen;
+	char		d_name[1];
+};
+
+struct old_linux_dirent32 {
+	u32		d_ino;
+	u32		d_offset;
+	unsigned short	d_namlen;
+	char		d_name[1];
+};
+
+struct linux_dirent {
+	unsigned long	d_ino;
+	unsigned long	d_off;
+	unsigned short	d_reclen;
+	char		d_name[1];
+};
+
+struct linux_dirent32 {
+	u32		d_ino;
+	u32		d_off;
+	unsigned short	d_reclen;
+	char		d_name[1];
+};
+
 #ifdef __KERNEL__
 
 struct linux_dirent64 {
@@ -28,5 +62,4 @@
 
 #endif	/* __KERNEL__ */
 
-
 #endif

--=-56IjHbEeGAu30pG71vbZ--

