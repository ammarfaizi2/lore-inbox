Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbUKXP34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbUKXP34 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 10:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbUKXN1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:27:02 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:61588 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262643AbUKXNDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:03:07 -0500
Subject: Suspend 2 merge: 27/51: Block I/O module.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101296756.5805.296.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:59:23 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the code that does all the really hard work in reading and
writing the image. It provides full asynchronous I/O, and in combination
with the layer above, readahead where I/O needs to be synchronous (image
decompression). I/O is also batched to further improve throughput. Some
of the key parameters are user tunable, as the best setting varies from
computer to computer.

diff -ruN 812-suspend2-block-io-module-old/kernel/power/suspend_block_io.c 812-suspend2-block-io-module-new/kernel/power/suspend_block_io.c
--- 812-suspend2-block-io-module-old/kernel/power/suspend_block_io.c	1970-01-01 10:00:00.000000000 +1000
+++ 812-suspend2-block-io-module-new/kernel/power/suspend_block_io.c	2004-11-23 22:18:49.000000000 +1100
@@ -0,0 +1,827 @@
+/*
+ * block_io.c
+ *
+ * Copyright 2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * Distributed under GPLv2.
+ * 
+ * This file contains block io functions for suspend2. These are
+ * used by the swapwriter and it is planned that they will also
+ * be used by the NFSwriter.
+ *
+ */
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/highmem.h>
+#include <linux/blkdev.h>
+#include <linux/bio.h>
+#include <linux/kthread.h>
+
+#include "suspend.h"
+#include "block_io.h"
+#include "proc.h"
+#include "plugins.h"
+
+/* Bits in struct io_info->flags */
+#define IO_WRITING 1
+#define IO_RESTORE_PAGE_PROT 2
+#define IO_AWAITING_READ 3
+#define IO_AWAITING_WRITE 4
+#define IO_CLEANUP_IN_PROGRESS 5
+#define IO_HANDLE_PAGE_PROT 6
+
+#define USE_KEVENTD
+//#define TUNE_BATCHING
+
+/*
+ * ---------------------------------------------------------------
+ *
+ *     IO in progress information storage and helpers
+ *
+ * ---------------------------------------------------------------
+ */
+
+struct io_info {
+	struct bio * sys_struct;
+	long blocks[PAGE_SIZE/512];
+	struct page * buffer_page;
+	struct page * data_page;
+	unsigned long flags;
+	struct block_device * dev;
+	int blocks_used;
+	int block_size;
+	struct list_head list;
+	int readahead_index;
+	struct work_struct work;
+};
+
+static LIST_HEAD(ioinfo_free);
+static LIST_HEAD(ioinfo_ready_for_cleanup);
+static LIST_HEAD(ioinfo_busy);
+static LIST_HEAD(ioinfo_submit_batch);
+static spinlock_t ioinfo_lists_lock = SPIN_LOCK_UNLOCKED;
+
+static int submit_batch = 0, submit_batch_size = 32;
+static void submit_batched(void);
+
+struct task_struct * suspend_bio_task;
+
+/* [Max] number of I/O operations pending */
+static atomic_t outstanding_io;
+static int max_outstanding_io = 0;
+static int buffer_allocs, buffer_frees;
+
+/* [Max] number of pages used for above struct */
+static int infopages = 0;
+static int maxinfopages = 0;
+
+static volatile unsigned long suspend_readahead_flags[((MAX_READAHEAD + (8 * sizeof(unsigned long) - 1)) / (8 * sizeof(unsigned long)))];
+static spinlock_t suspend_readahead_flags_lock = SPIN_LOCK_UNLOCKED;
+static struct page * suspend_readahead_pages[MAX_READAHEAD];
+
+static unsigned long nr_schedule_calls[6];
+static unsigned long bio_jiffies = 0;
+
+static char * sch_caller[] = {
+	"get_io_info_struct       ",
+	"suspend_finish_all_io    ",
+	"wait_on_one_page         ",
+	"submit                   ",
+	"start_one                ",
+	"suspend_wait_on_readahead",
+};
+
+static void suspend_io_cleanup(void * data);
+
+static void do_bio_wait(int caller)
+{
+#ifndef USE_KEVENTD
+	int num_cleaned = 0;
+	struct io_info * this, * next = NULL;
+#endif
+	int device;
+
+	nr_schedule_calls[caller]++;
+	
+	/* Don't want to wait on I/O we haven't submitted! */
+	submit_batched();
+
+#ifndef USE_KEVENTD
+	if (!list_empty(&ioinfo_ready_for_cleanup))
+		list_for_each_entry_safe(this, next, &ioinfo_ready_for_cleanup, list) {
+			suspend_io_cleanup((void *) this);
+			num_cleaned++;
+			if (num_cleaned == 32)
+				break;
+		}
+#endif
+	for (device = 0; device < MAX_SWAPFILES; device++) {
+		struct block_device * bdev = swap_info[device].bdev;
+		if (bdev) {
+			request_queue_t * q = bdev_get_queue(bdev);
+			if (q && q->unplug_fn)
+				q->unplug_fn(q);
+		}
+		/* kblockd_flush(); io_schedule(); */
+	}
+	schedule();
+}
+
+/*
+ * cleanup_one
+ * 
+ * Description: Clean up after completing I/O on a page.
+ * Arguments:	struct io_info:	Data for I/O to be completed.
+ */
+static inline void cleanup_one(struct io_info * io_info)
+{
+	struct page * buffer_page;
+	struct page * data_page;
+	char *buffer_address, *data_address;
+	int reading;
+
+	buffer_page = io_info->buffer_page;
+	data_page = io_info->data_page;
+
+	/* 
+	 * Already being cleaned up? Can't happen while we're single
+	 * threaded, but a good check for later.
+	 */
+	
+	if (test_and_set_bit(IO_CLEANUP_IN_PROGRESS, &io_info->flags))
+		return;
+
+	reading = test_bit(IO_AWAITING_READ, &io_info->flags);
+	suspend_message(SUSPEND_WRITER, SUSPEND_HIGH, 0,
+		"Cleanup IO: [%p]\n", 
+		io_info);
+
+	if (reading && io_info->readahead_index == -1) {
+		/*
+		 * Copy the page we read into the buffer our caller provided.
+		 */
+		data_address = (char *) kmap(data_page);
+		buffer_address = (char *) kmap(buffer_page);
+		memcpy(data_address, buffer_address, PAGE_SIZE);
+		flush_dcache_page(data_page);
+		kunmap(data_page);
+		kunmap(buffer_page);
+	
+	}
+
+	if (!reading || io_info->readahead_index == -1) {
+		/* Sanity check */
+		if (page_count(buffer_page) != 2)
+			printk(KERN_EMERG "Cleanup IO: Page count is %d. Not good!\n",
+					page_count(buffer_page));
+		put_page(buffer_page);
+		__free_pages(buffer_page, 0);
+		buffer_frees++;
+	} else
+		put_page(buffer_page);
+	
+	atomic_dec(&outstanding_io);
+	bio_put(io_info->sys_struct);
+	io_info->sys_struct = NULL;
+	io_info->flags = 0;
+}
+
+/*
+ * get_io_info_struct
+ *
+ * Description:	Get an I/O struct.
+ * Returns:	Pointer to the struct prepared for use.
+ */
+static struct io_info * get_io_info_struct(void)
+{
+	unsigned long newpage = 0, flags;
+	struct io_info * this = NULL;
+	int remaining = 0;
+
+	do {
+		/* Have we reached our number-of-IOs-activate-at-one limit? */
+		if ((max_async_ios) && (atomic_read(&outstanding_io) >= max_async_ios)) {
+			do_bio_wait(0);
+			continue;
+		}
+
+		/* Can start a new I/O. Is there a free one? */
+		if (!list_empty(&ioinfo_free)) {
+			/* Yes. Grab it. */
+			spin_lock_irqsave(&ioinfo_lists_lock, flags);
+			break;
+		}
+
+		/* No. Need to allocate a new page for I/O info structs. */
+		newpage = get_zeroed_page(GFP_ATOMIC);
+		if (!newpage)
+			continue;
+
+		suspend_message(SUSPEND_MEMORY, SUSPEND_VERBOSE, 0,
+				"[NewIOPage %lx]", newpage);
+		infopages++;
+		if (infopages > maxinfopages)
+			maxinfopages++;
+
+		/* Prepare the new page for use. */
+		this = (struct io_info *) newpage;
+		remaining = PAGE_SIZE;
+		spin_lock_irqsave(&ioinfo_lists_lock, flags);
+		while (remaining >= (sizeof(struct io_info))) {
+			list_add_tail(&this->list, &ioinfo_free);
+			this = (struct io_info *) (((char *) this) + 
+					sizeof(struct io_info));
+			remaining -= sizeof(struct io_info);
+		}
+		break;
+	} while (1);
+
+	/* We have an I/O info struct. Move it to the busy list. */
+	this = list_entry(ioinfo_free.next, struct io_info, list);
+	list_move_tail(&this->list, &ioinfo_busy);
+	spin_unlock_irqrestore(&ioinfo_lists_lock, flags);
+	return this;
+}
+
+/*
+ * suspend_finish_all_io
+ *
+ * Description:	Finishes all IO and frees all IO info struct pages.
+ */
+static void suspend_finish_all_io(void)
+{
+	struct io_info * this, * next = NULL;
+	unsigned long flags;
+
+	/* Submit any pending write batch */
+	submit_batched();
+
+	/* Wait for all I/O to complete. */
+	while (atomic_read(&outstanding_io))
+		do_bio_wait(1);
+
+	/*
+	 * We're single threaded and all I/O is completed, so we shouldn't
+	 * need to use the spinlock, but let's be safe.
+	 */
+	spin_lock_irqsave(&ioinfo_lists_lock, flags);
+	
+	/* 
+	 * Two stages, to avoid using freed pages.
+	 *
+	 * First free all io_info structs on a page except the first.
+	 */
+	list_for_each_entry_safe(this, next, &ioinfo_free, list) {
+		if (((unsigned long) this) & ~PAGE_MASK)
+			list_del(&this->list);
+	}
+
+	/* 
+	 * Now we have only one reference to each page, and can safely
+	 * free pages, knowing we're not going to be trying to access the
+	 * same page after freeing it.
+	 */
+	list_for_each_entry_safe(this, next, &ioinfo_free, list) {
+		list_del(&this->list);
+		free_pages((unsigned long) this, 0);
+		infopages--;
+		suspend_message(SUSPEND_MEMORY, SUSPEND_VERBOSE, 0,
+				"[FreedIOPage %lx]", this);
+	}
+	
+	spin_unlock_irqrestore(&ioinfo_lists_lock, flags);
+}
+
+/*
+ * wait_on_one_page
+ *
+ * Description:	Wait for a particular I/O to complete.
+ */
+static void wait_on_one_page(struct io_info * io_info)
+{
+	do { do_bio_wait(2); } while (io_info->flags);
+}
+
+/*
+ * suspend_reset_io_stats
+ *
+ * Description:	Reset all our sanity-checking statistics.
+ */
+static void suspend_reset_io_stats(void)
+{
+	int i;
+	
+	max_outstanding_io = 0;
+	maxinfopages = 0;
+	buffer_allocs = buffer_frees = 0;
+	
+	for (i = 0; i < 6; i++)
+		nr_schedule_calls[i] = 0;
+	bio_jiffies = 0;
+}
+
+/*
+ * suspend_check_io_stats
+ *
+ * Description:	Check that our statistics look right and print
+ * 		any debugging info wanted.
+ */
+static void suspend_check_io_stats(void)
+{
+	int i;
+
+	BUG_ON(atomic_read(&outstanding_io));
+	BUG_ON(infopages);
+	BUG_ON(buffer_allocs != buffer_frees);
+	BUG_ON(!list_empty(&ioinfo_busy));
+	BUG_ON(!list_empty(&ioinfo_ready_for_cleanup));
+	BUG_ON(!list_empty(&ioinfo_free));
+
+	if (atomic_read(&outstanding_io))
+		suspend_message(SUSPEND_WRITER, SUSPEND_MEDIUM, 0,
+			"Outstanding_io after writing is %d.\n",
+			atomic_read(&outstanding_io));
+	suspend_message(SUSPEND_WRITER, SUSPEND_LOW, 0,
+			"Maximum outstanding_io was %d.\n",
+			max_outstanding_io);
+	if (infopages)
+		suspend_message(SUSPEND_WRITER, SUSPEND_MEDIUM, 0,
+				"Info pages is %d.\n",
+				infopages);
+	suspend_message(SUSPEND_WRITER, SUSPEND_LOW, 0,
+			"Max info pages was %d.\n",
+			maxinfopages);
+	if (buffer_allocs != buffer_frees)
+		suspend_message(SUSPEND_WRITER, SUSPEND_MEDIUM, 0,
+			"Buffer allocs (%d) != buffer frees (%d)",
+				buffer_allocs,
+				buffer_frees);
+	for(i = 0; i < 6; i++)
+		suspend_message(SUSPEND_WRITER, SUSPEND_MEDIUM, 0,
+			"Nr schedule calls %s: %lu.\n", sch_caller[i], nr_schedule_calls[i]);
+	suspend_message(SUSPEND_WRITER, SUSPEND_MEDIUM, 0,
+		"Jiffies waiting for bio calls:%lu.\n", bio_jiffies);
+}
+
+/* suspend_io_cleanup
+ */
+
+static void suspend_io_cleanup(void * data)
+{
+	struct io_info * io_info = (struct io_info *) data;
+	int readahead_index;
+	unsigned long flags;
+
+	/*
+	 * If this I/O was a readahead, remember its index.
+	 */
+	readahead_index = io_info->readahead_index;
+
+	/*
+	 * Do the cleanup.
+	 */
+	cleanup_one(io_info);
+
+	/*
+	 * Record the readahead as done.
+	 */
+	if (readahead_index > -1) {
+		int index = readahead_index/(8 * sizeof(unsigned long));
+		int bit = readahead_index - (index * 8 * sizeof(unsigned long));
+		spin_lock_irqsave(&suspend_readahead_flags_lock, flags);
+		set_bit(bit, &suspend_readahead_flags[index]);
+		spin_unlock_irqrestore(&suspend_readahead_flags_lock, flags);
+	}
+
+	/*
+	 * Add it to the free list.
+	 */
+	spin_lock_irqsave(&ioinfo_lists_lock, flags);
+	list_move_tail(&io_info->list, &ioinfo_free);
+	spin_unlock_irqrestore(&ioinfo_lists_lock, flags);
+}
+
+/*
+ * suspend_end_bio
+ *
+ * Description:	Function called by block driver from interrupt context when I/O
+ * 		is completed. This is the reason we use spinlocks in
+ * 		manipulating the io_info lists. 		
+ * 		Nearly the fs/buffer.c version, but we want to mark the page as 
+ * 		done in our own structures too.
+ */
+
+static int suspend_end_bio(struct bio * bio, unsigned int num, int err)
+{
+	struct io_info *io_info = (struct io_info *) bio->bi_private;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ioinfo_lists_lock, flags);
+	list_move_tail(&io_info->list, &ioinfo_ready_for_cleanup);
+	spin_unlock_irqrestore(&ioinfo_lists_lock, flags);
+
+#ifdef USE_KEVENTD
+	INIT_WORK(&io_info->work, suspend_io_cleanup, (void *) io_info);
+	schedule_work(&io_info->work);
+#endif
+	return 0;
+}
+
+/**
+ *	submit - submit BIO request.
+ *	@rw:	READ or WRITE.
+ *	@io_info: IO info structure.
+ *
+ *	Straight from the textbook - allocate and initialize the bio.
+ *	If we're writing, make sure the page is marked as dirty.
+ *	Then submit it and carry on.
+ */
+
+static int submit(int rw, struct io_info * io_info)
+{
+	int error = 0;
+	struct bio * bio = NULL;
+	unsigned long j1 = jiffies;
+
+	while (!bio) {
+		bio = bio_alloc(GFP_ATOMIC,1);
+		if (!bio)
+			do_bio_wait(3);
+	}
+
+	bio->bi_sector = io_info->blocks[0] << (PAGE_SHIFT - 9);
+	bio->bi_bdev = io_info->dev;
+	bio->bi_private = io_info;
+	bio->bi_end_io = suspend_end_bio;
+	io_info->sys_struct = bio;
+
+	if (bio_add_page(bio, io_info->buffer_page, PAGE_SIZE, 0) < PAGE_SIZE) {
+		printk("ERROR: adding page to bio at %ld\n",
+				io_info->blocks[0]);
+		bio_put(bio);
+		return -EFAULT;
+	}
+
+	if (rw == WRITE)
+		bio_set_pages_dirty(bio);
+	submit_bio(rw,bio);
+	bio_jiffies += jiffies - j1;
+	return error;
+}
+
+/*
+ * suspend_set_block_size
+ *
+ * Description: Set the blocksize for a bdev. This is a separate function
+ * 		because we have different versions for 2.4 and 2.6.
+ */
+static int suspend_set_block_size(struct block_device * bdev, int size)
+{
+	return set_blocksize(bdev, size);
+}
+
+static int suspend_get_block_size(struct block_device * bdev)
+{
+	return block_size(bdev);
+}
+
+/* 
+ * We don't need to worry about new requests being added to the list;
+ * we're called from process context 
+ */
+static void submit_batched(void)
+{
+	unsigned long flags;
+	struct io_info * this, * next = NULL;
+	
+	list_for_each_entry_safe(this, next, &ioinfo_submit_batch, list) {
+		spin_lock_irqsave(&ioinfo_lists_lock, flags);
+		list_move_tail(&this->list, &ioinfo_busy);
+		spin_unlock_irqrestore(&ioinfo_lists_lock, flags);
+		if (test_bit(IO_AWAITING_READ, &this->flags))
+			submit(READ, this);
+		else
+			submit(WRITE, this);
+	}
+	submit_batch = 0;
+}
+static void add_to_batch(struct io_info * io_info)
+{
+	unsigned long flags;
+	
+	spin_lock_irqsave(&ioinfo_lists_lock, flags);
+	/* We have an I/O info struct. Move it to the batch list. */
+	list_move_tail(&io_info->list, &ioinfo_submit_batch);
+	spin_unlock_irqrestore(&ioinfo_lists_lock, flags);
+
+	submit_batch++;
+
+	if (submit_batch == submit_batch_size)
+		submit_batched();
+}
+/*
+ * start_one
+ *
+ * Description:	Prepare and start a read or write operation.
+ * 		Note that we use our own buffer for reading or writing.
+ * 		This simplifies doing readahead and asynchronous writing.
+ * 		We can begin a read without knowing the location into which
+ * 		the data will eventually be placed, and the buffer passed
+ * 		for a write can be reused immediately (essential for the
+ * 		plugins system).
+ * 		Failure? What's that?
+ * Returns:	The io_info struct created.
+ */
+static struct io_info * start_one(int rw, struct submit_params * submit_info)
+{
+	struct io_info * io_info = get_io_info_struct();
+	unsigned long buffer_virt = 0;
+	char * to, * from;
+	struct page * buffer_page;
+	int i;
+
+	if (!io_info)
+		return NULL;
+
+	/* Get our local buffer */
+	suspend_message(SUSPEND_WRITER, SUSPEND_HIGH, 1,
+			"Start_IO: [%p]", io_info);
+	
+	/* Copy settings to the io_info struct */
+	io_info->data_page = submit_info->page;
+	io_info->readahead_index = submit_info->readahead_index;
+
+	if (io_info->readahead_index == -1) {
+		while (!(buffer_virt = get_zeroed_page(GFP_ATOMIC)))
+			do_bio_wait(4);
+
+		buffer_allocs++;
+		suspend_message(SUSPEND_WRITER, SUSPEND_HIGH, 0,
+				"[ALLOC BUFFER]->%d",
+				real_nr_free_pages());
+		buffer_page = virt_to_page(buffer_virt);
+	
+		io_info->buffer_page = buffer_page;
+	} else {
+		unsigned long flags;
+		int index = io_info->readahead_index/(8 * sizeof(unsigned long));
+		int bit = io_info->readahead_index - index * 8 * sizeof(unsigned long);
+
+		spin_lock_irqsave(&suspend_readahead_flags_lock, flags);
+		clear_bit(bit, &suspend_readahead_flags[index]);
+		spin_unlock_irqrestore(&suspend_readahead_flags_lock, flags);
+
+		io_info->buffer_page = buffer_page = submit_info->page;
+	}
+
+	/* If writing, copy our data. The data is probably in
+	 * lowmem, but we cannot be certain. If there is no
+	 * compression/encryption, we might be passed the
+	 * actual source page's address. */
+	if (rw == WRITE) {
+		set_bit(IO_WRITING, &io_info->flags);
+
+		to = (char *) buffer_virt;
+		from = kmap_atomic(io_info->data_page, KM_USER1);
+		memcpy(to, from, PAGE_SIZE);
+		flush_dcache_page(io_info->data_page);
+		flush_dcache_page(buffer_page);
+		kunmap_atomic(from, KM_USER1);
+	}
+
+	/* Submit the page */
+	get_page(buffer_page);
+	
+	io_info->dev = submit_info->dev;
+	for (i = 0; i < submit_info->blocks_used; i++)
+		io_info->blocks[i] = submit_info->blocks[i];
+	io_info->blocks_used = submit_info->blocks_used;
+	io_info->block_size = PAGE_SIZE / submit_info->blocks_used;
+
+	if (rw == READ)
+		set_bit(IO_AWAITING_READ, &io_info->flags);
+	else
+		set_bit(IO_AWAITING_WRITE, &io_info->flags);
+
+	suspend_message(SUSPEND_WRITER, SUSPEND_HIGH, 1,
+			"-> (PRE BRW) %d\n",
+			real_nr_free_pages());
+
+	if (submit_batch_size > 1)
+		add_to_batch(io_info);
+	else
+	 	submit(rw, io_info);
+	
+	atomic_inc(&outstanding_io);
+	if (atomic_read(&outstanding_io) > max_outstanding_io)
+		max_outstanding_io++;
+	
+	return io_info;
+}
+
+static int suspend_do_io(int rw, 
+		struct submit_params * submit_info, int syncio)
+{
+	struct io_info * io_info = start_one(rw, submit_info);
+	if (!io_info)
+		return 1;
+	else if (syncio)
+		wait_on_one_page(io_info);
+
+	/* If we were the only one, clean everything up */
+	if (!atomic_read(&outstanding_io))
+		suspend_finish_all_io();
+	return 0;
+} 
+
+/* We used to use bread here, but it doesn't correctly handle
+ * blocksize != PAGE_SIZE. Now we create a submit_info to get the data we
+ * want and use our normal routines (synchronously).
+ */
+
+static int suspend_bdev_page_io(int rw, struct block_device * bdev, long pos,
+		struct page * page)
+{
+	struct submit_params submit_info;
+
+	submit_info.page = page;
+	submit_info.dev = bdev;
+
+	submit_info.blocks[0] = pos;
+	submit_info.blocks_used = 1;
+	submit_info.readahead_index = -1;
+	return suspend_do_io(rw, &submit_info, 1);
+}
+
+/*
+ * wait_on_readahead
+ *
+ * Wait until a particular readahead is ready.
+ */
+static void suspend_wait_on_readahead(int readahead_index)
+{
+	int index = readahead_index/(8 * sizeof(unsigned long));
+	int bit = readahead_index - index * 8 * sizeof(unsigned long);
+
+	/* read_ahead_index is the one we want to return */
+	while (!test_bit(bit, &suspend_readahead_flags[index]))
+		do_bio_wait(5);
+}
+
+/*
+ * readahead_done
+ *
+ * Returns whether the readahead requested is ready.
+ */
+
+static int suspend_readahead_ready(int readahead_index)
+{
+	int index = readahead_index/(8 * sizeof(unsigned long));
+	int bit = readahead_index - (index * 8 * sizeof(unsigned long));
+
+	return test_bit(bit, &suspend_readahead_flags[index]);
+}
+
+/* suspend_readahead_prepare
+ * Set up for doing readahead on an image */
+static int suspend_prepare_readahead(int index)
+{
+	unsigned long new_page = get_zeroed_page(GFP_ATOMIC);
+
+	if(!new_page) {
+		printk("No page for readahead %d.\n", index);
+		return -ENOMEM;
+	}
+
+	suspend_bio_ops.readahead_pages[index] = virt_to_page(new_page);
+	return 0;
+}
+
+/* suspend_readahead_cleanup
+ * Clean up structures used for readahead */
+static void suspend_cleanup_readahead(int page)
+{
+	__free_pages(suspend_bio_ops.readahead_pages[page], 0);
+	suspend_bio_ops.readahead_pages[page] = 0;
+	return;
+}
+
+static unsigned long suspend_bio_memory_needed(void)
+{
+	return (REAL_MAX_ASYNC * (PAGE_SIZE + sizeof(struct request) +
+				sizeof(struct bio) + sizeof(struct io_info)));
+}
+
+#if 0
+static int suspend_bio_kthread(void * data)
+{
+	return 0;
+}
+
+static int start_suspend_bio_thread(void)
+{
+	
+	suspend_bio_task = kthread_run(suspend_bio_kthread, NULL,
+		PF_NOFREEZE, "suspend_bio");
+
+	if (IS_ERR(suspend_bio_task)) {
+		printk("suspend_bio thread could not be started.\n");
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+static void end_suspend_bio_thread(void)
+{
+}
+#endif
+
+static struct suspend_proc_data proc_params[] = {
+	{ .filename			= "async_io_limit", 
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		  .integer = {
+			  .variable	= &max_async_ios,
+			  .minimum	= 1,
+			  .maximum	= MAX_READAHEAD,
+		  }
+	  }
+	},
+	
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+#ifdef TUNE_BATCHING
+	{ .filename			= "submit_batch_size", 
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		  .integer = {
+			  .variable	= &submit_batch_size,
+			  .minimum	= 1,
+			  .maximum	= 512,
+		  }
+	  }
+	},
+#endif
+#endif
+};
+
+struct suspend_bio_ops suspend_bio_ops = {
+	.set_block_size = suspend_set_block_size,
+	.get_block_size = suspend_get_block_size,
+	.submit_io = suspend_do_io,
+	.bdev_page_io = suspend_bdev_page_io,
+	.prepare_readahead = suspend_prepare_readahead,
+	.cleanup_readahead = suspend_cleanup_readahead,
+	.readahead_pages = suspend_readahead_pages,
+	.wait_on_readahead = suspend_wait_on_readahead,
+	.check_io_stats = suspend_check_io_stats,
+	.reset_io_stats = suspend_reset_io_stats,
+	.finish_all_io = suspend_finish_all_io,
+	.readahead_ready = suspend_readahead_ready,
+};
+
+EXPORT_SYMBOL(suspend_bio_ops);
+
+static struct suspend_plugin_ops suspend_blockwriter_ops = 
+{
+	.name					= "Block I/O",
+	.type					= MISC_PLUGIN,
+	//.initialise				= start_suspend_bio_thread,
+	//.cleanup				= end_suspend_bio_thread,
+	.memory_needed				= suspend_bio_memory_needed,
+};
+
+static __init int suspend_block_io_load(void)
+{
+	int i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+	int result;
+
+	if (!(result = suspend_register_plugin(&suspend_blockwriter_ops))) {
+		for (i=0; i< numfiles; i++)
+			suspend_register_procfile(&proc_params[i]);
+	}
+
+	return result;
+}
+
+#ifdef MODULE
+static __exit void suspend_block_io_unload(void)
+{
+	int i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+
+	for (i=0; i< numfiles; i++)
+		suspend_unregister_procfile(&proc_params[i]);
+	suspend_unregister_plugin(&suspend_blockwriter_ops);
+}
+
+module_init(suspend_block_io_load);
+module_exit(suspend_block_io_unload);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nigel Cunningham");
+MODULE_DESCRIPTION("Suspend2 block io functions");
+#else
+late_initcall(suspend_block_io_load);
+#endif


