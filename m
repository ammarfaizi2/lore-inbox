Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261510AbSJZUOQ>; Sat, 26 Oct 2002 16:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261511AbSJZUOQ>; Sat, 26 Oct 2002 16:14:16 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:20748 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261510AbSJZUOO>;
	Sat, 26 Oct 2002 16:14:14 -0400
Date: Sat, 26 Oct 2002 22:18:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.44uc1 (MMU-less support)
Message-ID: <20021026201856.GA1670@mars.ravnborg.org>
Mail-Followup-To: Greg Ungerer <gerg@snapgear.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3DBAC09A.4090104@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBAC09A.4090104@snapgear.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 02:19:38AM +1000, Greg Ungerer wrote:
>    - arch Makefiles rewritten
Took a look at them.
See comments below.

	Sam

diff -Naur linux-2.5.44/arch/m68knommu/Makefile linux-2.5.44uc1/arch/m68knommu/Makefile
--- linux-2.5.44/arch/m68knommu/Makefile	Thu Jan  1 10:00:00 1970
+++ linux-2.5.44uc1/arch/m68knommu/Makefile	Sun Oct 27 02:09:09 2002
+PLATFORM = $(platform-y)

Use := no late evaluation required.
+MODEL = $(model-y)
See above.

+cpuclass-$(CONFIG_M68VZ328)	:= 68328
+CPUCLASS = $(cpuclass-y)
+CLASSDIR = arch/m68knommu/platform/$(cpuclass-y)/
ditto

+CLEAN_FILES += include/asm-$(ARCH)/asm-offsets.h.tmp \
+	       include/asm-$(ARCH)/asm-offsets.h \
+	       arch/$(ARCH)/kernel/asm-offsets.s
Use the new clean infrastrucute.
clean-files := include/asm-$(ARCH)/asm-offsets.h.tmp \
               include/asm-$(ARCH)/asm-offsets.h \
               arch/$(ARCH)/kernel/asm-offsets.s

+prepare: include/asm-$(ARCH)/asm-offsets.h

+archclean:
Add a call to clean boot - something like
	$(call descend arch/$(ARCH)/boot, subdirclean)

+
+arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
+				   include/config/MARKER
+
+include/asm-$(ARCH)/asm-offsets.h.tmp: arch/$(ARCH)/kernel/asm-offsets.s
+	@$(generate-asm-offsets.h) < $< > $@
+
+include/asm-$(ARCH)/asm-offsets.h: include/asm-$(ARCH)/asm-offsets.h.tmp
+	@echo -n '  Generating $@'
+	@$(update-if-changed)
Combine it like this instead:
include/asm-$(ARCH)/asm-offsets.h: arch/$(ARCH)/kernel/asm-offsets.s \
				   include/asm include/linux/version.h \
				   include/config/MARKER
	@echo -n '  Generating $@'
	@$(generate-asm-offsets.h) < $< > $@
	@$(update-if-changed)

Thats more readable, and follow te normal way of doing it.

diff -Naur linux-2.5.44/arch/m68knommu/boot/Makefile linux-2.5.44uc1/arch/m68knommu/boot/Makefile
--- linux-2.5.44/arch/m68knommu/boot/Makefile	Thu Jan  1 10:00:00 1970
+++ linux-2.5.44uc1/arch/m68knommu/boot/Makefile	Sun Oct 27 02:09:08 2002
@@ -0,0 +1,5 @@
+clean:
+	rm -f *.[oa]
+
+dep depend:
+	:
The above can safely be deleted.

General comment.
Use
EXTRA_TARGET :=
in replacement for
EXTRA_TARGETS =
Thas is required in many platform specific makefiles
diff -Naur linux-2.5.44/arch/m68knommu/platform/68328/Makefile linux-2.5.44uc1/arch/m68knommu/platform/68328/Makefile
+
+arch/m68knommu/platform/68328/$(BOARD)/bootlogo.rh: arch/m68knommu/platform/68328/bootlogo.h
+	perl arch/m68knommu/platform/68328/bootlogo.pl \
+		< arch/m68knommu/platform/68328/bootlogo.h \
+		> arch/m68knommu/platform/68328/$(BOARD)/bootlogo.rh
The following is more readable:
$obj)/$(BOARD)/bootlogo.rh: $(src)/bootlogo.h
	$(PERL) $(src)/bootlogo.pl < $(src)/bootlogo.h 
				   > $(obj)/$(BOARD)/bootlogo.rh
diff -Naur linux-2.5.44/arch/m68knommu/platform/68EZ328/Makefile linux-2.5.44uc1/arch/m68knommu/platform/68EZ328/Makefile
+
$(obj)/$(BOARD)/bootlogo.rh: $(src)/bootlogo.h
	$(PERL) $(src)/bootlogo.pl < $(src)/bootlogo.h \
				   > $(obj)/$(BOARD)/bootlogo.rh

The same changes a listed above.
diff -Naur linux-2.5.44/arch/m68knommu/platform/68VZ328/Makefile linux-2.5.44uc1/arch/m68knommu/platform/68VZ328/Makefile
+arch/m68knommu/platform/68VZ328/$(BOARD)/bootlogo.rh: arch/m68knommu/platform/68EZ328/bootlogo.h
+	perl arch/m68knommu/platform/68328/bootlogo.pl \
+		< arch/m68knommu/platform/68EZ328/bootlogo.h \
+		> arch/m68knommu/platform/68VZ328/$(BOARD)/bootlogo.rh
Again - use $(obj) - $(src)

diff -Naur linux-2.5.44/arch/m68knommu/platform/Makefile linux-2.5.44uc1/arch/m68knommu/platform/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for the arch/m68knommu/platform.
+#
+
+include $(TOPDIR)/Rules.make
+
This makefile looks not at all usefull for me.

