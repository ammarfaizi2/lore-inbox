Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbTAaT3v>; Fri, 31 Jan 2003 14:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTAaT3v>; Fri, 31 Jan 2003 14:29:51 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:27796 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261900AbTAaT3r>; Fri, 31 Jan 2003 14:29:47 -0500
Date: Fri, 31 Jan 2003 20:38:59 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@codemonkey.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Rodland <arodland@noln.com>,
       john@grabjohn.com
Subject: Re: [PATCH] 2.5.59 morse code panics
Message-ID: <20030131193859.GP12286@louise.pinerecords.com>
References: <20030130150709.GC701@louise.pinerecords.com> <20030130173642.GB25824@codemonkey.org.uk> <1043952334.31674.20.camel@irongate.swansea.linux.org.uk> <20030131185927.B25927@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030131185927.B25927@ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [vojtech@suse.cz]
> 
> It should be in the keyboard.c file, using input_event() to blink the
> LEDs. This way it'll work on all archs in 2.5.

This change
 a) allows for other cleanups, too.
 b) probably makes the gazillion leds on sparc keyboards blink.  EVIL!!

So here's v3.

-- 
Tomas Szepe <szepe@pinerecords.com>


 drivers/char/keyboard.c  |   21 +++++++
 include/linux/morseops.h |   26 +++++++++
 include/linux/vt_kern.h  |    3 +
 init/Kconfig             |   15 +++++
 kernel/Makefile          |    1 
 kernel/morse.c           |  125 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/panic.c           |    4 +
 7 files changed, 194 insertions(+), 1 deletion(-)

diff -urN a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	2002-12-16 07:01:47.000000000 +0100
+++ b/drivers/char/keyboard.c	2003-01-31 20:24:33.000000000 +0100
@@ -262,6 +262,27 @@
 }
 
 /*
+ * Turn all possible leds on or off.
+ */
+void kd_turn_all_leds(int on_or_off)
+{
+	struct list_head *node;
+	on_or_off = on_or_off ? 1 : 0;
+
+	list_for_each(node, &kbd_handler.h_list) {
+		struct input_handle *handle = to_handle_h(node);
+		if (test_bit(EV_LED, handle->dev->evbit)) {
+			int led;
+			for (led = 0; led <= LED_MAX; led++) {
+				if (test_bit(led, handle->dev->ledbit))
+					input_event(handle->dev, EV_LED, led,
+						on_or_off);
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
+++ b/include/linux/morseops.h	2003-01-31 20:24:33.000000000 +0100
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
diff -urN a/include/linux/vt_kern.h b/include/linux/vt_kern.h
--- a/include/linux/vt_kern.h	2002-12-16 07:01:55.000000000 +0100
+++ b/include/linux/vt_kern.h	2003-01-31 20:24:33.000000000 +0100
@@ -33,7 +33,10 @@
 	wait_queue_head_t paste_wait;
 } *vt_cons[MAX_NR_CONSOLES];
 
+/* keyboard.c */
+
 extern void kd_mksound(unsigned int hz, unsigned int ticks);
+extern void kd_turn_all_leds(int on_or_off);
 extern int kbd_rate(struct kbd_repeat *rep);
 
 /* console.c */
diff -urN a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2003-01-17 04:27:10.000000000 +0100
+++ b/init/Kconfig	2003-01-31 20:24:33.000000000 +0100
@@ -98,6 +98,21 @@
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
+	  If unsure, say Y.  This feature is very helpful for those who
+	  spend most of their time in X.
+
 endmenu
 
 
diff -urN a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	2003-01-09 14:25:40.000000000 +0100
+++ b/kernel/Makefile	2003-01-31 20:24:33.000000000 +0100
@@ -22,6 +22,7 @@
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_MORSE_PANICS) += morse.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urN a/kernel/morse.c b/kernel/morse.c
--- a/kernel/morse.c	1970-01-01 01:00:00.000000000 +0100
+++ b/kernel/morse.c	2003-01-31 20:24:33.000000000 +0100
@@ -0,0 +1,125 @@
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
+static int morse_setting = 1;
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
+			kd_turn_all_leds(0);
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
+		if (morse_setting & 0x02)
+			kd_mksound(FREQ, len);
+
+		next_jiffie = jiffies + len;
+
+		if (morse_setting & 0x01)
+			kd_turn_all_leds(1);
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
+++ b/kernel/panic.c	2003-01-31 20:24:33.000000000 +0100
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
