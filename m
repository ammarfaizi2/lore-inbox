Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282067AbRKVHqq>; Thu, 22 Nov 2001 02:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282068AbRKVHqh>; Thu, 22 Nov 2001 02:46:37 -0500
Received: from [202.135.142.195] ([202.135.142.195]:43780 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S282067AbRKVHqW>; Thu, 22 Nov 2001 02:46:22 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: ajosey@rdg.opengroup.org, cyeoh@samba.org, torvalds@transmeta.com
Subject: [PATCH] PATH_MAX Includes Nul Fix
Date: Thu, 22 Nov 2001 18:45:56 +1100
Message-Id: <E166oYW-0000FI-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Grepping for PATH_MAX in the kernel reveals some ambiguity in whether
PATH_MAX includes a the trailing NUL or not.  From Andrew Josey
<ajosey@rdg.opengroup.org> (via Chris Yeoh):

 POSIX has long had an ambiguity in the area about whether the null
 byte is included in the PATH_MAX (it basically said both ways in
 the 1990 text). The POSIX.1a draft (the amendment to POSIX.1-1990)
 and XPG4 went with including the null byte in PATH_MAX, and the
 POSIX 1003.1-200x revision (Austin Group) and Single UNIX
 Specification Version 3 also continue this way.

Note that to reach compliance, glibc will need to be adjusted as
well.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.14/include/linux/limits.h working-2.4.14-pathmax/include/linux/limits.h
--- linux-2.4.14/include/linux/limits.h	Thu Jul 29 03:30:10 1999
+++ working-2.4.14-pathmax/include/linux/limits.h	Wed Nov 21 10:59:37 2001
@@ -11,7 +11,7 @@
 #define MAX_CANON        255	/* size of the canonical input queue */
 #define MAX_INPUT        255	/* size of the type-ahead buffer */
 #define NAME_MAX         255	/* # chars in a file name */
-#define PATH_MAX        4095	/* # chars in a path name */
+#define PATH_MAX        4096	/* # chars in a path name including nul */
 #define PIPE_BUF        4096	/* # bytes in atomic write to a pipe */
 
 #define RTSIG_MAX	  32
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.14/fs/dcache.c working-2.4.14-pathmax/fs/dcache.c
--- linux-2.4.14/fs/dcache.c	Thu Oct  4 15:57:36 2001
+++ working-2.4.14-pathmax/fs/dcache.c	Wed Nov 21 12:04:18 2001
@@ -1262,7 +1262,7 @@
 		panic("Cannot create buffer head SLAB cache");
 
 	names_cachep = kmem_cache_create("names_cache", 
-			PATH_MAX + 1, 0, 
+			PATH_MAX, 0, 
 			SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (!names_cachep)
 		panic("Cannot create names SLAB cache");
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.14/fs/namei.c working-2.4.14-pathmax/fs/namei.c
--- linux-2.4.14/fs/namei.c	Thu Oct 18 07:46:29 2001
+++ working-2.4.14-pathmax/fs/namei.c	Wed Nov 21 10:57:58 2001
@@ -99,16 +99,17 @@
  * kernel data space before using them..
  *
  * POSIX.1 2.4: an empty pathname is invalid (ENOENT).
+ * PATH_MAX includes the nul terminator --RR.
  */
 static inline int do_getname(const char *filename, char *page)
 {
 	int retval;
-	unsigned long len = PATH_MAX + 1;
+	unsigned long len = PATH_MAX;
 
 	if ((unsigned long) filename >= TASK_SIZE) {
 		if (!segment_eq(get_fs(), KERNEL_DS))
 			return -EFAULT;
-	} else if (TASK_SIZE - (unsigned long) filename < PATH_MAX + 1)
+	} else if (TASK_SIZE - (unsigned long) filename < PATH_MAX)
 		len = TASK_SIZE - (unsigned long) filename;
 
 	retval = strncpy_from_user((char *)page, filename, len);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.14/scripts/mkdep.c working-2.4.14-pathmax/scripts/mkdep.c
--- linux-2.4.14/scripts/mkdep.c	Sat Sep 15 07:40:00 2001
+++ working-2.4.14-pathmax/scripts/mkdep.c	Wed Nov 21 12:01:44 2001
@@ -218,7 +218,7 @@
 void add_path(const char * name)
 {
 	struct path_struct *path;
-	char resolved_path[PATH_MAX+1];
+	char resolved_path[PATH_MAX];
 	const char *name2;
 
 	if (strcmp(name, ".")) {

--
Premature optmztion is rt of all evl. --DK
