Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269676AbUIRXhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269676AbUIRXhc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 19:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269683AbUIRXdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 19:33:18 -0400
Received: from cantor.suse.de ([195.135.220.2]:34467 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269682AbUIRXai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 19:30:38 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: James Morris <jmorris@redhat.com>
Subject: Re: [PATCH 1/6] xattr consolidation v2 - generic xattr API
Date: Sun, 19 Sep 2004 01:31:01 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>
References: <Xine.LNX.4.44.0409180305300.10905-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0409180305300.10905-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409190131.01625.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the patches look good except for a theoretical race in generic_listxattr:

> +ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t
> buffer_size) +{
> +	struct inode *inode = dentry->d_inode;
> +	struct xattr_handler *handler, **handlers = inode->i_sb->s_xattr;
> +	unsigned int size = 0;
> +	char *buf;
> +
> +	for_each_xattr_handler(handlers, handler)
> +		size += handler->list(inode, NULL, NULL, 0);

We might setxattr here and the name list might change between the two passes.

> [...]
> +	for_each_xattr_handler(handlers, handler)
> +		buf += handler->list(inode, buf, NULL, 0);
> +
> +	return size;
> +}

This currently is only relevant for the security attribute. Selinux always 
returns the same attribute name so it can't trigger this problem, but other 
LSMs might do something different.

We can add a list_size parameter to xattr_handler->list to get this fixed. We 
should change the name_len parameter of xattr_handler->list from int to 
size_t:

Index: linux-2.6.9-rc1/include/linux/xattr.h
===================================================================
--- linux-2.6.9-rc1.orig/include/linux/xattr.h
+++ linux-2.6.9-rc1/include/linux/xattr.h
@@ -17,8 +17,8 @@
 
 struct xattr_handler {
 	char *prefix;
-	size_t (*list)(struct inode *inode, char *list, const char *name,
-		       int name_len);
+	size_t (*list)(struct inode *inode, char *list, size_t list_size,
+		       const char *name, size_t name_len);
 	int (*get)(struct inode *inode, const char *name, void *buffer,
 		   size_t size);
 	int (*set)(struct inode *inode, const char *name, const void *buffer,
Index: linux-2.6.9-rc1/fs/xattr.c
===================================================================
--- linux-2.6.9-rc1.orig/fs/xattr.c
+++ linux-2.6.9-rc1/fs/xattr.c
@@ -397,23 +397,22 @@ ssize_t generic_listxattr(struct dentry 
 	struct inode *inode = dentry->d_inode;
 	struct xattr_handler *handler, **handlers = inode->i_sb->s_xattr;
 	unsigned int size = 0;
-	char *buf;
-
-	for_each_xattr_handler(handlers, handler)
-		size += handler->list(inode, NULL, NULL, 0);
-
-	if (!buffer)
-		return size;
-		
-	if (size > buffer_size)
-		return -ERANGE;
-
-	buf = buffer;
-	handlers = inode->i_sb->s_xattr;
-	
-	for_each_xattr_handler(handlers, handler)
-		buf += handler->list(inode, buf, NULL, 0);
 
+	if (!buffer) {
+		for_each_xattr_handler(handlers, handler)
+			size += handler->list(inode, NULL, 0, NULL, 0);
+	} else {
+		char *buf = buffer;
+
+		for_each_xattr_handler(handlers, handler) {
+			size = handler->list(inode, buf, buffer_size, NULL, 0);
+			if (size > buffer_size)
+				return -ERANGE;
+			buf += size;
+			buffer_size -= size;
+		}
+		size = buf - buffer;
+	}
 	return size;
 }

The current users can easily be converted. As a side effect, the 
ext2_xattr_list() and ext3_xattr_list() functions could also be changed to do 
a single iteration only.

I also noticed that your additions to fs/xattr.c use a slightly different 
coding style than the rest of the file. You might want to change that as 
well.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG
