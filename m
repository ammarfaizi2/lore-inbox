Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262204AbSIZGa6>; Thu, 26 Sep 2002 02:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262205AbSIZGa6>; Thu, 26 Sep 2002 02:30:58 -0400
Received: from angband.namesys.com ([212.16.7.85]:41859 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S262204AbSIZGaz>; Thu, 26 Sep 2002 02:30:55 -0400
Date: Thu, 26 Sep 2002 10:36:11 +0400
From: Oleg Drokin <green@namesys.com>
To: adam@skullslayer.rod.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: UML compile error
Message-ID: <20020926103611.A5474@namesys.com>
References: <20020925105604.2777.qmail@unibar>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020925105604.2777.qmail@unibar>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Sep 25, 2002 at 08:56:04PM +1000, adam@skullslayer.rod.org wrote:
> I tried to test UML, and tried 2.5.36 through to 38, but have been
> unable to comile it. I tried using the default config, as well as
> my own config, but both 37 and 38 give the following error.
>   gcc -Wp,-MD,./.sched.o.d -D__KERNEL__ -I/usr/src/linux-2.5.38/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2  -fno-strict-aliasing -fno-common -g  -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE -I/usr/src/linux-2.5.38/arch/um/include -Derrno=kernel_errno -nostdinc -iwithprefix include    -fno-omit-frame-pointer -DKBUILD_BASENAME=sched   -c -o sched.o sched.c
> In file included from /usr/src/linux-2.5.38/include/asm/irq.h:9,
>                  from /usr/src/linux-2.5.38/include/linux/nmi.h:7,
>                  from sched.c:20:
> /usr/src/linux-2.5.38/include/asm/arch/irq.h:16:25: irq_vectors.h: No such file or directory
> make[1]: *** [sched.o] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.5.38/kernel'
> make: *** [kernel] Error 2

You need to apply a uml-patch-2.5.38-1.bz2 available from somewhere at
http://user-mode-linux.sf.net

Also you need below patch to fix makefiles.

Bye,
    Oleg

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
