Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267516AbTA3O6T>; Thu, 30 Jan 2003 09:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267518AbTA3O6T>; Thu, 30 Jan 2003 09:58:19 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:39054 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267516AbTA3O6P>; Thu, 30 Jan 2003 09:58:15 -0500
Date: Thu, 30 Jan 2003 16:07:09 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Rodland <arodland@noln.com>, john@grabjohn.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.59 morse code panics
Message-ID: <20030130150709.GC701@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the initial port of Andrew Rodland's morse code panics to
2.5.  It's probably got a few issues that need to be sorted out:
at least the acquisition of the atkbd handle is a shameful hack.
The original regular blinking code from ac has been removed,
because it's no use when we've got morse about. :)

Any comments appreciated, patch against 2.5.59.

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2002-12-08 20:06:16.000000000 +0100
+++ b/drivers/input/keyboard/atkbd.c	2003-01-30 15:19:50.000000000 +0100
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
diff -urN a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2003-01-17 04:27:10.000000000 +0100
+++ b/init/Kconfig	2003-01-30 15:15:56.000000000 +0100
@@ -98,6 +98,17 @@
 		     13 =>  8 KB
 		     12 =>  4 KB
 
+config MORSE_PANICS
+	bool "Morse code panics"
+	depends on KEYBOARD_ATKBD || VT
+	help
+	  When enabled, this code will make a panicking kernel scream for
+	  help in morse code, signalling on the leds of a possibly attached
+	  AT keyboard and/or a bleeper.  You can enable/disable your morse
+	  output devices of choice using the "panicmorse" kernel boot
+	  parameter.
+	  If unsure, say Y.
+
 endmenu
 
 
@@ -159,4 +170,3 @@
 	  in <file:Documentation/kmod.txt>.
 
 endmenu
-
diff -urN a/kernel/panic.c b/kernel/panic.c
--- a/kernel/panic.c	2003-01-09 14:25:40.000000000 +0100
+++ b/kernel/panic.c	2003-01-30 15:46:11.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
+#include <linux/vt_kern.h>
 
 asmlinkage void sys_sync(void);	/* it's really int */
 
@@ -31,6 +32,142 @@
 
 __setup("panic=", panic_setup);
 
+#ifdef CONFIG_MORSE_PANICS
+
+#ifdef CONFIG_KEYBOARD_ATKBD
+ extern int atkbd_blink(char led);	/* drivers/input/keyboards/atkbd.c */
+ #define do_blink(x) atkbd_blink(x)
+#else
+ #define do_blink(x) 0
+#endif
+
+static int morse_setting = 1;
+
+static const unsigned char morsetable[] = {
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
+static inline unsigned char tomorse(char c) {
+	if (c >= 'a' && c <= 'z')
+		c = c - 'a' + 'A';
+	if (c >= '"' && c <= '_') {
+		return morsetable[c - '"'];
+	} else
+		return 0;
+}
+
+#define DITLEN		(HZ / 5)
+#define DAHLEN		(3 * DITLEN)
+#define SPACELEN	(7 * DITLEN)
+
+#define FREQ 844
+
+/*  Tell the user who may be running in X and not see the console that
+ *  we have panic'd.  This is to distingush panics from "real lockups."
+ *  Could in theory send the panic message as morse, but that is left
+ *  as an exercise for the reader.
+ *
+ *  And now it's done! LED and speaker morse code by Andrew Rodland
+ *  <arodland@noln.com>, with improvements based on suggestions from
+ *  linux@horizon.com and a host of others.
+ *
+ *  Initial 2.5 morsepanics port by Tomas Szepe <szepe@pinerecords.com>,
+ *  January 2003.
+ */
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
+
+#endif /* CONFIG_MORSE_PANICS */
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -95,7 +232,10 @@
         disabled_wait(caller);
 #endif
 	local_irq_enable();
-	for(;;) {
+	for (;;) {
+#if defined(CONFIG_MORSE_PANICS)
+		panic_morseblink(buf);
+#endif
 		CHECK_EMERGENCY_SYNC
 	}
 }
