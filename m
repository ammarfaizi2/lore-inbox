Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933199AbWFZXUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933199AbWFZXUA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933170AbWFZWg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:57 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:49567 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933199AbWFZWgl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:41 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 12/19] [Suspend2] Read module configs from an image header.
Date: Tue, 27 Jun 2006 08:36:39 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223638.4219.31885.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Read the configurations used when writing the image, prior to loading the
data. Modules which are loaded now, and weren't when we suspended are
disabled. If a module which is needed is not available, we complain and
abort resuming. When built as modules, support for (say) encryption and
compression can end up loaded in the wrong order. We therefore also reorder
the modules to match the order used when suspending.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |  126 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 126 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index a0aabd1..b179c50 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -488,3 +488,129 @@ static int write_module_configs(void)
 	return 0;
 }
 
+/* read_module_configs()
+ *
+ * Description:	Reload module configurations from the image header.
+ * Returns:	Int. Zero on success, error value otherwise.
+ */
+
+static int read_module_configs(void)
+{
+	struct suspend_module_ops *this_module;
+	char *buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	int len, result = 0;
+	struct suspend_module_header suspend_module_header;
+
+	if (!buffer) {
+		printk("Failed to allocate a buffer for reloading module "
+				"configuration info.\n");
+		return -ENOMEM;
+	}
+		
+	/* All modules are initially disabled. That way, if we have a module
+	 * loaded now that wasn't loaded when we suspended, it won't be used
+	 * in trying to read the data.
+	 */
+	list_for_each_entry(this_module, &suspend_modules, module_list)
+		this_module->disabled = 1;
+	
+	/* Get the first module header */
+	result = suspend_active_writer->rw_header_chunk(READ, NULL,
+			(char *) &suspend_module_header, sizeof(suspend_module_header));
+	if (!result) {
+		printk("Failed to read the next module header.\n");
+		free_page((unsigned long) buffer);
+		return -EINVAL;
+	}
+
+	/* For each module (in registration order) */
+	while (suspend_module_header.name[0]) {
+
+		/* Find the module */
+		this_module = suspend_find_module_given_name(suspend_module_header.name);
+
+		if (!this_module) {
+			/* 
+			 * Is it used? Only need to worry about filters. The active
+			 * writer must be loaded!
+			 */
+			if (!suspend_module_header.disabled) {
+				suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,
+					"It looks like we need module %s for "
+					"reading the image but it hasn't been "
+					"registered.\n",
+					suspend_module_header.name);
+				if (!(test_suspend_state(SUSPEND_CONTINUE_REQ))) {
+					suspend_active_writer->invalidate_image();
+					free_page((unsigned long) buffer);
+					return -EINVAL;
+				}
+			} else
+				printk("Module %s configuration data found, but the module "
+					"hasn't registered. Looks like it was disabled, so "
+					"we're ignoring it's data.",
+					suspend_module_header.name);
+		}
+		
+		/* Get the length of the data (if any) */
+		result = suspend_active_writer->rw_header_chunk(READ, NULL,
+				(char *) &len, sizeof(int));
+		if (!result) {
+			printk("Failed to read the length of the module %s's"
+					" configuration data.\n",
+					suspend_module_header.name);
+			free_page((unsigned long) buffer);
+			return -EINVAL;
+		}
+
+		/* Read any data and pass to the module (if we found one) */
+		if (len) {
+			suspend_active_writer->rw_header_chunk(READ, NULL,
+					buffer, len);
+			if (this_module) {
+				if (!this_module->save_config_info) {
+					printk("Huh? Module %s appears to have "
+						"a save_config_info, but not a "
+						"load_config_info function!\n",
+						this_module->name);
+				} else
+					this_module->load_config_info(buffer, len);
+			}
+		}
+
+		if (this_module) {
+			/* Now move this module to the tail of its lists. This
+			 * will put it in order. Any new modules will end up at
+			 * the top of the lists. They should have been set to
+			 * disabled when loaded (people will normally not edit
+			 * an initrd to load a new module and then suspend
+			 * without using it!).
+			 */
+
+			suspend_move_module_tail(this_module);
+
+			/* 
+			 * We apply the disabled state; modules don't need to
+			 * save whether they were disabled and if they do, we
+			 * override them anyway.
+			 */
+			this_module->disabled = suspend_module_header.disabled;
+		}
+
+		/* Get the next module header */
+		result = suspend_active_writer->rw_header_chunk(READ, NULL,
+				(char *) &suspend_module_header,
+				sizeof(suspend_module_header));
+
+		if (!result) {
+			printk("Failed to read the next module header.\n");
+			free_page((unsigned long) buffer);
+			return -EINVAL;
+		}
+
+	}
+
+	free_page((unsigned long) buffer);
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
