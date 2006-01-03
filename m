Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWACKL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWACKL1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 05:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWACKKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 05:10:40 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:62690 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751355AbWACKKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 05:10:03 -0500
Date: Tue, 3 Jan 2006 11:09:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 17/19] mutex subsystem, semaphore to completion: CPU3WDT
Message-ID: <20060103100951.GQ23289@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

change CPU3WDT semaphores to completions.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 drivers/char/watchdog/cpu5wdt.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

Index: linux/drivers/char/watchdog/cpu5wdt.c
===================================================================
--- linux.orig/drivers/char/watchdog/cpu5wdt.c
+++ linux/drivers/char/watchdog/cpu5wdt.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/timer.h>
+#include <linux/completion.h>
 #include <linux/jiffies.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -57,7 +58,7 @@ static int ticks = 10000;
 /* some device data */
 
 static struct {
-	struct semaphore stop;
+	struct completion stop;
 	volatile int running;
 	struct timer_list timer;
 	volatile int queue;
@@ -85,7 +86,7 @@ static void cpu5wdt_trigger(unsigned lon
 	}
 	else {
 		/* ticks doesn't matter anyway */
-		up(&cpu5wdt_device.stop);
+		complete(&cpu5wdt_device.stop);
 	}
 
 }
@@ -239,7 +240,7 @@ static int __devinit cpu5wdt_init(void)
 	if ( !val )
 		printk(KERN_INFO PFX "sorry, was my fault\n");
 
-	init_MUTEX_LOCKED(&cpu5wdt_device.stop);
+	init_completion(&cpu5wdt_device.stop);
 	cpu5wdt_device.queue = 0;
 
 	clear_bit(0, &cpu5wdt_device.inuse);
@@ -269,7 +270,7 @@ static void __devexit cpu5wdt_exit(void)
 {
 	if ( cpu5wdt_device.queue ) {
 		cpu5wdt_device.queue = 0;
-		down(&cpu5wdt_device.stop);
+		wait_for_completion(&cpu5wdt_device.stop);
 	}
 
 	misc_deregister(&cpu5wdt_misc);
