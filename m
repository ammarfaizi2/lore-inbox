Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbTEUR7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 13:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbTEUR7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 13:59:04 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:3496 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262234AbTEUR7A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 13:59:00 -0400
Date: Wed, 21 May 2003 16:58:17 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] sysfs variable size files, lost dget, ...
Message-ID: <20030521145817.GA15960@ranty.ddts.net>
Reply-To: ranty@debian.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 Hi,

 While working on request_firmware() interface, I found some trouble
 with sysfs and Greg said that you are the one to send this patches:

  - sysfs-bin-flexible-size.diff:
	Make dynamically sized files possible.  And return the right
	value on successful write.

  - sysfs-bin-lost-dget.diff:
	I was having trouble when calling request_firmware() from a work
	queue, and after a little investigations it seams that this dget
	got lost along the way. Adding it back fixed the issue.
	Or am I causing a dentry leak now?

  - sysfs-bin-header.diff:
	I guess that I am the first user of sysfs's binary interface :-)

 Thanks

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sysfs-bin-flexible-size.diff"

diff --exclude=CVS -urN linux-2.5.orig/fs/sysfs/bin.c linux-2.5.mine/fs/sysfs/bin.c
--- linux-2.5.orig/fs/sysfs/bin.c	2003-05-17 20:44:03.000000000 +0200
+++ linux-2.5.mine/fs/sysfs/bin.c	2003-05-17 14:53:01.000000000 +0200
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
+	if(size){
+		if (offs > size)
+			return 0;
+		if (offs + count > size)
+			count = size - offs;
+	}
 
 	ret = fill_read(dentry, buffer, offs, count);
 	if (ret < 0) 
@@ -69,10 +74,14 @@
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
 	if (copy_from_user(buffer + offs, userbuf, count))
@@ -81,7 +90,7 @@
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
 

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sysfs-bin-header.diff"

Index: include/linux/sysfs.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/linux/sysfs.h,v
retrieving revision 1.9
diff -u -r1.9 sysfs.h
--- include/linux/sysfs.h	15 May 2003 23:50:23 -0000	1.9
+++ include/linux/sysfs.h	21 May 2003 13:49:29 -0000
@@ -23,6 +23,9 @@
 	ssize_t (*write)(struct kobject *, char *, loff_t, size_t);
 };
 
+int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);
+int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr);
+
 struct sysfs_ops {
 	ssize_t	(*show)(struct kobject *, struct attribute *,char *);
 	ssize_t	(*store)(struct kobject *,struct attribute *,const char *, size_t);

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sysfs-bin-lost-dget.diff"

diff --exclude=CVS -urN linux-2.5.orig/fs/sysfs/inode.c linux-2.5.mine/fs/sysfs/inode.c
--- linux-2.5.orig/fs/sysfs/inode.c	2003-05-17 20:44:03.000000000 +0200
+++ linux-2.5.mine/fs/sysfs/inode.c	2003-05-17 20:30:34.000000000 +0200
@@ -60,9 +60,10 @@
  Proceed:
 	if (init)
 		error = init(inode);
-	if (!error)
+	if (!error){
 		d_instantiate(dentry, inode);
-	else
+		dget(dentry); /* Extra count - pin the dentry in core */
+	} else
 		iput(inode);
  Done:
 	return error;

--jRHKVT23PllUwdXP--
