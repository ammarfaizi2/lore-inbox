Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSHGWcz>; Wed, 7 Aug 2002 18:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSHGWcz>; Wed, 7 Aug 2002 18:32:55 -0400
Received: from ppp-217-133-222-186.dialup.tiscali.it ([217.133.222.186]:27345
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S315806AbSHGWcp>; Wed, 7 Aug 2002 18:32:45 -0400
Subject: Re: [patch] tls-2.5.30-A1
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208071115290.4961-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208071115290.4961-100000@home.transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-h1r0v5j3ARmuM+F4a5mb"
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Aug 2002 00:36:06 +0200
Message-Id: <1028759766.11774.281.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h1r0v5j3ARmuM+F4a5mb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2002-08-07 at 20:33, Linus Torvalds wrote:
> 
> On Wed, 7 Aug 2002, Ingo Molnar wrote:
> > 
> > the attached patch (against BK-curr + Luca Barbieri's two TLS patches)  
> > does two things:
> > 
> >  - it implements a second TLS entry for Wine's purposes.
> 
> Guys, I really don't like how the segment map ends up getting uglier and
> uglier.
> 
> I would suggest:
>  - move all kernel-related (and thus non-visible to user space) segments 
>    up, and make the cacheline optimizations _there_. 
Done.
>  - keep the TLS entries contiguous, and make sure that segment 0040 (ie
>    GDT entry #8) is available to a TLS entry, since if I remember
>    correctly, that one is also magical for old Windows binaries for all
>    the wrong reasons (ie it was some system data area in DOS and in 
>    Windows 3.1)
Done. Segment 0x40 set to CPL 3.
>  - and for cleanliness bonus points: make the regular user data segments 
>    just another TLS segment that just happens to have default values. If 
>    the user wants to screw with its own segments, let it.
Bad idea: makes task switch slower without any practical advantage.
The user may load a TLS or LDT selector in %ds to get the same effect.
> Then, for double extra bonus points somebody should look into whether
> those damn PnP BIOS segments could be simply made to be TLS segments
> during module init. I don't know if that PnP stuff is required later or
> not.
Not sure what you mean. The current definition of TLS segments is "a
minimal number of GDT entries that are modified on task switch and that
can be set on a per-task basis so that the selectors can be loaded %fs
and %gs". How can kernel PNPBIOS segments fit in this definition?


The patch changes the descriptior layout so that LDT is in the kernel
segment cacheline, the 16-bit APM segments are together and user
segments are together. It also sets segment 0x40 CPL to 3.
__BOOT_CS and __BOOT_DS are introduced as the value of segment selectors
during boot (so that we don't have to enlarge the gdt in setup.s).

New layout:
 *   0 - null
 *   1 - PNPBIOS support (16->32 gate)
 *   2 - boot code segment
 *   3 - boot data segment
 *   4 - PNPBIOS support		<==== new cacheline
 *   5 - PNPBIOS support
 *   6 - PNPBIOS support
 *   7 - PNPBIOS support
 *   8 - APM BIOS support (0x400-0x1000)<==== new cacheline
 *   9 - APM BIOS support
 *  10 - APM BIOS support
 *  11 - APM BIOS support 
 *  12 - kernel code segment		<==== new cacheline
 *  13 - kernel data segment
 *  14 - TSS
 *  15 - LDT
 *  ------- start of user segments 
 *  16 - user code segment		<==== new cacheline
 *  17 - user data segment
 *  18 - Thread-Local Storage (TLS) segment #1
 *  19 - Thread-Local Storage (TLS) segment #2


diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/arch/i386/boot/compressed/head.S b/arch/i386/boot/compressed/head.S
--- a/arch/i386/boot/compressed/head.S	2002-07-20 21:12:21.000000000 +0200
+++ b/arch/i386/boot/compressed/head.S	2002-08-08 00:14:45.000000000 +0200
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
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/arch/i386/boot/compressed/misc.c b/arch/i386/boot/compressed/misc.c
--- a/arch/i386/boot/compressed/misc.c	2002-07-20 21:11:24.000000000 +0200
+++ b/arch/i386/boot/compressed/misc.c	2002-08-07 23:48:58.000000000 +0200
@@ -299,7 +299,7 @@
 struct {
 	long * a;
 	short b;
-	} stack_start = { & user_stack [STACK_SIZE] , __KERNEL_DS };
+	} stack_start = { & user_stack [STACK_SIZE] , __BOOT_DS };
 
 static void setup_normal_output_buffer(void)
 {
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
--- a/arch/i386/boot/setup.S	2002-07-20 21:11:05.000000000 +0200
+++ b/arch/i386/boot/setup.S	2002-08-08 00:14:30.000000000 +0200
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
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	2002-08-07 19:03:24.000000000 +0200
+++ b/arch/i386/kernel/head.S	2002-08-08 00:08:48.000000000 +0200
@@ -46,7 +46,7 @@
  * Set segments to known values
  */
 	cld
-	movl $(__KERNEL_DS),%eax
+	movl $(__BOOT_DS),%eax
 	movl %eax,%ds
 	movl %eax,%es
 	movl %eax,%fs
@@ -239,12 +239,7 @@
 	movl %eax,%es
 	movl %eax,%fs
 	movl %eax,%gs
-#ifdef CONFIG_SMP
-	movl $(__KERNEL_DS), %eax
-	movl %eax,%ss		# Reload the stack pointer (segment only)
-#else
-	lss stack_start,%esp	# Load processor stack
-#endif
+	movl %eax,%ss
 	xorl %eax,%eax
 	lldt %ax
 	cld			# gcc2 wants the direction flag cleared at all times
@@ -311,7 +306,7 @@
 
 ENTRY(stack_start)
 	.long init_thread_union+8192
-	.long __KERNEL_DS
+	.long __BOOT_DS
 
 /* This is the default interrupt "handler" :-) */
 int_msg:
@@ -415,31 +410,30 @@
  * The Global Descriptor Table contains 20 quadwords, per-CPU.
  */
 ENTRY(cpu_gdt_table)
-	.quad 0x0000000000000000	/* NULL descriptor */
-	.quad 0x0000000000000000	/* TSS descriptor */
-	.quad 0x00cf9a000000ffff	/* 0x10 kernel 4GB code at 0x00000000 */
-	.quad 0x00cf92000000ffff	/* 0x18 kernel 4GB data at 0x00000000 */
-	.quad 0x00cffa000000ffff	/* 0x23 user   4GB code at 0x00000000 */
-	.quad 0x00cff2000000ffff	/* 0x2b user   4GB data at 0x00000000 */
-	.quad 0x0000000000000000	/* TLS descriptor */
-	.quad 0x0000000000000000	/* LDT descriptor */
+	.quad 0x0000000000000000	/* 0x00 NULL descriptor */
+	.quad 0x00c09a0000000000	/* 0x08 PNPBIOS 32-bit code */	
+	.quad 0x00cf9a000000ffff	/* 0x10 boot 4GB code at 0x00000000 */
+	.quad 0x00cf92000000ffff	/* 0x18 boot 4GB data at 0x00000000 */
+	.quad 0x00809a0000000000	/* 0x20 PNPBIOS 16-bit code */
+	.quad 0x0080920000000000	/* 0x28 PNPBIOS 16-bit data */
+	.quad 0x0080920000000000	/* 0x30 PNPBIOS 16-bit data */
+	.quad 0x0080920000000000	/* 0x38 PNPBIOS 16-bit data */
 	/*
 	 * The APM segments have byte granularity and their bases
 	 * and limits are set at run time.
 	 */
-	.quad 0x0040920000000000	/* 0x40 APM set up for bad BIOS's */
+	.quad 0x0040f20000000000	/* 0x40 APM set up for bad BIOS's */
 	.quad 0x00409a0000000000	/* 0x48 APM CS    code */
 	.quad 0x00009a0000000000	/* 0x50 APM CS 16 code (16 bit) */
 	.quad 0x0040920000000000	/* 0x58 APM DS    data */
-	/* Segments used for calling PnP BIOS */
-	.quad 0x00c09a0000000000	/* 0x60 32-bit code */
-	.quad 0x00809a0000000000	/* 0x68 16-bit code */
-	.quad 0x0080920000000000	/* 0x70 16-bit data */
-	.quad 0x0080920000000000	/* 0x78 16-bit data */
-	.quad 0x0080920000000000	/* 0x80 16-bit data */
-	.quad 0x0000000000000000	/* 0x88 not used */
-	.quad 0x0000000000000000	/* 0x90 not used */
-	.quad 0x0000000000000000	/* 0x98 not used */
+	.quad 0x00cf9a000000ffff	/* 0x60 kernel 4GB code at 0x00000000 */
+	.quad 0x00cf92000000ffff	/* 0x68 kernel 4GB data at 0x00000000 */
+	.quad 0x0000000000000000	/* 0x70 TSS descriptor */	
+	.quad 0x0000000000000000	/* 0x78 LDT descriptor */
+	.quad 0x00cffa000000ffff	/* 0x80 user   4GB code at 0x00000000 */
+	.quad 0x00cff2000000ffff	/* 0x88 user   4GB data at 0x00000000 */
+	.quad 0x0000000000000000	/* 0x90 TLS1 descriptor */
+	.quad 0x0000000000000000	/* 0x98 TLS2 descriptor */
 
 #if CONFIG_SMP
 	.fill (NR_CPUS-1)*GDT_ENTRIES,8,0 /* other CPU's GDT */
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/drivers/pnp/pnpbios_core.c b/drivers/pnp/pnpbios_core.c
--- a/drivers/pnp/pnpbios_core.c	2002-08-02 01:19:05.000000000 +0200
+++ b/drivers/pnp/pnpbios_core.c	2002-08-08 00:03:13.000000000 +0200
@@ -90,12 +90,13 @@
 static union pnp_bios_expansion_header * pnp_bios_hdr = NULL;
 
 /* The PnP BIOS entries in the GDT */
-#define PNP_GDT    (0x0060)
-#define PNP_CS32   (PNP_GDT+0x00)	/* segment for calling fn */
-#define PNP_CS16   (PNP_GDT+0x08)	/* code segment for BIOS */
-#define PNP_DS     (PNP_GDT+0x10)	/* data segment for BIOS */
-#define PNP_TS1    (PNP_GDT+0x18)	/* transfer data segment */
-#define PNP_TS2    (PNP_GDT+0x20)	/* another data segment */
+#define PNP_CS32   (0x08)	/* segment for calling fn */
+
+#define PNP_GDT    (0x20)
+#define PNP_CS16   (PNP_GDT+0x00)	/* code segment for BIOS */
+#define PNP_DS     (PNP_GDT+0x08)	/* data segment for BIOS */
+#define PNP_TS1    (PNP_GDT+0x10)	/* transfer data segment */
+#define PNP_TS2    (PNP_GDT+0x18)	/* another data segment */
 
 /* 
  * These are some opcodes for a "static asmlinkage"
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/include/asm-i386/desc.h b/include/asm-i386/desc.h
--- a/include/asm-i386/desc.h	2002-08-07 21:27:54.000000000 +0200
+++ b/include/asm-i386/desc.h	2002-08-08 00:12:01.000000000 +0200
@@ -7,30 +7,31 @@
  * The layout of the per-CPU GDT under Linux:
  *
  *   0 - null
- *   1 - TSS
- *   2 - kernel code segment
- *   3 - kernel data segment
- *   4 - user code segment		<==== new cacheline
- *   5 - user data segment
- *   6 - Thread-Local Storage (TLS) segment #1
- *   7 - LDT
- *   8 - APM BIOS support		<==== new cacheline
+ *   1 - PNPBIOS support (16->32 gate)
+ *   2 - boot code segment
+ *   3 - boot data segment
+ *   4 - PNPBIOS support		<==== new cacheline
+ *   5 - PNPBIOS support
+ *   6 - PNPBIOS support
+ *   7 - PNPBIOS support
+ *   8 - APM BIOS support (0x400-0x1000)<==== new cacheline
  *   9 - APM BIOS support
  *  10 - APM BIOS support
- *  11 - APM BIOS support
- *  12 - PNPBIOS support		<==== new cacheline
- *  13 - PNPBIOS support
- *  14 - PNPBIOS support
- *  15 - PNPBIOS support
- *  16 - PNPBIOS support		<==== new cacheline
- *  17 - TLS segment #2
- *  18 - not used
- *  19 - not used
+ *  11 - APM BIOS support 
+ *  12 - kernel code segment		<==== new cacheline
+ *  13 - kernel data segment
+ *  14 - TSS
+ *  15 - LDT
+ *  ------- start of user segments 
+ *  16 - user code segment		<==== new cacheline
+ *  17 - user data segment
+ *  18 - Thread-Local Storage (TLS) segment #1
+ *  19 - Thread-Local Storage (TLS) segment #2
  */
-#define TSS_ENTRY 1
-#define TLS_ENTRY1 6
-#define TLS_ENTRY2 17
-#define LDT_ENTRY 7
+#define TSS_ENTRY 14
+#define LDT_ENTRY 15
+#define TLS_ENTRY1 18
+#define TLS_ENTRY2 19
 /*
  * The interrupt descriptor table has room for 256 idt's,
  * the global descriptor table is dependent on the number
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/include/asm-i386/segment.h b/include/asm-i386/segment.h
--- a/include/asm-i386/segment.h	2002-07-20 21:11:11.000000000 +0200
+++ b/include/asm-i386/segment.h	2002-08-07 23:50:08.000000000 +0200
@@ -1,10 +1,13 @@
 #ifndef _ASM_SEGMENT_H
 #define _ASM_SEGMENT_H
 
-#define __KERNEL_CS	0x10
-#define __KERNEL_DS	0x18
+#define __BOOT_CS	0x10
+#define __BOOT_DS	0x18
 
-#define __USER_CS	0x23
-#define __USER_DS	0x2B
+#define __KERNEL_CS	0x60
+#define __KERNEL_DS	0x68
+
+#define __USER_CS	0x83
+#define __USER_DS	0x8B
 
 #endif

--=-h1r0v5j3ARmuM+F4a5mb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9UaDWdjkty3ft5+cRAuxQAKCRiKd3sk4GzBWffQKf3i+6+BXb/ACfU8uv
6MguXHKyqtu5HRdefR5wl6E=
=++SJ
-----END PGP SIGNATURE-----

--=-h1r0v5j3ARmuM+F4a5mb--
