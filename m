Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317152AbSGSXA2>; Fri, 19 Jul 2002 19:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSGSXA2>; Fri, 19 Jul 2002 19:00:28 -0400
Received: from monster.nni.com ([216.107.0.51]:50437 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S317152AbSGSXA1>;
	Fri, 19 Jul 2002 19:00:27 -0400
Date: Fri, 19 Jul 2002 19:02:13 -0400
From: Andrew Rodland <arodland@noln.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code, v2
Message-Id: <20020719190213.2a2d51f8.arodland@noln.com>
In-Reply-To: <20020719011300.548d72d5.arodland@noln.com>
References: <20020719011300.548d72d5.arodland@noln.com>
X-Mailer: Sylpheed version 0.7.8claws55 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a million to the unnamed linux<AT>horizon.com for some great
suggestions/info. v2 of the morse-panic patch features better
punctuation handling, proper morse-like timings, and something like 1/5
the static data requirement, thanks to the varicode algo that I
couldn't come up with myself. :)

Patch follows.

diff -u -r linux.old/drivers/char/pc_keyb.c linux.new/drivers/char/pc_keyb.c
--- linux.old/drivers/char/pc_keyb.c	Fri Jul 19 18:56:36 2002
+++ linux.new/drivers/char/pc_keyb.c	Fri Jul 19 18:54:17 2002
@@ -1244,29 +1244,131 @@
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
+	And now it's done! LED and speaker morse code by Andrew Rodland 
+	<arodland@noln.com>, with improvements based on suggestions from
+	linux@horizon.com.
+*/ 
+
+static const char morsetable[] = {
+	/*	 .-   -... -.-. -..  .    ..-. --.  .... .. */
+		 006, 021, 025, 011, 002, 024, 013, 020, 004,	 /* A-I */
+	/*	 .--- -.-  .-.. --   -.-  ---  .--. --.- .-.  */
+		 036, 015, 022, 007, 005, 017, 026, 033, 012,	 /* J-R */
+	/*	 ...  -    ..-  ...- .--  -..- -.-- --.. */
+		 010, 003, 014, 030, 016, 031, 035, 023,	 /* S-Z */
+
+	077, 076, 074, 070, 060, 040, 041, 043, 047, 057 	 /* 0-9 */
+};
+
+
+#define DITLEN (HZ / 5)
+#define DAHLEN 3 * DITLEN
+#define SPACELEN 7 * DITLEN
+
+#define FREQ 844
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
+	static char morse = 0;
+	static char state;
+	
+	if (!blink_setting) 
+		return;
+
+	if (!buf)
+		buf="Panic lost?";
+
+
+	if (jiffies >= next_jiffie || !bufpos) { //messy. fix.
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
+		if (morse <=1 ) { /* Many thanks for the clever scheme, horizon! */
+			if (!*bufpos) { /*Repeat the message */ 
+				bufpos = (char *)buf;
+				next_jiffie = jiffies + 3 * DAHLEN;
+				return;
+			}
+
+			next_jiffie = jiffies + 3*DITLEN;
+
+			if (*bufpos >= 'A' && *bufpos <= 'Z') {
+				morse = morsetable[*bufpos - 'A'];
+			} else if (*bufpos >= 'a' && *bufpos <= 'z') {
+				morse = morsetable[*bufpos - 'a'];
+			} else if (*bufpos >= '0' && *bufpos <= '9') {
+				morse = morsetable[*bufpos - '0' + 26];
+			} else {
+				switch (*bufpos) {
+					case '/': morse = 0051; break; /* -..-.  */
+					case '=': morse = 0061; break; /* -...-  */
+					case '.': morse = 0152; break; /* .-.-.- */
+					case '?': morse = 0114; break; /* ..--.. */
+					case ',': morse = 0163; break; /* --..-- */
+					case '-': morse = 0141; break; /* -....- */
+					case '\'':morse = 0136; break; /* .----. */
+					case '"': morse = 0122; break; /* .-..-. */
+					case ':': morse = 0107; break; /* ---... */
+					default : /* Space */
+								 next_jiffie += 4*DITLEN; /*For a total of 7*/
+				}
+			}
+			bufpos ++;
+			return;
+		}
+
+		if (morse & 001) {
+			if (blink_setting & 0x02)
+				kd_mksound(FREQ, DAHLEN);
+			next_jiffie = jiffies + DAHLEN;
+			do_blink(1);
+			state = 1;
+			morse >>= 1;
+			return;
+		} else {
+			if (blink_setting & 0x02)
+				kd_mksound(FREQ, DITLEN);
+			next_jiffie = jiffies + DITLEN;
+			do_blink(1);
+			state = 1;
+			morse >>= 1;
+			return;
+		}
+		/*impossible*/
 	}
 }  
 
@@ -1274,7 +1376,7 @@
 {
     int par;
     if (get_option(&str,&par)) 
-	    blink_frequency = par*(1000/HZ);
+	    blink_setting = par;
     return 1;
 }
 
diff -u -r linux.old/kernel/panic.c linux.new/kernel/panic.c
--- linux.old/kernel/panic.c	Fri Jul 19 18:56:36 2002
+++ linux.new/kernel/panic.c	Thu Jul 18 21:45:45 2002
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
