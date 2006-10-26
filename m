Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423585AbWJZPtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423585AbWJZPtj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 11:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423587AbWJZPtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 11:49:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:41355 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423585AbWJZPti convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 11:49:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=cHpoehmyona2+YaVaijYJmhaU79/KmyQMNDz50PXB6OmMdn1znFOkfY9cuiQpbprxjUoUfo0mX6fRPQXXWse7Va1mYDkDtpEMmDDHT7VpPa/fawlpX+eHWhAu+CnR8BL33Ipw692irDwPtBgQjPBtq8gomgN3kXGLgtfRIPtUG0=
Date: Thu, 26 Oct 2006 17:48:58 +0000
From: Miguel Ojeda Sandonis <maxextreme@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19-rc1 update4] drivers: add LCD support
Message-Id: <20061026174858.b7c5eab1.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, here it is a small update for the
drivers-add-lcd-support patch at -mm2. Please apply.

Franck Bui-Huu, thanks for pointing out the lack of mmaping support.
---

 - Adds mmaping support for the cfag12864bfb.
 - Exchange the wiring drawing URL to a local ASCII drawing
   at Documentation/auxdisplay/cfag12864b.

 Documentation/auxdisplay/cfag12864b |   37 +++++++++++++++++++++-----
 drivers/auxdisplay/Kconfig          |    7 ----
 drivers/auxdisplay/cfag12864b.c     |   22 +++++++++------
 drivers/auxdisplay/cfag12864bfb.c   |   37 +++++++++++++++++++++++---
 4 files changed, 80 insertions(+), 23 deletions(-)

miguelojeda-2.6.19-rc1-drivers-add-LCD-support-4-mmaping-and-ascii-drawing.patch
Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff -uprN -X dontdiff linux-2.6.19-rc1-modified/Documentation/auxdisplay/cfag12864b linux/Documentation/auxdisplay/cfag12864b
--- linux-2.6.19-rc1-modified/Documentation/auxdisplay/cfag12864b	2006-10-26 16:57:38.000000000 +0000
+++ linux/Documentation/auxdisplay/cfag12864b	2006-10-26 16:38:54.000000000 +0000
@@ -4,7 +4,7 @@
 
 License:		GPLv2
 Author & Maintainer:	Miguel Ojeda Sandonis <maxextreme@gmail.com>
-Date:			2006-10-11
+Date:			2006-10-26
 
 
 
@@ -51,12 +51,37 @@ Addresses:	64 each page
 
 The cfag12864b LCD Series don't have official wiring.
 
-The common wiring is done to the parallel port:
-
-http://www.skippari.net/lcd/sekalaista/crystalfontz_cfag12864B-TMI-V.png
-
-You can get help at Crystalfontz and LCDInfo forums.
+The common wiring is done to the parallel port as shown:
 
+Parallel Port                          cfag12864b
+
+  Name Pin#                            Pin# Name
+
+Strobe ( 1)------------------------------(17) Enable
+Data 0 ( 2)------------------------------( 4) Data 0
+Data 1 ( 3)------------------------------( 5) Data 1
+Data 2 ( 4)------------------------------( 6) Data 2
+Data 3 ( 5)------------------------------( 7) Data 3
+Data 4 ( 6)------------------------------( 8) Data 4
+Data 5 ( 7)------------------------------( 9) Data 5
+Data 6 ( 8)------------------------------(10) Data 6
+Data 7 ( 9)------------------------------(11) Data 7
+       (10)                      [+5v]---( 1) Vdd
+       (11)                      [GND]---( 2) Ground
+       (12)                      [+5v]---(14) Reset
+       (13)                      [GND]---(15) Read / Write
+  Line (14)------------------------------(13) Controller Select 1
+       (15)               
+  Init (16)------------------------------(12) Controller Select 2
+Select (17)------------------------------(16) Data / Instruction
+Ground (18)---[GND]              [+5v]---(19) LED +
+Ground (19)---[GND]
+Ground (20)---[GND]              E    A             Values:
+Ground (21)---[GND]       [GND]---[P1]---(18) Vee    · R = Resistor = 22 ohm
+Ground (22)---[GND]                |                 · P1 = Preset = 10 Kohm
+Ground (23)---[GND]       ----   S ------( 3) V0     · P2 = Preset = 1 Kohm
+Ground (24)---[GND]       |  |
+Ground (25)---[GND] [GND]---[P2]---[R]---(20) LED -
 
 
 ------------------------
diff -uprN -X dontdiff linux-2.6.19-rc1-modified/drivers/auxdisplay/cfag12864b.c linux/drivers/auxdisplay/cfag12864b.c
--- linux-2.6.19-rc1-modified/drivers/auxdisplay/cfag12864b.c	2006-10-26 16:57:38.000000000 +0000
+++ linux/drivers/auxdisplay/cfag12864b.c	2006-10-26 16:48:36.000000000 +0000
@@ -6,7 +6,7 @@
  *     Depends: ks0108
  *
  *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
- *        Date: 2006-10-13
+ *        Date: 2006-10-26
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -182,7 +182,7 @@ static void cfag12864b_nop(void)
  * cfag12864b Internal Commands
  */
 
-unsigned char *cfag12864b_cache;
+static unsigned char *cfag12864b_cache;
 unsigned char *cfag12864b_buffer;
 EXPORT_SYMBOL_GPL(cfag12864b_buffer);
 
@@ -264,12 +264,18 @@ static int __init cfag12864b_init(void)
 {
 	int ret = -EINVAL;
 
-	cfag12864b_buffer = vmalloc(sizeof(unsigned char) *
-		CFAG12864B_SIZE);
+	if(PAGE_SIZE < CFAG12864B_SIZE) {
+		printk(KERN_ERR CFAG12864B_NAME ": ERROR: "
+			"page size (%i) < cfag12864b size (%i)\n",
+			(unsigned int)PAGE_SIZE, CFAG12864B_SIZE);
+		ret = -ENOMEM;
+		goto none;
+	}
+
+	cfag12864b_buffer = (unsigned char *) __get_free_page(GFP_KERNEL);
 	if (cfag12864b_buffer == NULL) {
 		printk(KERN_ERR CFAG12864B_NAME ": ERROR: "
-			"can't v-alloc buffer (%i bytes)\n",
-			CFAG12864B_SIZE);
+			"can't get a free page\n");
 		ret = -ENOMEM;
 		goto none;
 	}
@@ -302,7 +308,7 @@ cachealloced:
 	kfree(cfag12864b_cache);
 
 bufferalloced:
-	vfree(cfag12864b_buffer);
+	free_page((unsigned long) cfag12864b_buffer);
 
 none:
 	return ret;
@@ -317,7 +323,7 @@ static void __exit cfag12864b_exit(void)
 	cfag12864b_off();
 
 	kfree(cfag12864b_cache);
-	vfree(cfag12864b_buffer);
+	free_page((unsigned long) cfag12864b_buffer);
 }
 
 module_init(cfag12864b_init);
diff -uprN -X dontdiff linux-2.6.19-rc1-modified/drivers/auxdisplay/cfag12864bfb.c linux/drivers/auxdisplay/cfag12864bfb.c
--- linux-2.6.19-rc1-modified/drivers/auxdisplay/cfag12864bfb.c	2006-10-26 16:57:38.000000000 +0000
+++ linux/drivers/auxdisplay/cfag12864bfb.c	2006-10-26 16:22:42.000000000 +0000
@@ -6,7 +6,7 @@
  *     Depends: cfag12864b
  *
  *      Author: Copyright (C) Miguel Ojeda Sandonis <maxextreme@gmail.com>
- *        Date: 2006-10-13
+ *        Date: 2006-10-26
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -35,12 +35,13 @@
 #include <linux/platform_device.h>
 #include <linux/init.h>
 #include <linux/cfag12864b.h>
+#include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
 #define CFAG12864BFB_NAME "cfag12864bfb"
 
 static struct fb_fix_screeninfo cfag12864bfb_fix __initdata = {
-	.id = "cfag12864b", 
+	.id = "cfag12864b",
 	.type = FB_TYPE_PACKED_PIXELS,
 	.visual = FB_VISUAL_MONO10,
 	.xpanstep = 0,
@@ -66,11 +67,41 @@ static struct fb_var_screeninfo cfag1286
 	.vmode = FB_VMODE_NONINTERLACED,
 };
 
+DECLARE_MUTEX(cfag12864bfb_sem);
+
+struct page *cfag12864bfb_vma_nopage(struct vm_area_struct *vma,
+	unsigned long address, int *type)
+{
+	struct page *page;
+	down(&cfag12864bfb_sem);
+
+	page = virt_to_page(cfag12864b_buffer);
+	get_page(page);
+
+	if(type)
+		*type = VM_FAULT_MINOR;
+
+	up(&cfag12864bfb_sem);
+	return page;
+}
+
+static struct vm_operations_struct cfag12864bfb_vm_ops = {
+	.nopage = cfag12864bfb_vma_nopage,
+};
+
+static int cfag12864bfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
+{
+	vma->vm_ops = &cfag12864bfb_vm_ops;
+	vma->vm_flags |= VM_RESERVED;
+	return 0;
+}
+
 static struct fb_ops cfag12864bfb_ops = {
 	.owner = THIS_MODULE,
 	.fb_fillrect = cfb_fillrect,
 	.fb_copyarea = cfb_copyarea,
 	.fb_imageblit = cfb_imageblit,
+	.fb_mmap = cfag12864bfb_mmap,
 };
 
 static int __init cfag12864bfb_probe(struct platform_device *device)
@@ -81,7 +112,7 @@ static int __init cfag12864bfb_probe(str
 	if (!info)
 		goto none;
 
-	info->screen_base = (char __iomem *)cfag12864b_buffer;
+	info->screen_base = (char __iomem *) cfag12864b_buffer;
 	info->screen_size = CFAG12864B_SIZE;
 	info->fbops = &cfag12864bfb_ops;
 	info->fix = cfag12864bfb_fix;
diff -uprN -X dontdiff linux-2.6.19-rc1-modified/drivers/auxdisplay/Kconfig linux/drivers/auxdisplay/Kconfig
--- linux-2.6.19-rc1-modified/drivers/auxdisplay/Kconfig	2006-10-26 17:01:26.000000000 +0000
+++ linux/drivers/auxdisplay/Kconfig	2006-10-26 17:39:57.000000000 +0000
@@ -71,12 +71,7 @@ config CFAG12864B
 	  say Y. You also need the ks0108 LCD Controller driver.
 
 	  For help about how to wire your LCD to the parallel port,
-	  check this image:
-	  
-	  http://www.skippari.net/lcd/sekalaista/crystalfontz_cfag12864B-TMI-V.png
-
-	  Also, you can find help in Crystalfontz and LCDStudio forums.
-	  Check Documentation/lcddisplay/cfag12864b for more information.
+	  check Documentation/auxdisplay/cfag12864b
 
 	  The LCD framebuffer driver can be attached to a console.
 	  It will work fine. However, you can't attach it to the fbdev driver
