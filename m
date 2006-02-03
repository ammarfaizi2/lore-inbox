Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWBCBqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWBCBqW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 20:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWBCBqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 20:46:22 -0500
Received: from fmr18.intel.com ([134.134.136.17]:48270 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932507AbWBCBqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 20:46:22 -0500
Subject: [RFC][PATCH 001 of 3] MD Acceleration: Base ADMA interface
From: Dan Williams <dan.j.williams@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 18:46:20 -0700
Message-Id: <1138931180.6620.9.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a draft implementation of the ADMA interface.  The basic premise
is an interface that receives descriptors from a client and processes
them in a separate thread.  The descriptors address a wide range of
commands (xor, copy, compare, etc).  

On the front end a client can assume that operations queued to an engine
will be executed in queued order.  On the backend it is expected that
multiple hardware DMA channels may comprise a single ADMA engine.  For
example an XOR channel and a normal memory copy channel could be
presented to a client as a single ADMA engine.

The descriptor should remain under complete control of the engine.  This
allows the backend engine code to format the descriptor according to any
hardware requirements/constraints.  For this reason all access to
descriptor variables from the client side is through accessor routines.
Later on theses routines will take into account engine specific
descriptor constraints.

For now this code makes some pio_adma_engine assumptions which will be
addressed in future releases.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>

diff --git a/drivers/adma/Kconfig b/drivers/adma/Kconfig
new file mode 100644
index 0000000..772bd44
--- /dev/null
+++ b/drivers/adma/Kconfig
@@ -0,0 +1,16 @@
+menu "Asynchronous memory engine support (ADMA)"
+
+config ADMA
+	bool "Support asynchronous memory engines"
+	help
+	  Support asynchronous (hardware acceleratated) dma, xor, memset, etc... 
+	  Required for RAID 5/6.
+
+config PIO_ADMA
+	bool "Software ADMA engine implementation"
+	depends on ADMA
+	help
+	  Select this option to use a soft engine rather than a hardware accelerated
+	  ADMA engine
+
+endmenu
diff --git a/drivers/adma/Makefile b/drivers/adma/Makefile
new file mode 100644
index 0000000..2d1d640
--- /dev/null
+++ b/drivers/adma/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_ADMA)		+= adma.o
+obj-$(CONFIG_PIO_ADMA)		+= pio_adma.o
diff --git a/drivers/adma/adma.c b/drivers/adma/adma.c
new file mode 100755
index 0000000..aa6d85e
--- /dev/null
+++ b/drivers/adma/adma.c
@@ -0,0 +1,255 @@
+/*
+ * adma.c : Asychronous Memory Manipulation client interface
+ * Author: Dan Williams (dan.j.williams@intel.com)
+ * Copyright (C) 2006 Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kthread.h>
+#include <linux/adma/adma.h>
+
+/*
+ * The following can be used to debug the driver
+ */
+#define ADMA_DEBUG     0
+#define PRINTK(x...) ((void)(ADMA_DEBUG && printk(x)))
+
+#if ADMA_DEBUG
+#define dump_desc(x) { printk("%s: ", __FUNCTION__); __dump_desc(x);}
+/* Note: needs to change if engine internally modifies the 
+ * format of adma_desc_t
+ */
+static void __dump_desc(adma_desc_t *desc)
+{
+	int i;
+	if (desc) {
+		printk("desc[%p] command[%d] flags[%lu] len[%d] sources[%d] ops[%d]\n",
+		desc,
+		desc->command, 
+		desc->flags,
+		desc->len,
+		desc->sources,
+		atomic_read(&desc->engine->ops_pending));
+		for (i = 0; i < desc->sources; i++)
+			printk("\tsource[%d]: %p\n", i, desc->buf[i]);
+	} else printk("ERROR: NULL descriptor\n");
+}
+#else
+#define dump_desc(x) do {} while(0)
+#endif
+
+/* let the client know how much we can handle */
+static inline void adma_set_source_count(adma_engine_t *eng, int count)
+{
+	eng->max_source_count = count;
+}
+
+/* add descriptor to the process list and conditionally initiate operations */
+void adma_queue_desc(adma_desc_t *desc, int wake)
+{
+	adma_engine_t *eng = desc->engine;
+
+	spin_lock(&eng->lock);
+	list_add_tail(&desc->chain, &eng->desc_chain);
+	atomic_inc(&eng->ops_pending);
+	spin_unlock(&eng->lock);
+
+	if (wake) adma_wakeup_thread(eng->thread);
+
+	dump_desc(desc);
+}
+
+/* yet another place holder that changes once hw engines are defined */
+void adma_check_status(adma_desc_t *desc)
+{
+	set_bit(ADMA_STAT_DONE, &desc->flags);
+}
+
+/*
+ * This thread churns through the descriptor chain
+ * Runs the command and if necessary calls the callback function.
+ * Note: This thread makes pio_adma_engine assumptions for now
+ */
+void adma_run(adma_engine_t *eng)
+{
+	adma_desc_t *desc, *prev_desc;
+	int op = 0;
+
+	while(1) {
+		struct list_head *first;
+
+		spin_lock(&eng->lock);
+		if (list_empty(&eng->desc_chain))
+			break;
+
+		first = eng->desc_chain.next;
+
+		/* will be used to satisfy ordering requirements for adma
+		 * engines that process copy and xor operatations on different
+		 * channels 
+		 */ 
+		prev_desc = op++ ? desc : NULL;
+		desc = list_entry(first, adma_desc_t, chain);
+		dump_desc(desc);
+
+		list_del_init(first);
+
+		atomic_dec(&eng->ops_pending);
+		spin_unlock(&eng->lock);
+		
+		switch(desc->command) {
+			case ADMA_COPY:
+				eng->cpy_op(desc->buf[0], desc->buf[1], desc->len);
+				break;
+			case ADMA_SET:
+				eng->set_block_op(desc->sources, desc->len, desc->buf, desc->pattern);
+				break;
+			case ADMA_COMPARE:
+				if (eng->cmp_op(desc->buf[0], 
+				    desc->buf[1], 
+				    desc->len))
+					set_bit(ADMA_STAT_CMP, &desc->flags);
+				else
+					clear_bit(ADMA_STAT_CMP, &desc->flags);
+				break;
+			case ADMA_XOR:
+				eng->xor_block_op(desc->sources, desc->len, desc->buf);
+				break;
+			case ADMA_PQXOR:
+				printk("%s: Error ADMA_PQXOR not yet implemented\n", __FUNCTION__);
+				BUG();
+				break;
+		}
+		adma_check_status(desc);
+
+		if(desc->callback)
+			desc->callback(desc, desc->args);
+		else if(test_bit(ADMA_AUTO_REAP, &desc->flags)) {
+			BUG_ON(desc->args != NULL);
+			adma_put_desc(desc);
+		}
+	}
+	spin_unlock(&eng->lock);
+}
+
+static int adma_thread(void * arg)
+{
+	adma_thread_t *thread = arg;
+
+	/*
+	 * This thread handles:
+	 *	> issuing descriptors to an adma engine
+	 *	> maintaining order between dependent operations
+	 *	> garbage collecting descriptor resources (upon request)
+	 *	> running the pio version of an operation when underlying
+	 *	  hardware support is not present
+	 */
+
+	allow_signal(SIGKILL);
+	while (!kthread_should_stop()) {
+
+		/* We need to wait INTERRUPTIBLE so that
+		 * we don't add to the load-average.
+		 * That means we need to be sure no signals are
+		 * pending
+		 */
+		if (signal_pending(current))
+			flush_signals(current);
+
+		wait_event_interruptible_timeout
+			(thread->wqueue,
+			 test_bit(THREAD_WAKEUP, &thread->flags)
+			 || kthread_should_stop(),
+			 thread->timeout);
+		try_to_freeze();
+
+		clear_bit(THREAD_WAKEUP, &thread->flags);
+
+		thread->run(thread->eng);
+	}
+
+	return 0;
+}
+
+adma_thread_t *adma_register_thread(void (*run) (adma_engine_t *), adma_engine_t *eng)
+{
+	adma_thread_t *thread;
+	static int cnt = 0;
+
+	thread = kzalloc(sizeof(adma_thread_t), GFP_KERNEL);
+	if (!thread)
+		return NULL;
+
+	init_waitqueue_head(&thread->wqueue);
+
+	thread->run = run;
+	thread->eng = eng;
+	thread->timeout = MAX_SCHEDULE_TIMEOUT;
+	thread->tsk = kthread_run(adma_thread, thread, "adma%d", cnt++);
+	if (IS_ERR(thread->tsk)) {
+		kfree(thread);
+		return NULL;
+	}
+	return thread;
+}
+
+/* initialize the adma engine params */
+/* TODO: hw adma support w/ auto engine select */
+extern adma_engine_t pio_adma_engine;
+adma_engine_t *adma_engine_init(void)
+{
+	/* hard code the selection of the pio_adma_engine for now */
+	adma_engine_t *eng = &pio_adma_engine;
+	size_t desc_size = sizeof(adma_desc_t);
+	int src_cnt;
+
+	INIT_LIST_HEAD(&eng->desc_chain);
+	spin_lock_init(&eng->lock);
+	
+	src_cnt = adma_get_source_count(eng);
+	if (src_cnt > MAX_ADMA_SOURCE_BLOCKS) {
+		src_cnt = MAX_ADMA_SOURCE_BLOCKS;
+		adma_set_source_count(eng, src_cnt);
+	}
+	
+	/* adjust size for the source buffer count */
+	desc_size += sizeof(void**) * (src_cnt - 1);
+
+	/* if we fail to allocate a cache then it is assumed that 
+	 * clients will know how to get their work done in a pio
+	 * fashion.
+	 */
+	eng->desc_cache = kmem_cache_create(eng->desc_cache_name,
+					    desc_size, 
+					    0, 0, NULL, NULL);
+
+	eng->thread = adma_register_thread(adma_run, eng);
+
+	if (!eng->thread && eng->desc_cache)
+		kmem_cache_destroy(eng->desc_cache);
+
+	printk("%s: %s[%d]\n", __FUNCTION__, 
+				    eng->desc_cache_name,
+				    eng->desc_cache ? 1 : 0);
+
+	return eng->thread ? eng : NULL;
+}
+
+void adma_wakeup_thread(adma_thread_t *thread)
+{
+	if (thread) {
+		PRINTK("adma: waking up ADMA thread %s.\n", thread->tsk->comm);
+		set_bit(THREAD_WAKEUP, &thread->flags);
+		wake_up(&thread->wqueue);
+	}
+}
+
+void adma_unregister_thread(adma_thread_t *thread)
+{
+	PRINTK("interrupting ADMA-thread pid %d\n", thread->tsk->pid);
+
+	kthread_stop(thread->tsk);
+	kfree(thread);
+}
diff --git a/drivers/adma/pio_adma.c b/drivers/adma/pio_adma.c
new file mode 100755
index 0000000..9ed7471
--- /dev/null
+++ b/drivers/adma/pio_adma.c
@@ -0,0 +1,91 @@
+/*
+ * pio_adma.c : Software implementation for an ADMA engine
+ * Author: Dan Williams (dan.j.williams@intel.com)
+ * Copyright (C) 2006 Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/adma/adma.h>
+#include <linux/raid/raid5.h>
+#include <asm/string.h>
+
+adma_engine_t pio_adma_engine;
+
+/**
+ * adma_pio_set_block - run memset against a series of blocks
+ * @count: number of target blocks
+ * @bytes: buffer size
+ * @ptr: array of source buffers
+ * @pattern: pattern to set
+ */
+static void adma_pio_set_block(unsigned int count, unsigned int bytes, void **ptr, int pattern)
+{
+	unsigned int i;
+
+	for(i = 0; i < count; i++)
+		memset(ptr[i], pattern, bytes);
+}
+
+/**
+ * adma_pio_build_desc - build a descriptor for the pio adma engine
+ * @desc: if set this descriptor buffer is used instead of alloc
+ * @command: operation to be carried out
+ * @ptr: array of source buffers
+ * @sources: number of source buffers
+ * @len: size of source buffers or transfer length
+ * @pattern: pattern to set (n/a for non memcmp operations)
+ */
+static adma_desc_t *adma_pio_build_desc(adma_desc_t *desc, int command, 
+					     void **ptr, int sources, 
+					     size_t len, int pattern)
+{
+	int i;
+	if (!desc) desc = adma_get_desc(&pio_adma_engine);
+
+	if (desc) { 
+		INIT_LIST_HEAD(&desc->chain);
+		desc->command = command;
+		desc->engine = &pio_adma_engine;
+		desc->sources = sources;
+		desc->len = len;
+		desc->pattern = pattern;
+		desc->flags = 0;
+		desc->state = 0;
+		desc->callback = NULL;
+		desc->args = NULL;
+		for (i = 0; i < sources; i++)
+			desc->buf[i] = ptr[i];
+	}
+
+	return desc;
+}
+
+/* define our own memcpy since some archs might make memcpy a #define */
+static inline void *adma_pio_memcpy(void *dest, const void *src, size_t len)
+{
+	return memcpy(dest, src, len);
+}
+
+/* define our own memcmp since some archs might make memcmp a #define */
+static inline int adma_pio_memcmp(const void *buf1, const void *buf2, size_t len)
+{
+	return memcmp(buf1, buf2, len);
+}
+
+
+adma_engine_t pio_adma_engine = {
+	.max_source_count = MAX_XOR_BLOCKS,
+	.desc_cache_name = "pio_adma_desc",
+	.callback_cache_name = "pio_adma_cb",
+	.build_desc = adma_pio_build_desc,
+	.queue_desc = adma_queue_desc,
+	.set_block_op = adma_pio_set_block,
+	.xor_block_op = xor_block,
+	.cpy_op = adma_pio_memcpy,
+	.cmp_op = adma_pio_memcmp,
+	.flags = (1 << ADMA_ENG_CAP_COPY) | (1 << ADMA_ENG_CAP_SET) | 
+		 (1 << ADMA_ENG_CAP_COMPARE) | (1 << ADMA_ENG_CAP_XOR),
+
+};
diff --git a/include/linux/adma/adma.h b/include/linux/adma/adma.h
new file mode 100755
index 0000000..442386d
--- /dev/null
+++ b/include/linux/adma/adma.h
@@ -0,0 +1,132 @@
+#ifndef _ADMA_H
+#define _ADMA_H
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+
+struct adma_engine;
+typedef struct adma_thread {
+	void			(*run) (struct adma_engine *eng);
+	struct adma_engine 	*eng;
+	wait_queue_head_t	wqueue;
+	unsigned long           flags;
+	struct task_struct	*tsk;
+	unsigned long		timeout;
+} adma_thread_t;
+
+/* Client code should not depend on the format or 
+ * size of this structure, and should use the 
+ * eng->build_desc and adma_desc* routines to
+ * setup / modify a descriptor
+ */
+typedef struct adma_desc {
+	struct list_head chain;
+	int 		 command;
+	size_t 		 len;		      /* transaction size */
+	int		 sources;
+	int		 pattern;	      /* pattern for memset type operations */
+	unsigned long	 flags;
+	struct 		 adma_engine *engine;
+	void 		 (*callback)(struct adma_desc *, void *);
+	void		 *args;		      /* parameters for the callback  */
+	int		 state;		      /* a generic integer for clients to use in callbacks */
+	void 		 *buf[1];	      /* array entry per num sources (grows at init time) */
+} adma_desc_t;
+
+typedef struct adma_engine {
+	int 		 max_source_count;
+	struct list_head desc_chain;	      /* descriptor chain */
+	char		 desc_cache_name[20];
+	char		 callback_cache_name[20];
+	kmem_cache_t	 *desc_cache; 	      /* for allocating descriptors */
+	spinlock_t	 lock;
+	atomic_t	 ops_pending;
+	adma_thread_t	 *thread;
+	unsigned long	 flags;		      /* engine capabilities */
+	adma_desc_t *(*build_desc) (adma_desc_t *, int, void **, int, size_t, int);
+	void (*queue_desc)(adma_desc_t *, int);
+	void (*xor_block_op) (unsigned int, unsigned int, void **);
+	void (*set_block_op) (unsigned int, unsigned int, void **, int);
+	void *(*cpy_op) (void *, const void *, size_t);
+	int (*cmp_op) (const void *, const void *, size_t);
+	/* void (*pqxor_op) (); TODO for raid6 */
+	/* void (*crc_op) (); TODO since hardware support exists */
+} adma_engine_t;
+
+extern void adma_queue_desc(adma_desc_t *desc, int wake);
+extern adma_engine_t *adma_engine_init(void);
+extern void adma_run(adma_engine_t *eng);
+extern void adma_wakeup_thread(adma_thread_t *thread);
+
+static inline void adma_set_desc_flags(adma_desc_t *desc, int flags)
+{
+	desc->flags = flags;
+}
+
+/* return buffer for client to submit desc */
+static inline adma_desc_t *adma_get_desc(adma_engine_t *eng)
+{
+	if (eng->desc_cache)
+		return kmem_cache_alloc(eng->desc_cache, GFP_KERNEL);
+	else
+		return NULL;
+}
+
+static inline void adma_set_callback(adma_desc_t *desc, 
+					 void (*cb)(adma_desc_t *, void *), 
+					 void *args, int state)
+{
+	desc->callback = cb;
+	desc->args = args;
+	desc->state = state;
+}
+
+/* let the client know how much we can handle */
+static inline int adma_get_source_count(adma_engine_t *eng)
+{
+	return eng->max_source_count;
+}
+
+/* free the desc */
+static inline void adma_put_desc(adma_desc_t *desc)
+{
+	kmem_cache_free(desc->engine->desc_cache, desc);
+	desc = NULL;
+}
+
+static inline int adma_get_callback_state(adma_desc_t *desc)
+{
+	return desc->state;
+}
+
+#define MAX_ADMA_SOURCE_BLOCKS 16
+#define THREAD_WAKEUP  0
+
+/* ADMA commands */
+#define ADMA_COPY	0 /* memcpy */
+#define ADMA_SET	1 /* memset */
+#define ADMA_COMPARE	2 /* memcmp */
+#define ADMA_XOR	3 /* raid 5/6 */
+#define ADMA_PQXOR	4 /* raid 6 */
+
+/* Engine HW Capability Flags */
+#define ADMA_ENG_CAP_COPY	1
+#define ADMA_ENG_CAP_SET	2
+#define ADMA_ENG_CAP_COMPARE	3
+#define ADMA_ENG_CAP_XOR	4
+#define ADMA_ENG_CAP_PQXOR	5
+#define ADMA_ENG_CAP_CRC32	6
+#define ADMA_ENG_CAP_HIGHMEM	7
+
+/* Descriptor Flags */
+#define ADMA_AUTO_REAP 	1 /* adma_thread handles freeing the descriptor */
+#define ADMA_STAT_DONE		2 /* finished operations */
+#define ADMA_STAT_CMP		3 /* compare operation result */
+#define ADMA_STAT_ERROR	4 /* descriptor operation failed */
+
+
+static inline void adma_spin_wait_desc(adma_desc_t *desc)
+{
+	do {} while(!test_bit(ADMA_STAT_DONE, &desc->flags));
+}
+#endif


