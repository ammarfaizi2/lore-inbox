Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272163AbRHVXf4>; Wed, 22 Aug 2001 19:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272162AbRHVXfr>; Wed, 22 Aug 2001 19:35:47 -0400
Received: from mailhub1.almaden.ibm.com ([198.4.83.44]:55305 "EHLO
	mailhub1.almaden.ibm.com") by vger.kernel.org with ESMTP
	id <S272161AbRHVXfg>; Wed, 22 Aug 2001 19:35:36 -0400
Message-ID: <3B8441A7.63D721B@almaden.ibm.com>
Date: Wed, 22 Aug 2001 16:35:03 -0700
From: Benjamin Reed <breed@almaden.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: BUG/PATCH:  Unable to specify console=ttyX where X != 0
Content-Type: multipart/mixed;
 boundary="------------2DCDFA0BB3C44BB5407C68B6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2DCDFA0BB3C44BB5407C68B6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The serial_console.txt file implies that you can specify other vt's
beside tty0 to use as a console using the console= kernel parameter. 
However, if you specify any ttyX it always goes to tty0.  Closer
examination shows that when the console is registered it is ignoring the
specified tty.

Basically, I want all the kernel messages to go to tty2 so that I can
have a nice clean user interaction on tty1, but still allow access to
kernel messages on tty2.

The following patch sets up the correct tty to send the messages to
based on the console= parameter and initializes the virtual terminal.

enjoy

ben
--------------2DCDFA0BB3C44BB5407C68B6
Content-Type: text/plain; charset=us-ascii;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- console.c.old	Sun Aug 12 10:02:17 2001
+++ console.c	Wed Aug 22 16:17:11 2001
@@ -2369,6 +2369,21 @@
 
 DECLARE_TASKLET_DISABLED(console_tasklet, console_softint, 0);
 
+void __init con_setup_vt(unsigned int currcons)
+{
+        if (vc_cons[currcons].d) return;
+
+        vc_cons[currcons].d = (struct vc_data *)
+                              alloc_bootmem(sizeof(struct vc_data));
+        vt_cons[currcons] = (struct vt_struct *)
+                            alloc_bootmem(sizeof(struct vt_struct));
+        visual_init(currcons, 1);
+        screenbuf = (unsigned short *) alloc_bootmem(screenbuf_size);
+        kmalloced = 0;
+        vc_init(currcons, video_num_lines, video_num_columns,
+                currcons || !sw->con_save_screen);
+}
+
 void __init con_init(void)
 {
 	const char *display_desc = NULL;
@@ -2427,15 +2442,7 @@
 	 * kmalloc is not running yet - we use the bootmem allocator.
 	 */
 	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
-		vc_cons[currcons].d = (struct vc_data *)
-				alloc_bootmem(sizeof(struct vc_data));
-		vt_cons[currcons] = (struct vt_struct *)
-				alloc_bootmem(sizeof(struct vt_struct));
-		visual_init(currcons, 1);
-		screenbuf = (unsigned short *) alloc_bootmem(screenbuf_size);
-		kmalloced = 0;
-		vc_init(currcons, video_num_lines, video_num_columns, 
-			currcons || !sw->con_save_screen);
+                con_setup_vt(currcons);
 	}
 	currcons = fg_console = 0;
 	master_display_fg = vc_cons[currcons].d;
@@ -2452,6 +2459,11 @@
 
 #ifdef CONFIG_VT_CONSOLE
 	register_console(&vt_console_driver);
+        if (vt_console_driver.index > 0 &&
+	    vt_console_driver.index < MAX_NR_CONSOLES) {
+                con_setup_vt(vt_console_driver.index-1);
+                kmsg_redirect = vt_console_driver.index;
+        }
 #endif
 
 	tasklet_enable(&console_tasklet);

--------------2DCDFA0BB3C44BB5407C68B6--

