Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTDDNcs (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 08:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263546AbTDDNZp (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 08:25:45 -0500
Received: from smtp-out2.iol.cz ([194.228.2.87]:24509 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263531AbTDDNTo (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 08:19:44 -0500
Date: Fri, 4 Apr 2003 15:30:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: New Software Suspend Patch for testing.
Message-ID: <20030404133037.GA1333@elf.ucw.cz>
References: <1049454721.2418.33.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049454721.2418.33.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hopefully I'll soon find time to start bombarding Pavel, Patrick and
> Linus with incremental patches for merging :>. In the meantime, please
> give it a go.

Okay, lets take a look.

diff -ruN linux-2.5.66-original/arch/i386/kernel/cpu/mtrr/main.c linux-2.5.66-04/arch/i386/kernel/cpu/mtrr/main.c
--- linux-2.5.66-original/arch/i386/kernel/cpu/mtrr/main.c	2003-01-15 17:00:38.000000000 +1300
+++ linux-2.5.66-04/arch/i386/kernel/cpu/mtrr/main.c	2003-03-26 09:00:29.000000000 +1200
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/smp.h>
+#include <linux/suspend.h>
 
 #include <asm/mtrr.h>
 
@@ -644,6 +645,65 @@
     "write-protect",            /* 5 */
     "write-back",               /* 6 */
 };
-
+ 
+#ifdef SOFTWARE_SUSPEND_MTRR
+struct mtrr_suspend_state
+{
+     mtrr_type ltype;
+     unsigned long lbase;
+     unsigned int lsize;
+};
...

Please convert this to driver model and submit to mtrr maintainer.

diff -ruN linux-2.5.66-original/drivers/base/power.c linux-2.5.66-04/drivers/base/power.c
--- linux-2.5.66-original/drivers/base/power.c	2003-01-15 17:01:06.000000000 +1300
+++ linux-2.5.66-04/drivers/base/power.c	2003-04-04 20:51:40.000000000 +1200
@@ -35,8 +35,6 @@
 	struct list_head * node;
 	int error = 0;
 
-	printk(KERN_EMERG "Suspending devices\n");
-
 	down_write(&devices_subsys.rwsem);
 	list_for_each(node,&devices_subsys.kset.list) {
 		struct device * dev = to_dev(node);
@@ -73,7 +71,7 @@
 	}
 	up_write(&devices_subsys.rwsem);
 
-	printk(KERN_EMERG "Devices Resumed\n");
+	printk(KERN_INFO "Devices Resumed\n");
 }
 
 /**
@@ -83,7 +81,7 @@
 {
 	struct list_head * entry;
 	
-	printk(KERN_EMERG "Shutting down devices\n");
+	printk(KERN_INFO "Shutting down devices\n");
 
 	down_write(&devices_subsys.rwsem);
 	list_for_each(entry,&devices_subsys.kset.list) {

I guess that submitting this as trivial is okay.

diff -ruN linux-2.5.66-original/drivers/char/vt.c linux-2.5.66-04/drivers/char/vt.c
--- linux-2.5.66-original/drivers/char/vt.c	2003-03-26 08:56:47.000000000 +1200
+++ linux-2.5.66-04/drivers/char/vt.c	2003-03-26 09:00:29.000000000 +1200
@@ -149,13 +149,13 @@
 static void vc_init(unsigned int console, unsigned int rows,
 		    unsigned int cols, int do_clear);
 static void blank_screen(unsigned long dummy);
-static void gotoxy(int currcons, int new_x, int new_y);
+void gotoxy(int currcons, int new_x, int new_y);
 static void save_cur(int currcons);
-static void reset_terminal(int currcons, int do_clear);
+void reset_terminal(int currcons, int do_clear);
 static void con_flush_chars(struct tty_struct *tty);
 static void set_vesa_blanking(unsigned long arg);
 static void set_cursor(int currcons);
-static void hide_cursor(int currcons);
+void hide_cursor(int currcons);
 static void unblank_screen_t(unsigned long dummy);
 static void console_callback(void *ignored);
 static void __init con_init_devfs (void);

This is ugly as night. Is not there any public function (sys_write?)
you could use instead?

diff -ruN linux-2.5.66-original/drivers/ide/ide-disk.c linux-2.5.66-04/drivers/ide/ide-disk.c
--- linux-2.5.66-original/drivers/ide/ide-disk.c	2003-03-26 08:56:49.000000000 +1200
+++ linux-2.5.66-04/drivers/ide/ide-disk.c	2003-04-04 20:22:09.000000000 +1200
@@ -1515,8 +1515,6 @@
 {
 	ide_drive_t *drive = dev->driver_data;
 
-	printk("Suspending device %p\n", dev->driver_data);
-
 	/* I hope that every freeze operation from the upper levels have
 	 * already been done...
 	 */
@@ -1525,7 +1523,6 @@
 		return 0;
 
 	/* set the drive to standby */
-	printk(KERN_INFO "suspending: %s ", drive->name);
 	do_idedisk_standby(drive);
 	drive->blocked = 1;
 
@@ -1539,8 +1536,8 @@
 
 	if (level != RESUME_RESTORE_STATE)
 		return 0;
-	BUG_ON(!drive->blocked);
-	drive->blocked = 0;
+	if (drive->blocked)
+		drive->blocked--;
 	return 0;
 }
 

Please submitt this to alan, as soon as possible.

@@ -1804,7 +1801,8 @@
 	if ((!drive->head || drive->head > 16) && !drive->select.b.lba) {
 		printk(KERN_ERR "%s: INVALID GEOMETRY: %d PHYSICAL HEADS?\n",
 			drive->name, drive->head);
-		if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
+		if (((drive->id->cfs_enable_2 & 0x3000) && drive->wcache) ||
+		    ((drive->id->command_set_1 & 0x20) && drive->id->cfs_enable_1 & 0x20))
 			if (do_idedisk_flushcache(drive))
 				printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
 					drive->name);

Is this swsusp related?

diff -ruN linux-2.5.66-original/include/linux/pagemap.h linux-2.5.66-04/include/linux/pagemap.h
--- linux-2.5.66-original/include/linux/pagemap.h	2003-03-26 08:57:06.000000000 +1200
+++ linux-2.5.66-04/include/linux/pagemap.h	2003-03-26 09:00:29.000000000 +1200
@@ -8,6 +8,9 @@
 #include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/highmem.h>
+#ifdef CONFIG_SOFTWARE_SUSPEND
+#include <linux/suspend.h>
+#endif
 #include <asm/uaccess.h>
 
 /*

Do not use #ifdefs around includes.

@@ -123,6 +126,8 @@
 	page->mapping = mapping;
 	page->index = index;
 
+	if (suspend_task) 
+		last_suspend_cache_page = page;
 	mapping->nrpages++;
 	pagecache_acct(1);
 }
diff -ruN linux-2.5.66-original/include/linux/suspend-debug.h linux-2.5.66-04/include/linux/suspend-debug.h
--- linux-2.5.66-original/include/linux/suspend-debug.h	1970-01-01 12:00:00.000000000 +1200
+++ linux-2.5.66-04/include/linux/suspend-debug.h	2003-04-04 19:37:44.000000000 +1200
@@ -0,0 +1,61 @@
+
+#ifndef _LINUX_SWSUSP_DEBUG_H
+#define _LINUX_SWSUSP_DEBUG_H
+
+#include <linux/suspend.h>
+
+#define name_suspend "Suspend Machine:  "
+#define name_resume  "Resume Machine:   "
+#define swsusp_version "beta 19-20"
+#define name_swsusp  "Swsusp " swsusp_version ":   "
+#define console_suspend "S U S P E N D   T O   D I S K"
+#define console_resume "R E S U M E   F R O M   D I S K"

This is ugly. Are you trying to make it hard to read on purpose?

diff -ruN linux-2.5.66-original/include/linux/sysctl.h linux-2.5.66-04/include/linux/sysctl.h
--- linux-2.5.66-original/include/linux/sysctl.h	2003-03-01 15:10:38.000000000 +1300
+++ linux-2.5.66-04/include/linux/sysctl.h	2003-03-26 09:00:29.000000000 +1200
@@ -129,6 +129,7 @@
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
+        KERN_SWSUSP=57,		/* struct: interface to configure & activate software suspension */
 };
 
 

Is sysctl being used besides debugging?
 
 unsigned char software_suspend_enabled = 0;
+unsigned int suspend_task = 0;
+/*
+ * Poll the swsusp state every second
+ */
+#define SWSUSP_CHECK_TIMEOUT	(HZ)

What is this?

 /*
  * XXX: We try to keep some more pages free so that I/O operations succeed
  * without paging. Might this be more?
  */
-#define PAGES_FOR_IO	512
+#define PAGES_FOR_IO 512
+
+#ifdef DEBUG_DEFAULT
+int currentstage = 0;
+int swsusp_state[5] = {0,	/* when set to 1 swsusp_mainloop activates software_suspend (2.4 only)
+				   bit 0: off = normal state, on = suspend required
+				   bit 1: aborting suspend
+				*/

Please kill 2.4 stuff from 2.5 patch.

-	if (mode == MARK_SWAP_RESUME) {
-	  	if (!memcmp("S1",cur->swh.magic.magic,2))
-		  	memcpy(cur->swh.magic.magic,"SWAP-SPACE",10);
-		else if (!memcmp("S2",cur->swh.magic.magic,2))
-			memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
-		else printk("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
-		      	name_resume, cur->swh.magic.magic);
-	} else {
-	  	if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)))
-		  	memcpy(cur->swh.magic.magic,"S1SUSP....",10);
-		else if ((!memcmp("SWAPSPACE2",cur->swh.magic.magic,10)))
-			memcpy(cur->swh.magic.magic,"S2SUSP....",10);
-		else panic("\nSwapspace is not swapspace (%.10s)\n", cur->swh.magic.magic);
-		cur->link.next = prev; /* prev is the first/last swap page of the resume area */
-		/* link.next lies *no more* in last 4/8 bytes of magic */
+	switch(mode) {
+	case MARK_SWAP_RESUME:
+		if (!memcmp("1R",cur.pointer->swh.magic.magic,2))
+			memcpy(cur.pointer->swh.magic.magic,"SWAP-SPACE",10);
+		else if (!memcmp("2R",cur.pointer->swh.magic.magic,2))
+			memcpy(cur.pointer->swh.magic.magic,"SWAPSPACE2",10);
+		else printk(name_resume "Unable to find suspended-data signature (%.10s - misspelled?\n", 
+			    cur.pointer->swh.magic.magic);
+		break;

I guess this is nicer than previous code, good.

Snip. Sorry, have to go.
									Pavel


-- 
When do you have heart between your knees?
