Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272271AbTHDWOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 18:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272276AbTHDWOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 18:14:21 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:59045 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272271AbTHDWON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 18:14:13 -0400
Date: Tue, 5 Aug 2003 00:13:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: swsusp updates
Message-ID: <20030804221349.GC3078@elf.ucw.cz>
References: <20030804201432.GA467@elf.ucw.cz> <20030804134338.5d0f65cd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804134338.5d0f65cd.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Here are swsusp updates, retransmitted. Please apply this time.
> 
> With CONFIG_SOFTWARE_SUSPEND=n:
> 
> kernel/suspend.c: In function `prepare_suspend_console':
> kernel/suspend.c:272: `orig_loglevel' undeclared (first use in this function)
> kernel/suspend.c:272: (Each undeclared identifier is reported only once
> kernel/suspend.c:272: for each function it appears in.)
> kernel/suspend.c:273: `new_loglevel' undeclared (first use in this function)
> kernel/suspend.c:276: `orig_fgconsole' undeclared (first use in this function)
> kernel/suspend.c: In function `restore_console':
> kernel/suspend.c:297: `orig_loglevel' undeclared (first use in this
function)

This should fix it: (incremental).
								Pavel

--- /usr/src/tmp/linux/kernel/suspend.c	2003-08-05 00:02:29.000000000 +0200
+++ /usr/src/linux/kernel/suspend.c	2003-08-04 23:55:07.000000000 +0200
@@ -69,15 +69,6 @@
 
 unsigned char software_suspend_enabled = 0;
 
-#define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
-/* With SUSPEND_CONSOLE defined, it suspend looks *really* cool, but
-   we probably do not take enough locks for switching consoles, etc,
-   so bad things might happen.
-*/
-#if !defined(CONFIG_VT) || !defined(CONFIG_VT_CONSOLE)
-#undef SUSPEND_CONSOLE
-#endif
-
 #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
 #define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)
 #define ADDRESS2(x) __ADDRESS(__pa(x))		/* Needed for x86-64 where some pages are in memory twice */
@@ -91,9 +82,6 @@
 spinlock_t suspend_pagedir_lock __nosavedata = SPIN_LOCK_UNLOCKED;
 
 /* Variables to be preserved over suspend */
-static int new_loglevel = 7;
-static int orig_loglevel = 0;
-static int orig_fgconsole, orig_kmsg;
 static int pagedir_order_check;
 static int nr_copy_pages_check;
 
@@ -267,6 +255,19 @@
 	MDELAY(500);
 }
 
+#define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
+/* With SUSPEND_CONSOLE defined, it suspend looks *really* cool, but
+   we probably do not take enough locks for switching consoles, etc,
+   so bad things might happen.
+*/
+#if !defined(CONFIG_VT) || !defined(CONFIG_VT_CONSOLE)
+#undef SUSPEND_CONSOLE
+#endif
+
+static int new_loglevel = 7;
+static int orig_loglevel = 0;
+static int orig_fgconsole, orig_kmsg;
+
 int prepare_suspend_console(void)
 {
 	orig_loglevel = console_loglevel;


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
