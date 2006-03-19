Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWCSN0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWCSN0t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 08:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWCSN0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 08:26:49 -0500
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:53920 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S932087AbWCSN0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 08:26:48 -0500
Date: Sun, 19 Mar 2006 14:22:41 +0100 (CET)
From: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH]use kzalloc and kcalloc in core fs code
Message-ID: <Pine.LNX.4.58.0603191420470.8676@fachschaft.cup.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a straight conversion to kzalloc and kcalloc.

	Oliver

Signed-Off-By: Oliver Neukum <oliver@neukum.name>

--- a/fs/super.c	2006-03-11 23:12:55.000000000 +0100
+++ b/fs/super.c	2006-03-17 16:27:46.000000000 +0100
@@ -55,11 +55,10 @@
  */
 static struct super_block *alloc_super(void)
 {
-	struct super_block *s = kmalloc(sizeof(struct super_block),  GFP_USER);
+	struct super_block *s = kzalloc(sizeof(struct super_block),  GFP_USER);
 	static struct super_operations default_op;
 
 	if (s) {
-		memset(s, 0, sizeof(struct super_block));
 		if (security_sb_alloc(s)) {
 			kfree(s);
 			s = NULL;
--- a/fs/pipe.c	2006-03-11 23:12:55.000000000 +0100
+++ b/fs/pipe.c	2006-03-17 16:44:38.000000000 +0100
@@ -662,10 +662,9 @@
 {
 	struct pipe_inode_info *info;
 
-	info = kmalloc(sizeof(struct pipe_inode_info), GFP_KERNEL);
+	info = kzalloc(sizeof(struct pipe_inode_info), GFP_KERNEL);
 	if (!info)
 		goto fail_page;
-	memset(info, 0, sizeof(*info));
 	inode->i_pipe = info;
 
 	init_waitqueue_head(PIPE_WAIT(*inode));
--- a/fs/file.c	2006-03-11 23:12:55.000000000 +0100
+++ b/fs/file.c	2006-03-17 16:44:40.000000000 +0100
@@ -237,10 +237,9 @@
   	fd_set *new_openset = NULL, *new_execset = NULL;
 	struct file **new_fds;
 
-	fdt = kmalloc(sizeof(*fdt), GFP_KERNEL);
+	fdt = kzalloc(sizeof(*fdt), GFP_KERNEL);
 	if (!fdt)
   		goto out;
-	memset(fdt, 0, sizeof(*fdt));
 
 	nfds = __FD_SETSIZE;
   	/* Expand to the max in easy steps */
--- a/fs/exec.c	2006-03-11 23:12:55.000000000 +0100
+++ b/fs/exec.c	2006-03-17 16:44:43.000000000 +0100
@@ -1143,10 +1143,9 @@
 	int i;
 
 	retval = -ENOMEM;
-	bprm = kmalloc(sizeof(*bprm), GFP_KERNEL);
+	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
 	if (!bprm)
 		goto out_ret;
-	memset(bprm, 0, sizeof(*bprm));
 
 	file = open_exec(filename);
 	retval = PTR_ERR(file);
--- a/fs/compat.c	2006-03-11 23:12:55.000000000 +0100
+++ b/fs/compat.c	2006-03-17 16:44:45.000000000 +0100
@@ -1474,10 +1474,9 @@
 	int i;
 
 	retval = -ENOMEM;
-	bprm = kmalloc(sizeof(*bprm), GFP_KERNEL);
+	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
 	if (!bprm)
 		goto out_ret;
-	memset(bprm, 0, sizeof(*bprm));
 
 	file = open_exec(filename);
 	retval = PTR_ERR(file);
--- a/fs/char_dev.c	2006-03-11 23:12:55.000000000 +0100
+++ b/fs/char_dev.c	2006-03-17 16:44:47.000000000 +0100
@@ -145,12 +145,10 @@
 	int ret = 0;
 	int i;
 
-	cd = kmalloc(sizeof(struct char_device_struct), GFP_KERNEL);
+	cd = kzalloc(sizeof(struct char_device_struct), GFP_KERNEL);
 	if (cd == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	memset(cd, 0, sizeof(struct char_device_struct));
-
 	down(&chrdevs_lock);
 
 	/* temporary */
@@ -465,9 +463,8 @@
 
 struct cdev *cdev_alloc(void)
 {
-	struct cdev *p = kmalloc(sizeof(struct cdev), GFP_KERNEL);
+	struct cdev *p = kzalloc(sizeof(struct cdev), GFP_KERNEL);
 	if (p) {
-		memset(p, 0, sizeof(struct cdev));
 		p->kobj.ktype = &ktype_cdev_dynamic;
 		INIT_LIST_HEAD(&p->list);
 		kobject_init(&p->kobj);
--- a/fs/binfmt_elf.c	2006-03-11 23:12:55.000000000 +0100
+++ b/fs/binfmt_elf.c	2006-03-17 16:44:51.000000000 +0100
@@ -1465,12 +1465,11 @@
 		read_lock(&tasklist_lock);
 		do_each_thread(g,p)
 			if (current->mm == p->mm && current != p) {
-				tmp = kmalloc(sizeof(*tmp), GFP_ATOMIC);
+				tmp = kzalloc(sizeof(*tmp), GFP_ATOMIC);
 				if (!tmp) {
 					read_unlock(&tasklist_lock);
 					goto cleanup;
 				}
-				memset(tmp, 0, sizeof(*tmp));
 				INIT_LIST_HEAD(&tmp->list);
 				tmp->thread = p;
 				list_add(&tmp->list, &thread_list);
--- a/fs/aio.c	2006-03-11 23:12:55.000000000 +0100
+++ b/fs/aio.c	2006-03-19 13:51:40.000000000 +0100
@@ -122,10 +122,9 @@
 	info->nr = 0;
 	info->ring_pages = info->internal_pages;
 	if (nr_pages > AIO_RING_PAGES) {
-		info->ring_pages = kmalloc(sizeof(struct page *) * nr_pages, GFP_KERNEL);
+		info->ring_pages = kcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL);
 		if (!info->ring_pages)
 			return -ENOMEM;
-		memset(info->ring_pages, 0, sizeof(struct page *) * nr_pages);
 	}
 
 	info->mmap_size = nr_pages * PAGE_SIZE;
--- a/fs/bio.c	2006-03-11 23:12:55.000000000 +0100
+++ b/fs/bio.c	2006-03-19 14:14:52.000000000 +0100
@@ -635,12 +635,10 @@
 		return ERR_PTR(-ENOMEM);
 
 	ret = -ENOMEM;
-	pages = kmalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
+	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		goto out;
 
-	memset(pages, 0, nr_pages * sizeof(struct page *));
-
 	for (i = 0; i < iov_count; i++) {
 		unsigned long uaddr = (unsigned long)iov[i].iov_base;
 		unsigned long len = iov[i].iov_len;
@@ -1182,12 +1180,11 @@
 
 struct bio_set *bioset_create(int bio_pool_size, int bvec_pool_size, int scale)
 {
-	struct bio_set *bs = kmalloc(sizeof(*bs), GFP_KERNEL);
+	struct bio_set *bs = kzalloc(sizeof(*bs), GFP_KERNEL);
 
 	if (!bs)
 		return NULL;
 
-	memset(bs, 0, sizeof(*bs));
 	bs->bio_pool = mempool_create(bio_pool_size, mempool_alloc_slab,
 			mempool_free_slab, bio_slab);
 
