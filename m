Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288742AbSANElB>; Sun, 13 Jan 2002 23:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288747AbSANEkv>; Sun, 13 Jan 2002 23:40:51 -0500
Received: from [202.135.142.194] ([202.135.142.194]:21007 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S288742AbSANEkm>; Sun, 13 Jan 2002 23:40:42 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: cyeoh@samba.org, linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: [PATCH] 2.5: PATH_MAX length fix
Date: Mon, 14 Jan 2002 15:40:48 +1100
Message-Id: <E16PyvQ-0006zk-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  Kernel usage currently is confused about PATH_MAX.

D: From Andrew Josey <ajosey@rdg.opengroup.org> (via Chris Yeoh):
D:
D:  POSIX has long had an ambiguity in the area about whether the null
D:  byte is included in the PATH_MAX (it basically said both ways in
D:  the 1990 text). The POSIX.1a draft (the amendment to POSIX.1-1990)
D:  and XPG4 went with including the null byte in PATH_MAX, and the
D:  POSIX 1003.1-200x revision (Austin Group) and Single UNIX
D:  Specification Version 3 also continue this way.

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
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
