Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTIGFvt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 01:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263331AbTIGFvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 01:51:49 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:13829 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263330AbTIGFvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 01:51:46 -0400
Date: Sun, 7 Sep 2003 07:51:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, jsimmons@infradead.org,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6: spurious recompiles
Message-ID: <20030907055144.GA1627@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	"Randy.Dunlap" <rddunlap@osdl.org>, jsimmons@infradead.org,
	"Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
References: <20030906201417.GI14436@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030906201417.GI14436@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 06, 2003 at 10:14:18PM +0200, Adrian Bunk wrote:
> 2. pnmtologo
> The following happens again once, but not when doing a third "make":
>   ./scripts/pnmtologo -t mono -n logo_linux_mono -o drivers/video/logo/logo_linux_mono.c drivers/video/logo/logo_linux_mono.pbm

Would you mind to give this patch a spin. Only lightly tested here.

===== drivers/video/aty/Makefile 1.10 vs edited =====
--- 1.10/drivers/video/aty/Makefile	Thu May  1 18:32:15 2003
+++ edited/drivers/video/aty/Makefile	Sun Sep  7 07:45:54 2003
@@ -4,4 +4,3 @@
 atyfb-y				:= atyfb_base.o mach64_accel.o
 atyfb-$(CONFIG_FB_ATY_GX)	+= mach64_gx.o
 atyfb-$(CONFIG_FB_ATY_CT)	+= mach64_ct.o mach64_cursor.o
-atyfb-objs			:= $(atyfb-y)
===== drivers/video/console/Makefile 1.15 vs edited =====
--- 1.15/drivers/video/console/Makefile	Mon Feb  3 23:19:38 2003
+++ edited/drivers/video/console/Makefile	Sun Sep  7 07:45:55 2003
@@ -3,18 +3,16 @@
 # Rewritten to use lists instead of if-statements.
 
 # Font handling
-font-objs := fonts.o
+font-y := fonts.o
 
-font-objs-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
-font-objs-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
-font-objs-$(CONFIG_FONT_8x8)       += font_8x8.o
-font-objs-$(CONFIG_FONT_8x16)      += font_8x16.o
-font-objs-$(CONFIG_FONT_6x11)      += font_6x11.o
-font-objs-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
-font-objs-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
-font-objs-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
-
-font-objs += $(font-objs-y)
+font-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
+font-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
+font-$(CONFIG_FONT_8x8)       += font_8x8.o
+font-$(CONFIG_FONT_8x16)      += font_8x16.o
+font-$(CONFIG_FONT_6x11)      += font_6x11.o
+font-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
+font-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
+font-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
 
 # Each configuration option enables a list of files.
 
@@ -31,8 +29,11 @@
 # Files generated that shall be removed upon make clean
 clean-files := promcon_tbl.c
 
-$(obj)/promcon_tbl.c: $(src)/prom.uni
-	$(objtree)/scripts/conmakehash $< | \
+
+quiet_cmd_promtbl = GEN     $@
+      cmd_promtbl = scripts/conmakehash $< | \
 	sed -e '/#include <[^>]*>/p' -e 's/types/init/' \
 	    -e 's/dfont\(_uni.*\]\)/promfont\1 __initdata/' > $@
 
+$(obj)/promcon_tbl.c: $(src)/prom.uni
+	$(call cmd,promtbl)
===== drivers/video/i810/Makefile 1.2 vs edited =====
--- 1.2/drivers/video/i810/Makefile	Wed Jan  1 14:00:16 2003
+++ edited/drivers/video/i810/Makefile	Sun Sep  7 07:45:56 2003
@@ -1,15 +1,8 @@
 #
 # Makefile for the Intel 810/815 framebuffer driver
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
-# Note 2! The CFLAGS definitions are now in the main makefile...
-
 
 obj-$(CONFIG_FB_I810)		+= i810fb.o
-
 
 i810fb-objs                     := i810_main.o i810_accel.o
 
===== drivers/video/logo/Makefile 1.3 vs edited =====
--- 1.3/drivers/video/logo/Makefile	Mon Jul 21 23:30:38 2003
+++ edited/drivers/video/logo/Makefile	Sun Sep  7 07:47:00 2003
@@ -25,18 +25,23 @@
 
 # How to generate them
 
+# Create commands like "pnmtologo -t mono -n logo_mac_mono -o ..."
+quiet_cmd_logo = LOGO    $@
+      cmd_logo = scripts/pnmtologo \
+		 -t $(patsubst $*_%,%,$(notdir $(basename $<))) \
+		 -n $(notdir $(basename $<)) -o $@ $<
+
 $(obj)/%_mono.c:	$(src)/%_mono.pbm
-		$(objtree)/scripts/pnmtologo -t mono -n $*_mono -o $@ $<
+	$(call cmd,logo)
 
 $(obj)/%_vga16.c:	$(src)/%_vga16.ppm
-		$(objtree)/scripts/pnmtologo -t vga16 -n $*_vga16 -o $@ $<
+	$(call cmd,logo)
 
 $(obj)/%_clut224.c:	$(src)/%_clut224.ppm
-		$(objtree)/scripts/pnmtologo -t clut224 -n $*_clut224 -o $@ $<
+	$(call cmd,logo)
 
 $(obj)/%_gray256.c:	$(src)/%_gray256.pgm
-		$(objtree)/scripts/pnmtologo -t gray256 -n $*_gray256 -o $@ $<
-
+	$(call cmd,logo)
 
 # Files generated that shall be removed upon make clean
 clean-files := *_mono.c *_vga16.c *_clut224.c *_gray256.c
