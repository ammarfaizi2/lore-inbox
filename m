Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTIXKd7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 06:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbTIXKd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 06:33:58 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:51900 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261196AbTIXKdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 06:33:54 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] if(foo) BUG() -> BUG_ON(foo) for include/linux/
Date: Wed, 24 Sep 2003 12:36:31 +0200
User-Agent: KMail/1.5.3
Cc: Linus Torvalds <torvalds@osdl.org>
References: <200309241233.09877@bilbo.math.uni-mannheim.de> <200309241234.58125@bilbo.math.uni-mannheim.de>
In-Reply-To: <200309241234.58125@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309241236.31384@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux-2.6.0-test5-bk10/include/linux/bio.h linux-2.6.0-test5-bk10-test/include/linux/bio.h
--- linux-2.6.0-test5-bk10/include/linux/bio.h	2003-09-23 20:07:15.000000000 +0200
+++ linux-2.6.0-test5-bk10-test/include/linux/bio.h	2003-09-23 21:40:51.000000000 +0200
@@ -266,8 +266,7 @@
 	local_irq_save(*flags);
 	addr = (unsigned long) kmap_atomic(bvec->bv_page, KM_BIO_SRC_IRQ);
 
-	if (addr & ~PAGE_MASK)
-		BUG();
+	BUG_ON(addr & ~PAGE_MASK);
 
 	return (char *) addr + bvec->bv_offset;
 }
Nur in linux-2.6.0-test5-bk10-test/include/linux/: bio.h.orig.
diff -aur linux-2.6.0-test5-bk10/include/linux/buffer_head.h linux-2.6.0-test5-bk10-test/include/linux/buffer_head.h
--- linux-2.6.0-test5-bk10/include/linux/buffer_head.h	2003-09-08 21:49:51.000000000 +0200
+++ linux-2.6.0-test5-bk10-test/include/linux/buffer_head.h	2003-09-23 21:40:51.000000000 +0200
@@ -125,8 +125,7 @@
 /* If we *know* page->private refers to buffer_heads */
 #define page_buffers(page)					\
 	({							\
-		if (!PagePrivate(page))				\
-			BUG();					\
+		BUG_ON(!PagePrivate(page));		\
 		((struct buffer_head *)(page)->private);	\
 	})
 #define page_has_buffers(page)	PagePrivate(page)
diff -aur linux-2.6.0-test5-bk10/include/linux/dcache.h linux-2.6.0-test5-bk10-test/include/linux/dcache.h
--- linux-2.6.0-test5-bk10/include/linux/dcache.h	2003-09-08 21:50:42.000000000 +0200
+++ linux-2.6.0-test5-bk10-test/include/linux/dcache.h	2003-09-23 21:40:51.000000000 +0200
@@ -270,8 +270,7 @@
 static inline struct dentry *dget(struct dentry *dentry)
 {
 	if (dentry) {
-		if (!atomic_read(&dentry->d_count))
-			BUG();
+		BUG_ON(!atomic_read(&dentry->d_count));
 		atomic_inc(&dentry->d_count);
 	}
 	return dentry;
diff -aur linux-2.6.0-test5-bk10/include/linux/highmem.h linux-2.6.0-test5-bk10-test/include/linux/highmem.h
--- linux-2.6.0-test5-bk10/include/linux/highmem.h	2003-09-08 21:50:19.000000000 +0200
+++ linux-2.6.0-test5-bk10-test/include/linux/highmem.h	2003-09-23 21:40:51.000000000 +0200
@@ -56,8 +56,7 @@
 {
 	void *kaddr;
 
-	if (offset + size > PAGE_SIZE)
-		BUG();
+	BUG_ON(offset + size > PAGE_SIZE);
 
 	kaddr = kmap_atomic(page, KM_USER0);
 	memset((char *)kaddr + offset, 0, size);
diff -aur linux-2.6.0-test5-bk10/include/linux/netdevice.h linux-2.6.0-test5-bk10-test/include/linux/netdevice.h
--- linux-2.6.0-test5-bk10/include/linux/netdevice.h	2003-09-23 20:07:17.000000000 +0200
+++ linux-2.6.0-test5-bk10-test/include/linux/netdevice.h	2003-09-23 21:40:51.000000000 +0200
@@ -827,7 +827,7 @@
 	unsigned long flags;
 
 	local_irq_save(flags);
-	if (!test_bit(__LINK_STATE_RX_SCHED, &dev->state)) BUG();
+	BUG_ON(!test_bit(__LINK_STATE_RX_SCHED, &dev->state));
 	list_del(&dev->poll_list);
 	smp_mb__before_clear_bit();
 	clear_bit(__LINK_STATE_RX_SCHED, &dev->state);
@@ -853,7 +853,7 @@
  */
 static inline void __netif_rx_complete(struct net_device *dev)
 {
-	if (!test_bit(__LINK_STATE_RX_SCHED, &dev->state)) BUG();
+	BUG_ON(!test_bit(__LINK_STATE_RX_SCHED, &dev->state));
 	list_del(&dev->poll_list);
 	smp_mb__before_clear_bit();
 	clear_bit(__LINK_STATE_RX_SCHED, &dev->state);
Nur in linux-2.6.0-test5-bk10-test/include/linux/: netdevice.h.orig.
diff -aur linux-2.6.0-test5-bk10/include/linux/nfs_fs.h linux-2.6.0-test5-bk10-test/include/linux/nfs_fs.h
--- linux-2.6.0-test5-bk10/include/linux/nfs_fs.h	2003-09-08 21:50:01.000000000 +0200
+++ linux-2.6.0-test5-bk10-test/include/linux/nfs_fs.h	2003-09-23 21:40:51.000000000 +0200
@@ -262,8 +262,7 @@
 	if (file)
 		cred = (struct rpc_cred *)file->private_data;
 #ifdef RPC_DEBUG
-	if (cred && cred->cr_magic != RPCAUTH_CRED_MAGIC)
-		BUG();
+	BUG_ON(cred && cred->cr_magic != RPCAUTH_CRED_MAGIC);
 #endif
 	return cred;
 }
diff -aur linux-2.6.0-test5-bk10/include/linux/quotaops.h linux-2.6.0-test5-bk10-test/include/linux/quotaops.h
--- linux-2.6.0-test5-bk10/include/linux/quotaops.h	2003-09-08 21:49:58.000000000 +0200
+++ linux-2.6.0-test5-bk10-test/include/linux/quotaops.h	2003-09-23 21:40:51.000000000 +0200
@@ -44,8 +44,7 @@
 
 static __inline__ void DQUOT_INIT(struct inode *inode)
 {
-	if (!inode->i_sb)
-		BUG();
+	BUG_ON(!inode->i_sb);
 	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode))
 		inode->i_sb->dq_op->initialize(inode, -1);
 }
@@ -53,8 +52,7 @@
 static __inline__ void DQUOT_DROP(struct inode *inode)
 {
 	if (IS_QUOTAINIT(inode)) {
-		if (!inode->i_sb)
-			BUG();
+		BUG_ON(!inode->i_sb);
 		inode->i_sb->dq_op->drop(inode);	/* Ops must be set when there's any quota... */
 	}
 }
diff -aur linux-2.6.0-test5-bk10/include/linux/smp_lock.h linux-2.6.0-test5-bk10-test/include/linux/smp_lock.h
--- linux-2.6.0-test5-bk10/include/linux/smp_lock.h	2003-09-08 21:50:21.000000000 +0200
+++ linux-2.6.0-test5-bk10-test/include/linux/smp_lock.h	2003-09-23 21:40:51.000000000 +0200
@@ -49,8 +49,7 @@
 
 static inline void unlock_kernel(void)
 {
-	if (unlikely(current->lock_depth < 0))
-		BUG();
+	BUG_ON(current->lock_depth < 0);
 	if (likely(--current->lock_depth < 0))
 		put_kernel_lock();
 }
