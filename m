Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSGSFLD>; Fri, 19 Jul 2002 01:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315629AbSGSFLC>; Fri, 19 Jul 2002 01:11:02 -0400
Received: from monster.nni.com ([216.107.0.51]:11538 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S315540AbSGSFK5>;
	Fri, 19 Jul 2002 01:10:57 -0400
Date: Fri, 19 Jul 2002 01:13:00 -0400
From: Andrew Rodland <arodland@noln.com>
To: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: [PATCH -ac] Panicking in morse code
Message-Id: <20020719011300.548d72d5.arodland@noln.com>
X-Mailer: Sylpheed version 0.7.8claws55 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, it's not 1 April.

I was researching panic_blink() for someone who needed a little help,
when I noticed the comment above the function definition, not being the
kind to step down from a challenge (unless it's just really hard), I
decided to write morse code output code.

The option panicblink= has been hijacked to be a simple bitfield: 
bit 1 : blink LEDs
bit 2 : sound the PC speaker.

the blinking option depends only on pc_keyb.c. the pcspeaker option
depends on kb_mksound() actually doing something. At the moment, both of
these mean i386. The call to panic_blink() in panic() is still guarded
by an i386 #ifdef, anyway, for the moment. The default is to blink only,
because I figured the beeps would be too annoying. Opinions?

It recognizes letters, and digits, and treats everything else as a
space. The timings are tunable by #defines. It repeats the message
indefinitely. And it should only bloat the kernel by a few hundred
bytes, although if someone wants to wrap this in its own config option,
well, that's good too.

Anyway, here's the patch. It's against linux-2.4.19-rc1-ac1+preempt, but
I suspect it applies against all recent -ac. If 2.5 has this, it will
hopefully apply with some fuzz against that, too. I don't have a tree.
(modem. ecch.)


diff -u -r -d linux.old/drivers/char/pc_keyb.c linux/drivers/char/pc_keyb.c
--- linux.old/drivers/char/pc_keyb.c	Fri Jul 19 00:59:04 2002
+++ linux/drivers/char/pc_keyb.c	Fri Jul 19 01:00:34 2002
@@ -1244,37 +1244,126 @@
 #endif /* CONFIG_PSMOUSE */
 
 
-static int blink_frequency = HZ/2;
+static int blink_setting = 1;
 
 /* Tell the user who may be running in X and not see the console that we have 
    panic'ed. This is to distingush panics from "real" lockups. 
    Could in theory send the panic message as morse, but that is left as an
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
+   exercise for the reader.  
+	And now it's done! LED and speaker morse code by Andrew Rodland, 18-19 Jul 2002
+*/ 
+
+static const char * morse[] = {
+	".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", /* A-H */
+	"..", ".---.", "-.-", ".-..", "--", "-.", "---", ".--.", /* I-P */
+	"--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", /* Q-X */
+	"-.--", "--..",	 	 	 	 	 	 /* Y-Z */
+	"-----", ".----", "..---", "...--", "....-",	 	 /* 0-4 */
+	".....", "-....", "--...", "---..", "----."	 	 /* 5-9 */
+};
+
+#define DITLEN (HZ / 4)
+#define DAHLEN 3 * DITLEN
+#define FREQ 1000
+
+static __inline__ void do_blink (int led) {
+
+		if (! blink_setting & 0x01)
+			return;
+		
+		led = led ? (0x01 | 0x04) : 0x00;
+
 		while (kbd_read_status() & KBD_STAT_IBF) mdelay(1); 
 		kbd_write_output(KBD_CMD_SET_LEDS);
 		mdelay(1); 
 		while (kbd_read_status() & KBD_STAT_IBF) mdelay(1); 
 		mdelay(1); 
 		kbd_write_output(led);
-		last_jiffie = jiffies;
+}
+
+void panic_blink(char * buf)
+{ 
+	static unsigned long next_jiffie = 0;
+	static char * bufpos = 0;
+	static char * morsepos = 0;
+	static char state;
+	
+	if (!blink_setting) 
+		return;
+
+	if (!buf)
+		buf="ABC";
+
+
+	if (jiffies > next_jiffie || !bufpos) { //messy. fix.
+		
+		if (state) {
+			do_blink(0);
+			state = 0;
+			next_jiffie = jiffies + DITLEN;
+			return;
+		}
+
+		if (!bufpos) {
+			bufpos = (char *)buf;
+			return;
+		}
+
+	
+		if (!morsepos || !*morsepos) {
+			
+			if (!*bufpos) { /*Repeat the message */ 
+				bufpos = (char *)buf;
+				morsepos = 0;
+				next_jiffie = jiffies + 3 * DAHLEN;
+				return;
+			}
+			next_jiffie = jiffies + DITLEN;
+
+			if (*bufpos >= 'A' && *bufpos <= 'Z') {
+				morsepos = (char *)morse[*bufpos - 'A'];
+			} else if (*bufpos >= 'a' && *bufpos <= 'z') {
+				morsepos = (char *)morse[*bufpos - 'a'];
+			} else if (*bufpos >= '0' && *bufpos <= '9') {
+				morsepos = (char *)morse[*bufpos - '0' + 26];
+			} else {
+				next_jiffie += 2*DITLEN;
+			}
+			bufpos ++;
+			
+			return;
+		}
+
+		if (*morsepos == '.') {
+			if (blink_setting & 0x02)
+				kd_mksound(FREQ, DITLEN);
+			next_jiffie = jiffies + DITLEN;
+			do_blink(1);
+			state = 1;
+			morsepos++;
+			return;
+		} else if (*morsepos == '-') {
+			if (blink_setting & 0x02)
+				kd_mksound(FREQ, DAHLEN);
+			next_jiffie = jiffies + DAHLEN;
+			do_blink(1);
+			state = 1;
+			morsepos++;
+			return;
+		}
+
+		/*impossible*/
+		morsepos = 0;
+
 	}
+	
 }  
 
 static int __init panicblink_setup(char *str)
 {
     int par;
     if (get_option(&str,&par)) 
-	    blink_frequency = par*(1000/HZ);
+	    blink_setting = par;
     return 1;
 }
 
diff -u -r -d linux.old/kernel/panic.c linux/kernel/panic.c
--- linux.old/kernel/panic.c	Fri Jul 19 00:59:04 2002
+++ linux/kernel/panic.c	Thu Jul 18 21:45:45 2002
@@ -97,8 +97,8 @@
 	sti();
 	for(;;) {
 #if defined(__i386__) && defined(CONFIG_VT) 
-		extern void panic_blink(void);
-		panic_blink(); 
+		extern void panic_blink(char * buf);
+		panic_blink(buf); 
 #endif
 		CHECK_EMERGENCY_SYNC
 	}
