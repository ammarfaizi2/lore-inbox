Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268045AbUHaMEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268045AbUHaMEZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 08:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268055AbUHaMEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 08:04:25 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:61903 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268045AbUHaMET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 08:04:19 -0400
Date: Tue, 31 Aug 2004 14:04:14 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Paolo Ornati <ornati@fastwebnet.it>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1-mm2: tdfxfb_lib causes compile error
Message-ID: <20040831120414.GD3466@fs.tum.de>
References: <20040830235426.441f5b51.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830235426.441f5b51.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 11:54:26PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.9-rc1-mm1:
>...
> +tdfx-linkage-fix.patch
> 
>  fbdev driver fix
>...

This might result in object files being included twice both directly and 
via tdfxfb_lib, resulting in compile errors like the following:

<--  snip  -->

...
  LD      drivers/video/built-in.o
drivers/video/tdfxfb_lib.o(.text+0x0): In function `cfb_imageblit':
: multiple definition of `cfb_imageblit'
drivers/video/cfbimgblt.o(.text+0x0): first defined here
make[2]: *** [drivers/video/built-in.o] Error 1

<--  snip  -->


Please replace tdfx-linkage-fix.patch with the following patch:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.9-rc1-mm1-full/drivers/video/Makefile.old	2004-08-28 10:41:30.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/video/Makefile	2004-08-28 10:46:20.000000000 +0200
@@ -35,6 +35,9 @@
 obj-$(CONFIG_FB_GBE)              += gbefb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_SGIVW)            += sgivwfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_3DFX)             += tdfxfb.o cfbimgblt.o
+ifneq ($(CONFIG_FB_3DFX_ACCEL),y)
+  obj-$(CONFIG_FB_3DFX)           += cfbfillrect.o cfbcopyarea.o
+endif
 obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_HP300)            += hpfb.o cfbfillrect.o cfbimgblt.o
 obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o

