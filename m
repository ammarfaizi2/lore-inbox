Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265491AbTIDTqY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 15:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265500AbTIDTqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 15:46:24 -0400
Received: from sponsa.its.uu.se ([130.238.7.36]:47543 "EHLO sponsa.its.uu.se")
	by vger.kernel.org with ESMTP id S265491AbTIDTqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 15:46:17 -0400
Date: Thu, 4 Sep 2003 21:45:59 +0200 (MEST)
Message-Id: <200309041945.h84Jjxgs028968@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4.23-pre3] fix three DRM43 warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sent to Marcelo, forgot to cc: LKML]

This patch fixes three warnings in the new XFree 4.3 DRM code:
- drm_os_linux.h has a #warning on broken list_entry usage
- radeon_drv.h has a #warning PCI posting bug
- drm_agpsupport.h generates a gcc warning on an assignment used
  as a truth value

The first #warning is valid. The fix is to backport the
cleaned-up version from 2.6.

The second is bogus. The macro the #warning refers to is
a left-over from the drm-4.0 code. It's no longer used and
the fix is to simply remove it. It's also absent in 2.6.

The third simply requires an additional pair of parentheses,
like the code in 2.6 has.

gcc -D__KERNEL__ -I/tmp/linux-2.4.23-pre3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=radeon_drv  -c -o radeon_drv.o radeon_drv.c
In file included from drmP.h:75,
                 from radeon_drv.c:32:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
In file included from radeon_drv.c:35:
radeon_drv.h:846:2: warning: #warning PCI posting bug
In file included from radeon_drv.c:38:
drm_agpsupport.h: In function `radeon_agp_acquire':
drm_agpsupport.h:82: warning: suggest parentheses around assignment used as truth value

/Mikael

diff -ruN linux-2.4.23-pre3/drivers/char/drm/drm_agpsupport.h linux-2.4.23-pre3.drm43-fixes/drivers/char/drm/drm_agpsupport.h
--- linux-2.4.23-pre3/drivers/char/drm/drm_agpsupport.h	2003-09-04 18:54:00.000000000 +0200
+++ linux-2.4.23-pre3.drm43-fixes/drivers/char/drm/drm_agpsupport.h	2003-09-04 19:02:39.000000000 +0200
@@ -79,7 +79,7 @@
 		return -EBUSY;
 	if(!drm_agp->acquire)
 		return -EINVAL;
-	if (retcode = drm_agp->acquire())
+	if ((retcode = drm_agp->acquire()))
 		return retcode;
 	dev->agp->acquired = 1;
 	return 0;
diff -ruN linux-2.4.23-pre3/drivers/char/drm/drm_os_linux.h linux-2.4.23-pre3.drm43-fixes/drivers/char/drm/drm_os_linux.h
--- linux-2.4.23-pre3/drivers/char/drm/drm_os_linux.h	2003-09-04 18:54:00.000000000 +0200
+++ linux-2.4.23-pre3.drm43-fixes/drivers/char/drm/drm_os_linux.h	2003-09-04 19:02:39.000000000 +0200
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
diff -ruN linux-2.4.23-pre3/drivers/char/drm/radeon_drv.h linux-2.4.23-pre3.drm43-fixes/drivers/char/drm/radeon_drv.h
--- linux-2.4.23-pre3/drivers/char/drm/radeon_drv.h	2003-09-04 18:54:00.000000000 +0200
+++ linux-2.4.23-pre3.drm43-fixes/drivers/char/drm/radeon_drv.h	2003-09-04 19:02:39.000000000 +0200
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
