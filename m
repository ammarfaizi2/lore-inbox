Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287748AbSASXCD>; Sat, 19 Jan 2002 18:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287750AbSASXBx>; Sat, 19 Jan 2002 18:01:53 -0500
Received: from ns.suse.de ([213.95.15.193]:22540 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287748AbSASXBi> convert rfc822-to-8bit;
	Sat, 19 Jan 2002 18:01:38 -0500
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.sourceforge.net
Subject: NULL pointer reference in DRM
X-Yow: I am a jelly donut.  I am a jelly donut.
From: Andreas Schwab <schwab@suse.de>
Date: Sun, 20 Jan 2002 00:01:36 +0100
Message-ID: <jen0zat06n.fsf@sykes.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.1.30 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a NULL pointer reference when using a drm module that
does not enforce AGP (like r128) on a system without an AGP card.

Andreas.

--- linux/drivers/char/drm/drm_memory.h.~1~	Sat Jan 19 23:46:22 2002
+++ linux/drivers/char/drm/drm_memory.h	Fri Jan 18 23:26:31 2002
@@ -322,7 +322,7 @@
 	}
 
 #if __REALLY_HAVE_AGP
-	if(dev->agp->cant_use_aperture == 0)
+	if(!dev->agp || dev->agp->cant_use_aperture == 0)
 		goto standard_ioremap;
 
 	list_for_each(list, &dev->maplist->head) {
@@ -382,7 +382,7 @@
 		DRM_MEM_ERROR(DRM_MEM_MAPPINGS,
 			      "Attempt to free NULL pointer\n");
 #if __REALLY_HAVE_AGP
-	else if(dev->agp->cant_use_aperture == 0)
+	else if(!dev->agp || dev->agp->cant_use_aperture == 0)
 #else
 	else
 #endif
--- linux/drivers/char/drm/drm_vm.h.~1~	Sat Jan 19 23:47:13 2002
+++ linux/drivers/char/drm/drm_vm.h	Fri Jan 18 23:26:31 2002
@@ -78,7 +78,7 @@
          * Find the right map
          */
 
-	if(!dev->agp->cant_use_aperture) goto vm_nopage_error;
+	if(!dev->agp || !dev->agp->cant_use_aperture) goto vm_nopage_error;
 
 	list_for_each(list, &dev->maplist->head) {
 		r_list = (drm_map_list_t *)list;

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
