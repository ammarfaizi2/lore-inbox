Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289467AbSAJObP>; Thu, 10 Jan 2002 09:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289465AbSAJObE>; Thu, 10 Jan 2002 09:31:04 -0500
Received: from nat.transgeek.com ([66.92.79.28]:58095 "HELO smtp.transgeek.com")
	by vger.kernel.org with SMTP id <S289463AbSAJOat>;
	Thu, 10 Jan 2002 09:30:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: buffer.c lock_kernel() -- removal
Date: Thu, 10 Jan 2002 09:31:24 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020110102805.536F8C738A@smtp.transgeek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Included is a patch against buffer.c that removes the 
lock_kernel()/unlock_kernel() pairs in the few functions that they exist.  

This is for 2.5>2.5.2-pre10.

I beleive that I checked all of the member functions for locking schematics 
but if you can prove me wrong -- go for it.   The only issue I can see would 
be if DQUOT_SYNC() didn't do a lock_kernel() inside itself; but it does so 
that is taken care of (utilizing BKL only if dquot is compiled in).  Well 
after all of that, here is the patch for review.  


Craig. 

Index: linux/fs/buffer.c
diff -u linux/fs/buffer.c:1.3 linux/fs/buffer.c:1.4
--- linux/fs/buffer.c:1.3	Wed Jan  9 02:18:26 2002
+++ linux/fs/buffer.c	Thu Jan 10 09:14:10 2002
@@ -322,14 +322,12 @@
 	kdev_t dev = sb->s_dev;
 	sync_buffers(dev, 0);
 
-	lock_kernel();
 	sync_inodes_sb(sb);
 	DQUOT_SYNC(sb);
 	lock_super(sb);
 	if (sb->s_dirt && sb->s_op && sb->s_op->write_super)
 		sb->s_op->write_super(sb);
 	unlock_super(sb);
-	unlock_kernel();
 
 	return sync_buffers(dev, 1);
 }
@@ -345,7 +343,6 @@
 {
 	sync_buffers(dev, 0);
 
-	lock_kernel();
 	sync_inodes(dev);
 	if (!kdev_none(dev)) {
 		struct super_block *sb = get_super(dev);
@@ -356,7 +353,6 @@
 	} else
 			DQUOT_SYNC(NULL);
 	sync_supers(dev);
-	unlock_kernel();
 
 	return sync_buffers(dev, 1);
 }
@@ -387,7 +383,6 @@
 	kdev_t dev;
 	int ret;
 
-	lock_kernel();
 	/* sync the inode to buffers */
 	write_inode_now(inode, 0);
 
@@ -401,7 +396,6 @@
 	/* .. finally sync the buffers to disk */
 	dev = inode->i_dev;
 	ret = sync_buffers(dev, 1);
-	unlock_kernel();
 	return ret;
 }
 
@@ -2559,10 +2553,8 @@
 
 static int sync_old_buffers(void)
 {
-	lock_kernel();
 	sync_unlocked_inodes();
 	sync_supers(NODEV);
-	unlock_kernel();
 
 	for (;;) {
 		struct buffer_head *bh;
