Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbVJ0Wpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbVJ0Wpj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVJ0Wpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:45:39 -0400
Received: from packet.digeo.com ([12.110.80.53]:4262 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id S932645AbVJ0Wpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:45:38 -0400
From: "Jayachandran C." <jchandra@digeo.com>
Date: Thu, 27 Oct 2005 15:45:26 -0700
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] as: Fix issue reported by coverity in drivers/block/as-iosched.c
Message-ID: <20051027224526.GD20378@random.pao.digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-OriginalArrivalTime: 27 Oct 2005 22:45:26.0690 (UTC) FILETIME=[1FC29020:01C5DB48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an issue found in drivers/block/as-iosched.c by Coverity.

Error reported: 
CID: 3167
Checker: FORWARD_NULL (help)
File: /export2/p4-coverity/mc2/linux26/drivers/block/as-iosched.c
Function: as_insert_request
Description: Variable "arq" tracked as NULL was passed to a function that 
dereferences it.

Patch description:
It looks as if the code already assumes that arq != NULL. If arq == NULL, it
should crash later where arq is dereferenced(e.g. as_add_request) without
checking.  Removed the NULL check.

Signed-off-by: Jayachandran C. <c.jayachandran at gmail.com>

---

 as-iosched.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

--- linux-2.6.14-rc4-git2.clean/drivers/block/as-iosched.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.14-rc4-git2/drivers/block/as-iosched.c	2005-10-26 15:57:50.342974379 -0700
@@ -1513,13 +1513,11 @@
 	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
 
-	if (arq) {
-		if (arq->state != AS_RQ_PRESCHED) {
-			printk("arq->state: %d\n", arq->state);
-			WARN_ON(1);
-		}
-		arq->state = AS_RQ_NEW;
+	if (arq->state != AS_RQ_PRESCHED) {
+		printk("arq->state: %d\n", arq->state);
+		WARN_ON(1);
 	}
+	arq->state = AS_RQ_NEW;
 
 	/* barriers must flush the reorder queue */
 	if (unlikely(rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)
