Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTILSor (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbTILSny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:43:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:65001 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261878AbTILSmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:42:47 -0400
Date: Fri, 12 Sep 2003 11:24:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Voicu Liviu <pacman@mscc.huji.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-test5-mm1
Message-Id: <20030912112436.03ba9dd1.akpm@osdl.org>
In-Reply-To: <3F61C062.1080700@mscc.huji.ac.il>
References: <3F61C062.1080700@mscc.huji.ac.il>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voicu Liviu <pacman@mscc.huji.ac.il> wrote:
>
> This happens after I load alsa modules on boot..............
> 
> <from_dmesg>
> 
> Freeing unused kernel memory: 308k freed
> Adding 313228k swap on /dev/hda6.  Priority:-1 extents:1
> PCI: Found IRQ 5 for device 0000:00:09.0
> PCI: Sharing IRQ 5 with 0000:00:04.2
> Unable to handle kernel paging request at virtual address ffffffef


diff -puN fs/sysfs/dir.c~sysfs-create_dir-oops-fix fs/sysfs/dir.c
--- 25/fs/sysfs/dir.c~sysfs-create_dir-oops-fix	Wed Sep 10 15:46:50 2003
+++ 25-akpm/fs/sysfs/dir.c	Wed Sep 10 15:46:50 2003
@@ -24,10 +24,11 @@ static int init_dir(struct inode * inode
 static struct dentry * 
 create_dir(struct kobject * k, struct dentry * p, const char * n)
 {
-	struct dentry * dentry;
+	struct dentry *dentry, *ret;
 
 	down(&p->d_inode->i_sem);
 	dentry = sysfs_get_dentry(p,n);
+	ret = dentry;
 	if (!IS_ERR(dentry)) {
 		int error = sysfs_create(dentry,
 					 S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO,
@@ -36,11 +37,11 @@ create_dir(struct kobject * k, struct de
 			dentry->d_fsdata = k;
 			p->d_inode->i_nlink++;
 		} else
-			dentry = ERR_PTR(error);
+			ret = ERR_PTR(error);
 		dput(dentry);
 	}
 	up(&p->d_inode->i_sem);
-	return dentry;
+	return ret;
 }
 
 

_

