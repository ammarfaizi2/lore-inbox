Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVAWUNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVAWUNa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 15:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVAWUN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 15:13:29 -0500
Received: from news.suse.de ([195.135.220.2]:28598 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261355AbVAWUNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 15:13:22 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Remove the number of acl entries limit
Date: Sun, 23 Jan 2005 21:13:18 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501232113.19046.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the arbitrary limit of 32 acl entries on ext[23] when
writing acls. A patch that removes the same check when reding acls is in
BK since 12 March 2004, so all kernels since then are already able to
read large acls. I think that ten+ months are enough so that we can now
also remove the write limit.

This is the read-limit patch:
http://linux.bkbits.net:8080/linux-2.6/cset%404051e2863UsuQEgAQShmimgBooAXkg?nav=index.html

Even without this patch the xattr block could already contain less space
than needed for the acl, because other attributes might already use up
almost all space. So this patch does not introduce additional error
conditions. We have been shipping with this patch the last year
(almost).

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-latest/fs/ext2/acl.c
===================================================================
--- linux-2.6.11-latest.orig/fs/ext2/acl.c
+++ linux-2.6.11-latest/fs/ext2/acl.c
@@ -255,8 +255,6 @@ ext2_set_acl(struct inode *inode, int ty
 			return -EINVAL;
 	}
  	if (acl) {
-		if (acl->a_count > EXT2_ACL_MAX_ENTRIES)
-			return -EINVAL;
 		value = ext2_acl_to_disk(acl, &size);
 		if (IS_ERR(value))
 			return (int)PTR_ERR(value);
Index: linux-2.6.11-latest/fs/ext2/acl.h
===================================================================
--- linux-2.6.11-latest.orig/fs/ext2/acl.h
+++ linux-2.6.11-latest/fs/ext2/acl.h
@@ -7,7 +7,6 @@
 #include <linux/xattr_acl.h>
 
 #define EXT2_ACL_VERSION	0x0001
-#define EXT2_ACL_MAX_ENTRIES	32
 
 typedef struct {
 	__le16		e_tag;
Index: linux-2.6.11-latest/fs/ext3/acl.c
===================================================================
--- linux-2.6.11-latest.orig/fs/ext3/acl.c
+++ linux-2.6.11-latest/fs/ext3/acl.c
@@ -259,8 +259,6 @@ ext3_set_acl(handle_t *handle, struct in
 			return -EINVAL;
 	}
  	if (acl) {
-		if (acl->a_count > EXT3_ACL_MAX_ENTRIES)
-			return -EINVAL;
 		value = ext3_acl_to_disk(acl, &size);
 		if (IS_ERR(value))
 			return (int)PTR_ERR(value);
Index: linux-2.6.11-latest/fs/ext3/acl.h
===================================================================
--- linux-2.6.11-latest.orig/fs/ext3/acl.h
+++ linux-2.6.11-latest/fs/ext3/acl.h
@@ -7,7 +7,6 @@
 #include <linux/xattr_acl.h>
 
 #define EXT3_ACL_VERSION	0x0001
-#define EXT3_ACL_MAX_ENTRIES	32
 
 typedef struct {
 	__le16		e_tag;


Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
