Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWFHUvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWFHUvk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWFHUvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:51:40 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:28436 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965005AbWFHUvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:51:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KBOqPdAWAsmSLX9VctU1ZyQ8InxRTRCIIprK8XA7fbh1J02nXXlnGtXT4Z35CroEwl63SuL7dnEybZlRMxeVAwBLwLWyC9YkiLLMFfe/ZJ3C2W9b6I5Vf8pC7gRye+aU67ohFXVzf4W6/x0efh1+HPaS4VhkkuoYN08VWzqpzLs=
Message-ID: <69a7202e0606081351i1ec473f7jd608397282c983da@mail.gmail.com>
Date: Thu, 8 Jun 2006 16:51:38 -0400
From: "Carl Spalletta" <cspalletta@gmail.com>
Reply-To: cspalletta@adelphia.net
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] vfs: support for COW files in sys_open: filesystem changes
Cc: viro@zeniv.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giving the O_COW flag to open() will return a special error, if
IS_COW(inode) and write permissions are expressed or implied.  COW-aware
applications may set this flag and deal with this error according to
some user defined policy.  This will not change the semantics of any
existing application or affect any kernel user of open_namei(); nor does
it affect future applications unless they use O_COW.  Filesystem level
code is unimplemented except for an ext2 example.

Signed-off-by: Carl Spalletta <cspalletta@gmail.com>
---

 include/linux/ext2_fs.h     |    1 +
 fs/ext2/inode.c             |    2 ++
 2 files changed, 3 insertions(+)

--- a/include/linux/ext2_fs.h   2006-06-07 11:19:11.000000000 -0400
+++ b/include/linux/ext2_fs.h   2006-06-06 13:26:38.000000000 -0400
@@ -192,6 +192,7 @@ struct ext2_group_desc
 #define EXT2_NOTAIL_FL                 0x00008000 /* file tail should
not be merged */
 #define EXT2_DIRSYNC_FL                        0x00010000 /* dirsync
behaviour (directories only) */
 #define EXT2_TOPDIR_FL                 0x00020000 /* Top of directory
hierarchies*/
+#define EXT2_COW_FL                    0x00040000 /* Hint to
COW-aware applications */
 #define EXT2_RESERVED_FL               0x80000000 /* reserved for ext2 lib */

 #define EXT2_FL_USER_VISIBLE           0x0003DFFF /* User visible flags */
--- a/fs/ext2/inode.c   2006-06-07 11:19:12.000000000 -0400
+++ b/fs/ext2/inode.c   2006-06-06 13:32:28.000000000 -0400
@@ -1065,6 +1065,8 @@ void ext2_set_inode_flags(struct inode *
                inode->i_flags |= S_NOATIME;
        if (flags & EXT2_DIRSYNC_FL)
                inode->i_flags |= S_DIRSYNC;
+       if (flags & EXT2_COW_FL)
+               inode->i_flags |= S_COW;
 }

 void ext2_read_inode (struct inode * inode)
