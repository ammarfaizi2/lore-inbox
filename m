Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261510AbSIZUZk>; Thu, 26 Sep 2002 16:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbSIZUZi>; Thu, 26 Sep 2002 16:25:38 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:19723 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261492AbSIZUYU>;
	Thu, 26 Sep 2002 16:24:20 -0400
Date: Thu, 26 Sep 2002 13:28:10 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20020926202809.GD6908@kroah.com>
References: <20020926202552.GA6908@kroah.com> <20020926202647.GB6908@kroah.com> <20020926202713.GC6908@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020926202713.GC6908@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Copied linux-fsdevel, as it touches the core fs code.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.613   -> 1.614  
#	          fs/inode.c	1.69    -> 1.70   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/26	sds@tislabs.com	1.614
# [PATCH] LSM: inode.c init modification
# 
# On Thu, 19 Sep 2002, Greg KH wrote:
# 
# > Yes, and explaining the fine points of inode_init() and
# > inode_alloc_security() and why they are different, might be a bit tough.
# >
# > {sigh}, well if there's no other way (and I can't think of one right
# > now), but I really don't like it...
# 
# Here's a patch that attempt to support the same functionality without
# inserting hooks into filesystem-specific code.  This patch permits the
# security module to perform initialization of the inode security state
# based on the superblock information, enabling SELinux to initialize
# pipe, devpts, and shm inodes without relying on inode_precondition to
# catch them on first use.
# 
# This is achieved simply by moving the initialization of inode->i_sb
# before the call to inode_alloc_security, enabling the
# inode_alloc_security hook function to perform the allocation and
# initialization for such inodes.  No new hooks are required.
# --------------------------------------------
#
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Thu Sep 26 13:23:52 2002
+++ b/fs/inode.c	Thu Sep 26 13:23:52 2002
@@ -101,6 +101,7 @@
 	if (inode) {
 		struct address_space * const mapping = &inode->i_data;
 
+		inode->i_sb = sb;
 		inode->i_security = NULL;
 		if (security_ops->inode_alloc_security(inode)) {
 			if (inode->i_sb->s_op->destroy_inode)
@@ -109,7 +110,6 @@
 				kmem_cache_free(inode_cachep, (inode));
 			return NULL;
 		}
-		inode->i_sb = sb;
 		inode->i_dev = sb->s_dev;
 		inode->i_blkbits = sb->s_blocksize_bits;
 		inode->i_flags = 0;
