Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266350AbUAHUIc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 15:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266352AbUAHUIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 15:08:32 -0500
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:51108 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S266350AbUAHUIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 15:08:17 -0500
Subject: 2.4.23: user/kernel pointer bugs (drivers/char/vt.c,
	drivers/char/drm/gamma_dma.c)
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: marcelo.tosatti@cyclades.com
Cc: faith@valinux.com, dri-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Jan 2004 12:08:08 -0800
Message-Id: <1073592494.18588.77.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both of these bugs look exploitable.  The vt.c patch is
self-explanatory.  

In gamma_dma.c, argument "d" to gamma_dma_priority() points to a
structure copied from userspace (see gamma_dma()).  That means that
d->send_indices is a pointer under user control, so it shouldn't be
dereferenced.  The patch just safely copies the contents to a kernel
buffer and uses that instead.  Ditto for d->send_sizes.

Also, I notice the drm code uses it's own memory allocation wrappers.  I
don't know all the details of the drm code, so I just used kmalloc. 
You'll probably want to change those two calls after applying the
patch.  Sorry for the inconvenience.

Thanks for looking at this, and let me know if you have any questions.

Best,
Rob

P.S. Both of these bugs were found using the source code verification
tool, CQual, developed by Jeff Foster, myself, and others, and available
from http://www.cs.umd.edu/~jfoster/cqual/.


--- drivers/char/vt.c.orig	Thu Jan  8 10:53:01 2004
+++ drivers/char/vt.c	Wed Jan  7 15:22:17 2004
@@ -288,7 +288,7 @@
 	case KDGKBSENT:
 		sz = sizeof(tmp.kb_string) - 1; /* sz should have been
 						  a struct member */
-		q = user_kdgkb->kb_string;
+		q = tmp.kb_string;
 		p = func_table[i];
 		if(p)
 			for ( ; *p && sz; p++, sz--)



--- drivers/char/drm/gamma_dma.c.orig	Thu Jan  8 10:56:47 2004
+++ drivers/char/drm/gamma_dma.c	Wed Jan  7 19:21:57 2004
@@ -352,6 +352,8 @@
 	drm_buf_t	  *buf;
 	drm_buf_t	  *last_buf = NULL;
 	drm_device_dma_t  *dma	    = dev->dma;
+	int               *drm_send_indices = NULL;
+	int               *drm_send_sizes = NULL;
 	DECLARE_WAITQUEUE(entry, current);
 
 				/* Turn off interrupt handling */
@@ -371,11 +373,27 @@
 		++must_free;
 	}
 
+	drm_send_indices = kmalloc (d->send_count * sizeof(*drm_send_indices), GFP_KERNEL);
+	drm_send_sizes = kmalloc (d->send_count * sizeof(*drm_send_sizes), GFP_KERNEL);
+	if (! drm_send_indices || ! drm_send_sizes)
+	{
+		retcode = -ENOMEM;
+		goto cleanup;
+	}
+	if (copy_from_user(drm_send_indices, d->send_indices, 
+			   d->send_count * sizeof(*drm_send_indices)) ||
+	    copy_from_user(drm_send_sizes, d->send_sizes, 
+			   d->send_count * sizeof(*drm_send_sizes)))
+	{
+		retcode = -EFAULT;
+		goto cleanup;
+	}
+
 	for (i = 0; i < d->send_count; i++) {
-		idx = d->send_indices[i];
+		idx = drm_send_indices[i];
 		if (idx < 0 || idx >= dma->buf_count) {
 			DRM_ERROR("Index %d (of %d max)\n",
-				  d->send_indices[i], dma->buf_count - 1);
+				  drm_send_indices[i], dma->buf_count - 1);
 			continue;
 		}
 		buf = dma->buflist[ idx ];
@@ -397,7 +415,7 @@
 				   process closes the /dev/drm? handle, so
 				   it can't also be doing DMA. */
 		buf->list	  = DRM_LIST_PRIO;
-		buf->used	  = d->send_sizes[i];
+		buf->used	  = drm_send_sizes[i];
 		buf->context	  = d->context;
 		buf->while_locked = d->flags & _DRM_DMA_WHILE_LOCKED;
 		address		  = (unsigned long)buf->address;
@@ -408,14 +426,14 @@
 		if (buf->pending) {
 			DRM_ERROR("Sending pending buffer:"
 				  " buffer %d, offset %d\n",
-				  d->send_indices[i], i);
+				  drm_send_indices[i], i);
 			retcode = -EINVAL;
 			goto cleanup;
 		}
 		if (buf->waiting) {
 			DRM_ERROR("Sending waiting buffer:"
 				  " buffer %d, offset %d\n",
-				  d->send_indices[i], i);
+				  drm_send_indices[i], i);
 			retcode = -EINVAL;
 			goto cleanup;
 		}
@@ -464,6 +482,10 @@
 

 cleanup:
+	if (drm_send_indices)
+		kfree(drm_send_indices);
+	if (drm_send_sizes)
+		kfree(drm_send_sizes);				
 	if (last_buf) {
 		gamma_dma_ready(dev);
 		gamma_free_buffer(dev, last_buf);
@@ -487,7 +509,11 @@
 	drm_device_dma_t  *dma	    = dev->dma;
 
 	if (d->flags & _DRM_DMA_BLOCK) {
-		last_buf = dma->buflist[d->send_indices[d->send_count-1]];
+		int lastindex;
+		if (copy_from_user(&lastindex, &d->send_indices[d->send_count-1],
+				   sizeof(lastindex)))
+			return -EFAULT;
+		last_buf = dma->buflist[lastindex];
 		add_wait_queue(&last_buf->dma_wait, &entry);
 	}
 

