Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422942AbWJPXvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422942AbWJPXvc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWJPXvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:51:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58304 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750814AbWJPXvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:51:31 -0400
Date: Mon, 16 Oct 2006 16:51:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 01/12] fuse: fix hang on SMP
Message-Id: <20061016165125.4605824b.akpm@osdl.org>
In-Reply-To: <20061016162729.176738000@szeredi.hu>
References: <20061016162709.369579000@szeredi.hu>
	<20061016162729.176738000@szeredi.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 18:27:10 +0200
Miklos Szeredi <miklos@szeredi.hu> wrote:

> Fuse didn't always call i_size_write() with i_mutex held which caused
> rare hangs on SMP/32bit.

Yes, that is a bit of a trap.  I'll maintain a patch in -mm which spits a
warning if i_size_write() is called without i_mutex held.



--- a/include/linux/fs.h~mm-only-i_size_write-debugging
+++ a/include/linux/fs.h
@@ -646,25 +646,7 @@ static inline loff_t i_size_read(struct 
 #endif
 }
 
-/*
- * NOTE: unlike i_size_read(), i_size_write() does need locking around it
- * (normally i_mutex), otherwise on 32bit/SMP an update of i_size_seqcount
- * can be lost, resulting in subsequent i_size_read() calls spinning forever.
- */
-static inline void i_size_write(struct inode *inode, loff_t i_size)
-{
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	write_seqcount_begin(&inode->i_size_seqcount);
-	inode->i_size = i_size;
-	write_seqcount_end(&inode->i_size_seqcount);
-#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPT)
-	preempt_disable();
-	inode->i_size = i_size;
-	preempt_enable();
-#else
-	inode->i_size = i_size;
-#endif
-}
+void i_size_write(struct inode *inode, loff_t i_size);
 
 static inline unsigned iminor(struct inode *inode)
 {
diff -puN fs/inode.c~mm-only-i_size_write-debugging fs/inode.c
--- a/fs/inode.c~mm-only-i_size_write-debugging
+++ a/fs/inode.c
@@ -1384,6 +1384,23 @@ void __init inode_init(unsigned long mem
 		INIT_HLIST_HEAD(&inode_hashtable[loop]);
 }
 
+void i_size_write(struct inode *inode, loff_t i_size)
+{
+	WARN_ON_ONCE(!mutex_is_locked(&inode->i_mutex));
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+	write_seqcount_begin(&inode->i_size_seqcount);
+	inode->i_size = i_size;
+	write_seqcount_end(&inode->i_size_seqcount);
+#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPT)
+	preempt_disable();
+	inode->i_size = i_size;
+	preempt_enable();
+#else
+	inode->i_size = i_size;
+#endif
+}
+EXPORT_SYMBOL(i_size_write);
+
 void init_special_inode(struct inode *inode, umode_t mode, dev_t rdev)
 {
 	inode->i_mode = mode;
_

