Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTEVPXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTEVPXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:23:13 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:38859 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S261960AbTEVPXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:23:06 -0400
Date: Thu, 22 May 2003 17:36:00 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sysfs variable size files, lost dget, ...
Message-ID: <20030522153600.GA15982@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030521145817.GA15960@ranty.ddts.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20030521145817.GA15960@ranty.ddts.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 21, 2003 at 04:58:17PM +0200, Manuel Estrada Sainz wrote:
>  Hi,
> 
>  While working on request_firmware() interface, I found some trouble
>  with sysfs and Greg said that you are the one to send this patches:
> 
>   - sysfs-bin-flexible-size.diff:
> 	Make dynamically sized files possible.  And return the right
> 	value on successful write.
> 
>   - sysfs-bin-lost-dget.diff:
> 	I was having trouble when calling request_firmware() from a work
> 	queue, and after a little investigations it seams that this dget
> 	got lost along the way. Adding it back fixed the issue.
> 	Or am I causing a dentry leak now?
> 
>   - sysfs-bin-header.diff:
> 	I guess that I am the first user of sysfs's binary interface :-)
> 
>  Thanks
> 
>  	Manuel

 You can ignore those patches, the dynamic size stuff would fail badly
 when handling more than PAGE_SIZE data :-(

 Updated patches attached.

 Thanks

 	Manuel


-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sysfs-bin-flexible-size.diff"

diff --exclude=CVS -urN linux-2.5.orig/fs/sysfs/bin.c linux-2.5.mine/fs/sysfs/bin.c
--- linux-2.5.orig/fs/sysfs/bin.c	2003-05-17 20:44:03.000000000 +0200
+++ linux-2.5.mine/fs/sysfs/bin.c	2003-05-22 16:52:42.000000000 +0200
@@ -30,10 +30,15 @@
 	loff_t offs = *off;
 	int ret;
 
-	if (offs > size)
-		return 0;
-	if (offs + count > size)
-		count = size - offs;
+	if (count > PAGE_SIZE)
+		count = PAGE_SIZE;
+
+	if (size) {
+		if (offs > size)
+			return 0;
+		if (offs + count > size)
+			count = size - offs;
+	}
 
 	ret = fill_read(dentry, buffer, offs, count);
 	if (ret < 0) 
@@ -41,7 +46,7 @@
 	count = ret;
 
 	ret = -EFAULT;
-	if (copy_to_user(userbuf, buffer + offs, count) != 0)
+	if (copy_to_user(userbuf, buffer, count) != 0)
 		goto Done;
 
 	*off = offs + count;
@@ -69,19 +74,23 @@
 	loff_t offs = *off;
 	int ret;
 
-	if (offs > size)
-		return 0;
-	if (offs + count > size)
-		count = size - offs;
+	if (count > PAGE_SIZE)
+		count = PAGE_SIZE;
+	if (size) {
+		if (offs > size)
+			return 0;
+		if (offs + count > size)
+			count = size - offs;
+	}
 
 	ret = -EFAULT;
-	if (copy_from_user(buffer + offs, userbuf, count))
+	if (copy_from_user(buffer, userbuf, count))
 		goto Done;
 
 	count = flush_write(dentry, buffer, offs, count);
 	if (count > 0)
 		*off = offs + count;
-	ret = 0;
+	ret = count;
  Done:
 	return ret;
 }
@@ -102,7 +111,7 @@
 		goto Done;
 
 	error = -ENOMEM;
-	file->private_data = kmalloc(attr->size, GFP_KERNEL);
+	file->private_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!file->private_data)
 		goto Done;
 

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sysfs-bin-header.diff"

diff --exclude=CVS -urN linux-2.5.orig/include/linux/sysfs.h linux-2.5.mine/include/linux/sysfs.h
--- linux-2.5.orig/include/linux/sysfs.h	2003-05-21 17:38:39.000000000 +0200
+++ linux-2.5.mine/include/linux/sysfs.h	2003-05-21 10:22:08.000000000 +0200
@@ -23,6 +23,9 @@
 	ssize_t (*write)(struct kobject *, char *, loff_t, size_t);
 };
 
+int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);
+int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr);
+
 struct sysfs_ops {
 	ssize_t	(*show)(struct kobject *, struct attribute *,char *);
 	ssize_t	(*store)(struct kobject *,struct attribute *,const char *, size_t);

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sysfs-bin-lost-dget.diff"

diff --exclude=CVS -urN linux-2.5.orig/fs/sysfs/inode.c linux-2.5.mine/fs/sysfs/inode.c
--- linux-2.5.orig/fs/sysfs/inode.c	2003-05-17 20:44:03.000000000 +0200
+++ linux-2.5.mine/fs/sysfs/inode.c	2003-05-22 16:53:59.000000000 +0200
@@ -60,9 +60,10 @@
  Proceed:
 	if (init)
 		error = init(inode);
-	if (!error)
+	if (!error) {
 		d_instantiate(dentry, inode);
-	else
+		dget(dentry); /* Extra count - pin the dentry in core */
+	} else
 		iput(inode);
  Done:
 	return error;

--vkogqOf2sHV7VnPd--
