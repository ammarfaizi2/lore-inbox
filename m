Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbTFPNc3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 09:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTFPNc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 09:32:29 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:58231 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S262029AbTFPNc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 09:32:28 -0400
Date: Mon, 16 Jun 2003 14:47:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Suparna Bhattacharya <suparna@in.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] lock_buffer_wq do lock
Message-ID: <Pine.LNX.4.44.0306161435110.1846-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've twice got fs/buffer.c:2668 submit_bh BUG_ON(!buffer_locked(bh)):
when called from sync_dirty_buffer which clearly does the lock_buffer.
My suspicion falls on lock_buffer_wq (whereas __lock_page_wq looks OK).

I'm leaving a test running,
can't judge until tomorrow whether this is indeed the fix to that.

Hugh

--- 2.5.71-mm1/include/linux/buffer_head.h	Sun Jun 15 12:36:11 2003
+++ linux/include/linux/buffer_head.h	Mon Jun 16 14:13:25 2003
@@ -291,9 +291,11 @@
 
 static inline int lock_buffer_wq(struct buffer_head *bh, wait_queue_t *wait)
 {
-	if (test_set_buffer_locked(bh))
-		return __wait_on_buffer_wq(bh, wait);
-
+	while (test_set_buffer_locked(bh)) {
+		int ret = __wait_on_buffer_wq(bh, wait);
+		if (ret)
+			return ret;
+	}
 	return 0;
 }
 

