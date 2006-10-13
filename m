Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWJMAcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWJMAcY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 20:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWJMAcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 20:32:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:40723 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751382AbWJMAcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 20:32:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=sWeOBI0k2WabdGWBi7jUOj7HPR5JHDzBQ9vghsCdupJtzDfR4lvygNLh0iv7t6svNz67BtXofv+ul/U/6tZb75z4yFun7m52ryfgJhyd/OZuA2PYTTWKtYB5+Fu6LWm8sei+4AKcg1QgsOWXMsJ/UpuMKvinQB8gDzy57v7nfTs=
Date: Fri, 13 Oct 2006 02:32:18 +0000
From: Miguel Ojeda Sandonis <maxextreme@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Message-Id: <20061013023218.31362830.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, here it is the complete patch again as you requested.

Paulo, I got the algorithm much faster, thanks you very much.
(<2% CPU at 20 Hz on P4 3Ghz :).
---
miguelojeda-2.6.19-rc1-add-LCD-support.patch

Adds support for auxiliary displays, the ks0108 LCD controller,
the cfag12864b LCD and adds a framebuffer device: cfag12864bfb.

Brief
-----

 - Adds a "auxdisplay/" folder in "drivers/" for auxiliary display drivers.
 - Adds support for the ks0108 LCD Controller as a device driver.
   (uses parport interface)
 - Adds support for the cfag12864b LCD as a device driver.
   (uses ks0108 LCD Controller driver)
 - Adds a framebuffer device called cfag12864bfb.
   (uses cfag12864b LCD driver)
 - Adds the usual Documentation, includes, Makefiles, Kconfigs, MAINTAINERS, CREDITS...
 - Miguel Ojeda will maintain all the stuff above.

Patched files Index
-------------------

 CREDITS                             |   10
 Documentation/auxdisplay/cfag12864b |   98 +++++++
 Documentation/auxdisplay/ks0108     |   59 ++++
 MAINTAINERS                         |   24 +
 drivers/Kconfig                     |    2
 drivers/Makefile                    |    1
 drivers/auxdisplay/Kconfig          |  112 ++++++++
 drivers/auxdisplay/Makefile         |    6
 drivers/auxdisplay/cfag12864b.c     |  328 ++++++++++++++++++++++++++
 drivers/auxdisplay/cfag12864bfb.c   |  165 +++++++++++++
 drivers/auxdisplay/ks0108.c         |  167 +++++++++++++
 include/linux/cfag12864b.h          |   41 +++
 include/linux/ks0108.h              |   36 ++
 13 files changed, 1049 insertions(+)

miguelojeda-2.6.19-rc1-add-LCD-support.patch
Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff -uprN -X dontdiff linux-2.6.19-rc1-vanilla/CREDITS linux/CREDITS
--- linux-2.6.19-rc1-vanilla/CREDITS	2006-10-13 02:10:16.000000000 +0000
+++ linux/CREDITS	2006-10-12 12:26:23.000000000 +0000
@@ -2562,6 +2562,16 @@ S: Subiaco, 6008
 S: Perth, Western Australia
 S: Australia
 
+N: Miguel Ojeda Sandonis
+E: maxextreme@gmail.com
+D: Author: Auxiliary LCD Controller driver (ks0108)
+D: Author: Auxiliary LCD driver (cfag12864b)
+D: Author: Auxiliary LCD framebuffer driver (cfag12864bfb)
+D: Maintainer: Auxiliary display drivers tree (drivers/auxdisplay/*)
+S: C/ Mieses 20, 9-B
+S: Valladolid 47009
+S: Spain
+
 N: Greg Page
 E: gpage@sovereign.org
 D: IPX development and support
diff -uprN -X dontdiff linux-2.6.19-rc1-vanilla/Documentation/auxdisplay/cfag12864b linux/Documentation/auxdisplay/cfag12864b
--- linux-2.6.19-rc1-vanilla/Documentation/auxdisplay/cfag12864b	1970-01-01 00:00:00.000000000 +0000
+++ linux/Documentation/auxdisplay/cfag12864b	2006-10-13 01:41:22.000000000 +0000
@@ -0,0 +1,98 @@
+	===================================
+	cfag12864b LCD Driver Documentation
+	===================================
+
+License:		GPLv2
+Author & Maintainer:	Miguel Ojeda Sandonis <maxextreme@gmail.com>
+Date:			2006-10-11
+
+
+
+--------
+0. INDEX
+--------
+
+	1. DRIVER INFORMATION
+	2. DEVICE INFORMATION
+	3. WIRING
+	4. USER-SPACE PROGRAMMING
+
+
+---------------------
+1. DRIVER INFORMATION
+---------------------
+
+This driver support one cfag12864b display at time.
+
+
+---------------------
+2. DEVICE INFORMATION
+---------------------
+
+Manufacturer:	Crystalfontz
+Device Name:	Crystalfontz 12864b LCD Series
+Device Code:	cfag12864b
+Webpage:	http://www.crystalfontz.com
+Device Webpage:	http://www.crystalfontz.com/products/12864b/
+Type:		LCD (Liquid Crystal Display)
+Width:		128
+Height:		64
+Colors:		2 (B/N)
+Controller:	ks0108
+Controllers:	2
+Pages:		8 each controller
+Addresses:	64 each page
+
+
+
+---------
+3. WIRING
+---------
+
+The cfag12864b LCD Series don't have official wiring.
+
+The common wiring is done to the parallel port:
+
+http://www.skippari.net/lcd/sekalaista/crystalfontz_cfag12864B-TMI-V.png
+
+You can get help at Crystalfontz and LCDInfo forums.
+
+
+
+------------------------
+4. USERSPACE PROGRAMMING
+------------------------
+
+The cfag12864bfb describes a framebuffer driver (/dev/fbX).
+
+It has a size of 128 * 64 / 8 = 1024 bytes = 1 kB.
+Each bit represents one pixel. If the bit is high, the pixel will
+turn on. If the pixel is low, the pixel will turn off.
+
+You can mmap the framebuffer as usual.
+
+You can use a copy of this header in your userspace programs.
+
+---8<---
+/*
+ *    Filename: cfag12864b.h
+ * Description: cfag12864b LCD Display Driver Header for user-space apps
+ *
+ *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-10-11
+ */
+
+#ifndef _CFAG12864B_H_
+#define _CFAG12864B_H_
+
+#define CFAG12864B_WIDTH	(128)
+#define CFAG12864B_HEIGHT	(64)
+#define CFAG12864B_SIZE		((CFAG12864B_CONTROLLERS) * \
+				(CFAG12864B_PAGES) * \
+				(CFAG12864B_ADDRESSES))
+
+#endif // _CFAG12864B_H_
+---8<---
+
+
+EOF
diff -uprN -X dontdiff linux-2.6.19-rc1-vanilla/Documentation/auxdisplay/ks0108 linux/Documentation/auxdisplay/ks0108
--- linux-2.6.19-rc1-vanilla/Documentation/auxdisplay/ks0108	1970-01-01 00:00:00.000000000 +0000
+++ linux/Documentation/auxdisplay/ks0108	2006-10-05 13:46:44.000000000 +0000
@@ -0,0 +1,59 @@
+	==========================================
+	ks0108 LCD Controller Driver Documentation
+	==========================================
+
+License:		GPLv2
+Author & Maintainer:	Miguel Ojeda Sandonis <maxextreme@gmail.com>
+Date:			2006-10-04
+
+
+
+--------
+0. INDEX
+--------
+
+	1. DRIVER INFORMATION
+	2. DEVICE INFORMATION
+	3. WIRING
+
+
+---------------------
+1. DRIVER INFORMATION
+---------------------
+
+This driver support the ks0108 LCD controller.
+
+
+---------------------
+2. DEVICE INFORMATION
+---------------------
+
+Manufacturer:	Samsung
+Device Name:	KS0108 LCD Controller
+Device Code:	ks0108
+Webpage:	-
+Device Webpage:	-
+Type:		LCD Controller (Liquid Crystal Display Controller)
+Width:		64
+Height:		64
+Colors:		2 (B/N)
+Pages:		8
+Addresses:	64 each page
+
+
+
+---------
+3. WIRING
+---------
+
+The driver supports data parallel port wiring.
+
+If you aren't creating a LCD related hardware, you should check
+your LCD specific wiring information in the same folder, not this one.
+
+
+Wiring example of a cfag12864b LCD which has two ks0108 controllers:
+
+http://www.skippari.net/lcd/sekalaista/crystalfontz_cfag12864B-TMI-V.png
+
+EOF
diff -uprN -X dontdiff linux-2.6.19-rc1-vanilla/drivers/auxdisplay/cfag12864b.c linux/drivers/auxdisplay/cfag12864b.c
--- linux-2.6.19-rc1-vanilla/drivers/auxdisplay/cfag12864b.c	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/auxdisplay/cfag12864b.c	2006-10-13 02:18:59.000000000 +0000
@@ -0,0 +1,328 @@
+/*
+ *    Filename: cfag12864b.c
+ *     Version: 0.1.0
+ * Description: cfag12864b LCD driver
+ *     License: GPLv2
+ *     Depends: ks0108
+ *
+ *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-10-13
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/jiffies.h>
+#include <linux/workqueue.h>
+#include <linux/vmalloc.h>
+#include <linux/ks0108.h>
+#include <linux/cfag12864b.h>
+#include <linux/uaccess.h>
+
+#define CFAG12864B_NAME "cfag12864b"
+
+/*
+ * Module Parameters
+ */
+
+static unsigned int cfag12864b_rate = CONFIG_CFAG12864B_RATE;
+module_param(cfag12864b_rate, uint, S_IRUGO);
+MODULE_PARM_DESC(cfag12864b_rate,
+	"Refresh rate (hertzs)");
+
+/*
+ * cfag12864b Commands
+ *
+ *	E = Enable signal
+ *		Everytime E switch from low to high,
+ *		cfag12864b/ks0108 reads the command/data.
+ *
+ *	CS1 = First ks0108controller.
+ *		If high, the first ks0108 receives commands/data.
+ *
+ *	CS2 = Second ks0108 controller
+ *		If high, the second ks0108 receives commands/data.
+ *
+ *	DI = Data/Instruction
+ *		If low, cfag12864b will expect commands.
+ *		If high, cfag12864b will expect data.
+ *	
+ */
+
+#define bit(n) (((unsigned char)1)<<(n))
+
+#define CFAG12864B_BIT_E	(0)
+#define CFAG12864B_BIT_CS1	(2)
+#define CFAG12864B_BIT_CS2	(1)
+#define CFAG12864B_BIT_DI	(3)
+
+static unsigned char cfag12864b_state;
+
+static void cfag12864b_set(void)
+{
+	ks0108_writecontrol(cfag12864b_state);
+}
+
+static void cfag12864b_setbit(unsigned char state, unsigned char n)
+{
+	if (state)
+		cfag12864b_state |= bit(n);
+	else
+		cfag12864b_state &= ~bit(n);
+}
+
+static void cfag12864b_e(unsigned char state)
+{
+	cfag12864b_setbit(state, CFAG12864B_BIT_E);
+	cfag12864b_set();
+}
+
+static void cfag12864b_cs1(unsigned char state)
+{
+	cfag12864b_setbit(state, CFAG12864B_BIT_CS1);
+}
+
+static void cfag12864b_cs2(unsigned char state)
+{
+	cfag12864b_setbit(state, CFAG12864B_BIT_CS2);
+}
+
+static void cfag12864b_di(unsigned char state)
+{
+	cfag12864b_setbit(state, CFAG12864B_BIT_DI);
+}
+
+static void cfag12864b_setcontrollers(unsigned char first,
+	unsigned char second)
+{
+	if (first)
+		cfag12864b_cs1(0);
+	else
+		cfag12864b_cs1(1);
+
+	if (second)
+		cfag12864b_cs2(0);
+	else
+		cfag12864b_cs2(1);
+}
+
+static void cfag12864b_controller(unsigned char which)
+{
+	if (which == 0)
+		cfag12864b_setcontrollers(1, 0);
+	else if (which == 1)
+		cfag12864b_setcontrollers(0, 1);
+}
+
+static void cfag12864b_displaystate(unsigned char state)
+{
+	cfag12864b_di(0);
+	cfag12864b_e(1);
+	ks0108_displaystate(state);
+	cfag12864b_e(0);
+}
+
+static void cfag12864b_address(unsigned char address)
+{
+	cfag12864b_di(0);
+	cfag12864b_e(1);
+	ks0108_address(address);
+	cfag12864b_e(0);
+}
+
+static void cfag12864b_page(unsigned char page)
+{
+	cfag12864b_di(0);
+	cfag12864b_e(1);
+	ks0108_page(page);
+	cfag12864b_e(0);
+}
+
+static void cfag12864b_startline(unsigned char startline)
+{
+	cfag12864b_di(0);
+	cfag12864b_e(1);
+	ks0108_startline(startline);
+	cfag12864b_e(0);
+}
+
+static void cfag12864b_writebyte(unsigned char byte)
+{
+	cfag12864b_di(1);
+	cfag12864b_e(1);
+	ks0108_writedata(byte);
+	cfag12864b_e(0);
+}
+
+static void cfag12864b_nop(void)
+{
+	cfag12864b_startline(0);
+}
+
+/*
+ * cfag12864b Internal Commands
+ */
+
+unsigned char *cfag12864b_cache;
+unsigned char *cfag12864b_buffer;
+EXPORT_SYMBOL_GPL(cfag12864b_buffer);
+
+static void cfag12864b_on(void)
+{
+	cfag12864b_setcontrollers(1, 1);
+	cfag12864b_displaystate(1);
+}
+
+static void cfag12864b_off(void)
+{
+	cfag12864b_setcontrollers(1, 1);
+	cfag12864b_displaystate(0);
+}
+
+static void cfag12864b_clear(void)
+{
+	unsigned char i, j;
+
+	cfag12864b_setcontrollers(1, 1);
+	for (i = 0; i < CFAG12864B_PAGES; i++) {
+		cfag12864b_page(i);
+		cfag12864b_address(0);
+		for (j = 0; j < CFAG12864B_ADDRESSES; j++)
+			cfag12864b_writebyte(0);
+	}
+}
+
+/*
+ * Update work
+ */
+
+static void cfag12864b_update(void *arg);
+static struct workqueue_struct *cfag12864b_workqueue;
+DECLARE_WORK(cfag12864b_work, cfag12864b_update, NULL);
+
+static unsigned char cfag12864b_updating;
+
+static void cfag12864b_update(void *arg)
+{
+	unsigned char c;
+	unsigned short i, j, k, b;
+
+	if(memcmp(cfag12864b_cache, cfag12864b_buffer, CFAG12864B_SIZE)) {
+		for (i = 0; i < CFAG12864B_CONTROLLERS; i++) {
+			cfag12864b_controller(i);
+			cfag12864b_nop();
+			for (j = 0; j < CFAG12864B_PAGES; j++) {
+				cfag12864b_page(j);
+				cfag12864b_nop();
+				cfag12864b_address(0);
+				cfag12864b_nop();
+				for (k = 0; k < CFAG12864B_ADDRESSES; k++) {
+					for (c = 0, b = 0; b < 8; b++)
+						if (cfag12864b_buffer
+							[i * CFAG12864B_ADDRESSES / 8
+							+ k / 8 + (j * 8 + b) *
+							CFAG12864B_WIDTH / 8]
+							& bit(k % 8))
+							c |= bit(b);
+					cfag12864b_writebyte(c);
+				}
+			}
+		}
+
+		memcpy(cfag12864b_cache, cfag12864b_buffer, CFAG12864B_SIZE);
+	}
+
+	if(cfag12864b_updating)
+		queue_delayed_work(cfag12864b_workqueue, &cfag12864b_work,
+			HZ / cfag12864b_rate);
+}
+
+/*
+ * Module Init & Exit
+ */
+
+static int __init cfag12864b_init(void)
+{
+	int ret = -EINVAL;
+
+	cfag12864b_buffer = vmalloc(sizeof(unsigned char) *
+		CFAG12864B_SIZE);
+	if (cfag12864b_buffer == NULL) {
+		printk(KERN_ERR CFAG12864B_NAME ": ERROR: "
+			"can't v-alloc buffer (%i bytes)\n",
+			CFAG12864B_SIZE);
+		ret = -ENOMEM;
+		goto none;
+	}
+
+	cfag12864b_cache = kmalloc(sizeof(unsigned char) *
+		CFAG12864B_SIZE, GFP_KERNEL);
+	if (cfag12864b_buffer == NULL) {
+		printk(KERN_ERR CFAG12864B_NAME ": ERROR: "
+			"can't alloc cache buffer (%i bytes)\n",
+			CFAG12864B_SIZE);
+		ret = -ENOMEM;
+		goto bufferalloced;
+	}
+
+	memset(cfag12864b_buffer, 0, CFAG12864B_SIZE);
+
+	cfag12864b_clear();
+	cfag12864b_on();
+
+	cfag12864b_workqueue = create_singlethread_workqueue(CFAG12864B_NAME);
+	if(cfag12864b_workqueue == NULL)
+		goto cachealloced;
+
+	cfag12864b_updating = 1;
+	cfag12864b_update(NULL);
+
+	return 0;
+
+cachealloced:
+	kfree(cfag12864b_cache);
+
+bufferalloced:
+	vfree(cfag12864b_buffer);
+
+none:
+	return ret;
+}
+
+static void __exit cfag12864b_exit(void)
+{
+	cfag12864b_updating = 0;
+	mdelay((1000 / cfag12864b_rate) * 2);
+	destroy_workqueue(cfag12864b_workqueue);
+
+	cfag12864b_off();
+
+	kfree(cfag12864b_cache);
+	vfree(cfag12864b_buffer);
+}
+
+module_init(cfag12864b_init);
+module_exit(cfag12864b_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
+MODULE_DESCRIPTION("cfag12864b LCD driver");
diff -uprN -X dontdiff linux-2.6.19-rc1-vanilla/drivers/auxdisplay/cfag12864bfb.c linux/drivers/auxdisplay/cfag12864bfb.c
--- linux-2.6.19-rc1-vanilla/drivers/auxdisplay/cfag12864bfb.c	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/auxdisplay/cfag12864bfb.c	2006-10-13 02:19:04.000000000 +0000
@@ -0,0 +1,165 @@
+/*
+ *    Filename: cfag12864bfb.c
+ *     Version: 0.1.0
+ * Description: cfag12864b LCD framebuffer driver
+ *     License: GPLv2
+ *     Depends: cfag12864b
+ *
+ *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-10-13
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/cfag12864b.h>
+#include <asm/uaccess.h>
+
+#define CFAG12864BFB_NAME "cfag12864bfb"
+
+static struct fb_fix_screeninfo cfag12864bfb_fix __initdata = {
+	.id = "cfag12864b", 
+	.type = FB_TYPE_PACKED_PIXELS,
+	.visual = FB_VISUAL_MONO10,
+	.xpanstep = 0,
+	.ypanstep = 0,
+	.ywrapstep = 0,
+	.line_length = CFAG12864B_WIDTH / 8,
+	.accel = FB_ACCEL_NONE,
+};
+
+static struct fb_var_screeninfo cfag12864bfb_var __initdata = {
+	.xres = CFAG12864B_WIDTH,
+	.yres = CFAG12864B_HEIGHT,
+	.xres_virtual = CFAG12864B_WIDTH,
+	.yres_virtual = CFAG12864B_HEIGHT,
+	.bits_per_pixel = 1,
+	.red = { 0, 1, 0 },
+      	.green = { 0, 1, 0 },
+      	.blue = { 0, 1, 0 },
+	.left_margin = 0,
+	.right_margin = 0,
+	.upper_margin = 0,
+	.lower_margin = 0,
+	.vmode = FB_VMODE_NONINTERLACED,
+};
+
+static struct fb_ops cfag12864bfb_ops = {
+	.owner = THIS_MODULE,
+	.fb_fillrect = cfb_fillrect,
+	.fb_copyarea = cfb_copyarea,
+	.fb_imageblit = cfb_imageblit,
+};
+
+static int __init cfag12864bfb_probe(struct platform_device *device)
+{
+	int ret = -EINVAL;
+ 	struct fb_info *info = framebuffer_alloc(0, &device->dev);
+
+	if (!info)
+		goto none;
+
+	info->screen_base = (char __iomem *)cfag12864b_buffer;
+	info->screen_size = CFAG12864B_SIZE;
+	info->fbops = &cfag12864bfb_ops;
+	info->fix = cfag12864bfb_fix;
+	info->var = cfag12864bfb_var;
+	info->pseudo_palette = NULL;
+	info->par = NULL;
+	info->flags = FBINFO_FLAG_DEFAULT;
+
+	if (register_framebuffer(info) < 0)
+		goto fballoced;
+
+	platform_set_drvdata(device, info);
+
+	printk(KERN_INFO "fb%d: %s frame buffer device\n", info->node,
+		info->fix.id);
+
+	return 0;
+
+fballoced:
+	framebuffer_release(info);
+
+none:
+	return ret;
+}
+
+static int cfag12864bfb_remove(struct platform_device *device)
+{
+	struct fb_info *info = platform_get_drvdata(device);
+
+	if (info) {
+		unregister_framebuffer(info);
+		framebuffer_release(info);
+	}
+
+	return 0;
+}
+
+static struct platform_driver cfag12864bfb_driver = {
+	.probe	= cfag12864bfb_probe,
+	.remove = cfag12864bfb_remove,
+	.driver = {
+		.name	= CFAG12864BFB_NAME,
+	},
+};
+
+static struct platform_device *cfag12864bfb_device;
+
+static int __init cfag12864bfb_init(void)
+{
+	int ret = platform_driver_register(&cfag12864bfb_driver);
+
+	if (!ret) {
+		cfag12864bfb_device =
+			platform_device_alloc(CFAG12864BFB_NAME, 0);
+
+		if (cfag12864bfb_device)
+			ret = platform_device_add(cfag12864bfb_device);
+		else
+			ret = -ENOMEM;
+
+		if (ret) {
+			platform_device_put(cfag12864bfb_device);
+			platform_driver_unregister(&cfag12864bfb_driver);
+		}
+	}
+
+	return ret;
+}
+
+static void __exit cfag12864bfb_exit(void)
+{
+	platform_device_unregister(cfag12864bfb_device);
+	platform_driver_unregister(&cfag12864bfb_driver);
+}
+
+module_init(cfag12864bfb_init);
+module_exit(cfag12864bfb_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
+MODULE_DESCRIPTION("cfag12864b LCD framebuffer driver");
diff -uprN -X dontdiff linux-2.6.19-rc1-vanilla/drivers/auxdisplay/Kconfig linux/drivers/auxdisplay/Kconfig
--- linux-2.6.19-rc1-vanilla/drivers/auxdisplay/Kconfig	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/auxdisplay/Kconfig	2006-10-13 02:17:19.000000000 +0000
@@ -0,0 +1,112 @@
+#
+# For a description of the syntax of this configuration file,
+# see Documentation/kbuild/kconfig-language.txt.
+#
+# Auxiliary display drivers configuration.
+#
+
+menu "Auxiliary Display support"
+
+config KS0108
+	tristate "KS0108 LCD Controller"
+	select PARPORT
+	select PARPORT_PC
+	default n
+	---help---
+	  If you have a LCD controlled by one or more KS0108
+	  controllers, say Y. You will need also another more specific
+	  driver for your LCD.
+
+	  Depends on Parallel Port support. If you say Y at
+	  parport, you will be able to compile this as a module (M)
+	  and built-in as well (Y).
+
+	  To compile this as a module, choose M here:
+	  the module will be called ks0108.
+
+	  If unsure, say N.
+
+config KS0108_PORT
+	hex "Parallel port where the LCD is connected"
+	depends on KS0108
+	default 0x378
+	---help---
+	  The address of the parallel port where the LCD is connected.
+
+	  The first  standard parallel port address is 0x378.
+	  The second standard parallel port address is 0x278.
+	  The third  standard parallel port address is 0x3BC.
+
+	  You can specify a different address if you need.
+
+	  If you don't know what I'm talking about, load the parport module,
+	  and execute "dmesg" or "cat /proc/ioports". You can see there how
+	  many parallel ports are present and which address each one has.
+
+	  Usually you only need to use 0x378.
+
+	  If you compile this as a module, you can still override this
+	  using the module parameters.
+
+config KS0108_DELAY
+	int "Delay between each control writing (microseconds)"
+	depends on KS0108
+	default "2"
+	---help---
+	  Amount of time the ks0108 should wait between each control write
+	  to the parallel port.
+
+	  If your driver seems to miss random writings, increment this.
+
+	  If you don't know what I'm talking about, ignore it.
+
+	  If you compile this as a module, you can still override this
+	  value using the module parameters.
+
+config CFAG12864B
+	tristate "CFAG12864B LCD"
+	depends on KS0108
+	default n
+	---help---
+	  If you have a Crystalfontz 128x64 2-color LCD, cfag12864b Series,
+	  say Y. You also need the ks0108 LCD Controller driver.
+
+	  For help about how to wire your LCD to the parallel port,
+	  check this image:
+	  
+	  http://www.skippari.net/lcd/sekalaista/crystalfontz_cfag12864B-TMI-V.png
+
+	  Also, you can find help in Crystalfontz and LCDStudio forums.
+	  Check Documentation/lcddisplay/cfag12864b for more information.
+
+	  The LCD framebuffer driver can be attached to a console.
+	  It will work fine. However, you can't attach it to the fbdev driver
+	  of the xorg server.
+
+	  To compile this as a module, choose M here:
+	  the modules will be called cfag12864b and cfag12864bfb.
+
+	  If unsure, say N.
+
+config CFAG12864B_RATE
+	int "Refresh rate (hertzs)"
+	depends on CFAG12864B
+	default "20"
+	---help---
+	  Refresh rate of the LCD.
+
+	  As the LCD is not memory mapped, the driver has to make the work by
+	  software. This means you should be careful setting this value higher.
+	  If your CPUs are really slow or you feel the system is slowed down,
+	  decrease the value.
+
+	  Be careful modifying this value to a very high value:
+	  You can freeze the computer, or the LCD maybe can't draw as fast as you
+	  are requesting.
+
+	  If you don't know what I'm talking about, ignore it.
+
+	  If you compile this as a module, you can still override this
+	  value using the module parameters.
+endmenu
+
diff -uprN -X dontdiff linux-2.6.19-rc1-vanilla/drivers/auxdisplay/ks0108.c linux/drivers/auxdisplay/ks0108.c
--- linux-2.6.19-rc1-vanilla/drivers/auxdisplay/ks0108.c	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/auxdisplay/ks0108.c	2006-10-11 23:20:33.000000000 +0000
@@ -0,0 +1,167 @@
+/*
+ *    Filename: ks0108.c
+ *     Version: 0.1.0
+ * Description: ks0108 LCD Controller driver
+ *     License: GPLv2
+ *     Depends: parport
+ *
+ *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-10-04
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/delay.h>
+#include <linux/parport.h>
+#include <linux/ks0108.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#define KS0108_NAME "ks0108"
+
+/*
+ * Module Parameters
+ */
+
+static unsigned int ks0108_port = CONFIG_KS0108_PORT;
+module_param(ks0108_port, uint, S_IRUGO);
+MODULE_PARM_DESC(ks0108_port, "Parallel port where the LCD is connected");
+
+static unsigned int ks0108_delay = CONFIG_KS0108_DELAY;
+module_param(ks0108_delay, uint, S_IRUGO);
+MODULE_PARM_DESC(ks0108_delay, "Delay between each control writing (microseconds)");
+
+/*
+ * Device
+ */
+
+static struct parport *ks0108_parport;
+static struct pardevice *ks0108_pardevice;
+
+/*
+ * ks0108 Exported cmds (don't lock)
+ *
+ *   You _should_ lock in the top driver: This functions _should not_
+ *   get race conditions in any way. Locking for each byte here would be
+ *   so slow and useless.
+ *
+ *   There are not bit definitions because they are not flags,
+ *   just arbitrary combinations defined by the documentation for each
+ *   function in the ks0108 LCD controller. If you want to know what means
+ *   a specific combination, look at the function's name.
+ *
+ *   The ks0108_writecontrol bits need to be reverted ^(0,1,3) because
+ *   the parallel port also revert them with a "not" logic gate.
+ */
+
+#define bit(n) (((unsigned char)1)<<(n))
+
+void ks0108_writedata(unsigned char byte)
+{
+	parport_write_data(ks0108_parport, byte);
+}
+
+void ks0108_writecontrol(unsigned char byte)
+{
+	udelay(ks0108_delay);
+	parport_write_control(ks0108_parport, byte ^ (bit(0) | bit(1) | bit(3)));
+}
+
+void ks0108_displaystate(unsigned char state)
+{
+	ks0108_writedata((state ? bit(0) : 0) | bit(1) | bit(2) | bit(3) | bit(4) | bit(5));
+}
+
+void ks0108_startline(unsigned char startline)
+{
+	ks0108_writedata(min(startline,(unsigned char)63) | bit(6) | bit(7));
+}
+
+void ks0108_address(unsigned char address)
+{
+	ks0108_writedata(min(address,(unsigned char)63) | bit(6));
+}
+
+void ks0108_page(unsigned char page)
+{
+	ks0108_writedata(min(page,(unsigned char)7) | bit(3) | bit(4) | bit(5) | bit(7));
+}
+
+EXPORT_SYMBOL_GPL(ks0108_writedata);
+EXPORT_SYMBOL_GPL(ks0108_writecontrol);
+EXPORT_SYMBOL_GPL(ks0108_displaystate);
+EXPORT_SYMBOL_GPL(ks0108_startline);
+EXPORT_SYMBOL_GPL(ks0108_address);
+EXPORT_SYMBOL_GPL(ks0108_page);
+
+/*
+ * Module Init & Exit
+ */
+
+static int __init ks0108_init(void)
+{
+	int result;
+	int ret = -EINVAL;
+
+	ks0108_parport = parport_find_base(ks0108_port);
+	if (ks0108_parport == NULL) {
+		printk(KERN_ERR KS0108_NAME ": ERROR: "
+			"parport didn't find %i port\n", ks0108_port);
+		goto none;
+	}
+
+	ks0108_pardevice = parport_register_device(ks0108_parport, KS0108_NAME,
+		NULL, NULL, NULL, PARPORT_DEV_EXCL, NULL);
+	if (ks0108_pardevice == NULL) {
+		printk(KERN_ERR KS0108_NAME ": ERROR: "
+			"parport didn't register new device\n");
+		goto none;
+	}
+
+	result = parport_claim(ks0108_pardevice);
+	if (result != 0) {
+		printk(KERN_ERR KS0108_NAME ": ERROR: "
+			"can't claim %i parport, maybe in use\n", ks0108_port);
+		ret = result;
+		goto registered;
+	}
+
+	return 0;
+
+registered:
+	parport_unregister_device(ks0108_pardevice);
+
+none:
+	return ret;
+}
+
+static void __exit ks0108_exit(void)
+{
+	parport_release(ks0108_pardevice);
+	parport_unregister_device(ks0108_pardevice);
+}
+
+module_init(ks0108_init);
+module_exit(ks0108_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
+MODULE_DESCRIPTION("ks0108 LCD Controller driver");
+
diff -uprN -X dontdiff linux-2.6.19-rc1-vanilla/drivers/auxdisplay/Makefile linux/drivers/auxdisplay/Makefile
--- linux-2.6.19-rc1-vanilla/drivers/auxdisplay/Makefile	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/auxdisplay/Makefile	2006-10-11 15:51:37.000000000 +0000
@@ -0,0 +1,6 @@
+#
+# Makefile for the kernel auxiliary displays device drivers.
+#
+
+obj-$(CONFIG_KS0108)		+= ks0108.o
+obj-$(CONFIG_CFAG12864B)	+= cfag12864b.o cfag12864bfb.o
diff -uprN -X dontdiff linux-2.6.19-rc1-vanilla/drivers/Kconfig linux/drivers/Kconfig
--- linux-2.6.19-rc1-vanilla/drivers/Kconfig	2006-10-13 02:10:22.000000000 +0000
+++ linux/drivers/Kconfig	2006-10-05 13:46:44.000000000 +0000
@@ -76,4 +76,6 @@ source "drivers/rtc/Kconfig"
 
 source "drivers/dma/Kconfig"
 
+source "drivers/auxdisplay/Kconfig"
+
 endmenu
diff -uprN -X dontdiff linux-2.6.19-rc1-vanilla/drivers/Makefile linux/drivers/Makefile
--- linux-2.6.19-rc1-vanilla/drivers/Makefile	2006-10-13 02:10:22.000000000 +0000
+++ linux/drivers/Makefile	2006-10-05 13:46:44.000000000 +0000
@@ -77,3 +77,4 @@ obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
 obj-$(CONFIG_GENERIC_TIME)	+= clocksource/
 obj-$(CONFIG_DMA_ENGINE)	+= dma/
+obj-y				+= auxdisplay/
diff -uprN -X dontdiff linux-2.6.19-rc1-vanilla/include/linux/cfag12864b.h linux/include/linux/cfag12864b.h
--- linux-2.6.19-rc1-vanilla/include/linux/cfag12864b.h	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/cfag12864b.h	2006-10-12 15:14:09.000000000 +0000
@@ -0,0 +1,41 @@
+/*
+ *    Filename: cfag12864b.h
+ *     Version: 0.1.0
+ * Description: cfag12864b LCD driver header
+ *     License: GPLv2
+ *
+ *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-10-12
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef _CFAG12864B_H_
+#define _CFAG12864B_H_
+
+#define CFAG12864B_WIDTH	(128)
+#define CFAG12864B_HEIGHT	(64)
+#define CFAG12864B_CONTROLLERS	(2)
+#define CFAG12864B_PAGES	(8)
+#define CFAG12864B_ADDRESSES	(64)
+#define CFAG12864B_SIZE		((CFAG12864B_CONTROLLERS) * \
+				(CFAG12864B_PAGES) * \
+				(CFAG12864B_ADDRESSES))
+
+extern unsigned char * cfag12864b_buffer;
+
+#endif /* _CFAG12864B_H_ */
+
diff -uprN -X dontdiff linux-2.6.19-rc1-vanilla/include/linux/ks0108.h linux/include/linux/ks0108.h
--- linux-2.6.19-rc1-vanilla/include/linux/ks0108.h	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/ks0108.h	2006-10-05 13:46:44.000000000 +0000
@@ -0,0 +1,36 @@
+/*
+ *    Filename: ks0108.h
+ *     Version: 0.1.0
+ * Description: ks0108 LCD Controller driver header
+ *     License: GPLv2
+ *
+ *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-10-04
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef _KS0108_H_
+#define _KS0108_H_
+
+extern void ks0108_writedata(unsigned char byte);
+extern void ks0108_writecontrol(unsigned char byte);
+extern void ks0108_displaystate(unsigned char state);
+extern void ks0108_startline(unsigned char startline);
+extern void ks0108_address(unsigned char address);
+extern void ks0108_page(unsigned char page);
+
+#endif /* _KS0108_H_ */
diff -uprN -X dontdiff linux-2.6.19-rc1-vanilla/MAINTAINERS linux/MAINTAINERS
--- linux-2.6.19-rc1-vanilla/MAINTAINERS	2006-10-13 02:10:17.000000000 +0000
+++ linux/MAINTAINERS	2006-10-12 12:24:08.000000000 +0000
@@ -441,6 +441,12 @@ W:	http://people.redhat.com/sgrubb/audit
 T:	git kernel.org:/pub/scm/linux/kernel/git/dwmw2/audit-2.6.git
 S:	Maintained
 
+AUXILIARY DISPLAY DRIVERS
+P:	Miguel Ojeda Sandonis
+M:	maxextreme@gmail.com
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 AVR32 ARCHITECTURE
 P:	Atmel AVR32 Support Team
 M:	avr32@atmel.com
@@ -646,6 +652,18 @@ L:	linux-kernel@vger.kernel.org
 L:	discuss@x86-64.org
 S:	Maintained
 
+CFAG12864B LCD DRIVER
+P:	Miguel Ojeda Sandonis
+M:	maxextreme@gmail.com
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
+CFAG12864BFB LCD FRAMEBUFFER DRIVER
+P:	Miguel Ojeda Sandonis
+M:	maxextreme@gmail.com
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 COMMON INTERNET FILE SYSTEM (CIFS)
 P:	Steve French
 M:	sfrench@samba.org
@@ -1736,6 +1754,12 @@ M:	davem@davemloft.net
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+KS0108 LCD CONTROLLER DRIVER
+P:	Miguel Ojeda Sandonis
+M:	maxextreme@gmail.com
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 LAPB module
 L:	linux-x25@vger.kernel.org
 S:	Orphan
