Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315239AbSFJNv5>; Mon, 10 Jun 2002 09:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315257AbSFJNvO>; Mon, 10 Jun 2002 09:51:14 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:26496 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S315266AbSFJNuU>;
	Mon, 10 Jun 2002 09:50:20 -0400
Date: Mon, 10 Jun 2002 17:42:55 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200206101342.g5ADgtq6003842@bitshadow.namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.5] reiserfs changeset 1 of 15 for 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a changeset 1 out of 15.

You can pull it from bk://namesys.com/bk/reiser3-linux-2.5
Or use plain text patch at the end of this message.

   It fixes reiserfs tail and direntry alignment bug on filesystems converted
   from 3.5.x to 3.6.x.

Chris Mason spent a lot of efforts in helping to convert this changeset to
Linus-compatible form.

Diffstat:
 namei.c           |    2 +-
 tail_conversion.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Plaintext patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.594   -> 1.595  
#	 fs/reiserfs/namei.c	1.36    -> 1.37   
#	fs/reiserfs/tail_conversion.c	1.21    -> 1.22   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/30	green@angband.namesys.com	1.595
# tail_conversion.c, namei.c:
#   fix reiserfs tail and direntry alignment bug on filesystems converted from 3.5.x to 3.6.x.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c	Thu May 30 18:42:15 2002
+++ b/fs/reiserfs/namei.c	Thu May 30 18:42:15 2002
@@ -463,7 +463,7 @@
     } else
 	buffer = small_buf;
 
-    paste_size = (old_format_only (dir->i_sb)) ? (DEH_SIZE + namelen) : buflen;
+    paste_size = (get_inode_sd_version (dir) == STAT_DATA_V1) ? (DEH_SIZE + namelen) : buflen;
 
     /* fill buffer : directory entry head, name[, dir objectid | , stat data | ,stat data, dir objectid ] */
     deh = (struct reiserfs_de_head *)buffer;
diff -Nru a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
--- a/fs/reiserfs/tail_conversion.c	Thu May 30 18:42:15 2002
+++ b/fs/reiserfs/tail_conversion.c	Thu May 30 18:42:15 2002
@@ -214,7 +214,7 @@
     copy_item_head (&s_ih, PATH_PITEM_HEAD(p_s_path));
 
     tail_len = (n_new_file_size & (n_block_size - 1));
-    if (!old_format_only (p_s_sb))
+    if (get_inode_sd_version (p_s_inode) == STAT_DATA_V2)
 	round_tail_len = ROUND_UP (tail_len);
     else
 	round_tail_len = tail_len;
