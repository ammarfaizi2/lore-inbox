Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286615AbSATUqD>; Sun, 20 Jan 2002 15:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285073AbSATUpy>; Sun, 20 Jan 2002 15:45:54 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:22664 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S286615AbSATUpk>; Sun, 20 Jan 2002 15:45:40 -0500
Date: Sun, 20 Jan 2002 13:45:37 -0700
Message-Id: <200201202045.g0KKjbq13624@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: Tomasz Torcz <zdzichu@irc.pl>, linux-kernel@vger.kernel.org
Subject: Re: OOPS on 2.4.17 -18pre4 while mounting root (reiserfs, on LVM, devfs)
In-Reply-To: <3C471E5E.1090103@wanadoo.fr>
In-Reply-To: <20020117182758.GA736@irc.pl>
	<3C471E5E.1090103@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet writes:
> Tomasz Torcz wrote:
> 
> > VFS: Mounted root (reiserfs filesystem) readonly.
> > devfs: devfs_do_symlink(root): could not append to parent, err: -17
> > change_root: old root has d_count=2
> 
> try booting with devfs=nomount as devfs is not properly configured on 
> your system.

No, the problem is that he needs to apply the latest devfs patch. Some
of these problems have been fixed weeks ago. Grab devfs-patch-v199.7
and apply the appended patch as well. Let me know how it goes. I want
to release a new patch ASAP.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

diff -urN linux-2.5.3-pre2/fs/devfs/base.c linux/fs/devfs/base.c
--- linux-2.5.3-pre2/fs/devfs/base.c	Mon Jan 14 10:40:29 2002
+++ linux/fs/devfs/base.c	Sun Jan 20 12:09:55 2002
@@ -1,6 +1,6 @@
 /*  devfs (Device FileSystem) driver.
 
-    Copyright (C) 1998-2001  Richard Gooch
+    Copyright (C) 1998-2002  Richard Gooch
 
     This library is free software; you can redistribute it and/or
     modify it under the terms of the GNU Library General Public
@@ -604,6 +604,9 @@
     20020113   Richard Gooch <rgooch@atnf.csiro.au>
 	       Fixed (rare, old) race in <devfs_lookup>.
   v1.9
+    20020120   Richard Gooch <rgooch@atnf.csiro.au>
+	       Fixed deadlock bug in <devfs_d_revalidate_wait>.
+  v1.10
 */
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -636,7 +639,7 @@
 #include <asm/bitops.h>
 #include <asm/atomic.h>
 
-#define DEVFS_VERSION            "1.9 (20020113)"
+#define DEVFS_VERSION            "1.10 (20020120)"
 
 #define DEVFS_NAME "devfs"
 
@@ -2878,13 +2881,16 @@
     struct devfs_lookup_struct *lookup_info = dentry->d_fsdata;
     DECLARE_WAITQUEUE (wait, current);
 
-    if ( !dentry->d_inode && is_devfsd_or_child (fs_info) )
+    if ( is_devfsd_or_child (fs_info) )
     {
 	devfs_handle_t de = lookup_info->de;
 	struct inode *inode;
 
-	DPRINTK (DEBUG_I_LOOKUP, "(%s): dentry: %p de: %p by: \"%s\"\n",
-		 dentry->d_name.name, dentry, de, current->comm);
+	DPRINTK (DEBUG_I_LOOKUP,
+		 "(%s): dentry: %p inode: %p de: %p by: \"%s\"\n",
+		 dentry->d_name.name, dentry, dentry->d_inode, de,
+		 current->comm);
+	if (dentry->d_inode) return 1;
 	if (de == NULL)
 	{
 	    read_lock (&parent->u.dir.lock);
