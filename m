Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWEQS4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWEQS4f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWEQS4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:56:35 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:12891 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750957AbWEQS4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:56:33 -0400
Subject: [RFC] [Patch 5/6] statistics infrastructure
From: Martin Peschke <mp3@de.ibm.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Chase Venters <chase.venters@clientec.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Keith Owens <kaos@ocs.com.au>,
       Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>,
       "hch@infradead.org" <hch@infradead.org>,
       "arjan@infradead.org" <arjan@infradead.org>, "ak@suse.de" <ak@suse.de>
Content-Type: text/plain
Date: Wed, 17 May 2006 20:56:20 +0200
Message-Id: <1147892180.3076.23.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds statistics infrastructure as common code.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 MAINTAINERS                |    7
 arch/s390/Kconfig          |    6
 arch/s390/oprofile/Kconfig |    5
 include/linux/statistic.h  |  296 +++++++++
 lib/Kconfig.statistic      |   11
 lib/Makefile               |    2
 lib/statistic.c            | 1454 +++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 1776 insertions(+), 5 deletions(-)

diff -Nurp a/include/linux/statistic.h b/include/linux/statistic.h
--- a/include/linux/statistic.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/linux/statistic.h	2006-05-17 19:11:32.000000000 +0200
@@ -0,0 +1,296 @@
+/*
+ * include/linux/statistic.h
+ *
+ * Statistics facility
+ *
+ * (C) Copyright IBM Corp. 2005, 2006
+ *
+ * Author(s): Martin Peschke <mpeschke@de.ibm.com>
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
+#ifndef STATISTIC_H
+#define STATISTIC_H
+
+#include <linux/fs.h>
+#include <linux/types.h>
+#include <linux/percpu.h>
+
+#define STATISTIC_ROOT_DIR	"statistics"
+
+#define STATISTIC_FILENAME_DATA	"data"
+#define STATISTIC_FILENAME_DEF	"definition"
+
+#define STATISTIC_NEED_BARRIER	1
+
+#define STATISTIC_FLAGS_NOINCR	0x01
+
+struct statistic;
+
+enum statistic_state {
+	STATISTIC_STATE_INVALID,
+	STATISTIC_STATE_UNCONFIGURED,
+	STATISTIC_STATE_RELEASED,
+	STATISTIC_STATE_OFF,
+	STATISTIC_STATE_ON
+};
+
+enum statistic_type {
+	STATISTIC_TYPE_COUNTER_INC,
+	STATISTIC_TYPE_COUNTER_PROD,
+	STATISTIC_TYPE_UTIL,
+	STATISTIC_TYPE_HISTOGRAM_LIN,
+	STATISTIC_TYPE_HISTOGRAM_LOG2,
+	STATISTIC_TYPE_SPARSE,
+	STATISTIC_TYPE_NONE
+};
+
+struct statistic_info {
+	char *name;
+	char *x_unit;
+	char *y_unit;
+	int  flags;
+	char *defaults;
+};
+
+struct statistic_interface {
+	/* private */
+	struct list_head	 list;
+	struct dentry		*debugfs_dir;
+	struct dentry		*data_file;
+	struct dentry		*def_file;
+	/* these have to be set by exploiter prior calling statistic_create() */
+	struct statistic	*stat;		/* mandatory */
+	struct statistic_info	*info;		/* mandatory */
+	int			 number;	/* mandatory */
+	int			(*pull)(void*);	/* optional */
+	void			*pull_private;	/* optional */
+};
+
+struct sgrb_seg {
+	struct list_head list;
+	char *address;
+	int offset;
+	int size;
+};
+
+struct statistic_file_private {
+	struct list_head read_seg_lh;
+	struct list_head write_seg_lh;
+	size_t write_seg_total_size;
+};
+
+struct statistic_merge_private {
+	struct statistic *stat;
+	spinlock_t lock;
+	void *dst;
+};
+
+struct statistic_discipline {
+	int (*parse)(struct statistic *, struct statistic_info *, int, char *);
+	void* (*alloc)(struct statistic *, size_t, gfp_t, int);
+	void (*free)(struct statistic *, void *);
+	void (*reset)(struct statistic *, void *);
+	void (*merge)(struct statistic *, void *, void*);
+	int (*fdata)(struct statistic *, const char *,
+		     struct statistic_file_private *, void *);
+	int (*fdef)(struct statistic *, char *);
+	void (*add)(struct statistic *, int, s64, u64);
+	void (*set)(struct statistic *, s64, u64);
+	char *name;
+	size_t size;
+};
+
+struct statistic_entry_util {
+	u32 res;
+	u32 num;	/* FIXME: better 64 bit; do_div can't deal with it) */
+	s64 acc;
+	s64 min;
+	s64 max;
+};
+
+struct statistic_entry_sparse {
+	struct list_head list;
+	s64 value;
+	u64 hits;
+};
+
+struct statistic_sparse_list {
+	struct list_head entry_lh;
+	u32 entries;
+	u32 entries_max;
+	u64 hits_missed;
+};
+
+struct statistic {
+	enum statistic_state	 state;
+	enum statistic_type	 type;
+	struct percpu_data	*pdata;
+	void			(*add)(struct statistic *, int, s64, u64);
+	u64			 started;
+	u64			 stopped;
+	u64			 age;
+	union {
+		struct {
+			s64 range_min;
+			u32 last_index;
+			u32 base_interval;
+		} histogram;
+		struct {
+			u32 entries_max;
+		} sparse;
+	} u;
+};
+
+#ifdef CONFIG_STATISTICS
+
+extern int statistic_create(struct statistic_interface *, const char *);
+extern int statistic_remove(struct statistic_interface *);
+
+/**
+ * statistic_add - update statistic with (X, Y) data pair
+ * @stat: struct statistic array
+ * @i: index of statistic to be updated
+ * @value: X
+ * @incr: Y
+ *
+ * The actual processing of the (X, Y) data pair is determined by the current
+ * the definition applied to the statistic. See Documentation/statistics.txt.
+ *
+ * This variant takes care of protecting per-cpu data. It is preferred whenever
+ * exploiters don't update several statistics of the same entity in one go.
+ */
+static inline void statistic_add(struct statistic *stat, int i,
+				 s64 value, u64 incr)
+{
+	unsigned long flags;
+	if (stat[i].state == STATISTIC_STATE_ON) {
+		local_irq_save(flags);
+		stat[i].add(&stat[i], smp_processor_id(), value, incr);
+		local_irq_restore(flags);
+	}
+}
+
+/**
+ * statistic_add_nolock - update statistic with (X, Y) data pair
+ * @stat: struct statistic array
+ * @i: index of statistic to be updated
+ * @value: X
+ * @incr: Y
+ *
+ * The actual processing of the (X, Y) data pair is determined by the current
+ * the definition applied to the statistic. See Documentation/statistics.txt.
+ *
+ * This variant leaves protecting per-cpu data to exploiters. It is preferred
+ * whenever exploiters update several statistics of the same entity in one go.
+ */
+static inline void statistic_add_nolock(struct statistic *stat, int i,
+					s64 value, u64 incr)
+{
+	if (stat[i].state == STATISTIC_STATE_ON)
+		stat[i].add(&stat[i], smp_processor_id(), value, incr);
+}
+
+/**
+ * statistic_inc - update statistic with (X, 1) data pair
+ * @stat: struct statistic array
+ * @i: index of statistic to be updated
+ * @value: X
+ *
+ * The actual processing of the (X, Y) data pair is determined by the current
+ * the definition applied to the statistic. See Documentation/statistics.txt.
+ *
+ * This variant takes care of protecting per-cpu data. It is preferred whenever
+ * exploiters don't update several statistics of the same entity in one go.
+ */
+static inline void statistic_inc(struct statistic *stat, int i, s64 value)
+{
+	unsigned long flags;
+	if (stat[i].state == STATISTIC_STATE_ON) {
+		local_irq_save(flags);
+		stat[i].add(&stat[i], smp_processor_id(), value, 1);
+		local_irq_restore(flags);
+	}
+}
+
+/**
+ * statistic_inc_nolock - update statistic with (X, 1) data pair
+ * @stat: struct statistic array
+ * @i: index of statistic to be updated
+ * @value: X
+ *
+ * The actual processing of the (X, Y) data pair is determined by the current
+ * the definition applied to the statistic. See Documentation/statistics.txt.
+ *
+ * This variant leaves protecting per-cpu data to exploiters. It is preferred
+ * whenever exploiters update several statistics of the same entity in one go.
+ */
+static inline void statistic_inc_nolock(struct statistic *stat, int i,
+					s64 value)
+{
+	if (stat[i].state == STATISTIC_STATE_ON)
+		stat[i].add(&stat[i], smp_processor_id(), value, 1);
+}
+
+extern void statistic_set(struct statistic *, int, s64, u64);
+/* There is no other statistic_set() flavour needed. statistic_set() may only
+   be called when we pull statistic updates from exploiters. The statistics
+   infrastructure guarantees serialisation for that. Exploiters must not
+   intermix statistic_set() and statistic_add/inc() anyway. That is why,
+   concurrent updates won't happen and there is no additional protection
+   required for statistics fed through statistic_set().*/
+
+#else /* CONFIG_STATISTICS */
+
+static inline int statistic_create(struct statistic_interface *interface,
+				   const char *name)
+{
+	return 0;
+}
+
+static inline int statistic_remove(
+				struct statistic_interface *interface_ptr)
+{
+	return 0;
+}
+
+static inline void statistic_add(struct statistic *stat, int i,
+				 s64 value, u64 incr)
+{
+}
+
+static inline void statistic_add_nolock(struct statistic *stat, int i,
+					s64 value, u64 incr)
+{
+}
+
+static inline void statistic_inc(struct statistic *stat, int i, s64 value)
+{
+}
+
+static inline void statistic_inc_nolock(struct statistic *stat, int i,
+					s64 value)
+{
+}
+
+static inline void statistic_set(struct statistic *stat, int i,
+				 s64 value, u64 total)
+{
+}
+
+#endif /* CONFIG_STATISTICS */
+
+#endif /* STATISTIC_H */
diff -Nurp a/lib/statistic.c b/lib/statistic.c
--- a/lib/statistic.c	1970-01-01 01:00:00.000000000 +0100
+++ b/lib/statistic.c	2006-05-17 19:11:32.000000000 +0200
@@ -0,0 +1,1454 @@
+/*
+ *  lib/statistic.c
+ *    statistics facility
+ *
+ *    Copyright (C) 2005, 2006
+ *		IBM Deutschland Entwicklung GmbH,
+ *		IBM Corporation
+ *
+ *    Author(s): Martin Peschke (mpeschke@de.ibm.com),
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
+ *
+ *    another bunch of ideas being pondered:
+ *	- define a set of agreed names or a naming scheme for
+ *	  consistency and comparability across exploiters;
+ *	  this entails an agreement about granularities
+ *	  as well (e.g. separate statistic for read/write/no-data commands);
+ *	  a common set of unit strings would be nice then, too, of course
+ *	  (e.g. "seconds", "milliseconds", "microseconds", ...)
+ *	- perf. opt. of array: table lookup of values, binary search for values
+ *	- another statistic disclipline based on some sort of tree, but
+ *	  similar in semantics to list discipline (for high-perf. histograms of
+ *	  discrete values)
+ *	- allow for more than a single "view" on data at the same time by
+ *	  providing the capability to attach several (a list of) "definitions"
+ *	  to a struct statistic
+ *	  (e.g. show histogram of requests sizes and history of megabytes/sec.
+ *	  at the same time)
+ *	- multi-dimensional statistic (combination of two or more
+ *	  characteristics/discriminators); worth the effort??
+ *	  (e.g. a matrix of occurences for latencies of requests of
+ *	  particular sizes)
+ *
+ *	FIXME:
+ *	- statistics file access when statistics are being removed
+ */
+
+#include <linux/fs.h>
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/parser.h>
+#include <linux/time.h>
+#include <linux/sched.h>
+#include <linux/cpu.h>
+#include <linux/percpu.h>
+#include <linux/mutex.h>
+#include <linux/statistic.h>
+
+#include <asm/bug.h>
+#include <asm/uaccess.h>
+
+static struct statistic_discipline statistic_discs[];
+
+static inline int statistic_initialise(struct statistic *stat)
+{
+	stat->type = STATISTIC_TYPE_NONE;
+	stat->state = STATISTIC_STATE_UNCONFIGURED;
+	return 0;
+}
+
+static inline int statistic_uninitialise(struct statistic *stat)
+{
+	stat->state = STATISTIC_STATE_INVALID;
+	return 0;
+}
+
+static inline int statistic_define(struct statistic *stat)
+{
+	if (stat->type == STATISTIC_TYPE_NONE)
+		return -EINVAL;
+	stat->state = STATISTIC_STATE_RELEASED;
+	return 0;
+}
+
+static inline void statistic_reset_ptr(struct statistic *stat, void *ptr)
+{
+	struct statistic_discipline *disc = &statistic_discs[stat->type];
+	if (ptr)
+		disc->reset(stat, ptr);
+}
+
+static inline void statistic_move_ptr(struct statistic *stat, void *src)
+{
+	struct statistic_discipline *disc = &statistic_discs[stat->type];
+	unsigned long flags;
+	local_irq_save(flags);
+	disc->merge(stat, stat->pdata->ptrs[smp_processor_id()], src);
+	local_irq_restore(flags);
+}
+
+static inline void statistic_free_ptr(struct statistic *stat, void *ptr)
+{
+	struct statistic_discipline *disc = &statistic_discs[stat->type];
+	if (ptr) {
+		if (unlikely(disc->free))
+			disc->free(stat, ptr);
+		kfree(ptr);
+	}
+}
+
+static int statistic_free(struct statistic *stat, struct statistic_info *info)
+{
+	int cpu;
+	stat->state = STATISTIC_STATE_RELEASED;
+	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR)) {
+		statistic_free_ptr(stat, stat->pdata);
+		stat->pdata = NULL;
+		return 0;
+	}
+	for_each_cpu(cpu) {
+		statistic_free_ptr(stat, stat->pdata->ptrs[cpu]);
+		stat->pdata->ptrs[cpu] = NULL;
+	}
+	kfree(stat->pdata);
+	stat->pdata = NULL;
+	return 0;
+}
+
+static void * statistic_alloc_generic(struct statistic *stat, size_t size,
+				      gfp_t flags, int node)
+{
+	return kmalloc_node(size, flags, node);
+}
+
+static void * statistic_alloc_ptr(struct statistic *stat, gfp_t flags, int node)
+{
+	struct statistic_discipline *disc = &statistic_discs[stat->type];
+	void *buf = disc->alloc(stat, disc->size, flags, node);
+	if (likely(buf))
+		statistic_reset_ptr(stat, buf);
+	return buf;
+}
+
+static int statistic_alloc(struct statistic *stat,
+			   struct statistic_info *info)
+{
+	int cpu;
+	stat->age = sched_clock();
+	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR)) {
+		stat->pdata = statistic_alloc_ptr(stat, GFP_KERNEL, -1);
+		if (unlikely(!stat->pdata))
+			return -ENOMEM;
+		stat->state = STATISTIC_STATE_OFF;
+		return 0;
+	}
+	stat->pdata = kzalloc(sizeof(struct percpu_data), GFP_KERNEL);
+	if (unlikely(!stat->pdata))
+		return -ENOMEM;
+	for_each_online_cpu(cpu) {
+		stat->pdata->ptrs[cpu] = statistic_alloc_ptr(stat, GFP_KERNEL,
+							     cpu_to_node(cpu));
+		if (unlikely(!stat->pdata->ptrs[cpu])) {
+			statistic_free(stat, info);
+			return -ENOMEM;
+		}
+	}
+	stat->state = STATISTIC_STATE_OFF;
+	return 0;
+}
+
+static inline int statistic_start(struct statistic *stat)
+{
+	stat->started = sched_clock();
+	stat->state = STATISTIC_STATE_ON;
+	return 0;
+}
+
+static void _statistic_barrier(void *unused)
+{
+}
+
+static inline int statistic_stop(struct statistic *stat)
+{
+	stat->stopped = sched_clock();
+	stat->state = STATISTIC_STATE_OFF;
+	/* ensures that all CPUs have ceased updating statistics */
+	smp_mb();
+	on_each_cpu(_statistic_barrier, NULL, 0, 1);
+	return 0;
+}
+
+static int statistic_transition(struct statistic *stat,
+				struct statistic_info *info,
+				enum statistic_state requested_state)
+{
+	int z = (requested_state < stat->state ? 1 : 0);
+	int retval = -EINVAL;
+
+	while (stat->state != requested_state) {
+		switch (stat->state) {
+		case STATISTIC_STATE_INVALID :
+			retval = ( z ? -EINVAL : statistic_initialise(stat) );
+			break;
+		case STATISTIC_STATE_UNCONFIGURED :
+			retval = ( z ? statistic_uninitialise(stat)
+				     : statistic_define(stat) );
+			break;
+		case STATISTIC_STATE_RELEASED :
+			retval = ( z ? statistic_initialise(stat)
+				     : statistic_alloc(stat, info) );
+			break;
+		case STATISTIC_STATE_OFF :
+			retval = ( z ? statistic_free(stat, info)
+				     : statistic_start(stat) );
+			break;
+		case STATISTIC_STATE_ON :
+			retval = ( z ? statistic_stop(stat) : -EINVAL );
+			break;
+		}
+		if (unlikely(retval))
+			return retval;
+	}
+	return 0;
+}
+
+static int statistic_reset(struct statistic *stat, struct statistic_info *info)
+{
+	enum statistic_state prev_state = stat->state;
+	int cpu;
+
+	if (unlikely(stat->state < STATISTIC_STATE_OFF))
+		return 0;
+	statistic_transition(stat, info, STATISTIC_STATE_OFF);
+	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR))
+		statistic_reset_ptr(stat, stat->pdata);
+	else
+		for_each_cpu(cpu)
+			statistic_reset_ptr(stat, stat->pdata->ptrs[cpu]);
+	stat->age = sched_clock();
+	statistic_transition(stat, info, prev_state);
+	return 0;
+}
+
+static void statistic_merge(void *__mpriv)
+{
+	struct statistic_merge_private *mpriv = __mpriv;
+	struct statistic *stat = mpriv->stat;
+	struct statistic_discipline *disc = &statistic_discs[stat->type];
+	spin_lock(&mpriv->lock);
+	disc->merge(stat, mpriv->dst, stat->pdata->ptrs[smp_processor_id()]);
+	spin_unlock(&mpriv->lock);
+}
+
+/*
+ * For a particular statistic, exploiters must not intermix calls to
+ * statistic_set() and statistic_add/inc().
+ * Either a statistic is fed incremental data or it is about gathering
+ * total values already accumulated (like hardware counters).
+ * statistic_set() goes particularly well with a callback handler
+ * that can be registered by exploiters in order to allow users
+ * to pull fresh numbers when reading statistic data from file.
+ * Because reading from a file should be the only trigger for calling
+ * statistic_set(), we don't have to worry about concurrency nor
+ * per-cpu data in here. Neither does it have to be fast.
+ */
+void statistic_set(struct statistic *stat, int i, s64 value, u64 total)
+{
+	struct statistic_discipline *disc = &statistic_discs[stat[i].type];
+	if (stat[i].state == STATISTIC_STATE_ON)
+		disc->set(&stat[i], value, total);
+}
+
+static struct sgrb_seg * sgrb_seg_find(struct list_head *lh, int size)
+{
+	struct sgrb_seg *seg;
+
+	/* only the last buffer, if any, may have spare bytes */
+	list_for_each_entry_reverse(seg, lh, list) {
+		if (likely((PAGE_SIZE - seg->offset) >= size))
+			return seg;
+		break;
+	}
+	seg = kzalloc(sizeof(struct sgrb_seg), GFP_KERNEL);
+	if (unlikely(!seg))
+		return NULL;
+	seg->size = PAGE_SIZE;
+	seg->address = (void*)__get_free_page(GFP_KERNEL);
+	if (unlikely(!seg->address)) {
+		kfree(seg);
+		return NULL;
+	}
+	list_add_tail(&seg->list, lh);
+	return seg;
+}
+
+static void sgrb_seg_release_all(struct list_head *lh)
+{
+	struct sgrb_seg *seg, *tmp;
+
+	list_for_each_entry_safe(seg, tmp, lh, list) {
+		list_del(&seg->list);
+		free_page((unsigned long)seg->address);
+		kfree(seg);
+	}
+}
+
+static char * statistic_state_strings[] = {
+	"undefined(BUG)",
+	"unconfigured",
+	"released",
+	"off",
+	"on",
+};
+
+static int statistic_fdef(struct statistic_interface *interface, int i,
+			  struct statistic_file_private *private)
+{
+	struct statistic *stat = &interface->stat[i];
+	struct statistic_info *info = &interface->info[i];
+	struct statistic_discipline *disc = &statistic_discs[stat->type];
+	struct sgrb_seg *seg;
+	char t0[TIMESTAMP_SIZE], t1[TIMESTAMP_SIZE], t2[TIMESTAMP_SIZE];
+
+	seg = sgrb_seg_find(&private->read_seg_lh, 512);
+	if (unlikely(!seg))
+		return -ENOMEM;
+
+	seg->offset += sprintf(seg->address + seg->offset,
+			       "name=%s state=%s units=%s/%s",
+			       info->name, statistic_state_strings[stat->state],
+			       info->x_unit, info->y_unit);
+	if (stat->state == STATISTIC_STATE_UNCONFIGURED) {
+		seg->offset += sprintf(seg->address + seg->offset, "\n");
+		return 0;
+	}
+
+	seg->offset += sprintf(seg->address + seg->offset, " type=%s",
+			       disc->name);
+	if (disc->fdef)
+		seg->offset += disc->fdef(stat, seg->address + seg->offset);
+	if (stat->state == STATISTIC_STATE_RELEASED) {
+		seg->offset += sprintf(seg->address + seg->offset, "\n");
+		return 0;
+	}
+
+	nsec_to_timestamp(t0, stat->age);
+	nsec_to_timestamp(t1, stat->started);
+	nsec_to_timestamp(t2, stat->stopped);
+	seg->offset += sprintf(seg->address + seg->offset,
+			       " data=%s started=%s stopped=%s\n", t0, t1, t2);
+	return 0;
+}
+
+static inline int statistic_fdata(struct statistic_interface *interface, int i,
+				  struct statistic_file_private *fpriv)
+{
+	struct statistic *stat = &interface->stat[i];
+	struct statistic_info *info = &interface->info[i];
+	struct statistic_discipline *disc = &statistic_discs[stat->type];
+	struct statistic_merge_private mpriv;
+	int retval;
+
+	if (unlikely(stat->state < STATISTIC_STATE_OFF))
+		return 0;
+	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR))
+		return disc->fdata(stat, info->name, fpriv, stat->pdata);
+	mpriv.dst = statistic_alloc_ptr(stat, GFP_KERNEL, -1);
+	if (unlikely(!mpriv.dst))
+		return -ENOMEM;
+	spin_lock_init(&mpriv.lock);
+	mpriv.stat = stat;
+	on_each_cpu(statistic_merge, &mpriv, 0, 1);
+	retval = disc->fdata(stat, info->name, fpriv, mpriv.dst);
+	statistic_free_ptr(stat, mpriv.dst);
+	return retval;
+}
+
+/* cpu hotplug handling for per-cpu data */
+
+static inline int _statistic_hotcpu(struct statistic_interface *interface,
+				    int i, unsigned long action, int cpu)
+{
+	struct statistic *stat = &interface->stat[i];
+	struct statistic_info *info = &interface->info[i];
+
+	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR))
+		return 0;
+	if (stat->state < STATISTIC_STATE_OFF)
+		return 0;
+	switch (action) {
+	case CPU_UP_PREPARE:
+		stat->pdata->ptrs[cpu] = statistic_alloc_ptr(stat, GFP_ATOMIC,
+							     cpu_to_node(cpu));
+		break;
+	case CPU_UP_CANCELED:
+	case CPU_DEAD:
+		statistic_move_ptr(stat, stat->pdata->ptrs[cpu]);
+		statistic_free_ptr(stat, stat->pdata->ptrs[cpu]);
+		stat->pdata->ptrs[cpu] = NULL;
+		break;
+	}
+	return 0;
+}
+
+static struct list_head statistic_list;
+static struct mutex statistic_list_mutex;
+
+static int __devinit statistic_hotcpu(struct notifier_block *notifier,
+				      unsigned long action, void *__cpu)
+{
+	int cpu = (unsigned long)__cpu, i;
+	struct statistic_interface *interface;
+
+	mutex_lock(&statistic_list_mutex);
+	list_for_each_entry(interface, &statistic_list, list)
+		for (i = 0; i < interface->number; i++)
+			_statistic_hotcpu(interface, i, action, cpu);
+	mutex_unlock(&statistic_list_mutex);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block statistic_hotcpu_notifier =
+{
+	.notifier_call = statistic_hotcpu,
+};
+
+/* module startup / removal */
+
+static struct dentry *statistic_root_dir;
+
+int __init statistic_init(void)
+{
+	statistic_root_dir = debugfs_create_dir(STATISTIC_ROOT_DIR, NULL);
+	if (unlikely(!statistic_root_dir))
+		return -ENOMEM;
+	INIT_LIST_HEAD(&statistic_list);
+	mutex_init(&statistic_list_mutex);
+	register_cpu_notifier(&statistic_hotcpu_notifier);
+	return 0;
+}
+
+void __exit statistic_exit(void)
+{
+	unregister_cpu_notifier(&statistic_hotcpu_notifier);
+	debugfs_remove(statistic_root_dir);
+}
+
+/* parser used for configuring statistics */
+
+static int statistic_parse_single(struct statistic *stat,
+				  struct statistic_info *info,
+				  char *def, int type)
+{
+	struct statistic_discipline *disc = &statistic_discs[type];
+	int prev_state = stat->state, retval = 0;
+	char *copy;
+
+	if (disc->parse) {
+		copy = kstrdup(def, GFP_KERNEL);
+		if (unlikely(!copy))
+			return -ENOMEM;
+		retval = disc->parse(stat, info, type, copy);
+		kfree(copy);
+	} else if (type != stat->type)
+		statistic_transition(stat, info, STATISTIC_STATE_UNCONFIGURED);
+	if (!retval) {
+		stat->type = type;
+		stat->add = disc->add;
+	}
+	statistic_transition(stat, info,
+			     max(prev_state, STATISTIC_STATE_RELEASED));
+	return retval;
+}
+
+static match_table_t statistic_match_type = {
+	{1, "type=%s"},
+	{9, NULL}
+};
+
+static int statistic_parse_match(struct statistic *stat,
+				 struct statistic_info *info, char *def)
+{
+	int type, len;
+	char *p, *copy, *twisted;
+	substring_t args[MAX_OPT_ARGS];
+	struct statistic_discipline *disc;
+
+	if (!def)
+		def = info->defaults;
+	twisted = copy = kstrdup(def, GFP_KERNEL);
+	if (unlikely(!copy))
+		return -ENOMEM;
+	while ((p = strsep(&twisted, " ")) != NULL) {
+		if (!*p)
+			continue;
+		if (match_token(p, statistic_match_type, args) != 1)
+			continue;
+		len = (args[0].to - args[0].from) + 1;
+		for (type = 0; type < STATISTIC_TYPE_NONE; type++) {
+			disc = &statistic_discs[type];
+			if (unlikely(strncmp(disc->name, args[0].from, len)))
+				continue;
+			kfree(copy);
+			return statistic_parse_single(stat, info, def, type);
+		}
+	}
+	kfree(copy);
+	if (unlikely(stat->type == STATISTIC_TYPE_NONE))
+		return -EINVAL;
+	return statistic_parse_single(stat, info, def, stat->type);
+}
+
+static match_table_t statistic_match_common = {
+	{STATISTIC_STATE_UNCONFIGURED, "state=unconfigured"},
+	{STATISTIC_STATE_RELEASED, "state=released"},
+	{STATISTIC_STATE_OFF, "state=off"},
+	{STATISTIC_STATE_ON, "state=on"},
+	{1001, "name=%s"},
+	{1002, "data=reset"},
+	{1003, "defaults"},
+	{9999, NULL}
+};
+
+static void statistic_parse_line(struct statistic_interface *interface,
+				 char *def)
+{
+	char *p, *copy, *twisted, *name = NULL;
+	substring_t args[MAX_OPT_ARGS];
+	int token, reset = 0, defaults = 0, i;
+	int state = STATISTIC_STATE_INVALID;
+	struct statistic *stat = interface->stat;
+	struct statistic_info *info = interface->info;
+
+	if (unlikely(!def))
+		return;
+	twisted = copy = kstrdup(def, GFP_KERNEL);
+	if (unlikely(!copy))
+		return;
+
+	while ((p = strsep(&twisted, " ")) != NULL) {
+		if (!*p)
+			continue;
+		token = match_token(p, statistic_match_common, args);
+		switch (token) {
+		case STATISTIC_STATE_UNCONFIGURED :
+		case STATISTIC_STATE_RELEASED :
+		case STATISTIC_STATE_OFF :
+		case STATISTIC_STATE_ON :
+			state = token;
+			break;
+		case 1001 :
+			if (likely(!name))
+				name = match_strdup(&args[0]);
+			break;
+		case 1002 :
+			reset = 1;
+			break;
+		case 1003 :
+			defaults = 1;
+			break;
+		}
+	}
+	for (i = 0; i < interface->number; i++, stat++, info++) {
+		if (!name || (name && !strcmp(name, info->name))) {
+			if (defaults)
+				statistic_parse_match(stat, info, NULL);
+			if (name)
+				statistic_parse_match(stat, info, def);
+			if (state != STATISTIC_STATE_INVALID)
+				statistic_transition(stat, info, state);
+			if (reset)
+				statistic_reset(stat, info);
+		}
+	}
+	kfree(copy);
+	kfree(name);
+}
+
+static void statistic_parse(struct statistic_interface *interface,
+			    struct list_head *line_lh, size_t line_size)
+{
+	struct sgrb_seg *seg, *tmp;
+	char *buf;
+	int offset = 0;
+
+	if (unlikely(!line_size))
+		return;
+	buf = kmalloc(line_size + 2, GFP_KERNEL);
+	if (unlikely(!buf))
+		return;
+	buf[line_size] = ' ';
+	buf[line_size + 1] = '\0';
+	list_for_each_entry_safe(seg, tmp, line_lh, list) {
+		memcpy(buf + offset, seg->address, seg->size);
+		offset += seg->size;
+		list_del(&seg->list);
+		kfree(seg);
+	}
+	statistic_parse_line(interface, buf);
+	kfree(buf);
+}
+
+/* sequential files comprising user interface */
+
+static int statistic_generic_open(struct inode *inode,
+		struct file *file, struct statistic_interface **interface,
+		struct statistic_file_private **private)
+{
+	*interface = inode->u.generic_ip;
+	BUG_ON(!interface);
+	*private = kzalloc(sizeof(struct statistic_file_private), GFP_KERNEL);
+	if (unlikely(!*private))
+		return -ENOMEM;
+	INIT_LIST_HEAD(&(*private)->read_seg_lh);
+	INIT_LIST_HEAD(&(*private)->write_seg_lh);
+	file->private_data = *private;
+	return 0;
+}
+
+static int statistic_generic_close(struct inode *inode, struct file *file)
+{
+	struct statistic_file_private *private = file->private_data;
+	BUG_ON(!private);
+	sgrb_seg_release_all(&private->read_seg_lh);
+	sgrb_seg_release_all(&private->write_seg_lh);
+	kfree(private);
+	return 0;
+}
+
+static ssize_t statistic_generic_read(struct file *file,
+				char __user *buf, size_t len, loff_t *offset)
+{
+	struct statistic_file_private *private = file->private_data;
+	struct sgrb_seg *seg;
+	size_t seg_offset, seg_residual, seg_transfer;
+	size_t transfered = 0;
+	loff_t pos = 0;
+
+	BUG_ON(!private);
+	list_for_each_entry(seg, &private->read_seg_lh, list) {
+		if (unlikely(!len))
+			break;
+		if (*offset >= pos && *offset <= (pos + seg->offset)) {
+			seg_offset = *offset - pos;
+			seg_residual = seg->offset - seg_offset;
+			seg_transfer = min(len, seg_residual);
+			if (unlikely(copy_to_user(buf + transfered,
+						  seg->address + seg_offset,
+						  seg_transfer)))
+				return -EFAULT;
+			transfered += seg_transfer;
+			*offset += seg_transfer;
+			pos += seg_transfer + seg_offset;
+			len -= seg_transfer;
+		} else
+			pos += seg->offset;
+	}
+	return transfered;
+}
+
+static ssize_t statistic_generic_write(struct file *file,
+			const char __user *buf, size_t len, loff_t *offset)
+{
+	struct statistic_file_private *private = file->private_data;
+	struct sgrb_seg *seg;
+	size_t seg_residual, seg_transfer;
+	size_t transfered = 0;
+
+	BUG_ON(!private);
+	if (unlikely(*offset != private->write_seg_total_size))
+		return -EPIPE;
+	while (len) {
+		seg = sgrb_seg_find(&private->write_seg_lh, 1);
+		if (unlikely(!seg))
+			return -ENOMEM;
+		seg_residual = seg->size - seg->offset;
+		seg_transfer = min(len, seg_residual);
+		if (unlikely(copy_from_user(seg->address + seg->offset,
+					    buf + transfered, seg_transfer)))
+			return -EFAULT;
+		private->write_seg_total_size += seg_transfer;
+		seg->offset += seg_transfer;
+		transfered += seg_transfer;
+		*offset += seg_transfer;
+		len -= seg_transfer;
+	}
+	return transfered;
+}
+
+static int statistic_def_close(struct inode *inode, struct file *file)
+{
+	struct statistic_interface *interface = inode->u.generic_ip;
+	struct statistic_file_private *private = file->private_data;
+	struct sgrb_seg *seg, *seg_nl;
+	int offset;
+	struct list_head line_lh;
+	char *nl;
+	size_t line_size = 0;
+
+	INIT_LIST_HEAD(&line_lh);
+	list_for_each_entry(seg, &private->write_seg_lh, list) {
+		for (offset = 0; offset < seg->offset; offset += seg_nl->size) {
+			seg_nl = kmalloc(sizeof(struct sgrb_seg), GFP_KERNEL);
+			if (unlikely(!seg_nl))
+				/*
+				 * FIXME:
+				 * Should we omit other new settings because we
+				 * could not process this line of definitions?
+				 */
+				continue;
+			seg_nl->address = seg->address + offset;
+			nl = strnchr(seg_nl->address,
+				     seg->offset - offset, '\n');
+			if (nl) {
+				seg_nl->offset = nl - seg_nl->address;
+				if (seg_nl->offset)
+					seg_nl->offset--;
+			} else
+				seg_nl->offset = seg->offset - offset;
+			seg_nl->size = seg_nl->offset + 1;
+			line_size += seg_nl->size;
+			list_add_tail(&seg_nl->list, &line_lh);
+			if (nl) {
+				statistic_parse(interface, &line_lh, line_size);
+				line_size = 0;
+			}
+		}
+	}
+	if (!list_empty(&line_lh))
+		statistic_parse(interface, &line_lh, line_size);
+	return statistic_generic_close(inode, file);
+}
+
+static int statistic_def_open(struct inode *inode, struct file *file)
+{
+	struct statistic_interface *interface;
+	struct statistic_file_private *private;
+	int retval = 0;
+	int i;
+
+	retval = statistic_generic_open(inode, file, &interface, &private);
+	if (unlikely(retval))
+		return retval;
+	for (i = 0; i < interface->number; i++) {
+		retval = statistic_fdef(interface, i, private);
+		if (unlikely(retval)) {
+			statistic_def_close(inode, file);
+			break;
+		}
+	}
+	return retval;
+}
+
+static int statistic_data_open(struct inode *inode, struct file *file)
+{
+	struct statistic_interface *interface;
+	struct statistic_file_private *private;
+	int retval = 0;
+	int i;
+
+	retval = statistic_generic_open(inode, file, &interface, &private);
+	if (unlikely(retval))
+		return retval;
+	if (interface->pull)
+		interface->pull(interface->pull_private);
+	for (i = 0; i < interface->number; i++) {
+		retval = statistic_fdata(interface, i, private);
+		if (unlikely(retval)) {
+			statistic_generic_close(inode, file);
+			break;
+		}
+	}
+	return retval;
+}
+
+static struct file_operations statistic_def_fops = {
+	.owner		= THIS_MODULE,
+	.read		= statistic_generic_read,
+	.write		= statistic_generic_write,
+	.open		= statistic_def_open,
+	.release	= statistic_def_close,
+};
+
+static struct file_operations statistic_data_fops = {
+	.owner		= THIS_MODULE,
+	.read		= statistic_generic_read,
+	.open		= statistic_data_open,
+	.release	= statistic_generic_close,
+};
+
+/**
+ * statistic_create - setup statistics and create debugfs files
+ *
+ * @interface: struct statistic_interface provided by exploiter
+ * @name: name of debugfs directory to be created
+ *
+ * struct statistic_interface must have been set up prior to calling this.
+ *
+ * Creates a debugfs directory in "statistics" as well as the "data" and
+ * "definition" files. Then we attach setup statistics according to the
+ * definition provided by exploiter through struct statistic_interface.
+ *
+ * On success, 0 is returned.
+ *
+ * If some required memory could not be allocated, or the creation
+ * of debugfs entries failed, this routine fails, and -ENOMEM is returned.
+ */
+int statistic_create(struct statistic_interface *interface, const char *name)
+{
+	struct statistic *stat = interface->stat;
+	struct statistic_info *info = interface->info;
+	int i;
+
+	BUG_ON(!stat || !info || !interface->number);
+
+	interface->debugfs_dir =
+		debugfs_create_dir(name, statistic_root_dir);
+	if (unlikely(!interface->debugfs_dir))
+		return -ENOMEM;
+
+	interface->data_file = debugfs_create_file(
+		STATISTIC_FILENAME_DATA, S_IFREG | S_IRUSR,
+		interface->debugfs_dir, (void*)interface, &statistic_data_fops);
+	if (unlikely(!interface->data_file)) {
+		debugfs_remove(interface->debugfs_dir);
+		return -ENOMEM;
+	}
+
+	interface->def_file = debugfs_create_file(
+		STATISTIC_FILENAME_DEF, S_IFREG | S_IRUSR | S_IWUSR,
+		interface->debugfs_dir, (void*)interface, &statistic_def_fops);
+	if (unlikely(!interface->def_file)) {
+		debugfs_remove(interface->data_file);
+		debugfs_remove(interface->debugfs_dir);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < interface->number; i++, stat++, info++) {
+		statistic_transition(stat, info, STATISTIC_STATE_UNCONFIGURED);
+		statistic_parse_match(stat, info, NULL);
+	}
+
+	mutex_lock(&statistic_list_mutex);
+	list_add(&interface->list, &statistic_list);
+	mutex_unlock(&statistic_list_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(statistic_create);
+
+/**
+ * statistic_remove - remove unused statistics
+ * @interface_ptr: struct statistic_interface to clean up
+ *
+ * Remove a debugfs directory in "statistics" along with its "data" and
+ * "definition" files. Removing this user interface also causes the removal
+ * of all statistics attached to the interface.
+ *
+ * The exploiter must have ceased reporting statistic data.
+ *
+ * Returns -EINVAL for attempted double removal, 0 otherwise.
+ */
+int statistic_remove(struct statistic_interface *interface)
+{
+	struct statistic *stat = interface->stat;
+	struct statistic_info *info = interface->info;
+	int i;
+
+	if (unlikely(!interface->debugfs_dir))
+		return -EINVAL;
+	mutex_lock(&statistic_list_mutex);
+	list_del(&interface->list);
+	mutex_unlock(&statistic_list_mutex);
+	for (i = 0; i < interface->number; i++, stat++, info++)
+		statistic_transition(stat, info, STATISTIC_STATE_INVALID);
+	debugfs_remove(interface->data_file);
+	debugfs_remove(interface->def_file);
+	debugfs_remove(interface->debugfs_dir);
+	interface->debugfs_dir = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(statistic_remove);
+
+/* code concerned with single value statistics */
+
+static void statistic_reset_counter(struct statistic *stat, void *ptr)
+{
+	*(u64*)ptr = 0;
+}
+
+static void statistic_add_counter_inc(struct statistic *stat, int cpu,
+				     s64 value, u64 incr)
+{
+	*(u64*)stat->pdata->ptrs[cpu] += incr;
+}
+
+static void statistic_add_counter_prod(struct statistic *stat, int cpu,
+				       s64 value, u64 incr)
+{
+	if (unlikely(value < 0))
+		value = -value;
+	*(u64*)stat->pdata->ptrs[cpu] += value * incr;
+}
+
+static void statistic_set_counter_inc(struct statistic *stat,
+				      s64 value, u64 total)
+{
+	*(u64*)stat->pdata = total;
+}
+
+static void statistic_set_counter_prod(struct statistic *stat,
+				       s64 value, u64 total)
+{
+	if (unlikely(value < 0))
+		value = -value;
+	*(u64*)stat->pdata = value * total;
+}
+
+static void statistic_merge_counter(struct statistic *stat,
+				    void *dst, void *src)
+{
+	*(u64*)dst += *(u64*)src;
+}
+
+static int statistic_fdata_counter(struct statistic *stat, const char *name,
+				   struct statistic_file_private *fpriv,
+				   void *data)
+{
+	struct sgrb_seg *seg;
+	seg = sgrb_seg_find(&fpriv->read_seg_lh, 128);
+	if (unlikely(!seg))
+		return -ENOMEM;
+	seg->offset += sprintf(seg->address + seg->offset, "%s %Lu\n",
+			       name, *(unsigned long long *)data);
+	return 0;
+}
+
+/* code concerned with utilisation indicator statistic */
+
+static void statistic_reset_util(struct statistic *stat, void *ptr)
+{
+	struct statistic_entry_util *util = ptr;
+	util->num = 0;
+	util->acc = 0;
+	util->min = (~0ULL >> 1) - 1;
+	util->max = -(~0ULL >> 1) + 1;
+}
+
+static void statistic_add_util(struct statistic *stat, int cpu,
+			       s64 value, u64 incr)
+{
+	struct statistic_entry_util *util = stat->pdata->ptrs[cpu];
+	util->num += incr;
+	util->acc += value * incr;
+	if (unlikely(value < util->min))
+		util->min = value;
+	if (unlikely(value > util->max))
+		util->max = value;
+}
+
+static void statistic_set_util(struct statistic *stat, s64 value, u64 total)
+{
+	struct statistic_entry_util *util;
+	util = (struct statistic_entry_util *) stat->pdata;
+	util->num = total;
+	util->acc = value * total;
+	if (unlikely(value < util->min))
+		util->min = value;
+	if (unlikely(value > util->max))
+		util->max = value;
+}
+
+static void statistic_merge_util(struct statistic *stat, void *_dst, void *_src)
+{
+	struct statistic_entry_util *dst = _dst, *src = _src;
+	dst->num += src->num;
+	dst->acc += src->acc;
+	if (unlikely(src->min < dst->min))
+		dst->min = src->min;
+	if (unlikely(src->max > dst->max))
+		dst->max = src->max;
+}
+
+static int statistic_fdata_util(struct statistic *stat, const char *name,
+				struct statistic_file_private *fpriv,
+				void *data)
+{
+	struct sgrb_seg *seg;
+	struct statistic_entry_util *util = data;
+	unsigned long long whole = 0;
+	signed long long min = 0, max = 0, decimal = 0, last_digit;
+
+	seg = sgrb_seg_find(&fpriv->read_seg_lh, 128);
+	if (unlikely(!seg))
+		return -ENOMEM;
+	if (likely(util->num)) {
+		whole = util->acc;
+		do_div(whole, util->num);
+		decimal = util->acc * 10000;
+		do_div(decimal, util->num);
+		decimal -= whole * 10000;
+		if (decimal < 0)
+			decimal = -decimal;
+		last_digit = decimal;
+		do_div(last_digit, 10);
+		last_digit = decimal - last_digit * 10;
+		if (last_digit >= 5)
+			decimal += 10;
+		do_div(decimal, 10);
+		min = util->min;
+		max = util->max;
+	}
+	seg->offset += sprintf(seg->address + seg->offset,
+			       "%s %Lu %Ld %Ld.%03lld %Ld\n", name,
+			       (unsigned long long)util->num,
+			       (signed long long)min, whole, decimal,
+			       (signed long long)max);
+	return 0;
+}
+
+/* code concerned with histogram statistics */
+
+static void * statistic_alloc_histogram(struct statistic *stat, size_t size,
+					gfp_t flags, int node)
+{
+	return kmalloc_node(size * (stat->u.histogram.last_index + 1),
+			    flags, node);
+}
+
+static inline s64 statistic_histogram_calc_value_lin(struct statistic *stat,
+						     int i)
+{
+	return stat->u.histogram.range_min +
+		stat->u.histogram.base_interval * i;
+}
+
+static inline s64 statistic_histogram_calc_value_log2(struct statistic *stat,
+						      int i)
+{
+	return stat->u.histogram.range_min +
+		(i ? (stat->u.histogram.base_interval << (i - 1)) : 0);
+}
+
+static inline s64 statistic_histogram_calc_value(struct statistic *stat, int i)
+{
+	if (stat->type == STATISTIC_TYPE_HISTOGRAM_LIN)
+		return statistic_histogram_calc_value_lin(stat, i);
+	else
+		return statistic_histogram_calc_value_log2(stat, i);
+}
+
+static inline int statistic_histogram_calc_index_lin(struct statistic *stat,
+						 s64 value)
+{
+	unsigned long long i = value - stat->u.histogram.range_min;
+	do_div(i, stat->u.histogram.base_interval);
+	return i;
+}
+
+static inline int statistic_histogram_calc_index_log2(struct statistic *stat,
+						      s64 value)
+{
+	unsigned long long i;
+	for (i = 0;
+	     i < stat->u.histogram.last_index &&
+	     value > statistic_histogram_calc_value_log2(stat, i);
+	     i++);
+	return i;
+}
+
+static inline int statistic_histogram_calc_index(struct statistic *stat,
+						 s64 value)
+{
+	if (stat->type == STATISTIC_TYPE_HISTOGRAM_LIN)
+		return statistic_histogram_calc_index_lin(stat, value);
+	else
+		return statistic_histogram_calc_index_log2(stat, value);
+}
+
+static void statistic_reset_histogram(struct statistic *stat, void *ptr)
+{
+	memset(ptr, 0, (stat->u.histogram.last_index + 1) * sizeof(u64));
+}
+
+static void statistic_add_histogram_lin(struct statistic *stat, int cpu,
+					s64 value, u64 incr)
+{
+	int i = statistic_histogram_calc_index_lin(stat, value);
+	((u64*)stat->pdata->ptrs[cpu])[i] += incr;
+}
+
+static void statistic_add_histogram_log2(struct statistic *stat, int cpu,
+					 s64 value, u64 incr)
+{
+	int i = statistic_histogram_calc_index_log2(stat, value);
+	((u64*)stat->pdata->ptrs[cpu])[i] += incr;
+}
+
+static void statistic_set_histogram_lin(struct statistic *stat,
+					s64 value, u64 total)
+{
+	int i = statistic_histogram_calc_index_lin(stat, value);
+	((u64*)stat->pdata)[i] = total;
+}
+
+static void statistic_set_histogram_log2(struct statistic *stat,
+					 s64 value, u64 total)
+{
+	int i = statistic_histogram_calc_index_log2(stat, value);
+	((u64*)stat->pdata)[i] = total;
+}
+
+static void statistic_merge_histogram(struct statistic *stat,
+				      void *_dst, void *_src)
+{
+	u64 *dst = _dst, *src = _src;
+	int i;
+	for (i = 0; i <= stat->u.histogram.last_index; i++)
+		dst[i] += src[i];
+}
+
+static inline int statistic_fdata_histogram_line(const char *name,
+					struct statistic_file_private *private,
+					const char *prefix, s64 bound, u64 hits)
+{
+	struct sgrb_seg *seg;
+	seg = sgrb_seg_find(&private->read_seg_lh, 256);
+	if (unlikely(!seg))
+		return -ENOMEM;
+	seg->offset += sprintf(seg->address + seg->offset, "%s %s%Ld %Lu\n",
+			       name, prefix, (signed long long)bound,
+			       (unsigned long long)hits);
+	return 0;
+}
+
+static int statistic_fdata_histogram(struct statistic *stat, const char *name,
+				     struct statistic_file_private *fpriv,
+				     void *data)
+{
+	int i, retval;
+	s64 bound = 0;
+	for (i = 0; i < (stat->u.histogram.last_index); i++) {
+		bound = statistic_histogram_calc_value(stat, i);
+		retval = statistic_fdata_histogram_line(name, fpriv, "<=",
+							bound, ((u64*)data)[i]);
+		if (unlikely(retval))
+			return retval;
+	}
+	return statistic_fdata_histogram_line(name, fpriv, ">",
+					      bound, ((u64*)data)[i]);
+}
+
+static int statistic_fdef_histogram(struct statistic *stat, char *line)
+{
+	return sprintf(line, " range_min=%Li entries=%Li base_interval=%Lu",
+		       (signed long long)stat->u.histogram.range_min,
+		       (unsigned long long)(stat->u.histogram.last_index + 1),
+		       (unsigned long long)stat->u.histogram.base_interval);
+}
+
+static match_table_t statistic_match_histogram = {
+	{1, "entries=%u"},
+	{2, "base_interval=%s"},
+	{3, "range_min=%s"},
+	{9, NULL}
+};
+
+static int statistic_parse_histogram(struct statistic *stat,
+				     struct statistic_info *info,
+				     int type, char *def)
+{
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
+	int token, got_entries = 0, got_interval = 0, got_range = 0;
+	u32 entries, base_interval;
+	s64 range_min;
+
+	while ((p = strsep(&def, " ")) != NULL) {
+		if (!*p)
+			continue;
+		token = match_token(p, statistic_match_histogram, args);
+		switch (token) {
+		case 1 :
+			match_int(&args[0], &entries);
+			got_entries = 1;
+			break;
+		case 2 :
+			match_int(&args[0], &base_interval);
+			got_interval = 1;
+			break;
+		case 3 :
+			match_s64(&args[0], &range_min, 0);
+			got_range = 1;
+			break;
+		}
+	}
+	if (unlikely(type != stat->type &&
+		     !(got_entries && got_interval && got_range)))
+		return -EINVAL;
+	statistic_transition(stat, info, STATISTIC_STATE_UNCONFIGURED);
+	if (got_entries)
+		stat->u.histogram.last_index = entries - 1;
+	if (got_interval)
+		stat->u.histogram.base_interval = base_interval;
+	if (got_range)
+		stat->u.histogram.range_min = range_min;
+	return 0;
+}
+
+/* code concerned with histograms (discrete value) statistics */
+
+static void * statistic_alloc_sparse(struct statistic *stat, size_t size,
+				     gfp_t flags, int node)
+{
+	struct statistic_sparse_list *slist = kmalloc_node(size, flags, node);
+	INIT_LIST_HEAD(&slist->entry_lh);
+	slist->entries_max = stat->u.sparse.entries_max;
+	return slist;
+}
+
+static void statistic_free_sparse(struct statistic *stat, void *ptr)
+{
+	struct statistic_entry_sparse *entry, *tmp;
+	struct statistic_sparse_list *slist = ptr;
+	list_for_each_entry_safe(entry, tmp, &slist->entry_lh, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+	slist->hits_missed = 0;
+	slist->entries = 0;
+}
+
+static inline void statistic_add_sparse_sort(struct list_head *head,
+					struct statistic_entry_sparse *entry)
+{
+	struct statistic_entry_sparse *sort =
+		list_prepare_entry(entry, head, list);
+
+	list_for_each_entry_continue_reverse(sort, head, list)
+		if (likely(sort->hits >= entry->hits))
+			break;
+	if (unlikely(sort->list.next != &entry->list &&
+		     (&sort->list == head || sort->hits >= entry->hits)))
+		list_move(&entry->list, &sort->list);
+}
+
+static inline int statistic_add_sparse_new(struct statistic_sparse_list *slist,
+					   s64 value, u64 incr)
+{
+	struct statistic_entry_sparse *entry;
+
+	if (unlikely(slist->entries == slist->entries_max))
+		return -ENOMEM;
+	entry = kmalloc(sizeof(struct statistic_entry_sparse), GFP_ATOMIC);
+	if (unlikely(!entry))
+		return -ENOMEM;
+	entry->value = value;
+	entry->hits = incr;
+	slist->entries++;
+	list_add_tail(&entry->list, &slist->entry_lh);
+	return 0;
+}
+
+static inline void _statistic_add_sparse(struct statistic_sparse_list *slist,
+					 s64 value, u64 incr)
+{
+	struct list_head *head = &slist->entry_lh;
+	struct statistic_entry_sparse *entry;
+
+	list_for_each_entry(entry, head, list) {
+		if (likely(entry->value == value)) {
+			entry->hits += incr;
+			statistic_add_sparse_sort(head, entry);
+			return;
+		}
+	}
+	if (unlikely(statistic_add_sparse_new(slist, value, incr)))
+		slist->hits_missed += incr;
+}
+
+static void statistic_add_sparse(struct statistic *stat, int cpu,
+				 s64 value, u64 incr)
+{
+	struct statistic_sparse_list *slist = stat->pdata->ptrs[cpu];
+	_statistic_add_sparse(slist, value, incr);
+}
+
+static void statistic_set_sparse(struct statistic *stat, s64 value, u64 total)
+{
+	struct statistic_sparse_list *slist = (struct statistic_sparse_list *)
+						stat->pdata;
+	struct list_head *head = &slist->entry_lh;
+	struct statistic_entry_sparse *entry;
+
+	list_for_each_entry(entry, head, list) {
+		if (likely(entry->value == value)) {
+			entry->hits = total;
+			statistic_add_sparse_sort(head, entry);
+			return;
+		}
+	}
+	if (unlikely(statistic_add_sparse_new(slist, value, total)))
+		slist->hits_missed += total;
+}
+
+static void statistic_merge_sparse(struct statistic *stat,
+				   void *_dst, void *_src)
+{
+	struct statistic_sparse_list *dst = _dst, *src = _src;
+	struct statistic_entry_sparse *entry;
+	dst->hits_missed += src->hits_missed;
+	list_for_each_entry(entry, &src->entry_lh, list)
+		_statistic_add_sparse(dst, entry->value, entry->hits);
+}
+
+static int statistic_fdata_sparse(struct statistic *stat, const char *name,
+				  struct statistic_file_private *fpriv,
+				  void *data)
+{
+	struct sgrb_seg *seg;
+	struct statistic_sparse_list *slist = data;
+	struct statistic_entry_sparse *entry;
+
+	seg = sgrb_seg_find(&fpriv->read_seg_lh, 256);
+	if (unlikely(!seg))
+		return -ENOMEM;
+	seg->offset += sprintf(seg->address + seg->offset, "%s missed 0x%Lu\n",
+			       name, (unsigned long long)slist->hits_missed);
+	list_for_each_entry(entry, &slist->entry_lh, list) {
+		seg = sgrb_seg_find(&fpriv->read_seg_lh, 256);
+		if (unlikely(!seg))
+			return -ENOMEM;
+		seg->offset += sprintf(seg->address + seg->offset,
+				       "%s 0x%Lx %Lu\n", name,
+				       (signed long long)entry->value,
+				       (unsigned long long)entry->hits);
+	}
+	return 0;
+}
+
+static int statistic_fdef_sparse(struct statistic *stat, char *line)
+{
+	return sprintf(line, " entries=%u", stat->u.sparse.entries_max);
+}
+
+static match_table_t statistic_match_sparse = {
+	{1, "entries=%u"},
+	{9, NULL}
+};
+
+static int statistic_parse_sparse(struct statistic *stat,
+				  struct statistic_info *info,
+				  int type, char *def)
+{
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
+
+	while ((p = strsep(&def, " ")) != NULL) {
+		if (!*p)
+			continue;
+		if (match_token(p, statistic_match_sparse, args) == 1) {
+			statistic_transition(stat, info,
+					     STATISTIC_STATE_UNCONFIGURED);
+			match_int(&args[0], &stat->u.sparse.entries_max);
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+/* code mostly concerned with managing statistics */
+
+static struct statistic_discipline statistic_discs[] = {
+	{ /* STATISTIC_TYPE_COUNTER_INC */
+	  NULL,
+	  statistic_alloc_generic,
+	  NULL,
+	  statistic_reset_counter,
+	  statistic_merge_counter,
+	  statistic_fdata_counter,
+	  NULL,
+	  statistic_add_counter_inc,
+	  statistic_set_counter_inc,
+	  "counter_inc", sizeof(u64)
+	},
+	{ /* STATISTIC_TYPE_COUNTER_PROD */
+	  NULL,
+	  statistic_alloc_generic,
+	  NULL,
+	  statistic_reset_counter,
+	  statistic_merge_counter,
+	  statistic_fdata_counter,
+	  NULL,
+	  statistic_add_counter_prod,
+	  statistic_set_counter_prod,
+	  "counter_prod", sizeof(u64)
+	},
+	{ /* STATISTIC_TYPE_UTIL */
+	  NULL,
+	  statistic_alloc_generic,
+	  NULL,
+	  statistic_reset_util,
+	  statistic_merge_util,
+	  statistic_fdata_util,
+	  NULL,
+	  statistic_add_util,
+	  statistic_set_util,
+	  "utilisation", sizeof(struct statistic_entry_util)
+	},
+	{ /* STATISTIC_TYPE_HISTOGRAM_LIN */
+	  statistic_parse_histogram,
+	  statistic_alloc_histogram,
+	  NULL,
+	  statistic_reset_histogram,
+	  statistic_merge_histogram,
+	  statistic_fdata_histogram,
+	  statistic_fdef_histogram,
+	  statistic_add_histogram_lin,
+	  statistic_set_histogram_lin,
+	  "histogram_lin", sizeof(u64)
+	},
+	{ /* STATISTIC_TYPE_HISTOGRAM_LOG2 */
+	  statistic_parse_histogram,
+	  statistic_alloc_histogram,
+	  NULL,
+	  statistic_reset_histogram,
+	  statistic_merge_histogram,
+	  statistic_fdata_histogram,
+	  statistic_fdef_histogram,
+	  statistic_add_histogram_log2,
+	  statistic_set_histogram_log2,
+	  "histogram_log2", sizeof(u64)
+	},
+	{ /* STATISTIC_TYPE_SPARSE */
+	  statistic_parse_sparse,
+	  statistic_alloc_sparse,
+	  statistic_free_sparse,
+	  statistic_free_sparse,	/* reset equals free */
+	  statistic_merge_sparse,
+	  statistic_fdata_sparse,
+	  statistic_fdef_sparse,
+	  statistic_add_sparse,
+	  statistic_set_sparse,
+	  "sparse", sizeof(struct statistic_sparse_list)
+	},
+	{ /* STATISTIC_TYPE_NONE */ }
+};
+
+postcore_initcall(statistic_init);
+module_exit(statistic_exit);
+
+MODULE_LICENSE("GPL");
diff -Nurp a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	2006-05-17 19:02:04.000000000 +0200
+++ b/lib/Makefile	2006-05-17 19:07:17.000000000 +0200
@@ -47,6 +47,8 @@ obj-$(CONFIG_TEXTSEARCH_KMP) += ts_kmp.o
 obj-$(CONFIG_TEXTSEARCH_BM) += ts_bm.o
 obj-$(CONFIG_TEXTSEARCH_FSM) += ts_fsm.o
 
+obj-$(CONFIG_STATISTICS) += statistic.o
+
 obj-$(CONFIG_SWIOTLB) += swiotlb.o
 
 hostprogs-y	:= gen_crc32table
diff -Nurp a/lib/Kconfig.statistic b/lib/Kconfig.statistic
--- a/lib/Kconfig.statistic	1970-01-01 01:00:00.000000000 +0100
+++ b/lib/Kconfig.statistic	2006-05-17 19:07:17.000000000 +0200
@@ -0,0 +1,11 @@
+config STATISTICS
+	bool "Statistics infrastructure"
+	depends on DEBUG_FS
+	help
+	  The statistics infrastructure provides a debug-fs based user interface
+	  for statistics of kernel components, that is, usually device drivers.
+	  Statistics are available for components that have been instrumented to
+	  feed data into the statistics infrastructure.
+	  This feature is useful for performance measurements or performance
+	  debugging.
+	  If in doubt, say "N".
diff -Nurp a/arch/s390/oprofile/Kconfig b/arch/s390/oprofile/Kconfig
--- a/arch/s390/oprofile/Kconfig	2006-03-20 06:53:29.000000000 +0100
+++ b/arch/s390/oprofile/Kconfig	2006-05-17 19:07:17.000000000 +0200
@@ -1,6 +1,3 @@
-
-menu "Profiling support"
-
 config PROFILING
 	bool "Profiling support"
 	help
@@ -18,5 +15,3 @@ config OPROFILE
 
 	  If unsure, say N.
 
-endmenu
-
diff -Nurp a/arch/s390/Kconfig b/arch/s390/Kconfig
--- a/arch/s390/Kconfig	2006-05-17 19:01:52.000000000 +0200
+++ b/arch/s390/Kconfig	2006-05-17 19:07:17.000000000 +0200
@@ -474,8 +474,14 @@ source "drivers/net/Kconfig"
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+
 source "arch/s390/oprofile/Kconfig"
 
+source "lib/Kconfig.statistic"
+
+endmenu
+
 source "arch/s390/Kconfig.debug"
 
 source "security/Kconfig"
diff -Nurp a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2006-05-17 19:04:04.000000000 +0200
+++ b/MAINTAINERS	2006-05-17 19:07:17.000000000 +0200
@@ -2608,6 +2608,13 @@ STARMODE RADIO IP (STRIP) PROTOCOL DRIVE
 W:	http://mosquitonet.Stanford.EDU/strip.html
 S:	Unsupported ?
 
+STATISTICS INFRASTRUCTURE
+P:	Martin Peschke
+M:	mpeschke@de.ibm.com
+M:	linux390@de.ibm.com
+W:	http://www.ibm.com/developerworks/linux/linux390/
+S:	Supported
+
 STRADIS MPEG-2 DECODER DRIVER
 P:	Nathan Laredo
 M:	laredo@gnu.org


