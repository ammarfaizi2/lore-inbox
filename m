Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVAYVfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVAYVfy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVAYVdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:33:50 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:9669 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262169AbVAYVaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:30:18 -0500
Date: Tue, 25 Jan 2005 16:29:47 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [ANNOUNCE] inotify 0.18
In-reply-to: <20050125200100.GC8859@parcelfarce.linux.theplanet.co.uk>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, rml@novell.com, akpm@osdl.org,
       bkonrath@redhat.com, greg@kroah.com
Message-id: <41F6BA4B.2000303@sun.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_6bHYzk4JEwolaAZxWI/2dQ)"
X-Accept-Language: en-us, en
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <1106682112.23615.3.camel@vertex>
 <20050125200100.GC8859@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_6bHYzk4JEwolaAZxWI/2dQ)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Al Viro wrote:
> +static struct inode * find_inode(const char __user *dirname)
> +{
> +	struct inode *inode;
> +	struct nameidata nd;
> +	int error;
> +
> +	error = __user_walk(dirname, LOOKUP_FOLLOW, &nd);
> +	if (error)
> +		return ERR_PTR(error);
> +
> +	inode = nd.dentry->d_inode;
> +
> +	/* you can only watch an inode if you have read permissions on it */
> +	error = permission(inode, MAY_READ, NULL);
> +	if (error) {
> +		inode = ERR_PTR(error);
> +		goto release_and_out;
> +	}
> +
> +	spin_lock(&inode_lock);
> +	__iget(inode);
> +	spin_unlock(&inode_lock);
> +release_and_out:
> +	path_release(&nd);
> +	return inode;
> +}
> 
> Yawn...  OK, so what happens if we get umount in the middle of your
> find_inode(), so that path_release() in there drops the last remaining
> reference to vfsmount (and superblock)?

How about inotify hold on to the nameidata until it is sure to have
updated the watches?  That way, the inode will be seen by
inotify_super_block_umount when called by generic_shutdown_super.

There remains a small race though, in that the inotify ioctl may return
success for an added watch after the umount, but this would have to be
resolved by synchronizing in userspace anyway.

Incremental patch attached.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9rpKdQs4kOxk3/MRAl0RAJ9vssocI3P93AnfO+zwyhf/BX1V9wCffy9N
r6t7TV0ZxpT3bT5pcYfpCHk=
=RmBk
-----END PGP SIGNATURE-----

--Boundary_(ID_6bHYzk4JEwolaAZxWI/2dQ)
Content-type: text/x-patch; name=fix_find_inode.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=fix_find_inode.patch

Hold on to the nameidata of the watched file until we have successfully 
added/updated the watch on the inode.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>

---

 inotify.c |   48 ++++++++++++++++++++++++++----------------------
 1 files changed, 26 insertions(+), 22 deletions(-)

Index: linux-2.6.10/drivers/char/inotify.c
===================================================================
--- linux-2.6.10.orig/drivers/char/inotify.c	2005-01-25 15:47:15.000000000 -0500
+++ linux-2.6.10/drivers/char/inotify.c	2005-01-25 16:25:11.151174408 -0500
@@ -181,33 +181,24 @@ static inline void put_inode_data(struct
 }
 
 /*
- * find_inode - resolve a user-given path to a specific inode and iget() it
+ * find_inode - resolve a user-given path to a specific inode and return a nd
  */
-static struct inode * find_inode(const char __user *dirname)
+static int find_inode(const char __user *dirname, struct nameidata *nd)
 {
-	struct inode *inode;
-	struct nameidata nd;
 	int error;
 
-	error = __user_walk(dirname, LOOKUP_FOLLOW, &nd);
+	error = __user_walk(dirname, LOOKUP_FOLLOW, nd);
 	if (error)
-		return ERR_PTR(error);
-
-	inode = nd.dentry->d_inode;
+		return error;
 
 	/* you can only watch an inode if you have read permissions on it */
-	error = permission(inode, MAY_READ, NULL);
+	error = permission(nd->dentry->d_inode, MAY_READ, NULL);
 	if (error) {
-		inode = ERR_PTR(error);
 		goto release_and_out;
 	}
 
-	spin_lock(&inode_lock);
-	__iget(inode);
-	spin_unlock(&inode_lock);
 release_and_out:
-	path_release(&nd);
-	return inode;
+	return error;
 }
 
 struct inotify_kernel_event * kernel_event(s32 wd, u32 mask, u32 cookie,
@@ -911,11 +902,15 @@ static int inotify_add_watch(struct inot
 {
 	struct inode *inode;
 	struct inotify_watch *watch;
+	struct nameidata nd;
 	int ret;
 
-	inode = find_inode((const char __user*) request->dirname);
-	if (IS_ERR(inode))
-		return PTR_ERR(inode);
+	ret = find_inode((const char __user*) request->dirname, &nd);
+	if (ret)
+		return ret;
+
+	/* Held in place by references in nd */
+	inode = nd.dentry->d_inode;
 
 	spin_lock(&dev->lock);
 
@@ -930,7 +925,7 @@ static int inotify_add_watch(struct inot
 		owatch->mask = request->mask;
 		inode_update_watch_mask(inode);
 		spin_unlock(&dev->lock);
-		iput(inode);
+		path_release(&nd);
 
 		return owatch->wd;
 	}
@@ -939,7 +934,7 @@ static int inotify_add_watch(struct inot
 
 	watch = create_watch(dev, request->mask, inode);
 	if (!watch) {
-		iput(inode);
+		path_release(&nd);
 		return -ENOSPC;
 	}
 
@@ -949,7 +944,7 @@ static int inotify_add_watch(struct inot
 	if (inotify_dev_add_watch(dev, watch)) {
 		delete_watch(dev, watch);
 		spin_unlock(&dev->lock);
-		iput(inode);
+		path_release(&nd);
 		return -EINVAL;
 	}
 
@@ -958,12 +953,21 @@ static int inotify_add_watch(struct inot
 		list_del_init(&watch->d_list);
 		delete_watch(dev, watch);
 		spin_unlock(&dev->lock);
-		iput(inode);
+		path_release(&nd);
 		return ret;
 	}
 
 	spin_unlock(&dev->lock);
 
+	/*
+	 * demote the references in nd to a reference to inode held
+	 * by the watch.
+	 */
+	spin_lock(&inode_lock);
+	__iget(inode);
+	spin_unlock(&inode_lock);
+	path_release(&nd);
+
 	return watch->wd;
 }
 

--Boundary_(ID_6bHYzk4JEwolaAZxWI/2dQ)--
