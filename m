Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265972AbUAFAgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbUAFAgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:36:39 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:56018 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265972AbUAFAek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:34:40 -0500
Subject: [PATCH] VT locking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, James Simmons <jsimmons@infradead.org>
Content-Type: text/plain
Message-Id: <1073349182.9504.175.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Jan 2004 11:33:22 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The VT code is currently, it seems, full of races, it basically doesn't
do any locking... This patch is definitely not fixing everything, but at
least fixes some of the most obvious ones by putting things under the
umbrella of the console semaphore. For debugging purposes, I added an
is_console_locked() call to kernel/printk.c along with a bunch of WARN_ON
in low level VT functions that I think should be protected.

I suppose we should merge this at least into -mm. Getting the semaphore
around vc_resize, at least, seems necessary to avoid nasty problems with
fbdev's especally when those try to output some debug printk's in the
mode setting code.

I also moved the blanking code down to the console work queue instead of
calling the lower level blank right at interrupt time. Unblank is still
possibly called at interrupt time by printk/panic, but then, the console
sem will be held. The idea here is to properly protect calls to the low
level driver with the console semaphore. Without this, quite bad things
can happen, for example if blank() happens to preempt a mode switch
initiated by userland.

Note that the current console code definitely takes too much time in
keventd. It would probably be wise to consider turning these work queues
abuses into a console thread... I keep that for later.

Ben.

diff -urN linux-2.5/drivers/char/selection.c linuxppc-2.5-benh/drivers/char/selection.c
--- linux-2.5/drivers/char/selection.c	2004-01-06 10:03:50.467075336 +1100
+++ linuxppc-2.5-benh/drivers/char/selection.c	2003-12-31 12:38:10.000000000 +1100
@@ -24,6 +24,7 @@
 #include <linux/consolemap.h>
 #include <linux/selection.h>
 #include <linux/tiocl.h>
+#include <linux/console.h>
 
 #ifndef MIN
 #define MIN(a,b)	((a) < (b) ? (a) : (b))
@@ -290,7 +291,10 @@
 	int	pasted = 0, count;
 	DECLARE_WAITQUEUE(wait, current);
 
+	acquire_console_sem();
 	poke_blanked_console();
+	release_console_sem();
+
 	add_wait_queue(&vt->paste_wait, &wait);
 	while (sel_buffer && sel_buffer_lth > pasted) {
 		set_current_state(TASK_INTERRUPTIBLE);
diff -urN linux-2.5/drivers/char/tty_io.c linuxppc-2.5-benh/drivers/char/tty_io.c
--- linux-2.5/drivers/char/tty_io.c	2004-01-06 10:03:51.105978208 +1100
+++ linuxppc-2.5-benh/drivers/char/tty_io.c	2003-12-31 12:38:10.000000000 +1100
@@ -1484,7 +1484,12 @@
 #ifdef CONFIG_VT
 	if (tty->driver->type == TTY_DRIVER_TYPE_CONSOLE) {
 		unsigned int currcons = tty->index;
-		if (vc_resize(currcons, tmp_ws.ws_col, tmp_ws.ws_row))
+		int rc;
+
+		acquire_console_sem();	       
+		rc = vc_resize(currcons, tmp_ws.ws_col, tmp_ws.ws_row);
+		release_console_sem();
+		if (rc)
 			return -ENXIO;
 	}
 #endif
diff -urN linux-2.5/drivers/char/vt.c linuxppc-2.5-benh/drivers/char/vt.c
--- linux-2.5/drivers/char/vt.c	2004-01-06 10:03:51.225959968 +1100
+++ linuxppc-2.5-benh/drivers/char/vt.c	2003-12-31 15:49:38.000000000 +1100
@@ -148,7 +148,6 @@
 static int con_open(struct tty_struct *, struct file *);
 static void vc_init(unsigned int console, unsigned int rows,
 		    unsigned int cols, int do_clear);
-static void blank_screen(unsigned long dummy);
 static void gotoxy(int currcons, int new_x, int new_y);
 static void save_cur(int currcons);
 static void reset_terminal(int currcons, int do_clear);
@@ -156,8 +155,8 @@
 static void set_vesa_blanking(unsigned long arg);
 static void set_cursor(int currcons);
 static void hide_cursor(int currcons);
-static void unblank_screen_t(unsigned long dummy);
 static void console_callback(void *ignored);
+static void blank_screen_t(unsigned long dummy);
 
 static int printable;		/* Is console ready for printing? */
 
@@ -214,6 +213,13 @@
 int (*console_blank_hook)(int);
 
 static struct timer_list console_timer;
+static int blank_state;
+static int blank_timer_expired;
+enum {
+	blank_off = 0,
+	blank_normal_wait,
+	blank_vesa_wait,
+};
 
 /*
  *	Low-Level Functions
@@ -559,6 +565,8 @@
 
 static void set_origin(int currcons)
 {
+	WARN_ON(!is_console_locked());
+
 	if (!IS_VISIBLE ||
 	    !sw->con_set_origin ||
 	    !sw->con_set_origin(vc_cons[currcons].d))
@@ -570,6 +578,8 @@
 
 static inline void save_screen(int currcons)
 {
+	WARN_ON(!is_console_locked());
+
 	if (sw->con_save_screen)
 		sw->con_save_screen(vc_cons[currcons].d);
 }
@@ -583,6 +593,8 @@
 	int redraw = 1;
 	int currcons, old_console;
 
+	WARN_ON(!is_console_locked());
+
 	if (!vc_cons_allocated(new_console)) {
 		/* strange ... */
 		/* printk("redraw_screen: tty %d not allocated ??\n", new_console+1); */
@@ -660,6 +672,8 @@
 
 int vc_allocate(unsigned int currcons)	/* return 0 on success */
 {
+	WARN_ON(!is_console_locked());
+
 	if (currcons >= MAX_NR_CONSOLES)
 		return -ENXIO;
 	if (!vc_cons[currcons].d) {
@@ -726,6 +740,8 @@
 	unsigned int new_cols, new_rows, new_row_size, new_screen_size;
 	unsigned short *newscreen;
 
+	WARN_ON(!is_console_locked());
+
 	if (!vc_cons_allocated(currcons))
 		return -ENXIO;
 
@@ -2076,6 +2092,10 @@
 			sw->con_scrolldelta(vc_cons[currcons].d, scrollback_delta);
 		scrollback_delta = 0;
 	}
+	if (blank_timer_expired) {
+		do_blank_screen(0);
+		blank_timer_expired = 0;
+	}
 
 	release_console_sem();
 }
@@ -2409,7 +2429,9 @@
 
 	currcons = tty->index;
 
+	acquire_console_sem();
 	i = vc_allocate(currcons);
+	release_console_sem();
 	if (i)
 		return i;
 
@@ -2475,16 +2497,20 @@
 	const char *display_desc = NULL;
 	unsigned int currcons = 0;
 
+	acquire_console_sem();
+
 	if (conswitchp)
 		display_desc = conswitchp->con_startup();
 	if (!display_desc) {
 		fg_console = 0;
+		release_console_sem();
 		return 0;
 	}
 
 	init_timer(&console_timer);
-	console_timer.function = blank_screen;
+	console_timer.function = blank_screen_t;
 	if (blankinterval) {
+		blank_state = blank_normal_wait;
 		mod_timer(&console_timer, jiffies + blankinterval);
 	}
 
@@ -2515,6 +2541,8 @@
 	printable = 1;
 	printk("\n");
 
+	release_console_sem();
+
 #ifdef CONFIG_VT_CONSOLE
 	register_console(&vt_console_driver);
 #endif
@@ -2594,8 +2622,13 @@
 	int i, j = -1;
 	const char *desc;
 
+	acquire_console_sem();
+
 	desc = csw->con_startup();
-	if (!desc) return;
+	if (!desc) {
+		release_console_sem();
+		return;
+	}
 	if (deflt)
 		conswitchp = csw;
 
@@ -2635,6 +2668,8 @@
 		       desc, vc_cons[j].d->vc_cols, vc_cons[j].d->vc_rows);
 	else
 		printk("to %s\n", desc);
+
+	release_console_sem();
 }
 
 void give_up_console(const struct consw *csw)
@@ -2683,23 +2718,24 @@
     }
 }
 
-/*
- * This is a timer handler
- */
-static void vesa_powerdown_screen(unsigned long dummy)
-{
-	console_timer.function = unblank_screen_t;
-
-	vesa_powerdown();
-}
-
-static void timer_do_blank_screen(int entering_gfx, int from_timer_handler)
+void do_blank_screen(int entering_gfx)
 {
 	int currcons = fg_console;
 	int i;
 
-	if (console_blanked)
+	WARN_ON(!is_console_locked());
+
+	if (console_blanked) {
+		if (blank_state == blank_vesa_wait) {
+			blank_state = blank_off;
+			vesa_powerdown();
+			
+		}
 		return;
+	}
+	if (blank_state != blank_normal_wait)
+		return;
+	blank_state = blank_off;
 
 	/* entering graphics mode? */
 	if (entering_gfx) {
@@ -2718,9 +2754,8 @@
 	}
 
 	hide_cursor(currcons);
-	if (!from_timer_handler)
-		del_timer_sync(&console_timer);
-	console_timer.function = unblank_screen_t;
+	del_timer_sync(&console_timer);
+	blank_timer_expired = 0;
 
 	save_screen(currcons);
 	/* In case we need to reset origin, blanking hook returns 1 */
@@ -2733,7 +2768,7 @@
 		return;
 
 	if (vesa_off_interval) {
-		console_timer.function = vesa_powerdown_screen;
+		blank_state = blank_vesa_wait,
 		mod_timer(&console_timer, jiffies + vesa_off_interval);
 	}
 
@@ -2741,18 +2776,6 @@
 		sw->con_blank(vc_cons[currcons].d, vesa_blank_mode + 1);
 }
 
-void do_blank_screen(int entering_gfx)
-{
-	timer_do_blank_screen(entering_gfx, 0);
-}
-
-/*
- * This is a timer handler
- */
-static void unblank_screen_t(unsigned long dummy)
-{
-	unblank_screen();
-}
 
 /*
  * Called by timer as well as from vt_console_driver
@@ -2761,6 +2784,8 @@
 {
 	int currcons;
 
+	WARN_ON(!is_console_locked());
+
 	ignore_poke = 0;
 	if (!console_blanked)
 		return;
@@ -2773,9 +2798,9 @@
 	if (vcmode != KD_TEXT)
 		return; /* but leave console_blanked != 0 */
 
-	console_timer.function = blank_screen;
 	if (blankinterval) {
 		mod_timer(&console_timer, jiffies + blankinterval);
+		blank_state = blank_normal_wait;
 	}
 
 	console_blanked = 0;
@@ -2789,23 +2814,33 @@
 }
 
 /*
- * This is both a user-level callable and a timer handler
+ * We defer the timer blanking to work queue so it can take the console semaphore
+ * (console operations can still happen at irq time, but only from printk which
+ * has the console semaphore. Not perfect yet, but better than no locking
  */
-static void blank_screen(unsigned long dummy)
+static void blank_screen_t(unsigned long dummy)
 {
-	timer_do_blank_screen(0, 1);
+	blank_timer_expired = 1;
+	schedule_work(&console_work);	
 }
 
 void poke_blanked_console(void)
 {
+	WARN_ON(!is_console_locked());
+
+	/* This isn't perfectly race free, but a race here would be mostly harmless,
+	 * at worse, we'll do a spurrious blank and it's unlikely
+	 */
 	del_timer(&console_timer);
+	blank_timer_expired = 0;
+
 	if (ignore_poke || !vt_cons[fg_console] || vt_cons[fg_console]->vc_mode == KD_GRAPHICS)
 		return;
-	if (console_blanked) {
-		console_timer.function = unblank_screen_t;
-		mod_timer(&console_timer, jiffies);	/* Now */
-	} else if (blankinterval) {
+	if (console_blanked)
+		unblank_screen();
+	else if (blankinterval) {
 		mod_timer(&console_timer, jiffies + blankinterval);
+		blank_state = blank_normal_wait;
 	}
 }
 
@@ -2815,6 +2850,8 @@
 
 void set_palette(int currcons)
 {
+	WARN_ON(!is_console_locked());
+
 	if (vcmode != KD_GRAPHICS)
 		sw->con_set_palette(vc_cons[currcons].d, color_table);
 }
@@ -2854,11 +2891,15 @@
 
 int con_set_cmap(unsigned char *arg)
 {
+	WARN_ON(!is_console_locked());
+
 	return set_get_cmap (arg,1);
 }
 
 int con_get_cmap(unsigned char *arg)
 {
+	WARN_ON(!is_console_locked());
+
 	return set_get_cmap (arg,0);
 }
 
@@ -3029,10 +3070,14 @@
 	switch (rqst)
 	{
 	case PM_RESUME:
+		acquire_console_sem();
 		unblank_screen();
+		release_console_sem();
 		break;
 	case PM_SUSPEND:
+		acquire_console_sem();
 		do_blank_screen(0);
+		release_console_sem();
 		break;
 	}
 	return 0;
diff -urN linux-2.5/drivers/char/vt_ioctl.c linuxppc-2.5-benh/drivers/char/vt_ioctl.c
--- linux-2.5/drivers/char/vt_ioctl.c	2004-01-06 10:03:51.257955104 +1100
+++ linuxppc-2.5-benh/drivers/char/vt_ioctl.c	2003-12-31 15:26:05.000000000 +1100
@@ -470,6 +470,9 @@
 		 * currently, setting the mode from KD_TEXT to KD_GRAPHICS
 		 * doesn't do a whole lot. i'm not sure if it should do any
 		 * restoration of modes or what...
+		 *
+		 * XXX It should at least call into the driver, fbdev's definitely
+		 * need to restore their engine state. --BenH
 		 */
 		if (!perm)
 			return -EPERM;
@@ -492,10 +495,12 @@
 		/*
 		 * explicitly blank/unblank the screen if switching modes
 		 */
+		acquire_console_sem();
 		if (arg == KD_TEXT)
 			unblank_screen();
 		else
 			do_blank_screen(1);
+		release_console_sem();
 		return 0;
 
 	case KDGETMODE:
@@ -718,7 +723,9 @@
 		if (arg == 0 || arg > MAX_NR_CONSOLES)
 			return -ENXIO;
 		arg--;
+		acquire_console_sem();
 		i = vc_allocate(arg);
+		release_console_sem();
 		if (i)
 			return i;
 		set_console(arg);
@@ -768,17 +775,20 @@
 				 * The current vt has been released, so
 				 * complete the switch.
 				 */
-				int newvt = vt_cons[console]->vt_newvt;
+				int newvt;
+				acquire_console_sem();
+				newvt = vt_cons[console]->vt_newvt;
 				vt_cons[console]->vt_newvt = -1;
 				i = vc_allocate(newvt);
-				if (i)
+				if (i) {
+					release_console_sem();
 					return i;
+				}
 				/*
 				 * When we actually do the console switch,
 				 * make sure we are atomic with respect to
 				 * other console switches..
 				 */
-				acquire_console_sem();
 				complete_change_console(newvt);
 				release_console_sem();
 			}
@@ -828,8 +838,11 @@
 		if (get_user(ll, &vtsizes->v_rows) ||
 		    get_user(cc, &vtsizes->v_cols))
 			return -EFAULT;
-		for (i = 0; i < MAX_NR_CONSOLES; i++)
+		for (i = 0; i < MAX_NR_CONSOLES; i++) {
+			acquire_console_sem();
                         vc_resize(i, cc, ll);
+			release_console_sem();
+		}
 		return 0;
 	}
 
@@ -870,11 +883,13 @@
 		for (i = 0; i < MAX_NR_CONSOLES; i++) {
 			if (!vc_cons[i].d)
 				continue;
+			acquire_console_sem();
 			if (vlin)
 				vc_cons[i].d->vc_scan_lines = vlin;
 			if (clin)
 				vc_cons[i].d->vc_font.height = clin;
 			vc_resize(i, cc, ll);
+			release_console_sem();
 		}
   		return 0;
 	}
diff -urN linux-2.5/kernel/power/console.c linuxppc-2.5-benh/kernel/power/console.c
--- linux-2.5/kernel/power/console.c	2004-01-06 10:07:09.031888896 +1100
+++ linuxppc-2.5-benh/kernel/power/console.c	2003-12-31 15:49:32.000000000 +1100
@@ -6,6 +6,7 @@
 
 #include <linux/vt_kern.h>
 #include <linux/kbd_kern.h>
+#include <linux/console.h>
 #include "power.h"
 
 static int new_loglevel = 10;
@@ -18,14 +19,20 @@
 	console_loglevel = new_loglevel;
 
 #ifdef SUSPEND_CONSOLE
+	acquire_console_sem();
+
 	orig_fgconsole = fg_console;
 
-	if (vc_allocate(SUSPEND_CONSOLE))
+	if (vc_allocate(SUSPEND_CONSOLE)) {
 	  /* we can't have a free VC for now. Too bad,
 	   * we don't want to mess the screen for now. */
+		release_console_sem();
 		return 1;
+	}
 
 	set_console(SUSPEND_CONSOLE);
+	release_console_sem();
+
 	if (vt_waitactive(SUSPEND_CONSOLE)) {
 		pr_debug("Suspend: Can't switch VCs.");
 		return 1;
@@ -40,12 +47,9 @@
 {
 	console_loglevel = orig_loglevel;
 #ifdef SUSPEND_CONSOLE
+	acquire_console_sem();
 	set_console(orig_fgconsole);
-
-	/* FIXME: 
-	 * This following part is left over from swsusp. Is it really needed?
-	 */
-	update_screen(fg_console);
+	release_console_sem();
 #endif
 	return;
 }
diff -urN linux-2.5/kernel/printk.c linuxppc-2.5-benh/kernel/printk.c
--- linux-2.5/kernel/printk.c	2004-01-06 10:07:08.640948328 +1100
+++ linuxppc-2.5-benh/kernel/printk.c	2003-12-31 17:01:25.000000000 +1100
@@ -33,6 +33,11 @@
 
 #include <asm/uaccess.h>
 
+#ifdef CONFIG_BOOTX_TEXT
+#include <asm/btext.h>
+#endif
+
+
 #define __LOG_BUF_LEN	(1 << CONFIG_LOG_BUF_SHIFT)
 
 /* printk's without a loglevel use this.. */
@@ -62,6 +67,15 @@
  */
 static DECLARE_MUTEX(console_sem);
 struct console *console_drivers;
+/*
+ * This is used for debugging the mess that is the VT code by
+ * keeping track if we have the console semaphore held. It's
+ * definitely not the perfect debug tool (we don't know if _WE_
+ * hold it are racing, but it helps tracking those weird code
+ * path in the console code where we end up in places I want
+ * locked without the console sempahore held
+ */
+static int console_locked;
 
 /*
  * logbuf_lock protects log_buf, log_start, log_end, con_start and logged_chars
@@ -479,6 +493,9 @@
 	char *p;
 	static char printk_buf[1024];
 	static int log_level_unknown = 1;
+#ifdef CONFIG_BOOTX_TEXT
+	extern int force_printk_to_btext;
+#endif
 
 	if (oops_in_progress) {
 		/* If a crash is occurring, make sure we can't deadlock */
@@ -494,6 +511,10 @@
 	va_start(args, fmt);
 	printed_len = vsnprintf(printk_buf, sizeof(printk_buf), fmt, args);
 	va_end(args);
+#ifdef CONFIG_BOOTX_TEXT
+	if (force_printk_to_btext)
+		btext_drawstring(printk_buf);
+#endif /* CONFIG_BOOTX_TEXT */
 
 	/*
 	 * Copy the output into log_buf.  If the caller didn't provide
@@ -524,6 +545,7 @@
 		goto out;
 	}
 	if (!down_trylock(&console_sem)) {
+		console_locked = 1;
 		/*
 		 * We own the drivers.  We can drop the spinlock and let
 		 * release_console_sem() print the text
@@ -557,10 +579,17 @@
 	if (in_interrupt())
 		BUG();
 	down(&console_sem);
+	console_locked = 1;
 	console_may_schedule = 1;
 }
 EXPORT_SYMBOL(acquire_console_sem);
 
+int is_console_locked(void)
+{
+	return console_locked;
+}
+EXPORT_SYMBOL(is_console_locked);
+
 /**
  * release_console_sem - unlock the console system
  *
@@ -592,12 +621,14 @@
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 		call_console_drivers(_con_start, _log_end);
 	}
+	console_locked = 0;
 	console_may_schedule = 0;
 	up(&console_sem);
 	spin_unlock_irqrestore(&logbuf_lock, flags);
 	if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait))
 		wake_up_interruptible(&log_wait);
 }
+EXPORT_SYMBOL(release_console_sem);
 
 /** console_conditional_schedule - yield the CPU if required
  *
@@ -633,6 +664,7 @@
 	 */
 	if (down_trylock(&console_sem) != 0)
 		return;
+	console_locked = 1;
 	console_may_schedule = 0;
 	for (c = console_drivers; c != NULL; c = c->next)
 		if ((c->flags & CON_ENABLED) && c->unblank)
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

