Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVCWXtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVCWXtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVCWXtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:49:11 -0500
Received: from mail.dif.dk ([193.138.115.101]:36018 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262115AbVCWXlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:41:53 -0500
Date: Thu, 24 Mar 2005 00:43:37 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net,
       "Rickard E. (Rik) Faith" <faith@valinux.com>,
       Gareth Hughes <gareth@valinux.com>
Subject: drivers/char/drm/ severely broken - with this it at least builds
Message-ID: <Pine.LNX.4.62.0503240029270.7460@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Parts of drivers/char/drm/ is severely broken in 2.6.12-rc1-mm1 - this is 
fair enough since it /is/ marked as broken. So, why am I writing this 
mail? Well, I /tried/ to build some of the stuff in there, saw it blow up, 
then tried to fix it, then gave up trying to fix it, got it into a state 
where it's still completely broken and will blow up pretty bad if you try 
to use it, but at least it now builds. I have absolutely no idea if any of 
the changes I made will be useful to anyone, but I thought I'd at least 
submit a patch with the changes I made, and if bits of it are useful, then 
good, if not - ohh well..

See further below for some of the warnings and errors I initially got that 
prompted my to try and fix it.

Here's a patch with the changes I made - very ugly, very broken, possibly 
worse than it was, but perhaps there are some bits that are useful - you 
never know.  :

diff -uprN linux-2.6.12-rc1-mm1-orig/drivers/char/drm/drmP.h linux-2.6.12-rc1-mm1/drivers/char/drm/drmP.h
--- linux-2.6.12-rc1-mm1-orig/drivers/char/drm/drmP.h	2005-03-21 23:15:34.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/char/drm/drmP.h	2005-03-24 00:17:38.000000000 +0100
@@ -423,6 +423,7 @@ typedef struct drm_file {
 	struct drm_file	  *next;
 	struct drm_file	  *prev;
 	struct drm_head   *head;
+	struct drm_device *dev;
 	int 		  remove_auth_on_close;
 	unsigned long     lock_count;
 	void              *driver_priv;
@@ -737,6 +738,7 @@ typedef struct drm_device {
 	struct            drm_driver *driver;
 	drm_local_map_t   *agp_buffer_map;
 	drm_head_t primary;		/**< primary screen head */
+	u32               driver_features;
 } drm_device_t;
 
 static __inline__ int drm_core_check_feature(struct drm_device *dev, int feature)
diff -uprN linux-2.6.12-rc1-mm1-orig/drivers/char/drm/drm_memory.h linux-2.6.12-rc1-mm1/drivers/char/drm/drm_memory.h
--- linux-2.6.12-rc1-mm1-orig/drivers/char/drm/drm_memory.h	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/char/drm/drm_memory.h	2005-03-24 00:03:53.000000000 +0100
@@ -33,6 +33,9 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#ifndef __DRM_MEMORY_H
+#define __DRM_MEMORY_H
+
 #include <linux/config.h>
 #include <linux/highmem.h>
 #include <linux/vmalloc.h>
@@ -194,4 +197,4 @@ static inline void drm_ioremapfree(void 
 	iounmap(pt);
 }
 
-
+#endif	/* __DRM_MEMORY_H */
diff -uprN linux-2.6.12-rc1-mm1-orig/drivers/char/drm/drm_os_linux.h linux-2.6.12-rc1-mm1/drivers/char/drm/drm_os_linux.h
--- linux-2.6.12-rc1-mm1-orig/drivers/char/drm/drm_os_linux.h	2005-03-21 23:12:26.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/char/drm/drm_os_linux.h	2005-03-24 00:18:57.000000000 +0100
@@ -89,7 +89,7 @@ static __inline__ int mtrr_del (int reg,
 	copy_to_user(arg1, arg2, arg3)
 /* Macros for copyfrom user, but checking readability only once */
 #define DRM_VERIFYAREA_READ( uaddr, size ) 		\
-	verify_area( VERIFY_READ, uaddr, size )
+	(access_ok( VERIFY_READ, uaddr, size ) ? 0 : -EFAULT)
 #define DRM_COPY_FROM_USER_UNCHECKED(arg1, arg2, arg3) 	\
 	__copy_from_user(arg1, arg2, arg3)
 #define DRM_COPY_TO_USER_UNCHECKED(arg1, arg2, arg3)	\
diff -uprN linux-2.6.12-rc1-mm1-orig/drivers/char/drm/gamma.h linux-2.6.12-rc1-mm1/drivers/char/drm/gamma.h
--- linux-2.6.12-rc1-mm1-orig/drivers/char/drm/gamma.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/char/drm/gamma.h	2005-03-23 23:35:20.000000000 +0100
@@ -0,0 +1,4 @@
+#ifndef __GAMMA_H__
+#define __GAMMA_H__
+#define DRM(x) gamma_##x
+#endif
diff -uprN linux-2.6.12-rc1-mm1-orig/drivers/char/drm/gamma_context.h linux-2.6.12-rc1-mm1/drivers/char/drm/gamma_context.h
--- linux-2.6.12-rc1-mm1-orig/drivers/char/drm/gamma_context.h	2005-03-02 08:38:06.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/char/drm/gamma_context.h	2005-03-24 00:01:26.000000000 +0100
@@ -190,12 +190,14 @@ int DRM(context_switch_complete)(drm_dev
 		DRM_ERROR("Lock isn't held after context switch\n");
 	}
 
+/*
 	if (!dma || !(dma->next_buffer && dma->next_buffer->while_locked)) {
 		if (DRM(lock_free)(dev, &dev->lock.hw_lock->lock,
 				  DRM_KERNEL_CONTEXT)) {
 			DRM_ERROR("Cannot free lock\n");
 		}
 	}
+*/
 
 	clear_bit(0, &dev->context_flag);
 	wake_up_interruptible(&dev->context_wait);
diff -uprN linux-2.6.12-rc1-mm1-orig/drivers/char/drm/gamma_dma.c linux-2.6.12-rc1-mm1/drivers/char/drm/gamma_dma.c
--- linux-2.6.12-rc1-mm1-orig/drivers/char/drm/gamma_dma.c	2005-03-02 08:38:26.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/char/drm/gamma_dma.c	2005-03-24 00:16:43.000000000 +0100
@@ -136,10 +136,10 @@ irqreturn_t gamma_driver_irq_handler( DR
 				/* Free previous buffer */
 		if (test_and_set_bit(0, &dev->dma_flag))
 			return IRQ_HANDLED;
-		if (dma->this_buffer) {
+/*		if (dma->this_buffer) {
 			gamma_free_buffer(dev, dma->this_buffer);
 			dma->this_buffer = NULL;
-		}
+		} */
 		clear_bit(0, &dev->dma_flag);
 
 		/* Dispatch new buffer */
@@ -160,13 +160,13 @@ static int gamma_do_dma(drm_device_t *de
 	if (test_and_set_bit(0, &dev->dma_flag)) return -EBUSY;
 
 
-	if (!dma->next_buffer) {
+/*	if (!dma->next_buffer) {
 		DRM_ERROR("No next_buffer\n");
 		clear_bit(0, &dev->dma_flag);
 		return -EINVAL;
-	}
+	} */
 
-	buf	= dma->next_buffer;
+//	buf	= dma->next_buffer;
 	/* WE NOW ARE ON LOGICAL PAGES!! - using page table setup in dma_init */
 	/* So we pass the buffer index value into the physical page offset */
 	address = buf->idx << 12;
@@ -175,12 +175,12 @@ static int gamma_do_dma(drm_device_t *de
 	DRM_DEBUG("context %d, buffer %d (%ld bytes)\n",
 		  buf->context, buf->idx, length);
 
-	if (buf->list == DRM_LIST_RECLAIM) {
+/*	if (buf->list == DRM_LIST_RECLAIM) {
 		gamma_clear_next_buffer(dev);
 		gamma_free_buffer(dev, buf);
 		clear_bit(0, &dev->dma_flag);
 		return -EINVAL;
-	}
+	} */
 
 	if (!length) {
 		DRM_ERROR("0 length buffer\n");
@@ -195,7 +195,7 @@ static int gamma_do_dma(drm_device_t *de
 		return -EBUSY;
 	}
 
-	if (buf->while_locked) {
+/*	if (buf->while_locked) {
 		if (!_DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock)) {
 			DRM_ERROR("Dispatching buffer %d from pid %d"
 				  " \"while locked\", but no lock held\n",
@@ -208,47 +208,48 @@ static int gamma_do_dma(drm_device_t *de
 			return -EBUSY;
 		}
 	}
-
-	if (dev->last_context != buf->context
+*/
+/*	if (dev->last_context != buf->context
 	    && !(dev->queuelist[buf->context]->flags
 		 & _DRM_CONTEXT_PRESERVED)) {
+*/
 				/* PRE: dev->last_context != buf->context */
-		if (DRM(context_switch)(dev, dev->last_context,
+/*		if (DRM(context_switch)(dev, dev->last_context,
 					buf->context)) {
 			DRM(clear_next_buffer)(dev);
 			DRM(free_buffer)(dev, buf);
 		}
 		retcode = -EBUSY;
 		goto cleanup;
-
+*/
 				/* POST: we will wait for the context
 				   switch and will dispatch on a later call
 				   when dev->last_context == buf->context.
 				   NOTE WE HOLD THE LOCK THROUGHOUT THIS
 				   TIME! */
-	}
+/*	} */
 
 	gamma_clear_next_buffer(dev);
-	buf->pending	 = 1;
-	buf->waiting	 = 0;
-	buf->list	 = DRM_LIST_PEND;
+//	buf->pending	 = 1;
+//	buf->waiting	 = 0;
+//	buf->list	 = DRM_LIST_PEND;
 
 	/* WE NOW ARE ON LOGICAL PAGES!!! - overriding address */
-	address = buf->idx << 12;
+//	address = buf->idx << 12;
 
 	gamma_dma_dispatch(dev, address, length);
-	gamma_free_buffer(dev, dma->this_buffer);
-	dma->this_buffer = buf;
+//	gamma_free_buffer(dev, dma->this_buffer);
+//	dma->this_buffer = buf;
 
 	atomic_inc(&dev->counts[7]); /* _DRM_STAT_DMA */
 	atomic_add(length, &dev->counts[8]); /* _DRM_STAT_PRIMARY */
 
-	if (!buf->while_locked && !dev->context_flag && !locked) {
+/*	if (!buf->while_locked && !dev->context_flag && !locked) {
 		if (gamma_lock_free(dev, &dev->lock.hw_lock->lock,
 				  DRM_KERNEL_CONTEXT)) {
 			DRM_ERROR("\n");
 		}
-	}
+	} */
 cleanup:
 
 	clear_bit(0, &dev->dma_flag);
@@ -291,13 +292,13 @@ again:
 		clear_bit(0, &dev->interrupt_flag);
 		return -EBUSY;
 	}
-	if (dma->next_buffer) {
+//	if (dma->next_buffer) {
 				/* Unsent buffer that was previously
 				   selected, but that couldn't be sent
 				   because the lock could not be obtained
 				   or the DMA engine wasn't ready.  Try
 				   again. */
-		if (!(retcode = gamma_do_dma(dev, locked))) ++processed;
+/*		if (!(retcode = gamma_do_dma(dev, locked))) ++processed;
 	} else {
 		do {
 			next = gamma_select_queue(dev, gamma_dma_timer_bh);
@@ -318,7 +319,7 @@ again:
 			}
 		}
 	}
-
+*/
 	if (--expire) {
 		if (missed != atomic_read(&dev->counts[10])) {
 			if (gamma_dma_is_ready(dev)) goto again;
@@ -937,10 +938,10 @@ void gamma_driver_register_fns(drm_devic
 	dev->driver_features = DRIVER_USE_AGP | DRIVER_USE_MTRR | DRIVER_PCI_DMA | DRIVER_HAVE_DMA | DRIVER_HAVE_IRQ;
 	DRM(fops).read = gamma_fops_read;
 	DRM(fops).poll = gamma_fops_poll;
-	dev->driver.preinit = gamma_driver_preinit;
-	dev->driver.pretakedown = gamma_driver_pretakedown;
-	dev->driver.dma_ready = gamma_driver_dma_ready;
-	dev->driver.dma_quiescent = gamma_driver_dma_quiescent;
-	dev->driver.dma_flush_block_and_flush = gamma_flush_block_and_flush;
-	dev->driver.dma_flush_unblock = gamma_flush_unblock;
+	dev->driver->preinit = gamma_driver_preinit;
+	dev->driver->pretakedown = gamma_driver_pretakedown;
+	dev->driver->dma_ready = gamma_driver_dma_ready;
+	dev->driver->dma_quiescent = gamma_driver_dma_quiescent;
+//	dev->driver->dma_flush_block_and_flush = gamma_flush_block_and_flush;
+//	dev->driver->dma_flush_unblock = gamma_flush_unblock;
 }
diff -uprN linux-2.6.12-rc1-mm1-orig/drivers/char/drm/gamma_drv.c linux-2.6.12-rc1-mm1/drivers/char/drm/gamma_drv.c
--- linux-2.6.12-rc1-mm1-orig/drivers/char/drm/gamma_drv.c	2005-03-02 08:38:38.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/char/drm/gamma_drv.c	2005-03-24 00:27:51.000000000 +0100
@@ -36,24 +36,8 @@
 #include "gamma_drm.h"
 #include "gamma_drv.h"
 
-#include "drm_auth.h"
-#include "drm_agpsupport.h"
-#include "drm_bufs.h"
 #include "gamma_context.h"	/* NOTE! */
-#include "drm_dma.h"
 #include "gamma_old_dma.h"	/* NOTE */
-#include "drm_drawable.h"
-#include "drm_drv.h"
 
-#include "drm_fops.h"
-#include "drm_init.h"
-#include "drm_ioctl.h"
-#include "drm_irq.h"
 #include "gamma_lists.h"        /* NOTE */
-#include "drm_lock.h"
-#include "gamma_lock.h"		/* NOTE */
 #include "drm_memory.h"
-#include "drm_proc.h"
-#include "drm_vm.h"
-#include "drm_stub.h"
-#include "drm_scatter.h"
diff -uprN linux-2.6.12-rc1-mm1-orig/drivers/char/drm/gamma_old_dma.h linux-2.6.12-rc1-mm1/drivers/char/drm/gamma_old_dma.h
--- linux-2.6.12-rc1-mm1-orig/drivers/char/drm/gamma_old_dma.h	2005-03-02 08:38:38.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/char/drm/gamma_old_dma.h	2005-03-24 00:02:04.000000000 +0100
@@ -37,11 +37,13 @@ void DRM(clear_next_buffer)(drm_device_t
 {
 	drm_device_dma_t *dma = dev->dma;
 
+/*
 	dma->next_buffer = NULL;
 	if (dma->next_queue && !DRM_BUFCOUNT(&dma->next_queue->waitlist)) {
 		wake_up_interruptible(&dma->next_queue->flush_queue);
 	}
 	dma->next_queue	 = NULL;
+*/
 }
 
 int DRM(select_queue)(drm_device_t *dev, void (*wrapper)(unsigned long))





These are the initial errors I got - see further below for what they are 
reduced to with the above patch.

  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CC [M]  drivers/char/drm/gamma_drv.o
drivers/char/drm/gamma_drv.c:33:19: gamma.h: No such file or directory
In file included from drivers/char/drm/gamma_drv.c:37:
drivers/char/drm/gamma_drv.h:66: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_drv.h:66: warning: parameter names (without types) in function declaration
drivers/char/drm/gamma_drv.h:68: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_drv.h:68: warning: parameter names (without types) in function declaration
drivers/char/drm/gamma_drv.h:70: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_drv.h:70: warning: parameter names (without types) in function declaration
drivers/char/drm/gamma_drv.h:74: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_drv.h:74: warning: parameter names (without types) in function declaration
drivers/char/drm/gamma_drv.h:76: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_drv.h:76: warning: parameter names (without types) in function declaration
drivers/char/drm/gamma_drv.h:77: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_drv.h:77: warning: parameter names (without types) in function declaration
drivers/char/drm/gamma_drv.h:78: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_drv.h:78: warning: parameter names (without types) in function declaration
drivers/char/drm/gamma_drv.h:83: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_drv.h:83: warning: parameter names (without types) in function declaration
drivers/char/drm/gamma_drv.h:84: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_drv.h:84: warning: parameter names (without types) in function declaration
drivers/char/drm/gamma_drv.h:85: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_drv.h:85: warning: parameter names (without types) in function declaration
drivers/char/drm/gamma_drv.h:86: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_drv.h:86: warning: parameter names (without types) in function declaration
drivers/char/drm/gamma_drv.h:87: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_drv.h:87: warning: parameter names (without types) in function declaration
drivers/char/drm/gamma_drv.h:88: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_drv.h:88: warning: parameter names (without types) in function declaration
drivers/char/drm/gamma_drv.h:90: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_drv.h:90: warning: parameter names (without types) in function declaration
drivers/char/drm/gamma_drv.h:91: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_drv.h:91: warning: parameter names (without types) in function declaration
drivers/char/drm/gamma_drv.h:94: warning: parameter names (without types) in function declaration
drivers/char/drm/gamma_drv.h:94: error: conflicting types for 'DRM'
drivers/char/drm/gamma_drv.h:91: error: previous declaration of 'DRM' was here
drivers/char/drm/gamma_drv.h:94: error: conflicting types for 'DRM'
drivers/char/drm/gamma_drv.h:91: error: previous declaration of 'DRM' was here
drivers/char/drm/gamma_drv.c:39:22: drm_auth.h: No such file or directory
drivers/char/drm/gamma_drv.c:40:28: drm_agpsupport.h: No such file or directory
drivers/char/drm/gamma_drv.c:41:22: drm_bufs.h: No such file or directory
In file included from drivers/char/drm/gamma_drv.c:42:
drivers/char/drm/gamma_context.h: In function `gamma_fops_read':
drivers/char/drm/gamma_context.h:48: error: structure has no member named `dev'
drivers/char/drm/gamma_context.h: At top level:
drivers/char/drm/gamma_context.h:96: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_context.h:96: warning: function declaration isn't a prototype
drivers/char/drm/gamma_context.h:96: error: conflicting types for 'DRM'
drivers/char/drm/gamma_drv.h:94: error: previous declaration of 'DRM' was here
drivers/char/drm/gamma_context.h:96: error: conflicting types for 'DRM'
drivers/char/drm/gamma_drv.h:94: error: previous declaration of 'DRM' was here
drivers/char/drm/gamma_context.h: In function `DRM':
drivers/char/drm/gamma_context.h:97: error: `dev' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:97: error: (Each undeclared identifier is reported only once
drivers/char/drm/gamma_context.h:97: error: for each function it appears in.)
drivers/char/drm/gamma_context.h:98: error: `s' undeclared (first use in this function)
drivers/char/drm/gamma_context.h: In function `gamma_fops_poll':
drivers/char/drm/gamma_context.h:134: error: structure has no member named `dev'
drivers/char/drm/gamma_context.h: At top level:
drivers/char/drm/gamma_context.h:142: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_context.h:142: warning: function declaration isn't a prototype
drivers/char/drm/gamma_context.h:142: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:96: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h: In function `DRM':
drivers/char/drm/gamma_context.h:146: error: `dev' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:151: error: `old' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:151: error: `new' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:175: error: `write_string' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:175: error: called object is not a function
drivers/char/drm/gamma_context.h: At top level:
drivers/char/drm/gamma_context.h:183: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_context.h:183: warning: function declaration isn't a prototype
drivers/char/drm/gamma_context.h:183: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h:183: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h: In function `DRM':
drivers/char/drm/gamma_context.h:184: error: `dev' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:186: error: `new' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:193: error: structure has no member named `next_buffer'
drivers/char/drm/gamma_context.h:193: error: structure has no member named `next_buffer'
drivers/char/drm/gamma_context.h:194: error: `lock_free' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:195: error: called object is not a function
drivers/char/drm/gamma_context.h: At top level:
drivers/char/drm/gamma_context.h:207: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_context.h:207: warning: function declaration isn't a prototype
drivers/char/drm/gamma_context.h:207: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:183: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h:207: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h: In function `DRM':
drivers/char/drm/gamma_context.h:210: error: `q' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:231: error: `ctx' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:233: error: `waitlist_create' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:233: error: `dev' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:233: error: called object is not a function
drivers/char/drm/gamma_context.h: At top level:
drivers/char/drm/gamma_context.h:249: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_context.h:249: warning: function declaration isn't a prototype
drivers/char/drm/gamma_context.h:249: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:207: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h:249: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h: In function `DRM':
drivers/char/drm/gamma_context.h:255: error: `dev' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:267: error: `alloc' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:267: error: called object is not a function
drivers/char/drm/gamma_context.h:278: error: `realloc' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:281: error: called object is not a function
drivers/char/drm/gamma_context.h: At top level:
drivers/char/drm/gamma_context.h:297: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_context.h:297: warning: function declaration isn't a prototype
drivers/char/drm/gamma_context.h:297: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:249: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h:297: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h: In function `DRM':
drivers/char/drm/gamma_context.h:298: error: `arg' undeclared (first use in this function)
drivers/char/drm/gamma_context.h: At top level:
drivers/char/drm/gamma_context.h:324: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_context.h:324: warning: function declaration isn't a prototype
drivers/char/drm/gamma_context.h:324: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:297: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h:324: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h: In function `DRM':
drivers/char/drm/gamma_context.h:325: error: `filp' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:326: error: structure has no member named `dev'
drivers/char/drm/gamma_context.h:328: error: `arg' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:332: error: `alloc_queue' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:332: error: called object is not a function
drivers/char/drm/gamma_context.h:334: error: `init_queue' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:334: error: called object is not a function
drivers/char/drm/gamma_context.h:335: error: called object is not a function
drivers/char/drm/gamma_context.h:337: error: called object is not a function
drivers/char/drm/gamma_context.h: At top level:
drivers/char/drm/gamma_context.h:346: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_context.h:346: warning: function declaration isn't a prototype
drivers/char/drm/gamma_context.h:346: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:324: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h:346: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h: In function `DRM':
drivers/char/drm/gamma_context.h:347: error: `filp' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:348: error: structure has no member named `dev'
drivers/char/drm/gamma_context.h:352: error: `arg' undeclared (first use in this function)
drivers/char/drm/gamma_context.h: At top level:
drivers/char/drm/gamma_context.h:380: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_context.h:380: warning: function declaration isn't a prototype
drivers/char/drm/gamma_context.h:380: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:346: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h:380: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h: In function `DRM':
drivers/char/drm/gamma_context.h:381: error: `filp' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:382: error: structure has no member named `dev'
drivers/char/drm/gamma_context.h:383: error: `arg' undeclared (first use in this function)
drivers/char/drm/gamma_context.h: At top level:
drivers/char/drm/gamma_context.h:413: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_context.h:413: warning: function declaration isn't a prototype
drivers/char/drm/gamma_context.h:413: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:380: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h:413: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h: In function `DRM':
drivers/char/drm/gamma_context.h:414: error: `filp' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:415: error: structure has no member named `dev'
drivers/char/drm/gamma_context.h:418: error: `arg' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:421: error: `context_switch' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:421: error: called object is not a function
drivers/char/drm/gamma_context.h: At top level:
drivers/char/drm/gamma_context.h:426: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_context.h:426: warning: function declaration isn't a prototype
drivers/char/drm/gamma_context.h:426: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:413: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h:426: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h: In function `DRM':
drivers/char/drm/gamma_context.h:427: error: `filp' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:428: error: structure has no member named `dev'
drivers/char/drm/gamma_context.h:431: error: `arg' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:434: error: `context_switch_complete' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:434: error: called object is not a function
drivers/char/drm/gamma_context.h: At top level:
drivers/char/drm/gamma_context.h:441: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_context.h:441: warning: function declaration isn't a prototype
drivers/char/drm/gamma_context.h:441: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:426: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h:441: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_context.h: In function `DRM':
drivers/char/drm/gamma_context.h:442: error: `filp' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:443: error: structure has no member named `dev'
drivers/char/drm/gamma_context.h:448: error: `arg' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:474: error: `waitlist_get' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:474: error: called object is not a function
drivers/char/drm/gamma_context.h:475: error: `free_buffer' undeclared (first use in this function)
drivers/char/drm/gamma_context.h:475: error: called object is not a function
drivers/char/drm/gamma_drv.c:43:21: drm_dma.h: No such file or directory
In file included from drivers/char/drm/gamma_drv.c:44:
drivers/char/drm/gamma_old_dma.h: At top level:
drivers/char/drm/gamma_old_dma.h:37: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_old_dma.h:37: warning: function declaration isn't a prototype
drivers/char/drm/gamma_old_dma.h:37: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:441: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_old_dma.h:37: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_old_dma.h: In function `DRM':
drivers/char/drm/gamma_old_dma.h:38: error: `dev' undeclared (first use in this function)
drivers/char/drm/gamma_old_dma.h:40: error: structure has no member named `next_buffer'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member named `next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member named `next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member named `next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member named `next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member named `next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member named `next_queue'
drivers/char/drm/gamma_old_dma.h:42: error: structure has no member named `next_queue'
drivers/char/drm/gamma_old_dma.h:44: error: structure has no member named `next_queue'
drivers/char/drm/gamma_old_dma.h: At top level:
drivers/char/drm/gamma_old_dma.h:48: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_old_dma.h:48: warning: function declaration isn't a prototype
drivers/char/drm/gamma_old_dma.h:48: error: redefinition of 'DRM'
drivers/char/drm/gamma_old_dma.h:37: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_old_dma.h:48: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_old_dma.h: In function `DRM':
drivers/char/drm/gamma_old_dma.h:53: error: `dev' undeclared (first use in this function)
drivers/char/drm/gamma_old_dma.h:97: error: `wrapper' undeclared (first use in this function)
drivers/char/drm/gamma_old_dma.h: At top level:
drivers/char/drm/gamma_old_dma.h:116: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_old_dma.h:116: warning: function declaration isn't a prototype
drivers/char/drm/gamma_old_dma.h:116: error: redefinition of 'DRM'
drivers/char/drm/gamma_old_dma.h:48: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_old_dma.h:116: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_old_dma.h: In function `DRM':
drivers/char/drm/gamma_old_dma.h:117: error: `filp' undeclared (first use in this function)
drivers/char/drm/gamma_old_dma.h:118: error: structure has no member named `dev'
drivers/char/drm/gamma_old_dma.h:129: error: `d' undeclared (first use in this function)
drivers/char/drm/gamma_old_dma.h:173: error: `alloc' undeclared (first use in this function)
drivers/char/drm/gamma_old_dma.h:173: error: called object is not a function
drivers/char/drm/gamma_old_dma.h:222: error: `free_buffer' undeclared (first use in this function)
drivers/char/drm/gamma_old_dma.h:222: error: called object is not a function
drivers/char/drm/gamma_old_dma.h:224: error: `waitlist_put' undeclared (first use in this function)
drivers/char/drm/gamma_old_dma.h:224: error: called object is not a function
drivers/char/drm/gamma_old_dma.h:233: error: `free' undeclared (first use in this function)
drivers/char/drm/gamma_old_dma.h:233: error: called object is not a function
drivers/char/drm/gamma_old_dma.h: At top level:
drivers/char/drm/gamma_old_dma.h:240: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_old_dma.h:240: warning: function declaration isn't a prototype
drivers/char/drm/gamma_old_dma.h:240: error: redefinition of 'DRM'
drivers/char/drm/gamma_old_dma.h:116: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_old_dma.h:240: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_old_dma.h: In function `DRM':
drivers/char/drm/gamma_old_dma.h:241: error: `filp' undeclared (first use in this function)
drivers/char/drm/gamma_old_dma.h:242: error: structure has no member named `dev'
drivers/char/drm/gamma_old_dma.h:247: error: `d' undeclared (first use in this function)
drivers/char/drm/gamma_old_dma.h:248: error: `freelist_get' undeclared (first use in this function)
drivers/char/drm/gamma_old_dma.h:248: error: `order' undeclared (first use in this function)
drivers/char/drm/gamma_old_dma.h:249: error: called object is not a function
drivers/char/drm/gamma_old_dma.h: At top level:
drivers/char/drm/gamma_old_dma.h:276: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_old_dma.h:276: warning: function declaration isn't a prototype
drivers/char/drm/gamma_old_dma.h:276: error: redefinition of 'DRM'
drivers/char/drm/gamma_old_dma.h:240: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_old_dma.h:276: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_old_dma.h: In function `DRM':
drivers/char/drm/gamma_old_dma.h:281: error: `dma' undeclared (first use in this function)
drivers/char/drm/gamma_old_dma.h:281: error: called object is not a function
drivers/char/drm/gamma_old_dma.h:284: error: `dma_get_buffers_of_order' undeclared (first use in this function)
drivers/char/drm/gamma_old_dma.h:284: error: `filp' undeclared (first use in this function)
drivers/char/drm/gamma_old_dma.h:284: error: called object is not a function
drivers/char/drm/gamma_old_dma.h:295: error: called object is not a function
drivers/char/drm/gamma_old_dma.h:308: error: called object is not a function
drivers/char/drm/gamma_drv.c:45:26: drm_drawable.h: No such file or directory
drivers/char/drm/gamma_drv.c:46:21: drm_drv.h: No such file or directory
drivers/char/drm/gamma_drv.c:48:22: drm_fops.h: No such file or directory
drivers/char/drm/gamma_drv.c:49:22: drm_init.h: No such file or directory
drivers/char/drm/gamma_drv.c:50:23: drm_ioctl.h: No such file or directory
drivers/char/drm/gamma_drv.c:51:21: drm_irq.h: No such file or directory
In file included from drivers/char/drm/gamma_drv.c:52:
drivers/char/drm/gamma_lists.h: At top level:
drivers/char/drm/gamma_lists.h:36: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_lists.h:36: warning: function declaration isn't a prototype
drivers/char/drm/gamma_lists.h:36: error: redefinition of 'DRM'
drivers/char/drm/gamma_old_dma.h:276: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h:36: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h: In function `DRM':
drivers/char/drm/gamma_lists.h:37: error: `bl' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h:39: error: `alloc' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h:40: error: called object is not a function
drivers/char/drm/gamma_lists.h:44: error: `count' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h: At top level:
drivers/char/drm/gamma_lists.h:54: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_lists.h:54: warning: function declaration isn't a prototype
drivers/char/drm/gamma_lists.h:54: error: redefinition of 'DRM'
drivers/char/drm/gamma_lists.h:36: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h:54: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h: In function `DRM':
drivers/char/drm/gamma_lists.h:55: error: `bl' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h:56: error: `free' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h:58: error: called object is not a function
drivers/char/drm/gamma_lists.h: At top level:
drivers/char/drm/gamma_lists.h:68: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_lists.h:68: warning: function declaration isn't a prototype
drivers/char/drm/gamma_lists.h:68: error: redefinition of 'DRM'
drivers/char/drm/gamma_lists.h:54: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h:68: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h: In function `DRM':
drivers/char/drm/gamma_lists.h:72: error: `bl' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h:74: error: `buf' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h: At top level:
drivers/char/drm/gamma_lists.h:89: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_lists.h:89: warning: function declaration isn't a prototype
drivers/char/drm/gamma_lists.h:89: error: redefinition of 'DRM'
drivers/char/drm/gamma_lists.h:68: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h:89: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h: In function `DRM':
drivers/char/drm/gamma_lists.h:93: error: `bl' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h:97: warning: return makes integer from pointer without a cast
drivers/char/drm/gamma_lists.h:102: warning: return makes integer from pointer without a cast
drivers/char/drm/gamma_lists.h: At top level:
drivers/char/drm/gamma_lists.h:106: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_lists.h:106: warning: function declaration isn't a prototype
drivers/char/drm/gamma_lists.h:106: error: redefinition of 'DRM'
drivers/char/drm/gamma_lists.h:89: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h:106: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h: In function `DRM':
drivers/char/drm/gamma_lists.h:107: error: `bl' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h: At top level:
drivers/char/drm/gamma_lists.h:119: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_lists.h:119: warning: function declaration isn't a prototype
drivers/char/drm/gamma_lists.h:119: error: redefinition of 'DRM'
drivers/char/drm/gamma_lists.h:106: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h:119: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h: In function `DRM':
drivers/char/drm/gamma_lists.h:120: error: `bl' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h: At top level:
drivers/char/drm/gamma_lists.h:126: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_lists.h:126: warning: function declaration isn't a prototype
drivers/char/drm/gamma_lists.h:126: error: redefinition of 'DRM'
drivers/char/drm/gamma_lists.h:119: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h:126: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h: In function `DRM':
drivers/char/drm/gamma_lists.h:127: error: `dev' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h:134: error: `buf' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h:138: error: `bl' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h: At top level:
drivers/char/drm/gamma_lists.h:161: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_lists.h:161: warning: function declaration isn't a prototype
drivers/char/drm/gamma_lists.h:161: error: redefinition of 'DRM'
drivers/char/drm/gamma_lists.h:126: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h:161: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h: In function `DRM':
drivers/char/drm/gamma_lists.h:164: error: `bl' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h:164: warning: return makes integer from pointer without a cast
drivers/char/drm/gamma_lists.h:170: warning: return makes integer from pointer without a cast
drivers/char/drm/gamma_lists.h:184: warning: return makes integer from pointer without a cast
drivers/char/drm/gamma_lists.h: At top level:
drivers/char/drm/gamma_lists.h:188: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_lists.h:188: warning: function declaration isn't a prototype
drivers/char/drm/gamma_lists.h:188: error: redefinition of 'DRM'
drivers/char/drm/gamma_lists.h:161: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h:188: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lists.h: In function `DRM':
drivers/char/drm/gamma_lists.h:192: error: `bl' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h:192: warning: return makes integer from pointer without a cast
drivers/char/drm/gamma_lists.h:198: error: `block' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h:203: error: `freelist_try' undeclared (first use in this function)
drivers/char/drm/gamma_lists.h:203: error: called object is not a function
drivers/char/drm/gamma_lists.h:210: warning: return makes integer from pointer without a cast
drivers/char/drm/gamma_lists.h:213: error: called object is not a function
drivers/char/drm/gamma_drv.c:53:22: drm_lock.h: No such file or directory
In file included from drivers/char/drm/gamma_drv.c:54:
drivers/char/drm/gamma_lock.h: At top level:
drivers/char/drm/gamma_lock.h:36: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_lock.h:36: warning: function declaration isn't a prototype
drivers/char/drm/gamma_lock.h:36: error: redefinition of 'DRM'
drivers/char/drm/gamma_lists.h:188: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lock.h:36: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lock.h: In function `DRM':
drivers/char/drm/gamma_lock.h:39: error: `dev' undeclared (first use in this function)
drivers/char/drm/gamma_lock.h:39: error: `context' undeclared (first use in this function)
drivers/char/drm/gamma_lock.h: At top level:
drivers/char/drm/gamma_lock.h:69: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_lock.h:69: warning: function declaration isn't a prototype
drivers/char/drm/gamma_lock.h:69: error: redefinition of 'DRM'
drivers/char/drm/gamma_lock.h:36: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lock.h:69: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lock.h: In function `DRM':
drivers/char/drm/gamma_lock.h:70: error: `dev' undeclared (first use in this function)
drivers/char/drm/gamma_lock.h:70: error: `context' undeclared (first use in this function)
drivers/char/drm/gamma_lock.h: At top level:
drivers/char/drm/gamma_lock.h:87: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_lock.h:87: warning: function declaration isn't a prototype
drivers/char/drm/gamma_lock.h:87: error: redefinition of 'DRM'
drivers/char/drm/gamma_lock.h:69: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lock.h:87: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lock.h: In function `DRM':
drivers/char/drm/gamma_lock.h:93: error: `flags' undeclared (first use in this function)
drivers/char/drm/gamma_lock.h:94: error: `flush_queue' undeclared (first use in this function)
drivers/char/drm/gamma_lock.h:94: error: `dev' undeclared (first use in this function)
drivers/char/drm/gamma_lock.h:94: error: called object is not a function
drivers/char/drm/gamma_lock.h:95: error: `context' undeclared (first use in this function)
drivers/char/drm/gamma_lock.h:95: error: called object is not a function
drivers/char/drm/gamma_lock.h:99: error: called object is not a function
drivers/char/drm/gamma_lock.h: At top level:
drivers/char/drm/gamma_lock.h:106: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_lock.h:106: warning: function declaration isn't a prototype
drivers/char/drm/gamma_lock.h:106: error: redefinition of 'DRM'
drivers/char/drm/gamma_lock.h:87: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lock.h:106: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lock.h: In function `DRM':
drivers/char/drm/gamma_lock.h:112: error: `flags' undeclared (first use in this function)
drivers/char/drm/gamma_lock.h:113: error: `flush_unblock_queue' undeclared (first use in this function)
drivers/char/drm/gamma_lock.h:113: error: `dev' undeclared (first use in this function)
drivers/char/drm/gamma_lock.h:113: error: called object is not a function
drivers/char/drm/gamma_lock.h:114: error: `context' undeclared (first use in this function)
drivers/char/drm/gamma_lock.h:114: error: called object is not a function
drivers/char/drm/gamma_lock.h:118: error: called object is not a function
drivers/char/drm/gamma_lock.h: At top level:
drivers/char/drm/gamma_lock.h:127: error: `DRM' declared as function returning a function
drivers/char/drm/gamma_lock.h:127: warning: function declaration isn't a prototype
drivers/char/drm/gamma_lock.h:127: error: redefinition of 'DRM'
drivers/char/drm/gamma_lock.h:106: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lock.h:127: error: redefinition of 'DRM'
drivers/char/drm/gamma_context.h:142: error: previous definition of 'DRM' was here
drivers/char/drm/gamma_lock.h: In function `DRM':
drivers/char/drm/gamma_lock.h:128: error: `filp' undeclared (first use in this function)
drivers/char/drm/gamma_lock.h:129: error: structure has no member named `dev'
drivers/char/drm/gamma_lock.h:135: error: `arg' undeclared (first use in this function)
drivers/char/drm/gamma_lock.h:137: error: `flush_block_and_flush' undeclared (first use in this function)
drivers/char/drm/gamma_lock.h:137: error: called object is not a function
drivers/char/drm/gamma_lock.h:138: error: `flush_unblock' undeclared (first use in this function)
drivers/char/drm/gamma_lock.h:138: error: called object is not a function
In file included from drivers/char/drm/gamma_drv.c:55:
drivers/char/drm/drm_memory.h: At top level:
drivers/char/drm/drm_memory.h:65: error: redefinition of 'drm_lookup_map'
drivers/char/drm/drm_memory.h:65: error: previous definition of 'drm_lookup_map' was here
drivers/char/drm/drm_memory.h:83: error: redefinition of 'agp_remap'
drivers/char/drm/drm_memory.h:83: error: previous definition of 'agp_remap' was here
drivers/char/drm/drm_memory.h:123: error: redefinition of 'drm_follow_page'
drivers/char/drm/drm_memory.h:123: error: previous definition of 'drm_follow_page' was here
drivers/char/drm/drm_memory.h:151: error: redefinition of 'drm_ioremap'
drivers/char/drm/drm_memory.h:151: error: previous definition of 'drm_ioremap' was here
drivers/char/drm/drm_memory.h:163: error: redefinition of 'drm_ioremap_nocache'
drivers/char/drm/drm_memory.h:163: error: previous definition of 'drm_ioremap_nocache' was here
drivers/char/drm/drm_memory.h:174: error: redefinition of 'drm_ioremapfree'
drivers/char/drm/drm_memory.h:174: error: previous definition of 'drm_ioremapfree' was here
drivers/char/drm/gamma_drv.c:56:22: drm_proc.h: No such file or directory
drivers/char/drm/gamma_drv.c:57:20: drm_vm.h: No such file or directory
drivers/char/drm/gamma_drv.c:58:22: drm_stub.h: No such file or directory
drivers/char/drm/gamma_drv.c:59:25: drm_scatter.h: No such file or directory
drivers/char/drm/gamma_lists.h:161: warning: 'DRM' defined but not used
drivers/char/drm/gamma_lock.h:36: warning: 'DRM' defined but not used
drivers/char/drm/gamma_lock.h:69: warning: 'DRM' defined but not used
make[1]: *** [drivers/char/drm/gamma_drv.o] Error 1
make: *** [drivers/char/drm/] Error 2



Here's what I got it hacked down to : 

In file included from drivers/char/drm/gamma_drv.c:39:
drivers/char/drm/gamma_context.h: In function `gamma_context_switch_complete':
drivers/char/drm/gamma_context.h:184: warning: unused variable `dma'
In file included from drivers/char/drm/gamma_drv.c:39:
drivers/char/drm/gamma_context.h: In function `gamma_alloc_queue':
drivers/char/drm/gamma_context.h:269: warning: implicit declaration of function `gamma_alloc'
drivers/char/drm/gamma_context.h:269: warning: assignment makes pointer from integer without a cast
drivers/char/drm/gamma_context.h:280: warning: implicit declaration of function `gamma_realloc'
drivers/char/drm/gamma_context.h:283: warning: assignment makes pointer from integer without a cast
In file included from drivers/char/drm/gamma_drv.c:39:
drivers/char/drm/gamma_context.h: In function `gamma_rmctx':
drivers/char/drm/gamma_context.h:477: warning: implicit declaration of function `gamma_free_buffer'
In file included from drivers/char/drm/gamma_drv.c:40:
drivers/char/drm/gamma_old_dma.h: In function `gamma_clear_next_buffer':
drivers/char/drm/gamma_old_dma.h:38: warning: unused variable `dma'
In file included from drivers/char/drm/gamma_drv.c:40:
drivers/char/drm/gamma_old_dma.h: In function `gamma_dma_enqueue':
drivers/char/drm/gamma_old_dma.h:175: warning: assignment makes pointer from integer without a cast
drivers/char/drm/gamma_old_dma.h:235: warning: implicit declaration of function `gamma_free'
In file included from drivers/char/drm/gamma_drv.c:40:
drivers/char/drm/gamma_old_dma.h: In function `gamma_dma_get_buffers':
drivers/char/drm/gamma_old_dma.h:283: warning: implicit declaration of function `gamma_order'
In file included from drivers/char/drm/gamma_drv.c:42:
drivers/char/drm/gamma_lists.h: In function `gamma_waitlist_create':
drivers/char/drm/gamma_lists.h:40: warning: assignment makes pointer from integer without a cast
  CC [M]  drivers/char/drm/gamma_dma.o
drivers/char/drm/gamma_dma.c: In function `gamma_driver_irq_handler':
drivers/char/drm/gamma_dma.c:122: warning: unused variable `dma'
drivers/char/drm/gamma_dma.c: In function `gamma_do_dma':
drivers/char/drm/gamma_dma.c:188: warning: implicit declaration of function `gamma_free_buffer'
drivers/char/drm/gamma_dma.c:158: warning: unused variable `dma'
drivers/char/drm/gamma_dma.c:253: warning: label `cleanup' defined but not used
drivers/char/drm/gamma_dma.c:156: warning: 'buf' might be used uninitialized in this function
drivers/char/drm/gamma_dma.c: In function `gamma_dma_schedule':
drivers/char/drm/gamma_dma.c:273: warning: unused variable `next'
drivers/char/drm/gamma_dma.c:274: warning: unused variable `q'
drivers/char/drm/gamma_dma.c:275: warning: unused variable `buf'
drivers/char/drm/gamma_dma.c:280: warning: unused variable `dma'
drivers/char/drm/gamma_dma.c: In function `gamma_dma_priority':
drivers/char/drm/gamma_dma.c:361: warning: implicit declaration of function `gamma_lock_take'
drivers/char/drm/gamma_dma.c:372: warning: implicit declaration of function `gamma_alloc'
drivers/char/drm/gamma_dma.c:373: warning: assignment makes pointer from integer without a cast
drivers/char/drm/gamma_dma.c:383: warning: assignment makes pointer from integer without a cast
drivers/char/drm/gamma_dma.c:448: warning: implicit declaration of function `gamma_context_switch'
drivers/char/drm/gamma_dma.c:486: warning: implicit declaration of function `gamma_free'
drivers/char/drm/gamma_dma.c:493: warning: implicit declaration of function `gamma_lock_free'
drivers/char/drm/gamma_dma.c: In function `gamma_do_init_dma':
drivers/char/drm/gamma_dma.c:624: warning: assignment makes pointer from integer without a cast
drivers/char/drm/gamma_dma.c: In function `gamma_do_cleanup_dma':
drivers/char/drm/gamma_dma.c:699: warning: implicit declaration of function `gamma_irq_uninstall'
drivers/char/drm/gamma_dma.c: In function `gamma_driver_register_fns':
drivers/char/drm/gamma_dma.c:941: warning: assignment from incompatible pointer type
drivers/char/drm/gamma_dma.c: At top level:
drivers/char/drm/gamma_dma.c:153: warning: 'gamma_do_dma' defined but not used
drivers/char/drm/gamma_dma.c:262: warning: 'gamma_dma_timer_bh' defined but not used


-- 
Jesper Juhl

