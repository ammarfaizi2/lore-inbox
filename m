Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933215AbWFZXQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933215AbWFZXQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933232AbWFZWhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:37:39 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:57247 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933231AbWFZWhc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:37:32 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 07/32] [Suspend2] Wait for bio completion.
Date: Tue, 27 Jun 2006 08:37:31 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223729.4376.77995.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Submit any outstanding batched I/O, kick kblockd, io_schedule() and see
what we can cleanup.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index cfff687..6f8b29e 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -310,3 +310,26 @@ static void suspend_cleanup_some_complet
 	spin_unlock_irqrestore(&ioinfo_ready_lock, flags);
 }
 
+/* do_bio_wait
+ *
+ * Actions taken when we want some I/O to get run.
+ * 
+ * Submit any I/O that's batched up (if we're not already doing
+ * that, unplug queues, schedule and clean up whatever we can.
+ */
+static void do_bio_wait(int caller)
+{
+	int num_submitted = 0;
+
+	nr_schedule_calls[caller]++;
+	
+	/* Don't want to wait on I/O we haven't submitted! */
+	num_submitted = submit_batched();
+
+	kblockd_flush();
+	
+	io_schedule();
+
+	suspend_cleanup_some_completed_io();
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
