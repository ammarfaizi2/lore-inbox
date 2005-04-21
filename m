Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVDUBI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVDUBI6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 21:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVDUBI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 21:08:57 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:64708 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261164AbVDUBIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 21:08:18 -0400
Date: Thu, 21 Apr 2005 03:08:17 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] squashfs: kmalloc (less stack, less casts)
Message-ID: <20050421010817.GB29755@wohnheim.fh-wedel.de>
References: <20050420065500.GA24213@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050420065500.GA24213@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jörn

-- 
Rules of Optimization:
Rule 1: Don't do it.
Rule 2 (for experts only): Don't do it yet.
-- M.A. Jackson 


Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 fs/squashfs/inode.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

--- linux-2.6.12-rc2cow/fs/squashfs/inode.c~squashfs_cu2	2005-04-20 08:11:10.000000000 +0200
+++ linux-2.6.12-rc2cow/fs/squashfs/inode.c	2005-04-20 16:34:43.619956672 +0200
@@ -1453,11 +1453,14 @@ static int squashfs_readdir(struct file 
 		next_offset = SQUASHFS_I(i)->offset, length = 0, dirs_read = 0,
 		dir_count;
 	squashfs_dir_header dirh;
-	char buffer[sizeof(squashfs_dir_entry) + SQUASHFS_NAME_LEN + 1];
-	squashfs_dir_entry *dire = (squashfs_dir_entry *) buffer;
+	squashfs_dir_entry *dire;
 
 	TRACE("Entered squashfs_readdir [%x:%x]\n", next_block, next_offset);
 
+	dire = kmalloc(sizeof(*dire) + SQUASHFS_NAME_LEN + 1, GFP_KERNEL);
+	if (!dire)
+		return -ENOMEM;
+
 	length = get_dir_index_using_offset(i->i_sb, &next_block, &next_offset,
 				SQUASHFS_I(i)->u.s2.directory_index_start,
 				SQUASHFS_I(i)->u.s2.directory_index_offset,
@@ -1533,6 +1536,7 @@ static int squashfs_readdir(struct file 
 					squashfs_filetype_table[dire->type])
 					< 0) {
 				TRACE("Filldir returned less than 0\n");
+				kfree(dire);
 				return dirs_read;
 			}
 			file->f_pos = length;
@@ -1540,11 +1544,13 @@ static int squashfs_readdir(struct file 
 		}
 	}
 
+	kfree(dire);
 	return dirs_read;
 
 failed_read:
 	ERROR("Unable to read directory block [%x:%x]\n", next_block,
 		next_offset);
+	kfree(dire);
 	return 0;
 }
 
@@ -1562,12 +1568,15 @@ static struct dentry *squashfs_lookup(st
 				next_offset = SQUASHFS_I(i)->offset, length = 0,
 				dir_count;
 	squashfs_dir_header dirh;
-	char buffer[sizeof(squashfs_dir_entry) + SQUASHFS_NAME_LEN];
-	squashfs_dir_entry *dire = (squashfs_dir_entry *) buffer;
+	squashfs_dir_entry *dire;
 	int sorted = sBlk->s_major == 2 && sBlk->s_minor >= 1;
 
 	TRACE("Entered squashfs_lookup [%x:%x]\n", next_block, next_offset);
 
+	dire = kmalloc(sizeof(*dire) + SQUASHFS_NAME_LEN + 1, GFP_KERNEL);
+	if (!dire)
+		return ERR_PTR(-ENOMEM);
+
 	length = get_dir_index_using_name(i->i_sb, &next_block, &next_offset,
 				SQUASHFS_I(i)->u.s2.directory_index_start,
 				SQUASHFS_I(i)->u.s2.directory_index_offset,
@@ -1645,7 +1654,8 @@ static struct dentry *squashfs_lookup(st
 
 exit_loop:
 	d_add(dentry, inode);
-	return ERR_PTR(0);
+	kfree(dire);
+	return NULL;
 
 failed_read:
 	ERROR("Unable to read directory block [%x:%x]\n", next_block,
