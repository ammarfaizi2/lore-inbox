Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933222AbWFZWhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933222AbWFZWhS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933228AbWFZWhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:37:17 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:54687 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933224AbWFZWhP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:37:15 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 02/32] [Suspend2] Block io c file header.
Date: Tue, 27 Jun 2006 08:37:13 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223711.4376.6781.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/power/suspend_block_io.c does all the hard work of getting the data
written to storage via bio routines. The swapwriter and filewriter are
really only allocators - this file implements completely asynchronous
submission of the I/O and cleanup on completion. All the writers need to do
is feed a list of bdevs and blocks on each bdev, and then the pages to be
written or read.

The io_info struct stores the data on each page in flight. As pages
progress through processing, their io_info structs move from the free list
to the submit_batch list if being batched, to the busy list when submitted
to the block layer, to the ready_for_cleanup list with the completion
function is called, to the free list after cleanup. Each list has its own
spinlock to reduce locking issues.

Readahead pages are used like a ring buffer.

The posn_save struct is used to record where the three parts of the image
begin, thereby allowing quick 'seeking' to the start of a pageset or the
start of the header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |  130 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 130 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
new file mode 100644
index 0000000..94f1946
--- /dev/null
+++ b/kernel/power/suspend_block_io.c
@@ -0,0 +1,130 @@
+/*
+ * kernel/power/suspend_block_io.c
+ *
+ * Copyright 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * Distributed under GPLv2.
+ * 
+ * This file contains block io functions for suspend2. These are
+ * used by the swapwriter and it is planned that they will also
+ * be used by the NFSwriter.
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/syscalls.h>
+#include <linux/suspend.h>
+
+#include "suspend2.h"
+#include "proc.h"
+#include "modules.h"
+#include "prepare_image.h"
+#include "block_io.h"
+#include "ui.h"
+
+/* Bits in struct io_info->flags */
+enum {
+	IO_AWAITING_READ,
+	IO_AWAITING_SUBMIT,
+	IO_AWAITING_CLEANUP,
+};
+
+#define MAX_OUTSTANDING_IO 2048
+
+/*
+ *
+ *     IO in progress information storage and helpers
+ *
+ */
+
+struct io_info {
+	struct bio *sys_struct;
+	sector_t block[MAX_BUF_PER_PAGE];
+	struct page *buffer_page;
+	struct page *data_page;
+	unsigned long flags;
+	struct block_device *dev;
+	struct list_head list;
+	int readahead_index;
+};
+
+/*
+ * submit_params
+ */
+struct submit_params {
+	swp_entry_t swap_address;
+	struct page *page;
+	struct block_device *dev;
+	sector_t block[MAX_BUF_PER_PAGE];
+	int readahead_index;
+	struct submit_params *next;
+	int printme;
+};
+
+/* Locks separated to allow better SMP support.
+ * An io_struct moves through the lists as follows.
+ * free -> submit_batch -> busy -> ready_for_cleanup -> free
+ */
+static LIST_HEAD(ioinfo_free);
+static DEFINE_SPINLOCK(ioinfo_free_lock);
+
+static LIST_HEAD(ioinfo_ready_for_cleanup);
+static DEFINE_SPINLOCK(ioinfo_ready_lock);
+
+static LIST_HEAD(ioinfo_submit_batch);
+static DEFINE_SPINLOCK(ioinfo_submit_lock);
+
+static LIST_HEAD(ioinfo_busy);
+static DEFINE_SPINLOCK(ioinfo_busy_lock);
+
+static atomic_t submit_batch;
+static int submit_batch_size = 64;
+static int submit_batched(void);
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
+static int extra_page_forward = 0;
+
+static volatile unsigned long suspend_readahead_flags[
+	(MAX_OUTSTANDING_IO + BITS_PER_LONG - 1) / BITS_PER_LONG];
+static spinlock_t suspend_readahead_flags_lock = SPIN_LOCK_UNLOCKED;
+static struct page *suspend_readahead_pages[MAX_OUTSTANDING_IO];
+static int readahead_index, readahead_submit_index;
+
+static int current_stream;
+struct extent_iterate_saved_state suspend_writer_posn_save[3];
+
+/* Pointer to current entry being loaded/saved. */
+struct extent_iterate_state suspend_writer_posn;
+
+/* Not static, so that the allocators can setup and complete
+ * writing the header */
+char *suspend_writer_buffer;
+int suspend_writer_buffer_posn;
+
+int suspend_read_fd;
+
+static unsigned long nr_schedule_calls[8];
+
+static char *sch_caller[] = {
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
+static struct suspend_bdev_info *suspend_devinfo;
+
+int suspend_header_bytes_used = 0;
+

--
Nigel Cunningham		nigel at suspend2 dot net
