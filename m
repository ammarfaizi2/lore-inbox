Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVAVWJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVAVWJY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 17:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVAVWJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 17:09:24 -0500
Received: from mail.dif.dk ([193.138.115.101]:6591 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262755AbVAVWJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 17:09:16 -0500
Date: Sat, 22 Jan 2005 23:11:42 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] make loglevels in init/main.c a little more sane.
Message-ID: <Pine.LNX.4.61.0501222229210.3073@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch modifies a few of the printk() loglevels used in init/main.c in 
an attempt to make them a bit more appropriate.

The default loglevel is KERN_WARNING, but a few printk's without explicit 
loglevel are not (in my oppinion) warnings, so add proper warning levels - 
for instance; telling the user how many CPU's were brought up is hardly a 
warning, make it KERN_INFO instead. The initial printing of linux_banner 
is not a warning condition, I'd say it's more of a NOTICE or even INFO 
condition - I've made it KERN_NOTICE just as the printing of the kernel 
command line. A few printk's without explicit loglevel do match the 
default one, but I've made them explicit (the default could change in the 
future, and if it does then explicitly setting the proper loglevel is a 
nice thing).
Please consider applying.

Patch compiles and boots fine on my box.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.11-rc2-orig/init/main.c linux-2.6.11-rc2/init/main.c
--- linux-2.6.11-rc2-orig/init/main.c	2005-01-22 22:00:02.000000000 +0100
+++ linux-2.6.11-rc2/init/main.c	2005-01-22 22:45:23.000000000 +0100
@@ -347,7 +347,7 @@ static void __init smp_init(void)
 	}
 
 	/* Any cleanup work */
-	printk("Brought up %ld CPUs\n", (long)num_online_cpus());
+	printk(KERN_INFO "Brought up %ld CPUs\n", (long)num_online_cpus());
 	smp_cpus_done(max_cpus);
 #if 0
 	/* Get other processors into their bootup holding patterns. */
@@ -428,6 +428,7 @@ asmlinkage void __init start_kernel(void
  */
 	lock_kernel();
 	page_address_init();
+	printk(KERN_NOTICE);
 	printk(linux_banner);
 	setup_arch(&command_line);
 	setup_per_cpu_areas();
@@ -451,7 +452,7 @@ asmlinkage void __init start_kernel(void
 	preempt_disable();
 	build_all_zonelists();
 	page_alloc_init();
-	printk("Kernel command line: %s\n", saved_command_line);
+	printk(KERN_NOTICE "Kernel command line: %s\n", saved_command_line);
 	parse_early_param();
 	parse_args("Booting kernel", command_line, __start___param,
 		   __stop___param - __start___param,
@@ -558,7 +559,7 @@ static void __init do_initcalls(void)
 			local_irq_enable();
 		}
 		if (msg) {
-			printk("error in initcall at 0x%p: "
+			printk(KERN_WARNING "error in initcall at 0x%p: "
 				"returned with %s\n", *call, msg);
 		}
 	}
@@ -677,7 +678,7 @@ static int init(void * unused)
 	numa_default_policy();
 
 	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
-		printk("Warning: unable to open an initial console.\n");
+		printk(KERN_WARNING "Warning: unable to open an initial console.\n");
 
 	(void) sys_dup(0);
 	(void) sys_dup(0);



