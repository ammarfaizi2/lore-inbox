Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWFZQxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWFZQxt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWFZQxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:53:47 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:48262 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750909AbWFZQxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:53:35 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 11/11] [Suspend2] Header file for Suspend2 modules.
Date: Tue, 27 Jun 2006 02:53:39 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165337.10957.84107.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
References: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Header file, defining structures, enums, lists and routines related to
Suspend2 modules.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.h |  160 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 160 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.h b/kernel/power/modules.h
new file mode 100644
index 0000000..f04edb6
--- /dev/null
+++ b/kernel/power/modules.h
@@ -0,0 +1,160 @@
+/*
+ * kernel/power/modules.h
+ *
+ * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains declarations for modules. Modules are additions to
+ * suspend2 that provide facilities such as image compression or
+ * encryption, backends for storage of the image and user interfaces.
+ *
+ */
+
+#ifndef SUSPEND_MODULES_H
+#define SUSPEND_MODULES_H
+
+/* This is the maximum size we store in the image header for a module name */
+#define SUSPEND_MAX_MODULE_NAME_LENGTH 30
+
+/* Per-module metadata */
+struct suspend_module_header {
+	char name[SUSPEND_MAX_MODULE_NAME_LENGTH];
+	int disabled;
+	int type;
+	int index;
+	int data_length;
+	unsigned long signature;
+};
+
+extern int suspend_num_modules, suspend_num_writers;
+
+enum {
+	FILTER_MODULE,
+	WRITER_MODULE,
+	MISC_MODULE /* Block writer, eg. */
+};
+
+enum {
+	SUSPEND_ASYNC,
+	SUSPEND_SYNC
+};
+
+struct suspend_module_ops {
+	/* Functions common to all modules */
+	int type;
+	char *name;
+	struct module *module;
+	int disabled;
+	struct list_head module_list;
+
+	/* List of filters or writers */
+	struct list_head list, type_list;
+
+	/*
+	 * Requirements for memory and storage in
+	 * the image header..
+	 */
+	unsigned long (*memory_needed) (void);
+	unsigned long (*storage_needed) (void);
+
+	unsigned long header_requested, header_used;
+	
+	/* 
+	 * Debug info
+	 */
+	int (*print_debug_info) (char *buffer, int size);
+	int (*save_config_info) (char *buffer);
+	void (*load_config_info) (char *buffer, int len);
+
+	/* 
+	 * Initialise & cleanup - general routines called
+	 * at the start and end of a cycle.
+	 */
+	int (*initialise) (int starting_cycle);
+	void (*cleanup) (int finishing_cycle);
+
+	/* 
+	 * Calls for allocating storage (writers only).
+	 *
+	 * Header space is allocated separately. Note that allocation
+	 * of space for the header might result in allocated space 
+	 * being stolen from the main pool if there is no unallocated
+	 * space. We have to be able to allocate enough space for
+	 * the header. We can eat memory to ensure there is enough
+	 * for the main pool.
+	 */
+
+	int (*storage_available) (void);
+	int (*allocate_header_space) (int space_requested);
+	int (*allocate_storage) (int space_requested);
+	int (*storage_allocated) (void);
+	int (*release_storage) (void);
+	
+	/*
+	 * Routines used in image I/O.
+	 */
+	int (*rw_init) (int rw, int stream_number);
+	int (*rw_cleanup) (int rw);
+	int (*write_chunk) (struct page *buffer_page);
+	int (*read_chunk) (struct page *buffer_page, int sync);
+
+	/* Reset module if image exists but reading aborted */
+	void (*noresume_reset) (void);
+
+	/* Read and write the metadata */	
+	int (*write_header_init) (void);
+	int (*write_header_cleanup) (void);
+
+	int (*read_header_init) (void);
+	int (*read_header_cleanup) (void);
+
+	int (*rw_header_chunk) (int rw, struct suspend_module_ops *owner,
+			char *buffer_start, int buffer_size);
+	
+	/* Attempt to parse an image location */
+	int (*parse_sig_location) (char *buffer, int only_writer);
+
+	/* Determine whether image exists that we can restore */
+	int (*image_exists) (void);
+	
+	/* Mark the image as having tried to resume */
+	void (*mark_resume_attempted) (void);
+
+	/* Destroy image if one exists */
+	int (*invalidate_image) (void);
+	
+};
+
+extern struct suspend_module_ops *suspend_active_writer;
+extern struct list_head suspend_filters, suspend_writers, suspend_modules;
+
+extern void suspend_prepare_console_modules(void);
+extern void suspend_cleanup_console_modules(void);
+
+extern struct suspend_module_ops *suspend_find_module_given_name(char *name),
+	*suspend_get_next_filter(struct suspend_module_ops *);
+
+extern int suspend_register_module(struct suspend_module_ops *module);
+extern void suspend_move_module_tail(struct suspend_module_ops *module);
+
+extern unsigned long suspend_header_storage_for_modules(void);
+extern unsigned long suspend_memory_for_modules(void);
+
+extern int suspend_print_module_debug_info(char *buffer, int buffer_size);
+extern int suspend_register_module(struct suspend_module_ops *module);
+extern void suspend_unregister_module(struct suspend_module_ops *module);
+
+extern int suspend_initialise_modules(int starting_cycle);
+extern void suspend_cleanup_modules(int finishing_cycle);
+
+int suspend_get_modules(void);
+void suspend_put_modules(void);
+
+static inline void suspend_initialise_module_lists(void) {
+	INIT_LIST_HEAD(&suspend_filters);
+	INIT_LIST_HEAD(&suspend_writers);
+	INIT_LIST_HEAD(&suspend_modules);
+}
+
+#endif

--
Nigel Cunningham		nigel at suspend2 dot net
