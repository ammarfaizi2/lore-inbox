Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271346AbTHHNmQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 09:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271351AbTHHNmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 09:42:15 -0400
Received: from angband.namesys.com ([212.16.7.85]:26301 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S271346AbTHHNmN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 09:42:13 -0400
Date: Fri, 8 Aug 2003 17:42:11 +0400
From: Oleg Drokin <green@namesys.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [2.5] reiserfs: Fix handling of some extended inode attributes
Message-ID: <20030808134211.GA10853@namesys.com>
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
   the bit now). Also misleading comment in reiserfs_fs.h is removed.
   Please apply.

Bye,
    Oleg

===== fs/reiserfs/inode.c 1.79 vs edited =====
--- 1.79/fs/reiserfs/inode.c	Fri Jul 11 09:22:55 2003
+++ edited/fs/reiserfs/inode.c	Wed Aug  6 18:14:02 2003
@@ -2236,6 +2236,10 @@
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
===== fs/reiserfs/ioctl.c 1.11 vs edited =====
--- 1.11/fs/reiserfs/ioctl.c	Mon May 26 01:07:50 2003
+++ edited/fs/reiserfs/ioctl.c	Wed Aug  6 18:13:53 2003
@@ -47,7 +47,7 @@
 		if (get_user(flags, (int *) arg))
 			return -EFAULT;
 
-		if ( ( flags & REISERFS_IMMUTABLE_FL ) && 
+		if ( ( ( flags ^ REISERFS_I(inode) -> i_attrs) & ( REISERFS_IMMUTABLE_FL | REISERFS_APPEND_FL)) && 
 		     !capable( CAP_LINUX_IMMUTABLE ) )
 			return -EPERM;
 			
===== include/linux/reiserfs_fs.h 1.50 vs edited =====
--- 1.50/include/linux/reiserfs_fs.h	Fri Jul 11 09:22:55 2003
+++ edited/include/linux/reiserfs_fs.h	Wed Aug  6 20:07:30 2003
@@ -879,19 +879,14 @@
 /* we want common flags to have the same values as in ext2,
    so chattr(1) will work without problems */
 #define REISERFS_IMMUTABLE_FL EXT2_IMMUTABLE_FL
+#define REISERFS_APPEND_FL    EXT2_APPEND_FL
 #define REISERFS_SYNC_FL      EXT2_SYNC_FL
 #define REISERFS_NOATIME_FL   EXT2_NOATIME_FL
 #define REISERFS_NODUMP_FL    EXT2_NODUMP_FL
 #define REISERFS_SECRM_FL     EXT2_SECRM_FL
 #define REISERFS_UNRM_FL      EXT2_UNRM_FL
 #define REISERFS_COMPR_FL     EXT2_COMPR_FL
-/* persistent flag to disable tails on per-file basic.
-   Note, that is inheritable: mark directory with this and
-   all new files inside will not have tails. 
-
-   Teodore Tso allocated EXT2_NODUMP_FL (0x00008000) for this. Change
-   numeric constant to ext2 macro when available. */
-#define REISERFS_NOTAIL_FL    (0x00008000) /* EXT2_NOTAIL_FL */
+#define REISERFS_NOTAIL_FL    EXT2_NOTAIL_FL
 
 /* persistent flags that file inherits from the parent directory */
 #define REISERFS_INHERIT_MASK ( REISERFS_IMMUTABLE_FL |	\
