Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273981AbRISInj>; Wed, 19 Sep 2001 04:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274019AbRISIn2>; Wed, 19 Sep 2001 04:43:28 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:16900 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S273981AbRISInR>;
	Wed, 19 Sep 2001 04:43:17 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15272.23190.629095.594202@cargo.ozlabs.ibm.com>
Date: Wed, 19 Sep 2001 18:43:02 +1000 (EST)
To: "Nick Piggin" <s3293115@student.anu.edu.au>
Cc: linux-kernel@vger.kernel.org, rgooch@ras.ucalgary.ca
Subject: Re: [2.4.10-pre11 OOPS] in do_generic_file_read
In-Reply-To: <000701c13ffb$785126d0$0200a8c0@W2K>
In-Reply-To: <000701c13ffb$785126d0$0200a8c0@W2K>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin writes:

> I got the following oops on startup while mounting the root filesystem.
> Unfortunately there was no "Code" because of a bad EIP value. If anyone
> would like more information or anything for me to test, please CC me.

I got something similar.  I would predict that you are using devfs.
The problem is that devfs doesn't set inode->i_mapping->a_ops for a
block device.  Ext2 (for instance) calls init_special_inode, and pre11
added a line to that procedure to initialize that field.  But devfs
doesn't use init_special_inode.

The patch below fixes the problem for me.  It may be that devfs should
be calling init_special_inode instead, but that sets inode->i_fop as
well and it looks like devfs sets that a bit differently.  Richard?

Paul.

diff -urN linux/fs/devfs/base.c pmac/fs/devfs/base.c
--- linux/fs/devfs/base.c	Wed Sep 19 16:39:20 2001
+++ pmac/fs/devfs/base.c	Wed Sep 19 17:11:01 2001
@@ -2286,6 +2286,7 @@
 	}
 	else printk ("%s: read_inode(%d): no block device from bdget()\n",
 		     DEVFS_NAME, (int) inode->i_ino);
+	inode->i_mapping->a_ops = &def_blk_aops;
     }
     else if ( S_ISFIFO (de->inode.mode) ) inode->i_fop = &def_fifo_fops;
     else if ( S_ISREG (de->inode.mode) ) inode->i_size = de->u.fcb.u.file.size;
