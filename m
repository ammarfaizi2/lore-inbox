Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933192AbWFZWgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933192AbWFZWgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933191AbWFZWgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:18 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:40351 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933169AbWFZWfj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:39 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 15/20] [Suspend2] Attempt to freeze processes.
Date: Tue, 27 Jun 2006 08:35:38 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223537.4050.72340.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call the freezer code to get processes frozen, and abort suspending if that
fails. May be called multiple times as we thaw kernel space (only) if we
need to free memory to meet constraints.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index a23722d..12d715a 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -491,3 +491,26 @@ static int update_image(void) 
 		 (header_storage_needed() + main_storage_needed(1, 1)));
 }
 
+/* attempt_to_freeze
+ * 
+ * Try to freeze processes.
+ */
+
+static int attempt_to_freeze(void)
+{
+	int result;
+	
+	/* Stop processes before checking again */
+	thaw_processes(FREEZER_ALL_THREADS);
+	suspend_prepare_status(CLEAR_BAR, "Freezing processes");
+	result = freeze_processes();
+
+	if (result) {
+		set_result_state(SUSPEND_ABORTED);
+		set_result_state(SUSPEND_FREEZING_FAILED);
+	} else
+		are_frozen = 1;
+
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
