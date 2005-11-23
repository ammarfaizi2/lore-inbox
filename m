Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbVKWLiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbVKWLiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 06:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbVKWLiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 06:38:50 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:58805 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1030405AbVKWLit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 06:38:49 -0500
Date: Wed, 23 Nov 2005 11:38:33 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] drm fixes tree
Message-ID: <Pine.LNX.4.58.0511231134500.9749@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus/Andrew,

	Can you pull the 'drm-linus' branch from

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

It contains three minor fixes as shown below...

Dave.

commit 7655f493b74f3048c02458bc32cd0b144f7b394f
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Wed Nov 23 22:12:59 2005 +1100

    drm: move is_pci to the end of the structure

    We memset the structure across opens except for the flags. The correct
    fix is more intrusive but this should fix a problem with bad iounmaps
    seen on AGP radeons acting like PCI ones.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit c41f47121d8bf44b886ef2039779dab8c1e3a25f
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Wed Nov 23 22:09:13 2005 +1100

    drm: add __GFP_COMP to the drm_alloc_pages

    The DRM only uses drm_alloc_pages for non-SG PCI cards using DRM.

    Signed-off-by: Hugh Dickins <hugh@veritas.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit bd07ed2b4d7071716c09895e19849e8b04991656
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Wed Nov 23 21:45:43 2005 +1100

    I think that if a PCI bus is a root bus, attached to a host bridge not a
    PCI->PCI bridge, then bus->self is allowed to be NULL. Certainly that's
    the case on my Pegasos, and it makes the MGA DRM driver oops...

    Signed-off-by: David Woodhouse <dwmw2@infradead.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

diff --git a/drivers/char/drm/drm_memory.c b/drivers/char/drm/drm_memory.c
--- a/drivers/char/drm/drm_memory.c
+++ b/drivers/char/drm/drm_memory.c
@@ -95,7 +95,7 @@ unsigned long drm_alloc_pages(int order,
 	unsigned long addr;
 	unsigned int sz;

-	address = __get_free_pages(GFP_KERNEL, order);
+	address = __get_free_pages(GFP_KERNEL|__GFP_COMP, order);
 	if (!address)
 		return 0;

diff --git a/drivers/char/drm/drm_memory_debug.h b/drivers/char/drm/drm_memory_debug.h
--- a/drivers/char/drm/drm_memory_debug.h
+++ b/drivers/char/drm/drm_memory_debug.h
@@ -221,7 +221,7 @@ unsigned long DRM(alloc_pages) (int orde
 	}
 	spin_unlock(&DRM(mem_lock));

-	address = __get_free_pages(GFP_KERNEL, order);
+	address = __get_free_pages(GFP_KERNEL|__GFP_COMP, order);
 	if (!address) {
 		spin_lock(&DRM(mem_lock));
 		++DRM(mem_stats)[area].fail_count;
diff --git a/drivers/char/drm/mga_drv.c b/drivers/char/drm/mga_drv.c
--- a/drivers/char/drm/mga_drv.c
+++ b/drivers/char/drm/mga_drv.c
@@ -161,7 +161,7 @@ static int mga_driver_device_is_agp(drm_
 	 * device.
 	 */

-	if ((pdev->device == 0x0525)
+	if ((pdev->device == 0x0525) && pdev->bus->self
 	    && (pdev->bus->self->vendor == 0x3388)
 	    && (pdev->bus->self->device == 0x0021)) {
 		return 0;
diff --git a/drivers/char/drm/radeon_drv.h b/drivers/char/drm/radeon_drv.h
--- a/drivers/char/drm/radeon_drv.h
+++ b/drivers/char/drm/radeon_drv.h
@@ -214,8 +214,6 @@ typedef struct drm_radeon_private {

 	int microcode_version;

-	int is_pci;
-
 	struct {
 		u32 boxes;
 		int freelist_timeouts;
@@ -275,6 +273,7 @@ typedef struct drm_radeon_private {

 	/* starting from here on, data is preserved accross an open */
 	uint32_t flags;		/* see radeon_chip_flags */
+	int is_pci;
 } drm_radeon_private_t;

 typedef struct drm_radeon_buf_priv {
