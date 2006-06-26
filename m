Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933268AbWFZXS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933268AbWFZXS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933217AbWFZWhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:37:19 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:54175 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933209AbWFZWhL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:37:11 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 01/32] [Suspend2] Block I/O Header File
Date: Tue, 27 Jun 2006 08:37:09 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223708.4376.9487.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/power/block_io.h is the header file for the lowlevel block i/o code.
It defines the operations that the swapwriter and filewriter use to
actually perform the I/O.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/block_io.h |   55 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/kernel/power/block_io.h b/kernel/power/block_io.h
new file mode 100644
index 0000000..2e89ca2
--- /dev/null
+++ b/kernel/power/block_io.h
@@ -0,0 +1,55 @@
+/*
+ * kernel/power/block_io.h
+ *
+ * Copyright 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * Distributed under GPLv2.
+ *
+ * This file contains declarations for functions exported from
+ * block_io.c, which contains low level io functions.
+ */
+
+#include <linux/buffer_head.h>
+#include "extent.h"
+
+struct suspend_bdev_info {
+	struct block_device *bdev;
+	dev_t dev_t;
+	int bmap_shift;
+	int blocks_per_page;
+};
+
+/* 
+ * Our exported interface so the swapwriter and filewriter don't
+ * need these functions duplicated.
+ */
+struct suspend_bio_ops {
+	int (*bdev_page_io) (int rw, struct block_device *bdev, long pos,
+			struct page *page);
+	void (*check_io_stats) (void);
+	void (*reset_io_stats) (void);
+	void (*finish_all_io) (void);
+	int (*prepare_readahead) (int index);
+	void (*cleanup_readahead) (int index);
+	struct page ** readahead_pages;
+	int (*readahead_ready) (int readahead_index);
+	int (*forward_one_page) (void);
+	void (*set_extra_page_forward) (void);
+	void (*set_devinfo) (struct suspend_bdev_info *info);
+	int (*read_chunk) (struct page *buffer_page, int sync);
+	int (*write_chunk) (struct page *buffer_page);
+	int (*rw_header_chunk) (int rw, struct suspend_module_ops *owner,
+			char *buffer, int buffer_size);
+	int (*write_header_chunk_finish) (void);
+	int (*rw_init) (int rw, int stream_number);
+	int (*rw_cleanup) (int rw);
+};
+
+extern struct suspend_bio_ops suspend_bio_ops;
+
+extern char *suspend_writer_buffer;
+extern int suspend_writer_buffer_posn;
+extern int suspend_read_fd;
+extern struct extent_iterate_saved_state suspend_writer_posn_save[3];
+extern struct extent_iterate_state suspend_writer_posn;
+extern int suspend_header_bytes_used;

--
Nigel Cunningham		nigel at suspend2 dot net
