Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267072AbTBLKzV>; Wed, 12 Feb 2003 05:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267076AbTBLKzU>; Wed, 12 Feb 2003 05:55:20 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:18057 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267035AbTBLKxQ>;
	Wed, 12 Feb 2003 05:53:16 -0500
Date: Wed, 12 Feb 2003 12:02:42 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Get rid of kbd_pt_regs [5/14]
Message-ID: <20030212120242.D1563@ucw.cz>
References: <20030212115954.A1268@ucw.cz> <20030212120038.A1563@ucw.cz> <20030212120119.B1563@ucw.cz> <20030212120154.C1563@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030212120154.C1563@ucw.cz>; from vojtech@suse.cz on Wed, Feb 12, 2003 at 12:01:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1008, 2003-02-12 10:41:07+01:00, vojtech@suse.cz
  input: Get rid of the kbd_pt_regs variable, and instead pass the
  	value all the way from an interrupt handler to keyboard.c
  	that can display it.


 arch/sparc64/kernel/irq.c                      |    3 
 drivers/acorn/char/keyb_arc.c                  |    1 
 drivers/char/ec3104_keyb.c                     |    2 
 drivers/char/keyboard.c                        |  118 ++++++++++++-------------
 drivers/input/joystick/amijoy.c                |    2 
 drivers/input/joystick/iforce/iforce-packets.c |    5 -
 drivers/input/joystick/iforce/iforce-serio.c   |    4 
 drivers/input/joystick/iforce/iforce-usb.c     |   15 +--
 drivers/input/joystick/iforce/iforce.h         |    2 
 drivers/input/joystick/magellan.c              |    8 +
 drivers/input/joystick/spaceball.c             |    8 +
 drivers/input/joystick/spaceorb.c              |    8 +
 drivers/input/joystick/stinger.c               |    8 +
 drivers/input/joystick/twidjoy.c               |    8 +
 drivers/input/joystick/warrior.c               |   10 +-
 drivers/input/keyboard/amikbd.c                |    2 
 drivers/input/keyboard/atkbd.c                 |    3 
 drivers/input/keyboard/newtonkbd.c             |    8 +
 drivers/input/keyboard/sunkbd.c                |    3 
 drivers/input/keyboard/xtkbd.c                 |    3 
 drivers/input/misc/gsc_ps2.c                   |   13 +-
 drivers/input/mouse/amimouse.c                 |    2 
 drivers/input/mouse/inport.c                   |    2 
 drivers/input/mouse/logibm.c                   |    1 
 drivers/input/mouse/pc110pad.c                 |    1 
 drivers/input/mouse/psmouse.c                  |    8 +
 drivers/input/mouse/rpcmouse.c                 |    2 
 drivers/input/mouse/sermouse.c                 |   14 +-
 drivers/input/serio/ambakmi.c                  |    6 -
 drivers/input/serio/ct82c710.c                 |    2 
 drivers/input/serio/i8042.c                    |   16 +--
 drivers/input/serio/parkbd.c                   |    2 
 drivers/input/serio/q40kbd.c                   |    3 
 drivers/input/serio/rpckbd.c                   |    5 -
 drivers/input/serio/sa1111ps2.c                |    6 -
 drivers/input/serio/serio.c                    |    4 
 drivers/input/serio/serport.c                  |    5 -
 drivers/input/touchscreen/gunze.c              |    7 -
 drivers/input/touchscreen/h3600_ts_input.c     |    6 +
 drivers/macintosh/adbhid.c                     |   22 ++--
 drivers/serial/sunsu.c                         |    4 
 drivers/serial/sunzilog.c                      |    4 
 drivers/usb/input/aiptek.c                     |    2 
 drivers/usb/input/hid-core.c                   |   22 ++--
 drivers/usb/input/hid-input.c                  |    4 
 drivers/usb/input/hid.h                        |    4 
 drivers/usb/input/hiddev.c                     |    2 
 drivers/usb/input/powermate.c                  |    1 
 drivers/usb/input/usbkbd.c                     |    2 
 drivers/usb/input/usbmouse.c                   |    1 
 drivers/usb/input/wacom.c                      |    7 +
 drivers/usb/input/xpad.c                       |    6 -
 include/asm-sparc/system.h                     |    2 
 include/asm-sparc64/system.h                   |    2 
 include/linux/hiddev.h                         |    4 
 include/linux/input.h                          |    5 -
 include/linux/serio.h                          |   11 +-
 57 files changed, 242 insertions(+), 189 deletions(-)

===================================================================

diff -Nru a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
--- a/arch/sparc64/kernel/irq.c	Wed Feb 12 11:57:08 2003
+++ b/arch/sparc64/kernel/irq.c	Wed Feb 12 11:57:08 2003
@@ -740,9 +740,6 @@
 	irq_enter();
 	kstat_cpu(cpu).irqs[irq]++;
 
-	if (irq == 9)
-		kbd_pt_regs = regs;
-
 	/* Sliiiick... */
 #ifndef CONFIG_SMP
 	bp = ((irq != 0) ?
diff -Nru a/drivers/acorn/char/keyb_arc.c b/drivers/acorn/char/keyb_arc.c
--- a/drivers/acorn/char/keyb_arc.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/acorn/char/keyb_arc.c	Wed Feb 12 11:57:08 2003
@@ -406,7 +406,6 @@
 
 static void a5kkbd_rx(int irq, void *dev_id, struct pt_regs *regs)
 {
-	kbd_pt_regs = regs;
 	if (handle_rawcode(ioc_readb(IOC_KARTRX)))
 		tasklet_schedule(&keyboard_tasklet);
 }
diff -Nru a/drivers/char/ec3104_keyb.c b/drivers/char/ec3104_keyb.c
--- a/drivers/char/ec3104_keyb.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/char/ec3104_keyb.c	Wed Feb 12 11:57:08 2003
@@ -376,8 +376,6 @@
 	struct e5_struct *k = &ec3104_keyb;
 	u8 msr, lsr;
 
-	kbd_pt_regs = regs;
-
 	msr = ctrl_inb(EC3104_SER4_MSR);
 	
 	if ((msr & MSR_CTS) && !(k->last_msr & MSR_CTS)) {
diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/char/keyboard.c	Wed Feb 12 11:57:08 2003
@@ -64,8 +64,6 @@
 #define KBD_DEFLOCK 0
 #endif
 
-struct pt_regs *kbd_pt_regs;
-EXPORT_SYMBOL(kbd_pt_regs);
 void compute_shiftstate(void);
 
 /*
@@ -79,7 +77,7 @@
 	k_slock,	k_dead2,	k_ignore,	k_ignore
 
 typedef void (k_handler_fn)(struct vc_data *vc, unsigned char value, 
-			    char up_flag);
+			    char up_flag, struct pt_regs *regs);
 static k_handler_fn K_HANDLERS;
 static k_handler_fn *k_handler[16] = { K_HANDLERS };
 
@@ -90,7 +88,7 @@
 	fn_boot_it, 	fn_caps_on, 	fn_compose,	fn_SAK,\
 	fn_dec_console, fn_inc_console, fn_spawn_con, 	fn_bare_num
 
-typedef void (fn_handler_fn)(struct vc_data *vc);
+typedef void (fn_handler_fn)(struct vc_data *vc, struct pt_regs *regs);
 static fn_handler_fn FN_HANDLERS;
 static fn_handler_fn *fn_handler[] = { FN_HANDLERS };
 
@@ -422,7 +420,7 @@
 /*
  * Special function handlers
  */
-static void fn_enter(struct vc_data *vc)
+static void fn_enter(struct vc_data *vc, struct pt_regs *regs)
 {
 	if (diacr) {
 		put_queue(vc, diacr);
@@ -433,27 +431,27 @@
 		put_queue(vc, 10);
 }
 
-static void fn_caps_toggle(struct vc_data *vc)
+static void fn_caps_toggle(struct vc_data *vc, struct pt_regs *regs)
 {
 	if (rep)
 		return;
 	chg_vc_kbd_led(kbd, VC_CAPSLOCK);
 }
 
-static void fn_caps_on(struct vc_data *vc)
+static void fn_caps_on(struct vc_data *vc, struct pt_regs *regs)
 {
 	if (rep)
 		return;
 	set_vc_kbd_led(kbd, VC_CAPSLOCK);
 }
 
-static void fn_show_ptregs(struct vc_data *vc)
+static void fn_show_ptregs(struct vc_data *vc, struct pt_regs *regs)
 {
-	if (kbd_pt_regs)
-		show_regs(kbd_pt_regs);
+	if (regs)
+		show_regs(regs);
 }
 
-static void fn_hold(struct vc_data *vc)
+static void fn_hold(struct vc_data *vc, struct pt_regs *regs)
 {
 	struct tty_struct *tty = vc->vc_tty;
 
@@ -471,12 +469,12 @@
 		stop_tty(tty);
 }
 
-static void fn_num(struct vc_data *vc)
+static void fn_num(struct vc_data *vc, struct pt_regs *regs)
 {
 	if (vc_kbd_mode(kbd,VC_APPLIC))
 		applkey(vc, 'P', 1);
 	else
-		fn_bare_num(vc);
+		fn_bare_num(vc, regs);
 }
 
 /*
@@ -485,19 +483,19 @@
  * Bind this to NumLock if you prefer that the NumLock key always
  * changes the NumLock flag.
  */
-static void fn_bare_num(struct vc_data *vc)
+static void fn_bare_num(struct vc_data *vc, struct pt_regs *regs)
 {
 	if (!rep)
 		chg_vc_kbd_led(kbd, VC_NUMLOCK);
 }
 
-static void fn_lastcons(struct vc_data *vc)
+static void fn_lastcons(struct vc_data *vc, struct pt_regs *regs)
 {
 	/* switch to the last used console, ChN */
 	set_console(last_console);
 }
 
-static void fn_dec_console(struct vc_data *vc)
+static void fn_dec_console(struct vc_data *vc, struct pt_regs *regs)
 {
 	int i;
  
@@ -510,7 +508,7 @@
 	set_console(i);
 }
 
-static void fn_inc_console(struct vc_data *vc)
+static void fn_inc_console(struct vc_data *vc, struct pt_regs *regs)
 {
 	int i;
 
@@ -523,7 +521,7 @@
 	set_console(i);
 }
 
-static void fn_send_intr(struct vc_data *vc)
+static void fn_send_intr(struct vc_data *vc, struct pt_regs *regs)
 {
 	struct tty_struct *tty = vc->vc_tty;
 
@@ -533,44 +531,44 @@
 	con_schedule_flip(tty);
 }
 
-static void fn_scroll_forw(struct vc_data *vc)
+static void fn_scroll_forw(struct vc_data *vc, struct pt_regs *regs)
 {
 	scrollfront(0);
 }
 
-static void fn_scroll_back(struct vc_data *vc)
+static void fn_scroll_back(struct vc_data *vc, struct pt_regs *regs)
 {
 	scrollback(0);
 }
 
-static void fn_show_mem(struct vc_data *vc)
+static void fn_show_mem(struct vc_data *vc, struct pt_regs *regs)
 {
 	show_mem();
 }
 
-static void fn_show_state(struct vc_data *vc)
+static void fn_show_state(struct vc_data *vc, struct pt_regs *regs)
 {
 	show_state();
 }
 
-static void fn_boot_it(struct vc_data *vc)
+static void fn_boot_it(struct vc_data *vc, struct pt_regs *regs)
 {
 	ctrl_alt_del();
 }
 
-static void fn_compose(struct vc_data *vc)
+static void fn_compose(struct vc_data *vc, struct pt_regs *regs)
 {
 	dead_key_next = 1;
 }
 
-static void fn_spawn_con(struct vc_data *vc)
+static void fn_spawn_con(struct vc_data *vc, struct pt_regs *regs)
 {
         if (spawnpid)
 	   if(kill_proc(spawnpid, spawnsig, 1))
 	     spawnpid = 0;
 }
 
-static void fn_SAK(struct vc_data *vc)
+static void fn_SAK(struct vc_data *vc, struct pt_regs *regs)
 {
 	struct tty_struct *tty = vc->vc_tty;
 
@@ -583,7 +581,7 @@
 	reset_vc(fg_console);
 }
 
-static void fn_null(struct vc_data *vc)
+static void fn_null(struct vc_data *vc, struct pt_regs *regs)
 {
 	compute_shiftstate();
 }
@@ -591,11 +589,11 @@
 /*
  * Special key handlers
  */
-static void k_ignore(struct vc_data *vc, unsigned char value, char up_flag)
+static void k_ignore(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
 }
 
-static void k_spec(struct vc_data *vc, unsigned char value, char up_flag)
+static void k_spec(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
 	if (up_flag)
 		return;
@@ -605,15 +603,15 @@
 	     kbd->kbdmode == VC_MEDIUMRAW) && 
 	     value != K_SAK)
 		return;		/* SAK is allowed even in raw mode */
-	fn_handler[value](vc);
+	fn_handler[value](vc, regs);
 }
 
-static void k_lowercase(struct vc_data *vc, unsigned char value, char up_flag)
+static void k_lowercase(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
 	printk(KERN_ERR "keyboard.c: k_lowercase was called - impossible\n");
 }
 
-static void k_self(struct vc_data *vc, unsigned char value, char up_flag)
+static void k_self(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
 	if (up_flag)
 		return;		/* no action, if this is a key release */
@@ -634,7 +632,7 @@
  * dead keys modifying the same character. Very useful
  * for Vietnamese.
  */
-static void k_dead2(struct vc_data *vc, unsigned char value, char up_flag)
+static void k_dead2(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
 	if (up_flag)
 		return;
@@ -644,21 +642,21 @@
 /*
  * Obsolete - for backwards compatibility only
  */
-static void k_dead(struct vc_data *vc, unsigned char value, char up_flag)
+static void k_dead(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
 	static unsigned char ret_diacr[NR_DEAD] = {'`', '\'', '^', '~', '"', ',' };
 	value = ret_diacr[value];
-	k_dead2(vc, value, up_flag);
+	k_dead2(vc, value, up_flag, regs);
 }
 
-static void k_cons(struct vc_data *vc, unsigned char value, char up_flag)
+static void k_cons(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
 	if (up_flag)
 		return;
 	set_console(value);
 }
 
-static void k_fn(struct vc_data *vc, unsigned char value, char up_flag)
+static void k_fn(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
 	if (up_flag)
 		return;
@@ -669,7 +667,7 @@
 		printk(KERN_ERR "k_fn called with value=%d\n", value);
 }
 
-static void k_cur(struct vc_data *vc, unsigned char value, char up_flag)
+static void k_cur(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
 	static const char *cur_chars = "BDCA";
 
@@ -678,7 +676,7 @@
 	applkey(vc, cur_chars[value], vc_kbd_mode(kbd, VC_CKMODE));
 }
 
-static void k_pad(struct vc_data *vc, unsigned char value, char up_flag)
+static void k_pad(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
 	static const char *pad_chars = "0123456789+-*/\015,.?()#";
 	static const char *app_map = "pqrstuvwxylSRQMnnmPQS";
@@ -696,34 +694,34 @@
 		switch (value) {
 			case KVAL(K_PCOMMA):
 			case KVAL(K_PDOT):
-				k_fn(vc, KVAL(K_REMOVE), 0);
+				k_fn(vc, KVAL(K_REMOVE), 0, regs);
 				return;
 			case KVAL(K_P0):
-				k_fn(vc, KVAL(K_INSERT), 0);
+				k_fn(vc, KVAL(K_INSERT), 0, regs);
 				return;
 			case KVAL(K_P1):
-				k_fn(vc, KVAL(K_SELECT), 0);
+				k_fn(vc, KVAL(K_SELECT), 0, regs);
 				return;
 			case KVAL(K_P2):
-				k_cur(vc, KVAL(K_DOWN), 0);
+				k_cur(vc, KVAL(K_DOWN), 0, regs);
 				return;
 			case KVAL(K_P3):
-				k_fn(vc, KVAL(K_PGDN), 0);
+				k_fn(vc, KVAL(K_PGDN), 0, regs);
 				return;
 			case KVAL(K_P4):
-				k_cur(vc, KVAL(K_LEFT), 0);
+				k_cur(vc, KVAL(K_LEFT), 0, regs);
 				return;
 			case KVAL(K_P6):
-				k_cur(vc, KVAL(K_RIGHT), 0);
+				k_cur(vc, KVAL(K_RIGHT), 0, regs);
 				return;
 			case KVAL(K_P7):
-				k_fn(vc, KVAL(K_FIND), 0);
+				k_fn(vc, KVAL(K_FIND), 0, regs);
 				return;
 			case KVAL(K_P8):
-				k_cur(vc, KVAL(K_UP), 0);
+				k_cur(vc, KVAL(K_UP), 0, regs);
 				return;
 			case KVAL(K_P9):
-				k_fn(vc, KVAL(K_PGUP), 0);
+				k_fn(vc, KVAL(K_PGUP), 0, regs);
 				return;
 			case KVAL(K_P5):
 				applkey(vc, 'G', vc_kbd_mode(kbd, VC_APPLIC));
@@ -735,7 +733,7 @@
 		put_queue(vc, 10);
 }
 
-static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
+static void k_shift(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
 	int old_state = shift_state;
 
@@ -776,7 +774,7 @@
 	}
 }
 
-static void k_meta(struct vc_data *vc, unsigned char value, char up_flag)
+static void k_meta(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
 	if (up_flag)
 		return;
@@ -788,7 +786,7 @@
 		put_queue(vc, value | 0x80);
 }
 
-static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
+static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
 	int base;
 
@@ -810,16 +808,16 @@
 		npadch = npadch * base + value;
 }
 
-static void k_lock(struct vc_data *vc, unsigned char value, char up_flag)
+static void k_lock(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
 	if (up_flag || rep)
 		return;
 	chg_vc_kbd_lock(kbd, value);
 }
 
-static void k_slock(struct vc_data *vc, unsigned char value, char up_flag)
+static void k_slock(struct vc_data *vc, unsigned char value, char up_flag, struct pt_regs *regs)
 {
-	k_shift(vc, value, up_flag);
+	k_shift(vc, value, up_flag, regs);
 	if (up_flag || rep)
 		return;
 	chg_vc_kbd_slock(kbd, value);
@@ -910,6 +908,7 @@
 			input_event(handle->dev, EV_LED, LED_SCROLLL, !!(leds & 0x01));
 			input_event(handle->dev, EV_LED, LED_NUML,    !!(leds & 0x02));
 			input_event(handle->dev, EV_LED, LED_CAPSL,   !!(leds & 0x04));
+			input_sync(handle->dev);
 		}
 	}
 
@@ -930,6 +929,7 @@
 		input_event(handle->dev, EV_LED, LED_SCROLLL, !!(leds & 0x01));
 		input_event(handle->dev, EV_LED, LED_NUML,    !!(leds & 0x02));
 		input_event(handle->dev, EV_LED, LED_CAPSL,   !!(leds & 0x04));
+		input_sync(handle->dev);
 	}
 	tasklet_enable(&keyboard_tasklet);
 }
@@ -1012,7 +1012,7 @@
 }
 #endif
 
-void kbd_keycode(unsigned int keycode, int down)
+void kbd_keycode(unsigned int keycode, int down, struct pt_regs *regs)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
 	unsigned short keysym, *key_map;
@@ -1052,7 +1052,7 @@
 		return;
 	}
 	if (sysrq_down && down && !rep) {
-		handle_sysrq(kbd_sysrq_xlate[keycode], kbd_pt_regs, tty);
+		handle_sysrq(kbd_sysrq_xlate[keycode], regs, tty);
 		return;
 	}
 #endif
@@ -1129,7 +1129,7 @@
 		}
 	}
 
-	(*k_handler[type])(vc, keysym & 0xff, !down);
+	(*k_handler[type])(vc, keysym & 0xff, !down, regs);
 
 	if (type != KT_SLOCK)
 		kbd->slockstate = 0;
@@ -1140,7 +1140,7 @@
 {
 	if (event_type != EV_KEY)
 		return;
-	kbd_keycode(keycode, down);
+	kbd_keycode(keycode, down, handle->dev->regs);
 	tasklet_schedule(&keyboard_tasklet);
 	do_poke_blanked_console = 1;
 	schedule_console_callback();
diff -Nru a/drivers/input/joystick/amijoy.c b/drivers/input/joystick/amijoy.c
--- a/drivers/input/joystick/amijoy.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/joystick/amijoy.c	Wed Feb 12 11:57:08 2003
@@ -64,6 +64,8 @@
 				case 1: data = ~custom.joy1dat; button = (~ciaa.pra >> 7) & 1; break;
 			}
 
+			input_regs(amijoy_dev + i, fp);
+
 			input_report_key(amijoy_dev + i, BTN_TRIGGER, button);
 
 			input_report_abs(amijoy_dev + i, ABS_X, ((data >> 1) & 1) - ((data >> 9) & 1));
diff -Nru a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
--- a/drivers/input/joystick/iforce/iforce-packets.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/joystick/iforce/iforce-packets.c	Wed Feb 12 11:57:08 2003
@@ -151,7 +151,7 @@
 	return -1;
 }
 
-void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
+void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data, struct pt_regs *regs)
 {
 	struct input_dev *dev = &iforce->dev;
 	int i;
@@ -181,6 +181,8 @@
 		case 0x01:	/* joystick position data */
 		case 0x03:	/* wheel position data */
 
+			input_regs(dev, regs);
+
 			if (HI(cmd) == 1) {
 				input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
 				input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
@@ -219,6 +221,7 @@
 			break;
 
 		case 0x02:	/* status report */
+			input_regs(dev, regs);
 			input_report_key(dev, BTN_DEAD, data[0] & 0x02);
 			input_sync(dev);
 
diff -Nru a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
--- a/drivers/input/joystick/iforce/iforce-serio.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/joystick/iforce/iforce-serio.c	Wed Feb 12 11:57:08 2003
@@ -78,7 +78,7 @@
 	iforce_serial_xmit((struct iforce *)serio->private);
 }
 
-static void iforce_serio_irq(struct serio *serio, unsigned char data, unsigned int flags)
+static void iforce_serio_irq(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct iforce* iforce = serio->private;
 
@@ -115,7 +115,7 @@
 	}
 
 	if (iforce->idx == iforce->len) {
-		iforce_process_packet(iforce, (iforce->id << 8) | iforce->idx, iforce->data);
+		iforce_process_packet(iforce, (iforce->id << 8) | iforce->idx, iforce->data, regs);
 		iforce->pkt = 0;
 		iforce->id  = 0;
 		iforce->len = 0;
diff -Nru a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
--- a/drivers/input/joystick/iforce/iforce-usb.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/joystick/iforce/iforce-usb.c	Wed Feb 12 11:57:08 2003
@@ -74,7 +74,7 @@
 	spin_unlock_irqrestore(&iforce->xmit_lock, flags);
 }
 
-static void iforce_usb_irq(struct urb *urb)
+static void iforce_usb_irq(struct urb *urb, struct pt_regs *regs)
 {
 	struct iforce *iforce = urb->context;
 	int status;
@@ -96,7 +96,7 @@
 	}
 
 	iforce_process_packet(iforce,
-		(iforce->data[0] << 8) | (urb->actual_length - 1), iforce->data + 1);
+		(iforce->data[0] << 8) | (urb->actual_length - 1), iforce->data + 1, regs);
 
 exit:
 	status = usb_submit_urb (urb, GFP_ATOMIC);
@@ -105,7 +105,7 @@
 		     __FUNCTION__, status);
 }
 
-static void iforce_usb_out(struct urb *urb)
+static void iforce_usb_out(struct urb *urb, struct pt_regs *regs)
 {
 	struct iforce *iforce = urb->context;
 
@@ -120,7 +120,7 @@
 		wake_up(&iforce->wait);
 }
 
-static void iforce_usb_ctrl(struct urb *urb)
+static void iforce_usb_ctrl(struct urb *urb, struct pt_regs *regs)
 {
 	struct iforce *iforce = urb->context;
 	if (urb->status) return;
@@ -133,11 +133,14 @@
 				const struct usb_device_id *id)
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
+	struct usb_host_interface *interface;
 	struct usb_endpoint_descriptor *epirq, *epout;
 	struct iforce *iforce;
 
-	epirq = intf->altsetting[0].endpoint + 0;
-	epout = intf->altsetting[0].endpoint + 1;
+	interface = &intf->altsetting[intf->act_altsetting];
+
+	epirq = &interface->endpoint[0].desc;
+	epout = &interface->endpoint[1].desc;
 
 	if (!(iforce = kmalloc(sizeof(struct iforce) + 32, GFP_KERNEL)))
 		goto fail;
diff -Nru a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
--- a/drivers/input/joystick/iforce/iforce.h	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/joystick/iforce/iforce.h	Wed Feb 12 11:57:08 2003
@@ -176,7 +176,7 @@
 
 /* iforce-packets.c */
 int iforce_control_playback(struct iforce*, u16 id, unsigned int);
-void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data);
+void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data, struct pt_regs *regs);
 int iforce_send_packet(struct iforce *iforce, u16 cmd, unsigned char* data);
 void iforce_dump_packet(char *msg, u16 cmd, unsigned char *data) ;
 int iforce_get_id_packet(struct iforce *iforce, char *packet);
diff -Nru a/drivers/input/joystick/magellan.c b/drivers/input/joystick/magellan.c
--- a/drivers/input/joystick/magellan.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/joystick/magellan.c	Wed Feb 12 11:57:08 2003
@@ -81,7 +81,7 @@
 	return 0;
 }
 
-static void magellan_process_packet(struct magellan* magellan)
+static void magellan_process_packet(struct magellan* magellan, struct pt_regs *regs)
 {
 	struct input_dev *dev = &magellan->dev;
 	unsigned char *data = magellan->data;
@@ -89,6 +89,8 @@
 
 	if (!magellan->idx) return;
 
+	input_regs(dev, regs);
+
 	switch (magellan->data[0]) {
 
 		case 'd':				/* Axis data */
@@ -111,12 +113,12 @@
 	input_sync(dev);
 }
 
-static void magellan_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+static void magellan_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct magellan* magellan = serio->private;
 
 	if (data == '\r') {
-		magellan_process_packet(magellan);
+		magellan_process_packet(magellan, regs);
 		magellan->idx = 0;
 	} else {
 		if (magellan->idx < MAGELLAN_MAX_LENGTH)
diff -Nru a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
--- a/drivers/input/joystick/spaceball.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/joystick/spaceball.c	Wed Feb 12 11:57:08 2003
@@ -81,7 +81,7 @@
  * SpaceBall.
  */
 
-static void spaceball_process_packet(struct spaceball* spaceball)
+static void spaceball_process_packet(struct spaceball* spaceball, struct pt_regs *regs)
 {
 	struct input_dev *dev = &spaceball->dev;
 	unsigned char *data = spaceball->data;
@@ -89,6 +89,8 @@
 
 	if (spaceball->idx < 2) return;
 
+	input_regs(dev, regs);
+
 	switch (spaceball->data[0]) {
 
 		case 'D':					/* Ball data */
@@ -147,13 +149,13 @@
  * can occur in the axis values.
  */
 
-static void spaceball_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+static void spaceball_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct spaceball *spaceball = serio->private;
 
 	switch (data) {
 		case 0xd:
-			spaceball_process_packet(spaceball);
+			spaceball_process_packet(spaceball, regs);
 			spaceball->idx = 0;
 			spaceball->escape = 0;
 			return;
diff -Nru a/drivers/input/joystick/spaceorb.c b/drivers/input/joystick/spaceorb.c
--- a/drivers/input/joystick/spaceorb.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/joystick/spaceorb.c	Wed Feb 12 11:57:08 2003
@@ -74,7 +74,7 @@
  * SpaceOrb.
  */
 
-static void spaceorb_process_packet(struct spaceorb *spaceorb)
+static void spaceorb_process_packet(struct spaceorb *spaceorb, struct pt_regs *regs)
 {
 	struct input_dev *dev = &spaceorb->dev;
 	unsigned char *data = spaceorb->data;
@@ -86,6 +86,8 @@
 	for (i = 0; i < spaceorb->idx; i++) c ^= data[i];
 	if (c) return;
 
+	input_regs(dev, regs);
+
 	switch (data[0]) {
 
 		case 'R':				/* Reset packet */
@@ -128,12 +130,12 @@
 	input_sync(dev);
 }
 
-static void spaceorb_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+static void spaceorb_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct spaceorb* spaceorb = serio->private;
 
 	if (~data & 0x80) {
-		if (spaceorb->idx) spaceorb_process_packet(spaceorb);
+		if (spaceorb->idx) spaceorb_process_packet(spaceorb, regs);
 		spaceorb->idx = 0;
 	}
 	if (spaceorb->idx < SPACEORB_MAX_LENGTH)
diff -Nru a/drivers/input/joystick/stinger.c b/drivers/input/joystick/stinger.c
--- a/drivers/input/joystick/stinger.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/joystick/stinger.c	Wed Feb 12 11:57:08 2003
@@ -64,13 +64,15 @@
  * Stinger. It updates the data accordingly.
  */
 
-static void stinger_process_packet(struct stinger *stinger)
+static void stinger_process_packet(struct stinger *stinger, struct pt_regs *regs)
 {
 	struct input_dev *dev = &stinger->dev;
 	unsigned char *data = stinger->data;
 
 	if (!stinger->idx) return;
 
+	input_regs(dev, regs);
+
 	input_report_key(dev, BTN_A,	  ((data[0] & 0x20) >> 5));
 	input_report_key(dev, BTN_B,	  ((data[0] & 0x10) >> 4));
 	input_report_key(dev, BTN_C,	  ((data[0] & 0x08) >> 3));
@@ -96,7 +98,7 @@
  * packet processing routine.
  */
 
-static void stinger_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+static void stinger_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct stinger* stinger = serio->private;
 
@@ -106,7 +108,7 @@
 		stinger->data[stinger->idx++] = data;
 
 	if (stinger->idx == 4) {
-		stinger_process_packet(stinger);
+		stinger_process_packet(stinger, regs);
 		stinger->idx = 0;
 	}
 
diff -Nru a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
--- a/drivers/input/joystick/twidjoy.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/joystick/twidjoy.c	Wed Feb 12 11:57:08 2003
@@ -101,7 +101,7 @@
  * Twiddler. It updates the data accordingly.
  */
 
-static void twidjoy_process_packet(struct twidjoy *twidjoy)
+static void twidjoy_process_packet(struct twidjoy *twidjoy, struct pt_regs *regs)
 {
 	if (twidjoy->idx == TWIDJOY_MAX_LENGTH) {
 		struct input_dev *dev = &twidjoy->dev;
@@ -111,6 +111,8 @@
 
 		button_bits = ((data[1] & 0x7f) << 7) | (data[0] & 0x7f);
 
+		input_regs(dev, regs);
+
 		for (bp = twidjoy_buttons; bp->bitmask; bp++) {
 			int value = (button_bits & (bp->bitmask << bp->bitshift)) >> bp->bitshift;
 			int i;
@@ -140,7 +142,7 @@
  * packet processing routine.
  */
 
-static void twidjoy_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+static void twidjoy_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struc pt_regs *regs)
 {
 	struct twidjoy *twidjoy = serio->private;
 
@@ -157,7 +159,7 @@
 		twidjoy->data[twidjoy->idx++] = data;
 
 	if (twidjoy->idx == TWIDJOY_MAX_LENGTH) {
-		twidjoy_process_packet(twidjoy);
+		twidjoy_process_packet(twidjoy, regs);
 		twidjoy->idx = 0;
 	}
 
diff -Nru a/drivers/input/joystick/warrior.c b/drivers/input/joystick/warrior.c
--- a/drivers/input/joystick/warrior.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/joystick/warrior.c	Wed Feb 12 11:57:08 2003
@@ -63,13 +63,15 @@
  * Warrior. It updates the data accordingly.
  */
 
-static void warrior_process_packet(struct warrior *warrior)
+static void warrior_process_packet(struct warrior *warrior, struct pt_regs *regs)
 {
 	struct input_dev *dev = &warrior->dev;
 	unsigned char *data = warrior->data;
 
 	if (!warrior->idx) return;
 
+	input_regs(dev, regs);
+
 	switch ((data[0] >> 4) & 7) {
 		case 1:					/* Button data */
 			input_report_key(dev, BTN_TRIGGER,  data[3]       & 1);
@@ -97,12 +99,12 @@
  * packet processing routine.
  */
 
-static void warrior_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+static void warrior_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct warrior* warrior = serio->private;
 
 	if (data & 0x80) {
-		if (warrior->idx) warrior_process_packet(warrior);
+		if (warrior->idx) warrior_process_packet(warrior, regs);
 		warrior->idx = 0;
 		warrior->len = warrior_lengths[(data >> 4) & 7];
 	}
@@ -111,7 +113,7 @@
 		warrior->data[warrior->idx++] = data;
 
 	if (warrior->idx == warrior->len) {
-		if (warrior->idx) warrior_process_packet(warrior);	
+		if (warrior->idx) warrior_process_packet(warrior, regs);	
 		warrior->idx = 0;
 		warrior->len = 0;
 	}
diff -Nru a/drivers/input/keyboard/amikbd.c b/drivers/input/keyboard/amikbd.c
--- a/drivers/input/keyboard/amikbd.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/keyboard/amikbd.c	Wed Feb 12 11:57:08 2003
@@ -87,6 +87,8 @@
 
 		scancode = amikbd_keycode[scancode];
 
+		input_regs(&amikbd_dev, fp);
+
 		if (scancode == KEY_CAPSLOCK) {	/* CapsLock is a toggle switch key on Amiga */
 			input_report_key(&amikbd_dev, scancode, 1);
 			input_report_key(&amikbd_dev, scancode, 0);
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/keyboard/atkbd.c	Wed Feb 12 11:57:08 2003
@@ -132,7 +132,7 @@
  * the keyboard into events.
  */
 
-static void atkbd_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+static void atkbd_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct atkbd *atkbd = serio->private;
 	int code = data;
@@ -193,6 +193,7 @@
 				atkbd->set, code, serio->phys, atkbd->release ? "released" : "pressed");
 			break;
 		default:
+			input_regs(&atkbd->dev, regs);
 			input_report_key(&atkbd->dev, atkbd->keycode[code], !atkbd->release);
 			input_sync(&atkbd->dev);
 	}
diff -Nru a/drivers/input/keyboard/newtonkbd.c b/drivers/input/keyboard/newtonkbd.c
--- a/drivers/input/keyboard/newtonkbd.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/keyboard/newtonkbd.c	Wed Feb 12 11:57:08 2003
@@ -62,18 +62,20 @@
 	char phys[32];
 };
 
-void nkbd_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+void nkbd_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct nkbd *nkbd = serio->private;
 
 	/* invalid scan codes are probably the init sequence, so we ignore them */
-	if (nkbd->keycode[data & NKBD_KEY])
+	if (nkbd->keycode[data & NKBD_KEY]) {
+		input_regs(&nkbd->dev, regs);
 		input_report_key(&nkbd->dev, nkbd->keycode[data & NKBD_KEY], data & NKBD_PRESS);
+		input_sync(&nkbd->dev);
+	}
 
 	else if (data == 0xe7) /* end of init sequence */
 		printk(KERN_INFO "input: %s on %s\n", nkbd_name, serio->phys);
 
-	input_sync(&nkbd->dev);
 }
 
 void nkbd_connect(struct serio *serio, struct serio_dev *dev)
diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
--- a/drivers/input/keyboard/sunkbd.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/keyboard/sunkbd.c	Wed Feb 12 11:57:08 2003
@@ -89,7 +89,7 @@
  * is received.
  */
 
-static void sunkbd_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+static void sunkbd_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct sunkbd* sunkbd = serio->private;
 
@@ -119,6 +119,7 @@
 
 		default:
 			if (sunkbd->keycode[data & SUNKBD_KEY]) {
+				input_regs(&sunkbd->dev, regs);
                                 input_report_key(&sunkbd->dev, sunkbd->keycode[data & SUNKBD_KEY], !(data & SUNKBD_RELEASE));
 				input_sync(&sunkbd->dev);
                         } else {
diff -Nru a/drivers/input/keyboard/xtkbd.c b/drivers/input/keyboard/xtkbd.c
--- a/drivers/input/keyboard/xtkbd.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/keyboard/xtkbd.c	Wed Feb 12 11:57:08 2003
@@ -63,7 +63,7 @@
 	char phys[32];
 };
 
-void xtkbd_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+void xtkbd_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct xtkbd *xtkbd = serio->private;
 
@@ -74,6 +74,7 @@
 		default:
 
 			if (xtkbd->keycode[data & XTKBD_KEY]) {
+				input_regs(&xtkbd->dev, regs);
 				input_report_key(&xtkbd->dev, xtkbd->keycode[data & XTKBD_KEY], !(data & XTKBD_RELEASE));
 				input_sync(&xtkbd->dev);
 			} else {
diff -Nru a/drivers/input/misc/gsc_ps2.c b/drivers/input/misc/gsc_ps2.c
--- a/drivers/input/misc/gsc_ps2.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/misc/gsc_ps2.c	Wed Feb 12 11:57:08 2003
@@ -305,7 +305,7 @@
  * Receives a keyboard scancode, analyses it and sends it to the input layer.
  */
 
-static void gscps2_kbd_docode(void)
+static void gscps2_kbd_docode(struct pt_regs *regs)
 {
 	int scancode = gscps2_readb_input(hpkeyb.addr);
 	DPRINTK("rel=%d scancode=%d, esc=%d ", hpkeyb.released, scancode, hpkeyb.escaped);
@@ -341,6 +341,7 @@
 		default:
 			hpkeyb.scancode = scancode;
 			DPRINTK("sent=%d, rel=%d\n",hpkeyb.scancode, hpkeyb.released);
+			input_regs(regs);
 			input_report_key(&hpkeyb.dev, hpkeyb_keycode[hpkeyb.scancode], !hpkeyb.released);
 			input_sync(&hpkeyb.dev);
 			if (hpkeyb.escaped)
@@ -359,7 +360,7 @@
  * correct events to the input layer.
  */
 
-static void gscps2_mouse_docode(void)
+static void gscps2_mouse_docode(struct pt_regs *regs)
 {
 	int xrel, yrel;
 
@@ -368,7 +369,7 @@
 		hpmouse.nbread--;
 
 	/* stolen from psmouse.c */
-	if (hpmouse.nbread && time_after(jiffies, hpmouse.last + HZ/20)) {
+	if (hpmouse.nbread && time_after(jiffies, hpmouse.last + HZ/2)) {
 		printk(KERN_DEBUG "%s:%d : Lost mouse synchronization, throwing %d bytes away.\n", __FILE__, __LINE__,
 				hpmouse.nbread);
 		hpmouse.nbread = 0;
@@ -387,6 +388,8 @@
 		if ((hpmouse.bytes[PACKET_CTRL] & (MOUSE_XOVFLOW | MOUSE_YOVFLOW)))
 			DPRINTK("Mouse: position overflow\n");
 		
+		input_regs(regs);
+
 		input_report_key(&hpmouse.dev, BTN_LEFT, hpmouse.bytes[PACKET_CTRL] & MOUSE_LEFTBTN);
 		input_report_key(&hpmouse.dev, BTN_MIDDLE, hpmouse.bytes[PACKET_CTRL] & MOUSE_MIDBTN);
 		input_report_key(&hpmouse.dev, BTN_RIGHT, hpmouse.bytes[PACKET_CTRL] & MOUSE_RIGHTBTN);
@@ -421,11 +424,11 @@
 {
 	/* process mouse actions */
 	while (gscps2_readb_status(hpmouse.addr) & GSC_STAT_RBNE)
-		gscps2_mouse_docode();
+		gscps2_mouse_docode(reg);
 	
 	/* process keyboard scancode */
 	while (gscps2_readb_status(hpkeyb.addr) & GSC_STAT_RBNE)
-		gscps2_kbd_docode();
+		gscps2_kbd_docode(reg);
 }
 
 
diff -Nru a/drivers/input/mouse/amimouse.c b/drivers/input/mouse/amimouse.c
--- a/drivers/input/mouse/amimouse.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/mouse/amimouse.c	Wed Feb 12 11:57:08 2003
@@ -63,6 +63,8 @@
 
 	potgor = custom.potgor;
 
+	input_regs(&amimouse_dev, fp);
+
 	input_report_rel(&amimouse_dev, REL_X, dx);
 	input_report_rel(&amimouse_dev, REL_Y, dy);
 
diff -Nru a/drivers/input/mouse/inport.c b/drivers/input/mouse/inport.c
--- a/drivers/input/mouse/inport.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/mouse/inport.c	Wed Feb 12 11:57:08 2003
@@ -131,6 +131,8 @@
 	outb(INPORT_REG_MODE, INPORT_CONTROL_PORT);
 	outb(INPORT_MODE_HOLD | INPORT_MODE_IRQ | INPORT_MODE_BASE, INPORT_DATA_PORT);
 
+	input_regs(&inport_dev, regs);
+
 	outb(INPORT_REG_X, INPORT_CONTROL_PORT);
 	input_report_rel(&inport_dev, REL_X, inb(INPORT_DATA_PORT));
 
diff -Nru a/drivers/input/mouse/logibm.c b/drivers/input/mouse/logibm.c
--- a/drivers/input/mouse/logibm.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/mouse/logibm.c	Wed Feb 12 11:57:08 2003
@@ -130,6 +130,7 @@
 	dy |= (buttons & 0xf) << 4;
 	buttons = ~buttons >> 5;
 
+	input_regs(&logibm_dev, regs);
 	input_report_rel(&logibm_dev, REL_X, dx);
 	input_report_rel(&logibm_dev, REL_Y, dy);
 	input_report_key(&logibm_dev, BTN_RIGHT,  buttons & 1);
diff -Nru a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
--- a/drivers/input/mouse/pc110pad.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/mouse/pc110pad.c	Wed Feb 12 11:57:08 2003
@@ -73,6 +73,7 @@
 
 	if (pc110pad_count < 3) return;
 	
+	input_regs(&pc110pad_dev, regs);
 	input_report_key(&pc110pad_dev, BTN_TOUCH,
 		pc110pad_data[0] & 0x01);
 	input_report_abs(&pc110pad_dev, ABS_X,
diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/mouse/psmouse.c	Wed Feb 12 11:57:08 2003
@@ -73,11 +73,13 @@
  * reports relevant events to the input module.
  */
 
-static void psmouse_process_packet(struct psmouse *psmouse)
+static void psmouse_process_packet(struct psmouse *psmouse, struct pt_regs *regs)
 {
 	struct input_dev *dev = &psmouse->dev;
 	unsigned char *packet = psmouse->packet;
 
+	input_regs(dev, regs);
+
 /*
  * The PS2++ protocol is a little bit complex
  */
@@ -165,7 +167,7 @@
  * packets or passing them to the command routine as command output.
  */
 
-static void psmouse_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+static void psmouse_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct psmouse *psmouse = serio->private;
 
@@ -201,7 +203,7 @@
 	psmouse->packet[psmouse->pktcnt++] = data;
 
 	if (psmouse->pktcnt == 3 + (psmouse->type >= PSMOUSE_GENPS)) {
-		psmouse_process_packet(psmouse);
+		psmouse_process_packet(psmouse, regs);
 		psmouse->pktcnt = 0;
 		return;
 	}
diff -Nru a/drivers/input/mouse/rpcmouse.c b/drivers/input/mouse/rpcmouse.c
--- a/drivers/input/mouse/rpcmouse.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/mouse/rpcmouse.c	Wed Feb 12 11:57:08 2003
@@ -64,6 +64,8 @@
 	rpcmouse_lastx = x;
 	rpcmouse_lasty = y;
 
+	input_regs(dev, regs);
+
 	input_report_rel(dev, REL_X, dx);
 	input_report_rel(dev, REL_Y, -dy);
 
diff -Nru a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
--- a/drivers/input/mouse/sermouse.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/mouse/sermouse.c	Wed Feb 12 11:57:08 2003
@@ -60,11 +60,13 @@
  * second, which is as good as a PS/2 or USB mouse.
  */
 
-static void sermouse_process_msc(struct sermouse *sermouse, signed char data)
+static void sermouse_process_msc(struct sermouse *sermouse, signed char data, struct pt_regs *regs)
 {
 	struct input_dev *dev = &sermouse->dev;
 	signed char *buf = sermouse->buf;
 
+	input_regs(dev, regs);
+
 	switch (sermouse->count) {
 
 		case 0:
@@ -101,13 +103,15 @@
  * standard 3-byte packets and 1200 bps.
  */
 
-static void sermouse_process_ms(struct sermouse *sermouse, signed char data)
+static void sermouse_process_ms(struct sermouse *sermouse, signed char data, struct pt_regs *regs)
 {
 	struct input_dev *dev = &sermouse->dev;
 	signed char *buf = sermouse->buf;
 
 	if (data & 0x40) sermouse->count = 0;
 
+	input_regs(dev, regs);
+
 	switch (sermouse->count) {
 
 		case 0:
@@ -200,7 +204,7 @@
  * packets or passing them to the command routine as command output.
  */
 
-static void sermouse_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+static void sermouse_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct sermouse *sermouse = serio->private;
 
@@ -208,9 +212,9 @@
 	sermouse->last = jiffies;
 
 	if (sermouse->type > SERIO_SUN)
-		sermouse_process_ms(sermouse, data);
+		sermouse_process_ms(sermouse, data, regs);
 	else
-		sermouse_process_msc(sermouse, data);
+		sermouse_process_msc(sermouse, data, regs);
 }
 
 /*
diff -Nru a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
--- a/drivers/input/serio/ambakmi.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/serio/ambakmi.c	Wed Feb 12 11:57:08 2003
@@ -23,8 +23,6 @@
 #include <asm/irq.h>
 #include <asm/hardware/amba_kmi.h>
 
-extern struct pt_regs *kbd_pt_regs;
-
 #define KMI_BASE	(kmi->base)
 
 struct amba_kmi_port {
@@ -42,10 +40,8 @@
 	struct amba_kmi_port *kmi = dev_id;
 	unsigned int status = __raw_readb(KMIIR);
 
-	kbd_pt_regs = regs;
-
 	while (status & KMIIR_RXINTR) {
-		serio_interrupt(&kmi->io, __raw_readb(KMIDATA), 0);
+		serio_interrupt(&kmi->io, __raw_readb(KMIDATA), 0, regs);
 		status = __raw_readb(KMIIR);
 	}
 }
diff -Nru a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
--- a/drivers/input/serio/ct82c710.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/serio/ct82c710.c	Wed Feb 12 11:57:08 2003
@@ -156,7 +156,7 @@
 
 static void ct82c710_interrupt(int cpl, void *dev_id, struct pt_regs * regs)
 {
-	serio_interrupt(&ct82c710_port, inb(ct82c710_data), 0);
+	serio_interrupt(&ct82c710_port, inb(ct82c710_data), 0, regs);
 }
 
 /*
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/serio/i8042.c	Wed Feb 12 11:57:08 2003
@@ -62,8 +62,6 @@
 static unsigned char i8042_mux_open;
 struct timer_list i8042_timer;
 
-extern struct pt_regs *kbd_pt_regs;
-
 static unsigned long i8042_unxlate_seen[256 / BITS_PER_LONG];
 static unsigned char i8042_unxlate_table[128] = {
 	  0,118, 22, 30, 38, 37, 46, 54, 61, 62, 70, 69, 78, 85,102, 13,
@@ -345,10 +343,6 @@
 	} buffer[I8042_BUFFER_SIZE];
 	int i, j = 0;
 
-#ifdef CONFIG_VT
-	kbd_pt_regs = regs;
-#endif
-
 	spin_lock_irqsave(&i8042_lock, flags);
 
 	while (j < I8042_BUFFER_SIZE && 
@@ -381,7 +375,7 @@
 				dfl & SERIO_PARITY ? ", bad parity" : "",
 				dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
-			serio_interrupt(i8042_mux_port + ((str >> 6) & 3), data, dfl);
+			serio_interrupt(i8042_mux_port + ((str >> 6) & 3), data, dfl, regs);
 			continue;
 		}
 
@@ -391,7 +385,7 @@
 			dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
 		if (i8042_aux_values.exists && (str & I8042_STR_AUXDATA)) {
-			serio_interrupt(&i8042_aux_port, data, dfl);
+			serio_interrupt(&i8042_aux_port, data, dfl, regs);
 			continue;
 		}
 
@@ -399,7 +393,7 @@
 			continue;
 
 		if (i8042_direct) {
-			serio_interrupt(&i8042_kbd_port, data, dfl);
+			serio_interrupt(&i8042_kbd_port, data, dfl, regs);
 			continue;
 		}
 
@@ -408,7 +402,7 @@
 			if (index == 0xaa || index == 0xb6)
 				set_bit(index, i8042_unxlate_seen);
 			if (test_and_clear_bit(index, i8042_unxlate_seen)) {
-				serio_interrupt(&i8042_kbd_port, 0xf0, dfl);
+				serio_interrupt(&i8042_kbd_port, 0xf0, dfl, regs);
 				data = i8042_unxlate_table[data & 0x7f];
 			}
 		} else {
@@ -418,7 +412,7 @@
 
 		i8042_last_e0 = (data == 0xe0);
 
-		serio_interrupt(&i8042_kbd_port, data, dfl);
+		serio_interrupt(&i8042_kbd_port, data, dfl, regs);
 	}
 
 }
diff -Nru a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
--- a/drivers/input/serio/parkbd.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/serio/parkbd.c	Wed Feb 12 11:57:08 2003
@@ -136,7 +136,7 @@
 		parkbd_buffer |= (parkbd_readlines() >> 1) << parkbd_counter++;
 
 		if (parkbd_counter == parkbd_mode + 10)
-			serio_interrupt(&parkbd_port, (parkbd_buffer >> (2 - parkbd_mode)) & 0xff, 0);
+			serio_interrupt(&parkbd_port, (parkbd_buffer >> (2 - parkbd_mode)) & 0xff, 0, regs);
 	}
 
 	parkbd_last = jiffies;
diff -Nru a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
--- a/drivers/input/serio/q40kbd.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/serio/q40kbd.c	Wed Feb 12 11:57:08 2003
@@ -69,8 +69,7 @@
 static void q40kbd_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	if (Q40_IRQ_KEYB_MASK & master_inb(INTERRUPT_REG))
-		if (q40kbd_port.dev)
-                         q40kbd_port.dev->interrupt(&q40kbd_port, master_inb(KEYCODE_REG), 0);
+		serio_interrupt(&q40kbd_port, master_inb(KEYCODE_REG), 0, regs);
 
 	master_outb(-1, KEYBOARD_UNLOCK_REG);
 }
diff -Nru a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
--- a/drivers/input/serio/rpckbd.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/serio/rpckbd.c	Wed Feb 12 11:57:08 2003
@@ -44,8 +44,6 @@
 MODULE_DESCRIPTION("Acorn RiscPC PS/2 keyboard controller driver");
 MODULE_LICENSE("GPL");
 
-extern struct pt_regs *kbd_pt_regs;
-
 static int rpckbd_write(struct serio *port, unsigned char val)
 {
 	while (!(iomd_readb(IOMD_KCTRL) & (1 << 7)))
@@ -60,12 +58,11 @@
 {
 	struct serio *port = dev_id;
 	unsigned int byte;
-	kbd_pt_regs = regs;
 
 	while (iomd_readb(IOMD_KCTRL) & (1 << 5)) {
 		byte = iomd_readb(IOMD_KARTRX);
 
-		serio_interrupt(port, byte, 0);
+		serio_interrupt(port, byte, 0, regs);
 	}
 }
 
diff -Nru a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
--- a/drivers/input/serio/sa1111ps2.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/serio/sa1111ps2.c	Wed Feb 12 11:57:08 2003
@@ -24,8 +24,6 @@
 
 #include <asm/hardware/sa1111.h>
 
-extern struct pt_regs *kbd_pt_regs;
-
 struct ps2if {
 	struct serio		io;
 	struct sa1111_dev	*dev;
@@ -47,8 +45,6 @@
 	struct ps2if *ps2if = dev_id;
 	unsigned int scancode, flag, status;
 
-	kbd_pt_regs = regs;
-
 	status = sa1111_readl(ps2if->base + SA1111_PS2STAT);
 	while (status & PS2STAT_RXF) {
 		if (status & PS2STAT_STP)
@@ -62,7 +58,7 @@
 		if (hweight8(scancode) & 1)
 			flag ^= SERIO_PARITY;
 
-		serio_interrupt(&ps2if->io, scancode, flag);
+		serio_interrupt(&ps2if->io, scancode, flag, regs);
 
                	status = sa1111_readl(ps2if->base + SA1111_PS2STAT);
         }
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/serio/serio.c	Wed Feb 12 11:57:08 2003
@@ -135,10 +135,10 @@
 	wake_up(&serio_wait);
 }
 
-void serio_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+void serio_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs)
 {       
         if (serio->dev && serio->dev->interrupt) 
-                serio->dev->interrupt(serio, data, flags);
+                serio->dev->interrupt(serio, data, flags, regs);
 	else 
 		if (!flags)
 			serio_rescan(serio);
diff -Nru a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
--- a/drivers/input/serio/serport.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/serio/serport.c	Wed Feb 12 11:57:08 2003
@@ -114,6 +114,9 @@
  * serport_ldisc_receive() is called by the low level tty driver when characters
  * are ready for us. We forward the characters, one by one to the 'interrupt'
  * routine.
+ *
+ * FIXME: We should get pt_regs from the tty layer and forward them to
+ *	  serio_interrupt here.
  */
 
 static void serport_ldisc_receive(struct tty_struct *tty, const unsigned char *cp, char *fp, int count)
@@ -121,7 +124,7 @@
 	struct serport *serport = (struct serport*) tty->disc_data;
 	int i;
 	for (i = 0; i < count; i++)
-		serio_interrupt(&serport->serio, cp[i], 0);
+		serio_interrupt(&serport->serio, cp[i], 0, NULL);
 }
 
 /*
diff -Nru a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
--- a/drivers/input/touchscreen/gunze.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/touchscreen/gunze.c	Wed Feb 12 11:57:08 2003
@@ -60,7 +60,7 @@
 	char phys[32];
 };
 
-static void gunze_process_packet(struct gunze* gunze)
+static void gunze_process_packet(struct gunze* gunze, struct pt_regs *regs)
 {
 	struct input_dev *dev = &gunze->dev;
 
@@ -71,18 +71,19 @@
 		return;
 	}
 
+	input_regs(dev, regs);
 	input_report_abs(dev, ABS_X, simple_strtoul(gunze->data + 1, NULL, 10) * 4);
 	input_report_abs(dev, ABS_Y, 3072 - simple_strtoul(gunze->data + 6, NULL, 10) * 3);
 	input_report_key(dev, BTN_TOUCH, gunze->data[0] == 'T');
 	input_sync(dev);
 }
 
-static void gunze_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+static void gunze_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct gunze* gunze = serio->private;
 
 	if (data == '\r') {
-		gunze_process_packet(gunze);
+		gunze_process_packet(gunze, regs);
 		gunze->idx = 0;
 	} else {
 		if (gunze->idx < GUNZE_MAX_LENGTH)
diff -Nru a/drivers/input/touchscreen/h3600_ts_input.c b/drivers/input/touchscreen/h3600_ts_input.c
--- a/drivers/input/touchscreen/h3600_ts_input.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/input/touchscreen/h3600_ts_input.c	Wed Feb 12 11:57:08 2003
@@ -108,6 +108,7 @@
         int down = (GPLR & GPIO_BITSY_ACTION_BUTTON) ? 0 : 1;
 	struct input_dev *dev = (struct input_dev *) dev_id;
 
+	input_regs(dev, regs);
 	input_report_key(dev, KEY_ENTER, down);
 	input_sync(dev);
 }
@@ -121,6 +122,7 @@
 	 * This interrupt is only called when we release the key. So we have 
 	 * to fake a key press.
 	 */ 	
+	input_regs(dev, regs);
 	input_report_key(dev, KEY_SUSPEND, 1);
 	input_report_key(dev, KEY_SUSPEND, down); 	
 	input_sync(dev);
@@ -183,11 +185,13 @@
  * packets. Some packets coming from serial are not touchscreen related. In
  * this case we send them off to be processed elsewhere. 
  */
-static void h3600ts_process_packet(struct h3600_dev *ts)
+static void h3600ts_process_packet(struct h3600_dev *ts, struct pt_regs *regs)
 {
         struct input_dev *dev = &ts->dev;
 	static int touched = 0;
 	int key, down = 0;
+
+	input_regs(dev, regs);
 
         switch (ts->event) {
                 /*
diff -Nru a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
--- a/drivers/macintosh/adbhid.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/macintosh/adbhid.c	Wed Feb 12 11:57:08 2003
@@ -52,8 +52,6 @@
 #define KEYB_LEDREG	2	/* register # for leds on ADB keyboard */
 #define MOUSE_DATAREG	0	/* reg# for movement/button codes from mouse */
 
-extern struct pt_regs *kbd_pt_regs;
-
 static int adb_message_handler(struct notifier_block *, unsigned long, void *);
 static struct notifier_block adbhid_adb_notifier = {
 	.notifier_call	= adb_message_handler,
@@ -136,14 +134,13 @@
 	/* first check this is from register 0 */
 	if (nb != 3 || (data[0] & 3) != KEYB_KEYREG)
 		return;		/* ignore it */
-	kbd_pt_regs = regs;
-	adbhid_input_keycode(id, data[1], 0);
+	adbhid_input_keycode(id, data[1], 0, regs);
 	if (!(data[2] == 0xff || (data[2] == 0x7f && data[1] == 0x7f)))
-		adbhid_input_keycode(id, data[2], 0);
+		adbhid_input_keycode(id, data[2], 0, regs);
 }
 
 static void
-adbhid_input_keycode(int id, int keycode, int repeat)
+adbhid_input_keycode(int id, int keycode, int repeat, pt_regs *regs)
 {
 	int up_flag;
 
@@ -152,21 +149,24 @@
 
 	switch (keycode) {
 	case 0x39: /* Generate down/up events for CapsLock everytime. */
+		input_regs(&adbhid[id]->input, regs);
 		input_report_key(&adbhid[id]->input, KEY_CAPSLOCK, 1);
 		input_report_key(&adbhid[id]->input, KEY_CAPSLOCK, 0);
+		input_sync(&adbhid[id]->input);
 		return;
 	case 0x3f: /* ignore Powerbook Fn key */
 		return;
 	}
 
-	if (adbhid[id]->keycode[keycode])
+	if (adbhid[id]->keycode[keycode]) {
+		input_regs(&adbhid[id]->input, regs);
 		input_report_key(&adbhid[id]->input,
 				 adbhid[id]->keycode[keycode], !up_flag);
-	else
+		input_sync(&adbhid[id]->input);
+	} else
 		printk(KERN_INFO "Unhandled ADB key (scancode %#02x) %s.\n", keycode,
 		       up_flag ? "released" : "pressed");
 
-	input_sync(&adbhid[id]->input);
 }
 
 static void
@@ -253,6 +253,8 @@
                 break;
 	}
 
+	input_regs(&adbhid[id]->input, regs);
+
 	input_report_key(&adbhid[id]->input, BTN_LEFT,   !((data[1] >> 7) & 1));
 	input_report_key(&adbhid[id]->input, BTN_MIDDLE, !((data[2] >> 7) & 1));
 
@@ -276,6 +278,8 @@
 		printk(KERN_ERR "ADB HID on ID %d not yet registered\n", id);
 		return;
 	}
+
+	input_regs(&adbhid[id]->input, regs);
 
 	switch (adbhid[id]->original_handler_id) {
 	default:
diff -Nru a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
--- a/drivers/serial/sunsu.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/serial/sunsu.c	Wed Feb 12 11:57:08 2003
@@ -527,7 +527,7 @@
 			}
 			kbd_pt_regs = regs;
 #ifdef CONFIG_SERIO
-			serio_interrupt(&up->serio, ch, 0);
+			serio_interrupt(&up->serio, ch, 0, regs);
 #endif
 		} else if (up->su_type == SU_PORT_MS) {
 			int ret = suncore_mouse_baud_detection(ch, is_break);
@@ -541,7 +541,7 @@
 
 			case 0:
 #ifdef CONFIG_SERIO
-				serio_interrupt(&up->serio, ch, 0);
+				serio_interrupt(&up->serio, ch, 0, regs);
 #endif
 				break;
 			};
diff -Nru a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
--- a/drivers/serial/sunzilog.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/serial/sunzilog.c	Wed Feb 12 11:57:08 2003
@@ -303,7 +303,7 @@
 		}
 		kbd_pt_regs = regs;
 #ifdef CONFIG_SERIO
-		serio_interrupt(&up->serio, ch, 0);
+		serio_interrupt(&up->serio, ch, 0, regs);
 #endif
 	} else if (ZS_IS_MOUSE(up)) {
 		int ret = suncore_mouse_baud_detection(ch, is_break);
@@ -317,7 +317,7 @@
 
 		case 0:
 #ifdef CONFIG_SERIO
-			serio_interrupt(&up->serio, ch, 0);
+			serio_interrupt(&up->serio, ch, 0, regs);
 #endif
 			break;
 		};
diff -Nru a/drivers/usb/input/aiptek.c b/drivers/usb/input/aiptek.c
--- a/drivers/usb/input/aiptek.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/usb/input/aiptek.c	Wed Feb 12 11:57:08 2003
@@ -155,6 +155,8 @@
 		dbg("received unknown report #%d", data[0]);
 	}
 
+	input_regs(dev, regs);
+
 	proximity = data[5] & 0x01;
 	input_report_key(dev, BTN_TOOL_PEN, proximity);
 
diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/usb/input/hid-core.c	Wed Feb 12 11:57:08 2003
@@ -773,13 +773,13 @@
 	return -1;
 }
 
-static void hid_process_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value)
+static void hid_process_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value, struct pt_regs *regs)
 {
 	hid_dump_input(usage, value);
 	if (hid->claimed & HID_CLAIMED_INPUT)
-		hidinput_hid_event(hid, field, usage, value);
+		hidinput_hid_event(hid, field, usage, value, regs);
 	if (hid->claimed & HID_CLAIMED_HIDDEV)
-		hiddev_hid_event(hid, field, usage, value);
+		hiddev_hid_event(hid, field, usage, value, regs);
 }
 
 /*
@@ -788,7 +788,7 @@
  * reporting to the layer).
  */
 
-static void hid_input_field(struct hid_device *hid, struct hid_field *field, __u8 *data)
+static void hid_input_field(struct hid_device *hid, struct hid_field *field, __u8 *data, struct pt_regs *regs)
 {
 	unsigned n;
 	unsigned count = field->report_count;
@@ -818,25 +818,25 @@
 			} else {
 				if (value[n] == field->value[n]) continue;
 			}	
-			hid_process_event(hid, field, &field->usage[n], value[n]);
+			hid_process_event(hid, field, &field->usage[n], value[n], regs);
 			continue;
 		}
 
 		if (field->value[n] >= min && field->value[n] <= max
 			&& field->usage[field->value[n] - min].hid
 			&& search(value, field->value[n], count))
-				hid_process_event(hid, field, &field->usage[field->value[n] - min], 0);
+				hid_process_event(hid, field, &field->usage[field->value[n] - min], 0, regs);
 
 		if (value[n] >= min && value[n] <= max
 			&& field->usage[value[n] - min].hid
 			&& search(field->value, value[n], count))
-				hid_process_event(hid, field, &field->usage[value[n] - min], 1);
+				hid_process_event(hid, field, &field->usage[value[n] - min], 1, regs);
 	}
 
 	memcpy(field->value, value, count * sizeof(__s32));
 }
 
-static int hid_input_report(int type, struct urb *urb)
+static int hid_input_report(int type, struct urb *urb, struct pt_regs *regs)
 {
 	struct hid_device *hid = urb->context;
 	struct hid_report_enum *report_enum = hid->report_enum + type;
@@ -886,7 +886,7 @@
 		hiddev_report_event(hid, report);
 
 	for (n = 0; n < report->maxfield; n++)
-		hid_input_field(hid, report->field[n], data);
+		hid_input_field(hid, report->field[n], data, regs);
 
 	if (hid->claimed & HID_CLAIMED_INPUT)
 		hidinput_report_event(hid, report);
@@ -905,7 +905,7 @@
 
 	switch (urb->status) {
 	case 0:			/* success */
-		hid_input_report(HID_INPUT_REPORT, urb);
+		hid_input_report(HID_INPUT_REPORT, urb, regs);
 		break;
 	case -ECONNRESET:	/* unlink */
 	case -ENOENT:
@@ -1130,7 +1130,7 @@
 	spin_lock_irqsave(&hid->ctrllock, flags);
 
 	if (hid->ctrl[hid->ctrltail].dir == USB_DIR_IN) 
-		hid_input_report(hid->ctrl[hid->ctrltail].report->type, urb);
+		hid_input_report(hid->ctrl[hid->ctrltail].report->type, urb, regs);
 
 	hid->ctrltail = (hid->ctrltail + 1) & (HID_CONTROL_FIFO_SIZE - 1);
 
diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/usb/input/hid-input.c	Wed Feb 12 11:57:08 2003
@@ -380,10 +380,12 @@
 	}
 }
 
-void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value)
+void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value, struct pt_regs *regs)
 {
 	struct input_dev *input = &hid->input;
 	int *quirks = &hid->quirks;
+
+	input_regs(input, regs);
 
 	if (usage->hat_min != usage->hat_max) {
 		value = (value - usage->hat_min) * 8 / (usage->hat_max - usage->hat_min + 1) + 1;
diff -Nru a/drivers/usb/input/hid.h b/drivers/usb/input/hid.h
--- a/drivers/usb/input/hid.h	Wed Feb 12 11:57:08 2003
+++ b/drivers/usb/input/hid.h	Wed Feb 12 11:57:08 2003
@@ -420,13 +420,13 @@
 /* Applications from HID Usage Tables 4/8/99 Version 1.1 */
 /* We ignore a few input applications that are not widely used */
 #define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || ( a == 0x00010080) || ( a == 0x000c0001))
-extern void hidinput_hid_event(struct hid_device *, struct hid_field *, struct hid_usage *, __s32);
+extern void hidinput_hid_event(struct hid_device *, struct hid_field *, struct hid_usage *, __s32, struct pt_regs *regs);
 extern void hidinput_report_event(struct hid_device *hid, struct hid_report *report);
 extern int hidinput_connect(struct hid_device *);
 extern void hidinput_disconnect(struct hid_device *);
 #else
 #define IS_INPUT_APPLICATION(a) (0)
-static inline void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value) { }
+static inline void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value, struct pt_regs *regs) { }
 static inline void hidinput_report_event(struct hid_device *hid, struct hid_report *report) { }
 static inline int hidinput_connect(struct hid_device *hid) { return -ENODEV; }
 static inline void hidinput_disconnect(struct hid_device *hid) { }
diff -Nru a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/usb/input/hiddev.c	Wed Feb 12 11:57:08 2003
@@ -180,7 +180,7 @@
  * the interrupt pipe
  */
 void hiddev_hid_event(struct hid_device *hid, struct hid_field *field,
-		      struct hid_usage *usage, __s32 value)
+		      struct hid_usage *usage, __s32 value, struct pt_regs *regs)
 {
 	unsigned type = field->report_type;
 	struct hiddev_usage_ref uref;
diff -Nru a/drivers/usb/input/powermate.c b/drivers/usb/input/powermate.c
--- a/drivers/usb/input/powermate.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/usb/input/powermate.c	Wed Feb 12 11:57:08 2003
@@ -96,6 +96,7 @@
 	}
 
 	/* handle updates to device state */
+	input_regs(&pm->input, regs);
 	input_report_key(&pm->input, BTN_0, pm->data[0] & 0x01);
 	input_report_rel(&pm->input, REL_DIAL, pm->data[1]);
 	input_sync(&pm->input);
diff -Nru a/drivers/usb/input/usbkbd.c b/drivers/usb/input/usbkbd.c
--- a/drivers/usb/input/usbkbd.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/usb/input/usbkbd.c	Wed Feb 12 11:57:08 2003
@@ -99,6 +99,8 @@
 		goto resubmit;
 	}
 
+	input_regs(&kbd->dev, regs);
+
 	for (i = 0; i < 8; i++)
 		input_report_key(&kbd->dev, usb_kbd_keycode[i + 224], (kbd->new[0] >> i) & 1);
 
diff -Nru a/drivers/usb/input/usbmouse.c b/drivers/usb/input/usbmouse.c
--- a/drivers/usb/input/usbmouse.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/usb/input/usbmouse.c	Wed Feb 12 11:57:08 2003
@@ -76,6 +76,7 @@
 		goto resubmit;
 	}
 
+	input_regs(dev, regs);
 
 	input_report_key(dev, BTN_LEFT,   data[0] & 0x01);
 	input_report_key(dev, BTN_RIGHT,  data[0] & 0x02);
diff -Nru a/drivers/usb/input/wacom.c b/drivers/usb/input/wacom.c
--- a/drivers/usb/input/wacom.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/usb/input/wacom.c	Wed Feb 12 11:57:08 2003
@@ -129,6 +129,8 @@
 		dbg("received unknown report #%d", data[0]);
 
 	prox = data[1] & 0x40;
+
+	input_regs(dev, regs);
 	
 	input_report_key(dev, BTN_TOOL_PEN, prox);
 	
@@ -179,6 +181,7 @@
 		goto exit;
 	}
 
+	input_regs(dev, regs);
 	input_report_key(dev, BTN_TOOL_PEN, 1);
 	input_report_abs(dev, ABS_X, data[2] << 8 | data[1]);
 	input_report_abs(dev, ABS_Y, data[4] << 8 | data[3]);
@@ -223,6 +226,8 @@
 	x = data[2] | ((__u32)data[3] << 8);
 	y = data[4] | ((__u32)data[5] << 8);
 
+	input_regs(dev, regs);
+
 	switch ((data[1] >> 5) & 3) {
 
 		case 0:	/* Pen */
@@ -293,6 +298,8 @@
 
 	if (data[0] != 2)
 		dbg("received unknown report #%d", data[0]);
+
+	input_regs(dev, regs);
 
 	/* tool number */
 	idx = data[1] & 0x01;
diff -Nru a/drivers/usb/input/xpad.c b/drivers/usb/input/xpad.c
--- a/drivers/usb/input/xpad.c	Wed Feb 12 11:57:08 2003
+++ b/drivers/usb/input/xpad.c	Wed Feb 12 11:57:08 2003
@@ -124,9 +124,11 @@
  *	 http://euc.jp/periphs/xbox-controller.ja.html
  */
 
-static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
+static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data, struct pt_regs *regs)
 {
 	struct input_dev *dev = &xpad->dev;
+
+	input_regs(dev, regs);
 	
 	/* left stick */
 	input_report_abs(dev, ABS_X, (__s16) (((__s16)data[13] << 8) | data[12]));
@@ -183,7 +185,7 @@
 		goto exit;
 	}
 	
-	xpad_process_packet(xpad, 0, xpad->idata);
+	xpad_process_packet(xpad, 0, xpad->idata, regs);
 
 exit:
 	retval = usb_submit_urb (urb, GFP_ATOMIC);
diff -Nru a/include/asm-sparc/system.h b/include/asm-sparc/system.h
--- a/include/asm-sparc/system.h	Wed Feb 12 11:57:08 2003
+++ b/include/asm-sparc/system.h	Wed Feb 12 11:57:08 2003
@@ -62,8 +62,6 @@
 	return serial_console ? 0 : 1;
 }
 
-extern struct pt_regs *kbd_pt_regs;
-
 /* When a context switch happens we must flush all user windows so that
  * the windows of the current process are flushed onto its stack. This
  * way the windows are all clean for the next process and the stack
diff -Nru a/include/asm-sparc64/system.h b/include/asm-sparc64/system.h
--- a/include/asm-sparc64/system.h	Wed Feb 12 11:57:08 2003
+++ b/include/asm-sparc64/system.h	Wed Feb 12 11:57:08 2003
@@ -131,8 +131,6 @@
 	return serial_console ? 0 : 1;
 }
 
-extern struct pt_regs *kbd_pt_regs;
-
 extern void synchronize_user_stack(void);
 
 extern void __flushw_user(void);
diff -Nru a/include/linux/hiddev.h b/include/linux/hiddev.h
--- a/include/linux/hiddev.h	Wed Feb 12 11:57:08 2003
+++ b/include/linux/hiddev.h	Wed Feb 12 11:57:08 2003
@@ -204,7 +204,7 @@
 int hiddev_connect(struct hid_device *);
 void hiddev_disconnect(struct hid_device *);
 void hiddev_hid_event(struct hid_device *hid, struct hid_field *field,
-		      struct hid_usage *usage, __s32 value);
+		      struct hid_usage *usage, __s32 value, struct pt_regs *regs);
 void hiddev_report_event(struct hid_device *hid, struct hid_report *report);
 int __init hiddev_init(void);
 void __exit hiddev_exit(void);
@@ -212,7 +212,7 @@
 static inline int hiddev_connect(struct hid_device *hid) { return -1; }
 static inline void hiddev_disconnect(struct hid_device *hid) { }
 static inline void hiddev_hid_event(struct hid_device *hid, struct hid_field *field,
-		      struct hid_usage *usage, __s32 value) { }
+		      struct hid_usage *usage, __s32 value, struct pt_regs *regs) { }
 static inline void hiddev_report_event(struct hid_device *hid, struct hid_report *report) { }
 static inline int hiddev_init(void) { return 0; }
 static inline void hiddev_exit(void) { }
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Wed Feb 12 11:57:08 2003
+++ b/include/linux/input.h	Wed Feb 12 11:57:08 2003
@@ -774,6 +774,7 @@
 	struct timer_list timer;
 
 	struct pm_dev *pm_dev;
+	struct pt_regs *regs;
 	int state;
 
 	int sync;
@@ -899,12 +900,14 @@
 
 void input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value);
 
-#define input_sync(a)		input_event(a, EV_SYN, SYN_REPORT, 0)
 #define input_report_key(a,b,c) input_event(a, EV_KEY, b, !!(c))
 #define input_report_rel(a,b,c) input_event(a, EV_REL, b, c)
 #define input_report_abs(a,b,c) input_event(a, EV_ABS, b, c)
 #define input_report_ff(a,b,c)	input_event(a, EV_FF, b, c)
 #define input_report_ff_status(a,b,c)	input_event(a, EV_FF_STATUS, b, c)
+
+#define input_regs(a,b)		do { (a)->regs = (b); } while (0)
+#define input_sync(a)		do { input_event(a, EV_SYN, SYN_REPORT, 0); (a)->regs = NULL; } while (0)
 
 extern struct device_class input_devclass;
 
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Wed Feb 12 11:57:08 2003
+++ b/include/linux/serio.h	Wed Feb 12 11:57:08 2003
@@ -10,10 +10,13 @@
  */
 
 #include <linux/ioctl.h>
-#include <linux/list.h>
 
 #define SPIOCSTYPE	_IOW('q', 0x01, unsigned long)
 
+#ifdef __KERNEL__
+
+#include <linux/list.h>
+
 struct serio;
 
 struct serio {
@@ -47,7 +50,7 @@
 	char *name;
 
 	void (*write_wakeup)(struct serio *);
-	void (*interrupt)(struct serio *, unsigned char, unsigned int);
+	void (*interrupt)(struct serio *, unsigned char, unsigned int, struct pt_regs *);
 	void (*connect)(struct serio *, struct serio_dev *dev);
 	void (*disconnect)(struct serio *);
 	void (*cleanup)(struct serio *);
@@ -58,7 +61,7 @@
 int serio_open(struct serio *serio, struct serio_dev *dev);
 void serio_close(struct serio *serio);
 void serio_rescan(struct serio *serio);
-void serio_interrupt(struct serio *serio, unsigned char data, unsigned int flags);
+void serio_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs);
 
 void serio_register_port(struct serio *serio);
 void serio_unregister_port(struct serio *serio);
@@ -84,6 +87,8 @@
 	if (serio->dev && serio->dev->cleanup)
 		serio->dev->cleanup(serio);
 }
+
+#endif
 
 /*
  * bit masks for use in "interrupt" flags (3rd argument)
