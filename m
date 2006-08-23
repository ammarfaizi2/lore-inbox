Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWHWLfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWHWLfi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWHWLfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:35:04 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:58456 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932389AbWHWLe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:34:58 -0400
Message-Id: <20060823113317.722640313@localhost.localdomain>
References: <20060823113243.210352005@localhost.localdomain>
Date: Wed, 23 Aug 2006 20:32:47 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, okuji@enbug.org, Jens Axboe <axboe@suse.de>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 4/5] fail-injection capability for disk IO
Content-Disposition: inline; filename=fail_make_request.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides fail-injection capability for disk IO.

Boot option:

	fail_make_request=<probability>,<interval>,<times>,<space>

	<probability>

		specifies how often it should fail in percent.

	<interval>

		specifies the interval of failures.

	<times>

		specifies how many times failures may happen at most.

	<space>

		specifies the size of free space where disk IO can be issued
		safely in bytes.

Example:

	fail_make_request=100,10,-1,0

generic_make_request() fails once per 10 times.

Cc: Jens Axboe <axboe@suse.de>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 block/ll_rw_blk.c           |   19 +++++++++++++++++++
 include/linux/should_fail.h |    4 ++++
 lib/Kconfig.debug           |    7 +++++++
 3 files changed, 30 insertions(+)

Index: work-failmalloc/block/ll_rw_blk.c
===================================================================
--- work-failmalloc.orig/block/ll_rw_blk.c
+++ work-failmalloc/block/ll_rw_blk.c
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/blktrace_api.h>
+#include <linux/should_fail.h>
 
 /*
  * for max sense size
@@ -2993,6 +2994,21 @@ static void handle_bad_sector(struct bio
 	set_bit(BIO_EOF, &bio->bi_flags);
 }
 
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+
+static DEFINE_SHOULD_FAIL(fail_make_request_data);
+
+static int __init setup_fail_make_request(char *str)
+{
+	return setup_should_fail(&fail_make_request_data, str);
+}
+__setup("fail_make_request=", setup_fail_make_request);
+
+struct should_fail_data *fail_make_request = &fail_make_request_data;
+EXPORT_SYMBOL_GPL(fail_make_request);
+
+#endif
+
 /**
  * generic_make_request: hand a buffer to its device driver for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -3077,6 +3093,9 @@ end_io:
 		if (unlikely(test_bit(QUEUE_FLAG_DEAD, &q->queue_flags)))
 			goto end_io;
 
+		if (should_fail(fail_make_request, bio->bi_size))
+			goto end_io;
+
 		/*
 		 * If this device has partitions, remap block n
 		 * of partition p to block n+start(p) of the disk.
Index: work-failmalloc/lib/Kconfig.debug
===================================================================
--- work-failmalloc.orig/lib/Kconfig.debug
+++ work-failmalloc/lib/Kconfig.debug
@@ -386,3 +386,10 @@ config FAIL_PAGE_ALLOC
 	help
 	  This option provides fault-injection capabilitiy for alloc_pages().
 
+config FAIL_MAKE_REQUEST
+	bool "fault-injection capabilitiy for disk IO"
+	depends on DEBUG_KERNEL
+	select SHOULD_FAIL
+	help
+	  This option provides fault-injection capabilitiy to disk IO.
+
Index: work-failmalloc/include/linux/should_fail.h
===================================================================
--- work-failmalloc.orig/include/linux/should_fail.h
+++ work-failmalloc/include/linux/should_fail.h
@@ -43,6 +43,10 @@ extern struct should_fail_data *failslab
 extern struct should_fail_data *fail_page_alloc;
 #endif
 
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+extern struct should_fail_data *fail_make_request;
+#endif
+
 #else
 
 #define should_fail(data, size)	(0)

--
