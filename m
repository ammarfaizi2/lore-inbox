Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbTBUXOf>; Fri, 21 Feb 2003 18:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267800AbTBUXOf>; Fri, 21 Feb 2003 18:14:35 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:4052 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S267534AbTBUXOd>; Fri, 21 Feb 2003 18:14:33 -0500
Message-ID: <3E56B524.2060201@quark.didntduck.org>
Date: Fri, 21 Feb 2003 18:24:20 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Clean up list head usage in sysrq.c
Content-Type: multipart/mixed;
 boundary="------------010504040003090407020404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010504040003090407020404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Use list_for_each_entry() instead of open code.

--
				Brian Gerst

--------------010504040003090407020404
Content-Type: text/plain;
 name="sysrqlist-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysrqlist-1"

diff -urN linux-2.5.62-bk6/drivers/char/sysrq.c linux/drivers/char/sysrq.c
--- linux-2.5.62-bk6/drivers/char/sysrq.c	2003-01-13 16:20:50.000000000 -0500
+++ linux/drivers/char/sysrq.c	2003-02-21 10:36:41.000000000 -0500
@@ -153,7 +153,7 @@
 
 	if (remount_flag) { /* Remount R/O */
 		int ret, flags;
-		struct list_head *p;
+		struct file *file;
 
 		if (sb->s_flags & MS_RDONLY) {
 			printk("R/O\n");
@@ -161,8 +161,7 @@
 		}
 
 		file_list_lock();
-		for (p = sb->s_files.next; p != &sb->s_files; p = p->next) {
-			struct file *file = list_entry(p, struct file, f_list);
+		list_for_each_entry(file, &sb->s_files, f_list) {
 			if (file->f_dentry && file_count(file)
 				&& S_ISREG(file->f_dentry->d_inode->i_mode))
 				file->f_mode &= ~2;
@@ -205,15 +204,11 @@
 	remount_flag = (emergency_sync_scheduled == EMERG_REMOUNT);
 	emergency_sync_scheduled = 0;
 
-	for (sb = sb_entry(super_blocks.next);
-	     sb != sb_entry(&super_blocks); 
-	     sb = sb_entry(sb->s_list.next))
+	list_for_each_entry(sb, &super_blocks, s_list)
 		if (sb->s_bdev && is_local_disk(sb->s_bdev))
 			go_sync(sb, remount_flag);
 
-	for (sb = sb_entry(super_blocks.next);
-	     sb != sb_entry(&super_blocks); 
-	     sb = sb_entry(sb->s_list.next))
+	list_for_each_entry(sb, &super_blocks, s_list)
 		if (sb->s_bdev && !is_local_disk(sb->s_bdev))
 			go_sync(sb, remount_flag);
 

--------------010504040003090407020404--

