Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbUFNOSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUFNOSm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUFNOSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:18:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35079 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263095AbUFNONo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:13:44 -0400
Date: Mon, 14 Jun 2004 15:13:41 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 3/3] Convert console list to list_head
Message-ID: <20040614151341.J14403@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040614151217.H14403@flint.arm.linux.org.uk> <20040614151307.I14403@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040614151307.I14403@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Mon, Jun 14, 2004 at 03:13:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert console drivers to use list_head rather than its own private
list implementation.  Unfortunately, several other places reference
"console_drivers" directly, all of them without locking.  PPC/PPC64
even seems to export the list for no apparant reason.

arch/ia64/hp/sim/simserial.c:extern struct console *console_drivers; /* from kernel/printk.c */
arch/ia64/hp/sim/simserial.c:   console = console_drivers;

  This is interesting - it appears to search the console driver list
  for the first console, hold a reference to it, and call its write
  method.  If a console were to be unregistered via unregister_console()
  this would potentially oops.

arch/parisc/kernel/pdc_cons.c:  while ((console = console_drivers) != NULL)
arch/parisc/kernel/pdc_cons.c:          unregister_console(console_drivers);
arch/parisc/kernel/traps.c:     if (!console_drivers)
arch/parisc/kernel/traps.c:     if (!console_drivers)

  PARISC seems to like to unregister all consoles, and then re-
  registers its own console driver.  IOW, it assumes it can safely
  override the state of the console subsystem independent of whatever
  drivers may be registered.

arch/ppc/kernel/ppc_ksyms.c:EXPORT_SYMBOL(console_drivers);
arch/ppc64/kernel/ppc_ksyms.c:EXPORT_SYMBOL(console_drivers);

  Random exports of this kernel symbol...

arch/sparc64/kernel/setup.c:    cons = console_drivers;
arch/sparc64/kernel/setup.c:            cons = console_drivers;

  Sparc64 appears to want to temporarily override the console
  subsystem for debugging purposes.  Maybe there's a better way?

Since "console_drivers" vanishes as a result of this, all the above
break, so this needs further work before it can be merged into 2.6.
Can people consider the above and come up with both a cleaner and
saner solution?

Signed-Off-By: David Woodhouse <dwmw2@infradead.org>
Signed-Off-By: Russell King <rmk@arm.linux.org.uk>

--- linux/kernel/printk.c.console	Mon Jun 14 11:01:37 2004
+++ linux/kernel/printk.c	Mon Jun 14 11:06:07 2004
@@ -61,7 +61,8 @@
  * driver system.
  */
 static DECLARE_MUTEX(console_sem);
-struct console *console_drivers;
+static LIST_HEAD(console_driver_list);
+
 /*
  * This is used for debugging the mess that is the VT code by
  * keeping track if we have the console semaphore held. It's
@@ -383,7 +384,7 @@
 {
 	struct console *con;
 
-	for (con = console_drivers; con; con = con->next) {
+	list_for_each_entry(con, &console_driver_list, list) {
 		if ((con->flags & CON_ENABLED) && con->write)
 			con->write(con, &LOG_BUF(start), end - start);
 	}
@@ -396,7 +397,7 @@
 				unsigned long end, int msg_log_level)
 {
 	if (msg_log_level < console_loglevel &&
-			console_drivers && start != end) {
+	    !list_empty(&console_driver_list) && start != end) {
 		if ((start & LOG_BUF_MASK) > (end & LOG_BUF_MASK)) {
 			/* wrapped write */
 			__call_console_drivers(start & LOG_BUF_MASK,
@@ -580,7 +581,7 @@
  * acquire_console_sem - lock the console system for exclusive use.
  *
  * Acquires a semaphore which guarantees that the caller has
- * exclusive access to the console system and the console_drivers list.
+ * exclusive access to the console system and the console_driver_list.
  *
  * Can sleep, returns nothing.
  */
@@ -676,7 +677,7 @@
 		return;
 	console_locked = 1;
 	console_may_schedule = 0;
-	for (c = console_drivers; c != NULL; c = c->next)
+	list_for_each_entry(c, &console_driver_list, list)
 		if ((c->flags & CON_ENABLED) && c->unblank)
 			c->unblank();
 	release_console_sem();
@@ -689,7 +690,7 @@
 	struct tty_driver *driver = NULL;
 
 	acquire_console_sem();
-	for (c = console_drivers; c != NULL; c = c->next) {
+	list_for_each_entry(c, &console_driver_list, list) {
 		if (!c->device)
 			continue;
 		driver = c->device(c, index);
@@ -772,13 +773,11 @@
 	 *	preferred driver at the head of the list.
 	 */
 	acquire_console_sem();
-	if ((console->flags & CON_CONSDEV) || console_drivers == NULL) {
-		console->next = console_drivers;
-		console_drivers = console;
-	} else {
-		console->next = console_drivers->next;
-		console_drivers->next = console;
-	}
+	if ((console->flags & CON_CONSDEV) || list_empty(&console_driver_list)) 
+		list_add(&console->list, &console_driver_list);
+	else
+		list_add(&console->list, console_driver_list.next);
+
 	if (console->flags & CON_PRINTBUFFER) {
 		/*
 		 * release_console_sem() will print out the buffered messages
@@ -794,31 +793,17 @@
 
 int unregister_console(struct console * console)
 {
-        struct console *a,*b;
 	int res = 1;
 
 	acquire_console_sem();
-	if (console_drivers == console) {
-		console_drivers=console->next;
-		res = 0;
-	} else {
-		for (a=console_drivers->next, b=console_drivers ;
-		     a; b=a, a=b->next) {
-			if (a == console) {
-				b->next = a->next;
-				res = 0;
-				break;
-			}  
-		}
-	}
+	list_del(&console->list);
 	
 	/* If last console is removed, we re-enable picking the first
 	 * one that gets registered. Without that, pmac early boot console
 	 * would prevent fbcon from taking over.
 	 */
-	if (console_drivers == NULL)
+	if (list_empty(&console_driver_list))
 		preferred_console = -1;
-		
 
 	release_console_sem();
 	return res;
--- linux/include/linux/console.h.console	Mon Jun 14 11:00:21 2004
+++ linux/include/linux/console.h	Mon Jun 14 11:05:37 2004
@@ -16,6 +16,7 @@
 
 #include <linux/types.h>
 #include <linux/spinlock.h>
+#include <linux/list.h>
 
 struct vc_data;
 struct console_font_op;
@@ -93,13 +94,12 @@
 	short	index;
 	int	cflag;
 	void	*data;
-	struct	 console *next;
+	struct list_head list;
 };
 
 extern int add_preferred_console(char *name, int idx, char *options);
 extern void register_console(struct console *);
 extern int unregister_console(struct console *);
-extern struct console *console_drivers;
 extern void acquire_console_sem(void);
 extern void release_console_sem(void);
 extern void console_conditional_schedule(void);

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
