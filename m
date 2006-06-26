Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933217AbWFZXS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933217AbWFZXS6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWFZXS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:18:57 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:55711 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933209AbWFZWhW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:37:22 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 04/32] [Suspend2] Check the io stats.
Date: Tue, 27 Jun 2006 08:37:20 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223718.4376.43898.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perform sanity checking at the conclusion of performing some I/O. By the
time this is called, there should be no outstanding I/O, and the io_info
structure lists should all be empty. We check these conditions, and display
the vital statistics if the appropriate debugging level is enabled.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index 51e02ef..09682c4 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -144,3 +144,38 @@ static void suspend_reset_io_stats(void)
 		nr_schedule_calls[i] = 0;
 }
 
+/*
+ * suspend_check_io_stats
+ *
+ * Description:	Check that our statistics look right and print
+ * 		any debugging info wanted.
+ */
+static void suspend_check_io_stats(void)
+{
+	int i;
+
+	BUG_ON(atomic_read(&outstanding_io));
+	BUG_ON(infopages);
+	BUG_ON(!list_empty(&ioinfo_submit_batch));
+	BUG_ON(!list_empty(&ioinfo_busy));
+	BUG_ON(!list_empty(&ioinfo_ready_for_cleanup));
+	BUG_ON(!list_empty(&ioinfo_free));
+	BUG_ON(atomic_read(&buffer_allocs) != atomic_read(&buffer_frees));
+
+	suspend_message(SUSPEND_WRITER, SUSPEND_LOW, 0,
+			"Maximum outstanding_io was %d.\n",
+			max_outstanding_io);
+	suspend_message(SUSPEND_WRITER, SUSPEND_LOW, 0,
+			"Max info pages was %d.\n",
+			maxinfopages);
+	if (atomic_read(&buffer_allocs) != atomic_read(&buffer_frees))
+		suspend_message(SUSPEND_WRITER, SUSPEND_MEDIUM, 0,
+			"Buffer allocs (%d) != buffer frees (%d)",
+				atomic_read(&buffer_allocs),
+				atomic_read(&buffer_frees));
+	for(i = 0; i < 8; i++)
+		suspend_message(SUSPEND_WRITER, SUSPEND_MEDIUM, 0,
+			"Nr schedule calls %s: %lu.\n", sch_caller[i],
+			nr_schedule_calls[i]);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
