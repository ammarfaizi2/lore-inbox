Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbUJaBhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbUJaBhW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 21:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbUJaBhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 21:37:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:52178 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261463AbUJaBgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 21:36:50 -0400
Date: Sun, 31 Oct 2004 02:36:49 +0100
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Add panic blinking to 2.6
Message-ID: <20041031013649.GF19396@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch readds the panic blinking that was in 2.4
to 2.6. This is useful to see when you're in X that the 
machine has paniced 

It addresses previously criticism.
It should work now when the keyboard interrupt is off. 
It doesn't fully emulate the handler, but has a timeout 
for this case.

Signed-off-by: Andi Kleen <ak@suse.de>

diff -u linux-2.6.9-work/drivers/input/serio/i8042.c-PANIC linux-2.6.9-work/drivers/input/serio/i8042.c
--- linux-2.6.9-work/drivers/input/serio/i8042.c-PANIC	2004-10-19 01:55:13.000000000 +0200
+++ linux-2.6.9-work/drivers/input/serio/i8042.c	2004-10-20 05:20:24.000000000 +0200
@@ -887,6 +887,41 @@
         0
 };
 
+static int blink_frequency = 500;
+module_param_named(panicblink, blink_frequency, int, 0600);
+
+/* Catch the case when the kbd interrupt is off */
+#define DELAY do { mdelay(1); if (++delay > 10) return delay; } while(0) 
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
@@ -1047,6 +1082,8 @@
 
 	register_reboot_notifier(&i8042_notifier);
 
+	panic_blink = i8042_panic_blink;
+
 	return 0;
 }
 
@@ -1077,6 +1114,8 @@
 	driver_unregister(&i8042_driver);
 
 	i8042_platform_exit();
+
+	panic_blink = NULL;
 }
 
 module_init(i8042_init);
diff -u linux-2.6.9-work/include/linux/kernel.h-PANIC linux-2.6.9-work/include/linux/kernel.h
--- linux-2.6.9-work/include/linux/kernel.h-PANIC	2004-10-19 01:55:35.000000000 +0200
+++ linux-2.6.9-work/include/linux/kernel.h	2004-10-20 05:17:55.000000000 +0200
@@ -66,6 +66,7 @@
 	})
 
 extern struct notifier_block *panic_notifier_list;
+extern long (*panic_blink)(long time);
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
 asmlinkage NORET_TYPE void do_exit(long error_code)
diff -u linux-2.6.9-work/kernel/panic.c-PANIC linux-2.6.9-work/kernel/panic.c
--- linux-2.6.9-work/kernel/panic.c-PANIC	2004-10-19 01:55:36.000000000 +0200
+++ linux-2.6.9-work/kernel/panic.c	2004-10-20 05:17:55.000000000 +0200
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
