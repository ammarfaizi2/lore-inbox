Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318289AbSH0A0i>; Mon, 26 Aug 2002 20:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318302AbSH0A0i>; Mon, 26 Aug 2002 20:26:38 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:9347 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318289AbSH0A0f>;
	Mon, 26 Aug 2002 20:26:35 -0400
Date: Tue, 27 Aug 2002 02:30:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [patch] Fixed not keeping shifts over VT switch
Message-ID: <20020827023047.A27310@ucw.cz>
References: <20020827000636.B24577@ucw.cz> <Pine.LNX.4.33.0208261513370.2301-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0208261513370.2301-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Aug 26, 2002 at 03:14:56PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 03:14:56PM -0700, Linus Torvalds wrote:
> 
> More problems with the new code: it doesn't re-compute the modifier keys 
> on VT switch.
> 
> Test by holding down ALT, and pressing F1/F2/F3... to walk through the 
> VT's. After the first switch, it won't work any more, since the new VT 
> doesn't know that ALT is still depressed.

Fixed:

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.511, 2002-08-27 02:28:38+02:00, vojtech@suse.cz
  Fix bits that have fallen out when merging input-based keyboard.c
  into 2.5 - kbd0 init, sysrq support, show_regs, show_mem, show_state
  support, correct handling of shifts across vt switches, console
  blanking, console callback. Hope that's all.

 char/keyboard.c     |   77 +++++++++++++++++++++++++++++++++++++++++++++-------
 input/serio/i8042.c |    6 ++++
 2 files changed, 74 insertions(+), 9 deletions(-)

===================================================================

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Tue Aug 27 02:28:59 2002
+++ b/drivers/char/keyboard.c	Tue Aug 27 02:28:59 2002
@@ -40,7 +40,6 @@
 #include <linux/kbd_diacr.h>
 #include <linux/vt_kern.h>
 #include <linux/sysrq.h>
-#include <linux/pm.h>
 #include <linux/input.h>
 
 static void kbd_disconnect(struct input_handle *handle);
@@ -50,6 +49,22 @@
  * Exported functions/variables
  */
 
+#ifndef KBD_DEFMODE
+#define KBD_DEFMODE ((1 << VC_REPEAT) | (1 << VC_META))
+#endif
+
+#ifndef KBD_DEFLEDS
+/*
+ * Some laptops take the 789uiojklm,. keys as number pad when NumLock is on.
+ * This seems a good reason to start with NumLock off.
+ */
+#define KBD_DEFLEDS 0
+#endif
+
+#ifndef KBD_DEFLOCK
+#define KBD_DEFLOCK 0
+#endif
+
 struct pt_regs *kbd_pt_regs;
 void compute_shiftstate(void);
 
@@ -94,6 +109,7 @@
 
 struct kbd_struct kbd_table[MAX_NR_CONSOLES];
 static struct kbd_struct *kbd = kbd_table;
+static struct kbd_struct kbd0;
 
 int spawnpid, spawnsig;
 
@@ -124,6 +140,21 @@
 	unsigned char valid:1;
 } ledptrs[3];
 
+/* Simple translation table for the SysRq keys */
+
+#ifdef CONFIG_MAGIC_SYSRQ
+unsigned char kbd_sysrq_xlate[128] =
+        "\000\0331234567890-=\177\t"                    /* 0x00 - 0x0f */
+        "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
+        "dfghjkl;'`\000\\zxcv"                          /* 0x20 - 0x2f */
+        "bnm,./\000*\000 \000\201\202\203\204\205"      /* 0x30 - 0x3f */
+        "\206\207\210\211\212\000\000789-456+1"         /* 0x40 - 0x4f */
+        "230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\000" /* 0x50 - 0x5f */
+        "\r\000/";                                      /* 0x60 - 0x6f */
+static int sysrq_down;
+#endif
+static int sysrq_alt;
+
 /*
  * Translation of scancodes to keycodes. We set them on only the first attached
  * keyboard - for per-keyboard setting, /dev/input/event is more useful.
@@ -314,7 +345,7 @@
 		if (!key_down[i])
 			continue;
 
-		k = i*BITS_PER_LONG;
+		k = i * BITS_PER_LONG;
 
 		for (j = 0; j < BITS_PER_LONG; j++, k++) {
 
@@ -861,8 +892,6 @@
 
 #if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_ALPHA) || defined(CONFIG_MIPS) || defined(CONFIG_PPC)
 
-static int x86_sysrq_alt = 0;
-
 static unsigned short x86_keycodes[256] =
 	{ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
 	 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
@@ -902,7 +931,7 @@
 		return 0;
 	} 
 
-	if (keycode == KEY_SYSRQ && x86_sysrq_alt) {
+	if (keycode == KEY_SYSRQ && sysrq_alt) {
 		put_queue(vc, 0x54 | up_flag);
 		return 0;
 	}
@@ -917,9 +946,6 @@
 		put_queue(vc, 0x37 | up_flag);
 	}
 
-	if (keycode == KEY_LEFTALT || keycode == KEY_RIGHTALT)
-		x86_sysrq_alt = !up_flag;
-
 	return 0;
 }
 
@@ -957,10 +983,26 @@
 
 	kbd = kbd_table + fg_console;
 
+	if (keycode == KEY_LEFTALT || keycode == KEY_RIGHTALT)
+		sysrq_alt = down;
+
+	rep = (down == 2);
+
 	if ((raw_mode = (kbd->kbdmode == VC_RAW)))
 		if (emulate_raw(vc, keycode, !down << 7))
 			printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode %d\n", keycode);
 
+#ifdef CONFIG_MAGIC_SYSRQ	       /* Handle the SysRq Hack */
+	if (keycode == KEY_SYSRQ && !rep) {
+		sysrq_down = sysrq_alt && down;
+		return;
+	}
+	if (sysrq_down && down && !rep) {
+		handle_sysrq(kbd_sysrq_xlate[keycode], kbd_pt_regs, tty);
+		return;
+	}
+#endif
+
 	if (kbd->kbdmode == VC_MEDIUMRAW) {
 		/*
 		 * This is extended medium raw mode, with keys above 127
@@ -981,7 +1023,10 @@
 		raw_mode = 1;
 	}
 
-	rep = (down == 2);
+	if (down)
+		set_bit(keycode, key_down);
+	else
+		clear_bit(keycode, key_down);
 
 	if (rep && (!vc_kbd_mode(kbd, VC_REPEAT) || (tty && 
 		(!L_ECHO(tty) && tty->driver.chars_in_buffer(tty))))) {
@@ -1037,6 +1082,8 @@
 		return;
 	kbd_keycode(keycode, down);
 	tasklet_schedule(&keyboard_tasklet);
+	do_poke_blanked_console = 1;
+	schedule_console_callback();
 }
 
 static char kbd_name[] = "kbd";
@@ -1105,6 +1152,18 @@
 
 int __init kbd_init(void)
 {
+	int i;
+
+        kbd0.ledflagstate = kbd0.default_ledflagstate = KBD_DEFLEDS;
+        kbd0.ledmode = LED_SHOW_FLAGS;
+        kbd0.lockstate = KBD_DEFLOCK;
+        kbd0.slockstate = 0;
+        kbd0.modeflags = KBD_DEFMODE;
+        kbd0.kbdmode = VC_XLATE;
+
+        for (i = 0 ; i < MAX_NR_CONSOLES ; i++)
+                kbd_table[i] = kbd0;
+
 	tasklet_enable(&keyboard_tasklet);
 	tasklet_schedule(&keyboard_tasklet);
 	input_register_handler(&kbd_handler);
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Tue Aug 27 02:28:59 2002
+++ b/drivers/input/serio/i8042.c	Tue Aug 27 02:28:59 2002
@@ -61,6 +61,8 @@
 static unsigned long i8042_start;
 #endif
 
+extern struct pt_regs *kbd_pt_regs;
+
 static unsigned long i8042_unxlate_seen[128 / BITS_PER_LONG];
 static unsigned char i8042_unxlate_table[128] = {
 	  0,118, 22, 30, 38, 37, 46, 54, 61, 62, 70, 69, 78, 85,102, 13,
@@ -345,6 +347,10 @@
 	unsigned long flags;
 	unsigned char str, data;
 	unsigned int dfl;
+
+#ifdef CONFIG_VT
+	kbd_pt_regs = regs;
+#endif
 
 	spin_lock_irqsave(&i8042_lock, flags);
 

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch27294
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
2C*HN49G#BY;R+_A^>Z<0$0``
`
end

-- 
Vojtech Pavlik
SuSE Labs
