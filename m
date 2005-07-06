Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVGFDlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVGFDlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVGFDjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:39:37 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:10905 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262075AbVGFCTa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:30 -0400
Subject: [PATCH] [40/48] Suspend2 2.1.9.8 for 2.6.12: 616-prepare_image.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:43 +1000
Message-Id: <11206164431308@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 617-proc.patch-old/kernel/power/suspend2_core/proc.c 617-proc.patch-new/kernel/power/suspend2_core/proc.c
--- 617-proc.patch-old/kernel/power/suspend2_core/proc.c	1970-01-01 10:00:00.000000000 +1000
+++ 617-proc.patch-new/kernel/power/suspend2_core/proc.c	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,336 @@
+/*
+ * /kernel/power/proc.c
+ *
+ * Copyright (C) 2002-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * This file contains support for proc entries for tuning Software Suspend.
+ *
+ * We have a generic handler that deals with the most common cases, and
+ * hooks for special handlers to use.
+ *
+ * Versions:
+ * 1: /proc/sys/kernel/suspend the only tuning interface
+ * 2: Initial version of this file
+ * 3: Removed kernel debugger parameter.
+ *    Added checkpage parameter (for checking checksum of a page over time).
+ * 4: Added entry for maximum granularity in splash screen progress bar.
+ *    (Progress bar is slow, but the right setting will vary with disk &
+ *    processor speed and the user's tastes).
+ * 5: Added enable_escape to control ability to cancel aborting by pressing
+ *    ESC key.
+ * 6: Removed checksumming and checkpage parameter. Made all debugging proc
+ *    entries dependant upon debugging being compiled in.
+ *    Meaning of some flags also changed in this version.
+ * 7: Added header_locations entry to simplify getting the resume= parameter for
+ *    swapfiles easy and swapfile entry for automatically doing swapon/off from
+ *    swapfiles as well as partitions.
+ * 8: Added option for marking process pages as pageset 2 (processes_pageset2).
+ * 9: Added option for keep image mode.
+ *    Enumeration patch from Michael Frank applied.
+ * 10: Various corrections to when options are disabled/enabled;
+ *     Added option for specifying expected compression.
+ * 11: Added option for freezer testing. Debug only.
+ * 12: Removed test entries no_async_[read|write], processes_pageset2 and
+ *     NoPageset2.
+ * 13: Make default_console_level available when debugging disabled, but limited
+ *     to 0 or 1.
+ * 14: Rewrite to allow for dynamic registration of proc entries and smooth the
+ *     transition to kobjects in 2.6.
+ * 15: Add setting resume2 parameter without rebooting (still need to run lilo
+ *     though!). Add support for generic string handling and switch resume2 to use
+ *     it.
+ * 16: Switched to cryptoapi, adding entries for selecting encryptor and compressor.
+ */
+
+#define SUSPEND_PROC_C
+
+static int suspend_proc_version = 16;
+static int suspend_proc_initialised = 0;
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <asm/uaccess.h>
+
+#include "proc.h"
+#include "suspend.h"
+
+static struct list_head suspend_proc_entries;
+static struct proc_dir_entry *suspend_dir;
+static struct suspend_proc_data proc_params[];
+
+extern void __suspend2_try_resume(void);
+extern void __suspend2_try_suspend(void);
+
+/* suspend2_read_proc
+ *
+ * Generic handling for reading the contents of bits, integers,
+ * unsigned longs and strings.
+ */
+static int suspend2_read_proc(char * page, char ** start, off_t off, int count,
+		int *eof, void *data)
+{
+	int len = 0;
+	struct suspend_proc_data * proc_data = (struct suspend_proc_data *) data;
+
+	if (suspend_start_anything(0))
+		return -EBUSY;
+	
+	switch (proc_data->type) {
+		case SUSPEND_PROC_DATA_CUSTOM:
+			if (proc_data->data.special.read_proc) {
+				read_proc_t * read_proc = proc_data->data.special.read_proc;
+				len = read_proc(page, start, off, count, eof, data);
+			} else
+				len = 0;
+			break;
+		case SUSPEND_PROC_DATA_BIT:
+			len = sprintf(page, "%d\n", 
+				-test_bit(proc_data->data.bit.bit,
+					proc_data->data.bit.bit_vector));
+			break;
+		case SUSPEND_PROC_DATA_INTEGER:
+			{
+				int * variable = proc_data->data.integer.variable;
+				len = sprintf(page, "%d\n", *variable);
+				break;
+			}
+		case SUSPEND_PROC_DATA_UL:
+			{
+				long * variable = proc_data->data.ul.variable;
+				len = sprintf(page, "%lu\n", *variable);
+				break;
+			}
+		case SUSPEND_PROC_DATA_STRING:
+			{
+				char * variable = proc_data->data.string.variable;
+				len = sprintf(page, "%s\n", variable);
+				break;
+			}
+	}
+	/* Side effect routine? */
+	if (proc_data->read_proc)
+		proc_data->read_proc();
+	if ((proc_data->type != SUSPEND_PROC_DATA_CUSTOM) || (!proc_data->data.special.read_proc))
+		*eof = 1;
+	
+	suspend_finish_anything(0);
+	
+	return len;
+}
+/* suspend2_write_proc
+ *
+ * Generic routine for handling writing to files representing
+ * bits, integers and unsigned longs.
+ */
+
+static int suspend2_write_proc(struct file *file, const char * buffer,
+		unsigned long count, void * data)
+{
+	struct suspend_proc_data * proc_data = (struct suspend_proc_data *) data;
+	char * my_buf = (char *) get_zeroed_page(GFP_ATOMIC);
+	int result = count, assigned_temp_buffer = 0;
+
+	if (!my_buf)
+		return -ENOMEM;
+
+	if (count > PAGE_SIZE)
+		count = PAGE_SIZE;
+
+	if (copy_from_user(my_buf, buffer, count))
+		return -EFAULT;
+	
+	if (suspend_start_anything(proc_data == &proc_params[0]))
+		return -EBUSY;
+
+	my_buf[count] = 0;
+
+	switch (proc_data->type) {
+		case SUSPEND_PROC_DATA_CUSTOM:
+			if (proc_data->data.special.write_proc) {
+				write_proc_t * write_proc = proc_data->data.special.write_proc;
+				result = write_proc(file, buffer, count, data);
+			}
+			break;
+		case SUSPEND_PROC_DATA_BIT:
+			{
+			int value = simple_strtoul(my_buf, NULL, 0);
+			if (value)
+				set_bit(proc_data->data.bit.bit, 
+					(proc_data->data.bit.bit_vector));
+			else
+				clear_bit(proc_data->data.bit.bit,
+					(proc_data->data.bit.bit_vector));
+			}
+			break;
+		case SUSPEND_PROC_DATA_INTEGER:
+			{
+				int * variable = proc_data->data.integer.variable;
+				int minimum = proc_data->data.integer.minimum;
+				int maximum = proc_data->data.integer.maximum;
+				*variable = simple_strtol(my_buf, NULL, 0);
+				if (((*variable) < minimum))
+					*variable = minimum;
+
+				if (((*variable) > maximum))
+					*variable = maximum;
+				break;
+			}
+		case SUSPEND_PROC_DATA_UL:
+			{
+				unsigned long * variable = proc_data->data.ul.variable;
+				unsigned long minimum = proc_data->data.ul.minimum;
+				unsigned long maximum = proc_data->data.ul.maximum;
+				*variable = simple_strtoul(my_buf, NULL, 0);
+				
+				if (minimum && ((*variable) < minimum))
+					*variable = minimum;
+
+				if (maximum && ((*variable) > maximum))
+					*variable = maximum;
+				break;
+			}
+			break;
+		case SUSPEND_PROC_DATA_STRING:
+			{
+				int copy_len = count;
+				char * variable =
+					proc_data->data.string.variable;
+
+				if (proc_data->data.string.max_length &&
+				    (copy_len > proc_data->data.string.max_length))
+					copy_len = proc_data->data.string.max_length;
+
+				if (!variable) {
+					proc_data->data.string.variable =
+						variable = (char *) get_zeroed_page(GFP_ATOMIC);
+					assigned_temp_buffer = 1;
+				}
+				strncpy(variable, my_buf, copy_len);
+				if ((copy_len) &&
+					 (my_buf[copy_len - 1] == '\n'))
+					variable[count - 1] = 0;
+				variable[count] = 0;
+			}
+			break;
+	}
+	free_pages((unsigned long) my_buf, 0);
+	/* Side effect routine? */
+	if (proc_data->write_proc)
+		proc_data->write_proc();
+
+	/* Free temporary buffers */
+	if (assigned_temp_buffer) {
+		free_pages((unsigned long) proc_data->data.string.variable, 0);
+		proc_data->data.string.variable = NULL;
+	}
+
+	suspend_finish_anything(proc_data == &proc_params[0]);
+	
+	return result;
+}
+
+/* Non-plugin proc entries.
+ *
+ * This array contains entries that are automatically registered at
+ * boot. Plugins and the console code register their own entries separately.
+ *
+ * NB: If you move do_suspend, change suspend2_write_proc's test so that
+ * suspend_start_anything still gets a 1 when the user echos > do_suspend!
+ */
+
+static struct suspend_proc_data proc_params[] = {
+	{ .filename			= "do_suspend",
+	  .permissions			= PROC_WRITEONLY,
+	  .type				= SUSPEND_PROC_DATA_CUSTOM,
+	  .write_proc			= __suspend2_try_suspend,
+	},
+
+	{ .filename			= "do_resume",
+	  .permissions			= PROC_WRITEONLY,
+	  .type				= SUSPEND_PROC_DATA_CUSTOM,
+	  .write_proc			= __suspend2_try_resume,
+	},
+
+
+	{ .filename			= "interface_version",
+	  .permissions			= PROC_READONLY,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		  .integer = {
+			  .variable	= &suspend_proc_version,
+		  }
+	  }
+	},
+};
+
+/* suspend_initialise_proc
+ *
+ * Initialise the /proc/software_suspend directory.
+ */
+
+static void suspend_initialise_proc(void)
+{
+	int i;
+	int numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+	
+	if (suspend_proc_initialised)
+		return;
+
+	suspend_dir = proc_mkdir("software_suspend", NULL);
+	
+	BUG_ON(!suspend_dir);
+
+	INIT_LIST_HEAD(&suspend_proc_entries);
+
+	suspend_proc_initialised = 1;
+
+	for (i=0; i< numfiles; i++)
+		suspend_register_procfile(&proc_params[i]);
+}
+
+/* suspend_register_procfile
+ *
+ * Helper for registering a new /proc/software_suspend entry.
+ */
+
+struct proc_dir_entry * suspend_register_procfile(
+		struct suspend_proc_data * suspend_proc_data)
+{
+	struct proc_dir_entry * new_entry;
+	
+	if (!suspend_proc_initialised)
+		suspend_initialise_proc();
+
+	new_entry = create_proc_entry(
+			suspend_proc_data->filename,
+			suspend_proc_data->permissions, 
+			suspend_dir);
+	if (new_entry) {
+		list_add_tail(&suspend_proc_data->proc_data_list, &suspend_proc_entries);
+		new_entry->read_proc = suspend2_read_proc;
+		new_entry->write_proc = suspend2_write_proc;
+		new_entry->data = suspend_proc_data;
+	} else {
+		printk("Error! create_proc_entry returned NULL.\n");
+		INIT_LIST_HEAD(&suspend_proc_data->proc_data_list);
+	}
+	return new_entry;
+}
+
+/* suspend_unregister_procfile
+ *
+ * Helper for removing unwanted /proc/software_suspend entries.
+ *
+ */
+void suspend_unregister_procfile(struct suspend_proc_data * suspend_proc_data)
+{
+	if (list_empty(&suspend_proc_data->proc_data_list))
+		return;
+
+	remove_proc_entry(
+		suspend_proc_data->filename,
+		suspend_dir);
+	list_del(&suspend_proc_data->proc_data_list);
+}
diff -ruNp 617-proc.patch-old/kernel/power/suspend2_core/proc.h 617-proc.patch-new/kernel/power/suspend2_core/proc.h
--- 617-proc.patch-old/kernel/power/suspend2_core/proc.h	1970-01-01 10:00:00.000000000 +1000
+++ 617-proc.patch-new/kernel/power/suspend2_core/proc.h	2005-07-05 23:48:59.000000000 +1000
@@ -0,0 +1,66 @@
+/*
+ * kernel/power/proc.h
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It provides declarations for suspend to use in managing
+ * /proc/software_suspend. When we switch to kobjects,
+ * this will become redundant.
+ *
+ */
+
+#include <linux/proc_fs.h>
+
+struct suspend_proc_data {
+	char * filename;
+	int permissions;
+	int type;
+	union {
+		struct {
+			unsigned long * bit_vector;
+			int bit;
+		} bit;
+		struct {
+			int * variable;
+			int minimum;
+			int maximum;
+		} integer;
+		struct {
+			unsigned long * variable;
+			unsigned long minimum;
+			unsigned long maximum;
+		} ul;
+		struct {
+			char * variable;
+			int max_length;
+		} string;
+		struct {
+			read_proc_t * read_proc;
+			write_proc_t * write_proc;
+			void * data;
+		} special;
+	} data;
+	
+	/* Side effects routines. Used, eg, for reparsing the
+	 * resume2 entry when it changes */
+	void (* read_proc) (void);
+	void (* write_proc) (void); 
+	struct list_head proc_data_list;
+};
+
+#define SUSPEND_PROC_DATA_CUSTOM	0
+#define SUSPEND_PROC_DATA_BIT		1
+#define SUSPEND_PROC_DATA_INTEGER	2
+#define SUSPEND_PROC_DATA_UL		3
+#define SUSPEND_PROC_DATA_STRING	4
+
+#define PROC_WRITEONLY 0200
+#define PROC_READONLY 0400
+#define PROC_RW 0600
+
+struct proc_dir_entry * suspend_register_procfile(
+		struct suspend_proc_data * suspend_proc_data);
+void suspend_unregister_procfile(struct suspend_proc_data * suspend_proc_data);
+

