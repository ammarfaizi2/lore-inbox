Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUFNOPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUFNOPB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUFNONo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:13:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34567 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263088AbUFNONM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:13:12 -0400
Date: Mon, 14 Jun 2004 15:13:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] Provide console_suspend() and console_resume()
Message-ID: <20040614151307.I14403@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040614151217.H14403@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040614151217.H14403@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Mon, Jun 14, 2004 at 03:12:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add console_suspend() and console_resume() methods so the serial drivers
can disable console output before suspending a port, and re-enable output
afterwards.

We also add locking to ensure that we synchronise with any in-progress
printk.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/drivers/serial/serial_core.c linux/drivers/serial/serial_core.c
--- orig/drivers/serial/serial_core.c	Sun May 30 10:32:45 2004
+++ linux/drivers/serial/serial_core.c	Mon Jun 14 10:59:49 2004
@@ -1923,7 +1923,7 @@ int uart_suspend_port(struct uart_driver
 	 * Disable the console device before suspending.
 	 */
 	if (uart_console(port))
-		port->cons->flags &= ~CON_ENABLED;
+		console_suspend(port->cons);
 
 	uart_change_pm(state, 3);
 
@@ -1945,7 +1945,7 @@ int uart_resume_port(struct uart_driver 
 	 */
 	if (uart_console(port)) {
 		uart_change_speed(state, NULL);
-		port->cons->flags |= CON_ENABLED;
+		console_resume(port->cons);
 	}
 
 	if (state->info && state->info->flags & UIF_INITIALIZED) {
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/kernel/printk.c linux/kernel/printk.c
--- orig/kernel/printk.c	Mon Jun 14 11:01:49 2004
+++ linux/kernel/printk.c	Mon Jun 14 11:01:37 2004
@@ -700,6 +700,22 @@ struct tty_driver *console_device(int *i
 	return driver;
 }
 
+void console_suspend(struct console *console)
+{
+	acquire_console_sem();
+	console->flags &= ~CON_ENABLED;
+	release_console_sem();
+}
+EXPORT_SYMBOL(console_suspend);
+
+void console_resume(struct console *console)
+{
+	acquire_console_sem();
+	console->flags |= CON_ENABLED;
+	release_console_sem();
+}
+EXPORT_SYMBOL(console_resume);
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/include/linux/console.h linux/include/linux/console.h
--- orig/include/linux/console.h	Mon Jun 14 11:01:49 2004
+++ linux/include/linux/console.h	Mon Jun 14 11:00:21 2004
@@ -105,6 +105,8 @@ extern void release_console_sem(void);
 extern void console_conditional_schedule(void);
 extern void console_unblank(void);
 extern struct tty_driver *console_device(int *);
+extern void console_suspend(struct console *);
+extern void console_resume(struct console *);
 extern int is_console_locked(void);
 
 /* Some debug stub to catch some of the obvious races in the VT code */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
