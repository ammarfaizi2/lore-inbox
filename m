Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131507AbRAAFaC>; Mon, 1 Jan 2001 00:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131536AbRAAF3w>; Mon, 1 Jan 2001 00:29:52 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:52240 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131507AbRAAF3m>;
	Mon, 1 Jan 2001 00:29:42 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: J Sloan <jjs@pobox.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, dri-devel@lists.sourceforge.net,
        torvalds@transmeta.com
Subject: [patch] 2.4.0-prerelease drm and modversions
In-Reply-To: Your message of "Sun, 31 Dec 2000 14:38:16 -0800."
             <3A4FB558.688EFE01@pobox.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Jan 2001 15:59:08 +1100
Message-ID: <3866.978325148@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2000 14:38:16 -0800, 
J Sloan <jjs@pobox.com> wrote:
>Looks good here in most respects, but still needs makefile fixes -
>
># modprobe tdfx
>/lib/modules/2.4.0-prerelease/kernel/drivers/char/drm/tdfx.o: unresolved
>symbol remap_page_range
>.... etc, etc
>
>Of course, adding
>
>#include <linux/modversions.h>
>
>to drivers/char/drm/drmP.h makes it all work....

Wrong fix.

drivers/char/drm/Makefile is breaking the Makefile rules.  It builds
drmlib.a and expects to link that library into both the kernel and into
modules.  The kernel makefile system assumes that everything is either
kernel or module, not both.  The components in drmlib.a get compiled
for kernel only, when used in a module they are missing the symbol
versions.

The ability to link into both kernel and modules will be available in
the 2.5 Makefile redesign (already in progress) but this bandaid will
fix 2.4.  It is still fragile, if you change a drm driver from module
to built in or vice versa then you have to manually remove the old drm
driver first, but few people will do that (I hope).

The bandaid is to generate two copies of drmlib from the same C
sources, one for kernel and one for modules.

Index: 0-prerelease.1/drivers/char/drm/Makefile
--- 0-prerelease.1/drivers/char/drm/Makefile Sat, 16 Dec 2000 15:22:55 +1100 kaos (linux-2.4/I/b/2_Makefile 1.1.1.6 644)
+++ 0-prerelease.1(w)/drivers/char/drm/Makefile Mon, 01 Jan 2001 15:56:48 +1100 kaos (linux-2.4/I/b/2_Makefile 1.1.1.6 644)
@@ -55,13 +55,23 @@ obj-$(CONFIG_DRM_I810)  += i810.o
 # When linking into the kernel, link the library just once. 
 # If making modules, we include the library into each module
 
+lib-objs-mod := $(patsubst %.o,%-mod.o,$(lib-objs))
+obj-m += $(lib-objs-mod)
+
 ifdef MAKING_MODULES
-  lib = drmlib.a
+  lib = drmlib-mod.a
 else
   obj-y += drmlib.a
 endif
 
 include $(TOPDIR)/Rules.make
+
+$(patsubst %.o,%.c,$(lib-objs-mod)): 
+	@ln -sf $(subst -mod,,$@) $@
+
+drmlib-mod.a: $(lib-objs-mod)
+	rm -f $@
+	$(AR) $(EXTRA_ARFLAGS) rcs $@ $(lib-objs-mod)
 
 drmlib.a: $(lib-objs)
 	rm -f $@
Index: 0-prerelease.1/Makefile
--- 0-prerelease.1/Makefile Mon, 01 Jan 2001 14:23:43 +1100 kaos (linux-2.4/B/c/27_Makefile 1.1.2.2.2.4.1.7.1.3.1.5.2.5.2.2.1.6.1.10 644)
+++ 0-prerelease.1(w)/Makefile Mon, 01 Jan 2001 15:47:10 +1100 kaos (linux-2.4/B/c/27_Makefile 1.1.2.2.2.4.1.7.1.3.1.5.2.5.2.2.1.6.1.10 644)
@@ -188,6 +188,7 @@ CLEAN_FILES = \
 	.tmp* \
 	drivers/char/consolemap_deftbl.c drivers/video/promcon_tbl.c \
 	drivers/char/conmakehash \
+	drivers/char/drm/*-mod.c \
 	drivers/pci/devlist.h drivers/pci/classlist.h drivers/pci/gen-devlist \
 	drivers/zorro/devlist.h drivers/zorro/gen-devlist \
 	drivers/sound/bin2hex drivers/sound/hex2hex \

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
