Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUGHLGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUGHLGJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 07:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265945AbUGHLGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 07:06:09 -0400
Received: from 154.192.88.213.host.tele1europe.se ([213.88.192.154]:59520 "EHLO
	defiant") by vger.kernel.org with ESMTP id S265943AbUGHLFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 07:05:53 -0400
Date: Thu, 8 Jul 2004 13:05:49 +0200
From: Erik Rigtorp <erik@rigtorp.com>
To: linux-kernel@vger.kernel.org
Cc: pavel@ucw.cz
Subject: [PATCH] swsusp bootsplash support
Message-ID: <20040708110549.GB9919@linux.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for bootsplash to swsusp. The code interfacing to
bootsplash needs some more work, currently it's more or less ripped from
swsusp2. Some more code could probably be moved into console.c instead.

Erik

diff -Nru linux-2.6.7/kernel/power/console.c linux-2.6.7-swsusp/kernel/power/console.c
--- linux-2.6.7/kernel/power/console.c	2004-06-16 07:18:37.000000000 +0200
+++ linux-2.6.7-swsusp/kernel/power/console.c	2004-07-07 15:41:27.000000000 +0200
@@ -8,6 +8,7 @@
 #include <linux/kbd_kern.h>
 #include <linux/console.h>
 #include "power.h"
+#include "splash.h"
 
 static int new_loglevel = 10;
 static int orig_loglevel;
@@ -30,13 +31,24 @@
 		return 1;
 	}
 
-	set_console(SUSPEND_CONSOLE);
+	if (splash_is_on(SUSPEND_SPLASH_CONSOLE))
+		set_console(SUSPEND_SPLASH_CONSOLE);
+	else
+		set_console(SUSPEND_CONSOLE);
 	release_console_sem();
 
-	if (vt_waitactive(SUSPEND_CONSOLE)) {
-		pr_debug("Suspend: Can't switch VCs.");
-		return 1;
+	if (splash_is_on(SUSPEND_SPLASH_CONSOLE)) {
+		if (vt_waitactive(SUSPEND_SPLASH_CONSOLE)) {
+			pr_debug("Suspend: Can't switch VCs.");
+			return 1;
+		}
+	} else {
+		if (vt_waitactive(SUSPEND_CONSOLE)) {
+			pr_debug("Suspend: Can't switch VCs.");
+			return 1;
+		}
 	}
+
 	orig_kmsg = kmsg_redirect;
 	kmsg_redirect = SUSPEND_CONSOLE;
 #endif
diff -Nru linux-2.6.7/kernel/power/Makefile linux-2.6.7-swsusp/kernel/power/Makefile
--- linux-2.6.7/kernel/power/Makefile	2004-06-16 07:19:52.000000000 +0200
+++ linux-2.6.7-swsusp/kernel/power/Makefile	2004-07-04 22:14:44.000000000 +0200
@@ -1,5 +1,5 @@
 obj-y				:= main.o process.o console.o pm.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o splash.o
 obj-$(CONFIG_PM_DISK)		+= disk.o pmdisk.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
diff -Nru linux-2.6.7/kernel/power/splash.c linux-2.6.7-swsusp/kernel/power/splash.c
--- linux-2.6.7/kernel/power/splash.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-swsusp/kernel/power/splash.c	2004-07-07 15:12:28.000000000 +0200
@@ -0,0 +1,112 @@
+/* 
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2004 Nigel Cunningham <ncunningham@users.sourceforge.net>
+ * Copyright (C)      2004 Erik Rigtorp <erik@rigtorp.com>
+ */
+
+#include <linux/suspend.h>
+#include <linux/console.h>
+#include <linux/interrupt.h>
+#include <linux/bitops.h>
+#include <linux/proc_fs.h>
+#include "../../drivers/video/console/fbcon.h"
+
+#if defined(CONFIG_PROC_FS) && defined(CONFIG_BOOTSPLASH)
+
+extern struct display fb_display[MAX_NR_CONSOLES];
+
+static inline struct splash_data * get_splash_data(int consolenr)
+{   
+           BUG_ON(consolenr >= MAX_NR_CONSOLES);
+   
+           if (vc_cons[consolenr].d)
+                     return vc_cons[consolenr].d->vc_splash_data;
+   
+           return NULL;
+}
+
+int splash_is_on(int consolenr)
+{
+	struct splash_data *info = get_splash_data(consolenr);
+
+	if (info)
+		return ((info->splash_state & 1) == 1);
+   
+	return 0;
+}
+
+static struct proc_dir_entry * find_proc_dir_entry(const char *name, 
+	    struct proc_dir_entry *parent)
+{
+	struct proc_dir_entry **p;
+	int len;
+
+	len = strlen(name);
+	for (p = &parent->subdir; *p; p=&(*p)->next ) {
+		if (proc_match(len, name, *p)) {
+			return *p;
+		}
+	}
+	return NULL;
+}
+
+/* FIXME: we only care about bootsplash under 2.6, is this nescesaary then? */
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
+void splash_write_proc(const char *buffer, unsigned long count)
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
+/* Set the progress bar position for a splash screen. */
+int splash_set_progress(unsigned long value, unsigned long maximum)
+{
+	char buf[15];
+	int length, bitshift = generic_fls(maximum) - 16;
+	
+	if (in_interrupt())
+		return 0;
+
+	if (value > maximum)
+		value = maximum;
+
+	/* Avoid math problems - we can't do 64 bit math here */
+	if (bitshift > 0) {
+		maximum = maximum >> bitshift;
+		value = value >> bitshift;
+	}
+
+	length = sprintf(buf, "show %lu", value * 65534 / maximum);
+	splash_write_proc(buf, length);
+	
+	return 0;
+}
+
+EXPORT_SYMBOL(splash_is_on);
+EXPORT_SYMBOL(splash_write_proc);
+EXPORT_SYMBOL(splash_set_progress);
+
+#endif
diff -Nru linux-2.6.7/kernel/power/splash.h linux-2.6.7-swsusp/kernel/power/splash.h
--- linux-2.6.7/kernel/power/splash.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-swsusp/kernel/power/splash.h	2004-07-07 14:28:21.000000000 +0200
@@ -0,0 +1,21 @@
+#ifndef _SPLASH_H
+#define _SPLASH_H
+
+#define SUSPEND_SPLASH_CONSOLE 0
+
+#if defined(CONFIG_PROC_FS) && defined(CONFIG_BOOTSPLASH)
+
+int splash_is_on(int consolenr);
+void splash_write_proc(const char *buffer, unsigned long count);
+int splash_set_progress(unsigned long value, unsigned long maximum);
+
+#else
+#define splash_is_on(consolenr) (0)
+#define splash_set_progress(...) do { } while(0)
+#define splash_write_proc(...) do { } while(0)
+#endif
+
+#define splash_set_verbose() splash_write_proc("verbose\n", 9);
+#define splash_set_silent() splash_write_proc("silent\n", 8);
+
+#endif
diff -Nru linux-2.6.7/kernel/power/swsusp.c linux-2.6.7-swsusp/kernel/power/swsusp.c
--- linux-2.6.7/kernel/power/swsusp.c	2004-06-16 07:19:02.000000000 +0200
+++ linux-2.6.7-swsusp/kernel/power/swsusp.c	2004-07-07 15:33:01.000000000 +0200
@@ -69,6 +69,7 @@
 #include <asm/io.h>
 
 #include "power.h"
+#include "splash.h"
 
 unsigned char software_suspend_enabled = 0;
 
@@ -312,11 +313,15 @@
 
 	if (!buffer)
 		return -ENOMEM;
-
+   
 	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
 	for (i=0; i<nr_copy_pages; i++) {
-		if (!(i%100))
+		if (!(i%100)) {
+			if (splash_is_on(SUSPEND_SPLASH_CONSOLE))
+				splash_set_progress(i, nr_copy_pages);
 			printk( "." );
+		}
+
 		if (!(entry = get_swap_page()).val)
 			panic("\nNot enough swapspace when writing data" );
 		
@@ -829,6 +834,12 @@
 	}		
 	if (pm_prepare_console())
 		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
+   
+	if (splash_is_on(SUSPEND_SPLASH_CONSOLE)) {
+		splash_set_progress(0, 1);
+		splash_set_silent();
+	}
+	   
 	if (!prepare_suspend_processes()) {
 
 		/* At this point, all user processes and "dangerous"
@@ -855,6 +866,10 @@
 	software_suspend_enabled = 1;
 	MDELAY(1000);
 	pm_restore_console();
+
+	if (splash_is_on(SUSPEND_SPLASH_CONSOLE))
+		splash_set_verbose();
+
 	return res;
 }
 
@@ -1067,6 +1082,9 @@
 	printk( "%sSignature found, resuming\n", name_resume );
 	MDELAY(1000);
 
+   	if (pm_prepare_console())
+		printk("swsusp: Can't allocate a console... proceeding\n");
+   
 	if (bdev_read_page(bdev, next.val, cur)) return -EIO;
 	if (sanity_check(&cur->sh)) 	/* Is this same machine? */	
 		return -EPERM;
@@ -1100,8 +1118,12 @@
 	printk( "Reading image data (%d pages): ", nr_copy_pages );
 	for(i=0; i < nr_copy_pages; i++) {
 		swp_entry_t swap_address = (pagedir_nosave+i)->swap_address;
-		if (!(i%100))
+		if (!(i%100)) {
+			if (splash_is_on(SUSPEND_SPLASH_CONSOLE))
+				splash_set_progress(i, nr_copy_pages);
 			printk( "." );
+		}
+	   
 		/* You do not need to check for overlaps...
 		   ... check_pagedir already did this work */
 		if (bdev_read_page(bdev, swp_offset(swap_address) * PAGE_SIZE, (char *)((pagedir_nosave+i)->address)))
@@ -1190,9 +1212,6 @@
 	}
 	MDELAY(1000);
 
-	if (pm_prepare_console())
-		printk("swsusp: Can't allocate a console... proceeding\n");
-
 	if (!resume_file[0] && resume_status == RESUME_SPECIFIED) {
 		printk( "suspension device unspecified\n" );
 		return -EINVAL;
@@ -1206,7 +1225,6 @@
 	panic("This never returns");
 
 read_failure:
-	pm_restore_console();
 	return 0;
 }
 
