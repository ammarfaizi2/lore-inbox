Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131989AbRCVMEM>; Thu, 22 Mar 2001 07:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132002AbRCVMED>; Thu, 22 Mar 2001 07:04:03 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:31108 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131989AbRCVMDq>; Thu, 22 Mar 2001 07:03:46 -0500
Message-ID: <3AB9EA54.AE711F3F@uow.edu.au>
Date: Thu, 22 Mar 2001 23:04:36 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: lkml <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [patch] console updates
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

patch against -ac20 fixes a few things:

- console.c: reviewed and commented locking rules

- tioclinux(): set_selection() was racy wrt console writes, which
  causes mouse droppings on the screen when using gpm.  It was
  always SMP racy.  Removing the console_lock make it UP-racy.
  Now fixed.

- con_flush_chars(): this is being called from timer context,
  and for a couple of people it was going splat on a BUG() I
  added when they were switching from X back to the console.
  We just skip the flush in this case.

  This could possibly cause the cursor to not be present until
  a character is output immediately after switching out of X,
  but it works for me, and it's not obvious that this is worth
  straining over.

- In reset_vc(), don't call set_pallette() in interrupt context.
  It's racy.  This only happens when SAK is used.

- keyboard.c: poke the cosole after printing, rather than before.
  See below for details...

- printk.c: fix the off-by-one which prevented a bare

	printk(KERN_ERR);

  from working.

- add lib/bust_spinlocks.c for archs which don't provide one.

Outstanding problems (of which I'm aware):

1: riva_hw.c:ShowHideCursor() is called from a timer
   handler and a race here could cause registers to get the
   wrong values.  It was always racy on SMP. The driver
   needs locking.

2: This code:

	printk(KERN_ERR "something");
	console_loglevel = something_else;

   is now racy, because the actual printing of the output
   could be deferred if someone currently holds console_sem().

   The only known instance of this is the sysrq handler, and
   I fixed that.

The corresponding patch against 2.4.3-pre6 is at

	http://www.uow.edu.au/~andrewm/linux/console.html


--- linux-2.4.2-ac20/drivers/char/console.c	Tue Mar 13 20:29:21 2001
+++ ac/drivers/char/console.c	Thu Mar 22 21:29:10 2001
@@ -69,6 +69,9 @@
  *
  * Removed old-style timers, introduced console_timer, made timer
  * deletion SMP-safe.  17Jun00, Andrew Morton <andrewm@uow.edu.au>
+ *
+ * Removed console_lock, enabled interrupts across all console operations
+ * 13 March 2001, Andrew Morton
  */
 
 #include <linux/module.h>
@@ -1034,6 +1037,7 @@
 	color = def_color;
 }
 
+/* console_sem is held */
 static void csi_m(int currcons)
 {
 	int i;
@@ -1173,6 +1177,7 @@
 	return report_mouse;
 }
 
+/* console_sem is held */
 static void set_mode(int currcons, int on_off)
 {
 	int i;
@@ -1238,6 +1243,7 @@
 		}
 }
 
+/* console_sem is held */
 static void setterm_command(int currcons)
 {
 	switch(par[0]) {
@@ -1292,19 +1298,7 @@
 	}
 }
 
-static void insert_line(int currcons, unsigned int nr)
-{
-	scrdown(currcons,y,bottom,nr);
-	need_wrap = 0;
-}
-
-
-static void delete_line(int currcons, unsigned int nr)
-{
-	scrup(currcons,y,bottom,nr);
-	need_wrap = 0;
-}
-
+/* console_sem is held */
 static void csi_at(int currcons, unsigned int nr)
 {
 	if (nr > video_num_columns - x)
@@ -1314,15 +1308,18 @@
 	insert_char(currcons, nr);
 }
 
+/* console_sem is held */
 static void csi_L(int currcons, unsigned int nr)
 {
 	if (nr > video_num_lines - y)
 		nr = video_num_lines - y;
 	else if (!nr)
 		nr = 1;
-	insert_line(currcons, nr);
+	scrdown(currcons,y,bottom,nr);
+	need_wrap = 0;
 }
 
+/* console_sem is held */
 static void csi_P(int currcons, unsigned int nr)
 {
 	if (nr > video_num_columns - x)
@@ -1332,15 +1329,18 @@
 	delete_char(currcons, nr);
 }
 
+/* console_sem is held */
 static void csi_M(int currcons, unsigned int nr)
 {
 	if (nr > video_num_lines - y)
 		nr = video_num_lines - y;
 	else if (!nr)
 		nr=1;
-	delete_line(currcons, nr);
+	scrup(currcons,y,bottom,nr);
+	need_wrap = 0;
 }
 
+/* console_sem is held (except via vc_init->reset_terminal */
 static void save_cur(int currcons)
 {
 	saved_x		= x;
@@ -1355,6 +1355,7 @@
 	saved_G1	= G1_charset;
 }
 
+/* console_sem is held */
 static void restore_cur(int currcons)
 {
 	gotoxy(currcons,saved_x,saved_y);
@@ -1375,6 +1376,7 @@
 	EShash, ESsetG0, ESsetG1, ESpercent, ESignore, ESnonstd,
 	ESpalette };
 
+/* console_sem is held (except via vc_init()) */
 static void reset_terminal(int currcons, int do_clear)
 {
 	top		= 0;
@@ -1430,6 +1432,7 @@
 	    csi_J(currcons,2);
 }
 
+/* console_sem is held */
 static void do_con_trol(struct tty_struct *tty, unsigned int currcons, int c)
 {
 	/*
@@ -1810,6 +1813,7 @@
 #define CON_BUF_SIZE	PAGE_SIZE
 DECLARE_MUTEX(con_buf_sem);
 
+/* acquires console_sem */
 static int do_con_write(struct tty_struct * tty, int from_user,
 			const unsigned char *buf, int count)
 {
@@ -2049,7 +2053,7 @@
 void set_console(int nr)
 {
 	want_console = nr;
-	schedule_task(&console_callback_tq);
+	schedule_console_callback();
 }
 
 #ifdef CONFIG_VT_CONSOLE
@@ -2171,9 +2175,21 @@
  *	Handling of Linux-specific VC ioctls
  */
 
+/*
+ * Generally a bit racy with respect to console_sem().
+ *
+ * There are some functions which don't need it.
+ *
+ * There are some functions which can sleep for arbitrary periods (paste_selection)
+ * but we don't need the lock there anyway.
+ *
+ * set_selection has locking, and definitely needs it
+ */
+
 int tioclinux(struct tty_struct *tty, unsigned long arg)
 {
 	char type, data;
+	int ret;
 
 	if (tty->driver.type != TTY_DRIVER_TYPE_CONSOLE)
 		return -EINVAL;
@@ -2181,17 +2197,23 @@
 		return -EPERM;
 	if (get_user(type, (char *)arg))
 		return -EFAULT;
+	ret = 0;
 	switch (type)
 	{
 		case 2:
-			return set_selection(arg, tty, 1);
+			acquire_console_sem();
+			ret = set_selection(arg, tty, 1);
+			release_console_sem();
+			break;
 		case 3:
-			return paste_selection(tty);
+			ret = paste_selection(tty);
+			break;
 		case 4:
 			unblank_screen();
-			return 0;
+			break;
 		case 5:
-			return sel_loadlut(arg);
+			ret = sel_loadlut(arg);
+			break;
 		case 6:
 			
 	/*
@@ -2201,24 +2223,33 @@
 	 * related to the kernel should not use this.
 	 */
 	 		data = shift_state;
-			return __put_user(data, (char *) arg);
+			ret = __put_user(data, (char *) arg);
+			break;
 		case 7:
 			data = mouse_reporting();
-			return __put_user(data, (char *) arg);
+			ret = __put_user(data, (char *) arg);
+			break;
 		case 10:
 			set_vesa_blanking(arg);
-			return 0;
+			break;;
 		case 11:	/* set kmsg redirect */
-			if (!capable(CAP_SYS_ADMIN))
-				return -EPERM;
-			if (get_user(data, (char *)arg+1))
-					return -EFAULT;
-			kmsg_redirect = data;
-			return 0;
+			if (!capable(CAP_SYS_ADMIN)) {
+				ret = -EPERM;
+			} else {
+				if (get_user(data, (char *)arg+1))
+					ret = -EFAULT;
+				else
+					kmsg_redirect = data;
+			}
+			break;
 		case 12:	/* get fg_console */
-			return fg_console;
+			ret = fg_console;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
 	}
-	return -EINVAL;
+	return ret;
 }
 
 /*
@@ -2304,6 +2335,9 @@
 static void con_flush_chars(struct tty_struct *tty)
 {
 	struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
+
+	if (in_interrupt())	/* from flush_to_ldisc */
+		return;
 
 	pm_access(pm_con);
 	acquire_console_sem();
--- linux-2.4.2-ac20/drivers/video/fbcon.c	Tue Mar 13 20:29:28 2001
+++ ac/drivers/video/fbcon.c	Thu Mar 22 21:29:10 2001
@@ -1149,8 +1149,8 @@
 	    	    start++;
 	    	}
 	    }
-	    console_conditional_schedule();
 	    scr_writew(c, d);
+	    console_conditional_schedule();
 	    s++;
 	    d++;
 	} while (s < le);
--- linux-2.4.2-ac20/drivers/char/vt.c	Tue Mar 13 20:29:22 2001
+++ ac/drivers/char/vt.c	Thu Mar 22 21:29:10 2001
@@ -23,6 +23,7 @@
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/console.h>
+#include <linux/irq.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -1169,7 +1170,8 @@
 	vt_cons[new_console]->vt_mode.frsig = 0;
 	vt_cons[new_console]->vt_pid = -1;
 	vt_cons[new_console]->vt_newvt = -1;
-	reset_palette (new_console) ;
+	if (!in_interrupt())	/* Via keyboard.c:SAK() - akpm */
+		reset_palette (new_console) ;
 }
 
 /*
--- linux-2.4.2-ac20/drivers/char/keyboard.c	Tue Mar 13 20:29:21 2001
+++ ac/drivers/char/keyboard.c	Thu Mar 22 21:29:10 2001
@@ -205,9 +205,6 @@
 	char raw_mode;
 
 	pm_access(pm_kbd);
-
-	do_poke_blanked_console = 1;
-	schedule_console_callback();
 	add_keyboard_randomness(scancode | up_flag);
 
 	tty = ttytab? ttytab[fg_console]: NULL;
@@ -233,7 +230,7 @@
 	 *  Convert scancode to keycode
 	 */
 	if (!kbd_translate(scancode, &keycode, raw_mode))
-	    return;
+		goto out;
 
 	/*
 	 * At this point the variable `keycode' contains the keycode.
@@ -252,11 +249,11 @@
 #ifdef CONFIG_MAGIC_SYSRQ		/* Handle the SysRq Hack */
 	if (keycode == SYSRQ_KEY) {
 		sysrq_pressed = !up_flag;
-		return;
+		goto out;
 	} else if (sysrq_pressed) {
 		if (!up_flag) {
 			handle_sysrq(kbd_sysrq_xlate[keycode], kbd_pt_regs, kbd, tty);
-			return;
+			goto out;
 		}
 	}
 #endif
@@ -298,7 +295,7 @@
 			if (type >= 0xf0) {
 			    type -= 0xf0;
 			    if (raw_mode && ! (TYPES_ALLOWED_IN_RAW_MODE & (1 << type)))
-				return;
+				goto out;
 			    if (type == KT_LETTER) {
 				type = KT_LATIN;
 				if (vc_kbd_led(kbd, VC_CAPSLOCK)) {
@@ -329,6 +326,9 @@
 #endif
 		}
 	}
+out:
+	do_poke_blanked_console = 1;
+	schedule_console_callback();
 }
 
 
--- linux-2.4.2-ac20/drivers/char/sysrq.c	Tue Mar 13 20:29:22 2001
+++ ac/drivers/char/sysrq.c	Thu Mar 22 21:29:10 2001
@@ -58,7 +58,6 @@
  * This function is called by the keyboard handler when SysRq is pressed
  * and any other keycode arrives.
  */
-
 void handle_sysrq(int key, struct pt_regs *pt_regs,
 		  struct kbd_struct *kbd, struct tty_struct *tty)
 {
@@ -153,6 +152,15 @@
 		/* Don't use 'A' as it's handled specially on the Sparc */
 	}
 
+	/*
+	 * There's a race here.  keyboard.c:handle_scancode() has done a
+	 * schedule_task(console_callback).  On another CPU, console_callback()
+	 * will acquire the console_sem.  So the above printk()'s _could_ end up
+	 * getting buffered in log_buf, and will be printed by keventd in console_callback()'s
+	 * release_console_sem().  But by the time that happens, this CPU has changed
+	 * console_loglevel, so the output won't be shown on the console.  The workaround 
+	 * was to move the console poking to the end of handle_scancode().
+	 */
 	console_loglevel = orig_log_level;
 }
 
--- linux-2.4.2-ac20/kernel/printk.c	Tue Mar 13 20:29:30 2001
+++ ac/kernel/printk.c	Thu Mar 22 22:49:36 2001
@@ -267,6 +267,7 @@
 		spin_lock_irq(&logbuf_lock);
 		error = log_end - log_start;
 		spin_unlock_irq(&logbuf_lock);
+		break;
 	default:
 		error = -EINVAL;
 		break;
@@ -328,7 +329,7 @@
 	start_print = start;
 	while (cur_index != end) {
 		if (	msg_level < 0 &&
-			((end - cur_index) > 3) &&
+			((end - cur_index) >= 3) &&
 			LOG_BUF(cur_index + 0) == '<' &&
 			LOG_BUF(cur_index + 1) >= '0' &&
 			LOG_BUF(cur_index + 1) <= '7' &&
@@ -343,6 +344,15 @@
 			cur_index++;
 
 			if (c == '\n') {
+				if (msg_level < 0) {
+					/*
+					 * printk() has already given us loglevel tags in
+					 * the buffer.  This code is here in case the
+					 * log buffer has wrapped right round and scribbled
+					 * on those tags
+					 */
+					msg_level = default_message_loglevel;
+				}
 				_call_console_drivers(start_print, cur_index, msg_level);
 				msg_level = -1;
 				start_print = cur_index;
@@ -373,6 +383,10 @@
  * into the log buffer and return.  The current holder of the console_sem will
  * notice the new output in release_console_sem() and will send it to the
  * consoles before releasing the semaphore.
+ *
+ * One effect of this deferred printing is that code which calls printk() and
+ * then changes console_loglevel may break. This is because console_loglevel
+ * is inspected when the actual printing occurs.
  */
 asmlinkage int printk(const char *fmt, ...)
 {
@@ -479,10 +493,11 @@
 {
 	unsigned long flags;
 	unsigned long _con_start, _log_end;
-	unsigned long must_wake_klogd;
+	unsigned long must_wake_klogd = 0;
 
 	for ( ; ; ) {
 		spin_lock_irqsave(&logbuf_lock, flags);
+		must_wake_klogd |= log_start - log_end;
 		if (con_start == log_end)
 			break;			/* Nothing to print */
 		_con_start = con_start;
@@ -491,7 +506,6 @@
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 		call_console_drivers(_con_start, _log_end);
 	}
-	must_wake_klogd = log_start - log_end;
 	console_may_schedule = 0;
 	up(&console_sem);
 	spin_unlock_irqrestore(&logbuf_lock, flags);
--- linux-2.4.2-ac20/lib/Makefile	Sat Dec 30 09:07:24 2000
+++ ac/lib/Makefile	Thu Mar 22 21:29:10 2001
@@ -10,7 +10,7 @@
 
 export-objs := cmdline.o
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   obj-y += dec_and_lock.o
--- linux-2.4.2-ac20/lib/bust_spinlocks.c	Thu Jan  1 00:00:00 1970
+++ ac/lib/bust_spinlocks.c	Thu Mar 22 21:29:10 2001
@@ -0,0 +1,38 @@
+/*
+ * lib/bust_spinlocks.c
+ *
+ * Provides a minimal bust_spinlocks for architectures which don't have one of their own.
+ *
+ * bust_spinlocks() clears any spinlocks which would prevent oops, die(), BUG()
+ * and panic() information from reaching the user.
+ */
+
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/tty.h>
+#include <linux/wait.h>
+#include <linux/vt_kern.h>
+
+extern spinlock_t timerlist_lock;
+
+void bust_spinlocks(int yes)
+{
+	spin_lock_init(&timerlist_lock);
+	if (yes) {
+		oops_in_progress = 1;
+	} else {
+		int loglevel_save = console_loglevel;
+		unblank_screen();
+		oops_in_progress = 0;
+		/*
+		 * OK, the message is on the console.  Now we call printk()
+		 * without oops_in_progress set so that printk() will give klogd
+		 * and the blanked console a poke.  Hold onto your hats...
+		 */
+		console_loglevel = 15;		/* NMI oopser may have shut the console up */
+		printk(" ");
+		console_loglevel = loglevel_save;
+	}
+}
+
+
