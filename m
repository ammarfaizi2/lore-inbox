Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbUCVHJA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 02:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUCVHI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 02:08:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:51894 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261792AbUCVHIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 02:08:14 -0500
Date: Sun, 21 Mar 2004 23:08:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop O_LARGEFILE from F_GETFL for POSIX compliance
Message-Id: <20040321230811.3bb94aa3.akpm@osdl.org>
In-Reply-To: <20040322071425.3cd57aca.ak@suse.de>
References: <20040322051318.597ad1f9.ak@suse.de>
	<20040321213944.2fdb980d.akpm@osdl.org>
	<20040322071425.3cd57aca.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> > > +++ linux-merge/fs/fcntl.c	2003-10-23 15:40:52.000000000 +0200
> > > @@ -271,7 +271,7 @@ static long do_fcntl(unsigned int fd, un
> > >  			set_close_on_exec(fd, arg&1);
> > >  			break;
> > >  		case F_GETFL:
> > > -			err = filp->f_flags;
> > > +			err = filp->f_flags & ~O_LARGEFILE;
> > >  			break;
> > >  		case F_SETFL:
> > >  			lock_kernel();
> > 
> > eh?   If the application on a 64-bit box does
> > 
> > 	open("foo", O_LARGEFILE|O_RDWR);
> > 
> > then a subsequent F_GETFL will now return just O_RDWR, will it not?  So
> > it's still posixly incorrect?
> 
> No, because O_LARGEFILE is not part of POSIX :-) (they use open64 etc.)
> 

But doesn't glibc implement open64() by adding O_LARGEFILE?  If so then an
F_GETFL will return O_LARGEFILE even though the caller didn't supply it. 
Unless glibc jumps through hoops.

Which it does not:

#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>

main()
{
	int fd;
	int flags;

	fd = open64("foo", O_RDONLY);
	if (fd < 0)
		perror("open");
	flags = fcntl(fd, F_GETFL);
	printf("supplied %o, received %o\n", O_RDONLY, flags);
}

bix:/home/akpm> ./a.out
supplied 0, received 100000

I guess your test suite forgot to test that ;)

> > I think open() needs to set O_KERNEL_LARGEFILE, and we mask that off in
> > F_GETFL, and test for (O_LARGEFILE|O_KERNEL_LARGEFILE) everywhere.
> 
> 
> That would be the best solution, agreed But it would be a lot more intrusive
> because all file systems need to be audited and fixed.

Only weirdo filesystems go looking at O_LARGEFILE (hi, sgi).  Oh, and ext3
too, although that looks bogus.


Here's a 2.6 patch.

---

 25-akpm/arch/ia64/ia32/sys_ia32.c     |    3 +-
 25-akpm/arch/ppc64/kernel/sys_ppc32.c |    2 -
 25-akpm/arch/x86_64/ia32/sys_ia32.c   |    2 -
 25-akpm/fs/block_dev.c                |    2 -
 25-akpm/fs/exec.c                     |    3 +-
 25-akpm/fs/ext3/file.c                |    6 ++--
 25-akpm/fs/fcntl.c                    |    2 -
 25-akpm/fs/ncpfs/file.c               |    3 +-
 25-akpm/fs/nfsd/vfs.c                 |    4 +--
 25-akpm/fs/open.c                     |   12 ++++-----
 25-akpm/fs/udf/file.c                 |    5 ++-
 25-akpm/fs/xfs/linux/xfs_file.c       |    3 +-
 25-akpm/fs/xfs/linux/xfs_ioctl.c      |    2 -
 25-akpm/include/asm-alpha/fcntl.h     |   37 ++++++++++++++-------------
 25-akpm/include/asm-arm/fcntl.h       |   35 +++++++++++++-------------
 25-akpm/include/asm-arm26/fcntl.h     |   35 +++++++++++++-------------
 25-akpm/include/asm-cris/fcntl.h      |   35 +++++++++++++-------------
 25-akpm/include/asm-h8300/fcntl.h     |   35 +++++++++++++-------------
 25-akpm/include/asm-i386/fcntl.h      |   35 +++++++++++++-------------
 25-akpm/include/asm-ia64/fcntl.h      |   35 +++++++++++++-------------
 25-akpm/include/asm-m68k/fcntl.h      |   35 +++++++++++++-------------
 25-akpm/include/asm-mips/fcntl.h      |   33 ++++++++++++------------
 25-akpm/include/asm-parisc/fcntl.h    |   45 +++++++++++++++++-----------------
 25-akpm/include/asm-ppc/fcntl.h       |   35 +++++++++++++-------------
 25-akpm/include/asm-ppc64/fcntl.h     |   35 +++++++++++++-------------
 25-akpm/include/asm-s390/fcntl.h      |   35 +++++++++++++-------------
 25-akpm/include/asm-sh/fcntl.h        |   35 +++++++++++++-------------
 25-akpm/include/asm-sparc/fcntl.h     |   35 +++++++++++++-------------
 25-akpm/include/asm-sparc64/fcntl.h   |   36 +++++++++++++--------------
 25-akpm/include/asm-v850/fcntl.h      |   35 +++++++++++++-------------
 25-akpm/include/asm-x86_64/fcntl.h    |   35 +++++++++++++-------------
 25-akpm/mm/filemap.c                  |    2 -
 arch/sparc64/kernel/sys_sparc32.c     |    0 
 arch/sparc64/solaris/fs.c             |    0 
 drivers/usb/gadget/file_storage.c     |    0 
 fs/cifs/file.c                        |    0 
 36 files changed, 357 insertions(+), 335 deletions(-)

diff -puN arch/sparc64/kernel/sys_sparc32.c~O_LARGEFILE-fix arch/sparc64/kernel/sys_sparc32.c
diff -puN arch/sparc64/solaris/fs.c~O_LARGEFILE-fix arch/sparc64/solaris/fs.c
diff -puN arch/ia64/ia32/sys_ia32.c~O_LARGEFILE-fix arch/ia64/ia32/sys_ia32.c
--- 25/arch/ia64/ia32/sys_ia32.c~O_LARGEFILE-fix	2004-03-21 22:36:32.530114696 -0800
+++ 25-akpm/arch/ia64/ia32/sys_ia32.c	2004-03-21 22:37:45.050089984 -0800
@@ -2106,7 +2106,8 @@ sys32_brk (unsigned int brk)
 }
 
 /*
- * Exactly like fs/open.c:sys_open(), except that it doesn't set the O_LARGEFILE flag.
+ * Exactly like fs/open.c:sys_open(), except that it doesn't set the
+ * O_KERNEL_LARGEFILE flag.
  */
 asmlinkage long
 sys32_open (const char * filename, int flags, int mode)
diff -puN arch/ppc64/kernel/sys_ppc32.c~O_LARGEFILE-fix arch/ppc64/kernel/sys_ppc32.c
--- 25/arch/ppc64/kernel/sys_ppc32.c~O_LARGEFILE-fix	2004-03-21 22:36:32.583106640 -0800
+++ 25-akpm/arch/ppc64/kernel/sys_ppc32.c	2004-03-21 22:37:51.785066112 -0800
@@ -2399,7 +2399,7 @@ off_t ppc32_lseek(unsigned int fd, u32 o
 
 /*
  * This is just a version for 32-bit applications which does
- * not force O_LARGEFILE on.
+ * not force O_KERNEL_LARGEFILE on.
  */
 long sys32_open(const char * filename, int flags, int mode)
 {
diff -puN arch/x86_64/ia32/sys_ia32.c~O_LARGEFILE-fix arch/x86_64/ia32/sys_ia32.c
--- 25/arch/x86_64/ia32/sys_ia32.c~O_LARGEFILE-fix	2004-03-21 22:36:32.612102232 -0800
+++ 25-akpm/arch/x86_64/ia32/sys_ia32.c	2004-03-21 22:37:56.536343808 -0800
@@ -1783,7 +1783,7 @@ asmlinkage long sys32_open(const char * 
 	char * tmp;
 	int fd, error;
 
-	/* don't force O_LARGEFILE */
+	/* don't force O_KERNEL_LARGEFILE */
 	tmp = getname(filename);
 	fd = PTR_ERR(tmp);
 	if (!IS_ERR(tmp)) {
diff -puN drivers/usb/gadget/file_storage.c~O_LARGEFILE-fix drivers/usb/gadget/file_storage.c
diff -puN include/asm-ppc64/fcntl.h~O_LARGEFILE-fix include/asm-ppc64/fcntl.h
--- 25/include/asm-ppc64/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:32.662094632 -0800
+++ 25-akpm/include/asm-ppc64/fcntl.h	2004-03-21 22:39:15.803293400 -0800
@@ -10,23 +10,24 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
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
-#define O_DIRECTORY      040000	/* must be a directory */
-#define O_NOFOLLOW      0100000	/* don't follow links */
-#define O_LARGEFILE     0200000
-#define O_DIRECT	0400000	/* direct disk access hint */
+#define O_ACCMODE	       0003
+#define O_RDONLY	         00
+#define O_WRONLY	         01
+#define O_RDWR		         02
+#define O_CREAT		       0100	/* not fcntl */
+#define O_EXCL		       0200	/* not fcntl */
+#define O_NOCTTY	       0400	/* not fcntl */
+#define O_TRUNC		      01000	/* not fcntl */
+#define O_APPEND	      02000
+#define O_NONBLOCK	      04000
+#define O_NDELAY	    O_NONBLOCK
+#define O_SYNC		     010000
+#define FASYNC		     020000	/* fcntl, for BSD compatibility */
+#define O_DIRECTORY          040000	/* must be a directory */
+#define O_NOFOLLOW          0100000	/* don't follow links */
+#define O_LARGEFILE         0200000
+#define O_DIRECT	    0400000	/* direct disk access hint */
+#define O_KERNEL_LARGEFILE 01000000	/* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -puN include/asm-x86_64/fcntl.h~O_LARGEFILE-fix include/asm-x86_64/fcntl.h
--- 25/include/asm-x86_64/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:32.688090680 -0800
+++ 25-akpm/include/asm-x86_64/fcntl.h	2004-03-21 22:40:04.754851632 -0800
@@ -3,23 +3,24 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
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
+#define O_ACCMODE	       0003
+#define O_RDONLY	         00
+#define O_WRONLY	         01
+#define O_RDWR		         02
+#define O_CREAT		       0100	/* not fcntl */
+#define O_EXCL		       0200	/* not fcntl */
+#define O_NOCTTY	       0400	/* not fcntl */
+#define O_TRUNC		      01000	/* not fcntl */
+#define O_APPEND	      02000
+#define O_NONBLOCK	      04000
+#define O_NDELAY	    O_NONBLOCK
+#define O_SYNC		     010000
+#define FASYNC		     020000	/* fcntl, for BSD compatibility */
+#define O_DIRECT	     040000	/* direct disk access hint */
+#define O_LARGEFILE	    0100000
+#define O_DIRECTORY	    0200000	/* must be a directory */
+#define O_NOFOLLOW	    0400000	/* don't follow links */
+#define O_KERNEL_LARGEFILE 01000000	/* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -puN include/asm-ppc/fcntl.h~O_LARGEFILE-fix include/asm-ppc/fcntl.h
--- 25/include/asm-ppc/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:32.718086120 -0800
+++ 25-akpm/include/asm-ppc/fcntl.h	2004-03-21 22:40:43.884902960 -0800
@@ -3,23 +3,24 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
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
-#define O_DIRECTORY      040000	/* must be a directory */
-#define O_NOFOLLOW      0100000	/* don't follow links */
-#define O_LARGEFILE     0200000
-#define O_DIRECT	0400000	/* direct disk access hint */
+#define O_ACCMODE	       0003
+#define O_RDONLY	         00
+#define O_WRONLY	         01
+#define O_RDWR		         02
+#define O_CREAT		       0100	/* not fcntl */
+#define O_EXCL		       0200	/* not fcntl */
+#define O_NOCTTY	       0400	/* not fcntl */
+#define O_TRUNC		      01000	/* not fcntl */
+#define O_APPEND	      02000
+#define O_NONBLOCK	      04000
+#define O_NDELAY	    O_NONBLOCK
+#define O_SYNC		     010000
+#define FASYNC		     020000	/* fcntl, for BSD compatibility */
+#define O_DIRECTORY          040000	/* must be a directory */
+#define O_NOFOLLOW          0100000	/* don't follow links */
+#define O_LARGEFILE         0200000
+#define O_DIRECT	    0400000	/* direct disk access hint */
+#define O_KERNEL_LARGEFILE 01000000	/* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -puN include/asm-m68k/fcntl.h~O_LARGEFILE-fix include/asm-m68k/fcntl.h
--- 25/include/asm-m68k/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:32.745082016 -0800
+++ 25-akpm/include/asm-m68k/fcntl.h	2004-03-21 22:41:22.805986056 -0800
@@ -3,23 +3,24 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	  0003
-#define O_RDONLY	    00
-#define O_WRONLY	    01
-#define O_RDWR		    02
-#define O_CREAT		  0100	/* not fcntl */
-#define O_EXCL		  0200	/* not fcntl */
-#define O_NOCTTY	  0400	/* not fcntl */
-#define O_TRUNC		 01000	/* not fcntl */
-#define O_APPEND	 02000
-#define O_NONBLOCK	 04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		010000
-#define FASYNC		020000	/* fcntl, for BSD compatibility */
-#define O_DIRECTORY	040000	/* must be a directory */
-#define O_NOFOLLOW	0100000	/* don't follow links */
-#define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
-#define O_LARGEFILE	0400000
+#define O_ACCMODE	      0003
+#define O_RDONLY	        00
+#define O_WRONLY	        01
+#define O_RDWR		        02
+#define O_CREAT		      0100	/* not fcntl */
+#define O_EXCL		      0200	/* not fcntl */
+#define O_NOCTTY	      0400	/* not fcntl */
+#define O_TRUNC		     01000	/* not fcntl */
+#define O_APPEND	     02000
+#define O_NONBLOCK	     04000
+#define O_NDELAY	    O_NONBLOCK
+#define O_SYNC		    010000
+#define FASYNC		    020000	/* fcntl, for BSD compatibility */
+#define O_DIRECTORY	    040000	/* must be a directory */
+#define O_NOFOLLOW	    0100000	/* don't follow links */
+#define O_DIRECT	    0200000	/* direct disk access hint */
+#define O_LARGEFILE	    0400000
+#define O_KERNEL_LARGEFILE 01000000	/* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -puN include/asm-ia64/fcntl.h~O_LARGEFILE-fix include/asm-ia64/fcntl.h
--- 25/include/asm-ia64/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:32.772077912 -0800
+++ 25-akpm/include/asm-ia64/fcntl.h	2004-03-21 22:42:03.518796768 -0800
@@ -11,23 +11,24 @@
  * open/fcntl - O_SYNC is only implemented on blocks devices and on
  * files located on an ext2 file system
  */
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
-#define O_DIRECT	 040000	/* direct disk access hint - currently ignored */
-#define O_LARGEFILE	0100000
-#define O_DIRECTORY	0200000	/* must be a directory */
-#define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_ACCMODE	       0003
+#define O_RDONLY	         00
+#define O_WRONLY	         01
+#define O_RDWR		         02
+#define O_CREAT		       0100	/* not fcntl */
+#define O_EXCL		       0200	/* not fcntl */
+#define O_NOCTTY	       0400	/* not fcntl */
+#define O_TRUNC		      01000	/* not fcntl */
+#define O_APPEND	      02000
+#define O_NONBLOCK	      04000
+#define O_NDELAY	    O_NONBLOCK
+#define O_SYNC		     010000
+#define FASYNC		     020000	/* fcntl, for BSD compatibility */
+#define O_DIRECT	     040000	/* direct disk access hint */
+#define O_LARGEFILE	    0100000
+#define O_DIRECTORY	    0200000	/* must be a directory */
+#define O_NOFOLLOW	    0400000	/* don't follow links */
+#define O_KERNEL_LARGEFILE 01000000	/* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -puN include/asm-parisc/fcntl.h~O_LARGEFILE-fix include/asm-parisc/fcntl.h
--- 25/include/asm-parisc/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:32.802073352 -0800
+++ 25-akpm/include/asm-parisc/fcntl.h	2004-03-21 22:43:02.661805664 -0800
@@ -3,28 +3,29 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	00000003
-#define O_RDONLY	00000000
-#define O_WRONLY	00000001
-#define O_RDWR		00000002
-#define O_APPEND	00000010
-#define O_BLKSEEK	00000100 /* HPUX only */
-#define O_CREAT		00000400 /* not fcntl */
-#define O_TRUNC		00001000 /* not fcntl */
-#define O_EXCL		00002000 /* not fcntl */
-#define O_LARGEFILE	00004000
-#define O_SYNC		00100000
-#define O_NONBLOCK	00200004 /* HPUX has separate NDELAY & NONBLOCK */
-#define O_NDELAY	O_NONBLOCK
-#define O_NOCTTY	00400000 /* not fcntl */
-#define O_DSYNC		01000000 /* HPUX only */
-#define O_RSYNC		02000000 /* HPUX only */
-
-#define FASYNC		00020000 /* fcntl, for BSD compatibility */
-#define O_DIRECT	00040000 /* direct disk access hint - currently ignored */
-#define O_DIRECTORY	00010000 /* must be a directory */
-#define O_NOFOLLOW	00000200 /* don't follow links */
-#define O_INVISIBLE	04000000 /* invisible I/O, for DMAPI/XDSM */
+#define O_ACCMODE		00000003
+#define O_RDONLY		00000000
+#define O_WRONLY		00000001
+#define O_RDWR			00000002
+#define O_APPEND		00000010
+#define O_BLKSEEK		00000100 /* HPUX only */
+#define O_CREAT			00000400 /* not fcntl */
+#define O_TRUNC			00001000 /* not fcntl */
+#define O_EXCL			00002000 /* not fcntl */
+#define O_LARGEFILE		00004000
+#define O_SYNC			00100000
+#define O_NONBLOCK		00200004 /* HPUX has separate NDELAY & NONBLOCK */
+#define O_NDELAY		O_NONBLOCK
+#define O_NOCTTY		00400000 /* not fcntl */
+#define O_DSYNC			01000000 /* HPUX only */
+#define O_RSYNC			02000000 /* HPUX only */
+
+#define FASYNC			00020000 /* fcntl, for BSD compatibility */
+#define O_DIRECT		00040000 /* direct disk access hint */
+#define O_DIRECTORY		00010000 /* must be a directory */
+#define O_NOFOLLOW		00000200 /* don't follow links */
+#define O_INVISIBLE		04000000 /* invisible I/O, for DMAPI/XDSM */
+#define O_KERNEL_LARGEFILE     010000000 /* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get f_flags */
diff -puN include/asm-arm/fcntl.h~O_LARGEFILE-fix include/asm-arm/fcntl.h
--- 25/include/asm-arm/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:32.835068336 -0800
+++ 25-akpm/include/asm-arm/fcntl.h	2004-03-21 22:43:34.447973432 -0800
@@ -3,23 +3,24 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
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
-#define O_DIRECTORY	 040000	/* must be a directory */
-#define O_NOFOLLOW	0100000	/* don't follow links */
-#define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
-#define O_LARGEFILE	0400000
+#define O_ACCMODE	       0003
+#define O_RDONLY	         00
+#define O_WRONLY	         01
+#define O_RDWR		         02
+#define O_CREAT		       0100	/* not fcntl */
+#define O_EXCL		       0200	/* not fcntl */
+#define O_NOCTTY	       0400	/* not fcntl */
+#define O_TRUNC		      01000	/* not fcntl */
+#define O_APPEND	      02000
+#define O_NONBLOCK	      04000
+#define O_NDELAY	    O_NONBLOCK
+#define O_SYNC		     010000
+#define FASYNC		     020000	/* fcntl, for BSD compatibility */
+#define O_DIRECTORY	     040000	/* must be a directory */
+#define O_NOFOLLOW	    0100000	/* don't follow links */
+#define O_DIRECT	    0200000	/* direct disk access hint */
+#define O_LARGEFILE	    0400000
+#define O_KERNEL_LARGEFILE 01000000	/* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -puN include/asm-mips/fcntl.h~O_LARGEFILE-fix include/asm-mips/fcntl.h
--- 25/include/asm-mips/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:32.859064688 -0800
+++ 25-akpm/include/asm-mips/fcntl.h	2004-03-21 22:44:03.819508280 -0800
@@ -10,22 +10,23 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	0x0003
-#define O_RDONLY	0x0000
-#define O_WRONLY	0x0001
-#define O_RDWR		0x0002
-#define O_APPEND	0x0008
-#define O_SYNC		0x0010
-#define O_NONBLOCK	0x0080
-#define O_CREAT         0x0100	/* not fcntl */
-#define O_TRUNC		0x0200	/* not fcntl */
-#define O_EXCL		0x0400	/* not fcntl */
-#define O_NOCTTY	0x0800	/* not fcntl */
-#define FASYNC		0x1000	/* fcntl, for BSD compatibility */
-#define O_LARGEFILE	0x2000	/* allow large file opens */
-#define O_DIRECT	0x8000	/* direct disk access hint */
-#define O_DIRECTORY	0x10000	/* must be a directory */
-#define O_NOFOLLOW	0x20000	/* don't follow links */
+#define O_ACCMODE		0x0003
+#define O_RDONLY		0x0000
+#define O_WRONLY		0x0001
+#define O_RDWR			0x0002
+#define O_APPEND		0x0008
+#define O_SYNC			0x0010
+#define O_NONBLOCK		0x0080
+#define O_CREAT         	0x0100	/* not fcntl */
+#define O_TRUNC			0x0200	/* not fcntl */
+#define O_EXCL			0x0400	/* not fcntl */
+#define O_NOCTTY		0x0800	/* not fcntl */
+#define FASYNC			0x1000	/* fcntl, for BSD compatibility */
+#define O_LARGEFILE		0x2000	/* allow large file opens */
+#define O_DIRECT		0x8000	/* direct disk access hint */
+#define O_DIRECTORY		0x10000	/* must be a directory */
+#define O_NOFOLLOW		0x20000	/* don't follow links */
+#define O_KERNEL_LARGEFILE	0x40000	/* kernel-internal large file hint */
 
 #define O_NDELAY	O_NONBLOCK
 
diff -puN include/asm-sparc/fcntl.h~O_LARGEFILE-fix include/asm-sparc/fcntl.h
--- 25/include/asm-sparc/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:32.885060736 -0800
+++ 25-akpm/include/asm-sparc/fcntl.h	2004-03-21 22:44:27.766867728 -0800
@@ -4,23 +4,24 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_RDONLY	0x0000
-#define O_WRONLY	0x0001
-#define O_RDWR		0x0002
-#define O_ACCMODE	0x0003
-#define O_APPEND	0x0008
-#define FASYNC		0x0040	/* fcntl, for BSD compatibility */
-#define O_CREAT		0x0200	/* not fcntl */
-#define O_TRUNC		0x0400	/* not fcntl */
-#define O_EXCL		0x0800	/* not fcntl */
-#define O_SYNC		0x2000
-#define O_NONBLOCK	0x4000
-#define O_NDELAY	(0x0004 | O_NONBLOCK)
-#define O_NOCTTY	0x8000	/* not fcntl */
-#define O_DIRECTORY	0x10000	/* must be a directory */
-#define O_NOFOLLOW	0x20000	/* don't follow links */
-#define O_LARGEFILE	0x40000
-#define O_DIRECT        0x100000 /* direct disk access hint */
+#define O_RDONLY		0x0000
+#define O_WRONLY		0x0001
+#define O_RDWR			0x0002
+#define O_ACCMODE		0x0003
+#define O_APPEND		0x0008
+#define FASYNC			0x0040	/* fcntl, for BSD compatibility */
+#define O_CREAT			0x0200	/* not fcntl */
+#define O_TRUNC			0x0400	/* not fcntl */
+#define O_EXCL			0x0800	/* not fcntl */
+#define O_SYNC			0x2000
+#define O_NONBLOCK		0x4000
+#define O_NDELAY		(0x0004 | O_NONBLOCK)
+#define O_NOCTTY		0x8000	/* not fcntl */
+#define O_DIRECTORY		0x10000	/* must be a directory */
+#define O_NOFOLLOW		0x20000	/* don't follow links */
+#define O_LARGEFILE		0x40000
+#define O_DIRECT        	0x100000 /* direct disk access hint */
+#define O_KERNEL_LARGEFILE	0x200000 /* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -puN include/asm-alpha/fcntl.h~O_LARGEFILE-fix include/asm-alpha/fcntl.h
--- 25/include/asm-alpha/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:32.917055872 -0800
+++ 25-akpm/include/asm-alpha/fcntl.h	2004-03-21 22:45:48.553586280 -0800
@@ -3,24 +3,25 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	  0003
-#define O_RDONLY	    00
-#define O_WRONLY	    01
-#define O_RDWR		    02
-#define O_CREAT		 01000	/* not fcntl */
-#define O_TRUNC		 02000	/* not fcntl */
-#define O_EXCL		 04000	/* not fcntl */
-#define O_NOCTTY	010000	/* not fcntl */
-
-#define O_NONBLOCK	 00004
-#define O_APPEND	 00010
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		040000
-#define FASYNC		020000	/* fcntl, for BSD compatibility */
-#define O_DIRECTORY	0100000	/* must be a directory */
-#define O_NOFOLLOW	0200000 /* don't follow links */
-#define O_LARGEFILE	0400000 /* will be set by the kernel on every open */
-#define O_DIRECT	02000000 /* direct disk access - should check with OSF/1 */
+#define O_ACCMODE	      0003
+#define O_RDONLY	        00
+#define O_WRONLY	        01
+#define O_RDWR		        02
+#define O_CREAT		     01000	/* not fcntl */
+#define O_TRUNC		     02000	/* not fcntl */
+#define O_EXCL		     04000	/* not fcntl */
+#define O_NOCTTY	    010000	/* not fcntl */
+
+#define O_NONBLOCK	     00004
+#define O_APPEND	     00010
+#define O_NDELAY	    O_NONBLOCK
+#define O_SYNC		    040000
+#define FASYNC		    020000	/* fcntl, for BSD compatibility */
+#define O_DIRECTORY	    0100000	/* must be a directory */
+#define O_NOFOLLOW	    0200000	/* don't follow links */
+#define O_LARGEFILE	    0400000
+#define O_DIRECT	    02000000 /* direct access - check with OSF/1 */
+#define O_KERNEL_LARGEFILE  04000000 /* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -puN include/asm-i386/fcntl.h~O_LARGEFILE-fix include/asm-i386/fcntl.h
--- 25/include/asm-i386/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:32.963048880 -0800
+++ 25-akpm/include/asm-i386/fcntl.h	2004-03-21 22:46:11.798052584 -0800
@@ -3,23 +3,24 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
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
+#define O_ACCMODE	       0003
+#define O_RDONLY	         00
+#define O_WRONLY	         01
+#define O_RDWR		         02
+#define O_CREAT		       0100	/* not fcntl */
+#define O_EXCL		       0200	/* not fcntl */
+#define O_NOCTTY	       0400	/* not fcntl */
+#define O_TRUNC		      01000	/* not fcntl */
+#define O_APPEND	      02000
+#define O_NONBLOCK	      04000
+#define O_NDELAY	    O_NONBLOCK
+#define O_SYNC		     010000
+#define FASYNC		     020000	/* fcntl, for BSD compatibility */
+#define O_DIRECT	     040000	/* direct disk access hint */
+#define O_LARGEFILE	    0100000
+#define O_DIRECTORY	    0200000	/* must be a directory */
+#define O_NOFOLLOW	    0400000	/* don't follow links */
+#define O_KERNEL_LARGEFILE 01000000	/* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -puN include/asm-s390/fcntl.h~O_LARGEFILE-fix include/asm-s390/fcntl.h
--- 25/include/asm-s390/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:32.988045080 -0800
+++ 25-akpm/include/asm-s390/fcntl.h	2004-03-21 22:46:36.897236928 -0800
@@ -10,23 +10,24 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
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
+#define O_ACCMODE	       0003
+#define O_RDONLY	         00
+#define O_WRONLY	         01
+#define O_RDWR		         02
+#define O_CREAT		       0100	/* not fcntl */
+#define O_EXCL		       0200	/* not fcntl */
+#define O_NOCTTY	       0400	/* not fcntl */
+#define O_TRUNC		      01000	/* not fcntl */
+#define O_APPEND	      02000
+#define O_NONBLOCK	      04000
+#define O_NDELAY	    O_NONBLOCK
+#define O_SYNC		     010000
+#define FASYNC		     020000	/* fcntl, for BSD compatibility */
+#define O_DIRECT	     040000	/* direct disk access hint */
+#define O_LARGEFILE	    0100000
+#define O_DIRECTORY	    0200000	/* must be a directory */
+#define O_NOFOLLOW	    0400000	/* don't follow links */
+#define O_KERNEL_LARGEFILE 01000000	/* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -puN include/asm-h8300/fcntl.h~O_LARGEFILE-fix include/asm-h8300/fcntl.h
--- 25/include/asm-h8300/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:33.023039760 -0800
+++ 25-akpm/include/asm-h8300/fcntl.h	2004-03-21 22:47:08.332458048 -0800
@@ -3,23 +3,24 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	  0003
-#define O_RDONLY	    00
-#define O_WRONLY	    01
-#define O_RDWR		    02
-#define O_CREAT		  0100	/* not fcntl */
-#define O_EXCL		  0200	/* not fcntl */
-#define O_NOCTTY	  0400	/* not fcntl */
-#define O_TRUNC		 01000	/* not fcntl */
-#define O_APPEND	 02000
-#define O_NONBLOCK	 04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		010000
-#define FASYNC		020000	/* fcntl, for BSD compatibility */
-#define O_DIRECTORY	040000	/* must be a directory */
-#define O_NOFOLLOW	0100000	/* don't follow links */
-#define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
-#define O_LARGEFILE	0400000
+#define O_ACCMODE	      0003
+#define O_RDONLY	        00
+#define O_WRONLY	        01
+#define O_RDWR		        02
+#define O_CREAT		      0100	/* not fcntl */
+#define O_EXCL		      0200	/* not fcntl */
+#define O_NOCTTY	      0400	/* not fcntl */
+#define O_TRUNC		     01000	/* not fcntl */
+#define O_APPEND	     02000
+#define O_NONBLOCK	     04000
+#define O_NDELAY	    O_NONBLOCK
+#define O_SYNC		    010000
+#define FASYNC		    020000	/* fcntl, for BSD compatibility */
+#define O_DIRECTORY	    040000	/* must be a directory */
+#define O_NOFOLLOW	    0100000	/* don't follow links */
+#define O_DIRECT	    0200000	/* direct disk access hint */
+#define O_LARGEFILE	    0400000
+#define O_KERNEL_LARGEFILE 01000000	/* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -puN include/asm-sparc64/fcntl.h~O_LARGEFILE-fix include/asm-sparc64/fcntl.h
--- 25/include/asm-sparc64/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:33.051035504 -0800
+++ 25-akpm/include/asm-sparc64/fcntl.h	2004-03-21 22:47:34.488481728 -0800
@@ -4,24 +4,24 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_RDONLY	0x0000
-#define O_WRONLY	0x0001
-#define O_RDWR		0x0002
-#define O_ACCMODE	0x0003
-#define O_NDELAY	0x0004
-#define O_APPEND	0x0008
-#define FASYNC		0x0040	/* fcntl, for BSD compatibility */
-#define O_CREAT		0x0200	/* not fcntl */
-#define O_TRUNC		0x0400	/* not fcntl */
-#define O_EXCL		0x0800	/* not fcntl */
-#define O_SYNC		0x2000
-#define O_NONBLOCK	0x4000
-#define O_NOCTTY	0x8000	/* not fcntl */
-#define O_DIRECTORY	0x10000	/* must be a directory */
-#define O_NOFOLLOW	0x20000	/* don't follow links */
-#define O_LARGEFILE	0x40000
-#define O_DIRECT        0x100000 /* direct disk access hint */
-
+#define O_RDONLY		0x0000
+#define O_WRONLY		0x0001
+#define O_RDWR			0x0002
+#define O_ACCMODE		0x0003
+#define O_NDELAY		0x0004
+#define O_APPEND		0x0008
+#define FASYNC			0x0040	/* fcntl, for BSD compatibility */
+#define O_CREAT			0x0200	/* not fcntl */
+#define O_TRUNC			0x0400	/* not fcntl */
+#define O_EXCL			0x0800	/* not fcntl */
+#define O_SYNC			0x2000
+#define O_NONBLOCK		0x4000
+#define O_NOCTTY		0x8000	/* not fcntl */
+#define O_DIRECTORY		0x10000	/* must be a directory */
+#define O_NOFOLLOW		0x20000	/* don't follow links */
+#define O_LARGEFILE		0x40000
+#define O_DIRECT        	0x100000 /* direct disk access hint */
+#define O_KERNEL_LARGEFILE	0x200000 /* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -puN include/asm-arm26/fcntl.h~O_LARGEFILE-fix include/asm-arm26/fcntl.h
--- 25/include/asm-arm26/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:33.079031248 -0800
+++ 25-akpm/include/asm-arm26/fcntl.h	2004-03-21 22:48:00.467532312 -0800
@@ -3,23 +3,24 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
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
-#define O_DIRECTORY	 040000	/* must be a directory */
-#define O_NOFOLLOW	0100000	/* don't follow links */
-#define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
-#define O_LARGEFILE	0400000
+#define O_ACCMODE	       0003
+#define O_RDONLY	         00
+#define O_WRONLY	         01
+#define O_RDWR		         02
+#define O_CREAT		       0100	/* not fcntl */
+#define O_EXCL		       0200	/* not fcntl */
+#define O_NOCTTY	       0400	/* not fcntl */
+#define O_TRUNC		      01000	/* not fcntl */
+#define O_APPEND	      02000
+#define O_NONBLOCK	      04000
+#define O_NDELAY	    O_NONBLOCK
+#define O_SYNC		     010000
+#define FASYNC		     020000	/* fcntl, for BSD compatibility */
+#define O_DIRECTORY	     040000	/* must be a directory */
+#define O_NOFOLLOW	    0100000	/* don't follow links */
+#define O_DIRECT	    0200000	/* direct disk access hint */
+#define O_LARGEFILE	    0400000
+#define O_KERNEL_LARGEFILE 01000000	/* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -puN include/asm-cris/fcntl.h~O_LARGEFILE-fix include/asm-cris/fcntl.h
--- 25/include/asm-cris/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:33.109026688 -0800
+++ 25-akpm/include/asm-cris/fcntl.h	2004-03-21 22:48:37.901841432 -0800
@@ -5,23 +5,24 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
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
-#define O_DIRECT	 040000	/* direct disk access hint - currently ignored */
-#define O_LARGEFILE	0100000
-#define O_DIRECTORY	0200000	/* must be a directory */
-#define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_ACCMODE	       0003
+#define O_RDONLY	         00
+#define O_WRONLY	         01
+#define O_RDWR		         02
+#define O_CREAT		       0100	/* not fcntl */
+#define O_EXCL		       0200	/* not fcntl */
+#define O_NOCTTY	       0400	/* not fcntl */
+#define O_TRUNC		      01000	/* not fcntl */
+#define O_APPEND	      02000
+#define O_NONBLOCK	      04000
+#define O_NDELAY	    O_NONBLOCK
+#define O_SYNC		     010000
+#define FASYNC		     020000	/* fcntl, for BSD compatibility */
+#define O_DIRECT	     040000	/* direct disk access hint */
+#define O_LARGEFILE	    0100000
+#define O_DIRECTORY	    0200000	/* must be a directory */
+#define O_NOFOLLOW	    0400000	/* don't follow links */
+#define O_KERNEL_LARGEFILE 01000000	/* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get f_flags */
diff -puN include/asm-v850/fcntl.h~O_LARGEFILE-fix include/asm-v850/fcntl.h
--- 25/include/asm-v850/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:33.139022128 -0800
+++ 25-akpm/include/asm-v850/fcntl.h	2004-03-21 22:49:23.909847152 -0800
@@ -3,23 +3,24 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
-#define O_ACCMODE	  0003
-#define O_RDONLY	    00
-#define O_WRONLY	    01
-#define O_RDWR		    02
-#define O_CREAT		  0100	/* not fcntl */
-#define O_EXCL		  0200	/* not fcntl */
-#define O_NOCTTY	  0400	/* not fcntl */
-#define O_TRUNC		 01000	/* not fcntl */
-#define O_APPEND	 02000
-#define O_NONBLOCK	 04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		010000
-#define FASYNC		020000	/* fcntl, for BSD compatibility */
-#define O_DIRECTORY	040000	/* must be a directory */
-#define O_NOFOLLOW     0100000	/* don't follow links */
-#define O_DIRECT       0200000	/* direct disk access hint - currently ignored */
-#define O_LARGEFILE    0400000
+#define O_ACCMODE	       0003
+#define O_RDONLY	         00
+#define O_WRONLY	         01
+#define O_RDWR		         02
+#define O_CREAT		       0100	/* not fcntl */
+#define O_EXCL		       0200	/* not fcntl */
+#define O_NOCTTY	       0400	/* not fcntl */
+#define O_TRUNC		      01000	/* not fcntl */
+#define O_APPEND	      02000
+#define O_NONBLOCK	      04000
+#define O_NDELAY	     O_NONBLOCK
+#define O_SYNC		     010000
+#define FASYNC		     020000	/* fcntl, for BSD compatibility */
+#define O_DIRECTORY	     040000	/* must be a directory */
+#define O_NOFOLLOW          0100000	/* don't follow links */
+#define O_DIRECT            0200000	/* direct disk access hint */
+#define O_LARGEFILE         0400000
+#define O_KERNEL_LARGEFILE 01000000	/* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -puN include/asm-sh/fcntl.h~O_LARGEFILE-fix include/asm-sh/fcntl.h
--- 25/include/asm-sh/fcntl.h~O_LARGEFILE-fix	2004-03-21 22:36:33.168017720 -0800
+++ 25-akpm/include/asm-sh/fcntl.h	2004-03-21 22:49:56.544885872 -0800
@@ -3,23 +3,24 @@
 
 /* open/fcntl - O_SYNC is only implemented on blocks devices and on files
    located on an ext2 file system */
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
-#define O_DIRECT	 040000	/* direct disk access hint - currently ignored */
-#define O_LARGEFILE	0100000
-#define O_DIRECTORY	0200000	/* must be a directory */
-#define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_ACCMODE	       0003
+#define O_RDONLY	         00
+#define O_WRONLY	         01
+#define O_RDWR		         02
+#define O_CREAT		       0100	/* not fcntl */
+#define O_EXCL		       0200	/* not fcntl */
+#define O_NOCTTY	       0400	/* not fcntl */
+#define O_TRUNC		      01000	/* not fcntl */
+#define O_APPEND	      02000
+#define O_NONBLOCK	      04000
+#define O_NDELAY	    O_NONBLOCK
+#define O_SYNC		     010000
+#define FASYNC		     020000	/* fcntl, for BSD compatibility */
+#define O_DIRECT	     040000	/* direct disk access hint */
+#define O_LARGEFILE	    0100000
+#define O_DIRECTORY	    0200000	/* must be a directory */
+#define O_NOFOLLOW	    0400000	/* don't follow links */
+#define O_KERNEL_LARGEFILE 01000000	/* kernel-internal large file hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -puN fs/xfs/linux/xfs_file.c~O_LARGEFILE-fix fs/xfs/linux/xfs_file.c
--- 25/fs/xfs/linux/xfs_file.c~O_LARGEFILE-fix	2004-03-21 22:36:33.184015288 -0800
+++ 25-akpm/fs/xfs/linux/xfs_file.c	2004-03-21 22:50:24.923571656 -0800
@@ -276,7 +276,8 @@ linvfs_open(
 	vnode_t		*vp = LINVFS_GET_VP(inode);
 	int		error;
 
-	if (!(filp->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_LFS)
+	if (!(filp->f_flags & (O_LARGEFILE|O_KERNEL_LARGEFILE)) &&
+			i_size_read(inode) > MAX_NON_LFS)
 		return -EFBIG;
 
 	ASSERT(vp);
diff -puN fs/xfs/linux/xfs_ioctl.c~O_LARGEFILE-fix fs/xfs/linux/xfs_ioctl.c
--- 25/fs/xfs/linux/xfs_ioctl.c~O_LARGEFILE-fix	2004-03-21 22:36:33.200012856 -0800
+++ 25-akpm/fs/xfs/linux/xfs_ioctl.c	2004-03-21 22:50:35.833913032 -0800
@@ -326,7 +326,7 @@ xfs_open_by_handle(
 	}
 
 #if BITS_PER_LONG != 32
-	hreq.oflags |= O_LARGEFILE;
+	hreq.oflags |= O_KERNEL_LARGEFILE;
 #endif
 	/* Put open permission in namei format. */
 	permflag = hreq.oflags;
diff -puN fs/nfsd/vfs.c~O_LARGEFILE-fix fs/nfsd/vfs.c
--- 25/fs/nfsd/vfs.c~O_LARGEFILE-fix	2004-03-21 22:36:33.217010272 -0800
+++ 25-akpm/fs/nfsd/vfs.c	2004-03-21 22:51:02.437868616 -0800
@@ -455,7 +455,7 @@ nfsd_open(struct svc_rqst *rqstp, struct
 {
 	struct dentry	*dentry;
 	struct inode	*inode;
-	int		flags = O_RDONLY|O_LARGEFILE, err;
+	int		flags = O_RDONLY|O_KERNEL_LARGEFILE, err;
 
 	/*
 	 * If we get here, then the client has already done an "open",
@@ -491,7 +491,7 @@ nfsd_open(struct svc_rqst *rqstp, struct
 		if (err)
 			goto out_nfserr;
 
-		flags = O_WRONLY|O_LARGEFILE;
+		flags = O_WRONLY|O_KERNEL_LARGEFILE;
 
 		DQUOT_INIT(inode);
 	}
diff -puN fs/cifs/file.c~O_LARGEFILE-fix fs/cifs/file.c
diff -puN fs/udf/file.c~O_LARGEFILE-fix fs/udf/file.c
--- 25/fs/udf/file.c~O_LARGEFILE-fix	2004-03-21 22:36:33.270002216 -0800
+++ 25-akpm/fs/udf/file.c	2004-03-21 22:51:59.948125728 -0800
@@ -262,14 +262,15 @@ static int udf_release_file(struct inode
  *
  * DESCRIPTION
  *  Use this to disallow opening RW large files on 32 bit systems.
- *  On 64 bit systems we force on O_LARGEFILE in sys_open.
+ *  On 64 bit systems we force on O_KERNEL_LARGEFILE in sys_open.
  *
  * HISTORY
  *
  */
 static int udf_open_file(struct inode * inode, struct file * filp)
 {
-	if ((inode->i_size & 0xFFFFFFFF80000000ULL) && !(filp->f_flags & O_LARGEFILE))
+	if ((inode->i_size & 0xFFFFFFFF80000000ULL) &&
+			!(filp->f_flags & (O_LARGEFILE|O_KERNEL_LARGEFILE)))
 		return -EFBIG;
 	return 0;
 }
diff -puN fs/ncpfs/file.c~O_LARGEFILE-fix fs/ncpfs/file.c
--- 25/fs/ncpfs/file.c~O_LARGEFILE-fix	2004-03-21 22:36:33.290999024 -0800
+++ 25-akpm/fs/ncpfs/file.c	2004-03-21 22:52:28.007860000 -0800
@@ -213,7 +213,8 @@ ncp_file_write(struct file *file, const 
 		pos = inode->i_size;
 	}
 
-	if (pos + count > MAX_NON_LFS && !(file->f_flags&O_LARGEFILE)) {
+	if (pos + count > MAX_NON_LFS &&
+	    !(file->f_flags & (O_LARGEFILE|O_KERNEL_LARGEFILE))) {
 		if (pos >= MAX_NON_LFS) {
 			send_sig(SIGXFSZ, current, 0);
 			return -EFBIG;
diff -puN fs/open.c~O_LARGEFILE-fix fs/open.c
--- 25/fs/open.c~O_LARGEFILE-fix	2004-03-21 22:36:33.310995984 -0800
+++ 25-akpm/fs/open.c	2004-03-21 22:53:52.105075280 -0800
@@ -279,7 +279,7 @@ static inline long do_sys_ftruncate(unsi
 		goto out;
 
 	/* explicitly opened as large or we are on 64-bit box */
-	if (file->f_flags & O_LARGEFILE)
+	if (file->f_flags & (O_LARGEFILE|O_KERNEL_LARGEFILE))
 		small = 0;
 
 	dentry = file->f_dentry;
@@ -931,7 +931,7 @@ asmlinkage long sys_open(const char __us
 	int fd, error;
 
 #if BITS_PER_LONG != 32
-	flags |= O_LARGEFILE;
+	flags |= O_KERNEL_LARGEFILE;
 #endif
 	tmp = getname(filename);
 	fd = PTR_ERR(tmp);
@@ -1046,14 +1046,14 @@ asmlinkage long sys_vhangup(void)
 /*
  * Called when an inode is about to be open.
  * We use this to disallow opening large files on 32bit systems if
- * the caller didn't specify O_LARGEFILE.  On 64bit systems we force
- * on this flag in sys_open.
+ * the caller didn't specify O_LARGEFILE or O_KERNEL_LARGEFILE.  On 64bit
+ * systems we force on O_KERNEL_LARGEFILE in sys_open.
  */
 int generic_file_open(struct inode * inode, struct file * filp)
 {
-	if (!(filp->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_LFS)
+	if (!(filp->f_flags & (O_LARGEFILE|O_KERNEL_LARGEFILE)) &&
+				i_size_read(inode) > MAX_NON_LFS)
 		return -EFBIG;
 	return 0;
 }
-
 EXPORT_SYMBOL(generic_file_open);
diff -puN fs/ext3/file.c~O_LARGEFILE-fix fs/ext3/file.c
--- 25/fs/ext3/file.c~O_LARGEFILE-fix	2004-03-21 22:36:33.328993248 -0800
+++ 25-akpm/fs/ext3/file.c	2004-03-21 22:54:25.683970512 -0800
@@ -44,12 +44,12 @@ static int ext3_release_file (struct ino
 /*
  * Called when an inode is about to be opened.
  * We use this to disallow opening RW large files on 32bit systems if
- * the caller didn't specify O_LARGEFILE.  On 64bit systems we force
- * on this flag in sys_open.
+ * the caller didn't specify O_LARGEFILE or O_KERNEL_LARGEFILE.  On 64bit
+ * systems we force on O_KERNEL_LARGEFILE in sys_open.
  */
 static int ext3_open_file (struct inode *inode, struct file *filp)
 {
-	if (!(filp->f_flags & O_LARGEFILE) &&
+	if (!(filp->f_flags & (O_LARGEFILE|O_KERNEL_LARGEFILE)) &&
 	    inode->i_size > 0x7FFFFFFFLL)
 		return -EFBIG;
 	return 0;
diff -puN fs/exec.c~O_LARGEFILE-fix fs/exec.c
--- 25/fs/exec.c~O_LARGEFILE-fix	2004-03-21 22:36:33.354989296 -0800
+++ 25-akpm/fs/exec.c	2004-03-21 22:55:33.016734376 -0800
@@ -1387,7 +1387,8 @@ int do_coredump(long signr, int exit_cod
 		goto fail_unlock;
 
  	format_corename(corename, core_pattern, signr);
-	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
+	file = filp_open(corename,
+			O_CREAT|O_RDWR|O_NOFOLLOW|O_KERNEL_LARGEFILE, 0600);
 	if (IS_ERR(file))
 		goto fail_unlock;
 	inode = file->f_dentry->d_inode;
diff -puN fs/block_dev.c~O_LARGEFILE-fix fs/block_dev.c
--- 25/fs/block_dev.c~O_LARGEFILE-fix	2004-03-21 22:36:33.375986104 -0800
+++ 25-akpm/fs/block_dev.c	2004-03-21 22:55:40.934530688 -0800
@@ -679,7 +679,7 @@ int blkdev_open(struct inode * inode, st
 	 * binary needs it. We might want to drop this workaround
 	 * during an unstable branch.
 	 */
-	filp->f_flags |= O_LARGEFILE;
+	filp->f_flags |= O_KEREL_LARGEFILE;
 
 	bdev = bd_acquire(inode);
 
diff -puN mm/filemap.c~O_LARGEFILE-fix mm/filemap.c
--- 25/mm/filemap.c~O_LARGEFILE-fix	2004-03-21 22:36:33.408981088 -0800
+++ 25-akpm/mm/filemap.c	2004-03-21 22:56:09.042257664 -0800
@@ -1668,7 +1668,7 @@ inline int generic_write_checks(struct f
 	 * LFS rule
 	 */
 	if (unlikely(*pos + *count > MAX_NON_LFS &&
-				!(file->f_flags & O_LARGEFILE))) {
+	    !(file->f_flags & (O_LARGEFILE|O_KERNEL_LARGEFILE)))) {
 		if (*pos >= MAX_NON_LFS) {
 			send_sig(SIGXFSZ, current, 0);
 			return -EFBIG;
diff -puN fs/fcntl.c~O_LARGEFILE-fix fs/fcntl.c
--- 25/fs/fcntl.c~O_LARGEFILE-fix	2004-03-21 22:56:12.073796800 -0800
+++ 25-akpm/fs/fcntl.c	2004-03-21 22:56:27.551443840 -0800
@@ -300,7 +300,7 @@ static long do_fcntl(unsigned int fd, un
 			set_close_on_exec(fd, arg & FD_CLOEXEC);
 			break;
 		case F_GETFL:
-			err = filp->f_flags;
+			err = filp->f_flags & ~O_KERNEL_LARGEFILE;
 			break;
 		case F_SETFL:
 			err = setfl(fd, filp, arg);

_

