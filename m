Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267831AbTGHWTc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267838AbTGHWTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:19:32 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:4022 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S267831AbTGHWTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:19:18 -0400
Date: Wed, 9 Jul 2003 00:33:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       torvalds@transmeta.com
Subject: Suspend: PRINTK() cleanups
Message-ID: <20030708223339.GB183@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This cleans PRINTK()s a bit, and schedule()s at the end of thaw, so
processes are unstuck here. Please apply,
							Pavel

--- /usr/src/tmp/linux/kernel/suspend.c	2003-07-09 00:21:15.000000000 +0200
+++ /usr/src/linux/kernel/suspend.c	2003-07-08 14:11:28.000000000 +0200
@@ -149,15 +149,15 @@
 #define TEST_SWSUSP 1		/* Set to 1 to reboot instead of halt machine after suspension */
 
 #ifdef DEBUG_DEFAULT
-# define PRINTK(f, a...)       printk(f, ## a)
+# define PRINTK(f, a...)	do { printk(f, ## a); } while (0)
 #else
-# define PRINTK(f, a...)
+# define PRINTK(f, a...)	do {} while (0)
 #endif
 
 #ifdef DEBUG_SLOW
 #define MDELAY(a) mdelay(a)
 #else
-#define MDELAY(a)
+#define MDELAY(a) do {} while (0)
 #endif
 
 /*
@@ -247,13 +247,15 @@
 	do_each_thread(g, p) {
 		INTERESTING(p);
 		
-		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
+		if (p->flags & PF_FROZEN)
+			p->flags &= ~PF_FROZEN;
 		else
 			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
 		wake_up_process(p);
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
+	schedule();
 	printk( " done\n" );
 	MDELAY(500);
 }
@@ -871,7 +873,6 @@
 			 * using normal kernel mechanism.
 			 */
 			do_magic(0);
-		PRINTK("Restarting processes...\n");
 		thaw_processes();
 	}
 	software_suspend_enabled = 1;

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
