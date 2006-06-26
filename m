Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933203AbWFZXVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933203AbWFZXVB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933106AbWFZWgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:53 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:46495 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933169AbWFZWgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:20 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 06/19] [Suspend2] Initialise modules before doing I/O.
Date: Tue, 27 Jun 2006 08:36:18 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223617.4219.53258.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a routine to initialise modules in preparation for reading or writing a
portion of the image proper (not used for the header).

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index b3a997f..401789d 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -161,3 +161,48 @@ static void fill_suspend_header(struct s
 		       suspend_io_time[i/2][i%2];
 }
 
+/*
+ * rw_init_modules
+ *
+ * Iterate over modules, preparing the ones that will be used to read or write
+ * data.
+ */
+static int rw_init_modules(int rw, int which)
+{
+	struct suspend_module_ops *this_module;
+	/* Initialise page transformers */
+	list_for_each_entry(this_module, &suspend_filters, type_list) {
+		if (this_module->disabled)
+			continue;
+		if (this_module->rw_init &&
+		     	this_module->rw_init(rw, which)) {
+			abort_suspend("Failed to initialise the %s filter.",
+				this_module->name);
+				return 1;
+		}
+	}
+
+	/* Initialise writer */
+	if (suspend_active_writer->rw_init(rw, which)) {
+		abort_suspend("Failed to initialise the writer."); 
+		if (!rw)
+			suspend_active_writer->invalidate_image();
+		return 1;
+	}
+
+	/* Initialise other modules */
+	list_for_each_entry(this_module, &suspend_modules, module_list) {
+		if (this_module->disabled)
+			continue;
+		if ((this_module->type == FILTER_MODULE) ||
+		    (this_module->type == WRITER_MODULE))
+			continue;
+		if (this_module->rw_init && this_module->rw_init(rw, which)) {
+				set_result_state(SUSPEND_ABORTED);
+				return 1;
+			}
+	}
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
