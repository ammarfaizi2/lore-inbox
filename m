Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267754AbTAaKeU>; Fri, 31 Jan 2003 05:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267755AbTAaKeU>; Fri, 31 Jan 2003 05:34:20 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:38546 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267754AbTAaKeQ>; Fri, 31 Jan 2003 05:34:16 -0500
Date: Fri, 31 Jan 2003 11:43:26 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@codemonkey.org.uk>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Rodland <arodland@noln.com>, john@grabjohn.com
Subject: Re: [PATCH] 2.5.59 morse code panics
Message-ID: <20030131104326.GF12286@louise.pinerecords.com>
References: <20030130150709.GC701@louise.pinerecords.com> <20030130173642.GB25824@codemonkey.org.uk> <1043952334.31674.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043952334.31674.20.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@lxorguk.ukuu.org.uk]
> 
> On Thu, 2003-01-30 at 17:36, Dave Jones wrote:
> 
> > As this patch further builds upon the previous one,
> > It'd take a complete change of mind on his part to take
> > this as it is.
> 
> If its attached to atkbd then its not a PCism and its now
> nicely modularised in the atkbd driver. Providing we have
> a clear split between the core "morse sender" and the
> platform specific morse output device (do we want 
> morse_ops 8)) it should be clean and you can write morse
> drivers for pc speaker, for non pc keyboard and even for
> soundblaster 8)

Of course we want morseops. :)
v2 follows.

-- 
Tomas Szepe <szepe@pinerecords.com>


 drivers/input/keyboard/atkbd.c |   22 +++++-
 include/linux/morseops.h       |   26 +++++++
 init/Kconfig                   |   14 +++-
 kernel/Makefile                |    1 
 kernel/morse.c                 |  137 +++++++++++++++++++++++++++++++++++++++++
 kernel/panic.c                 |    4 -
 6 files changed, 200 insertions(+), 4 deletions(-)

diff -urN b/drivers/input/keyboard/atkbd.c a/drivers/input/keyboard/atkbd.c
--- b/drivers/input/keyboard/atkbd.c	2002-12-08 20:06:16.000000000 +0100
+++ a/drivers/input/keyboard/atkbd.c	2003-01-31 10:20:56.000000000 +0100
@@ -445,6 +445,23 @@
 	atkbd_command(atkbd, &atkbd->oldset, ATKBD_CMD_SSCANSET);
 }
 
+#ifdef CONFIG_MORSE_PANICS
+static struct atkbd *atkbd_blinkdev = NULL;
+int atkbd_blink(char led) {
+	char param[2] = "\0\0";
+	led = led ? (0x01 | 0x04) : 0x00;
+	*param = led;
+
+	if (atkbd_blinkdev == NULL)
+		return -1;
+
+	if (atkbd_command(atkbd_blinkdev, param, ATKBD_CMD_SETLEDS))
+		return -1;
+
+	return 0;
+}
+#endif
+
 /*
  * atkbd_disconnect() closes and frees.
  */
@@ -543,11 +560,12 @@
 			set_bit(atkbd->keycode[i], atkbd->dev.keybit);
 
 	input_register_device(&atkbd->dev);
-
+#ifdef CONFIG_MORSE_PANICS
+	atkbd_blinkdev = atkbd;
+#endif
 	printk(KERN_INFO "input: %s on %s\n", atkbd->name, serio->phys);
 }
 
-
 static struct serio_dev atkbd_dev = {
 	.interrupt =	atkbd_interrupt,
 	.connect =	atkbd_connect,
diff -urN b/include/linux/morseops.h a/include/linux/morseops.h
--- b/include/linux/morseops.h	1970-01-01 01:00:00.000000000 +0100
+++ a/include/linux/morseops.h	2003-01-31 11:20:05.000000000 +0100
@@ -0,0 +1,26 @@
+/* Yes, it's morse code ops indeed. */
+
+#ifndef _LINUX_MORSEOPS_H
+#define _LINUX_MORSEOPS_H
+
+#include <linux/config.h>
+
+#if defined(CONFIG_MORSE_PANICS)
+
+extern const unsigned char morsetable[];	/* in kernel/morse.c */
+void panic_morseblink(char *buf);		/* in kernel/morse.c */
+
+static inline unsigned char tomorse(char c) {
+	if (c >= 'a' && c <= 'z')
+		c = c - 'a' + 'A';
+	if (c >= '"' && c <= '_') {
+		return morsetable[c - '"'];
+	} else
+		return 0;
+}
+
+#else	/* CONFIG_MORSE_PANICS */
+ #define panic_morseblink(buf)
+#endif	/* CONFIG_MORSE_PANICS */
+
+#endif	/* _LINUX_MORSEOPS_H */
diff -urN b/init/Kconfig a/init/Kconfig
--- b/init/Kconfig	2003-01-17 04:27:43.000000000 +0100
+++ a/init/Kconfig	2003-01-31 11:06:31.000000000 +0100
@@ -98,6 +98,19 @@
 		     13 =>  8 KB
 		     12 =>  4 KB
 
+config MORSE_PANICS
+	bool "Morse code panics"
+	depends on KEYBOARD_ATKBD || VT
+	help
+	  When enabled, this code will make a panicking kernel cry for
+	  help in morse code, signalling on the leds of a possibly attached
+	  AT keyboard and/or a bleeper.  You can enable/disable your morse
+	  output devices of choice using the "panicmorse" kernel boot
+	  parameter.
+
+	  If unsure, say Y.  This feature is very helpful for those who
+	  spend most of their time in X.
+
 endmenu
 
 
@@ -159,4 +172,3 @@
 	  in <file:Documentation/kmod.txt>.
 
 endmenu
-
diff -urN b/kernel/Makefile a/kernel/Makefile
--- b/kernel/Makefile	2003-01-09 10:59:41.000000000 +0100
+++ a/kernel/Makefile	2003-01-31 10:28:04.000000000 +0100
@@ -22,6 +22,7 @@
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_MORSE_PANICS) += morse.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urN b/kernel/morse.c a/kernel/morse.c
--- b/kernel/morse.c	1970-01-01 01:00:00.000000000 +0100
+++ a/kernel/morse.c	2003-01-31 11:19:54.000000000 +0100
@@ -0,0 +1,137 @@
+/*
+ *  kernel/morse.c
+ *
+ *  Copyright (C) 2002 Andrew Rodland <arodland@noln.com>
+ *  Copyright (C) 2003 Tomas Szepe <szepe@pinerecords.com>
+ *
+ *  Tell the user who may be running in X and not see the console that
+ *  we have panic'd.  This is to distingush panics from "real lockups."
+ *  Could in theory send the panic message as morse, but that is left
+ *  as an exercise for the reader.
+ *
+ *  And now it's done! LED and speaker morse code by Andrew Rodland
+ *  <arodland@noln.com>, with improvements based on suggestions from
+ *  linux@horizon.com and a host of others.
+ *
+ *  Initial 2.5 morsepanics port and cleanup by
+ *  Tomas Szepe <szepe@pinerecords.com>, January 2003.
+ */
+
+#include <linux/config.h>
+#include <linux/morseops.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/vt_kern.h>
+
+#define DITLEN		(HZ / 5)
+#define DAHLEN		(3 * DITLEN)
+#define SPACELEN	(7 * DITLEN)
+#define FREQ		844
+
+/*  Only blink by default if AT keyboard is available,
+ *  go for beeping if it isn't.
+ */
+#ifdef CONFIG_KEYBOARD_ATKBD
+extern int atkbd_blink(char led);	/* drivers/input/keyboards/atkbd.c */
+#define do_blink(x) atkbd_blink(x)
+static int morse_setting = 1;
+#else
+#define do_blink(x)
+static int morse_setting = 2;
+#endif
+
+const unsigned char morsetable[] = {
+	0122, 0, 0310, 0, 0, 0163,				/* "#$%&' */
+	055, 0155, 0, 0, 0163, 0141, 0152, 0051, 		/* ()*+,-./ */
+	077, 076, 074, 070, 060, 040, 041, 043, 047, 057,	/* 0-9 */
+	0107, 0125, 0, 0061, 0, 0114, 0, 			/* :;<=>?@ */
+	006, 021, 025, 011, 002, 024, 013, 020, 004,		/* A-I */
+	036, 015, 022, 007, 005, 017, 026, 033, 012,		/* J-R */
+	010, 003, 014, 030, 016, 031, 035, 023,			/* S-Z */
+	0, 0, 0, 0, 0154					/* [\]^_ */
+};
+
+void panic_morseblink(char *buf)
+{ 
+	static unsigned long next_jiffie = 0;
+	static char * bufpos = 0;
+	static unsigned char morse = 0;
+	static char state = 1;
+	
+	if (!morse_setting) 
+		return;
+
+	if (!buf)
+		buf = "Uh oh, we lost the panic msg.";
+
+	/* Waiting for something? */
+	if (bufpos && time_after(next_jiffie, jiffies))
+		return;
+
+	if (state) {	/* Coming off of a blink. */
+		if (morse_setting & 0x01)
+			do_blink(0);
+
+		state = 0;
+
+		if (morse > 1) {
+			/* Not done yet, just a one-dit pause. */
+			next_jiffie = jiffies + DITLEN;
+		} else {
+			/* Get a new char, figure out how much space. */
+
+			/* First time through */
+			if (!bufpos)
+				bufpos = (char *) buf;
+
+			if (!*bufpos) {
+				/* Repeating */
+				bufpos = (char *) buf;
+				next_jiffie = jiffies + SPACELEN;
+			} else {
+				/* Inter-letter space */
+				next_jiffie = jiffies + DAHLEN; 
+			}
+
+			if (!(morse = tomorse(*bufpos))) {
+				next_jiffie = jiffies + SPACELEN;
+				state = 1;	/* And get us back here */
+			}
+			bufpos++;
+		}
+	} else {
+		/* Starting a new blink.  We have a valid code in morse. */
+		int len;
+
+		len = (morse & 001) ? DAHLEN : DITLEN;
+
+#ifdef CONFIG_VT
+		if (morse_setting & 0x02)
+			kd_mksound(FREQ, len);
+#endif
+
+		next_jiffie = jiffies + len;
+
+		if (morse_setting & 0x01)
+			do_blink(1);
+
+		state = 1;
+		morse >>= 1;
+	}
+}
+
+static int __init panicmorse_setup(char *str)
+{
+	int par;
+	if (get_option(&str, &par)) 
+		morse_setting = par;
+	return 1;
+}
+
+/*  "panicmorse=0" disables the blinking as it caused problems with
+ *  certain console switches.
+ *
+ *  "panicmorse | 1" does the show using kbd leds.
+ *  "panicmorse | 2" throws in bleeping via kd_mksound().
+ */
+__setup("panicmorse=", panicmorse_setup);
diff -urN b/kernel/panic.c a/kernel/panic.c
--- b/kernel/panic.c	2003-01-09 10:59:41.000000000 +0100
+++ a/kernel/panic.c	2003-01-31 10:36:50.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
+#include <linux/morseops.h>
 
 asmlinkage void sys_sync(void);	/* it's really int */
 
@@ -95,7 +96,8 @@
         disabled_wait(caller);
 #endif
 	local_irq_enable();
-	for(;;) {
+	for (;;) {
+		panic_morseblink(buf);
 		CHECK_EMERGENCY_SYNC
 	}
 }
