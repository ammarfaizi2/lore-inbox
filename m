Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268221AbRHAVEe>; Wed, 1 Aug 2001 17:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268217AbRHAVEY>; Wed, 1 Aug 2001 17:04:24 -0400
Received: from hera.cwi.nl ([192.16.191.8]:62429 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S268254AbRHAVEL>;
	Wed, 1 Aug 2001 17:04:11 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 1 Aug 2001 21:03:20 GMT
Message-Id: <200108012103.VAA93890@vlet.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, hch@caldera.de, torvalds@transmeta.com,
        viro@math.psu.edu
Subject: [PATCH] vxfs fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus, Alan, Al, Christoph, all,

If one mounts without specifying a type, mount will try
all available types. After having tried vxfs the next type
will cause
	set_blocksize: b_count 1 ...
since vxfs forgets to free a block.
The patch below adds the missing brelse().
(In fact there are more resources that are never freed there -
maybe the maintainer can have a look some time -
I only added a comment.)

When mount continues to try all types, it may try V7.
That always succeeds, there is no test for magic or so,
and after garbage has been mounted as a V7 filesystem,
the kernel crashes or hangs or fails in other sad ways.
Have not tried to debug.

Andries


--- ../linux-2.4.7/linux/fs/freevxfs/vxfs_super.c	Sat Jul 28 17:08:46 2001
+++ linux/fs/freevxfs/vxfs_super.c	Wed Aug  1 22:41:24 2001
@@ -178,7 +178,8 @@
 	}
 
 	if (rsbp->vs_version < 2 || rsbp->vs_version > 4) {
-		printk(KERN_NOTICE "vxfs: unsupported VxFS version (%d)\n", rsbp->vs_version);
+		printk(KERN_NOTICE "vxfs: unsupported VxFS version (%d)\n",
+		       rsbp->vs_version);
 		goto out;
 	}
 
@@ -221,6 +222,7 @@
 	if (vxfs_read_fshead(sbp)) {
 		printk(KERN_WARNING "vxfs: unable to read fshead\n");
 		return NULL;
+		/* BUG: lots of gets not matched by puts here */
 	}
 
 	sbp->s_op = &vxfs_super_ops;
@@ -229,6 +231,7 @@
 	
 	printk(KERN_WARNING "vxfs: unable to get root dentry.\n");
 out:
+	brelse(bp);
 	kfree(infp);
 	return NULL;
 }
