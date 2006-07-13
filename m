Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWGMMoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWGMMoE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWGMMoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:44:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26927 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751497AbWGMMoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:44:02 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH] 7/15 elevator: introduce a way to reuse rq for internal FIFO handling
Date: Thu, 13 Jul 2006 14:46:30 +0200
Message-Id: <1152794798200-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
In-Reply-To: <11527947982769-git-send-email-axboe@suse.de>
References: <11527947982769-git-send-email-axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The io schedulers can use this instead of having to allocate space for
it themselves.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 include/linux/elevator.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 95b2a04..0e7b1a7 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -166,4 +166,16 @@ enum {
 #define rq_end_sector(rq)	((rq)->sector + (rq)->nr_sectors)
 #define rb_entry_rq(node)	rb_entry((node), struct request, rb_node)
 
+/*
+ * Hack to reuse the donelist list_head as the fifo time holder while
+ * the request is in the io scheduler. Saves an unsigned long in rq.
+ */
+#define rq_fifo_time(rq)	((unsigned long) (rq)->donelist.next)
+#define rq_set_fifo_time(rq,exp)	((rq)->donelist.next = (void *) (exp))
+#define rq_entry_fifo(ptr)	list_entry((ptr), struct request, queuelist)
+#define rq_fifo_clear(rq)	do {		\
+	list_del_init(&(rq)->queuelist);	\
+	INIT_LIST_HEAD(&(rq)->donelist);	\
+	} while (0)
+
 #endif
-- 
1.4.1.ged0e0

