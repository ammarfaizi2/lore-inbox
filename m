Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWHHLpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWHHLpV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 07:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWHHLpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 07:45:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58589 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964772AbWHHLpU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 07:45:20 -0400
Subject: PATCH: tty locking on resize
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Aug 2006 13:04:59 +0100
Message-Id: <1155038699.5729.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current kernel serializes console resizes but does not serialize the
resize against the tty structure updates. This means that while two
parallel resizes cannot mess up the console you can get incorrect
results reported.

Secondly while doing this I added vc_lock_resize() to lock and resize
the console. This leaves all knowledge of the console_sem in the
vt/console driver and kicks it out of the tty layer, which is good

Thirdly while doing this I decided I couldn't stand "disallocate" any
longer so I switched it to "deallocate".

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc3-mm2/drivers/char/selection.c linux-2.6.18-rc3-mm2/drivers/char/selection.c
--- linux.vanilla-2.6.18-rc3-mm2/drivers/char/selection.c	2006-08-07 16:15:18.000000000 +0100
+++ linux-2.6.18-rc3-mm2/drivers/char/selection.c	2006-08-07 16:28:52.000000000 +0100
@@ -33,7 +33,7 @@
 
 /* Variables for selection control. */
 /* Use a dynamic buffer, instead of static (Dec 1994) */
-struct vc_data *sel_cons;		/* must not be disallocated */
+struct vc_data *sel_cons;		/* must not be deallocated */
 static volatile int sel_start = -1; 	/* cleared by clear_selection */
 static int sel_end;
 static int sel_buffer_lth;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc3-mm2/drivers/char/vt.c linux-2.6.18-rc3-mm2/drivers/char/vt.c
--- linux.vanilla-2.6.18-rc3-mm2/drivers/char/vt.c	2006-08-07 16:20:33.000000000 +0100
+++ linux-2.6.18-rc3-mm2/drivers/char/vt.c	2006-08-07 23:54:01.000000000 +0100
@@ -885,8 +885,17 @@
 	return err;
 }
 
+int vc_lock_resize(struct vc_data *vc, unsigned int cols, unsigned int lines)
+{
+	int rc;
+
+	acquire_console_sem();
+	rc = vc_resize(vc, cols, lines);
+	release_console_sem();
+	return rc;
+}
 
-void vc_disallocate(unsigned int currcons)
+void vc_deallocate(unsigned int currcons)
 {
 	WARN_CONSOLE_UNLOCKED();
 
@@ -3788,6 +3797,7 @@
 EXPORT_SYMBOL(update_region);
 EXPORT_SYMBOL(redraw_screen);
 EXPORT_SYMBOL(vc_resize);
+EXPORT_SYMBOL(vc_lock_resize);
 EXPORT_SYMBOL(fg_console);
 EXPORT_SYMBOL(console_blank_hook);
 EXPORT_SYMBOL(console_blanked);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc3-mm2/drivers/char/vt_ioctl.c linux-2.6.18-rc3-mm2/drivers/char/vt_ioctl.c
--- linux.vanilla-2.6.18-rc3-mm2/drivers/char/vt_ioctl.c	2006-08-07 16:15:18.000000000 +0100
+++ linux-2.6.18-rc3-mm2/drivers/char/vt_ioctl.c	2006-08-07 16:30:47.000000000 +0100
@@ -96,7 +96,7 @@
 		if (!perm)
 			return -EPERM;
 		if (!i && v == K_NOSUCHMAP) {
-			/* disallocate map */
+			/* deallocate map */
 			key_map = key_maps[s];
 			if (s && key_map) {
 			    key_maps[s] = NULL;
@@ -819,20 +819,20 @@
 		if (arg > MAX_NR_CONSOLES)
 			return -ENXIO;
 		if (arg == 0) {
-		    /* disallocate all unused consoles, but leave 0 */
+		    /* deallocate all unused consoles, but leave 0 */
 			acquire_console_sem();
 			for (i=1; i<MAX_NR_CONSOLES; i++)
 				if (! VT_BUSY(i))
-					vc_disallocate(i);
+					vc_deallocate(i);
 			release_console_sem();
 		} else {
-			/* disallocate a single console, if possible */
+			/* deallocate a single console, if possible */
 			arg--;
 			if (VT_BUSY(arg))
 				return -EBUSY;
 			if (arg) {			      /* leave 0 */
 				acquire_console_sem();
-				vc_disallocate(arg);
+				vc_deallocate(arg);
 				release_console_sem();
 			}
 		}
@@ -847,11 +847,8 @@
 		if (get_user(ll, &vtsizes->v_rows) ||
 		    get_user(cc, &vtsizes->v_cols))
 			return -EFAULT;
-		for (i = 0; i < MAX_NR_CONSOLES; i++) {
-			acquire_console_sem();
-			vc_resize(vc_cons[i].d, cc, ll);
-			release_console_sem();
-		}
+		for (i = 0; i < MAX_NR_CONSOLES; i++)
+			vc_lock_resize(vc_cons[i].d, cc, ll);
 		return 0;
 	}
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc3-mm2/include/linux/vt_kern.h linux-2.6.18-rc3-mm2/include/linux/vt_kern.h
--- linux.vanilla-2.6.18-rc3-mm2/include/linux/vt_kern.h	2006-08-07 16:15:59.000000000 +0100
+++ linux-2.6.18-rc3-mm2/include/linux/vt_kern.h	2006-08-07 17:13:26.000000000 +0100
@@ -33,7 +33,8 @@
 int vc_allocate(unsigned int console);
 int vc_cons_allocated(unsigned int console);
 int vc_resize(struct vc_data *vc, unsigned int cols, unsigned int lines);
-void vc_disallocate(unsigned int console);
+int vc_lock_resize(struct vc_data *vc, unsigned int cols, unsigned int lines);
+void vc_deallocate(unsigned int console);
 void reset_palette(struct vc_data *vc);
 void do_blank_screen(int entering_gfx);
 void do_unblank_screen(int leaving_gfx);
--- linux.vanilla-2.6.18-rc3-mm2/drivers/char/tty_io.c	2006-08-07 16:20:33.000000000 +0100
+++ linux-2.6.18-rc3-mm2/drivers/char/tty_io.c	2006-08-08 12:16:15.200878984 +0100
@@ -2770,12 +2770,11 @@
  *	actually has driver level meaning and triggers a VC resize.
  *
  *	Locking:
- *		The console_sem is used to ensure we do not try and resize
- *	the console twice at once.
- *	FIXME: Two racing size sets may leave the console and kernel
- *		parameters disagreeing. Is this exploitable ?
- *	FIXME: Random values racing a window size get is wrong
- *	should lock here against that
+ *		Called function use the console_sem is used to ensure we do
+ *	not try and resize the console twice at once.
+ *		The tty->termios_sem is used to ensure we don't double
+ *	resize and get confused. Lock order - tty->termios.sem before
+ *	console sem
  */
 
 static int tiocswinsz(struct tty_struct *tty, struct tty_struct *real_tty,
@@ -2785,17 +2784,17 @@
 
 	if (copy_from_user(&tmp_ws, arg, sizeof(*arg)))
 		return -EFAULT;
+
+	down(&tty->termios_sem);
 	if (!memcmp(&tmp_ws, &tty->winsize, sizeof(*arg)))
-		return 0;
+		goto done;
+
 #ifdef CONFIG_VT
 	if (tty->driver->type == TTY_DRIVER_TYPE_CONSOLE) {
-		int rc;
-
-		acquire_console_sem();
-		rc = vc_resize(tty->driver_data, tmp_ws.ws_col, tmp_ws.ws_row);
-		release_console_sem();
-		if (rc)
-			return -ENXIO;
+		if (vc_lock_resize(tty->driver_data, tmp_ws.ws_col, tmp_ws.ws_row)) {
+			up(&tty->termios_sem);
+ 			return -ENXIO;
+		}
 	}
 #endif
 	if (tty->pgrp > 0)
@@ -2804,6 +2803,8 @@
 		kill_pg(real_tty->pgrp, SIGWINCH, 1);
 	tty->winsize = tmp_ws;
 	real_tty->winsize = tmp_ws;
+done:	
+	up(&tty->termios_sem);
 	return 0;
 }
 

