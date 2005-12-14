Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932632AbVLNQNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbVLNQNW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbVLNQNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:13:22 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:16085 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932629AbVLNQNV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:13:21 -0500
Message-ID: <43A044AA.4040103@de.ibm.com>
Date: Wed, 14 Dec 2005 17:13:30 +0100
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: [patch 1/6] statistics infrastructure - prerequisite: scatter-gather
 ringbuffer
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/6] statistics infrastructure - prerequisite: scatter-gather ringbuffer

This patch implemenents a ringbuffer made up of scattered memory (pages).
The current implementation allows fixed-size entries to be stored in the
ringbuffer. There are routines that simplify writing entries to a buffer
and reading entries from a buffer. Ringbuffer resizing is not supported, yet.

This is actually a separate feature which could be used for purposes
other than statistics.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

  include/linux/sgrb.h |   92 ++++++++++++++
  lib/Kconfig          |    6
  lib/Makefile         |    2
  lib/sgrb.c           |  329 +++++++++++++++++++++++++++++++++++++++++++++++++++
  4 files changed, 429 insertions(+)

diff -Nurp a/include/linux/sgrb.h b/include/linux/sgrb.h
--- a/include/linux/sgrb.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/linux/sgrb.h	2005-12-14 13:08:49.000000000 +0100
@@ -0,0 +1,92 @@
+/*
+ * include/linux/sgrb.h
+ *
+ * a ringbuffer made up of scattered buffers;
+ * holds fixed-size entries smaller than the size of underlying buffers
+ * (ringbuffer resizing has not been implemented)
+ *
+ * (C) Copyright IBM Corp. 2005
+ *
+ * Author(s): Martin Peschke <mp3@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef SGRB_H
+#define SGRB_H
+
+#define SGRB_H_REVISION "$Revision: 1.2 $"
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+
+#define SGRB_BUFFER_SIZE	PAGE_SIZE
+
+struct sgrb_seg {
+	struct list_head list;
+	char *address;
+	int offset;
+	int size;
+};
+
+struct sgrb_ptr {
+	struct sgrb_seg *seg;
+	signed int offset;
+};
+
+struct sgrb {
+	struct list_head seg_lh;
+	struct sgrb_ptr first;
+	struct sgrb_ptr last;
+	int entry_size;
+	int entries;
+};
+
+/**
+ * sgrb_ptr_copy - prepare ringbuffer pointer a by copying b
+ * @a: duplicate
+ * @b: original
+ *
+ * required to prepare a ringbuffer pointer for use with sgrb_consume_nodelete()
+ */
+static inline void sgrb_ptr_copy(struct sgrb_ptr *a, struct sgrb_ptr *b)
+{
+	a->seg = b->seg;
+	a->offset = b->offset;
+}
+
+/**
+ * sgrb_entry - returns address of entry
+ * @a: ringbuffer pointer that determines entry
+ */
+static inline void * sgrb_entry(struct sgrb_ptr *a)
+{
+	return (a->seg->address + a->offset);
+}
+
+extern struct sgrb_seg * sgrb_seg_find(struct list_head *, int, gfp_t);
+extern void sgrb_seg_release_all(struct list_head *);
+
+extern int sgrb_alloc(struct sgrb *, int, int, int, gfp_t);
+extern void sgrb_release(struct sgrb *);
+extern void sgrb_reset(struct sgrb *);
+
+extern void * sgrb_produce_overwrite(struct sgrb *);
+extern void * sgrb_produce_nooverwrite(struct sgrb *);
+extern void * sgrb_consume_delete(struct sgrb *);
+extern void * sgrb_consume_nodelete(struct sgrb *, struct sgrb_ptr *);
+
+#endif /* SGRB_H */
diff -Nurp a/lib/Kconfig b/lib/Kconfig
--- a/lib/Kconfig	2005-10-28 02:02:08.000000000 +0200
+++ b/lib/Kconfig	2005-12-14 13:08:49.000000000 +0100
@@ -86,4 +86,10 @@ config TEXTSEARCH_BM
  config TEXTSEARCH_FSM
  	tristate

+#
+# Scatter-gather ring-buffer is select'ed if needed
+#
+config SGRB
+	boolean
+
  endmenu
diff -Nurp a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	2005-12-14 12:51:41.000000000 +0100
+++ b/lib/Makefile	2005-12-14 13:26:51.000000000 +0100
@@ -46,6 +46,8 @@ obj-$(CONFIG_TEXTSEARCH_FSM) += ts_fsm.o

  obj-$(CONFIG_SWIOTLB) += swiotlb.o

+obj-$(CONFIG_SGRB) += sgrb.o
+
  hostprogs-y	:= gen_crc32table
  clean-files	:= crc32table.h

diff -Nurp a/lib/sgrb.c b/lib/sgrb.c
--- a/lib/sgrb.c	1970-01-01 01:00:00.000000000 +0100
+++ b/lib/sgrb.c	2005-12-14 13:08:49.000000000 +0100
@@ -0,0 +1,329 @@
+/*
+ * lib/sgrb.c
+ *
+ * a ringbuffer made up of scattered buffers;
+ * holds fixed-size entries smaller than the size of underlying buffers
+ * (ringbuffer resizing has not been implemented)
+ *
+ * (C) Copyright IBM Corp. 2005
+ *
+ * Author(s): Martin Peschke <mp3@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#define SGRB_C_REVISION "$Revision: 1.2 $"
+
+#include <linux/module.h>
+#include <linux/sgrb.h>
+
+static struct sgrb_seg * sgrb_seg_alloc(struct list_head *lh, int size,
+					gfp_t gfp)
+{
+	struct sgrb_seg *seg;
+
+	seg = kmalloc(sizeof(struct sgrb_seg), gfp);
+	if (!seg)
+		return NULL;
+	seg->offset = 0;
+	seg->size = size;
+	seg->address = kmalloc(size, gfp);
+	if (!seg->address) {
+		kfree(seg);
+		return NULL;
+	}
+	list_add_tail(&seg->list, lh);
+	return seg;
+}
+
+/**
+ * sgrb_seg_find - find room for another entry
+ * @lh: list_head that holds list of scattered buffers used to store entries
+ * @size: entry size (must be smaller than size of underlying buffers)
+ * @gfp: GFP_* flags used if another buffer needs to be allocated
+ *
+ * tries to find room for an entry in buffer alloacted last, and if required
+ * allocates another buffer
+ */
+struct sgrb_seg * sgrb_seg_find(struct list_head *lh, int size, gfp_t gfp)
+{
+	struct sgrb_seg *seg;
+
+	list_for_each_entry_reverse(seg, lh, list) {
+		if ((seg->size - seg->offset) >= size)
+			return seg;
+		break;
+	}
+	return sgrb_seg_alloc(lh, SGRB_BUFFER_SIZE, gfp);
+}
+EXPORT_SYMBOL_GPL(sgrb_seg_find);
+
+/**
+ * sgrb_seg_release_all - releases scatter-gather buffer
+ * @lh: list_head that holds list of scattered buffer parts
+ */
+void sgrb_seg_release_all(struct list_head *lh)
+{
+	struct sgrb_seg *seg, *tmp;
+
+	list_for_each_entry_safe(seg, tmp, lh, list) {
+		list_del(&seg->list);
+		kfree(seg->address);
+		kfree(seg);
+	}
+}
+EXPORT_SYMBOL_GPL(sgrb_seg_release_all);
+
+static inline int sgrb_ptr_identical(struct sgrb_ptr *a, struct sgrb_ptr *b)
+{
+	if (a->seg == b->seg &&
+	    a->offset == b->offset)
+		return 1;
+	else
+		return 0;
+}
+
+static inline int sgrb_ptr_valid(struct sgrb_ptr *a)
+{
+	return (a->offset >= 0);
+}
+
+static inline void sgrb_ptr_invalidate(struct sgrb *rb, struct sgrb_ptr *a)
+{
+	a->offset = -rb->entry_size;
+}
+
+static inline void sgrb_init(struct sgrb *rb)
+{
+	sgrb_ptr_invalidate(rb, &rb->first);
+	sgrb_ptr_invalidate(rb, &rb->last);
+	rb->entries = 0;
+}
+
+void sgrb_reset(struct sgrb *rb)
+{
+	sgrb_init(rb);
+}
+EXPORT_SYMBOL(sgrb_reset);
+
+/**
+ * sgrb_alloc - prepare a new ringbuffer for use
+ *
+ * @rb: a ringbuffer struct provided by the exploiter
+ * @entry_size: size of entries in ringbuffer
+ * @entry_num: total number of entries in ringbuffer
+ * @seg_size: size of underlying scatter-gather segments used to build up
+ *            ringbuffer
+ * @gfp: GFP_* flags for kmalloc()
+ *
+ * Returns 0 on success.
+ * Returns -ENOMEM if some memory allocation failed.
+ */
+int sgrb_alloc(struct sgrb *rb, int entry_size, int entry_num, int seg_size,
+	       gfp_t gfp)
+{
+	int i;
+	struct sgrb_seg *seg;
+	int entries_per_seg = (seg_size / entry_size);
+	int seg_num = entry_num / entries_per_seg;
+	int residual = (entry_num % entries_per_seg) * entry_size;
+
+	rb->entry_size = entry_size;
+	INIT_LIST_HEAD(&rb->seg_lh);
+	for (i = 0; i < seg_num; i++)
+		if (!sgrb_seg_alloc(&rb->seg_lh, seg_size, gfp)) {
+			sgrb_release(rb);
+			return -ENOMEM;
+		}
+	if (residual)
+		if (!sgrb_seg_alloc(&rb->seg_lh, residual, gfp)) {
+			sgrb_release(rb);
+			return -ENOMEM;
+		}
+	/* get the first list entry */
+	list_for_each_entry(seg, &rb->seg_lh, list)
+		break;
+	rb->first.seg = seg;
+	rb->last.seg = seg;
+	sgrb_init(rb);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sgrb_alloc);
+
+/**
+ * sgrb_release - destroy a ringbuffer
+ *
+ * @rb: the ringbuffer to release
+ *
+ * It is the callers responsibility to make sure that the ringbuffer is
+ * unused.
+ */
+void sgrb_release(struct sgrb *rb)
+{
+	sgrb_seg_release_all(&rb->seg_lh);
+}
+EXPORT_SYMBOL_GPL(sgrb_release);
+
+static void sgrb_next_entry(struct sgrb *rb, struct sgrb_ptr *pos,
+			    struct sgrb_ptr *next)
+{
+	sgrb_ptr_copy(next, pos);
+	next->offset += rb->entry_size;
+	if ((next->offset + rb->entry_size) - 1 > next->seg->size) {
+		if (rb->seg_lh.prev == &next->seg->list) {
+			next->seg = NULL;
+			next->seg = list_prepare_entry(next->seg, &rb->seg_lh, list);
+		}
+		/* get the first list entry */
+		list_for_each_entry_continue(next->seg, &rb->seg_lh, list)
+			break;
+		next->offset = 0;
+	}
+}
+
+/**
+ * sgrb_produce_overwrite - put an entry into the ringbuffer and
+ *     overwrite an older entry if required
+ *
+ * @rb: the ringbuffer being worked with
+ *
+ * It is the callers responsibility to protect the critical section
+ * as described here through locking:
+ * 	spin_lock(lock_for_this_ringbuffer);
+ * 	entry = sgrb_produce_overwrite(&ringbuffer);
+ *	write entry;
+ *	spin_unlock(lock_for_this_ringbuffer);
+ *
+ * Always returns address of the new entry.
+ */
+void * sgrb_produce_overwrite(struct sgrb *rb)
+{
+	struct sgrb_ptr next;
+
+	sgrb_next_entry(rb, &rb->last, &next);
+	if (!sgrb_ptr_valid(&rb->first))
+		sgrb_ptr_copy(&rb->first, &next);
+	else if (sgrb_ptr_identical(&next, &rb->first))
+		sgrb_consume_delete(rb);
+	sgrb_ptr_copy(&rb->last, &next);
+	rb->entries++;
+	return sgrb_entry(&next);
+}
+EXPORT_SYMBOL_GPL(sgrb_produce_overwrite);
+
+/**
+ * sgrb_produce_nooverwrite - put an entry into the ringbuffer
+ *     if there is room without the need to overwrite the oldest
+ *     entry not yet deleted on consumption
+ *
+ * @rb: the ringbuffer being worked with
+ *
+ * It is the callers responsibility to protect the critical section
+ * as described here through locking:
+ * 	spin_lock(lock_for_this_ringbuffer);
+ * 	entry = sgrb_produce_nooverwrite(&ringbuffer);
+ *	if (entry)
+ *		write entry;
+ *	spin_unlock(lock_for_this_ringbuffer);
+ *
+ * Returns address of the new entry, if there is room for it.
+ * Returns NULL otherwise.
+ */
+void * sgrb_produce_nooverwrite(struct sgrb *rb)
+{
+	struct sgrb_ptr next;
+
+	sgrb_next_entry(rb, &rb->last, &next);
+	if (!sgrb_ptr_valid(&rb->first))
+		sgrb_ptr_copy(&rb->first, &next);
+	else if (sgrb_ptr_identical(&next, &rb->first))
+		return NULL;
+	rb->entries++;
+	return sgrb_entry(&next);
+}
+EXPORT_SYMBOL_GPL(sgrb_produce_nooverwrite);
+
+/**
+ * sgrb_consume_delete - get an entry from the ringbuffer and
+ *     delete the entry from the ringbuffer so that it can't
+ *     be consumed twice, and in order to free up its slot for
+ *     another entry
+ *
+ * @rb: the ringbuffer being worked with
+ *
+ * It is the callers responsibility to protect the critical section
+ * as described here through locking:
+ * 	spin_lock(lock_for_this_ringbuffer);
+ * 	entry = sgrb_consume_delete(&ringbuffer);
+ *	read entry;
+ *	spin_unlock(lock_for_this_ringbuffer);
+ *
+ * Returns address of the entry read, if there is an entry available.
+ * Returns NULL otherwise.
+ */
+void * sgrb_consume_delete(struct sgrb *rb)
+{
+	struct sgrb_ptr prev;
+
+	if (!sgrb_ptr_valid(&rb->first))
+		return NULL;
+	sgrb_ptr_copy(&prev, &rb->first);
+	if (sgrb_ptr_identical(&rb->last, &rb->first))
+		sgrb_init(rb);
+	else
+		sgrb_next_entry(rb, &rb->first, &rb->first);
+	rb->entries--;
+	return sgrb_entry(&prev);
+}
+EXPORT_SYMBOL_GPL(sgrb_consume_delete);
+
+/**
+ * sgrb_consume_nodelete - get an entry from the ringbuffer
+ *     while keeping this entry in the ringbuffer so that it can
+ *     be consumed again
+ *
+ * @rb: the ringbuffer being worked with
+ * @pos: the ringbuffer pointer that determines which entry to consume
+ *
+ * Use sgrb_ptr_copy() to prepare pos prior to iterating over the ringbuffer
+ * (copy rb->first, the producers tail and the consumers head, to pos).
+ * This routine is particularly useful to get a snapshot of the complete
+ * content of the ringbuffer without changing it.
+ *
+ * It is the callers responsibility to protect the critical section
+ * as described here through locking:
+ * 	spin_lock(lock_for_this_ringbuffer);
+ * 	sgrb_ptr_copy(&i, &ringbuffer.first);
+ * 	while (entry = sgrb_consume_nodelete(&ringbuffer, &i))
+ *		read entry;
+ *	spin_unlock(lock_for_this_ringbuffer);
+ *
+ * Returns address of the entry read, if there is an entry available.
+ * Returns NULL otherwise.
+ */
+void * sgrb_consume_nodelete(struct sgrb *rb, struct sgrb_ptr *pos)
+{
+	struct sgrb_ptr prev;
+
+	if (!sgrb_ptr_valid(pos))
+		return NULL;
+	sgrb_ptr_copy(&prev, pos);
+	if (sgrb_ptr_identical(&rb->last, pos))
+		sgrb_ptr_invalidate(rb, pos);
+	else
+		sgrb_next_entry(rb, pos, pos);
+	return sgrb_entry(&prev);
+}
+EXPORT_SYMBOL_GPL(sgrb_consume_nodelete);
