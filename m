Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbTIKQi7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbTIKQi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:38:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:33672 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261371AbTIKQiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:38:54 -0400
Date: Thu, 11 Sep 2003 09:36:10 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sysfs & dput.
In-Reply-To: <20030911115957.GA4312@mschwid3.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.33.0309110933021.984-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> there is another, small bug in sysfs. In sysfs_create_bin_file 
> dentry gets assigned the error value of the call to sysfs_create
> if the call failed. The subsequent call to dput will crash. The
> solution is to remove the assignment of the error to dentry.

Thanks for the catch; Andrew Morton also posted a patch yesterday. 
However, your patch drops the error value, and his adds another variable. 
The patch below should be equivalent (and fixes the same problem for 
directories, too). 

Please test it, if you get a chance. 

> blue skies,

Heh, not today. :)


Thanks,


	Pat


===== fs/sysfs/dir.c 1.11 vs edited =====
--- 1.11/fs/sysfs/dir.c	Fri Aug 29 14:17:37 2003
+++ edited/fs/sysfs/dir.c	Thu Sep 11 09:32:12 2003
@@ -32,12 +32,12 @@
 		int error = sysfs_create(dentry,
 					 S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO,
 					 init_dir);
+		dput(dentry);
 		if (!error) {
 			dentry->d_fsdata = k;
 			p->d_inode->i_nlink++;
 		} else
 			dentry = ERR_PTR(error);
-		dput(dentry);
 	}
 	up(&p->d_inode->i_sem);
 	return dentry;
===== fs/sysfs/file.c 1.11 vs edited =====
--- 1.11/fs/sysfs/file.c	Fri Aug 29 09:40:51 2003
+++ edited/fs/sysfs/file.c	Thu Sep 11 09:32:19 2003
@@ -353,12 +353,14 @@
 	down(&dir->d_inode->i_sem);
 	dentry = sysfs_get_dentry(dir,attr->name);
 	if (!IS_ERR(dentry)) {
-		error = sysfs_create(dentry,(attr->mode & S_IALLUGO) | S_IFREG,init_file);
+		error = sysfs_create(dentry,
+				     (attr->mode & S_IALLUGO) | S_IFREG,
+				     init_file);
+		dput(dentry);
 		if (!error)
 			dentry->d_fsdata = (void *)attr;
 		else
 			dentry = ERR_PTR(error);
-		dput(dentry);
 	} else
 		error = PTR_ERR(dentry);
 	up(&dir->d_inode->i_sem);

