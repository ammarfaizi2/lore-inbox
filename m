Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289243AbSCHDJS>; Thu, 7 Mar 2002 22:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310670AbSCHDJI>; Thu, 7 Mar 2002 22:09:08 -0500
Received: from member.michigannet.com ([207.158.188.18]:50444 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S289243AbSCHDJC>; Thu, 7 Mar 2002 22:09:02 -0500
Date: Thu, 7 Mar 2002 22:11:19 -0500
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: filldir() change broke my CFS -- any ideas?
Message-ID: <20020307221119.G218@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi;

	CFS is a user space cryptographic filesystem that is
implemented by a daemon that acts as an nfs server.
	In 2.4.9-pre1 a little patch promoted the type of one of
the arguments to filldir from off_t to loff_t. (patch included
below). This has the effect of breaking directory listings for
CFS: I can only see the first 63 files in a dir. In order to
access the other files, I must delete some from the pool of 63.
	I have watched the routine in cfsd that gets called to
deliver the directories back to the client via whatever rpc
magic, and it looks like its doing the same thing with or without
this patch. (this routine gets called multiple times, until
all files have been read via readdir(3)-- 63 just happens to be
the number that fits in the buffer constraints for an
invocation-- and the 63 files I see are from the first
invocation.)
	I rebuilt glibc against 2.4.18 kernel headers, then
nfs-utils, then cfsd, but still the broken behaviour.
I dont know where the breakage is occuring, and would appreciate
any insight, while I continue to poke at this...

Thanks;
Paul
set@pobox.com

(the patch in question, culled from patch-2.4.9-pre1, arch i386
bits only)

diff -u --recursive --new-file v2.4.8/linux/fs/readdir.c linux/fs/readdir.c
--- v2.4.8/linux/fs/readdir.c	Mon Dec 11 13:45:42 2000
+++ linux/fs/readdir.c	Sun Aug 12 14:59:08 2001
@@ -122,7 +122,7 @@
 	int count;
 };
 
-static int fillonedir(void * __buf, const char * name, int namlen, off_t offset,
+static int fillonedir(void * __buf, const char * name, int namlen, loff_t offset,
 		      ino_t ino, unsigned int d_type)
 {
 	struct readdir_callback * buf = (struct readdir_callback *) __buf;
@@ -183,7 +183,7 @@
 	int error;
 };
 
-static int filldir(void * __buf, const char * name, int namlen, off_t offset,
+static int filldir(void * __buf, const char * name, int namlen, loff_t offset,
 		   ino_t ino, unsigned int d_type)
 {
 	struct linux_dirent * dirent;
@@ -261,7 +261,7 @@
 	int error;
 };
 
-static int filldir64(void * __buf, const char * name, int namlen, off_t offset,
+static int filldir64(void * __buf, const char * name, int namlen, loff_t offset,
 		     ino_t ino, unsigned int d_type)
 {
 	struct linux_dirent64 * dirent, d;
diff -u --recursive --new-file v2.4.8/linux/include/linux/fs.h linux/include/linux/fs.h
--- v2.4.8/linux/include/linux/fs.h	Sun Aug 12 13:28:01 2001
+++ linux/include/linux/fs.h	Sun Aug 12 14:58:26 2001
@@ -763,7 +763,7 @@
  * This allows the kernel to read directories into kernel space or
  * to have different dirent layouts depending on the binary type.
  */
-typedef int (*filldir_t)(void *, const char *, int, off_t, ino_t, unsigned);
+typedef int (*filldir_t)(void *, const char *, int, loff_t, ino_t, unsigned);
 
 struct block_device_operations {
 	int (*open) (struct inode *, struct file *);
