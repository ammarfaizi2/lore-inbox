Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131611AbRCOIkX>; Thu, 15 Mar 2001 03:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRCOIkF>; Thu, 15 Mar 2001 03:40:05 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:17567 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131662AbRCOIkB>; Thu, 15 Mar 2001 03:40:01 -0500
Message-ID: <3AB08010.B811B96B@uow.edu.au>
Date: Thu, 15 Mar 2001 19:40:48 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [patch] console and bust_spinlocks() fixes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three things.

- Adds lib/bust_spinlocks.c for architectures which don't
  provide bust_spinlocks() .

- Closes a race between tioclinux() and console scrolling
  which was leaving bits of stuff on the screen when the
  mouse was used with gpm. 

- Added a missing break statement in do_syslog() (James Simmons) 


Patch against -ac20 is here.  The full `remove console_lock' patch
against 2.4.3-pre4 is at http://www.uow.edu.au/~andrewm/linux/console.html



--- linux-2.4.2-ac20/drivers/char/console.c	Tue Mar 13 20:29:21 2001
+++ ac/drivers/char/console.c	Tue Mar 13 21:12:47 2001
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
--- linux-2.4.2-ac20/drivers/video/fbcon.c	Tue Mar 13 20:29:28 2001
+++ ac/drivers/video/fbcon.c	Tue Mar 13 21:11:29 2001
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
--- linux-2.4.2-ac20/kernel/printk.c	Tue Mar 13 20:29:30 2001
+++ ac/kernel/printk.c	Thu Mar 15 18:12:46 2001
@@ -267,6 +267,7 @@
 		spin_lock_irq(&logbuf_lock);
 		error = log_end - log_start;
 		spin_unlock_irq(&logbuf_lock);
+		break;
 	default:
 		error = -EINVAL;
 		break;
--- linux-2.4.2-ac20/lib/Makefile	Sat Dec 30 09:07:24 2000
+++ ac/lib/Makefile	Thu Mar 15 18:26:19 2001
@@ -10,7 +10,7 @@
 
 export-objs := cmdline.o
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   obj-y += dec_and_lock.o
--- linux-2.4.2-ac20/lib/bust_spinlocks.c	Thu Jan  1 00:00:00 1970
+++ ac/lib/bust_spinlocks.c	Thu Mar 15 18:28:28 2001
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
+		 * without oops_in_progress set so that printk will give klogd
+		 * and the blankded console a poke.  Hold onto your hats...
+		 */
+		console_loglevel = 15;		/* NMI oopser may have shut the console up */
+		printk(" ");
+		console_loglevel = loglevel_save;
+	}
+}
+
+
