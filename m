Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130446AbREEIIf>; Sat, 5 May 2001 04:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130466AbREEIIP>; Sat, 5 May 2001 04:08:15 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:32723 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S130446AbREEIII>; Sat, 5 May 2001 04:08:08 -0400
To: "David L. Parsley" <parsley@linuxjedi.org>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] inline symlinks for tmpfs
In-Reply-To: <Pine.GSO.4.21.0104240639580.6992-100000@weyl.math.psu.edu>
	<m3n196v2un.fsf@linux.local> <3AE5AF68.404AEF0E@linuxjedi.org>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <3AE5AF68.404AEF0E@linuxjedi.org>
Message-ID: <m3elu4rj12.fsf_-_@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date: 05 May 2001 09:48:26 +0200
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi David,

On Tue, 24 Apr 2001, David L. Parsley wrote:
>> OK I will do that for tmpfs soon. And I will do the symlink
>> inlining with that patch.

OK, here comes the patch for the symlink inlining. It is on top of my
previous patch to encapsulate access to the private inode info.

Greetings
		Christoph


--=-=-=
Content-Disposition: attachment; filename=patch-inline_symlink

diff -uNr 2.4.4-mmap_write-SHMEM_I/mm/shmem.c 2.4.4-mmap_write-SHMEM_I-symlink/mm/shmem.c
--- 2.4.4-mmap_write-SHMEM_I/mm/shmem.c	Fri May  4 21:32:22 2001
+++ 2.4.4-mmap_write-SHMEM_I-symlink/mm/shmem.c	Fri May  4 21:37:34 2001
@@ -41,7 +41,6 @@
 static struct inode_operations shmem_inode_operations;
 static struct file_operations shmem_dir_operations;
 static struct inode_operations shmem_dir_inode_operations;
-static struct inode_operations shmem_symlink_inode_operations;
 static struct vm_operations_struct shmem_vm_ops;
 
 LIST_HEAD (shmem_inodes);
@@ -205,11 +204,13 @@
 {
 	struct shmem_sb_info *info = &inode->i_sb->u.shmem_sb;
 
-	spin_lock (&shmem_ilock);
-	list_del (&SHMEM_I(inode)->list);
-	spin_unlock (&shmem_ilock);
 	inode->i_size = 0;
-	shmem_truncate (inode);
+	if (inode->i_op->truncate == shmem_truncate){ 
+		spin_lock (&shmem_ilock);
+		list_del (&SHMEM_I(inode)->list);
+		spin_unlock (&shmem_ilock);
+		shmem_truncate(inode);
+	}
 	spin_lock (&info->stat_lock);
 	info->free_inodes++;
 	spin_unlock (&info->stat_lock);
@@ -532,6 +533,9 @@
 		case S_IFREG:
 			inode->i_op = &shmem_inode_operations;
 			inode->i_fop = &shmem_file_operations;
+			spin_lock (&shmem_ilock);
+			list_add (&SHMEM_I(inode)->list, &shmem_inodes);
+			spin_unlock (&shmem_ilock);
 			break;
 		case S_IFDIR:
 			inode->i_nlink++;
@@ -539,17 +543,17 @@
 			inode->i_fop = &shmem_dir_operations;
 			break;
 		case S_IFLNK:
-			inode->i_op = &shmem_symlink_inode_operations;
 			break;
 		}
-		spin_lock (&shmem_ilock);
-		list_add (&SHMEM_I(inode)->list, &shmem_inodes);
-		spin_unlock (&shmem_ilock);
 	}
 	return inode;
 }
 
 #ifdef CONFIG_TMPFS
+
+static struct inode_operations shmem_symlink_inode_operations;
+static struct inode_operations shmem_symlink_inline_operations;
+
 static ssize_t
 shmem_file_write(struct file *file,const char *buf,size_t count,loff_t *ppos)
 {
@@ -930,33 +934,54 @@
 	struct inode *inode;
 	struct page *page;
 	char *kaddr;
+	struct shmem_inode_info * info;
 
 	error = shmem_mknod(dir, dentry, S_IFLNK | S_IRWXUGO, 0);
 	if (error)
 		return error;
 
-	len = strlen(symname);
+	len = strlen(symname) + 1;
 	if (len > PAGE_SIZE)
 		return -ENAMETOOLONG;
-		
+
 	inode = dentry->d_inode;
-	down(&inode->i_sem);
-	page = shmem_getpage_locked(SHMEM_I(inode), inode, 0);
-	if (IS_ERR(page))
-		goto fail;
-	kaddr = kmap(page);
-	memcpy(kaddr, symname, len);
-	kunmap(page);
+	info = SHMEM_I(inode);
 	inode->i_size = len;
-	SetPageDirty(page);
-	UnlockPage(page);
-	page_cache_release(page);
-	up(&inode->i_sem);
+	if (len <= sizeof(struct shmem_inode_info)) {
+		/* do it inline */
+		memcpy(info, symname, len);
+		inode->i_op = &shmem_symlink_inline_operations;
+	} else {
+		spin_lock (&shmem_ilock);
+		list_add (&info->list, &shmem_inodes);
+		spin_unlock (&shmem_ilock);
+		down(&inode->i_sem);
+		page = shmem_getpage_locked(info, inode, 0);
+		if (IS_ERR(page)) {
+			up(&inode->i_sem);
+			return PTR_ERR(page);
+		}
+		kaddr = kmap(page);
+		memcpy(kaddr, symname, len);
+		kunmap(page);
+		SetPageDirty(page);
+		UnlockPage(page);
+		page_cache_release(page);
+		up(&inode->i_sem);
+		inode->i_op = &shmem_symlink_inode_operations;
+	}
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	return 0;
-fail:
-	up(&inode->i_sem);
-	return PTR_ERR(page);
+}
+
+static int shmem_readlink_inline(struct dentry *dentry, char *buffer, int buflen)
+{
+	return vfs_readlink(dentry,buffer,buflen, (const char *)SHMEM_I(dentry->d_inode));
+}
+
+static int shmem_follow_link_inline(struct dentry *dentry, struct nameidata *nd)
+{
+	return vfs_follow_link(nd, (const char *)SHMEM_I(dentry->d_inode));
 }
 
 static int shmem_readlink(struct dentry *dentry, char *buffer, int buflen)
@@ -986,6 +1011,17 @@
 	return res;
 }
 
+static struct inode_operations shmem_symlink_inline_operations = {
+	readlink:	shmem_readlink_inline,
+	follow_link:	shmem_follow_link_inline,
+};
+
+static struct inode_operations shmem_symlink_inode_operations = {
+	truncate:	shmem_truncate,
+	readlink:	shmem_readlink,
+	follow_link:	shmem_follow_link,
+};
+
 static int shmem_parse_options(char *options, int *mode, unsigned long * blocks, unsigned long *inodes)
 {
 	char *this_char, *value;
@@ -1118,14 +1154,6 @@
 
 static struct inode_operations shmem_inode_operations = {
 	truncate:	shmem_truncate,
-};
-
-static struct inode_operations shmem_symlink_inode_operations = {
-	truncate:	shmem_truncate,
-#ifdef CONFIG_TMPFS
-	readlink:	shmem_readlink,
-	follow_link:	shmem_follow_link,
-#endif
 };
 
 static struct file_operations shmem_dir_operations = {

--=-=-=--

