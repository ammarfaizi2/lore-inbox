Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264499AbUFLBPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbUFLBPX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 21:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbUFLBPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 21:15:23 -0400
Received: from salzburg.nitnet.com.br ([200.157.204.105]:33217 "EHLO
	nat.cesarb.net") by vger.kernel.org with ESMTP id S264499AbUFLBO4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 21:14:56 -0400
Date: Fri, 11 Jun 2004 22:11:29 -0300
To: linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@math.psu.edu>
Subject: [PATCH] O_NOATIME support
Message-ID: <20040612011129.GD1967@flower.home.cesarb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(not subscribed to lkml, please CC: me on replies)

This patch adds support for the O_NOATIME open flag (GNU extension):

int O_NOATIME  	Macro
  If this bit is set, read will not update the access time of the file.
  See File Times. This is used by programs that do backups, so that
  backing a file up does not count as reading it. Only the owner of the
  file or the superuser may use this bit.

It is useful if you want to do something with the file atime (for
instance, moving files that have not been accessed in a while to
somewhere else, or something like Debian's popularity-contest) but you
also want to read all files periodically (for instance, tripwire or
debsums).

Currently, the program that reads all files periodically has to use
utimes, which can race with the atime update:

    A               B
  open
  fstat
  read
                  open
                  read
                  close
  close
  utimes

And the file still has the old atime, instead of the new one from when B
did the read from it. This problem does not happen if A uses O_NOATIME
instead of utimes to preserve the atime.

This patch adds the O_NOATIME constant for all architectures, but it
would also be possible to add it one architecture at a time by defining
it to 0 when not defined in asm-*.

Based on patch by Marek Michalkiewicz <marekm@i17linuxb.ists.pwr.wroc.pl> at
http://www.uwsg.iu.edu/hypermail/linux/kernel/9811.2/0118.html

Lightly tested on i386.


 fs/fcntl.c                  |    7 ++++++-
 fs/namei.c                  |    5 +++++
 include/asm-alpha/fcntl.h   |    1 +
 include/asm-arm/fcntl.h     |    1 +
 include/asm-arm26/fcntl.h   |    1 +
 include/asm-cris/fcntl.h    |    1 +
 include/asm-h8300/fcntl.h   |    1 +
 include/asm-i386/fcntl.h    |    1 +
 include/asm-ia64/fcntl.h    |    1 +
 include/asm-m68k/fcntl.h    |    1 +
 include/asm-mips/fcntl.h    |    1 +
 include/asm-parisc/fcntl.h  |    1 +
 include/asm-ppc/fcntl.h     |    1 +
 include/asm-ppc64/fcntl.h   |    1 +
 include/asm-s390/fcntl.h    |    1 +
 include/asm-sh/fcntl.h      |    1 +
 include/asm-sparc/fcntl.h   |    1 +
 include/asm-sparc64/fcntl.h |    1 +
 include/asm-v850/fcntl.h    |    1 +
 include/asm-x86_64/fcntl.h  |    1 +
 include/linux/fs.h          |    3 ++-
 21 files changed, 31 insertions(+), 2 deletions(-)


diff -Nur linux-2.6.6.orig/fs/fcntl.c linux-2.6.6/fs/fcntl.c
--- linux-2.6.6.orig/fs/fcntl.c	2004-05-14 18:21:42.000000000 -0300
+++ linux-2.6.6/fs/fcntl.c	2004-06-10 18:14:28.000000000 -0300
@@ -212,7 +212,7 @@
 	return ret;
 }
 
-#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | FASYNC | O_DIRECT)
+#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | FASYNC | O_DIRECT | O_NOATIME)
 
 static int setfl(int fd, struct file * filp, unsigned long arg)
 {
@@ -223,6 +223,11 @@
 	if (!(arg & O_APPEND) && IS_APPEND(inode))
 		return -EPERM;
 
+	/* O_NOATIME can only be set by the owner or superuser */
+	if ((arg & O_NOATIME) && !(filp->f_flags & O_NOATIME))
+		if (current->fsuid != inode->i_uid && !capable(CAP_FOWNER))
+			return -EPERM;
+
 	/* required for strict SunOS emulation */
 	if (O_NONBLOCK != O_NDELAY)
 	       if (arg & O_NDELAY)
diff -Nur linux-2.6.6.orig/fs/namei.c linux-2.6.6/fs/namei.c
--- linux-2.6.6.orig/fs/namei.c	2004-05-14 18:21:43.000000000 -0300
+++ linux-2.6.6/fs/namei.c	2004-06-10 18:30:07.000000000 -0300
@@ -1206,6 +1206,11 @@
 			return -EPERM;
 	}
 
+	/* O_NOATIME can only be set by the owner or superuser */
+	if (flag & O_NOATIME)
+		if (current->fsuid != inode->i_uid && !capable(CAP_FOWNER))
+			return -EPERM;
+
 	/*
 	 * Ensure there are no outstanding leases on the file.
 	 */
diff -Nur linux-2.6.6.orig/include/asm-alpha/fcntl.h linux-2.6.6/include/asm-alpha/fcntl.h
--- linux-2.6.6.orig/include/asm-alpha/fcntl.h	2004-04-04 00:37:24.000000000 -0300
+++ linux-2.6.6/include/asm-alpha/fcntl.h	2004-06-10 18:36:01.000000000 -0300
@@ -21,6 +21,7 @@
 #define O_NOFOLLOW	0200000 /* don't follow links */
 #define O_LARGEFILE	0400000 /* will be set by the kernel on every open */
 #define O_DIRECT	02000000 /* direct disk access - should check with OSF/1 */
+#define O_NOATIME	04000000
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -Nur linux-2.6.6.orig/include/asm-arm/fcntl.h linux-2.6.6/include/asm-arm/fcntl.h
--- linux-2.6.6.orig/include/asm-arm/fcntl.h	2004-04-04 00:36:27.000000000 -0300
+++ linux-2.6.6/include/asm-arm/fcntl.h	2004-06-10 18:36:55.000000000 -0300
@@ -20,6 +20,7 @@
 #define O_NOFOLLOW	0100000	/* don't follow links */
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
+#define O_NOATIME	01000000
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -Nur linux-2.6.6.orig/include/asm-arm26/fcntl.h linux-2.6.6/include/asm-arm26/fcntl.h
--- linux-2.6.6.orig/include/asm-arm26/fcntl.h	2004-04-04 00:37:40.000000000 -0300
+++ linux-2.6.6/include/asm-arm26/fcntl.h	2004-06-10 18:37:42.000000000 -0300
@@ -20,6 +20,7 @@
 #define O_NOFOLLOW	0100000	/* don't follow links */
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
+#define O_NOATIME	01000000
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -Nur linux-2.6.6.orig/include/asm-cris/fcntl.h linux-2.6.6/include/asm-cris/fcntl.h
--- linux-2.6.6.orig/include/asm-cris/fcntl.h	2004-04-04 00:36:25.000000000 -0300
+++ linux-2.6.6/include/asm-cris/fcntl.h	2004-06-10 18:37:59.000000000 -0300
@@ -22,6 +22,7 @@
 #define O_LARGEFILE	0100000
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_NOATIME	01000000
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get f_flags */
diff -Nur linux-2.6.6.orig/include/asm-h8300/fcntl.h linux-2.6.6/include/asm-h8300/fcntl.h
--- linux-2.6.6.orig/include/asm-h8300/fcntl.h	2004-04-04 00:37:43.000000000 -0300
+++ linux-2.6.6/include/asm-h8300/fcntl.h	2004-06-10 18:38:16.000000000 -0300
@@ -20,6 +20,7 @@
 #define O_NOFOLLOW	0100000	/* don't follow links */
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
+#define O_NOATIME	01000000
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -Nur linux-2.6.6.orig/include/asm-i386/fcntl.h linux-2.6.6/include/asm-i386/fcntl.h
--- linux-2.6.6.orig/include/asm-i386/fcntl.h	2004-04-04 00:37:23.000000000 -0300
+++ linux-2.6.6/include/asm-i386/fcntl.h	2004-06-10 18:38:26.000000000 -0300
@@ -20,6 +20,7 @@
 #define O_LARGEFILE	0100000
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_NOATIME	01000000
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -Nur linux-2.6.6.orig/include/asm-ia64/fcntl.h linux-2.6.6/include/asm-ia64/fcntl.h
--- linux-2.6.6.orig/include/asm-ia64/fcntl.h	2004-04-04 00:37:23.000000000 -0300
+++ linux-2.6.6/include/asm-ia64/fcntl.h	2004-06-10 18:38:38.000000000 -0300
@@ -28,6 +28,7 @@
 #define O_LARGEFILE	0100000
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_NOATIME	01000000
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -Nur linux-2.6.6.orig/include/asm-m68k/fcntl.h linux-2.6.6/include/asm-m68k/fcntl.h
--- linux-2.6.6.orig/include/asm-m68k/fcntl.h	2004-04-04 00:36:53.000000000 -0300
+++ linux-2.6.6/include/asm-m68k/fcntl.h	2004-06-10 18:38:49.000000000 -0300
@@ -20,6 +20,7 @@
 #define O_NOFOLLOW	0100000	/* don't follow links */
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
+#define O_NOATIME	01000000
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -Nur linux-2.6.6.orig/include/asm-mips/fcntl.h linux-2.6.6/include/asm-mips/fcntl.h
--- linux-2.6.6.orig/include/asm-mips/fcntl.h	2004-04-04 00:37:43.000000000 -0300
+++ linux-2.6.6/include/asm-mips/fcntl.h	2004-06-10 18:39:12.000000000 -0300
@@ -26,6 +26,7 @@
 #define O_DIRECT	0x8000	/* direct disk access hint */
 #define O_DIRECTORY	0x10000	/* must be a directory */
 #define O_NOFOLLOW	0x20000	/* don't follow links */
+#define O_NOATIME	0x40000
 
 #define O_NDELAY	O_NONBLOCK
 
diff -Nur linux-2.6.6.orig/include/asm-parisc/fcntl.h linux-2.6.6/include/asm-parisc/fcntl.h
--- linux-2.6.6.orig/include/asm-parisc/fcntl.h	2004-04-04 00:37:07.000000000 -0300
+++ linux-2.6.6/include/asm-parisc/fcntl.h	2004-06-10 18:40:03.000000000 -0300
@@ -19,6 +19,7 @@
 #define O_NOCTTY	00400000 /* not fcntl */
 #define O_DSYNC		01000000 /* HPUX only */
 #define O_RSYNC		02000000 /* HPUX only */
+#define O_NOATIME	04000000
 
 #define FASYNC		00020000 /* fcntl, for BSD compatibility */
 #define O_DIRECT	00040000 /* direct disk access hint - currently ignored */
diff -Nur linux-2.6.6.orig/include/asm-ppc/fcntl.h linux-2.6.6/include/asm-ppc/fcntl.h
--- linux-2.6.6.orig/include/asm-ppc/fcntl.h	2004-04-04 00:37:07.000000000 -0300
+++ linux-2.6.6/include/asm-ppc/fcntl.h	2004-06-10 18:40:14.000000000 -0300
@@ -20,6 +20,7 @@
 #define O_NOFOLLOW      0100000	/* don't follow links */
 #define O_LARGEFILE     0200000
 #define O_DIRECT	0400000	/* direct disk access hint */
+#define O_NOATIME	01000000
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -Nur linux-2.6.6.orig/include/asm-ppc64/fcntl.h linux-2.6.6/include/asm-ppc64/fcntl.h
--- linux-2.6.6.orig/include/asm-ppc64/fcntl.h	2004-04-04 00:36:15.000000000 -0300
+++ linux-2.6.6/include/asm-ppc64/fcntl.h	2004-06-10 18:40:25.000000000 -0300
@@ -27,6 +27,7 @@
 #define O_NOFOLLOW      0100000	/* don't follow links */
 #define O_LARGEFILE     0200000
 #define O_DIRECT	0400000	/* direct disk access hint */
+#define O_NOATIME	01000000
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -Nur linux-2.6.6.orig/include/asm-s390/fcntl.h linux-2.6.6/include/asm-s390/fcntl.h
--- linux-2.6.6.orig/include/asm-s390/fcntl.h	2004-04-04 00:36:12.000000000 -0300
+++ linux-2.6.6/include/asm-s390/fcntl.h	2004-06-10 18:40:42.000000000 -0300
@@ -27,6 +27,7 @@
 #define O_LARGEFILE	0100000
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_NOATIME	01000000
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -Nur linux-2.6.6.orig/include/asm-sh/fcntl.h linux-2.6.6/include/asm-sh/fcntl.h
--- linux-2.6.6.orig/include/asm-sh/fcntl.h	2004-04-04 00:37:42.000000000 -0300
+++ linux-2.6.6/include/asm-sh/fcntl.h	2004-06-10 18:40:52.000000000 -0300
@@ -20,6 +20,7 @@
 #define O_LARGEFILE	0100000
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_NOATIME	01000000
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -Nur linux-2.6.6.orig/include/asm-sparc/fcntl.h linux-2.6.6/include/asm-sparc/fcntl.h
--- linux-2.6.6.orig/include/asm-sparc/fcntl.h	2004-04-04 00:38:20.000000000 -0300
+++ linux-2.6.6/include/asm-sparc/fcntl.h	2004-06-10 18:41:14.000000000 -0300
@@ -21,6 +21,7 @@
 #define O_NOFOLLOW	0x20000	/* don't follow links */
 #define O_LARGEFILE	0x40000
 #define O_DIRECT        0x100000 /* direct disk access hint */
+#define O_NOATIME	0x200000
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -Nur linux-2.6.6.orig/include/asm-sparc64/fcntl.h linux-2.6.6/include/asm-sparc64/fcntl.h
--- linux-2.6.6.orig/include/asm-sparc64/fcntl.h	2004-04-04 00:38:20.000000000 -0300
+++ linux-2.6.6/include/asm-sparc64/fcntl.h	2004-06-10 18:41:27.000000000 -0300
@@ -21,6 +21,7 @@
 #define O_NOFOLLOW	0x20000	/* don't follow links */
 #define O_LARGEFILE	0x40000
 #define O_DIRECT        0x100000 /* direct disk access hint */
+#define O_NOATIME	0x200000
 
 
 #define F_DUPFD		0	/* dup */
diff -Nur linux-2.6.6.orig/include/asm-v850/fcntl.h linux-2.6.6/include/asm-v850/fcntl.h
--- linux-2.6.6.orig/include/asm-v850/fcntl.h	2004-04-04 00:36:53.000000000 -0300
+++ linux-2.6.6/include/asm-v850/fcntl.h	2004-06-10 18:41:56.000000000 -0300
@@ -20,6 +20,7 @@
 #define O_NOFOLLOW     0100000	/* don't follow links */
 #define O_DIRECT       0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE    0400000
+#define O_NOATIME	01000000
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -Nur linux-2.6.6.orig/include/asm-x86_64/fcntl.h linux-2.6.6/include/asm-x86_64/fcntl.h
--- linux-2.6.6.orig/include/asm-x86_64/fcntl.h	2004-04-04 00:36:26.000000000 -0300
+++ linux-2.6.6/include/asm-x86_64/fcntl.h	2004-06-10 18:42:13.000000000 -0300
@@ -20,6 +20,7 @@
 #define O_LARGEFILE	0100000
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_NOATIME	01000000
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -Nur linux-2.6.6.orig/include/linux/fs.h linux-2.6.6/include/linux/fs.h
--- linux-2.6.6.orig/include/linux/fs.h	2004-05-14 18:21:59.000000000 -0300
+++ linux-2.6.6/include/linux/fs.h	2004-06-10 17:57:30.000000000 -0300
@@ -974,7 +974,8 @@
 
 static inline void file_accessed(struct file *file)
 {
-	touch_atime(file->f_vfsmnt, file->f_dentry);
+	if (!(file->f_flags & O_NOATIME))
+		touch_atime(file->f_vfsmnt, file->f_dentry);
 }
 
 int sync_inode(struct inode *inode, struct writeback_control *wbc);


-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br
