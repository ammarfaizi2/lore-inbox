Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVGFDBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVGFDBe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVGFDAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:00:43 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:7577 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262063AbVGFCT0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:26 -0400
Subject: [PATCH] [28/48] Suspend2 2.1.9.8 for 2.6.12: 605-kernel_power_suspend.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:42 +1000
Message-Id: <1120616442343@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 606-all-settings.patch-old/kernel/power/suspend2_core/all_settings.c 606-all-settings.patch-new/kernel/power/suspend2_core/all_settings.c
--- 606-all-settings.patch-old/kernel/power/suspend2_core/all_settings.c	1970-01-01 10:00:00.000000000 +1000
+++ 606-all-settings.patch-new/kernel/power/suspend2_core/all_settings.c	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,325 @@
+/*
+ * /kernel/power/suspend2_core/all_settings.c
+ *
+ * Suspend2 is released under the GPLv2.
+ * 
+ * Copyright (C) 2002-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file provides the all_settings proc entry, used to save
+ * and restore all suspend2 settings en masse.
+ */
+
+#include <linux/mm.h>
+#include <linux/suspend.h>
+#include <asm/uaccess.h>
+
+#include "plugins.h"
+#include "proc.h"
+#include "suspend2_common.h"
+#include "prepare_image.h"
+#include "power_off.h"
+#include "io.h"
+
+#define ALL_SETTINGS_VERSION 4
+
+static int resume2_len;
+
+/*
+ * suspend_write2_compat_proc.
+ *
+ * This entry allows all of the settings to be set at once. 
+ * It was originally for compatibility with pre- /proc/suspend
+ * versions, but has been retained because it makes saving and
+ * restoring the configuration simpler.
+ */
+static int suspend2_write_compat_proc(struct file *file, const char * buffer,
+		unsigned long count, void * data)
+{
+	char * buf1 = (char *) get_zeroed_page(GFP_ATOMIC), *curbuf, *lastbuf;
+	char * buf2 = (char *) get_zeroed_page(GFP_ATOMIC); 
+	int i, file_offset = 0, used_size = 0, reparse_resume_device = 0;
+	unsigned long nextval;
+	struct suspend_plugin_ops * plugin;
+	struct plugin_header * plugin_header = NULL;
+	int version_applying = 0;
+
+	if ((!buf1) || (!buf2)) {
+		count = -ENOMEM;
+		goto out2;
+	}
+
+	while (file_offset < count) {
+		int length = count - file_offset;
+		if (length > (PAGE_SIZE - used_size))
+			length = PAGE_SIZE - used_size;
+
+		if (copy_from_user(buf1 + used_size, buffer + file_offset, length)) {
+			count = -EFAULT;
+			goto out2;
+		}
+
+		curbuf = buf1;
+
+		if (!file_offset) {
+			/* Integers first */
+			for (i = 0; i < 8; i++) {
+				if (!*curbuf)
+					break;
+				lastbuf = curbuf;
+				nextval = simple_strtoul(curbuf, &curbuf, 0);
+				if (curbuf == lastbuf)
+					break;
+				switch (i) {
+					case 0:
+						version_applying = nextval;
+						if (nextval < 3) {
+							printk("Error loading saved settings. This data is for version %ld, but kernel module supports format 3 or later.\n",
+									nextval);
+							goto out2;
+						}
+					case 1:
+						suspend_result = nextval;
+						break;
+					case 2:
+						suspend_action = nextval;
+						break;
+					case 3:
+#ifdef CONFIG_PM_DEBUG
+						suspend_debug_state = nextval;
+#endif
+						break;
+					case 4:
+						suspend_default_console_level = nextval;
+#ifndef CONFIG_PM_DEBUG
+						if (suspend_default_console_level > 1)
+							suspend_default_console_level = 1;
+#endif
+						break;
+					case 5:
+						image_size_limit = nextval;
+						break;
+					case 6:
+#ifdef CONFIG_ACPI
+						suspend2_powerdown_method = nextval;
+						if (suspend2_powerdown_method < 3)
+							suspend2_powerdown_method = 3;
+						if (suspend2_powerdown_method > 5)
+#endif
+							suspend2_powerdown_method = 5;
+						break;
+					case 7:
+						resume2_len = nextval;
+				}
+
+				curbuf++;
+				while (*curbuf == ' ')
+					curbuf++;
+
+				if (version_applying == 3 && i == 7)
+					break;
+			}
+
+			if (count <= (curbuf - buf1))
+				goto out;
+			else {
+				list_for_each_entry(plugin, &suspend_plugins, plugin_list)
+					plugin->disabled = 1;
+			}
+
+			if (version_applying > 3) {
+				/* Resume2.
+				 *
+				 * Since the integers will be short and resume2 is 255 chars max,
+				 * there's no danger of buffer overflow.
+				 */
+				strncpy(resume2_file, curbuf, resume2_len);
+				curbuf += resume2_len + 1;
+			}
+		}
+
+		if (((unsigned long) curbuf  & ~PAGE_MASK) + sizeof(plugin_header) > PAGE_SIZE)
+			goto shift_buffer;
+		
+		/* Plugins */
+		plugin_header = (struct plugin_header *) curbuf;
+
+		if (((unsigned long) curbuf & ~PAGE_MASK) + sizeof(plugin_header) + plugin_header->data_length  > PAGE_SIZE)
+			goto shift_buffer;
+		
+		if (plugin_header->signature != 0xADEDC0DE) {
+			printk("Bad plugin data signature.\n");
+			break;
+		}
+
+		plugin = find_plugin_given_name(plugin_header->name);
+
+		if (plugin) {	/* May validly have config saved for a plugin not now loaded */
+			if ((plugin->type == WRITER_PLUGIN) &&
+			    ((!active_writer && plugin->disabled && !plugin_header->disabled) ||
+			     (active_writer == plugin && plugin_header->disabled)))
+				reparse_resume_device = 1;
+			plugin->disabled = plugin_header->disabled;
+			if (plugin_header->data_length)
+				plugin->load_config_info(curbuf + sizeof(struct plugin_header), 
+						plugin_header->data_length);
+		} else
+			printk("Data for plugin %s not used because not currently loaded.\n", plugin_header->name);
+
+		curbuf += sizeof(struct plugin_header) + plugin_header->data_length;
+
+shift_buffer:
+		if (!(curbuf - buf1))
+			break;
+
+		file_offset += curbuf - buf1;
+		
+		used_size = PAGE_SIZE + buf1 - curbuf;
+		memcpy(buf2, curbuf, used_size);
+		memcpy(buf1, buf2, used_size);
+	}
+out:
+	attempt_to_parse_resume_device();
+
+out2:
+	if (buf1)
+		free_pages((unsigned long) buf1, 0);
+
+	if (buf2)
+		free_pages((unsigned long) buf2, 0);
+	
+	return count;
+}
+
+/*
+ * suspend2_read_compat_proc.
+ *
+ * Like its sibling, this entry allows all of the settings
+ * to be read at once.
+ * It too was originally for compatibility with pre- /proc/suspend
+ * versions, but has been retained because it makes saving and
+ * restoring the configuration simpler.
+ */
+static int suspend2_read_compat_proc(char * page, char ** start, off_t off, int count,
+		int *eof, void *data)
+{
+	struct suspend_plugin_ops * this_plugin;
+	char * buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	int index = 1, file_pos = 0, page_offset = 0, len;
+	int copy_len = 0;
+	struct plugin_header plugin_header;
+
+	if (!buffer) {
+		printk("Failed to allocate a buffer for getting "
+				"plugin configuration info.\n");
+		return -ENOMEM;
+	}
+		
+	plugin_header.signature = 0xADEDC0DE;
+
+	len = sprintf(buffer, "%d %ld %ld %ld %d %d %ld %d %s\n",
+			ALL_SETTINGS_VERSION,
+			suspend_result,
+			suspend_action,
+			suspend_debug_state,
+			suspend_default_console_level,
+			image_size_limit,
+			suspend2_powerdown_method,
+			strlen(resume2_file),
+			resume2_file);
+
+	if (len >= off) {
+		copy_len = (len < off + count) ? len - off : count - off;
+		memcpy(page, buffer + off, copy_len);
+		page_offset+= copy_len;
+	}
+
+	file_pos += len;
+
+	/* 
+	 * We have to know which data goes with which plugin, so we at
+	 * least write a length of zero for a plugin. Note that we are
+	 * also assuming every plugin's config data takes <= PAGE_SIZE.
+	 */
+
+	/* For each plugin (in registration order) */
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+
+		/* Get the data from the plugin */
+		if (this_plugin->save_config_info) {
+			plugin_header.data_length = this_plugin->save_config_info(buffer);
+		} else
+			plugin_header.data_length = 0;
+
+		if (file_pos > (off + count)) {
+			file_pos += sizeof(struct plugin_header) + plugin_header.data_length;
+			continue;
+		}
+
+		len = 0;
+		if ((file_pos + sizeof(struct plugin_header) >= off) &&
+		    (file_pos < (off + count))) {
+
+			/* Save the details of the plugin */
+			memcpy(plugin_header.name, this_plugin->name, 
+					SUSPEND_MAX_PLUGIN_NAME_LENGTH);
+			plugin_header.disabled = this_plugin->disabled;
+			plugin_header.type = this_plugin->type;
+			plugin_header.index = index++;
+			
+			copy_len = sizeof(struct plugin_header);
+
+			if (copy_len + page_offset > count)
+				copy_len = count - page_offset;
+
+			memcpy(page + page_offset,
+				 ((char *) &plugin_header) + off + page_offset - file_pos,
+				 copy_len);	 
+
+			page_offset += copy_len;
+		}
+
+		file_pos += sizeof(struct plugin_header);
+
+		if (plugin_header.data_length && (file_pos >= off) && (file_pos < (off + count))) {
+			copy_len = plugin_header.data_length;
+
+			if (copy_len + page_offset > count + off)
+				copy_len = count - page_offset;
+			
+			memcpy(page + page_offset,
+				 buffer,
+				 copy_len);	 
+
+			page_offset += copy_len;
+
+		}
+
+		file_pos += plugin_header.data_length;
+		
+	}
+	free_pages((unsigned long) buffer, 0);
+	if (page_offset < count)
+		*eof = 1;
+	return page_offset;
+}
+
+static struct suspend_proc_data proc_params =
+	{ .filename			= "all_settings",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_CUSTOM,
+	  .data = {
+		  .special = {
+	  		 .read_proc	= suspend2_read_compat_proc,
+			 .write_proc	= suspend2_write_compat_proc,
+		  }
+	  }
+	}
+;
+
+/* Create the entry when we boot. */
+__init int suspend2_all_settings_proc_init(void)
+{
+	suspend_register_procfile(&proc_params);
+	return 0;
+}
+late_initcall(suspend2_all_settings_proc_init);

