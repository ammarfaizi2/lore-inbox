Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbUKXO6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbUKXO6T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbUKXOyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:54:22 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:19328 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262730AbUKXOxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 09:53:07 -0500
Subject: Suspend 2 merge: 43/51: Utility functions.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101299832.5805.371.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 00:01:46 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the routines that I think could possibly be useful elsewhere
too.

- A snprintf routine that returns the number of bytes actually put into
the buffer, not the number that would have been put in if the buffer was
big enough.
- Routine for finding a proc dir entry (we use it to find /proc/splash
when)
- Support routines for dynamically allocated pageflags. Save those
precious bits!

diff -ruN 834-utility-old/kernel/power/utility.c 834-utility-new/kernel/power/utility.c
--- 834-utility-old/kernel/power/utility.c	1970-01-01 10:00:00.000000000 +1000
+++ 834-utility-new/kernel/power/utility.c	2004-11-04 16:27:41.000000000 +1100
@@ -0,0 +1,152 @@
+/*
+ * kernel/power/utility.c
+ *
+ * Copyright (C) 2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ * 
+ * This file is released under the GPLv2.
+ *
+ * Routines that only suspend uses at the moment, but which might move
+ * when we merge because they're generic.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/proc_fs.h>
+#include <asm/string.h>
+
+#include "pageflags.h"
+
+extern int suspend_snprintf(char * buffer, int buffer_size, const char *fmt, ...);
+extern struct proc_dir_entry * find_proc_dir_entry(const char *name, struct proc_dir_entry *parent);
+
+/*
+ * suspend_snprintf
+ *
+ * Functionality    : Print a string with parameters to a buffer of a 
+ *                    limited size. Unlike vsnprintf, we return the number
+ *                    of bytes actually put in the buffer, not the number
+ *                    that would have been put in if it was big enough.
+ */
+int suspend_snprintf(char * buffer, int buffer_size, const char *fmt, ...)
+{
+	int result;
+	va_list args;
+
+	if (!buffer_size) {
+		return 0;
+	}
+
+	va_start(args, fmt);
+	result = vsnprintf(buffer, buffer_size, fmt, args);
+	va_end(args);
+
+	if (result > buffer_size) {
+		return buffer_size;
+	}
+
+	return result;
+}
+
+/* 
+ * find_proc_dir_entry.
+ *
+ * Based on remove_proc_entry.
+ * This will go shortly, once user space utilities
+ * are updated to look at /proc/suspend/all_settings.
+ */
+
+struct proc_dir_entry * find_proc_dir_entry(const char *name, struct proc_dir_entry *parent)
+{
+	struct proc_dir_entry **p;
+	int len;
+
+	len = strlen(name);
+	for (p = &parent->subdir; *p; p=&(*p)->next ) {
+		if (proc_match(len, name, *p)) {
+			return *p;
+		}
+	}
+	return NULL;
+}
+
+/* ------------- Dynamically Allocated Page Flags --------------- */
+
+#define BITS_PER_PAGE (PAGE_SIZE * 8)
+#define PAGES_PER_BITMAP ((max_mapnr + BITS_PER_PAGE - 1) / BITS_PER_PAGE)
+#define BITMAP_ORDER (get_bitmask_order((PAGES_PER_BITMAP) - 1))
+
+/* clear_map
+ *
+ * Description:	Clear an array used to store local page flags.
+ * Arguments:	unsigned long *:	The pagemap to be cleared.
+ */
+
+void clear_map(unsigned long * pagemap)
+{
+	int size = (1 << BITMAP_ORDER) * PAGE_SIZE;
+	
+	memset(pagemap, 0, size);
+}
+
+/* allocate_local_pageflags
+ *
+ * Description:	Allocate a bitmap for local page flags.
+ * Arguments:	unsigned long **:	Pointer to the bitmap.
+ * 		int:			Whether to set nosave flags for the
+ * 					newly allocated pages.
+ * Note:	This looks suboptimal, but remember that we might be allocating
+ * 		the Nosave bitmap here.
+ */
+int allocate_local_pageflags(unsigned long ** pagemap, int setnosave)
+{
+	unsigned long * check;
+	int i;
+	if (*pagemap) {
+		printk("Error. Local pageflags map already allocated.\n");
+		clear_map(*pagemap);
+	} else {
+		check = (unsigned long *) __get_free_pages(GFP_ATOMIC,
+				BITMAP_ORDER);
+		if (!check) {
+			printk("Error. Unable to allocate memory for local page flags.");
+			return 1;
+		}
+		clear_map(check);
+		*pagemap = check;
+		if (setnosave) {
+			struct page * firstpage = 
+				virt_to_page((unsigned long) check);
+			for (i = 0; i < (1 << BITMAP_ORDER); i++)
+				SetPageNosave(firstpage + i);
+		}
+	}
+	return 0;
+}
+
+/* freemap
+ *
+ * Description:	Free a local pageflags bitmap.
+ * Arguments:	unsigned long **: Pointer to the bitmap being freed.
+ * Note:	Map being freed might be Nosave.
+ */
+int free_local_pageflags(unsigned long ** pagemap)
+{
+	int i;
+	if (!*pagemap)
+		return 1;
+	else {
+		struct page * firstpage =
+			virt_to_page((unsigned long) *pagemap);
+		for (i = 0; i < (1 << BITMAP_ORDER); i++)
+			ClearPageNosave(firstpage + i);
+		free_pages((unsigned long) *pagemap, BITMAP_ORDER);
+		*pagemap = NULL;
+		return 0;
+	}
+}
+
+EXPORT_SYMBOL(suspend_snprintf);
+EXPORT_SYMBOL(allocate_local_pageflags);
+EXPORT_SYMBOL(free_local_pageflags);
+EXPORT_SYMBOL(find_proc_dir_entry);


