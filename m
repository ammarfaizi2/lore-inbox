Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262842AbVDAS2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbVDAS2z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbVDAS0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:26:53 -0500
Received: from webmail.topspin.com ([12.162.17.3]:34971 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262842AbVDASZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:25:00 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][3/6] IB: Fix FMR pool crash
In-Reply-To: <2005411023.AERMWYHGiX8V5KDM@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 10:23:51 -0800
Message-Id: <2005411023.09JoUTQ2SAMPiKPQ@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 18:23:51.0254 (UTC) FILETIME=[F4375760:01C536E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mask bits correctly from jhash result in ib_fmr_hash() so that the
computed bucket index is within our hash table.  This fixes an SDP
crash.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/core/fmr_pool.c	2005-03-31 19:07:05.000000000 -0800
+++ linux-export/drivers/infiniband/core/fmr_pool.c	2005-04-01 10:08:58.240241456 -0800
@@ -103,9 +103,8 @@
 
 static inline u32 ib_fmr_hash(u64 first_page)
 {
-	return jhash_2words((u32) first_page,
-			    (u32) (first_page >> 32),
-			    0);
+	return jhash_2words((u32) first_page, (u32) (first_page >> 32), 0) &
+		(IB_FMR_HASH_SIZE - 1);
 }
 
 /* Caller must hold pool_lock */

