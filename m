Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262701AbTCRWYP>; Tue, 18 Mar 2003 17:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262736AbTCRWYP>; Tue, 18 Mar 2003 17:24:15 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:27012 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S262701AbTCRWYH>; Tue, 18 Mar 2003 17:24:07 -0500
Date: Tue, 18 Mar 2003 23:35:00 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] morse code panics for 2.5.65
Message-ID: <20030318223500.GC13142@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arch-independent morse code panics.
Rediffed against 2.5.65.


diff -urN a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	2003-02-15 10:20:06.000000000 +0100
+++ b/drivers/char/keyboard.c	2003-03-18 08:18:15.000000000 +0100
@@ -260,6 +260,27 @@
 }
 
 /*
+ * Turn all possible leds on or off.
+ */
+void kd_set_led_all(int state)
+{
+	struct list_head *node;
+	state = state ? 1 : 0;
+
+	list_for_each(node, &kbd_handler.h_list) {
+		struct input_handle *handle = to_handle_h(node);
+		if (test_bit(EV_LED, handle->dev->evbit)) {
+			int led;
+			for (led = 0; led <= LED_MAX; led++) {
+				if (test_bit(led, handle->dev->ledbit))
+					input_event(handle->dev, EV_LED, led,
+						state);
+			}
+		}
+	}
+}
+
+/*
  * Setting the keyboard rate.
  */
 static inline unsigned int ms_to_jiffies(unsigned int ms) {
diff -urN a/include/linux/morseops.h b/include/linux/morseops.h
--- a/include/linux/morseops.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/linux/morseops.h	2003-03-18 08:16:43.000000000 +0100
@@ -0,0 +1,23 @@
+/*  Yes, it's morse code ops indeed.  */
+
+#ifndef _LINUX_MORSEOPS_H
+#define _LINUX_MORSEOPS_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_MORSE_PANICS
+
+extern const unsigned char morsetable[];	/* in kernel/morse.c */
+void panic_morseblink(char *buf);		/* in kernel/morse.c */
+
+static inline unsigned char tomorse(char c) {
+	if (c >= 'a' && c <= 'z')
+		c -= 'a' - 'A';
+	return (c >= '"' && c <= '_') ? morsetable[c - '"'] : 0;
+}
+
+#else	/* CONFIG_MORSE_PANICS */
+# define panic_morseblink(buf)		do { } while (0)
+#endif	/* CONFIG_MORSE_PANICS */
+
+#endif	/* _LINUX_MORSEOPS_H */
diff -urN a/include/linux/vt_kern.h b/include/linux/vt_kern.h
--- a/include/linux/vt_kern.h	2002-12-16 07:01:55.000000000 +0100
+++ b/include/linux/vt_kern.h	2003-03-18 08:19:01.000000000 +0100
@@ -33,7 +33,10 @@
 	wait_queue_head_t paste_wait;
 } *vt_cons[MAX_NR_CONSOLES];
 
+/* keyboard.c */
+
 extern void kd_mksound(unsigned int hz, unsigned int ticks);
+extern void kd_set_led_all(int state);
 extern int kbd_rate(struct kbd_repeat *rep);
 
 /* console.c */
diff -urN a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2003-03-18 08:15:50.000000000 +0100
+++ b/init/Kconfig	2003-03-18 08:16:43.000000000 +0100
@@ -108,6 +108,21 @@
 		     13 =>  8 KB
 		     12 =>  4 KB
 
+config MORSE_PANICS
+	bool "Morse code panics"
+	depends on VT
+	help
+	  When enabled, this code will make a panicking kernel cry for
+	  help in morse code, signalling on the leds of a possibly attached
+	  keyboard and/or a bleeper.  You can enable/disable your morse
+	  output devices of choice using the "panicmorse" kernel boot
+	  parameter.  Currently, "panicmorse=0" will disable the signalling
+	  completely, "panicmorse=1" (the default) will only blink the leds,
+	  "panicmorse=2" will only beep, and "panicmorse=3" will do both.
+
+	  If unsure, say Y.  This feature is very helpful to those who
+	  spend most of their time in X.
+
 endmenu
 
 
diff -urN a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	2003-02-25 07:44:43.000000000 +0100
+++ b/kernel/Makefile	2003-03-18 08:16:43.000000000 +0100
@@ -18,6 +18,7 @@
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_MORSE_PANICS) += morse.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urN a/kernel/morse.c b/kernel/morse.c
--- a/kernel/morse.c	1970-01-01 01:00:00.000000000 +0100
+++ b/kernel/morse.c	2003-03-18 08:20:12.000000000 +0100
@@ -0,0 +1,229 @@
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
+ *
+ *  Cryptic morse code table replaced with meticulous macrowork by
+ *  Jan-Benedict Glaw <jbglaw@lug-owl.de>, February 2003.
+ */
+
+#include <linux/config.h>
+#include <linux/morseops.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/vt_kern.h>
+
+#define DITLEN			(HZ / 5)
+#define DAHLEN			(3 * DITLEN)
+#define SPACELEN		(7 * DITLEN)
+#define FREQ			844
+
+#define MORSE_OUTPUT_BLINK	(1 << 0)
+#define MORSE_OUTPUT_BLEEP	(1 << 1)
+#define MORSE_OUTPUT_ESTRADE	(MORSE_OUTPUT_BLINK | MORSE_OUTPUT_BLEEP)
+
+static int morse_setting = MORSE_OUTPUT_BLINK;
+
+/*  The following macros are used to make up the morse code table.  */
+
+#define	IS_DASH(letter, shift)					\
+	((letter) == '-' ? (1 << (shift)) : (0 << (shift)))
+#define	MORSE(shift, b1, b2, b3, b4, b5, b6)			\
+	(1 << (shift)	| IS_DASH((b1), 5) | IS_DASH((b2), 4)	\
+			| IS_DASH((b3), 3) | IS_DASH((b4), 2)	\
+			| IS_DASH((b5), 1) | IS_DASH((b6), 0))
+#define	MORSE0(letter)						\
+		(0)
+#define	MORSE1(letter, b1)					\
+		MORSE(1, '.', '.', '.', '.', '.', (b1))
+#define	MORSE2(letter, b1, b2)					\
+		MORSE(2, '.', '.', '.', '.', (b1), (b2))
+#define	MORSE3(letter, b1, b2, b3)				\
+		MORSE(3, '.', '.', '.', (b1), (b2), (b3))
+#define	MORSE4(letter, b1, b2, b3, b4)				\
+		MORSE(4, '.', '.', (b1), (b1), (b3), (b4))
+#define	MORSE5(letter, b1, b2, b3, b4, b5)			\
+		MORSE(5, '.', (b1), (b2), (b3), (b4), (b5))
+#define	MORSE6(letter, b1, b2, b3, b4, b5, b6)			\
+		MORSE(6, (b1), (b2), (b3), (b4), (b5), (b6))
+
+/*  Do not shuffle things about in here, the order matters.  */
+const unsigned char morsetable[] = {
+
+	/*  0122, 0, 0310, 0, 0, 0163,				"#$%&'  */
+	MORSE6('"', '-', '.', '-', '-', '.', '-'),
+	MORSE0('#'),
+	0310,		/*  '$': FIXME  */
+	MORSE0('%'),
+	MORSE0('&'),
+	MORSE6('\'', '-', '.', '-', '.', '-', '-'),
+
+	/*  055, 0155, 0, 0, 0163, 0141, 0152, 0051,		()*+,-./  */
+	MORSE5('(', '-', '.', '-', '-', '.'),
+	MORSE6(')', '-', '.', '-', '-', '.', '-'),
+	MORSE0('*'),
+
+	/*  http://www.vennfuessler.de/service/technik/morsen.html  */
+	MORSE5('+', '.', '-', '.', '-', '.'),
+
+	MORSE6(',', '-', '-', '.', '.', '.', '-'),
+	MORSE6('-', '-', '.', '.', '.', '.', '-'),
+	MORSE6('.', '.', '-', '.', '-', '.', '-'),
+	MORSE5('/', '-', '.', '.', '-', '.'),
+
+	/*  077, 076, 074, 070, 060, 040, 041, 043, 047, 057,	0-9  */
+	MORSE5('0', '-', '-', '-', '-', '-'),
+	MORSE5('1', '.', '-', '-', '-', '-'),
+	MORSE5('2', '.', '.', '-', '-', '-'),
+	MORSE5('3', '.', '.', '.', '-', '-'),
+	MORSE5('4', '.', '.', '.', '.', '-'),
+	MORSE5('5', '.', '.', '.', '.', '.'),
+	MORSE5('6', '-', '.', '.', '.', '.'),
+	MORSE5('7', '-', '-', '.', '.', '.'),
+	MORSE5('8', '-', '-', '-', '.', '.'),
+	MORSE5('9', '-', '-', '-', '-', '.'),
+
+	/*  0107, 0125, 0, 0061, 0, 0114, 0,			:;<=>?@  */
+	MORSE6(':', '-', '-', '-', '.', '.', '.'),
+	MORSE6(';', '-', '.', '-', '.', '-', '.'),
+	MORSE0('<'),
+	MORSE5('=', '-', '.', '.', '.', '-'),
+	MORSE0('>'),
+	MORSE6('?', '.', '.', '-', '-', '.', '.'),
+	MORSE0('@'),
+
+	/*  006, 021, 025, 011, 002, 024, 013, 020, 004,	A-I  */
+	MORSE2('A', '.', '-'),
+	MORSE4('B', '-', '.', '.', '.'),
+	MORSE4('C', '-', '.', '-', '.'),
+	MORSE3('D', '-', '.', '.'),
+	MORSE1('E', '.'),
+	MORSE4('F', '.', '.', '-', '.'),
+	MORSE3('G', '-', '-', '.'),
+	MORSE4('H', '.', '.', '.', '.'),
+	MORSE2('I', '.', '.'),
+
+	/*  036, 015, 022, 007, 005, 017, 026, 033, 012,	J-R  */
+	MORSE4('J', '.', '-', '-', '-'),
+	MORSE3('K', '-', '.', '-'),
+	MORSE4('L', '.', '-', '.', '.'),
+	MORSE2('M', '-', '-'),
+	MORSE2('N', '-', '.'),
+	MORSE3('O', '-', '-', '-'),
+	MORSE4('P', '.', '-', '-', '.'),
+	MORSE4('Q', '-', '-', '.', '-'),
+	MORSE3('R', '.', '-', '.'),
+
+	/*  010, 003, 014, 030, 016, 031, 035, 023,		S-Z  */
+	MORSE3('S', '.', '.', '.'),
+	MORSE1('T', '-'),
+	MORSE3('U', '.', '.', '-'),
+	MORSE4('V', '.', '.', '.', '-'),
+	MORSE3('W', '.', '-', '-'),
+	MORSE4('X', '-', '.', '.', '-'),
+	MORSE4('Y', '-', '.', '-', '-'),
+	MORSE4('Z', '-', '-', '.', '.'),
+
+	/*  0, 0, 0, 0, 0154					[\]^_  */
+	MORSE0('['),
+	MORSE0('\\'),
+	MORSE0(']'),
+	MORSE0('^'),
+	MORSE6('_', '.', '-', '-', '-', '.', '-'),
+};
+
+void panic_morseblink(char *buf)
+{ 
+	static unsigned long next_jiffie = 0;
+	static char *bufpos = 0;
+	static unsigned char morse = 0;
+	static char state = 1;
+	
+	if (!(morse_setting & MORSE_OUTPUT_ESTRADE))
+		return;
+
+	if (!buf)
+		buf = "Uh oh, we lost the panic msg.";
+
+	/*  Waiting for something?  */
+	if (bufpos && time_after(next_jiffie, jiffies))
+		return;
+
+	if (state) {	/*  Coming off of a blink.  */
+		if (morse_setting & MORSE_OUTPUT_BLINK)
+			kd_set_led_all(0);
+
+		state = 0;
+
+		if (morse > 1) {
+			/*  Not done yet, just a one-dit pause.  */
+			next_jiffie = jiffies + DITLEN;
+		} else {
+			/*  Get a new char, figure out how much space.  */
+
+			/*  First time through.  */
+			if (!bufpos)
+				bufpos = buf;
+
+			if (!*bufpos) {
+				/*  Repeating.  */
+				bufpos = buf;
+				next_jiffie = jiffies + SPACELEN;
+			} else {
+				/*  Inter-letter space.  */
+				next_jiffie = jiffies + DAHLEN; 
+			}
+
+			if (!(morse = tomorse(*bufpos))) {
+				next_jiffie = jiffies + SPACELEN;
+				state = 1;	/*  And get us back here.  */
+			}
+			bufpos++;
+		}
+	} else {
+		/*  Starting a new blink.  We have a valid code in morse.  */
+		int len;
+
+		len = (morse & 0x01) ? DAHLEN : DITLEN;
+
+		if (morse_setting & MORSE_OUTPUT_BLEEP)
+			kd_mksound(FREQ, len);
+
+		if (morse_setting & MORSE_OUTPUT_BLINK)
+			kd_set_led_all(1);
+
+		next_jiffie = jiffies + len;
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
diff -urN a/kernel/panic.c b/kernel/panic.c
--- a/kernel/panic.c	2003-01-09 14:25:40.000000000 +0100
+++ b/kernel/panic.c	2003-03-18 08:16:43.000000000 +0100
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
