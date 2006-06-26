Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWFZXIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWFZXIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWFZXIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:08:18 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:17847 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933244AbWFZWjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:08 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 01/35] [Suspend2] Header file for suspend_file.c
Date: Tue, 27 Jun 2006 08:39:06 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223904.4685.11871.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Header for the filewriter, which allows us to write an image to a simple
file: a partition, a file on a filesystem or possibly (untested) things
like /dev/ttyS0.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   96 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
new file mode 100644
index 0000000..525e482
--- /dev/null
+++ b/kernel/power/suspend_file.c
@@ -0,0 +1,96 @@
+/*
+ * kernel/power/suspend_file.c
+ *
+ * Copyright 2005-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * Distributed under GPLv2.
+ * 
+ * This file encapsulates functions for usage of a simple file as a
+ * backing store. It is based upon the swapwriter, and shares the
+ * same basic working. Here, though, we have nothing to do with
+ * swapspace, and only one device to worry about.
+ *
+ * The user can just
+ *
+ * echo Suspend2 > /path/to/my_file
+ *
+ * and
+ *
+ * echo /path/to/my_file > /proc/software_suspend/filewriter_target
+ *
+ * then put what they find in /proc/software_suspend/resume2
+ * as their resume2= parameter in lilo.conf (and rerun lilo if using it).
+ *
+ * Having done this, they're ready to suspend and resume.
+ *
+ * TODO:
+ * - File resizing.
+ */
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/blkdev.h>
+#include <linux/file.h>
+#include <linux/stat.h>
+#include <linux/mount.h>
+#include <linux/statfs.h>
+#include <linux/syscalls.h>
+#include <linux/namei.h>
+#include <linux/fs.h>
+
+#include "suspend2.h"
+#include "suspend2_common.h"
+#include "version.h"
+#include "proc.h"
+#include "modules.h"
+#include "ui.h"
+#include "extent.h"
+#include "io.h"
+#include "storage.h"
+#include "block_io.h"
+
+static struct suspend_module_ops filewriterops;
+
+/* Details of our target.  */
+
+char filewriter_target[256];
+static struct inode *target_inode;
+static struct file *target_file;
+static struct block_device *filewriter_target_bdev;
+static dev_t resume_dev_t;
+static int used_devt = 0;
+static int setting_filewriter_target = 0;
+static sector_t target_firstblock = 0, target_header_start = 0;
+static int target_storage_available = 0;
+static int target_claim = 0;
+
+static char HaveImage[] = "HaveImage\n";
+static char NoImage[] =   "Suspend2\n";
+#define sig_size (sizeof(HaveImage) + 1)
+
+struct filewriter_header {
+	char sig[sig_size];
+	int resumed_before;
+	unsigned long first_header_block;
+};
+
+extern dev_t ROOT_DEV;
+extern char *__initdata root_device_name;
+
+/* Header_pages must be big enough for signature */
+static int header_pages, main_pages;
+
+#define target_is_normal_file() (S_ISREG(target_inode->i_mode))
+
+static struct suspend_bdev_info devinfo;
+
+/* Extent chain for blocks */
+static struct extent_chain block_chain;
+
+/* Signature operations */
+enum {
+	GET_IMAGE_EXISTS,
+	INVALIDATE,
+	MARK_RESUME_ATTEMPTED,
+};
+

--
Nigel Cunningham		nigel at suspend2 dot net
