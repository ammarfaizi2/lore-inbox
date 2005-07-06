Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVGFDqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVGFDqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVGFDnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:43:46 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:11673 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262081AbVGFCTd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:33 -0400
Subject: [PATCH] [33/48] Suspend2 2.1.9.8 for 2.6.12: 610-encryption.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:43 +1000
Message-Id: <11206164431243@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 610-extent.patch-old/kernel/power/suspend2_core/extent.c 610-extent.patch-new/kernel/power/suspend2_core/extent.c
--- 610-extent.patch-old/kernel/power/suspend2_core/extent.c	1970-01-01 10:00:00.000000000 +1000
+++ 610-extent.patch-new/kernel/power/suspend2_core/extent.c	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,206 @@
+/*
+ * kernel/power/suspend2_core/extent.c
+ * 
+ * Suspend2 routines for manipulating extents.
+ *
+ * (C) 2003-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * Distributed under GPLv2.
+ * 
+ * These functions encapsulate the manipulation of extents.
+ * They work like this:
+ *
+ * A lot of the data that suspend saves involves continguous extents of memory
+ * or storage. Let's say that we're storing data on disk in blocks 1-32768 and
+ * 49152-49848 of a swap partition. Rather than recording 1, 2, 3... in arrays
+ * pointing to the locations, we simply use:
+ *
+ * struct extent {
+ * 	unsigned long min;
+ * 	unsigned long max;
+ * 	struct extent * next;
+ * }
+ *
+ * We can then store 1-32768 and 49152-49848 in 2 struct extents, using 24 bytes
+ * instead of something like 133,860. This is of course inefficient where a extent
+ * covers only one or two values, but the benefits gained by the much larger
+ * extents more than outweigh these instances.
+ *
+ * When _all_ the metadata was stored in extents, we used to have fancier code that
+ * stored them in pages and was optimised for our usage. Nowadays they are only
+ * used for storage information. We therefore kmalloc them as required, and
+ * provide a far simpler routine to serialise them in the image header.
+ */
+
+#include <linux/module.h>
+#include <linux/suspend.h>
+#include "plugins.h"
+#include "extent.h"
+#include "ui.h"
+
+int extents_allocated = 0, max_extents_used = 0;
+
+/* get_extent
+ *
+ * Returns a free extent.
+ * May fail, returning NULL instead.
+ */
+
+static struct extent * get_extent(void)
+{
+	struct extent * result;
+	
+	if (!(result = kmalloc(sizeof(struct extent), GFP_ATOMIC)))
+		return NULL;
+
+	extents_allocated++;
+	if (extents_allocated > max_extents_used)
+		max_extents_used++;
+	result->minimum = result->maximum = 0;
+	result->next = NULL;
+	return result;
+}
+
+/*
+ * put_extent.
+ *
+ * Frees an extent.
+ *
+ * Assumes unlinking is done by the caller.
+ */
+void put_extent(struct extent * extent)
+{
+	if (!extent) {
+		printk("Error! put_extent called with NULL extent.\n");
+		return;
+	}
+	kfree(extent);
+	extents_allocated--;
+}
+
+/*
+ * put_extent_chain.
+ *
+ * Frees a whole chain of extents.
+ */
+void put_extent_chain(struct extentchain * chain)
+{
+	struct extent * this;
+
+	this = chain->first;
+
+	if (!this)
+		return;
+
+	while(this) {
+		struct extent * next = this->next;
+		kfree(this);
+		chain->frees++;
+		extents_allocated --;
+		this = next;
+	}
+	
+	BUG_ON(chain->frees != chain->allocs);
+	chain->first = chain->last = NULL;
+	chain->size = chain->allocs = chain->frees = 0;
+}
+
+/* 
+ * append_extent_to_extent_chain
+ *
+ * Used where we know a extent is to be added to the end of the list
+ * and does not need merging with the current last extent.
+ */
+
+int append_extent_to_extent_chain(struct extentchain * chain, 
+		unsigned long minimum, unsigned long maximum)
+{
+	struct extent * newextent = NULL;
+
+	newextent = get_extent();
+	if (!newextent) {
+		printk("Error unable to append a new extent to the chain.\n");
+		return 2;
+	}
+
+	chain->allocs++;
+	chain->size+= (maximum - minimum + 1);
+	newextent->minimum = minimum;
+	newextent->maximum = maximum;
+	newextent->next = NULL;
+
+	if (chain->last) {
+		chain->last->next = newextent;
+		chain->last = newextent;
+	} else 
+		chain->last = chain->first = newextent;
+
+	/* No need to reset optimisation info since added to end */
+	return 0;
+}
+
+/* 
+ * serialise_extent_chain
+ *
+ * Write a chain in the image.
+ */
+int serialise_extent_chain(struct extentchain * chain)
+{
+	struct extent * this;
+	int ret, i = 1;
+	
+	if ((ret = active_writer->ops.writer.write_header_chunk((char *) chain,
+		sizeof(struct extentchain) - 2 * sizeof(struct extent *)))) {
+		printk("Write header chunk returned %d - aborting serialising chain.\n",
+				ret);
+		return ret;
+	}
+
+	this = chain->first;
+	while (this) {
+		if ((ret = active_writer->ops.writer.write_header_chunk((char *) this,
+				2 * sizeof(unsigned long)))) {
+			printk("Failed to write extent.\n");
+			return ret;
+		}
+		this = this->next;
+		i++;
+	}
+	return ret;
+}
+
+/* 
+ * load_extent_chain
+ *
+ * Read back a chain saved in the image.
+ */
+int load_extent_chain(struct extentchain * chain)
+{
+	struct extent * this, * last = NULL;
+	int i, ret;
+
+	if (!(ret = active_writer->ops.writer.read_header_chunk((char *) chain,
+		sizeof(struct extentchain) - 2 * sizeof(struct extent *)))) {
+		printk("Read header chunk returned %d - aborting serialising chain.\n",
+				ret);
+		return ret;
+	}
+
+	for (i = 0; i < (chain->allocs - chain->frees); i++) {
+		this = kmalloc(sizeof(struct extent), GFP_ATOMIC);
+		BUG_ON(!this); /* Shouldn't run out of memory trying this! */
+		this->next = NULL;
+		if (!(ret = active_writer->ops.writer.read_header_chunk((char *) this,
+				2 * sizeof(unsigned long)))) {
+			printk("Failed to read extent.\n");
+			return ret;
+		}
+		if (last)
+			last->next = this;
+		else
+			chain->first = this;
+		last = this;
+	}
+	chain->last = last;
+	return ret;
+}
diff -ruNp 610-extent.patch-old/kernel/power/suspend2_core/extent.h 610-extent.patch-new/kernel/power/suspend2_core/extent.h
--- 610-extent.patch-old/kernel/power/suspend2_core/extent.h	1970-01-01 10:00:00.000000000 +1000
+++ 610-extent.patch-new/kernel/power/suspend2_core/extent.h	2005-07-05 23:48:59.000000000 +1000
@@ -0,0 +1,84 @@
+/*
+ * kernel/power/extent.h
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains declarations related to extents. Extents are
+ * suspend's method of storing some of the metadata for the image.
+ * See extent.c for more info.
+ *
+ */
+
+#ifndef EXTENT_H
+#define EXTENT_H
+struct extentchain {
+	int size; /* size of the extent ie sum (max-min+1) */
+	int allocs;
+	int frees;
+	int debug;
+	int timesusedoptimisation;
+	char * name;
+	struct extent * first;
+	struct extent * last;
+};
+
+/*
+ * We rely on extents not fitting evenly into a page.
+ * The last four bytes are used to store the number
+ * of the page, to make saving & reloading pages simpler.
+ */
+struct extent {
+	unsigned long minimum;
+	unsigned long maximum;
+	struct extent * next;
+};
+
+
+#define extent_for_each(extentchain, extentpointer, value) \
+if ((extentchain)->first) \
+	for ((extentpointer) = (extentchain)->first, (value) = \
+			(extentpointer)->minimum; \
+	     ((extentpointer) && ((extentpointer)->next || (value) <= \
+				 (extentpointer)->maximum)); \
+	     (((value) == (extentpointer)->maximum) ? \
+		((extentpointer) = (extentpointer)->next, (value) = \
+		 ((extentpointer) ? (extentpointer)->minimum : 0)) : \
+			(value)++))
+
+/*
+ * When using compression and expected_compression > 0,
+ * we allocate fewer swap entries, so GET_EXTENT_NEXT can
+ * validly run out of data to return.
+ */
+#define GET_EXTENT_NEXT(currentextent, currentval) \
+{ \
+	if (currentextent) { \
+		if ((currentval) == (currentextent)->maximum) { \
+			if ((currentextent)->next) { \
+				(currentextent) = (currentextent)->next; \
+				(currentval) = (currentextent)->minimum; \
+			} else { \
+				(currentextent) = NULL; \
+				(currentval) = 0; \
+			} \
+		} else \
+			currentval++; \
+	} \
+}
+
+extern int max_extents_used, extents_allocated;
+void put_extent(struct extent * extent);
+void put_extent_chain(struct extentchain * chain);
+int append_extent_to_extent_chain(struct extentchain * chain, 
+		unsigned long minimum, unsigned long maximum);
+int serialise_extent_chain(struct extentchain * chain);
+int load_extent_chain(struct extentchain * chain);
+
+/* swap_entry_to_extent_val & extent_val_to_swap_entry: 
+ * We are putting offset in the low bits so consecutive swap entries
+ * make consecutive extent values */
+#define swap_entry_to_extent_val(swp_entry) (swp_entry.val)
+#define extent_val_to_swap_entry(val) (swp_entry_t) { (val) }
+#endif

