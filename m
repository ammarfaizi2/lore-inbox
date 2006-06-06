Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWFFLKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWFFLKM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 07:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWFFLKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 07:10:11 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:53140 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751153AbWFFLKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 07:10:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=W0ALaAUyMhwfL+EiWn6MDTjJYbtc+wJmFYQbT03QSqM1z+asFVlwPvoPfDgXD25eqXnDt1HJGRQtNeFEXOVYWi105gU9PID2RI+MXArPfjLld8Q1HTZrfW3mWYJpVTF98EHisa3P2DBLZoiVFXtzRVZSaAeqxggwYZziOjBDIDY=
Message-ID: <4485620C.20606@gmail.com>
Date: Tue, 06 Jun 2006 19:07:56 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] Detaching fbcon: Fix vgacon to allow retaking of the
 console
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order for fbcon to detach itself from the console layer, vgacon, which is a
boot console driver, must be fixed so it can retake the console multiple
times, not just during init.  The following needs to be done:

- remove __init from the vgacon_startup, this is called again by
  take_over_console().

- vc->rows and vc->cols are set manually by vgacon during init. After init,
  vc_resize() can be used

- make sure the scrollback_buffer is not reallocated

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/vgacon.c |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index a595382..01401cd 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -114,6 +114,7 @@ static int 		vga_512_chars;
 static int 		vga_video_font_height;
 static int 		vga_scan_lines;
 static unsigned int 	vga_rolled_over = 0;
+static int              vga_init_done;
 
 static int __init no_scroll(char *str)
 {
@@ -190,7 +191,7 @@ static void vgacon_scrollback_init(int p
 	}
 }
 
-static void __init vgacon_scrollback_startup(void)
+static void vgacon_scrollback_startup(void)
 {
 	vgacon_scrollback = alloc_bootmem(CONFIG_VGACON_SOFT_SCROLLBACK_SIZE
 					  * 1024);
@@ -355,7 +356,7 @@ static int vgacon_scrolldelta(struct vc_
 }
 #endif /* CONFIG_VGACON_SOFT_SCROLLBACK */
 
-static const char __init *vgacon_startup(void)
+static const char *vgacon_startup(void)
 {
 	const char *display_desc = NULL;
 	u16 saved1, saved2;
@@ -523,7 +524,12 @@ #endif
 
 	vgacon_xres = ORIG_VIDEO_COLS * VGA_FONTWIDTH;
 	vgacon_yres = vga_scan_lines;
-	vgacon_scrollback_startup();
+
+	if (!vga_init_done) {
+		vgacon_scrollback_startup();
+		vga_init_done = 1;
+	}
+
 	return display_desc;
 }
 
@@ -531,10 +537,20 @@ static void vgacon_init(struct vc_data *
 {
 	unsigned long p;
 
-	/* We cannot be loaded as a module, therefore init is always 1 */
+	/*
+	 * We cannot be loaded as a module, therefore init is always 1,
+	 * but vgacon_init can be called more than once, and init will
+	 * not be 1.
+	 */
 	c->vc_can_do_color = vga_can_do_color;
-	c->vc_cols = vga_video_num_columns;
-	c->vc_rows = vga_video_num_lines;
+
+	/* set dimensions manually if init != 0 since vc_resize() will fail */
+	if (init) {
+		c->vc_cols = vga_video_num_columns;
+		c->vc_rows = vga_video_num_lines;
+	} else
+		vc_resize(c, vga_video_num_columns, vga_video_num_lines);
+
 	c->vc_scan_lines = vga_scan_lines;
 	c->vc_font.height = vga_video_font_height;
 	c->vc_complement_mask = 0x7700;




