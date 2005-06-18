Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVFRPDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVFRPDs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 11:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVFRPDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 11:03:48 -0400
Received: from god.demon.nl ([83.160.164.11]:60032 "EHLO god.dyndns.org")
	by vger.kernel.org with ESMTP id S262134AbVFRO5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 10:57:33 -0400
Date: Sat, 18 Jun 2005 16:57:30 +0200
From: Henk <Henk.Vergonet@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] new driver for yealink usb-p1k phone
Message-ID: <20050618145730.GA12871@god.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi developers,

In an attempt to make VOIP technology usable by other members of the
household, I have created a device driver for the Yealink usb-p1k phone
also known as a so called Skype phone.

Basically the device consists of an usb sound-card with keyboard, LCD, 
speaker and will set you back for about 30 euro's.

The "sound card" is supported by the generic usb-audio driver.
This driver adds support for keyboard, LED, dialtone and LCD functions.


The patch is tested and generated against linux-2.6.12-rc6 and contains
the following files:

	Documentation/input/yealink.txt		new
	drivers/usb/input/map_to_7segment.h	new
	   (see a related discussion on http://lkml.org/lkml/2005/5/31/232 )
	drivers/usb/input/yealink.c		new
	drivers/usb/input/yealink.h		new
	drivers/usb/input/Kconfig		modified
	drivers/usb/input/Makefile		modified



Please can this be included in the development tree, I would be happy to 
adapt the code if this is needed after some review.

What dou you think?

Cheers,

Henk

(PS This message was also posted to linux-usb-devel)


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="PATCH.2.6.12.rc6.yealink.driver"

--- linux-2.6/drivers/usb/input/map_to_7segment.h.orig	2005-06-16 23:21:31.000000000 +0200
+++ linux-2.6/drivers/usb/input/map_to_7segment.h	2005-05-31 22:57:16.000000000 +0200
@@ -0,0 +1,189 @@
+/*
+ * include/map/map_to_7segment.h
+ *
+ * Copyright (c) 2005 Henk Vergonet <Henk.Vergonet@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef MAP_TO_7SEGMENT_H
+#define MAP_TO_7SEGMENT_H
+
+/* This file provides translation primitives and tables for the conversion 
+ * of (ASCII) characters to a 7-segments notation.
+ *
+ * The 7 segment's notation below s used as standard, as it looks like it is
+ * the most commonly used.
+ *
+ * See: http://en.wikipedia.org/wiki/Seven_segment_display
+ *
+ * Notation:	+-a-+
+ *		f   b
+ *		+-g-+
+ *		e   c
+ *		+-d-+
+ *
+ * Usage:
+ *
+ *   Register a map variable, and fill it with a character set:
+ * 	static SEG7_DEFAULT_MAP(map_seg7);
+ *
+ *
+ *   Then use for conversion:
+ *	seg7 = map_to_seg7(&map_seg7, some_char);
+ *	...
+ * 
+ * In device drivers it is recommended to make the map accessible via the
+ * sysfs interface, please use the MAP_SEG7_SYSFS_FILE naming convention:
+ *
+ * static ssize_t show_map(struct device *dev, char *buf) {
+ *	memcpy(buf, &map_seg7, sizeof(map_seg7));
+ *	return sizeof(map_seg7);
+ * }
+ * static ssize_t store_map(struct device *dev, const char *buf, size_t cnt) {
+ *	memcpy(&map_seg7, buf, cnt > sizeof(map_seg7) ? sizeof(map_seg7) : cnt);
+ *	return cnt;
+ * }
+ * static DEVICE_ATTR(map_seg7, PERMS_RW, show_map, store_map);
+ *
+ * History:
+ * 2005-05-31	RFC linux-kernel@vger.kernel.org
+ */
+#include <linux/errno.h>
+
+
+#define BIT_SEG7_A		0
+#define BIT_SEG7_B		1
+#define BIT_SEG7_C		2
+#define BIT_SEG7_D		3
+#define BIT_SEG7_E		4
+#define BIT_SEG7_F		5
+#define BIT_SEG7_G		6
+#define BIT_SEG7_RESERVED	7
+
+struct seg7_conversion_map {
+	unsigned char	table[128];
+};
+
+static inline int map_to_seg7(struct seg7_conversion_map *map, int c)
+{
+	return c & 0x7f ? map->table[c] : -EINVAL;
+}
+
+#define SEG7_CONVERSION_MAP(_name, _map)	\
+	struct seg7_conversion_map _name = { .table = { _map } }
+
+/*
+ * It is recommended to use a facility that allows user space to redefine
+ * custom character sets for LCD devices. Please use a sysfs interface
+ * as described above.
+ */
+#define MAP_TO_SEG7_SYSFS_FILE	"map_seg7"
+
+/*******************************************************************************
+ * ASCII conversion table
+ ******************************************************************************/
+
+#define _SEG7(l,a,b,c,d,e,f,g)	\
+      (	a<<BIT_SEG7_A |	b<<BIT_SEG7_B |	c<<BIT_SEG7_C |	d<<BIT_SEG7_D |	\
+	e<<BIT_SEG7_E |	f<<BIT_SEG7_F |	g<<BIT_SEG7_G )
+
+#define _MAP_0_32_ASCII_SEG7_NON_PRINTABLE	\
+	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+
+#define _MAP_33_47_ASCII_SEG7_SYMBOL		\
+ _SEG7('!',0,0,0,0,1,1,0), _SEG7('"',0,1,0,0,0,1,0), _SEG7('#',0,1,1,0,1,1,0),\
+ _SEG7('$',1,0,1,1,0,1,1), _SEG7('%',0,0,1,0,0,1,0), _SEG7('&',1,0,1,1,1,1,1),\
+ _SEG7('\'',0,0,0,0,0,1,0),_SEG7('(',1,0,0,1,1,1,0), _SEG7(')',1,1,1,1,0,0,0),\
+ _SEG7('*',0,1,1,0,1,1,1), _SEG7('+',0,1,1,0,0,0,1), _SEG7(',',0,0,0,0,1,0,0),\
+ _SEG7('-',0,0,0,0,0,0,1), _SEG7('.',0,0,0,0,1,0,0), _SEG7('/',0,1,0,0,1,0,1),
+
+#define _MAP_48_57_ASCII_SEG7_NUMERIC		\
+ _SEG7('0',1,1,1,1,1,1,0), _SEG7('1',0,1,1,0,0,0,0), _SEG7('2',1,1,0,1,1,0,1),\
+ _SEG7('3',1,1,1,1,0,0,1), _SEG7('4',0,1,1,0,0,1,1), _SEG7('5',1,0,1,1,0,1,1),\
+ _SEG7('6',1,0,1,1,1,1,1), _SEG7('7',1,1,1,0,0,0,0), _SEG7('8',1,1,1,1,1,1,1),\
+ _SEG7('9',1,1,1,1,0,1,1),
+
+#define _MAP_58_64_ASCII_SEG7_SYMBOL		\
+ _SEG7(':',0,0,0,1,0,0,1), _SEG7(';',0,0,0,1,0,0,1), _SEG7('<',1,0,0,0,0,1,1),\
+ _SEG7('=',0,0,0,1,0,0,1), _SEG7('>',1,1,0,0,0,0,1), _SEG7('?',1,1,1,0,0,1,0),\
+ _SEG7('@',1,1,0,1,1,1,1), 
+
+#define _MAP_65_90_ASCII_SEG7_ALPHA_UPPR	\
+ _SEG7('A',1,1,1,0,1,1,1), _SEG7('B',1,1,1,1,1,1,1), _SEG7('C',1,0,0,1,1,1,0),\
+ _SEG7('D',1,1,1,1,1,1,0), _SEG7('E',1,0,0,1,1,1,1), _SEG7('F',1,0,0,0,1,1,1),\
+ _SEG7('G',1,1,1,1,0,1,1), _SEG7('H',0,1,1,0,1,1,1), _SEG7('I',0,1,1,0,0,0,0),\
+ _SEG7('J',0,1,1,1,0,0,0), _SEG7('K',0,1,1,0,1,1,1), _SEG7('L',0,0,0,1,1,1,0),\
+ _SEG7('M',1,1,1,0,1,1,0), _SEG7('N',1,1,1,0,1,1,0), _SEG7('O',1,1,1,1,1,1,0),\
+ _SEG7('P',1,1,0,0,1,1,1), _SEG7('Q',1,1,1,1,1,1,0), _SEG7('R',1,1,1,0,1,1,1),\
+ _SEG7('S',1,0,1,1,0,1,1), _SEG7('T',0,0,0,1,1,1,1), _SEG7('U',0,1,1,1,1,1,0),\
+ _SEG7('V',0,1,1,1,1,1,0), _SEG7('W',0,1,1,1,1,1,1), _SEG7('X',0,1,1,0,1,1,1),\
+ _SEG7('Y',0,1,1,0,0,1,1), _SEG7('Z',1,1,0,1,1,0,1),
+
+#define _MAP_91_96_ASCII_SEG7_SYMBOL		\
+ _SEG7('[',1,0,0,1,1,1,0), _SEG7('\\',0,0,1,0,0,1,1),_SEG7(']',1,1,1,1,0,0,0),\
+ _SEG7('^',1,1,0,0,0,1,0), _SEG7('_',0,0,0,1,0,0,0), _SEG7('`',0,1,0,0,0,0,0),
+
+#define _MAP_97_122_ASCII_SEG7_ALPHA_LOWER	\
+ _SEG7('A',1,1,1,0,1,1,1), _SEG7('b',0,0,1,1,1,1,1), _SEG7('c',0,0,0,1,1,0,1),\
+ _SEG7('d',0,1,1,1,1,0,1), _SEG7('E',1,0,0,1,1,1,1), _SEG7('F',1,0,0,0,1,1,1),\
+ _SEG7('G',1,1,1,1,0,1,1), _SEG7('h',0,0,1,0,1,1,1), _SEG7('i',0,0,1,0,0,0,0),\
+ _SEG7('j',0,0,1,1,0,0,0), _SEG7('k',0,0,1,0,1,1,1), _SEG7('L',0,0,0,1,1,1,0),\
+ _SEG7('M',1,1,1,0,1,1,0), _SEG7('n',0,0,1,0,1,0,1), _SEG7('o',0,0,1,1,1,0,1),\
+ _SEG7('P',1,1,0,0,1,1,1), _SEG7('q',1,1,1,0,0,1,1), _SEG7('r',0,0,0,0,1,0,1),\
+ _SEG7('S',1,0,1,1,0,1,1), _SEG7('T',0,0,0,1,1,1,1), _SEG7('u',0,0,1,1,1,0,0),\
+ _SEG7('v',0,0,1,1,1,0,0), _SEG7('W',0,1,1,1,1,1,1), _SEG7('X',0,1,1,0,1,1,1),\
+ _SEG7('y',0,1,1,1,0,1,1), _SEG7('Z',1,1,0,1,1,0,1),
+
+#define _MAP_123_126_ASCII_SEG7_SYMBOL		\
+ _SEG7('{',1,0,0,1,1,1,0), _SEG7('|',0,0,0,0,1,1,0), _SEG7('}',1,1,1,1,0,0,0),\
+ _SEG7('~',1,0,0,0,0,0,0),
+
+/* Maps */
+
+/* This set tries to map as close as possible to the visible characteristics
+ * of the ASCII symbol, lowercase and uppercase letters may differ in
+ * presentation on the display.
+ */
+#define MAP_ASCII7SEG_ALPHANUM			\
+	_MAP_0_32_ASCII_SEG7_NON_PRINTABLE	\
+	_MAP_33_47_ASCII_SEG7_SYMBOL		\
+	_MAP_48_57_ASCII_SEG7_NUMERIC		\
+	_MAP_58_64_ASCII_SEG7_SYMBOL		\
+	_MAP_65_90_ASCII_SEG7_ALPHA_UPPR	\
+	_MAP_91_96_ASCII_SEG7_SYMBOL		\
+	_MAP_97_122_ASCII_SEG7_ALPHA_LOWER	\
+	_MAP_123_126_ASCII_SEG7_SYMBOL
+
+/* This set tries to map as close as possible to the symbolic characteristics
+ * of the ASCII character for maximum discrimination.
+ * For now this means all alpha chars are in lower case representations.
+ * (This for example facilitates the use of hex numbers with uppercase input.)
+ */
+#define MAP_ASCII7SEG_ALPHANUM_LC			\
+	_MAP_0_32_ASCII_SEG7_NON_PRINTABLE	\
+	_MAP_33_47_ASCII_SEG7_SYMBOL		\
+	_MAP_48_57_ASCII_SEG7_NUMERIC		\
+	_MAP_58_64_ASCII_SEG7_SYMBOL		\
+	_MAP_97_122_ASCII_SEG7_ALPHA_LOWER	\
+	_MAP_91_96_ASCII_SEG7_SYMBOL		\
+	_MAP_97_122_ASCII_SEG7_ALPHA_LOWER	\
+	_MAP_123_126_ASCII_SEG7_SYMBOL
+
+#define SEG7_DEFAULT_MAP(_name)		\
+	SEG7_CONVERSION_MAP(_name,MAP_ASCII7SEG_ALPHANUM)
+
+#endif	/* MAP_TO_7SEGMENT_H */
+
--- linux-2.6/drivers/usb/input/Makefile.orig	2005-06-16 21:08:11.000000000 +0200
+++ linux-2.6/drivers/usb/input/Makefile	2005-06-16 23:31:15.000000000 +0200
@@ -36,4 +36,5 @@
 obj-$(CONFIG_USB_EGALAX)	+= touchkitusb.o
 obj-$(CONFIG_USB_POWERMATE)	+= powermate.o
 obj-$(CONFIG_USB_WACOM)		+= wacom.o
+obj-$(CONFIG_USB_YEALINK)	+= yealink.o
 obj-$(CONFIG_USB_XPAD)		+= xpad.o
--- linux-2.6/drivers/usb/input/yealink.c.orig	2005-06-16 23:21:21.000000000 +0200
+++ linux-2.6/drivers/usb/input/yealink.c	2005-06-11 13:56:25.000000000 +0200
@@ -0,0 +1,861 @@
+/*
+ * drivers/usb/input/yealink.c
+ *
+ * Copyright (c) 2005 Henk Vergonet <Henk.Vergonet@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+/*
+ * Description:
+ *   Driver for the USB-P1K voip usb phone.
+ *   This device is produced by Yealink Network Technology Co Ltd
+ *   but may be branded under several names:
+ *	- Yealink usb-p1k
+ *	- Tiptel 115
+ *	- ...
+ *
+ * This driver is based on:
+ *   - the usbb2k-api	http://savannah.nongnu.org/projects/usbb2k-api/
+ *   - information from	http://memeteau.free.fr/usbb2k
+ *   - the xpad-driver	drivers/usb/input/xpad.c
+ *
+ * Thanks to:
+ *   - Olivier Vandorpe, for providing the usbb2k-api.
+ *   - Martin Diehl, for spotting my memory allocation bug.
+ *
+ * TODO:
+ *   - FIX ringtone:
+ *
+ * History:
+ *   20050527 henk	First version, functional keyboard. Keyboard events
+ *			will pop-up on the ../input/eventX bus.
+ *   20050531 henk	Added led, LCD, dialtone and sysfs interface.
+ *   20050610 henk	Cleanups, make it ready for public consumption.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/smp_lock.h>
+#include <linux/usb.h>
+
+// #include <linux/map/map_to_7segment.h>  /* proposed location */
+#include "map_to_7segment.h"
+
+#define DRIVER_VERSION "yld-20050610"
+#define DRIVER_AUTHOR "Henk Vergonet"
+#define DRIVER_DESC "Yealink phone driver"
+
+#define USB_PKT_LEN		16
+#define MAX_REPEAT_COUNT	16
+
+struct yld_status {
+	u8	lcd[24];	
+	u8	led;
+	u8	tone;
+} __attribute__ ((packed));
+
+struct lcd_segment_map {
+	char	type, value;
+ /* actually the "value" should be part of an yld structure as it's the
+  * only part that is not a constant.
+  */
+	union {
+		struct pictogram_map {
+			u8	a,m;
+			char	name[10];
+		}	p;
+		struct segment_map {
+			u8	a,m;
+		} s[7];
+	} u;
+};
+
+/* get the lcd_segment_map */
+#define _REGISTER_TABLES
+#include "yealink.h"
+
+/* Register a 7 segment character set */
+static SEG7_DEFAULT_MAP(map_seg7);
+
+struct yealink_dev {
+	struct input_dev idev;		/* input device */
+	struct usb_device *udev;	/* usb device */
+
+	/* irq input channel */
+	unsigned char		*irq_data;
+	dma_addr_t 		irq_dma;
+	struct urb		*urb_irq;
+
+	/* control output channel */
+	unsigned char		*ctl_data;
+	dma_addr_t		ctl_dma;
+	struct usb_ctrlrequest	*ctl_req;
+	dma_addr_t		ctl_req_dma;
+	struct urb		*urb_ctl;
+
+	int open_count;			/* reference count */
+	char phys[64];			/* physical device path */
+
+	int key_number;
+	int key_code;
+
+	int	idle_repeat;
+	int	stat_ix;
+	union {
+		struct yld_status s;
+		u8		  b[sizeof(struct yld_status)];
+	} master, copy;
+};
+
+
+/*******************************************************************************
+ * Yealink lcd interface
+ ******************************************************************************/
+
+ /* Display a char,
+  * char '\9' and '\n' are placeholders and do not overwrite the original text.
+  * A space will always hide an icon.
+  */
+static int setChar(struct yealink_dev *yld, int el, int chr)
+{
+	int i, a, m, val;
+
+	if (el >= sizeof(lcdMap)/sizeof(lcdMap[0]))
+		return -EINVAL;
+
+	if (chr == '\t' || chr == '\n')
+	    return 0;
+
+	lcdMap[el].value = chr;
+
+	if (lcdMap[el].type == '.') {
+		a = lcdMap[el].u.p.a;
+		m = lcdMap[el].u.p.m;
+		if (chr != ' ') {
+			yld->master.b[a] |= m;
+		} else {
+			yld->master.b[a] &= ~m;
+		}
+		return 0;
+	}
+	
+	val = map_to_seg7(&map_seg7, chr);
+	for(i=0; i<sizeof(lcdMap[0].u.s)/sizeof(lcdMap[0].u.s[0]); i++) {
+		m = lcdMap[el].u.s[i].m;
+
+		if (m == 0)
+			continue;
+		
+		a = lcdMap[el].u.s[i].a;
+		if (val & 1) {
+			yld->master.b[a] |= m;
+		} else {
+			yld->master.b[a] &= ~m;
+		}
+		val = val >> 1;
+	}
+	return 0;
+};
+
+/*******************************************************************************
+ * Yealink key interface 
+ ******************************************************************************/
+
+/* Map device buttons to internal key events.
+ *
+ * USB-P1K button layout:
+ *
+ *             up
+ *       IN           OUT
+ *            down
+ *
+ *     pickup   C    hangup
+ *       1      2      3
+ *       4      5      6
+ *       7      8      9
+ *       *      0      #
+ *
+ * The "up" and "down" keys, are symbolised by arrows on the button.
+ * The "pickup" and "hangup" keys are symbolised by a green and red phone
+ * on the button.
+ */
+static int map_p1k_to_key(int scancode)
+{
+	switch(scancode) {		/* phone key:	*/
+	case 0x23: return KEY_LEFT;	/*   IN		*/
+	case 0x33: return KEY_UP;	/*   up		*/
+	case 0x04: return KEY_RIGHT;	/*   OUT	*/
+	case 0x24: return KEY_DOWN;	/*   down	*/
+	case 0x03: return KEY_ENTER;	/*   pickup	*/
+	case 0x14: return KEY_BACKSPACE; /*  C		*/
+	case 0x13: return KEY_ESC;	/*   hangup	*/
+	case 0x00: return KEY_1;	/*   1		*/
+	case 0x01: return KEY_2;	/*   2 		*/
+	case 0x02: return KEY_3;	/*   3		*/
+	case 0x10: return KEY_4;	/*   4		*/
+	case 0x11: return KEY_5;	/*   5		*/
+	case 0x12: return KEY_6;	/*   6		*/
+	case 0x20: return KEY_7;	/*   7		*/
+	case 0x21: return KEY_8;	/*   8		*/
+	case 0x22: return KEY_9;	/*   9		*/
+	case 0x30: return KEY_KPASTERISK; /* *		*/
+	case 0x31: return KEY_0;	/*   0		*/
+	case 0x32: return KEY_LEFTSHIFT |
+			  KEY_3 << 8;	/*   #		*/
+	}
+	return -1;
+}
+
+/* Completes a request by converting the data into events for the
+ * input subsystem.
+ *
+ * The key parameter can be cascaded: key2 << 8 | key1
+ */
+static void report_key(struct yealink_dev *yld, int key, struct pt_regs *regs)
+{
+	struct input_dev *idev = &yld->idev;
+
+	input_regs(idev, regs);
+	if (yld->key_code >= 0) {
+		/* old key up */
+		input_report_key(idev, yld->key_code & 0xff, 0);
+		if (yld->key_code >> 8)
+			input_report_key(idev, yld->key_code >> 8, 0);
+	}
+	
+	yld->key_code = key;
+	if (key >= 0) {
+		/* new valid key */
+		input_report_key(idev, key & 0xff, 1);
+		if (key >> 8)
+			input_report_key(idev, key >> 8, 1);
+	};
+	input_sync(idev);
+}
+
+/*******************************************************************************
+ * Yealink usb communication interface
+ ******************************************************************************/
+
+/* keep stat_master & stat_copy in sync.
+ */
+static int yealink_do_idle_tasks(struct yealink_dev *yld)
+{
+	u8 *buf = yld->ctl_data; 
+	unsigned val;
+	int i, ix;
+
+	memcpy(buf, cmd_KEYPRESS, USB_PKT_LEN);
+	yld->idle_repeat--;
+	if(yld->idle_repeat < 0)
+		return 0;
+
+	/* find update candidates */
+
+	for (i=0; i<sizeof(yld->master); i++) {
+		ix = (yld->stat_ix + i) % sizeof(yld->master);
+		if (yld->master.b[ix] != yld->copy.b[ix])
+			goto update;
+	}
+	yld->idle_repeat = 0;
+	yld->stat_ix = (yld->stat_ix + 1) % sizeof(yld->master);
+	return 0;
+update:
+	yld->copy.b[ix] = val = yld->master.b[ix];
+	
+	if (ix == offsetof(struct yld_status, tone)) {
+		memcpy(buf, cmd_TONE, USB_PKT_LEN);
+		buf[4] = val;
+		buf[15] -= val;
+	} else if (ix == offsetof(struct yld_status, led)) {
+		memcpy(buf, cmd_LED_USB, USB_PKT_LEN);
+		if(val) {
+			buf[3] = 0x0;
+			buf[4] = 0xff;
+		}
+	} else {
+		memcpy(buf, cmd_LCD, USB_PKT_LEN);
+		buf[3] = ix;
+		buf[4] = val;
+		buf[15] -= (ix + val);
+	}
+	yld->stat_ix = (ix + 1) % sizeof(yld->master);
+	return 1;
+}
+
+/* Decide on how to handle responses
+ *
+ * The state transition diagram is somethhing like:
+ *
+ *          syncState<--+
+ *               |      |
+ *               |    idle
+ *              \|/     | 
+ * init --ok--> waitForKey --ok--> getKey
+ *  ^               ^                |
+ *  |               +-------ok-------+
+ * error,start
+ *
+ */
+static int yealink_state_machine(struct yealink_dev *yld, struct pt_regs *regs)
+{
+	u8 *buf = yld->ctl_data; 
+	int print = 1;
+	unsigned int keynum;
+
+	/* yealink state machine */
+	switch (*(u16 *)yld->irq_data) {
+	case OP16_KEYPRESS: /* return key pressed */
+
+		keynum = yld->irq_data[4];
+		if (keynum != yld->key_number) {
+			yld->key_number = keynum;
+
+			dbg("return keynum %x", keynum);
+
+			memcpy(buf, cmd_KEYCODE, USB_PKT_LEN);
+			
+			keynum--;
+			keynum &= 0x1f;
+			buf[3] = keynum;
+			buf[15] -= keynum;
+
+		} else {
+			/* no input, check if we need to send updates */
+			yld->idle_repeat = MAX_REPEAT_COUNT;
+			print = yealink_do_idle_tasks(yld);
+		}
+		break;
+
+	case OP16_KEYCODE: /* return from key code */
+
+		dbg("get keyCode %x", yld->irq_data[4]);
+
+		report_key(yld, map_p1k_to_key(yld->irq_data[4]), regs);
+
+		memcpy(buf, cmd_KEYPRESS, USB_PKT_LEN);
+		break;
+
+	case OP16_INIT: /* return from init */
+		
+		dbg("return from init");
+		
+		memcpy(buf, cmd_KEYPRESS, USB_PKT_LEN);
+		break;
+
+	default:
+		yealink_do_idle_tasks(yld);
+	}
+
+	if (print) {
+		dbg("in %08x%08x%08x%08x",
+			ntohl(*(u32 *)&yld->irq_data[0]),
+			ntohl(*(u32 *)&yld->irq_data[4]),
+			ntohl(*(u32 *)&yld->irq_data[8]),
+			ntohl(*(u32 *)&yld->irq_data[12]));
+	}
+
+	return usb_submit_urb (yld->urb_ctl, GFP_ATOMIC);
+}
+
+static void urb_irq_callback(struct urb *urb, struct pt_regs *regs)
+{
+	struct yealink_dev *yld = urb->context;
+	int ret;
+
+	switch (urb->status) {
+	case 0:
+		/* success */
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/* this urb is terminated, clean up */
+		dbg("%s - urb shutting down with status: %d",
+				__FUNCTION__, urb->status);
+		return;
+	default:
+		dbg("%s - nonzero urb status received: %d", __FUNCTION__, urb->status);
+		*(u16 *)yld->irq_data = 0;	/* restart keyboard */
+	}
+
+	/* figure out what todo next */
+	if ((ret = yealink_state_machine(yld, regs)) != 0)
+		err ("%s - yealink_state_machine result %d", __FUNCTION__, ret);
+}
+
+static void urb_ctl_callback(struct urb *urb, struct pt_regs *regs)
+{
+	struct yealink_dev *yld = urb->context;
+	int ret;
+
+	if (urb->status)
+		err ("config urb returned %d", urb->status);
+
+	ret = usb_submit_urb (yld->urb_irq, GFP_ATOMIC);
+	if (ret)
+		err ("%s - usb_submit_urb irq failed %d",
+		     __FUNCTION__, ret);
+}
+
+/*******************************************************************************
+ * input event interface 
+ ******************************************************************************/
+
+// TODO should we issue a ringtone on a SND_BELL event?
+static int input_ev (struct input_dev *dev, unsigned int type,
+		unsigned int code, int value)
+{
+	// struct yealink_dev *yld = dev->private;
+
+	if (type != EV_SND)
+		return -EINVAL;
+
+	switch (code) {
+	case SND_BELL:
+	case SND_TONE:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int input_open (struct input_dev *dev)
+{
+	struct yealink_dev *yld = dev->private;
+	int i, ret;
+
+	dbg("%s", __FUNCTION__);
+
+	if (yld->open_count++)
+		return 0;
+
+	/* force updates to device */
+	for (i=0; i<sizeof(yld->master); i++)
+		yld->copy.b[i] = ~yld->master.b[i];
+
+	yld->key_code = -1;;
+	yld->urb_irq->dev = yld->udev;
+	yld->urb_ctl->dev = yld->udev;
+
+	/* issue INIT */
+	memcpy(yld->ctl_data, cmd_INIT, USB_PKT_LEN);
+	if ((ret = usb_submit_urb(yld->urb_ctl, GFP_KERNEL)) != 0) {
+		dbg ("%s - usb_submit_urb failed with result %d",
+		     __FUNCTION__, ret);
+		yld->open_count--;
+		return ret;
+	}
+	return 0;
+}
+
+static void input_close (struct input_dev *dev)
+{
+	struct yealink_dev *yld = dev->private;
+	
+	dbg("%s", __FUNCTION__);
+	if (!--yld->open_count)
+		usb_kill_urb(yld->urb_irq);
+}
+
+/*******************************************************************************
+ * sysfs interface
+ ******************************************************************************/
+
+/* Interface to the 7-segments translation table aka. char set.
+ */
+static ssize_t show_map(struct device *dev, char *buf)
+{
+	memcpy(buf, &map_seg7, sizeof(map_seg7));
+	return sizeof(map_seg7);
+}
+static ssize_t store_map(struct device *dev, const char *buf, size_t cnt)
+{
+	memcpy(&map_seg7, buf, cnt > sizeof(map_seg7) ? sizeof(map_seg7) : cnt);
+	return cnt;
+}
+
+/* Interface to the LCD.
+ */
+
+/* Reading /sys/../lineX will return the format string with its settings:
+ *
+ * Example:
+ * cat ./line3
+ * 888888888888
+ * Linux Rocks!
+ */
+static ssize_t show_line(char *buf, int a, int b)
+{
+	int i = 0;
+	for (i=a; i<b; i++)
+		*buf++ = lcdMap[i].type;
+	*buf++ = '\n';
+	for (i=a; i<b; i++)
+		*buf++ = lcdMap[i].value;
+	*buf++ = '\n';
+	*buf = 0;
+	return 3 + ((b - a) << 1);
+}
+static ssize_t show_line1(struct device *dev, char *buf)
+{ return show_line(buf, LCD_LINE1_OFFSET, LCD_LINE2_OFFSET); }
+static ssize_t show_line2(struct device *dev, char *buf)
+{ return show_line(buf, LCD_LINE2_OFFSET, LCD_LINE3_OFFSET); }
+static ssize_t show_line3(struct device *dev, char *buf)
+{ return show_line(buf, LCD_LINE3_OFFSET, LCD_LINE4_OFFSET); }
+
+/* Writing to /sys/../lineX will set the coresponding LCD line.
+ * - Excess characters are ignored. 
+ * - If less characters are written than allowed, the remaining digits are
+ *   unchanged.
+ * - The '\n' or '\t' char is a placeholder, it does not overwrite the
+ *   original content.
+ */
+static ssize_t store_line(struct device *dev, const char *buf, size_t count,
+		int el, size_t len)
+{
+	struct yealink_dev *yld = dev_get_drvdata(dev);
+	int i;
+
+	if (yld == NULL)
+		return 0;
+
+	if (len > count)
+		len = count;
+	for (i=0; i<len; i++)
+		setChar(yld, el++, buf[i]);
+	return count;
+}
+static ssize_t store_line1(struct device *dev, const char *buf, size_t count)
+{ return store_line(dev, buf, count, LCD_LINE1_OFFSET, LCD_LINE1_SIZE); }
+static ssize_t store_line2(struct device *dev, const char *buf, size_t count)
+{ return store_line(dev, buf, count, LCD_LINE2_OFFSET, LCD_LINE2_SIZE); }
+static ssize_t store_line3(struct device *dev, const char *buf, size_t count)
+{ return store_line(dev, buf, count, LCD_LINE3_OFFSET, LCD_LINE3_SIZE); }
+
+/* Interface to visible and audible "icons", these include:
+ * pictures on the LCD, the LED, and the dialtone signal.
+ */
+
+/* Get a list of "switchable elements" with their current state. */
+static ssize_t get_icons(struct device *dev, char *buf)
+{
+	int i, ret = 1;
+	for (i=0; i<sizeof(lcdMap)/sizeof(lcdMap[0]); i++) {
+		if (lcdMap[i].type != '.')
+			continue;
+		ret += sprintf(&buf[ret], "%s %s\n",
+				lcdMap[i].value == ' ' ? "  " : "on",
+				lcdMap[i].u.p.name);
+	}
+	return ret;
+}
+
+/* Change the visibility of a particular element. */
+static ssize_t set_icon(struct device *dev, const char *buf, size_t count,
+		int chr)
+{
+	struct yealink_dev *yld = dev_get_drvdata(dev);
+	int i;
+
+	if (yld == NULL)
+		return count;
+	for (i=0; i<sizeof(lcdMap)/sizeof(lcdMap[0]); i++) {
+		if (lcdMap[i].type != '.')
+			continue;
+		if (strncmp(buf, lcdMap[i].u.p.name, count) == 0)
+		{
+			setChar(yld, i, chr);
+			break;
+		}
+	}
+	return count;
+}
+static ssize_t show_icon(struct device *dev, const char *buf, size_t count)
+{ return set_icon(dev, buf, count, buf[0]); }
+static ssize_t hide_icon(struct device *dev, const char *buf, size_t count)
+{ return set_icon(dev, buf, count, ' '); }
+
+/* TODO the ringtone interface.
+ *
+static ssize_t get_ringtone(struct device *dev, char *buf)
+{
+	returns a list of available ringtones, with an indication of the
+	currently selected one.
+}
+static ssize_t set_ringtone(struct device *dev, const char *buf, size_t count)
+{
+	sets the a ringtone.
+}
+static DEVICE_ATTR(ringtone, S_IRUGO|S_IWUSR|S_IWGRP, get_ringtone, set_ringtone);
+*/
+
+static DEVICE_ATTR(map_seg7, S_IRUGO|S_IWUSR|S_IWGRP, show_map, store_map);
+static DEVICE_ATTR(line1, S_IRUGO|S_IWUSR|S_IWGRP, show_line1, store_line1);
+static DEVICE_ATTR(line2, S_IRUGO|S_IWUSR|S_IWGRP, show_line2, store_line2);
+static DEVICE_ATTR(line3, S_IRUGO|S_IWUSR|S_IWGRP, show_line3, store_line3);
+static DEVICE_ATTR(get_icons, S_IRUGO, get_icons, NULL);
+static DEVICE_ATTR(show_icon, S_IWUSR|S_IWGRP, NULL, show_icon);
+static DEVICE_ATTR(hide_icon, S_IWUSR|S_IWGRP, NULL, hide_icon);
+
+static void remove_sysfs_files(struct device *dev)
+{
+	device_remove_file(dev, &dev_attr_line1);
+	device_remove_file(dev, &dev_attr_line2);
+	device_remove_file(dev, &dev_attr_line3);
+	device_remove_file(dev, &dev_attr_get_icons);
+	device_remove_file(dev, &dev_attr_show_icon);
+	device_remove_file(dev, &dev_attr_hide_icon);
+	device_remove_file(dev, &dev_attr_map_seg7);
+}
+
+static int create_sysfs_files(struct device *dev)
+{
+	struct yealink_dev *yld = dev_get_drvdata(dev);
+	int i, ret;
+
+	for (i=0; i<sizeof(lcdMap)/sizeof(lcdMap[0]); i++)
+		setChar(yld, i, lcdMap[i].value);
+	store_line3(dev, DRIVER_VERSION, sizeof(DRIVER_VERSION));
+	if (	(ret = device_create_file(dev, &dev_attr_line1))	||
+		(ret = device_create_file(dev, &dev_attr_line2))	||
+		(ret = device_create_file(dev, &dev_attr_line3))	||
+		(ret = device_create_file(dev, &dev_attr_get_icons))	||
+		(ret = device_create_file(dev, &dev_attr_show_icon))	||
+		(ret = device_create_file(dev, &dev_attr_hide_icon))	||
+		(ret = device_create_file(dev, &dev_attr_map_seg7)) )
+	{
+		err("killing own sysfs device files");
+		remove_sysfs_files(dev);
+	}
+	return ret;
+}
+
+/*******************************************************************************
+ * Linux interface and usb initialisation
+ ******************************************************************************/
+
+static const struct yld_device {
+	u16 idVendor;
+	u16 idProduct;
+	char *name;
+} yld_device[] = {
+	{ 0x6993, 0xb001, "Yealink usb-p1k" },
+};
+
+static struct usb_device_id usb_table [] = {
+	{ USB_INTERFACE_INFO(USB_CLASS_HID, 0, 0) },
+	{ }
+};
+
+static int usb_cleanup(struct yealink_dev *yld, int err)
+{
+	if (yld == NULL)
+		return err;
+
+        if (yld->urb_irq) {
+		usb_kill_urb(yld->urb_irq);
+		usb_free_urb(yld->urb_irq);
+	}
+        if (yld->urb_ctl)
+		usb_free_urb(yld->urb_ctl);
+        if (yld->idev.dev)
+		input_unregister_device(&yld->idev);
+	if (yld->ctl_req)
+		usb_buffer_free(yld->udev, sizeof(*(yld->ctl_req)),
+				yld->ctl_req, yld->ctl_req_dma);
+	if (yld->ctl_data)
+		usb_buffer_free(yld->udev, USB_PKT_LEN,
+				yld->ctl_data, yld->ctl_dma);
+	if (yld->irq_data)
+		usb_buffer_free(yld->udev, USB_PKT_LEN,
+				yld->irq_data, yld->irq_dma);
+	kfree(yld);
+	return err;
+}
+
+static void usb_disconnect(struct usb_interface *intf) {
+	struct yealink_dev *yld = usb_get_intfdata (intf);
+
+	usb_set_intfdata(intf, NULL);
+	remove_sysfs_files(&intf->dev);
+	usb_cleanup(yld, 0);
+}
+
+static int usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
+{
+	struct usb_device *udev = interface_to_usbdev (intf);
+	struct usb_host_interface *interface;
+	struct usb_endpoint_descriptor *endpoint;
+	struct yealink_dev *yld;
+	char path[64];
+	int ret, pipe, i;
+	
+	/* test for vendor */
+	for (i=0; i<sizeof(yld_device)/sizeof(yld_device[0]); i++) {
+		if ((udev->descriptor.idVendor == yld_device[i].idVendor) &&
+		    (udev->descriptor.idProduct == yld_device[i].idProduct))
+			goto device_found;
+	}
+	return -ENODEV;
+
+device_found:
+	
+	interface = intf->cur_altsetting;
+	endpoint = &interface->endpoint[0].desc;
+	if (!(endpoint->bEndpointAddress & 0x80))
+		return -EIO;
+	if ((endpoint->bmAttributes & 3) != 3)
+		return -EIO;
+
+	if ((yld = kmalloc(sizeof(struct yealink_dev), GFP_KERNEL)) == NULL)
+		return -ENOMEM;
+
+	memset(yld, 0, sizeof(struct yealink_dev));
+	yld->udev = udev;
+
+	/* allocate usb buffers */
+	yld->irq_data = usb_buffer_alloc(udev, USB_PKT_LEN,
+					SLAB_ATOMIC, &yld->irq_dma);
+	if (yld->irq_data == NULL)
+		return usb_cleanup(yld, -ENOMEM);
+
+	yld->ctl_data = usb_buffer_alloc(udev, USB_PKT_LEN,
+					SLAB_ATOMIC, &yld->ctl_dma);
+	if (!yld->ctl_data)
+		return usb_cleanup(yld, -ENOMEM);
+
+	yld->ctl_req = usb_buffer_alloc(udev, sizeof(*(yld->ctl_req)),
+					SLAB_ATOMIC, &yld->ctl_req_dma);
+	if (yld->ctl_req == NULL)
+		return usb_cleanup(yld, -ENOMEM);
+
+	/* allocate urb structures */
+	yld->urb_irq = usb_alloc_urb(0, GFP_KERNEL);
+        if (yld->urb_irq == NULL)
+		return usb_cleanup(yld, -ENOMEM);
+
+	yld->urb_ctl = usb_alloc_urb(0, GFP_KERNEL);
+        if (yld->urb_ctl == NULL)
+		return usb_cleanup(yld, -ENOMEM);
+
+	/* get a handle to the interrupt data pipe */
+	pipe = usb_rcvintpipe(udev, endpoint->bEndpointAddress);
+	ret = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
+	if (ret != USB_PKT_LEN) {
+		err("invalid payload size %d, expected %d", ret, USB_PKT_LEN);
+	}
+	
+	/* initialise irq urb */
+	usb_fill_int_urb(yld->urb_irq, udev, pipe, yld->irq_data,
+			USB_PKT_LEN,
+			urb_irq_callback,
+			yld, endpoint->bInterval);
+	yld->urb_irq->transfer_dma = yld->irq_dma;
+	yld->urb_irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+
+	/* initialise ctl urb */
+	yld->ctl_req->bRequestType = USB_TYPE_CLASS | USB_RECIP_INTERFACE |
+				      USB_DIR_OUT;
+	yld->ctl_req->bRequest	= USB_REQ_SET_CONFIGURATION;
+	yld->ctl_req->wValue	= cpu_to_le16(0x200);
+	yld->ctl_req->wIndex	= cpu_to_le16(interface->desc.bInterfaceNumber);
+	yld->ctl_req->wLength	= cpu_to_le16(USB_PKT_LEN);
+
+	usb_fill_control_urb(yld->urb_ctl, udev, usb_sndctrlpipe(udev, 0),
+			(void *)yld->ctl_req, yld->ctl_data, USB_PKT_LEN,
+			urb_ctl_callback, yld);
+	yld->urb_ctl->setup_dma	= yld->ctl_req_dma;
+	yld->urb_ctl->transfer_dma	= yld->ctl_dma;
+	yld->urb_ctl->transfer_flags	|= URB_NO_SETUP_DMA_MAP |
+					URB_NO_TRANSFER_DMA_MAP;
+
+	/* find out the physical bus location */
+	if (usb_make_path(udev, path, sizeof(path)) > 0) {
+		snprintf(yld->phys, sizeof(yld->phys)-1,  "%s/input0", path);
+	}
+
+	/* register settings for the input device */
+	init_input_dev(&yld->idev);
+	yld->idev.private	= yld;
+	yld->idev.id.bustype	= BUS_USB;
+	yld->idev.id.vendor	= udev->descriptor.idVendor;
+	yld->idev.id.product	= udev->descriptor.idProduct;
+	yld->idev.id.version	= udev->descriptor.bcdDevice;
+	yld->idev.dev		= &intf->dev;
+	yld->idev.name		= yld_device[i].name;
+	yld->idev.phys		= yld->phys;
+	yld->idev.event		= input_ev;
+	yld->idev.open		= input_open;
+	yld->idev.close		= input_close;
+
+	/* register available key events */
+	yld->idev.evbit[0] = BIT(EV_KEY);
+	for (i=0; i<256; i++) {
+		int k = map_p1k_to_key(i);
+		if (k >= 0) {
+			set_bit(k & 0xff, yld->idev.keybit);
+			if (k >> 8)
+				set_bit(k >> 8, yld->idev.keybit);
+		}
+	}
+
+	printk(KERN_INFO "input: %s on %s\n", yld->idev.name, path);
+
+	input_register_device(&yld->idev);
+
+	usb_set_intfdata(intf, yld);
+
+	create_sysfs_files(&intf->dev);
+	return 0;
+}
+
+static struct usb_driver yealink_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "yealink",
+	.probe		= usb_probe,
+	.disconnect	= usb_disconnect,
+	.id_table	= usb_table,
+};
+
+static int __init yealink_dev_init(void)
+{
+	int ret = usb_register(&yealink_driver);
+	if (ret == 0)
+		info(DRIVER_DESC ":" DRIVER_VERSION);
+	return ret;
+}
+
+static void __exit yealink_dev_exit(void)
+{
+	usb_deregister(&yealink_driver);
+}
+
+module_init(yealink_dev_init);
+module_exit(yealink_dev_exit);
+
+MODULE_DEVICE_TABLE (usb, usb_table);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
--- linux-2.6/drivers/usb/input/yealink.h.orig	2005-06-16 23:21:24.000000000 +0200
+++ linux-2.6/drivers/usb/input/yealink.h	2005-06-11 13:00:13.000000000 +0200
@@ -0,0 +1,225 @@
+/*
+ * drivers/usb/input/yealink.h
+ *
+ * Copyright (c) 2005 Henk Vergonet <Henk.Vergonet@gmail.com>
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifdef _TABLE
+
+/* Using interface 3 the device is operated via a series of request response
+ * messages. The request is issued via a control channel, followed by a
+ * response on the interrupt channel.
+ *
+ * Each request response consists of 16 bytes with in the last byte a negative
+ * sum of the preceding bytes.
+ */
+
+/* Init registers
+ */
+_TABLE(INIT,		0x8e,0x0a,0x00,0x00,0x00,0,0,0,0,0,0,0,0,0,0) 
+
+/* Scan for key presses
+ *	on return byte[4] returns the key number
+ */
+_TABLE(KEYPRESS,	0x80,0x01,0x00,0x00,0x00,0,0,0,0,0,0,0,0,0,0)
+
+/* Request keycode
+ *	on return byte 4 defines the key
+ */
+_TABLE(KEYCODE,		0x81,0x01,0x00,0x00,0x00,0,0,0,0,0,0,0,0,0,0)
+
+/* Set LCD
+ *	byte[3] is a segment cluster (0-26)
+ *	byte[4] defines individual segments
+ */
+_TABLE(LCD,		0x04,0x01,0x00,0x00,0x00,0,0,0,0,0,0,0,0,0,0)
+
+/* Set dial tone
+ *	byte[4] = 0 OFF / 1 ON
+ */
+_TABLE(TONE,		0x09,0x01,0x00,0x00,0x00,0,0,0,0,0,0,0,0,0,0)
+ 
+/* Set led 
+ *	byte[3..4] = 0xff 0x00 OFF / 0x00 0xff ON
+ */
+_TABLE(LED_USB,		0x05,0x02,0x00,0xFF,0x00,0,0,0,0,0,0,0,0,0,0)
+	
+#ifdef DEBUG
+/* USB / PSTN SWITCH CMD */
+_TABLE(USB_ON,		0x0E,0x01,0x00,0x00,0x00,0,0,0,0,0,0,0,0,0,0)
+_TABLE(USB_OFF,		0x0E,0x01,0x00,0x00,0x01,0,0,0,0,0,0,0,0,0,0)
+_TABLE(LED_USB_ON,	0x05,0x02,0x00,0x00,0xFF,0,0,0,0,0,0,0,0,0,0)
+_TABLE(LED_USB_OFF,	0x05,0x02,0x00,0xFF,0x00,0,0,0,0,0,0,0,0,0,0)
+/* TONE / RING CMD */
+_TABLE(TONE_ON,		0x09,0x01,0x00,0x00,0x01,0,0,0,0,0,0,0,0,0,0)
+_TABLE(TONE_OFF,	0x09,0x01,0x00,0x00,0x00,0,0,0,0,0,0,0,0,0,0)
+_TABLE(RING_ON,		0x01,0x01,0x00,0x00,0x01,0,0,0,0,0,0,0,0,0,0)
+_TABLE(RING_OFF,	0x01,0x01,0x00,0x00,0x00,0,0,0,0,0,0,0,0,0,0)
+/* Handset detection */
+_TABLE(HANDSET,		0x8d,0x01,0x00,0x00,0x00,0,0,0,0,0,0,0,0,0,0)
+/* test commands */
+_TABLE(DECROCHE3,	0x05,0x02,0x00,0x00,0xff,0,0,0,0,0,0,0,0,0,0)
+_TABLE(DECROCHE4,	0x0e,0x01,0x00,0x00,0x00,0,0,0,0,0,0,0,0,0,0)
+_TABLE(TEST,		0x07,0x01,0x00,0x00,0x00,0,0,0,0,0,0,0,0,0,0)
+/*	byte[4] = 0 OFF / 1 ON */
+_TABLE(SPKR,		0x03,0x01,0x00,0x00,0x00,0,0,0,0,0,0,0,0,0,0)
+#endif /* DEBUG */
+
+#undef _TABLE
+#endif /* _TABLE */
+
+
+#if defined(_SEG) && defined(_PIC)
+
+/* LCD, each segment must be driven seperately.
+ *
+ * Layout:
+ *
+ *   |[]   [][]   [][]   [][]   in   |[][]
+ *   |[] M [][] D [][] : [][]   out  |[][]
+ *                             store
+ *
+ *    NEW REP         SU MO TU WE TH FR SA
+ *
+ *    [] [] [] [] [] [] [] [] [] [] [] []
+ *    [] [] [] [] [] [] [] [] [] [] [] []
+ */ 
+
+/* Line 1
+ *	Format		: 18.e8.M8.88...188
+ *	Icon names	: M D : IN OUT STORE
+ */
+#define LCD_LINE1_OFFSET	0
+#define LCD_LINE1_SIZE		17
+
+/*
+ * This table maps segments to individual bit positions, with (offset,
+ * bitmask) pairs.
+ */
+
+/* Note: first g then f =>				    !      !      */ 
+/*	    type  val    a      b      c      d      e      g      f      */
+	_SEG('1', ' ',  0,0 , 22,2 , 22,2 ,  0,0 ,  0,0 ,  0,0 ,  0,0	),
+	_SEG('8', ' ', 20,1 , 20,2 , 20,4 , 20,8 , 21,4 , 21,2 , 21,1	),
+	_PIC('.', ' ', 22,1 , "M"					),
+	_SEG('e', ' ', 18,1 , 18,2 , 18,4 , 18,1 , 19,2 , 18,1 , 19,1	),
+	_SEG('8', ' ', 16,1 , 16,2 , 16,4 , 16,8 , 17,4 , 17,2 , 17,1	),
+	_PIC('.', ' ', 15,8 , "D"					),
+	_SEG('M', ' ', 14,1 , 14,2 , 14,4 , 14,1 , 15,4 , 15,2 , 15,1	),
+	_SEG('8', ' ', 12,1 , 12,2 , 12,4 , 12,8 , 13,4 , 13,2 , 13,1	),
+	_PIC('.', ' ', 11,8 , ":"					),
+	_SEG('8', ' ', 10,1 , 10,2 , 10,4 , 10,8 , 11,4 , 11,2 , 11,1	),
+	_SEG('8', ' ',  8,1 ,  8,2 ,  8,4 ,  8,8 ,  9,4 ,  9,2 ,  9,1	),
+	_PIC('.', ' ',  7,1 , "IN"					),
+	_PIC('.', ' ',  7,2 , "OUT"					),
+	_PIC('.', ' ',  7,4 , "STORE"					),
+	_SEG('1', ' ',  0,0 ,  5,1 ,  5,1 ,  0,0 ,  0,0 ,  0,0 ,  0,0	),
+	_SEG('8', ' ',  4,1 ,  4,2 ,  4,4 ,  4,8 ,  5,8 ,  5,4 ,  5,2	),
+	_SEG('8', ' ',  2,1 ,  2,2 ,  2,4 ,  2,8 ,  3,4 ,  3,2 ,  3,1	),
+
+/* Line 2
+ *	Format		: .........
+ *	Pict. name	: NEW REP SU MO TU WE TH FR SA
+ */
+#define LCD_LINE2_OFFSET	LCD_LINE1_OFFSET + LCD_LINE1_SIZE
+#define LCD_LINE2_SIZE		9
+
+	_PIC('.', ' ', 23,2 , "NEW"	),
+	_PIC('.', ' ', 23,4 , "REP"	),
+	_PIC('.', ' ',  1,8 , "SU"	),
+	_PIC('.', ' ',  1,4 , "MO"	),
+	_PIC('.', ' ',  1,2 , "TU"	),
+	_PIC('.', ' ',  1,1 , "WE"	),
+	_PIC('.', ' ',  0,1 , "TH"	),
+	_PIC('.', ' ',  0,2 , "FR"	),
+	_PIC('.', ' ',  0,4 , "SA"	),
+
+/* Line 3
+ *	Format		: 888888888888
+ */
+#define LCD_LINE3_OFFSET	LCD_LINE2_OFFSET + LCD_LINE2_SIZE
+#define LCD_LINE3_SIZE		12
+
+	_SEG('8', ' ', 22,16, 22,32, 22,64, 22,128, 23,128, 23,64, 23,32  ),
+	_SEG('8', ' ', 20,16, 20,32, 20,64, 20,128, 21,128, 21,64, 21,32  ),
+	_SEG('8', ' ', 18,16, 18,32, 18,64, 18,128, 19,128, 19,64, 19,32  ),
+	_SEG('8', ' ', 16,16, 16,32, 16,64, 16,128, 17,128, 17,64, 17,32  ),
+	_SEG('8', ' ', 14,16, 14,32, 14,64, 14,128, 15,128, 15,64, 15,32  ),
+	_SEG('8', ' ', 12,16, 12,32, 12,64, 12,128, 13,128, 13,64, 13,32  ),
+	_SEG('8', ' ', 10,16, 10,32, 10,64, 10,128, 11,128, 11,64, 11,32  ),
+	_SEG('8', ' ',  8,16,  8,32,  8,64,  8,128,  9,128,  9,64,  9,32  ),
+	_SEG('8', ' ',  6,16,  6,32,  6,64,  6,128,  7,128,  7,64,  7,32  ),
+	_SEG('8', ' ',  4,16,  4,32,  4,64,  4,128,  5,128,  5,64,  5,32  ),
+	_SEG('8', ' ',  2,16,  2,32,  2,64,  2,128,  3,128,  3,64,  3,32  ),
+	_SEG('8', ' ',  0,16,  0,32,  0,64,  0,128,  1,128,  1,64,  1,32  ),
+
+/* Line 4
+ *
+ * The USB LED is implemented as an icon.
+ */
+#define LCD_LINE4_OFFSET	LCD_LINE3_OFFSET + LCD_LINE3_SIZE
+	
+	_PIC('.', ' ',  offsetof(struct yld_status, led) , 0x1, "LED_USB" ),
+	_PIC('.', ' ',  offsetof(struct yld_status, tone) , 0x1, "DIALTONE" ),
+
+#undef _SEG
+#undef _PIC
+#endif /* _SEG && _PIC */
+
+
+
+#ifdef _REGISTER_TABLES
+#undef _REGISTER_TABLES
+
+/*
+ * Command table and defines.
+ */
+
+/* Register command strings */
+#define _TABLE(lbl,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o)		\
+	static const u8 cmd_##lbl [USB_PKT_LEN] = {		\
+		a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,			\
+		(-a-b-c-d-e-f-g-h-i-j-k-l-m-n-o) & 0xff 	\
+	};
+#include "yealink.h"
+
+/* Register host notations of CMD opcodes */
+#define _TABLE(lbl,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o)		\
+	OP16_##lbl	= __constant_ntohs((a) << 8 | (b)),
+enum u16 {
+#include "yealink.h"
+};
+
+/*
+ * LCD segment and icon map
+ */
+#define _LOC(k,l)	{ .a = (k), .m = (l) }
+#define _SEG(t, v, a, am, b, bm, c, cm, d, dm, e, em, f, fm, g, gm)	\
+	{ .type	= (t), .value = (v),					\
+	  .u.s = {	_LOC(a, am), _LOC(b, bm), _LOC(c, cm),		\
+		        _LOC(d, dm), _LOC(e, em), _LOC(g, gm), _LOC(f, fm) } }
+#define _PIC(t, v, h, hm, n)						\
+	{ .type	= (t), .value = (v),					\
+ 	  .u.p = { .name = (n), .a = (h), .m = (hm) } }
+
+static struct lcd_segment_map lcdMap[] = {
+#include "yealink.h"
+};
+
+#endif /* _REGISTER_TABLES */
+
--- linux-2.6/drivers/usb/input/Kconfig.orig	2005-06-16 21:08:11.000000000 +0200
+++ linux-2.6/drivers/usb/input/Kconfig	2005-06-16 23:30:19.000000000 +0200
@@ -206,6 +206,20 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called touchkitusb.
 
+config USB_YEALINK
+	tristate "Yealink usb-p1k voip phone"
+	depends on USB && INPUT && EXPERIMENTAL
+	---help---
+	  Say Y here if you want to enable keyboard and LDC functions of the
+	  Yealink usb-p1k usb phones. The audio part is enabled by the generic
+	  usb sound driver, so you might want to enable that as well.
+
+	  For information about how to use these additional functions, see
+	  <file:Documentation/input/yealink.txt>.
+	  
+	  To compile this driver as a module, choose M here: the module will be
+	  called yealink.
+
 config USB_XPAD
 	tristate "X-Box gamepad support"
 	depends on USB && INPUT
--- linux-2.6/Documentation/input/yealink.txt.orig	2005-06-16 23:19:00.000000000 +0200
+++ linux-2.6/Documentation/input/yealink.txt	2005-06-16 23:17:16.000000000 +0200
@@ -0,0 +1,152 @@
+yealink - Linux driver for usb-p1k phones
+
+0. Status
+~~~~~~~~~
+
+The p1k is a relatively cheap usb 1.1 phone with:
+  - LCD			full support
+  - LED			full support
+  - keyboard		full support
+  - dialtone		full support
+  - ringtone/speaker	TODO please fixme
+  - audio playback   	full support via generic usb audio diver
+  - audio record     	full support via generic usb audio diver
+
+
+0.1. LCD
+~~~~~~~~
+
+The LCD is divided is organised as a 3 line display:
+ 
+    |[]   [][]   [][]   [][]   in   |[][]
+    |[] M [][] D [][] : [][]   out  |[][]
+                              store
+ 
+    NEW REP         SU MO TU WE TH FR SA
+
+    [] [] [] [] [] [] [] [] [] [] [] []
+    [] [] [] [] [] [] [] [] [] [] [] []
+
+
+Line 1	Format (see below)	: 18.e8.M8.88...188
+	Icon names		:   M  D  :  IN OUT STORE
+Line 2  Format			: .........
+	Icon name		: NEW REP SU MO TU WE TH FR SA
+Line 3  Format			: 888888888888
+
+
+Format description:
+  From a user space perspective the world is seperated in "digits" and "icons".
+  A digit can have a character set, an icon can only be ON or OFF.
+
+  Format specifier
+    '8' :  Generic 7 segment digit with individual addressable segments
+
+    Reduced capabillity 7 segm digit, when segments are hard wired together.
+    '1' : 2 segments digit only able to produce a 1.
+    'e' : Most significant day of the month digit,
+          able to produce at least 1 2 3.
+    'M' : Most significant minute digit,
+          able to produce at least 0 1 2 3 4 5.
+
+    Icons or pictograms:
+    '.' : For example like AM, PM, SU, a 'dot' .. or other single segment
+	  elements.
+
+
+1. Driver usage
+~~~~~~~~~~~~~~~
+
+For userland the following interfaces are available:
+  /sys/.../
+           line1	Read Write, lcd line1
+           line2	Read Write, lcd line2
+           line3	Read Write, lcd line3
+
+	   get_icons    Read, returns a set of available icons.
+	   hide_icon    Write, hide the element by writing the icon name.
+	   show_icon    Write, display the element by writing the icon name.
+	   
+	   map_seg7	R/W, the 7 segments char set, see map_to_7segment.h
+
+1.1 lineX
+~~~~~~~~~
+Reading /sys/../lineX will return the format string with its current value:
+
+  Example:
+  cat ./line3
+  888888888888
+  Linux Rocks!
+
+Writing to /sys/../lineX will set the coresponding LCD line.
+ - Excess characters are ignored. 
+ - If less characters are written than allowed, the remaining digits are
+   unchanged.
+ - The tab '\t'and '\n' char does not overwrite the original content.
+ - Writing a space to an icon will always hide its content.
+
+  Example:
+  date +"%m.%e.%k:%M"  | sed 's/^0/ /' > ./line1
+
+
+1.2 get_icons 
+~~~~~~~~~~~~~
+Reading will return all available icon names and its current settings:
+
+  cat ./get_icons
+  on M
+  on D
+  on :
+     IN
+     OUT
+     STORE
+     NEW
+     REP
+     SU
+     MO
+     TU
+     WE
+     TH
+     FR
+     SA
+     LED_USB
+
+1.3 show/hide icons 
+~~~~~~~~~~~~~~~~~~~
+Writing to these files will update the state of the icon.
+Only one icon at a time may be updated.
+
+If an icon is also on a ./lineX the corresponding value is
+updated with the first letter of the icon.
+
+  Example:
+  echo -n "STORE" > ./show_icon
+ 
+
+1.3 keyboard
+~~~~~~~~~~~~
+The current mapping in the kernel is provided by the map_p1k_to_key
+function:
+
+   Physical USB-P1K button layout	input events
+ 
+ 
+              up			     up
+        IN           OUT		left,	right
+             down			    down
+ 
+      pickup   C    hangup		enter, backspace, escape
+        1      2      3			1, 2, 3
+        4      5      6			4, 5, 6,
+        7      8      9			7, 8, 9,
+        *      0      #			*, 0, #,
+ 
+  The "up" and "down" keys, are symbolised by arrows on the button.
+  The "pickup" and "hangup" keys are symbolised by a green and red phone
+  on the button.
+
+2. Thanks
+~~~~~~~~~
+  - Olivier Vandorpe, for providing the usbb2k-api.
+  - Martin Diehl, for spotting my memory allocation bug.
+

--SLDf9lqlvOQaIe6s--
