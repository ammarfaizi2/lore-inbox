Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTFJPYg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263245AbTFJPX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:23:58 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:19837 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263183AbTFJPWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:22:01 -0400
Date: Tue, 10 Jun 2003 16:38:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] loop 9/9 don't lose PF_MEMDIE
In-Reply-To: <Pine.LNX.4.44.0306101606080.2285-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0306101637090.2285-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loop_get_buffer loses PF_MEMDIE if it's added while in loop_copy_bio:
not a high probability since it's not waiting there, but could happen,
and sets a bad example (compare with add_to_swap fixed a while back).

--- loop8/drivers/block/loop.c	Tue Jun 10 11:55:11 2003
+++ loop9/drivers/block/loop.c	Tue Jun 10 12:05:17 2003
@@ -484,7 +484,9 @@
 
 		current->flags &= ~PF_MEMALLOC;
 		bio = loop_copy_bio(rbh);
-		current->flags = flags;
+		if (flags & PF_MEMALLOC)
+			current->flags |= PF_MEMALLOC;
+
 		if (bio == NULL)
 			blk_congestion_wait(WRITE, HZ/10);
 	} while (bio == NULL);

