Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVGFEhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVGFEhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 00:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVGFEhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 00:37:15 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:13209 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262086AbVGFCTk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:40 -0400
Subject: [PATCH] [46/48] Suspend2 2.1.9.8 for 2.6.12: 622-swapwriter.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:44 +1000
Message-Id: <11206164442712@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 623-generic-block-io.patch-old/kernel/power/block_io.h 623-generic-block-io.patch-new/kernel/power/block_io.h
--- 623-generic-block-io.patch-old/kernel/power/block_io.h	1970-01-01 10:00:00.000000000 +1000
+++ 623-generic-block-io.patch-new/kernel/power/block_io.h	2005-07-05 23:48:59.000000000 +1000
@@ -0,0 +1,55 @@
+/*
+ * block_io.h
+ *
+ * Copyright 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * Distributed under GPLv2.
+ *
+ * This file contains declarations for functions exported from
+ * block_io.c, which contains low level io functions.
+ */
+
+/* 
+ * The maximum amount of I/O we submit at once.
+ */
+#define MAX_READAHEAD 1024
+
+/* Forward Declarations */
+
+/*
+ * submit_params
+ *
+ * The structure we use for tracking submitted I/O.
+ */
+struct submit_params {
+	swp_entry_t swap_address;
+	struct page * page;
+	struct block_device * dev;
+	long block[8];
+	int readahead_index;
+	struct submit_params * next;
+};
+
+
+/* 
+ * Our exported interface so the swapwriter and filewriter don't
+ * need these functions duplicated.
+ */
+struct suspend_bio_ops {
+	int (*set_block_size) (struct block_device * bdev, int size);
+	int (*get_block_size) (struct block_device * bdev);
+	int (*submit_io) (int rw, 
+		struct submit_params * submit_info, int syncio);
+	int (*bdev_page_io) (int rw, struct block_device * bdev, long pos,
+			struct page * page);
+	void (*wait_on_readahead) (int readahead_index);
+	void (*check_io_stats) (void);
+	void (*reset_io_stats) (void);
+	void (*finish_all_io) (void);
+	int (*prepare_readahead) (int index);
+	void (*cleanup_readahead) (int index);
+	struct page ** readahead_pages;
+	int (*readahead_ready) (int readahead_index);
+};
+
+extern struct suspend_bio_ops suspend_bio_ops;
diff -ruNp 623-generic-block-io.patch-old/kernel/power/suspend_block_io.c 623-generic-block-io.patch-new/kernel/power/suspend_block_io.c
--- 623-generic-block-io.patch-old/kernel/power/suspend_block_io.c	1970-01-01 10:00:00.000000000 +1000
+++ 623-generic-block-io.patch-new/kernel/power/suspend_block_io.c	2005-07-05 23:48:59.000000000 +1000
@@ -0,0 +1,817 @@
+/*
+ * block_io.c
+ *
+ * Copyright 2004-2005 Nigel Cunningham <nigel@suspend2.net>
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
+#include "suspend2_core/suspend.h"
+#include "suspend2_core/proc.h"
+#include "suspend2_core/plugins.h"
+#include "suspend2_core/utility.h"
+#include "suspend2_core/prepare_image.h"
+
+#include "block_io.h"
+
+/* Bits in struct io_info->flags */
+#define IO_WRITING 1
+#define IO_RESTORE_PAGE_PROT 2
+#define IO_AWAITING_READ 3
+#define IO_AWAITING_WRITE 4
+#define IO_AWAITING_SUBMIT 5
+#define IO_AWAITING_CLEANUP 6
+#define IO_HANDLE_PAGE_PROT 7
+
+#define MAX_OUTSTANDING_IO 1024
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
+	long block[PAGE_SIZE/512];
+	struct page * buffer_page;
+	struct page * data_page;
+	unsigned long flags;
+	struct block_device * dev;
+	struct list_head list;
+	int readahead_index;
+	struct work_struct work;
+};
+
+/* Locks separated to allow better SMP support.
+ * An io_struct moves through the lists as follows.
+ * free -> submit_batch -> busy -> ready_for_cleanup -> free
+ */
+static LIST_HEAD(ioinfo_free);
+static spinlock_t ioinfo_free_lock = SPIN_LOCK_UNLOCKED;
+
+static LIST_HEAD(ioinfo_ready_for_cleanup);
+static spinlock_t ioinfo_ready_lock = SPIN_LOCK_UNLOCKED;
+
+static LIST_HEAD(ioinfo_submit_batch);
+static spinlock_t ioinfo_submit_lock = SPIN_LOCK_UNLOCKED;
+
+static LIST_HEAD(ioinfo_busy);
+static spinlock_t ioinfo_busy_lock = SPIN_LOCK_UNLOCKED;
+
+static atomic_t submit_batch;
+static int submit_batch_size = 64;
+static int submit_batched(void);
+
+struct task_struct * suspend_bio_task;
+
+/* [Max] number of I/O operations pending */
+static atomic_t outstanding_io;
+static int max_outstanding_io = 0;
+static atomic_t buffer_allocs, buffer_frees;
+
+/* [Max] number of pages used for above struct */
+static int infopages = 0;
+static int maxinfopages = 0;
+
+#define BITS_PER_UL (8 * sizeof(unsigned long))
+static volatile unsigned long suspend_readahead_flags[(MAX_READAHEAD + BITS_PER_UL - 1) / BITS_PER_UL];
+static spinlock_t suspend_readahead_flags_lock = SPIN_LOCK_UNLOCKED;
+static struct page * suspend_readahead_pages[MAX_READAHEAD];
+
+static unsigned long nr_schedule_calls[8];
+
+static char * sch_caller[] = {
+	"get_io_info_struct #1    ",
+	"get_io_info_struct #2    ",
+	"get_io_info_struct #3    ",
+	"suspend_finish_all_io    ",
+	"wait_on_one_page         ",
+	"submit                   ",
+	"start_one                ",
+	"suspend_wait_on_readahead",
+};
+
+static int __suspend_io_cleanup(void * data);
+
+/* cleanup_some_completed_io
+ *
+ * NB: This is designed so that multiple callers can be in here simultaneously.
+ */
+
+static void cleanup_some_completed_io(void)
+{
+	int num_cleaned = 0;
+	struct io_info * first;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ioinfo_ready_lock, flags);
+	while(!list_empty(&ioinfo_ready_for_cleanup)) {
+		int result;
+		first = list_entry(ioinfo_ready_for_cleanup.next, struct io_info, list);
+
+		BUG_ON(!test_and_clear_bit(IO_AWAITING_CLEANUP, &first->flags));
+
+		list_del_init(&first->list);
+
+		spin_unlock_irqrestore(&ioinfo_ready_lock, flags);
+
+		result = __suspend_io_cleanup((void *) first);
+
+		spin_lock_irqsave(&ioinfo_ready_lock, flags);
+		if (result)
+			continue;
+		num_cleaned++;
+		if (num_cleaned == submit_batch_size)
+			break;
+	}
+	spin_unlock_irqrestore(&ioinfo_ready_lock, flags);
+}
+
+/* do_bio_wait
+ *
+ * Actions taken when we want some I/O to get run.
+ * 
+ * Submit any I/O that's batched up, unplug queues, schedule
+ * and clean up whatever we can.
+ */
+static void do_bio_wait(int caller)
+{
+	int device;
+	int num_submitted = 0;
+
+	nr_schedule_calls[caller]++;
+	
+	/* Don't want to wait on I/O we haven't submitted! */
+	num_submitted = submit_batched();
+
+	for (device = 0; device < MAX_SWAPFILES; device++) {
+		struct block_device * bdev = swap_info[device].bdev;
+		/* Check for a potential oops here */
+		if (bdev && bdev->bd_disk) {
+			request_queue_t * q = bdev_get_queue(bdev);
+			if (q && q->unplug_fn)
+				q->unplug_fn(q);
+		}
+		/* kblockd_flush(); io_schedule(); */
+	}
+
+	schedule();
+
+	cleanup_some_completed_io();
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
+			printk(KERN_EMERG "Cleanup IO: Page count on page %p is %d. Not good!\n",
+					buffer_page, page_count(buffer_page));
+		put_page(buffer_page);
+		__free_pages(buffer_page, 0);
+		atomic_inc(&buffer_frees);
+	} else
+		put_page(buffer_page);
+	
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
+		while (atomic_read(&outstanding_io) >= MAX_OUTSTANDING_IO)
+			do_bio_wait(0);
+
+		/* Can start a new I/O. Is there a free one? */
+		if (!list_empty(&ioinfo_free)) {
+			/* Yes. Grab it. */
+			spin_lock_irqsave(&ioinfo_free_lock, flags);
+			break;
+		}
+
+		/* No. Need to allocate a new page for I/O info structs. */
+		newpage = get_zeroed_page(GFP_ATOMIC);
+		if (!newpage) {
+			do_bio_wait(1);
+			continue;
+		}
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
+		spin_lock_irqsave(&ioinfo_free_lock, flags);
+		while (remaining >= (sizeof(struct io_info))) {
+			list_add_tail(&this->list, &ioinfo_free);
+			this = (struct io_info *) (((char *) this) + 
+					sizeof(struct io_info));
+			remaining -= sizeof(struct io_info);
+		}
+		break;
+	} while (1);
+
+	/*
+	 * We have an I/O info struct. Remove it from the free list.
+	 * It will be added to the submit or busy list later.
+	 */
+	this = list_entry(ioinfo_free.next, struct io_info, list);
+	list_del_init(&this->list);
+	spin_unlock_irqrestore(&ioinfo_free_lock, flags);
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
+	/* Wait for all I/O to complete. */
+	while (atomic_read(&outstanding_io))
+		do_bio_wait(2);
+
+	spin_lock_irqsave(&ioinfo_free_lock, flags);
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
+	spin_unlock_irqrestore(&ioinfo_free_lock, flags);
+}
+
+/*
+ * wait_on_one_page
+ *
+ * Description:	Wait for a particular I/O to complete.
+ */
+static void wait_on_one_page(struct io_info * io_info)
+{
+	do { do_bio_wait(3); } while (io_info->flags);
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
+	
+	for (i = 0; i < 8; i++)
+		nr_schedule_calls[i] = 0;
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
+	BUG_ON(!list_empty(&ioinfo_submit_batch));
+	BUG_ON(!list_empty(&ioinfo_busy));
+	BUG_ON(!list_empty(&ioinfo_ready_for_cleanup));
+	BUG_ON(!list_empty(&ioinfo_free));
+	BUG_ON(atomic_read(&buffer_allocs) != atomic_read(&buffer_frees));
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
+	if (atomic_read(&buffer_allocs) != atomic_read(&buffer_frees))
+		suspend_message(SUSPEND_WRITER, SUSPEND_MEDIUM, 0,
+			"Buffer allocs (%d) != buffer frees (%d)",
+				atomic_read(&buffer_allocs),
+				atomic_read(&buffer_frees));
+	for(i = 0; i < 8; i++)
+		suspend_message(SUSPEND_WRITER, SUSPEND_MEDIUM, 0,
+			"Nr schedule calls %s: %lu.\n", sch_caller[i], nr_schedule_calls[i]);
+}
+
+/* __suspend_io_cleanup
+ */
+
+static int __suspend_io_cleanup(void * data)
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
+	 * Add it to the free list.
+	 */
+	list_del_init(&io_info->list);
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
+	spin_lock_irqsave(&ioinfo_free_lock, flags);
+	list_add_tail(&io_info->list, &ioinfo_free);
+	spin_unlock_irqrestore(&ioinfo_free_lock, flags);
+	
+	/* Important: Must be last thing we do to avoid a race with
+	 * finish_all_io when using keventd to do the cleanup */
+	atomic_dec(&outstanding_io);
+
+	return 0;
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
+	spin_lock_irqsave(&ioinfo_busy_lock, flags);
+	list_del_init(&io_info->list);
+	spin_unlock_irqrestore(&ioinfo_busy_lock, flags);
+
+	set_bit(IO_AWAITING_CLEANUP, &io_info->flags);
+		
+	spin_lock_irqsave(&ioinfo_ready_lock, flags);
+	list_add_tail(&io_info->list, &ioinfo_ready_for_cleanup);
+	spin_unlock_irqrestore(&ioinfo_ready_lock, flags);
+	return 0;
+}
+
+/**
+ *	submit - submit BIO request.
+ *	@rw:	READ or WRITE.
+ *	@io_info: IO info structure.
+ *
+ * 	Based on Patrick's pmdisk code from long ago:
+ *	"Straight from the textbook - allocate and initialize the bio.
+ *	If we're writing, make sure the page is marked as dirty.
+ *	Then submit it and carry on."
+ *
+ *	With a twist, though - we handle block_size != PAGE_SIZE.
+ *	Caller has already checked that our page is not fragmented.
+ */
+
+static int submit(int rw, struct io_info * io_info)
+{
+	int error = 0;
+	struct bio * bio = NULL;
+	unsigned long flags;
+
+	while (!bio) {
+		bio = bio_alloc(GFP_ATOMIC,1);
+		if (!bio)
+			do_bio_wait(4);
+	}
+
+	bio->bi_bdev = io_info->dev;
+	bio->bi_sector = io_info->block[0] * (io_info->dev->bd_block_size >> 9);
+	bio->bi_private = io_info;
+	bio->bi_end_io = suspend_end_bio;
+	io_info->sys_struct = bio;
+
+	if (bio_add_page(bio, io_info->buffer_page, PAGE_SIZE, 0) < PAGE_SIZE) {
+		printk("ERROR: adding page to bio at %ld\n",
+				io_info->block[0]);
+		bio_put(bio);
+		return -EFAULT;
+	}
+
+	if (rw == WRITE)
+		bio_set_pages_dirty(bio);
+
+	spin_lock_irqsave(&ioinfo_busy_lock, flags);
+	list_add_tail(&io_info->list, &ioinfo_busy);
+	spin_unlock_irqrestore(&ioinfo_busy_lock, flags);
+	
+	submit_bio(rw,bio);
+
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
+ * submit a batch
+ */
+static int submit_batched(void)
+{
+	struct io_info * first;
+	unsigned long flags;
+	int num_submitted = 0;
+
+	spin_lock_irqsave(&ioinfo_submit_lock, flags);
+	while(!list_empty(&ioinfo_submit_batch)) {
+		first = list_entry(ioinfo_submit_batch.next, struct io_info, list);
+
+		BUG_ON(!test_and_clear_bit(IO_AWAITING_SUBMIT, &first->flags));
+
+		list_del_init(&first->list);
+
+		atomic_dec(&submit_batch);
+
+		spin_unlock_irqrestore(&ioinfo_submit_lock, flags);
+
+		if (test_bit(IO_AWAITING_READ, &first->flags))
+			submit(READ, first);
+		else
+			submit(WRITE, first);
+
+		spin_lock_irqsave(&ioinfo_submit_lock, flags);
+		
+		num_submitted++;
+		if (num_submitted == submit_batch_size)
+			break;
+	}
+	spin_unlock_irqrestore(&ioinfo_submit_lock, flags);
+
+	return num_submitted;
+}
+static void add_to_batch(struct io_info * io_info)
+{
+	unsigned long flags;
+	
+	set_bit(IO_AWAITING_SUBMIT, &io_info->flags);
+
+	/* Put our prepared I/O struct on the batch list. */
+	spin_lock_irqsave(&ioinfo_submit_lock, flags);
+	list_add_tail(&io_info->list, &ioinfo_submit_batch);
+	spin_unlock_irqrestore(&ioinfo_submit_lock, flags);
+
+	atomic_inc(&submit_batch);
+
+	if ((!suspend_bio_task) && (atomic_read(&submit_batch) >= submit_batch_size))
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
+			do_bio_wait(5);
+
+		atomic_inc(&buffer_allocs);
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
+	io_info->block[0] = submit_info->block[0];
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
+	submit_info.block[0] = pos;
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
+		do_bio_wait(6);
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
+	if(!new_page)
+		return -ENOMEM;
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
+	/* We want to have at least enough memory so as to have 128 I/O
+	 * transactions on the fly at once. If we can to more, fine. */
+	return (128 * (PAGE_SIZE + sizeof(struct request) +
+				sizeof(struct bio) + sizeof(struct io_info)));
+}
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
+static struct suspend_plugin_ops suspend_blockwriter_ops = 
+{
+	.name					= "Block I/O",
+	.type					= MISC_PLUGIN,
+	.module					= THIS_MODULE,
+	.memory_needed				= suspend_bio_memory_needed,
+};
+
+static __init int suspend_block_io_load(void)
+{
+	return suspend_register_plugin(&suspend_blockwriter_ops);
+}
+
+#ifdef MODULE
+static __exit void suspend_block_io_unload(void)
+{
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

