Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277398AbRJVBPR>; Sun, 21 Oct 2001 21:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277401AbRJVBPB>; Sun, 21 Oct 2001 21:15:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48516 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277398AbRJVBOy>;
	Sun, 21 Oct 2001 21:14:54 -0400
Date: Sun, 21 Oct 2001 18:15:23 -0700 (PDT)
Message-Id: <20011021.181523.112610375.davem@redhat.com>
To: sten@blinkenlights.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: INIT_MMAP on sparc64
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.40-blink.0110211736030.19859-100000@deepthought.blinkenlights.nl>
In-Reply-To: <20011021.080432.71105870.davem@redhat.com>
	<Pine.LNX.4.40-blink.0110211736030.19859-100000@deepthought.blinkenlights.nl>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


DRI works perfectly fine in my current sources, patches below.

Wrt the 3.5MB size limitation, use modules man.

diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/drivers/char/drm/drm_drv.h linux/drivers/char/drm/drm_drv.h
--- vanilla/linux/drivers/char/drm/drm_drv.h	Fri Sep 14 14:04:07 2001
+++ linux/drivers/char/drm/drm_drv.h	Thu Oct 18 09:03:58 2001
@@ -1047,6 +1047,25 @@
 
 	atomic_inc( &dev->counts[_DRM_STAT_UNLOCKS] );
 
+#if __HAVE_KERNEL_CTX_SWITCH
+	/* We no longer really hold it, but if we are the next
+	 * agent to request it then we should just be able to
+	 * take it immediately and not eat the ioctl.
+	 */
+	dev->lock.pid = 0;
+	{
+		__volatile__ unsigned int *plock = &dev->lock.hw_lock->lock;
+		unsigned int old, new, prev, ctx;
+
+		ctx = lock.context;
+		do {
+			old  = *plock;
+			new  = ctx;
+			prev = cmpxchg(plock, old, new);
+		} while (prev != old);
+	}
+	wake_up_interruptible(&dev->lock.lock_queue);
+#else
 	DRM(lock_transfer)( dev, &dev->lock.hw_lock->lock,
 			    DRM_KERNEL_CONTEXT );
 #if __HAVE_DMA_SCHEDULE
@@ -1061,6 +1080,7 @@
 			DRM_ERROR( "\n" );
 		}
 	}
+#endif /* !__HAVE_KERNEL_CTX_SWITCH */
 
 	unblock_all_signals();
 	return 0;
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/drivers/char/drm/drm_vm.h linux/drivers/char/drm/drm_vm.h
--- vanilla/linux/drivers/char/drm/drm_vm.h	Thu Oct 18 19:06:21 2001
+++ linux/drivers/char/drm/drm_vm.h	Sat Oct 20 04:40:42 2001
@@ -531,10 +531,17 @@
 			vma->vm_flags |= VM_IO;	/* not in core dump */
 		}
 		offset = DRIVER_GET_REG_OFS();
+#ifdef __sparc__
+		if (io_remap_page_range(vma->vm_start,
+					VM_OFFSET(vma) + offset,
+					vma->vm_end - vma->vm_start,
+					vma->vm_page_prot, 0))
+#else
 		if (remap_page_range(vma->vm_start,
 				     VM_OFFSET(vma) + offset,
 				     vma->vm_end - vma->vm_start,
 				     vma->vm_page_prot))
+#endif
 				return -EAGAIN;
 		DRM_DEBUG("   Type = %d; start = 0x%lx, end = 0x%lx,"
 			  " offset = 0x%lx\n",
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/drivers/char/drm/ffb_drv.c linux/drivers/char/drm/ffb_drv.c
--- vanilla/linux/drivers/char/drm/ffb_drv.c	Sun Aug 12 11:23:32 2001
+++ linux/drivers/char/drm/ffb_drv.c	Thu Oct 18 09:03:58 2001
@@ -1,4 +1,4 @@
-/* $Id: ffb_drv.c,v 1.15 2001/08/09 17:47:51 davem Exp $
+/* $Id: ffb_drv.c,v 1.16 2001/10/18 16:00:24 davem Exp $
  * ffb_drv.c: Creator/Creator3D direct rendering driver.
  *
  * Copyright (C) 2000 David S. Miller (davem@redhat.com)
@@ -45,16 +45,16 @@
 #define DRIVER_PRESETUP()	do {		\
 	int _ret;				\
 	_ret = ffb_presetup(dev);		\
-	if(_ret != 0) return _ret;		\
+	if (_ret != 0) return _ret;		\
 } while(0)
 
 /* Free private structure */
 #define DRIVER_PRETAKEDOWN()	do {				\
-	if(dev->dev_private) kfree(dev->dev_private);		\
+	if (dev->dev_private) kfree(dev->dev_private);		\
 } while(0)
 
 #define DRIVER_POSTCLEANUP()	do {				\
-	if(ffb_position != NULL) kfree(ffb_position);		\
+	if (ffb_position != NULL) kfree(ffb_position);		\
 } while(0)
 
 /* We have to free up the rogue hw context state holding error or 
@@ -66,7 +66,9 @@
 	int idx;							\
 									\
 	idx = context - 1;						\
-	if (fpriv && fpriv->hw_state[idx] != NULL) {			\
+	if (fpriv &&							\
+	    context != DRM_KERNEL_CONTEXT &&				\
+	    fpriv->hw_state[idx] != NULL) {				\
 		kfree(fpriv->hw_state[idx]);				\
 		fpriv->hw_state[idx] = NULL;				\
 	}								\
