Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283836AbRL1A5t>; Thu, 27 Dec 2001 19:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283860AbRL1A5n>; Thu, 27 Dec 2001 19:57:43 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:34822 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S283836AbRL1A5d>;
	Thu, 27 Dec 2001 19:57:33 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk,
        linux-m68k@lists.linux-m68k.org
Subject: [patch] 2.4.18-pre1 replace .text.lock with .subsection
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Dec 2001 11:57:11 +1100
Message-ID: <18061.1009501031@ocs3.intra.ocs.com.au>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.4.18-pre1 replaces section .text.lock with
.subsection.  Using a special section for out of line code can generate
dangling references to discarded sections, the dangling references are
flagged as an error by binutils 2.11.92.0.12 onwards.  See thread
http://marc.theaimsgroup.com/?l=linux-kernel&m=100909932003300&w=2

Normally I would do this against 2.5 and backport to 2.4 but this bug
is affecting 2.4 users now.

The patch hits several architectures but only i386, arm and m68k are
really affected, the other changes are removing dead lines.  i386 has
been tested, I need arm and m68k users to check that the generated code
is valid.

ia64 is still using .text.lock, the version of gas that I use
(2.96-ia64-000717) makes a complete mess of .subsection.  I will look
at converting ia64 next year, after finding a version of gas that
handles subsection correctly.

The patch consists of several semi-independent patches, broken up and
commented for readability.

======

Standard macro for converting #define to a string.  Don't want to use
MODULE_STRING, include module.h pulls in all the module definitions as well.

Index: 18-pre1.1/include/linux/stringify.h
--- 18-pre1.1/include/linux/stringify.h Fri, 28 Dec 2001 11:04:37 +1100 kaos ()
+++ 18-pre1.3(w)/include/linux/stringify.h Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/O/f/50_stringify. 1.1 644)
@@ -0,0 +1,12 @@
+#ifndef __LINUX_STRINGIFY_H
+#define __LINUX_STRINGIFY_H
+
+/* Indirect stringification.  Doing two levels allows the parameter to be a
+ * macro itself.  For example, compile with -DFOO=bar, __stringify(FOO)
+ * converts to "bar".
+ */
+
+#define __stringify_1(x)	#x
+#define __stringify(x)		__stringify_1(x)
+
+#endif	/* !__LINUX_STRINGIFY_H */
 
======

Add KBUILD_BASENAME to assorted Makefiles, it is used to generate
source specific labels to help in debugging lock problems.

Index: 18-pre1.1/Makefile
--- 18-pre1.1/Makefile Thu, 27 Dec 2001 14:15:09 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40.1.1 644)
+++ 18-pre1.3(w)/Makefile Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.43 644)
@@ -329,11 +329,13 @@ include/linux/version.h: ./Makefile
 	@echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))' >>.ver
 	@mv -f .ver $@
 
+comma	:= ,
+
 init/version.o: init/version.c include/linux/compile.h include/config/MARKER
-	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) -DUTS_MACHINE='"$(ARCH)"' -c -o init/version.o init/version.c
+	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) -DUTS_MACHINE='"$(ARCH)"' -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o init/version.o init/version.c
 
 init/main.o: init/main.c include/config/MARKER
-	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -c -o $*.o $<
+	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o $*.o $<
 
 fs lib mm ipc kernel drivers net: dummy
 	$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" $(subst $@, _dir_$@, $@)
Index: 18-pre1.1/Rules.make
--- 18-pre1.1/Rules.make Wed, 07 Mar 2001 23:04:43 +1100 kaos (linux-2.4/T/c/47_Rules.make 1.1.2.2 644)
+++ 18-pre1.3(w)/Rules.make Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/T/c/47_Rules.make 1.1.2.2.2.1 644)
@@ -31,6 +31,8 @@ unexport subdir-m
 unexport subdir-n
 unexport subdir-
 
+comma	:= ,
+
 #
 # Get things started.
 #
@@ -54,7 +56,7 @@ ALL_SUB_DIRS	:= $(sort $(subdir-y) $(sub
 	$(CPP) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) $< > $@
 
 %.o: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -c -o $@ $<
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) $(CFLAGS_$@) -c -o $@ $<
 	@ ( \
 	    echo 'ifeq ($(strip $(subst $(comma),:,$(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@))),$$(strip $$(subst $$(comma),:,$$(CFLAGS) $$(EXTRA_CFLAGS) $$(CFLAGS_$@))))' ; \
 	    echo 'FILES_FLAGS_UP_TO_DATE += $@' ; \
@@ -270,7 +272,7 @@ endif # CONFIG_MODVERSIONS
 
 ifneq "$(strip $(export-objs))" ""
 $(export-objs): $(export-objs:.o=.c) $(TOPDIR)/include/linux/modversions.h
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -DEXPORT_SYMTAB -c $(@:.o=.c)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) $(CFLAGS_$@) -DEXPORT_SYMTAB -c $(@:.o=.c)
 	@ ( \
 	    echo 'ifeq ($(strip $(subst $(comma),:,$(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -DEXPORT_SYMTAB)),$$(strip $$(subst $$(comma),:,$$(CFLAGS) $$(EXTRA_CFLAGS) $$(CFLAGS_$@) -DEXPORT_SYMTAB)))' ; \
 	    echo 'FILES_FLAGS_UP_TO_DATE += $@' ; \
Index: 18-pre1.1/arch/i386/boot/compressed/Makefile
--- 18-pre1.1/arch/i386/boot/compressed/Makefile Fri, 14 Sep 2001 12:20:01 +1000 kaos (linux-2.4/T/c/42_Makefile 1.2 644)
+++ 18-pre1.3(w)/arch/i386/boot/compressed/Makefile Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/T/c/42_Makefile 1.2.1.2 644)
@@ -32,8 +32,10 @@ bvmlinux: piggy.o $(OBJECTS)
 head.o: head.S
 	$(CC) $(AFLAGS) -traditional -c head.S
 
+comma	:= ,
+
 misc.o: misc.c
-	$(CC) $(CFLAGS) -c misc.c
+	$(CC) $(CFLAGS) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c misc.c
 
 piggy.o:	$(SYSTEM)
 	tmppiggy=_tmp_$$$$piggy; \
Index: 18-pre1.1/arch/ia64/sn/fprom/Makefile
--- 18-pre1.1/arch/ia64/sn/fprom/Makefile Sun, 08 Apr 2001 14:10:15 +1000 kaos (linux-2.4/q/c/46_Makefile 1.1.3.1 644)
+++ 18-pre1.3(w)/arch/ia64/sn/fprom/Makefile Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/q/c/46_Makefile 1.1.3.2 644)
@@ -18,10 +18,12 @@ obj-y=fprom
 fprom: $(OBJ)
 	$(LD) -static -Tfprom.lds -o fprom $(OBJ) $(LIB)
 
+comma	:= ,
+
 .S.o:
 	$(CC)  -D__ASSEMBLY__ $(AFLAGS) $(AFLAGS_KERNEL) -c -o $*.o $<
 .c.o:
-	$(CC)  $(CFLAGS) $(CFLAGS_KERNEL) -c -o $*.o $<
+	$(CC)  $(CFLAGS) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) $(CFLAGS_KERNEL) -c -o $*.o $<
 
 clean:
 	rm -f *.o fprom
Index: 18-pre1.1/arch/ia64/tools/Makefile
--- 18-pre1.1/arch/ia64/tools/Makefile Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/q/c/1_Makefile 1.1 644)
+++ 18-pre1.3(w)/arch/ia64/tools/Makefile Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/q/c/1_Makefile 1.1.1.1 644)
@@ -31,8 +31,10 @@ ifeq ($(CROSS_COMPILE),)
 offsets.h: print_offsets
 	./print_offsets > offsets.h
 
+comma	:= ,
+
 print_offsets: print_offsets.c FORCE_RECOMPILE
-	$(CC) $(CFLAGS) print_offsets.c -o $@
+	$(CC) $(CFLAGS) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) print_offsets.c -o $@
 
 FORCE_RECOMPILE:
 
@@ -42,7 +44,7 @@ offsets.h: print_offsets.s
 	$(AWK) -f print_offsets.awk $^ > $@
 
 print_offsets.s: print_offsets.c
-	$(CC) $(CFLAGS) -S print_offsets.c -o $@
+	$(CC) $(CFLAGS) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -S print_offsets.c -o $@
 
 endif
 
======

Remove .text.lock from vmlinux.lds.  Most of these architectures never
actually used .text.lock.

Index: 18-pre1.1/arch/arm/vmlinux-armo.lds.in
--- 18-pre1.1/arch/arm/vmlinux-armo.lds.in Mon, 13 Aug 2001 14:14:10 +1000 kaos (linux-2.4/u/c/19_vmlinux-ar 1.1.3.1.1.1.1.1 644)
+++ 18-pre1.3(w)/arch/arm/vmlinux-armo.lds.in Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/u/c/19_vmlinux-ar 1.1.3.1.1.1.1.1.1.1 644)
@@ -48,7 +48,6 @@ SECTIONS
 			*(.text)
 			*(.fixup)
 			*(.gnu.warning)
-			*(.text.lock)	/* out-of-line lock text */
 			*(.rodata)
 			*(.rodata.*)
 			*(.glue_7)
Index: 18-pre1.1/arch/arm/vmlinux-armv.lds.in
--- 18-pre1.1/arch/arm/vmlinux-armv.lds.in Mon, 13 Aug 2001 14:14:10 +1000 kaos (linux-2.4/u/c/18_vmlinux-ar 1.1.3.1.1.1.1.2.1.1 644)
+++ 18-pre1.3(w)/arch/arm/vmlinux-armv.lds.in Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/u/c/18_vmlinux-ar 1.1.3.1.1.1.1.2.1.1.1.1 644)
@@ -43,7 +43,6 @@ SECTIONS
 			*(.text)
 			*(.fixup)
 			*(.gnu.warning)
-			*(.text.lock)	/* out-of-line lock text */
 			*(.rodata)
 			*(.rodata.*)
 			*(.glue_7)
Index: 18-pre1.1/arch/cris/cris.ld
--- 18-pre1.1/arch/cris/cris.ld Tue, 09 Oct 2001 11:09:32 +1000 kaos (linux-2.4/m/d/44_cris.ld 1.2.1.5 644)
+++ 18-pre1.3(w)/arch/cris/cris.ld Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/m/d/44_cris.ld 1.2.1.6 644)
@@ -24,7 +24,6 @@ SECTIONS
 		*(.fixup)
 		*(.text.__*)
 	}
-  	.text.lock : { *(.text.lock) }        /* out-of-line lock text */
 
 	_etext = . ;                  /* End of text section */ 
 	__etext = .;
Index: 18-pre1.1/arch/i386/vmlinux.lds
--- 18-pre1.1/arch/i386/vmlinux.lds Tue, 03 Jul 2001 11:11:12 +1000 kaos (linux-2.4/R/c/35_vmlinux.ld 1.1.4.1 644)
+++ 18-pre1.3(w)/arch/i386/vmlinux.lds Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/R/c/35_vmlinux.ld 1.1.4.1.1.1 644)
@@ -13,7 +13,6 @@ SECTIONS
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
-  .text.lock : { *(.text.lock) }	/* out-of-line lock text */
 
   _etext = .;			/* End of text section */
 
Index: 18-pre1.1/arch/m68k/vmlinux.lds
--- 18-pre1.1/arch/m68k/vmlinux.lds Tue, 03 Jul 2001 11:11:12 +1000 kaos (linux-2.4/B/c/24_vmlinux.ld 1.1.4.1 644)
+++ 18-pre1.3(w)/arch/m68k/vmlinux.lds Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/B/c/24_vmlinux.ld 1.1.4.1.1.1 644)
@@ -9,7 +9,6 @@ SECTIONS
   .text : {
 	*(.text)
 	*(.fixup)
-	*(.text.lock)		/* out-of-line lock text */
 	*(.gnu.warning)
 	} = 0x4e75
   .rodata : { *(.rodata) *(.rodata.*) }
Index: 18-pre1.1/arch/m68k/vmlinux-sun3.lds
--- 18-pre1.1/arch/m68k/vmlinux-sun3.lds Tue, 03 Jul 2001 11:11:12 +1000 kaos (linux-2.4/z/c/50_vmlinux-su 1.1.4.1 644)
+++ 18-pre1.3(w)/arch/m68k/vmlinux-sun3.lds Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/z/c/50_vmlinux-su 1.1.4.1.1.1 644)
@@ -10,7 +10,6 @@ SECTIONS
 	*(.head)
 	*(.text)
 	*(.fixup)
-	*(.text.lock)		/* out-of-line lock text */
 	*(.gnu.warning)
 	} = 0x4e75
   .kstrtab : { *(.kstrtab) }
Index: 18-pre1.1/arch/s390/vmlinux.lds
--- 18-pre1.1/arch/s390/vmlinux.lds Tue, 03 Jul 2001 11:11:12 +1000 kaos (linux-2.4/m/c/40_vmlinux.ld 1.3 644)
+++ 18-pre1.3(w)/arch/s390/vmlinux.lds Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/m/c/40_vmlinux.ld 1.4 644)
@@ -13,7 +13,6 @@ SECTIONS
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0700
-  .text.lock : { *(.text.lock) }	/* out-of-line lock text */
   .rodata : { *(.rodata) *(.rodata.*) }
   .kstrtab : { *(.kstrtab) }
 
Index: 18-pre1.1/arch/s390/vmlinux-shared.lds
--- 18-pre1.1/arch/s390/vmlinux-shared.lds Mon, 13 Aug 2001 14:14:10 +1000 kaos (linux-2.4/Q/e/48_vmlinux-sh 1.1 644)
+++ 18-pre1.3(w)/arch/s390/vmlinux-shared.lds Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/Q/e/48_vmlinux-sh 1.2 644)
@@ -13,7 +13,6 @@ SECTIONS
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0700
-  .text.lock : { *(.text.lock) }	/* out-of-line lock text */
   .rodata : { *(.rodata) }
   .kstrtab : { *(.kstrtab) }
 
Index: 18-pre1.1/arch/s390x/vmlinux.lds
--- 18-pre1.1/arch/s390x/vmlinux.lds Tue, 03 Jul 2001 11:11:12 +1000 kaos (linux-2.4/o/d/49_vmlinux.ld 1.1.2.2 644)
+++ 18-pre1.3(w)/arch/s390x/vmlinux.lds Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/o/d/49_vmlinux.ld 1.1.2.3 644)
@@ -13,7 +13,6 @@ SECTIONS
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0700
-  .text.lock : { *(.text.lock) }	/* out-of-line lock text */
   .rodata : { *(.rodata) *(.rodata.*) }
   .kstrtab : { *(.kstrtab) }
 
Index: 18-pre1.1/arch/s390x/vmlinux-shared.lds
--- 18-pre1.1/arch/s390x/vmlinux-shared.lds Mon, 13 Aug 2001 14:14:10 +1000 kaos (linux-2.4/Q/e/47_vmlinux-sh 1.1 644)
+++ 18-pre1.3(w)/arch/s390x/vmlinux-shared.lds Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/Q/e/47_vmlinux-sh 1.2 644)
@@ -13,7 +13,6 @@ SECTIONS
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0700
-  .text.lock : { *(.text.lock) }	/* out-of-line lock text */
   .rodata : { *(.rodata) }
   .kstrtab : { *(.kstrtab) }
 
Index: 18-pre1.1/arch/sh/vmlinux.lds.S
--- 18-pre1.1/arch/sh/vmlinux.lds.S Sun, 09 Sep 2001 19:22:07 +1000 kaos (linux-2.4/s/c/43_vmlinux.ld 1.3 644)
+++ 18-pre1.3(w)/arch/sh/vmlinux.lds.S Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/s/c/43_vmlinux.ld 1.3.1.1 644)
@@ -23,7 +23,6 @@ SECTIONS
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0009
-  .text.lock : { *(.text.lock) }	/* out-of-line lock text */
   .rodata : { *(.rodata) *(.rodata.*) }
   .kstrtab : { *(.kstrtab) }
 
======

Obsolete comments in parisc.

Index: 18-pre1.1/include/asm-parisc/semaphore.h
--- 18-pre1.1/include/asm-parisc/semaphore.h Sun, 22 Apr 2001 08:14:43 +1000 kaos (linux-2.4/k/41_semaphore. 1.1.2.1 644)
+++ 18-pre1.3(w)/include/asm-parisc/semaphore.h Fri, 28 Dec 2001 11:01:19 +1100 kaos (linux-2.4/k/41_semaphore. 1.1.2.2 644)
@@ -12,10 +12,6 @@
  *
  */
 
-/* if you're going to use out-of-line slowpaths, use .section .lock.text,
- * not .text.lock or the -ffunction-sections monster will eat you alive
- */
-
 #include <linux/spinlock.h>
 #include <linux/rwsem.h>
 
Index: 18-pre1.1/include/asm-parisc/spinlock.h
--- 18-pre1.1/include/asm-parisc/spinlock.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/k/26_spinlock.h 1.1 644)
+++ 18-pre1.3(w)/include/asm-parisc/spinlock.h Fri, 28 Dec 2001 11:01:19 +1100 kaos (linux-2.4/k/26_spinlock.h 1.1.2.1 644)
@@ -3,10 +3,6 @@
 
 #include <asm/system.h>
 
-/* if you're going to use out-of-line slowpaths, use .section .lock.text,
- * not .text.lock or the -ffunction-sections monster will eat you alive
- */
-
 /* we seem to be the only architecture that uses 0 to mean locked - but we
  * have to.  prumpf */
 
======

ARM was incorrectly using .text.lock for the functions themselves.

Index: 18-pre1.1/arch/arm/kernel/entry-common.S
--- 18-pre1.1/arch/arm/kernel/entry-common.S Fri, 12 Oct 2001 11:40:38 +1000 kaos (linux-2.4/w/c/51_entry-comm 1.1.1.2.1.1.1.1 644)
+++ 18-pre1.3(w)/arch/arm/kernel/entry-common.S Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/w/c/51_entry-comm 1.1.1.2.1.1.1.2 644)
@@ -22,12 +22,10 @@
  * Our do_softirq out of line code.  See include/asm-arm/softirq.h for
  * the calling assembly.
  */
-	.section ".text.lock","ax"
 ENTRY(__do_softirq)
 	stmfd	sp!, {r0 - r3, ip, lr}
 	bl	do_softirq
 	ldmfd	sp!, {r0 - r3, ip, pc}
-	.previous
 
 	.align	5
 /*
Index: 18-pre1.1/arch/arm/kernel/semaphore.c
--- 18-pre1.1/arch/arm/kernel/semaphore.c Sat, 28 Apr 2001 18:38:57 +1000 kaos (linux-2.4/w/c/30_semaphore. 1.1.1.2 644)
+++ 18-pre1.3(w)/arch/arm/kernel/semaphore.c Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/w/c/30_semaphore. 1.1.1.3 644)
@@ -177,8 +177,7 @@ int __down_trylock(struct semaphore * se
  * value in some cases..
  */
 #ifdef CONFIG_CPU_26
-asm("	.section	.text.lock, \"ax\"
-	.align	5
+asm("	.align	5
 	.globl	__down_failed
 __down_failed:
 	stmfd	sp!, {r0 - r3, lr}
@@ -212,13 +211,11 @@ __up_wakeup:
 	bl	__up
 	ldmfd	sp!, {r0 - r3, pc}^
 
-	.previous
 	");
 
 #else
 /* 32 bit version */
-asm("	.section	.text.lock, \"ax\"
-	.align	5
+asm("	.align	5
 	.globl	__down_failed
 __down_failed:
 	stmfd	sp!, {r0 - r3, lr}
@@ -252,7 +249,6 @@ __up_wakeup:
 	bl	__up
 	ldmfd	sp!, {r0 - r3, pc}
 
-	.previous
 	");
 
 #endif

======

Convert m68k to .subsection.

Index: 18-pre1.1/include/asm-m68k/semaphore.h
--- 18-pre1.1/include/asm-m68k/semaphore.h Fri, 26 Oct 2001 15:50:03 +1000 kaos (linux-2.4/N/2_semaphore. 1.1.1.1.1.1 644)
+++ 18-pre1.3(w)/include/asm-m68k/semaphore.h Fri, 28 Dec 2001 11:01:19 +1100 kaos (linux-2.4/N/2_semaphore. 1.1.1.1.1.2 644)
@@ -9,6 +9,7 @@
 #include <linux/wait.h>
 #include <linux/spinlock.h>
 #include <linux/rwsem.h>
+#include <linux/stringify.h>
 
 #include <asm/system.h>
 #include <asm/atomic.h>
@@ -94,11 +95,14 @@ extern inline void down(struct semaphore
 		"subql #1,%0@\n\t"
 		"jmi 2f\n\t"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
 		".even\n"
+		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
+		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\tpea 1b\n\t"
 		"jbra __down_failed\n"
-		".previous"
+		".subsection 0\n"
 		: /* no outputs */
 		: "a" (sem1)
 		: "memory");
@@ -119,11 +123,14 @@ extern inline int down_interruptible(str
 		"jmi 2f\n\t"
 		"clrl %0\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
 		".even\n"
+		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
+		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\tpea 1b\n\t"
 		"jbra __down_failed_interruptible\n"
-		".previous"
+		".subsection 0\n"
 		: "=d" (result)
 		: "a" (sem1)
 		: "memory");
@@ -145,11 +152,14 @@ extern inline int down_trylock(struct se
 		"jmi 2f\n\t"
 		"clrl %0\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
 		".even\n"
+		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
+		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\tpea 1b\n\t"
 		"jbra __down_failed_trylock\n"
-		".previous"
+		".subsection 0\n"
 		: "=d" (result)
 		: "a" (sem1)
 		: "memory");
@@ -175,12 +185,15 @@ extern inline void up(struct semaphore *
 		"addql #1,%0@\n\t"
 		"jle 2f\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
 		".even\n"
+		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
+		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\t"
 		"pea 1b\n\t"
 		"jbra __up_wakeup\n"
-		".previous"
+		".subsection 0\n"
 		: /* no outputs */
 		: "a" (sem1)
 		: "memory");
 
======

Convert i386 to .subsection.

Index: 18-pre1.1/arch/i386/kernel/head.S
--- 18-pre1.1/arch/i386/kernel/head.S Thu, 21 Jun 2001 11:20:56 +1000 kaos (linux-2.4/S/c/23_head.S 1.3.1.2 644)
+++ 18-pre1.3(w)/arch/i386/kernel/head.S Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/S/c/23_head.S 1.3.1.3 644)
@@ -446,12 +446,3 @@ ENTRY(gdt_table)
 	.quad 0x00009a0000000000	/* 0x50 APM CS 16 code (16 bit) */
 	.quad 0x0040920000000000	/* 0x58 APM DS    data */
 	.fill NR_CPUS*4,8,0		/* space for TSS's and LDT's */
-		
-/*
- * This is to aid debugging, the various locking macros will be putting
- * code fragments here.  When an oops occurs we'd rather know that it's
- * inside the .text.lock section rather than as some offset from whatever
- * function happens to be last in the .text segment.
- */
-.section .text.lock
-ENTRY(stext_lock)
Index: 18-pre1.1/include/asm-i386/rwlock.h
--- 18-pre1.1/include/asm-i386/rwlock.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/T/20_rwlock.h 1.1 644)
+++ 18-pre1.3(w)/include/asm-i386/rwlock.h Fri, 28 Dec 2001 11:01:19 +1100 kaos (linux-2.4/T/20_rwlock.h 1.3 644)
@@ -17,6 +17,8 @@
 #ifndef _ASM_I386_RWLOCK_H
 #define _ASM_I386_RWLOCK_H
 
+#include <linux/stringify.h>
+
 #define RW_LOCK_BIAS		 0x01000000
 #define RW_LOCK_BIAS_STR	"0x01000000"
 
@@ -24,23 +26,29 @@
 	asm volatile(LOCK "subl $1,(%0)\n\t" \
 		     "js 2f\n" \
 		     "1:\n" \
-		     ".section .text.lock,\"ax\"\n" \
+		     ".subsection 1\n" \
+		     ".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n" \
+		     "_text_lock_" __stringify(KBUILD_BASENAME) ":\n" \
+		     ".endif\n" \
 		     "2:\tcall " helper "\n\t" \
 		     "jmp 1b\n" \
-		     ".previous" \
+		     ".subsection 0\n" \
 		     ::"a" (rw) : "memory")
 
 #define __build_read_lock_const(rw, helper)   \
 	asm volatile(LOCK "subl $1,%0\n\t" \
 		     "js 2f\n" \
 		     "1:\n" \
-		     ".section .text.lock,\"ax\"\n" \
+		     ".subsection 1\n" \
+		     ".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n" \
+		     "_text_lock_" __stringify(KBUILD_BASENAME) ":\n" \
+		     ".endif\n" \
 		     "2:\tpushl %%eax\n\t" \
 		     "leal %0,%%eax\n\t" \
 		     "call " helper "\n\t" \
 		     "popl %%eax\n\t" \
 		     "jmp 1b\n" \
-		     ".previous" \
+		     ".subsection 0\n" \
 		     :"=m" (*(volatile int *)rw) : : "memory")
 
 #define __build_read_lock(rw, helper)	do { \
@@ -54,23 +62,29 @@
 	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
 		     "jnz 2f\n" \
 		     "1:\n" \
-		     ".section .text.lock,\"ax\"\n" \
+		     ".subsection 1\n" \
+		     ".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n" \
+		     "_text_lock_" __stringify(KBUILD_BASENAME) ":\n" \
+		     ".endif\n" \
 		     "2:\tcall " helper "\n\t" \
 		     "jmp 1b\n" \
-		     ".previous" \
+		     ".subsection 0\n" \
 		     ::"a" (rw) : "memory")
 
 #define __build_write_lock_const(rw, helper) \
 	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
 		     "jnz 2f\n" \
 		     "1:\n" \
-		     ".section .text.lock,\"ax\"\n" \
+		     ".subsection 1\n" \
+		     ".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n" \
+		     "_text_lock_" __stringify(KBUILD_BASENAME) ":\n" \
+		     ".endif\n" \
 		     "2:\tpushl %%eax\n\t" \
 		     "leal %0,%%eax\n\t" \
 		     "call " helper "\n\t" \
 		     "popl %%eax\n\t" \
 		     "jmp 1b\n" \
-		     ".previous" \
+		     ".subsection 0\n" \
 		     :"=m" (*(volatile int *)rw) : : "memory")
 
 #define __build_write_lock(rw, helper)	do { \
Index: 18-pre1.1/include/asm-i386/rwsem.h
--- 18-pre1.1/include/asm-i386/rwsem.h Thu, 26 Apr 2001 12:48:22 +1000 kaos (linux-2.4/K/d/10_rwsem.h 1.5 644)
+++ 18-pre1.3(w)/include/asm-i386/rwsem.h Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/K/d/10_rwsem.h 1.7 644)
@@ -40,6 +40,7 @@
 
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/stringify.h>
 
 struct rwsem_waiter;
 
@@ -101,7 +102,10 @@ static inline void __down_read(struct rw
 LOCK_PREFIX	"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
 		"  js        2f\n\t" /* jump if we weren't granted the lock */
 		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
+		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
+		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\n\t"
 		"  pushl     %%ecx\n\t"
 		"  pushl     %%edx\n\t"
@@ -109,7 +113,7 @@ LOCK_PREFIX	"  incl      (%%eax)\n\t" /*
 		"  popl      %%edx\n\t"
 		"  popl      %%ecx\n\t"
 		"  jmp       1b\n"
-		".previous"
+		".subsection 0\n"
 		"# ending down_read\n\t"
 		: "+m"(sem->count)
 		: "a"(sem)
@@ -130,13 +134,16 @@ LOCK_PREFIX	"  xadd      %0,(%%eax)\n\t"
 		"  testl     %0,%0\n\t" /* was the count 0 before? */
 		"  jnz       2f\n\t" /* jump if we weren't granted the lock */
 		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
+		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
+		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\n\t"
 		"  pushl     %%ecx\n\t"
 		"  call      rwsem_down_write_failed\n\t"
 		"  popl      %%ecx\n\t"
 		"  jmp       1b\n"
-		".previous\n"
+		".subsection 0\n"
 		"# ending down_write"
 		: "+d"(tmp), "+m"(sem->count)
 		: "a"(sem)
@@ -154,7 +161,10 @@ static inline void __up_read(struct rw_s
 LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old value */
 		"  js        2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
+		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
+		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\n\t"
 		"  decw      %%dx\n\t" /* do nothing if still outstanding active readers */
 		"  jnz       1b\n\t"
@@ -162,7 +172,7 @@ LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n
 		"  call      rwsem_wake\n\t"
 		"  popl      %%ecx\n\t"
 		"  jmp       1b\n"
-		".previous\n"
+		".subsection 0\n"
 		"# ending __up_read\n"
 		: "+m"(sem->count), "+d"(tmp)
 		: "a"(sem)
@@ -180,7 +190,10 @@ static inline void __up_write(struct rw_
 LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n\t" /* tries to transition 0xffff0001 -> 0x00000000 */
 		"  jnz       2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
+		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
+		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\n\t"
 		"  decw      %%dx\n\t" /* did the active count reduce to 0? */
 		"  jnz       1b\n\t" /* jump back if not */
@@ -188,7 +201,7 @@ LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n
 		"  call      rwsem_wake\n\t"
 		"  popl      %%ecx\n\t"
 		"  jmp       1b\n"
-		".previous\n"
+		".subsection 0\n"
 		"# ending __up_write\n"
 		: "+m"(sem->count)
 		: "a"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS)
Index: 18-pre1.1/include/asm-i386/semaphore.h
--- 18-pre1.1/include/asm-i386/semaphore.h Fri, 14 Sep 2001 12:20:01 +1000 kaos (linux-2.4/U/13_semaphore. 1.1.1.3 644)
+++ 18-pre1.3(w)/include/asm-i386/semaphore.h Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/U/13_semaphore. 1.1.1.5 644)
@@ -40,6 +40,7 @@
 #include <asm/atomic.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
+#include <linux/stringify.h>
 
 struct semaphore {
 	atomic_t count;
@@ -122,10 +123,13 @@ static inline void down(struct semaphore
 		LOCK "decl %0\n\t"     /* --sem->count */
 		"js 2f\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
+		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
+		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\tcall __down_failed\n\t"
 		"jmp 1b\n"
-		".previous"
+		".subsection 0\n"
 		:"=m" (sem->count)
 		:"c" (sem)
 		:"memory");
@@ -149,10 +153,13 @@ static inline int down_interruptible(str
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
+		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
+		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\tcall __down_failed_interruptible\n\t"
 		"jmp 1b\n"
-		".previous"
+		".subsection 0\n"
 		:"=a" (result), "=m" (sem->count)
 		:"c" (sem)
 		:"memory");
@@ -177,10 +184,13 @@ static inline int down_trylock(struct se
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
+		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
+		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\tcall __down_failed_trylock\n\t"
 		"jmp 1b\n"
-		".previous"
+		".subsection 0\n"
 		:"=a" (result), "=m" (sem->count)
 		:"c" (sem)
 		:"memory");
@@ -203,10 +213,13 @@ static inline void up(struct semaphore *
 		LOCK "incl %0\n\t"     /* ++sem->count */
 		"jle 2f\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
+		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
+		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\tcall __up_wakeup\n\t"
 		"jmp 1b\n"
-		".previous"
+		".subsection 0\n"
 		:"=m" (sem->count)
 		:"c" (sem)
 		:"memory");
Index: 18-pre1.1/include/asm-i386/softirq.h
--- 18-pre1.1/include/asm-i386/softirq.h Sun, 09 Sep 2001 19:22:07 +1000 kaos (linux-2.4/T/51_softirq.h 1.8.1.1 644)
+++ 18-pre1.3(w)/include/asm-i386/softirq.h Fri, 28 Dec 2001 11:01:20 +1100 kaos (linux-2.4/T/51_softirq.h 1.8.1.3 644)
@@ -3,6 +3,7 @@
 
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
+#include <linux/stringify.h>
 
 #define __cpu_bh_enable(cpu) \
 		do { barrier(); local_bh_count(cpu)--; } while (0)
@@ -33,12 +34,15 @@ do {									\
 			"jnz 2f;"					\
 			"1:;"						\
 									\
-			".section .text.lock,\"ax\";"			\
+			".subsection 1;"				\
+			".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"		\
+			"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"		\
+			".endif\n"					\
 			"2: pushl %%eax; pushl %%ecx; pushl %%edx;"	\
 			"call %c1;"					\
 			"popl %%edx; popl %%ecx; popl %%eax;"		\
 			"jmp 1b;"					\
-			".previous;"					\
+			".subsection 0;"				\
 									\
 		: /* no output */					\
 		: "r" (ptr), "i" (do_softirq)				\
Index: 18-pre1.1/include/asm-i386/spinlock.h
--- 18-pre1.1/include/asm-i386/spinlock.h Fri, 26 Oct 2001 15:50:03 +1000 kaos (linux-2.4/T/50_spinlock.h 1.1.2.2 644)
+++ 18-pre1.3(w)/include/asm-i386/spinlock.h Fri, 28 Dec 2001 11:01:19 +1100 kaos (linux-2.4/T/50_spinlock.h 1.1.2.5 644)
@@ -5,6 +5,7 @@
 #include <asm/rwlock.h>
 #include <asm/page.h>
 #include <linux/config.h>
+#include <linux/stringify.h>
 
 extern int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
@@ -56,13 +57,16 @@ typedef struct {
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
 	"js 2f\n" \
-	".section .text.lock,\"ax\"\n" \
+	".subsection 1\n" \
+	".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n" \
+	"_text_lock_" __stringify(KBUILD_BASENAME) ":\n" \
+	".endif\n" \
 	"2:\t" \
 	"cmpb $0,%0\n\t" \
 	"rep;nop\n\t" \
 	"jle 2b\n\t" \
 	"jmp 1b\n" \
-	".previous"
+	".subsection 0\n"
 
 /*
  * This works. Despite all the confusion.

