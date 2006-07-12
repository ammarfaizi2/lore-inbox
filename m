Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWGLIEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWGLIEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 04:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWGLIDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 04:03:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45369 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750850AbWGLICc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 04:02:32 -0400
Date: Wed, 12 Jul 2006 10:05:19 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: nickpiggin@yahoo.com.au
Subject: [PATCH 4/7] elevator: introduce a way to reuse rq for internal FIFO handling
Message-ID: <20060712080519.GE13920@suse.de>
References: <20060712080319.GA13920@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712080319.GA13920@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] elevator: introduce a way to reuse rq for internal FIFO handling

The io schedulers can use this instead of having to allocate space for
it themselves.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 include/linux/elevator.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 38f0f0d..6e1c903 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -167,4 +167,16 @@ enum {
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

-- 
Jens Axboe

