Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTLBQVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 11:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbTLBQVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 11:21:38 -0500
Received: from aun.it.uu.se ([130.238.12.36]:52900 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262328AbTLBQVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 11:21:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16332.48129.638814.999930@alkaid.it.uu.se>
Date: Tue, 2 Dec 2003 17:21:21 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4.23] fix some DRM43 warnings
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend. Was ignored for 2.4.23-pre :-(]

This patch fixes three sources of warnings in the new 4.3 DRM code:
- drm_os_linux.h has a #warning on broken list_entry usage.
  The patch backports a fix from the 2.6 code.
- radeon_drv.h has a #warning PCI posting bug.
  The #warning refers to an obsolete and unused macro.
  Simply remove it. It's also gone from the 2.6 code.
- drm_agpsupport.h generates a gcc warning on an assignment
  used as a truth value.
  The patch backports a fix from the 2.6 code.

These changes are well-tested: they have been in 2.6 for ages,
and I've been running them in 2.4.23-pre/rc for months.
Please apply.

/Mikael

diff -ruN linux-2.4.23/drivers/char/drm/drm_agpsupport.h linux-2.4.23.drm43-fixes/drivers/char/drm/drm_agpsupport.h
--- linux-2.4.23/drivers/char/drm/drm_agpsupport.h	2003-11-29 00:28:11.000000000 +0100
+++ linux-2.4.23.drm43-fixes/drivers/char/drm/drm_agpsupport.h	2003-11-29 00:33:29.000000000 +0100
@@ -79,7 +79,7 @@
 		return -EBUSY;
 	if(!drm_agp->acquire)
 		return -EINVAL;
-	if (retcode = drm_agp->acquire())
+	if ((retcode = drm_agp->acquire()))
 		return retcode;
 	dev->agp->acquired = 1;
 	return 0;
diff -ruN linux-2.4.23/drivers/char/drm/drm_os_linux.h linux-2.4.23.drm43-fixes/drivers/char/drm/drm_os_linux.h
--- linux-2.4.23/drivers/char/drm/drm_os_linux.h	2003-11-29 00:28:11.000000000 +0100
+++ linux-2.4.23.drm43-fixes/drivers/char/drm/drm_os_linux.h	2003-11-29 00:33:29.000000000 +0100
@@ -13,12 +13,10 @@
 		return -EFAULT
 
 
-#warning the author of this code needs to read up on list_entry
 #define DRM_GETSAREA()							 \
 do { 									 \
-	struct list_head *list;						 \
-	list_for_each( list, &dev->maplist->head ) {			 \
-		drm_map_list_t *entry = (drm_map_list_t *)list;		 \
+	drm_map_list_t *entry;						 \
+	list_for_each_entry( entry, &dev->maplist->head, head ) {	 \
 		if ( entry->map &&					 \
 		     entry->map->type == _DRM_SHM &&			 \
 		     (entry->map->flags & _DRM_CONTAINS_LOCK) ) {	 \
diff -ruN linux-2.4.23/drivers/char/drm/radeon_drv.h linux-2.4.23.drm43-fixes/drivers/char/drm/radeon_drv.h
--- linux-2.4.23/drivers/char/drm/radeon_drv.h	2003-11-29 00:28:11.000000000 +0100
+++ linux-2.4.23.drm43-fixes/drivers/char/drm/radeon_drv.h	2003-11-29 00:33:29.000000000 +0100
@@ -839,14 +839,6 @@
  * Ring control
  */
 
-#if defined(__powerpc__)
-#define radeon_flush_write_combine()	(void) GET_RING_HEAD( &dev_priv->ring )
-#else
-#define radeon_flush_write_combine()	wmb()
-#warning PCI posting bug
-#endif
-
-
 #define RADEON_VERBOSE	0
 
 #define RING_LOCALS	int write, _nr; unsigned int mask; u32 *ring;
