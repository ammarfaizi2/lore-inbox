Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbUC3X4k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbUC3X4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:56:39 -0500
Received: from mail.kroah.org ([65.200.24.183]:63686 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262117AbUC3X4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:56:35 -0500
Date: Tue, 30 Mar 2004 15:55:33 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       stern@rowland.harvard.edu, david-b@pacbell.net, viro@math.psu.edu,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] back out sysfs reference count change
Message-ID: <20040330235533.GA9018@kroah.com>
References: <20040328063711.GA6387@kroah.com> <Pine.LNX.4.44L0.0403281057100.17150-100000@netrider.rowland.org> <20040328123857.55f04527.akpm@osdl.org> <20040329210219.GA16735@kroah.com> <20040329132551.23e12144.akpm@osdl.org> <20040329231604.GA29494@kroah.com> <20040329153117.558c3263.akpm@osdl.org> <20040330055135.GA8448@in.ibm.com> <20040330230142.GA13571@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330230142.GA13571@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch below backs out Maneesh's sysfs patch that was recently added
to the kernel.  In its defense, the original patch did solve some fixes
that could be duplicated on SMP machines, but the side affect of the
patch caused lots of problems.  Basically it caused kobjects to get
their references incremented when files that are not present in the
kobject are asked for (udev can easily trigger this when it looks for
files call "dev" in directories that do not have that file).  This can
cause easy oopses when the VFS later ages out those old dentries and the
kobject has its reference finally released (usually after the module
that the kobject lived in was removed.)

I will continue to work with Maneesh to try to solve the original bug,
but for now, this patch needs to be applied.

thanks,

greg k-h

--- 1.10/fs/sysfs/dir.c	Fri Mar 19 17:46:51 2004
+++ edited/fs/sysfs/dir.c	Tue Mar 30 15:23:21 2004
@@ -20,18 +20,6 @@
 	return 0;
 }
 
-static void sysfs_d_iput(struct dentry * dentry, struct inode * inode)
-{
-	struct kobject * kobj = dentry->d_fsdata;
-
-	if (kobj)
-		kobject_put(kobj);
-	iput(inode);
-}
-
-static struct dentry_operations sysfs_dentry_operations = {
-	.d_iput	= &sysfs_d_iput,
-};
 
 static int create_dir(struct kobject * k, struct dentry * p,
 		      const char * n, struct dentry ** d)
@@ -45,8 +33,7 @@
 					 S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO,
 					 init_dir);
 		if (!error) {
-			(*d)->d_op = &sysfs_dentry_operations;
-			(*d)->d_fsdata = kobject_get(k);
+			(*d)->d_fsdata = k;
 			p->d_inode->i_nlink++;
 		}
 		dput(*d);
