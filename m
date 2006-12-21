Return-Path: <linux-kernel-owner+w=401wt.eu-S1161094AbWLUAgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbWLUAgR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWLUAgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:36:16 -0500
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:39849 "EHLO
	tomts25-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161093AbWLUAgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:36:15 -0500
Date: Wed, 20 Dec 2006 19:31:01 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, David Wilder <dwilder@us.ibm.com>,
       Tom Zanussi <zanussi@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>
Cc: ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] Relay CPU Hotplug support
Message-ID: <20061221003101.GA28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:29:46 up 119 days, 21:37,  6 users,  load average: 4.21, 3.12, 2.31
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch, result of the combined work of Tom Zanussi and myself, to add
CPU hotplug support to Relay.

This patch applies on 2.6.20-rc1-git7.

Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -24,7 +24,7 @@ #define FIX_SIZE(x) ((((x) - 1) & PAGE_M
 /*
  * Tracks changes to rchan/rchan_buf structs
  */
-#define RELAYFS_CHANNEL_VERSION		6
+#define RELAYFS_CHANNEL_VERSION		7
 
 /*
  * Per-cpu relay channel buffer
@@ -64,6 +64,10 @@ struct rchan
 	void *private_data;		/* for user-defined data */
 	size_t last_toobig;		/* tried to log event > subbuf size */
 	struct rchan_buf *buf[NR_CPUS]; /* per-cpu channel buffers */
+	int is_global;			/* One global buffer ? */
+	struct list_head list;		/* for channel list */
+	struct dentry *parent;		/* parent dentry passed to open */
+	char base_filename[NAME_MAX];	/* saved base filename */
 };
 
 /*
@@ -162,7 +166,8 @@ struct rchan *relay_open(const char *bas
 			 struct dentry *parent,
 			 size_t subbuf_size,
 			 size_t n_subbufs,
-			 struct rchan_callbacks *cb);
+			 struct rchan_callbacks *cb,
+			 void *private_data);
 extern void relay_close(struct rchan *chan);
 extern void relay_flush(struct rchan *chan);
 extern void relay_subbufs_consumed(struct rchan *chan,
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -7,6 +7,8 @@
  * Copyright (C) 1999-2005 - Karim Yaghmour (karim@opersys.com)
  *
  * Moved to kernel/relay.c by Paul Mundt, 2006.
+ * November 2006 - CPU hotplug support by Mathieu Desnoyers
+ * 	(mathieu.desnoyers@polymtl.ca)
  *
  * This file is released under the GPL.
  */
@@ -18,6 +20,11 @@ #include <linux/string.h>
 #include <linux/relay.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
+#include <linux/cpu.h>
+
+/* list of open channels, for cpu hotplug */
+static DEFINE_MUTEX(relay_channels_mutex);
+static LIST_HEAD(relay_channels);
 
 /*
  * close() vm_op implementation for relay file mapping.
@@ -187,6 +194,7 @@ void relay_destroy_buf(struct rchan_buf 
 			__free_page(buf->page_array[i]);
 		kfree(buf->page_array);
 	}
+	chan->buf[buf->cpu] = NULL;
 	kfree(buf->padding);
 	kfree(buf);
 	kref_put(&chan->kref, relay_destroy_channel);
@@ -362,58 +370,76 @@ static inline void __relay_reset(struct 
 void relay_reset(struct rchan *chan)
 {
 	unsigned int i;
-	struct rchan_buf *prev = NULL;
 
 	if (!chan)
 		return;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!chan->buf[i] || chan->buf[i] == prev)
-			break;
-		__relay_reset(chan->buf[i], 0);
-		prev = chan->buf[i];
+ 	if (chan->is_global && chan->buf[0]) {
+		__relay_reset(chan->buf[0], 0);
+		return;
 	}
+
+	lock_cpu_hotplug();
+	for_each_online_cpu(i)
+		if (chan->buf[i])
+			__relay_reset(chan->buf[i], 0);
+	unlock_cpu_hotplug();
 }
 EXPORT_SYMBOL_GPL(relay_reset);
 
 /*
  *	relay_open_buf - create a new relay channel buffer
  *
- *	Internal - used by relay_open().
+ *	used by relay_open() and CPU hotplug.
  */
-static struct rchan_buf *relay_open_buf(struct rchan *chan,
-					const char *filename,
-					struct dentry *parent,
-					int *is_global)
+static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
 {
-	struct rchan_buf *buf;
+ 	struct rchan_buf *buf = NULL;
 	struct dentry *dentry;
+ 	char *tmpname;
 
-	if (*is_global)
+ 	if (chan->is_global)
 		return chan->buf[0];
 
+	tmpname = kzalloc(NAME_MAX + 1, GFP_KERNEL);
+ 	if (!tmpname)
+ 		goto end;
+ 	snprintf(tmpname, NAME_MAX, "%s%d", chan->base_filename, cpu);
+
 	buf = relay_create_buf(chan);
 	if (!buf)
-		return NULL;
+ 		goto free_name;
 
-	/* Create file in fs */
-	dentry = chan->cb->create_buf_file(filename, parent, S_IRUSR,
-					   buf, is_global);
-	if (!dentry) {
-		relay_destroy_buf(buf);
-		return NULL;
-	}
+ 	buf->cpu = cpu;
+ 	__relay_reset(buf, 1);
 
+	/* Create file in fs */
+ 	dentry = chan->cb->create_buf_file(tmpname, chan->parent, S_IRUSR,
+ 					   buf, &chan->is_global);
+ 	if (!dentry)
+ 		goto free_buf;
+ 
 	buf->dentry = dentry;
-	__relay_reset(buf, 1);
 
+ 	if(chan->is_global) {
+ 		chan->buf[0] = buf;
+ 		buf->cpu = 0;
+  	}
+
+ 	goto free_name;
+
+free_buf:
+ 	relay_destroy_buf(buf);
+free_name:
+ 	kfree(tmpname);
+end:
 	return buf;
 }
 
 /**
  *	relay_close_buf - close a channel buffer
  *	@buf: channel buffer
- *
+ *	
  *	Marks the buffer finalized and restores the default callbacks.
  *	The channel buffer and channel buffer data structure are then freed
  *	automatically when the last reference is given up.
@@ -448,12 +474,54 @@ static inline void setup_callbacks(struc
 }
 
 /**
+ *
+ * 	relay_hotcpu_callback - CPU hotplug callback
+ * 	@nb: notifier block
+ * 	@action: hotplug action to take
+ * 	@hcpu: CPU number
+ *
+ * 	Returns the success/failure of the operation. (NOTIFY_OK, NOTIFY_BAD)
+ */
+static int __cpuinit relay_hotcpu_callback(struct notifier_block *nb,
+				unsigned long action,
+				void *hcpu)
+{
+	unsigned int hotcpu = (unsigned long)hcpu;
+	struct rchan *chan;
+
+	switch(action) {
+	case CPU_UP_PREPARE:
+		mutex_lock(&relay_channels_mutex);
+		list_for_each_entry(chan, &relay_channels, list) {
+			if (chan->buf[hotcpu])
+				continue;
+			chan->buf[hotcpu] = relay_open_buf(chan, hotcpu);
+			if(!chan->buf[hotcpu]) {
+				printk(KERN_ERR
+					"relay_hotcpu_callback: cpu %d buffer "
+					"creation failed\n", hotcpu);
+				mutex_unlock(&relay_channels_mutex);
+				return NOTIFY_BAD;
+			}
+		}
+		mutex_unlock(&relay_channels_mutex);
+		break;
+	case CPU_DEAD:
+		/* No need to flush the cpu : will be flushed upon
+		 * final relay_flush() call. */
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+/**
  *	relay_open - create a new relay channel
  *	@base_filename: base name of files to create
  *	@parent: dentry of parent directory, %NULL for root directory
  *	@subbuf_size: size of sub-buffers
  *	@n_subbufs: number of sub-buffers
  *	@cb: client callback functions
+ *	@private_data: user-defined data
  *
  *	Returns channel pointer if successful, %NULL otherwise.
  *
@@ -466,13 +534,11 @@ struct rchan *relay_open(const char *bas
 			 struct dentry *parent,
 			 size_t subbuf_size,
 			 size_t n_subbufs,
-			 struct rchan_callbacks *cb)
+			 struct rchan_callbacks *cb,
+			 void *private_data)
 {
 	unsigned int i;
 	struct rchan *chan;
-	char *tmpname;
-	int is_global = 0;
-
 	if (!base_filename)
 		return NULL;
 
@@ -487,38 +553,34 @@ struct rchan *relay_open(const char *bas
 	chan->n_subbufs = n_subbufs;
 	chan->subbuf_size = subbuf_size;
 	chan->alloc_size = FIX_SIZE(subbuf_size * n_subbufs);
+	chan->parent = parent;
+	chan->private_data = private_data;
+	strlcpy(chan->base_filename, base_filename, NAME_MAX);
 	setup_callbacks(chan, cb);
 	kref_init(&chan->kref);
 
-	tmpname = kmalloc(NAME_MAX + 1, GFP_KERNEL);
-	if (!tmpname)
-		goto free_chan;
-
+	lock_cpu_hotplug();
 	for_each_online_cpu(i) {
-		sprintf(tmpname, "%s%d", base_filename, i);
-		chan->buf[i] = relay_open_buf(chan, tmpname, parent,
-					      &is_global);
+		chan->buf[i] = relay_open_buf(chan, i);
 		if (!chan->buf[i])
 			goto free_bufs;
-
-		chan->buf[i]->cpu = i;
 	}
+	mutex_lock(&relay_channels_mutex);
+	list_add(&chan->list, &relay_channels);
+	mutex_unlock(&relay_channels_mutex);
+	unlock_cpu_hotplug();
 
-	kfree(tmpname);
 	return chan;
 
 free_bufs:
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_online_cpu(i) {
 		if (!chan->buf[i])
 			break;
 		relay_close_buf(chan->buf[i]);
-		if (is_global)
-			break;
 	}
-	kfree(tmpname);
 
-free_chan:
 	kref_put(&chan->kref, relay_destroy_channel);
+	unlock_cpu_hotplug();
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(relay_open);
@@ -619,24 +681,28 @@ EXPORT_SYMBOL_GPL(relay_subbufs_consumed
 void relay_close(struct rchan *chan)
 {
 	unsigned int i;
-	struct rchan_buf *prev = NULL;
 
 	if (!chan)
 		return;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!chan->buf[i] || chan->buf[i] == prev)
-			break;
-		relay_close_buf(chan->buf[i]);
-		prev = chan->buf[i];
-	}
+	lock_cpu_hotplug();
+	if (chan->is_global && chan->buf[0])
+		relay_close_buf(chan->buf[0]);
+	else
+		for_each_possible_cpu(i)
+			if (chan->buf[i])
+				relay_close_buf(chan->buf[i]);
 
 	if (chan->last_toobig)
 		printk(KERN_WARNING "relay: one or more items not logged "
 		       "[item size (%Zd) > sub-buffer size (%Zd)]\n",
 		       chan->last_toobig, chan->subbuf_size);
 
+	mutex_lock(&relay_channels_mutex);
+	list_del(&chan->list);
+	mutex_unlock(&relay_channels_mutex);
 	kref_put(&chan->kref, relay_destroy_channel);
+	unlock_cpu_hotplug();
 }
 EXPORT_SYMBOL_GPL(relay_close);
 
@@ -649,17 +715,20 @@ EXPORT_SYMBOL_GPL(relay_close);
 void relay_flush(struct rchan *chan)
 {
 	unsigned int i;
-	struct rchan_buf *prev = NULL;
 
 	if (!chan)
 		return;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!chan->buf[i] || chan->buf[i] == prev)
-			break;
-		relay_switch_subbuf(chan->buf[i], 0);
-		prev = chan->buf[i];
+	if (chan->is_global && chan->buf[0]) {
+		relay_switch_subbuf(chan->buf[0], 0);
+		return;
 	}
+
+	lock_cpu_hotplug();
+	for_each_possible_cpu(i)
+		if (chan->buf[i])
+			relay_switch_subbuf(chan->buf[i], 0);
+	unlock_cpu_hotplug();
 }
 EXPORT_SYMBOL_GPL(relay_flush);
 
@@ -1023,3 +1092,12 @@ const struct file_operations relay_file_
 	.sendfile       = relay_file_sendfile,
 };
 EXPORT_SYMBOL_GPL(relay_file_operations);
+
+static __init int relay_init(void)
+{
+
+	hotcpu_notifier(relay_hotcpu_callback, 0);
+	return 0;
+}
+
+module_init(relay_init);
--- a/block/blktrace.c
+++ b/block/blktrace.c
@@ -363,10 +363,9 @@ static int blk_trace_setup(request_queue
 	if (!bt->dropped_file)
 		goto err;
 
-	bt->rchan = relay_open("trace", dir, buts.buf_size, buts.buf_nr, &blk_relay_callbacks);
+	bt->rchan = relay_open("trace", dir, buts.buf_size, buts.buf_nr, &blk_relay_callbacks, bt);
 	if (!bt->rchan)
 		goto err;
-	bt->rchan->private_data = bt;
 
 	bt->act_mask = buts.act_mask;
 	if (!bt->act_mask)

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
