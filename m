Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSJHQHI>; Tue, 8 Oct 2002 12:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbSJHQHI>; Tue, 8 Oct 2002 12:07:08 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:28870 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261318AbSJHQHE>;
	Tue, 8 Oct 2002 12:07:04 -0400
Date: Wed, 9 Oct 2002 02:12:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5.41] create asm-generic/fcntl.h
Message-Id: <20021009021239.24a2f6a7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.3 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch creates asm-generic/fcntl.h in preparation for consolidating
all the asm/fcntl.h files.  It also modifies asm-i386/fcntl.h to use
it.  After you apply this, the other architectures can be modified in
their own good time.  I have all the patches for the other architectures
and I will send them to the appropriate maintainers (if I can find them)
when this patch is merged.

asm-generic/fcntl.h |  143 ++++++++++++++++++++++++++++++++++++++++++++++++++++
asm-i386/fcntl.h    |   83 ------------------------------
 2 files changed, 144 insertions(+), 82 deletions(-)

Please apply.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.41/include/asm-generic/fcntl.h 2.5.41-fcntl.1/include/asm-generic/fcntl.h
--- 2.5.41/include/asm-generic/fcntl.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.41-fcntl.1/include/asm-generic/fcntl.h	2002-10-08 12:14:41.000000000 +1000
@@ -0,0 +1,143 @@
+#ifndef _ASM_GENERIC_FCNTL_H
+#define _ASM_GENERIC_FCNTL_H
+
+/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
+   located on an ext2 file system */
+#define O_ACCMODE	   0003
+#define O_RDONLY	     00
+#define O_WRONLY	     01
+#define O_RDWR		     02
+#ifndef O_CREAT
+#define O_CREAT		   0100	/* not fcntl */
+#endif
+#ifndef O_EXCL
+#define O_EXCL		   0200	/* not fcntl */
+#endif
+#ifndef O_NOCTTY
+#define O_NOCTTY	   0400	/* not fcntl */
+#endif
+#ifndef O_TRUNC
+#define O_TRUNC		  01000	/* not fcntl */
+#endif
+#ifndef O_APPEND
+#define O_APPEND	  02000
+#endif
+#ifndef O_NONBLOCK
+#define O_NONBLOCK	  04000
+#endif
+#ifndef O_NDELAY
+#define O_NDELAY	O_NONBLOCK
+#endif
+#ifndef O_SYNC
+#define O_SYNC		 010000
+#endif
+#ifndef FASYNC
+#define FASYNC		 020000	/* fcntl, for BSD compatibility */
+#endif
+#ifndef O_DIRECT
+#define O_DIRECT	 040000	/* direct disk access hint */
+#endif
+#ifndef O_LARGEFILE
+#define O_LARGEFILE	0100000
+#endif
+#ifndef O_DIRECTORY
+#define O_DIRECTORY	0200000	/* must be a directory */
+#endif
+#ifndef O_NOFOLLOW
+#define O_NOFOLLOW	0400000 /* don't follow links */
+#endif
+
+#define F_DUPFD		0	/* dup */
+#define F_GETFD		1	/* get close_on_exec */
+#define F_SETFD		2	/* set/clear close_on_exec */
+#define F_GETFL		3	/* get file->f_flags */
+#define F_SETFL		4	/* set file->f_flags */
+#ifndef F_GETLK
+#define F_GETLK		5
+#endif
+#ifndef F_SETLK
+#define F_SETLK		6
+#endif
+#ifndef F_SETLKW
+#define F_SETLKW	7
+#endif
+
+#ifndef F_SETOWN
+#define F_SETOWN	8	/*  for sockets. */
+#endif
+#ifndef F_GETOWN
+#define F_GETOWN	9	/*  for sockets. */
+#endif
+#ifndef F_SETSIG
+#define F_SETSIG	10	/*  for sockets. */
+#endif
+#ifndef F_GETSIG
+#define F_GETSIG	11	/*  for sockets. */
+#endif
+
+#ifndef __NO_FCNTL_LK64
+#ifndef F_GETLK64
+#define F_GETLK64	12	/*  using 'struct flock64' */
+#endif
+#ifndef F_SETLK64
+#define F_SETLK64	13
+#endif
+#ifndef F_SETLKW64
+#define F_SETLKW64	14
+#endif
+#endif /* __NO_FCNTL_LK64 */
+
+/* for F_[GET|SET]FL */
+#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
+
+/* for posix fcntl() and lockf() */
+#ifndef F_RDLCK
+#define F_RDLCK		0
+#endif
+#ifndef F_WRLCK
+#define F_WRLCK		1
+#endif
+#ifndef F_UNLCK
+#define F_UNLCK		2
+#endif
+
+/* for leases */
+#ifndef F_INPROGRESS
+#define F_INPROGRESS	16
+#endif
+
+/* operations for bsd flock(), also used by the kernel implementation */
+#define LOCK_SH		1	/* shared lock */
+#define LOCK_EX		2	/* exclusive lock */
+#define LOCK_NB		4	/* or'd with one of the above to prevent
+				   blocking */
+#define LOCK_UN		8	/* remove lock */
+
+#define LOCK_MAND	32	/* This is a mandatory flock */
+#define LOCK_READ	64	/* ... Which allows concurrent read operations */
+#define LOCK_WRITE	128	/* ... Which allows concurrent write operations */
+#define LOCK_RW		192	/* ... Which allows concurrent read & write ops */
+
+#ifndef HAVE_ARCH_STRUCT_FLOCK
+struct flock {
+	short l_type;
+	short l_whence;
+	off_t l_start;
+	off_t l_len;
+	pid_t l_pid;
+};
+#endif
+
+#ifndef HAVE_ARCH_STRUCT_FLOCK64
+struct flock64 {
+	short  l_type;
+	short  l_whence;
+	loff_t l_start;
+	loff_t l_len;
+	pid_t  l_pid;
+};
+#endif
+
+#define F_LINUX_SPECIFIC_BASE	1024
+
+#endif /* _ASM_GENERIC_FCNTL_H */
diff -ruN 2.5.41/include/asm-i386/fcntl.h 2.5.41-fcntl.1/include/asm-i386/fcntl.h
--- 2.5.41/include/asm-i386/fcntl.h	2001-09-18 06:16:30.000000000 +1000
+++ 2.5.41-fcntl.1/include/asm-i386/fcntl.h	2002-10-08 12:14:41.000000000 +1000
@@ -1,87 +1,6 @@
 #ifndef _I386_FCNTL_H
 #define _I386_FCNTL_H
 
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_ACCMODE	   0003
-#define O_RDONLY	     00
-#define O_WRONLY	     01
-#define O_RDWR		     02
-#define O_CREAT		   0100	/* not fcntl */
-#define O_EXCL		   0200	/* not fcntl */
-#define O_NOCTTY	   0400	/* not fcntl */
-#define O_TRUNC		  01000	/* not fcntl */
-#define O_APPEND	  02000
-#define O_NONBLOCK	  04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		 010000
-#define FASYNC		 020000	/* fcntl, for BSD compatibility */
-#define O_DIRECT	 040000	/* direct disk access hint */
-#define O_LARGEFILE	0100000
-#define O_DIRECTORY	0200000	/* must be a directory */
-#define O_NOFOLLOW	0400000 /* don't follow links */
-
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
-#define F_GETFL		3	/* get file->f_flags */
-#define F_SETFL		4	/* set file->f_flags */
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS	16
-
-/* operations for bsd flock(), also used by the kernel implementation */
-#define LOCK_SH		1	/* shared lock */
-#define LOCK_EX		2	/* exclusive lock */
-#define LOCK_NB		4	/* or'd with one of the above to prevent
-				   blocking */
-#define LOCK_UN		8	/* remove lock */
-
-#define LOCK_MAND	32	/* This is a mandatory flock */
-#define LOCK_READ	64	/* ... Which allows concurrent read operations */
-#define LOCK_WRITE	128	/* ... Which allows concurrent write operations */
-#define LOCK_RW		192	/* ... Which allows concurrent read & write ops */
-
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
-#define F_LINUX_SPECIFIC_BASE	1024
+#include <asm-generic/fcntl.h>
 
 #endif
