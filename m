Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267483AbUIUDZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267483AbUIUDZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 23:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267490AbUIUDZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 23:25:27 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:16570 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267483AbUIUDZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 23:25:15 -0400
Message-ID: <8e6f9472040920202565041b61@mail.gmail.com>
Date: Mon, 20 Sep 2004 23:25:10 -0400
From: Will Dyson <will.dyson@gmail.com>
Reply-To: Will Dyson <will.dyson@gmail.com>
To: James Morris <jmorris@redhat.com>
Subject: Re: [PATCH 1/6] xattr consolidation v2 - generic xattr API
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Xine.LNX.4.44.0409201904220.23206-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <8e6f9472040920105013b4e0cd@mail.gmail.com>
	 <Xine.LNX.4.44.0409201904220.23206-100000@thoron.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2004 19:07:21 -0400 (EDT), James Morris
<jmorris@redhat.com> wrote:

> > For example:
> >
> > /*
> > In order to implement different sets of xattr operations for each
> > xattr prefix, a filesystem should create a null-terminated array of
> > struct xattr_handler (one for each prefix) and hang a pointer to it
> > off of the s_xattr field of the superblock. The generic_fooxattr
> > functions will search this list for a xattr_handler with a prefix
> > field that matches the prefix of the xattr we are dealing with and
> > call the apropriate function pointer from that xattr_handler.
> > */
> 
> The above is inaccurate.  e.g. not all of the generic functions search for
> a matching xattr handler.

Ok. You see the difficulty of documenting code that someone else
wrote.  Please consider the following:

--- xattr.c.old	2004-09-20 22:39:18.000000000 -0400
+++ xattr.c	2004-09-20 23:13:53.000000000 -0400
@@ -359,11 +359,24 @@
 	return *a_prefix ? NULL : a;
 }
 
+/*
+ * In order to implement different sets of xattr operations for each xattr
+ * prefix, a filesystem should create a null-terminated array of struct
+ * xattr_handler (one for each prefix) and hang a pointer to it off of the
+ * s_xattr field of the superblock.
+ *
+ * The generic_fooxattr() functions will use this list to dispatch xattr
+ * operations to the correct xattr_handler.
+ */
+
 #define for_each_xattr_handler(handlers, handler)		\
 		for ((handler) = *(handlers)++;			\
 			(handler) != NULL;			\
 			(handler) = *(handlers)++)	
 			
+/*
+ * Find the xattr_handler with the matching prefix
+ */
 static struct xattr_handler *xattr_resolve_name(struct xattr_handler
**handlers, const char **name)
 {
 	struct xattr_handler *handler;
@@ -381,6 +394,9 @@
 	return handler;
 }
 
+/*
+ * Find the handler for the prefix and dispatch the operation through it
+ */
 ssize_t generic_getxattr(struct dentry *dentry, const char *name,
void *buffer, size_t size)
 {
 	struct xattr_handler *handler;
@@ -392,6 +408,10 @@
 	return handler->get(inode, name, buffer, size);
 }
 
+/*
+ * Combine the results of the list() function from every xattr_handler in the
+ * list.
+ */
 ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t
buffer_size)
 {
 	struct inode *inode = dentry->d_inode;
@@ -417,6 +437,9 @@
 	return size;
 }
 
+/*
+ * Find the handler for the prefix and dispatch the operation through it
+ */
 int generic_setxattr(struct dentry *dentry, const char *name, const
void *value, size_t size, int flags)
 {
 	struct xattr_handler *handler;
@@ -430,6 +453,9 @@
 	return handler->set(inode, name, value, size, flags);
 }
 
+/*
+ * Find the handler for the prefix and dispatch the operation through it
+ */
 int generic_removexattr(struct dentry *dentry, const char *name)
 {
 	struct xattr_handler *handler;


-- 
Will Dyson - Consultant
http://www.lucidts.com/
