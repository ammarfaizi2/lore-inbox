Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270540AbTGSVJT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 17:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270541AbTGSVJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 17:09:18 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:30480 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S270540AbTGSVJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 17:09:10 -0400
Date: Sat, 19 Jul 2003 23:24:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] usr/: Updated .incbin support
Message-ID: <20030719212406.GA12993@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please apply.

Update support for .incbin in /usr. No longer generate .S files
from within the Makefile.
Also deleted the assignment to LDFLAGS_BLOB for most architectures.
Only ARM and cris i di not touch.
arm: Russell told me they did not have a new as that could be used
cris: Lokked like it was used for more than just usr/

	Sam

 arch/alpha/Makefile     |    1 -
 arch/h8300/Makefile     |    1 -
 arch/i386/Makefile      |    1 -
 arch/m68k/Makefile      |    1 -
 arch/m68knommu/Makefile |    2 --
 arch/mips/Makefile      |    2 --
 arch/parisc/Makefile    |    2 --
 arch/ppc/Makefile       |    1 -
 arch/ppc64/Makefile     |    1 -
 arch/s390/Makefile      |    2 --
 arch/sh/Makefile        |    2 --
 arch/sparc/Makefile     |    2 --
 arch/sparc64/Makefile   |    1 -
 arch/v850/Makefile      |    1 -
 arch/x86_64/Makefile    |    1 -
 usr/Makefile            |    9 +++++----
 usr/initramfs_data.S    |   30 ++++++++++++++++++++++++++++++
 17 files changed, 35 insertions(+), 25 deletions(-)

diff -Nru a/arch/alpha/Makefile b/arch/alpha/Makefile
--- a/arch/alpha/Makefile	Sat Jul 19 23:19:24 2003
+++ b/arch/alpha/Makefile	Sat Jul 19 23:19:24 2003
@@ -11,7 +11,6 @@
 NM := $(NM) -B
 
 LDFLAGS_vmlinux	:= -static -N #-relax
-LDFLAGS_BLOB	:= --format binary --oformat elf64-alpha
 cflags-y	:= -pipe -mno-fp-regs -ffixed-8
 
 # Determine if we can use the BWX instructions with GAS.
diff -Nru a/arch/h8300/Makefile b/arch/h8300/Makefile
--- a/arch/h8300/Makefile	Sat Jul 19 23:19:24 2003
+++ b/arch/h8300/Makefile	Sat Jul 19 23:19:24 2003
@@ -34,7 +34,6 @@
 CFLAGS += -DUTS_SYSNAME=\"uClinux\" -DTARGET=$(BOARD)
 AFLAGS += -DPLATFORM=$(PLATFORM) -DTARGET=$(BOARD) -DMODEL=$(MODEL) $(cflags-y)
 LDFLAGS += $(ldflags-y)
-LDFLAGS_BLOB :=  --format binary --oformat elf32-h8300
 
 CROSS_COMPILE = h8300-elf-
 #HEAD := arch/$(ARCH)/platform/$(platform-y)/$(board-y)/crt0_$(model-y).o
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Sat Jul 19 23:19:24 2003
+++ b/arch/i386/Makefile	Sat Jul 19 23:19:24 2003
@@ -18,7 +18,6 @@
 LDFLAGS		:= -m elf_i386
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
 LDFLAGS_vmlinux :=
-LDFLAGS_BLOB	:= --format binary --oformat elf32-i386
 
 CFLAGS += -pipe
 
diff -Nru a/arch/m68k/Makefile b/arch/m68k/Makefile
--- a/arch/m68k/Makefile	Sat Jul 19 23:19:24 2003
+++ b/arch/m68k/Makefile	Sat Jul 19 23:19:24 2003
@@ -19,7 +19,6 @@
 # override top level makefile
 AS += -m68020
 LDFLAGS := -m m68kelf
-LDFLAGS_BLOB := --format binary --oformat elf32-m68k
 ifneq ($(COMPILE_ARCH),$(ARCH))
 	# prefix for cross-compiling binaries
 	CROSS_COMPILE = m68k-linux-
diff -Nru a/arch/m68knommu/Makefile b/arch/m68knommu/Makefile
--- a/arch/m68knommu/Makefile	Sat Jul 19 23:19:24 2003
+++ b/arch/m68knommu/Makefile	Sat Jul 19 23:19:24 2003
@@ -85,8 +85,6 @@
 CFLAGS += -D__linux__
 CFLAGS += -DUTS_SYSNAME=\"uClinux\"
 
-LDFLAGS_BLOB	:= --format binary --oformat elf32-m68k
-
 head-y := arch/m68knommu/platform/$(platform-y)/$(board-y)/crt0_$(model-y).o
 
 CLEAN_FILES := include/asm-$(ARCH)/asm-offsets.h \
diff -Nru a/arch/mips/Makefile b/arch/mips/Makefile
--- a/arch/mips/Makefile	Sat Jul 19 23:19:24 2003
+++ b/arch/mips/Makefile	Sat Jul 19 23:19:24 2003
@@ -18,11 +18,9 @@
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 tool-prefix	= mipsel-linux-
 JIFFIES32	= jiffies_64
-LDFLAGS_BLOB   := --format binary --oformat elf32-tradlittlemips
 else
 tool-prefix	= mips-linux-
 JIFFIES32	= jiffies_64 + 4
-LDFLAGS_BLOB   := --format binary --oformat elf32-tradbigmips
 endif
 
 ifdef CONFIG_CROSSCOMPILE
diff -Nru a/arch/parisc/Makefile b/arch/parisc/Makefile
--- a/arch/parisc/Makefile	Sat Jul 19 23:19:24 2003
+++ b/arch/parisc/Makefile	Sat Jul 19 23:19:24 2003
@@ -20,13 +20,11 @@
 ifdef CONFIG_PARISC64
 CROSS_COMPILE	:= hppa64-linux-
 UTS_MACHINE	:= parisc64
-LDFLAGS_BLOB	:= --format binary --oformat elf64-hppa-linux
 else
 MACHINE := $(subst 64,,$(shell uname -m))
 ifneq ($(MACHINE),parisc)
 CROSS_COMPILE	:= hppa-linux-
 endif
-LDFLAGS_BLOB	:= --format binary --oformat elf32-hppa-linux
 endif
 
 FINAL_LD=$(CROSS_COMPILE)ld --warn-common --warn-section-align 
diff -Nru a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile	Sat Jul 19 23:19:24 2003
+++ b/arch/ppc/Makefile	Sat Jul 19 23:19:24 2003
@@ -13,7 +13,6 @@
 # This must match PAGE_OFFSET in include/asm-ppc/page.h.
 KERNELLOAD	:= $(CONFIG_KERNEL_START)
 
-LDFLAGS_BLOB	:= --format binary --oformat elf32-powerpc
 LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
 CPPFLAGS	+= -Iarch/$(ARCH)
 AFLAGS		+= -Iarch/$(ARCH)
diff -Nru a/arch/ppc64/Makefile b/arch/ppc64/Makefile
--- a/arch/ppc64/Makefile	Sat Jul 19 23:19:24 2003
+++ b/arch/ppc64/Makefile	Sat Jul 19 23:19:24 2003
@@ -17,7 +17,6 @@
 
 LDFLAGS		:= -m elf64ppc
 LDFLAGS_vmlinux	:= -Bstatic -e $(KERNELLOAD) -Ttext $(KERNELLOAD)
-LDFLAGS_BLOB	:= --format binary --oformat elf64-powerpc
 CFLAGS		+= -msoft-float -pipe -Wno-uninitialized -mminimal-toc \
 		-mtraceback=full -mcpu=power4
 
diff -Nru a/arch/s390/Makefile b/arch/s390/Makefile
--- a/arch/s390/Makefile	Sat Jul 19 23:19:24 2003
+++ b/arch/s390/Makefile	Sat Jul 19 23:19:24 2003
@@ -17,7 +17,6 @@
 
 ifdef CONFIG_ARCH_S390_31
 LDFLAGS		:= -m elf_s390
-LDFLAGS_BLOB	:= --format binary --oformat elf32-s390
 CFLAGS		+= -m31
 AFLAGS		+= -m31
 UTS_MACHINE	:= s390
@@ -26,7 +25,6 @@
 ifdef CONFIG_ARCH_S390X
 LDFLAGS		:= -m elf64_s390
 MODFLAGS	+= -fpic -D__PIC__
-LDFLAGS_BLOB	:= --format binary --oformat elf64-s390
 CFLAGS		+= -m64
 AFLAGS		+= -m64
 UTS_MACHINE	:= s390x
diff -Nru a/arch/sh/Makefile b/arch/sh/Makefile
--- a/arch/sh/Makefile	Sat Jul 19 23:19:24 2003
+++ b/arch/sh/Makefile	Sat Jul 19 23:19:24 2003
@@ -50,10 +50,8 @@
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 LDFLAGS_vmlinux     +=  --defsym 'jiffies=jiffies_64' -EL
-LDFLAGS_BLOB    :=--format binary --oformat elf32-sh-linux
 else
 LDFLAGS_vmlinux     +=  --defsym 'jiffies=jiffies_64+4' -EB
-LDFLAGS_BLOB    :=--format binary --oformat elf32-shbig-linux
 endif
 
 CFLAGS		+= -pipe $(cpu-y)
diff -Nru a/arch/sparc/Makefile b/arch/sparc/Makefile
--- a/arch/sparc/Makefile	Sat Jul 19 23:19:24 2003
+++ b/arch/sparc/Makefile	Sat Jul 19 23:19:24 2003
@@ -23,8 +23,6 @@
 LDFLAGS		:= -m elf32_sparc
 endif
 
-LDFLAGS_BLOB	:= --format binary --oformat elf32-sparc
-
 #CFLAGS := $(CFLAGS) -g -pipe -fcall-used-g5 -fcall-used-g7
 ifneq ($(IS_EGCS),y)
 CFLAGS := $(CFLAGS) -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
diff -Nru a/arch/sparc64/Makefile b/arch/sparc64/Makefile
--- a/arch/sparc64/Makefile	Sat Jul 19 23:19:24 2003
+++ b/arch/sparc64/Makefile	Sat Jul 19 23:19:24 2003
@@ -32,7 +32,6 @@
 else
 AS		:= $(AS) -64
 LDFLAGS		:= -m elf64_sparc
-LDFLAGS_BLOB	:= --format binary --oformat elf64-sparc
 endif
 
 ifneq ($(UNDECLARED_REGS),y)
diff -Nru a/arch/v850/Makefile b/arch/v850/Makefile
--- a/arch/v850/Makefile	Sat Jul 19 23:19:24 2003
+++ b/arch/v850/Makefile	Sat Jul 19 23:19:24 2003
@@ -27,7 +27,6 @@
 # some reason)
 LDFLAGS_MODULE += --unique=.gnu.linkonce.this_module
 
-LDFLAGS_BLOB := -b binary --oformat elf32-little
 OBJCOPY_FLAGS_BLOB := -I binary -O elf32-little -B v850e
 
 
diff -Nru a/arch/x86_64/Makefile b/arch/x86_64/Makefile
--- a/arch/x86_64/Makefile	Sat Jul 19 23:19:24 2003
+++ b/arch/x86_64/Makefile	Sat Jul 19 23:19:24 2003
@@ -36,7 +36,6 @@
 LDFLAGS		:= -m elf_x86_64
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
 LDFLAGS_vmlinux := -e stext
-LDFLAGS_BLOB	:= --format binary --oformat elf64-x86-64
 
 CFLAGS += -mno-red-zone
 CFLAGS += -mcmodel=kernel
diff -Nru a/usr/Makefile b/usr/Makefile
--- a/usr/Makefile	Sat Jul 19 23:19:24 2003
+++ b/usr/Makefile	Sat Jul 19 23:19:24 2003
@@ -3,11 +3,12 @@
 
 host-progs  := gen_init_cpio
 
-clean-files := initramfs_data.cpio.gz initramfs_data.S
+clean-files := initramfs_data.cpio.gz
 
-$(src)/initramfs_data.S: $(obj)/initramfs_data.cpio.gz
-	echo "	.section .init.ramfs,\"a\"" > $(src)/initramfs_data.S
-	echo ".incbin \"usr/initramfs_data.cpio.gz\"" >> $(src)/initramfs_data.S
+# initramfs_data.o contains the initramfs_data.cpio.gz image.
+# The image is included using .incbin, a dependency which is not
+# tracked automatically.
+$(obj)/initramfs_data.o: $(obj)/initramfs_data.cpio.gz FORCE
 
 # initramfs-y are the programs which will be copied into the CPIO
 # archive. Currently, the filenames are hardcoded in gen_init_cpio,
diff -Nru a/usr/initramfs_data.S b/usr/initramfs_data.S
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/usr/initramfs_data.S	Sat Jul 19 23:19:24 2003
@@ -0,0 +1,30 @@
+/*
+  initramfs_data includes the compressed binary that is the
+  filesystem used for early user space.
+  Note: Older versions of "as" (prior to binutils 2.11.90.0.23
+  released on 2001-07-14) dit not support .incbin.
+  If you are forced to use older binutils than that then the
+  following trick can be applied to create the resulting binary:
+
+
+  ld -m elf_i386  --format binary --oformat elf32-i386 -r \
+  -T initramfs_data.scr initramfs_data.cpio.gz -o initramfs_data.o
+   ld -m elf_i386  -r -o built-in.o initramfs_data.o
+
+  initramfs_data.scr looks like this:
+SECTIONS
+{
+       .init.ramfs : { *(.data) }
+}
+
+  The above example is for i386 - the parameters vary from architectures.
+  Eventually look up LDFLAGS_BLOB in an older version of the
+  arch/$(ARCH)/Makefile to see the flags used before .incbin was introduced.
+
+  Using .incbin has the advantage over ld that the correct flags are set
+  in the ELF header, as required by certain architectures.
+*/
+
+.section .init.ramfs,"a"
+.incbin "usr/initramfs_data.cpio.gz"
+
