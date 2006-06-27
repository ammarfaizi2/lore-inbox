Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWF0FKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWF0FKs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030666AbWF0Eiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:38:55 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:19931 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030659AbWF0Eiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:51 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 01/10] [Suspend2] Atomic copy file header.
Date: Tue, 27 Jun 2006 14:38:50 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043848.14546.41152.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
References: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the header for the atomic copy file. This file contains the routines
related to doing the copying and restoration of pages that need to be
atomically copied.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/atomic_copy.c |   52 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/kernel/power/atomic_copy.c b/kernel/power/atomic_copy.c
new file mode 100644
index 0000000..e54de43
--- /dev/null
+++ b/kernel/power/atomic_copy.c
@@ -0,0 +1,52 @@
+/*
+ * kernel/power/atomic_copy.c
+ *
+ * Copyright 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * Distributed under GPLv2.
+ *
+ * Routines for doing the atomic save/restore.
+ */
+
+#include <linux/suspend.h>
+#include <linux/highmem.h>
+#include <linux/bootmem.h>
+#include <asm/setup.h>
+#include "suspend2_common.h"
+#include "storage.h"
+#include "power_off.h"
+#include "version.h"
+#include "ui.h"
+#include "power.h"
+#include "io.h"
+#include "prepare_image.h"
+#include "pageflags.h"
+#include "extent.h"
+
+static int state1 __nosavedata = 0;
+static int state2 __nosavedata = 0;
+static int state3 __nosavedata = 0;
+static int io_speed_save[2][2] __nosavedata;
+__nosavedata char suspend_resume_commandline[COMMAND_LINE_SIZE];
+
+extern void suspend_power_down(void);
+extern int swsusp_resume(void);
+extern int suspend2_in_suspend __nosavedata;
+int extra_pd1_pages_used;
+
+#ifdef CONFIG_HIGHMEM
+static dyn_pageflags_t __nosavedata origmap;
+static dyn_pageflags_t __nosavedata copymap;
+static unsigned long __nosavedata origoffset;
+static unsigned long __nosavedata copyoffset;
+static __nosavedata int o_zone_num, c_zone_num;
+
+struct zone_data {
+	unsigned long start_pfn;
+	unsigned long end_pfn;
+	int is_highmem;
+};
+
+static __nosavedata struct zone_data *zone_nosave;
+static __nosavedata int num_zones;
+

--
Nigel Cunningham		nigel at suspend2 dot net
