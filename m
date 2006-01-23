Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWAWI1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWAWI1Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 03:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWAWI1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 03:27:16 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:64075 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751432AbWAWI1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 03:27:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=V93NtV+LLNSmIPtYTeOm4lFUeM3LIW0BynHqeqKJo8WTQXyQLfYdxlLlYPSAavQqvGIkoIWDDuC03nWpvJrxNbJu0+FY0vozTCbZxHgGF2L+T1sXNFqFNp91uz6TU9S8rzCOzBnUb9eQfzPDl4qJW70IEt9p22cLCnlzVbqq9M8=
Message-ID: <43D492C4.3000801@gmail.com>
Date: Mon, 23 Jan 2006 16:24:36 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] vgacon: Add support for soft scrollback
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The scrollback buffer of the VGA console is located in VGA RAM. This
RAM is fixed in size and is very small. To make the scrollback buffer
larger, it must be placed instead in System RAM.

This patch adds this feature.  The feature and the size of the buffer
are made as a kernel config option.  Besides consuming kernel memory,
this feature will slow down the console by approximately 20%.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

This patch is the result of a discussion on how to capture very long
oops tracings.  One of the suggestions was to increase the size of
the scrollback buffer of the VGA console.

I haven't tested the code rigorously, so let me know of any bugs. I
also tried to make it behave as close as possible to vgacon with a hard
scrollback.

Tony 

 drivers/video/console/Kconfig  |   24 ++++
 drivers/video/console/vgacon.c |  245 +++++++++++++++++++++++++++++++++-------
 2 files changed, 226 insertions(+), 43 deletions(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 6ee4498..4444bef 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -26,6 +26,30 @@ config VGA_CONSOLE
 #	   fi
 #	fi
 
+config VGACON_SOFT_SCROLLBACK
+       bool "Enable Scrollback Buffer in System RAM"
+       depends on VGA_CONSOLE
+       default n
+       help
+         The scrollback buffer of the standard VGA console is located in
+	 the VGA RAM.  The size of this RAM is fixed and is quite small.
+	 If you require a larger scrollback buffer, this can be placed in
+	 System RAM which is dynamically allocated during intialization.
+	 Placing the scrollback buffer in System RAM will slightly slow
+	 down the console.
+
+	 If you want this feature, say 'Y' here and enter the amount of
+	 RAM to allocate for this buffer.  If unsure, say 'N'.
+
+config VGACON_SOFT_SCROLLBACK_SIZE
+       int "Scrollback Buffer Size (in KB)"
+       depends on VGACON_SOFT_SCROLLBACK
+       default "64"
+       help
+         Enter the amount of System RAM to allocate for the scrollback
+	 buffer.  Each 64KB will give you approximately 16 80x25
+	 screenfuls of scrollback buffer
+
 config VIDEO_SELECT
 	bool "Video mode selection support"
 	depends on  X86 && VGA_CONSOLE
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 12d9329..ec0aabc 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -93,7 +93,6 @@ static u8 vgacon_build_attr(struct vc_da
 static void vgacon_invert_region(struct vc_data *c, u16 * p, int count);
 static unsigned long vgacon_uni_pagedir[2];
 
-
 /* Description of the hardware situation */
 static unsigned long	vga_vram_base;		/* Base of video memory */
 static unsigned long	vga_vram_end;		/* End of video memory */
@@ -161,6 +160,202 @@ static inline void write_vga(unsigned ch
 	spin_unlock_irqrestore(&vga_lock, flags);
 }
 
+static inline void vga_set_mem_top(struct vc_data *c)
+{
+	write_vga(12, (c->vc_visible_origin - vga_vram_base) / 2);
+}
+
+#ifdef CONFIG_VGACON_SOFT_SCROLLBACK
+#include <linux/bootmem.h>
+/* software scrollback */
+static void *vgacon_scrollback;
+static int vgacon_scrollback_tail;
+static int vgacon_scrollback_size;
+static int vgacon_scrollback_rows;
+static int vgacon_scrollback_cnt;
+static int vgacon_scrollback_cur;
+static int vgacon_scrollback_save;
+static int vgacon_scrollback_restore;
+
+static void vgacon_scrollback_init(int pitch)
+{
+	int rows = CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024/pitch;
+
+	if (vgacon_scrollback) {
+		vgacon_scrollback_cnt  = 0;
+		vgacon_scrollback_tail = 0;
+		vgacon_scrollback_cur  = 0;
+		vgacon_scrollback_rows = rows - 1;
+		vgacon_scrollback_size = rows * pitch;
+	}
+}
+
+static void __init vgacon_scrollback_startup(void)
+{
+	vgacon_scrollback = alloc_bootmem(CONFIG_VGACON_SOFT_SCROLLBACK_SIZE
+					  * 1024);
+	vgacon_scrollback_init(vga_video_num_columns * 2);
+}
+
+static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
+{
+	void *p;
+
+	if (!vgacon_scrollback_size || c->vc_num != fg_console)
+		return;
+
+	p = (void *) (c->vc_origin + t * c->vc_size_row);
+
+	while (count--) {
+		scr_memcpyw(vgacon_scrollback + vgacon_scrollback_tail,
+			    p, c->vc_size_row);
+		vgacon_scrollback_cnt++;
+		p += c->vc_size_row;
+		vgacon_scrollback_tail += c->vc_size_row;
+
+		if (vgacon_scrollback_tail >= vgacon_scrollback_size)
+			vgacon_scrollback_tail = 0;
+
+		if (vgacon_scrollback_cnt > vgacon_scrollback_rows)
+			vgacon_scrollback_cnt = vgacon_scrollback_rows;
+
+		vgacon_scrollback_cur = vgacon_scrollback_cnt;
+	}
+}
+
+static void vgacon_restore_screen(struct vc_data *c)
+{
+	vgacon_scrollback_save = 0;
+
+	if (!vga_is_gfx && !vgacon_scrollback_restore) {
+		scr_memcpyw((u16 *) c->vc_origin, (u16 *) c->vc_screenbuf,
+			    c->vc_screenbuf_size > vga_vram_size ?
+			    vga_vram_size : c->vc_screenbuf_size);
+		vgacon_scrollback_restore = 1;
+		vgacon_scrollback_cur = vgacon_scrollback_cnt;
+	}
+}
+
+static int vgacon_scrolldelta(struct vc_data *c, int lines)
+{
+	int start, end, count, soff, diff;
+	void *d, *s;
+
+	if (!lines) {
+		c->vc_visible_origin = c->vc_origin;
+		vga_set_mem_top(c);
+		return 1;
+	}
+
+	if (!vgacon_scrollback)
+		return 1;
+
+	if (!vgacon_scrollback_save) {
+		vgacon_cursor(c, CM_ERASE);
+		vgacon_save_screen(c);
+		vgacon_scrollback_save = 1;
+	}
+
+	vgacon_scrollback_restore = 0;
+	start = vgacon_scrollback_cur + lines;
+	end = start + abs(lines);
+
+	if (start < 0)
+		start = 0;
+
+	if (start > vgacon_scrollback_cnt)
+		start = vgacon_scrollback_cnt;
+
+	if (end < 0)
+		end = 0;
+
+	if (end > vgacon_scrollback_cnt)
+		end = vgacon_scrollback_cnt;
+
+	vgacon_scrollback_cur = start;
+	count = end - start;
+	soff = vgacon_scrollback_tail - ((vgacon_scrollback_cnt - end) *
+					 c->vc_size_row);
+	soff -= count * c->vc_size_row;
+
+	if (soff < 0)
+		soff += vgacon_scrollback_size;
+
+	count = vgacon_scrollback_cnt - start;
+
+	if (count > c->vc_rows)
+		count = c->vc_rows;
+
+	diff = c->vc_rows - count;
+
+	d = (void *) c->vc_origin;
+	s = (void *) c->vc_screenbuf;
+
+	while (count--) {
+		scr_memcpyw(d, vgacon_scrollback + soff, c->vc_size_row);
+		d += c->vc_size_row;
+		soff += c->vc_size_row;
+
+		if (soff >= vgacon_scrollback_size)
+			soff = 0;
+	}
+
+	if (diff == c->vc_rows) {
+		vgacon_cursor(c, CM_MOVE);
+	} else {
+		while (diff--) {
+			scr_memcpyw(d, s, c->vc_size_row);
+			d += c->vc_size_row;
+			s += c->vc_size_row;
+		}
+	}
+
+	return 1;
+}
+#else
+#define vgacon_scrollback_startup(...) do { } while (0)
+#define vgacon_scrollback_init(...)    do { } while (0)
+#define vgacon_scrollback_update(...)  do { } while (0)
+
+static void vgacon_restore_screen(struct vc_data *c)
+{
+	if (c->vc_origin != c->vc_visible_origin)
+		vgacon_scrolldelta(c, 0);
+}
+
+static int vgacon_scrolldelta(struct vc_data *c, int lines)
+{
+	if (!lines)		/* Turn scrollback off */
+		c->vc_visible_origin = c->vc_origin;
+	else {
+		int margin = c->vc_size_row * 4;
+		int ul, we, p, st;
+
+		printk("vgacon delta: %i\n", lines);
+		if (vga_rolled_over >
+		    (c->vc_scr_end - vga_vram_base) + margin) {
+			ul = c->vc_scr_end - vga_vram_base;
+			we = vga_rolled_over + c->vc_size_row;
+		} else {
+			ul = 0;
+			we = vga_vram_size;
+		}
+		p = (c->vc_visible_origin - vga_vram_base - ul + we) % we +
+		    lines * c->vc_size_row;
+		st = (c->vc_origin - vga_vram_base - ul + we) % we;
+		if (st < 2 * margin)
+			margin = 0;
+		if (p < margin)
+			p = 0;
+		if (p > st - margin)
+			p = st;
+		c->vc_visible_origin = vga_vram_base + (p + ul) % we;
+	}
+	vga_set_mem_top(c);
+	return 1;
+}
+#endif /* CONFIG_VGACON_SOFT_SCROLLBACK */
+
 static const char __init *vgacon_startup(void)
 {
 	const char *display_desc = NULL;
@@ -330,7 +525,7 @@ static const char __init *vgacon_startup
 
 	vgacon_xres = ORIG_VIDEO_COLS * VGA_FONTWIDTH;
 	vgacon_yres = vga_scan_lines;
-
+	vgacon_scrollback_startup();
 	return display_desc;
 }
 
@@ -357,11 +552,6 @@ static void vgacon_init(struct vc_data *
 		con_set_default_unimap(c);
 }
 
-static inline void vga_set_mem_top(struct vc_data *c)
-{
-	write_vga(12, (c->vc_visible_origin - vga_vram_base) / 2);
-}
-
 static void vgacon_deinit(struct vc_data *c)
 {
 	/* When closing the last console, reset video origin */
@@ -450,8 +640,8 @@ static void vgacon_set_cursor_size(int x
 
 static void vgacon_cursor(struct vc_data *c, int mode)
 {
-	if (c->vc_origin != c->vc_visible_origin)
-		vgacon_scrolldelta(c, 0);
+	vgacon_restore_screen(c);
+
 	switch (mode) {
 	case CM_ERASE:
 		write_vga(14, (c->vc_pos - vga_vram_base) / 2);
@@ -592,6 +782,7 @@ static int vgacon_switch(struct vc_data 
 			vgacon_doresize(c, c->vc_cols, c->vc_rows);
 	}
 
+	vgacon_scrollback_init(c->vc_size_row);
 	return 0;		/* Redrawing not needed */
 }
 
@@ -1059,37 +1250,6 @@ static int vgacon_resize(struct vc_data 
 	return 0;
 }
 
-static int vgacon_scrolldelta(struct vc_data *c, int lines)
-{
-	if (!lines)		/* Turn scrollback off */
-		c->vc_visible_origin = c->vc_origin;
-	else {
-		int margin = c->vc_size_row * 4;
-		int ul, we, p, st;
-
-		if (vga_rolled_over >
-		    (c->vc_scr_end - vga_vram_base) + margin) {
-			ul = c->vc_scr_end - vga_vram_base;
-			we = vga_rolled_over + c->vc_size_row;
-		} else {
-			ul = 0;
-			we = vga_vram_size;
-		}
-		p = (c->vc_visible_origin - vga_vram_base - ul + we) % we +
-		    lines * c->vc_size_row;
-		st = (c->vc_origin - vga_vram_base - ul + we) % we;
-		if (st < 2 * margin)
-			margin = 0;
-		if (p < margin)
-			p = 0;
-		if (p > st - margin)
-			p = st;
-		c->vc_visible_origin = vga_vram_base + (p + ul) % we;
-	}
-	vga_set_mem_top(c);
-	return 1;
-}
-
 static int vgacon_set_origin(struct vc_data *c)
 {
 	if (vga_is_gfx ||	/* We don't play origin tricks in graphic modes */
@@ -1132,15 +1292,14 @@ static int vgacon_scroll(struct vc_data 
 	if (t || b != c->vc_rows || vga_is_gfx)
 		return 0;
 
-	if (c->vc_origin != c->vc_visible_origin)
-		vgacon_scrolldelta(c, 0);
-
 	if (!vga_hardscroll_enabled || lines >= c->vc_rows / 2)
 		return 0;
 
+	vgacon_restore_screen(c);
 	oldo = c->vc_origin;
 	delta = lines * c->vc_size_row;
 	if (dir == SM_UP) {
+		vgacon_scrollback_update(c, t, lines);
 		if (c->vc_scr_end + delta >= vga_vram_end) {
 			scr_memcpyw((u16 *) vga_vram_base,
 				    (u16 *) (oldo + delta),

