Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267899AbUH1AZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267899AbUH1AZR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 20:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267889AbUH1AXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 20:23:23 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:38629 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267869AbUH1AUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 20:20:54 -0400
Date: Sat, 28 Aug 2004 01:20:53 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK pull] DRM tree - fix some missing 0->NULL and __user
Message-ID: <Pine.LNX.4.58.0408280119500.23054@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please do a

	bk pull bk://drm.bkbits.net/drm-2.6

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/i915_dma.c |    2 +-
 drivers/char/drm/i915_mem.c |   18 +++++++++---------
 drivers/char/drm/sis_mm.c   |    7 ++++---
 3 files changed, 14 insertions(+), 13 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/08/28 1.1876)
   Add some missing NULL->0 and __user annotiations

   Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/drm/i915_dma.c b/drivers/char/drm/i915_dma.c
--- a/drivers/char/drm/i915_dma.c	Sat Aug 28 10:18:25 2004
+++ b/drivers/char/drm/i915_dma.c	Sat Aug 28 10:18:25 2004
@@ -429,7 +429,7 @@
 				     drm_i915_batchbuffer_t * batch)
 {
 	drm_i915_private_t *dev_priv = dev->dev_private;
-	drm_clip_rect_t *boxes = batch->cliprects;
+	drm_clip_rect_t __user *boxes = batch->cliprects;
 	int nbox = batch->num_cliprects;
 	int i = 0, count;
 	RING_LOCALS;
diff -Nru a/drivers/char/drm/i915_mem.c b/drivers/char/drm/i915_mem.c
--- a/drivers/char/drm/i915_mem.c	Sat Aug 28 10:18:25 2004
+++ b/drivers/char/drm/i915_mem.c	Sat Aug 28 10:18:25 2004
@@ -80,7 +80,7 @@
 			goto out;
 		newblock->start = start;
 		newblock->size = p->size - (start - p->start);
-		newblock->filp = 0;
+		newblock->filp = NULL;
 		newblock->next = p->next;
 		newblock->prev = p;
 		p->next->prev = newblock;
@@ -96,7 +96,7 @@
 			goto out;
 		newblock->start = start + size;
 		newblock->size = p->size - size;
-		newblock->filp = 0;
+		newblock->filp = NULL;
 		newblock->next = p->next;
 		newblock->prev = p;
 		p->next->prev = newblock;
@@ -118,7 +118,7 @@

 	for (p = heap->next; p != heap; p = p->next) {
 		int start = (p->start + mask) & ~mask;
-		if (p->filp == 0 && start + size <= p->start + p->size)
+		if (p->filp == NULL && start + size <= p->start + p->size)
 			return split_block(p, start, size, filp);
 	}

@@ -138,12 +138,12 @@

 static void free_block(struct mem_block *p)
 {
-	p->filp = 0;
+	p->filp = NULL;

 	/* Assumes a single contiguous range.  Needs a special filp in
 	 * 'heap' to stop it being subsumed.
 	 */
-	if (p->next->filp == 0) {
+	if (p->next->filp == NULL) {
 		struct mem_block *q = p->next;
 		p->size += q->size;
 		p->next = q->next;
@@ -151,7 +151,7 @@
 		DRM_FREE(q, sizeof(*q));
 	}

-	if (p->prev->filp == 0) {
+	if (p->prev->filp == NULL) {
 		struct mem_block *q = p->prev;
 		q->size += p->size;
 		q->next = p->next;
@@ -177,7 +177,7 @@

 	blocks->start = start;
 	blocks->size = size;
-	blocks->filp = 0;
+	blocks->filp = NULL;
 	blocks->next = blocks->prev = *heap;

 	memset(*heap, 0, sizeof(**heap));
@@ -197,7 +197,7 @@

 	for (p = heap->next; p != heap; p = p->next) {
 		if (p->filp == filp) {
-			p->filp = 0;
+			p->filp = NULL;
 			mark_block(dev, p, 0);
 		}
 	}
@@ -206,7 +206,7 @@
 	 * 'heap' to stop it being subsumed.
 	 */
 	for (p = heap->next; p != heap; p = p->next) {
-		while (p->filp == 0 && p->next->filp == 0) {
+		while (p->filp == NULL && p->next->filp == NULL) {
 			struct mem_block *q = p->next;
 			p->size += q->size;
 			p->next = q->next;
diff -Nru a/drivers/char/drm/sis_mm.c b/drivers/char/drm/sis_mm.c
--- a/drivers/char/drm/sis_mm.c	Sat Aug 28 10:18:25 2004
+++ b/drivers/char/drm/sis_mm.c	Sat Aug 28 10:18:25 2004
@@ -90,9 +90,10 @@
 {
 	drm_sis_mem_t fb;
 	struct sis_memreq req;
+	drm_sis_mem_t __user *argp = (void __user *)data;
 	int retval = 0;

-	DRM_COPY_FROM_USER_IOCTL(fb, (drm_sis_mem_t *)data, sizeof(fb));
+	DRM_COPY_FROM_USER_IOCTL(fb, argp, sizeof(fb));

 	req.size = fb.size;
 	sis_malloc(&req);
@@ -111,7 +112,7 @@
 		fb.free = 0;
 	}

-	DRM_COPY_TO_USER_IOCTL((drm_sis_mem_t *)data, fb, sizeof(fb));
+	DRM_COPY_TO_USER_IOCTL(argp, fb, sizeof(fb));

 	DRM_DEBUG("alloc fb, size = %d, offset = %d\n", fb.size, req.offset);

@@ -123,7 +124,7 @@
 	drm_sis_mem_t fb;
 	int retval = 0;

-	DRM_COPY_FROM_USER_IOCTL(fb, (drm_sis_mem_t *)data, sizeof(fb));
+	DRM_COPY_FROM_USER_IOCTL(fb, (drm_sis_mem_t __user *)data, sizeof(fb));

 	if (!fb.free)
 		return DRM_ERR(EINVAL);
