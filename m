Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUHBEdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUHBEdz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 00:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266248AbUHBEdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 00:33:55 -0400
Received: from digitalimplant.org ([64.62.235.95]:34187 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S266245AbUHBEdt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 00:33:49 -0400
Date: Sun, 1 Aug 2004 21:33:33 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [14/25] Merge pmdisk and swsusp
In-Reply-To: <20040718221802.GE31958@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.50.0408012131490.25060-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0407171530410.22290-100000@monsoon.he.net>
 <20040718221802.GE31958@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Jul 2004, Pavel Machek wrote:

> Moving #ifdef inside function will result with a little less code...

Actually, we should change them to pr_debug(), like below. And, how about
makin it a config option, so one does not have to go around editing source
files to turn on the extra messages?

BTW, many of those printk()s could use some editing to make them
meaningful to average user. ;)


	Pat

diff -Nru a/kernel/power/Kconfig b/kernel/power/Kconfig
--- a/kernel/power/Kconfig	2004-08-01 21:32:06 -07:00
+++ b/kernel/power/Kconfig	2004-08-01 21:32:06 -07:00
@@ -18,6 +18,13 @@
 	  will issue the hlt instruction if nothing is to be done, thereby
 	  sending the processor to sleep and saving power.

+config PM_DEBUG
+	bool "Power Management Debug Support"
+	---help---
+	This option enables verbose debugging support in the Power Management
+	code. This is helpful when debugging and reporting various PM bugs,
+	like suspend support.
+
 config SOFTWARE_SUSPEND
 	bool "Software Suspend (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && PM && SWAP
diff -Nru a/kernel/power/Makefile b/kernel/power/Makefile
--- a/kernel/power/Makefile	2004-08-01 21:32:06 -07:00
+++ b/kernel/power/Makefile	2004-08-01 21:32:06 -07:00
@@ -1,4 +1,8 @@

+ifeq ($(CONFIG_PM_DEBUG),y)
+EXTRA_CFLAGS	+=	-DDEBUG
+endif
+
 swsusp-smp-$(CONFIG_SMP)	+= smp.o

 obj-y				:= main.o process.o console.o pm.o
diff -Nru a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c	2004-08-01 21:32:06 -07:00
+++ b/kernel/power/disk.c	2004-08-01 21:32:06 -07:00
@@ -8,9 +8,6 @@
  *
  */

-#define DEBUG
-
-
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <linux/reboot.h>
diff -Nru a/kernel/power/main.c b/kernel/power/main.c
--- a/kernel/power/main.c	2004-08-01 21:32:06 -07:00
+++ b/kernel/power/main.c	2004-08-01 21:32:06 -07:00
@@ -8,8 +8,6 @@
  *
  */

-#define DEBUG
-
 #include <linux/suspend.h>
 #include <linux/kobject.h>
 #include <linux/string.h>
diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-08-01 21:32:06 -07:00
+++ b/kernel/power/swsusp.c	2004-08-01 21:32:06 -07:00
@@ -123,26 +123,6 @@
 static const char name_resume[] = "Resume Machine: ";

 /*
- * Debug
- */
-#define	DEBUG_DEFAULT
-#undef	DEBUG_PROCESS
-#undef	DEBUG_SLOW
-#define TEST_SWSUSP 0		/* Set to 1 to reboot instead of halt machine after suspension */
-
-#ifdef DEBUG_DEFAULT
-# define PRINTK(f, a...)	printk(f, ## a)
-#else
-# define PRINTK(f, a...)       	do { } while(0)
-#endif
-
-#ifdef DEBUG_SLOW
-#define MDELAY(a) mdelay(a)
-#else
-#define MDELAY(a) do { } while(0)
-#endif
-
-/*
  * Saving part...
  */

@@ -328,27 +308,20 @@
 	return error;
 }

-#ifdef DEBUG
 static void dump_info(void)
 {
-	printk(" swsusp: Version: %u\n",swsusp_info.version_code);
-	printk(" swsusp: Num Pages: %ld\n",swsusp_info.num_physpages);
-	printk(" swsusp: UTS Sys: %s\n",swsusp_info.uts.sysname);
-	printk(" swsusp: UTS Node: %s\n",swsusp_info.uts.nodename);
-	printk(" swsusp: UTS Release: %s\n",swsusp_info.uts.release);
-	printk(" swsusp: UTS Version: %s\n",swsusp_info.uts.version);
-	printk(" swsusp: UTS Machine: %s\n",swsusp_info.uts.machine);
-	printk(" swsusp: UTS Domain: %s\n",swsusp_info.uts.domainname);
-	printk(" swsusp: CPUs: %d\n",swsusp_info.cpus);
-	printk(" swsusp: Image: %ld Pages\n",swsusp_info.image_pages);
-	printk(" swsusp: Pagedir: %ld Pages\n",swsusp_info.pagedir_pages);
+	pr_debug(" swsusp: Version: %u\n",swsusp_info.version_code);
+	pr_debug(" swsusp: Num Pages: %ld\n",swsusp_info.num_physpages);
+	pr_debug(" swsusp: UTS Sys: %s\n",swsusp_info.uts.sysname);
+	pr_debug(" swsusp: UTS Node: %s\n",swsusp_info.uts.nodename);
+	pr_debug(" swsusp: UTS Release: %s\n",swsusp_info.uts.release);
+	pr_debug(" swsusp: UTS Version: %s\n",swsusp_info.uts.version);
+	pr_debug(" swsusp: UTS Machine: %s\n",swsusp_info.uts.machine);
+	pr_debug(" swsusp: UTS Domain: %s\n",swsusp_info.uts.domainname);
+	pr_debug(" swsusp: CPUs: %d\n",swsusp_info.cpus);
+	pr_debug(" swsusp: Image: %ld Pages\n",swsusp_info.image_pages);
+	pr_debug(" swsusp: Pagedir: %ld Pages\n",swsusp_info.pagedir_pages);
 }
-#else
-static void dump_info(void)
-{
-
-}
-#endif

 static void init_header(void)
 {
@@ -574,7 +547,7 @@
 	if (PageNosave(page))
 		return 0;
 	if (PageReserved(page) && pfn_is_nosave(pfn)) {
-		PRINTK("[nosave pfn 0x%lx]", pfn);
+		pr_debug("[nosave pfn 0x%lx]", pfn);
 		return 0;
 	}
 	if ((chunk_size = is_head_of_free_region(page))) {
