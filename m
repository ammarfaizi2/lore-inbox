Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130151AbQKRS4M>; Sat, 18 Nov 2000 13:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130462AbQKRS4C>; Sat, 18 Nov 2000 13:56:02 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:7461 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130151AbQKRSzs>; Sat, 18 Nov 2000 13:55:48 -0500
Date: Sat, 18 Nov 2000 19:25:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "H . J . Lu" <hjl@valinux.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: lseek/llseek allows the negative offset
Message-ID: <20001118192542.B24555@athlon.random>
In-Reply-To: <20001117155913.A26622@valinux.com> <20001117160900.A27010@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001117160900.A27010@valinux.com>; from hjl@valinux.com on Fri, Nov 17, 2000 at 04:09:00PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 04:09:00PM -0800, H . J . Lu wrote:
> On Fri, Nov 17, 2000 at 03:59:13PM -0800, H . J . Lu wrote:
> > # gcc x.c
> > # ./a.out
> > lseek on -100000: -100000
> > write: File too large
> > 
> > Should kernel allow negative offsets for lseek/llseek?
> > 
> > 
> 
> Never mind. I was running the wrong kernel.

With 2.2.18pre21aa2 this little proggy:

main()
{
	int fd = creat("x", 0600);
	lseek(fd, 0x80000000, 0);
}

get confused this way:

lseek(3, 2147483648, SEEK_SET)          = -1 ERRNO_0 (Success)
_exit(-2147483648)                      = ?

I fixed it this way:

diff -urN 2.2.18pre21/fs/read_write.c lseek/fs/read_write.c
--- 2.2.18pre21/fs/read_write.c	Tue Sep  5 02:28:49 2000
+++ lseek/fs/read_write.c	Sat Nov 18 18:42:55 2000
@@ -53,6 +53,10 @@
 	struct dentry * dentry;
 	struct inode * inode;
 
+	retval = -EINVAL;
+	if (offset < 0)
+		goto out_nolock;
+
 	lock_kernel();
 	retval = -EBADF;
 	file = fget(fd);
@@ -69,6 +73,7 @@
 	fput(file);
 bad:
 	unlock_kernel();
+out_nolock:
 	return retval;
 }
 
@@ -83,6 +88,11 @@
 	struct inode * inode;
 	loff_t offset;
 
+	retval = -EINVAL;
+	offset = ((loff_t) offset_high << 32) | offset_low;
+	if (offset < 0)
+		goto out_nolock;
+
 	lock_kernel();
 	retval = -EBADF;
 	file = fget(fd);
@@ -96,8 +106,7 @@
 	if (origin > 2)
 		goto out_putf;
 
-	offset = llseek(file, ((loff_t) offset_high << 32) | offset_low,
-			origin);
+	offset = llseek(file, offset, origin);
 
 	retval = (int)offset;
 	if (offset >= 0) {
@@ -109,6 +118,7 @@
 	fput(file);
 bad:
 	unlock_kernel();
+out_nolock:
 	return retval;
 }
 #endif


I've not tried yet in practice but by reading sources 2.4.x has the same bug
since doing the check internally to ext2 is too late to handle the 32bit
(non-lfs) lseek interface.  After moving the checks into the vfs (that seems
the right thing to do to me) the check internally to ext2 can be removed of
course (it was superflous anyways because ext2 file size is limited to 4T
that's not negative value in 64bit signed math)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
