Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWF0NQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWF0NQO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWF0NQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:16:14 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:47283 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932169AbWF0NQM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:16:12 -0400
Date: Tue, 27 Jun 2006 17:16:04 +0400
From: Vitaly Wool <vitalywool@gmail.com>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add framebuffer and display update module support for
 pnx4008
Message-Id: <20060627171604.941d0538.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.1 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

inlined is the patch that adds support for Display Update Module and RGB framebuffer device on Philips PNX4008 ARM board.

 Kconfig            |   15
 Makefile           |    2
 pnx4008/Makefile   |    7
 pnx4008/dum.h      |  243 ++++++++++++++
 pnx4008/fbcommon.h |   43 ++
 pnx4008/rgbfb.c    |  223 +++++++++++++
 pnx4008/sdum.c     |  866 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 pnx4008/sdum.h     |  139 ++++++++
 8 files changed, 1538 insertions(+)

Signed-off-by: Grigory Tolstolytkin <gtolstolytkin@ru.mvista.com>
Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

Index: linux-2.6.git/drivers/video/pnx4008/Makefile
===================================================================
--- /dev/null
+++ linux-2.6.git/drivers/video/pnx4008/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the new PNX4008 framebuffer device driver
+#
+
+obj-$(CONFIG_FB_PNX4008_DUM) += sdum.o
+obj-$(CONFIG_FB_PNX4008_DUM_RGB) += rgbfb.o
+
Index: linux-2.6.git/drivers/video/pnx4008/dum.h
===================================================================
--- /dev/null
+++ linux-2.6.git/drivers/video/pnx4008/dum.h
@@ -0,0 +1,243 @@
+/*
+ * linux/drivers/video/pnx4008/dum.h
+ *
+ * Internal header for SDUM
+ *
+ * 2005 (c) Koninklijke Philips N.V. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __PNX008_DUM_H__
+#define __PNX008_DUM_H__
+
+#include <asm/arch/platform.h>
+
+#define PNX4008_DUMCONF_VA_BASE		IO_ADDRESS(PNX4008_DUMCONF_BASE)
+#define PNX4008_DUM_MAIN_VA_BASE	IO_ADDRESS(PNX4008_DUM_MAINCFG_BASE)
+
+/* DUM CFG ADDRESSES */
+#define DUM_CH_BASE_ADR		(PNX4008_DUMCONF_VA_BASE + 0x00)
+#define DUM_CH_MIN_ADR		(PNX4008_DUMCONF_VA_BASE + 0x00)
+#define DUM_CH_MAX_ADR		(PNX4008_DUMCONF_VA_BASE + 0x04)
+#define DUM_CH_CONF_ADR		(PNX4008_DUMCONF_VA_BASE + 0x08)
+#define DUM_CH_STAT_ADR		(PNX4008_DUMCONF_VA_BASE + 0x0C)
+#define DUM_CH_CTRL_ADR		(PNX4008_DUMCONF_VA_BASE + 0x10)
+
+#define DUM_CH_MIN(i)		(*((volatile u32 *)DUM_CH_MIN_ADR + (i) * 5))
+#define DUM_CH_MAX(i)		(*((volatile u32 *)DUM_CH_MAX_ADR + (i) * 5))
+#define DUM_CH_CONF(i)		(*((volatile u32 *)DUM_CH_CONF_ADR + (i) * 5))
+#define DUM_CH_STAT(i)		(*((volatile u32 *)DUM_CH_STAT_ADR + (i) * 5))
+#define DUM_CH_CTRL(i)		(*((volatile u32 *)DUM_CH_CTRL_ADR + (i) * 5))
+
+#define DUM_CONF_ADR          (PNX4008_DUM_MAIN_VA_BASE + 0x4000)
+#define DUM_CTRL_ADR          (PNX4008_DUM_MAIN_VA_BASE + 0x4004)
+#define DUM_STAT_ADR          (PNX4008_DUM_MAIN_VA_BASE + 0x4008)
+#define DUM_DECODE_ADR        (PNX4008_DUM_MAIN_VA_BASE + 0x400C)
+#define DUM_COM_BASE_ADR      (PNX4008_DUM_MAIN_VA_BASE + 0x4010)
+#define DUM_SYNC_C_ADR        (PNX4008_DUM_MAIN_VA_BASE + 0x4014)
+#define DUM_CLK_DIV_ADR       (PNX4008_DUM_MAIN_VA_BASE + 0x4018)
+#define DUM_DIRTY_LOW_ADR     (PNX4008_DUM_MAIN_VA_BASE + 0x4020)
+#define DUM_DIRTY_HIGH_ADR    (PNX4008_DUM_MAIN_VA_BASE + 0x4024)
+#define DUM_FORMAT_ADR        (PNX4008_DUM_MAIN_VA_BASE + 0x4028)
+#define DUM_WTCFG1_ADR        (PNX4008_DUM_MAIN_VA_BASE + 0x4030)
+#define DUM_RTCFG1_ADR        (PNX4008_DUM_MAIN_VA_BASE + 0x4034)
+#define DUM_WTCFG2_ADR        (PNX4008_DUM_MAIN_VA_BASE + 0x4038)
+#define DUM_RTCFG2_ADR        (PNX4008_DUM_MAIN_VA_BASE + 0x403C)
+#define DUM_TCFG_ADR          (PNX4008_DUM_MAIN_VA_BASE + 0x4040)
+#define DUM_OUTP_FORMAT1_ADR  (PNX4008_DUM_MAIN_VA_BASE + 0x4044)
+#define DUM_OUTP_FORMAT2_ADR  (PNX4008_DUM_MAIN_VA_BASE + 0x4048)
+#define DUM_SYNC_MODE_ADR     (PNX4008_DUM_MAIN_VA_BASE + 0x404C)
+#define DUM_SYNC_OUT_C_ADR    (PNX4008_DUM_MAIN_VA_BASE + 0x4050)
+
+#define DUM_CONF              (*(volatile u32 *)(DUM_CONF_ADR))
+#define DUM_CTRL              (*(volatile u32 *)(DUM_CTRL_ADR))
+#define DUM_STAT              (*(volatile u32 *)(DUM_STAT_ADR))
+#define DUM_DECODE            (*(volatile u32 *)(DUM_DECODE_ADR))
+#define DUM_COM_BASE          (*(volatile u32 *)(DUM_COM_BASE_ADR))
+#define DUM_SYNC_C            (*(volatile u32 *)(DUM_SYNC_C_ADR))
+#define DUM_CLK_DIV           (*(volatile u32 *)(DUM_CLK_DIV_ADR))
+#define DUM_DIRTY_LOW         (*(volatile u32 *)(DUM_DIRTY_LOW_ADR))
+#define DUM_DIRTY_HIGH        (*(volatile u32 *)(DUM_DIRTY_HIGH_ADR))
+#define DUM_FORMAT            (*(volatile u32 *)(DUM_FORMAT_ADR))
+#define DUM_WTCFG1            (*(volatile u32 *)(DUM_WTCFG1_ADR))
+#define DUM_RTCFG1            (*(volatile u32 *)(DUM_RTCFG1_ADR))
+#define DUM_WTCFG2            (*(volatile u32 *)(DUM_WTCFG2_ADR))
+#define DUM_RTCFG2            (*(volatile u32 *)(DUM_RTCFG2_ADR))
+#define DUM_TCFG              (*(volatile u32 *)(DUM_TCFG_ADR))
+#define DUM_OUTP_FORMAT1      (*(volatile u32 *)(DUM_OUTP_FORMAT1_ADR))
+#define DUM_OUTP_FORMAT2      (*(volatile u32 *)(DUM_OUTP_FORMAT2_ADR))
+#define DUM_SYNC_MODE         (*(volatile u32 *)(DUM_SYNC_MODE_ADR))
+#define DUM_SYNC_OUT_C        (*(volatile u32 *)(DUM_SYNC_OUT_C_ADR))
+
+/* DUM SLAVE ADDRESSES */
+#define DUM_SLAVE_WRITE_ADR      (PNX4008_DUM_MAINCFG_BASE + 0x0000000)
+#define DUM_SLAVE_READ1_I_ADR    (PNX4008_DUM_MAINCFG_BASE + 0x1000000)
+#define DUM_SLAVE_READ1_R_ADR    (PNX4008_DUM_MAINCFG_BASE + 0x1000004)
+#define DUM_SLAVE_READ2_I_ADR    (PNX4008_DUM_MAINCFG_BASE + 0x1000008)
+#define DUM_SLAVE_READ2_R_ADR    (PNX4008_DUM_MAINCFG_BASE + 0x100000C)
+
+#define DUM_SLAVE_WRITE_W  ((volatile u32 *)(DUM_SLAVE_WRITE_ADR))
+#define DUM_SLAVE_WRITE_HW ((volatile u16 *)(DUM_SLAVE_WRITE_ADR))
+#define DUM_SLAVE_READ1_I  ((volatile u8 *)(DUM_SLAVE_READ1_I_ADR))
+#define DUM_SLAVE_READ1_R  ((volatile u16 *)(DUM_SLAVE_READ1_R_ADR))
+#define DUM_SLAVE_READ2_I  ((volatile u8 *)(DUM_SLAVE_READ2_I_ADR))
+#define DUM_SLAVE_READ2_R  ((volatile u16 *)(DUM_SLAVE_READ2_R_ADR))
+
+/* Sony display register addresses */
+#define DISP_0_REG            (0x00)
+#define DISP_1_REG            (0x01)
+#define DISP_CAL_REG          (0x20)
+#define DISP_ID_REG           (0x2A)
+#define DISP_XMIN_L_REG       (0x30)
+#define DISP_XMIN_H_REG       (0x31)
+#define DISP_YMIN_REG         (0x32)
+#define DISP_XMAX_L_REG       (0x34)
+#define DISP_XMAX_H_REG       (0x35)
+#define DISP_YMAX_REG         (0x36)
+#define DISP_SYNC_EN_REG      (0x38)
+#define DISP_SYNC_RISE_L_REG  (0x3C)
+#define DISP_SYNC_RISE_H_REG  (0x3D)
+#define DISP_SYNC_FALL_L_REG  (0x3E)
+#define DISP_SYNC_FALL_H_REG  (0x3F)
+#define DISP_PIXEL_REG        (0x0B)
+#define DISP_DUMMY1_REG       (0x28)
+#define DISP_DUMMY2_REG       (0x29)
+#define DISP_TIMING_REG       (0x98)
+#define DISP_DUMP_REG         (0x99)
+
+/* Sony display constants */
+#define SONY_ID1              (0x22)
+#define SONY_ID2              (0x23)
+
+/* Philips display register addresses */
+#define PH_DISP_ORIENT_REG    (0x003)
+#define PH_DISP_YPOINT_REG    (0x200)
+#define PH_DISP_XPOINT_REG    (0x201)
+#define PH_DISP_PIXEL_REG     (0x202)
+#define PH_DISP_YMIN_REG      (0x406)
+#define PH_DISP_YMAX_REG      (0x407)
+#define PH_DISP_XMIN_REG      (0x408)
+#define PH_DISP_XMAX_REG      (0x409)
+
+/* Misc constants */
+#define NO_VALID_DISPLAY_FOUND      (0)
+#define DISPLAY2_IS_NOT_CONNECTED   (0)
+
+/* register values */
+#define V_BAC_ENABLE		(BIT(0))
+#define V_BAC_DISABLE_IDLE	(BIT(1))
+#define V_BAC_DISABLE_TRIG	(BIT(2))
+#define V_DUM_RESET		(BIT(3))
+#define V_MUX_RESET		(BIT(4))
+#define BAC_ENABLED		(BIT(0))
+#define BAC_DISABLED		0
+
+/* Sony LCD commands */
+#define V_LCD_STANDBY_OFF	((BIT(25)) | (0 << 16) | DISP_0_REG)
+#define V_LCD_USE_9BIT_BUS	((BIT(25)) | (2 << 16) | DISP_1_REG)
+#define V_LCD_SYNC_RISE_L	((BIT(25)) | (0 << 16) | DISP_SYNC_RISE_L_REG)
+#define V_LCD_SYNC_RISE_H	((BIT(25)) | (0 << 16) | DISP_SYNC_RISE_H_REG)
+#define V_LCD_SYNC_FALL_L	((BIT(25)) | (160 << 16) | DISP_SYNC_FALL_L_REG)
+#define V_LCD_SYNC_FALL_H	((BIT(25)) | (0 << 16) | DISP_SYNC_FALL_H_REG)
+#define V_LCD_SYNC_ENABLE	((BIT(25)) | (128 << 16) | DISP_SYNC_EN_REG)
+#define V_LCD_DISPLAY_ON	((BIT(25)) | (64 << 16) | DISP_0_REG)
+
+enum {
+	PAD_NONE,
+	PAD_512,
+	PAD_1024
+};
+
+enum {
+	RGB888,
+	RGB666,
+	RGB565,
+	BGR565,
+	ARGB1555,
+	ABGR1555,
+	ARGB4444,
+	ABGR4444
+};
+
+struct dum_setup {
+	int sync_neg_edge;
+	int round_robin;
+	int mux_int;
+	int synced_dirty_flag_int;
+	int dirty_flag_int;
+	int error_int;
+	int pf_empty_int;
+	int sf_empty_int;
+	int bac_dis_int;
+	u32 dirty_base_adr;
+	u32 command_base_adr;
+	u32 sync_clk_div;
+	int sync_output;
+	u32 sync_restart_val;
+	u32 set_sync_high;
+	u32 set_sync_low;
+};
+
+struct dum_ch_setup {
+	int disp_no;
+	u32 xmin;
+	u32 ymin;
+	u32 xmax;
+	u32 ymax;
+	int xmirror;
+	int ymirror;
+	int rotate;
+	u32 minadr;
+	u32 maxadr;
+	u32 dirtybuffer;
+	int pad;
+	int format;
+	int hwdirty;
+	int slave_trans;
+};
+
+struct disp_window {
+	u32 xmin_l;
+	u32 xmin_h;
+	u32 ymin;
+	u32 xmax_l;
+	u32 xmax_h;
+	u32 ymax;
+};
+
+struct dumchanregs {
+	u32 dum_ch_min;
+	u32 dum_ch_max;
+	u32 dum_ch_conf;
+	u32 dum_ch_stat;
+	u32 dum_ch_ctrl;
+
+} __attribute__ ((aligned(0x100)));
+
+struct dumglobregs {
+	u32 dum_conf;		/* 0x400BC000 */
+	u32 dum_ctrl;
+	u32 dum_stat;
+	u32 dum_decode;
+	u32 dum_com_base;	/* 0x400BC010 */
+	u32 dum_sync_c;
+	u32 dum_clk_div;
+	u32 dum_hf_count;
+	u32 dummy1;		/* 0x400BC020 */
+	u32 dummy2;
+	u32 dum_format;
+	u32 dum_cs_ctrl;
+	u32 dum_wtcfg1;		/* 0x400BC030 */
+	u32 dum_rtcfg1;
+	u32 dum_wtcfg2;
+	u32 dum_rtcfg2;
+	u32 dum_tcfg;		/* 0x400BC040 */
+	u32 dum_outp_format1;
+	u32 dum_outp_format2;
+	u32 dum_sync_mode;
+	u32 dum_sync_out_c;	/* 0x400BC050 */
+};
+
+#endif				/* #ifndef __PNX008_DUM_H__ */
Index: linux-2.6.git/drivers/video/pnx4008/fbcommon.h
===================================================================
--- /dev/null
+++ linux-2.6.git/drivers/video/pnx4008/fbcommon.h
@@ -0,0 +1,43 @@
+/*
+ * Copyright (C) 2005 Philips Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; see the file COPYING.  If not, write to
+ * the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 02111-1307, USA, or http://www.gnu.org/licenses/gpl.html
+*/
+
+#define QCIF_W  (176)
+#define QCIF_H  (144)
+
+#define CIF_W   (352)
+#define CIF_H   (288)
+
+#define LCD_X_RES	208
+#define LCD_Y_RES	320
+#define LCD_X_PAD	256
+#define LCD_BBP		4	/* Bytes Per Pixel */
+
+#define DISP_MAX_X_SIZE     (320)
+#define DISP_MAX_Y_SIZE     (208)
+
+#define RETURNVAL_BASE (0x400)
+
+enum fb_ioctl_returntype {
+	ENORESOURCESLEFT = RETURNVAL_BASE,
+	ERESOURCESNOTFREED,
+	EPROCNOTOWNER,
+	EFBNOTOWNER,
+	ECOPYFAILED,
+	EIOREMAPFAILED,
+};
Index: linux-2.6.git/drivers/video/pnx4008/rgbfb.c
===================================================================
--- /dev/null
+++ linux-2.6.git/drivers/video/pnx4008/rgbfb.c
@@ -0,0 +1,223 @@
+/*
+ * drivers/video/pnx4008/rgbfb.c
+ *
+ * PNX4008's framebuffer support
+ *
+ * Author: Grigory Tolstolytkin <gtolstolytkin@ru.mvista.com>
+ * Based on Philips Semiconductors's code
+ *
+ * Copyrght (c) 2005 MontaVista Software, Inc.
+ * Copyright (c) 2005 Philips Semiconductors
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <asm/uaccess.h>
+#include "sdum.h"
+#include "fbcommon.h"
+
+static u32 colreg[16];
+
+extern u32 rgb_lcd_video_start;
+extern u32 rgb_lcd_video_size;
+extern u32 lcd_phys_video_start;
+
+static struct fb_var_screeninfo rgbfb_var __initdata = {
+	.xres = LCD_X_RES,
+	.yres = LCD_Y_RES,
+	.xres_virtual = LCD_X_RES,
+	.yres_virtual = LCD_Y_RES,
+	.bits_per_pixel = 32,
+	.red.offset = 16,
+	.red.length = 8,
+	.green.offset = 8,
+	.green.length = 8,
+	.blue.offset = 0,
+	.blue.length = 8,
+	.left_margin = 0,
+	.right_margin = 0,
+	.upper_margin = 0,
+	.lower_margin = 0,
+	.vmode = FB_VMODE_NONINTERLACED,
+};
+static struct fb_fix_screeninfo rgbfb_fix __initdata = {
+	.id = "RGBFB",
+	.line_length = LCD_X_PAD * LCD_BBP,
+	.type = FB_TYPE_PACKED_PIXELS,
+	.visual = FB_VISUAL_TRUECOLOR,
+	.xpanstep = 0,
+	.ypanstep = 0,
+	.ywrapstep = 0,
+	.accel = FB_ACCEL_NONE,
+};
+
+static int channel_owned;
+
+static int no_cursor(struct fb_info *info, struct fb_cursor *cursor)
+{
+	return 0;
+}
+
+static int rgbfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
+			   u_int transp, struct fb_info *info)
+{
+	if (regno > 15)
+		return 1;
+
+	colreg[regno] = ((red & 0xff00) << 8) | (green & 0xff00) |
+	    ((blue & 0xff00) >> 8);
+	return 0;
+}
+
+static int rgbfb_open(struct fb_info *info, int user)
+{
+	return 0;
+}
+
+static int rgbfb_release(struct fb_info *info, int user)
+{
+	return 0;
+}
+
+static int rgbfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
+{
+	return pnx4008_sdum_mmap(info, vma, NULL);
+}
+
+static struct fb_ops rgbfb_ops = {
+	.fb_open = rgbfb_open,
+	.fb_release = rgbfb_release,
+	.fb_mmap = rgbfb_mmap,
+	.fb_setcolreg = rgbfb_setcolreg,
+	.fb_fillrect = cfb_fillrect,
+	.fb_copyarea = cfb_copyarea,
+	.fb_imageblit = cfb_imageblit,
+	.fb_cursor = no_cursor,
+};
+
+static int rgbfb_remove(struct platform_device *pdev)
+{
+	struct fb_info *info = platform_get_drvdata(pdev);
+
+	if (info) {
+		unregister_framebuffer(info);
+		fb_dealloc_cmap(&info->cmap);
+		framebuffer_release(info);
+		platform_set_drvdata(pdev, NULL);
+	}
+
+	pnx4008_free_dum_channel(channel_owned, pdev->id);
+	pnx4008_set_dum_exit_notification(pdev->id);
+
+	return 0;
+}
+
+static int __devinit rgbfb_probe(struct platform_device *pdev)
+{
+	struct fb_info *info;
+	struct dumchannel_uf chan_uf;
+	int ret;
+
+	info = framebuffer_alloc(sizeof(u32) * 256, &pdev->dev);
+	if (!info) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	pnx4008_get_fb_addresses(FB_TYPE_RGB, (void **)&info->screen_base,
+				 (dma_addr_t *) &rgbfb_fix.smem_start,
+				 &rgbfb_fix.smem_len);
+
+	if ((ret = pnx4008_alloc_dum_channel(pdev->id)) < 0)
+		goto err;
+	else {
+		channel_owned = ret;
+		chan_uf.channelnr = channel_owned;
+		chan_uf.dirty = (u32 *) NULL;
+		chan_uf.source = (u32 *) rgbfb_fix.smem_start;
+		chan_uf.x_offset = 0;
+		chan_uf.y_offset = 0;
+		chan_uf.width = LCD_X_RES;
+		chan_uf.height = LCD_Y_RES;
+
+		if ((ret = pnx4008_put_dum_channel_uf(chan_uf, pdev->id))< 0)
+			goto err;
+
+		if ((ret =
+		     pnx4008_set_dum_channel_sync(channel_owned, CONF_SYNC_ON,
+						  pdev->id)) < 0)
+			goto err;
+
+		if ((ret =
+		     pnx4008_set_dum_chanel_dirty_detect(channel_owned,
+							 CONF_DIRTYDETECTION_ON,
+							 pdev->id)) < 0)
+			goto err;
+	}
+
+	info->node = -1;
+	info->flags = FBINFO_FLAG_DEFAULT;
+	info->fbops = &rgbfb_ops;
+	info->fix = rgbfb_fix;
+	info->var = rgbfb_var;
+	info->screen_size = rgbfb_fix.smem_len;
+	info->pseudo_palette = info->par;
+	info->par = NULL;
+
+	ret = fb_alloc_cmap(&info->cmap, 256, 0);
+	if (ret < 0)
+		goto err1;
+
+	ret = register_framebuffer(info);
+	if (ret < 0)
+		goto err2;
+	platform_set_drvdata(pdev, info);
+
+	return 0;
+
+err2:
+	fb_dealloc_cmap(&info->cmap);
+err1:
+	framebuffer_release(info);
+err:
+	pnx4008_free_dum_channel(channel_owned, pdev->id);
+	return ret;
+}
+
+static struct platform_driver rgbfb_driver = {
+	.driver = {
+		.name = "rgbfb",
+	},
+	.probe = rgbfb_probe,
+	.remove = rgbfb_remove,
+};
+
+static int __init rgbfb_init(void)
+{
+	return platform_driver_register(&rgbfb_driver);
+}
+
+static void __exit rgbfb_exit(void)
+{
+	platform_driver_unregister(&rgbfb_driver);
+}
+
+module_init(rgbfb_init);
+module_exit(rgbfb_exit);
+
+MODULE_LICENSE("GPL");
Index: linux-2.6.git/drivers/video/Kconfig
===================================================================
--- linux-2.6.git.orig/drivers/video/Kconfig
+++ linux-2.6.git/drivers/video/Kconfig
@@ -1560,6 +1560,21 @@ config FB_S3C2410_DEBUG
 	  Turn on debugging messages. Note that you can set/unset at run time
 	  through sysfs
 
+config FB_PNX4008_DUM
+	tristate "Display Update Module support on Philips PNX4008 board"
+	depends on FB && ARCH_PNX4008
+	---help---
+	  Say Y here to enable support for PNX4008 Display Update Module (DUM)
+
+config FB_PNX4008_DUM_RGB
+	tristate "RGB Framebuffer support on Philips PNX4008 board"
+	depends on FB_PNX4008_DUM
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	---help---
+	  Say Y here to enable support for PNX4008 RGB Framebuffer
+
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
Index: linux-2.6.git/drivers/video/Makefile
===================================================================
--- linux-2.6.git.orig/drivers/video/Makefile
+++ linux-2.6.git/drivers/video/Makefile
@@ -94,6 +94,8 @@ obj-$(CONFIG_FB_TX3912)		  += tx3912fb.o
 obj-$(CONFIG_FB_S1D13XXX)	  += s1d13xxxfb.o
 obj-$(CONFIG_FB_IMX)              += imxfb.o
 obj-$(CONFIG_FB_S3C2410)	  += s3c2410fb.o
+obj-$(CONFIG_FB_PNX4008_DUM)	  += pnx4008/
+obj-$(CONFIG_FB_PNX4008_DUM_RGB)  += pnx4008/
 
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_VESA)             += vesafb.o
Index: linux-2.6.git/drivers/video/pnx4008/sdum.c
===================================================================
--- /dev/null
+++ linux-2.6.git/drivers/video/pnx4008/sdum.c
@@ -0,0 +1,866 @@
+/*
+ * drivers/video/pnx4008/sdum.c
+ *
+ * Display Update Master support
+ *
+ * Authors: Grigory Tolstolytkin <gtolstolytkin@ru.mvista.com>
+ *          Vitaly Wool <vitalywool@gmail.com>
+ * Based on Philips Semiconductors's code
+ *
+ * Copyrght (c) 2005-2006 MontaVista Software, Inc.
+ * Copyright (c) 2005 Philips Semiconductors
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/dma-mapping.h>
+#include <linux/clk.h>
+#include <asm/uaccess.h>
+#include <asm/arch/gpio.h>
+
+#include "sdum.h"
+#include "fbcommon.h"
+#include "dum.h"
+
+/* Framebuffers we have */
+
+static struct pnx4008_fb_addr {
+	int fb_type;
+	long addr_offset;
+	long fb_length;
+} fb_addr[] = {
+	[0] = {
+		FB_TYPE_YUV, 0, 0xB0000
+	},
+	[1] = {
+		FB_TYPE_RGB, 0xB0000, 0x50000
+	},
+};
+
+static struct dum_data {
+	u32 lcd_phys_start;
+	u32 lcd_virt_start;
+	u32 slave_phys_base;
+	u32 *slave_virt_base;
+	int fb_owning_channel[MAX_DUM_CHANNELS];
+	struct dumchannel_uf chan_uf_store[MAX_DUM_CHANNELS];
+} dum_data;
+
+/* Different local helper functions */
+
+static u32 nof_pixels_dx(struct dum_ch_setup *ch_setup)
+{
+	return (ch_setup->xmax - ch_setup->xmin + 1);
+}
+
+static u32 nof_pixels_dy(struct dum_ch_setup *ch_setup)
+{
+	return (ch_setup->ymax - ch_setup->ymin + 1);
+}
+
+static u32 nof_pixels_dxy(struct dum_ch_setup *ch_setup)
+{
+	return (nof_pixels_dx(ch_setup) * nof_pixels_dy(ch_setup));
+}
+
+static u32 nof_bytes(struct dum_ch_setup *ch_setup)
+{
+	u32 r = nof_pixels_dxy(ch_setup);
+	switch (ch_setup->format) {
+	case RGB888:
+	case RGB666:
+		r *= 4;
+		break;
+
+	default:
+		r *= 2;
+		break;
+	}
+	return r;
+}
+
+static u32 build_command(int disp_no, u32 reg, u32 val)
+{
+	return ((disp_no << 26) | BIT(25) | (val << 16) | (disp_no << 10) |
+		(reg << 0));
+}
+
+static u32 build_double_index(int disp_no, u32 val)
+{
+	return ((disp_no << 26) | (val << 16) | (disp_no << 10) | (val << 0));
+}
+
+static void build_disp_window(struct dum_ch_setup * ch_setup, struct disp_window * dw)
+{
+	dw->ymin = ch_setup->ymin;
+	dw->ymax = ch_setup->ymax;
+	dw->xmin_l = ch_setup->xmin & 0xFF;
+	dw->xmin_h = (ch_setup->xmin & BIT(8)) >> 8;
+	dw->xmax_l = ch_setup->xmax & 0xFF;
+	dw->xmax_h = (ch_setup->xmax & BIT(8)) >> 8;
+}
+static int get_channel(struct dumchannel *p_chan)
+{
+	int i = p_chan->channelnr;
+
+	if (i < 0 || i > MAX_DUM_CHANNELS)
+		return -EINVAL;
+	else {
+		p_chan->dum_ch_min = DUM_CH_MIN(i);
+		p_chan->dum_ch_max = DUM_CH_MAX(i);
+		p_chan->dum_ch_conf = DUM_CH_CONF(i);
+		p_chan->dum_ch_stat = DUM_CH_STAT(i);
+		p_chan->dum_ch_ctrl = 0;	/* WriteOnly control register */
+	}
+
+	return 0;
+}
+
+static int put_channel(struct dumchannel chan)
+{
+	int i = chan.channelnr;
+
+	if (i < 0 || i > MAX_DUM_CHANNELS)
+		return -EINVAL;
+	else {
+		DUM_CH_MIN(i) = chan.dum_ch_min;
+		DUM_CH_MAX(i) = chan.dum_ch_max;
+		DUM_CH_CONF(i) = chan.dum_ch_conf;
+		DUM_CH_CTRL(i) = chan.dum_ch_ctrl;
+	}
+
+	return 0;
+}
+
+static void clear_channel(int channr)
+{
+	struct dumchannel chan;
+
+	chan.channelnr = channr;
+	chan.dum_ch_min = 0;
+	chan.dum_ch_max = 0;
+	chan.dum_ch_conf = 0;
+	chan.dum_ch_ctrl = 0;
+
+	put_channel(chan);
+}
+
+static int put_cmd_string(struct cmdstring cmds)
+{
+	u16 *cmd_str_virtaddr;
+	int *cmd_ptr0_virtaddr;
+	int cmd_str_physaddr;
+
+	int i = cmds.channelnr;
+
+	if (i < 0 || i > MAX_DUM_CHANNELS)
+		return -EINVAL;
+	else if ((cmd_ptr0_virtaddr =
+		  (int *)ioremap_nocache(DUM_COM_BASE,
+					 sizeof(int) * MAX_DUM_CHANNELS)) ==
+		 NULL)
+		return -EIOREMAPFAILED;
+	else {
+		cmd_str_physaddr = cmd_ptr0_virtaddr[cmds.channelnr];
+		if ((cmd_str_virtaddr =
+		     (u16 *) ioremap_nocache(cmd_str_physaddr,
+					     sizeof(cmds))) == NULL) {
+			iounmap(cmd_ptr0_virtaddr);
+			return -EIOREMAPFAILED;
+		} else {
+			int t;
+			for (t = 0; t < 8; t++)
+				cmd_str_virtaddr[t] =
+				    *((u16 *) & (cmds.prestringlen) + t);
+
+			for (t = 0; t < cmds.prestringlen / 2; t++)
+				cmd_str_virtaddr[8 + t] =
+				    *((u16 *) & (cmds.precmd) + t);
+
+			for (t = 0; t < cmds.poststringlen / 2; t++)
+				cmd_str_virtaddr[8 + t +
+						 cmds.prestringlen / 2] =
+				    *((u16 *) & (cmds.postcmd) + t);
+
+			iounmap(cmd_ptr0_virtaddr);
+			iounmap(cmd_str_virtaddr);
+		}
+	}
+
+	return 0;
+}
+
+static u32 dum_ch_setup(int ch_no, struct dum_ch_setup * ch_setup)
+{
+	struct cmdstring cmds_c;
+	struct cmdstring *cmds = &cmds_c;
+	struct disp_window dw;
+	int standard;
+	u32 orientation = 0;
+	struct dumchannel chan = { 0 };
+	int ret;
+
+	if ((ch_setup->xmirror) || (ch_setup->ymirror) || (ch_setup->rotate)) {
+		standard = 0;
+
+		orientation = BIT(1);	/* always set 9-bit-bus */
+		if (ch_setup->xmirror)
+			orientation |= BIT(4);
+		if (ch_setup->ymirror)
+			orientation |= BIT(3);
+		if (ch_setup->rotate)
+			orientation |= BIT(0);
+	} else
+		standard = 1;
+
+	cmds->channelnr = ch_no;
+
+	/* build command string header */
+	if (standard) {
+		cmds->prestringlen = 32;
+		cmds->poststringlen = 0;
+	} else {
+		cmds->prestringlen = 48;
+		cmds->poststringlen = 16;
+	}
+
+	cmds->format =
+	    (u16) ((ch_setup->disp_no << 4) | (BIT(3)) | (ch_setup->format));
+	cmds->reserved = 0x0;
+	cmds->startaddr_low = (ch_setup->minadr & 0xFFFF);
+	cmds->startaddr_high = (ch_setup->minadr >> 16);
+
+	if ((ch_setup->minadr == 0) && (ch_setup->maxadr == 0)
+	    && (ch_setup->xmin == 0)
+	    && (ch_setup->ymin == 0) && (ch_setup->xmax == 0)
+	    && (ch_setup->ymax == 0)) {
+		cmds->pixdatlen_low = 0;
+		cmds->pixdatlen_high = 0;
+	} else {
+		u32 nbytes = nof_bytes(ch_setup);
+		cmds->pixdatlen_low = (nbytes & 0xFFFF);
+		cmds->pixdatlen_high = (nbytes >> 16);
+	}
+
+	if (ch_setup->slave_trans)
+		cmds->pixdatlen_high |= BIT(15);
+
+	/* build pre-string */
+	build_disp_window(ch_setup, &dw);
+
+	if (standard) {
+		cmds->precmd[0] =
+		    build_command(ch_setup->disp_no, DISP_XMIN_L_REG, 0x99);
+		cmds->precmd[1] =
+		    build_command(ch_setup->disp_no, DISP_XMIN_L_REG,
+				  dw.xmin_l);
+		cmds->precmd[2] =
+		    build_command(ch_setup->disp_no, DISP_XMIN_H_REG,
+				  dw.xmin_h);
+		cmds->precmd[3] =
+		    build_command(ch_setup->disp_no, DISP_YMIN_REG, dw.ymin);
+		cmds->precmd[4] =
+		    build_command(ch_setup->disp_no, DISP_XMAX_L_REG,
+				  dw.xmax_l);
+		cmds->precmd[5] =
+		    build_command(ch_setup->disp_no, DISP_XMAX_H_REG,
+				  dw.xmax_h);
+		cmds->precmd[6] =
+		    build_command(ch_setup->disp_no, DISP_YMAX_REG, dw.ymax);
+		cmds->precmd[7] =
+		    build_double_index(ch_setup->disp_no, DISP_PIXEL_REG);
+	} else {
+		if (dw.xmin_l == ch_no)
+			cmds->precmd[0] =
+			    build_command(ch_setup->disp_no, DISP_XMIN_L_REG,
+					  0x99);
+		else
+			cmds->precmd[0] =
+			    build_command(ch_setup->disp_no, DISP_XMIN_L_REG,
+					  ch_no);
+
+		cmds->precmd[1] =
+		    build_command(ch_setup->disp_no, DISP_XMIN_L_REG,
+				  dw.xmin_l);
+		cmds->precmd[2] =
+		    build_command(ch_setup->disp_no, DISP_XMIN_H_REG,
+				  dw.xmin_h);
+		cmds->precmd[3] =
+		    build_command(ch_setup->disp_no, DISP_YMIN_REG, dw.ymin);
+		cmds->precmd[4] =
+		    build_command(ch_setup->disp_no, DISP_XMAX_L_REG,
+				  dw.xmax_l);
+		cmds->precmd[5] =
+		    build_command(ch_setup->disp_no, DISP_XMAX_H_REG,
+				  dw.xmax_h);
+		cmds->precmd[6] =
+		    build_command(ch_setup->disp_no, DISP_YMAX_REG, dw.ymax);
+		cmds->precmd[7] =
+		    build_command(ch_setup->disp_no, DISP_1_REG, orientation);
+		cmds->precmd[8] =
+		    build_double_index(ch_setup->disp_no, DISP_PIXEL_REG);
+		cmds->precmd[9] =
+		    build_double_index(ch_setup->disp_no, DISP_PIXEL_REG);
+		cmds->precmd[0xA] =
+		    build_double_index(ch_setup->disp_no, DISP_PIXEL_REG);
+		cmds->precmd[0xB] =
+		    build_double_index(ch_setup->disp_no, DISP_PIXEL_REG);
+		cmds->postcmd[0] =
+		    build_command(ch_setup->disp_no, DISP_1_REG, BIT(1));
+		cmds->postcmd[1] =
+		    build_command(ch_setup->disp_no, DISP_DUMMY1_REG, 1);
+		cmds->postcmd[2] =
+		    build_command(ch_setup->disp_no, DISP_DUMMY1_REG, 2);
+		cmds->postcmd[3] =
+		    build_command(ch_setup->disp_no, DISP_DUMMY1_REG, 3);
+	}
+
+	if ((ret = put_cmd_string(cmds_c)) != 0) {
+		return ret;
+	}
+
+	chan.channelnr = cmds->channelnr;
+	chan.dum_ch_min = ch_setup->dirtybuffer + ch_setup->minadr;
+	chan.dum_ch_max = ch_setup->dirtybuffer + ch_setup->maxadr;
+	chan.dum_ch_conf = 0x002;
+	chan.dum_ch_ctrl = 0x04;
+
+	put_channel(chan);
+
+	return 0;
+}
+
+static u32 display_open(int ch_no, int auto_update, u32 * dirty_buffer,
+			u32 * frame_buffer, u32 xpos, u32 ypos, u32 w, u32 h)
+{
+
+	struct dum_ch_setup k;
+	int ret;
+
+	/* keep width & height within display area */
+	if ((xpos + w) > DISP_MAX_X_SIZE)
+		w = DISP_MAX_X_SIZE - xpos;
+
+	if ((ypos + h) > DISP_MAX_Y_SIZE)
+		h = DISP_MAX_Y_SIZE - ypos;
+
+	/* assume 1 display only */
+	k.disp_no = 0;
+	k.xmin = xpos;
+	k.ymin = ypos;
+	k.xmax = xpos + (w - 1);
+	k.ymax = ypos + (h - 1);
+
+	/* adjust min and max values if necessary */
+	if (k.xmin > DISP_MAX_X_SIZE - 1)
+		k.xmin = DISP_MAX_X_SIZE - 1;
+	if (k.ymin > DISP_MAX_Y_SIZE - 1)
+		k.ymin = DISP_MAX_Y_SIZE - 1;
+
+	if (k.xmax > DISP_MAX_X_SIZE - 1)
+		k.xmax = DISP_MAX_X_SIZE - 1;
+	if (k.ymax > DISP_MAX_Y_SIZE - 1)
+		k.ymax = DISP_MAX_Y_SIZE - 1;
+
+	k.xmirror = 0;
+	k.ymirror = 0;
+	k.rotate = 0;
+	k.minadr = (u32) frame_buffer;
+	k.maxadr = (u32) frame_buffer + (((w - 1) << 10) | ((h << 2) - 2));
+	k.pad = PAD_1024;
+	k.dirtybuffer = (u32) dirty_buffer;
+	k.format = RGB888;
+	k.hwdirty = 0;
+	k.slave_trans = 0;
+
+	ret = dum_ch_setup(ch_no, &k);
+
+	return ret;
+}
+
+static void lcd_reset(void)
+{
+	u32 *dum_pio_base = (u32 *)IO_ADDRESS(PNX4008_PIO_BASE);
+
+	udelay(1);
+	__raw_writel(BIT(19), &dum_pio_base[2]);
+	udelay(1);
+	__raw_writel(BIT(19), &dum_pio_base[1]);
+	udelay(1);
+}
+
+static int dum_init(struct platform_device *pdev)
+{
+	struct clk *clk;
+
+	/* enable DUM clock */
+	clk = clk_get(&pdev->dev, "dum_ck");
+	if (IS_ERR(clk)) {
+		printk(KERN_ERR "pnx4008_dum: Unable to access DUM clock\n");
+		return PTR_ERR(clk);
+	}
+
+	clk_set_rate(clk, 1);
+	clk_put(clk);
+
+	DUM_CTRL = V_DUM_RESET;
+
+	/* set priority to "round-robin". All other params to "false" */
+	DUM_CONF = BIT(9);
+
+	/* Display 1 */
+	DUM_WTCFG1 = PNX4008_DUM_WT_CFG;
+	DUM_RTCFG1 = PNX4008_DUM_RT_CFG;
+	DUM_TCFG = PNX4008_DUM_T_CFG;
+
+	return 0;
+}
+
+static void dum_chan_init(void)
+{
+	int i = 0, ch = 0;
+	u32 *cmdptrs;
+	u32 *cmdstrings;
+
+	DUM_COM_BASE =
+		CMDSTRING_BASEADDR + BYTES_PER_CMDSTRING * NR_OF_CMDSTRINGS;
+
+	if ((cmdptrs =
+	     (u32 *) ioremap_nocache(DUM_COM_BASE,
+				     sizeof(u32) * NR_OF_CMDSTRINGS)) == NULL)
+		return;
+
+	for (ch = 0; ch < NR_OF_CMDSTRINGS; ch++)
+		iowrite32(CMDSTRING_BASEADDR + BYTES_PER_CMDSTRING * ch,
+			  cmdptrs + ch);
+
+	for (ch = 0; ch < MAX_DUM_CHANNELS; ch++)
+		clear_channel(ch);
+
+	/* Clear the cmdstrings */
+	cmdstrings =
+	    (u32 *)ioremap_nocache(*cmdptrs,
+				   BYTES_PER_CMDSTRING * NR_OF_CMDSTRINGS);
+
+	if (!cmdstrings)
+		goto out;
+
+	for (i = 0; i < NR_OF_CMDSTRINGS * BYTES_PER_CMDSTRING / sizeof(u32);
+	     i++)
+		__raw_writel(0, cmdstrings + i);
+
+	iounmap((u32 *)cmdstrings);
+
+out:
+	iounmap((u32 *)cmdptrs);
+}
+
+static void lcd_init(void)
+{
+	lcd_reset();
+
+	DUM_OUTP_FORMAT1 = 0; /* DUM_OUTP_FORMAT1, RGB666 */
+
+	udelay(1);
+	__raw_writel(V_LCD_STANDBY_OFF, dum_data.slave_virt_base);
+	udelay(1);
+	__raw_writel(V_LCD_USE_9BIT_BUS, dum_data.slave_virt_base);
+	udelay(1);
+	__raw_writel(V_LCD_SYNC_RISE_L, dum_data.slave_virt_base);
+	udelay(1);
+	__raw_writel(V_LCD_SYNC_RISE_H, dum_data.slave_virt_base);
+	udelay(1);
+	__raw_writel(V_LCD_SYNC_FALL_L, dum_data.slave_virt_base);
+	udelay(1);
+	__raw_writel(V_LCD_SYNC_FALL_H, dum_data.slave_virt_base);
+	udelay(1);
+	__raw_writel(V_LCD_SYNC_ENABLE, dum_data.slave_virt_base);
+	udelay(1);
+	__raw_writel(V_LCD_DISPLAY_ON, dum_data.slave_virt_base);
+	udelay(1);
+}
+
+/* Interface exported to framebuffer drivers */
+
+int pnx4008_get_fb_addresses(int fb_type, void **virt_addr,
+			     dma_addr_t *phys_addr, int *fb_length)
+{
+	int i;
+	int ret = -1;
+	for (i = 0; i < ARRAY_SIZE(fb_addr); i++)
+		if (fb_addr[i].fb_type == fb_type) {
+			*virt_addr = (void *)(dum_data.lcd_virt_start +
+					fb_addr[i].addr_offset);
+			*phys_addr =
+			    dum_data.lcd_phys_start + fb_addr[i].addr_offset;
+			*fb_length = fb_addr[i].fb_length;
+			ret = 0;
+			break;
+		}
+
+	return ret;
+}
+
+EXPORT_SYMBOL(pnx4008_get_fb_addresses);
+
+int pnx4008_alloc_dum_channel(int dev_id)
+{
+	int i = 0;
+
+	while ((i < MAX_DUM_CHANNELS) && (dum_data.fb_owning_channel[i] != -1))
+		i++;
+
+	if (i == MAX_DUM_CHANNELS)
+		return -ENORESOURCESLEFT;
+	else {
+		dum_data.fb_owning_channel[i] = dev_id;
+		return i;
+	}
+}
+
+EXPORT_SYMBOL(pnx4008_alloc_dum_channel);
+
+int pnx4008_free_dum_channel(int channr, int dev_id)
+{
+	if (channr < 0 || channr > MAX_DUM_CHANNELS)
+		return -EINVAL;
+	else if (dum_data.fb_owning_channel[channr] != dev_id)
+		return -EFBNOTOWNER;
+	else {
+		clear_channel(channr);
+		dum_data.fb_owning_channel[channr] = -1;
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL(pnx4008_free_dum_channel);
+
+int pnx4008_get_dum_channel_uf(struct dumchannel_uf *p_chan_uf, int dev_id)
+{
+	int i = p_chan_uf->channelnr;
+
+	if (i < 0 || i > MAX_DUM_CHANNELS)
+		return -EINVAL;
+	else if (dum_data.fb_owning_channel[i] != dev_id)
+		return -EFBNOTOWNER;
+	else {
+		p_chan_uf->dirty = dum_data.chan_uf_store[i].dirty;
+		p_chan_uf->source = dum_data.chan_uf_store[i].source;
+		p_chan_uf->x_offset = dum_data.chan_uf_store[i].x_offset;
+		p_chan_uf->y_offset = dum_data.chan_uf_store[i].y_offset;
+		p_chan_uf->width = dum_data.chan_uf_store[i].width;
+		p_chan_uf->height = dum_data.chan_uf_store[i].height;
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL(pnx4008_get_dum_channel_uf);
+
+int pnx4008_put_dum_channel_uf(struct dumchannel_uf chan_uf, int dev_id)
+{
+	int i = chan_uf.channelnr;
+	int ret;
+
+	if (i < 0 || i > MAX_DUM_CHANNELS)
+		return -EINVAL;
+	else if (dum_data.fb_owning_channel[i] != dev_id)
+		return -EFBNOTOWNER;
+	else if ((ret =
+		  display_open(chan_uf.channelnr, 0, chan_uf.dirty,
+			       chan_uf.source, chan_uf.y_offset,
+			       chan_uf.x_offset, chan_uf.height,
+			       chan_uf.width)) != 0)
+		return ret;
+	else {
+		dum_data.chan_uf_store[i].dirty = chan_uf.dirty;
+		dum_data.chan_uf_store[i].source = chan_uf.source;
+		dum_data.chan_uf_store[i].x_offset = chan_uf.x_offset;
+		dum_data.chan_uf_store[i].y_offset = chan_uf.y_offset;
+		dum_data.chan_uf_store[i].width = chan_uf.width;
+		dum_data.chan_uf_store[i].height = chan_uf.height;
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL(pnx4008_put_dum_channel_uf);
+
+int pnx4008_get_dum_channel_config(int channr, int dev_id)
+{
+	int ret;
+	struct dumchannel chan;
+
+	if (channr < 0 || channr > MAX_DUM_CHANNELS)
+		return -EINVAL;
+	else if (dum_data.fb_owning_channel[channr] != dev_id)
+		return -EFBNOTOWNER;
+	else {
+		chan.channelnr = channr;
+		if ((ret = get_channel(&chan)) != 0)
+			return ret;
+	}
+
+	return (chan.dum_ch_conf & DUM_CHANNEL_CFG_MASK);
+}
+
+EXPORT_SYMBOL(pnx4008_get_dum_channel_config);
+
+int pnx4008_set_dum_channel_sync(int channr, int val, int dev_id)
+{
+	if (channr < 0 || channr > MAX_DUM_CHANNELS)
+		return -EINVAL;
+	else if (dum_data.fb_owning_channel[channr] != dev_id)
+		return -EFBNOTOWNER;
+	else {
+		if (val == CONF_SYNC_ON) {
+			DUM_CH_CONF(channr) |= CONF_SYNCENABLE;
+			DUM_CH_CONF(channr) |= DUM_CHANNEL_CFG_SYNC_MASK |
+				DUM_CHANNEL_CFG_SYNC_MASK_SET;
+		} else if (val == CONF_SYNC_OFF)
+			DUM_CH_CONF(channr) &= ~CONF_SYNCENABLE;
+		else
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL(pnx4008_set_dum_channel_sync);
+
+int pnx4008_set_dum_chanel_dirty_detect(int channr, int val, int dev_id)
+{
+	if (channr < 0 || channr > MAX_DUM_CHANNELS)
+		return -EINVAL;
+	else if (dum_data.fb_owning_channel[channr] != dev_id)
+		return -EFBNOTOWNER;
+	else {
+		if (val == CONF_DIRTYDETECTION_ON)
+			DUM_CH_CONF(channr) |= CONF_DIRTYENABLE;
+		else if (val == CONF_DIRTYDETECTION_OFF)
+			DUM_CH_CONF(channr) &= ~CONF_DIRTYENABLE;
+		else
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL(pnx4008_set_dum_chanel_dirty_detect);
+
+int pnx4008_force_update_dum_channel(int channr, int dev_id)
+{
+	if (channr < 0 || channr > MAX_DUM_CHANNELS)
+		return -EINVAL;
+
+	else if (dum_data.fb_owning_channel[channr] != dev_id)
+		return -EFBNOTOWNER;
+	else
+		DUM_CH_CTRL(channr) = CTRL_SETDIRTY;
+
+	return 0;
+}
+
+EXPORT_SYMBOL(pnx4008_force_update_dum_channel);
+
+int pnx4008_sdum_mmap(struct fb_info *info, struct vm_area_struct *vma,
+		      struct device *dev)
+{
+	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
+
+	if (off < info->fix.smem_len) {
+		vma->vm_pgoff += 1;
+		return dma_mmap_writecombine(dev, vma,
+				(void *)dum_data.lcd_virt_start,
+				dum_data.lcd_phys_start,
+				FB_DMA_SIZE);
+	}
+	return -EINVAL;
+}
+
+EXPORT_SYMBOL(pnx4008_sdum_mmap);
+
+int pnx4008_set_dum_exit_notification(int dev_id)
+{
+	int i;
+
+	for (i = 0; i < MAX_DUM_CHANNELS; i++)
+		if (dum_data.fb_owning_channel[i] == dev_id)
+			return -ERESOURCESNOTFREED;
+
+	return 0;
+}
+
+EXPORT_SYMBOL(pnx4008_set_dum_exit_notification);
+
+/* Platform device driver for DUM */
+
+static int sdum_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	int retval = 0;
+	struct clk *clk;
+
+	clk = clk_get(0, "dum_ck");
+	if (!IS_ERR(clk)) {
+		clk_set_rate(clk, 0);
+		clk_put(clk);
+	} else
+		retval = PTR_ERR(clk);
+
+	/* disable BAC */
+	DUM_CTRL = V_BAC_DISABLE_IDLE;
+
+	/* LCD standby & turn off display */
+	lcd_reset();
+
+	return retval;
+}
+
+static int sdum_resume(struct platform_device *pdev)
+{
+	int retval = 0;
+	struct clk *clk;
+
+	clk = clk_get(0, "dum_ck");
+	if (!IS_ERR(clk)) {
+		clk_set_rate(clk, 1);
+		clk_put(clk);
+	} else
+		retval = PTR_ERR(clk);
+
+	/* wait for BAC disable */
+	DUM_CTRL = V_BAC_DISABLE_TRIG;
+
+	while (DUM_CTRL & BAC_ENABLED)
+		udelay(10);
+
+	/* re-init LCD */
+	lcd_init();
+
+	/* enable BAC and reset MUX */
+	DUM_CTRL = V_BAC_ENABLE;
+	udelay(1);
+	DUM_CTRL = V_MUX_RESET;
+	return 0;
+}
+
+static int __devinit sdum_probe(struct platform_device *pdev)
+{
+	int ret = 0, i = 0;
+
+	/* map frame buffer */
+	dum_data.lcd_virt_start = (u32) dma_alloc_writecombine(&pdev->dev,
+						       FB_DMA_SIZE,
+						       &dum_data.lcd_phys_start,
+						       GFP_KERNEL);
+
+	if (!dum_data.lcd_virt_start) {
+		ret = -ENOMEM;
+		goto out_3;
+	}
+
+	/* map slave registers */
+	dum_data.slave_phys_base = PNX4008_DUM_SLAVE_BASE;
+	dum_data.slave_virt_base =
+	    (u32 *) ioremap_nocache(dum_data.slave_phys_base, sizeof(u32));
+
+	if (dum_data.slave_virt_base == NULL) {
+		ret = -ENOMEM;
+		goto out_2;
+	}
+
+	/* initialize DUM and LCD display */
+	ret = dum_init(pdev);
+	if (ret)
+		goto out_1;
+
+	dum_chan_init();
+	lcd_init();
+
+	DUM_CTRL = V_BAC_ENABLE;
+	udelay(1);
+	DUM_CTRL = V_MUX_RESET;
+
+	/* set decode address and sync clock divider */
+	DUM_DECODE = dum_data.lcd_phys_start & DUM_DECODE_MASK;
+	DUM_CLK_DIV = PNX4008_DUM_CLK_DIV;
+
+	for (i = 0; i < MAX_DUM_CHANNELS; i++)
+		dum_data.fb_owning_channel[i] = -1;
+
+	/*setup wakeup interrupt */
+	start_int_set_rising_edge(SE_DISP_SYNC_INT);
+	start_int_ack(SE_DISP_SYNC_INT);
+	start_int_umask(SE_DISP_SYNC_INT);
+
+	return 0;
+
+out_1:
+	iounmap((void *)dum_data.slave_virt_base);
+out_2:
+	dma_free_writecombine(&pdev->dev, FB_DMA_SIZE, (void *)dum_data.lcd_virt_start,
+			      dum_data.lcd_phys_start);
+out_3:
+	return ret;
+}
+
+static int sdum_remove(struct platform_device *pdev)
+{
+	struct clk *clk;
+
+	start_int_mask(SE_DISP_SYNC_INT);
+
+	clk = clk_get(0, "dum_ck");
+	if (!IS_ERR(clk)) {
+		clk_set_rate(clk, 0);
+		clk_put(clk);
+	}
+
+	iounmap((void *)dum_data.slave_virt_base);
+
+	dma_free_writecombine(&pdev->dev, FB_DMA_SIZE,
+			(void *)dum_data.lcd_virt_start,
+			dum_data.lcd_phys_start);
+
+	return 0;
+}
+
+static struct platform_driver sdum_driver = {
+	.driver = {
+		.name = "sdum",
+	},
+	.probe = sdum_probe,
+	.remove = sdum_remove,
+	.suspend = sdum_suspend,
+	.resume = sdum_resume,
+};
+
+int __init sdum_init(void)
+{
+	return platform_driver_register(&sdum_driver);
+}
+
+static void __exit sdum_exit(void)
+{
+	platform_driver_unregister(&sdum_driver);
+};
+
+module_init(sdum_init);
+module_exit(sdum_exit);
+
+MODULE_LICENSE("GPL");
Index: linux-2.6.git/drivers/video/pnx4008/sdum.h
===================================================================
--- /dev/null
+++ linux-2.6.git/drivers/video/pnx4008/sdum.h
@@ -0,0 +1,139 @@
+/*
+ * Copyright (C) 2005 Philips Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; see the file COPYING.  If not, write to
+ * the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 02111-1307, USA, or http://www.gnu.org/licenses/gpl.html
+*/
+
+#define MAX_DUM_CHANNELS	64
+
+#define RGB_MEM_WINDOW(x) (0x10000000 + (x)*0x00100000)
+
+#define QCIF_OFFSET(x) (((x) == 0) ? 0x00000: ((x) == 1) ? 0x30000: -1)
+#define CIF_OFFSET(x)  (((x) == 0) ? 0x00000: ((x) == 1) ? 0x60000: -1)
+
+#define CTRL_SETDIRTY	 	(0x00000001)
+#define CONF_DIRTYENABLE	(0x00000020)
+#define CONF_SYNCENABLE		(0x00000004)
+
+#define DIRTY_ENABLED(conf)	((conf) & 0x0020)
+#define SYNC_ENABLED(conf) 	((conf) & 0x0004)
+
+/* Display 1 & 2 Write Timing Configuration */
+#define PNX4008_DUM_WT_CFG		0x00372000
+
+/* Display 1 & 2 Read Timing Configuration */
+#define PNX4008_DUM_RT_CFG		0x00003A47
+
+/* DUM Transit State Timing Configuration */
+#define PNX4008_DUM_T_CFG		0x1D	/* 29 HCLK cycles */
+
+/* DUM Sync count clock divider */
+#define PNX4008_DUM_CLK_DIV		0x02DD
+
+/* Memory size for framebuffer, allocated through dma_alloc_writecombine().
+ * Must be PAGE aligned
+ */
+#define FB_DMA_SIZE (PAGE_ALIGN(SZ_1M + PAGE_SIZE))
+
+#define OFFSET_RGBBUFFER (0xB0000)
+#define OFFSET_YUVBUFFER (0x00000)
+
+#define YUVBUFFER (lcd_video_start + OFFSET_YUVBUFFER)
+#define RGBBUFFER (lcd_video_start + OFFSET_RGBBUFFER)
+
+#define CMDSTRING_BASEADDR	(0x00C000)	/* iram */
+#define BYTES_PER_CMDSTRING	(0x80)
+#define NR_OF_CMDSTRINGS	(64)
+
+#define MAX_NR_PRESTRINGS (0x40)
+#define MAX_NR_POSTSTRINGS (0x40)
+
+/* various mask definitions */
+#define DUM_CLK_ENABLE 0x01
+#define DUM_CLK_DISABLE 0
+#define DUM_DECODE_MASK 0x1FFFFFFF
+#define DUM_CHANNEL_CFG_MASK 0x01FF
+#define DUM_CHANNEL_CFG_SYNC_MASK 0xFFFE00FF
+#define DUM_CHANNEL_CFG_SYNC_MASK_SET 0x0CA00
+
+#define SDUM_RETURNVAL_BASE (0x500)
+
+#define CONF_SYNC_OFF		(0x602)
+#define CONF_SYNC_ON		(0x603)
+
+#define CONF_DIRTYDETECTION_OFF	(0x600)
+#define CONF_DIRTYDETECTION_ON	(0x601)
+
+/* Set the corresponding bit. */
+#define BIT(n) (0x1U << (n))
+
+struct dumchannel_uf {
+	int channelnr;
+	u32 *dirty;
+	u32 *source;
+	u32 x_offset;
+	u32 y_offset;
+	u32 width;
+	u32 height;
+};
+
+enum {
+	FB_TYPE_YUV,
+	FB_TYPE_RGB
+};
+
+struct cmdstring {
+	int channelnr;
+	uint16_t prestringlen;
+	uint16_t poststringlen;
+	uint16_t format;
+	uint16_t reserved;
+	uint16_t startaddr_low;
+	uint16_t startaddr_high;
+	uint16_t pixdatlen_low;
+	uint16_t pixdatlen_high;
+	u32 precmd[MAX_NR_PRESTRINGS];
+	u32 postcmd[MAX_NR_POSTSTRINGS];
+
+};
+
+struct dumchannel {
+	int channelnr;
+	int dum_ch_min;
+	int dum_ch_max;
+	int dum_ch_conf;
+	int dum_ch_stat;
+	int dum_ch_ctrl;
+};
+
+int pnx4008_alloc_dum_channel(int dev_id);
+int pnx4008_free_dum_channel(int channr, int dev_id);
+
+int pnx4008_get_dum_channel_uf(struct dumchannel_uf *pChan_uf, int dev_id);
+int pnx4008_put_dum_channel_uf(struct dumchannel_uf chan_uf, int dev_id);
+
+int pnx4008_set_dum_channel_sync(int channr, int val, int dev_id);
+int pnx4008_set_dum_chanel_dirty_detect(int channr, int val, int dev_id);
+
+int pnx4008_force_dum_update_channel(int channr, int dev_id);
+
+int pnx4008_get_dum_channel_config(int channr, int dev_id);
+
+int pnx4008_sdum_mmap(struct fb_info *info, struct vm_area_struct *vma, struct device *dev);
+int pnx4008_set_dum_exit_notification(int dev_id);
+
+int pnx4008_get_fb_addresses(int fb_type, void **virt_addr,
+			     dma_addr_t * phys_addr, int *fb_length);
