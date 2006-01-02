Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWABQgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWABQgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 11:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWABQgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 11:36:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54228 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750750AbWABQf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 11:35:26 -0500
Date: Mon, 2 Jan 2006 17:35:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 14/19] mutex subsystem, semaphore to mutex: VFS, ->i_sem, more
Message-ID: <20060102163511.GO31501@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

more i_sem -> i_mutex conversions that were needed for my .config.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 fs/nfs/dir.c                |    6 +++---
 ipc/mqueue.c                |    8 ++++----
 security/inode.c            |    8 ++++----
 sound/core/oss/pcm_oss.c    |    4 ++--
 sound/core/seq/seq_memory.c |    4 ----
 5 files changed, 13 insertions(+), 17 deletions(-)

Index: linux/fs/nfs/dir.c
===================================================================
--- linux.orig/fs/nfs/dir.c
+++ linux/fs/nfs/dir.c
@@ -194,7 +194,7 @@ int nfs_readdir_filler(nfs_readdir_descr
 	spin_unlock(&inode->i_lock);
 	/* Ensure consistent page alignment of the data.
 	 * Note: assumes we have exclusive access to this mapping either
-	 *	 through inode->i_sem or some other mechanism.
+	 *	 through inode->i_mutex or some other mechanism.
 	 */
 	if (page->index == 0)
 		invalidate_inode_pages2_range(inode->i_mapping, PAGE_CACHE_SIZE, -1);
@@ -1001,7 +1001,7 @@ static int nfs_open_revalidate(struct de
 	openflags &= ~(O_CREAT|O_TRUNC);
 
 	/*
-	 * Note: we're not holding inode->i_sem and so may be racing with
+	 * Note: we're not holding inode->i_mutex and so may be racing with
 	 * operations that change the directory. We therefore save the
 	 * change attribute *before* we do the RPC call.
 	 */
@@ -1051,7 +1051,7 @@ static struct dentry *nfs_readdir_lookup
 		return dentry;
 	if (!desc->plus || !(entry->fattr->valid & NFS_ATTR_FATTR))
 		return NULL;
-	/* Note: caller is already holding the dir->i_sem! */
+	/* Note: caller is already holding the dir->i_mutex! */
 	dentry = d_alloc(parent, &name);
 	if (dentry == NULL)
 		return NULL;
Index: linux/ipc/mqueue.c
===================================================================
--- linux.orig/ipc/mqueue.c
+++ linux/ipc/mqueue.c
@@ -660,7 +660,7 @@ asmlinkage long sys_mq_open(const char _
 	if (fd < 0)
 		goto out_putname;
 
-	down(&mqueue_mnt->mnt_root->d_inode->i_sem);
+	mutex_lock(&mqueue_mnt->mnt_root->d_inode->i_mutex);
 	dentry = lookup_one_len(name, mqueue_mnt->mnt_root, strlen(name));
 	if (IS_ERR(dentry)) {
 		error = PTR_ERR(dentry);
@@ -697,7 +697,7 @@ out_putfd:
 out_err:
 	fd = error;
 out_upsem:
-	up(&mqueue_mnt->mnt_root->d_inode->i_sem);
+	mutex_unlock(&mqueue_mnt->mnt_root->d_inode->i_mutex);
 out_putname:
 	putname(name);
 	return fd;
@@ -714,7 +714,7 @@ asmlinkage long sys_mq_unlink(const char
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 
-	down(&mqueue_mnt->mnt_root->d_inode->i_sem);
+	mutex_lock(&mqueue_mnt->mnt_root->d_inode->i_mutex);
 	dentry = lookup_one_len(name, mqueue_mnt->mnt_root, strlen(name));
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
@@ -735,7 +735,7 @@ out_err:
 	dput(dentry);
 
 out_unlock:
-	up(&mqueue_mnt->mnt_root->d_inode->i_sem);
+	mutex_unlock(&mqueue_mnt->mnt_root->d_inode->i_mutex);
 	putname(name);
 	if (inode)
 		iput(inode);
Index: linux/security/inode.c
===================================================================
--- linux.orig/security/inode.c
+++ linux/security/inode.c
@@ -172,7 +172,7 @@ static int create_by_name(const char *na
 		return -EFAULT;
 	}
 
-	down(&parent->d_inode->i_sem);
+	mutex_lock(&parent->d_inode->i_mutex);
 	*dentry = lookup_one_len(name, parent, strlen(name));
 	if (!IS_ERR(dentry)) {
 		if ((mode & S_IFMT) == S_IFDIR)
@@ -181,7 +181,7 @@ static int create_by_name(const char *na
 			error = create(parent->d_inode, *dentry, mode);
 	} else
 		error = PTR_ERR(dentry);
-	up(&parent->d_inode->i_sem);
+	mutex_unlock(&parent->d_inode->i_mutex);
 
 	return error;
 }
@@ -302,7 +302,7 @@ void securityfs_remove(struct dentry *de
 	if (!parent || !parent->d_inode)
 		return;
 
-	down(&parent->d_inode->i_sem);
+	mutex_lock(&parent->d_inode->i_mutex);
 	if (positive(dentry)) {
 		if (dentry->d_inode) {
 			if (S_ISDIR(dentry->d_inode->i_mode))
@@ -312,7 +312,7 @@ void securityfs_remove(struct dentry *de
 			dput(dentry);
 		}
 	}
-	up(&parent->d_inode->i_sem);
+	mutex_unlock(&parent->d_inode->i_mutex);
 	simple_release_fs(&mount, &mount_count);
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
Index: linux/sound/core/oss/pcm_oss.c
===================================================================
--- linux.orig/sound/core/oss/pcm_oss.c
+++ linux/sound/core/oss/pcm_oss.c
@@ -2141,9 +2141,9 @@ static ssize_t snd_pcm_oss_write(struct 
 	substream = pcm_oss_file->streams[SNDRV_PCM_STREAM_PLAYBACK];
 	if (substream == NULL)
 		return -ENXIO;
-	up(&file->f_dentry->d_inode->i_sem);
+	mutex_unlock(&file->f_dentry->d_inode->i_mutex);
 	result = snd_pcm_oss_write1(substream, buf, count);
-	down(&file->f_dentry->d_inode->i_sem);
+	mutex_lock(&file->f_dentry->d_inode->i_mutex);
 #ifdef OSS_DEBUG
 	printk("pcm_oss: write %li bytes (wrote %li bytes)\n", (long)count, (long)result);
 #endif
Index: linux/sound/core/seq/seq_memory.c
===================================================================
--- linux.orig/sound/core/seq/seq_memory.c
+++ linux/sound/core/seq/seq_memory.c
@@ -32,10 +32,6 @@
 #include "seq_info.h"
 #include "seq_lock.h"
 
-/* semaphore in struct file record */
-#define semaphore_of(fp)	((fp)->f_dentry->d_inode->i_sem)
-
-
 static inline int snd_seq_pool_available(pool_t *pool)
 {
 	return pool->total_elements - atomic_read(&pool->counter);
