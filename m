Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312850AbSDFWGX>; Sat, 6 Apr 2002 17:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312852AbSDFWGW>; Sat, 6 Apr 2002 17:06:22 -0500
Received: from stingr.net ([212.193.32.15]:50562 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S312850AbSDFWGS>;
	Sat, 6 Apr 2002 17:06:18 -0500
Date: Sun, 7 Apr 2002 02:06:12 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [CFT][RFC][PATCH][CLEANUP] task->state cleanup: pilot
Message-ID: <20020406220612.GF839@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the pilot of task->state cleanup in 2.4.x. Feel free to blame me for
incorrect use of set_task_state vs. __set_task_state

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.310   -> 1.311  
#	drivers/char/drm-4.0/radeon_drv.c	1.1     -> 1.2    
#	drivers/char/drm-4.0/tdfx_drv.c	1.1     -> 1.2    
#	drivers/char/drm/drm_lock.h	1.2     -> 1.3    
#	drivers/char/drm-4.0/i810_drv.c	1.1     -> 1.2    
#	drivers/char/drm-4.0/lists.c	1.1     -> 1.2    
#	drivers/char/drm/drm_drv.h	1.3     -> 1.4    
#	drivers/char/drm/drm_lists.h	1.2     -> 1.3    
#	drivers/char/drm/i810_dma.c	1.6     -> 1.7    
#	drivers/char/drm-4.0/r128_drv.c	1.1     -> 1.2    
#	drivers/char/drm-4.0/gamma_dma.c	1.1     -> 1.2    
#	drivers/char/drm-4.0/mga_dma.c	1.1     -> 1.2    
#	drivers/char/drm-4.0/dma.c	1.1     -> 1.2    
#	drivers/char/drm-4.0/i810_dma.c	1.2     -> 1.3    
#	drivers/char/drm-4.0/ffb_drv.c	1.2     -> 1.3    
#	drivers/char/drm/drm_dma.h	1.3     -> 1.4    
#	drivers/char/drm-4.0/lock.c	1.1     -> 1.2    
#	drivers/char/drm-4.0/mga_drv.c	1.1     -> 1.2    
#	drivers/char/drm/gamma_dma.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/07	stingray@stingr.net	1.311
# task->state cleanup part 1
# --------------------------------------------
#
diff -Nru a/drivers/char/drm/drm_dma.h b/drivers/char/drm/drm_dma.h
--- a/drivers/char/drm/drm_dma.h	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm/drm_dma.h	Sun Apr  7 02:02:35 2002
@@ -359,7 +359,7 @@
 		add_wait_queue(&q->write_queue, &entry);
 		atomic_inc(&q->block_count);
 		for (;;) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			if (!atomic_read(&q->block_write)) break;
 			schedule();
 			if (signal_pending(current)) {
@@ -369,7 +369,7 @@
 			}
 		}
 		atomic_dec(&q->block_count);
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&q->write_queue, &entry);
 	}
 
diff -Nru a/drivers/char/drm/drm_drv.h b/drivers/char/drm/drm_drv.h
--- a/drivers/char/drm/drm_drv.h	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm/drm_drv.h	Sun Apr  7 02:02:35 2002
@@ -790,7 +790,7 @@
 		DECLARE_WAITQUEUE( entry, current );
 		add_wait_queue( &dev->lock.lock_queue, &entry );
 		for (;;) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			if ( !dev->lock.hw_lock ) {
 				/* Device has been unregistered */
 				retcode = -EINTR;
@@ -813,7 +813,7 @@
 				break;
 			}
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue( &dev->lock.lock_queue, &entry );
 		if( !retcode ) {
 			DRIVER_RELEASE();
@@ -962,7 +962,7 @@
         if ( !ret ) {
                 add_wait_queue( &dev->lock.lock_queue, &entry );
                 for (;;) {
-                        current->state = TASK_INTERRUPTIBLE;
+                        set_current_state(TASK_INTERRUPTIBLE);
                         if ( !dev->lock.hw_lock ) {
                                 /* Device has been unregistered */
                                 ret = -EINTR;
@@ -983,7 +983,7 @@
                                 break;
                         }
                 }
-                current->state = TASK_RUNNING;
+                set_current_state(TASK_RUNNING);
                 remove_wait_queue( &dev->lock.lock_queue, &entry );
         }
 
diff -Nru a/drivers/char/drm/drm_lists.h b/drivers/char/drm/drm_lists.h
--- a/drivers/char/drm/drm_lists.h	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm/drm_lists.h	Sun Apr  7 02:02:35 2002
@@ -212,13 +212,13 @@
 		if (block) {
 			add_wait_queue(&bl->waiting, &entry);
 			for (;;) {
-				current->state = TASK_INTERRUPTIBLE;
+				set_current_state(TASK_INTERRUPTIBLE);
 				if (!atomic_read(&bl->wfh)
 				    && (buf = DRM(freelist_try)(bl))) break;
 				schedule();
 				if (signal_pending(current)) break;
 			}
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 			remove_wait_queue(&bl->waiting, &entry);
 		}
 		return buf;
diff -Nru a/drivers/char/drm/drm_lock.h b/drivers/char/drm/drm_lock.h
--- a/drivers/char/drm/drm_lock.h	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm/drm_lock.h	Sun Apr  7 02:02:35 2002
@@ -125,7 +125,7 @@
 		add_wait_queue(&q->flush_queue, &entry);
 		atomic_inc(&q->block_count);
 		for (;;) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			if (!DRM_BUFCOUNT(&q->waitlist)) break;
 			schedule();
 			if (signal_pending(current)) {
@@ -134,7 +134,7 @@
 			}
 		}
 		atomic_dec(&q->block_count);
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&q->flush_queue, &entry);
 	}
 	atomic_dec(&q->use_count);
diff -Nru a/drivers/char/drm/gamma_dma.c b/drivers/char/drm/gamma_dma.c
--- a/drivers/char/drm/gamma_dma.c	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm/gamma_dma.c	Sun Apr  7 02:02:35 2002
@@ -428,7 +428,7 @@
 		    && !(dev->queuelist[buf->context]->flags
 			 & _DRM_CONTEXT_PRESERVED)) {
 			add_wait_queue(&dev->context_wait, &entry);
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 				/* PRE: dev->last_context != buf->context */
 			DRM(context_switch)(dev, dev->last_context,
 					    buf->context);
@@ -438,7 +438,7 @@
 				   NOTE WE HOLD THE LOCK THROUGHOUT THIS
 				   TIME! */
 			schedule();
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 			remove_wait_queue(&dev->context_wait, &entry);
 			if (signal_pending(current)) {
 				retcode = -EINTR;
@@ -505,7 +505,7 @@
 	if (d->flags & _DRM_DMA_BLOCK) {
 		DRM_DEBUG("%d waiting\n", current->pid);
 		for (;;) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			if (!last_buf->waiting && !last_buf->pending)
 				break; /* finished */
 			schedule();
@@ -514,7 +514,7 @@
 				break;
 			}
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		DRM_DEBUG("%d running\n", current->pid);
 		remove_wait_queue(&last_buf->dma_wait, &entry);
 		if (!retcode
diff -Nru a/drivers/char/drm/i810_dma.c b/drivers/char/drm/i810_dma.c
--- a/drivers/char/drm/i810_dma.c	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm/i810_dma.c	Sun Apr  7 02:02:35 2002
@@ -975,7 +975,7 @@
    	end = jiffies + (HZ*3);
 
    	for (;;) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 	      	i810_dma_quiescent_emit(dev);
 	   	if (atomic_read(&dev_priv->flush_done) == 1) break;
 		if((signed)(end - jiffies) <= 0) {
@@ -988,7 +988,7 @@
 		}
 	}
 
-   	current->state = TASK_RUNNING;
+   	set_current_state(TASK_RUNNING);
    	remove_wait_queue(&dev_priv->flush_queue, &entry);
 
    	return;
@@ -1009,7 +1009,7 @@
    	add_wait_queue(&dev_priv->flush_queue, &entry);
    	end = jiffies + (HZ*3);
    	for (;;) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 	      	i810_dma_emit_flush(dev);
 	   	if (atomic_read(&dev_priv->flush_done) == 1) break;
 		if((signed)(end - jiffies) <= 0) {
@@ -1023,7 +1023,7 @@
 		}
 	}
 
-   	current->state = TASK_RUNNING;
+   	set_current_state(TASK_RUNNING);
    	remove_wait_queue(&dev_priv->flush_queue, &entry);
 
 
diff -Nru a/drivers/char/drm-4.0/dma.c b/drivers/char/drm-4.0/dma.c
--- a/drivers/char/drm-4.0/dma.c	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm-4.0/dma.c	Sun Apr  7 02:02:35 2002
@@ -403,7 +403,7 @@
 		add_wait_queue(&q->write_queue, &entry);
 		atomic_inc(&q->block_count);
 		for (;;) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			if (!atomic_read(&q->block_write)) break;
 			schedule();
 			if (signal_pending(current)) {
@@ -413,7 +413,7 @@
 			}
 		}
 		atomic_dec(&q->block_count);
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&q->write_queue, &entry);
 	}
 	
diff -Nru a/drivers/char/drm-4.0/ffb_drv.c b/drivers/char/drm-4.0/ffb_drv.c
--- a/drivers/char/drm-4.0/ffb_drv.c	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm-4.0/ffb_drv.c	Sun Apr  7 02:02:35 2002
@@ -709,7 +709,7 @@
                         
 		/* Contention */
 		atomic_inc(&dev->total_sleeps);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		current->policy |= SCHED_YIELD;
 		schedule();
 		if (signal_pending(current)) {
@@ -717,7 +717,7 @@
 			break;
 		}
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&dev->lock.lock_queue, &entry);
 
         if (!ret) {
diff -Nru a/drivers/char/drm-4.0/gamma_dma.c b/drivers/char/drm-4.0/gamma_dma.c
--- a/drivers/char/drm-4.0/gamma_dma.c	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm-4.0/gamma_dma.c	Sun Apr  7 02:02:35 2002
@@ -466,7 +466,7 @@
 		    && !(dev->queuelist[buf->context]->flags
 			 & _DRM_CONTEXT_PRESERVED)) {
 			add_wait_queue(&dev->context_wait, &entry);
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 				/* PRE: dev->last_context != buf->context */
 			drm_context_switch(dev, dev->last_context,
 					   buf->context);
@@ -476,7 +476,7 @@
 				   NOTE WE HOLD THE LOCK THROUGHOUT THIS
 				   TIME! */
 			schedule();
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 			remove_wait_queue(&dev->context_wait, &entry);
 			if (signal_pending(current)) {
 				retcode = -EINTR;
@@ -543,7 +543,7 @@
 	if (d->flags & _DRM_DMA_BLOCK) {
 		DRM_DEBUG("%d waiting\n", current->pid);
 		for (;;) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			if (!last_buf->waiting && !last_buf->pending)
 				break; /* finished */
 			schedule();
@@ -552,7 +552,7 @@
 				break;
 			}
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		DRM_DEBUG("%d running\n", current->pid);
 		remove_wait_queue(&last_buf->dma_wait, &entry);
 		if (!retcode
@@ -771,13 +771,13 @@
 			if (j > 0 && j <= DRM_LOCK_SLICE) {
 				/* Can't take lock if we just had it and
 				   there is contention. */
-				current->state = TASK_INTERRUPTIBLE;
+				set_current_state(TASK_INTERRUPTIBLE);
 				schedule_timeout(j);
 			}
 		}
 		add_wait_queue(&dev->lock.lock_queue, &entry);
 		for (;;) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			if (!dev->lock.hw_lock) {
 				/* Device has been unregistered */
 				ret = -EINTR;
@@ -800,7 +800,7 @@
 				break;
 			}
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&dev->lock.lock_queue, &entry);
 	}
 
diff -Nru a/drivers/char/drm-4.0/i810_dma.c b/drivers/char/drm-4.0/i810_dma.c
--- a/drivers/char/drm-4.0/i810_dma.c	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm-4.0/i810_dma.c	Sun Apr  7 02:02:35 2002
@@ -1071,7 +1071,7 @@
    	end = jiffies + (HZ*3);
    
    	for (;;) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 	      	i810_dma_quiescent_emit(dev);
 	   	if (atomic_read(&dev_priv->flush_done) == 1) break;
 		if((signed)(end - jiffies) <= 0) {
@@ -1084,7 +1084,7 @@
 		}
 	}
    
-   	current->state = TASK_RUNNING;
+   	set_current_state(TASK_RUNNING);
    	remove_wait_queue(&dev_priv->flush_queue, &entry);
    
    	return;
@@ -1105,7 +1105,7 @@
    	add_wait_queue(&dev_priv->flush_queue, &entry);
    	end = jiffies + (HZ*3);
    	for (;;) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 	      	i810_dma_emit_flush(dev);
 	   	if (atomic_read(&dev_priv->flush_done) == 1) break;
 		if((signed)(end - jiffies) <= 0) {
@@ -1119,7 +1119,7 @@
 		}
 	}
    
-   	current->state = TASK_RUNNING;
+   	set_current_state(TASK_RUNNING);
    	remove_wait_queue(&dev_priv->flush_queue, &entry);
 
 
@@ -1199,7 +1199,7 @@
 	if (!ret) {
 		add_wait_queue(&dev->lock.lock_queue, &entry);
 		for (;;) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			if (!dev->lock.hw_lock) {
 				/* Device has been unregistered */
 				ret = -EINTR;
@@ -1222,7 +1222,7 @@
 				break;
 			}
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&dev->lock.lock_queue, &entry);
 	}
 	
diff -Nru a/drivers/char/drm-4.0/i810_drv.c b/drivers/char/drm-4.0/i810_drv.c
--- a/drivers/char/drm-4.0/i810_drv.c	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm-4.0/i810_drv.c	Sun Apr  7 02:02:35 2002
@@ -508,7 +508,7 @@
 	   	DECLARE_WAITQUEUE(entry, current);
 	   	add_wait_queue(&dev->lock.lock_queue, &entry);
 		for (;;) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			if (!dev->lock.hw_lock) {
 				/* Device has been unregistered */
 				retcode = -EINTR;
@@ -529,7 +529,7 @@
 				break;
 			}
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&dev->lock.lock_queue, &entry);
 	   	if(!retcode) {
 		   	i810_reclaim_buffers(dev, priv->pid);
diff -Nru a/drivers/char/drm-4.0/lists.c b/drivers/char/drm-4.0/lists.c
--- a/drivers/char/drm-4.0/lists.c	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm-4.0/lists.c	Sun Apr  7 02:02:35 2002
@@ -202,13 +202,13 @@
 		if (block) {
 			add_wait_queue(&bl->waiting, &entry);
 			for (;;) {
-				current->state = TASK_INTERRUPTIBLE;
+				set_current_state(TASK_INTERRUPTIBLE);
 				if (!atomic_read(&bl->wfh)
 				    && (buf = drm_freelist_try(bl))) break;
 				schedule();
 				if (signal_pending(current)) break;
 			}
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 			remove_wait_queue(&bl->waiting, &entry);
 		}
 		return buf;
diff -Nru a/drivers/char/drm-4.0/lock.c b/drivers/char/drm-4.0/lock.c
--- a/drivers/char/drm-4.0/lock.c	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm-4.0/lock.c	Sun Apr  7 02:02:35 2002
@@ -125,7 +125,7 @@
 		add_wait_queue(&q->flush_queue, &entry);
 		atomic_inc(&q->block_count);
 		for (;;) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			if (!DRM_BUFCOUNT(&q->waitlist)) break;
 			schedule();
 			if (signal_pending(current)) {
@@ -134,7 +134,7 @@
 			}
 		}
 		atomic_dec(&q->block_count);
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&q->flush_queue, &entry);
 	}
 	atomic_dec(&q->use_count);
diff -Nru a/drivers/char/drm-4.0/mga_dma.c b/drivers/char/drm-4.0/mga_dma.c
--- a/drivers/char/drm-4.0/mga_dma.c	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm-4.0/mga_dma.c	Sun Apr  7 02:02:35 2002
@@ -217,7 +217,7 @@
 	   	add_wait_queue(&dev_priv->buf_queue, &entry);
 		set_bit(MGA_IN_GETBUF, &dev_priv->dispatch_status);
 	   	for (;;) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 		   	mga_dma_schedule(dev, 0);
 			if(dev_priv->tail->age < dev_priv->last_prim_age)
 				break;
@@ -229,7 +229,7 @@
 			}
 		}
 		clear_bit(MGA_IN_GETBUF, &dev_priv->dispatch_status);
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 	   	remove_wait_queue(&dev_priv->buf_queue, &entry);
 		if (return_null) return NULL;
 	}
@@ -446,7 +446,7 @@
    	if(test_and_set_bit(MGA_BUF_IN_USE, &prim_buffer->buffer_status)) {
 	   	add_wait_queue(&dev_priv->wait_queue, &entry);
 	   	for (;;) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 		   	mga_dma_schedule(dev, 0);
 		   	if(!test_and_set_bit(MGA_BUF_IN_USE,
 					     &prim_buffer->buffer_status))
@@ -459,7 +459,7 @@
 			   	break;
 			}
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 	   	remove_wait_queue(&dev_priv->wait_queue, &entry);
 	   	if(ret) return ret;
 	}
@@ -894,7 +894,7 @@
 		set_bit(MGA_IN_FLUSH, &dev_priv->dispatch_status);
 		mga_dma_schedule(dev, 0);
    		for (;;) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 	   		if (!test_bit(MGA_IN_FLUSH,
 				      &dev_priv->dispatch_status))
 				break;
@@ -907,7 +907,7 @@
 		   		break;
 			}
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
    		remove_wait_queue(&dev_priv->flush_queue, &entry);
 	}
    	return ret;
@@ -967,7 +967,7 @@
 	if (!ret) {
 		add_wait_queue(&dev->lock.lock_queue, &entry);
 		for (;;) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			if (!dev->lock.hw_lock) {
 				/* Device has been unregistered */
 				ret = -EINTR;
@@ -989,7 +989,7 @@
 				break;
 			}
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&dev->lock.lock_queue, &entry);
 	}
 
diff -Nru a/drivers/char/drm-4.0/mga_drv.c b/drivers/char/drm-4.0/mga_drv.c
--- a/drivers/char/drm-4.0/mga_drv.c	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm-4.0/mga_drv.c	Sun Apr  7 02:02:35 2002
@@ -523,7 +523,7 @@
 	   	DECLARE_WAITQUEUE(entry, current);
 	   	add_wait_queue(&dev->lock.lock_queue, &entry);
 		for (;;) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			if (!dev->lock.hw_lock) {
 				/* Device has been unregistered */
 				retcode = -EINTR;
@@ -544,7 +544,7 @@
 				break;
 			}
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&dev->lock.lock_queue, &entry);
 	   	if(!retcode) {
 		   	mga_reclaim_buffers(dev, priv->pid);
diff -Nru a/drivers/char/drm-4.0/r128_drv.c b/drivers/char/drm-4.0/r128_drv.c
--- a/drivers/char/drm-4.0/r128_drv.c	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm-4.0/r128_drv.c	Sun Apr  7 02:02:35 2002
@@ -595,7 +595,7 @@
         if (!ret) {
                 add_wait_queue(&dev->lock.lock_queue, &entry);
                 for (;;) {
-                        current->state = TASK_INTERRUPTIBLE;
+                        set_current_state(TASK_INTERRUPTIBLE);
                         if (!dev->lock.hw_lock) {
                                 /* Device has been unregistered */
                                 ret = -EINTR;
@@ -617,7 +617,7 @@
                                 break;
                         }
                 }
-                current->state = TASK_RUNNING;
+                set_current_state(TASK_RUNNING);
                 remove_wait_queue(&dev->lock.lock_queue, &entry);
         }
 
diff -Nru a/drivers/char/drm-4.0/radeon_drv.c b/drivers/char/drm-4.0/radeon_drv.c
--- a/drivers/char/drm-4.0/radeon_drv.c	Sun Apr  7 02:02:34 2002
+++ b/drivers/char/drm-4.0/radeon_drv.c	Sun Apr  7 02:02:35 2002
@@ -598,7 +598,7 @@
         if (!ret) {
                 add_wait_queue(&dev->lock.lock_queue, &entry);
                 for (;;) {
-                        current->state = TASK_INTERRUPTIBLE;
+                        set_current_state(TASK_INTERRUPTIBLE);
                         if (!dev->lock.hw_lock) {
                                 /* Device has been unregistered */
                                 ret = -EINTR;
@@ -620,7 +620,7 @@
                                 break;
                         }
                 }
-                current->state = TASK_RUNNING;
+                set_current_state(TASK_RUNNING);
                 remove_wait_queue(&dev->lock.lock_queue, &entry);
         }
 
diff -Nru a/drivers/char/drm-4.0/tdfx_drv.c b/drivers/char/drm-4.0/tdfx_drv.c
--- a/drivers/char/drm-4.0/tdfx_drv.c	Sun Apr  7 02:02:35 2002
+++ b/drivers/char/drm-4.0/tdfx_drv.c	Sun Apr  7 02:02:35 2002
@@ -553,7 +553,7 @@
                                 DRM_DEBUG("%d (pid %d) delayed j=%d dev=%d jiffies=%d\n",
 					lock.context, current->pid, j,
 					dev->lock.lock_time, jiffies);
-                                current->state = TASK_INTERRUPTIBLE;
+                                set_current_state(TASK_INTERRUPTIBLE);
 				current->policy |= SCHED_YIELD;
                                 schedule_timeout(DRM_LOCK_SLICE-j);
 				DRM_DEBUG("jiffies=%d\n", jiffies);
@@ -562,7 +562,7 @@
 #endif
                 add_wait_queue(&dev->lock.lock_queue, &entry);
                 for (;;) {
-                        current->state = TASK_INTERRUPTIBLE;
+                        set_current_state(TASK_INTERRUPTIBLE);
                         if (!dev->lock.hw_lock) {
                                 /* Device has been unregistered */
                                 ret = -EINTR;
@@ -587,7 +587,7 @@
                                 break;
                         }
                 }
-                current->state = TASK_RUNNING;
+                set_current_state(TASK_RUNNING);
                 remove_wait_queue(&dev->lock.lock_queue, &entry);
         }
 
@@ -596,7 +596,7 @@
 		lock.context != tdfx_res_ctx.handle &&
 		dev->last_context != tdfx_res_ctx.handle) {
 		add_wait_queue(&dev->context_wait, &entry);
-	        current->state = TASK_INTERRUPTIBLE;
+	        set_current_state(TASK_INTERRUPTIBLE);
                 /* PRE: dev->last_context != lock.context */
 	        tdfx_context_switch(dev, dev->last_context, lock.context);
 		/* POST: we will wait for the context
@@ -606,7 +606,7 @@
                    TIME! */
 		current->policy |= SCHED_YIELD;
 	        schedule();
-	        current->state = TASK_RUNNING;
+	        set_current_state(TASK_RUNNING);
 	        remove_wait_queue(&dev->context_wait, &entry);
 	        if (signal_pending(current)) {
 	                ret = -EINTR;



-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
