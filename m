Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTFORo2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbTFORo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:44:28 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:21424 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262482AbTFORoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:44:23 -0400
Date: Sun, 15 Jun 2003 19:58:15 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Cc: Brian Jackson <brian@mdrx.com>, Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: [PATCH] make cramfs look less hostile
Message-ID: <20030615175815.GI1063@wohnheim.fh-wedel.de>
References: <20030615160524.GD1063@wohnheim.fh-wedel.de> <20030615182642.A19479@infradead.org> <20030615173926.GH1063@wohnheim.fh-wedel.de> <20030615184417.A19712@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030615184417.A19712@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 June 2003 18:44:17 +0100, Christoph Hellwig wrote:
> On Sun, Jun 15, 2003 at 07:39:26PM +0200, Jörn Engel wrote:
> > > Umm, cramfs_fill_super has a silent parameter that's true for
> > > probing the root filesystem.  I'd suggest disabling the printk
> > > completly if it's set.
> > 
> > Good idea, but only at first glance.  cramfs_fill_super() always gets
> > called with silent=1.  So if "(!silent) printk(...);" is functionally
> > equivalent to ";".
> 
> It's not.  The rootfs is mounted with the (grossly misnamed) MS_VERBOSE
> flag which translates to the last argument of the fill_super callback
> set to 1.

Ok, you win this one.  Leaves this case:
$ mount /dev/somewhere /mnt
cramfs: wrong magic
$ echo $?
0
$

Here I consider the message evil as well.  The patch below on the
other hand might go a little too far.  All the other printk()s are
rare and might hold some useful information for normal users as well.

Any arguments for or against this patch?

Jörn

-- 
To recognize individual spam features you have to try to get into the
mind of the spammer, and frankly I want to spend as little time inside
the minds of spammers as possible.
-- Paul Graham

--- linux-2.5.71/fs/cramfs/inode.c~cramfs_message	2003-06-05 17:47:36.000000000 +0200
+++ linux-2.5.71/fs/cramfs/inode.c	2003-06-15 19:39:03.000000000 +0200
@@ -27,6 +27,14 @@
 
 #include <asm/uaccess.h>
 
+#define DEBUG 0	/* set to 1 for verbose messages during system bringup */
+
+#if DEBUG
+# define dprintk(fmt,args...) printk(fmt , ##args)
+#else
+# define dprintk(fmt,args...)
+#endif
+
 static struct super_operations cramfs_ops;
 static struct inode_operations cramfs_dir_inode_operations;
 static struct file_operations cramfs_directory_operations;
@@ -218,20 +226,20 @@
 		/* check at 512 byte offset */
 		memcpy(&super, cramfs_read(sb, 512, sizeof(super)), sizeof(super));
 		if (super.magic != CRAMFS_MAGIC) {
-			printk(KERN_ERR "cramfs: wrong magic\n");
+			dprintk(KERN_INFO "cramfs: magic not found\n");
 			goto out;
 		}
 	}
 
 	/* get feature flags first */
 	if (super.flags & ~CRAMFS_SUPPORTED_FLAGS) {
-		printk(KERN_ERR "cramfs: unsupported filesystem features\n");
+		dprintk(KERN_ERR "cramfs: unsupported filesystem features\n");
 		goto out;
 	}
 
 	/* Check that the root inode is in a sane state */
 	if (!S_ISDIR(super.root.mode)) {
-		printk(KERN_ERR "cramfs: root is not a directory\n");
+		dprintk(KERN_ERR "cramfs: root is not a directory\n");
 		goto out;
 	}
 	root_offset = super.root.offset << 2;
@@ -247,12 +255,12 @@
 	sbi->magic=super.magic;
 	sbi->flags=super.flags;
 	if (root_offset == 0)
-		printk(KERN_INFO "cramfs: empty filesystem");
+		dprintk(KERN_INFO "cramfs: empty filesystem");
 	else if (!(super.flags & CRAMFS_FLAG_SHIFTED_ROOT_OFFSET) &&
 		 ((root_offset != sizeof(struct cramfs_super)) &&
 		  (root_offset != 512 + sizeof(struct cramfs_super))))
 	{
-		printk(KERN_ERR "cramfs: bad root offset %lu\n", root_offset);
+		dprintk(KERN_ERR "cramfs: bad root offset %lu\n", root_offset);
 		goto out;
 	}
 
