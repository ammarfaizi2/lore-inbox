Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270165AbTGUPiO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270185AbTGUPiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:38:14 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:5897 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270165AbTGUPhq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:37:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] vfat dentry handling fix (3/11)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 22 Jul 2003 00:52:39 +0900
Message-ID: <87fzkzx4fs.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Intent of this fixes following case of vfat_revalidate().

before:
	# mount -t vfat /dev/hda6 /mnt -o shortname=winnt
	# cd /mnt
	# cat File.Txt			# make negative dentry
	cat: File.Txt: No such file or directory
	# touch file.txt		# match negative dentry
	# ls
	File.Txt

after:
	# mount -t vfat /dev/hda6 /mnt -o shortname=winnt
	# cd /mnt
	# cat File.Txt			# make negative dentry
	cat: File.Txt: No such file or directory
	# touch file.txt		# match negative dentry
	# ls
	file.txt


 fs/vfat/namei.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff -puN fs/vfat/namei.c~fat_dentry-handling-fix fs/vfat/namei.c
--- linux-2.6.0-test1/fs/vfat/namei.c~fat_dentry-handling-fix	2003-07-21 02:48:14.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/vfat/namei.c	2003-07-21 02:48:14.000000000 +0900
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/namei.h>
 
 #define DEBUG_LEVEL 0
 #if (DEBUG_LEVEL >= 1)
@@ -70,14 +71,20 @@ static struct dentry_operations vfat_den
 
 static int vfat_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
+	int ret = 1;
 	PRINTK1(("vfat_revalidate: %s\n", dentry->d_name.name));
 	spin_lock(&dcache_lock);
-	if (dentry->d_time == dentry->d_parent->d_inode->i_version) {
-		spin_unlock(&dcache_lock);
-		return 1;
-	}
+	if (nd && !(nd->flags & LOOKUP_CONTINUE) && (nd->flags & LOOKUP_CREATE))
+		/*
+		 * negative dentry is dropped, in order to make sure
+		 * to use the name which a user desires if this is
+		 * create path.
+		 */
+		ret = 0;
+	else if (dentry->d_time != dentry->d_parent->d_inode->i_version)
+		ret = 0;
 	spin_unlock(&dcache_lock);
-	return 0;
+	return ret;
 }
 
 static inline unsigned char

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
