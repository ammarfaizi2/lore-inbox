Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWF0E6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWF0E6k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933446AbWF0Ex6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:53:58 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:42459 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933409AbWF0ElR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:17 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 01/21] [Suspend2] User interface c header.
Date: Tue, 27 Jun 2006 14:41:15 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044114.14883.3011.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/power/ui.c header. This implements the kernel side of the user
interface.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
new file mode 100644
index 0000000..1ef8957
--- /dev/null
+++ b/kernel/power/ui.c
@@ -0,0 +1,69 @@
+/*
+ * kernel/power/ui.c
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Routines for Suspend2's user interface.
+ *
+ * The user interface code talks to a userspace program via a
+ * netlink socket.
+ *
+ * The kernel side:
+ * - starts the userui program;
+ * - sends text messages and progress bar status;
+ *
+ * The user space side:
+ * - passes messages regarding user requests (abort, toggle reboot etc)
+ *
+ */
+
+#define __KERNEL_SYSCALLS__
+
+#include <linux/suspend.h>
+#include <linux/freezer.h>
+#include <linux/console.h>
+#include <linux/ctype.h>
+#include <linux/tty.h>
+#include <linux/vt_kern.h>
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/kmod.h>
+#include <linux/security.h>
+#include <linux/syscalls.h>
+ 
+#include "proc.h"
+#include "modules.h"
+#include "suspend2.h"
+#include "suspend2_common.h"
+#include "ui.h"
+#include "version.h"
+#include "netlink.h"
+#include "power.h"
+#include "power_off.h"
+
+static char local_printf_buf[1024];	/* Same as printk - should be safe */
+
+/*! The console log level we default to. */
+int suspend_default_console_level = 0;
+
+#ifdef CONFIG_NET
+static struct user_helper_data ui_helper_data;
+static struct suspend_module_ops userui_ops;
+static int orig_loglevel;
+static int orig_default_message_loglevel;
+static int orig_kmsg;
+
+static char lastheader[512];
+static int lastheader_message_len = 0;
+extern int console_suspended;
+
+/* Number of distinct progress amounts that userspace can display */
+static int progress_granularity = 30;
+
+DECLARE_WAIT_QUEUE_HEAD(userui_wait_for_key);
+

--
Nigel Cunningham		nigel at suspend2 dot net
