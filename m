Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318887AbSHQA1X>; Fri, 16 Aug 2002 20:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318943AbSHQA1X>; Fri, 16 Aug 2002 20:27:23 -0400
Received: from host194.steeleye.com ([216.33.1.194]:62725 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S318887AbSHQA1T>; Fri, 16 Aug 2002 20:27:19 -0400
Message-Id: <200208170031.g7H0V4806751@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: mingo@elte.hu
cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
Subject: Boot failure in 2.5.31 BK with new TLS patch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Aug 2002 19:31:04 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is probably local to me since I've got a box which takes quad CPU cards 
that has always been very picky about the GDT layout at boot.  However, it's 
been failing miserably with the new padding the TLS stuff introduces into the 
boot time GDT.

I attach a patch that leaves the boot time %cs and %ds at their old values 
(0x10 and 0x18), and shifts to the new GDT layout after the switch to 
protected mode has been accomplished.

For those who don't have this GDT boot problem, it reduces the size of the 
boot code by about 64 bytes.

James

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.486, 2002-08-16 18:23:02-05:00, jejb@mulgrave.(none)
  Separate boot GDT from runtime GDT.  Allow small compact GDT at boot
  for those PCs which have problems with big ones during the protected
  mode transition.


 arch/i386/boot/compressed/head.S |    8 ++++----
 arch/i386/boot/compressed/misc.c |    2 +-
 arch/i386/boot/setup.S           |   15 +++++++--------
 arch/i386/kernel/head.S          |   15 +++++++++++++--
 arch/i386/kernel/trampoline.S    |    6 +++---
 include/asm-i386/segment.h       |    8 ++++++++
 6 files changed, 36 insertions(+), 18 deletions(-)


diff -Nru a/arch/i386/boot/compressed/head.S b/arch/i386/boot/compressed/head.S
--- a/arch/i386/boot/compressed/head.S	Fri Aug 16 19:29:20 2002
+++ b/arch/i386/boot/compressed/head.S	Fri Aug 16 19:29:20 2002
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
diff -Nru a/arch/i386/boot/compressed/misc.c b/arch/i386/boot/compressed/misc.c
--- a/arch/i386/boot/compressed/misc.c	Fri Aug 16 19:29:20 2002
+++ b/arch/i386/boot/compressed/misc.c	Fri Aug 16 19:29:20 2002
@@ -299,7 +299,7 @@
 struct {
 	long * a;
 	short b;
-	} stack_start = { & user_stack [STACK_SIZE] , __KERNEL_DS };
+	} stack_start = { & user_stack [STACK_SIZE] , __BOOT_DS };
 
 static void setup_normal_output_buffer(void)
 {
diff -Nru a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
--- a/arch/i386/boot/setup.S	Fri Aug 16 19:29:20 2002
+++ b/arch/i386/boot/setup.S	Fri Aug 16 19:29:20 2002
@@ -801,7 +801,7 @@
 	subw	$DELTA_INITSEG, %si
 	shll	$4, %esi			# Convert to 32-bit pointer
 # NOTE: For high loaded big kernels we need a
-#	jmpi    0x100000,__KERNEL_CS
+#	jmpi    0x100000,__BOOT_CS
 #
 #	but we yet haven't reloaded the CS register, so the default size 
 #	of the target offset still is 16 bit.
@@ -812,7 +812,7 @@
 	.byte 0x66, 0xea			# prefix + jmpi-opcode
 code32:	.long	0x1000				# will be set to 0x100000
 						# for big kernels
-	.word	__KERNEL_CS
+	.word	__BOOT_CS
 
 # Here's a bunch of information about your current kernel..
 kernel_version:	.ascii	UTS_RELEASE
@@ -1007,12 +1007,12 @@
 # Descriptor tables
 #
 # NOTE: if you think the GDT is large, you can make it smaller by just
-# defining the KERNEL_CS and KERNEL_DS entries and shifting the gdt
-# address down by GDT_ENTRY_KERNEL_CS*8. This puts bogus entries into
+# defining the BOOT_CS and BOOT_DS entries and shifting the gdt
+# address down by GDT_ENTRY_BOOT_CS*8. This puts bogus entries into
 # the GDT, but those wont be used so it's not a problem.
 #
 gdt:
-	.fill GDT_ENTRY_KERNEL_CS,8,0
+	.fill GDT_ENTRY_BOOT_CS,8,0
 
 	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
 	.word	0				# base address = 0
@@ -1025,13 +1025,12 @@
 	.word	0x9200				# data read/write
 	.word	0x00CF				# granularity = 4096, 386
 						#  (+5th nibble of limit)
+gdt_end:
 idt_48:
 	.word	0				# idt limit = 0
 	.word	0, 0				# idt base = 0L
 gdt_48:
-	.word	0x8000				# gdt limit=2048,
-						#  256 GDT entries
-
+	.word	gdt_end - gdt - 1		# gdt limit
 	.word	0, 0				# gdt base (filled in later)
 
 # Include video setup & detection code
diff -Nru a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	Fri Aug 16 19:29:20 2002
+++ b/arch/i386/kernel/head.S	Fri Aug 16 19:29:20 2002
@@ -46,7 +46,7 @@
  * Set segments to known values
  */
 	cld
-	movl $(__KERNEL_DS),%eax
+	movl $(__BOOT_DS),%eax
 	movl %eax,%ds
 	movl %eax,%es
 	movl %eax,%fs
@@ -306,7 +306,7 @@
 
 ENTRY(stack_start)
 	.long init_thread_union+8192
-	.long __KERNEL_DS
+	.long __BOOT_DS
 
 /* This is the default interrupt "handler" :-) */
 int_msg:
@@ -409,6 +409,17 @@
 /*
  * The Global Descriptor Table contains 28 quadwords, per-CPU.
  */
+#ifdef CONFIG_SMP
+/*
+ * The boot_gdt_table must mirror the equivalent in setup.S and is
+ * used only by the trampoline for booting other CPUs
+ */
+ENTRY(boot_gdt_table)
+	.fill GDT_ENTRY_BOOT_CS,8,0
+	.quad 0x00cf9a000000ffff	/* kernel 4GB code at 0x00000000 */
+	.quad 0x00cf92000000ffff	/* kernel 4GB data at 0x00000000 */
+#endif
+	
 ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* NULL descriptor */
 	.quad 0x0000000000000000	/* 0x0b reserved */
diff -Nru a/arch/i386/kernel/trampoline.S b/arch/i386/kernel/trampoline.S
--- a/arch/i386/kernel/trampoline.S	Fri Aug 16 19:29:20 2002
+++ b/arch/i386/kernel/trampoline.S	Fri Aug 16 19:29:20 2002
@@ -56,7 +56,7 @@
 	lmsw	%ax		# into protected mode
 	jmp	flush_instr
 flush_instr:
-	ljmpl	$__KERNEL_CS, $0x00100000
+	ljmpl	$__BOOT_CS, $0x00100000
 			# jump to startup_32 in arch/i386/kernel/head.S
 
 idt_48:
@@ -69,8 +69,8 @@
 #
 
 gdt_48:
-	.word	0x0800			# gdt limit = 2048, 256 GDT entries
-	.long	cpu_gdt_table-__PAGE_OFFSET	# gdt base = gdt (first SMP CPU)
+	.word	__BOOT_DS + 7			# gdt limit
+	.long	boot_gdt_table-__PAGE_OFFSET	# gdt base = gdt (first SMP CPU)
 
 .globl trampoline_end
 trampoline_end:
diff -Nru a/include/asm-i386/segment.h b/include/asm-i386/segment.h
--- a/include/asm-i386/segment.h	Fri Aug 16 19:29:20 2002
+++ b/include/asm-i386/segment.h	Fri Aug 16 19:29:20 2002
@@ -69,6 +69,14 @@
 
 #define GDT_SIZE (GDT_ENTRIES * 8)
 
+/* Simple and small GDT entries for booting only */
+
+#define GDT_ENTRY_BOOT_CS		2
+#define __BOOT_CS	(GDT_ENTRY_BOOT_CS * 8)
+
+#define GDT_ENTRY_BOOT_DS		(GDT_ENTRY_BOOT_CS + 1)
+#define __BOOT_DS	(GDT_ENTRY_BOOT_DS * 8)
+
 /*
  * The interrupt descriptor table has room for 256 idt's,
  * the global descriptor table is dependent on the number

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch6639
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
/T0@!Y4;FGUG`S`5B%P``
`
end


