Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261759AbSI2Tsb>; Sun, 29 Sep 2002 15:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261761AbSI2TsO>; Sun, 29 Sep 2002 15:48:14 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:2321 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S261759AbSI2Tqk>; Sun, 29 Sep 2002 15:46:40 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove fat_search_long() in vfat_add_entry()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 30 Sep 2002 04:52:00 +0900
Message-ID: <87r8fck1zz.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch removes the fat_search_long() in the vfat_add_entry(). This
path is already checked by the vfs layer whether file/directory
exists. So, we don't need the fat_search_long() in vfat_add_entry().


The following is the result of created the 1000 files,

2.5.39
root@devron (a)[1007]# time ../../create

real    0m2.761s
user    0m0.006s
sys     0m2.752s
root@devron (a)[1008]#

2.5.39 + patch
root@devron (a)[1007]# time ../../create

real    0m1.601s
user    0m0.008s
sys     0m1.575s
root@devron (a)[1008]#

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

--- linux-2.5/fs/vfat/namei.c~	2002-09-29 16:44:00.000000000 +0900
+++ linux-2.5/fs/vfat/namei.c	2002-09-29 17:36:08.000000000 +0900
@@ -890,7 +890,6 @@ static int vfat_add_entry(struct inode *
 	struct msdos_dir_entry *dummy_de;
 	struct buffer_head *dummy_bh;
 	int dummy_ino;
-	loff_t dummy;
 
 	dir_slots = (struct msdos_dir_slot *)
 	       kmalloc(sizeof(struct msdos_dir_slot) * MSDOS_SLOTS, GFP_KERNEL);
@@ -900,15 +899,6 @@ static int vfat_add_entry(struct inode *
 	len = qname->len;
 	while (len && qname->name[len-1] == '.')
 		len--;
-	res = fat_search_long(dir, qname->name, len,
-			      (MSDOS_SB(sb)->options.name_check != 's')
-			      || !MSDOS_SB(sb)->options.posixfs,
-			      &dummy, &dummy);
-	if (res > 0) /* found */
-		res = -EEXIST;
-	if (res)
-		goto cleanup;
-
 	res = vfat_build_slots(dir, qname->name, len,
 			       dir_slots, &slots, is_dir);
 	if (res < 0)
