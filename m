Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268490AbUIGTbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268490AbUIGTbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268503AbUIGT2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:28:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20238 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S268289AbUIGT0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:26:48 -0400
Date: Tue, 7 Sep 2004 21:26:16 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org, geert@linux-m68k.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [patch] 2.6.9-rc1-mm4: atyfb_base.c gcc 2.95 compile error
Message-ID: <20040907192616.GC2454@fs.tum.de>
References: <20040907020831.62390588.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907020831.62390588.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 02:08:31AM -0700, Andrew Morton wrote:
>...
> +fbdev-add-module_init-and-fb_get_options-per-driver.patch
> 
>  fbdev update
>...

gcc 2.95 doesn't support code mixed with variable declarations:

<--  snip  -->

...
  CC      drivers/video/aty/atyfb_base.o
drivers/video/aty/atyfb_base.c: In function `atyfb_init':
drivers/video/aty/atyfb_base.c:1912: parse error before `unsigned'
...
make[3]: *** [drivers/video/aty/atyfb_base.o] Error 1

<--  snip  -->


A possible fix is below.

BTW (not related to this patch):
Why are #ifdef __sparc__ in the #else branch of an #ifdef __sparc__
(e.g. line 2225)???


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.9-rc1-mm4-full/drivers/video/aty/atyfb_base.c.old	2004-09-07 21:11:52.000000000 +0200
+++ linux-2.6.9-rc1-mm4-full/drivers/video/aty/atyfb_base.c	2004-09-07 21:18:01.000000000 +0200
@@ -1900,37 +1900,42 @@
 	printk("fb%d: %s frame buffer device on %s\n",
 	       info->node, info->fix.id, name);
 	return 1;
 }
 
 int __init atyfb_init(void)
 {
-#ifndef MODULE
-	atyfb_setup(fb_get_options("atyfb"));
-#endif
-
 #if defined(CONFIG_PCI)
 	unsigned long addr, res_start, res_size;
 	struct atyfb_par *default_par;
 	struct pci_dev *pdev = NULL;
 	struct fb_info *info;
 	int i;
 #ifdef __sparc__
 	extern void (*prom_palette) (int);
 	extern int con_is_present(void);
 	struct pcidev_cookie *pcp;
 	char prop[128];
 	int node, len, j;
 	u32 mem, chip_id;
+#else
+	u16 tmp;
+#endif
+#endif
 
+#ifndef MODULE
+	atyfb_setup(fb_get_options("atyfb"));
+#endif
+
+#if defined(CONFIG_PCI)
+
+#ifdef __sparc__
 	/* Do not attach when we have a serial console. */
 	if (!con_is_present())
 		return -ENXIO;
-#else
-	u16 tmp;
 #endif
 
 	while ((pdev =
 		pci_find_device(PCI_VENDOR_ID_ATI, PCI_ANY_ID, pdev))) {
 		if ((pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
 			struct resource *rp;
 

