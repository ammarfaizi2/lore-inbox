Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbUKXNkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbUKXNkE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbUKXNgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:36:51 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:6806 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262679AbUKXNMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:12:24 -0500
Subject: Suspend 2 merge: 45/51: Bootsplash support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101300016.5805.377.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 00:02:01 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support for bootsplash.

I might switch to fbsplash soon. It is better supported.

diff -ruN 851-suspend-bootsplash-old/kernel/power/suspend_bootsplash.c 851-suspend-bootsplash-new/kernel/power/suspend_bootsplash.c
--- 851-suspend-bootsplash-old/kernel/power/suspend_bootsplash.c	1970-01-01 10:00:00.000000000 +1000
+++ 851-suspend-bootsplash-new/kernel/power/suspend_bootsplash.c	2004-11-11 07:30:21.000000000 +1100
@@ -0,0 +1,302 @@
+/*
+ * kernel/power/suspend2_bootsplash.c
+ *
+ * Copyright (C) 2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ * This file implements bootsplash support for suspend2.
+ */
+#define SUSPEND_CONSOLE_C
+
+#define __KERNEL_SYSCALLS__
+
+#include <linux/suspend.h>
+#include <linux/console.h>
+#include <linux/proc_fs.h>
+#include <linux/hardirq.h>
+#include <asm/hardirq.h>
+
+#include "plugins.h"
+#include "proc.h"
+#include "suspend.h"
+
+static int barwidth = 100, barposn = -1, newbarposn = 0;
+static int lastloglevel = -1;
+
+/* Your bootsplash progress bar may have a width of (eg) 1024 pixels. That
+ * doesn't necessarily mean you want the bar updated 1024 times when writing
+ * the image */
+static int bar_granularity_limit = 0;
+
+/* ------------------  Splash screen defines  -------------------------- */
+
+extern struct display fb_display[MAX_NR_CONSOLES];
+
+/* splash_is_on
+ * 
+ * Description: Determine whether a VT has a splash screen on.
+ * Arguments:	int consolenr. The VT number of a console to check.
+ * Returns:	Boolean indicating whether the splash screen for
+ *		that console is on right now.
+ */
+static int splash_is_on(int consolenr)
+{
+	struct splash_data *info = get_splash_data(consolenr);
+
+	if (info)
+		return ((info->splash_state & 1) == 1);
+	return 0;
+}
+
+/* splash_write_proc.
+ *
+ * Write to Bootsplash's proc entry. We need this to work when /proc
+ * hasn't been mounted yet and / can't be mounted. In addition, we
+ * want it to work despite the fact that bootsplash (under 2.4 at least)
+ * removes its proc entry when it shouldn't.  We therefore use
+ * our proc.c find_proc_dir_entry routine to get the location of the
+ * write routine once (boot time & at start of each resume), and keep it.
+ */
+
+extern struct proc_dir_entry * find_proc_dir_entry(const char *name,
+	struct proc_dir_entry *parent);
+
+static void splash_write_proc(const char *buffer, unsigned long count)
+{
+	static write_proc_t * write_routine;
+	struct proc_dir_entry * proc_entry;
+
+	if (in_interrupt())
+		return;
+
+	if (unlikely(!write_routine)) {
+		proc_entry = find_proc_dir_entry("splash", &proc_root);
+		if (proc_entry)
+			write_routine = proc_entry->write_proc;
+	}
+        
+	if (write_routine)
+                write_routine(NULL, buffer, count, NULL);
+}
+
+/* fb_splash-set_progress
+ *
+ * Description:	Set the progress bar position for a splash screen.
+ * Arguments:	int consolenr. The VT number of a console to use.
+ * 		unsigned long value, unsigned long maximum:
+ * 		The proportion (value/maximum) of the bar to fill.
+ */
+
+static int fb_splash_set_progress(int consolenr, unsigned long value,
+	unsigned long maximum)
+{
+	char procstring[15];
+	int length, bitshift = generic_fls(maximum) - 16;
+	static unsigned long lastvalue = 0;
+	unsigned long thisvalue;
+
+	BUG_ON(consolenr >= MAX_NR_CONSOLES);
+	
+	if (in_interrupt())
+		return 0;
+
+	if (value > maximum)
+		value = maximum;
+
+	/* Avoid math problems - we can't do 64 bit math here
+	 * (and don't need it - anyone got screen resolution
+	 * of 65536 pixels or more?) */
+	if (bitshift > 0) {
+		maximum = maximum >> bitshift;
+		value = value >> bitshift;
+	}
+
+	thisvalue = value * 65534 / maximum;
+
+	length = sprintf(procstring, "show %lu", thisvalue);
+
+	splash_write_proc(procstring, length);
+	
+	lastvalue = thisvalue;
+	
+	return 0;
+}
+
+/* bootsplash_loglevel_change
+ *
+ * Description:	Update the display when the user changes the log level.
+ */
+
+static void bootsplash_loglevel_change(void)
+{
+	/* Calculate progress bar width. Note that whether the
+	 * splash screen is on might have changed (this might be
+	 * the first call in a new cycle), so we can't take it
+	 * for granted that the width should be the same as
+	 * last time we came in here */
+	if (!splash_is_on(fg_console))
+		return;
+	
+	/* proc interface ensures bar_granularity_limit >= 0 */
+	if (bar_granularity_limit)
+		barwidth = bar_granularity_limit;
+	else
+		barwidth = 100;
+
+	/* Only reset the display if we're switching between nice display
+	 * and displaying debugging output */
+	if (console_loglevel > 1) {
+		if (lastloglevel < 2)
+			splash_write_proc("verbose\n", 9);
+	} else if (lastloglevel > 1)
+			splash_write_proc("silent\n", 8);
+	
+	lastloglevel = console_loglevel;
+}
+
+static void bootsplash_prepare(void)
+{
+	if (!splash_is_on(fg_console))
+		return;
+
+	if (console_loglevel < 2)
+		splash_write_proc("silent\n", 8);
+	else
+		splash_write_proc("verbose\n", 9);
+}
+
+/* bootsplash_update_progress
+ *
+ * Description: Update the progress bar and (if on) in-bar message.
+ * Arguments:	UL value, maximum: Current progress percentage (value/max).
+ * 		const char *fmt, ...: Message to be displayed in the middle
+ * 		of the progress bar.
+ * 		Note that a NULL message does not mean that any previous
+ * 		message is erased! For that, you need message with
+ * 		clearbar on.
+ * Returns:	Unsigned long: The next value where status needs to be updated.
+ * 		This is to reduce unnecessary calls to update_progress.
+ *
+ * Note that for Bootsplash, we ignore the in-bar message
+ */
+static unsigned long bootsplash_update_progress(
+		unsigned long value, unsigned long maximum,
+		const char *fmt, va_list args)
+{
+	unsigned long next_update = 0;
+	int bitshift = generic_fls(maximum) - 16;
+
+	if ((!maximum) || (!barwidth))
+		return maximum;
+
+	if (value < 0)
+		value = 0;
+
+	if (value > maximum)
+		value = maximum;
+
+	/* Try to avoid math problems - we can't do 64 bit math here
+	 * (and shouldn't need it - anyone got screen resolution
+	 * of 65536 pixels or more?) */
+	if (bitshift > 0) {
+		unsigned long temp_maximum = maximum >> bitshift;
+		unsigned long temp_value = value >> bitshift;
+		newbarposn = (int) (temp_value * barwidth / temp_maximum);
+	} else
+		newbarposn = (int) (value * barwidth / maximum);
+	
+	if (newbarposn < barposn)
+		barposn = 0;
+
+	next_update = ((newbarposn + 1) * maximum / barwidth) + 1;
+
+	if ((splash_is_on(fg_console)) &&
+			(newbarposn != barposn)) {
+		fb_splash_set_progress(fg_console, value, maximum);
+		barposn = newbarposn;
+	}
+	return next_update;
+}
+
+/*
+ * User interface specific /proc/suspend entries.
+ */
+static struct suspend_plugin_ops bootsplash_ops;
+
+static struct suspend_proc_data proc_params[] = {
+	{ .filename			= "bootsplash_granularity_limit",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		  .integer = {
+			  .variable	= &bar_granularity_limit,
+			  .minimum	= 1,
+			  .maximum	= 2000,
+		  }
+	  }
+	},
+
+	{ .filename			= "disable_bootsplash_support",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		.integer = {
+			.variable	= &bootsplash_ops.disabled,
+			.minimum	= 0,
+			.maximum	= 1,
+		}
+	  }
+	}
+};
+
+static struct suspend_plugin_ops bootsplash_ops = {
+	.type					= UI_PLUGIN,
+	.name					= "Bootsplash Support",
+	.ops = {
+		.ui = {
+			.prepare		= bootsplash_prepare,
+			.log_level_change	= bootsplash_loglevel_change,
+			.update_progress	= bootsplash_update_progress,
+			.post_kernel_restore_redraw =
+				bootsplash_prepare,
+		}
+	}
+};
+
+/* ---- Registration ---- */
+
+static __init int bootsplash_load(void)
+{
+	int i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+	int result;
+
+	if (!(result = suspend_register_plugin(&bootsplash_ops))) {
+		printk("Software Suspend Bootsplash Support loaded.\n");
+		for (i=0; i< numfiles; i++)
+			suspend_register_procfile(&proc_params[i]);
+	}
+	return result;
+}
+
+#ifdef MODULE
+static __exit void bootsplash_unload(void)
+{
+	int i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+
+	printk("Software Suspend Bootsplash support unloading.\n");
+
+	for (i=0; i< numfiles; i++)
+		suspend_unregister_procfile(&proc_params[i]);
+	
+	suspend_unregister_plugin(&bootsplash_ops);
+}
+
+module_init(bootsplash_load);
+module_exit(bootsplash_unload);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nigel Cunningham");
+MODULE_DESCRIPTION("Suspend2 Bootsplash support");
+#else
+late_initcall(bootsplash_load);
+#endif


