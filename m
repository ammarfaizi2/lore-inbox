Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268378AbUI2NHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268378AbUI2NHF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUI2NHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:07:04 -0400
Received: from zero.aec.at ([193.170.194.10]:33293 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268378AbUI2NFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:05:32 -0400
To: akpm@osdl.org, linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: [PATCH] Readd panic blinking in 2.6
From: Andi Kleen <ak@muc.de>
Date: Wed, 29 Sep 2004 15:05:09 +0200
Message-ID: <m3llet4456.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Later 2.4 had a feature that would make the keyboard LEDs
blink when a panic occurred.  This patch adds it to 2.6 too.

This is useful when your machine is in X and locks up.
With the blinking keyboard lights you at least know
that a panic happened, not that it randomly locked up.

I cleaned it up a bit and ported it to the new keyboard
driver. Unlike 2.4 it also works now with panic=...
and doesn't rely on the timer interrupt ticking anymore. 
It's also clear, now it uses a generic callback, no ifdefs.
Should also work now with modular keyboard driver
and the panic blink frequency can be configured in sysfs
(this is useful for a few KVMs who don't like this). Setting
it to 0 turns it off.

Work left to do: find some way to use HLT in the busy loops.
Currently machines eat a lot of power in panic and sometimes
they hang in this state for days until somebody can reset them.
Unfortunately this will require relying on the timer interrupts
again.

P.S. Before anyone asks: no, i'm not interested in morse code
output.

diff -u linux-2.6.9rc2-bk11/drivers/input/serio/i8042.c-PANIC linux-2.6.9rc2-bk11/drivers/input/serio/i8042.c
--- linux-2.6.9rc2-bk11/drivers/input/serio/i8042.c-PANIC	2004-09-25 16:03:19.000000000 +0200
+++ linux-2.6.9rc2-bk11/drivers/input/serio/i8042.c	2004-09-27 01:22:23.000000000 +0200
@@ -887,6 +887,40 @@
         0
 };
 
+static int blink_frequency = 500;
+module_param_named(panicblink, blink_frequency, int, 0600);
+
+#define DELAY mdelay(1), delay++
+
+/* Tell the user who may be running in X and not see the console that we have 
+   panic'ed. This is to distingush panics from "real" lockups.  */
+static long i8042_panic_blink(long count)
+{ 
+	long delay = 0;
+	static long last_blink;
+	static char led;
+	/* Roughly 1/2s frequency. KDB uses about 1s. Make sure it is 
+	   different. */
+	if (!blink_frequency) 
+		return 0;
+	if (count - last_blink < blink_frequency)
+		return 0;
+	led ^= 0x01 | 0x04;
+	while (i8042_read_status() & I8042_STR_IBF)
+		DELAY;
+	i8042_write_data(0xed); /* set leds */
+	DELAY;
+	while (i8042_read_status() & I8042_STR_IBF)
+		DELAY;
+	DELAY;
+	i8042_write_data(led);
+	DELAY;
+	last_blink = count;
+	return delay;
+}  
+
+#undef DELAY
+
 /*
  * Suspend/resume handlers for the new PM scheme (driver model)
  */
@@ -1047,6 +1081,8 @@
 
 	register_reboot_notifier(&i8042_notifier);
 
+	panic_blink = i8042_panic_blink;
+
 	return 0;
 }
 
@@ -1077,6 +1113,8 @@
 	driver_unregister(&i8042_driver);
 
 	i8042_platform_exit();
+
+	panic_blink = NULL;
 }
 
 module_init(i8042_init);
diff -u linux-2.6.9rc2-bk11/include/linux/kernel.h-PANIC linux-2.6.9rc2-bk11/include/linux/kernel.h
--- linux-2.6.9rc2-bk11/include/linux/kernel.h-PANIC	2004-09-25 16:03:29.000000000 +0200
+++ linux-2.6.9rc2-bk11/include/linux/kernel.h	2004-09-27 00:54:20.000000000 +0200
@@ -66,6 +66,7 @@
 	})
 
 extern struct notifier_block *panic_notifier_list;
+extern long (*panic_blink)(long time);
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
 asmlinkage NORET_TYPE void do_exit(long error_code)
diff -u linux-2.6.9rc2-bk11/kernel/panic.c-PANIC linux-2.6.9rc2-bk11/kernel/panic.c
--- linux-2.6.9rc2-bk11/kernel/panic.c-PANIC	2004-09-19 12:21:52.000000000 +0200
+++ linux-2.6.9rc2-bk11/kernel/panic.c	2004-09-27 01:18:15.000000000 +0200
@@ -37,6 +37,15 @@
 }
 __setup("panic=", panic_setup);
 
+static long no_blink(long time)
+{
+	return 0;
+}
+
+/* Returns how long it waited in ms */
+long (*panic_blink)(long time) = no_blink;
+EXPORT_SYMBOL(panic_blink);
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -49,6 +58,7 @@
  
 NORET_TYPE void panic(const char * fmt, ...)
 {
+	long i;
 	static char buf[1024];
 	va_list args;
 #if defined(CONFIG_ARCH_S390)
@@ -70,15 +80,16 @@
 
 	if (panic_timeout > 0)
 	{
-		int i;
 		/*
 	 	 * Delay timeout seconds before rebooting the machine. 
 		 * We can't use the "normal" timers since we just panicked..
 	 	 */
 		printk(KERN_EMERG "Rebooting in %d seconds..",panic_timeout);
-		for (i = 0; i < panic_timeout; i++) {
+		for (i = 0; i < panic_timeout*1000; ) {
 			touch_nmi_watchdog();
-			mdelay(1000);
+			i += panic_blink(i);
+			mdelay(1);
+			i++;
 		}
 		/*
 		 *	Should we run the reboot notifier. For the moment Im
@@ -99,8 +110,11 @@
         disabled_wait(caller);
 #endif
 	local_irq_enable();
-	for (;;)
-		;
+	for (i = 0;;) { 
+		i += panic_blink(i);
+		mdelay(1); 
+		i++; 
+	}
 }
 
 EXPORT_SYMBOL(panic);




