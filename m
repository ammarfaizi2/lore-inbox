Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283259AbRLIJXA>; Sun, 9 Dec 2001 04:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283254AbRLIJWw>; Sun, 9 Dec 2001 04:22:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28933 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283259AbRLIJWl>; Sun, 9 Dec 2001 04:22:41 -0500
Date: Sun, 9 Dec 2001 01:22:07 -0800
Message-Id: <200112090922.BAA11252@tazenda.transmeta.com>
From: "H. Peter Anvin" <hpa@zytor.com>
To: torvalds@transmeta.com, marcelo@kernel.org, linux-kernel@vger.kernel.org
Subject: Linux/i386 boot protocol version 2.03
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch is a fairly small and fully backwards compatible
change to the i386 boot protocol.  It makes the maximum legal initrd
address explicitly available to the boot loader, so it doesn't have to
guess.  To make matters worse, the current documentation specifies
0x3C000000 as the top address (exclusive), but the real address is
0x38000000.

This patch:

a) Bumps the boot protocol version number to 2.03;
b) Adds a field to the boot header which contains the maximum legal
   initrd address;
c) Slightly reorganizes a couple of macros to make (b) possible;
d) Documents this change and the actual behaviour for previous
   protocol versions.

The patch is against 2.4.17-pre6, but applies to 2.5.1-pre8 as well.

	-hpa



diff -ur stock3/linux-2.4.17-pre6/Documentation/i386/boot.txt linux-2.4.17-pre6/Documentation/i386/boot.txt
--- stock3/linux-2.4.17-pre6/Documentation/i386/boot.txt	Wed Nov  7 14:46:01 2001
+++ linux-2.4.17-pre6/Documentation/i386/boot.txt	Sun Dec  9 01:12:01 2001
@@ -2,7 +2,7 @@
 		     ----------------------------
 
 		    H. Peter Anvin <hpa@zytor.com>
-			Last update 2000-10-29
+			Last update 2001-12-09
 
 On the i386 platform, the Linux kernel uses a rather complicated boot
 convention.  This has evolved partially due to historical aspects, as
@@ -25,12 +25,15 @@
 Protocol 2.01:	(Kernel 1.3.76) Added a heap overrun warning.
 
 Protocol 2.02:	(Kernel 2.4.0-test3-pre3) New command line protocol.
-		Lower the conventional memory ceiling.  No overwrite
+		Lower the conventional memory ceiling.	No overwrite
 		of the traditional setup area, thus making booting
 		safe for systems which use the EBDA from SMM or 32-bit
 		BIOS entry points.  zImage deprecated but still
 		supported.
 
+Protocol 2.03:	(???) Explicitly makes the highest possible initrd address
+		available to the bootloader.
+
 
 **** MEMORY LAYOUT
 
@@ -45,7 +48,7 @@
 098000	+------------------------+	
 	|  Kernel setup		 |	The kernel real-mode code.
 090200	+------------------------+
-	|  Kernel boot sector    |	The kernel legacy boot sector.
+	|  Kernel boot sector	 |	The kernel legacy boot sector.
 090000	+------------------------+
 	|  Protected-mode kernel |	The bulk of the kernel image.
 010000	+------------------------+
@@ -62,7 +65,7 @@
 When using bzImage, the protected-mode kernel was relocated to
 0x100000 ("high memory"), and the kernel real-mode block (boot sector,
 setup, and stack/heap) was made relocatable to any address between
-0x10000 and end of low memory.  Unfortunately, in protocols 2.00 and
+0x10000 and end of low memory.	Unfortunately, in protocols 2.00 and
 2.01 the command line is still required to live in the 0x9XXXX memory
 range, and that memory range is still overwritten by the early kernel.
 The 2.02 protocol fixes that.
@@ -71,7 +74,7 @@
 low memory touched by the boot loader -- as low as possible, since
 some newer BIOSes have begun to allocate some rather large amounts of
 memory, called the Extended BIOS Data Area, near the top of low
-memory.  The boot loader should use the "INT 12h" BIOS call to verify
+memory.	 The boot loader should use the "INT 12h" BIOS call to verify
 how much low memory is available.
 
 Unfortunately, if INT 12h reports that the amount of memory is too
@@ -123,6 +126,7 @@
 0224/2	2.01+	heap_end_ptr	Free memory after setup end
 0226/2	N/A	pad1		Unused
 0228/4	2.02+	cmd_line_ptr	32-bit pointer to the kernel command line
+022C/4	2.03+	initrd_addr_max	Highest legal initrd address
 
 For backwards compatibility, if the setup_sects field contains 0, the
 real value is 4.
@@ -180,9 +184,9 @@
 
 	The initrd should typically be located as high in memory as
 	possible, as it may otherwise get overwritten by the early
-	kernel initialization sequence.  However, it must never be
-	located above address 0x3C000000 if you want all kernels to
-	read it.
+	kernel initialization sequence.	 However, it must never be
+	located above the address specified in the initrd_addr_max
+	field.	The initrd should be at least 4K page aligned.
 
   cmd_line_ptr:
 	If the protocol version is 2.02 or higher, this is a 32-bit
@@ -192,7 +196,15 @@
 	command line, in which case you can point this to an empty
 	string (or better yet, to the string "auto".)  If this field
 	is left at zero, the kernel will assume that your boot loader
-	does not support the 2.02 protocol.
+	does not support the 2.02+ protocol.
+
+  ramdisk_max:
+	The maximum address that may be occupied by the initrd
+	contents.  For boot protocols 2.02 or earlier, this field is
+	not present, and the maximum address is 0x37FFFFFF.  (This
+	address is defined as the address of the highest safe byte, so
+	if your ramdisk is exactly 131072 bytes long and this field is
+	0x37FFFFFF, you can start your ramdisk at 0x37FE0000.)
 
 
 **** THE KERNEL COMMAND LINE
@@ -254,14 +266,14 @@
 		if ( protocol >= 0x0202 ) {
 			cmd_line_ptr = base_ptr + 0x9000;
 		} else {
-			cmd_line_magic  = 0xA33F;
+			cmd_line_magic	= 0xA33F;
 			cmd_line_offset = 0x9000;
 			setup_move_size = 0x9100;
 		}
 	} else {
 		/* Very old kernel */
 
-		cmd_line_magic  = 0xA33F;
+		cmd_line_magic	= 0xA33F;
 		cmd_line_offset = 0x9000;
 
 		/* A very old kernel MUST have its real-mode code
@@ -411,4 +423,3 @@
 
 	After completing your hook, you should jump to the address
 	that was in this field before your boot loader overwrote it.
-
diff -ur stock3/linux-2.4.17-pre6/arch/i386/boot/setup.S linux-2.4.17-pre6/arch/i386/boot/setup.S
--- stock3/linux-2.4.17-pre6/arch/i386/boot/setup.S	Sat Dec  8 23:48:42 2001
+++ linux-2.4.17-pre6/arch/i386/boot/setup.S	Sun Dec  9 01:05:29 2001
@@ -50,7 +50,8 @@
 #include <linux/compile.h>
 #include <asm/boot.h>
 #include <asm/e820.h>
-
+#include <asm/page.h>
+	
 /* Signature words to ensure LILO loaded us right */
 #define SIG1	0xAA55
 #define SIG2	0x5A5A
@@ -79,7 +80,7 @@
 # This is the setup header, and it must start at %cs:2 (old 0x9020:2)
 
 		.ascii	"HdrS"		# header signature
-		.word	0x0202		# header version number (>= 0x0105)
+		.word	0x0203		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
 realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
 start_sys_seg:	.word	SYSSEG
@@ -153,6 +154,10 @@
 					# can be located anywhere in
 					# low memory 0x10000 or higher.
 
+ramdisk_max:	.long __MAXMEM-1	# (Header version 0x0203 or later)
+					# The highest safe address for
+					# the contents of an initrd
+
 trampoline:	call	start_of_setup
 		.space	1024
 # End of setup header #####################################################
@@ -539,7 +544,7 @@
 	cmpw	$0, %cs:realmode_swtch
 	jz	rmodeswtch_normal
 
-	lcall	*%cs:realmode_swtch
+	lcall	%cs:realmode_swtch
 
 	jmp	rmodeswtch_end
 
diff -ur stock3/linux-2.4.17-pre6/arch/i386/kernel/setup.c linux-2.4.17-pre6/arch/i386/kernel/setup.c
--- stock3/linux-2.4.17-pre6/arch/i386/kernel/setup.c	Sat Dec  8 23:48:42 2001
+++ linux-2.4.17-pre6/arch/i386/kernel/setup.c	Sun Dec  9 00:45:42 2001
@@ -827,10 +827,8 @@
 #define PFN_PHYS(x)	((x) << PAGE_SHIFT)
 
 /*
- * 128MB for vmalloc and initrd
+ * Reserved space for vmalloc and iomap - defined in asm/page.h
  */
-#define VMALLOC_RESERVE	(unsigned long)(128 << 20)
-#define MAXMEM		(unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE)
 #define MAXMEM_PFN	PFN_DOWN(MAXMEM)
 #define MAX_NONPAE_PFN	(1 << 20)
 
diff -ur stock3/linux-2.4.17-pre6/include/asm-i386/page.h linux-2.4.17-pre6/include/asm-i386/page.h
--- stock3/linux-2.4.17-pre6/include/asm-i386/page.h	Thu Nov 22 11:46:18 2001
+++ linux-2.4.17-pre6/include/asm-i386/page.h	Sun Dec  9 00:51:43 2001
@@ -80,6 +80,12 @@
 
 #define __PAGE_OFFSET		(0xC0000000)
 
+/*
+ * This much address space is reserved for vmalloc() and iomap()
+ * as well as fixmap mappings.
+ */
+#define __VMALLOC_RESERVE	(128 << 20)
+
 #ifndef __ASSEMBLY__
 
 /*
@@ -118,6 +124,9 @@
 #endif /* __ASSEMBLY__ */
 
 #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
+#define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
+#define __MAXMEM		(-__PAGE_OFFSET-__VMALLOC_RESERVE)
+#define MAXMEM			((unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE))
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
 #define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
