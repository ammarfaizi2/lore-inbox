Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130529AbRBJTf4>; Sat, 10 Feb 2001 14:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131714AbRBJTfq>; Sat, 10 Feb 2001 14:35:46 -0500
Received: from ns.caldera.de ([212.34.180.1]:49928 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130529AbRBJTfd>;
	Sat, 10 Feb 2001 14:35:33 -0500
Date: Sat, 10 Feb 2001 20:34:42 +0100
From: Christoph Hellwig <hch@caldera.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Use slab in pipe code
Message-ID: <20010210203442.A8973@caldera.de>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this patch makes the pipe code use the slab allocator instead of
kmalloc/kfree.  The changes are pretty small, so I think it's ok
for the stable series.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.


--- linux-2.4.2-pre3/fs/pipe.c	Sat Feb 10 20:03:33 2001
+++ linux/fs/pipe.c	Sat Feb 10 20:36:57 2001
@@ -21,8 +21,13 @@
  * 
  * Reads with count = 0 should always return 0.
  * -- Julian Bradfield 1999-06-07.
+ *
+ * Use slab allocator instead of kmalloc/kfree.
+ * -- Christoph Hellwig 2001-02-07
  */
 
+static kmem_cache_t * pipe_cachep;
+
 /* Drop the inode semaphore and wait for a pipe event, atomically */
 void pipe_wait(struct inode * inode)
 {
@@ -448,7 +453,7 @@
 	if (!page)
 		return NULL;
 
-	inode->i_pipe = kmalloc(sizeof(struct pipe_inode_info), GFP_KERNEL);
+	inode->i_pipe = kmem_cache_alloc(pipe_cachep, SLAB_KERNEL);
 	if (!inode->i_pipe)
 		goto fail_page;
 
@@ -578,7 +583,7 @@
 	put_unused_fd(i);
 close_f12_inode:
 	free_page((unsigned long) PIPE_BASE(*inode));
-	kfree(inode->i_pipe);
+	kmem_cache_free(pipe_cachep, inode->i_pipe);
 	inode->i_pipe = NULL;
 	iput(inode);
 close_f12:
@@ -635,15 +640,28 @@
 
 static int __init init_pipe_fs(void)
 {
-	int err = register_filesystem(&pipe_fs_type);
-	if (!err) {
-		pipe_mnt = kern_mount(&pipe_fs_type);
-		err = PTR_ERR(pipe_mnt);
-		if (IS_ERR(pipe_mnt))
-			unregister_filesystem(&pipe_fs_type);
-		else
-			err = 0;
-	}
+	int err = -ENOMEM;
+
+	pipe_cachep = kmem_cache_create("pipe_cache",
+			sizeof(struct pipe_inode_info), 0,
+			SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (pipe_cachep == NULL)
+		goto err_out;
+	
+	err = register_filesystem(&pipe_fs_type);
+	if (err)
+		goto err_out;
+
+	pipe_mnt = kern_mount(&pipe_fs_type);
+
+	err = PTR_ERR(pipe_mnt);
+	if (!IS_ERR(pipe_mnt))
+		return 0;
+
+	unregister_filesystem(&pipe_fs_type);
+
+err_out:
+	kmem_cache_destroy(pipe_cachep);
 	return err;
 }
 
@@ -651,6 +669,7 @@
 {
 	unregister_filesystem(&pipe_fs_type);
 	kern_umount(pipe_mnt);
+	kmem_cache_destroy(pipe_cachep);
 }
 
 module_init(init_pipe_fs)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
