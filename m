Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbVKYWyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVKYWyA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 17:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbVKYWyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 17:54:00 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:13499 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932445AbVKYWx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 17:53:59 -0500
Subject: [PATCH -rt] convert watchdog cpu5wdt from compat_sem to completion.
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>,
       Aleksey Makarov <amakarov@dev.rtsoft.ru>
In-Reply-To: <1132929218.11915.2.camel@localhost.localdomain>
References: <438709F5.1050801@dev.rtsoft.ru>
	 <1132929218.11915.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 17:53:49 -0500
Message-Id: <1132959229.24417.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK Ingo,

This one is the last.  Of the compat_semaphores in drivers that I looked
at, these were the trivial ones.  The other ones I would not touch
unless I had hardware to test with, or the time to look deeper into it.

-- Steve

Index: linux-2.6.14-rt15/drivers/char/watchdog/cpu5wdt.c
===================================================================
--- linux-2.6.14-rt15.orig/drivers/char/watchdog/cpu5wdt.c	2005-11-25 10:14:09.000000000 -0500
+++ linux-2.6.14-rt15/drivers/char/watchdog/cpu5wdt.c	2005-11-25 16:57:31.000000000 -0500
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/timer.h>
+#include <linux/completion.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
@@ -56,7 +57,7 @@
 /* some device data */
 
 static struct {
-	struct compat_semaphore stop;
+	struct completion stop;
 	volatile int running;
 	struct timer_list timer;
 	volatile int queue;
@@ -84,7 +85,7 @@
 	}
 	else {
 		/* ticks doesn't matter anyway */
-		up(&cpu5wdt_device.stop);
+		complete(&cpu5wdt_device.stop);
 	}
 
 }
@@ -238,7 +239,7 @@
 	if ( !val )
 		printk(KERN_INFO PFX "sorry, was my fault\n");
 
-	init_MUTEX_LOCKED(&cpu5wdt_device.stop);
+	init_completion(&cpu5wdt_device.stop);
 	cpu5wdt_device.queue = 0;
 
 	clear_bit(0, &cpu5wdt_device.inuse);
@@ -268,7 +269,7 @@
 {
 	if ( cpu5wdt_device.queue ) {
 		cpu5wdt_device.queue = 0;
-		down(&cpu5wdt_device.stop);
+		wait_for_completion(&cpu5wdt_device.stop);
 	}
 
 	misc_deregister(&cpu5wdt_misc);


