Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262002AbREREwp>; Fri, 18 May 2001 00:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262179AbREREwf>; Fri, 18 May 2001 00:52:35 -0400
Received: from kffopc5.szfki.kfki.hu ([148.6.138.105]:13577 "EHLO
	bird.szfki.kfki.hu") by vger.kernel.org with ESMTP
	id <S262002AbREREwS>; Fri, 18 May 2001 00:52:18 -0400
Message-Id: <200105180452.GAA15176@bird.szfki.kfki.hu>
To: linux-kernel@vger.kernel.org
cc: karpati@kffopc5.szfki.kfki.hu
Subject: serial driver patch
Date: Fri, 18 May 2001 06:52:16 +0200
From: Attila Karpati <karpati@optics.szfki.kfki.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a 16450 serial chip at home and it bothered me that if I play music and
compile some programs there are packet errors reported by
/sbin/ifconfig. Irqtune did help a bit but not much, so created a small patch
to add an option to use the SA_INTERRUPT flag in serial.c. Since then there
are no packet errors. You can find the patch at the end of my mail. The patch
is against 2.4.4. Maybe other people who use irqtune find it useful.

Bye,
 Attila

diff -urbBd linux.orig/drivers/char/Config.in linux/drivers/char/Config.in
--- linux.orig/drivers/char/Config.in	Wed Mar  7 04:44:34 2001
+++ linux/drivers/char/Config.in	Fri May 18 06:31:36 2001
@@ -20,6 +20,7 @@
 if [ "$CONFIG_SERIAL_EXTENDED" = "y" ]; then
    bool '  Support more than 4 serial ports' CONFIG_SERIAL_MANY_PORTS
    bool '  Support for sharing serial interrupts' CONFIG_SERIAL_SHARE_IRQ
+   bool '  Disable other interrupts and disable sharing' CONFIG_SERIAL_DISABLE_INTERRUPTS_DONT_SHARE
    bool '  Autodetect IRQ on standard ports (unsafe)' CONFIG_SERIAL_DETECT_IRQ
    bool '  Support special multiport boards' CONFIG_SERIAL_MULTIPORT
    bool '  Support the Bell Technologies HUB6 card' CONFIG_HUB6
diff -urbBd linux.orig/drivers/char/serial.c linux/drivers/char/serial.c
--- linux.orig/drivers/char/serial.c	Sat Apr 14 05:26:07 2001
+++ linux/drivers/char/serial.c	Fri May 18 06:29:10 2001
@@ -1336,8 +1336,13 @@
 		} else 
 			handler = rs_interrupt_single;
 
-		retval = request_irq(state->irq, handler, SA_SHIRQ,
-				     "serial", &IRQ_ports[state->irq]);
+		retval = request_irq(state->irq, handler, 
+#ifdef CONFIG_SERIAL_DISABLE_INTERRUPTS_DONT_SHARE
+				     SA_INTERRUPT
+#else
+				     SA_SHIRQ
+#endif
+				     , "serial", &IRQ_ports[state->irq]);
 		if (retval) {
 			if (capable(CAP_SYS_ADMIN)) {
 				if (info->tty)
@@ -1489,7 +1494,12 @@
 		if (IRQ_ports[state->irq]) {
 			free_irq(state->irq, &IRQ_ports[state->irq]);
 			retval = request_irq(state->irq, rs_interrupt_single,
-					     SA_SHIRQ, "serial",
+#ifdef CONFIG_SERIAL_DISABLE_INTERRUPTS_DONT_SHARE
+					     SA_INTERRUPT
+#else
+					     SA_SHIRQ
+#endif
+					     , "serial",
 					     &IRQ_ports[state->irq]);
 			
 			if (retval)
@@ -2503,8 +2513,13 @@
 		else
 			handler = rs_interrupt;
 
-		retval = request_irq(state->irq, handler, SA_SHIRQ,
-				     "serial", &IRQ_ports[state->irq]);
+		retval = request_irq(state->irq, handler, 
+#ifdef CONFIG_SERIAL_DISABLE_INTERRUPTS_DONT_SHARE
+				     SA_INTERRUPT
+#else
+				     SA_SHIRQ
+#endif
+				     , "serial", &IRQ_ports[state->irq]);
 		if (retval) {
 			printk("Couldn't reallocate serial interrupt "
 			       "driver!!\n");
