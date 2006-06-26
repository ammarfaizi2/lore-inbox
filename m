Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933216AbWFZX0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933216AbWFZX0u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933208AbWFZX0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:26:25 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:45471 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933172AbWFZWgN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:13 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 04/19] [Suspend2] Reset modules after invalidating an image.
Date: Tue, 27 Jun 2006 08:36:12 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223610.4219.99290.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reset modules after using them to read an image header and invalidate it,
when the user puts noresume2 on the command line.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index bfe4468..5c0acdd 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -111,3 +111,23 @@ void attempt_to_parse_resume_device2(voi
 	suspend_cleanup_usm();
 }
 
+/* noresume_reset_modules
+ *
+ * Description:	When we read the start of an image, modules (and especially the
+ * 		active writer) might need to reset data structures if we decide
+ * 		to invalidate the image rather than resuming from it.
+ */
+
+static void noresume_reset_modules(void)
+{
+	struct suspend_module_ops *this_filter;
+	
+	list_for_each_entry(this_filter, &suspend_filters, type_list) {
+		if (this_filter->noresume_reset)
+			this_filter->noresume_reset();
+	}
+
+	if (suspend_active_writer && suspend_active_writer->noresume_reset)
+		suspend_active_writer->noresume_reset();
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
