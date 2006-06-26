Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933116AbWFZWeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933116AbWFZWeh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933143AbWFZWeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:34:09 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:64746 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933111AbWFZWdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:33:21 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 01/16] [Suspend2] Suspend.c header.
Date: Tue, 27 Jun 2006 08:33:18 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223316.3832.96336.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
References: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Header file for the Suspend2's main c file.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend.c |  182 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 182 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
new file mode 100644
index 0000000..28bb91c
--- /dev/null
+++ b/kernel/power/suspend.c
@@ -0,0 +1,182 @@
+/*
+ * kernel/power/suspend.c
+ */
+/** \mainpage Suspend2.
+ *
+ * Suspend2 provides support for saving and restoring an image of
+ * system memory to an arbitrary storage device, either on the local computer,
+ * or across some network. The support is entirely OS based, so Suspend2 
+ * works without requiring BIOS, APM or ACPI support. The vast majority of the
+ * code is also architecture independant, so it should be very easy to port
+ * the code to new architectures. Suspend includes support for SMP, 4G HighMem
+ * and preemption. Initramfses and initrds are also supported.
+ *
+ * Suspend2 uses a modular design, in which the method of storing the image is
+ * completely abstracted from the core code, as are transformations on the data
+ * such as compression and/or encryption (multiple 'modules' can be used to
+ * provide arbitrary combinations of functionality). The user interface is also
+ * modular, so that arbitrarily simple or complex interfaces can be used to
+ * provide anything from debugging information through to eye candy.
+ * 
+ * \section Copyright
+ *
+ * Suspend2 is released under the GPLv2.
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu><BR>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz><BR>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr><BR>
+ * Copyright (C) 2002-2006 Nigel Cunningham <nigel@suspend2.net><BR>
+ *
+ * \section Credits
+ * 
+ * Nigel would like to thank the following people for their work:
+ * 
+ * Pavel Machek <pavel@ucw.cz><BR>
+ * Modifications, defectiveness pointing, being with Gabor at the very beginning,
+ * suspend to swap space, stop all tasks. Port to 2.4.18-ac and 2.5.17.
+ *
+ * Steve Doddi <dirk@loth.demon.co.uk><BR> 
+ * Support the possibility of hardware state restoring.
+ *
+ * Raph <grey.havens@earthling.net><BR>
+ * Support for preserving states of network devices and virtual console
+ * (including X and svgatextmode)
+ *
+ * Kurt Garloff <garloff@suse.de><BR>
+ * Straightened the critical function in order to prevent compilers from
+ * playing tricks with local variables.
+ *
+ * Andreas Mohr <a.mohr@mailto.de>
+ *
+ * Alex Badea <vampire@go.ro><BR>
+ * Fixed runaway init
+ *
+ * Jeff Snyder <je4d@pobox.com><BR>
+ * ACPI patch
+ *
+ * Nathan Friess <natmanz@shaw.ca><BR>
+ * Some patches.
+ *
+ * Michael Frank <mhf@linuxmail.org><BR>
+ * Extensive testing and help with improving stability. Nigel was constantly
+ * amazed by the quality and quantity of Michael's help.
+ *
+ * Bernard Blackham <bernard@blackham.com.au><BR>
+ * Web page & Wiki administration, some coding. Another person without whom
+ * Suspend would not be where it is.
+ *
+ * ..and of course the myriads of Suspend2 users who have helped diagnose
+ * and fix bugs, made suggestions on how to improve the code, proofread
+ * documentation, and donated time and money.
+ *
+ * Thanks also to corporate sponsors:
+ *
+ * <B>Cyclades.com.</B> Nigel's employers from Dec 2004, who allow him to work on
+ * Suspend and PM related issues on company time.
+ * 
+ * <B>LinuxFund.org.</B> Sponsored Nigel's work on Suspend for four months Oct 2003
+ * to Jan 2004.
+ *
+ * <B>LAC Linux.</B> Donated P4 hardware that enabled development and ongoing
+ * maintenance of SMP and Highmem support.
+ *
+ * <B>OSDL.</B> Provided access to various hardware configurations, make occasional
+ * small donations to the project.
+ */
+
+#define SUSPEND_MAIN_C
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/console.h>
+#include <linux/version.h>
+#include <linux/reboot.h>
+#include <linux/mm.h>
+#include <linux/highmem.h>
+#include <linux/freezer.h>
+#include <asm/uaccess.h>
+#include <asm/setup.h>
+
+#include "version.h"
+#include "suspend2.h"
+#include "suspend.h"
+#include "modules.h"
+#include "proc.h"
+#include "pageflags.h"
+#include "prepare_image.h"
+#include "io.h"
+#include "ui.h"
+#include "suspend2_common.h"
+#include "extent.h"
+#include "power_off.h"
+#include "storage.h"
+#include "power.h"
+
+#ifdef  CONFIG_X86
+#include <asm/i387.h> /* for kernel_fpu_end */
+#endif
+
+int suspend2_running;
+ 
+/* Variables to be preserved over suspend */
+long pageset1_sizelow = 0, pageset2_sizelow = 0, image_size_limit = 0;
+unsigned long suspend_orig_mem_free = 0;
+
+static char *debug_info_buffer;
+static char suspend_core_version[] = SUSPEND_CORE_VERSION;
+
+extern __nosavedata char suspend_resume_commandline[COMMAND_LINE_SIZE];
+
+unsigned long suspend_action = 0;
+unsigned long suspend_result = 0;
+unsigned long suspend_debug_state = 0;
+
+int suspend2_in_suspend __nosavedata;
+extern void copyback_post(void);
+extern int suspend2_suspend(void);
+extern int extra_pd1_pages_used;
+
+static int orig_system_state;
+
+/* 
+ * ---  Variables -----
+ * 
+ * The following are used by the arch specific low level routines 
+ * and only needed if suspend2 is compiled in. Other variables,
+ * used by the freezer even if suspend2 is not compiled in, are
+ * found in process.c
+ */
+
+/*! How long I/O took. */
+int suspend_io_time[2][2];
+
+/* Compression ratio */
+__nosavedata unsigned long bytes_in = 0, bytes_out = 0;
+
+/*! Pageset metadata. */
+struct pagedir pagedir1 = { 0, 0}, pagedir2 = { 0, 0}; 
+
+/* Suspend2 variables used by built-in routines. */
+
+/*! The number of suspends we have started (some may have been cancelled) */
+unsigned int nr_suspends = 0;
+
+/* 
+ * For resume2= kernel option. It's pointless to compile
+ * suspend2 without any writers, but compilation shouldn't
+ * fail if you do.
+ */
+
+unsigned long suspend_state = ((1 << SUSPEND_BOOT_TIME) |
+		(1 << SUSPEND_RESUME_NOT_DONE) | (1 << SUSPEND_IGNORE_LOGLEVEL));
+
+mm_segment_t	oldfs;
+
+char resume2_file[256] = CONFIG_SUSPEND2_DEFAULT_RESUME2;
+
+static atomic_t actions_running;
+
+extern int block_dump;
+
+int block_dump_save;
+

--
Nigel Cunningham		nigel at suspend2 dot net
