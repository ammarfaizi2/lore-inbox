Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318037AbSG3Fgr>; Tue, 30 Jul 2002 01:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318212AbSG3Fgr>; Tue, 30 Jul 2002 01:36:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:41552 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318037AbSG3Fgo>; Tue, 30 Jul 2002 01:36:44 -0400
Date: Tue, 30 Jul 2002 07:41:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: async-io API registration for 2.5.29
Message-ID: <20020730054111.GA1159@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patch against 2.5.29 adds the async-io API as from latest Ben's
patch.

I find the dynamic syscall approch in some vendor kernel out there
that implements a /proc/libredhat unacceptable since it's not forward
compatible with 2.5:

@@ -636,6 +637,12 @@
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for fremovexattr */
  	.long SYMBOL_NAME(sys_tkill)
 
+ 	.rept __NR_sys_dynamic_syscall-(.-sys_call_table)/4
+ 		.long SYMBOL_NAME(sys_ni_syscall)
+ 	.endr
+ 	.long SYMBOL_NAME(sys_dynamic_syscall)
+ 	.long SYMBOL_NAME(sys_io_submit)
+
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
 	.endr

diff -urN v2.4.19-pre5/include/asm-i386/unistd.h
linux.diff/include/asm-i386/unistd.h
--- v2.4.19-pre5/include/asm-i386/unistd.h	Wed Apr  3 21:04:38 2002
+++ linux.diff/include/asm-i386/unistd.h	Sat May 18 11:44:01 2002
@@ -245,6 +245,9 @@
 
 #define __NR_tkill		238
 
+#define __NR_sys_dynamic_syscall	250
+#define __NR_io_submit			251
+
 /* user-visible error numbers are in the range -1 - -124: see
 * <asm-i386/errno.h> */
 

to try not to execute random code they use a magic number choosen at
compile time from /dev/urandom, so the probability to execute random
code is low but still there's a chance. For the io_sumbit I'm not even
sure if it's using the magic anymore (I guess checking the cookie
payload was a showstopper performance hit, in some older patch the
io_sumbit operation was passing through the slowdown of the dynamic
syscall but infact the new code does this:

+asmlinkage long vsys_io_submit(aio_context_t ctx_id, long nr, struct iocb **iocbpp)
+{
+	long res;
+	__asm__ volatile ("int $0x80"
+		: "=a" (res)
+		: "0" (__NR_io_submit), "b" (ctx_id), "c" (nr),
+		  "d" (iocbpp));
+	return res;
+}

). So I would ask if you could merge the below interface into 2.5 so we can
ship a real async-io with real syscalls in 2.4, there's not much time to
change it given this is just used in production userspace today. I
prepared a patch against 2.5.29. Ben, I would appreciate if you could
review and confirm you're fine with it too.

BTW, I'm not the author of the API, and personally I dislike the
sys_io_sumbit approch, the worst part is the multiplexing of course:

+		if (IOCB_CMD_PREAD == tmp.aio_lio_opcode) {
+			op = file->f_op->aio_read;
+			if (unlikely(!(file->f_mode & FMODE_READ)))
+				goto out_put_req;
+		} else if (IOCB_CMD_PREADX == tmp.aio_lio_opcode) {
+			op = file->f_op->aio_readx;
+			if (unlikely(!(file->f_mode & FMODE_READ)))
+				goto out_put_req;
+		} else if (IOCB_CMD_PWRITE == tmp.aio_lio_opcode) {
+			op = file->f_op->aio_write;
+			if (unlikely(!(file->f_mode & FMODE_WRITE)))
+				goto out_put_req;
+		} else if (IOCB_CMD_FSYNC == tmp.aio_lio_opcode) {
+			op = file->f_op->aio_fsync;
+		} else if (IOCB_CMD_POLL == tmp.aio_lio_opcode) {
+			op = generic_aio_poll;
+		} else
+			op = NULL;


instead of separate syscalls for the various async_io
PREAD/PREADX/PWRITE/FSYNC/POLL operations there is just a single entry
point and a parameters specify the operation. But this is what the
current userspace expects and I wouldn't have too much time to change it
anyways because then I would break all the userspace libs too (I just
break them because of the true syscalls instead of passing through the
/proc/libredhat that calls into the dynamic syscall, but that's not
too painful to adapt). And after all even the io_submit isn't too bad
besides the above slowdown in the multiplexing (at least it's sharing
some icache for top/bottom of the functionality).

checked that it still compiles fine on x86 (all other archs should keep
compiling too). available also from here:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.5/2.5.29/aio-api-1

Comments are welcome, many thanks.

diff -urNp 2.5.29/arch/i386/kernel/entry.S aio-api-1/arch/i386/kernel/entry.S
--- 2.5.29/arch/i386/kernel/entry.S	Sat Jul 27 06:07:21 2002
+++ aio-api-1/arch/i386/kernel/entry.S	Tue Jul 30 05:23:46 2002
@@ -753,6 +753,12 @@ ENTRY(sys_call_table)
 	.long sys_sched_setaffinity
 	.long sys_sched_getaffinity
 	.long sys_set_thread_area
+	.long sys_io_setup
+	.long sys_io_destroy	/* 245 */
+	.long sys_io_submit
+	.long sys_io_cancel
+	.long sys_io_wait
+	.long sys_io_getevents
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -urNp 2.5.29/fs/Makefile aio-api-1/fs/Makefile
--- 2.5.29/fs/Makefile	Wed Jul 17 02:13:47 2002
+++ aio-api-1/fs/Makefile	Tue Jul 30 05:25:03 2002
@@ -15,7 +15,7 @@ obj-y :=	open.o read_write.o devices.o f
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o direct-io.o
+		fs-writeback.o mpage.o direct-io.o aio.o
 
 ifneq ($(CONFIG_NFSD),n)
 ifneq ($(CONFIG_NFSD),)
diff -urNp 2.5.29/fs/aio.c aio-api-1/fs/aio.c
--- 2.5.29/fs/aio.c	Thu Jan  1 01:00:00 1970
+++ aio-api-1/fs/aio.c	Tue Jul 30 05:33:20 2002
@@ -0,0 +1,38 @@
+#include <linux/kernel.h>
+#include <linux/aio.h>
+#include <linux/time.h>
+#include <linux/errno.h>
+
+asmlinkage long sys_io_setup(unsigned nr_reqs, aio_context_t *ctxp)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_io_destroy(aio_context_t ctx)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_io_submit(aio_context_t ctx_id, long nr, struct iocb **iocbpp)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_io_cancel(aio_context_t ctx_id, struct iocb *iocb)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_io_wait(aio_context_t ctx_id, struct iocb *iocb,
+			    const struct timespec *timeout)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_io_getevents(aio_context_t ctx_id,
+				 long nr,
+				 struct io_event *events,
+				 const struct timespec *timeout)
+{
+	return -ENOSYS;
+}
diff -urNp 2.5.29/include/asm-i386/unistd.h aio-api-1/include/asm-i386/unistd.h
--- 2.5.29/include/asm-i386/unistd.h	Sun Apr 14 22:09:06 2002
+++ aio-api-1/include/asm-i386/unistd.h	Tue Jul 30 05:22:38 2002
@@ -247,6 +247,13 @@
 #define __NR_futex		240
 #define __NR_sched_setaffinity	241
 #define __NR_sched_getaffinity	242
+#define __NR_set_thread_area	243
+#define __NR_io_setup		244
+#define __NR_io_destroy		245
+#define __NR_io_submit		246
+#define __NR_io_cancel		247
+#define __NR_io_wait		248
+#define __NR_io_getevents	249
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -urNp 2.5.29/include/linux/aio.h aio-api-1/include/linux/aio.h
--- 2.5.29/include/linux/aio.h	Thu Jan  1 01:00:00 1970
+++ aio-api-1/include/linux/aio.h	Tue Jul 30 05:32:30 2002
@@ -0,0 +1,6 @@
+#ifndef __LINUX__AIO_H
+#define __LINUX__AIO_H
+
+#include <linux/aio_abi.h>
+
+#endif /* __LINUX__AIO_H */
diff -urNp 2.5.29/include/linux/aio_abi.h aio-api-1/include/linux/aio_abi.h
--- 2.5.29/include/linux/aio_abi.h	Thu Jan  1 01:00:00 1970
+++ aio-api-1/include/linux/aio_abi.h	Tue Jul 30 05:57:23 2002
@@ -0,0 +1,86 @@
+/* linux/aio_abi.h
+ *
+ * Copyright 2000,2001,2002 Red Hat.
+ *
+ * Written by Benjamin LaHaise <bcrl@redhat.com>
+ *
+ * Permission to use, copy, modify, and distribute this software and its
+ * documentation is hereby granted, provided that the above copyright
+ * notice appears in all copies.  This software is provided without any
+ * warranty, express or implied.  Red Hat makes no representations about
+ * the suitability of this software for any purpose.
+ *
+ * IN NO EVENT SHALL RED HAT BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
+ * SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OF
+ * THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF RED HAT HAS BEEN ADVISED
+ * OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * RED HAT DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND
+ * RED HAT HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES,
+ * ENHANCEMENTS, OR MODIFICATIONS.
+ */
+#ifndef __LINUX__AIO_ABI_H
+#define __LINUX__AIO_ABI_H
+
+#include <asm/byteorder.h>
+
+typedef unsigned long	aio_context_t;
+
+enum {
+	IOCB_CMD_PREAD = 0,
+	IOCB_CMD_PWRITE = 1,
+	IOCB_CMD_FSYNC = 2,
+	IOCB_CMD_FDSYNC = 3,
+	IOCB_CMD_PREADX = 4,
+	IOCB_CMD_POLL = 5,
+	IOCB_CMD_NOOP = 6,
+};
+
+/* read() from /dev/aio returns these structures. */
+struct io_event {
+	__u64		data;		/* the data field from the iocb */
+	__u64		obj;		/* what iocb this event came from */
+	__s64		res;		/* result code for this event */
+	__s64		res2;		/* secondary result */
+};
+
+#if defined(__LITTLE_ENDIAN)
+#define PADDED(x,y)	x, y
+#elif defined(__BIG_ENDIAN)
+#define PADDED(x,y)	y, x
+#else
+#error edit for your odd byteorder.
+#endif
+
+/*
+ * we always use a 64bit off_t when communicating
+ * with userland.  its up to libraries to do the
+ * proper padding and aio_error abstraction
+ */
+
+struct iocb {
+	/* these are internal to the kernel/libc. */
+	__u64	aio_data;	/* data to be returned in event's data */
+	__u32	PADDED(aio_key, aio_reserved1);
+				/* the kernel sets aio_key to the req # */
+
+	/* common fields */
+	__u16	aio_lio_opcode;	/* see IOCB_CMD_ above */
+	__s16	aio_reqprio;
+	__u32	aio_fildes;
+
+	__u64	aio_buf;
+	__u64	aio_nbytes;
+	__s64	aio_offset;
+
+	/* extra parameters */
+	__u64	aio_reserved2;
+	__u64	aio_reserved3;
+}; /* 64 bytes */
+
+#undef IFBIG
+#undef IFLITTLE
+
+#endif /* __LINUX__AIO_ABI_H */

Andrea
