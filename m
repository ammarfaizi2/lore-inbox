Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266168AbUFIWxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266168AbUFIWxt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 18:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266180AbUFIWxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 18:53:49 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:57984 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S266168AbUFIWxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 18:53:43 -0400
Subject: PATCH: 2.6.7-rc3 drivers/char/drm/gamma_dma.c: several user/kernel
	pointer bugs
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: faith@valinux.com
Cc: dri-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2004 15:53:40 -0700
Message-Id: <1086821620.32053.120.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gamma_dma_priority and gamma_dma_send_buffers both deref d->send_indices
and/or d->send_sizes.  When these functions are called from gamma_dma, 
these pointers are user pointers and are thus not safe to deref.  This patch
copies over the pointers inside gamma_dma_priority and 
gamma_dma_send_buffers.  Let me know if you have any questions or if I've 
made a mistake.

Best,
Rob


--- linux-2.6.7-rc3-full/drivers/char/drm/gamma_dma.c.orig	Wed Jun  9 12:04:35 2004
+++ linux-2.6.7-rc3-full/drivers/char/drm/gamma_dma.c	Wed Jun  9 11:58:42 2004
@@ -346,6 +346,9 @@ static int gamma_dma_priority(struct fil
 	drm_buf_t	  *buf;
 	drm_buf_t	  *last_buf = NULL;
 	drm_device_dma_t  *dma	    = dev->dma;
+	int               *send_indices = NULL;
+	int               *send_sizes = NULL;
+
 	DECLARE_WAITQUEUE(entry, current);
 
 				/* Turn off interrupt handling */
@@ -365,11 +368,31 @@ static int gamma_dma_priority(struct fil
 		++must_free;
 	}
 
+	send_indices = DRM(alloc)(d->send_count * sizeof(*send_indices),
+		                  DRM_MEM_DRIVER);
+        if (send_indices == NULL)
+                return -ENOMEM;
+	if (copy_from_user(send_indices, d->send_indices, 
+			   d->send_count * sizeof(*send_indices))) {
+		retcode = -EFAULT;
+                goto cleanup;
+	}
+	
+	send_sizes = DRM(alloc)(d->send_count * sizeof(*send_sizes),
+		                  DRM_MEM_DRIVER);
+        if (send_sizes == NULL)
+                return -ENOMEM;
+	if (copy_from_user(send_sizes, d->send_sizes, 
+			   d->send_count * sizeof(*send_sizes))) {
+		retcode = -EFAULT;
+                goto cleanup;
+	}
+
 	for (i = 0; i < d->send_count; i++) {
-		idx = d->send_indices[i];
+		idx = send_indices[i];
 		if (idx < 0 || idx >= dma->buf_count) {
 			DRM_ERROR("Index %d (of %d max)\n",
-				  d->send_indices[i], dma->buf_count - 1);
+				  send_indices[i], dma->buf_count - 1);
 			continue;
 		}
 		buf = dma->buflist[ idx ];
@@ -391,7 +414,7 @@ static int gamma_dma_priority(struct fil
 				   process closes the /dev/drm? handle, so
 				   it can't also be doing DMA. */
 		buf->list	  = DRM_LIST_PRIO;
-		buf->used	  = d->send_sizes[i];
+		buf->used	  = send_sizes[i];
 		buf->context	  = d->context;
 		buf->while_locked = d->flags & _DRM_DMA_WHILE_LOCKED;
 		address		  = (unsigned long)buf->address;
@@ -402,14 +425,14 @@ static int gamma_dma_priority(struct fil
 		if (buf->pending) {
 			DRM_ERROR("Sending pending buffer:"
 				  " buffer %d, offset %d\n",
-				  d->send_indices[i], i);
+				  send_indices[i], i);
 			retcode = -EINVAL;
 			goto cleanup;
 		}
 		if (buf->waiting) {
 			DRM_ERROR("Sending waiting buffer:"
 				  " buffer %d, offset %d\n",
-				  d->send_indices[i], i);
+				  send_indices[i], i);
 			retcode = -EINVAL;
 			goto cleanup;
 		}
@@ -458,6 +481,12 @@ cleanup:
 		gamma_dma_ready(dev);
 		gamma_free_buffer(dev, last_buf);
 	}
+        if (send_indices)
+                DRM(free)(send_indices, d->send_count * sizeof(*send_indices), 
+			  DRM_MEM_DRIVER);
+        if (send_sizes)
+                DRM(free)(send_sizes, d->send_count * sizeof(*send_sizes), 
+			  DRM_MEM_DRIVER);
 
 	if (must_free && !dev->context_flag) {
 		if (gamma_lock_free(dev, &dev->lock.hw_lock->lock,
@@ -476,9 +505,13 @@ static int gamma_dma_send_buffers(struct
 	drm_buf_t	  *last_buf = NULL;
 	int		  retcode   = 0;
 	drm_device_dma_t  *dma	    = dev->dma;
+	int               send_index;
+
+	if (get_user(send_index, &d->send_indices[d->send_count-1]))
+		return -EFAULT;
 
 	if (d->flags & _DRM_DMA_BLOCK) {
-		last_buf = dma->buflist[d->send_indices[d->send_count-1]];
+		last_buf = dma->buflist[send_index];
 		add_wait_queue(&last_buf->dma_wait, &entry);
 	}
 



