Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318017AbSIESYJ>; Thu, 5 Sep 2002 14:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318020AbSIESYJ>; Thu, 5 Sep 2002 14:24:09 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:29093 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S318017AbSIESYI>;
	Thu, 5 Sep 2002 14:24:08 -0400
Date: Thu, 5 Sep 2002 22:27:27 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.5] unsigned int type for i_nlink field of struct inode
Message-ID: <20020905182727.GA26277@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Per your suggestion I just changed i_nlink type in include/linux/fs.h to
   unsigned int. Also just so that userspace people won't see negative st_nlink
   numbers, I implemented simple conversion in fs/stat.c::generic_fillattr()
   and define that calculates maximum number that fits into nlink_t in
   include/linux/stat.h.

   Filesystems that both allow i_nlink to be bigger that 15 bit and have their
   own fillattr implementation should do somethink like I did in
   generic_fillattr.

   Please apply.

Bye,
    Oleg

===== fs/stat.c 1.13 vs edited =====
--- 1.13/fs/stat.c	Mon Jul 22 14:12:48 2002
+++ edited/fs/stat.c	Thu Sep  5 21:54:54 2002
@@ -21,7 +21,7 @@
 	stat->dev = inode->i_dev;
 	stat->ino = inode->i_ino;
 	stat->mode = inode->i_mode;
-	stat->nlink = inode->i_nlink;
+	stat->nlink = min_t(unsigned int, inode->i_nlink, MAX_NLINK_T);
 	stat->uid = inode->i_uid;
 	stat->gid = inode->i_gid;
 	stat->rdev = kdev_t_to_nr(inode->i_rdev);
===== include/linux/fs.h 1.159 vs edited =====
--- 1.159/include/linux/fs.h	Wed Sep  4 09:03:32 2002
+++ edited/include/linux/fs.h	Thu Sep  5 21:51:42 2002
@@ -368,7 +368,7 @@
 	atomic_t		i_count;
 	dev_t			i_dev;
 	umode_t			i_mode;
-	nlink_t			i_nlink;
+	unsigned int		i_nlink;
 	uid_t			i_uid;
 	gid_t			i_gid;
 	kdev_t			i_rdev;
===== include/linux/stat.h 1.2 vs edited =====
--- 1.2/include/linux/stat.h	Wed Feb  6 21:46:29 2002
+++ edited/include/linux/stat.h	Thu Sep  5 22:05:00 2002
@@ -55,6 +55,9 @@
 
 #include <linux/types.h>
 
+/* May be different for different architectures */
+#define MAX_NLINK_T (nlink_t)((((nlink_t) -1) > 0)?~0:((1u<<(sizeof(nlink_t)*8-1))-1))
+
 struct kstat {
 	unsigned long	ino;
 	dev_t		dev;
