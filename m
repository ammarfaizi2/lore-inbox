Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTLWRcD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 12:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTLWRcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 12:32:03 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:10911 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S261957AbTLWRbw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 12:31:52 -0500
Date: Tue, 23 Dec 2003 10:31:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-mm1
Message-ID: <20031223173151.GG26574@stop.crashing.org>
References: <20031222211131.70a963fb.akpm@osdl.org> <20031223172907.GF26574@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223172907.GF26574@stop.crashing.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 10:29:07AM -0700, Tom Rini wrote:

> On Mon, Dec 22, 2003 at 09:11:31PM -0800, Andrew Morton wrote:
> 
> [snip]
> > moto-ppc32-booting-fix.patch
> >   Fix booting on a number of Motorola PPC32 machines
> 
> The following, based on comments from Keith Owens is better, please
> replace, thanks:
[snip]
The following patch depends on the above, and fixes the 'znetboot' and
'znetbootrd' targets so that they work again (If you would prefer things
in a different format, please let me know).  Thanks:
- Update the comments to reflect how things work with the correct
  usages now.
- Fix the znetboot / znetbootrd targets.  We now always set end-y,
  and use this to figure out what image will be tftpboot'ed.
===== arch/ppc/boot/simple/Makefile 1.24 vs edited =====
--- 1.24/arch/ppc/boot/simple/Makefile	Tue Dec 23 10:00:06 2003
+++ edited/arch/ppc/boot/simple/Makefile	Tue Dec 23 10:01:04 2003
@@ -4,30 +4,38 @@
 # Author: Tom Rini <trini@mvista.com>
 #
 # Notes:
-# (1) For machine targets which produce more than one image, define
-# ZNETBOOT and ZNETBOOTRD to the image which should be available for
-# 'znetboot' and 'znetboot.initrd`
-# (2) Also, for machine targets which just need to remove the ELF header,
-# define END to be the machine name you want in the image.
-# (3) For machine targets which use the mktree program, define END to be
-# the machine name you want in the image, and you can optionally set
-# ENTRYPOINT which the image should be loaded at.  The optimal setting
-# for ENTRYPOINT is the link address.
+# (1) For machines that do not want to use the ELF image directly (including
+# stripping just the ELF header off), they must set the variables
+# zimage-$(CONFIG_MACHINE) and zimagerd-$(CONFIG_MACHINE) to the target
+# that produces the desired image and they must set end-$(CONFIG_MACHINE)
+# to what will be suffixed to the image filename.
+# (2) Regardless of (1), to have the resulting image be something other
+# than 'zImage.elf', set end-$(CONFIG_MACHINE) to be the suffix used for
+# the zImage, znetboot, and znetbootrd targets.
+# (3) For machine targets which use the mktree program, you can optionally
+# set entrypoint-$(CONFIG_MACHINE) to the location which the image should be
+# loaded at.  The optimal setting for entrypoint-$(CONFIG_MACHINE) is the link
+# address.
 # (4) It is advisable to pass in the memory size using BI_MEMSIZE and
 # get_mem_size(), which is memory controller dependent.  Add in the correct
-# XXX_memory.o file for this to work, as well as editing the $(MISC) file.
-
+# XXX_memory.o file for this to work, as well as editing the
+# misc-$(CONFIG_MACHINE) variable.
 
 boot				:= arch/ppc/boot
 common				:= $(boot)/common
 utils				:= $(boot)/utils
 bootlib				:= $(boot)/lib
 images				:= $(boot)/images
+tftpboot			:= /tftpboot
 
 # Normally, we use the 'misc.c' file for decompress_kernel and
 # whatnot.  Sometimes we need to override this however.
 misc-y	:= misc.o
 
+# Normally, we have our images end in .elf, but something we want to
+# change this.
+end-y := elf
+
 # Additionally, we normally don't need to mess with the L2 / L3 caches
 # if present on 'classic' PPC.
 cacheflag-y	:= -DCLEAR_CACHES=""
@@ -41,35 +49,31 @@
       zimage-$(CONFIG_IBM_OPENBIOS)	:= zImage-TREE
 zimageinitrd-$(CONFIG_IBM_OPENBIOS)	:= zImage.initrd-TREE
          end-$(CONFIG_IBM_OPENBIOS)	:= treeboot
-   tftpimage-$(CONFIG_IBM_OPENBIOS)	:= /tftpboot/zImage.$(end-y)
         misc-$(CONFIG_IBM_OPENBIOS)	:= misc-embedded.o
 
-   tftpimage-$(CONFIG_EMBEDDEDBOOT)	:=  /tftpboot/zImage.embedded
+         end-$(CONFIG_EMBEDDEDBOOT)	:= embedded
         misc-$(CONFIG_EMBEDDEDBOOT)	:= misc-embedded.o
 
       zimage-$(CONFIG_EBONY)		:= zImage-TREE
 zimageinitrd-$(CONFIG_EBONY)		:= zImage.initrd-TREE
          end-$(CONFIG_EBONY)		:= ebony
   entrypoint-$(CONFIG_EBONY)		:= 0x01000000
-   tftpimage-$(CONFIG_EBONY)		:= /tftpboot/zImage.$(end-y)
 
       zimage-$(CONFIG_OCOTEA)		:= zImage-TREE
 zimageinitrd-$(CONFIG_OCOTEA)		:= zImage.initrd-TREE
          end-$(CONFIG_OCOTEA)		:= ocotea
   entrypoint-$(CONFIG_OCOTEA)		:= 0x01000000
-   tftpimage-$(CONFIG_OCOTEA)		:= /tftpboot/zImage.$(end-y)
 
      extra.o-$(CONFIG_EV64260)		:= direct.o misc-ev64260.o
-   tftpimage-$(CONFIG_EV64260)		:= /tftpboot/zImage.ev64260
+         end-$(CONFIG_EV64260)		:= ev64260
    cacheflag-$(CONFIG_EV64260)		:= -include $(clear_L2_L3)
 
       zimage-$(CONFIG_GEMINI)		:= zImage-STRIPELF
 zimageinitrd-$(CONFIG_GEMINI)		:= zImage.initrd-STRIPELF
          end-$(CONFIG_GEMINI)		:= gemini
-   tftpimage-$(CONFIG_GEMINI)		:= /tftpboot/zImage.$(end-y)
 
      extra.o-$(CONFIG_K2)		:= legacy.o
-   tftpimage-$(CONFIG_K2)		:= /tftpboot/zImage.k2
+         end-$(CONFIG_K2)		:= k2
    cacheflag-$(CONFIG_K2)		:= -include $(clear_L2_L3)
 
 # kconfig 'feature', only one of these will ever be 'y' at a time.
@@ -81,9 +85,7 @@
 
       zimage-$(motorola)		:= zImage-PPLUS
 zimageinitrd-$(motorola)		:= zImage.initrd-PPLUS
-   tftpimage-$(motorola)		:= /tftpboot/zImage.pplus
-    znetboot-$(motorola)		:= zImage.pplus
-  znetbootrd-$(motorola)		:= zImage.initrd.pplus
+         end-$(motorola)		:= pplus
 
 # Overrides previous assingment
      extra.o-$(CONFIG_PPLUS)		:= legacy.o
@@ -92,10 +94,9 @@
 zimageinitrd-$(pcore)			:= zImage.initrd-STRIPELF
      extra.o-$(pcore)			:= chrpmap.o
          end-$(pcore)			:= pcore
-   tftpimage-$(pcore)			:= /tftpboot/zImage.$(end-y)
    cacheflag-$(pcore)			:= -include $(clear_L2_L3)
 
-   tftpimage-$(CONFIG_SANDPOINT)	:= /tftpboot/zImage.sandpoint
+         end-$(CONFIG_SANDPOINT)	:= sandpoint
    cacheflag-$(CONFIG_SANDPOINT)	:= -include $(clear_L2_L3)
 
       zimage-$(CONFIG_SPRUCE)		:= zImage-TREE
@@ -103,11 +104,9 @@
          end-$(CONFIG_SPRUCE)		:= spruce
   entrypoint-$(CONFIG_SPRUCE)		:= 0x00800000
         misc-$(CONFIG_SPRUCE)		:= misc-spruce.o
-   tftpimage-$(CONFIG_SPRUCE)		:= /tftpboot/zImage.$(end-y)
-
 
-# tftp image is prefixed with .smp if compiled for SMP
-tftpimage-$(CONFIG_SMP)	+= .smp
+# SMP images should have a '.smp' suffix.
+         end-$(CONFIG_SMP)		+= .smp
 
 # This is a treeboot that needs init functions until the
 # boot rom is sorted out (i.e. this is short lived)
@@ -181,18 +180,10 @@
 	rm -f $(obj)/zvmlinux.initrd
 
 znetboot: zImage
-ifneq ($(ZNETBOOT),)
-	cp $(images)/$(ZNETBOOT) $(tftpimage-y)
-else
-	cp $(images)/zImage.* $(tftpimage-y)
-endif
+	cp $(images)/zImage.$(end-y) $(tftpboot)/zImage.$(end-y)
 
 znetboot.initrd: zImage.initrd
-ifneq ($(znetbootrd-y),)
-	cp $(images)/$(znetbootrd-y) $(tftpimage-y)
-else
-	cp $(images)/zImage.* $(tftpimage-y)
-endif
+	cp $(images)/zImage.initrd.$(end-y) $(tftpboot)/zImage.initrd.$(end-y)
 
 $(images)/zImage-STRIPELF: $(obj)/zvmlinux
 	dd if=$(obj)/zvmlinux of=$(images)/zImage.$(end-y) skip=64 bs=1k

-- 
Tom Rini
http://gate.crashing.org/~trini/
