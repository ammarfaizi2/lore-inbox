Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTGASfW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTGASek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:34:40 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:46474 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263310AbTGASdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:33:11 -0400
Date: Tue, 1 Jul 2003 20:46:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (4/6): processor type.
Message-ID: <20030701184627.GE12212@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add configuration option to select the different processor types. Add new
path group algorith and new relocation types introduces with z990.

diffstat:
 arch/s390/Kconfig             |   32 ++++++++++++++++++++++++++++++--
 arch/s390/Makefile            |   13 ++++++++++++-
 arch/s390/defconfig           |    3 +++
 arch/s390/kernel/Makefile     |    5 -----
 arch/s390/kernel/head.S       |    4 ++++
 arch/s390/kernel/head64.S     |    4 ++++
 arch/s390/kernel/module.c     |   22 ++++++++++++++++++----
 drivers/s390/cio/requestirq.c |   10 +++++++---
 include/asm-s390/elf.h        |    7 ++++++-
 include/asm-s390/setup.h      |    1 +
 10 files changed, 85 insertions(+), 16 deletions(-)

diff -urN linux-2.5/arch/s390/Kconfig linux-2.5-s390/arch/s390/Kconfig
--- linux-2.5/arch/s390/Kconfig	Tue Jul  1 20:48:08 2003
+++ linux-2.5-s390/arch/s390/Kconfig	Tue Jul  1 20:48:27 2003
@@ -45,6 +45,34 @@
 	depends on ARCH_S390X = 'n'
 	default y
 
+choice 
+	prompt "Processor type"
+	default MARCH_G5
+
+config MARCH_G5
+	bool "S/390 model G5 and G6"
+	depends on ARCH_S390_31
+	help
+	  Select this to build a 31 bit kernel that works
+	  on all S/390 and zSeries machines.
+
+config MARCH_Z900
+	bool "IBM eServer zSeries model z800 and z900"
+	help
+	  Select this to optimize for zSeries machines. This
+	  will enable some optimizations that are not available
+	  on older 31 bit only CPUs.
+
+config MARCH_Z990
+	bool "IBM eServer zSeries model z990"
+	help
+	  Select this enable optimizations for model z990.
+	  This will be slightly faster but does not work on
+	  older machines such as the z900.
+
+endchoice 
+
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
@@ -90,7 +118,7 @@
 
 config MATHEMU
 	bool "IEEE FPU emulation"
-	depends on ARCH_S390X = n
+	depends on MARCH_G5
 	help
 	  This option is required for IEEE compliant floating point arithmetic
 	  on older S/390 machines. Say Y unless you know your machine doesn't 
@@ -130,7 +158,7 @@
 	tristate "QDIO support"
 	---help---
 	  This driver provides the Queued Direct I/O base support for the
-	  IBM S/390 (G5 and G6) and eServer zSeries (z800 and z900).
+	  IBM S/390 (G5 and G6) and eServer zSeries (z800, z900 and z990).
 
 	  For details please refer to the documentation provided by IBM at
 	  <http://www10.software.ibm.com/developerworks/opensource/linux390>
diff -urN linux-2.5/arch/s390/Makefile linux-2.5-s390/arch/s390/Makefile
--- linux-2.5/arch/s390/Makefile	Sun Jun 22 20:32:35 2003
+++ linux-2.5-s390/arch/s390/Makefile	Tue Jul  1 20:48:27 2003
@@ -13,10 +13,13 @@
 # Copyright (C) 1994 by Linus Torvalds
 #
 
+check_gcc = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+
 ifdef CONFIG_ARCH_S390_31
 LDFLAGS		:= -m elf_s390
 LDFLAGS_BLOB	:= --format binary --oformat elf32-s390
 CFLAGS		+= -m31
+AFLAGS		+= -m31
 UTS_MACHINE	:= s390
 endif
 
@@ -25,12 +28,20 @@
 MODFLAGS	+= -fpic -D__PIC__
 LDFLAGS_BLOB	:= --format binary --oformat elf64-s390
 CFLAGS		+= -m64
+AFLAGS		+= -m64
 UTS_MACHINE	:= s390x
 endif
 
+cflags-$(CONFIG_MARCH_G5)   += $(call check_gcc,-march=g5,)
+cflags-$(CONFIG_MARCH_Z900) += $(call check_gcc,-march=z900,)
+cflags-$(CONFIG_MARCH_Z990) += $(call check_gcc,-march=trex,)
+
+CFLAGS		+= $(cflags-y)
+CFLAGS		+= $(call check_gcc,-finline-limit=10000,)
+CFLAGS 		+= -pipe -fno-strength-reduce -Wno-sign-compare 
+
 OBJCOPYFLAGS	:= -O binary
 LDFLAGS_vmlinux := -e start
-CFLAGS 		+= -pipe -fno-strength-reduce -finline-limit-10000 -Wno-sign-compare 
 
 head-$(CONFIG_ARCH_S390_31)	+= arch/$(ARCH)/kernel/head.o
 head-$(CONFIG_ARCH_S390X)	+= arch/$(ARCH)/kernel/head64.o
diff -urN linux-2.5/arch/s390/defconfig linux-2.5-s390/arch/s390/defconfig
--- linux-2.5/arch/s390/defconfig	Tue Jul  1 20:48:08 2003
+++ linux-2.5-s390/arch/s390/defconfig	Tue Jul  1 20:48:27 2003
@@ -41,6 +41,9 @@
 #
 # CONFIG_ARCH_S390X is not set
 CONFIG_ARCH_S390_31=y
+CONFIG_MARCH_G5=y
+# CONFIG_MARCH_Z900 is not set
+# CONFIG_MARCH_Z990 is not set
 CONFIG_SMP=y
 CONFIG_NR_CPUS=32
 CONFIG_MATHEMU=y
diff -urN linux-2.5/arch/s390/kernel/Makefile linux-2.5-s390/arch/s390/kernel/Makefile
--- linux-2.5/arch/s390/kernel/Makefile	Sun Jun 22 20:33:32 2003
+++ linux-2.5-s390/arch/s390/kernel/Makefile	Tue Jul  1 20:48:27 2003
@@ -23,11 +23,6 @@
 obj-$(CONFIG_ARCH_S390_31)	+= entry.o reipl.o
 obj-$(CONFIG_ARCH_S390X)	+= entry64.o reipl64.o
 
-ifdef CONFIG_ARCH_S390X
-$(obj)%.o: $(patsubst arch/s390/%,arch/s390x/%,$(src))%.c
-	$(call if_changed_dep,cc_o_c)
-endif
-
 #
 # This is just to get the dependencies...
 #
diff -urN linux-2.5/arch/s390/kernel/head.S linux-2.5-s390/arch/s390/kernel/head.S
--- linux-2.5/arch/s390/kernel/head.S	Sun Jun 22 20:32:38 2003
+++ linux-2.5-s390/arch/s390/kernel/head.S	Tue Jul  1 20:48:27 2003
@@ -533,6 +533,10 @@
         bne    .Lnop390-.LPG1(%r13)
         oi     3(%r12),4                # set P/390 flag
 .Lnop390:
+	chi    %r0,0x2084		# new stidp format?
+	bne    .Loldfmt-.LPG1(%r13)
+	oi     3(%r12),64		# set new stidp flag
+.Loldfmt:	
 
 #
 # find out if we have an IEEE fpu
diff -urN linux-2.5/arch/s390/kernel/head64.S linux-2.5-s390/arch/s390/kernel/head64.S
--- linux-2.5/arch/s390/kernel/head64.S	Sun Jun 22 20:32:39 2003
+++ linux-2.5-s390/arch/s390/kernel/head64.S	Tue Jul  1 20:48:27 2003
@@ -553,6 +553,10 @@
         bne    1f-.LPG1(%r13)
         oi     7(%r12),4                # set P/390 flag
 1:
+	chi    %r0,0x2084		# new stidp format?
+	bne    2f-.LPG1(%r13)
+	oi     7(%r12),64		# set new stidp flag
+2:	
 
 #
 # find out if we have the MVPG instruction
diff -urN linux-2.5/arch/s390/kernel/module.c linux-2.5-s390/arch/s390/kernel/module.c
--- linux-2.5/arch/s390/kernel/module.c	Sun Jun 22 20:33:16 2003
+++ linux-2.5-s390/arch/s390/kernel/module.c	Tue Jul  1 20:48:27 2003
@@ -67,12 +67,14 @@
 	switch (ELF_R_TYPE (rela->r_info)) {
 	case R_390_GOT12:	/* 12 bit GOT offset.  */
 	case R_390_GOT16:	/* 16 bit GOT offset.  */
+	case R_390_GOT20:	/* 20 bit GOT offset.  */
 	case R_390_GOT32:	/* 32 bit GOT offset.  */
 	case R_390_GOT64:	/* 64 bit GOT offset.  */
 	case R_390_GOTENT:	/* 32 bit PC rel. to GOT entry shifted by 1. */
 	case R_390_GOTPLT12:	/* 12 bit offset to jump slot.	*/
-	case R_390_GOTPLT16:	/* 16 bit offset to jump slot. */
-	case R_390_GOTPLT32:	/* 32 bit offset to jump slot. */
+	case R_390_GOTPLT16:	/* 16 bit offset to jump slot.  */
+	case R_390_GOTPLT20:	/* 20 bit offset to jump slot.  */
+	case R_390_GOTPLT32:	/* 32 bit offset to jump slot.  */
 	case R_390_GOTPLT64:	/* 64 bit offset to jump slot.	*/
 	case R_390_GOTPLTENT:	/* 32 bit rel. offset to jump slot >> 1. */
 		if (info->got_offset == -1UL) {
@@ -201,6 +203,7 @@
 	case R_390_8:		/* Direct 8 bit.   */
 	case R_390_12:		/* Direct 12 bit.  */
 	case R_390_16:		/* Direct 16 bit.  */
+	case R_390_20:		/* Direct 20 bit.  */
 	case R_390_32:		/* Direct 32 bit.  */
 	case R_390_64:		/* Direct 64 bit.  */
 		val += rela->r_addend;
@@ -211,6 +214,10 @@
 				(*(unsigned short *) loc & 0xf000);
 		else if (r_type == R_390_16)
 			*(unsigned short *) loc = val;
+		else if (r_type == R_390_20)
+			*(unsigned int *) loc =
+				(*(unsigned int *) loc & 0xf00000ff) |
+				(val & 0xfff) << 16 | (val & 0xff000) >> 4;
 		else if (r_type == R_390_32)
 			*(unsigned int *) loc = val;
 		else if (r_type == R_390_64)
@@ -235,12 +242,14 @@
 		break;
 	case R_390_GOT12:	/* 12 bit GOT offset.  */
 	case R_390_GOT16:	/* 16 bit GOT offset.  */
+	case R_390_GOT20:	/* 20 bit GOT offset.  */
 	case R_390_GOT32:	/* 32 bit GOT offset.  */
 	case R_390_GOT64:	/* 64 bit GOT offset.  */
 	case R_390_GOTENT:	/* 32 bit PC rel. to GOT entry shifted by 1. */
 	case R_390_GOTPLT12:	/* 12 bit offset to jump slot.	*/
-	case R_390_GOTPLT16:	/* 16 bit offset to jump slot. */
-	case R_390_GOTPLT32:	/* 32 bit offset to jump slot. */
+	case R_390_GOTPLT20:	/* 20 bit offset to jump slot.  */
+	case R_390_GOTPLT16:	/* 16 bit offset to jump slot.  */
+	case R_390_GOTPLT32:	/* 32 bit offset to jump slot.  */
 	case R_390_GOTPLT64:	/* 64 bit offset to jump slot.	*/
 	case R_390_GOTPLTENT:	/* 32 bit rel. offset to jump slot >> 1. */
 		if (info->got_initialized == 0) {
@@ -259,6 +268,11 @@
 		else if (r_type == R_390_GOT16 ||
 			 r_type == R_390_GOTPLT16)
 			*(unsigned short *) loc = val;
+		else if (r_type == R_390_GOT20 ||
+			 r_type == R_390_GOTPLT20)
+			*(unsigned int *) loc =
+				(*(unsigned int *) loc & 0xf00000ff) |
+				(val & 0xfff) << 16 | (val & 0xff000) >> 4;
 		else if (r_type == R_390_GOT32 ||
 			 r_type == R_390_GOTPLT32)
 			*(unsigned int *) loc = val;
diff -urN linux-2.5/drivers/s390/cio/requestirq.c linux-2.5-s390/drivers/s390/cio/requestirq.c
--- linux-2.5/drivers/s390/cio/requestirq.c	Sun Jun 22 20:33:00 2003
+++ linux-2.5-s390/drivers/s390/cio/requestirq.c	Tue Jul  1 20:48:27 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/requestirq.c
  *   S/390 common I/O routines -- enabling and disabling of devices
- *   $Revision: 1.44 $
+ *   $Revision: 1.45 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -45,11 +45,15 @@
 	/*
 	 * Let's build our path group ID here.
 	 */
+	if (MACHINE_NEW_STIDP)
+		global_pgid.cpu_addr = 0x8000;
+	else {
 #ifdef CONFIG_SMP
-	global_pgid.cpu_addr = hard_smp_processor_id();
+		global_pgid.cpu_addr = hard_smp_processor_id();
 #else
-	global_pgid.cpu_addr = 0;
+		global_pgid.cpu_addr = 0;
 #endif
+	}
 	global_pgid.cpu_id = ((cpuid_t *) __LC_CPUID)->ident;
 	global_pgid.cpu_model = ((cpuid_t *) __LC_CPUID)->machine;
 	global_pgid.tod_high = (__u32) (get_clock() >> 32);
diff -urN linux-2.5/include/asm-s390/elf.h linux-2.5-s390/include/asm-s390/elf.h
--- linux-2.5/include/asm-s390/elf.h	Sun Jun 22 20:33:16 2003
+++ linux-2.5-s390/include/asm-s390/elf.h	Tue Jul  1 20:48:27 2003
@@ -84,8 +84,13 @@
 #define R_390_TLS_DTPOFF	55	/* Offset in TLS block.  */
 #define R_390_TLS_TPOFF		56	/* Negate offset in static TLS
                                            block.  */
+#define R_390_20		57	/* Direct 20 bit.  */
+#define R_390_GOT20		58	/* 20 bit GOT offset.  */
+#define R_390_GOTPLT20		59	/* 20 bit offset to jump slot.  */
+#define R_390_TLS_GOTIE20	60	/* 20 bit GOT offset for static TLS
+					   block offset.  */
 /* Keep this the last entry.  */
-#define R_390_NUM	57
+#define R_390_NUM	61
 
 /*
  * ELF register definitions..
diff -urN linux-2.5/include/asm-s390/setup.h linux-2.5-s390/include/asm-s390/setup.h
--- linux-2.5/include/asm-s390/setup.h	Sun Jun 22 20:33:16 2003
+++ linux-2.5-s390/include/asm-s390/setup.h	Tue Jul  1 20:48:27 2003
@@ -35,6 +35,7 @@
 #define MACHINE_IS_P390		(machine_flags & 4)
 #define MACHINE_HAS_MVPG	(machine_flags & 16)
 #define MACHINE_HAS_DIAG44	(machine_flags & 32)
+#define MACHINE_NEW_STIDP	(machine_flags & 64)
 
 #ifndef __s390x__
 #define MACHINE_HAS_IEEE	(machine_flags & 2)
