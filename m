Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261377AbTCOKKh>; Sat, 15 Mar 2003 05:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261378AbTCOKKh>; Sat, 15 Mar 2003 05:10:37 -0500
Received: from comtv.ru ([217.10.32.4]:29347 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261377AbTCOKKg>;
	Sat, 15 Mar 2003 05:10:36 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: [PATCH] remove BKL from ext2's readdir
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 15 Mar 2003 13:13:20 +0300
Message-ID: <m3vfyluedb.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi!

I took a look at readdir() in 2.5.64's ext2 and found it serialized by BKL.
As far as I see in sources, there is no need in this BKL. So, here is small
patch and some benchmarks. of course, the result was expected pretty much ;)


             500         1000
readdir+BKL: 0m11.793s   0m23.403s
readdir-BKL: 0m6.060s    0m12.113s

description: two processes read own dir populated by files (500 and 1000 files).
this repeats for 100000 times. the iron is dual 1GHz P3.


diff -uNr linux/fs/ext2/dir.c edited/fs/ext2/dir.c
--- linux/fs/ext2/dir.c	Sat Mar 15 13:08:24 2003
+++ edited/fs/ext2/dir.c	Sat Mar 15 13:08:11 2003
@@ -259,8 +259,6 @@
 	int need_revalidate = (filp->f_version != inode->i_version);
 	int ret = 0;
 
-	lock_kernel();
-
 	if (pos > inode->i_size - EXT2_DIR_REC_LEN(1))
 		goto done;
 
@@ -313,7 +311,6 @@
 	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
 	filp->f_version = inode->i_version;
 	UPDATE_ATIME(inode);
-	unlock_kernel();
 	return 0;
 }
 

