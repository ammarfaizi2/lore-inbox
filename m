Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTE2PFf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 11:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbTE2PFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 11:05:35 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:35804 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262283AbTE2PFR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 11:05:17 -0400
Date: Thu, 29 May 2003 08:18:21 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: hugh@veritas.com
Cc: phillips@arcor.de, akpm@digeo.com, hch@infradead.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] Remove LINUX_2_2
Message-ID: <20030529151821.GB1397@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20030523114202.C5383@us.ibm.com> <20030529151424.GA1397@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529151424.GA1397@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 08:14:24AM -0700, Paul E. McKenney wrote:
> Rediffed for 2.5.70-mm1.  Some added lines of code due to following
> the "#ifndef LINUX_2_2" in the sound system.  The patch in the following
> email removes these #ifdefs on the off-chance that they are a
> holdover rather than the sound system's way of maintaining
> a single code base across all versions of Linux or some such.

This is the patch to remove the LINUX_2_2.  This patch depends
on the earlier install_new_page.2.5.70-mm1-3.patch sent earlier.

 					Thanx, Paul


diff -urN -X dontdiff linux-2.5.70-mm1.install_new_page/sound/core/control.c linux-2.5.70-mm1.loseLINUX_2_2/sound/core/control.c
--- linux-2.5.70-mm1.install_new_page/sound/core/control.c	2003-05-26 18:00:24.000000000 -0700
+++ linux-2.5.70-mm1.loseLINUX_2_2/sound/core/control.c	2003-05-28 22:41:51.000000000 -0700
@@ -931,9 +931,7 @@
 
 static struct file_operations snd_ctl_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_ctl_read,
 	.open =		snd_ctl_open,
 	.release =	snd_ctl_release,
diff -urN -X dontdiff linux-2.5.70-mm1.install_new_page/sound/core/hwdep.c linux-2.5.70-mm1.loseLINUX_2_2/sound/core/hwdep.c
--- linux-2.5.70-mm1.install_new_page/sound/core/hwdep.c	2003-05-26 18:00:21.000000000 -0700
+++ linux-2.5.70-mm1.loseLINUX_2_2/sound/core/hwdep.c	2003-05-28 22:41:51.000000000 -0700
@@ -292,9 +292,7 @@
 
 static struct file_operations snd_hwdep_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner = 	THIS_MODULE,
-#endif
 	.llseek =	snd_hwdep_llseek,
 	.read = 	snd_hwdep_read,
 	.write =	snd_hwdep_write,
diff -urN -X dontdiff linux-2.5.70-mm1.install_new_page/sound/core/info.c linux-2.5.70-mm1.loseLINUX_2_2/sound/core/info.c
--- linux-2.5.70-mm1.install_new_page/sound/core/info.c	2003-05-26 18:00:59.000000000 -0700
+++ linux-2.5.70-mm1.loseLINUX_2_2/sound/core/info.c	2003-05-28 22:41:51.000000000 -0700
@@ -126,27 +126,6 @@
 snd_info_entry_t *snd_oss_root = NULL;
 #endif
 
-#ifdef LINUX_2_2
-static void snd_info_fill_inode(struct inode *inode, int fill)
-{
-	if (fill)
-		MOD_INC_USE_COUNT;
-	else
-		MOD_DEC_USE_COUNT;
-}
-
-static inline void snd_info_entry_prepare(struct proc_dir_entry *de)
-{
-	de->fill_inode = snd_info_fill_inode;
-}
-
-void snd_remove_proc_entry(struct proc_dir_entry *parent,
-			   struct proc_dir_entry *de)
-{
-	if (parent && de)
-		proc_unregister(parent, de->low_ino);
-}
-#else
 static inline void snd_info_entry_prepare(struct proc_dir_entry *de)
 {
 	de->owner = THIS_MODULE;
@@ -158,7 +137,6 @@
 	if (de)
 		remove_proc_entry(de->name, parent);
 }
-#endif
 
 static loff_t snd_info_entry_llseek(struct file *file, loff_t offset, int orig)
 {
@@ -520,9 +498,7 @@
 
 static struct file_operations snd_info_entry_operations =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.llseek =	snd_info_entry_llseek,
 	.read =		snd_info_entry_read,
 	.write =	snd_info_entry_write,
@@ -533,67 +509,22 @@
 	.release =	snd_info_entry_release,
 };
 
-#ifdef LINUX_2_2
-static struct inode_operations snd_info_entry_inode_operations =
-{
-	&snd_info_entry_operations,	/* default sound info directory file-ops */
-};
-
-static struct inode_operations snd_info_device_inode_operations =
-{
-	&snd_fops,		/* default sound info directory file-ops */
-};
-#endif	/* LINUX_2_2 */
-
 static int snd_info_card_readlink(struct dentry *dentry,
 				  char *buffer, int buflen)
 {
         char *s = PDE(dentry->d_inode)->data;
-#ifndef LINUX_2_2
 	return vfs_readlink(dentry, buffer, buflen, s);
-#else
-	int len;
-	
-	if (s == NULL)
-		return -EIO;
-	len = strlen(s);
-	if (len > buflen)
-		len = buflen;
-	if (copy_to_user(buffer, s, len))
-		return -EFAULT;
-	return len;
-#endif
 }
 
-#ifndef LINUX_2_2
 static int snd_info_card_followlink(struct dentry *dentry,
 				    struct nameidata *nd)
 {
-        char *s = PDE(dentry->d_inode)->data;
-        return vfs_follow_link(nd, s);
-}
-#else
-static struct dentry *snd_info_card_followlink(struct dentry *dentry,
-					       struct dentry *base,
-					       unsigned int follow)
-{
 	char *s = PDE(dentry->d_inode)->data;
-	return lookup_dentry(s, base, follow);
+	return vfs_follow_link(nd, s);
 }
-#endif
-
-#ifdef LINUX_2_2
-static struct file_operations snd_info_card_link_operations =
-{
-	NULL
-};
-#endif
 
 struct inode_operations snd_info_card_link_inode_operations =
 {
-#ifdef LINUX_2_2
-	.default_file_ops =	&snd_info_card_link_operations,
-#endif
 	.readlink =		snd_info_card_readlink,
 	.follow_link =		snd_info_card_followlink,
 };
@@ -744,12 +675,8 @@
 	if (p == NULL)
 		return -ENOMEM;
 	p->data = s;
-#ifndef LINUX_2_2
 	p->owner = card->module;
 	p->proc_iops = &snd_info_card_link_inode_operations;
-#else
-	p->ops = &snd_info_card_link_inode_operations;
-#endif
 	card->proc_root_link = p;
 	return 0;
 }
@@ -1008,40 +935,11 @@
 	snd_magic_kfree(entry);
 }
 
-#ifdef LINUX_2_2
-static void snd_info_device_fill_inode(struct inode *inode, int fill)
-{
-	struct proc_dir_entry *de;
-	snd_info_entry_t *entry;
-
-	if (!fill) {
-		MOD_DEC_USE_COUNT;
-		return;
-	}
-	MOD_INC_USE_COUNT;
-	de = PDE(inode);
-	if (de == NULL)
-		return;
-	entry = (snd_info_entry_t *) de->data;
-	if (entry == NULL)
-		return;
-	inode->i_gid = device_gid;
-	inode->i_uid = device_uid;
-	inode->i_rdev = MKDEV(entry->c.device.major, entry->c.device.minor);
-}
-
-static inline void snd_info_device_entry_prepare(struct proc_dir_entry *de, snd_info_entry_t *entry)
-{
-	de->fill_inode = snd_info_device_fill_inode;
-	de->ops = &snd_info_device_inode_operations;
-}
-#else
 static inline void snd_info_device_entry_prepare(struct proc_dir_entry *de, snd_info_entry_t *entry)
 {
 	de->rdev = mk_kdev(entry->c.device.major, entry->c.device.minor);
 	de->owner = THIS_MODULE;
 }
-#endif /* LINUX_2_2 */
 
 /*
  * create a procfs device file
@@ -1119,15 +1017,9 @@
 		up(&info_mutex);
 		return -ENOMEM;
 	}
-#ifndef LINUX_2_2
 	p->owner = entry->module;
-#endif
 	if (!S_ISDIR(entry->mode)) {
-#ifndef LINUX_2_2
 		p->proc_fops = &snd_info_entry_operations;
-#else
-		p->ops = &snd_info_entry_inode_operations;
-#endif
 	}
 	p->size = entry->size;
 	p->data = entry;
diff -urN -X dontdiff linux-2.5.70-mm1.install_new_page/sound/core/init.c linux-2.5.70-mm1.loseLINUX_2_2/sound/core/init.c
--- linux-2.5.70-mm1.install_new_page/sound/core/init.c	2003-05-26 18:00:25.000000000 -0700
+++ linux-2.5.70-mm1.loseLINUX_2_2/sound/core/init.c	2003-05-28 22:41:51.000000000 -0700
@@ -193,9 +193,7 @@
 		f_ops = &s_f_ops->f_ops;
 
 		memset(f_ops, 0, sizeof(*f_ops));
-#ifndef LINUX_2_2
 		f_ops->owner = file->f_op->owner;
-#endif
 		f_ops->release = file->f_op->release;
 		f_ops->poll = snd_disconnect_poll;
 
diff -urN -X dontdiff linux-2.5.70-mm1.install_new_page/sound/core/oss/mixer_oss.c linux-2.5.70-mm1.loseLINUX_2_2/sound/core/oss/mixer_oss.c
--- linux-2.5.70-mm1.install_new_page/sound/core/oss/mixer_oss.c	2003-05-26 18:00:42.000000000 -0700
+++ linux-2.5.70-mm1.loseLINUX_2_2/sound/core/oss/mixer_oss.c	2003-05-28 22:41:51.000000000 -0700
@@ -376,9 +376,7 @@
 
 static struct file_operations snd_mixer_oss_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.open =		snd_mixer_oss_open,
 	.release =	snd_mixer_oss_release,
 	.ioctl =	snd_mixer_oss_ioctl,
diff -urN -X dontdiff linux-2.5.70-mm1.install_new_page/sound/core/oss/pcm_oss.c linux-2.5.70-mm1.loseLINUX_2_2/sound/core/oss/pcm_oss.c
--- linux-2.5.70-mm1.install_new_page/sound/core/oss/pcm_oss.c	2003-05-26 18:00:56.000000000 -0700
+++ linux-2.5.70-mm1.loseLINUX_2_2/sound/core/oss/pcm_oss.c	2003-05-28 22:41:51.000000000 -0700
@@ -2148,9 +2148,7 @@
 
 static struct file_operations snd_pcm_oss_f_reg =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_pcm_oss_read,
 	.write =	snd_pcm_oss_write,
 	.open =		snd_pcm_oss_open,
diff -urN -X dontdiff linux-2.5.70-mm1.install_new_page/sound/core/pcm_native.c linux-2.5.70-mm1.loseLINUX_2_2/sound/core/pcm_native.c
--- linux-2.5.70-mm1.install_new_page/sound/core/pcm_native.c	2003-05-28 21:39:45.000000000 -0700
+++ linux-2.5.70-mm1.loseLINUX_2_2/sound/core/pcm_native.c	2003-05-28 22:46:38.000000000 -0700
@@ -60,11 +60,6 @@
 static int snd_pcm_hw_refine_old_user(snd_pcm_substream_t * substream, struct sndrv_pcm_hw_params_old * _oparams);
 static int snd_pcm_hw_params_old_user(snd_pcm_substream_t * substream, struct sndrv_pcm_hw_params_old * _oparams);
 
-#ifndef LINUX_2_2
-#define NOPAGE_OOM VM_FAULT_OOM
-#define NOPAGE_SIGBUS VM_FAULT_SIGBUS
-#endif
-
 /*
  *
  */
@@ -2687,21 +2682,13 @@
 }
 
 #ifndef VM_RESERVED
-#ifndef LINUX_2_2
 static int snd_pcm_mmap_swapout(struct page * page, struct file * file)
-#else
-static int snd_pcm_mmap_swapout(struct vm_area_struct * area, struct page * page)
-#endif
 {
 	return 0;
 }
 #endif
 
-#ifndef LINUX_2_2
 static int snd_pcm_mmap_status_nopage(struct mm_struct *mm, struct vm_area_struct *area, unsigned long address, int write_access, pmd_t *pmd)
-#else
-static unsigned long snd_pcm_mmap_status_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
-#endif
 {
 	snd_pcm_substream_t *substream = (snd_pcm_substream_t *)area->vm_private_data;
 	snd_pcm_runtime_t *runtime;
@@ -2712,11 +2699,7 @@
 	runtime = substream->runtime;
 	page = virt_to_page(runtime->status);
 	get_page(page);
-#ifndef LINUX_2_2
 	return install_new_page(mm, area, address, write_access, pmd, page);
-#else
-	return page_address(page);
-#endif
 }
 
 static struct vm_operations_struct snd_pcm_vm_ops_status =
@@ -2740,22 +2723,14 @@
 	if (size != PAGE_ALIGN(sizeof(snd_pcm_mmap_status_t)))
 		return -EINVAL;
 	area->vm_ops = &snd_pcm_vm_ops_status;
-#ifndef LINUX_2_2
 	area->vm_private_data = substream;
-#else
-	area->vm_private_data = (long)substream;	
-#endif
 #ifdef VM_RESERVED
 	area->vm_flags |= VM_RESERVED;
 #endif
 	return 0;
 }
 
-#ifndef LINUX_2_2
 static int snd_pcm_mmap_control_nopage(struct mm_struct *mm, struct vm_area_struct *area, unsigned long address, int write_access, pmd_t *pmd)
-#else
-static unsigned long snd_pcm_mmap_control_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
-#endif
 {
 	snd_pcm_substream_t *substream = (snd_pcm_substream_t *)area->vm_private_data;
 	snd_pcm_runtime_t *runtime;
@@ -2766,11 +2741,7 @@
 	runtime = substream->runtime;
 	page = virt_to_page(runtime->control);
 	get_page(page);
-#ifndef LINUX_2_2
 	return install_new_page(mm, area, address, write_access, pmd, page);
-#else
-	return page_address(page);
-#endif
 }
 
 static struct vm_operations_struct snd_pcm_vm_ops_control =
@@ -2794,11 +2765,7 @@
 	if (size != PAGE_ALIGN(sizeof(snd_pcm_mmap_control_t)))
 		return -EINVAL;
 	area->vm_ops = &snd_pcm_vm_ops_control;
-#ifndef LINUX_2_2
 	area->vm_private_data = substream;
-#else
-	area->vm_private_data = (long)substream;	
-#endif
 #ifdef VM_RESERVED
 	area->vm_flags |= VM_RESERVED;
 #endif
@@ -2817,11 +2784,7 @@
 	atomic_dec(&substream->runtime->mmap_count);
 }
 
-#ifndef LINUX_2_2
 static int snd_pcm_mmap_data_nopage(struct mm_struct *mm, struct vm_area_struct *area, unsigned long address, int write_access, pmd_t *pmd)
-#else
-static unsigned long snd_pcm_mmap_data_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
-#endif
 {
 	snd_pcm_substream_t *substream = (snd_pcm_substream_t *)area->vm_private_data;
 	snd_pcm_runtime_t *runtime;
@@ -2852,11 +2815,7 @@
 		page = virt_to_page(vaddr);
 	}
 	get_page(page);
-#ifndef LINUX_2_2
 	return install_new_page(mm, area, address, write_access, pmd, page);
-#else
-	return page_address(page);
-#endif
 }
 
 static struct vm_operations_struct snd_pcm_vm_ops_data =
@@ -2906,11 +2865,7 @@
 		return -EINVAL;
 
 	area->vm_ops = &snd_pcm_vm_ops_data;
-#ifndef LINUX_2_2
 	area->vm_private_data = substream;
-#else
-	area->vm_private_data = (long)substream;
-#endif
 #ifdef VM_RESERVED
 	area->vm_flags |= VM_RESERVED;
 #endif
@@ -3040,9 +2995,7 @@
  */
 
 static struct file_operations snd_pcm_f_ops_playback = {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.write =	snd_pcm_write,
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 44)
 	.writev =	snd_pcm_writev,
@@ -3056,9 +3009,7 @@
 };
 
 static struct file_operations snd_pcm_f_ops_capture = {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_pcm_read,
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 44)
 	.readv =	snd_pcm_readv,
diff -urN -X dontdiff linux-2.5.70-mm1.install_new_page/sound/core/rawmidi.c linux-2.5.70-mm1.loseLINUX_2_2/sound/core/rawmidi.c
--- linux-2.5.70-mm1.install_new_page/sound/core/rawmidi.c	2003-05-26 18:00:24.000000000 -0700
+++ linux-2.5.70-mm1.loseLINUX_2_2/sound/core/rawmidi.c	2003-05-28 22:41:51.000000000 -0700
@@ -1316,9 +1316,7 @@
 
 static struct file_operations snd_rawmidi_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_rawmidi_read,
 	.write =	snd_rawmidi_write,
 	.open =		snd_rawmidi_open,
diff -urN -X dontdiff linux-2.5.70-mm1.install_new_page/sound/core/seq/oss/seq_oss.c linux-2.5.70-mm1.loseLINUX_2_2/sound/core/seq/oss/seq_oss.c
--- linux-2.5.70-mm1.install_new_page/sound/core/seq/oss/seq_oss.c	2003-05-26 18:00:46.000000000 -0700
+++ linux-2.5.70-mm1.loseLINUX_2_2/sound/core/seq/oss/seq_oss.c	2003-05-28 22:41:51.000000000 -0700
@@ -194,9 +194,7 @@
 
 static struct file_operations seq_oss_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		odev_read,
 	.write =	odev_write,
 	.open =		odev_open,
diff -urN -X dontdiff linux-2.5.70-mm1.install_new_page/sound/core/seq/seq_clientmgr.c linux-2.5.70-mm1.loseLINUX_2_2/sound/core/seq/seq_clientmgr.c
--- linux-2.5.70-mm1.install_new_page/sound/core/seq/seq_clientmgr.c	2003-05-26 18:00:24.000000000 -0700
+++ linux-2.5.70-mm1.loseLINUX_2_2/sound/core/seq/seq_clientmgr.c	2003-05-28 22:41:51.000000000 -0700
@@ -2454,9 +2454,7 @@
 
 static struct file_operations snd_seq_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_seq_read,
 	.write =	snd_seq_write,
 	.open =		snd_seq_open,
diff -urN -X dontdiff linux-2.5.70-mm1.install_new_page/sound/core/seq/seq_memory.c linux-2.5.70-mm1.loseLINUX_2_2/sound/core/seq/seq_memory.c
--- linux-2.5.70-mm1.install_new_page/sound/core/seq/seq_memory.c	2003-05-26 18:00:23.000000000 -0700
+++ linux-2.5.70-mm1.loseLINUX_2_2/sound/core/seq/seq_memory.c	2003-05-28 22:41:51.000000000 -0700
@@ -235,18 +235,7 @@
 	while (pool->free == NULL && ! nonblock && ! pool->closing) {
 
 		spin_unlock(&pool->lock);
-#ifdef LINUX_2_2
-		/* change semaphore to allow other clients
-		   to access device file */
-		if (file)
-			up(&semaphore_of(file));
-#endif
 		interruptible_sleep_on(&pool->output_sleep);
-#ifdef LINUX_2_2
-		/* restore semaphore again */
-		if (file)
-			down(&semaphore_of(file));
-#endif
 		spin_lock(&pool->lock);
 		/* interrupted? */
 		if (signal_pending(current)) {
diff -urN -X dontdiff linux-2.5.70-mm1.install_new_page/sound/core/sound.c linux-2.5.70-mm1.loseLINUX_2_2/sound/core/sound.c
--- linux-2.5.70-mm1.install_new_page/sound/core/sound.c	2003-05-26 18:00:43.000000000 -0700
+++ linux-2.5.70-mm1.loseLINUX_2_2/sound/core/sound.c	2003-05-28 22:41:51.000000000 -0700
@@ -157,9 +157,7 @@
 
 struct file_operations snd_fops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.open =		snd_open
 };
 
diff -urN -X dontdiff linux-2.5.70-mm1.install_new_page/sound/core/timer.c linux-2.5.70-mm1.loseLINUX_2_2/sound/core/timer.c
--- linux-2.5.70-mm1.install_new_page/sound/core/timer.c	2003-05-26 18:00:41.000000000 -0700
+++ linux-2.5.70-mm1.loseLINUX_2_2/sound/core/timer.c	2003-05-28 22:41:51.000000000 -0700
@@ -1733,9 +1733,7 @@
 
 static struct file_operations snd_timer_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_timer_user_read,
 	.open =		snd_timer_user_open,
 	.release =	snd_timer_user_release,
