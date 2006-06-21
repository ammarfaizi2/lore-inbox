Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWFURBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWFURBU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWFURBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:01:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:34235 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750817AbWFURBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:01:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=E1I+6urskTob8+bkGjm+nqF7GNvoeQ6yRnrDtFY+u2m2VazuCmYGUmERRgafGQQlP/RzqLBMiT5EoM4w/iv6M5QmRGNo85Pj68V3BHnMdCCmjdlb7dQyyvzjTZmKR7prZxmoKOI/D1katpTn94NrlhCLeof0Gb5zmdZpy5hhvdc=
Message-ID: <5c49b0ed0606211001s452c080cu3f55103a130b78f1@mail.gmail.com>
Date: Wed, 21 Jun 2006 10:01:17 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] mm/tracking dirty pages: update get_dirty_limits for mmap tracking
Cc: "Hugh Dickins" <hugh@veritas.com>, "Andrew Morton" <akpm@osdl.org>,
       "David Howells" <dhowells@redhat.com>,
       "Christoph Lameter" <christoph@lameter.com>,
       "Martin Bligh" <mbligh@google.com>, "Nick Piggin" <npiggin@suse.de>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Hans Reiser" <reiser@namesys.com>, "E. Gryaznova" <grev@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update write throttling calculations now that we can track and
throttle dirty mmap'd pages.  A version of this patch has been tested
with iozone:

http://namesys.com/intbenchmarks/iozone/06.06.19.tracking.dirty.page-noatime_-B/e3-2.6.16-tr.drt.pgs-rt.40_vs_rt.80.html
http://namesys.com/intbenchmarks/iozone/06.06.19.tracking.dirty.page-noatime_-B/r4-2.6.16-tr.drt.pgs-rt.40_vs_rt.80.html

Signed-off-by: Nate Diller <nate.diller@gmail.com>

--- linux-2.6.orig/mm/page-writeback.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6/mm/page-writeback.c	2006-06-21 08:24:11.000000000 -0700
@@ -69,7 +69,7 @@ int dirty_background_ratio = 10;
 /*
  * The generator of dirty data starts writeback at this percentage
  */
-int vm_dirty_ratio = 40;
+int vm_dirty_ratio = 80;

 /*
  * The interval between `kupdate'-style writebacks, in centiseconds
@@ -119,15 +119,14 @@ static void get_writeback_state(struct w
  * Work out the current dirty-memory clamping and background writeout
  * thresholds.
  *
- * The main aim here is to lower them aggressively if there is a lot of mapped
- * memory around.  To avoid stressing page reclaim with lots of unreclaimable
- * pages.  It is better to clamp down on writers than to start swapping, and
- * performing lots of scanning.
- *
- * We only allow 1/2 of the currently-unmapped memory to be dirtied.
- *
- * We don't permit the clamping level to fall below 5% - that is getting rather
- * excessive.
+ * We now have dirty memory accounting for mmap'd pages, so we calculate the
+ * ratios based on the available memory.  We still have no way of tracking
+ * how many pages are pinned (eg BSD wired accounting), so we still need the
+ * hard clamping, but the default has been raised to 80.
+ *
+ * We now allow the ratios to be set to anything, because there is less risk
+ * of OOM, and because databases and such will need more flexible tuning,
+ * now that they are being throttled too.
  *
  * We make sure that the background writeout level is below the adjusted
  * clamping level.
@@ -136,9 +135,6 @@ static void
 get_dirty_limits(struct writeback_state *wbs, long *pbackground, long *pdirty,
 		struct address_space *mapping)
 {
-	int background_ratio;		/* Percentages */
-	int dirty_ratio;
-	int unmapped_ratio;
 	long background;
 	long dirty;
 	unsigned long available_memory = total_pages;
@@ -155,27 +151,16 @@ get_dirty_limits(struct writeback_state
 		available_memory -= totalhigh_pages;
 #endif

-
-	unmapped_ratio = 100 - (wbs->nr_mapped * 100) / total_pages;
-
-	dirty_ratio = vm_dirty_ratio;
-	if (dirty_ratio > unmapped_ratio / 2)
-		dirty_ratio = unmapped_ratio / 2;
-
-	if (dirty_ratio < 5)
-		dirty_ratio = 5;
-
-	background_ratio = dirty_background_ratio;
-	if (background_ratio >= dirty_ratio)
-		background_ratio = dirty_ratio / 2;
-
-	background = (background_ratio * available_memory) / 100;
-	dirty = (dirty_ratio * available_memory) / 100;
+	background = (dirty_background_ratio * available_memory) / 100;
+	dirty = (vm_dirty_ratio * available_memory) / 100;
 	tsk = current;
 	if (tsk->flags & PF_LESS_THROTTLE || rt_task(tsk)) {
 		background += background / 4;
-		dirty += dirty / 4;
+		dirty += dirty / 8;
 	}
+	if (background > dirty)
+		background = dirty;
+
 	*pbackground = background;
 	*pdirty = dirty;
 }
