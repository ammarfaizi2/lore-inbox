Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933162AbWFZWfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933162AbWFZWfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933161AbWFZWfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:35:16 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:33183 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933110AbWFZWev
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:51 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 01/20] [Suspend2] Prepare_image.c header.
Date: Tue, 27 Jun 2006 08:34:49 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223448.4050.24065.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add header for prepare_image.c, containing functions that are used in
preparing an image (ie getting processes frozen, calculating the contents
and vital statistics of the image, getting the writer to allocate storage,
freeing memory if needs-be and allocating extra memory if required. Whew!)

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
new file mode 100644
index 0000000..9e13418
--- /dev/null
+++ b/kernel/power/prepare_image.c
@@ -0,0 +1,42 @@
+/*
+ * kernel/power/prepare_image.c
+ *
+ * Copyright (C) 2003-2006 Nigel Cunningham <nigel@suspend.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * We need to eat memory until we can:
+ * 1. Perform the save without changing anything (RAM_NEEDED < max_pfn)
+ * 2. Fit it all in available space (suspend_active_writer->available_space() >=
+ *    storage_needed())
+ * 3. Reload the pagedir and pageset1 to places that don't collide with their
+ *    final destinations, not knowing to what extent the resumed kernel will
+ *    overlap with the one loaded at boot time. I think the resumed kernel
+ *    should overlap completely, but I don't want to rely on this as it is 
+ *    an unproven assumption. We therefore assume there will be no overlap at
+ *    all (worse case).
+ * 4. Meet the user's requested limit (if any) on the size of the image.
+ *    The limit is in MB, so pages/256 (assuming 4K pages).
+ *
+ */
+
+#include <linux/highmem.h>
+#include <linux/freezer.h>
+#include <linux/hardirq.h>
+
+#include "suspend2.h"
+#include "pageflags.h"
+#include "modules.h"
+#include "suspend2_common.h"
+#include "io.h"
+#include "ui.h"
+#include "extent.h"
+#include "prepare_image.h"
+#include "block_io.h"
+
+static int are_frozen = 0, num_nosave = 0;
+static long header_space_allocated = 0;
+static long storage_allocated = 0;
+static long storage_available = 0;
+long extra_pd1_pages_allowance = MIN_EXTRA_PAGES_ALLOWANCE;
+

--
Nigel Cunningham		nigel at suspend2 dot net
