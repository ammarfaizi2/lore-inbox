Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTERQDk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 12:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbTERQDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 12:03:40 -0400
Received: from verein.lst.de ([212.34.181.86]:25608 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262116AbTERQDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 12:03:17 -0400
Date: Sun, 18 May 2003 18:15:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: perex@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove 2.2 compat cruft from sound/
Message-ID: <20030518181551.A28588@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, perex@suse.cz,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not that it actually is compilable due to random changes..


--- 1.20/sound/core/control.c	Thu Apr 10 12:28:10 2003
+++ edited/sound/core/control.c	Sat May 17 19:41:59 2003
@@ -931,9 +931,7 @@
 
 static struct file_operations snd_ctl_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_ctl_read,
 	.open =		snd_ctl_open,
 	.release =	snd_ctl_release,
===== sound/core/hwdep.c 1.12 vs edited =====
--- 1.12/sound/core/hwdep.c	Tue Feb 25 14:46:05 2003
+++ edited/sound/core/hwdep.c	Sat May 17 19:42:07 2003
@@ -292,9 +292,7 @@
 
 static struct file_operations snd_hwdep_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner = 	THIS_MODULE,
-#endif
 	.llseek =	snd_hwdep_llseek,
 	.read = 	snd_hwdep_read,
 	.write =	snd_hwdep_write,
===== sound/core/init.c 1.16 vs edited =====
--- 1.16/sound/core/init.c	Thu Mar 20 17:41:11 2003
+++ edited/sound/core/init.c	Sat May 17 19:42:50 2003
@@ -193,9 +193,7 @@
 		f_ops = &s_f_ops->f_ops;
 
 		memset(f_ops, 0, sizeof(*f_ops));
-#ifndef LINUX_2_2
 		f_ops->owner = file->f_op->owner;
-#endif
 		f_ops->release = file->f_op->release;
 		f_ops->poll = snd_disconnect_poll;
 
===== sound/core/memalloc.c 1.4 vs edited =====
--- 1.4/sound/core/memalloc.c	Fri Apr 11 07:38:48 2003
+++ edited/sound/core/memalloc.c	Sat May 17 19:49:24 2003
@@ -79,7 +79,6 @@
 #define snd_assert(expr, args...) /**/
 #endif
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
 #ifdef CONFIG_PCI
 #if defined(__i386__) || defined(__ppc__) || defined(__x86_64__)
 #define HACK_PCI_ALLOC_CONSISTENT
@@ -132,7 +131,6 @@
 
 #endif /* arch */
 #endif /* CONFIG_PCI */
-#endif /* LINUX >= 2.4.0 */
 
 
 /*
@@ -622,7 +620,7 @@
 }
 
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0) && defined(__i386__)
+#ifdef __i386__
 /*
  * on ix86, we allocate a page with GFP_KERNEL to assure the
  * allocation.  the code is almost same with kernel/i386/pci-dma.c but
===== sound/core/pcm_native.c 1.30 vs edited =====
--- 1.30/sound/core/pcm_native.c	Thu Apr 10 12:28:11 2003
+++ edited/sound/core/pcm_native.c	Sat May 17 19:46:29 2003
@@ -2494,9 +2494,6 @@
 	snd_pcm_runtime_t *runtime;
 	snd_pcm_sframes_t result;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 3, 0)
-	up(&file->f_dentry->d_inode->i_sem);
-#endif
 	pcm_file = snd_magic_cast(snd_pcm_file_t, file->private_data, result = -ENXIO; goto end);
 	substream = pcm_file->substream;
 	snd_assert(substream != NULL, result = -ENXIO; goto end);
@@ -2514,13 +2511,9 @@
 	if (result > 0)
 		result = frames_to_bytes(runtime, result);
  end:
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 3, 0)
-	down(&file->f_dentry->d_inode->i_sem);
-#endif
 	return result;
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 44)
 static ssize_t snd_pcm_readv(struct file *file, const struct iovec *_vector,
 			     unsigned long count, loff_t * offset)
 
@@ -2567,9 +2560,6 @@
 	void **bufs;
 	snd_pcm_uframes_t frames;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 3, 0)
-	up(&file->f_dentry->d_inode->i_sem);
-#endif
 	pcm_file = snd_magic_cast(snd_pcm_file_t, file->private_data, result = -ENXIO; goto end);
 	substream = pcm_file->substream;
 	snd_assert(substream != NULL, result = -ENXIO; goto end);
@@ -2594,12 +2584,8 @@
 		result = frames_to_bytes(runtime, result);
 	kfree(bufs);
  end:
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 3, 0)
-	down(&file->f_dentry->d_inode->i_sem);
-#endif
 	return result;
 }
-#endif
 
 unsigned int snd_pcm_playback_poll(struct file *file, poll_table * wait)
 {
@@ -2681,22 +2667,7 @@
 	return mask;
 }
 
-#ifndef VM_RESERVED
-#ifndef LINUX_2_2
-static int snd_pcm_mmap_swapout(struct page * page, struct file * file)
-#else
-static int snd_pcm_mmap_swapout(struct vm_area_struct * area, struct page * page)
-#endif
-{
-	return 0;
-}
-#endif
-
-#ifndef LINUX_2_2
 static struct page * snd_pcm_mmap_status_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
-#else
-static unsigned long snd_pcm_mmap_status_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
-#endif
 {
 	snd_pcm_substream_t *substream = (snd_pcm_substream_t *)area->vm_private_data;
 	snd_pcm_runtime_t *runtime;
@@ -2707,19 +2678,12 @@
 	runtime = substream->runtime;
 	page = virt_to_page(runtime->status);
 	get_page(page);
-#ifndef LINUX_2_2
 	return page;
-#else
-	return page_address(page);
-#endif
 }
 
 static struct vm_operations_struct snd_pcm_vm_ops_status =
 {
 	.nopage =	snd_pcm_mmap_status_nopage,
-#ifndef VM_RESERVED
-	.swapout =	snd_pcm_mmap_swapout,
-#endif
 };
 
 int snd_pcm_mmap_status(snd_pcm_substream_t *substream, struct file *file,
@@ -2735,22 +2699,12 @@
 	if (size != PAGE_ALIGN(sizeof(snd_pcm_mmap_status_t)))
 		return -EINVAL;
 	area->vm_ops = &snd_pcm_vm_ops_status;
-#ifndef LINUX_2_2
 	area->vm_private_data = substream;
-#else
-	area->vm_private_data = (long)substream;	
-#endif
-#ifdef VM_RESERVED
 	area->vm_flags |= VM_RESERVED;
-#endif
 	return 0;
 }
 
-#ifndef LINUX_2_2
 static struct page * snd_pcm_mmap_control_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
-#else
-static unsigned long snd_pcm_mmap_control_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
-#endif
 {
 	snd_pcm_substream_t *substream = (snd_pcm_substream_t *)area->vm_private_data;
 	snd_pcm_runtime_t *runtime;
@@ -2761,19 +2715,12 @@
 	runtime = substream->runtime;
 	page = virt_to_page(runtime->control);
 	get_page(page);
-#ifndef LINUX_2_2
 	return page;
-#else
-	return page_address(page);
-#endif
 }
 
 static struct vm_operations_struct snd_pcm_vm_ops_control =
 {
 	.nopage =	snd_pcm_mmap_control_nopage,
-#ifndef VM_RESERVED
-	.swapout =	snd_pcm_mmap_swapout,
-#endif
 };
 
 static int snd_pcm_mmap_control(snd_pcm_substream_t *substream, struct file *file,
@@ -2789,14 +2736,8 @@
 	if (size != PAGE_ALIGN(sizeof(snd_pcm_mmap_control_t)))
 		return -EINVAL;
 	area->vm_ops = &snd_pcm_vm_ops_control;
-#ifndef LINUX_2_2
 	area->vm_private_data = substream;
-#else
-	area->vm_private_data = (long)substream;	
-#endif
-#ifdef VM_RESERVED
 	area->vm_flags |= VM_RESERVED;
-#endif
 	return 0;
 }
 
@@ -2812,11 +2753,7 @@
 	atomic_dec(&substream->runtime->mmap_count);
 }
 
-#ifndef LINUX_2_2
 static struct page * snd_pcm_mmap_data_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
-#else
-static unsigned long snd_pcm_mmap_data_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
-#endif
 {
 	snd_pcm_substream_t *substream = (snd_pcm_substream_t *)area->vm_private_data;
 	snd_pcm_runtime_t *runtime;
@@ -2828,11 +2765,7 @@
 	if (substream == NULL)
 		return NOPAGE_OOM;
 	runtime = substream->runtime;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 25)
 	offset = area->vm_pgoff << PAGE_SHIFT;
-#else
-	offset = area->vm_offset;
-#endif
 	offset += address - area->vm_start;
 	snd_assert((offset % PAGE_SIZE) == 0, return NOPAGE_OOM);
 	dma_bytes = PAGE_ALIGN(runtime->dma_bytes);
@@ -2847,11 +2780,7 @@
 		page = virt_to_page(vaddr);
 	}
 	get_page(page);
-#ifndef LINUX_2_2
 	return page;
-#else
-	return page_address(page);
-#endif
 }
 
 static struct vm_operations_struct snd_pcm_vm_ops_data =
@@ -2859,9 +2788,6 @@
 	.open =		snd_pcm_mmap_data_open,
 	.close =	snd_pcm_mmap_data_close,
 	.nopage =	snd_pcm_mmap_data_nopage,
-#ifndef VM_RESERVED
-	.swapout =	snd_pcm_mmap_swapout,
-#endif
 };
 
 int snd_pcm_mmap_data(snd_pcm_substream_t *substream, struct file *file,
@@ -2889,11 +2815,7 @@
 	    runtime->access == SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
 		return -EINVAL;
 	size = area->vm_end - area->vm_start;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 25)
 	offset = area->vm_pgoff << PAGE_SHIFT;
-#else
-	offset = area->vm_offset;
-#endif
 	dma_bytes = PAGE_ALIGN(runtime->dma_bytes);
 	if ((size_t)size > dma_bytes)
 		return -EINVAL;
@@ -2901,14 +2823,8 @@
 		return -EINVAL;
 
 	area->vm_ops = &snd_pcm_vm_ops_data;
-#ifndef LINUX_2_2
 	area->vm_private_data = substream;
-#else
-	area->vm_private_data = (long)substream;
-#endif
-#ifdef VM_RESERVED
 	area->vm_flags |= VM_RESERVED;
-#endif
 	atomic_inc(&runtime->mmap_count);
 	return 0;
 }
@@ -2923,11 +2839,7 @@
 	substream = pcm_file->substream;
 	snd_assert(substream != NULL, return -ENXIO);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 25)
 	offset = area->vm_pgoff << PAGE_SHIFT;
-#else
-	offset = area->vm_offset;
-#endif
 	switch (offset) {
 	case SNDRV_PCM_MMAP_OFFSET_STATUS:
 		return snd_pcm_mmap_status(substream, file, area);
@@ -3035,13 +2947,9 @@
  */
 
 static struct file_operations snd_pcm_f_ops_playback = {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.write =	snd_pcm_write,
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 44)
 	.writev =	snd_pcm_writev,
-#endif
 	.open =		snd_pcm_open,
 	.release =	snd_pcm_release,
 	.poll =		snd_pcm_playback_poll,
@@ -3051,13 +2959,9 @@
 };
 
 static struct file_operations snd_pcm_f_ops_capture = {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_pcm_read,
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 44)
 	.readv =	snd_pcm_readv,
-#endif
 	.open =		snd_pcm_open,
 	.release =	snd_pcm_release,
 	.poll =		snd_pcm_capture_poll,
===== sound/core/rawmidi.c 1.23 vs edited =====
--- 1.23/sound/core/rawmidi.c	Thu Mar 20 17:41:12 2003
+++ edited/sound/core/rawmidi.c	Sat May 17 19:42:57 2003
@@ -1316,9 +1316,7 @@
 
 static struct file_operations snd_rawmidi_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_rawmidi_read,
 	.write =	snd_rawmidi_write,
 	.open =		snd_rawmidi_open,
===== sound/core/sound.c 1.27 vs edited =====
--- 1.27/sound/core/sound.c	Sat May 17 21:39:14 2003
+++ edited/sound/core/sound.c	Sat May 17 19:48:38 2003
@@ -157,9 +157,7 @@
 
 struct file_operations snd_fops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.open =		snd_open
 };
 
@@ -358,9 +356,6 @@
 #ifndef MODULE
 	printk(KERN_INFO "Advanced Linux Sound Architecture Driver Version " CONFIG_SND_VERSION CONFIG_SND_DATE ".\n");
 #endif
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0) && defined(CONFIG_APM)
-	pm_init();
-#endif
 	return err;
 }
 
@@ -375,9 +370,6 @@
 	snd_info_minor_unregister();
 #endif
 	snd_info_done();
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0) && defined(CONFIG_APM)
-	pm_done();
-#endif
 #ifdef CONFIG_SND_DEBUG_MEMORY
 	snd_memory_done();
 #endif
===== sound/core/timer.c 1.16 vs edited =====
--- 1.16/sound/core/timer.c	Thu Mar 20 17:41:13 2003
+++ edited/sound/core/timer.c	Sat May 17 19:43:13 2003
@@ -1733,9 +1733,7 @@
 
 static struct file_operations snd_timer_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_timer_user_read,
 	.open =		snd_timer_user_open,
 	.release =	snd_timer_user_release,
===== sound/core/oss/mixer_oss.c 1.16 vs edited =====
--- 1.16/sound/core/oss/mixer_oss.c	Thu Apr 10 12:28:10 2003
+++ edited/sound/core/oss/mixer_oss.c	Sat May 17 19:42:20 2003
@@ -376,9 +376,7 @@
 
 static struct file_operations snd_mixer_oss_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.open =		snd_mixer_oss_open,
 	.release =	snd_mixer_oss_release,
 	.ioctl =	snd_mixer_oss_ioctl,
===== sound/core/oss/pcm_oss.c 1.22 vs edited =====
--- 1.22/sound/core/oss/pcm_oss.c	Thu Apr 10 12:28:10 2003
+++ edited/sound/core/oss/pcm_oss.c	Sat May 17 19:48:13 2003
@@ -1981,11 +1981,7 @@
 	if (runtime->oss.plugin_first != NULL)
 		return -EIO;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 25)
 	if (area->vm_pgoff != 0)
-#else
-	if (area->vm_offset != 0)
-#endif
 		return -EINVAL;
 
 	err = snd_pcm_mmap_data(substream, file, area);
@@ -2148,9 +2144,7 @@
 
 static struct file_operations snd_pcm_oss_f_reg =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_pcm_oss_read,
 	.write =	snd_pcm_oss_write,
 	.open =		snd_pcm_oss_open,
===== sound/core/seq/seq_clientmgr.c 1.16 vs edited =====
--- 1.16/sound/core/seq/seq_clientmgr.c	Sat May 17 21:39:14 2003
+++ edited/sound/core/seq/seq_clientmgr.c	Sat May 17 19:41:03 2003
@@ -2458,9 +2458,7 @@
 
 static struct file_operations snd_seq_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		snd_seq_read,
 	.write =	snd_seq_write,
 	.open =		snd_seq_open,
===== sound/core/seq/seq_memory.c 1.7 vs edited =====
--- 1.7/sound/core/seq/seq_memory.c	Thu Apr 10 12:28:11 2003
+++ edited/sound/core/seq/seq_memory.c	Sat May 17 19:41:51 2003
@@ -235,18 +235,8 @@
 	while (pool->free == NULL && ! nonblock && ! pool->closing) {
 
 		spin_unlock(&pool->lock);
-#ifdef LINUX_2_2
-		/* change semaphore to allow other clients
-		   to access device file */
-		if (file)
-			up(&semaphore_of(file));
-#endif
+		/* XXX: this is racy and wants wait_event_interruptible_lock */
 		interruptible_sleep_on(&pool->output_sleep);
-#ifdef LINUX_2_2
-		/* restore semaphore again */
-		if (file)
-			down(&semaphore_of(file));
-#endif
 		spin_lock(&pool->lock);
 		/* interrupted? */
 		if (signal_pending(current)) {
===== sound/core/seq/oss/seq_oss.c 1.4 vs edited =====
--- 1.4/sound/core/seq/oss/seq_oss.c	Tue Oct  1 19:06:28 2002
+++ edited/sound/core/seq/oss/seq_oss.c	Sat May 17 19:40:54 2003
@@ -194,9 +194,7 @@
 
 static struct file_operations seq_oss_f_ops =
 {
-#ifndef LINUX_2_2
 	.owner =	THIS_MODULE,
-#endif
 	.read =		odev_read,
 	.write =	odev_write,
 	.open =		odev_open,
===== sound/oss/msnd.c 1.6 vs edited =====
--- 1.6/sound/oss/msnd.c	Mon Feb 11 03:50:14 2002
+++ edited/sound/oss/msnd.c	Sat May 17 19:54:36 2003
@@ -25,9 +25,6 @@
  ********************************************************************/
 
 #include <linux/version.h>
-#if LINUX_VERSION_CODE < 0x020101
-#  define LINUX20
-#endif
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -35,18 +32,10 @@
 #include <linux/types.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
-#ifdef LINUX20
-#  include <linux/major.h>
-#  include <linux/fs.h>
-#  include <linux/sound.h>
-#  include <asm/segment.h>
-#  include "sound_config.h"
-#else
-#  include <linux/init.h>
-#  include <asm/io.h>
-#  include <asm/uaccess.h>
-#  include <linux/spinlock.h>
-#endif
+#include <linux/init.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <linux/spinlock.h>
 #include <asm/irq.h>
 #include "msnd.h"
 
@@ -364,7 +353,6 @@
 	return -EIO;
 }
 
-#ifndef LINUX20
 EXPORT_SYMBOL(msnd_register);
 EXPORT_SYMBOL(msnd_unregister);
 EXPORT_SYMBOL(msnd_get_num_devs);
@@ -387,20 +375,7 @@
 
 EXPORT_SYMBOL(msnd_enable_irq);
 EXPORT_SYMBOL(msnd_disable_irq);
-#endif
 
-#ifdef MODULE
-MODULE_AUTHOR				("Andrew Veliath <andrewtv@usa.net>");
-MODULE_DESCRIPTION			("Turtle Beach MultiSound Driver Base");
+MODULE_AUTHOR("Andrew Veliath <andrewtv@usa.net>");
+MODULE_DESCRIPTION("Turtle Beach MultiSound Driver Base");
 MODULE_LICENSE("GPL");
-
-
-int init_module(void)
-{
-	return 0;
-}
-
-void cleanup_module(void)
-{
-}
-#endif
===== sound/oss/os.h 1.7 vs edited =====
--- 1.7/sound/oss/os.h	Thu Apr 24 12:36:55 2003
+++ edited/sound/oss/os.h	Sat May 17 20:16:40 2003
@@ -6,12 +6,6 @@
 
 #include <linux/module.h>
 #include <linux/version.h>
-
-#if LINUX_VERSION_CODE > 131328
-#define LINUX21X
-#endif
-
-#ifdef __KERNEL__
 #include <linux/utsname.h>
 #include <linux/string.h>
 #include <linux/fs.h>
@@ -30,7 +24,6 @@
 #include <asm/uaccess.h>
 #include <linux/poll.h>
 #include <linux/pci.h>
-#endif
 
 #include <linux/soundcard.h>
 
===== sound/oss/rme96xx.c 1.13 vs edited =====
--- 1.13/sound/oss/rme96xx.c	Mon Apr 21 09:32:53 2003
+++ edited/sound/oss/rme96xx.c	Sat May 17 19:53:37 2003
@@ -1758,9 +1758,7 @@
 
 
 static struct file_operations rme96xx_audio_fops = {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	.owner	 = THIS_MODULE,
-#endif
 	.read	 = rme96xx_read,
 	.write	 = rme96xx_write,
 	.poll	 = rme96xx_poll,
@@ -1857,9 +1855,7 @@
 }
 
 static /*const*/ struct file_operations rme96xx_mixer_fops = {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	.owner	 = THIS_MODULE,
-#endif
 	.ioctl	 = rme96xx_mixer_ioctl,
 	.open	 = rme96xx_mixer_open,
 	.release = rme96xx_mixer_release,
===== sound/pci/rme9652/hammerfall_mem.c 1.13 vs edited =====
--- 1.13/sound/pci/rme9652/hammerfall_mem.c	Thu Mar 20 17:41:15 2003
+++ edited/sound/pci/rme9652/hammerfall_mem.c	Sat May 17 19:44:12 2003
@@ -98,15 +98,7 @@
 {
 	void *res;
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 3, 0)
 	res = (void *) pci_alloc_consistent(pci, size, dmaaddr);
-#else
-	int pg;
-	for (pg = 0; PAGE_SIZE * (1 << pg) < size; pg++);
-	res = (void *)__get_free_pages(GFP_KERNEL, pg);
-	if (res != NULL)
-		*dmaaddr = virt_to_bus(res);
-#endif
 	if (res != NULL) {
 		struct page *page = virt_to_page(res);
 		struct page *last_page = page + (size + PAGE_SIZE - 1) / PAGE_SIZE;
@@ -127,19 +119,7 @@
 	last_page = virt_to_page(ptr) + (size + PAGE_SIZE - 1) / PAGE_SIZE;
 	while (page < last_page)
 		clear_bit(PG_reserved, &(page++)->flags);
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 3, 0)
 	pci_free_consistent(pci, size, ptr, dmaaddr);
-#else
-	{
-		int pg;
-		for (pg = 0; PAGE_SIZE * (1 << pg) < size; pg++);
-		if (bus_to_virt(dmaaddr) != ptr) {
-			printk(KERN_ERR "hammerfall_free_pages: dmaaddr != ptr\n");
-			return;
-		}
-		free_pages((unsigned long)ptr, pg);
-	}
-#endif
 }
 
 void *snd_hammerfall_get_buffer (struct pci_dev *pcidev, dma_addr_t *dmaaddr)
===== sound/ppc/awacs.c 1.10 vs edited =====
--- 1.10/sound/ppc/awacs.c	Thu Apr 10 12:28:14 2003
+++ edited/sound/ppc/awacs.c	Sat May 17 19:45:08 2003
@@ -32,7 +32,7 @@
 #define chip_t pmac_t
 
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0) || defined(CONFIG_ADB_CUDA)
+#if defined(CONFIG_ADB_CUDA)
 #define PMAC_AMP_AVAIL
 #endif
 
@@ -43,11 +43,7 @@
 	unsigned char amp_tone[2];
 } awacs_amp_t;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
-#define CHECK_CUDA_AMP() (adb_hardware == ADB_VIACUDA)
-#else
 #define CHECK_CUDA_AMP() (sys_ctrler == SYS_CTRLER_CUDA)
-#endif
 
 #endif /* PMAC_AMP_AVAIL */
 
===== sound/ppc/pmac.c 1.13 vs edited =====
--- 1.13/sound/ppc/pmac.c	Mon Apr 21 09:32:53 2003
+++ edited/sound/ppc/pmac.c	Sat May 17 19:44:26 2003
@@ -36,11 +36,6 @@
 #include <asm/feature.h>
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
-#define pmu_suspend()	/**/
-#define pmu_resume()	/**/
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,18)
 #define request_OF_resource(io,num,str)  1
 #define release_OF_resource(io,num) /**/
===== sound/ppc/pmac.h 1.4 vs edited =====
--- 1.4/sound/ppc/pmac.h	Thu Apr 10 12:28:14 2003
+++ edited/sound/ppc/pmac.h	Sat May 17 19:50:01 2003
@@ -27,18 +27,12 @@
 #include <sound/pcm.h>
 #include "awacs.h"
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
-#include <asm/adb.h>
-#include <asm/cuda.h>
-#include <asm/pmu.h>
-#else /* 2.4.0 kernel */
 #include <linux/adb.h>
 #ifdef CONFIG_ADB_CUDA
 #include <linux/cuda.h>
 #endif
 #ifdef CONFIG_ADB_PMU
 #include <linux/pmu.h>
-#endif
 #endif
 #include <linux/nvram.h>
 #include <linux/tty.h>
