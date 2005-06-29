Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbVF2S7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVF2S7Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVF2S5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:57:38 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:54321 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S262424AbVF2Svj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:51:39 -0400
Date: Wed, 29 Jun 2005 11:51:02 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org
Subject: [RFC] [PATCH 2/2] update filesystems for new delete_inode behavior
Message-ID: <20050629185102.GK8215@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the file systems in fs/ implementing a delete_inode() callback to
call truncate_inode_pages(). One implementation note: In developing
this patch I put the calls to truncate_inode_pages() at the very top of
those filesystems delete_inode() callbacks in order to retain the
previous behavior. I'm guessing that some of those could probably be
optimized.

Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>

--- linux-2.6.12.orig/fs/affs/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/affs/inode.c	2005-06-28 16:19:18.104473000 -0700
@@ -255,6 +255,7 @@
 affs_delete_inode(struct inode *inode)
 {
 	pr_debug("AFFS: delete_inode(ino=%lu, nlink=%u)\n", inode->i_ino, inode->i_nlink);
+	truncate_inode_pages(&inode->i_data, 0);
 	inode->i_size = 0;
 	if (S_ISREG(inode->i_mode))
 		affs_truncate(inode);
--- linux-2.6.12.orig/fs/bfs/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/bfs/inode.c	2005-06-28 16:19:31.468300000 -0700
@@ -143,6 +143,8 @@
 
 	dprintf("ino=%08lx\n", inode->i_ino);
 
+	truncate_inode_pages(&inode->i_data, 0);
+
 	if (inode->i_ino < BFS_ROOT_INO || inode->i_ino > info->si_lasti) {
 		printf("invalid ino=%08lx\n", inode->i_ino);
 		return;
--- linux-2.6.12.orig/fs/ext2/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/ext2/inode.c	2005-06-28 16:22:15.372657000 -0700
@@ -70,6 +70,8 @@
  */
 void ext2_delete_inode (struct inode * inode)
 {
+	truncate_inode_pages(&inode->i_data, 0);
+
 	if (is_bad_inode(inode))
 		goto no_delete;
 	EXT2_I(inode)->i_dtime	= get_seconds();
--- linux-2.6.12.orig/fs/ext3/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/ext3/inode.c	2005-06-28 16:22:22.656409000 -0700
@@ -187,6 +187,8 @@
 {
 	handle_t *handle;
 
+	truncate_inode_pages(&inode->i_data, 0);
+
 	if (is_bad_inode(inode))
 		goto no_delete;
 
--- linux-2.6.12.orig/fs/fat/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/fat/inode.c	2005-06-28 16:23:02.308570000 -0700
@@ -335,6 +335,8 @@
 
 static void fat_delete_inode(struct inode *inode)
 {
+	truncate_inode_pages(&inode->i_data, 0);
+
 	if (!is_bad_inode(inode)) {
 		inode->i_size = 0;
 		fat_truncate(inode);
--- linux-2.6.12.orig/fs/hostfs/hostfs_kern.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/hostfs/hostfs_kern.c	2005-06-28 16:23:20.049001000 -0700
@@ -287,6 +287,7 @@
 
 static void hostfs_delete_inode(struct inode *inode)
 {
+	truncate_inode_pages(&inode->i_data, 0);
 	if(HOSTFS_I(inode)->fd != -1) {
 		close_file(&HOSTFS_I(inode)->fd);
 		HOSTFS_I(inode)->fd = -1;
--- linux-2.6.12.orig/fs/hpfs/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/hpfs/inode.c	2005-06-28 16:23:46.456445000 -0700
@@ -284,6 +284,7 @@
 
 void hpfs_delete_inode(struct inode *inode)
 {
+	truncate_inode_pages(&inode->i_data, 0);
 	lock_kernel();
 	hpfs_remove_fnode(inode->i_sb, inode->i_ino);
 	unlock_kernel();
--- linux-2.6.12.orig/fs/jffs/inode-v23.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/jffs/inode-v23.c	2005-06-28 16:24:43.284179000 -0700
@@ -1747,6 +1747,7 @@
 	D3(printk("jffs_delete_inode(): inode->i_ino == %lu\n",
 		  inode->i_ino));
 
+	truncate_inode_pages(&inode->i_data, 0);
 	lock_kernel();
 	inode->i_size = 0;
 	inode->i_blocks = 0;
--- linux-2.6.12.orig/fs/jfs/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/jfs/inode.c	2005-06-28 16:33:03.768648000 -0700
@@ -135,6 +135,8 @@
 {
 	jfs_info("In jfs_delete_inode, inode = 0x%p", inode);
 
+	truncate_inode_pages(&inode->i_data, 0);
+
 	if (test_cflag(COMMIT_Freewmap, inode))
 		freeZeroLink(inode);
 
--- linux-2.6.12.orig/fs/minix/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/minix/inode.c	2005-06-28 16:25:24.445987000 -0700
@@ -24,6 +24,7 @@
 
 static void minix_delete_inode(struct inode *inode)
 {
+	truncate_inode_pages(&inode->i_data, 0);
 	inode->i_size = 0;
 	minix_truncate(inode);
 	minix_free_inode(inode);
--- linux-2.6.12.orig/fs/ncpfs/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/ncpfs/inode.c	2005-06-28 16:25:47.360604000 -0700
@@ -286,6 +286,8 @@
 static void
 ncp_delete_inode(struct inode *inode)
 {
+	truncate_inode_pages(&inode->i_data, 0);
+
 	if (S_ISDIR(inode->i_mode)) {
 		DDPRINTK("ncp_delete_inode: put directory %ld\n", inode->i_ino);
 	}
--- linux-2.6.12.orig/fs/nfs/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/nfs/inode.c	2005-06-28 16:27:44.790047000 -0700
@@ -129,6 +129,8 @@
 {
 	dprintk("NFS: delete_inode(%s/%ld)\n", inode->i_sb->s_id, inode->i_ino);
 
+	truncate_inode_pages(&inode->i_data, 0);
+
 	nfs_wb_all(inode);
 	/*
 	 * The following should never happen...
--- linux-2.6.12.orig/fs/proc/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/proc/inode.c	2005-06-28 16:28:03.876948000 -0700
@@ -60,6 +60,8 @@
 	struct proc_dir_entry *de;
 	struct task_struct *tsk;
 
+	truncate_inode_pages(&inode->i_data, 0);
+
 	/* Let go of any associated process */
 	tsk = PROC_I(inode)->task;
 	if (tsk)
--- linux-2.6.12.orig/fs/qnx4/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/qnx4/inode.c	2005-06-28 16:28:23.816528000 -0700
@@ -63,6 +63,7 @@
 static void qnx4_delete_inode(struct inode *inode)
 {
 	QNX4DEBUG(("qnx4: deleting inode [%lu]\n", (unsigned long) inode->i_ino));
+	truncate_inode_pages(&inode->i_data, 0);
 	inode->i_size = 0;
 	qnx4_truncate(inode);
 	lock_kernel();
--- linux-2.6.12.orig/fs/reiserfs/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/reiserfs/inode.c	2005-06-28 16:28:42.508429000 -0700
@@ -31,6 +31,8 @@
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 + 2 * REISERFS_QUOTA_INIT_BLOCKS;
     struct reiserfs_transaction_handle th ;
   
+    truncate_inode_pages(&inode->i_data, 0);
+
     reiserfs_write_lock(inode->i_sb);
 
     /* The = 0 happens when we abort creating a new inode for some reason like lack of space.. */
--- linux-2.6.12.orig/fs/smbfs/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/smbfs/inode.c	2005-06-28 18:12:45.989710000 -0700
@@ -331,6 +331,7 @@
 smb_delete_inode(struct inode *ino)
 {
 	DEBUG1("ino=%ld\n", ino->i_ino);
+	truncate_inode_pages(&ino->i_data, 0);
 	lock_kernel();
 	if (smb_close(ino))
 		PARANOIA("could not close inode %ld\n", ino->i_ino);
--- linux-2.6.12.orig/fs/sysv/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/sysv/inode.c	2005-06-28 16:29:29.229622000 -0700
@@ -292,6 +292,7 @@
 
 static void sysv_delete_inode(struct inode *inode)
 {
+	truncate_inode_pages(&inode->i_data, 0);
 	inode->i_size = 0;
 	sysv_truncate(inode);
 	lock_kernel();
--- linux-2.6.12.orig/fs/udf/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/udf/inode.c	2005-06-28 16:29:41.812490000 -0700
@@ -87,6 +87,8 @@
  */
 void udf_delete_inode(struct inode * inode)
 {
+	truncate_inode_pages(&inode->i_data, 0);
+
 	if (is_bad_inode(inode))
 		goto no_delete;
 
--- linux-2.6.12.orig/fs/ufs/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/ufs/inode.c	2005-06-28 16:29:54.506337000 -0700
@@ -804,6 +804,7 @@
 
 void ufs_delete_inode (struct inode * inode)
 {
+	truncate_inode_pages(&inode->i_data, 0);
 	/*UFS_I(inode)->i_dtime = CURRENT_TIME;*/
 	lock_kernel();
 	mark_inode_dirty(inode);
