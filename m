Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbVKDLiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbVKDLiX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 06:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbVKDLiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 06:38:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:7555 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750986AbVKDLiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 06:38:22 -0500
Date: Fri, 4 Nov 2005 12:38:51 +0100
From: jblunck@suse.de
To: linux-kernel@vger.kernel.org
Subject: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
Message-ID: <20051104113851.GA4770@hasse.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
"From: jblunck@suse.de"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

This patch effects all users of libfs' dcache directory implementation.

Old glibc implementations (e.g. glibc-2.2.5) are lseeking after every call to
getdents(), subsequent calls to getdents() are starting to read from a wrong
f_pos, when the directory is modified in between. Therefore not all directory
entries are returned. IMHO this is a bug and it breaks applications, e.g. "rm
-fr" on tmpfs.

SuSV3 only says:
"If a file is removed from or added to the directory after the most recent
call to opendir() or rewinddir(), whether a subsequent call to readdir_r()
returns an entry for that file is unspecified."

Although I tried to provide a small fix, this is a complete rework of the
libfs' dcache_readdir() and dcache_dir_lseek(). This patch use the dentries
name hashes as the offsets for the directory entries. I'm not that sure it is
maybe a problem to use full_name_hash() for that. If hash collisions occur,
readdir() might return duplicate entries after an lseek(). Any ideas?

This patch is compile and boot tested. This patch is against 2.6.14-git of
today.

Comments, please.
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test1.c"

#include <stdio.h>
#include <unistd.h>
#include <dirent.h>

int main(int argc, char *argv[])
{
	DIR *dir;
	struct dirent *entry;
	unsigned int offset;

        if (argc < 2) {
                printf("USAGE:  %s <directory>\n", argv[0]);
                return 1;
        }

	dir = opendir(argv[1]);
	if (!dir)
		return 1;

	while((entry = readdir(dir)) != NULL) {
		seekdir(dir, entry->d_off);
		printf("name=%s\tino=%d off=%d\n", entry->d_name, entry->d_ino,
		       entry->d_off);
		if (*entry->d_name == '.')
			continue;
		if(unlink(entry->d_name) != 0)
			break;
	}

	closedir(dir);
	return 0;
}

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="libfs-dcache_readdir_lseek-fix.diff"

 fs/libfs.c |  140 +++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 76 insertions(+), 64 deletions(-)

Index: linux-2.6/fs/libfs.c
===================================================================
--- linux-2.6.orig/fs/libfs.c
+++ linux-2.6/fs/libfs.c
@@ -72,42 +72,57 @@ int dcache_dir_close(struct inode *inode
 	return 0;
 }
 
-loff_t dcache_dir_lseek(struct file *file, loff_t offset, int origin)
+loff_t dcache_dir_lseek(struct file * file, loff_t offset, int origin)
 {
+	struct dentry * dentry = file->f_dentry;
+	int found = 0;
+
+	/* for directories it doesn't make any sense to seek relative */
+	if (origin != 0)
+		return -EINVAL;
+
 	down(&file->f_dentry->d_inode->i_sem);
-	switch (origin) {
-		case 1:
-			offset += file->f_pos;
-		case 0:
-			if (offset >= 0)
-				break;
-		default:
-			up(&file->f_dentry->d_inode->i_sem);
-			return -EINVAL;
-	}
 	if (offset != file->f_pos) {
-		file->f_pos = offset;
-		if (file->f_pos >= 2) {
-			struct list_head *p;
-			struct dentry *cursor = file->private_data;
-			loff_t n = file->f_pos - 2;
+		struct list_head *p;
+		struct dentry *cursor = file->private_data;
 
+		// Handle the special values
+		if ((offset == 0)
+		    || (offset == full_name_hash(".", 1))
+		    || (offset == full_name_hash("..", 2))) {
+			found = 1;
+			file->f_pos = offset;
 			spin_lock(&dcache_lock);
 			list_del(&cursor->d_child);
-			p = file->f_dentry->d_subdirs.next;
-			while (n && p != &file->f_dentry->d_subdirs) {
-				struct dentry *next;
-				next = list_entry(p, struct dentry, d_child);
-				if (!d_unhashed(next) && next->d_inode)
-					n--;
-				p = p->next;
+			list_add(&cursor->d_child, &dentry->d_subdirs);
+			spin_unlock(&dcache_lock);
+			goto out;
+		}
+
+		spin_lock(&dcache_lock);
+		list_del(&cursor->d_child);
+		p = file->f_dentry->d_subdirs.next;
+		while (p != &file->f_dentry->d_subdirs) {
+			struct dentry *next;
+			next = list_entry(p, struct dentry, d_child);
+			if (!d_unhashed(next) && next->d_inode
+			    && (offset == full_name_hash(next->d_name.name,
+							 next->d_name.len))) {
+				found = 1;
+				break;
 			}
+			p = p->next;
+		}
+
+		if (found) {
 			list_add_tail(&cursor->d_child, p);
-			spin_unlock(&dcache_lock);
+			file->f_pos = offset;
 		}
+		spin_unlock(&dcache_lock);
 	}
+out:
 	up(&file->f_dentry->d_inode->i_sem);
-	return offset;
+	return (found ? offset : -EINVAL);
 }
 
 /* Relationship between i_mode and the DT_xxx types */
@@ -128,47 +143,44 @@ int dcache_readdir(struct file * filp, v
 	struct dentry *cursor = filp->private_data;
 	struct list_head *p, *q = &cursor->d_child;
 	ino_t ino;
-	int i = filp->f_pos;
 
-	switch (i) {
-		case 0:
-			ino = dentry->d_inode->i_ino;
-			if (filldir(dirent, ".", 1, i, ino, DT_DIR) < 0)
-				break;
-			filp->f_pos++;
-			i++;
-			/* fallthrough */
-		case 1:
-			ino = parent_ino(dentry);
-			if (filldir(dirent, "..", 2, i, ino, DT_DIR) < 0)
-				break;
-			filp->f_pos++;
-			i++;
-			/* fallthrough */
-		default:
-			spin_lock(&dcache_lock);
-			if (filp->f_pos == 2) {
-				list_del(q);
-				list_add(q, &dentry->d_subdirs);
-			}
-			for (p=q->next; p != &dentry->d_subdirs; p=p->next) {
-				struct dentry *next;
-				next = list_entry(p, struct dentry, d_child);
-				if (d_unhashed(next) || !next->d_inode)
-					continue;
-
-				spin_unlock(&dcache_lock);
-				if (filldir(dirent, next->d_name.name, next->d_name.len, filp->f_pos, next->d_inode->i_ino, dt_type(next->d_inode)) < 0)
-					return 0;
-				spin_lock(&dcache_lock);
-				/* next is still alive */
-				list_del(q);
-				list_add(q, p);
-				p = q;
-				filp->f_pos++;
-			}
-			spin_unlock(&dcache_lock);
+//	if (IS_ERR(cursor->d_fsdata))
+//		return PTR_ERR(cursor->d_fsdata);
+
+	if (filp->f_pos == 0) {
+		ino = dentry->d_inode->i_ino;
+		if (filldir(dirent, ".", 1, filp->f_pos, ino, DT_DIR) < 0)
+			goto out;
+		filp->f_pos = full_name_hash(".", 1);
 	}
+	if (filp->f_pos == full_name_hash(".", 1)) {
+		ino = parent_ino(dentry);
+		if (filldir(dirent, "..", 2, filp->f_pos, ino, DT_DIR) < 0)
+			goto out;
+		filp->f_pos = full_name_hash("..", 2);
+	}
+	spin_lock(&dcache_lock);
+	for (p=q->next; p != &dentry->d_subdirs; p=p->next) {
+		struct dentry *next;
+		next = list_entry(p, struct dentry, d_child);
+		if (d_unhashed(next) || !next->d_inode)
+			continue;
+		spin_unlock(&dcache_lock);
+		if (filldir(dirent, next->d_name.name,
+			    next->d_name.len, filp->f_pos,
+			    next->d_inode->i_ino,
+			    dt_type(next->d_inode)) < 0)
+			goto out;
+		spin_lock(&dcache_lock);
+		/* next is still alive */
+		list_del(q);
+		list_add(q, p);
+		p = q;
+		filp->f_pos = full_name_hash(next->d_name.name,
+					     next->d_name.len);
+	}
+	spin_unlock(&dcache_lock);
+out:
 	return 0;
 }
 

--zYM0uCDKw75PZbzx--
