Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131224AbRAMSZj>; Sat, 13 Jan 2001 13:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131163AbRAMSZf>; Sat, 13 Jan 2001 13:25:35 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131155AbRAMSZW>;
	Sat, 13 Jan 2001 13:25:22 -0500
X-Gnus-Agent-Meta-Information: mail nil
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] symlink fix for shm/swap fs
In-Reply-To: <m3ae8v211w.fsf@linux.local>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <m3ae8v211w.fsf@linux.local>
Message-ID: <m3bstbk1j5.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
Date: 13 Jan 2001 17:03:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Here comes a patch which fixes the totally broken symlink support in
shm/swapfs. It is additional to my former patches for read and write
support.

It survives now a parallel kernel make on my 8way.

Greetings
                Christoph

diff -uNr 2.4.0-shm_vm_locked-truncate-rw-swapfs/mm/shmem.c 2.4.0-shm_vm_locked-truncate-rw-swapfs-symlink/mm/shmem.c
--- 2.4.0-shm_vm_locked-truncate-rw-swapfs/mm/shmem.c	Sat Jan 13 13:22:59 2001
+++ 2.4.0-shm_vm_locked-truncate-rw-swapfs-symlink/mm/shmem.c	Sat Jan 13 16:29:53 2001
@@ -39,6 +39,7 @@
 static struct inode_operations shmem_inode_operations;
 static struct file_operations shmem_dir_operations;
 static struct inode_operations shmem_dir_inode_operations;
+static struct inode_operations shmem_symlink_inode_operations;
 static struct vm_operations_struct shmem_vm_ops;
 
 LIST_HEAD (shmem_inodes);
@@ -127,7 +128,7 @@
 
 	spin_lock (&info->lock);
 	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	if (index >= info->max_index)
+	if (index > info->max_index)
 		goto out;
 
 	start = shmem_truncate_part (info->i_direct, SHMEM_NR_DIRECT, index, &freed);
@@ -419,7 +420,7 @@
 			inode->i_fop = &shmem_dir_operations;
 			break;
 		case S_IFLNK:
-			inode->i_op = &page_symlink_inode_operations;
+			inode->i_op = &shmem_symlink_inode_operations;
 			break;
 		}
 		spin_lock (&shmem_ilock);
@@ -787,14 +788,63 @@
 static int shmem_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
 {
 	int error;
+	int len;
+	struct inode *inode;
+	struct page *page;
+	char *kaddr;
 
 	error = shmem_mknod(dir, dentry, S_IFLNK | S_IRWXUGO, 0);
-	if (!error) {
-		int l = strlen(symname)+1;
-		struct inode *inode = dentry->d_inode;
-		error = block_symlink(inode, symname, l);
-	}
-	return error;
+	if (error)
+		return error;
+
+	len = strlen(symname);
+	if (len > PAGE_SIZE)
+		return -ENAMETOOLONG;
+		
+	inode = dentry->d_inode;
+	down(&inode->i_sem);
+	page = shmem_getpage_locked(inode, 0);
+	if (IS_ERR(page))
+		goto fail;
+	kaddr = kmap(page);
+	memcpy(kaddr, symname, len);
+	kunmap(page);
+	inode->i_size = len;
+	SetPageDirty(page);
+	UnlockPage(page);
+	page_cache_release(page);
+	up(&inode->i_sem);
+	return 0;
+fail:
+	up(&inode->i_sem);
+	return PTR_ERR(page);
+}
+
+static int shmem_readlink(struct dentry *dentry, char *buffer, int buflen)
+{
+	struct page * page;
+	int res = shmem_getpage(dentry->d_inode, 0, &page);
+
+	if (res)
+		return res;
+
+	res = vfs_readlink(dentry,buffer,buflen, kmap(page));
+	kunmap(page);
+	page_cache_release(page);
+	return res;
+}
+
+static int shmem_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	struct page * page;
+	int res = shmem_getpage(dentry->d_inode, 0, &page);
+	if (res)
+		return res;
+
+	res = vfs_follow_link(nd, kmap(page));
+	kunmap(page);
+	page_cache_release(page);
+	return res;
 }
 
 static int shmem_parse_options(char *options, int *mode, unsigned long * blocks, unsigned long *inodes)
@@ -912,6 +962,12 @@
 
 static struct inode_operations shmem_inode_operations = {
 	truncate:	shmem_truncate,
+};
+
+static struct inode_operations shmem_symlink_inode_operations = {
+	truncate:	shmem_truncate,
+	readlink:	shmem_readlink,
+	follow_link:	shmem_follow_link,
 };
 
 static struct file_operations shmem_dir_operations = {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
