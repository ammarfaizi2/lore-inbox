Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933188AbWFZWgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933188AbWFZWgL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933163AbWFZWgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:07 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:41887 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933172AbWFZWfu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:50 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 18/20] [Suspend2] Free up memory if necessary.
Date: Tue, 27 Jun 2006 08:35:48 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223547.4050.40672.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seek to ensure memory constraints are met. If we need to free memory, we
thaw kernel space processes only, so that we won't deadlock with the swap
and filesystem code. We then call shrink_all_memory until the constraints
are met or we determine that we're not getting anywhere. We may also bail
immediately if the user has said they don't want any memory to be freed.
Kernel space is re-frozen before we exit.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |   94 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index 054d0d4..893ba72 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -528,3 +528,97 @@ long ram_to_suspend(void)
 		MIN_FREE_RAM + suspend_memory_for_modules());
 }
 
+/* eat_memory
+ *
+ * Try to free some memory, either to meet hard or soft constraints on the image
+ * characteristics.
+ * 
+ * Hard constraints:
+ * - Pageset1 must be < half of memory;
+ * - We must have enough memory free at resume time to have pageset1
+ *   be able to be loaded in pages that don't conflict with where it has to
+ *   be restored.
+ * Soft constraints
+ * - User specificied image size limit.
+ */
+static int eat_memory(void)
+{
+	int amount_wanted = 0;
+	int free_flags = 0, did_eat_memory = 0;
+	
+	/*
+	 * Note that if we have enough storage space and enough free memory, we may
+	 * exit without eating anything. We give up when the last 10 iterations ate
+	 * no extra pages because we're not going to get much more anyway, but
+	 * the few pages we get will take a lot of time.
+	 *
+	 * We freeze processes before beginning, and then unfreeze them if we
+	 * need to eat memory until we think we have enough. If our attempts
+	 * to freeze fail, we give up and abort.
+	 */
+
+	/* -- Stage 1: Freeze Processes -- */
+
+	
+	suspend_recalculate_image_contents(0);
+	amount_wanted = amount_needed(1);
+
+	switch (image_size_limit) {
+		case -1: /* Don't eat any memory */
+			if (amount_wanted > 0) {
+				set_result_state(SUSPEND_ABORTED);
+				set_result_state(SUSPEND_WOULD_EAT_MEMORY);
+			}
+			break;
+		case -2:  /* Free caches only */
+			free_flags = GFP_NOIO | __GFP_HIGHMEM;
+			amount_wanted = 1 << 31; /* As much cache as we can get */
+			break;
+		default:
+			free_flags = GFP_ATOMIC | __GFP_HIGHMEM;
+	}
+		
+	thaw_processes(FREEZER_KERNEL_THREADS);
+
+	/* -- Stage 2: Eat memory -- */
+
+	if (amount_wanted > 0 && !test_result_state(SUSPEND_ABORTED) &&
+			image_size_limit != -1) {
+
+		suspend_prepare_status(CLEAR_BAR, "Seeking to free %dMB of memory.", MB(amount_wanted));
+
+		shrink_all_memory(amount_wanted);
+		suspend_recalculate_image_contents(0);
+
+		did_eat_memory = 1;
+
+		suspend_cond_pause(0, NULL);
+	}
+
+	if (freeze_processes()) {
+		set_result_state(SUSPEND_FREEZING_FAILED);
+		set_result_state(SUSPEND_ABORTED);
+	}
+	
+	if (did_eat_memory) {
+		unsigned long orig_state = get_suspend_state();
+		/* Freeze_processes will call sys_sync too */
+		restore_suspend_state(orig_state);
+		suspend_recalculate_image_contents(0);
+	}
+
+	/* Blank out image size display */
+	suspend_update_status(100, 100, NULL);
+
+	if (!test_result_state(SUSPEND_ABORTED) &&
+	    (amount_needed(0) - extra_pd1_pages_allowance > 0)) {
+		printk("Unable to free sufficient memory to suspend. Still need %d pages.\n",
+			amount_needed(1));
+		display_stats(1, 1);
+		set_result_state(SUSPEND_ABORTED);
+		set_result_state(SUSPEND_UNABLE_TO_FREE_ENOUGH_MEMORY);
+	}
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
