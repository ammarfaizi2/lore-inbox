Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVGETVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVGETVb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 15:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVGETVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 15:21:30 -0400
Received: from mail.hypersurf.com ([209.237.0.6]:45316 "EHLO
	mail.hypersurf.com") by vger.kernel.org with ESMTP id S261378AbVGETS4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 15:18:56 -0400
Message-ID: <42CADC8A.7030205@hypersurf.com>
Date: Tue, 05 Jul 2005 12:16:27 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i486; en-US; rv:1.7b) Gecko/20040809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 386/486 clock frequency
Content-Type: multipart/mixed;
 boundary="------------040006000109050201080006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040006000109050201080006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

	The following patch provides a resonable estimate of the clock 
frequency for the 386 & 486. It is based on the bogomips (aka 
loops_per_jiffy) and an estimate of the cycles per loop in the delay 
routine. Some values I have seen:

	ALR Business VEISA (with 386@33 MHz cpu card):	32.704
	above system with 486DX2@66 cpu card and a
		Kingston TurboChip (AMD 5x86):		132.710
	Nec VersaM/100 (kernel 2.2.12):			99.5328

	Patch is against 2.4.31.

--------------040006000109050201080006
Content-Type: text/plain;
 name="386clk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="386clk.patch"

diff -U3 -r linux-2.4.31.orig/Documentation/Configure.help linux-2.4.31/Documentation/Configure.help
--- linux-2.4.31.orig/Documentation/Configure.help	Mon Jun 27 16:39:09 2005
+++ linux-2.4.31/Documentation/Configure.help	Thu Jun 30 15:50:59 2005
@@ -20640,6 +20640,21 @@
   For pentium machines the mce support defaults to off as the mainboard
   support is not always present. You must activate it as a boot option.
 
+386/486 Clock Speed Guess
+CONFIG_386_CLK_GUESS
+  This will include code to guesstimate the 386 clock speed from the
+  computed loops per jiffy value and knowledge of the number of cycles
+  that each loop in the delay routine takes
+
+Override Default Cycles Per Loop
+CONFIG_386_CLK_CPL
+  This allows you to override the default cycles per loop value used to
+  guess the clock speed. The defaults are 10 for the 386 and 4 for the 486.
+  A non-zero value overrides the defaults. This can also be used to compensate
+  for known wait states. Especially useful if your 386 cache card blows up.
+  The actual computation is:
+    hz = loops_per_jiffy * HZ * cycles_per_loop
+
 Toshiba Laptop support
 CONFIG_TOSHIBA
   This adds a driver to safely access the System Management Mode of
diff -U3 -r linux-2.4.31.orig/arch/i386/config.in linux-2.4.31/arch/i386/config.in
--- linux-2.4.31.orig/arch/i386/config.in	Mon Jun 27 16:30:54 2005
+++ linux-2.4.31/arch/i386/config.in	Sun Jul  3 10:25:26 2005
@@ -192,6 +192,13 @@
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
 
+if [ "$CONFIG_M386" = "y" -o "$CONFIG_M486" = "y" -o "$CONFIG_M586" = "y"]; then
+	bool 'Enable 386 Clock Guess' CONFIG_386_CLK_GUESS
+	if [ "$CONFIG_386_CLK_GUESS" = "y" ]; then
+		int '  Override default cycles per loop' CONFIG_386_CLK_CPL 0
+	fi
+fi
+
 bool 'Machine Check Exception' CONFIG_X86_MCE
 
 tristate 'Toshiba Laptop support' CONFIG_TOSHIBA
diff -U3 -r linux-2.4.31.orig/arch/i386/kernel/setup.c linux-2.4.31/arch/i386/kernel/setup.c
--- linux-2.4.31.orig/arch/i386/kernel/setup.c	Mon Jun 27 16:39:13 2005
+++ linux-2.4.31/arch/i386/kernel/setup.c	Tue Jun 28 16:35:16 2005
@@ -3112,7 +3112,7 @@
 	else
 		seq_printf(m, "stepping\t: unknown\n");
 
-	if ( test_bit(X86_FEATURE_TSC, &c->x86_capability) ) {
+	if ( cpu_khz ) {
 		seq_printf(m, "cpu MHz\t\t: %lu.%03lu\n",
 			cpu_khz / 1000, (cpu_khz % 1000));
 	}
diff -U3 -r linux-2.4.31.orig/arch/i386/kernel/time.c linux-2.4.31/arch/i386/kernel/time.c
--- linux-2.4.31.orig/arch/i386/kernel/time.c	Tue Aug  3 11:39:19 2004
+++ linux-2.4.31/arch/i386/kernel/time.c	Sun Jul  3 10:27:51 2005
@@ -841,6 +841,8 @@
 	xtime.tv_sec = get_cmos_time();
 	xtime.tv_usec = 0;
 
+	cpu_khz = 0;
+
 /*
  * If we have APM enabled or the CPU clock speed is variable
  * (CPU stops clock on HLT or slows clock to save power)
@@ -924,3 +926,37 @@
 	setup_irq(0, &irq0);
 #endif
 }
+
+#ifdef CONFIG_386_CLK_GUESS
+/*
+ * Need this to run AFTER the delay loop has been calibrated
+ */
+void __init init_386_clock(void)
+{
+	/*
+	 * If already computed just bail
+	 */
+	if(cpu_khz) return;
+
+	if(boot_cpu_data.x86==3 || boot_cpu_data.x86==4) {
+		/*
+		 * Each loop in __delay() takes 10 cycles on a 386 and 4?
+		 * on a 486. Allow these to be overriden during config for
+		 * mutant 386 and 486 clones.
+		 */
+#if CONFIG_386_CLK_CPL != 0
+		cpu_khz=CONFIG_386_CLK_CPL;
+#else
+		cpu_khz=(boot_cpu_data.x86==3)?10:4;
+#endif
+
+
+		cpu_khz=boot_cpu_data.loops_per_jiffy*HZ*cpu_khz;
+		cpu_khz=(cpu_khz+500)/1000;
+		printk("Guesstimated %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
+	}
+}
+
+__initcall(init_386_clock);
+#endif
+
diff -U3 -r linux-2.4.31.orig/arch/i386/lib/delay.c linux-2.4.31/arch/i386/lib/delay.c
--- linux-2.4.31.orig/arch/i386/lib/delay.c	Sun Aug 10 21:33:11 2003
+++ linux-2.4.31/arch/i386/lib/delay.c	Fri Jul  1 10:23:58 2005
@@ -47,6 +47,11 @@
 static void __loop_delay(unsigned long loops)
 {
 	int d0;
+
+	/*
+	 * If this is changed the cycles for loop estimates will need to be
+	 * looked at for the 386/486 clock estimation code in kernel/time.c
+	 */
 	__asm__ __volatile__(
 		"\tjmp 1f\n"
 		".align 16\n"

--------------040006000109050201080006--
