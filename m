Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265628AbSLMXdn>; Fri, 13 Dec 2002 18:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbSLMXdn>; Fri, 13 Dec 2002 18:33:43 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:53729 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265628AbSLMXdl>; Fri, 13 Dec 2002 18:33:41 -0500
Date: Fri, 13 Dec 2002 16:34:11 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BK fbdev] Yet again more fbdev updates.
In-Reply-To: <Pine.LNX.4.44.0212131347240.10159-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212132236270.6237-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> James,
>  the fbcon update seems to have broken the plain VGA console. I get a page
> fault at vgacon_scroll+0x144, the call sequence seems to be:
>
> 	vt_console_print+0x203
> 	set_cursor+0x78
> 	vgacon_cursor+x0xb5
> 	scrup+0x122
> 	vgacon_scroll+0x144
>
> I don't know what triggers it, since it seems to happen pretty randomly.

Strange. I avoided touching that driver as much as possible. The other
strange error I have seen is vesa mode 791 for some reason stopped woking
on some boards. I just did a diff between 2.5.49 vgacon.c and the current
vgacon.c. The result is

--- /usr/src/linux-2.5.49/drivers/video/vgacon.c	Fri Sep 13 14:17:14 2002
+++ vgacon.c	Fri Dec 13 15:22:02 2002
@@ -41,7 +41,6 @@
 #include <linux/kernel.h>
 #include <linux/tty.h>
 #include <linux/console.h>
-#include <linux/console_struct.h>
 #include <linux/string.h>
 #include <linux/kd.h>
 #include <linux/slab.h>
@@ -180,6 +179,13 @@
 #endif
 	}

+	/* VGA16 modes are not handled by VGACON */
+	if ((ORIG_VIDEO_MODE == 0x0D) || /* 320x200/4 */
+	    (ORIG_VIDEO_MODE == 0x0E) || /* 640x200/4 */
+	    (ORIG_VIDEO_MODE == 0x10) || /* 640x350/4 */
+	    (ORIG_VIDEO_MODE == 0x12) || /* 640x480/4 */
+	    (ORIG_VIDEO_MODE == 0x6A))   /* 800x600/4, 0x6A is very common */
+		goto no_vga;

 	vga_video_num_lines = ORIG_VIDEO_LINES;
 	vga_video_num_columns = ORIG_VIDEO_COLS;
@@ -838,8 +844,8 @@
 static int
 vgacon_adjust_height(unsigned fontheight)
 {
-	int rows, maxscan;
 	unsigned char ovr, vde, fsr;
+	int rows, maxscan, i;

 	if (fontheight == vga_video_font_height)
 		return 0;
@@ -881,7 +887,12 @@
 	outb_p( vde, vga_video_port_val );
 	spin_unlock_irq(&vga_lock);

-	vc_resize_all(rows, 0);			/* Adjust console size */
+	for (i = 0; i < MAX_NR_CONSOLES; i++) {
+		struct vc_data *c = vc_cons[i].d;
+
+		if (c && c->vc_sw == &vga_con)
+			vc_resize(c->vc_num, 0, rows);	/* Adjust console size */
+	}
 	return 0;
 }

  Now the first chuck of code was from a vga16fb patch. Originally you
could set a vga graphical mode that was standard but not apart of the VESA
number range (100+) and vgacon would still start. This prevented it.
To the people having trouble setting VESA fb mode 791 remove this code and
tell me if your problem goes away.
   The second possible source is in vga_adjust_height. This is called when
you change your font set from userland. I attempted to change my font and
didn't have a problem.
   The err you are talking about that is having issues in vgacon_scroll is

c->vc_origin = vga_vram_end - c->vc_screenbuf_size;

Which is when dir equals SM_DOWN and the old origin minus the amount we
scroll is less than A000 (vga_vram_base). Its just strange. I'm going to
stress test vgacon to see what is going on.



