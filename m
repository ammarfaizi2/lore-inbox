Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319266AbSIKSgA>; Wed, 11 Sep 2002 14:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319268AbSIKSgA>; Wed, 11 Sep 2002 14:36:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21360 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S319266AbSIKSf6>; Wed, 11 Sep 2002 14:35:58 -0400
Date: Wed, 11 Sep 2002 20:41:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Austin Gonyou <austin@coremetrics.com>
Cc: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
Message-ID: <20020911184111.GY17868@dualathlon.random>
References: <20020911201602.A13655@pc9391.uni-regensburg.de> <1031768655.24629.23.camel@UberGeek.coremetrics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031768655.24629.23.camel@UberGeek.coremetrics.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

was a collision between new xfs and new scheduler, you can use this fix
in the meantime:

--- 2.4.20pre5aa3/fs/xfs/pagebuf/page_buf.c.~1~	Wed Sep 11 05:17:46 2002
+++ 2.4.20pre5aa3/fs/xfs/pagebuf/page_buf.c	Wed Sep 11 06:00:35 2002
@@ -2055,9 +2055,9 @@ pagebuf_iodone_daemon(
 	spin_unlock_irq(&current->sigmask_lock);
 
 	/* Migrate to the right CPU */
-	current->cpus_allowed = 1UL << cpu;
-	while (smp_processor_id() != cpu)
-		schedule();
+	set_cpus_allowed(current, 1UL << cpu);
+	if (cpu() != cpu)
+		BUG();
 
 	sprintf(current->comm, "pagebuf_io_CPU%d", bind_cpu);
 	INIT_LIST_HEAD(&pagebuf_iodone_tq[cpu]);

also remeber to apply the O_DIRECT fixes for reiserfs and ext3 (that
were left over after merging the new nfs stuff). all will be fixed in
next -aa of course.

--- 2.4.19pre3aa1/fs/reiserfs/inode.c.~1~	Tue Mar 12 00:07:18 2002
+++ 2.4.19pre3aa1/fs/reiserfs/inode.c	Tue Mar 12 01:24:21 2002
@@ -2161,10 +2161,11 @@
 	}
 }
 
-static int reiserfs_direct_io(int rw, struct inode *inode, 
+static int reiserfs_direct_io(int rw, struct file * filp,
                               struct kiobuf *iobuf, unsigned long blocknr,
 			      int blocksize) 
 {
+    struct inode * inode = filp->f_dentry->d_inode->i_mapping->host;
     return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize,
                              reiserfs_get_block_direct_io) ;
 }
--- 2.4.20pre5aa2/fs/ext3/inode.c.~1~	Mon Sep  9 02:38:08 2002
+++ 2.4.20pre5aa2/fs/ext3/inode.c	Tue Sep 10 05:22:18 2002
@@ -1385,9 +1385,10 @@ static int ext3_releasepage(struct page 
 }
 
 static int
-ext3_direct_IO(int rw, struct inode *inode, struct kiobuf *iobuf,
+ext3_direct_IO(int rw, struct file * filp, struct kiobuf *iobuf,
 		unsigned long blocknr, int blocksize)
 {
+	struct inode * inode = filp->f_dentry->d_inode->i_mapping->host;
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	handle_t *handle = NULL;
 	int ret;

Andrea
