Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbVAKP3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVAKP3V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 10:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbVAKP3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 10:29:20 -0500
Received: from mail.suse.de ([195.135.220.2]:48073 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262796AbVAKP2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 10:28:37 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qq1xL7tEkK"
Content-Transfer-Encoding: 7bit
Message-ID: <16867.58009.828782.164427@xf14.fra.suse.de>
Date: Tue, 11 Jan 2005 15:28:41 +0100
From: Egbert Eich <eich@suse.de>
To: linux-kernel@vger.kernel.org
Cc: eich@suse.de
Subject: vgacon fixes to help font restauration in X11
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qq1xL7tEkK
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit


[Please leave me in Cc as I'm not subscribed to this list]

So far the X.Org/XFree86 Xservers use internal functions to 
perform saving/restoring of console fonts. This doesn't work 
under all circumstances and has disadvantages:

1. On some platforms (IA64) X needs to POST the BIOS before
   it even has a chance to access the hardware itself. This POSTing 
   will usually undo any changes to the graphics hardware that the 
   kernel may have done.
2. More and more drivers fully rely on BIOS support. However
   the BIOS functions which could be used to save/restore 
   register settings may be broken so the only way of mode
   save/restore is getting/setting the BIOS mode ID.
   This will restore the BIOSes default fonts, not the custom font
   that the user may have loaded.

I would like to utilize the kernels save/restore console 
fonts ioctls to save/restore the text mode console fonts 
from inside X. 

The patch does two things:

1. Eliminates the optimization that returns from vgacon_adjust_height()
   early (without reprogramming the HW) when the hight of the font hasn't
   changed.
2. Resets the stored 'from' and 'to' lines for the text cursor in
   vgacon_adjust_height() to cause vgacon_set_cursor_size() reprogram 
   the textcursor start and end line.

These are necessary to sanitize the HW in case something other than
the kernel has changed the register values without restoring them 
properly.

I'm fully aware that in the long run we will need to look into a new 
driver model for graphics where no two instances fight over who gets
register access. However such a model won't be created nor will we get 
the majority of the drivers ported over night.
Therefore we need to find an interim solution for the most pressing 
problems.


Egbert.

<Patch against latest snapshot>

--Qq1xL7tEkK
Content-Type: text/plain
Content-Disposition: inline;
	filename="diff.vgacon"
Content-Transfer-Encoding: 7bit

Index: drivers/video/console/vgacon.c
===================================================================
RCS file: /work/kernelcvs/linux/drivers/video/console/vgacon.c,v
retrieving revision 1.1.1.2
diff -u -p -r1.1.1.2 vgacon.c
--- drivers/video/console/vgacon.c	11 Jan 2005 10:27:11 -0000	1.1.1.2
+++ drivers/video/console/vgacon.c	11 Jan 2005 13:40:19 -0000
@@ -54,6 +54,7 @@
 #include <asm/io.h>
 
 static spinlock_t vga_lock = SPIN_LOCK_UNLOCKED;
+static int cursor_size_lastfrom = 0, cursor_size_lastto = 0;
 static struct vgastate state;
 
 #define BLANK 0x0020
@@ -409,17 +410,16 @@ static void vgacon_set_cursor_size(int x
 {
 	unsigned long flags;
 	int curs, cure;
-	static int lastfrom, lastto;
 
 #ifdef TRIDENT_GLITCH
 	if (xpos < 16)
 		from--, to--;
 #endif
 
-	if ((from == lastfrom) && (to == lastto))
+	if ((from == cursor_size_lastfrom) && (to == cursor_size_lastto))
 		return;
-	lastfrom = from;
-	lastto = to;
+	cursor_size_lastfrom = from;
+	cursor_size_lastto = to;
 
 	spin_lock_irqsave(&vga_lock, flags);
 	outb_p(0x0a, vga_video_port_reg);	/* Cursor start */
@@ -862,11 +862,6 @@ static int vgacon_adjust_height(struct v
 	unsigned char ovr, vde, fsr;
 	int rows, maxscan, i;
 
-	if (fontheight == vc->vc_font.height)
-		return 0;
-
-	vc->vc_font.height = fontheight;
-
 	rows = vc->vc_scan_lines / fontheight;	/* Number of video rows we end up with */
 	maxscan = rows * fontheight - 1;	/* Scan lines to actually display-1 */
 
@@ -905,6 +900,11 @@ static int vgacon_adjust_height(struct v
 		struct vc_data *c = vc_cons[i].d;
 
 		if (c && c->vc_sw == &vga_con) {
+			if( CON_IS_VISIBLE(c)) {
+			        /* void size to cause regs to be rewritten */
+				cursor_size_lastfrom = cursor_size_lastto = 0;
+				c->vc_sw->con_cursor(c, CM_DRAW);
+			}
 			c->vc_font.height = fontheight;
 			vc_resize(c->vc_num, 0, rows);	/* Adjust console size */
 		}

--Qq1xL7tEkK--
