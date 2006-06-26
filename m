Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933155AbWFZWfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933155AbWFZWfH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933156AbWFZWfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:35:06 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:34719 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933154AbWFZWfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:01 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 04/20] [Suspend2] Calculate pagedir1 growth allowance.
Date: Tue, 27 Jun 2006 08:35:00 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223459.4050.65990.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While writing the LRU, and (more importantly) as a result of suspending the
drivers, the amount of memory needed for the atomic copy may increase
significantly. This amount is always predictable - LRU I/O will only ever
get a few more slab pages allocated, and drivers suspend and resume will
allocate a fixed number. The problem is that most drivers use virtually
nothing, so that the default allowance of 100 pages is ample. NVidia
drivers especially, however, allocate thousands of pages in some
configurations, so we need a way for the user to be able to tune or
autotune this value.

This routine provides a method for autotuning. If the allowance is set to
zero, this routine will be invoked, determining how much extra memory will
be allocated by the drivers when the real call is made later. We can then
take that, plus our normal 100 page allowance, as the value to use.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index cb1a3da..271f904 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -81,3 +81,29 @@ long real_nr_free_pages(void)
 	return nr_free_pages() + num_pcp_pages();
 }
 
+/*
+ * Discover how much extra memory will be required by the drivers
+ * when they're asked to suspend. We can then ensure that amount
+ * of memory is available when we really want it.
+ */
+static void get_extra_pd1_allowance(void)
+{
+	int orig_num_free = real_nr_free_pages(), final;
+	
+	suspend_prepare_status(CLEAR_BAR, "Finding allowance for drivers.");
+	device_suspend(PMSG_FREEZE);
+	local_irq_disable(); /* irqs might have been re-enabled on us */
+	device_power_down(PMSG_FREEZE);
+	
+	final = real_nr_free_pages();
+
+	device_power_up();
+	local_irq_enable();
+
+	device_resume();
+
+	extra_pd1_pages_allowance = max(
+		orig_num_free - final + MIN_EXTRA_PAGES_ALLOWANCE,
+		MIN_EXTRA_PAGES_ALLOWANCE);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
