Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262610AbSJLBYC>; Fri, 11 Oct 2002 21:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262616AbSJLBYB>; Fri, 11 Oct 2002 21:24:01 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:55751 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262610AbSJLBXv>; Fri, 11 Oct 2002 21:23:51 -0400
Date: Fri, 11 Oct 2002 18:23:07 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [BK PATCH] console changes 2
Message-ID: <Pine.LNX.4.33.0210111821450.2595-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



console keyboard clean up. I'm preparing for when the global array of
struct kbd_struct will go away.

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.573.100.14, 2002-10-08 13:01:35-07:00, jsimmons@maxwell.earthlink.net
  Moved keyboard defines around and made code easier to read.Name change for console_init to con_init. Makes it clear it is for VTs.


 drivers/char/keyboard.c  |   57 ++++++++++++++---------------------------------
 drivers/char/tty_io.c    |    2 -
 drivers/char/vt.c        |   30 +++++-------------------
 drivers/char/vt_ioctl.c  |    6 ++--
 include/linux/kbd_kern.h |   28 ++++++++++++++---------
 include/linux/tty.h      |    6 ++++
 6 files changed, 52 insertions(+), 77 deletions(-)


diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Fri Oct 11 18:15:37 2002
+++ b/drivers/char/keyboard.c	Fri Oct 11 18:15:37 2002
@@ -44,30 +44,9 @@

 static void kbd_disconnect(struct input_handle *handle);
 extern void ctrl_alt_del(void);
-
-/*
- * Exported functions/variables
- */
-
-#ifndef KBD_DEFMODE
-#define KBD_DEFMODE ((1 << VC_REPEAT) | (1 << VC_META))
-#endif
-
-#ifndef KBD_DEFLEDS
-/*
- * Some laptops take the 789uiojklm,. keys as number pad when NumLock is on.
- * This seems a good reason to start with NumLock off.
- */
-#define KBD_DEFLEDS 0
-#endif
-
-#ifndef KBD_DEFLOCK
-#define KBD_DEFLOCK 0
-#endif
-
+void compute_shiftstate(void);
 struct pt_regs *kbd_pt_regs;
 EXPORT_SYMBOL(kbd_pt_regs);
-void compute_shiftstate(void);

 /*
  * Handler Tables.
@@ -418,7 +397,7 @@
 		diacr = 0;
 	}
 	put_queue(vc, 13);
-	if (vc_kbd_mode(kbd, VC_CRLF))
+	if (get_kbd_mode(kbd, VC_CRLF))
 		put_queue(vc, 10);
 }

@@ -426,14 +405,14 @@
 {
 	if (rep)
 		return;
-	chg_vc_kbd_led(kbd, VC_CAPSLOCK);
+	chg_kbd_led(kbd, VC_CAPSLOCK);
 }

 static void fn_caps_on(struct vc_data *vc)
 {
 	if (rep)
 		return;
-	set_vc_kbd_led(kbd, VC_CAPSLOCK);
+	set_kbd_led(kbd, VC_CAPSLOCK);
 }

 static void fn_show_ptregs(struct vc_data *vc)
@@ -462,7 +441,7 @@

 static void fn_num(struct vc_data *vc)
 {
-	if (vc_kbd_mode(kbd,VC_APPLIC))
+	if (get_kbd_mode(kbd,VC_APPLIC))
 		applkey(vc, 'P', 1);
 	else
 		fn_bare_num(vc);
@@ -477,7 +456,7 @@
 static void fn_bare_num(struct vc_data *vc)
 {
 	if (!rep)
-		chg_vc_kbd_led(kbd, VC_NUMLOCK);
+		chg_kbd_led(kbd, VC_NUMLOCK);
 }

 static void fn_lastcons(struct vc_data *vc)
@@ -664,7 +643,7 @@

 	if (up_flag)
 		return;
-	applkey(vc, cur_chars[value], vc_kbd_mode(kbd, VC_CKMODE));
+	applkey(vc, cur_chars[value], get_kbd_mode(kbd, VC_CKMODE));
 }

 static void k_pad(struct vc_data *vc, unsigned char value, char up_flag)
@@ -676,12 +655,12 @@
 		return;		/* no action, if this is a key release */

 	/* kludge... shift forces cursor/number keys */
-	if (vc_kbd_mode(kbd, VC_APPLIC) && !shift_down[KG_SHIFT]) {
+	if (get_kbd_mode(kbd, VC_APPLIC) && !shift_down[KG_SHIFT]) {
 		applkey(vc, app_map[value], 1);
 		return;
 	}

-	if (!vc_kbd_led(kbd, VC_NUMLOCK))
+	if (!get_kbd_led(kbd, VC_NUMLOCK))
 		switch (value) {
 			case KVAL(K_PCOMMA):
 			case KVAL(K_PDOT):
@@ -715,12 +694,12 @@
 				k_fn(vc, KVAL(K_PGUP), 0);
 				return;
 			case KVAL(K_P5):
-				applkey(vc, 'G', vc_kbd_mode(kbd, VC_APPLIC));
+				applkey(vc, 'G', get_kbd_mode(kbd, VC_APPLIC));
 				return;
 		}

 	put_queue(vc, pad_chars[value]);
-	if (value == KVAL(K_PENTER) && vc_kbd_mode(kbd, VC_CRLF))
+	if (value == KVAL(K_PENTER) && get_kbd_mode(kbd, VC_CRLF))
 		put_queue(vc, 10);
 }

@@ -737,7 +716,7 @@
 	if (value == KVAL(K_CAPSSHIFT)) {
 		value = KVAL(K_SHIFT);
 		if (!up_flag)
-			clr_vc_kbd_led(kbd, VC_CAPSLOCK);
+			clr_kbd_led(kbd, VC_CAPSLOCK);
 	}

 	if (up_flag) {
@@ -770,7 +749,7 @@
 	if (up_flag)
 		return;

-	if (vc_kbd_mode(kbd, VC_META)) {
+	if (get_kbd_mode(kbd, VC_META)) {
 		put_queue(vc, '\033');
 		put_queue(vc, value);
 	} else
@@ -803,7 +782,7 @@
 {
 	if (up_flag || rep)
 		return;
-	chg_vc_kbd_lock(kbd, value);
+	chg_kbd_lock(kbd, value);
 }

 static void k_slock(struct vc_data *vc, unsigned char value, char up_flag)
@@ -811,11 +790,11 @@
 	k_shift(vc, value, up_flag);
 	if (up_flag || rep)
 		return;
-	chg_vc_kbd_slock(kbd, value);
+	chg_kbd_slock(kbd, value);
 	/* try to make Alt, oops, AltGr and such work */
 	if (!key_maps[kbd->lockstate ^ kbd->slockstate]) {
 		kbd->slockstate = 0;
-		chg_vc_kbd_slock(kbd, value);
+		chg_kbd_slock(kbd, value);
 	}
 }

@@ -1060,7 +1039,7 @@
 	else
 		clear_bit(keycode, key_down);

-	if (rep && (!vc_kbd_mode(kbd, VC_REPEAT) || (tty &&
+	if (rep && (!get_kbd_mode(kbd, VC_REPEAT) || (tty &&
 		(!L_ECHO(tty) && tty->driver.chars_in_buffer(tty))))) {
 		/*
 		 * Don't repeat a key if the input buffers are not empty and the
@@ -1094,7 +1073,7 @@

 	if (type == KT_LETTER) {
 		type = KT_LATIN;
-		if (vc_kbd_led(kbd, VC_CAPSLOCK)) {
+		if (get_kbd_led(kbd, VC_CAPSLOCK)) {
 			key_map = key_maps[shift_final ^ (1 << KG_SHIFT)];
 			if (key_map)
 				keysym = key_map[keycode];
diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Fri Oct 11 18:15:37 2002
+++ b/drivers/char/tty_io.c	Fri Oct 11 18:15:37 2002
@@ -2190,7 +2190,7 @@
 	disable_early_printk();
 #endif
 #ifdef CONFIG_VT
-	con_init();
+	vt_console_init();
 #endif
 #ifdef CONFIG_AU1000_SERIAL_CONSOLE
 	au1000_serial_console_init();
diff -Nru a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c	Fri Oct 11 18:15:37 2002
+++ b/drivers/char/vt.c	Fri Oct 11 18:15:37 2002
@@ -150,7 +150,6 @@
 static void hide_cursor(int currcons);
 static void unblank_screen_t(unsigned long dummy);
 static void console_callback(void *ignored);
-static void __init con_init_devfs (void);

 static int printable;		/* Is console ready for printing? */

@@ -812,9 +811,9 @@
  *	VT102 emulator
  */

-#define set_kbd(x) set_vc_kbd_mode(kbd_table+currcons,x)
-#define clr_kbd(x) clr_vc_kbd_mode(kbd_table+currcons,x)
-#define is_kbd(x) vc_kbd_mode(kbd_table+currcons,x)
+#define set_kbd(x) set_kbd_mode(kbd_table+currcons,x)
+#define clr_kbd(x) clr_kbd_mode(kbd_table+currcons,x)
+#define is_kbd(x) get_kbd_mode(kbd_table+currcons,x)

 #define decarm		VC_REPEAT
 #define decckm		VC_CKMODE
@@ -2325,7 +2324,7 @@
 	console_num = minor(tty->device) - (tty->driver.minor_start);
 	if (!vc_cons_allocated(console_num))
 		return;
-	set_vc_kbd_led(kbd_table + console_num, VC_SCROLLOCK);
+	set_kbd_led(kbd_table + console_num, VC_SCROLLOCK);
 	set_leds();
 }

@@ -2340,7 +2339,7 @@
 	console_num = minor(tty->device) - (tty->driver.minor_start);
 	if (!vc_cons_allocated(console_num))
 		return;
-	clr_vc_kbd_led(kbd_table + console_num, VC_SCROLLOCK);
+	clr_kbd_led(kbd_table + console_num, VC_SCROLLOCK);
 	set_leds();
 }

@@ -2435,7 +2434,7 @@
 struct tty_driver console_driver;
 static int console_refcount;

-void __init con_init(void)
+void __init vt_console_init(void)
 {
 	const char *display_desc = NULL;
 	unsigned int currcons = 0;
@@ -2499,9 +2498,8 @@
 	console_driver.flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_RESET_TERMIOS;
 	/* Tell tty_register_driver() to skip consoles because they are
 	 * registered before kmalloc() is ready. We'll patch them in later.
-	 * See comments at console_init(); see also con_init_devfs().
+	 * See comments at console_init();
 	 */
-	console_driver.flags |= TTY_DRIVER_NO_DEVFS;
 	console_driver.refcount = &console_refcount;
 	console_driver.table = console_table;
 	console_driver.termios = console_termios;
@@ -2525,7 +2523,6 @@

 	kbd_init();
 	console_map_init();
-	con_init_devfs();
 	vcs_init();
 	return 0;
 }
@@ -2618,19 +2615,6 @@
     unsigned int mode;
     get_user(mode, argp);
     vesa_blank_mode = (mode < 4) ? mode : 0;
-}
-
-/* We can't register the console with devfs during con_init(), because it
- * is called before kmalloc() works.  This function is called later to
- * do the registration.
- */
-static void __init con_init_devfs (void)
-{
-	int i;
-
-	for (i = 0; i < console_driver.num; i++)
-		tty_register_devfs (&console_driver, DEVFS_FL_AOPEN_NOTIFY,
-				    console_driver.minor_start + i);
 }

 /*
diff -Nru a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
--- a/drivers/char/vt_ioctl.c	Fri Oct 11 18:15:37 2002
+++ b/drivers/char/vt_ioctl.c	Fri Oct 11 18:15:37 2002
@@ -527,10 +527,10 @@
 	case KDSKBMETA:
 		switch(arg) {
 		  case K_METABIT:
-			clr_vc_kbd_mode(kbd, VC_META);
+			clr_kbd_mode(kbd, VC_META);
 			break;
 		  case K_ESCPREFIX:
-			set_vc_kbd_mode(kbd, VC_META);
+			set_kbd_mode(kbd, VC_META);
 			break;
 		  default:
 			return -EINVAL;
@@ -538,7 +538,7 @@
 		return 0;

 	case KDGKBMETA:
-		ucval = (vc_kbd_mode(kbd, VC_META) ? K_ESCPREFIX : K_METABIT);
+		ucval = (get_kbd_mode(kbd, VC_META) ? K_ESCPREFIX : K_METABIT);
 	setint:
 		return put_user(ucval, (int *)arg);

diff -Nru a/include/linux/kbd_kern.h b/include/linux/kbd_kern.h
--- a/include/linux/kbd_kern.h	Fri Oct 11 18:15:37 2002
+++ b/include/linux/kbd_kern.h	Fri Oct 11 18:15:37 2002
@@ -14,6 +14,14 @@
 extern char *funcbufptr;
 extern int funcbufsize, funcbufleft;

+#define KBD_DEFMODE    ((1 << VC_REPEAT) | (1 << VC_META))
+/*
+ * Some laptops take the 789uiojklm,. keys as number pad when NumLock is on.
+ * This seems a good reason to start with NumLock off.
+ */
+#define KBD_DEFLEDS    0
+#define KBD_DEFLOCK    0
+
 /*
  * kbd->xxx contains the VC-local things (flag settings etc..)
  *
@@ -82,52 +90,52 @@
 	tasklet_schedule(&keyboard_tasklet);
 }

-static inline int vc_kbd_mode(struct kbd_struct * kbd, int flag)
+static inline int get_kbd_mode(struct kbd_struct * kbd, int flag)
 {
 	return ((kbd->modeflags >> flag) & 1);
 }

-static inline int vc_kbd_led(struct kbd_struct * kbd, int flag)
+static inline int get_kbd_led(struct kbd_struct * kbd, int flag)
 {
 	return ((kbd->ledflagstate >> flag) & 1);
 }

-static inline void set_vc_kbd_mode(struct kbd_struct * kbd, int flag)
+static inline void set_kbd_mode(struct kbd_struct * kbd, int flag)
 {
 	kbd->modeflags |= 1 << flag;
 }

-static inline void set_vc_kbd_led(struct kbd_struct * kbd, int flag)
+static inline void set_kbd_led(struct kbd_struct * kbd, int flag)
 {
 	kbd->ledflagstate |= 1 << flag;
 }

-static inline void clr_vc_kbd_mode(struct kbd_struct * kbd, int flag)
+static inline void clr_kbd_mode(struct kbd_struct * kbd, int flag)
 {
 	kbd->modeflags &= ~(1 << flag);
 }

-static inline void clr_vc_kbd_led(struct kbd_struct * kbd, int flag)
+static inline void clr_kbd_led(struct kbd_struct * kbd, int flag)
 {
 	kbd->ledflagstate &= ~(1 << flag);
 }

-static inline void chg_vc_kbd_lock(struct kbd_struct * kbd, int flag)
+static inline void chg_kbd_lock(struct kbd_struct * kbd, int flag)
 {
 	kbd->lockstate ^= 1 << flag;
 }

-static inline void chg_vc_kbd_slock(struct kbd_struct * kbd, int flag)
+static inline void chg_kbd_slock(struct kbd_struct * kbd, int flag)
 {
 	kbd->slockstate ^= 1 << flag;
 }

-static inline void chg_vc_kbd_mode(struct kbd_struct * kbd, int flag)
+static inline void chg_kbd_mode(struct kbd_struct * kbd, int flag)
 {
 	kbd->modeflags ^= 1 << flag;
 }

-static inline void chg_vc_kbd_led(struct kbd_struct * kbd, int flag)
+static inline void chg_kbd_led(struct kbd_struct * kbd, int flag)
 {
 	kbd->ledflagstate ^= 1 << flag;
 }
diff -Nru a/include/linux/tty.h b/include/linux/tty.h
--- a/include/linux/tty.h	Fri Oct 11 18:15:37 2002
+++ b/include/linux/tty.h	Fri Oct 11 18:15:37 2002
@@ -348,7 +348,6 @@

 extern int kmsg_redirect;

-extern void con_init(void);
 extern void console_init(void);

 extern int lp_init(void);
@@ -368,6 +367,7 @@
 extern int espserial_init(void);
 extern int macserial_init(void);
 extern int a2232board_init(void);
+extern void vt_console_init(void);

 extern int tty_paranoia_check(struct tty_struct *tty, kdev_t device,
 			      const char *routine);
@@ -418,6 +418,10 @@
 extern void console_print(const char *);

 /* vt.c */
+
+extern int vty_init(void);
+
+/* vt_ioctl.c */

 extern int vt_ioctl(struct tty_struct *tty, struct file * file,
 		    unsigned int cmd, unsigned long arg);

===================================================================


This BitKeeper patch contains the following changesets:
1.573.100.14
## Wrapped with gzip_uu ##


begin 664 bkpatch2413
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
F<SI_0F5`<\TM\//L_YC>F'GW^20^9:[N^`ZSE'\`J'JPTT0=````
`
end

