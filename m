Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271329AbTHHNel (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 09:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271341AbTHHNel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 09:34:41 -0400
Received: from angband.namesys.com ([212.16.7.85]:23485 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S271329AbTHHNei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 09:34:38 -0400
Date: Fri, 8 Aug 2003 17:34:36 +0400
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [BK] [2.4] reiserfs: fix some issues with extended inode attributes
Message-ID: <20030808133436.GA10733@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   This patch fixes a problem in reiserfs' handling of immutable attribute,
   where every user (not just root) can unset it. Also it adds "append-only"
   attribute "support" (all the support is in VFS anyway, we only recognise
   the bit now). Also it fixes incorrect comment in reiserfs_fs.h file, in fact
   we do support 't' attribute as "do not pack tail", not 'd' attribute
   as stated in the comment.
   Please pull from bk://namesys.com/bk/reiser3-linux-2.4-attrs-immut-append

Diffstat:
 fs/reiserfs/inode.c         |    4 ++++
 fs/reiserfs/ioctl.c         |    2 +-
 include/linux/reiserfs_fs.h |    3 ++-
 3 files changed, 7 insertions(+), 2 deletions(-)

Plain text patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1064  -> 1.1065 
#	 fs/reiserfs/inode.c	1.48    -> 1.49   
#	 fs/reiserfs/ioctl.c	1.6     -> 1.7    
#	include/linux/reiserfs_fs.h	1.30    -> 1.31   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/08	green@angband.namesys.com	1.1065
# reiserfs: Add support for 'append-only' attribute, fix 'immutable' attribute handling, fix misleading comment
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Fri Aug  8 17:27:11 2003
+++ b/fs/reiserfs/inode.c	Fri Aug  8 17:27:11 2003
@@ -2181,6 +2181,10 @@
 			inode -> i_flags |= S_IMMUTABLE;
 		else
 			inode -> i_flags &= ~S_IMMUTABLE;
+		if( sd_attrs & REISERFS_APPEND_FL )
+			inode -> i_flags |= S_APPEND;
+		else
+			inode -> i_flags &= ~S_APPEND;
 		if( sd_attrs & REISERFS_NOATIME_FL )
 			inode -> i_flags |= S_NOATIME;
 		else
diff -Nru a/fs/reiserfs/ioctl.c b/fs/reiserfs/ioctl.c
--- a/fs/reiserfs/ioctl.c	Fri Aug  8 17:27:11 2003
+++ b/fs/reiserfs/ioctl.c	Fri Aug  8 17:27:11 2003
@@ -51,7 +51,7 @@
 		if (get_user(flags, (int *) arg))
 			return -EFAULT;
 
-		if ( ( flags & REISERFS_IMMUTABLE_FL ) && 
+		if ( ( ( flags ^ inode->u.reiserfs_i.i_attrs) & ( REISERFS_IMMUTABLE_FL | REISERFS_APPEND_FL)) && 
 		     !capable( CAP_LINUX_IMMUTABLE ) )
 			return -EPERM;
 			
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Fri Aug  8 17:27:11 2003
+++ b/include/linux/reiserfs_fs.h	Fri Aug  8 17:27:11 2003
@@ -867,6 +867,7 @@
 /* we want common flags to have the same values as in ext2,
    so chattr(1) will work without problems */
 #define REISERFS_IMMUTABLE_FL EXT2_IMMUTABLE_FL
+#define REISERFS_APPEND_FL    EXT2_APPEND_FL
 #define REISERFS_SYNC_FL      EXT2_SYNC_FL
 #define REISERFS_NOATIME_FL   EXT2_NOATIME_FL
 #define REISERFS_NODUMP_FL    EXT2_NODUMP_FL
@@ -877,7 +878,7 @@
    Note, that is inheritable: mark directory with this and
    all new files inside will not have tails. 
 
-   Teodore Tso allocated EXT2_NODUMP_FL (0x00008000) for this. Change
+   Teodore Tso allocated EXT2_NOTAIL_FL (0x00008000) for this. Change
    numeric constant to ext2 macro when available. */
 #define REISERFS_NOTAIL_FL    (0x00008000) /* EXT2_NOTAIL_FL */
 
