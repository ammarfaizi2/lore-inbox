Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVDSRER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVDSRER (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 13:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVDSRER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 13:04:17 -0400
Received: from galileo.bork.org ([134.117.69.57]:59861 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261152AbVDSREN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 13:04:13 -0400
Date: Tue, 19 Apr 2005 13:04:13 -0400
From: Martin Hicks <mort@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, holt@sgi.com
Subject: [PATCH] pgtables: fix GFP_KERNEL allocation with preempt disabled
Message-ID: <20050419170413.GB21616@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

This is a fix to the pgtable_quicklist code.  There is a GFP_KERNEL
allocation in pgtable_quicklist_alloc(), which spews the usual warnings
if the kernel is under heavy VM pressure and the reclaim code is
invoked.

This patch is against 2.6.12-rc2-mm2

Signed-off-by:  Martin Hicks <mort@sgi.com>


Index: linux-2.6.12-rc2.wk/include/asm-ia64/pgalloc.h
===================================================================
--- linux-2.6.12-rc2.wk.orig/include/asm-ia64/pgalloc.h	2005-04-19 09:01:06.000000000 -0700
+++ linux-2.6.12-rc2.wk/include/asm-ia64/pgalloc.h	2005-04-19 09:53:39.000000000 -0700
@@ -50,7 +50,7 @@ static inline void *pgtable_quicklist_al
 		ret[0] = 0;
 		--pgtable_quicklist_size;
 	} else {
-		ret = (unsigned long *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+		ret = (unsigned long *)__get_free_page(GFP_ATOMIC | __GFP_ZERO);
 	}
 
 	preempt_enable();
