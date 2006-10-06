Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422981AbWJFVhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422981AbWJFVhR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422984AbWJFVhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:37:17 -0400
Received: from mx2.netapp.com ([216.240.18.37]:57387 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1422982AbWJFVhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:37:15 -0400
X-IronPort-AV: i="4.09,273,1157353200"; 
   d="scan'208"; a="415716431:sNHT16042840"
Subject: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Andrew Morton <akpm@osdl.org>, Steve Dickson <SteveD@redhat.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Fri, 06 Oct 2006 17:37:09 -0400
Message-Id: <1160170629.5453.34.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 06 Oct 2006 21:37:24.0785 (UTC) FILETIME=[9CDB4A10:01C6E98F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If try_to_release_page() is called with a zero gfp mask, then the
filesystem is effectively denied the possibility of sleeping while
attempting to release the page. There doesn't appear to be any valid
reason why this should be banned, given that we're not calling this from
a memory allocation context.
 
For this reason, change the gfp_mask argument of the call to GFP_KERNEL.
    
Note: I am less sure of what the callers of invalidate_complete_page()
require, and so this patch does not touch that mask.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---
diff --git a/mm/truncate.c b/mm/truncate.c
index f4edbc1..49c1ffd 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -302,7 +302,7 @@ invalidate_complete_page2(struct address
 	if (page->mapping != mapping)
 		return 0;
 
-	if (PagePrivate(page) && !try_to_release_page(page, 0))
+	if (PagePrivate(page) && !try_to_release_page(page, GFP_KERNEL))
 		return 0;
 
 	write_lock_irq(&mapping->tree_lock);
