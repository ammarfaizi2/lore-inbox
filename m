Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWI2Byf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWI2Byf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 21:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWI2Bye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 21:54:34 -0400
Received: from mga07.intel.com ([143.182.124.22]:22545 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751282AbWI2Bye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 21:54:34 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,232,1157353200"; 
   d="scan'208"; a="124578905:sNHT2735555676"
Subject: [PATCH] Add flag __GFP_NOFAIL when allocating block
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1159494812.20092.727.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 29 Sep 2006 09:53:33 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang, Yanmin <yanmin.zhang@intel.com>

Function journal_write_metadata_buffer doesn't estimate the return
value of jbd_slab_alloc. If the allocation fails, later jbd_slab_free
or memcpy will cause kernel oops.

Add flag __GFP_NOFAIL when allocating block. The patch is against
2.6.18-mm1.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

--- linux-2.6.18_mm1/fs/jbd/journal.c	2006-09-29 07:19:49.000000000 -0600
+++ linux-2.6.18_mm1_fix/fs/jbd/journal.c	2006-09-30 03:01:38.000000000 -0600
@@ -329,7 +329,7 @@ repeat:
 		char *tmp;
 
 		jbd_unlock_bh_state(bh_in);
-		tmp = jbd_slab_alloc(bh_in->b_size, GFP_NOFS);
+		tmp = jbd_slab_alloc(bh_in->b_size, GFP_NOFS|__GFP_NOFAIL);
 		jbd_lock_bh_state(bh_in);
 		if (jh_in->b_frozen_data) {
 			jbd_slab_free(tmp, bh_in->b_size);
