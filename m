Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262862AbTCWGjG>; Sun, 23 Mar 2003 01:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262875AbTCWGjG>; Sun, 23 Mar 2003 01:39:06 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:35968 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262862AbTCWGii>; Sun, 23 Mar 2003 01:38:38 -0500
Date: Sun, 23 Mar 2003 15:48:47 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.65-ac3] Updates for PC-9800 related (5/5) video
Message-ID: <20030323064847.GE2851@yuzuki.cinet.co.jp>
References: <20030323063207.GA2803@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030323063207.GA2803@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the update patch for NEC PC-9800 subarchitecture related files
against 2.5.65-ac3. (5/5)

Add missing patch. These files are lost between 2.5.64-ac4 and 2.5.65-ac1.
(PC98 standard video card text mode driver.)

Regards,
Osamu Tomita

diff -Nru linux-2.5.60/drivers/video/console/Makefile linux98-2.5.60/drivers/video/console/Makefile
--- linux-2.5.60/drivers/video/console/Makefile	2003-02-11 03:38:30.000000000 +0900
+++ linux98-2.5.60/drivers/video/console/Makefile	2003-02-11 09:47:18.000000000 +0900
@@ -19,6 +19,7 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_DUMMY_CONSOLE)       += dummycon.o
+obj-$(CONFIG_GDC_CONSOLE)         += gdccon.o
 obj-$(CONFIG_SGI_NEWPORT_CONSOLE) += newport_con.o
 obj-$(CONFIG_PROM_CONSOLE)        += promcon.o promcon_tbl.o
 obj-$(CONFIG_STI_CONSOLE)         += sticon.o sticore.o
diff -Nru linux-2.5.61/drivers/video/console/gdccon.c linux98-2.5.61/drivers/video/console/gdccon.c
--- linux-2.5.61/drivers/video/console/gdccon.c	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.61/drivers/video/console/gdccon.c	2003-02-16 17:19:03.000000000 +0900
@@ -0,0 +1,833 @@
+/*
+ * linux/drivers/video/gdccon.c
+ * Low level GDC based console driver for NEC PC-9800 series
+ *
+ * Created 24 Dec 1998 by Linux/98 project
+ *
+ * based on:
+ * linux/drivers/video/vgacon.c in Linux 2.1.131 by Geert Uytterhoeven
+ * linux/char/gdc.c in Linux/98 2.1.57 by Linux/98 project
+ * linux/char/console.c in Linux/98 2.1.57 by Linux/98 project
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/tty.h>
+#include <linux/console.h>
+#include <linux/string.h>
+#include <linux/kd.h>
+#include <linux/slab.h>
+#include <linux/vt_kern.h>
+#include <linux/selection.h>
+#include <linux/spinlock.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/pc9800.h>
+
+static spinlock_t gdc_lock = SPIN_LOCK_UNLOCKED;
+
+static char str_gdc_master[] = "GDC (master)";
+static char str_gdc_slave[] = "GDC (slave)";
+static char str_crtc[] = "crtc";
+static struct resource gdc_console_resources[] = {
+    {str_gdc_master, 0x60, 0x60, 0},
+    {str_gdc_master, 0x62, 0x62, 0},
+    {str_gdc_master, 0x64, 0x64, 0},
+    {str_gdc_master, 0x66, 0x66, 0},
+    {str_gdc_master, 0x68, 0x68, 0},
+    {str_gdc_master, 0x6a, 0x6a, 0},
+    {str_gdc_master, 0x6c, 0x6c, 0},
+    {str_gdc_master, 0x6e, 0x6e, 0},
+    {str_crtc, 0x70, 0x70, 0},
+    {str_crtc, 0x72, 0x72, 0},
+    {str_crtc, 0x74, 0x74, 0},
+    {str_crtc, 0x76, 0x76, 0},
+    {str_crtc, 0x78, 0x78, 0},
+    {str_crtc, 0x7a, 0x7a, 0},
+    {str_gdc_slave, 0xa0, 0xa0, 0},
+    {str_gdc_slave, 0xa2, 0xa2, 0},
+    {str_gdc_slave, 0xa4, 0xa4, 0},
+    {str_gdc_slave, 0xa6, 0xa6, 0},
+};
+
+#define GDC_CONSOLE_RESOURCES (sizeof(gdc_console_resources)/sizeof(struct resource))
+
+#define BLANK 0x0020
+#define BLANK_ATTR 0x00e1
+
+/* GDC/GGDC port# */
+#define GDC_COMMAND 0x62
+#define GDC_PARAM 0x60
+#define GDC_STAT 0x60
+#define GDC_DATA 0x62
+
+#define MODE_FF1	(0x0068)	/* mode F/F register 1 */
+
+#define  MODE_FF1_ATR_SEL	(0x00)	/* 0: vertical line 1: 8001 graphic */
+#define  MODE_FF1_GRAPHIC_MODE	(0x02)	/* 0: color 1: mono */
+#define  MODE_FF1_COLUMN_WIDTH	(0x04)	/* 0: 80col 1: 40col */
+#define  MODE_FF1_FONT_SEL	(0x06)	/* 0: 6x8 1: 7x13 */
+#define  MODE_FF1_GRP_MODE	(0x08)	/* 0: display odd-y raster 1: not */
+#define  MODE_FF1_KAC_MODE	(0x0a)	/* 0: code access 1: dot access */
+#define  MODE_FF1_NVMW_PERMIT	(0x0c)	/* 0: protect 1: permit */
+#define  MODE_FF1_DISP_ENABLE	(0x0e)	/* 0: enable 1: disable */
+
+#define GGDC_COMMAND 0xa2
+#define GGDC_PARAM 0xa0
+#define GGDC_STAT 0xa0
+#define GGDC_DATA 0xa2
+
+/* GDC status */
+#define GDC_DATA_READY		(1 << 0)
+#define GDC_FIFO_FULL		(1 << 1)
+#define GDC_FIFO_EMPTY		(1 << 2)
+#define GGDC_FIFO_EMPTY		GDC_FIFO_EMPTY
+#define GDC_DRAWING		(1 << 3)
+#define GDC_DMA_EXECUTE		(1 << 4)	/* nonsense on 98 */
+#define GDC_VERTICAL_SYNC	(1 << 5)
+#define GDC_HORIZONTAL_BLANK	(1 << 6)
+#define GDC_LIGHTPEN_DETECT	(1 << 7)	/* nonsense on 98 */
+
+#define ATTR_G		(1U << 7)
+#define ATTR_R		(1U << 6)
+#define ATTR_B		(1U << 5)
+#define ATTR_GRAPHIC	(1U << 4)
+#define ATTR_VERTBAR	ATTR_GRAPHIC	/* vertical bar */
+#define ATTR_UNDERLINE	(1U << 3)
+#define ATTR_REVERSE	(1U << 2)
+#define ATTR_BLINK	(1U << 1)
+#define ATTR_NOSECRET	(1U << 0)
+#define AMASK_NOCOLOR	(ATTR_GRAPHIC | ATTR_UNDERLINE | ATTR_REVERSE \
+			 | ATTR_BLINK | ATTR_NOSECRET)
+
+/*
+ *  Interface used by the world
+ */
+static const char *gdccon_startup(void);
+static void gdccon_init(struct vc_data *c, int init);
+static void gdccon_deinit(struct vc_data *c);
+static void gdccon_cursor(struct vc_data *c, int mode);
+static int gdccon_switch(struct vc_data *c);
+static int gdccon_blank(struct vc_data *c, int blank);
+static int gdccon_scrolldelta(struct vc_data *c, int lines);
+static int gdccon_set_origin(struct vc_data *c);
+static void gdccon_save_screen(struct vc_data *c);
+static int gdccon_scroll(struct vc_data *c, int t, int b, int dir, int lines);
+static u8 gdccon_build_attr(struct vc_data *c, u8 color, u8 intensity, u8 blink, u8 underline, u8 reverse);
+static void gdccon_invert_region(struct vc_data *c, u16 *p, int count);
+static unsigned long gdccon_uni_pagedir[2];
+
+/* Description of the hardware situation */
+static unsigned long   gdc_vram_base;		/* Base of video memory */
+static unsigned long   gdc_vram_end;		/* End of video memory */
+static unsigned int    gdc_video_num_columns = 80;
+						/* Number of text columns */
+static unsigned int    gdc_video_num_lines = 25;
+						/* Number of text lines */
+static int	       gdc_can_do_color = 1;	/* Do we support colors? */
+static unsigned char   gdc_video_type;		/* Card type */
+static unsigned char   gdc_hardscroll_enabled;
+static unsigned char   gdc_hardscroll_user_enable = 1;
+static int	       gdc_vesa_blanked = 0;
+static unsigned int    gdc_rolled_over = 0;
+
+#define DISP_FREQ_AUTO 0
+#define DISP_FREQ_25k  1
+#define DISP_FREQ_31k  2
+
+static unsigned int    gdc_disp_freq = DISP_FREQ_AUTO;
+
+#define gdc_attr_offset(x) ((typeof(x))((unsigned long)(x)+0x2000))
+
+#define	gdc_outb(val, port)	outb_p((val), (port))
+#define	gdc_inb(port)		inb_p(port)
+
+#define __gdc_write_command(cmd)	gdc_outb((cmd), GDC_COMMAND)
+#define __gdc_write_param(param)	gdc_outb((param), GDC_PARAM)
+
+static const char * __init gdccon_startup(void)
+{
+	const char *display_desc = NULL;
+	unsigned long hdots = gdc_video_num_lines * 16;
+	int i;
+
+	while (!(inb_p(GDC_STAT) & GDC_FIFO_EMPTY));
+	while (!(inb_p(GGDC_STAT) & GDC_FIFO_EMPTY));
+	spin_lock_irq(&gdc_lock);	
+	outb_p(0x0c, GDC_COMMAND);	/* STOP */
+	outb_p(0x0c, GGDC_COMMAND);	/* STOP */
+	if (PC9800_9821_P() && gdc_disp_freq == DISP_FREQ_AUTO) {
+		if (gdc_video_num_lines >= 30 || (inb(0x9a8) & 0x01)) {
+			gdc_disp_freq = DISP_FREQ_31k;
+		}
+	}
+
+	if (PC9800_9821_P() && gdc_disp_freq == DISP_FREQ_31k) {
+		outb_p(0x01, 0x9a8);   /* 31.47KHz */
+		outb_p(0x0e, GDC_COMMAND);  /* SYNC, DE deny */
+		outb_p(0x00, GDC_PARAM);  /* CHR, F, I, D, G, S = 0 */
+		outb_p(0x4e, GDC_PARAM);  /* C/R = 78 (80 chars) */
+		outb_p(0x4b, GDC_PARAM);  /* VSL = 2(3) ; HS = 11 */
+		outb_p(0x0c, GDC_PARAM);  /* HFP = 3    ; VSH = 0(VS=2) */
+		outb_p(0x03, GDC_PARAM);  /* DS, PH = 0 ; HBP = 3 */
+		outb_p(0x06, GDC_PARAM);  /* VH, VL = 0 ; VFP = 6 */
+		outb_p(hdots & 0xff, GDC_PARAM);  /* LFL */
+		outb_p(0x94 | ((hdots >> 8) & 0x03), GDC_PARAM);
+						/* VBP = 37   ; LFH */
+		outb_p(0x47, GDC_COMMAND);  /* PITCH */
+		outb_p(0x50, GDC_PARAM);
+
+		outb_p(0x70, GDC_COMMAND);  /* SCROLL */
+		outb_p(0x00, GDC_PARAM);
+		outb_p(0x00, GDC_PARAM);
+		outb_p((hdots << 4) & 0xf0, GDC_PARAM);  /* SL1=592 (0x250) */
+		outb_p((hdots >> 4) & 0x3f, GDC_PARAM);
+
+		outb_p(0x0e, GGDC_COMMAND);  /* SYNC, DE deny */
+		outb_p(0x00, GGDC_PARAM);  /* CHR, F, I, D, G, S = 0 */
+		outb_p(0x4e, GGDC_PARAM);  /* C/R = 78 (80 chars) */
+		outb_p(0x4b, GGDC_PARAM);  /* VSL = 2(3) ; HS = 11 */
+		outb_p(0x0c, GGDC_PARAM);  /* HFP = 3    ; VSH = 0(VS=2) */
+		outb_p(0x03, GGDC_PARAM);  /* DS, PH = 0 ; HBP = 3 */
+		outb_p(0x06, GGDC_PARAM);  /* VH, VL = 0 ; VFP = 6 */
+		outb_p(hdots & 0xff, GGDC_PARAM);  /* LFL */
+		outb_p(0x94 | ((hdots >> 8) & 0x03), GGDC_PARAM);
+						/* VBP = 37   ; LFH */
+	} else {
+		outb_p(0x00, 0x9a8);   /* 24.83 KHz */
+		outb_p(0x0e, GDC_COMMAND);  /* SYNC, DE deny */
+		outb_p(0x00, GDC_PARAM);  /* CHR, F, I, D, G, S = 0 */
+		outb_p(0x4e, GDC_PARAM);  /* C/R = 78 (80 chars) */
+		outb_p(0x07, GDC_PARAM);  /* VSL = 0(3) ; HS = 7 */
+		outb_p(0x25, GDC_PARAM);  /* HFP = 9    ; VSH = 1(VS=8) */
+		outb_p(0x07, GDC_PARAM);  /* DS, PH = 0 ; HBP = 7 */
+		outb_p(0x07, GDC_PARAM);  /* VH, VL = 0 ; VFP = 7 */
+		outb_p(hdots & 0xff, GDC_PARAM);  /* LFL */
+		outb_p(0x64 | ((hdots >> 8) & 0x03), GDC_PARAM);
+						/* VBP = 25   ; LFH */
+		outb_p(0x47, GDC_COMMAND);  /* PITCH */
+		outb_p(0x50, GDC_PARAM);
+
+		outb_p(0x70, GDC_COMMAND);  /* SCROLL */
+		outb_p(0x00, GDC_PARAM);
+		outb_p(0x00, GDC_PARAM);
+		outb_p((hdots << 4) & 0xf0, GDC_PARAM);  /* SL1=592 (0x250) */
+		outb_p((hdots >> 4) & 0x3f, GDC_PARAM);
+
+		outb_p(0x0e, GGDC_COMMAND);  /* SYNC */
+		outb_p(0x00, GGDC_PARAM);
+		outb_p(0x4e, GGDC_PARAM);
+		outb_p(0x07, GGDC_PARAM);
+		outb_p(0x25, GGDC_PARAM);
+		outb_p(0x07, GGDC_PARAM);
+		outb_p(0x07, GGDC_PARAM);
+		outb_p(hdots & 0xff, GGDC_PARAM);  /* LFL */
+		outb_p(0x64 | ((hdots >> 8) & 0x03), GGDC_PARAM);
+						/* VBP = 25   ; LFH */
+	}
+
+	outb_p(0x47, GGDC_COMMAND);  /* PITCH */ 
+	outb_p(0x28, GGDC_PARAM);
+
+	outb_p(0x0d, GDC_COMMAND);	/* START */
+	outb_p(0x0d, GGDC_COMMAND);	/* START */
+	spin_unlock_irq(&gdc_lock);	
+
+	gdc_vram_base = (unsigned long)phys_to_virt(0xa0000);
+	/* Last few bytes of text VRAM area are for NVRAM. */
+	gdc_vram_end = gdc_vram_base + 0x1fe0;
+
+	if (!PC9800_HIGHRESO_P()) {
+		gdc_video_type = VIDEO_TYPE_98NORMAL;
+		display_desc = "NEC PC-9800 Normal";
+	} else {
+		gdc_video_type = VIDEO_TYPE_98HIRESO;
+		display_desc = "NEC PC-9800 High Resolution";
+	}
+
+	gdc_hardscroll_enabled = gdc_hardscroll_user_enable;
+	
+	for (i = 0; i < GDC_CONSOLE_RESOURCES; i++)
+		request_resource(&ioport_resource, gdc_console_resources + i);
+
+	return display_desc;
+}
+
+static void gdccon_init(struct vc_data *c, int init)
+{
+	unsigned long p;
+	
+	/* We cannot be loaded as a module, therefore init is always 1 */
+	c->vc_can_do_color = gdc_can_do_color;
+	c->vc_cols = gdc_video_num_columns;
+	c->vc_rows = gdc_video_num_lines;
+	c->vc_complement_mask = ATTR_REVERSE << 8;
+	p = *c->vc_uni_pagedir_loc;
+	if (c->vc_uni_pagedir_loc == &c->vc_uni_pagedir
+	    || !--c->vc_uni_pagedir_loc[1])
+		con_free_unimap(c->vc_num);
+
+	c->vc_uni_pagedir_loc = gdccon_uni_pagedir;
+	gdccon_uni_pagedir[1]++;
+	if (!gdccon_uni_pagedir[0] && p)
+		con_set_default_unimap(c->vc_num);
+}
+
+static inline void gdc_set_mem_top(struct vc_data *c)
+{
+	unsigned long flags;
+	unsigned long origin = (c->vc_visible_origin - gdc_vram_base) / 2;
+
+	spin_lock_irqsave(&gdc_lock, flags);
+	while (!(inb_p(GDC_STAT) & GDC_FIFO_EMPTY));
+	__gdc_write_command(0x70);			/* SCROLL */
+	__gdc_write_param(origin);			/* SAD1 (L) */
+	__gdc_write_param((origin >> 8) & 0x1f);	/* SAD1 (H) */
+	spin_unlock_irqrestore(&gdc_lock, flags);
+}
+
+static void gdccon_deinit(struct vc_data *c)
+{
+	/* When closing the last console, reset video origin */
+	if (!--gdccon_uni_pagedir[1]) {
+		c->vc_visible_origin = gdc_vram_base;
+		gdc_set_mem_top(c);
+		con_free_unimap(c->vc_num);
+	}
+
+	c->vc_uni_pagedir_loc = &c->vc_uni_pagedir;
+	con_set_default_unimap(c->vc_num);
+}
+
+#if 0
+/* Translate ANSI terminal color code to GDC color code.  */
+#define BGR_TO_GRB(bgr)	((((bgr) & 4) >> 2) | (((bgr) & 3) << 1))
+#else
+#define RGB_TO_GRB(rgb)	((((rgb) & 4) >> 1) | (((rgb) & 2) << 1) | ((rgb) & 1))
+#endif
+
+static const u8 gdccon_color_table[] = {
+#define C(color)	((RGB_TO_GRB (color) << 5) | ATTR_NOSECRET)
+	C(0), C(1), C(2), C(3), C(4), C(5), C(6), C(7)
+#undef C
+};
+
+static u8 gdccon_build_attr(struct vc_data *c, u8 color, u8 intensity, u8 blink, u8 underline, u8 reverse)
+{
+	u8 attr = gdccon_color_table[color & 0x07];
+
+	if (!gdc_can_do_color)
+		attr = (intensity == 0 ? 0x61
+			: intensity == 2 ? 0xe1 : 0xa1);
+
+	if (underline)
+		attr |= 0x08;
+
+	/* ignore intensity */
+#if 0
+	if(intensity == 0)
+		;
+	else if (intensity == 2)
+		attr |= 0x10; /* virtical line */
+#else
+	if (intensity == 0) {
+		if (attr == c->vc_def_attr)
+			attr = c->vc_half_attr;
+		else
+			attr |= c->vc_half_attr & AMASK_NOCOLOR;
+	} else if (intensity == 2) {
+		if (attr == c->vc_def_attr)
+			attr = c->vc_bold_attr;
+		else
+			attr |= c->vc_bold_attr & AMASK_NOCOLOR;
+	}
+#endif
+	if (reverse)
+		attr |= ATTR_REVERSE;
+
+	if ((color & 0x07) == 0) {	/* foreground color == black */
+		/* Fake background color by reversed character
+		   as GDC cannot set background color.  */
+		attr |= gdccon_color_table[(color >> 4) & 0x07];
+		attr ^= ATTR_REVERSE;
+	}
+
+	if (blink)
+		attr |= ATTR_BLINK;
+
+	return attr;
+}
+
+static void gdccon_invert_region(struct vc_data *c, u16 *p, int count)
+{
+	while (count--) {
+		*((u16 *)(gdc_attr_offset(p))) ^= ATTR_REVERSE;
+		p++;
+	}
+}
+
+static u8 gdc_csrform_lr = 15;			/* Lines/Row */
+static u16 gdc_csrform_bl_bd = ((12 << 6)	/* BLinking Rate */
+				| (0 << 5));	/* Blinking Disable */
+
+static inline void gdc_hide_cursor(void)
+{
+    __gdc_write_command(0x4b);		/* CSRFORM */
+    __gdc_write_param(gdc_csrform_lr);	/* CS = 0, CE = 0, L/R = ? */
+}
+
+static inline void gdc_show_cursor(int cursor_start, int cursor_finish)
+{
+    __gdc_write_command(0x4b);		/* CSRFORM */
+    __gdc_write_param(0x80 | gdc_csrform_lr);		/* CS = 1 */
+    __gdc_write_param(cursor_start | gdc_csrform_bl_bd);
+    __gdc_write_param((cursor_finish << 3) | (gdc_csrform_bl_bd >> 8));
+}
+
+static void gdccon_cursor(struct vc_data *c, int mode)
+{
+    unsigned long flags;
+    u16 ead;
+
+    if (c->vc_origin != c->vc_visible_origin)
+	gdccon_scrolldelta(c, 0);
+
+    spin_lock_irqsave(&gdc_lock, flags);
+    while (!(inb_p(GDC_STAT) & GDC_FIFO_EMPTY));
+    spin_unlock_irqrestore(&gdc_lock, flags);
+    switch (mode) {
+	case CM_ERASE:
+	    gdc_hide_cursor();
+	    break;
+
+	case CM_MOVE:
+	case CM_DRAW:
+	    switch (c->vc_cursor_type & 0x0f) {
+		case CUR_UNDERLINE:
+		    gdc_show_cursor(14, 15);	/* XXX font height */
+		    break;
+
+		case CUR_TWO_THIRDS:
+		    gdc_show_cursor(5, 15);	/* XXX */
+		    break;
+
+		case CUR_LOWER_THIRD:
+		    gdc_show_cursor(11, 15);	/* XXX */
+		    break;
+
+		case CUR_LOWER_HALF:
+		    gdc_show_cursor(8, 15);	/* XXX */
+		    break;
+
+		case CUR_NONE:
+		    gdc_hide_cursor();
+		    break;
+
+          	default:
+		    gdc_show_cursor(0, 15);	/* XXX */
+		    break;
+	    }
+
+	    spin_lock_irqsave(&gdc_lock, flags);
+	    __gdc_write_command(0x49);		/* CSRW */
+	    ead = (c->vc_pos - gdc_vram_base) >> 1;
+	    __gdc_write_param(ead);
+	    __gdc_write_param((ead >> 8) & 0x1f);
+	    spin_unlock_irqrestore(&gdc_lock, flags);
+	    break;
+    }
+
+}
+
+static int gdccon_switch(struct vc_data *c)
+{
+	/*
+	 * We need to save screen size here as it's the only way
+	 * we can spot the screen has been resized and we need to
+	 * set size of freshly allocated screens ourselves.
+	 */
+	gdc_video_num_columns = c->vc_cols;
+	gdc_video_num_lines = c->vc_rows;
+	if (c->vc_origin != (unsigned long)c->vc_screenbuf
+	    && gdc_vram_base <= c->vc_origin && c->vc_origin < gdc_vram_end) {
+		_scr_memcpyw_to((u16 *)c->vc_origin,
+				(u16 *)c->vc_screenbuf,
+				c->vc_screenbuf_size);
+		_scr_memcpyw_to((u16 *)gdc_attr_offset(c->vc_origin),
+				(u16 *)((char *)c->vc_screenbuf
+					 + c->vc_screenbuf_size),
+				c->vc_screenbuf_size);
+	} else
+		printk(KERN_WARNING
+			"gdccon: switch (vc #%d) called on origin=%lx\n",
+			c->vc_num, c->vc_origin);
+
+	return 0;	/* Redrawing not needed */
+}
+
+static int gdccon_set_palette(struct vc_data *c, unsigned char *table)
+{
+	return -EINVAL;
+}
+
+#define RELAY0		0x01
+#define RELAY0_GDC	0x00
+#define RELAY0_ACCEL	0x01
+#define RELAY1		0x02
+#define RELAY1_INTERNAL	0x00
+#define RELAY1_EXTERNAL	0x02
+#define IO_RELAY	0x0fac
+#define IO_DPMS		0x09a2
+static unsigned char relay_mode = RELAY0_GDC | RELAY1_INTERNAL;
+
+static void gdc_vesa_blank(int mode)
+{
+    unsigned char stat;
+
+    spin_lock_irq(&gdc_lock);
+
+    relay_mode = inb_p(IO_RELAY);
+    if ((relay_mode & (RELAY0 | RELAY1)) != (RELAY0_GDC | RELAY1_INTERNAL)) {
+#ifdef CONFIG_DONTTOUCHRELAY
+	spin_unlock_irq(&gdc_lock);
+	return;
+#else
+	outb_p((relay_mode & ~(RELAY0 | RELAY1)) |
+	       RELAY0_GDC | RELAY1_INTERNAL , IO_RELAY);
+#endif
+    }
+
+    if (mode & VESA_VSYNC_SUSPEND) {
+	stat = inb_p(IO_DPMS);
+	outb_p(stat | 0x80, IO_DPMS);
+    }
+    if (mode & VESA_HSYNC_SUSPEND) {
+	stat = inb_p(IO_DPMS);
+	outb_p(stat | 0x40, IO_DPMS);
+    }
+
+    spin_unlock_irq(&gdc_lock);
+}
+
+static void gdc_vesa_unblank(void)
+{
+    unsigned char stat;
+
+#ifdef CONFIG_DONTTOUCHRELAY
+    if (relay_mode & (RELAY0 | RELAY1))
+	return;
+#endif
+
+    spin_lock_irq(&gdc_lock);
+
+    stat = inb_p(0x09a2);
+    outb_p(stat & ~0xc0, IO_DPMS);
+    if (relay_mode & (RELAY0 | RELAY1))
+	outb_p(relay_mode, IO_RELAY);
+
+    spin_unlock_irq(&gdc_lock);
+}
+
+static int gdccon_blank(struct vc_data *c, int blank)
+{
+	switch (blank) {
+	case 0:				/* Unblank */
+		if (gdc_vesa_blanked) {
+			gdc_vesa_unblank();
+			gdc_vesa_blanked = 0;
+		}
+
+		outb(MODE_FF1_DISP_ENABLE | 1, MODE_FF1);
+
+		/* Tell console.c that it need not to restore the screen */
+		return 0;
+
+	case 1:				/* Normal blanking */
+		/* Disable displaying */
+		outb(MODE_FF1_DISP_ENABLE | 0, MODE_FF1);
+
+		/* Tell console.c that it need not to reset origin */
+		return 0;
+
+	case -1:			/* Entering graphic mode */
+		return 1;
+
+	default:			/* VESA blanking */
+		if (gdc_video_type == VIDEO_TYPE_98NORMAL
+		    || gdc_video_type == VIDEO_TYPE_9840
+		    || gdc_video_type == VIDEO_TYPE_98HIRESO) {
+			gdc_vesa_blank(blank - 1);
+			gdc_vesa_blanked = blank;
+		}
+
+		return 0;
+	}
+}
+
+static int gdccon_font_op(struct vc_data *c, struct console_font_op *op)
+{
+	return -ENOSYS;
+}
+
+static int gdccon_scrolldelta(struct vc_data *c, int lines)
+{
+	if (!lines)			/* Turn scrollback off */
+		c->vc_visible_origin = c->vc_origin;
+	else {
+		int vram_size = gdc_vram_end - gdc_vram_base;
+		int margin = c->vc_size_row /* * 4 */;
+		int ul, we, p, st;
+
+		if (gdc_rolled_over > c->vc_scr_end - gdc_vram_base + margin) {
+			ul = c->vc_scr_end - gdc_vram_base;
+			we = gdc_rolled_over + c->vc_size_row;
+		} else {
+			ul = 0;
+			we = vram_size;
+		}
+
+		p = (c->vc_visible_origin - gdc_vram_base - ul + we)
+			% we + lines * c->vc_size_row;
+		st = (c->vc_origin - gdc_vram_base - ul + we) % we;
+		if (p < margin)
+			p = 0;
+
+		if (p > st - margin)
+			p = st;
+		c->vc_visible_origin = gdc_vram_base + (p + ul) % we;
+	}
+
+	gdc_set_mem_top(c);
+	return 1;
+}
+
+static int gdccon_set_origin(struct vc_data *c)
+{
+	c->vc_origin = c->vc_visible_origin = gdc_vram_base;
+	gdc_set_mem_top(c);
+	gdc_rolled_over = 0;
+	return 1;
+}
+
+static void gdccon_save_screen(struct vc_data *c)
+{
+	static int gdc_bootup_console = 0;
+
+	if (!gdc_bootup_console) {
+		/* This is a gross hack, but here is the only place we can
+		 * set bootup console parameters without messing up generic
+		 * console initialization routines.
+		 */
+		gdc_bootup_console = 1;
+		c->vc_x = ORIG_X;
+		c->vc_y = ORIG_Y;
+	}
+
+	_scr_memcpyw_from((u16 *)c->vc_screenbuf,
+				(u16 *)c->vc_origin, c->vc_screenbuf_size);
+	_scr_memcpyw_from((u16 *)((char *)c->vc_screenbuf + c->vc_screenbuf_size), (u16 *)gdc_attr_offset(c->vc_origin), c->vc_screenbuf_size);
+}
+
+static int gdccon_scroll(struct vc_data *c, int t, int b, int dir, int lines)
+{
+	unsigned long oldo;
+	unsigned int delta;
+
+	if (t || b != c->vc_rows)
+		return 0;
+
+	if (c->vc_origin != c->vc_visible_origin)
+		gdccon_scrolldelta(c, 0);
+
+	if (!gdc_hardscroll_enabled || lines >= c->vc_rows / 2)
+		return 0;
+
+	oldo = c->vc_origin;
+	delta = lines * c->vc_size_row;
+	if (dir == SM_UP) {
+		if (c->vc_scr_end + delta >= gdc_vram_end) {
+			_scr_memcpyw((u16 *)gdc_vram_base,
+				    (u16 *)(oldo + delta),
+				    c->vc_screenbuf_size - delta);
+			_scr_memcpyw((u16 *)gdc_attr_offset(gdc_vram_base),
+				    (u16 *)gdc_attr_offset(oldo + delta),
+				    c->vc_screenbuf_size - delta);
+			c->vc_origin = gdc_vram_base;
+			gdc_rolled_over = oldo - gdc_vram_base;
+		} else
+			c->vc_origin += delta;
+
+		_scr_memsetw((u16 *)(c->vc_origin + c->vc_screenbuf_size - delta), c->vc_video_erase_char & 0xff, delta);
+		_scr_memsetw((u16 *)gdc_attr_offset(c->vc_origin + c->vc_screenbuf_size - delta), c->vc_video_erase_char >> 8, delta);
+	} else {
+		if (oldo - delta < gdc_vram_base) {
+			_scr_memmovew((u16 *)(gdc_vram_end - c->vc_screenbuf_size + delta), (u16 *)oldo, c->vc_screenbuf_size - delta);
+			_scr_memmovew((u16 *)gdc_attr_offset(gdc_vram_end - c->vc_screenbuf_size + delta), (u16 *)gdc_attr_offset(oldo), c->vc_screenbuf_size - delta);
+			c->vc_origin = gdc_vram_end - c->vc_screenbuf_size;
+			gdc_rolled_over = 0;
+		} else
+			c->vc_origin -= delta;
+
+		c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
+		_scr_memsetw((u16 *)(c->vc_origin), c->vc_video_erase_char & 0xff, delta);
+		_scr_memsetw((u16 *)gdc_attr_offset(c->vc_origin), c->vc_video_erase_char >> 8, delta);
+	}
+
+	c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
+	c->vc_visible_origin = c->vc_origin;
+	gdc_set_mem_top(c);
+	c->vc_pos = (c->vc_pos - oldo) + c->vc_origin;
+	return 1;
+}
+
+static int gdccon_setterm_command(struct vc_data *c)
+{
+	switch (c->vc_par[0]) {
+	case 1: /* set attr for underline mode */
+		if (c->vc_npar < 2) {
+			if (c->vc_par[1] < 16)
+				c->vc_ul_attr = gdccon_color_table[color_table[c->vc_par[1]] & 7];
+		} else {
+			if (c->vc_par[2] < 256)
+				c->vc_ul_attr = c->vc_par[2];
+		}
+
+		if (c->vc_underline)
+			goto update_attr;
+
+		return 1;
+
+	case 2:	/* set attr for half intensity mode */
+		if (c->vc_npar < 2) {
+			if (c->vc_par[1] < 16)
+				c->vc_half_attr = gdccon_color_table[color_table[c->vc_par[1]] & 7];
+		}
+		else {
+			if (c->vc_par[2] < 256)
+				c->vc_half_attr = c->vc_par[2];
+		}
+
+		if (c->vc_intensity == 0)
+			goto update_attr;
+
+		return 1;
+
+	case 3: /* set color for bold mode */
+		if (c->vc_npar < 2) {
+			if (c->vc_par[1] < 16)
+				c->vc_bold_attr = gdccon_color_table[color_table[c->vc_par[1]] & 7];
+		} else {
+			if (c->vc_par[2] < 256)
+				c->vc_bold_attr = c->vc_par[2];
+		}
+
+		if (c->vc_intensity == 2)
+			goto update_attr;
+
+		return 1;
+	}
+
+	return 0;
+
+update_attr:
+	c->vc_attr = gdccon_build_attr(c,
+					c->vc_color, c->vc_intensity,
+					c->vc_blink, c->vc_underline,
+					c->vc_reverse);
+	return 1;
+}
+
+/*
+ *  The console `switch' structure for the GDC based console
+ */
+
+static int gdccon_dummy(struct vc_data *c)
+{
+	return 0;
+}
+
+#define DUMMY (void *) gdccon_dummy
+
+const struct consw gdc_con = {
+	.con_startup =		gdccon_startup,
+	.con_init =		gdccon_init,
+	.con_deinit =		gdccon_deinit,
+	.con_clear =		DUMMY,
+	.con_putc =		DUMMY,
+	.con_putcs =		DUMMY,
+	.con_cursor =		gdccon_cursor,
+	.con_scroll =		gdccon_scroll,
+	.con_bmove =		DUMMY,
+	.con_switch =		gdccon_switch,
+	.con_blank =		gdccon_blank,
+	.con_font_op =		gdccon_font_op,
+	.con_set_palette =	gdccon_set_palette,
+	.con_scrolldelta =	gdccon_scrolldelta,
+	.con_set_origin =	gdccon_set_origin,
+	.con_save_screen =	gdccon_save_screen,
+	.con_build_attr =	gdccon_build_attr,
+	.con_invert_region =	gdccon_invert_region,
+	.con_setterm_command =	gdccon_setterm_command
+};
+
+static int __init gdc_setup(char *str)
+{
+	unsigned long tmp_ulong;
+	char *opt, *orig_opt, *endp;
+
+	while ((opt = strsep(&str, ",")) != NULL) {
+		int force = 0;
+
+		orig_opt = opt;
+		if (!strncmp(opt, "force", 5)) {
+			force = 1;
+			opt += 5;
+		}
+
+		if (!strcmp(opt, "mono"))
+			gdc_can_do_color = 0;
+		else if ((tmp_ulong = simple_strtoul(opt, &endp, 0)) > 0) {
+			if (!strcmp(endp, "lines")
+			    || (!strcmp(endp, "linesforce") && (force == 1))) {
+				if (!force
+				    && (tmp_ulong < 20
+					|| (!PC9800_9821_P()
+					    && 25 < tmp_ulong)
+					|| 37 < tmp_ulong))
+					printk(KERN_ERR
+						"gdccon: %d is out of bound"
+						" for number of lines\n",
+						(int)tmp_ulong);
+				else
+					gdc_video_num_lines = tmp_ulong;
+			} else if (!strcmp(endp, "kHz")) {
+				if (tmp_ulong == 24 || tmp_ulong == 25)
+					gdc_disp_freq = DISP_FREQ_25k;
+				else
+					printk(KERN_ERR "gdccon: `%s' ignored\n",
+						orig_opt);
+			} else
+				printk(KERN_ERR "gdccon: unknown option `%s'\n",
+					orig_opt);
+		} else
+			printk(KERN_ERR "gdccon: unknown option `%s'\n",
+				orig_opt);
+	}
+
+	return 1; 
+}
+
+__setup("gdccon=", gdc_setup);
+
+/*
+ * We will follow Linus's indenting style...
+ *
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
