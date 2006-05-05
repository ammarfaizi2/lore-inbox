Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751703AbWEEUcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbWEEUcw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 16:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWEEUcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 16:32:52 -0400
Received: from [151.97.230.9] ([151.97.230.9]:8412 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751703AbWEEUcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 16:32:52 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] blk_start_queue must be called with irq disabled - add warning
Date: Fri, 05 May 2006 17:39:59 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Message-Id: <20060505153959.13099.60729.stgit@zion.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by alpha.home.local id k45KY1U5031112

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The queue lock can be taken from interrupts so it must always be taken with irq
disabling primitives. Some primitives already verify this.
blk_start_queue() is called under this lock, so interrupts must be disabled.

Also document this requirement clearly in blk_init_queue(), where the queue
spinlock is set.

Cc: Jens Axboe <axboe@suse.de>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 block/ll_rw_blk.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index e5041a0..11872d1 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -1663,6 +1663,8 @@ static void blk_unplug_timeout(unsigned 
  **/
 void blk_start_queue(request_queue_t *q)
 {
+	WARN_ON(!irqs_disabled());
+
 	clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);
 
 	/*
@@ -1865,7 +1867,8 @@ EXPORT_SYMBOL(blk_alloc_queue_node);
  *    get dealt with eventually.
  *
  *    The queue spin lock must be held while manipulating the requests on the
- *    request queue.
+ *    request queue; this lock will be taken also from interrupt context, so irq
+ *    disabling is needed for it.
  *
  *    Function returns a pointer to the initialized request queue, or NULL if
  *    it didn't succeed.
