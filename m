Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265540AbUBJEUi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 23:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265546AbUBJEUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 23:20:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:63631 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265540AbUBJEUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 23:20:34 -0500
Subject: [PATCH] drivers/char/vt possible race
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076386813.884.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 10 Feb 2004 15:20:13 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I falled again on the crash in con_do_write() with driver->data
beeing NULL. It happens during boot, when userland is playing
open/close games with tty's, I was intentionally typing keys like
mad during boot trying to trigger another problem when this one
poped up.

Looking at the code, I'm not sure how protected we are by the
above (tty) layer, paulus told me to not rely on anything like
locking coming from there, so I decided to extend the scope of
the console semaphore one more bit to cover races between calls
to con_open, con_close and con_write. Note that in con_do_write,
I intentionally drop the semaphore to avoid keeping it held
when waiting on the local buffer, and I added some sanity checks
on tty->driver_data with some printk's in case we still have
an open race by the tty layer. At least, now, the couple
vc_allocated & tty->driver_data should be protected though.

Andrew: I suggest putting that in -mm for a while, and if it
doesn't trigger any new problem, upstream, maybe without my
2 printk's "argh" :)

Ben.

diff -urN linux-2.5/drivers/char/vt.c linuxppc-2.5-benh/drivers/char/vt.c
--- linux-2.5/drivers/char/vt.c	2004-02-05 13:35:02.000000000 +1100
+++ linuxppc-2.5-benh/drivers/char/vt.c	2004-02-10 13:36:56.000000000 +1100
@@ -1883,14 +1883,24 @@
 	int c, tc, ok, n = 0, draw_x = -1;
 	unsigned int currcons;
 	unsigned long draw_from = 0, draw_to = 0;
-	struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
+	struct vt_struct *vt;
 	u16 himask, charmask;
 	const unsigned char *orig_buf = NULL;
 	int orig_count;
 
 	if (in_interrupt())
 		return count;
-		
+
+	might_sleep();
+
+	acquire_console_sem();
+	vt = (struct vt_struct *)tty->driver_data;
+	if (vt == NULL) {
+		printk(KERN_ERR "vt: argh, driver_data is NULL !\n");
+		release_console_sem();
+		return 0;
+	}
+
 	currcons = vt->vc_num;
 	if (!vc_cons_allocated(currcons)) {
 	    /* could this happen? */
@@ -1899,13 +1909,16 @@
 		error = 1;
 		printk("con_write: tty %d not allocated\n", currcons+1);
 	    }
+	    release_console_sem();
 	    return 0;
 	}
+	release_console_sem();
 
 	orig_buf = buf;
 	orig_count = count;
 
 	if (from_user) {
+
 		down(&con_buf_sem);
 
 again:
@@ -1929,6 +1942,13 @@
 
 	acquire_console_sem();
 
+	vt = (struct vt_struct *)tty->driver_data;
+	if (vt == NULL) {
+		printk(KERN_ERR "vt: argh, driver_data _became_ NULL !\n");
+		release_console_sem();
+		goto out;
+	}
+
 	himask = hi_font_mask;
 	charmask = himask ? 0x1ff : 0xff;
 
@@ -2442,14 +2462,16 @@
 
 	acquire_console_sem();
 	i = vc_allocate(currcons);
-	release_console_sem();
-	if (i)
+	if (i) {
+		release_console_sem();
 		return i;
-
+	}
 	vt_cons[currcons]->vc_num = currcons;
 	tty->driver_data = vt_cons[currcons];
 	vc_cons[currcons].d->vc_tty = tty;
 
+	release_console_sem();
+
 	if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
 		tty->winsize.ws_row = video_num_lines;
 		tty->winsize.ws_col = video_num_columns;
@@ -2467,10 +2489,12 @@
 		return;
 
 	vcs_remove_devfs(tty);
+	acquire_console_sem();
 	vt = (struct vt_struct*)tty->driver_data;
 	if (vt)
 		vc_cons[vt->vc_num].d->vc_tty = NULL;
 	tty->driver_data = 0;
+	release_console_sem();
 }
 
 static void vc_init(unsigned int currcons, unsigned int rows, unsigned int cols, int do_clear)


