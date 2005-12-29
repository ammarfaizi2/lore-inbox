Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVL2VGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVL2VGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 16:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbVL2VGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 16:06:11 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:53387 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750989AbVL2VGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 16:06:02 -0500
Date: Thu, 29 Dec 2005 22:05:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 13/13] mutex subsystem, more i_sem -> i_mutex conversions
Message-ID: <20051229210536.GN665@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

more i_sem -> i_mutex conversions that were needed for my .config.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
--

 fs/nfs/dir.c                |    6 +++---
 fs/nfs/file.c               |   12 ++++++------
 sound/core/oss/pcm_oss.c    |    4 ++--
 sound/core/seq/seq_memory.c |    4 ----
 4 files changed, 11 insertions(+), 15 deletions(-)

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
Index: linux/fs/nfs/file.c
===================================================================
--- linux.orig/fs/nfs/file.c
+++ linux/fs/nfs/file.c
@@ -434,9 +434,9 @@ static int do_unlk(struct file *filp, in
 	 * with locks..
 	 */
 	filemap_fdatawrite(filp->f_mapping);
-	down(&inode->i_sem);
+	mutex_lock(&inode->i_mutex);
 	nfs_wb_all(inode);
-	up(&inode->i_sem);
+	mutex_unlock(&inode->i_mutex);
 	filemap_fdatawait(filp->f_mapping);
 
 	/* NOTE: special case
@@ -467,9 +467,9 @@ static int do_setlk(struct file *filp, i
 	 */
 	status = filemap_fdatawrite(filp->f_mapping);
 	if (status == 0) {
-		down(&inode->i_sem);
+		mutex_lock(&inode->i_mutex);
 		status = nfs_wb_all(inode);
-		up(&inode->i_sem);
+		mutex_unlock(&inode->i_mutex);
 		if (status == 0)
 			status = filemap_fdatawait(filp->f_mapping);
 	}
@@ -498,9 +498,9 @@ static int do_setlk(struct file *filp, i
 	 * This makes locking act as a cache coherency point.
 	 */
 	filemap_fdatawrite(filp->f_mapping);
-	down(&inode->i_sem);
+	mutex_lock(&inode->i_mutex);
 	nfs_wb_all(inode);	/* we may have slept */
-	up(&inode->i_sem);
+	mutex_unlock(&inode->i_mutex);
 	filemap_fdatawait(filp->f_mapping);
 	nfs_zap_caches(inode);
 out:
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
