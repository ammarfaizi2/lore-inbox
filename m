Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263226AbUEWRhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUEWRhq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 13:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUEWRhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 13:37:46 -0400
Received: from gprs214-26.eurotel.cz ([160.218.214.26]:20864 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263226AbUEWRgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 13:36:11 -0400
Date: Sun, 23 May 2004 19:35:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: samg <samg@seven4sky.com>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Smp swsusp testing wanted
Message-ID: <20040523173559.GA1558@elf.ucw.cz>
References: <20040522143628.A6D3927327@smtp.etmail.cz> <40B0014B.1030002@seven4sky.com> <20040523173457.GB804@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523173457.GB804@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >Hi! If you have smp machine where swsusp works with only one procesor and 
> > >can test patches, please let me know. --p
> 
> > I have  (1) smp machine (dual proc), running 2.4.18/2.6.5/2.6.6,  If you 
> > have a patch I can test it for you.
> 
> Please verify that swsusp works in "UP" mode, first. Then apply this
> and go to "SMP" mode, and see if it still works.
> 
> I have SMP machine here but swsusp will not work there even in "UP"
> mode; I'll need to debug it. 

Sorry, here it is.
								Pavel

--- clean/include/linux/suspend.h	2004-05-20 23:11:46.000000000 +0200
+++ linux/include/linux/suspend.h	2004-05-21 15:02:33.000000000 +0200
@@ -81,6 +81,14 @@
 }
 #endif	/* CONFIG_PM */
 
+#ifdef CONFIG_SMP
+extern void smp_freeze(void);
+extern void smp_restart(void);
+#else
+static inline void smp_freeze(void) {}
+static inline void smp_restart(void) {}
+#endif
+
 asmlinkage void do_magic(int is_resume);
 asmlinkage void do_magic_resume_1(void);
 asmlinkage void do_magic_resume_2(void);
--- clean/kernel/power/Makefile	2003-09-28 22:06:44.000000000 +0200
+++ linux/kernel/power/Makefile	2004-05-21 14:22:50.000000000 +0200
@@ -1,4 +1,5 @@
 obj-y				:= main.o process.o console.o pm.o
+obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
 obj-$(CONFIG_PM_DISK)		+= disk.o pmdisk.o
 
--- clean/kernel/power/smp.c	2004-05-21 14:08:45.000000000 +0200
+++ linux/kernel/power/smp.c	2004-05-21 14:46:40.000000000 +0200
@@ -0,0 +1,62 @@
+/*
+ * drivers/power/smp.c - Functions for stopping other CPUs.
+ *
+ * Copyright 2004 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Nigel Cunningham <ncunningham@clear.net.nz>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#undef DEBUG
+
+#include <linux/smp_lock.h>
+#include <linux/interrupt.h>
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <asm/atomic.h>
+
+static atomic_t cpu_counter, freeze;
+
+static void smp_pause(void * data)
+{
+	atomic_inc(&cpu_counter);
+	while (atomic_read(&freeze)) {
+		cpu_relax();
+		barrier();
+		{
+			int i;
+			for (i=0; i<10000; i++)
+				barrier();
+		}
+	}
+	atomic_dec(&cpu_counter);
+}
+
+void smp_freeze(void)
+{
+	/* FIXME: for this to work, all the CPUs must be running
+	 * "idle" thread (or we deadlock). Is that guaranteed? */
+	printk("Freezing CPUs...");
+	atomic_set(&cpu_counter, 0);
+	atomic_set(&freeze, 1);
+	smp_call_function(smp_pause, NULL, 0, 0);
+	if (num_online_cpus() != 2)
+		printk("not HT machine?");
+	while (atomic_read(&cpu_counter) < (num_online_cpus() - 1)) {
+		cpu_relax();
+		barrier();
+	}
+	printk("ok\n");
+}
+
+void smp_restart(void)
+{
+	printk("Restarting CPUs...");
+	atomic_set(&freeze, 0);
+	while (atomic_read(&cpu_counter)) {
+		cpu_relax();
+		barrier();
+	}
+	printk("ok\n");
+}
+
--- clean/kernel/power/swsusp.c	2004-05-21 09:49:11.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-05-21 14:39:38.000000000 +0200
@@ -859,6 +859,8 @@
 
 		free_some_memory();
 		
+		mdelay(1000);
+		smp_freeze();
 		/* Save state of all device drivers, and stop them. */		   
 		if ((res = device_suspend(4))==0)
 			/* If stopping device drivers worked, we proceed basically into
@@ -872,6 +874,7 @@
 			 */
 			do_magic(0);
 		thaw_processes();
+		smp_restart();
 	} else
 		res = -EBUSY;
 	software_suspend_enabled = 1;
@@ -1195,8 +1198,7 @@
 static int __init software_resume(void)
 {
 	if (num_online_cpus() > 1) {
-		printk(KERN_WARNING "Software Suspend has malfunctioning SMP support. Disabled :(\n");	
-		return -EINVAL;
+		printk(KERN_WARNING "SMP support is very experimental.\n");	
 	}
 	/* We enable the possibility of machine suspend */
 	software_suspend_enabled = 1;
@@ -1223,6 +1225,8 @@
 	printk( "resuming from %s\n", resume_file);
 	if (read_suspend_image(resume_file, 0))
 		goto read_failure;
+	mdelay(1000);
+	smp_freeze();
 	device_suspend(4);
 	do_magic(1);
 	panic("This never returns");


-- 
934a471f20d6580d5aad759bf0d97ddc
