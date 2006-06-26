Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933337AbWFZWwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933337AbWFZWwe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933312AbWFZWlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:41:16 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:36535 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933319AbWFZWlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:11 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 01/28] [Suspend2] Swapwriter.c header.
Date: Tue, 27 Jun 2006 08:41:09 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224107.4975.5382.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Header for kernel/power/suspend_swap.c.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   89 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
new file mode 100644
index 0000000..7732a75
--- /dev/null
+++ b/kernel/power/suspend_swap.c
@@ -0,0 +1,89 @@
+/*
+ * Swapwriter.c
+ *
+ * Copyright 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * Distributed under GPLv2.
+ * 
+ * This file encapsulates functions for usage of swap space as a
+ * backing store.
+ */
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/blkdev.h>
+#include <linux/swapops.h>
+#include <linux/swap.h>
+
+#include "suspend2.h"
+#include "suspend2_common.h"
+#include "version.h"
+#include "proc.h"
+#include "modules.h"
+#include "io.h"
+#include "ui.h"
+#include "extent.h"
+#include "block_io.h"
+
+static struct suspend_module_ops swapwriterops;
+
+#define SIGNATURE_VER 6
+
+/* --- Struct of pages stored on disk */
+
+union diskpage {
+	union swap_header swh;	/* swh.magic is the only member used */
+};
+
+union p_diskpage {
+	union diskpage *pointer;
+	char *ptr;
+        unsigned long address;
+};
+
+/* Devices used for swap */
+static struct suspend_bdev_info devinfo[MAX_SWAPFILES];
+
+/* Extent chains for swap & blocks */
+struct extent_chain swapextents;
+struct extent_chain block_chain[MAX_SWAPFILES];
+
+static dev_t header_dev_t;
+static struct block_device *header_block_device;
+static unsigned long headerblock;
+
+/* For swapfile automatically swapon/off'd. */
+static char swapfilename[SWAP_FILENAME_MAXLENGTH] = "";
+extern asmlinkage long sys_swapon(const char *specialfile, int swap_flags);
+extern asmlinkage long sys_swapoff(const char *specialfile);
+static int suspend_swapon_status;
+
+/* Header Page Information */
+static int header_pages_allocated;
+
+/* User Specified Parameters. */
+
+static unsigned long resume_firstblock;
+static int resume_blocksize;
+static dev_t resume_dev_t;
+static struct block_device *resume_block_device;
+
+struct sysinfo swapinfo;
+static int swapwriter_invalidate_image(void);
+
+/* Block devices open. */
+struct bdev_opened
+{
+	dev_t device;
+	struct block_device *bdev;
+	int claimed;
+};
+
+/* 
+ * Entry MAX_SWAPFILES is the resume block device, which may
+ * not be a swap device enabled when we suspend.
+ * Entry MAX_SWAPFILES + 1 is the header block device, which
+ * is needed before we find out which slot it occupies.
+ */
+static struct bdev_opened *bdev_info_list[MAX_SWAPFILES + 2];
+       

--
Nigel Cunningham		nigel at suspend2 dot net
