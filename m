Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263101AbUFNONN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUFNONN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbUFNONM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:13:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33031 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263041AbUFNOMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:12:21 -0400
Date: Mon, 14 Jun 2004 15:12:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] Provide console_device()
Message-ID: <20040614151217.H14403@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This patch series has also been separately sent to the architecture
 maintainers]

Add console_device() to return the console tty driver structure and the
index.  Acquire the console lock while scanning the list of console
drivers to protect us against console driver list manipulations.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/drivers/char/tty_io.c linux/drivers/char/tty_io.c
--- orig/drivers/char/tty_io.c	Wed Jun  9 00:51:02 2004
+++ linux/drivers/char/tty_io.c	Mon Jun 14 10:55:28 2004
@@ -1344,13 +1344,8 @@ retry_open:
 	}
 #endif
 	if (device == MKDEV(TTYAUX_MAJOR,1)) {
-		struct console *c = console_drivers;
-		for (c = console_drivers; c; c = c->next) {
-			if (!c->device)
-				continue;
-			driver = c->device(c, &index);
-			if (!driver)
-				continue;
+		driver = console_device(&index);
+		if (driver) {
 			/* Don't let /dev/console block */
 			filp->f_flags |= O_NONBLOCK;
 			noctty = 1;
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/kernel/printk.c linux/kernel/printk.c
--- orig/kernel/printk.c	Sun May 30 10:33:00 2004
+++ linux/kernel/printk.c	Mon Jun 14 10:56:18 2004
@@ -683,6 +683,23 @@ void console_unblank(void)
 }
 EXPORT_SYMBOL(console_unblank);
 
+struct tty_driver *console_device(int *index)
+{
+	struct console *c;
+	struct tty_driver *driver = NULL;
+
+	acquire_console_sem();
+	for (c = console_drivers; c != NULL; c = c->next) {
+		if (!c->device)
+			continue;
+		driver = c->device(c, index);
+		if (driver)
+			break;
+	}
+	release_console_sem();
+	return driver;
+}
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/include/linux/console.h linux/include/linux/console.h
--- orig/include/linux/console.h	Mon May 24 11:26:21 2004
+++ linux/include/linux/console.h	Mon Jun 14 10:55:28 2004
@@ -104,6 +104,7 @@ extern void acquire_console_sem(void);
 extern void release_console_sem(void);
 extern void console_conditional_schedule(void);
 extern void console_unblank(void);
+extern struct tty_driver *console_device(int *);
 extern int is_console_locked(void);
 
 /* Some debug stub to catch some of the obvious races in the VT code */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
