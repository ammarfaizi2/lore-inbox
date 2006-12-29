Return-Path: <linux-kernel-owner+w=401wt.eu-S1751615AbWL2LCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWL2LCa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 06:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbWL2LC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 06:02:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:42827 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbWL2LC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 06:02:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=T4coE/qQXgXwJjhGcrEhgPE59a223pxLmMlDbatmatzxTIN+3DZhXBBMNPYZCZVIv2Z/nsyewbzZ53zeaUWdnyQ5d/pFdeliXK4n8sHJW+y3Pl9Zt/VWVvVZm9InzG8tBIQMr7C5Vp37gjrGqiSbiiPZrqf4lp1+w4N5c/EJ67M=
Date: Fri, 29 Dec 2006 11:00:41 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       Oliver Neukum <oliver@neukum.name>, Greg KH <greg@kroah.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.20-rc2-mm1: INFO: possible recursive locking detected in con_close
Message-ID: <20061229110041.GA1441@slug>
References: <20061228024237.375a482f.akpm@osdl.org> <45943638.30705@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45943638.30705@free.fr>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 10:25:12PM +0100, Laurent Riffard wrote:
> Le 28.12.2006 11:42, Andrew Morton a écrit :
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc2/2.6.20-rc2-mm1/
> 
> Hello,
> 
> got this with 2.6.20-rc2-mm1, reverting 
> gregkh-driver-driver-core-fix-race-in-sysfs-between-sysfs_remove_file-and-read-write.patch made it disappear.
> 
Hi, 

This is due to sysfs_hash_and_remove() holding dir->d_inode->i_mutex
before calling sysfs_drop_dentry() which calls orphan_all_buffers()
which in turn takes node->i_mutex.
The following patch solves the problem by defering the buffers orphaning
after the dir->d_inode->imutex is released. Not sure it's the best
solution though, Greg?

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/fs/sysfs/inode.c b/fs/sysfs/inode.c
index 8c533cb..7cac0b6 100644
--- a/fs/sysfs/inode.c
+++ b/fs/sysfs/inode.c
@@ -230,10 +230,10 @@ static inline void orphan_all_buffers(struct inode *node)
  * Unhashes the dentry corresponding to given sysfs_dirent
  * Called with parent inode's i_mutex held.
  */
-void sysfs_drop_dentry(struct sysfs_dirent * sd, struct dentry * parent)
+struct inode *sysfs_drop_dentry(struct sysfs_dirent * sd, struct dentry * parent)
 {
 	struct dentry * dentry = sd->s_dentry;
-	struct inode *inode;
+	struct inode *inode = NULL;
 
 	if (dentry) {
 		spin_lock(&dcache_lock);
@@ -248,19 +248,19 @@ void sysfs_drop_dentry(struct sysfs_dirent * sd, struct dentry * parent)
 			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);
 			simple_unlink(parent->d_inode, dentry);
-			orphan_all_buffers(inode);
-			iput(inode);
 		} else {
 			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);
 		}
 	}
+	return inode;
 }
 
 int sysfs_hash_and_remove(struct dentry * dir, const char * name)
 {
 	struct sysfs_dirent * sd;
 	struct sysfs_dirent * parent_sd;
+	struct inode *inode;
 	int found = 0;
 
 	if (!dir)
@@ -277,7 +277,7 @@ int sysfs_hash_and_remove(struct dentry * dir, const char * name)
 			continue;
 		if (!strcmp(sysfs_get_name(sd), name)) {
 			list_del_init(&sd->s_sibling);
-			sysfs_drop_dentry(sd, dir);
+			inode = sysfs_drop_dentry(sd, dir);
 			sysfs_put(sd);
 			found = 1;
 			break;
@@ -285,5 +285,10 @@ int sysfs_hash_and_remove(struct dentry * dir, const char * name)
 	}
 	mutex_unlock(&dir->d_inode->i_mutex);
 
+	if (found == 1 && inode) {
+		orphan_all_buffers(inode);
+		iput(inode);
+	}
+
 	return found ? 0 : -ENOENT;
 }
diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
index 5100a12..ef9d217 100644
--- a/fs/sysfs/sysfs.h
+++ b/fs/sysfs/sysfs.h
@@ -17,7 +17,7 @@ extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **)
 extern void sysfs_remove_subdir(struct dentry *);
 
 extern const unsigned char * sysfs_get_name(struct sysfs_dirent *sd);
-extern void sysfs_drop_dentry(struct sysfs_dirent *sd, struct dentry *parent);
+extern struct inode * sysfs_drop_dentry(struct sysfs_dirent *sd, struct dentry *parent);
 extern int sysfs_setattr(struct dentry *dentry, struct iattr *iattr);
 
 extern struct rw_semaphore sysfs_rename_sem;
