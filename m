Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbUDGHRq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 03:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264130AbUDGHRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 03:17:45 -0400
Received: from gizmo11bw.bigpond.com ([144.140.70.21]:20136 "HELO
	gizmo11bw.bigpond.com") by vger.kernel.org with SMTP
	id S264131AbUDGHRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 03:17:01 -0400
Message-ID: <4073AAE5.2010005@techdrive.com.au>
Date: Wed, 07 Apr 2004 17:16:53 +1000
From: Richard James <richard@techdrive.com.au>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Updated Ross Dickson C1Halt patch for 2.6.5
Content-Type: multipart/mixed;
 boundary="------------030402000000030402060306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030402000000030402060306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch works against kernel 2.6.5 as it did for 2.6.3. If you try 
and turn APIC off in settings then the kernel will crash at compile 
because of his C1halt function. I'm not sure how to fix that. I forgot 
to record the compile error as well. To use it you need to send 
idle=C1patch to the kernel at boot and their needs to be a way so that 
you can instead select this from the config menu and toggle it on and 
off with the APIC controls.

Richard James :)

--------------030402000000030402060306
Content-Type: text/plain;
 name="nforce2-idleC1halt-rd-2.6.5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nforce2-idleC1halt-rd-2.6.5.patch"

--- process.c.origional	2004-04-06 19:14:01.000000000 +1000
+++ process.c	2004-04-06 19:13:44.000000000 +1000
@@ -50,6 +50,7 @@
 #include <asm/math_emu.h>
 #endif
 
+#include <asm/apic.h>
 #include <linux/irq.h>
 #include <linux/err.h>
 
@@ -88,7 +89,7 @@ EXPORT_SYMBOL(enable_hlt);
  * We use this if we don't have any better
  * idle routine..
  */
-void default_idle(void)
+static void default_idle(void)
 {
 	if (!hlt_counter && current_cpu_data.hlt_works_ok) {
 		local_irq_disable();
@@ -99,6 +100,28 @@ void default_idle(void)
 	}
 }
 
+ /*
+ * We use this to avoid nforce2 lockups
+ * Reduces frequency of C1 disconnects
+ */
+static void c1halt_idle(void)
+{
+	if (!hlt_counter && current_cpu_data.hlt_works_ok) {
+		local_irq_disable();
+		/* only hlt disconnect if more than 1.6% of apic interval remains */
+		if( (!need_resched()) &&
+			(apic_read(APIC_TMCCT) > (apic_read(APIC_TMICT)>>6))) {
+			ndelay(600); /* helps nforce2 but adds 0.6us hard int latency */
+			safe_halt();  /* nothing better to do until we wake up */
+		}
+		else
+			local_irq_enable();
+	}
+}
+
+
+
+
 /*
  * On SMP it's slightly faster (but much more power-consuming!)
  * to poll the ->work.need_resched flag instead of waiting for the
@@ -137,16 +160,14 @@ static void poll_idle (void)
  * low exit latency (ie sit in a loop waiting for
  * somebody to say that they'd like to reschedule)
  */
+static void (*idle)(void);
 void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
-			void (*idle)(void) = pm_idle;
-
 			if (!idle)
-				idle = default_idle;
-
+				idle = pm_idle ? pm_idle : default_idle;
 			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 			idle();
 		}
@@ -201,10 +222,13 @@ static int __init idle_setup (char *str)
 {
 	if (!strncmp(str, "poll", 4)) {
 		printk("using polling idle threads.\n");
-		pm_idle = poll_idle;
+		idle = poll_idle;
 	} else if (!strncmp(str, "halt", 4)) {
 		printk("using halt in idle threads.\n");
-		pm_idle = default_idle;
+	  idle = default_idle;
+	} else if (!strncmp(str, "C1halt", 6)) {
+		printk("using C1 halt disconnect friendly idle threads.\n");
+		idle = c1halt_idle;
 	}
 
 	return 1;

--------------030402000000030402060306--

