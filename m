Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbUK3Mms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbUK3Mms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 07:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbUK3Mms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 07:42:48 -0500
Received: from [61.135.145.20] ([61.135.145.20]:27958 "EHLO
	webstmp232.sohu.com") by vger.kernel.org with ESMTP id S262053AbUK3Mmm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 07:42:42 -0500
Message-ID: <13462255.1101818423343.JavaMail.postfix@mx20.mail.sohu.com>
Date: Tue, 30 Nov 2004 20:40:23 +0800 (CST)
From: <stone_wang@sohu.com>
To: <linux-kernel@vger.kernel.org>
Subject: PATCH] Perhaps invalid goal for file block #1 in ext3(2)_find_goal 
Cc: <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Sohu Web Mail 2.0.13
X-SHIP: 219.136.50.184
X-Priority: 3
X-SHMOBILE: 0
X-Sohu-Antivirus: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi:

I am learning how Ext2/3 works and how we could better use it for our servers.

In the process,i found something strange in ext3_find_goal:
when we create a file,write initial 4k bytes to it,then we reboot the system,and after that,we again append another 4k bytes to the file,thus the file becomes 8k bytes now;but under this condition,the file will be in 2 chunks,not continous.

I did simple tests(i reboot the system to make sure that the inode cache get outdated between the 2 write/append operations,and i am sure that under some VM pressure result will be the same--ext3_read_inode clear ei->i_next_alloc_block to zero):

#dd if=/dev/zero of=/root/4kfile bs=1024 count=4
#cp /root/4kfile tmpfile
# ll tmpfile 
-rw-r--r--  1 root root 4096 Dec 17 13:05 tmpfile
# filefrag tmpfile 
tmpfile: 1 extent found
------THEN I REBOOT THE LINUX SYSTEM----
#cat /root/4kfile >>tmpfile
# ll tmpfile 
-rw-r--r--  1 root root 8192 Dec 17 13:14 tmpfile
# filefrag tmpfile 
tmpfile: 2 extents found, perfection would be 1 extent

debugfs shows that there are free blocks just next to the block#0 of tmpfile.

Generally,continous creating/appending(without rebooting the system or VM pressure)a file get 1 extent.

Here are my simple patch for kernel 2.6.9,it works for me.

---2.6.9/fs/ext3/inode.c    2004-12-17 
+++2.6.9-ext3-find-goal-fixed/fs/ext3/inode.c     2004-12-17 
@@ -525,7 +525,7 @@
 {
        struct ext3_inode_info *ei = EXT3_I(inode);
        /* Writer: ->i_next_alloc* */
-       if (block == ei->i_next_alloc_block + 1) {
+       if ((block == ei->i_next_alloc_block + 1)&&(ei->i_next_alloc_goal!=0)) {
                ei->i_next_alloc_block++;
                ei->i_next_alloc_goal++;
        }

Regards.

Peter Wang
2004.11.29
