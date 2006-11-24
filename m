Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935093AbWKXVwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935093AbWKXVwp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935094AbWKXVwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:52:44 -0500
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:49093 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S935093AbWKXVwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:52:43 -0500
Date: Fri, 24 Nov 2006 16:52:39 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: [PATCH 2/16] LTTng 0.6.36 for 2.6.18 : relay hotplug support
Message-ID: <20061124215239.GC25048@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:51:42 up 93 days, 18:59,  4 users,  load average: 0.34, 0.30, 0.25
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch submitted to Tom Zanussi to add hotplug support to relay.

patch02-2.6.18-lttng-core-0.6.36-relay.diff

Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--BEGIN--
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
@@ -41,6 +41,7 @@ struct rchan_buf
 	struct work_struct wake_readers; /* reader wake-up work struct */
 	struct dentry *dentry;		/* channel file dentry */
 	struct kref kref;		/* channel buffer refcount */
+	struct kref krefw;		/* channel buffer writers refcount */
 	struct page **page_array;	/* array of current buffer pages */
 	unsigned int page_count;	/* number of current buffer pages */
 	unsigned int finalized;		/* buffer has been finalized */
@@ -64,6 +65,10 @@ struct rchan
 	void *private_data;		/* for user-defined data */
 	size_t last_toobig;		/* tried to log event > subbuf size */
 	struct rchan_buf *buf[NR_CPUS]; /* per-cpu channel buffers */
+	int is_global;			/* One global buffer ? */
+	struct list_head list;		/* for channel list */
+	struct dentry *parent;		/* parent dentry passed to open */
+	char base_filename[NAME_MAX];	/* saved base filename */
 };
 
 /*
@@ -133,6 +138,8 @@ struct rchan_callbacks
 	 * cause relay_open() to create a single global buffer rather
 	 * than the default set of per-cpu buffers.
 	 *
+	 * buf->chan->buf[buf->cpu] is not set when this callback is called.
+	 *
 	 * See Documentation/filesystems/relayfs.txt for more info.
 	 */
 	struct dentry *(*create_buf_file)(const char *filename,
@@ -162,7 +169,8 @@ struct rchan *relay_open(const char *bas
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
@@ -7,8 +7,14 @@
  * Copyright (C) 1999-2005 - Karim Yaghmour (karim@opersys.com)
  *
  * Moved to kernel/relay.c by Paul Mundt, 2006.
+ * November 2006 - CPU hotplug support by Mathieu Desnoyers
+ * 	(mathieu.desnoyers@polymtl.ca)
  *
  * This file is released under the GPL.
+ *
+ * In case CPU_DEAD CPU hotplug is someday implemented, we protect against
+ * buffer removal by locking cpu hotplug around each test on buf[cpu] being
+ * NULL everywhere in the file.
  */
 #include <linux/errno.h>
 #include <linux/stddef.h>
@@ -18,6 +24,11 @@ #include <linux/string.h>
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
@@ -189,6 +200,7 @@ void relay_destroy_buf(struct rchan_buf 
 	}
 	kfree(buf->padding);
 	kfree(buf);
+	chan->buf[buf->cpu] = NULL;
 	kref_put(&chan->kref, relay_destroy_channel);
 }
 
@@ -327,6 +339,7 @@ static inline void __relay_reset(struct 
 	if (init) {
 		init_waitqueue_head(&buf->read_wait);
 		kref_init(&buf->kref);
+		kref_init(&buf->krefw);
 		INIT_WORK(&buf->wake_readers, NULL, NULL);
 	} else {
 		cancel_delayed_work(&buf->wake_readers);
@@ -360,70 +373,104 @@ static inline void __relay_reset(struct 
 void relay_reset(struct rchan *chan)
 {
 	unsigned int i;
-	struct rchan_buf *prev = NULL;
 
 	if (!chan)
 		return;
-
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!chan->buf[i] || chan->buf[i] == prev)
-			break;
-		__relay_reset(chan->buf[i], 0);
-		prev = chan->buf[i];
+	lock_cpu_hotplug();
+	if (chan->is_global) {
+		if (chan->buf[0])
+			__relay_reset(chan->buf[0], 0);
+	} else {
+		for_each_online_cpu(i)
+			if (chan->buf[i])
+				__relay_reset(chan->buf[i], 0);
 	}
+	unlock_cpu_hotplug();
 }
 EXPORT_SYMBOL_GPL(relay_reset);
 
 /**
  *	relay_open_buf - create a new relay channel buffer
  *
- *	Internal - used by relay_open().
+ *	used by relay_open() and CPU hotplug.
  */
-static struct rchan_buf *relay_open_buf(struct rchan *chan,
-					const char *filename,
-					struct dentry *parent,
-					int *is_global)
+struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
 {
-	struct rchan_buf *buf;
+	struct rchan_buf *buf = NULL;
 	struct dentry *dentry;
+	char *tmpname;
 
-	if (*is_global)
+	if (chan->is_global) {
+		kref_get(&chan->buf[0]->krefw);
 		return chan->buf[0];
+	}
+
+	tmpname = kmalloc(NAME_MAX + 1, GFP_KERNEL);
+	if (!tmpname)
+		goto end;
+	sprintf(tmpname, "%s%d", chan->base_filename, cpu);
 
 	buf = relay_create_buf(chan);
 	if (!buf)
-		return NULL;
+		goto free_name;
+
+	buf->cpu = cpu;
+	__relay_reset(buf, 1);
 
 	/* Create file in fs */
-	dentry = chan->cb->create_buf_file(filename, parent, S_IRUSR,
-					   buf, is_global);
-	if (!dentry) {
-		relay_destroy_buf(buf);
-		return NULL;
+	dentry = chan->cb->create_buf_file(tmpname, chan->parent, S_IRUSR,
+					   buf, &chan->is_global);
+	if (!dentry)
+		goto free_buf;
+
+	if(chan->is_global) {
+		chan->buf[0] = buf;
+		buf->cpu = 0;
 	}
 
 	buf->dentry = dentry;
-	__relay_reset(buf, 1);
+	goto free_name;
 
+free_buf:
+	relay_destroy_buf(buf);
+free_name:
+	kfree(tmpname);
+end:
 	return buf;
 }
+EXPORT_SYMBOL_GPL(relay_open_buf);
 
 /**
- *	relay_close_buf - close a channel buffer
- *	@buf: channel buffer
+ *	relay_close_write_buf - close write to a channel buffer
+ *	@kref: buffer writers reference
  *
  *	Marks the buffer finalized and restores the default callbacks.
  *	The channel buffer and channel buffer data structure are then freed
  *	automatically when the last reference is given up.
  */
-static inline void relay_close_buf(struct rchan_buf *buf)
+static void relay_close_write_buf(struct kref *kref)
 {
+	struct rchan_buf *buf = container_of(kref, struct rchan_buf, krefw);
+
 	buf->finalized = 1;
 	cancel_delayed_work(&buf->wake_readers);
 	flush_scheduled_work();
 	kref_put(&buf->kref, relay_remove_buf);
 }
 
+/**
+ *	relay_close_buf - close a channel buffer
+ *	@buf: channel buffer
+ *	
+ *	Remove a writer reference.
+ */
+
+void relay_close_buf(struct rchan_buf *buf)
+{
+	kref_put(&buf->krefw, relay_close_write_buf);
+}
+EXPORT_SYMBOL_GPL(relay_close_buf);
+
 static inline void setup_callbacks(struct rchan *chan,
 				   struct rchan_callbacks *cb)
 {
@@ -446,6 +493,45 @@ static inline void setup_callbacks(struc
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
  *	@parent: dentry of parent directory, NULL for root directory
@@ -464,13 +550,11 @@ struct rchan *relay_open(const char *bas
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
 
@@ -485,38 +569,40 @@ struct rchan *relay_open(const char *bas
 	chan->n_subbufs = n_subbufs;
 	chan->subbuf_size = subbuf_size;
 	chan->alloc_size = FIX_SIZE(subbuf_size * n_subbufs);
+	chan->is_global = 0;
+	chan->parent = parent;
+	chan->private_data = private_data;
+	strcpy(chan->base_filename, base_filename);
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
-		if (!chan->buf[i])
-			break;
-		relay_close_buf(chan->buf[i]);
-		if (is_global)
-			break;
+	if (chan->is_global) {
+		if (chan->buf[0])
+			relay_close_buf(chan->buf[0]);
+	} else {
+		for_each_online_cpu(i) {
+			if (!chan->buf[i])
+				break;
+			relay_close_buf(chan->buf[i]);
+		}
 	}
-	kfree(tmpname);
 
-free_chan:
 	kref_put(&chan->kref, relay_destroy_channel);
+	unlock_cpu_hotplug();
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(relay_open);
@@ -616,24 +702,29 @@ EXPORT_SYMBOL_GPL(relay_subbufs_consumed
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
+	if (chan->is_global) {
+		if(chan->buf[0])
+			relay_close_buf(chan->buf[0]);
+	} else
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
 
@@ -646,17 +737,18 @@ EXPORT_SYMBOL_GPL(relay_close);
 void relay_flush(struct rchan *chan)
 {
 	unsigned int i;
-	struct rchan_buf *prev = NULL;
 
 	if (!chan)
 		return;
-
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!chan->buf[i] || chan->buf[i] == prev)
-			break;
-		relay_switch_subbuf(chan->buf[i], 0);
-		prev = chan->buf[i];
-	}
+	lock_cpu_hotplug();
+	if (chan->is_global) {
+		if(chan->buf[0])
+			relay_switch_subbuf(chan->buf[0], 0);
+	} else
+		for_each_possible_cpu(i)
+			if (chan->buf[i])
+				relay_switch_subbuf(chan->buf[i], 0);
+	unlock_cpu_hotplug();
 }
 EXPORT_SYMBOL_GPL(relay_flush);
 
@@ -1010,3 +1102,12 @@ struct file_operations relay_file_operat
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
@@ -332,10 +332,9 @@ static int blk_trace_setup(request_queue
 	if (!bt->dropped_file)
 		goto err;
 
-	bt->rchan = relay_open("trace", dir, buts.buf_size, buts.buf_nr, &blk_relay_callbacks);
+	bt->rchan = relay_open("trace", dir, buts.buf_size, buts.buf_nr, &blk_relay_callbacks, bt);
 	if (!bt->rchan)
 		goto err;
-	bt->rchan->private_data = bt;
 
 	bt->act_mask = buts.act_mask;
 	if (!bt->act_mask)
--END--

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
