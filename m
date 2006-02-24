Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWBXMEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWBXMEo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 07:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWBXMEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 07:04:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6575 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932086AbWBXMEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 07:04:44 -0500
Date: Fri, 24 Feb 2006 04:04:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Ph. Marek" <philipp.marek@bmlv.gv.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ramfs and directory modification time
Message-Id: <20060224040400.2f093523.akpm@osdl.org>
In-Reply-To: <200602231405.04091.philipp.marek@bmlv.gv.at>
References: <200602231405.04091.philipp.marek@bmlv.gv.at>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ph. Marek" <philipp.marek@bmlv.gv.at> wrote:
>
> I believe that I found a problem regarding ramfs and directory modification 
>  times.
> 
> 
> 
>  Observe:
>  	$ /tmp# mkdir newdir
>  	$ /tmp# mount -t ramfs none newdir
>  	$ /tmp# cd newdir/
>  	$ /tmp/newdir# mkdir sub
>  	$ /tmp/newdir# cd sub
>  	$ /tmp/newdir/sub# ls -la --full-time
>  	total 0
>  	drwxr-xr-x 2 root root 0 2006-02-23 14:01:37.573655160 +0100 .
>  	drwxr-xr-x 3 root root 0 2006-02-23 14:01:33.221316816 +0100 ..
>  	$ /tmp/newdir/sub# touch a-new-file
>  	$ /tmp/newdir/sub# ls -la --full-time
>  	total 0
>  	drwxr-xr-x 2 root root 0 2006-02-23 14:01:37.573655160 +0100 .
>  	drwxr-xr-x 3 root root 0 2006-02-23 14:01:33.221316816 +0100 ..
>  	-rw-r--r-- 1 root root 0 2006-02-23 14:01:48.019067216 +0100 a-new-file
> 
>  On a tmpfs or other (disk-based) filesystems (ext3) it works correctly.

Yes, bug.  Thanks.


--- devel/fs/ramfs/inode.c~ramfs-update-dir-mtime-and-ctime	2006-02-24 03:53:46.000000000 -0800
+++ devel-akpm/fs/ramfs/inode.c	2006-02-24 03:54:29.000000000 -0800
@@ -27,6 +27,7 @@
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
+#include <linux/time.h>
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
@@ -104,6 +105,7 @@ ramfs_mknod(struct inode *dir, struct de
 		d_instantiate(dentry, inode);
 		dget(dentry);	/* Extra count - pin the dentry in core */
 		error = 0;
+		dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	}
 	return error;
 }
_

