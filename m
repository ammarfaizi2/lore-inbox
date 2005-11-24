Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVKXKvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVKXKvp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 05:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbVKXKvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 05:51:45 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:9137 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751359AbVKXKvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 05:51:44 -0500
Date: Thu, 24 Nov 2005 10:51:39 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git tree] drm locking fix
Message-ID: <Pine.LNX.4.58.0511241049210.14276@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
	Lee Revell reported a problem with the via driver, this patch to
fix it is from DRM CVS.. can you pull the drm-linus branch from:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

diff-tree cf65f1623dd005ddfb1cbba20af3423a6c638dbe (from 33bc227e4e48ddadcf2eacb381c19df338f0a6c8)
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Thu Nov 24 21:41:14 2005 +1100

    drm: fix quiescent locking

    A fix for a locking bug which is triggered when a client tries to lock with
    flag DMA_QUIESCENT (typically the X server), but gets interrupted by a signal.
    The locking IOCTL should then return an error, but if DMA_QUIESCENT succeeds
    it returns 0, and the client falsely thinks it has the lock. In addition
    The client waits for DMA_QUISCENT and possibly DMA_READY without having the lock.

    From: Thomas Hellstrom
    Signed-off-by: Dave Airlie <airlied@linux.ie>

:100644 100644 b276ae8a6633bb836cd96ed3cd927ca3504efce0 b48a595d54eca0e9c13b0cb269b88fba6dc49f56 M	drivers/char/drm/drm_lock.c
diff --git a/drivers/char/drm/drm_lock.c b/drivers/char/drm/drm_lock.c
--- a/drivers/char/drm/drm_lock.c
+++ b/drivers/char/drm/drm_lock.c
@@ -104,6 +104,10 @@ int drm_lock(struct inode *inode, struct
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&dev->lock.lock_queue, &entry);

+	DRM_DEBUG("%d %s\n", lock.context, ret ? "interrupted" : "has lock");
+	if (ret)
+		return ret;
+
 	sigemptyset(&dev->sigmask);
 	sigaddset(&dev->sigmask, SIGSTOP);
 	sigaddset(&dev->sigmask, SIGTSTP);
@@ -116,8 +120,12 @@ int drm_lock(struct inode *inode, struct
 	if (dev->driver->dma_ready && (lock.flags & _DRM_LOCK_READY))
 		dev->driver->dma_ready(dev);

-	if (dev->driver->dma_quiescent && (lock.flags & _DRM_LOCK_QUIESCENT))
-		return dev->driver->dma_quiescent(dev);
+	if (dev->driver->dma_quiescent && (lock.flags & _DRM_LOCK_QUIESCENT)) {
+		if (dev->driver->dma_quiescent(dev)) {
+			DRM_DEBUG("%d waiting for DMA quiescent\n", lock.context);
+			return DRM_ERR(EBUSY);
+		}
+	}

 	/* dev->driver->kernel_context_switch isn't used by any of the x86
 	 *  drivers but is used by the Sparc driver.
@@ -128,9 +136,7 @@ int drm_lock(struct inode *inode, struct
 		dev->driver->kernel_context_switch(dev, dev->last_context,
 						   lock.context);
 	}
-	DRM_DEBUG("%d %s\n", lock.context, ret ? "interrupted" : "has lock");
-
-	return ret;
+	return 0;
 }

 /**
