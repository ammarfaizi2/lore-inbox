Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135217AbRDZJD6>; Thu, 26 Apr 2001 05:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135222AbRDZJDs>; Thu, 26 Apr 2001 05:03:48 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26899 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S135217AbRDZJDl>; Thu, 26 Apr 2001 05:03:41 -0400
Message-ID: <3AE7E198.45388E0@evision-ventures.com>
Date: Thu, 26 Apr 2001 10:51:36 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PATCH for 2.4.3 - tinny mount code cleanup (kernel 0.97 compatibility)
Content-Type: multipart/mixed;
 boundary="------------90F3D8AB4DDB5027AEB8A08F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------90F3D8AB4DDB5027AEB8A08F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The attached patch is fixing georgeous "backward compatibility"
in the mount system command. It is removing two useless defines in
the kernel headers and finally doubles the number of possible
flags for the mount command.

Please apply.

If there are any line count difference warnings when applying this
patch to the vanilla 2.4.3 tree- then please bear with me, 
it's only due to the fact that I preffered to edit this patch by hand
out form some other...

Thank's in advance.

-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort:
ru_RU.KOI8-R
--------------90F3D8AB4DDB5027AEB8A08F
Content-Type: text/plain; charset=us-ascii;
 name="mount.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mount.diff"

diff -ur linux/arch/sparc/kernel/sys_sunos.c new/arch/sparc/kernel/sys_sunos.c
--- linux/arch/sparc/kernel/sys_sunos.c	Wed Apr 18 20:40:50 2001
+++ new/arch/sparc/kernel/sys_sunos.c	Thu Apr 26 01:01:50 2001
@@ -749,7 +749,7 @@
 asmlinkage int
 sunos_mount(char *type, char *dir, int flags, void *data)
 {
-	int linux_flags = MS_MGC_MSK; /* new semantics */
+	int linux_flags = 0;
 	int ret = -EINVAL;
 	char *dev_fname = 0;
 	char *dir_page, *type_page;
diff -ur linux/arch/sparc64/kernel/sys_sunos32.c new/arch/sparc64/kernel/sys_sunos32.c
--- linux/arch/sparc64/kernel/sys_sunos32.c	Wed Apr 18 20:40:50 2001
+++ new/arch/sparc64/kernel/sys_sunos32.c	Thu Apr 26 01:01:46 2001
@@ -717,7 +717,7 @@
 asmlinkage int
 sunos_mount(char *type, char *dir, int flags, void *data)
 {
-	int linux_flags = MS_MGC_MSK; /* new semantics */
+	int linux_flags = 0;
 	int ret = -EINVAL;
 	char *dev_fname = 0;
 	char *dir_page, *type_page;
diff -ur linux/fs/super.c new/fs/super.c
--- linux/fs/super.c	Wed Apr 18 20:41:17 2001
+++ new/fs/super.c	Thu Apr 26 01:08:48 2001
@@ -1297,16 +1297,12 @@
 }
 
 /*
- * Flags is a 16-bit value that allows up to 16 non-fs dependent flags to
+ * Flags is a 32-bit value that allows up to 32 non-fs dependent flags to
  * be given to the mount() call (ie: read-only, no-dev, no-suid etc).
  *
  * data is a (void *) that can point to any structure up to
  * PAGE_SIZE-1 bytes, which can contain arbitrary fs-dependent
  * information (or be NULL).
- *
- * NOTE! As pre-0.97 versions of mount() didn't use this setup, the
- * flags used to have a special 16-bit magic number in the high word:
- * 0xC0ED. If this magic number is present, the high word is discarded.
  */
 long do_mount(char * dev_name, char * dir_name, char *type_page,
 		  unsigned long flags, void *data_page)
@@ -1317,10 +1313,6 @@
 	struct super_block *sb;
 	int retval = 0;
 
-	/* Discard magic */
-	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
-		flags &= ~MS_MGC_MSK;
- 
 	/* Basic sanity checks */
 
 	if (!dir_name || !*dir_name || !memchr(dir_name, 0, PAGE_SIZE))
@@ -1345,12 +1337,6 @@
 	if (!type_page || !memchr(type_page, 0, PAGE_SIZE))
 		return -EINVAL;
 
-#if 0	/* Can be deleted again. Introduced in patch-2.3.99-pre6 */
-	/* loopback mount? This is special - requires fewer capabilities */
-	if (strcmp(type_page, "bind")==0)
-		return do_loopback(dev_name, dir_name);
-#endif
-
 	/* for the rest we _really_ need capabilities... */
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
diff -ur linux/include/linux/fs.h new/include/linux/fs.h
--- linux/include/linux/fs.h	Wed Apr 18 20:41:18 2001
+++ new/include/linux/fs.h	Thu Apr 26 01:03:03 2001
@@ -121,12 +121,6 @@
 #define MS_RMT_MASK	(MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|\
 			MS_SYNCHRONOUS|MS_MANDLOCK|MS_NOATIME|MS_NODIRATIME)
 
-/*
- * Magic mount flag number. Has to be or-ed to the flag values.
- */
-#define MS_MGC_VAL 0xC0ED0000	/* magic flag number to indicate "new" flags */
-#define MS_MGC_MSK 0xffff0000	/* magic flag number mask */
-
 /* Inode flags - they have nothing to superblock flags now */
 
 #define S_SYNC		1	/* Writes are synced at once */

--------------90F3D8AB4DDB5027AEB8A08F--

