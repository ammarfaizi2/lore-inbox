Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318757AbSHQWaM>; Sat, 17 Aug 2002 18:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318760AbSHQWaM>; Sat, 17 Aug 2002 18:30:12 -0400
Received: from host194.steeleye.com ([216.33.1.194]:2576 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S318757AbSHQWaI>; Sat, 17 Aug 2002 18:30:08 -0400
Message-Id: <200208172234.g7HMY2o05554@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Linus Torvalds <torvalds@transmeta.com>
cc: Gabriel Paubert <paubert@iram.es>,
       James Bottomley <James.Bottomley@HansenPartnership.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Boot failure in 2.5.31 BK with new TLS patch 
In-Reply-To: Message from Linus Torvalds <torvalds@transmeta.com> 
   of "Sat, 17 Aug 2002 11:36:53 PDT." <Pine.LNX.4.44.0208171134070.3169-100000@home.transmeta.com> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1619018740"
Date: Sat, 17 Aug 2002 17:34:01 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_1619018740
Content-Type: text/plain; charset=us-ascii

torvalds@transmeta.com said:
> The gdt descriptor alignment really shouldn't matter, but that bogus
> GDT  _size_ thing in the descriptor might do it. 

I knowit shouldn't, all I can say is that it does for me.

> Right now it's set to be 0x8000, which is not a legal GDT size (it
> should  be of the form n*8-1), and is nonsensical anyway (the comment
> says 2048  entries, but the fact is, we don't _have_ 2048 entries in
> there). 

I fixed this as part of my cleanups, but it doesn't actually make a difference 
to the voyagers.  What kills them is either gdt not 8 bytes aligned in setup.S 
or %cs above about 0x30 when going from real to protected mode (once in 
protected mode, it will happily accept arbitrary descriptor values).

The attached patch should fix all of the issues in this thread

- Align boot time GDT on 16 byte boundary (per intel recommendation)
- Use minimal boot time GDT and switch to complex one after protected mode.
- intel recommended aligment of gdt_desc and idt_desc in boot/setup.S
- make the boot time gdt_desc have the correct length.
- intel recommended aligment of cpu_gdt_descr
- make cpu_gdt_table align exactly on a cache line

I really only care about the first two of these to boot my voyager systems, 
but fixing all the others may help future proof us for later intel chips (at 
least now we follow all of the intel guidelines).

James


--==_Exmh_1619018740
Content-Type: text/plain ; name="tmp.BK"; charset=us-ascii
Content-Description: tmp.BK
Content-Disposition: attachment; filename="tmp.BK"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.488, 2002-08-17 15:24:14-05:00, jejb@mulgrave.(none)
  Alter Boot to use minimal GDT different from protected mode run time
  GDT.   Also correct a variety of aligment issues to be in line with
  intel recommendations.


 arch/i386/boot/compressed/head.S |    8 ++++----
 arch/i386/boot/compressed/misc.c |    2 +-
 arch/i386/boot/setup.S           |   26 ++++++++++++++++----------
 arch/i386/kernel/head.S          |   22 +++++++++++++++++-----
 arch/i386/kernel/trampoline.S    |    6 +++---
 include/asm-i386/desc.h          |    1 +
 include/asm-i386/segment.h       |    8 ++++++++
 7 files changed, 50 insertions(+), 23 deletions(-)


diff -Nru a/arch/i386/boot/compressed/head.S b/arch/i386/boot/compressed/head.S
--- a/arch/i386/boot/compressed/head.S	Sat Aug 17 15:26:52 2002
+++ b/arch/i386/boot/compressed/head.S	Sat Aug 17 15:26:52 2002
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
--- a/arch/i386/boot/compressed/misc.c	Sat Aug 17 15:26:52 2002
+++ b/arch/i386/boot/compressed/misc.c	Sat Aug 17 15:26:52 2002
@@ -299,7 +299,7 @@
 struct {
 	long * a;
 	short b;
-	} stack_start = { & user_stack [STACK_SIZE] , __KERNEL_DS };
+	} stack_start = { & user_stack [STACK_SIZE] , __BOOT_DS };
 
 static void setup_normal_output_buffer(void)
 {
diff -Nru a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
--- a/arch/i386/boot/setup.S	Sat Aug 17 15:26:52 2002
+++ b/arch/i386/boot/setup.S	Sat Aug 17 15:26:52 2002
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
@@ -1006,13 +1006,15 @@
 
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
+	.align 16
 gdt:
-	.fill GDT_ENTRY_KERNEL_CS,8,0
+	.fill GDT_ENTRY_BOOT_CS,8,0
 
 	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
 	.word	0				# base address = 0
@@ -1025,13 +1027,17 @@
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
-	.word	0x8000				# gdt limit=2048,
-						#  256 GDT entries
 
+	.word	0				# alignment byte
+gdt_48:
+	.word	gdt_end - gdt - 1		# gdt limit
 	.word	0, 0				# gdt base (filled in later)
 
 # Include video setup & detection code
diff -Nru a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	Sat Aug 17 15:26:52 2002
+++ b/arch/i386/kernel/head.S	Sat Aug 17 15:26:52 2002
@@ -15,6 +15,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/desc.h>
+#include <asm/cache.h>
 
 #define OLD_CL_MAGIC_ADDR	0x90020
 #define OLD_CL_MAGIC		0xA33F
@@ -46,7 +47,7 @@
  * Set segments to known values
  */
 	cld
-	movl $(__KERNEL_DS),%eax
+	movl $(__BOOT_DS),%eax
 	movl %eax,%ds
 	movl %eax,%es
 	movl %eax,%fs
@@ -306,7 +307,7 @@
 
 ENTRY(stack_start)
 	.long init_thread_union+8192
-	.long __KERNEL_DS
+	.long __BOOT_DS
 
 /* This is the default interrupt "handler" :-) */
 int_msg:
@@ -349,12 +350,12 @@
 	.long idt_table
 
 # boot GDT descriptor (later on used by CPU#0):
-
+	.word 0				# 32 bit align gdt_desc.address
 cpu_gdt_descr:
 	.word GDT_ENTRIES*8-1
 	.long cpu_gdt_table
 
-	.fill NR_CPUS-1,6,0		# space for the other GDT descriptors
+	.fill NR_CPUS-1,8,0		# space for the other GDT descriptors
 
 /*
  * This is initialized to create an identity-mapping at 0-8M (for bootup
@@ -405,10 +406,21 @@
  */
 .data
 
-ALIGN
 /*
  * The Global Descriptor Table contains 28 quadwords, per-CPU.
  */
+#ifdef CONFIG_SMP
+/*
+ * The boot_gdt_table must mirror the equivalent in setup.S and is
+ * used only by the trampoline for booting other CPUs
+ */
+	.align L1_CACHE_BYTES
+ENTRY(boot_gdt_table)
+	.fill GDT_ENTRY_BOOT_CS,8,0
+	.quad 0x00cf9a000000ffff	/* kernel 4GB code at 0x00000000 */
+	.quad 0x00cf92000000ffff	/* kernel 4GB data at 0x00000000 */
+#endif
+	.align L1_CACHE_BYTES
 ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* NULL descriptor */
 	.quad 0x0000000000000000	/* 0x0b reserved */
diff -Nru a/arch/i386/kernel/trampoline.S b/arch/i386/kernel/trampoline.S
--- a/arch/i386/kernel/trampoline.S	Sat Aug 17 15:26:52 2002
+++ b/arch/i386/kernel/trampoline.S	Sat Aug 17 15:26:52 2002
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
diff -Nru a/include/asm-i386/desc.h b/include/asm-i386/desc.h
--- a/include/asm-i386/desc.h	Sat Aug 17 15:26:52 2002
+++ b/include/asm-i386/desc.h	Sat Aug 17 15:26:52 2002
@@ -13,6 +13,7 @@
 struct Xgt_desc_struct {
 	unsigned short size;
 	unsigned long address __attribute__((packed));
+	unsigned short pad;
 } __attribute__ ((packed));
 
 extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
diff -Nru a/include/asm-i386/segment.h b/include/asm-i386/segment.h
--- a/include/asm-i386/segment.h	Sat Aug 17 15:26:52 2002
+++ b/include/asm-i386/segment.h	Sat Aug 17 15:26:52 2002
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


begin 664 bkpatch5117
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
JT-"*2>^`[CTVWUDVWYF:G_XI$DL]_ZZHDD/BAK;G<<?\/]0"+"H`'0``
`
end

--==_Exmh_1619018740--


