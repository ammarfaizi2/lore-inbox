Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265759AbSKFRTg>; Wed, 6 Nov 2002 12:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265846AbSKFRTg>; Wed, 6 Nov 2002 12:19:36 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:47144 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265759AbSKFRTd>; Wed, 6 Nov 2002 12:19:33 -0500
Message-ID: <3DC950A2.A2BA88CF@cinet.co.jp>
Date: Thu, 07 Nov 2002 02:25:54 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.45-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCHSET 1/17] support PC-9800 against 2.5.45-ac1 (boot)
References: <3DC94C7B.79DE5EBC@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------837951E0B0B1D188A0EECA8E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------837951E0B0B1D188A0EECA8E
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

This patch is for already merged files, to follow changes for
standard PC in -ac1.

diffstat:
 arch/i386/boot98/Makefile          |    2 +-
 arch/i386/boot98/compressed/head.S |    8 ++++----
 arch/i386/boot98/compressed/misc.c |    6 +++++-
 arch/i386/boot98/setup.S           |   29 ++++++++++++++++++++---------
 4 files changed, 30 insertions(+), 15 deletions(-)
--------------837951E0B0B1D188A0EECA8E
Content-Type: text/plain; charset=iso-2022-jp;
 name="boot98.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot98.patch"

diff -urN linux-2.5.45-ac1/arch/i386/boot98/Makefile linux98-2.5.45-ac1/arch/i386/boot98/Makefile
--- linux-2.5.45-ac1/arch/i386/boot98/Makefile	Wed Nov  6 16:07:08 2002
+++ linux98-2.5.45-ac1/arch/i386/boot98/Makefile	Thu Oct 31 09:42:28 2002
@@ -46,7 +46,7 @@
 $(obj)/bzImage: EXTRA_AFLAGS := -traditional $(SVGA_MODE) $(RAMDISK) -D__BIG_KERNEL__
 $(obj)/bzImage: BUILDFLAGS   := -b
 
-quiet_cmd_image = BUILD   $(echo_target)
+quiet_cmd_image = BUILD   $@
 cmd_image = $(obj)/tools/build $(BUILDFLAGS) $(obj)/bootsect $(obj)/setup \
 	    $(obj)/vmlinux.bin $(ROOT_DEV) > $@
 
diff -urN linux-2.5.45-ac1/arch/i386/boot98/compressed/head.S linux98-2.5.45-ac1/arch/i386/boot98/compressed/head.S
--- linux-2.5.45-ac1/arch/i386/boot98/compressed/head.S	Wed Nov  6 16:07:08 2002
+++ linux98-2.5.45-ac1/arch/i386/boot98/compressed/head.S	Tue Nov  5 10:16:17 2002
@@ -31,7 +31,7 @@
 startup_32:
 	cld
 	cli
-	movl $(__KERNEL_DS),%eax
+	movl $(__BOOT_DS),%eax
 	movl %eax,%ds
 	movl %eax,%es
 	movl %eax,%fs
@@ -74,7 +74,7 @@
 	popl %esi	# discard address
 	popl %esi	# real mode pointer
 	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $0x100000
+	ljmp $(__BOOT_CS), $0x100000
 
 /*
  * We come here, if we were loaded high.
@@ -101,7 +101,7 @@
 	popl %eax	# hcount
 	movl $0x100000,%edi
 	cli		# make sure we don't get interrupted
-	ljmp $(__KERNEL_CS), $0x1000 # and jump to the move routine
+	ljmp $(__BOOT_CS), $0x1000 # and jump to the move routine
 
 /*
  * Routine (template) for moving the decompressed kernel in place,
@@ -124,5 +124,5 @@
 	movsl
 	movl %ebx,%esi	# Restore setup pointer
 	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $0x100000
+	ljmp $(__BOOT_CS), $0x100000
 move_routine_end:
diff -urN linux-2.5.45-ac1/arch/i386/boot98/compressed/misc.c linux98-2.5.45-ac1/arch/i386/boot98/compressed/misc.c
--- linux-2.5.45-ac1/arch/i386/boot98/compressed/misc.c	Wed Nov  6 16:07:08 2002
+++ linux98-2.5.45-ac1/arch/i386/boot98/compressed/misc.c	Wed Nov  6 15:10:28 2002
@@ -301,7 +301,7 @@
 struct {
 	long * a;
 	short b;
-	} stack_start = { & user_stack [STACK_SIZE] , __KERNEL_DS };
+	} stack_start = { & user_stack [STACK_SIZE] , __BOOT_DS };
 
 static void setup_normal_output_buffer(void)
 {
@@ -373,3 +373,7 @@
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
 }
+
+/* We don't actually check for stack overflows this early. */
+__asm__(".globl mcount ; mcount: ret\n");
+
diff -urN linux-2.5.45-ac1/arch/i386/boot98/setup.S linux98-2.5.45-ac1/arch/i386/boot98/setup.S
--- linux-2.5.45-ac1/arch/i386/boot98/setup.S	Wed Nov  6 16:07:08 2002
+++ linux98-2.5.45-ac1/arch/i386/boot98/setup.S	Wed Nov  6 15:23:42 2002
@@ -660,7 +660,7 @@
 	subw	$DELTA_INITSEG, %si
 	shll	$4, %esi			# Convert to 32-bit pointer
 # NOTE: For high loaded big kernels we need a
-#	jmpi    0x100000,__KERNEL_CS
+#	jmpi    0x100000,__BOOT_CS
 #
 #	but we yet haven't reloaded the CS register, so the default size 
 #	of the target offset still is 16 bit.
@@ -671,7 +671,7 @@
 	.byte 0x66, 0xea			# prefix + jmpi-opcode
 code32:	.long	0x1000				# will be set to 0x100000
 						# for big kernels
-	.word	__KERNEL_CS
+	.word	__BOOT_CS
 
 # Here's a bunch of information about your current kernel..
 kernel_version:	.ascii	UTS_RELEASE
@@ -902,13 +902,19 @@
 
 # Descriptor tables
 #
-# NOTE: if you think the GDT is large, you can make it smaller by just
-# defining the KERNEL_CS and KERNEL_DS entries and shifting the gdt
-# address down by GDT_ENTRY_KERNEL_CS*8. This puts bogus entries into
-# the GDT, but those wont be used so it's not a problem.
+# NOTE: The intel manual says gdt should be sixteen bytes aligned for
+# efficiency reasons.  However, there are machines which are known not
+# to boot with misaligned GDTs, so alter this at your peril!  If you alter
+# GDT_ENTRY_BOOT_CS (in asm/segment.h) remember to leave at least two
+# empty GDT entries (one for NULL and one reserved).
 #
+# NOTE:	On some CPUs, the GDT must be 8 byte aligned.  This is
+# true for the Voyager Quad CPU card which will not boot without
+# This directive.  16 byte aligment is recommended by intel.
+#
+	.align 16
 gdt:
-	.fill GDT_ENTRY_KERNEL_CS,8,0
+	.fill GDT_ENTRY_BOOT_CS,8,0
 
 	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
 	.word	0				# base address = 0
@@ -921,12 +927,17 @@
 	.word	0x9200				# data read/write
 	.word	0x00CF				# granularity = 4096, 386
 						#  (+5th nibble of limit)
+gdt_end:
+	.align	4
+	
+	.word	0				# alignment byte
 idt_48:
 	.word	0				# idt limit = 0
 	.word	0, 0				# idt base = 0L
-gdt_48:
-	.word	GDT_ENTRY_KERNEL_CS*8 + 16 - 1	# gdt limit
 
+	.word	0				# alignment byte
+gdt_48:
+	.word	gdt_end - gdt - 1		# gdt limit
 	.word	0, 0				# gdt base (filled in later)
 
 # Include video setup & detection code

--------------837951E0B0B1D188A0EECA8E--

