Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751631AbVJ1OGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbVJ1OGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbVJ1OGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:06:18 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:27837 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751627AbVJ1OGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:06:16 -0400
Date: Fri, 28 Oct 2005 16:06:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, mpeschke@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 1/14] s390: statistics infrastructure.
Message-ID: <20051028140617.GA7300@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Peschke <mpeschke@de.ibm.com>

[patch 1/14] s390: statistics infrastructure.

Add the statistics facility. This features offers a simple way to
gather statistical data and to display them via the debugfs.
An example how this is used:

	struct statistic_interface *stat_if;
	struct statistic *stat;

	statistic_interface_create(&stat_if, "whatever");
	statistic_create(&stat, stat_if, "stat-name", "unit");
	statistic_define_value(stat, range_min, range_max, def_mode);
	...
	statistic_inc(stat, value);	/* repeat.. */
	...
	statistic_interface_remove(&stat_if);

Signed-off-by: Martin Peschke <mpeschke@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/Makefile    |    3 
 arch/s390/kernel/sgrb.c      |  303 +++++
 arch/s390/kernel/statistic.c | 2236 +++++++++++++++++++++++++++++++++++++++++++
 include/asm-s390/sgrb.h      |   94 +
 include/asm-s390/statistic.h |  334 ++++++
 include/linux/list.h         |   12 
 include/linux/parser.h       |    2 
 lib/parser.c                 |   60 +
 8 files changed, 3043 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/Makefile linux-2.6-patched/arch/s390/kernel/Makefile
--- linux-2.6/arch/s390/kernel/Makefile	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/Makefile	2005-10-28 14:04:43.000000000 +0200
@@ -6,7 +6,8 @@ EXTRA_AFLAGS	:= -traditional
 
 obj-y	:=  bitmap.o traps.o time.o process.o \
             setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
-            semaphore.o s390_ext.o debug.o profile.o irq.o reipl_diag.o
+            semaphore.o s390_ext.o debug.o profile.o irq.o sgrb.o \
+            statistic.o reipl_diag.o
 
 extra-$(CONFIG_ARCH_S390_31)	+= head.o 
 extra-$(CONFIG_ARCH_S390X)	+= head64.o 
diff -urpN linux-2.6/arch/s390/kernel/sgrb.c linux-2.6-patched/arch/s390/kernel/sgrb.c
--- linux-2.6/arch/s390/kernel/sgrb.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/sgrb.c	2005-10-28 14:04:43.000000000 +0200
@@ -0,0 +1,303 @@
+/*
+ * arch/s390/kernel/sgrb.c
+ *
+ * a ringbuffer made up of scattered buffers; holds fixed-size entries
+ * (resizing has not been implemented)
+ *
+ * (C) Copyright IBM Corp. 2005
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
+#define SGRB_C_REVISION "$Revision: 1.3 $"
+
+#include <linux/module.h>
+
+#include <asm/sgrb.h>
+
+static struct sgrb_seg *
+sgrb_seg_alloc(struct list_head *lh, int size, unsigned int gfp)
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
+ * @size: entry size (should be identical for all entries of same buffer list)
+ * @gfp: GFP_* flags used if another buffer needs to be allocated
+ *
+ * tries to find room for an entry in buffer alloacted last, and, on failure,
+ * allocates another buffer
+ */
+struct sgrb_seg *
+sgrb_seg_find(struct list_head *lh, int size, unsigned int gfp)
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
+EXPORT_SYMBOL(sgrb_seg_find);
+
+/**
+ * sgrb_seg_release_all - releases scatter-gather buffer
+ * @lh: list_head that holds list of scattered buffer parts
+ */
+void
+sgrb_seg_release_all(struct list_head *lh)
+{
+	struct sgrb_seg *seg, *tmp;
+
+	list_for_each_entry_safe(seg, tmp, lh, list) {
+		list_del(&seg->list);
+		kfree(seg->address);
+		kfree(seg);
+	}
+}
+EXPORT_SYMBOL(sgrb_seg_release_all);
+
+static inline int
+sgrb_ptr_identical(
+	struct sgrb_ptr *a,
+	struct sgrb_ptr *b)
+{
+	if (a->seg == b->seg &&
+	    a->offset == b->offset)
+		return 1;
+	else
+		return 0;
+}
+
+static inline int
+sgrb_ptr_valid(struct sgrb_ptr *a)
+{
+	return (a->offset >= 0);
+}
+
+static inline void
+sgrb_ptr_invalidate(struct sgrb *rb, struct sgrb_ptr *a)
+{
+	a->offset = -rb->entry_size;
+}
+
+static inline void
+sgrb_init(struct sgrb *rb)
+{
+	sgrb_ptr_invalidate(rb, &rb->first);
+	sgrb_ptr_invalidate(rb, &rb->last);
+	rb->entries = 0;
+}
+
+/**
+ * sgrb_alloc - prepare a new ringbuffer for use
+ *
+ * @rb: a ringbuffer struct provided by the exploiter
+ * @entry_size: size of entries in ringbuffer
+ * @entry_num: total number of entries in ringbuffer
+ * @seg_size: size of individual, scatter-gathered segments used to build up
+ *            ringbuffer
+ * @gfp: kmalloc flags
+ *
+ * Returns 0 on success.
+ * Returns -ENOMEM if some memory allocation failed.
+ **/
+int
+sgrb_alloc(
+	struct sgrb *rb,
+	int entry_size, int entry_num, int seg_size, int gfp)
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
+		if (!sgrb_seg_alloc(&rb->seg_lh, seg_size, gfp))
+			return -ENOMEM;
+	if (residual)
+		if (!sgrb_seg_alloc(&rb->seg_lh, residual, gfp))
+			return -ENOMEM;
+	list_for_each_entry(seg, &rb->seg_lh, list)
+		break;
+	rb->first.seg = seg;
+	rb->last.seg = seg;
+	sgrb_init(rb);
+	return 0;
+}
+EXPORT_SYMBOL(sgrb_alloc);
+
+/**
+ * sgrb_release - destroy a ringbuffer
+ *
+ * @rb: the ringbuffer to release
+ **/
+void
+sgrb_release(struct sgrb *rb)
+{
+	sgrb_seg_release_all(&rb->seg_lh);
+	memset(rb, 0, sizeof(struct sgrb));
+}
+EXPORT_SYMBOL(sgrb_release);
+
+static void
+sgrb_next_entry(
+	struct sgrb *rb,
+	struct sgrb_ptr *pos,
+	struct sgrb_ptr *next)
+{
+	sgrb_ptr_copy(next, pos);
+	next->offset += rb->entry_size;
+	if ((next->offset + rb->entry_size) - 1 > next->seg->size) {
+		if (rb->seg_lh.prev == &next->seg->list) {
+			next->seg = NULL;
+			next->seg = list_prepare_entry(next->seg, &rb->seg_lh, list);
+		}
+		list_for_each_entry_continue(next->seg, &rb->seg_lh, list)
+			break;
+		next->offset = 0;
+	}
+}
+
+/**
+ * sgrb_produce_overwrite - put an entry into the ringbuffer and
+ *     overwrite an older entry not yet consumed if required
+ *
+ * @rb: the ringbuffer pointer to use
+ *
+ * Always returns address of the new entry.
+ **/
+void *
+sgrb_produce_overwrite(struct sgrb *rb)
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
+EXPORT_SYMBOL(sgrb_produce_overwrite);
+
+/**
+ * sgrb_produce_nooverwrite - put an entry into the ringbuffer
+ *     if there is room whithout the need to overwrite the oldest
+ *     entry not yet consumed
+ *
+ * @rb: the ringbuffer to use
+ *
+ * Returns address of the new entry, if there is room for it.
+ * Returns NULL otherwise.
+ **/
+void *
+sgrb_produce_nooverwrite(struct sgrb *rb)
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
+EXPORT_SYMBOL(sgrb_produce_nooverwrite);
+
+/**
+ * sgrb_consume_delete - get an entry from the ringbuffer and
+ *     delete the entry from the ringbuffer so that it can't
+ *     be consumed twice, and in order to free up its slot for
+ *     another entry
+ *
+ * @rb: the ringbuffer to use
+ *
+ * Returns address of the entry read, if there is an entry available.
+ * Returns NULL otherwise.
+ **/
+void *
+sgrb_consume_delete(struct sgrb *rb)
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
+EXPORT_SYMBOL(sgrb_consume_delete);
+
+/**
+ * sgrb_consume_delete - get an entry from the ringbuffer
+ *     while keeping this entry in the ringbuffer so that it can
+ *     be consumed again
+ *
+ * @rb: the ringbuffer to use
+ * @pos:  the ringbuffer pointer that determines which entry to consume
+ *
+ * Use sgrb_ptr_copy() to prepare pos prior to iterating over the ringbuffer
+ * (copy rb->first, the producers tail and the consumers head, to pos).
+ *
+ * Returns address of the new entry, if there is room for it.
+ * Returns NULL otherwise.
+ **/
+void *
+sgrb_consume_nodelete(
+	struct sgrb *rb,
+	struct sgrb_ptr *pos)
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
+EXPORT_SYMBOL(sgrb_consume_nodelete);
diff -urpN linux-2.6/arch/s390/kernel/statistic.c linux-2.6-patched/arch/s390/kernel/statistic.c
--- linux-2.6/arch/s390/kernel/statistic.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/statistic.c	2005-10-28 14:04:43.000000000 +0200
@@ -0,0 +1,2236 @@
+/*
+ *  arch/s390/kernel/statistic.c
+ *   S/390 statistic facility
+ *
+ *    Copyright (C) 2005 IBM Deutschland Entwicklung GmbH,
+ *                       IBM Corporation
+ *
+ *    Author(s): Martin Peschke (mpeschke@de.ibm.com),
+ *
+ *    Bugreports to: <Linux390@de.ibm.com>
+ *
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
+ *
+ *    todos:
+ *	- dev. team: define a set of agreed names or a naming scheme for
+ *	  consistency and comparability across exploiters
+ *	  (e.g. similar statistic names for latencies of dasd driver
+ *	  and zfcp driver); this entails an agreement about granularities
+ *	  as well (e.g. seperate statistic for read/write/no-data commands);
+ *	  a common set of unit strings would be nice then, too, of course
+ *	  (e.g. "seconds", "milliseconds", "microseconds", ...)
+ *
+ *
+ *    another bunch of ideas being pondered:
+ *	- provide a (perl?) script for automatic reformating and processing of
+ *	  the contents of "data" files (for generating fancy tables, diagrams
+ *	  in ASCII-art, XML-output ready to be imported into the OpenOffice
+ *	  spreadsheet/diagram tool, ... you name it); a generic script that
+ *	  takes hints from "definition" files into account would basically
+ *	  suffice for all exploiters
+ *	- slim down struct statistic and move on/off/reset/started/stopped
+ *        etc. up to struct statistic_interface???
+ *	  (Is there a need to turn individual statistic on and off etc; or
+ *	  is it more handy and sufficient to allow that only for the entirety
+ *	  of all statistic attached to an interface?)
+ *	- some user-configurable that allows to release unused resources
+ *	  of stopped statistic; or release on stop / allocate on start?
+ *	- perf. opt. of array: table lookup of values, binary search for values
+ *	- another statistic disclipline based on some sort of tree, but
+ *	  similar in semantics to list discipline (for high-perf. histograms of
+ *	  discrete values)
+ *	- use list entries (visible in data file) for hits_out_of_range/
+ *	  hits_missed instead of meta data values (visible in definition file)
+ *	  on analogy to first and last entries of array discipline (<=range_min,
+ *	  >range_max)???
+ *	- allow for more than a single "view" on data at the same time by
+ *	  providing the capability to attach several (a list of) "definitions"
+ *	  to a struct statistic
+ *	  (e.g. show histogram of requests sizes and history of megabytes/sec.
+ *	  at the same time)
+ *	- group similar statitistics in classes and allow for redefinitions
+ *	  per group
+ *	  (e.g. [automagically?] group all list disciplines of request sizes
+ *	  gathered by zfcp in order to allow for a single-operation redefinition
+ *	  of range_max for all of them)
+ *	- multi-dimensional statistic (combination of two or more
+ *	  characteristics/discriminators); worth the effort??
+ *	  (e.g. a matrix of occurences for latencies of requests of
+ *	  particular sizes)
+ *	- allow exploiters to register a callback with every struct statistic
+ *	  (or statistic interface?) in order to be able to do another
+ *	  statitics update when the user reads the data file; would be useful
+ *	  for gathering statistic data about any ongoing condition
+ *	- have exploiters always provide the best granularity possible
+ *	  (like nanoseconds instead of milliseconds) in order to keep
+ *	  flexibility, and have the statitics user interface handle any
+ *	  desired computation (like from nanoseconds to milliseconds)
+ *	- allow user to choose hex/oct/dec representation of numbers
+ *	- make "history" an extra option that allows it to combine with
+ *	  any other type/discipline??? (history request size lists???)
+ *
+ *
+ *    locking rules (provided "as is" ;)
+ *	- We grab a global semaphore on calls to statistic_interface_create() /
+ *	  statistic_interface_remove() to make sure various exploiters do not
+ *	  interfere with each other by corrupting internal global data (list).
+ *	- Once an interface has been created, it is assumed that the exploiter
+ *	  serialises any other setup or closure business related to statistic
+ *	  attached to an interface. No locking by us for this purpose!
+ *	- data reading vs. data gathering vs. redefinition (incl. on/off/reset):
+ *	  We hold the interface's spinlock to make sure that statistic' meta
+ *	  data as well its data is accessible (unaccesible during redefinition),
+ *	  and coherent on reading (concurrent updates shall not interfere).
+ *	- data gathering vs. removal of statistic: It is assumed that the
+ *	  exploiter makes sure that data gathering has been turned off and
+ *	  ceased prior to removing any statistic. We cross-check on removal
+ *	  that data gatherig has been turned off.
+ *	- multiple related data updates in the scope of a single interface:
+ *	  We provide *_nolock variants of the statistic_inc() /
+ *	  statistic_add() routines, and thus allow exploiters to manage
+ *	  locking during updates. This way multiple updates can be made in
+ *	  an atomic fashion. Exploiters are encouraged to make use of this
+ *	  if an atomic update of more than one statistic is required to
+ *	  generate the next valid state as to the coherence of different
+ *	  statistic.
+ *	- touching files by user vs. removal of anything: tbd
+ */
+
+#define STATISTIC_C_REVISION "$Revision: 1.16 $"
+
+#include <linux/fs.h>
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/parser.h>
+#include <linux/time.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+
+#include <asm/bug.h>
+#include <asm/uaccess.h>
+#include <asm/semaphore.h>
+
+#include <asm/sgrb.h>
+#include <asm/statistic.h>
+
+extern void tod_to_timeval(__u64, struct timespec *);
+
+struct statistic_global_data statistic_globals;
+
+static int statistic_interface_generic_close(struct inode *inode, struct file *file);
+static ssize_t statistic_interface_generic_read(struct file *, char __user *, size_t, loff_t *);
+static ssize_t statistic_interface_generic_write(struct file *, const char __user *, size_t, loff_t *);
+
+static int statistic_interface_def_open(struct inode *, struct file *);
+static int statistic_interface_def_close(struct inode *, struct file *);
+
+static int statistic_interface_data_open(struct inode *, struct file *);
+
+struct file_operations statistic_def_file_ops = {
+	.owner		= THIS_MODULE,
+	.read		= statistic_interface_generic_read,
+	.write		= statistic_interface_generic_write,
+	.open		= statistic_interface_def_open,
+	.release	= statistic_interface_def_close,
+};
+
+struct file_operations statistic_data_file_ops = {
+	.owner		= THIS_MODULE,
+	.read		= statistic_interface_generic_read,
+	.open		= statistic_interface_data_open,
+	.release	= statistic_interface_generic_close,
+};
+
+// FIXME: get rid of statistic_strings, by merging it into statistic_def? anyone?
+static char * statistic_strings[] = {
+	"name=",
+	"units=",
+	"type=value",
+	"type=range",
+	"type=array",
+	"type=list",
+	"type=raw",
+	"type=history",
+	"on=1",
+	"on=0",
+	"started=",
+	"stopped=",
+	"range_min=",
+	"range_max=",
+	"scale=lin",
+	"scale=log2",
+	"entries_max=",
+	"base_interval=",
+	"hits_missed=",
+	"hits_out_of_range=",
+	"data=",
+	"mode=increments",
+	"mode=products",
+	"mode=range",
+	"period=",
+	NULL
+};
+
+static match_table_t statistic_def = {
+	{STATISTIC_DEF_NAME, "name=%s"},
+	{STATISTIC_DEF_UNIT, "units="},
+	{STATISTIC_DEF_TYPE_VALUE, "type=value"},
+	{STATISTIC_DEF_TYPE_RANGE, "type=range"},
+	{STATISTIC_DEF_TYPE_ARRAY, "type=array"},
+	{STATISTIC_DEF_TYPE_LIST, "type=list"},
+	{STATISTIC_DEF_TYPE_RAW, "type=raw"},
+	{STATISTIC_DEF_TYPE_HISTORY, "type=history"},
+	{STATISTIC_DEF_ON, "on=1"},
+	{STATISTIC_DEF_OFF, "on=0"},
+	{STATISTIC_DEF_STARTED, "started="},
+	{STATISTIC_DEF_STOPPED, "stopped="},
+	{STATISTIC_DEF_RANGEMIN, "range_min=%s"},
+	{STATISTIC_DEF_RANGEMAX, "range_max=%s"},
+	{STATISTIC_DEF_SCALE_LIN, "scale=lin"},
+	{STATISTIC_DEF_SCALE_LOG2, "scale=log2"},
+	{STATISTIC_DEF_ENTRIESMAX, "entries_max=%u"},
+	{STATISTIC_DEF_BASEINT, "base_interval=%s"},
+	{STATISTIC_DEF_HITSMISSED, "hits_missed="},
+	{STATISTIC_DEF_HITSOUT, "hits_out_of_range="},
+	{STATISTIC_DEF_RESET, "data=reset"},
+	{STATISTIC_DEF_MODE_INC, "mode=increments"},
+	{STATISTIC_DEF_MODE_PROD, "mode=products"},
+	{STATISTIC_DEF_MODE_RANGE, "mode=range"},
+	{STATISTIC_DEF_PERIOD, "period=%s"},
+	{STATISTIC_DEF_VOID, NULL}
+};
+
+/* code concerned with module matters */
+
+int
+__init statistic_init(void)
+{
+	sema_init(&statistic_globals.sem, 1);
+	INIT_LIST_HEAD(&statistic_globals.interface_lh);
+	statistic_globals.root_dir = debugfs_create_dir(STATISTIC_ROOT_DIR, NULL);
+	return 0;
+}
+
+void
+__exit statistic_exit(void)
+{
+	// FIXME: any need to cleanup any statistic possibly still allocated?
+	debugfs_remove(statistic_globals.root_dir);
+}
+
+/* basic helper routines for time handling */
+
+static inline void
+statistic_nsec_to_timespec(u64 nsec, struct timespec *xtime)
+{
+	unsigned long long sec;
+
+        sec = nsec;
+        do_div(sec, 1000000000);
+        xtime->tv_sec = sec;
+        xtime->tv_nsec = nsec - sec * 1000000000;
+}
+
+static inline u64
+statistic_timespec_to_nsec(struct timespec *xtime)
+{
+	return (xtime->tv_sec * 1000000000 + xtime->tv_nsec);
+}
+
+static inline void
+statistic_tod_to_timespec(u64 tod, struct timespec *xtime)
+{
+	tod -= 0x8126d60e46000000LL - (0x3c26700LL * 1000000 * 4096);
+	tod_to_timeval(tod, xtime);
+}
+
+static inline u64
+statistic_tod_to_nsec(u64 tod)
+{
+	struct timespec xtime;
+
+	statistic_tod_to_timespec(tod, &xtime);
+	return statistic_timespec_to_nsec(&xtime);
+}
+
+static inline u64
+statistic_get_clock_nsec(void)
+{
+	return statistic_tod_to_nsec(get_clock());
+}
+
+static inline char *
+statistic_timespec_to_string(struct timespec *xtime, char *s)
+{
+	sprintf(s, "%011lu:%06lu", xtime->tv_sec, xtime->tv_nsec / 1000);
+	return s;
+}
+
+static inline char *
+statistic_tod_to_string(u64 tod, char *s)
+{
+	struct timespec xtime;
+
+	statistic_tod_to_timespec(tod, &xtime);
+	return statistic_timespec_to_string(&xtime, s);
+}
+
+static inline char *
+statistic_nsec_to_string(u64 nsec, char *s)
+{
+	struct timespec xtime;
+
+	statistic_nsec_to_timespec(nsec, &xtime);
+	return statistic_timespec_to_string(&xtime, s);
+}
+
+/* code mostly concerned with accounting */
+
+static inline void
+statistic_release(struct statistic *stat)
+{
+	if (stat->release)
+		stat->release(stat);
+	stat->reset = 0;
+}
+
+static inline int
+statistic_alloc(struct statistic *stat)
+{
+	int retval = 0;
+
+	if (stat->alloc)
+		retval = stat->alloc(stat);
+
+	if (retval)
+		statistic_release(stat);
+	else
+		stat->reset = get_clock();
+
+	return retval;
+}
+
+static inline int
+statistic_start_nolock(struct statistic *stat)
+{
+	int retval = stat->on;
+
+	stat->on = STATISTIC_DEF_ON;
+	stat->started = get_clock();
+
+	return retval;
+}
+
+/**
+ * statistic_start - enable statistic for data gathering
+ * @stat: statistic to be enabled
+ *
+ * Start data gathering without discarding old data.
+ * Function is both available to exploiting device drivers as well as to
+ * the user through the "definition" file.
+ *
+ * On success, returns the previous on/off state.
+ **/
+int
+statistic_start(struct statistic *stat)
+{
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&stat->interface->lock, flags);
+	retval = statistic_start_nolock(stat);
+	spin_unlock_irqrestore(&stat->interface->lock, flags);
+
+	return retval;
+}
+
+static inline int
+statistic_stop_nolock(struct statistic *stat)
+{
+	int retval = stat->on;
+
+	stat->on = STATISTIC_DEF_OFF;
+	stat->stopped = get_clock();
+
+	return retval;
+}
+
+/**
+ * statistic_stop - disable statistic for data gathering
+ * @stat: statistic to be disabled
+ *
+ * Stop data gathering without discarding old data.
+ * Function is both available to exploiting device drivers as well as to
+ * the user through the "definition" file.
+ *
+ * On success, returns the previous on/off state.
+ **/
+int
+statistic_stop(struct statistic *stat)
+{
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&stat->interface->lock, flags);
+	retval = statistic_stop_nolock(stat);
+	spin_unlock_irqrestore(&stat->interface->lock, flags);
+
+	return retval;
+}
+
+static inline int
+statistic_reset_nolock(struct statistic *stat)
+{
+	statistic_release(stat);
+	return statistic_alloc(stat);
+}
+
+/**
+ * statistic_reset - reset statistic as to data gathered so far
+ * @stat: statistic to be disabled
+ *
+ * Discard any gathered data without changing the on/off state.
+ * Function is both available to exploiting device drivers as well as to
+ * the user through the "definition" file.
+ *
+ * On success, returns the previous on/off state.
+ *
+ * If some required memory could not be (re-)allocated this routine fails,
+ * and -ENOMEM is returned.
+ **/
+int
+statistic_reset(struct statistic *stat)
+{
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&stat->interface->lock, flags);
+	retval = statistic_reset_nolock(stat);
+	spin_unlock_irqrestore(&stat->interface->lock, flags);
+
+	return retval;
+}
+
+/**
+ * statistic_create - create a statistic and attach it to a given interface
+ * @stat_ptr: reference to struct statistic pointer
+ * @interface_ptr: reference to struct statistic_interface pointer
+ * @name: name of statistic to be created and as seen in "data" and
+ *        "definition" files
+ *
+ * Create a statistic, which - after being defined and enabled - is ready
+ * to capture and compute data provided by the exploiter. A line in the
+ * interface's "definition" file will hold specifics about the named statistic.
+ *
+ * On success, 0 is returned, the struct statistic pointer
+ * provided by the caller points to a newly alloacted struct,
+ * and the statistic is defined as type "value" by default.
+ *
+ * If the struct statistic pointer provided by the caller
+ * is not NULL (used), this routine fails, the struct statistic
+ * pointer is not changed, and -EINVAL is returned.
+ *
+ * If some required memory could not be allocated this routine fails,
+ * the struct statistic pointer is not changed, and -ENOMEM is returned.
+ **/
+int
+statistic_create(
+	struct statistic **stat_ptr,
+	struct statistic_interface *interface,
+	const char *name,
+	const char *units)
+{
+	struct statistic *stat;
+
+	if (*stat_ptr || !interface)
+		return -EINVAL;
+
+	stat = kmalloc(sizeof(struct statistic), GFP_KERNEL);
+	if (!stat)
+		return -ENOMEM;
+	memset(stat, 0, sizeof(struct statistic));
+
+	stat->interface = interface;
+	strlcpy(stat->name, name, sizeof(stat->name));
+	strlcpy(stat->units, units, sizeof(stat->units));
+	statistic_define_value(stat, STATISTIC_RANGE_MIN, STATISTIC_RANGE_MAX,
+				STATISTIC_DEF_MODE_INC);
+	statistic_stop_nolock(stat);
+	stat->started = stat->stopped;
+	stat->stat_ptr = stat_ptr;
+
+	list_add_tail(&stat->list, &interface->statistic_lh);
+
+	*stat_ptr = stat;
+
+	return 0;
+}
+
+/**
+ * statistic_remove - remove given statistic
+ * @stat_ptr: reference to struct statistic_interface pointer
+ *
+ * Remove statistic along with its recent data an definition.
+ *
+ * On success, 0 is returned and the struct statistic pointer
+ * provided by the caller is set to NULL.
+ *
+ * If the struct statistic pointer provided by the caller
+ * is NULL (unused), this routine fails, the struct statistic
+ * pointer is not changed, and -EINVAL is returned.
+ **/
+int
+statistic_remove(struct statistic **stat_ptr)
+{
+	if (!*stat_ptr)
+		return -EINVAL;
+
+	statistic_release(*stat_ptr);
+	list_del(&(*stat_ptr)->list);
+	kfree(*stat_ptr);
+	*stat_ptr = NULL;
+
+	return 0;
+}
+
+static int
+statistic_format_def(struct statistic *stat, struct statistic_file_private *private)
+{
+	struct sgrb_seg *seg;
+	char t0[22], t1[22], t2[22];
+
+	seg = sgrb_seg_find(&private->read_seg_lh, 1024, GFP_ATOMIC);
+	if (!seg)
+		return -ENOMEM;
+
+	seg->offset += sprintf(seg->address + seg->offset,
+				"%s%s %s %s %s%lld %s%lld",
+				statistic_strings[STATISTIC_DEF_NAME],
+				stat->name,
+				statistic_strings[stat->on],
+				statistic_strings[stat->type],
+				statistic_strings[STATISTIC_DEF_RANGEMIN],
+				(long long signed)stat->range_min,
+				statistic_strings[STATISTIC_DEF_RANGEMAX],
+				(long long signed)stat->range_max);
+
+	if (stat->format_def)
+		seg->offset += stat->format_def(stat,
+						seg->address + seg->offset);
+
+	seg->offset += sprintf(seg->address + seg->offset,
+				" %s%llu %s%s %s%s %s%s %s%s\n\n",
+				statistic_strings[STATISTIC_DEF_HITSOUT],
+				(long long unsigned)stat->hits_out_of_range,
+				statistic_strings[STATISTIC_DEF_RESET],
+				(stat->reset ?
+				 statistic_tod_to_string(stat->reset, t0) :
+				 "NOMEM"),
+				statistic_strings[STATISTIC_DEF_STARTED],
+				statistic_tod_to_string(stat->started, t1),
+				statistic_strings[STATISTIC_DEF_STOPPED],
+				statistic_tod_to_string(stat->stopped, t2),
+				statistic_strings[STATISTIC_DEF_UNIT],
+				stat->units);
+
+	return 0;
+}
+
+/* code concerned with single value statistic */
+
+static int
+statistic_alloc_value(struct statistic *stat)
+{
+	stat->data.value.hits = 0;
+	return 0;
+}
+
+static inline void
+_statistic_format_data_value(
+	struct statistic *stat, struct sgrb_seg *seg, char *s,
+	u64 value)
+{
+	seg->offset += sprintf(seg->address + seg->offset, "%s%s %llu\n",
+				stat->name, s,
+				(unsigned long long)stat->data.value.hits);
+}
+
+static int
+statistic_format_data_value(
+	struct statistic *stat, struct statistic_file_private *private)
+{
+	struct sgrb_seg *seg;
+
+	seg = sgrb_seg_find(&private->read_seg_lh, 128, GFP_ATOMIC);
+	if (!seg)
+		return -ENOMEM;
+
+	_statistic_format_data_value(stat, seg, "", stat->data.value.hits);
+	return 0;
+}
+
+static int
+statistic_format_def_value(struct statistic *stat, char *line)
+{
+	return sprintf(line, " %s", statistic_strings[stat->data.value.mode]);
+}
+
+static inline u64
+_statistic_add_value_increments(s64 *single, s64 value, u64 incr)
+{
+	return (*single += incr);
+}
+
+static inline u64
+_statistic_add_value_products(s64 *single, s64 value, u64 incr)
+{
+	if (value < 0)
+		value = -value;
+	return (*single += value * incr);
+}
+
+static u64
+statistic_add_value_increments(struct statistic *stat, s64 value, u64 incr)
+{
+	if (value < stat->range_min || value > stat->range_max) {
+		stat->hits_out_of_range++;
+		return 0;
+	}
+	return _statistic_add_value_increments(
+			&stat->data.value.hits, value, incr);
+}
+
+static u64
+statistic_add_value_products(struct statistic *stat, s64 value, u64 incr)
+{
+	if (value < stat->range_min || value > stat->range_max) {
+		stat->hits_out_of_range++;
+		return 0;
+	}
+	return _statistic_add_value_products(
+			&stat->data.value.hits, value, incr);
+}
+
+/**
+ * statistic_define_value - instantiate statistic as single value (counter)
+ * @stat: statistic to be defined
+ * @range_min: lower bound of discriminators
+ * @range_max: upper bound of discriminators
+ * @mode: accumulate increments only, or products of discriminator and increment
+ *
+ * Determines that the statistic accumulates all increments - regardless of the
+ * value of the discriminator - into a single value. It can be seen as a
+ * histogram collapsed into a single counter providing the total of all
+ * increments.
+ *
+ * Depending on the definition, accumulation is done as
+ *
+ * a) <total> += <increment N>				(mode=increments)
+ * b) <total> += ABS(<discriminator N>) * <increment N>	(mode=products)
+ *
+ * The output format of a single value statistic found in the "data" file is:
+ * <statistic name> <total>
+ *
+ * This (re)definition function is available both to exploiting device drivers
+ * and to the user through the "definition" file. Device driver programmers
+ * might find it user-friendly to provide a default definition for
+ * particular statistic by calling this or a related function. A previous
+ * definition is replaced by the new one. Next, the statistic must be enabled
+ * in order to make it gather data. A line in the interface's "definition"
+ * file will hold specifics about the named statistic.
+ *
+ * On success, 0 is returned.
+ *
+ * If some required memory could not be allocated this routine fails,
+ * and -ENOMEM is returned.
+ **/
+int statistic_define_value(
+	struct statistic *stat, s64 range_min, s64 range_max, int mode)
+{
+	unsigned long flags;
+	int retval;
+
+	if (mode != STATISTIC_DEF_MODE_INC &&
+	    mode != STATISTIC_DEF_MODE_PROD)
+		return -EINVAL;
+
+	spin_lock_irqsave(&stat->interface->lock, flags);
+
+	statistic_release(stat);
+
+	stat->type = STATISTIC_DEF_TYPE_VALUE;
+	stat->range_min = range_min;
+	stat->range_max = range_max;
+	stat->data.value.mode = mode;
+
+	stat->alloc = statistic_alloc_value;
+	stat->release = NULL;
+	stat->format_data = statistic_format_data_value;
+	stat->format_def = statistic_format_def_value;
+	if (mode == STATISTIC_DEF_MODE_INC)
+		stat->add = statistic_add_value_increments;
+	else
+		stat->add = statistic_add_value_products;
+
+	retval = statistic_alloc(stat);
+
+	spin_unlock_irqrestore(&stat->interface->lock, flags);
+
+	return retval;
+}
+
+/* code concerned with range statistic */
+
+static inline void
+_statistic_alloc_range(
+	struct statistic_entry_range *range, s64 range_min, s64 range_max)
+{
+	range->num = 0;
+	range->acc = 0;
+	range->min = range_max + 1;
+	range->max = range_min - 1;
+}
+
+static int
+statistic_alloc_range(struct statistic *stat)
+{
+	_statistic_alloc_range(
+		&stat->data.range.range, stat->range_min, stat->range_max);
+	return 0;
+}
+
+static inline void
+_statistic_format_data_range(
+	struct statistic *stat, struct sgrb_seg *seg, char *s,
+	struct statistic_entry_range *range)
+{
+	long long unsigned whole = 0;
+	long long signed min = 0, max = 0, decimal = 0, last_digit;
+
+	if (range->num) {
+		whole = range->acc;
+		do_div(whole, range->num);
+		decimal  = range->acc * 10000;
+		do_div(decimal, range->num);
+		decimal -= whole * 10000;
+		if (decimal < 0)
+			decimal = -decimal;
+		last_digit = decimal;
+		do_div(last_digit, 10);
+		last_digit = decimal - last_digit * 10;
+		if (last_digit >= 5)
+			decimal += 10;
+		do_div(decimal, 10);
+		min = range->min;
+		max = range->max;
+	}
+
+	seg->offset += sprintf(seg->address + seg->offset,
+				"%s%s %llu %lld %lld.%03lld %lld\n",
+				stat->name, s,
+				(long long unsigned)range->num,
+				(long long signed)min,
+				whole, decimal,
+				(long long signed)max);
+}
+
+static int
+statistic_format_data_range(
+	struct statistic *stat, struct statistic_file_private *private)
+{
+	struct sgrb_seg *seg;
+
+	seg = sgrb_seg_find(&private->read_seg_lh, 128, GFP_ATOMIC);
+	if (!seg)
+		return -ENOMEM;
+
+	_statistic_format_data_range(
+		stat, seg, "", &stat->data.range.range);
+	return 0;
+}
+
+static inline u64
+_statistic_add_range(struct statistic_entry_range *range, s64 value, u64 incr)
+{
+	range->num += incr;
+	range->acc += value * incr;
+	if (value < range->min)
+		range->min = value;
+	if (value > range->max)
+		range->max = value;
+	return range->num;
+}
+
+static u64
+statistic_add_range(struct statistic *stat, s64 value, u64 incr)
+{
+	if (value < stat->range_min || value > stat->range_max) {
+		stat->hits_out_of_range++;
+		return 0;
+	}
+	return _statistic_add_range(&stat->data.range.range, value, incr);
+}
+
+/**
+ * statistic_define_range - instantiate statistic as small set of values
+ *    that describe a range
+ * @stat: statistic to be defined
+ * @range_min: lower bound of discriminators
+ * @range_max: upper bound of discriminators
+ *
+ * Determines that the statistic provides the minimum, average and maximum
+ * of the numbers reported by the exploiter. Besides the number of updates
+ * is counted. Statistics events with increments larger than 1 are counted
+ * as multiple occurences of a particular discrimintator with regard to
+ * the computation of average.
+ * For example, this statistic type could be used as a fill level or
+ * utilisation indicator for queues.
+ *
+ * The output format of a range statistic found in the "data" file is:
+ * <statistic name> <total of increments> <minimum> <average> <maximum>
+ *
+ * This (re)definition function is available both to exploiting device drivers
+ * and to the user through the "definition" file. Device driver programmers
+ * might find it user-friendly to provide a default definition for
+ * particular statistic by calling this or a related function. A previous
+ * definition is replaced by the new one. Next, the statistic must be enabled
+ * in order to make it gather data. A line in the interface's "definition"
+ * file will hold specifics about the named statistic.
+ *
+ * On success, 0 is returned.
+ *
+ * If some required memory could not be allocated this routine fails,
+ * and -ENOMEM is returned.
+ **/
+int statistic_define_range(
+	struct statistic *stat, s64 range_min, s64 range_max)
+{
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&stat->interface->lock, flags);
+
+	statistic_release(stat);
+
+	stat->type = STATISTIC_DEF_TYPE_RANGE;
+	stat->range_min = range_min;
+	stat->range_max = range_max;
+
+	stat->alloc = statistic_alloc_range;
+	stat->release = NULL;
+	stat->format_data = statistic_format_data_range;
+	stat->format_def = NULL;
+	stat->add = statistic_add_range;
+
+	retval = statistic_alloc(stat);
+
+	spin_unlock_irqrestore(&stat->interface->lock, flags);
+
+	return retval;
+}
+
+/* code concerned with fixed array statistic */
+
+static inline s64
+statistic_array_calc_value_lin(struct statistic *stat, int index)
+{
+	return stat->range_min + (stat->data.array.base_interval * index);
+}
+
+static inline s64
+statistic_array_calc_value_log2(struct statistic *stat, int index)
+{
+	return stat->range_min +
+		(index ? (stat->data.array.base_interval << (index - 1)) : 0);
+}
+
+static inline s64
+statistic_array_calc_value(struct statistic *stat, int index)
+{
+	if (stat->data.array.scale == STATISTIC_DEF_SCALE_LIN)
+		return statistic_array_calc_value_lin(stat, index);
+	else
+		return statistic_array_calc_value_log2(stat, index);
+}
+
+static inline int
+statistic_array_calc_index_lin(struct statistic *stat, s64 value)
+{
+	unsigned long long index = value - stat->range_min;
+	do_div(index, stat->data.array.base_interval);
+	return index;
+}
+
+static inline int
+statistic_array_calc_index_log2(struct statistic *stat, s64 value)
+{
+	unsigned long long index;
+
+	for (index = 0;
+	     index < (stat->data.array.entries - 1) &&
+	     value > statistic_array_calc_value_log2(stat, index);
+	     index++);
+	return index;
+}
+
+static inline int
+statistic_array_calc_index(struct statistic *stat, s64 value)
+{
+	if (stat->data.array.scale == STATISTIC_DEF_SCALE_LIN)
+		return statistic_array_calc_index_lin(stat, value);
+	else
+		return statistic_array_calc_index_log2(stat, value);
+}
+
+static int
+statistic_alloc_array(struct statistic *stat)
+{
+	int i, size;
+
+	for (i = 0;
+	     statistic_array_calc_value(stat, i) <= stat->range_max;
+	     i++);
+	i++;
+	if (i < 2)
+		return -EINVAL;
+	stat->data.array.entries = i;
+
+	size = stat->data.array.entries * sizeof(u64);
+	stat->data.array.hits = kmalloc(size, GFP_ATOMIC);
+	if (!stat->data.array.hits)
+		return -ENOMEM;
+	memset(stat->data.array.hits, 0, size);
+	return 0;
+}
+
+static void
+statistic_release_array(struct statistic *stat)
+{
+	kfree(stat->data.array.hits);
+	stat->data.array.hits = NULL;
+}
+
+static inline int
+statistic_format_data_array_line(
+	struct statistic *stat, struct statistic_file_private *private,
+	int i, const char *prefix, u64 value)
+{
+	struct sgrb_seg *seg;
+
+	seg = sgrb_seg_find(&private->read_seg_lh, 256, GFP_ATOMIC);
+	if (!seg)
+		return -ENOMEM;
+
+	seg->offset += sprintf(seg->address + seg->offset,
+				"%s %s%lld %llu\n", stat->name,
+				prefix, (long long signed)value,
+				(long long unsigned)stat->data.array.hits[i]);
+	return 0;
+}
+
+static int
+statistic_format_data_array(
+	struct statistic *stat, struct statistic_file_private *private)
+{
+	int i;
+	int retval;
+
+	for (i = 0; i < (stat->data.array.entries - 1); i++) {
+		retval = statistic_format_data_array_line(
+				stat, private, i, "<=",
+				statistic_array_calc_value(stat, i));
+		if (retval)
+			return retval;
+	}
+	retval = statistic_format_data_array_line(
+			stat, private, i, ">",
+			statistic_array_calc_value(stat, i - 1));
+	return retval;
+}
+
+static int
+statistic_format_def_array(struct statistic *stat, char *line)
+{
+	return  sprintf(line,
+			" %s%llu %s",
+			statistic_strings[STATISTIC_DEF_BASEINT],
+			(long long unsigned)stat->data.array.base_interval,
+			statistic_strings[stat->data.array.scale]);
+}
+
+static u64
+statistic_add_array_lin(struct statistic *stat, s64 value, u64 incr)
+{
+	int index = statistic_array_calc_index_lin(stat, value);
+	return (stat->data.array.hits[index] += incr);
+}
+
+static u64
+statistic_add_array_log2(struct statistic *stat, s64 value, u64 incr)
+{
+	int index = statistic_array_calc_index_log2(stat, value);
+	return (stat->data.array.hits[index] += incr);
+}
+
+/**
+ * statistic_define_array - instantiate statistic as fixed size array of
+ *    discriminator/counter pairs (histogram for intervals)
+ * @stat: statistic to be defined
+ * @range_min: lower bound of discriminators
+ * @range_max: upper bound of discriminators
+ * @base_interval: width of intervals between two discriminators (linear scale);
+ *         starting width of intervals (logarithmic scale, base 2)
+ * @scale: scale applied to discriminators (linear/logarithmic)
+ *
+ * Determines that the statistic maintains a counter for each interval
+ * as determined by the above parameters. These counters hold the total
+ * of the increments applicable to particular intervals. The first interval
+ * is determined by (<the smallest s64 value>, range_min). The last interval
+ * is (range_max, <the largest s64 value>). That means, this statistic
+ * discpline is capable of giving account of hits out of the specified range.
+ * Basically, the function implemented by this statistic discipline is a
+ * histogram for intervals.
+ *
+ * The output format of a fixed-size array statistic found in the "data" file
+ * is:
+ *
+ * <statistic name> "<="<discriminator 0> <total of increments for interval
+ *                                          (smallest s64, discriminator 0)>
+ * <statistic name> "<="<discriminator 1> <total of increments for interval
+ *                                          (discriminator 0, discriminator 1)>
+ * ...
+ * <statistic name> "<="<discriminator N> <total of increments for interval
+ *                                          (discrminator N-1, discrminator N)>
+ * <statistic name> ">"<discriminator N> <total of increments for interval
+ *                                         (discrminator N, largest s64)>
+ *
+ * This (re)definition function is available both to exploiting device drivers
+ * and to the user through the "definition" file. Device driver programmers
+ * might find it user-friendly to provide a default definition for
+ * particular statistic by calling this or a related function. A previous
+ * definition is replaced by the new one. Next, the statistic must be enabled
+ * in order to make it gather data. A line in the interface's "definition"
+ * file will hold specifics about the named statistic.
+ *
+ * On success, 0 is returned.
+ *
+ * If some required memory could not be allocated this routine fails,
+ * and -ENOMEM is returned.
+ **/
+int statistic_define_array(
+	struct statistic *stat, s64 range_min, s64 range_max,
+	u32 base_interval, u8 scale)
+{
+	unsigned long flags;
+	int retval;
+
+	if (stat->range_min > stat->range_max)
+		return -EINVAL;
+
+	if (scale != STATISTIC_DEF_SCALE_LIN &&
+	    scale != STATISTIC_DEF_SCALE_LOG2)
+		return -EINVAL;
+
+	spin_lock_irqsave(&stat->interface->lock, flags);
+
+	statistic_release(stat);
+
+	stat->type = STATISTIC_DEF_TYPE_ARRAY;
+
+	stat->range_min = range_min;
+	stat->range_max = range_max;
+	stat->data.array.base_interval = base_interval;
+	stat->data.array.scale = scale;
+
+	stat->alloc = statistic_alloc_array;
+	stat->release = statistic_release_array;
+	stat->format_data = statistic_format_data_array;
+	stat->format_def = statistic_format_def_array;
+	if (scale == STATISTIC_DEF_SCALE_LIN)
+		stat->add = statistic_add_array_lin;
+	else
+		stat->add = statistic_add_array_log2;
+
+	retval = statistic_alloc(stat);
+
+	spin_unlock_irqrestore(&stat->interface->lock, flags);
+
+	return retval;
+}
+
+/* code concerned with adaptable list statistic */
+
+static int
+statistic_alloc_list(struct statistic *stat)
+{
+	INIT_LIST_HEAD(&stat->data.list.entry_lh);
+	stat->data.list.hits_missed = 0;
+	stat->data.list.entries = 0;
+	return 0;
+}
+
+static void
+statistic_release_list(struct statistic *stat)
+{
+	struct statistic_entry_list *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &stat->data.list.entry_lh, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+}
+
+static int
+statistic_format_data_list(
+		struct statistic *stat, struct statistic_file_private *private)
+{
+	struct sgrb_seg *seg;
+	struct statistic_entry_list *entry;
+
+	list_for_each_entry(entry, &stat->data.list.entry_lh, list) {
+		seg = sgrb_seg_find(&private->read_seg_lh, 256, GFP_ATOMIC);
+		if (!seg)
+			return -ENOMEM;
+		seg->offset += sprintf(seg->address + seg->offset,
+					"%s 0x%llx %llu\n",
+					stat->name,
+					(long long signed)entry->value,
+					(long long unsigned)entry->hits);
+	}
+	return 0;
+}
+
+static int
+statistic_format_def_list(struct statistic *stat, char *line)
+{
+	return sprintf(line,
+			" %s%u %s%llu",
+			statistic_strings[STATISTIC_DEF_ENTRIESMAX],
+			stat->data.list.entries_max,
+			statistic_strings[STATISTIC_DEF_HITSMISSED],
+			(long long unsigned)stat->data.list.hits_missed);
+}
+
+static inline void
+statistic_add_list_sort(
+		struct list_head *head,
+		struct statistic_entry_list *entry)
+{
+	struct statistic_entry_list *sort =
+		list_prepare_entry(entry, head, list);
+
+	list_for_each_entry_continue_reverse(sort, head, list)
+		if (sort->hits >= entry->hits)
+			break;
+	if (sort->list.next != &entry->list &&
+	    (&sort->list == head || sort->hits >= entry->hits))
+		list_move(&entry->list, &sort->list);
+}
+
+static inline int
+statistic_add_list_new(
+		struct statistic *stat,
+		s64 value,
+		u64 incr)
+{
+	struct statistic_entry_list *entry;
+
+	if (stat->data.list.entries == stat->data.list.entries_max)
+		return -ENOMEM;
+
+	entry = kmalloc(sizeof(struct statistic_entry_list), GFP_ATOMIC);
+	if (entry) {
+		entry->value = value;
+		entry->hits = incr;
+		stat->data.list.entries++;
+		list_add_tail(&entry->list, &stat->data.list.entry_lh);
+		return 0;
+	} else	return -ENOMEM;
+}
+
+static u64
+statistic_add_list(struct statistic *stat, s64 value, u64 incr)
+{
+	struct statistic_entry_list *entry;
+	struct list_head *head = &stat->data.list.entry_lh;
+
+	if (value < stat->range_min || value > stat->range_max) {
+		stat->hits_out_of_range++;
+		return 0;
+	}
+
+	list_for_each_entry(entry, head, list) {
+		if (entry->value == value) {
+			entry->hits += incr;
+			statistic_add_list_sort(head, entry);
+			return entry->hits;
+		}
+	}
+	if (statistic_add_list_new(stat, value, incr)) {
+		stat->data.list.hits_missed++;
+		return 0;
+	} else
+		return incr;
+}
+
+/**
+ * statistic_define_list - instantiate statistic as adaptable size list of
+ *    discriminator/counter pairs (histogram for discrete values)
+ * @stat: statistic to be defined
+ * @range_min: lower bound of discriminators
+ * @range_max: upper bound of discriminators
+ * @entries_max: limits the list size
+ *
+ * Determines that the statistic maintains a counter for each discrete
+ * discriminator that is reported along with increments by the exploiter.
+ * These counters hold the total of the increments applicable to particular
+ * discrminators. Hits that were out of the specified range, or that would have
+ * required list entries beyond the specified maximum, are discarded and their
+ * numbers are visible through the "definition" file.
+ * Basically, the function implemented by this statistic discipline is a
+ * histogram for discrete values. Which values make it into the histogram is
+ * determined by their order of appearance (first come, ...).
+ *
+ * The output format of an adaptable-size list statistic found in the "data"
+ * file is:
+ *
+ * <statistic name> <discriminator 0> <total of increments for discriminator 0>
+ * <statistic name> <discriminator 1> <total of increments for discriminator 1>
+ * ...
+ * <statistic name> <discriminator N> <total of increments for discriminator N>
+ *
+ * This (re)definition function is available both to exploiting device drivers
+ * and to the user through the "definition" file. Device driver programmers
+ * might find it user-friendly to provide a default definition for
+ * particular statistic by calling this or a related function. A previous
+ * definition is replaced by the new one. Next, the statistic must be enabled
+ * in order to make it gather data. A line in the interface's "definition"
+ * file will hold specifics about the named statistic.
+ *
+ * On success, 0 is returned.
+ *
+ * If some required memory could not be allocated this routine fails,
+ * and -ENOMEM is returned.
+ **/
+int
+statistic_define_list(
+	struct statistic *stat, s64 range_min, s64 range_max, u32 entries_max)
+{
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&stat->interface->lock, flags);
+
+	statistic_release(stat);
+
+	stat->type = STATISTIC_DEF_TYPE_LIST;
+
+	stat->range_min = range_min;
+	stat->range_max = range_max;
+	stat->data.list.entries_max = entries_max;
+
+	stat->alloc = statistic_alloc_list;
+	stat->release = statistic_release_list;
+	stat->format_data = statistic_format_data_list;
+	stat->format_def = statistic_format_def_list;
+	stat->add = statistic_add_list;
+
+	retval = statistic_alloc(stat);
+
+	spin_unlock_irqrestore(&stat->interface->lock, flags);
+
+	return retval;
+}
+
+/* code concerned with raw, timestamped statistic events */
+
+static int
+statistic_alloc_raw(struct statistic *stat)
+{
+	stat->data.raw.next_serial = 0;
+	return sgrb_alloc(
+			&stat->data.raw.rb,
+			sizeof(struct statistic_entry_raw),
+			stat->data.raw.entries_max, PAGE_SIZE, GFP_ATOMIC);
+}
+
+static void
+statistic_release_raw(struct statistic *stat)
+{
+	sgrb_release(&stat->data.raw.rb);
+}
+
+static int
+statistic_format_data_raw(
+	struct statistic *stat, struct statistic_file_private *private)
+{
+	struct sgrb_seg *seg;
+	struct sgrb_ptr ptr;
+	struct statistic_entry_raw *entry;
+	char t[22];
+
+	sgrb_ptr_copy(&ptr, &stat->data.raw.rb.first);
+	while ((entry = sgrb_consume_nodelete(&stat->data.raw.rb, &ptr))) {
+		seg = sgrb_seg_find(&private->read_seg_lh, 256, GFP_ATOMIC);
+		if (!seg)
+			return -ENOMEM;
+		seg->offset += sprintf(seg->address + seg->offset,
+					"%s %s %llu %lld %llu\n",
+					stat->name,
+					statistic_tod_to_string
+						(entry->clock, t),
+					(long long unsigned)entry->serial,
+					(long long signed)entry->value,
+					(long long unsigned)entry->incr);
+	}
+	return 0;
+}
+
+static int
+statistic_format_def_raw(struct statistic *stat, char *line)
+{
+	return sprintf(line,
+			" %s%u",
+			statistic_strings[STATISTIC_DEF_ENTRIESMAX],
+			stat->data.raw.entries_max);
+}
+
+static u64
+statistic_add_raw(struct statistic *stat, s64 value, u64 incr)
+{
+	struct statistic_entry_raw *entry;
+
+	if (value < stat->range_min || value > stat->range_max) {
+		stat->hits_out_of_range++;
+		return 0;
+	}
+
+	entry = sgrb_produce_overwrite(&stat->data.raw.rb);
+
+	entry->clock = get_clock();
+	entry->serial = stat->data.raw.next_serial++;
+	entry->value = value;
+	entry->incr = incr;
+
+	return incr;
+}
+
+/**
+ * statistic_define_raw - instantiate statistic as a record of incremental
+ *    updates as they have happened (history of statistic events)
+ * @stat: statistic to be defined
+ * @range_min: lower bound of discriminators
+ * @range_max: upper bound of discriminators
+ * @entries_max: maximum number of entries in ringbuffer
+ *
+ * Determines that the statistic does not maintain counters for any increments,
+ * but that it accumulates the reported updates in the form of a history of
+ * these updates. Updates out of the specified range are dropped, though their
+ * total number is readable through the "definition" file. Besides, once the
+ * allocated pages are completely occupied, new entries are written over the
+ * oldest ones (ringbuffer). Each entry is tagged with a unique serial number
+ * and a timestamp. A single entry consumes 32 bytes.
+ *
+ * The output format of a "raw" statistic found in the "data" file is:
+ *
+ * <statistic name> <discriminator> <increments> <serial> <timestamp>
+ *
+ * This (re)definition function is available both to exploiting device drivers
+ * and to the user through the "definition" file. Device driver programmers
+ * might find it user-friendly to provide a default definition for
+ * particular statistic by calling this or a related function. A previous
+ * definition is replaced by the new one. Next, the statistic must be enabled
+ * in order to make it gather data. A line in the interface's "definition"
+ * file will hold specifics about the named statistic.
+ *
+ * On success, 0 is returned.
+ *
+ * If some required memory could not be allocated this routine fails,
+ * and -ENOMEM is returned.
+ **/
+int statistic_define_raw(
+	struct statistic *stat, s64 range_min, s64 range_max, u32 entries_max)
+{
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&stat->interface->lock, flags);
+
+	statistic_release(stat);
+
+	stat->type = STATISTIC_DEF_TYPE_RAW;
+
+	stat->range_min = range_min;
+	stat->range_max = range_max;
+	stat->data.raw.entries_max = entries_max;
+
+	stat->alloc = statistic_alloc_raw;
+	stat->release = statistic_release_raw;
+	stat->format_data = statistic_format_data_raw;
+	stat->format_def = statistic_format_def_raw;
+	stat->add = statistic_add_raw;
+
+	retval = statistic_alloc(stat);
+
+	spin_unlock_irqrestore(&stat->interface->lock, flags);
+
+	return retval;
+}
+
+/* code concerned with history statistic */
+
+static int
+statistic_alloc_history(struct statistic *stat)
+{
+	int entry_size = (STATISTIC_DEF_MODE_RANGE ?
+				sizeof(struct statistic_entry_range) :
+				sizeof(s64)) ;
+	int retval = sgrb_alloc(&stat->data.history.rb, entry_size,
+				stat->data.history.entries_max,
+				PAGE_SIZE, GFP_ATOMIC);
+	if (retval)
+		return retval;
+
+	stat->data.history.checkpoint = statistic_get_clock_nsec();
+
+	return 0;
+}
+
+static void
+statistic_release_history(struct statistic *stat)
+{
+	sgrb_release(&stat->data.history.rb);
+}
+
+static inline void *
+statistic_add_history_entry(struct statistic *stat)
+{
+	u64 now, then, window, period, checkp, elapsed;
+	void *entry = NULL;
+
+	window = stat->data.history.window;
+	period = stat->data.history.period;
+	checkp = stat->data.history.checkpoint;
+
+	now = statistic_get_clock_nsec();
+	if (now <= checkp)
+		entry = sgrb_entry(&stat->data.history.rb.last);
+	else	{
+		then = checkp;
+		elapsed = now - then;
+		/*
+		 * FIXME: replace loops by formula for supposedly
+		 * improved performance
+		 *  - would require something like do_div64_64()
+		 */
+#if 0
+		if (elapsed > window)
+			then = (now - window) + (period - elapsed % period);
+#endif
+
+		if (elapsed > window) {
+			for (; then < now - 2 * window; then += window);
+			for (; then < now - window; then += period);
+		}
+		for (; then < now; then += period) {
+			entry = sgrb_produce_overwrite(&stat->data.history.rb);
+			memset(entry, 0, stat->data.history.rb.entry_size);
+		}
+		if (stat->data.history.mode == STATISTIC_DEF_MODE_RANGE)
+			_statistic_alloc_range(
+				(struct statistic_entry_range *)entry,
+				stat->range_min,
+				stat->range_max);
+		stat->data.history.checkpoint = then;
+	}
+	return entry;
+}
+
+static inline int
+statistic_format_data_history(
+	struct statistic *stat, struct statistic_file_private *private)
+{
+	struct sgrb_seg *seg;
+	struct sgrb_ptr ptr;
+	void *entry;
+	u64 time;
+	char t[23];
+
+	/* enforce update in case of inactivity */
+	statistic_add_history_entry(stat);
+	time = stat->data.history.checkpoint -
+	       stat->data.history.period *
+			(stat->data.history.rb.entries - 1);
+	sgrb_ptr_copy(&ptr, &stat->data.history.rb.first);
+	while ((entry = sgrb_consume_nodelete(&stat->data.history.rb, &ptr))) {
+		seg = sgrb_seg_find(&private->read_seg_lh, 256, GFP_ATOMIC);
+		if (!seg)
+			return -ENOMEM;
+		t[0] = ' ';
+		statistic_nsec_to_string(time, &t[1]);
+		switch (stat->data.history.mode) {
+		case STATISTIC_DEF_MODE_INC :
+		case STATISTIC_DEF_MODE_PROD :
+			_statistic_format_data_value(
+				stat, seg, t, *(u64*)entry);
+			break;
+		case STATISTIC_DEF_MODE_RANGE :
+			_statistic_format_data_range(
+				stat, seg, t,
+				(struct statistic_entry_range *)entry);
+			break;
+		default :
+			break;
+		}
+		time += stat->data.history.period;
+	}
+	return 0;
+}
+
+static inline int
+statistic_format_def_history(struct statistic *stat, char *line)
+{
+	unsigned long long period = stat->data.history.period;
+
+	do_div(period, 1000);
+	return sprintf(line,
+			" %s%u %s %s%llu",
+			statistic_strings[STATISTIC_DEF_ENTRIESMAX],
+			stat->data.history.entries_max,
+	    		statistic_strings[stat->data.history.mode],
+			statistic_strings[STATISTIC_DEF_PERIOD],
+			period);
+}
+
+static u64
+statistic_add_history_increments(struct statistic *stat, s64 value, u64 incr)
+{
+	if (value < stat->range_min || value > stat->range_max) {
+		stat->hits_out_of_range++;
+		return 0;
+	}
+	return _statistic_add_value_increments(
+			(s64*) statistic_add_history_entry(stat), value, incr);
+}
+
+static u64
+statistic_add_history_products(struct statistic *stat, s64 value, u64 incr)
+{
+	if (value < stat->range_min || value > stat->range_max) {
+		stat->hits_out_of_range++;
+		return 0;
+	}
+	return _statistic_add_value_products(
+			(s64*) statistic_add_history_entry(stat), value, incr);
+}
+
+static u64
+statistic_add_history_range(struct statistic *stat, s64 value, u64 incr)
+{
+	if (value < stat->range_min || value > stat->range_max) {
+		stat->hits_out_of_range++;
+		return 0;
+	}
+	return _statistic_add_range(
+			(struct statistic_entry_range *)
+				statistic_add_history_entry(stat),
+			value, incr);
+}
+
+/**
+ * statistic_define_history - instantiate statistic as a history
+ *    that accumulates all updates per defined period of time
+ * @stat: statistic to be defined
+ * @range_min: lower bound of discriminators
+ * @range_max: upper bound of discriminators
+ * @entries: number of entries of the history buffer
+ * @mode: accumulate increments only, or products of discriminator and increment
+ * @period: time to elapse for each entry in history
+ *
+ * Determines that the statistic does not maintain counters per a fixed period
+ * of time. All updates within a particular period of time are added up. When
+ * that period has passed, the next entry in the history buffer is used to start
+ * over with accumulation. The history buffer is a ringbuffer, that is, the
+ * oldest entry is replaced by the newest, if the history buffer has been filled
+ * up. Updates out of the specified range are dropped, though their total number
+ * is readable through the "definition" file. Each entry is tagged with a
+ * and a timestamp. Each entry consumes 8 bytes (mode=increments, mode=products)
+ * or 32 bytes (mode=range).
+ *
+ * Depending on the definition, accumulation is done as
+ *
+ * a) mode=increments	: see statistic_define_value()
+ * b) mode=products	: see statistic_define_value()
+ * c) mode=range	: see statistic_define_range()
+ *
+ * The output format of a "history" statistic found in the "data" file is
+ * (for mode=increments and mode=products):
+ *
+ * <statistic name> <timestamp> <total for period of time>
+ *
+ * This (re)definition function is available both to exploiting device drivers
+ * and to the user through the "definition" file. Device driver programmers
+ * might find it user-friendly to provide a default definition for
+ * particular statistic by calling this or a related function. A previous
+ * definition is replaced by the new one. Next, the statistic must be enabled
+ * in order to make it gather data. A line in the interface's "definition"
+ * file will hold specifics about the named statistic.
+ *
+ * On success, 0 is returned.
+ *
+ * If some required memory could not be allocated this routine fails,
+ * and -ENOMEM is returned.
+ **/
+int statistic_define_history(
+	struct statistic *stat, s64 range_min, s64 range_max, u32 entries_max,
+	u64 period, int mode)
+{
+	unsigned long flags;
+	int retval;
+
+	if (mode != STATISTIC_DEF_MODE_INC &&
+	    mode != STATISTIC_DEF_MODE_PROD &&
+	    mode != STATISTIC_DEF_MODE_RANGE)
+		return -EINVAL;
+
+	spin_lock_irqsave(&stat->interface->lock, flags);
+
+	statistic_release(stat);
+
+	period *= 1000;	/* microseconds to nanoseconds */
+
+	stat->type = STATISTIC_DEF_TYPE_HISTORY;
+	stat->range_min = range_min;
+	stat->range_max = range_max;
+	stat->data.history.entries_max = entries_max;
+	stat->data.history.mode = mode;
+	stat->data.history.period = period;
+	stat->data.history.window = entries_max * period;
+
+	stat->alloc = statistic_alloc_history;
+	stat->release = statistic_release_history;
+	stat->format_data = statistic_format_data_history;
+	stat->format_def = statistic_format_def_history;
+	if (mode == STATISTIC_DEF_MODE_INC)
+		stat->add = statistic_add_history_increments;
+	else if (mode == STATISTIC_DEF_MODE_PROD)
+		stat->add = statistic_add_history_products;
+	else
+		stat->add = statistic_add_history_range;
+
+	retval = statistic_alloc(stat);
+
+	spin_unlock_irqrestore(&stat->interface->lock, flags);
+
+	return retval;
+}
+
+/* code concerned with user interface */
+
+/**
+ * statistic_interface_create - create debugfs files for statistic
+ * @interface_ptr: reference to struct statistic_interface pointer
+ * @name: name of debugfs directory to be created
+ *
+ * Create a debugfs directory in "s390stat" as well as the "data" and
+ * "definition" files. Creating this user interface is prequisite for
+ * attaching statistic to an interface.
+ *
+ * On success, 0 is returned and the struct statistic_interface pointer
+ * provided by the caller points to a newly alloacted struct.
+ *
+ * If the struct statistic_interface pointer provided by the caller
+ * is not NULL (used), this routine fails, the struct statistic_interface
+ * pointer is not changed, and -EINVAL is returned.
+ *
+ * If some required memory could not be allocated, or the creation
+ * of debugfs entries failed, this routine fails, the struct
+ * statistic_interface pointer is not changed, and -ENOMEM is returned.
+ **/
+int
+statistic_interface_create(
+	struct statistic_interface **interface_ptr,
+	const char *name)
+{
+	struct statistic_interface *interface;
+	int retval;
+
+	if (*interface_ptr)
+		return -EINVAL;
+
+	interface = kmalloc(sizeof(struct statistic_interface), GFP_KERNEL);
+	if (!interface)
+		return -ENOMEM;
+	memset(interface, 0, sizeof(struct statistic_interface));
+	INIT_LIST_HEAD(&interface->statistic_lh);
+	spin_lock_init(&interface->lock);
+
+	down(&statistic_globals.sem);
+
+	interface->debugfs_dir = debugfs_create_dir(
+					name, statistic_globals.root_dir);
+	if (!interface->debugfs_dir) {
+		retval = -ENOMEM;
+		goto failed_dir;
+	}
+
+	interface->data_file = debugfs_create_file(
+					STATISTIC_FILENAME_DATA,
+					S_IFREG | S_IRUSR,
+					interface->debugfs_dir,
+					(void*) interface,
+					&statistic_data_file_ops);
+	if (!interface->data_file) {
+		retval = -ENOMEM;
+		goto failed_data;
+	}
+
+	interface->def_file = debugfs_create_file(
+					STATISTIC_FILENAME_DEF,
+					S_IFREG | S_IRUSR | S_IWUSR,
+					interface->debugfs_dir,
+					(void*) interface,
+					&statistic_def_file_ops);
+	if (!interface->def_file) {
+		retval = -ENOMEM;
+		goto failed_def;
+	}
+
+	list_add_tail(&interface->list, &statistic_globals.interface_lh);
+	*interface_ptr = interface;
+	retval = 0;
+	goto out;
+
+failed_def:
+	debugfs_remove(interface->data_file);
+
+failed_data:
+failed_dir:
+	kfree(interface);
+	interface = NULL;
+
+out:
+	up(&statistic_globals.sem);
+
+	return retval;
+}
+
+/**
+ * statistic_interface_remove - remove debugfs files for statistic
+ * @interface_ptr: reference to struct statistic_interface pointer
+ *
+ * Remove a debugfs directory in "s390stat" along with its "data" and
+ * "definition" files. Removing this user interface also causes the removal
+ * of all statistic attached to the interface.
+ *
+ * On success, 0 is returned and the struct statistic_interface pointer
+ * provided by the caller is set to NULL.
+ *
+ * If the struct statistic_interface pointer provided by the caller
+ * is NULL (unused), this routine fails, the struct statistic_interface
+ * pointer is not changed, and -EINVAL is returned.
+ **/
+int
+statistic_interface_remove(struct statistic_interface **interface_ptr)
+{
+	struct statistic_interface *interface = *interface_ptr;
+	struct statistic *stat, *tmp;
+
+	if (!interface)
+		return -EINVAL;
+
+	down(&statistic_globals.sem);
+
+	list_for_each_entry_safe(stat, tmp, &interface->statistic_lh, list)
+		statistic_remove(stat->stat_ptr);
+
+	debugfs_remove(interface->data_file);
+	debugfs_remove(interface->def_file);
+	debugfs_remove(interface->debugfs_dir);
+
+	list_del(&interface->list);
+	kfree(interface);
+	*interface_ptr = NULL;
+
+	up(&statistic_globals.sem);
+
+	return 0;
+}
+
+static int
+statistic_interface_generic_open(
+		struct inode *inode, struct file *file,
+		struct statistic_interface **interface,
+		struct statistic_file_private **private)
+{
+	*interface = (struct statistic_interface *) inode->u.generic_ip;
+	BUG_ON(!interface);
+
+	*private = kmalloc(sizeof(struct statistic_file_private), GFP_KERNEL);
+	if (!(*private))
+		return -ENOMEM;
+
+	memset(*private, 0, sizeof(struct statistic_file_private));
+	INIT_LIST_HEAD(&(*private)->read_seg_lh);
+	INIT_LIST_HEAD(&(*private)->write_seg_lh);
+	file->private_data = *private;
+	return 0;
+}
+
+static int
+statistic_interface_generic_close(struct inode *inode, struct file *file)
+{
+	struct statistic_file_private *private;
+
+	private = (struct statistic_file_private *) file->private_data;
+	BUG_ON(!private);
+
+	sgrb_seg_release_all(&private->read_seg_lh);
+	sgrb_seg_release_all(&private->write_seg_lh);
+
+	kfree(private);
+	return 0;
+}
+
+static ssize_t
+statistic_interface_generic_read(struct file *file, char __user *buf, size_t len, loff_t *offset)
+{
+	struct statistic_file_private *private;
+	struct sgrb_seg *seg;
+	size_t seg_offset, seg_residual, seg_transfer;
+	size_t transfered = 0;
+	loff_t pos = 0;
+
+	private = (struct statistic_file_private *) file->private_data;
+	BUG_ON(!private);
+
+	list_for_each_entry(seg, &private->read_seg_lh, list) {
+		if (!len)
+			break;
+		if (*offset >= pos  &&
+		    *offset <= (pos + seg->offset)) {
+			seg_offset = *offset - pos;
+			seg_residual = seg->offset - seg_offset;
+			seg_transfer = min(len, seg_residual);
+			if (copy_to_user(buf + transfered,
+					 seg->address + seg_offset,
+					 seg_transfer))
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
+static ssize_t
+statistic_interface_generic_write(struct file *file, const char __user *buf, size_t len, loff_t *offset)
+{
+	struct statistic_file_private *private;
+	struct sgrb_seg *seg;
+	size_t seg_residual, seg_transfer;
+	size_t transfered = 0;
+
+	private = (struct statistic_file_private *) file->private_data;
+	BUG_ON(!private);
+
+	if (*offset != private->write_seg_total_size)
+		return -EPIPE;
+
+	while (len) {
+		seg = sgrb_seg_find(&private->write_seg_lh, 1, GFP_KERNEL);
+		if (!seg)
+			return -ENOMEM;
+		seg_residual = seg->size - seg->offset;
+		seg_transfer = min(len, seg_residual);
+		if (copy_from_user(seg->address + seg->offset,
+				   buf + transfered,
+				   seg_transfer))
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
+static int
+statistic_interface_def_open(struct inode *inode, struct file *file)
+{
+	struct statistic_interface *interface;
+	struct statistic_file_private *private;
+	struct statistic *stat;
+	unsigned long flags;
+	int retval = 0;
+
+	retval = statistic_interface_generic_open(
+			inode, file, &interface, &private);
+	if (retval)
+		return retval;
+
+	spin_lock_irqsave(&interface->lock, flags);
+	list_for_each_entry(stat, &interface->statistic_lh, list) {
+		retval = statistic_format_def(stat, private);
+		if (retval) {
+			statistic_interface_def_close(inode, file);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&interface->lock, flags);
+	return retval;
+}
+
+static int
+statistic_parse_definitions_line(
+		struct statistic_interface *interface, char *def)
+{
+	struct statistic *stat;
+	char * p;
+	substring_t args[MAX_OPT_ARGS];
+	int token, type = 0, scale = 0;
+	u32 entries_max, base_interval;
+	s64 range_min, range_max;
+	u64 period = 0;
+	int mode = 0;
+	char *name = NULL;
+	int retval = 0;
+	unsigned long flags;
+	int got_type = 0, got_scale = 0, got_entries_max = 0,
+	    got_range_min = 0, got_range_max = 0,
+	    got_base_interval = 0, got_period = 0, got_mode = 0, got_reset = 0,
+	    got_on = 0, got_off = 0,redefinition = 0, new_type = 0,
+	    was_on = 0;
+
+	if (!def)
+		return 1;
+
+	while ((p = strsep (&def, " ")) != NULL) {
+		token = match_token(p, statistic_def, args);
+		switch (token) {
+		case STATISTIC_DEF_NAME :
+			if (!name)
+				name = match_strdup(&args[0]);
+			break;
+		case STATISTIC_DEF_TYPE_VALUE :
+		case STATISTIC_DEF_TYPE_RANGE :
+		case STATISTIC_DEF_TYPE_ARRAY :
+		case STATISTIC_DEF_TYPE_LIST :
+		case STATISTIC_DEF_TYPE_RAW :
+		case STATISTIC_DEF_TYPE_HISTORY :
+			type = token;
+			got_type = 1;
+			break;
+		case STATISTIC_DEF_ON :
+			got_on = 1;
+			break;
+		case STATISTIC_DEF_OFF :
+			got_off = 1;
+			break;
+		case STATISTIC_DEF_SCALE_LIN :
+		case STATISTIC_DEF_SCALE_LOG2 :
+			scale = token;
+			got_scale = 1;
+			break;
+		case STATISTIC_DEF_ENTRIESMAX :
+			match_int(&args[0], &entries_max);
+			got_entries_max = 1;
+			break;
+		case STATISTIC_DEF_RANGEMIN :
+			match_s64(&args[0], &range_min, 0);
+			got_range_min = 1;
+			break;
+		case STATISTIC_DEF_RANGEMAX :
+			match_s64(&args[0], &range_max, 0);
+			got_range_max = 1;
+			break;
+		case STATISTIC_DEF_BASEINT :
+			match_int(&args[0], &base_interval);
+			got_base_interval = 1;
+			break;
+		case STATISTIC_DEF_PERIOD :
+			match_u64(&args[0], &period, 0);
+			got_period = 1;
+			break;
+		case STATISTIC_DEF_MODE_INC :
+		case STATISTIC_DEF_MODE_PROD :
+		case STATISTIC_DEF_MODE_RANGE :
+			mode = token;
+			got_mode = 1;
+			break;
+		case STATISTIC_DEF_RESET :
+			got_reset = 1;
+			break;
+		default :
+			break;
+		}
+	}
+
+	redefinition =  got_type | got_mode | got_scale | got_entries_max |
+			got_range_min | got_range_max |
+			got_base_interval | got_period;
+
+	if (!name) {
+		if (redefinition)
+			goto out;
+		spin_lock_irqsave(&interface->lock, flags);
+		if (got_on)
+			list_for_each_entry(stat, &interface->statistic_lh, list)
+				statistic_start_nolock(stat);
+		if (got_off)
+			list_for_each_entry(stat, &interface->statistic_lh, list)
+				statistic_stop_nolock(stat);
+		if (got_reset) {
+			list_for_each_entry(stat, &interface->statistic_lh, list)
+				statistic_reset_nolock(stat);
+		}
+		spin_unlock_irqrestore(&interface->lock, flags);
+		goto out;
+	}
+
+	spin_lock_irqsave(&interface->lock, flags);
+	list_for_each_entry(stat, &interface->statistic_lh, list) {
+		if (!strcmp(stat->name, name))
+			break;
+	}
+	spin_unlock_irqrestore(&interface->lock, flags);
+	if (strcmp(stat->name, name))
+		goto out;
+
+	if (!redefinition) {
+		if (got_on)
+			statistic_start(stat);
+		if (got_off)
+			statistic_stop(stat);
+		if (got_reset)
+			statistic_reset(stat);
+		goto out;
+	}
+
+	if (statistic_stop(stat) == STATISTIC_DEF_ON)
+		was_on = 1;
+
+	if (!got_type)
+		type = stat->type;
+	else if (type != stat->type)
+		new_type = 1;
+
+	if (!got_range_min)
+		range_min = stat->range_min;
+	if (!got_range_max)
+		range_max = stat->range_max;
+
+        switch (type) {
+        case STATISTIC_DEF_TYPE_VALUE :
+		if (new_type && !got_mode) {
+			retval = -EINVAL;
+			break;
+		}
+		if (!got_mode)
+			mode = stat->data.value.mode;
+		retval = statistic_define_value(
+				stat, range_min, range_max, mode);
+		break;
+        case STATISTIC_DEF_TYPE_RANGE :
+		retval = statistic_define_range(
+				stat, range_min, range_max);
+		break;
+        case STATISTIC_DEF_TYPE_ARRAY :
+		if (new_type && (!got_base_interval || !got_scale)) {
+			retval = -EINVAL;
+			break;
+		}
+		if (!got_base_interval)
+			base_interval = stat->data.array.base_interval;
+		if (!got_scale)
+			scale = stat->data.array.scale;
+		retval = statistic_define_array(
+				stat, range_min, range_max, base_interval, scale);
+		break;
+        case STATISTIC_DEF_TYPE_LIST :
+		if (new_type && !got_entries_max) {
+			retval = -EINVAL;
+			break;
+		}
+		if (!got_entries_max)
+			entries_max = stat->data.list.entries_max;
+		retval = statistic_define_list(
+				stat, range_min, range_max, entries_max);
+		break;
+        case STATISTIC_DEF_TYPE_RAW :
+		if (new_type && !got_entries_max) {
+			retval = -EINVAL;
+			break;
+		}
+		if (!got_entries_max)
+			entries_max = stat->data.raw.entries_max;
+		retval = statistic_define_raw(
+				stat, range_min, range_max, entries_max);
+		break;
+        case STATISTIC_DEF_TYPE_HISTORY :
+		if (new_type && (!got_entries_max || !got_period ||
+				 !got_mode)) {
+			retval = -EINVAL;
+			break;
+		}
+		if (!got_entries_max)
+			entries_max = stat->data.history.entries_max;
+		if (!got_period)
+			period = stat->data.history.period;
+		if (!got_mode)
+			mode = stat->data.history.mode;
+		retval = statistic_define_history(
+				stat, range_min, range_max, entries_max,
+				period, mode);
+		break;
+        default :
+                retval = -EINVAL;
+        }
+
+	if (got_on || was_on)
+		statistic_start(stat);
+
+out:
+	kfree(name);
+	return retval;
+}
+
+static void
+statistic_interface_def_close_parse(
+		struct statistic_interface *interface,
+		struct list_head *line_lh, size_t *line_size)
+{
+	struct sgrb_seg *seg, *tmp;
+	char *buf;
+	int offset = 0;
+
+	if (!*line_size)
+		return;
+
+	buf = kmalloc(*line_size + 2, GFP_KERNEL);
+	buf[*line_size] = ' ';
+	buf[*line_size + 1] = '\0';
+	*line_size = 0;
+	if (!buf)
+		return;
+
+	list_for_each_entry_safe(seg, tmp, line_lh, list) {
+		memcpy(buf + offset, seg->address, seg->size);
+		offset += seg->size;
+		list_del(&seg->list);
+		kfree(seg);
+	}
+
+	statistic_parse_definitions_line(interface, buf);
+
+	kfree(buf);
+}
+
+static int
+statistic_interface_def_close(struct inode *inode, struct file *file)
+{
+	struct statistic_interface *interface;
+	struct statistic_file_private *private;
+	struct sgrb_seg *seg, *seg_nl;
+	int offset;
+	struct list_head line_lh;
+	char *nl;
+	size_t line_size = 0;
+
+	INIT_LIST_HEAD(&line_lh);
+	interface = (struct statistic_interface *) inode->u.generic_ip;
+	private = (struct statistic_file_private *) file->private_data;
+
+	list_for_each_entry(seg, &private->write_seg_lh, list) {
+		for (offset = 0; offset < seg->offset; offset += seg_nl->size) {
+			seg_nl = kmalloc(sizeof(struct sgrb_seg),
+					 GFP_KERNEL);
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
+			if (nl)
+				statistic_interface_def_close_parse(
+					interface, &line_lh, &line_size);
+		}
+	}
+	if (!list_empty(&line_lh))
+		statistic_interface_def_close_parse(
+			interface, &line_lh, &line_size);
+
+	return statistic_interface_generic_close(inode, file);
+}
+
+static int
+statistic_interface_data_open(struct inode *inode, struct file *file)
+{
+	struct statistic_interface *interface;
+	struct statistic_file_private *private;
+	struct statistic *stat;
+	unsigned long flags;
+	int retval = 0;
+
+	retval = statistic_interface_generic_open(
+			inode, file, &interface, &private);
+	if (retval)
+		return retval;
+
+	spin_lock_irqsave(&interface->lock, flags);
+	list_for_each_entry(stat, &interface->statistic_lh, list) {
+		if (stat->format_data) {
+			retval = stat->format_data(stat, private);
+			if (retval) {
+				statistic_interface_generic_close(inode, file);
+				break;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&interface->lock, flags);
+
+	return retval;
+}
+
+postcore_initcall(statistic_init);
+module_exit(statistic_exit);
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(statistic_interface_create);
+EXPORT_SYMBOL(statistic_interface_remove);
+EXPORT_SYMBOL(statistic_create);
+EXPORT_SYMBOL(statistic_remove);
+EXPORT_SYMBOL(statistic_define_value);
+EXPORT_SYMBOL(statistic_define_range);
+EXPORT_SYMBOL(statistic_define_array);
+EXPORT_SYMBOL(statistic_define_list);
+EXPORT_SYMBOL(statistic_define_raw);
+EXPORT_SYMBOL(statistic_define_history);
+EXPORT_SYMBOL(statistic_start);
+EXPORT_SYMBOL(statistic_stop);
+EXPORT_SYMBOL(statistic_reset);
diff -urpN linux-2.6/include/asm-s390/sgrb.h linux-2.6-patched/include/asm-s390/sgrb.h
--- linux-2.6/include/asm-s390/sgrb.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/sgrb.h	2005-10-28 14:04:43.000000000 +0200
@@ -0,0 +1,94 @@
+/*
+ * linux/asm-s390/sgrb.h
+ *
+ * a ringbuffer made up of scattered buffers; holds fixed-size entries
+ * (resizing has not been implemented)
+ '
+ * (C) Copyright IBM Corp. 2005
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
+ * sgrb_ptr_copy - prepare pointer a by copying b
+ * @a: duplicate
+ * @b: original
+ *
+ * required to prepare a pointer for use with sgrb_consume_nodelete()
+ */
+static inline void
+sgrb_ptr_copy(
+	struct sgrb_ptr *a,
+	struct sgrb_ptr *b)
+{
+	a->seg = b->seg;
+	a->offset = b->offset;
+}
+
+/**
+ * sgrb_entry - returns address of entry
+ * @a: pointer that determines entry
+ */
+static inline void *
+sgrb_entry(struct sgrb_ptr *a)
+{
+	return (a->seg->address + a->offset);
+}
+
+struct sgrb_seg * sgrb_seg_find(struct list_head *, int, unsigned int);
+void sgrb_seg_release_all(struct list_head *);
+
+int sgrb_alloc(struct sgrb *, int, int, int, int);
+void sgrb_release(struct sgrb *);
+
+void * sgrb_produce_overwrite(struct sgrb *);
+void * sgrb_produce_nooverwrite(struct sgrb *);
+void * sgrb_consume_delete(struct sgrb *);
+void * sgrb_consume_nodelete(struct sgrb *, struct sgrb_ptr *);
+
+#endif /* SGRB_H */
diff -urpN linux-2.6/include/asm-s390/statistic.h linux-2.6-patched/include/asm-s390/statistic.h
--- linux-2.6/include/asm-s390/statistic.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/statistic.h	2005-10-28 14:04:43.000000000 +0200
@@ -0,0 +1,334 @@
+/*
+ * linux/asm-s390/statistic.h
+ *
+ * Statistics facility
+ *
+ * (C) Copyright IBM Corp. 2005
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
+#define STATISTIC_H_REVISION "$Revision: 1.12 $"
+
+#include <linux/fs.h>
+#include <linux/types.h>
+
+#include <asm/spinlock.h>
+#include <asm/sgrb.h>
+
+#define STATISTIC_ROOT_DIR	"s390stat"
+
+#define STATISTIC_FILENAME_DATA	"data"
+#define STATISTIC_FILENAME_DEF	"definition"
+
+#define STATISTIC_NAME_SIZE	64
+
+#define STATISTIC_RANGE_MIN	-0x7fffffffffffffffLL
+#define STATISTIC_RANGE_MAX	 0x7ffffffffffffffeLL
+
+enum {
+	STATISTIC_DEF_NAME,
+	STATISTIC_DEF_UNIT,
+	STATISTIC_DEF_TYPE_VALUE,
+	STATISTIC_DEF_TYPE_RANGE,
+	STATISTIC_DEF_TYPE_ARRAY,
+	STATISTIC_DEF_TYPE_LIST,
+	STATISTIC_DEF_TYPE_RAW,
+	STATISTIC_DEF_TYPE_HISTORY,
+	STATISTIC_DEF_ON,
+	STATISTIC_DEF_OFF,
+	STATISTIC_DEF_STARTED,
+	STATISTIC_DEF_STOPPED,
+	STATISTIC_DEF_RANGEMIN,
+	STATISTIC_DEF_RANGEMAX,
+	STATISTIC_DEF_SCALE_LIN,
+	STATISTIC_DEF_SCALE_LOG2,
+	STATISTIC_DEF_ENTRIESMAX,
+	STATISTIC_DEF_BASEINT,
+	STATISTIC_DEF_HITSMISSED,
+	STATISTIC_DEF_HITSOUT,
+	STATISTIC_DEF_RESET,
+	STATISTIC_DEF_MODE_INC,
+	STATISTIC_DEF_MODE_PROD,
+	STATISTIC_DEF_MODE_RANGE,
+	STATISTIC_DEF_PERIOD,
+	STATISTIC_DEF_VOID,
+};
+
+struct statistic;
+struct statistic_file_private;
+
+typedef int (statistic_alloc_fn) (struct statistic *);
+typedef void (statistic_release_fn) (struct statistic *);
+typedef int (statistic_format_data_fn)
+		(struct statistic *, struct statistic_file_private *);
+typedef int (statistic_format_def_fn) (struct statistic *, char *);
+typedef u64 (statistic_add_fn) (struct statistic *, s64, u64);
+
+struct statistic_entry_list {
+	struct list_head	list;
+	s64			value;
+	u64			hits;
+};
+
+struct statistic_entry_raw {
+	u64 clock;
+	u64 serial;
+	s64 value;
+	u64 incr;
+};
+
+struct statistic_entry_range {
+	u32 res;
+	u32 num;	/* FIXME: better 64 bit; do_div can't deal with it) */
+	s64 acc;
+	s64 min;
+	s64 max;
+};
+
+struct statistic {
+	struct list_head		list;
+	struct statistic_interface	*interface;
+	struct statistic		**stat_ptr;
+	statistic_alloc_fn		*alloc;
+	statistic_release_fn		*release;
+	statistic_format_data_fn	*format_data;
+	statistic_format_def_fn		*format_def;
+	statistic_add_fn		*add;
+	char	name[STATISTIC_NAME_SIZE];
+	char	units[STATISTIC_NAME_SIZE];
+	u8	type;
+	u8	on;
+	u64	started;
+	u64	stopped;
+	u64	reset;
+	s64 	range_min;
+	s64 	range_max;
+	u64	hits_out_of_range;
+	union {
+		struct {
+			/* data */
+			u64 hits;
+			/* user-writeable */
+			int mode;
+		} value;
+		struct {
+			/* data */
+			struct statistic_entry_range range;
+		} range;
+		struct {
+			/* data */
+			u64 *hits;
+			/* user-writeable */
+			u32 base_interval;
+			u8 scale;
+			/* internal */
+			u32 entries;
+		} array;
+		struct {
+			/* data */
+			struct list_head entry_lh;
+			/* user-writeable */
+			u32 entries_max;
+			/* informational for user */
+			u64 hits_missed;
+			/* internal */
+			u32 entries;
+		} list;
+		struct {
+			/* data */
+			struct sgrb rb;
+			/* user-writeable */
+			u32 entries_max;
+			/* internal */
+			u64 next_serial;
+		} raw;
+		struct {
+			/* data */
+			struct sgrb rb;
+			/* user-writeable */
+			u32 entries_max;
+			int mode;
+			u64 period;
+			/* internal */
+			u64 checkpoint;
+			u64 window;
+			u8 entry_size;
+		} history;
+	} data;
+};
+
+struct statistic_interface {
+	struct list_head	list;
+	struct dentry		*debugfs_dir;
+	struct dentry		*data_file;
+	struct dentry		*def_file;
+	struct list_head	statistic_lh;
+	struct semaphore	sem;
+	spinlock_t		lock;
+};
+
+struct statistic_file_private {
+	struct list_head read_seg_lh;
+	struct list_head write_seg_lh;
+	size_t write_seg_total_size;
+};
+
+struct statistic_global_data {
+	struct dentry		*root_dir;
+	struct list_head	interface_lh;
+	struct semaphore	sem;
+};
+
+int statistic_interface_create(struct statistic_interface **, const char *);
+int statistic_interface_remove(struct statistic_interface **);
+
+int statistic_create(struct statistic **, struct statistic_interface *, const char *, const char *);
+int statistic_remove(struct statistic **);
+
+int statistic_define_value(struct statistic *, s64, s64, int);
+int statistic_define_range(struct statistic *, s64, s64);
+int statistic_define_array(struct statistic *, s64, s64, u32, u8);
+int statistic_define_list(struct statistic *, s64, s64, u32);
+int statistic_define_raw(struct statistic *, s64, s64, u32);
+int statistic_define_history(struct statistic *, s64, s64, u32, u64, int);
+
+int statistic_start(struct statistic *);
+int statistic_stop(struct statistic *);
+int statistic_reset(struct statistic *);
+
+/**
+ * statistic_add - update statistic with (discriminator, increment) pair
+ * @stat: statistic
+ * @value: discriminator
+ * @incr: increment
+ *
+ * The actual processing of (discriminator, increment) is determined by the
+ * the definition applied to the statistic. See the statistic_define_*()
+ * routine desciption for details.
+ *
+ * This variant grabs a lock to ensure a) data integrity with regard to
+ * to potentially concurrent data gathering, and b) data consistency across
+ * all statistic attached to the parent interface when being read as a
+ * snapshot by the user through the "data" file.
+ *
+ * On success, the return value is dependend on which type of accumulation
+ * has been applied through the recent definition. Usually, returns the
+ * updated total of increments reported for this discriminator, if the
+ * defined type of accumulation does this kind of computation.
+ *
+ * If the struct statistic pointer provided by the caller
+ * is NULL (unused), this routine fails, and 0 is returned.
+ *
+ * If some required memory could not be allocated this routine fails,
+ * and 0 is returned.
+ *
+ * If the discriminator is not valid (out of range), this routine failes,
+ * and 0 is returned.
+ **/
+static inline u64
+statistic_add(struct statistic *stat, s64 value, u64 incr)
+{
+	unsigned long flags;
+	int retval;
+
+	if (stat->on != STATISTIC_DEF_ON)
+		return 0;
+
+	spin_lock_irqsave(&stat->interface->lock, flags);
+	retval = stat->add(stat, value, incr);
+	spin_unlock_irqrestore(&stat->interface->lock, flags);
+
+	return retval;
+}
+
+/**
+ * statistic_add_nolock - a statistic_add() variant
+ * @stat: statistic
+ * @value: discriminator
+ * @incr: increment
+ *
+ * Same purpose and behavious as statistic_add(). See there for details.
+ *
+ * Only difference to statistic_add():
+ * Lock management is up to the exploiter. Basically, we give exploiters
+ * the option to ensure data consistency across all statistics attached
+ * to a parent interface by adding several calls to this routine into one
+ * critical section protected by stat->interface->lock,
+ **/
+static inline u64
+statistic_add_nolock(struct statistic *stat, s64 value, u64 incr)
+{
+	if (stat->on != STATISTIC_DEF_ON)
+		return 0;
+
+#ifdef DEBUG
+	assert_spin_locked(&stat->interface->lock);
+#endif
+
+	return stat->add(stat, value, incr);
+}
+
+/**
+ * statistic_inc - a statistic_add() variant
+ * @stat: statistic
+ * @value: discriminator
+ *
+ * Same purpose and behavious as statistic_add(). See there for details.
+ * Difference: Increment defaults to 1.
+ **/
+static inline u64
+statistic_inc(struct statistic *stat, s64 value)
+{
+	unsigned long flags;
+	int retval;
+
+	if (stat->on != STATISTIC_DEF_ON)
+		return 0;
+
+	spin_lock_irqsave(&stat->interface->lock, flags);
+	retval = stat->add(stat, value, 1);
+	spin_unlock_irqrestore(&stat->interface->lock, flags);
+
+	return retval;
+}
+
+/**
+ * statistic_inc_nolock - a statistic_add_nolock() variant
+ * @stat: statistic
+ * @value: discriminator
+ *
+ * Same purpose and behavious as statistic_add_nolock(). See there for details.
+ * Difference: Increment defaults to 1.
+ **/
+static inline u64
+statistic_inc_nolock(struct statistic *stat, s64 value)
+{
+	if (stat->on != STATISTIC_DEF_ON)
+		return 0;
+
+#ifdef DEBUG
+	assert_spin_locked(&stat->interface->lock);
+#endif
+
+	return stat->add(stat, value, 1);
+}
+
+#endif /* STATISTIC_H */
diff -urpN linux-2.6/include/linux/list.h linux-2.6-patched/include/linux/list.h
--- linux-2.6/include/linux/list.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/include/linux/list.h	2005-10-28 14:04:43.000000000 +0200
@@ -406,6 +406,18 @@ static inline void list_splice_init(stru
 	     pos = list_entry(pos->member.next, typeof(*pos), member))
 
 /**
+ * list_for_each_entry_continue_reverse -       iterate backwards over list
+ *                      of given type continuing before existing point
+ * @pos:        the type * to use as a loop counter.
+ * @head:       the head for your list.
+ * @member:     the name of the list_struct within the struct.
+ */
+#define list_for_each_entry_continue_reverse(pos, head, member)                 \
+        for (pos = list_entry(pos->member.prev, typeof(*pos), member);  \
+             prefetch(pos->member.prev), &pos->member != (head);        \
+             pos = list_entry(pos->member.prev, typeof(*pos), member))
+
+/**
  * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
  * @pos:	the type * to use as a loop counter.
  * @n:		another type * to use as temporary storage
diff -urpN linux-2.6/include/linux/parser.h linux-2.6-patched/include/linux/parser.h
--- linux-2.6/include/linux/parser.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/include/linux/parser.h	2005-10-28 14:04:43.000000000 +0200
@@ -31,3 +31,5 @@ int match_octal(substring_t *, int *resu
 int match_hex(substring_t *, int *result);
 void match_strcpy(char *, substring_t *);
 char *match_strdup(substring_t *);
+int match_u64(substring_t *, u64 *result, int);
+int match_s64(substring_t *, s64 *result, int);
diff -urpN linux-2.6/lib/parser.c linux-2.6-patched/lib/parser.c
--- linux-2.6/lib/parser.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/lib/parser.c	2005-10-28 14:04:43.000000000 +0200
@@ -140,6 +140,64 @@ static int match_number(substring_t *s, 
 }
 
 /**
+ * match_u64: scan a number in the given base from a substring_t
+ * @s: substring to be scanned
+ * @result: resulting integer on success
+ * @base: base to use when converting string
+ *
+ * Description: Given a &substring_t and a base, attempts to parse the substring
+ * as a number in that base. On success, sets @result to the u64 represented
+ * by the string and returns 0. Returns either -ENOMEM or -EINVAL on failure.
+ */
+int match_u64(substring_t *s, u64 *result, int base)
+{
+        char *endp;
+        char *buf;
+        int ret;
+
+        buf = kmalloc(s->to - s->from + 1, GFP_KERNEL);
+        if (!buf)
+                return -ENOMEM;
+        memcpy(buf, s->from, s->to - s->from);
+        buf[s->to - s->from] = '\0';
+        *result = simple_strtoull(buf, &endp, base);
+        ret = 0;
+        if (endp == buf)
+                ret = -EINVAL;
+        kfree(buf);
+        return ret;
+}
+
+/**
+ * match_s64: scan a number in the given base from a substring_t
+ * @s: substring to be scanned
+ * @result: resulting integer on success
+ * @base: base to use when converting string
+ *
+ * Description: Given a &substring_t and a base, attempts to parse the substring
+ * as a number in that base. On success, sets @result to the s64 represented
+ * by the string and returns 0. Returns either -ENOMEM or -EINVAL on failure.
+ */
+int match_s64(substring_t *s, s64 *result, int base)
+{
+        char *endp;
+        char *buf;
+        int ret;
+
+        buf = kmalloc(s->to - s->from + 1, GFP_KERNEL);
+        if (!buf)
+                return -ENOMEM;
+        memcpy(buf, s->from, s->to - s->from);
+        buf[s->to - s->from] = '\0';
+        *result = simple_strtoll(buf, &endp, base);
+        ret = 0;
+        if (endp == buf)
+                ret = -EINVAL;
+        kfree(buf);
+        return ret;
+}
+
+/**
  * match_int: - scan a decimal representation of an integer from a substring_t
  * @s: substring_t to be scanned
  * @result: resulting integer on success
@@ -218,3 +276,5 @@ EXPORT_SYMBOL(match_octal);
 EXPORT_SYMBOL(match_hex);
 EXPORT_SYMBOL(match_strcpy);
 EXPORT_SYMBOL(match_strdup);
+EXPORT_SYMBOL(match_u64);
+EXPORT_SYMBOL(match_s64);
