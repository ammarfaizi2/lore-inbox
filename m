Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130339AbQLDQeM>; Mon, 4 Dec 2000 11:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130144AbQLDQeC>; Mon, 4 Dec 2000 11:34:02 -0500
Received: from [195.77.234.5] ([195.77.234.5]:11274 "HELO ntdes.cirsa.com")
	by vger.kernel.org with SMTP id <S129692AbQLDQd4>;
	Mon, 4 Dec 2000 11:33:56 -0500
Message-ID: <01C05E13.BEE08A70@wsi_joan.UNIDESA_RD>
From: Joan Bertran <jbertran@cirsa.com>
To: "'mj@suse.cz'" <mj@suse.cz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Config setting to remove linux logo
Date: Mon, 4 Dec 2000 17:00:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I know that there is a similar question about this in linux-kernel Fri, 01 Oct 1999
but I will like that the Linux logo were a config option. The difference betwen
the stripped uncompressed vmlinux 2.4.0-test11 file is of 12288 bytes.

 I have a patch without the config menu option:
diff -ur ./linux-2.4.0.test11_orig/drivers/video/fbcon.c ./linux-2.4.0.test11/drivers/video/fbcon.c
--- ./linux-2.4.0.test11_orig/drivers/video/fbcon.c	Sun Oct 29 06:17:34 2000
+++ ./linux-2.4.0.test11/drivers/video/fbcon.c	Mon Dec  4 16:00:21 2000
@@ -53,6 +53,7 @@
  *  License.  See the file COPYING in the main directory of this archive for
  *  more details.
  */
+#define NO_FB_LOGO
 
 #undef FBCONDEBUG
 
@@ -94,8 +95,11 @@
 #ifdef CONFIG_FBCON_VGA_PLANES
 #include <asm/io.h>
 #endif
+
+#ifndef NO_FB_LOGO
 #define INCLUDE_LINUX_LOGO_DATA
 #include <asm/linux_logo.h>
+#endif
 
 #include <video/fbcon.h>
 #include <video/fbcon-mac.h>	/* for 6x11 font on mac */
@@ -113,8 +117,12 @@
 
 struct display fb_display[MAX_NR_CONSOLES];
 char con2fb_map[MAX_NR_CONSOLES];
+
+#ifndef NO_FB_LOGO
 static int logo_lines;
 static int logo_shown = -1;
+#endif /* NO_FB_LOGO */
+
 /* Software scrollback */
 int fbcon_softback_size = 32768;
 static unsigned long softback_buf, softback_curr;
@@ -211,8 +219,11 @@
 				 struct display *p, int count);
 static void fbcon_bmove_rec(struct display *p, int sy, int sx, int dy, int dx,
 			    int height, int width, u_int y_break);
-
+#ifndef NO_FB_LOGO
 static int fbcon_show_logo(void);
+#else
+static inline int fbcon_show_logo(void) {}
+#endif
 
 #ifdef CONFIG_MAC
 /*
@@ -604,6 +615,7 @@
     nr_cols = p->var.xres/fontwidth(p);
     nr_rows = p->var.yres/fontheight(p);
     
+#ifndef NO_FB_LOGO
     if (logo) {
     	/* Need to make room for the logo */
 	int cnt;
@@ -642,6 +654,7 @@
 		    conp->vc_video_erase_char, 
     		conp->vc_size_row * logo_lines);
     }
+#endif /* NO_FB_LOGO */
     
     /*
      *  ++guenther: console.c:vc_allocate() relies on initializing
@@ -691,17 +704,21 @@
 	}
 	if (save) {
     	    q = (unsigned short *)(conp->vc_origin + conp->vc_size_row * old_rows);
+#ifndef NO_FB_LOGO
 	    scr_memcpyw(q, save, logo_lines * nr_cols * 2);
 	    conp->vc_y += logo_lines;
     	    conp->vc_pos += logo_lines * conp->vc_size_row;
+#endif /* NO_FB_LOGO */
     	    kfree(save);
 	}
     }
 	
+#ifndef NO_FB_LOGO
     if (logo) {
 	logo_shown = -2;
     	conp->vc_top = logo_lines;
     }
+#endif /* NO_FB_LOGO */
     
     if (con == fg_console && softback_buf) {
     	int l = fbcon_softback_size / conp->vc_size_row;
@@ -1233,7 +1250,9 @@
 		count = conp->vc_rows;
 	    if (softback_top)
 	        fbcon_softback_note(conp, t, count);
+#ifndef NO_FB_LOGO
 	    if (logo_shown >= 0) goto redraw_up;
+#endif
 	    switch (p->scrollmode & __SCROLL_YMASK) {
 	    case __SCROLL_YMOVE:
 		p->dispsw->bmove(p, t+count, 0, t, 0, b-t-count,
@@ -1435,6 +1454,7 @@
 	    softback_top = 0;
 	}
     }
+#ifndef NO_FB_LOGO
     if (logo_shown >= 0) {
     	struct vc_data *conp2 = vc_cons[logo_shown].d;
     	
@@ -1442,6 +1462,7 @@
     		conp2->vc_top = 0;
     	logo_shown = -1;
     }
+#endif /* NO_FB_LOGO */
     p->var.yoffset = p->yscroll = 0;
     switch (p->scrollmode & __SCROLL_YMASK) {
 	case __SCROLL_YWRAP:
@@ -1463,6 +1484,8 @@
 	(*info->switch_con)(unit, info);
     if (p->dispsw->clear_margins && vt_cons[unit]->vc_mode == KD_TEXT)
 	p->dispsw->clear_margins(conp, p, 0);
+
+#ifndef NO_FB_LOGO
     if (logo_shown == -2) {
 	logo_shown = fg_console;
 	fbcon_show_logo(); /* This is protected above by initmem_freed */
@@ -1471,6 +1494,8 @@
 		      conp->vc_size_row * (conp->vc_bottom - conp->vc_top) / 2);
 	return 0;
     }
+#endif
+
     return 1;
 }
 
@@ -1964,6 +1989,7 @@
     	    return 0;
     	if (vt_cons[unit]->vc_mode != KD_TEXT || !lines)
     	    return 0;
+#ifndef NO_FB_LOGO
     	if (logo_shown >= 0) {
 		struct vc_data *conp2 = vc_cons[logo_shown].d;
     	
@@ -1987,6 +2013,7 @@
     		}
 		logo_shown = -1;
 	}
+#endif /* NO_FB_LOGO */
     	fbcon_cursor(conp, CM_ERASE|CM_SOFTBACK);
     	fbcon_redraw_softback(conp, p, lines);
     	fbcon_cursor(conp, CM_DRAW|CM_SOFTBACK);
@@ -2045,6 +2072,7 @@
     return n<0 ? d>>-n : d<<n;
 }
 
+#ifndef NO_FB_LOGO
 static int __init fbcon_show_logo( void )
 {
     struct display *p = &fb_display[fg_console]; /* draw to vt in foreground */
@@ -2380,6 +2408,8 @@
 
     return done ? (LOGO_H + fontheight(p) - 1) / fontheight(p) : 0 ;
 }
+#endif   /* NO_FB_LOGO */
+
 
 /*
  *  The console `switch' structure for the frame buffer based console
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
