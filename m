Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271626AbTGQX2g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 19:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271629AbTGQX2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 19:28:36 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:28859 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S271626AbTGQX2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 19:28:34 -0400
Subject: info leak -- padded struct copied to user
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@digeo.com, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1058484872.733.25.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Jul 2003 19:34:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not OK to leak bits of the kernel stack.
(timy security flaw) I found this with -Wpadded.

diff -Naurd old/fs/stat.c new/fs/stat.c
--- old/fs/stat.c	2003-07-17 18:25:20.000000000 -0400
+++ new/fs/stat.c	2003-07-17 18:27:47.000000000 -0400
@@ -123,6 +123,7 @@
 	SET_OLDSTAT_UID(tmp, stat->uid);
 	SET_OLDSTAT_GID(tmp, stat->gid);
 	tmp.st_rdev = stat->rdev;
+	tmp.__pad_16bit = 0;  /* don't leak kernel stack data! */
 #if BITS_PER_LONG == 32
 	if (stat->size > MAX_NON_LFS)
 		return -EOVERFLOW;
diff -Naurd old/include/asm-i386/stat.h new/include/asm-i386/stat.h
--- old/include/asm-i386/stat.h	2003-06-26 17:50:47.000000000 -0400
+++ new/include/asm-i386/stat.h	2003-07-17 18:23:01.000000000 -0400
@@ -9,6 +9,7 @@
 	unsigned short st_uid;
 	unsigned short st_gid;
 	unsigned short st_rdev;
+	unsigned short __pad_16bit;
 	unsigned long  st_size;
 	unsigned long  st_atime;
 	unsigned long  st_mtime;



