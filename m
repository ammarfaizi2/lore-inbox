Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVCQU5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVCQU5z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 15:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVCQU5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 15:57:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27796 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261174AbVCQUzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 15:55:52 -0500
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OvFiSqH9Dy"
Content-Transfer-Encoding: 7bit
Message-ID: <16953.58653.816204.598208@segfault.boston.redhat.com>
Date: Thu, 17 Mar 2005 15:14:21 -0500
To: linux-kernel@vger.kernel.org
Subject: [rfc] non-blocking event loop for network & disk I/O
X-Mailer: VM 7.19 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OvFiSqH9Dy
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

In designing a streaming media application, I want to use a single event
processing loop for both disk and network I/O.  The idea is that the I/O
done in this loop should never block.  Doing this for network I/O is pretty
standard (i.e. set O_NONBLOCK and use a poll variant).

Asynchronous/nonblocking file I/O has its limitations, however.  AIO can
only be used in conjunction with O_DIRECT, and I'd rather be able to
utilize the page cache.  Even so, it is difficult to mix io_getevents with
poll in a single event loop.  You could use mmap/mincore, but there is
still a race between the mincore call and the actual read of the data.

So, have I missed any other tools which would help to solve this problem?

It seems that if we introduced a nonblocking flag for file I/O, this
problem would be addressed.  Call it O_ATOMICREAD or some such thing.  It's
actually quite easy to do (patch attached).

I even went so far as to modify squid's aufs store type to use this, so
there is use outside of just the streaming media example given above
(though I haven't had time to benchmark it).

Comments?

Thanks in advance,

Jeff


--OvFiSqH9Dy
Content-Type: text/plain
Content-Disposition: inline;
	filename="linux-2.6.11-o_atomicread.patch"
Content-Transfer-Encoding: 7bit

--- linux-2.6.11/fs/fcntl.c.orig	2005-03-17 13:48:28.302745792 -0500
+++ linux-2.6.11/fs/fcntl.c	2005-03-17 13:48:48.203720384 -0500
@@ -181,7 +181,7 @@ asmlinkage long sys_dup(unsigned int fil
 	return ret;
 }
 
-#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | FASYNC | O_DIRECT | O_NOATIME)
+#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | FASYNC | O_DIRECT | O_NOATIME | O_ATOMICREAD)
 
 static int setfl(int fd, struct file * filp, unsigned long arg)
 {
--- linux-2.6.11/include/asm-mips/fcntl.h.orig	2005-03-17 14:01:08.039248288 -0500
+++ linux-2.6.11/include/asm-mips/fcntl.h	2005-03-17 14:01:30.365854128 -0500
@@ -27,6 +27,7 @@
 #define O_DIRECTORY	0x10000	/* must be a directory */
 #define O_NOFOLLOW	0x20000	/* don't follow links */
 #define O_NOATIME	0x40000
+#define O_ATOMICREAD	0x80000 /* non-blocking file i/o */
 
 #define O_NDELAY	O_NONBLOCK
 
--- linux-2.6.11/include/asm-parisc/fcntl.h.orig	2005-03-17 14:02:01.120178760 -0500
+++ linux-2.6.11/include/asm-parisc/fcntl.h	2005-03-17 14:02:02.160020680 -0500
@@ -20,6 +20,7 @@
 #define O_DSYNC		01000000 /* HPUX only */
 #define O_RSYNC		02000000 /* HPUX only */
 #define O_NOATIME	04000000
+#define O_ATOMICREAD	10000000 /* non-blocking file i/o */
 
 #define FASYNC		00020000 /* fcntl, for BSD compatibility */
 #define O_DIRECT	00040000 /* direct disk access hint - currently ignored */
--- linux-2.6.11/include/asm-ppc64/fcntl.h.orig	2005-03-17 13:57:16.464453008 -0500
+++ linux-2.6.11/include/asm-ppc64/fcntl.h	2005-03-17 13:57:26.291959000 -0500
@@ -28,6 +28,7 @@
 #define O_LARGEFILE     0200000
 #define O_DIRECT	0400000	/* direct disk access hint */
 #define O_NOATIME	01000000
+#define O_ATOMICREAD	02000000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux-2.6.11/include/asm-x86_64/fcntl.h.orig	2005-03-17 13:56:19.711080832 -0500
+++ linux-2.6.11/include/asm-x86_64/fcntl.h	2005-03-17 13:56:24.575341352 -0500
@@ -21,6 +21,7 @@
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
+#define O_ATOMICREAD	02000000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux-2.6.11/include/asm-arm/fcntl.h.orig	2005-03-17 13:58:49.073374312 -0500
+++ linux-2.6.11/include/asm-arm/fcntl.h	2005-03-17 13:58:50.032228544 -0500
@@ -21,6 +21,7 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 #define O_NOATIME	01000000
+#define O_ATOMICREAD	02000000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux-2.6.11/include/asm-m68k/fcntl.h.orig	2005-03-17 14:00:32.230692016 -0500
+++ linux-2.6.11/include/asm-m68k/fcntl.h	2005-03-17 14:00:33.107558712 -0500
@@ -21,6 +21,7 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 #define O_NOATIME	01000000
+#define O_ATOMICREAD	02000000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux-2.6.11/include/asm-ppc/fcntl.h.orig	2005-03-17 13:56:56.661463520 -0500
+++ linux-2.6.11/include/asm-ppc/fcntl.h	2005-03-17 13:57:07.509814320 -0500
@@ -21,6 +21,7 @@
 #define O_LARGEFILE     0200000
 #define O_DIRECT	0400000	/* direct disk access hint */
 #define O_NOATIME	01000000
+#define O_ATOMICREAD	02000000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux-2.6.11/include/asm-sparc/fcntl.h.orig	2005-03-17 14:02:57.827557928 -0500
+++ linux-2.6.11/include/asm-sparc/fcntl.h	2005-03-17 14:02:58.682427968 -0500
@@ -22,6 +22,7 @@
 #define O_LARGEFILE	0x40000
 #define O_DIRECT        0x100000 /* direct disk access hint */
 #define O_NOATIME	0x200000
+#define O_ATOMICREAD	0x400000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux-2.6.11/include/asm-alpha/fcntl.h.orig	2005-03-17 13:58:22.624395168 -0500
+++ linux-2.6.11/include/asm-alpha/fcntl.h	2005-03-17 13:58:23.599246968 -0500
@@ -22,6 +22,7 @@
 #define O_LARGEFILE	0400000 /* will be set by the kernel on every open */
 #define O_DIRECT	02000000 /* direct disk access - should check with OSF/1 */
 #define O_NOATIME	04000000
+#define O_ATOMICREAD	10000000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux-2.6.11/include/asm-v850/fcntl.h.orig	2005-03-17 14:03:45.439319840 -0500
+++ linux-2.6.11/include/asm-v850/fcntl.h	2005-03-17 14:03:46.312187144 -0500
@@ -21,6 +21,7 @@
 #define O_DIRECT       0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE    0400000
 #define O_NOATIME	01000000
+#define O_ATOMICREAD	02000000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux-2.6.11/include/asm-i386/fcntl.h.orig	2005-03-17 13:55:43.761545992 -0500
+++ linux-2.6.11/include/asm-i386/fcntl.h	2005-03-17 13:56:02.172747064 -0500
@@ -21,6 +21,7 @@
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
+#define O_ATOMICREAD	02000000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux-2.6.11/include/asm-frv/fcntl.h.orig	2005-03-17 13:59:33.734584776 -0500
+++ linux-2.6.11/include/asm-frv/fcntl.h	2005-03-17 13:59:34.580456184 -0500
@@ -21,6 +21,7 @@
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
+#define O_ATOMICREAD	02000000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux-2.6.11/include/asm-m32r/fcntl.h.orig	2005-03-17 14:00:13.786495960 -0500
+++ linux-2.6.11/include/asm-m32r/fcntl.h	2005-03-17 14:00:14.661362960 -0500
@@ -25,6 +25,7 @@
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
+#define O_ATOMICREAD	02000000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux-2.6.11/include/asm-h8300/fcntl.h.orig	2005-03-17 13:59:56.604108080 -0500
+++ linux-2.6.11/include/asm-h8300/fcntl.h	2005-03-17 13:59:57.522968392 -0500
@@ -21,6 +21,7 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 #define O_NOATIME	01000000
+#define O_ATOMICREAD	02000000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux-2.6.11/include/asm-s390/fcntl.h.orig	2005-03-17 13:57:42.654471520 -0500
+++ linux-2.6.11/include/asm-s390/fcntl.h	2005-03-17 13:57:43.860288208 -0500
@@ -28,6 +28,7 @@
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
+#define O_ATOMICREAD	02000000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux-2.6.11/include/asm-ia64/fcntl.h.orig	2005-03-17 13:56:44.119370208 -0500
+++ linux-2.6.11/include/asm-ia64/fcntl.h	2005-03-17 13:56:46.889949016 -0500
@@ -29,6 +29,7 @@
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
+#define O_ATOMICREAD	02000000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux-2.6.11/include/asm-cris/fcntl.h.orig	2005-03-17 13:59:20.996521256 -0500
+++ linux-2.6.11/include/asm-cris/fcntl.h	2005-03-17 13:59:22.037363024 -0500
@@ -23,6 +23,7 @@
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
+#define O_ATOMICREAD	02000000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get f_flags */
--- linux-2.6.11/include/asm-sparc64/fcntl.h.orig	2005-03-17 14:03:18.313443600 -0500
+++ linux-2.6.11/include/asm-sparc64/fcntl.h	2005-03-17 14:03:19.482265912 -0500
@@ -22,6 +22,7 @@
 #define O_LARGEFILE	0x40000
 #define O_DIRECT        0x100000 /* direct disk access hint */
 #define O_NOATIME	0x200000
+#define O_ATOMICREAD	0x400000 /* non-blocking file i/o */
 
 
 #define F_DUPFD		0	/* dup */
--- linux-2.6.11/include/asm-arm26/fcntl.h.orig	2005-03-17 13:59:04.970957512 -0500
+++ linux-2.6.11/include/asm-arm26/fcntl.h	2005-03-17 13:59:06.485727232 -0500
@@ -21,6 +21,7 @@
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
 #define O_NOATIME	01000000
+#define O_ATOMICREAD	02000000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux-2.6.11/include/asm-sh/fcntl.h.orig	2005-03-17 14:02:16.734804976 -0500
+++ linux-2.6.11/include/asm-sh/fcntl.h	2005-03-17 14:02:24.028696136 -0500
@@ -21,6 +21,7 @@
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
+#define O_ATOMICREAD	02000000 /* non-blocking file i/o */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
--- linux-2.6.11/mm/filemap.c.orig	2005-03-17 13:37:48.270045552 -0500
+++ linux-2.6.11/mm/filemap.c	2005-03-17 13:48:20.594917560 -0500
@@ -696,7 +696,7 @@ void do_generic_mapping_read(struct addr
 	unsigned long prev_index;
 	loff_t isize;
 	struct page *cached_page;
-	int error;
+	int error, nonblock = filp->f_flags & O_ATOMICREAD;
 	struct file_ra_state ra = *_ra;
 
 	cached_page = NULL;
@@ -728,7 +728,7 @@ void do_generic_mapping_read(struct addr
 		nr = nr - offset;
 
 		cond_resched();
-		if (index == next_index && req_size) {
+		if (index == next_index && req_size && !nonblock) {
 			ret_size = page_cache_readahead(mapping, &ra,
 					filp, index, req_size);
 			next_index += ret_size;
@@ -738,11 +738,21 @@ void do_generic_mapping_read(struct addr
 find_page:
 		page = find_get_page(mapping, index);
 		if (unlikely(page == NULL)) {
+			if (nonblock) {
+				desc->error = -EWOULDBLOCK;
+				break;
+			}
 			handle_ra_miss(mapping, &ra, index);
 			goto no_cached_page;
 		}
-		if (!PageUptodate(page))
+		if (!PageUptodate(page)) {
+			if (nonblock) {
+				page_cache_release(page);
+				desc->error = -EWOULDBLOCK;
+				break;
+			}
 			goto page_not_up_to_date;
+		}
 page_ok:
 
 		/* If users can be writing to this page using arbitrary
@@ -1000,7 +1010,7 @@ __generic_file_aio_read(struct kiocb *io
 			desc.error = 0;
 			do_generic_file_read(filp,ppos,&desc,file_read_actor);
 			retval += desc.written;
-			if (!retval) {
+			if (!retval || desc.error) {
 				retval = desc.error;
 				break;
 			}

--OvFiSqH9Dy--
