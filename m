Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261652AbSIXMK6>; Tue, 24 Sep 2002 08:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261656AbSIXMK6>; Tue, 24 Sep 2002 08:10:58 -0400
Received: from angband.namesys.com ([212.16.7.85]:9357 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261652AbSIXMK5>; Tue, 24 Sep 2002 08:10:57 -0400
Date: Tue, 24 Sep 2002 16:16:10 +0400
From: Oleg Drokin <green@namesys.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: UML kbuild patch
Message-ID: <20020924161610.A31093@namesys.com>
References: <200209240109.UAA05448@ccure.karaya.com> <Pine.LNX.4.44.0209231913060.13892-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209231913060.13892-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Sep 23, 2002 at 07:24:01PM -0500, Kai Germaschewski wrote:
 
> I just thought of another solution, which actually seems cleaner and has 
> less impact on the top-level (generic) Makefile.

On a little bit unrelated note, I found that your changes accepted by Linus
broke UML (the ones entitled as 'kbuild: arch/um cleanup / O_TARGET removal')
build for 2.5.38, so that's what I was forced to do to make it to compile:

===== arch/um/Makefile 1.3 vs edited =====
--- 1.3/arch/um/Makefile	Tue Sep 24 15:37:03 2002
+++ edited/arch/um/Makefile	Tue Sep 24 16:12:46 2002
@@ -30,15 +30,10 @@
 LINK_PROFILE = $(PROFILE) -Wl,--wrap,__monstartup
 endif
 
-ARCH_SUBDIRS = $(ARCH_DIR)/drivers $(ARCH_DIR)/kernel \
-	$(ARCH_DIR)/sys-$(SUBARCH) $(ARCH_DIR)/os-$(OS)
-
-SUBDIRS += $(ARCH_SUBDIRS)
-
 core-y			+= $(ARCH_DIR)/kernel/		 \
-			+= $(ARCH_DIR)/drivers/          \
-			+= $(ARCH_DIR)/sys-$(SUBARCH)/	 \
-			+= $(ARCH_DIR)/os-$(OS)/
+			   $(ARCH_DIR)/drivers/          \
+			   $(ARCH_DIR)/sys-$(SUBARCH)/	 \
+			   $(ARCH_DIR)/os-$(OS)/
 
 libs-$(CONFIG_PT_PROXY)	+= $(ARCH_DIR)/ptproxy/
 
@@ -63,7 +58,9 @@
 	-DELF_ARCH=$(ELF_ARCH) -DELF_FORMAT=\"$(ELF_FORMAT)\"
 
 LD_vmlinux = $(CC) 
-LDFLAGS_vmlinux = $(LINK_PROFILE) $(LINK_WRAPS) -static $(ARCH_DIR)/main.o 
+LDFLAGS_vmlinux = $(LINK_PROFILE) $(LINK_WRAPS) -static $(ARCH_DIR)/main.o -L/usr/lib
+
+LIBS += -lutil
 
 SYMLINK_HEADERS = include/asm-um/archparam.h include/asm-um/system.h \
 	include/asm-um/sigcontext.h include/asm-um/processor.h \
===== arch/um/Makefile-os-Linux 1.1 vs edited =====
--- 1.1/arch/um/Makefile-os-Linux	Fri Sep  6 21:29:28 2002
+++ edited/arch/um/Makefile-os-Linux	Tue Sep 24 15:56:31 2002
@@ -4,4 +4,3 @@
 #
 
 SUBDIRS += $(ARCH_DIR)/os-$(OS)/drivers
-LIBS += $(ARCH_DIR)/os-$(OS)/drivers/drivers.o
===== arch/um/kernel/Makefile 1.2 vs edited =====
--- 1.2/arch/um/kernel/Makefile	Mon Sep 23 03:40:07 2002
+++ edited/arch/um/kernel/Makefile	Tue Sep 24 15:49:48 2002
@@ -10,7 +10,6 @@
 	umid.o user_util.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd_kern.o initrd_user.o
-endif
 
 # user_syms.o not included here because Rules.make has its own ideas about
 # building anything in export-objs
