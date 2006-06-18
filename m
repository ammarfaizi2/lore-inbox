Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWFRHgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWFRHgI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWFRHfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:35:20 -0400
Received: from mail33.syd.optusnet.com.au ([211.29.132.104]:61630 "EHLO
	mail33.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932156AbWFRHfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:35:07 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][25/29] mm-decrease_minimum_dirty_ratio.patch
Date: Sun, 18 Jun 2006 17:35:04 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 2160
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181735.05219.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to set dirty_ratio to 0, setting it to MAX_WRITEBACK_PAGES
when the value is ultra low, and set background to 0 when that is the case.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 mm/page-writeback.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

Index: linux-ck-dev/mm/page-writeback.c
===================================================================
--- linux-ck-dev.orig/mm/page-writeback.c	2006-06-18 15:20:11.000000000 +1000
+++ linux-ck-dev/mm/page-writeback.c	2006-06-18 15:25:16.000000000 +1000
@@ -126,9 +126,6 @@ static void get_writeback_state(struct w
  *
  * We only allow 1/2 of the currently-unmapped memory to be dirtied.
  *
- * We don't permit the clamping level to fall below 5% - that is getting rather
- * excessive.
- *
  * We make sure that the background writeout level is below the adjusted
  * clamping level.
  */
@@ -162,15 +159,16 @@ get_dirty_limits(struct writeback_state 
 	if (dirty_ratio > unmapped_ratio / 2)
 		dirty_ratio = unmapped_ratio / 2;
 
-	if (dirty_ratio < 5)
-		dirty_ratio = 5;
-
 	background_ratio = dirty_background_ratio;
 	if (background_ratio >= dirty_ratio)
 		background_ratio = dirty_ratio / 2;
 
 	background = (background_ratio * available_memory) / 100;
 	dirty = (dirty_ratio * available_memory) / 100;
+	if (dirty < MAX_WRITEBACK_PAGES) {
+		dirty = MAX_WRITEBACK_PAGES;
+		background = 0;
+	}
 	tsk = current;
 	if (tsk->flags & PF_LESS_THROTTLE || rt_task(tsk)) {
 		background += background / 4;

-- 
-ck
