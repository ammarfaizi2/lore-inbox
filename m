Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131465AbQKUWWC>; Tue, 21 Nov 2000 17:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131533AbQKUWVw>; Tue, 21 Nov 2000 17:21:52 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:8965 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S131465AbQKUWVk>;
	Tue, 21 Nov 2000 17:21:40 -0500
Date: Tue, 21 Nov 2000 23:51:25 +0200 (EET)
From: <jani@virtualro.ic.ro>
To: jsimmons@suse.com
cc: linux-kernel@vger.kernel.org
Subject: [patch] some cleanup in vgacon.c 
Message-ID: <Pine.LNX.4.10.10011212336210.11105-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James 
	this is a newer cleaning patch for vgacon.c against test11.
It includes the one I sent a couple of days ago.Could you check this too
and if OK send it to Linus?Unless of course it violates the code-freeze
policy :-)

Thanks,
	 Jani.

It does the following

1)Removes explicit static initialisation

2)Removes a duplicated code line in vgacon_scroll

3)Removes the static variable vga_hardscroll_user_enable which I guess was 
superfluous since it was only indirectly used by vga_hardscroll_enabled.
The no-scroll option still works for me :-)

4)Removed 3 #includes: fs.h ,sched.h and malloc.h seem never to be used,
and besides fs.h is very large :-).I think string.h isn't needed either
but maybe on non x86 ?
It compiles and works without them and I hope no other architecture uses
these headers in vgacon.It would be awkward....


--- /usr/src/patches/original/vgacon/vgacon.c	Tue Nov 21 22:52:04 2000
+++ vgacon.c	Tue Nov 21 23:34:33 2000
@@ -35,15 +35,12 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
-#include <linux/sched.h>
-#include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/tty.h>
 #include <linux/console.h>
 #include <linux/console_struct.h>
 #include <linux/string.h>
 #include <linux/kd.h>
-#include <linux/malloc.h>
 #include <linux/vt_kern.h>
 #include <linux/selection.h>
 #include <linux/spinlock.h>
@@ -104,17 +101,17 @@
 static u16             vga_video_port_val;	/* Video register value port */
 static unsigned int    vga_video_num_columns;	/* Number of text columns */
 static unsigned int    vga_video_num_lines;	/* Number of text lines */
-static int	       vga_can_do_color = 0;	/* Do we support colors? */
+static int	       vga_can_do_color;	/* Do we support colors? */
 static unsigned int    vga_default_font_height;	/* Height of default screen font */
 static unsigned char   vga_video_type;		/* Card type */
-static unsigned char   vga_hardscroll_enabled;
+
 #ifdef CONFIG_IA64_SOFTSDV_HACKS
 /*
  * SoftSDV doesn't have hardware assist VGA scrolling 
  */
-static unsigned char   vga_hardscroll_user_enable = 0;
+static unsigned char   vga_hardscroll_enabled; 
 #else
-static unsigned char   vga_hardscroll_user_enable = 1;
+static unsigned char   vga_hardscroll_enabled = 1; 
 #endif
 static unsigned char   vga_font_is_default = 1;
 static int	       vga_vesa_blanked;
@@ -122,7 +119,7 @@
 static int	       vga_is_gfx;
 static int	       vga_512_chars;
 static int	       vga_video_font_height;
-static unsigned int    vga_rolled_over = 0;
+static unsigned int    vga_rolled_over;
 
 
 static int __init no_scroll(char *str)
@@ -132,7 +129,7 @@
 	 * Braille reader made by F.H. Papenmeier (Germany).
 	 * Use the "no-scroll" bootflag.
 	 */
-	vga_hardscroll_user_enable = vga_hardscroll_enabled = 0;
+	vga_hardscroll_enabled = 0;
 	return 1;
 }
 
@@ -316,7 +313,6 @@
 	if (vga_video_type == VIDEO_TYPE_EGAC
 	    || vga_video_type == VIDEO_TYPE_VGAC
 	    || vga_video_type == VIDEO_TYPE_EGAM) {
-		vga_hardscroll_enabled = vga_hardscroll_user_enable;
 		vga_default_font_height = ORIG_VIDEO_POINTS;
 		vga_video_font_height = ORIG_VIDEO_POINTS;
 		/* This may be suboptimal but is a safe bet - go with it */
@@ -965,7 +961,7 @@
 
 static void vgacon_save_screen(struct vc_data *c)
 {
-	static int vga_bootup_console = 0;
+	static int vga_bootup_console;
 
 	if (!vga_bootup_console) {
 		/* This is a gross hack, but here is the only place we can
@@ -1015,7 +1011,6 @@
 			vga_rolled_over = 0;
 		} else
 			c->vc_origin -= delta;
-		c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
 		scr_memsetw((u16 *)(c->vc_origin), c->vc_video_erase_char, delta);
 	}
 	c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
