Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVAMKvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVAMKvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 05:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVAMKvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 05:51:54 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:63894 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261569AbVAMKky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:40:54 -0500
Date: Thu, 13 Jan 2005 11:31:43 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Tridgell <tridge@samba.org>
Subject: [RESEND][PATCH 6/9] Ext3: extended attribute sharing fixes and in-inode EAs
Message-Id: <1105549936.907251@suse.de>
References: <1105549936.694778@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ext[23]: no spare xattr handler slots needed

The ext3_xattr_set_handle2 and ext3_xattr_delete_inode functions contain
duplicate code to decrease the reference count of an xattr block. Move
this to a separate function.

Also we know we have exclusive access to the inode in
ext3_xattr_delete_inode; there is no need to grab the xattr_sem lock.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.10/fs/ext3/xattr.c
===================================================================
--- linux-2.6.10.orig/fs/ext3/xattr.c
+++ linux-2.6.10/fs/ext3/xattr.c
@@ -102,7 +102,7 @@ static void ext3_xattr_rehash(struct ext
 
 static struct mb_cache *ext3_xattr_cache;
 
-static struct xattr_handler *ext3_xattr_handler_map[EXT3_XATTR_INDEX_MAX] = {
+static struct xattr_handler *ext3_xattr_handler_map[] = {
 	[EXT3_XATTR_INDEX_USER]		     = &ext3_xattr_user_handler,
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
 	[EXT3_XATTR_INDEX_POSIX_ACL_ACCESS]  = &ext3_xattr_acl_access_handler,
@@ -132,7 +132,7 @@ ext3_xattr_handler(int name_index)
 {
 	struct xattr_handler *handler = NULL;
 
-	if (name_index > 0 && name_index <= EXT3_XATTR_INDEX_MAX)
+	if (name_index > 0 && name_index < ARRAY_SIZE(ext3_xattr_handler_map))
 		handler = ext3_xattr_handler_map[name_index];
 	return handler;
 }
Index: linux-2.6.10/fs/ext2/xattr.c
===================================================================
--- linux-2.6.10.orig/fs/ext2/xattr.c
+++ linux-2.6.10/fs/ext2/xattr.c
@@ -100,7 +100,7 @@ static void ext2_xattr_rehash(struct ext
 
 static struct mb_cache *ext2_xattr_cache;
 
-static struct xattr_handler *ext2_xattr_handler_map[EXT2_XATTR_INDEX_MAX] = {
+static struct xattr_handler *ext2_xattr_handler_map[] = {
 	[EXT2_XATTR_INDEX_USER]		     = &ext2_xattr_user_handler,
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
 	[EXT2_XATTR_INDEX_POSIX_ACL_ACCESS]  = &ext2_xattr_acl_access_handler,
@@ -130,7 +130,7 @@ ext2_xattr_handler(int name_index)
 {
 	struct xattr_handler *handler = NULL;
 
-	if (name_index > 0 && name_index <= EXT2_XATTR_INDEX_MAX)
+	if (name_index > 0 && name_index < ARRAY_SIZE(ext2_xattr_handler_map))
 		handler = ext2_xattr_handler_map[name_index];
 	return handler;
 }
Index: linux-2.6.10/fs/ext3/xattr.h
===================================================================
--- linux-2.6.10.orig/fs/ext3/xattr.h
+++ linux-2.6.10/fs/ext3/xattr.h
@@ -16,7 +16,6 @@
 #define EXT3_XATTR_REFCOUNT_MAX		1024
 
 /* Name indexes */
-#define EXT3_XATTR_INDEX_MAX			10
 #define EXT3_XATTR_INDEX_USER			1
 #define EXT3_XATTR_INDEX_POSIX_ACL_ACCESS	2
 #define EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT	3
Index: linux-2.6.10/fs/ext2/xattr.h
===================================================================
--- linux-2.6.10.orig/fs/ext2/xattr.h
+++ linux-2.6.10/fs/ext2/xattr.h
@@ -17,7 +17,6 @@
 #define EXT2_XATTR_REFCOUNT_MAX		1024
 
 /* Name indexes */
-#define EXT2_XATTR_INDEX_MAX			10
 #define EXT2_XATTR_INDEX_USER			1
 #define EXT2_XATTR_INDEX_POSIX_ACL_ACCESS	2
 #define EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT	3
--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

