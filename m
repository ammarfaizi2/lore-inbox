Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317539AbSGTVbW>; Sat, 20 Jul 2002 17:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317540AbSGTVbW>; Sat, 20 Jul 2002 17:31:22 -0400
Received: from monster.nni.com ([216.107.0.51]:56070 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S317539AbSGTVbT>;
	Sat, 20 Jul 2002 17:31:19 -0400
Date: Sat, 20 Jul 2002 17:32:22 -0400
From: Andrew Rodland <arodland@noln.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code v3
Message-Id: <20020720173222.3286fcbb.arodland@noln.com>
In-Reply-To: <20020719011300.548d72d5.arodland@noln.com>
References: <20020719011300.548d72d5.arodland@noln.com>
X-Mailer: Sylpheed version 0.7.8claws55 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once more Mr. unnamed sent me some suggestions, and once more I've
merged [my own adaptation of] them in. Also, I took an attempt to make
it somewhat more platform-independent, and re-organize. The original
panic_blink was in pc_keyb.c, and was guarded by an #ifdef __i386__ .
v3 moves the generic code out of pc_keyb (and into panic.c). It should
be able to blink on anything that uses pc_keyb (i386, some ARM, and
some MIPS, apparently), and should be able to beep on anything that
defines kd_mksound to do something (currently only i386). Also the code
has been reorganized so as to be easier to read and follow, and there
are a few more punctuation characters.

Yes, I actually _am_ trying to turn this into something useful.
Now, I don't have a 2.5 tree, and probably wouldn't understand it if I
did, but I get a feeling that this won't be so incredibly easy to port,
thanks to having everything use the input layer. Or am I wrong?

--hobbs

Patch follows

diff -u -r linux.old/drivers/char/pc_keyb.c linux.new/drivers/char/pc_keyb.c
--- linux.old/drivers/char/pc_keyb.c	Fri Jul 19 18:56:36 2002
+++ linux.new/drivers/char/pc_keyb.c	Sat Jul 20 13:18:40 2002
@@ -1244,41 +1244,13 @@
 #endif /* CONFIG_PSMOUSE */
 
 
-static int blink_frequency = HZ/2;
+void pckbd_blink (char led) {
+		led = led ? (0x01 | 0x04) : 0x00;
 
-/* Tell the user who may be running in X and not see the console that we have 
-   panic'ed. This is to distingush panics from "real" lockups. 
-   Could in theory send the panic message as morse, but that is left as an
-   exercise for the reader.  */ 
-void panic_blink(void)
-{ 
-	static unsigned long last_jiffie;
-	static char led;
-	/* Roughly 1/2s frequency. KDB uses about 1s. Make sure it is 
-	   different. */
-	if (!blink_frequency) 
-		return;
-	if (jiffies - last_jiffie > blink_frequency) {
-		led ^= 0x01 | 0x04;
 		while (kbd_read_status() & KBD_STAT_IBF) mdelay(1); 
 		kbd_write_output(KBD_CMD_SET_LEDS);
 		mdelay(1); 
 		while (kbd_read_status() & KBD_STAT_IBF) mdelay(1); 
 		mdelay(1); 
 		kbd_write_output(led);
-		last_jiffie = jiffies;
-	}
-}  
-
-static int __init panicblink_setup(char *str)
-{
-    int par;
-    if (get_option(&str,&par)) 
-	    blink_frequency = par*(1000/HZ);
-    return 1;
 }
-
-/* panicblink=0 disables the blinking as it caused problems with some console
-   switches. otherwise argument is ms of a blink period. */
-__setup("panicblink=", panicblink_setup);
-
diff -u -r linux.old/kernel/panic.c linux.new/kernel/panic.c
--- linux.old/kernel/panic.c	Fri Jul 19 18:56:36 2002
+++ linux.new/kernel/panic.c	Sat Jul 20 17:28:41 2002
@@ -16,6 +16,8 @@
 #include <linux/init.h>
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
+#include <linux/vt_kern.h>
+#include <linux/pc_keyb.h>
 
 asmlinkage void sys_sync(void);	/* it's really int */
 
@@ -28,9 +30,132 @@
 	panic_timeout = simple_strtoul(str, NULL, 0);
 	return 1;
 }
-
 __setup("panic=", panic_setup);
 
+static int blink_setting = 1;
+
+/* Tell the user who may be running in X and not see the console that we have 
+   panic'ed. This is to distingush panics from "real" lockups. 
+   Could in theory send the panic message as morse, but that is left as an
+   exercise for the reader.  
+	And now it's done! LED and speaker morse code by Andrew Rodland 
+	<arodland@noln.com>, with improvements based on suggestions from
+	linux@horizon.com.
+*/ 
+
+static const unsigned char morsetable[] = {
+	/*  !   "    #  $     %  &    '	 	 */
+	    0, 0122, 0, 0310, 0, 0, 0163,
+	/*  (       )  *  +    ,     -    .      /	 */
+	    055, 0155, 0, 0, 0163, 0141, 0152, 0051,
+	/* 0-9 */
+	    077, 076, 074, 070, 060, 040, 041, 043, 047, 057,
+	/*  :     ;     <   =    >   ?    @  */
+	    0107, 0125, 0, 0061, 0, 0114, 0,
+	/* A-I */
+	   006, 021, 025, 011, 002, 024, 013, 020, 004,
+	/* J-R */
+	   036, 015, 022, 007, 005, 017, 026, 033, 012,
+	/* S-Z */
+	   010, 003, 014, 030, 016, 031, 035, 023,
+	/* [  \  ]  ^  */
+	   0, 0, 0, 0,
+	/* _ */
+	   0154
+
+};
+
+#define DITLEN (HZ / 5)
+#define DAHLEN 3 * DITLEN
+#define SPACELEN 7 * DITLEN
+
+#define FREQ 844
+
+
+#if (defined(__i386__) && defined(CONFIG_VT)) || defined(CONFIG_PC_KEYB)
+#define do_blink(x) pckbd_blink(x)
+#else
+#define do_blink(x) 0
+#endif
+
+void panic_blink(char * buf)
+{ 
+	static unsigned long next_jiffie = 0;
+	static char * bufpos = 0;
+	static unsigned char morse = 0;
+	static char state = 1;
+	
+	if (!blink_setting) 
+		return;
+
+	if (!buf)
+		buf="Panic lost?";
+
+
+	if (bufpos && time_after (next_jiffie, jiffies)) {
+		return; /* Waiting for something. */
+	}
+
+	if (state) { /* Coming off of a blink. */
+		if (blink_setting & 0x01)
+			do_blink(0);
+
+		state = 0;
+
+		if(morse > 1) { /* Not done yet, just a one-dit pause. */
+			next_jiffie = jiffies + DITLEN;
+		} else { /* Get a new char, and figure out how much space. */
+			
+			if(!bufpos)
+				bufpos = (char *)buf; /* First time through */
+
+			if(!*bufpos) {
+				bufpos = (char *)buf; /* Repeating */
+				next_jiffie = jiffies + SPACELEN;
+			} else {
+				next_jiffie = jiffies + DAHLEN; /* Inter-letter space */
+			}
+
+			if (*bufpos >= '!' && *bufpos <= '_') {
+				morse = morsetable[*bufpos - '!'];
+			} else if (*bufpos >= 'a' && *bufpos <= 'z') {
+				morse = morsetable[*bufpos - 'a' + 'A' - '!'];
+			} else {
+				next_jiffie = jiffies + SPACELEN; /*Space -- For a total of 7*/
+				state = 1; /* And bring us back here when we're done */
+			}
+			bufpos ++;
+		}
+	} else { /* Starting a new blink. We have valid code in morse. */
+		int len;
+
+		len = (morse & 001) ? DAHLEN : DITLEN;
+
+		if (blink_setting & 0x02)
+			kd_mksound(FREQ, len);
+		
+		next_jiffie = jiffies + len;
+
+		if (blink_setting & 0x01)
+			do_blink(1);
+		state = 1;
+		morse >>= 1;
+	}
+}  
+
+static int __init panicblink_setup(char *str)
+{
+    int par;
+    if (get_option(&str,&par)) 
+	    blink_setting = par;
+    return 1;
+}
+
+/* panicblink=0 disables the blinking as it caused problems with some console
+   switches. otherwise argument is ms of a blink period. */
+__setup("panicblink=", panicblink_setup);
+
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -96,10 +221,7 @@
 #endif
 	sti();
 	for(;;) {
-#if defined(__i386__) && defined(CONFIG_VT) 
-		extern void panic_blink(void);
-		panic_blink(); 
-#endif
+		panic_blink(buf); 
 		CHECK_EMERGENCY_SYNC
 	}
 }

