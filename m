Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271847AbRIMQra>; Thu, 13 Sep 2001 12:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271856AbRIMQrN>; Thu, 13 Sep 2001 12:47:13 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:17925 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S271857AbRIMQqw>; Thu, 13 Sep 2001 12:46:52 -0400
Date: Thu, 13 Sep 2001 18:41:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com
Subject: [x86-64 patch 8/11] Joystick timing for x86-64
Message-ID: <20010913184142.A2621@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch adds support for timing on x86-64 in the joystick drivers. It
also changes the compile-time configuration of TSC vs PIT timing to
runtime - PIT is too slow to notice the extra check and TSC processors
are fast enough to make it non-noticeable (and TSC precision is much
much more than we need anyway in the joystick drivers).

diff -urN linux-x86_64/drivers/char/joystick/analog.c linux-64-latest/drivers/char/joystick/analog.c
--- linux-x86_64/drivers/char/joystick/analog.c	Thu Sep 13 15:17:33 2001
+++ linux-64-latest/drivers/char/joystick/analog.c	Thu Sep 13 16:55:10 2001
@@ -39,6 +39,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/gameport.h>
+#include <asm/timex.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("Analog joystick and gamepad driver for Linux");
@@ -135,27 +136,25 @@
  */
 
 #ifdef __i386__
-#ifdef CONFIG_X86_TSC
-#define GET_TIME(x)	__asm__ __volatile__ ( "rdtsc" : "=a" (x) : : "dx" )
+#define TSC_PRESENT	(test_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capability))
+#define GET_TIME(x)	do { if (TSC_PRESENT) rdtscl(x); else outb(0, 0x43); x = inb(0x40); x |= inb(0x40) << 8; } while (0)
+#define DELTA(x,y)	(TSC_PRESENT?((y)-(x)):((x)-(y)+((x)<(y)?1193180L/HZ:0)))
+#define TIME_NAME	(TSC_PRESENT?"TSC":"PIT")
+#elif __x86_64__
+#define GET_TIME(x)	rdtscl(x)
 #define DELTA(x,y)	((y)-(x))
-#define TIME_NAME "TSC"
-#else
-#define GET_TIME(x)	do { outb(0, 0x43); x = inb(0x40); x |= inb(0x40) << 8; } while (0)
-#define DELTA(x,y)	((x)-(y)+((x)<(y)?1193180L/HZ:0))
-#define TIME_NAME "PIT"
-#endif
+#define TIME_NAME	"TSC"
 #elif __alpha__
-#define GET_TIME(x)	__asm__ __volatile__ ( "rpcc %0" : "=r" (x) )
+#define GET_TIME(x)	get_cycles(x)
 #define DELTA(x,y)	((y)-(x))
-#define TIME_NAME "PCC"
-#endif
-
-#ifndef GET_TIME
+#define TIME_NAME	"PCC"
+#else
 #define FAKE_TIME
 static unsigned long analog_faketime = 0;
 #define GET_TIME(x)     do { x = analog_faketime++; } while(0)
 #define DELTA(x,y)	((y)-(x))
-#define TIME_NAME "Unreliable"
+#define TIME_NAME	"Unreliable"
+#warning Precise timer not defined for this architecture.
 #endif
 
 /*
@@ -497,7 +496,7 @@
 	if (port->cooked)
 		printk(" [ADC port]\n");
 	else
-		printk(" ["TIME_NAME" timer, %d %sHz clock, %d ns res]\n",
+		printk(" [%s timer, %d %sHz clock, %d ns res]\n", TIME_NAME,
 		port->speed > 10000 ? (port->speed + 800) / 1000 : port->speed,
 		port->speed > 10000 ? "M" : "k", (port->loop * 1000000) / port->speed);
 }
diff -urN linux-x86_64/drivers/char/joystick/gameport.c linux-64-latest/drivers/char/joystick/gameport.c
--- linux-x86_64/drivers/char/joystick/gameport.c	Thu Sep 13 15:17:33 2001
+++ linux-64-latest/drivers/char/joystick/gameport.c	Thu Sep 13 15:54:50 2001
@@ -61,7 +61,7 @@
 
 static int gameport_measure_speed(struct gameport *gameport)
 {
-#ifdef __i386__
+#if defined(__i386__) || defined(__x86_64__)
 
 #define GET_TIME(x)     do { outb(0, 0x43); x = inb(0x40); x |= inb(0x40) << 8; } while (0)
 #define DELTA(x,y)      ((y)-(x)+((y)<(x)?1193180L/HZ:0))

-- 
Vojtech Pavlik
SuSE Labs
