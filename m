Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265751AbUAKEWe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 23:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265756AbUAKEWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 23:22:32 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:21438 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265751AbUAKEWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 23:22:03 -0500
Subject: Re: VT locking patch #2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@infradead.org>
In-Reply-To: <1073792656.750.82.camel@gaston>
References: <1073792656.750.82.camel@gaston>
Content-Type: text/plain
Message-Id: <1073794650.750.84.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 15:17:31 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-11 at 14:44, Benjamin Herrenschmidt wrote:
> Hi Andrew !
> 
> Here's a new version of the patch, against 2.6.1 bk.
> 
> I went more in depth into some of the calls in vt_ioctl and I think
> fixed a few more races along with a possible false-positive. I added
> the check for oops in progress too.
> 
> There are matching bits that have to go to fbdev as well, they'll be
> part of the fbdev merge.
> 
> James: Do no include this patch with your big fbdev patches please,
> it makes things more confusing. I'll send you separately the patches
> to apply to fbdev to add locking in the right place.

And with the patch attached...

===== drivers/char/selection.c 1.6 vs edited =====
--- 1.6/drivers/char/selection.c	Thu Jun 12 12:54:19 2003
+++ edited/drivers/char/selection.c	Sun Jan 11 13:58:58 2004
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
===== drivers/char/tty_io.c 1.127 vs edited =====
--- 1.127/drivers/char/tty_io.c	Wed Oct 22 14:42:38 2003
+++ edited/drivers/char/tty_io.c	Sun Jan 11 13:57:14 2004
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
===== drivers/char/vt.c 1.56 vs edited =====
--- 1.56/drivers/char/vt.c	Fri Oct 10 08:13:53 2003
+++ edited/drivers/char/vt.c	Sun Jan 11 13:58:25 2004
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
@@ -337,6 +343,8 @@
 
 void update_region(int currcons, unsigned long start, int count)
 {
+	WARN_CONSOLE_UNLOCKED();
+       
 	if (DO_UPDATE) {
 		hide_cursor(currcons);
 		do_update_region(currcons, start, count);
@@ -400,6 +408,8 @@
 {
 	unsigned short *p;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	count /= 2;
 	p = screenpos(currcons, offset, viewed);
 	if (sw->con_invert_region)
@@ -445,6 +455,8 @@
 	static unsigned short old;
 	static unsigned short oldx, oldy;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	if (p) {
 		scr_writew(old, p);
 		if (DO_UPDATE)
@@ -559,6 +571,8 @@
 
 static void set_origin(int currcons)
 {
+	WARN_CONSOLE_UNLOCKED();
+
 	if (!IS_VISIBLE ||
 	    !sw->con_set_origin ||
 	    !sw->con_set_origin(vc_cons[currcons].d))
@@ -570,6 +584,8 @@
 
 static inline void save_screen(int currcons)
 {
+	WARN_CONSOLE_UNLOCKED();
+
 	if (sw->con_save_screen)
 		sw->con_save_screen(vc_cons[currcons].d);
 }
@@ -583,6 +599,8 @@
 	int redraw = 1;
 	int currcons, old_console;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	if (!vc_cons_allocated(new_console)) {
 		/* strange ... */
 		/* printk("redraw_screen: tty %d not allocated ??\n", new_console+1); */
@@ -660,6 +678,8 @@
 
 int vc_allocate(unsigned int currcons)	/* return 0 on success */
 {
+	WARN_CONSOLE_UNLOCKED();
+
 	if (currcons >= MAX_NR_CONSOLES)
 		return -ENXIO;
 	if (!vc_cons[currcons].d) {
@@ -726,6 +746,8 @@
 	unsigned int new_cols, new_rows, new_row_size, new_screen_size;
 	unsigned short *newscreen;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	if (!vc_cons_allocated(currcons))
 		return -ENXIO;
 
@@ -812,7 +834,8 @@
 
 void vc_disallocate(unsigned int currcons)
 {
-	acquire_console_sem();
+	WARN_CONSOLE_UNLOCKED();
+
 	if (vc_cons_allocated(currcons)) {
 	    sw->con_deinit(vc_cons[currcons].d);
 	    if (kmalloced)
@@ -821,7 +844,6 @@
 		kfree(vc_cons[currcons].d);
 	    vc_cons[currcons].d = NULL;
 	}
-	release_console_sem();
 }
 
 /*
@@ -2076,6 +2098,10 @@
 			sw->con_scrolldelta(vc_cons[currcons].d, scrollback_delta);
 		scrollback_delta = 0;
 	}
+	if (blank_timer_expired) {
+		do_blank_screen(0);
+		blank_timer_expired = 0;
+	}
 
 	release_console_sem();
 }
@@ -2409,7 +2435,9 @@
 
 	currcons = tty->index;
 
+	acquire_console_sem();
 	i = vc_allocate(currcons);
+	release_console_sem();
 	if (i)
 		return i;
 
@@ -2475,16 +2503,20 @@
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
 
@@ -2515,6 +2547,8 @@
 	printable = 1;
 	printk("\n");
 
+	release_console_sem();
+
 #ifdef CONFIG_VT_CONSOLE
 	register_console(&vt_console_driver);
 #endif
@@ -2594,8 +2628,13 @@
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
 
@@ -2635,6 +2674,8 @@
 		       desc, vc_cons[j].d->vc_cols, vc_cons[j].d->vc_rows);
 	else
 		printk("to %s\n", desc);
+
+	release_console_sem();
 }
 
 void give_up_console(const struct consw *csw)
@@ -2683,23 +2724,24 @@
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
+	WARN_CONSOLE_UNLOCKED();
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
@@ -2718,9 +2760,8 @@
 	}
 
 	hide_cursor(currcons);
-	if (!from_timer_handler)
-		del_timer_sync(&console_timer);
-	console_timer.function = unblank_screen_t;
+	del_timer_sync(&console_timer);
+	blank_timer_expired = 0;
 
 	save_screen(currcons);
 	/* In case we need to reset origin, blanking hook returns 1 */
@@ -2733,7 +2774,7 @@
 		return;
 
 	if (vesa_off_interval) {
-		console_timer.function = vesa_powerdown_screen;
+		blank_state = blank_vesa_wait,
 		mod_timer(&console_timer, jiffies + vesa_off_interval);
 	}
 
@@ -2741,18 +2782,6 @@
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
@@ -2761,6 +2790,8 @@
 {
 	int currcons;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	ignore_poke = 0;
 	if (!console_blanked)
 		return;
@@ -2773,9 +2804,9 @@
 	if (vcmode != KD_TEXT)
 		return; /* but leave console_blanked != 0 */
 
-	console_timer.function = blank_screen;
 	if (blankinterval) {
 		mod_timer(&console_timer, jiffies + blankinterval);
+		blank_state = blank_normal_wait;
 	}
 
 	console_blanked = 0;
@@ -2789,23 +2820,33 @@
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
+	WARN_CONSOLE_UNLOCKED();
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
 
@@ -2815,6 +2856,8 @@
 
 void set_palette(int currcons)
 {
+	WARN_CONSOLE_UNLOCKED();
+
 	if (vcmode != KD_GRAPHICS)
 		sw->con_set_palette(vc_cons[currcons].d, color_table);
 }
@@ -2823,6 +2866,8 @@
 {
     int i, j, k;
 
+    WARN_CONSOLE_UNLOCKED();
+
     for (i = 0; i < 16; i++)
 	if (set) {
 	    get_user(default_red[i], arg++);
@@ -2854,12 +2899,24 @@
 
 int con_set_cmap(unsigned char *arg)
 {
-	return set_get_cmap (arg,1);
+	int rc;
+
+	acquire_console_sem();
+	rc = set_get_cmap (arg,1);
+	release_console_sem();
+
+	return rc;
 }
 
 int con_get_cmap(unsigned char *arg)
 {
-	return set_get_cmap (arg,0);
+	int rc;
+
+	acquire_console_sem();
+	rc = set_get_cmap (arg,0);
+	release_console_sem();
+
+	return rc;
 }
 
 void reset_palette(int currcons)
@@ -2933,8 +2990,12 @@
 		set = 1;
 	} else if (op->op == KD_FONT_OP_GET)
 		set = 0;
-	else
-		return sw->con_font_op(vc_cons[currcons].d, op);
+	else {
+		acquire_console_sem();
+		rc = sw->con_font_op(vc_cons[currcons].d, op);
+		release_console_sem();
+		return rc;
+	}
 	if (op->data) {
 		temp = kmalloc(size, GFP_KERNEL);
 		if (!temp)
@@ -3029,10 +3090,14 @@
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
===== drivers/char/vt_ioctl.c 1.32 vs edited =====
--- 1.32/drivers/char/vt_ioctl.c	Tue Dec 30 08:38:05 2003
+++ edited/drivers/char/vt_ioctl.c	Sun Jan 11 13:58:48 2004
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
@@ -665,18 +670,29 @@
 			return -EFAULT;
 		if (tmp.mode != VT_AUTO && tmp.mode != VT_PROCESS)
 			return -EINVAL;
+		acquire_console_sem();
 		vt_cons[console]->vt_mode = tmp;
 		/* the frsig is ignored, so we set it to 0 */
 		vt_cons[console]->vt_mode.frsig = 0;
 		vt_cons[console]->vt_pid = current->pid;
 		/* no switch is required -- saw@shade.msu.ru */
 		vt_cons[console]->vt_newvt = -1; 
+		release_console_sem();
 		return 0;
 	}
 
 	case VT_GETMODE:
-		return copy_to_user((void*)arg, &(vt_cons[console]->vt_mode), 
-							sizeof(struct vt_mode)) ? -EFAULT : 0; 
+	{
+		struct vt_mode tmp;
+		int rc;
+		
+		acquire_console_sem();
+		memcpy(&tmp, &vt_cons[console]->vt_mode, sizeof(struct vt_mode));
+		release_console_sem();
+
+		rc = copy_to_user((void*)arg, &tmp, sizeof(struct vt_mode));
+		return rc ? -EFAULT : 0;		
+	}
 
 	/*
 	 * Returns global vt state. Note that VT 0 is always open, since
@@ -718,7 +734,9 @@
 		if (arg == 0 || arg > MAX_NR_CONSOLES)
 			return -ENXIO;
 		arg--;
+		acquire_console_sem();
 		i = vc_allocate(arg);
+		release_console_sem();
 		if (i)
 			return i;
 		set_console(arg);
@@ -768,17 +786,20 @@
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
@@ -806,16 +827,21 @@
 			return -ENXIO;
 		if (arg == 0) {
 		    /* disallocate all unused consoles, but leave 0 */
-		    for (i=1; i<MAX_NR_CONSOLES; i++)
-		      if (! VT_BUSY(i))
-			vc_disallocate(i);
+			acquire_console_sem();
+			for (i=1; i<MAX_NR_CONSOLES; i++)
+				if (! VT_BUSY(i))
+					vc_disallocate(i);
+			release_console_sem();
 		} else {
-		    /* disallocate a single console, if possible */
-		    arg--;
-		    if (VT_BUSY(arg))
-		      return -EBUSY;
-		    if (arg)			      /* leave 0 */
-		      vc_disallocate(arg);
+			/* disallocate a single console, if possible */
+			arg--;
+			if (VT_BUSY(arg))
+				return -EBUSY;
+			if (arg) {			      /* leave 0 */
+				acquire_console_sem();
+				vc_disallocate(arg);
+				release_console_sem();
+			}
 		}
 		return 0;
 
@@ -828,8 +854,11 @@
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
 
@@ -870,11 +899,13 @@
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
===== include/linux/console.h 1.10 vs edited =====
--- 1.10/include/linux/console.h	Tue Dec 30 12:01:55 2003
+++ edited/include/linux/console.h	Sun Jan 11 13:59:31 2004
@@ -102,6 +102,14 @@
 extern void release_console_sem(void);
 extern void console_conditional_schedule(void);
 extern void console_unblank(void);
+extern int is_console_locked(void);
+
+/* Some debug stub to catch some of the obvious races in the VT code */
+#if 1
+#define WARN_CONSOLE_UNLOCKED()	WARN_ON(!is_console_locked() && !oops_in_progress)
+#else
+#define WARN_CONSOLE_UNLOCKED()
+#endif
 
 /* VESA Blanking Levels */
 #define VESA_NO_BLANKING        0
===== kernel/printk.c 1.30 vs edited =====
--- 1.30/kernel/printk.c	Wed Dec 31 08:49:22 2003
+++ edited/kernel/printk.c	Sun Jan 11 14:00:01 2004
@@ -62,6 +62,15 @@
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
@@ -524,6 +533,7 @@
 		goto out;
 	}
 	if (!down_trylock(&console_sem)) {
+		console_locked = 1;
 		/*
 		 * We own the drivers.  We can drop the spinlock and let
 		 * release_console_sem() print the text
@@ -557,10 +567,17 @@
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
@@ -592,12 +609,14 @@
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
@@ -633,6 +652,7 @@
 	 */
 	if (down_trylock(&console_sem) != 0)
 		return;
+	console_locked = 1;
 	console_may_schedule = 0;
 	for (c = console_drivers; c != NULL; c = c->next)
 		if ((c->flags & CON_ENABLED) && c->unblank)
===== kernel/power/console.c 1.5 vs edited =====
--- 1.5/kernel/power/console.c	Sat Aug 23 06:15:05 2003
+++ edited/kernel/power/console.c	Sun Jan 11 14:00:10 2004
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


