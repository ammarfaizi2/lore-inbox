Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUIOAUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUIOAUq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 20:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUIOAUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 20:20:46 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:14783 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264443AbUIOAUn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 20:20:43 -0400
Subject: [Patch 1/2]: ext3 reservation window size increase incorrectly fix
From: Mingming Cao <cmm@us.ibm.com>
To: Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       pbadari@us.ibm.com
In-Reply-To: <200409071302.i87D2bDf030921@sisko.scot.redhat.com>
References: <200409071302.i87D2bDf030921@sisko.scot.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Sep 2004 17:20:33 -0700
Message-Id: <1095207635.1637.22612.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two ext3 reservation bug fixes.

In current reservation code (with or without the recent red-black tree
changes), when an existing old reservation is re-used as the new window
without adjusting it's position in the current per-filesystem tree, we
just need to update window's start and end block value, without any
remove/insert business. But we missed the the allocation hit ratio bit,
it is not reset.

Since this is the magic number used to determine whether the window size
should be doubled next time, this will cause the window size increase
incorrectly or too quickly.

Patch applies to 2.6.9-rc1-mm5, tested.

---

 linux-2.6.9-rc1-mm5-ming/fs/ext3/balloc.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN fs/ext3/balloc.c~ext3_reservation_window_hit_ratio_fix fs/ext3/balloc.c
--- linux-2.6.9-rc1-mm5/fs/ext3/balloc.c~ext3_reservation_window_hit_ratio_fix	2004-09-14 00:30:41.667359608 -0700
+++ linux-2.6.9-rc1-mm5-ming/fs/ext3/balloc.c	2004-09-14 00:34:19.170294136 -0700
@@ -945,6 +945,7 @@ found_rsv_window:
 	}
 	my_rsv->rsv_start = reservable_space_start;
 	my_rsv->rsv_end = my_rsv->rsv_start + size - 1;
+	atomic_set(&my_rsv->rsv_alloc_hit, 0);
 	if (my_rsv != prev_rsv)  {
 		rsv_window_add(sb, my_rsv);
 	}

_



