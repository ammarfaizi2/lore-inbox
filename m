Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265274AbSJRR1G>; Fri, 18 Oct 2002 13:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265318AbSJRR1F>; Fri, 18 Oct 2002 13:27:05 -0400
Received: from gateway.cinet.co.jp ([210.166.75.129]:45841 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265274AbSJRQvv>; Fri, 18 Oct 2002 12:51:51 -0400
Date: Sat, 19 Oct 2002 01:56:59 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET 25/25] add support for PC-9800 architecture (video)
Message-ID: <20021019015659.A1660@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 26/26 of patchset for add support NEC PC-9800 architecture,
against 2.5.43.

Summary:
 New driver support for PC-9800 standard text console.

diffstat:
 drivers/video/gdccon.c |  963 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/gdc.h |  225 +++++++++++
 2 files changed, 1188 insertions(+)

patch:
diff -urN linux/drivers/video/gdccon.c linux98/drivers/video/gdccon.c
--- linux/drivers/video/gdccon.c	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/video/gdccon.c	Sun Sep  8 19:09:48 2002
@@ -0,0 +1,963 @@
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
+/*
+#define GDCCON_DEBUG_MEMFUNCS
+#define VRAM_OVERRUN_DEBUG
+*/
+
+#ifdef VRAM_OVERRUN_DEBUG
+# define NEED_UNMAP_PHYSPAGE
+#endif
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/tty.h>
+#include <linux/console.h>
+#include <linux/console_struct.h>
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
+#ifdef VRAM_OVERRUN_DEBUG
+# include <asm/pc9800_debug.h>
+#endif
+
+static spinlock_t gdc_lock = SPIN_LOCK_UNLOCKED;
+
+static struct resource gdc_console_resource[3] = {
+    {"GDC (master)", 0x60, 0x6e, IORESOURCE98_SPARSE},
+    {"crtc", 0x70, 0x7a, IORESOURCE98_SPARSE},
+    {"GDC (slave)", 0xa0, 0xa6, IORESOURCE98_SPARSE},
+};
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
+	request_resource(&ioport_resource, &gdc_console_resource[0]);
+	request_resource(&ioport_resource, &gdc_console_resource[1]);
+	request_resource(&ioport_resource, &gdc_console_resource[2]);
+
+	return display_desc;
+}
+
+#ifdef VRAM_OVERRUN_DEBUG
+static int __init gdccon_setup_trap(void)
+{
+	/*
+	 * Trap scr_mem{move,set,...} overrun by unmapping memory page.
+	 * If kernel hits these pages, page fault are triggered and
+	 * then kernel forces oops.
+	 */
+	unmap_physpage(GDC_MAP_MEM(0x9f000));
+	unmap_physpage(GDC_MAP_MEM(0xa6000));
+
+	printk(KERN_DEBUG "gdccon: overrun trap code activated\n");
+	return 0;
+}
+
+/*
+ * Call gdccon_setup_trap() while normal driver setup, as gdccon_startup()
+ * may be called while bootup temporary page table is in use. (Is this true?)
+ */
+__initcall (gdccon_setup_trap);
+#endif
+
+static void gdccon_init(struct vc_data *c, int init)
+{
+	unsigned long p;
+	
+	/* We cannot be loaded as a module, therefore init is always 1 */
+	c->vc_can_do_color = gdc_can_do_color;
+	c->vc_cols = gdc_video_num_columns;
+	c->vc_rows = gdc_video_num_lines;
+	c->vc_complement_mask = ATTR_REVERSE;
+	p = *c->vc_uni_pagedir_loc;
+	if (c->vc_uni_pagedir_loc == &c->vc_uni_pagedir
+	    || !--c->vc_uni_pagedir_loc[1])
+		con_free_unimap(c->vc_num);
+
+	c->vc_uni_pagedir_loc = gdccon_uni_pagedir;
+#ifdef PC9800_GDCCON_DEBUG
+	printk(KERN_DEBUG "%s: #%u: %scolor, %ux%u, uni %p\n",
+		__FUNCTION__, c->vc_num, "!" + !!c->vc_can_do_color,
+		c->vc_cols, c->vc_rows, c->vc_uni_pagedir_loc);
+#endif
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
+		u16 a = scr_readw(gdc_attr_offset(p));
+
+		a ^= ATTR_REVERSE;
+		scr_writew(a, gdc_attr_offset(p));
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
+#if 0
+	printk(KERN_DEBUG
+		"%s: c=%p {origin=%#x, screenbuf=%#x, screenbuf_size=%u\n",
+		__FUNCTION__, c,
+		c->vc_origin, c->vc_screenbuf, c->vc_screenbuf_size);
+#endif
+	if (c->vc_origin != (unsigned long)c->vc_screenbuf
+	    && gdc_vram_base <= c->vc_origin && c->vc_origin < gdc_vram_end) {
+		scr_memcpyw_to((u16 *)c->vc_origin,
+				(u16 *)c->vc_screenbuf,
+				c->vc_screenbuf_size);
+		scr_memcpyw_to((u16 *)gdc_attr_offset(c->vc_origin),
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
+/*
+#define PC9800_GDCCON_DEBUG 1
+*/
+
+static int gdccon_scrolldelta(struct vc_data *c, int lines)
+{
+#ifdef PC9800_GDCCON_DEBUG
+	printk("gdccon_scrolldelta: lines=%d", lines);
+#endif
+
+	if (!lines)			/* Turn scrollback off */
+		c->vc_visible_origin = c->vc_origin;
+	else {
+		int vram_size = gdc_vram_end - gdc_vram_base;
+		int margin = c->vc_size_row /* * 4 */;
+		int ul, we, p, st;
+
+#ifdef PC9800_GDCCON_DEBUG
+		printk(", gdc_vram_base=0x%lx, gdc_vram_end=0x%lx",
+			__pa(gdc_vram_base), __pa(gdc_vram_end));
+		printk(", vram_size=%d, margin=%d", vram_size, margin);
+		printk(", c->vc_origin=0x%lx, c->vc_visible_origin=0x%lx, "
+			"c->vc_scr_end=0x%lx", __pa(c->vc_origin),
+			__pa(c->vc_visible_origin), __pa(c->vc_scr_end));
+		printk(", c->vc_size_row=%u, gdc_rolled_over=%u",
+			c->vc_size_row, gdc_rolled_over);
+#endif
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
+#ifdef PC9800_GDCCON_DEBUG
+		printk(", ul=%d, we=%d", ul, we);
+		printk(", p=%d, st=%d", p, st);
+#endif
+		if (p < margin)
+			p = 0;
+
+		if (p > st - margin)
+			p = st;
+#ifdef PC9800_GDCCON_DEBUG
+		printk(", p(new)=%d", p);
+#endif
+		c->vc_visible_origin = gdc_vram_base + (p + ul) % we;
+	}
+
+	gdc_set_mem_top(c);
+#ifdef PC9800_GDCCON_DEBUG
+	printk(", c->vc_visible_origin(new)=0x%lx, done.\n",
+		__pa(c->vc_visible_origin));
+#endif
+	return 1;
+}
+
+#undef PC9800_GDCCON_DEBUG
+
+static int gdccon_set_origin(struct vc_data *c)
+{
+#ifdef PC9800_GDCCON_DEBUG
+	printk(KERN_DEBUG "%s: c=%p, console_blanked=%d\n",
+		__FUNCTION__, c, console_blanked);
+#endif
+#if 0 /* It is now Ok to write to blanked screens,
+	 since output from video controller is cut off */
+	if (console_blanked)	/* We are writing to blanked screens */
+		return 0;
+#endif
+
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
+	scr_memcpyw_from((u16 *)c->vc_screenbuf,
+				(u16 *)c->vc_origin, c->vc_screenbuf_size);
+	scr_memcpyw_from((u16 *)((char *)c->vc_screenbuf + c->vc_screenbuf_size), (u16 *)gdc_attr_offset(c->vc_origin), c->vc_screenbuf_size);
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
+			scr_memcpyw((u16 *)gdc_vram_base,
+				    (u16 *)(oldo + delta),
+				    c->vc_screenbuf_size - delta);
+			scr_memcpyw((u16 *)gdc_attr_offset(gdc_vram_base),
+				    (u16 *)gdc_attr_offset(oldo + delta),
+				    c->vc_screenbuf_size - delta);
+			c->vc_origin = gdc_vram_base;
+			gdc_rolled_over = oldo - gdc_vram_base;
+		} else
+			c->vc_origin += delta;
+
+		scr_memsetw((u16 *)(c->vc_origin + c->vc_screenbuf_size - delta), c->vc_video_erase_char, delta);
+		scr_memsetw((u16 *)gdc_attr_offset(c->vc_origin + c->vc_screenbuf_size - delta), c->vc_video_erase_attr, delta);
+	} else {
+		if (oldo - delta < gdc_vram_base) {
+#if 0
+			printk(KERN_DEBUG
+				"gdc_vram_base = %#lx, gdc_vram_end = %#lx\n",
+				gdc_vram_base, gdc_vram_end);
+#endif
+			scr_memmovew((u16 *)(gdc_vram_end - c->vc_screenbuf_size + delta),
+				     (u16 *)oldo,
+				     c->vc_screenbuf_size - delta);
+			scr_memmovew((u16 *)gdc_attr_offset(gdc_vram_end - c->vc_screenbuf_size + delta),
+				     (u16 *)gdc_attr_offset(oldo),
+				     c->vc_screenbuf_size - delta);
+			c->vc_origin = gdc_vram_end - c->vc_screenbuf_size;
+			gdc_rolled_over = 0;
+		} else
+			c->vc_origin -= delta;
+
+		c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
+#if 0
+		printk(KERN_DEBUG "scr_memsetw(%p, %#x, %u)\n",
+			c->vc_origin, c->vc_video_erase_char, delta);
+#endif
+		scr_memsetw((u16 *)(c->vc_origin), c->vc_video_erase_char,
+				delta);
+#if 0
+		printk(KERN_DEBUG "scr_memsetw(%p, %#x, %u)\n",
+			gdc_attr_offset(c->vc_origin), c->vc_video_erase_attr,
+			delta);
+#endif
+		scr_memsetw((u16 *)gdc_attr_offset(c->vc_origin),
+				c->vc_video_erase_attr, delta);
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
+#ifdef GDCCON_DEBUG_MEMFUNCS
+void gdccon_check_address(const void *start, size_t len,
+			   const char *name, const char *function,
+			   const char *file, unsigned int lineno)
+{
+	int i;
+	static int inhibit;
+
+	if (inhibit)
+		return;
+
+	if (gdc_vram_base <= (unsigned long)start
+	    && (unsigned long)start + len <= gdc_vram_end + 0x2000)
+		return;
+
+	for (i = 0; i < MAX_NR_CONSOLES; i++)
+		if (vc_cons[i].d
+		    && (void *)vc_cons[i].d->vc_screenbuf <= start
+		    && start + len <= ((void *)vc_cons[i].d->vc_screenbuf
+				       + vc_cons[i].d->vc_screenbuf_size * 2))
+			return;
+
+	inhibit = 1;
+	if (function)
+		printk(KERN_WARNING "gdccon: In function `%s'\n", function);
+
+	if (file)
+		printk(KERN_WARNING "gdccon: %s:%u", file, lineno);
+	else
+		printk(KERN_WARNING "gdccon");
+
+	printk(": %s address out of range (%p+%u)\nStack: ",
+		name, start, len);
+	show_stack(NULL);
+	printk("\n");
+	inhibit = 0;
+}
+#endif
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
diff -urN linux/include/asm-i386/gdc.h linux98/include/asm-i386/gdc.h
--- linux/include/asm-i386/gdc.h	Thu Jan  1 09:00:00 1970
+++ linux98/include/asm-i386/gdc.h	Sun Aug 19 14:13:09 2001
@@ -0,0 +1,225 @@
+/*
+ *  gdc.h - macro & inline functions for accessing GDC text-VRAM
+ *
+ *  Copyright (C) 1997-2000   KITAGAWA Takurou,
+ *			      UGAWA Tomoharu,
+ *			      TAKAI Kosuke
+ *			      (Linux/98 Project)
+ */
+#ifndef _LINUX_ASM_GDC_H_
+#define _LINUX_ASM_GDC_H_
+
+#include <linux/config.h>
+
+#define GDC_MAP_MEM(x) (unsigned long)phys_to_virt(x)
+
+#define gdc_readb(x) (*(x))
+#define gdc_writeb(x,y) (*(y) = (x))
+
+#define VT_BUF_HAVE_RW
+#define scr_writew(val, addr)	(*(volatile __u16 *)(addr) = (val))
+#define scr_readw(addr)		(*(volatile __u16 *)(addr))
+
+#define VT_BUF_HAVE_MEMSETW
+extern inline void
+scr_memsetw(u16 *s, u16 c, unsigned int count)
+{
+#ifdef CONFIG_GDC_32BITACCESS
+	__asm__ __volatile__ ("shr%L1 %1
+	jz 2f
+" /*	cld	kernel code now assumes DF = 0 any time */ "\
+	test%L0 %3,%0
+	jz 1f
+	stos%W2
+	dec%L1 %1
+1:	shr%L1 %1
+	rep
+	stos%L2
+	jnc 2f
+	stos%W2
+	rep
+	stos%W2
+2:"
+			      : "=D"(s), "=c"(count)
+			      : "a"((((u32) c) << 16) | c), "g"(2),
+			        "0"(s), "1"(count));
+#else
+	__asm__ __volatile__ ("rep\n\tstosw"
+			      : "=D"(s), "=c"(count)
+			      : "0"(s), "1"(count / 2), "a"(c));
+#endif	
+}
+
+#define VT_BUF_HAVE_MEMCPYW
+extern inline void
+scr_memcpyw(u16 *d, u16 *s, unsigned int count)
+{
+#if 1 /* def CONFIG_GDC_32BITACCESS */
+	__asm__ __volatile__ ("shr%L2 %2
+	jz 2f
+" /*	cld	*/ "\
+	test%L0 %3,%0
+	jz 1f
+	movs%W0
+	dec%L2 %2
+1:	shr%L2 %2
+	rep
+	movs%L0
+	jnc 2f
+	movs%W0
+2:"
+			      : "=D"(d), "=S"(s), "=c"(count)
+			      : "g"(2), "0"(d), "1"(s), "2"(count));
+#else
+	__asm__ __volatile__ ("rep\n\tmovsw"
+			      : "=D"(d), "=S"(s), "=c"(count)
+			      : "0"(d), "1"(s), "2"(count / 2));
+#endif
+}
+
+extern inline void
+scr_memrcpyw(u16 *d, u16 *s, unsigned int count)
+{
+#if 1 /* def CONFIG_GDC_32BITACCESS */
+	u16 tmp;
+
+	__asm__ __volatile__ ("shr%L3 %3
+	jz 2f
+	std
+	lea%L1 -4(%1,%3,2),%1
+	lea%L2 -4(%2,%3,2),%2
+	test%L1 %4,%1
+	jz 1f
+	mov%W0 2(%2),%0
+	sub%L2 %4,%2
+	dec%L3 %3
+	mov%W0 %0,2(%1)
+	sub%L1 %4,%1
+1:	shr%L3 %3
+	rep
+	movs%L0
+	jnc 3f
+	mov%W0 2(%2),%0
+	mov%W0 %0,2(%1)
+3:	cld
+2:"
+			      : "=r"(tmp), "=D"(d), "=S"(s), "=c"(count)
+			      : "g"(2), "1"(d), "2"(s), "3"(count));
+#else
+	__asm__ __volatile__ ("std\n\trep\n\tmovsw\n\tcld"
+			      : "=D"(d), "=S"(s), "=c"(count)
+			      : "0"((void *) d + count - 2),
+			        "1"((void *) s + count - 2), "2"(count / 2));
+#endif	
+}
+
+#define VT_BUF_HAVE_MEMMOVEW
+extern inline void
+scr_memmovew(u16 *d, u16 *s, unsigned int count)
+{
+	if (d > s)
+		scr_memrcpyw(d, s, count);
+	else
+		scr_memcpyw(d, s, count);
+}	
+
+#define VT_BUF_HAVE_MEMCPYF
+extern inline void
+scr_memcpyw_from(u16 *d, u16 *s, unsigned int count)
+{
+#ifdef CONFIG_GDC_32BITACCESS
+	/* VRAM is quite slow, so we align source pointer (%esi)
+	   to double-word alignment. */
+	__asm__ __volatile__ ("shr%L2 %2
+	jz 2f
+" /*	cld	*/ "\
+	test%L0 %3,%0
+	jz 1f
+	movs%W0
+	dec%L2 %2
+1:	shr%L2 %2
+	rep
+	movs%L0
+	jnc 2f
+	movs%W0
+2:"
+			      : "=D"(d), "=S"(s), "=c"(count)
+			      : "g"(2), "0"(d), "1"(s), "2"(count));
+#else
+	__asm__ __volatile__ ("rep\n\tmovsw"
+			      : "=D"(d), "=S"(s), "=c"(count)
+			      : "0"(d), "1"(s), "2"(count / 2));
+#endif
+}
+
+#ifdef CONFIG_GDC_32BITACCESS
+# define scr_memcpyw_to	scr_memcpyw
+#else
+# define scr_memcpyw_to scr_memcpyw_from
+#endif
+
+/* #define GDCCON_DEBUG_MEMFUNCS */
+#ifdef GDCCON_DEBUG_MEMFUNCS
+
+extern void gdccon_check_address(const void *, size_t, const char *,
+				  const char *, const char *, unsigned int);
+
+#undef scr_writew
+#define scr_writew(val, addr)	({					\
+	__u16 *_p_ = (void *)(addr);					\
+	gdccon_check_address(_p_, 2, "destination",			\
+			      "scr_writew", __FILE__, __LINE__);	\
+	*(volatile __u16 *)_p_ = (val);					\
+})
+
+#undef scr_readw
+#define scr_readw(addr)	({					\
+	__u16 *_p_ = (void *)(addr);				\
+	gdccon_check_address(_p_, 2, "source",			\
+			      "scr_readw", __FILE__, __LINE__);	\
+	*(volatile __u16 *)_p_;					\
+})
+
+#define scr_memsetw(dest, ch, count)	({				\
+	__u16 *_dest_ = (dest);						\
+	size_t _count_ = (count);					\
+	gdccon_check_address(_dest_, _count_, "destitnation",		\
+			      "scr_memsetw", __FILE__, __LINE__);	\
+	scr_memsetw(_dest_, (ch), _count_);				\
+})
+
+#define scr_memcpyw(dest, src, count)	({				\
+	__u16 *_dest_ = (dest);						\
+	__u16 *_src_ = (src);						\
+	size_t _count_ = (count);					\
+	gdccon_check_address(_dest_, _count_, "destitnation",		\
+			      "scr_memcpyw", __FILE__, __LINE__);	\
+	gdccon_check_address(_src_, _count_, "source",			\
+			      "scr_memcpyw", __FILE__, __LINE__);	\
+	scr_memcpyw(_dest_, _src_, _count_);				\
+})
+
+#define scr_memmovew(dest, src, count)	({				\
+	__u16 *_dest_ = (dest);						\
+	__u16 *_src_ = (src);						\
+	size_t _count_ = (count);					\
+	gdccon_check_address(_dest_, _count_, "destitnation",		\
+			      "scr_memmovew", __FILE__, __LINE__);	\
+	gdccon_check_address(_src_, _count_, "source",			\
+			      "scr_memmovew", __FILE__, __LINE__);	\
+	scr_memmovew(_dest_, _src_, _count_);				\
+})
+
+#define scr_memcpyw_from(dest, src, count)	({			\
+	__u16 *_dest_ = (dest);						\
+	__u16 *_src_ = (src);						\
+	size_t _count_ = (count);					\
+	gdccon_check_address(_dest_, _count_, "destitnation",		\
+			      "scr_memcpyw_from", __FILE__, __LINE__);	\
+	gdccon_check_address(_src_, _count_, "source",			\
+			      "scr_memcpyw_from", __FILE__, __LINE__);	\
+	scr_memcpyw_from(_dest_, _src_, _count_);			\
+})
+#endif /* GDCCON_DEBUG_MEMFUNCS */
+
+#endif /* _LINUX_ASM_GDC_H_ */
