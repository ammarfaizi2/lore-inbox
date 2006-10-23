Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWJWTtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWJWTtz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWJWTsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:48:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:4559 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965008AbWJWTsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:48:00 -0400
Date: Mon, 23 Oct 2006 15:42:06 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: [PATCH 10/11] i386: Implement CONFIG_PHYSICAL_ALIGN
Message-ID: <20061023194206.GK13263@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061023192456.GA13263@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023192456.GA13263@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Now CONFIG_PHYSICAL_START is being replaced with CONFIG_PHYSICAL_ALIGN.
  Hardcoding the kernel physical start value creates a problem in relocatable
  kernel context due to boot loader limitations. For ex, if somebody
  compiles a relocatable kernel to be run from address 4MB, but this kernel
  will run from location 1MB as grub loads the kernel at physical address
  1MB. Kernel thinks that I am a relocatable kernel and I should run from
  the address I have been loaded at. So somebody wanting to run kernel
  from 4MB alignment location (for improved performance regions) can't do
  that.

o Hence, Eric proposed that probably CONFIG_PHYSICAL_ALIGN will make
  more sense in relocatable kernel context. At run time kernel will move
  itself to a physical addr location which meets user specified alignment
  restrictions.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/Kconfig                |   33 ++++++++++++++++++---------------
 arch/i386/boot/compressed/head.S |   26 ++++++++++++++------------
 arch/i386/boot/compressed/misc.c |    7 ++++---
 arch/i386/kernel/vmlinux.lds.S   |    3 ++-
 include/asm-i386/boot.h          |    6 +++++-
 5 files changed, 43 insertions(+), 32 deletions(-)

diff -puN arch/i386/boot/compressed/head.S~i386-implement-config-physical-align-option arch/i386/boot/compressed/head.S
--- linux-2.6.19-rc2-git7-reloc/arch/i386/boot/compressed/head.S~i386-implement-config-physical-align-option	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/boot/compressed/head.S	2006-10-23 13:15:21.000000000 -0400
@@ -26,6 +26,7 @@
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/page.h>
+#include <asm/boot.h>
 
 .section ".text.head"
 	.globl startup_32
@@ -52,17 +53,17 @@ startup_32:
 1:	popl %ebp
 	subl $1b, %ebp
 
-/* Compute the delta between where we were compiled to run at
- * and where the code will actually run at.
+/* %ebp contains the address we are loaded at by the boot loader and %ebx
+ * contains the address where we should move the kernel image temporarily
+ * for safe in-place decompression.
  */
-	/* Start with the delta to where the kernel will run at.  If we are
-	 * a relocatable kernel this is the delta to our load address otherwise
-	 * this is the delta to CONFIG_PHYSICAL start.
-	 */
+
 #ifdef CONFIG_RELOCATABLE
-	movl %ebp, %ebx
+	movl 	%ebp, %ebx
+	addl    $(CONFIG_PHYSICAL_ALIGN - 1), %ebx
+	andl    $(~(CONFIG_PHYSICAL_ALIGN - 1)), %ebx
 #else
-	movl $(CONFIG_PHYSICAL_START - startup_32), %ebx
+	movl $LOAD_PHYSICAL_ADDR, %ebx
 #endif
 
 	/* Replace the compressed data size with the uncompressed size */
@@ -94,9 +95,10 @@ startup_32:
 /* Compute the kernel start address.
  */
 #ifdef CONFIG_RELOCATABLE
-	leal	startup_32(%ebp), %ebp
+	addl    $(CONFIG_PHYSICAL_ALIGN - 1), %ebp
+	andl    $(~(CONFIG_PHYSICAL_ALIGN - 1)), %ebp
 #else
-	movl	$CONFIG_PHYSICAL_START, %ebp
+	movl	$LOAD_PHYSICAL_ADDR, %ebp
 #endif
 
 /*
@@ -150,8 +152,8 @@ relocated:
  * and where it was actually loaded.
  */
 	movl %ebp, %ebx
-	subl $CONFIG_PHYSICAL_START, %ebx
-
+	subl $LOAD_PHYSICAL_ADDR, %ebx
+	jz   2f		/* Nothing to be done if loaded at compiled addr. */
 /*
  * Process relocations.
  */
diff -puN arch/i386/boot/compressed/misc.c~i386-implement-config-physical-align-option arch/i386/boot/compressed/misc.c
--- linux-2.6.19-rc2-git7-reloc/arch/i386/boot/compressed/misc.c~i386-implement-config-physical-align-option	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/boot/compressed/misc.c	2006-10-23 13:15:21.000000000 -0400
@@ -14,6 +14,7 @@
 #include <linux/screen_info.h>
 #include <asm/io.h>
 #include <asm/page.h>
+#include <asm/boot.h>
 
 /* WARNING!!
  * This code is compiled with -fPIC and it is relocated dynamically
@@ -360,12 +361,12 @@ asmlinkage void decompress_kernel(void *
 	insize = input_len;
 	inptr  = 0;
 
-	if (((u32)output - CONFIG_PHYSICAL_START) & 0x3fffff)
-		error("Destination address not 4M aligned");
+	if ((u32)output & (CONFIG_PHYSICAL_ALIGN -1))
+		error("Destination address not CONFIG_PHYSICAL_ALIGN aligned");
 	if (end > ((-__PAGE_OFFSET-(512 <<20)-1) & 0x7fffffff))
 		error("Destination address too large");
 #ifndef CONFIG_RELOCATABLE
-	if ((u32)output != CONFIG_PHYSICAL_START)
+	if ((u32)output != LOAD_PHYSICAL_ADDR)
 		error("Wrong destination address");
 #endif
 
diff -puN arch/i386/Kconfig~i386-implement-config-physical-align-option arch/i386/Kconfig
--- linux-2.6.19-rc2-git7-reloc/arch/i386/Kconfig~i386-implement-config-physical-align-option	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/Kconfig	2006-10-23 13:15:21.000000000 -0400
@@ -785,23 +785,26 @@ config RELOCATABLE
           must live at a different physical address than the primary
           kernel.
 
-config PHYSICAL_START
-	hex "Physical address where the kernel is loaded" if (EMBEDDED || CRASH_DUMP)
-
-	default "0x1000000" if CRASH_DUMP
+config PHYSICAL_ALIGN
+	hex "Alignment value to which kernel should be aligned"
 	default "0x100000"
+	range 0x2000 0x400000
 	help
-	  This gives the physical address where the kernel is loaded. Normally
-	  for regular kernels this value is 0x100000 (1MB). But in the case
-	  of kexec on panic the fail safe kernel needs to run at a different
-	  address than the panic-ed kernel. This option is used to set the load
-	  address for kernels used to capture crash dump on being kexec'ed
-	  after panic. The default value for crash dump kernels is
-	  0x1000000 (16MB). This can also be set based on the "X" value as
-	  specified in the "crashkernel=YM@XM" command line boot parameter
-	  passed to the panic-ed kernel. Typically this parameter is set as
-	  crashkernel=64M@16M. Please take a look at
-	  Documentation/kdump/kdump.txt for more details about crash dumps.
+	  This value puts the alignment restrictions on physical address
+ 	  where kernel is loaded and run from. Kernel is compiled for an
+ 	  address which meets above alignment restriction.
+
+ 	  If bootloader loads the kernel at a non-aligned address and
+ 	  CONFIG_RELOCATABLE is set, kernel will move itself to nearest
+ 	  address aligned to above value and run from there.
+
+ 	  If bootloader loads the kernel at a non-aligned address and
+ 	  CONFIG_RELOCATABLE is not set, kernel will ignore the run time
+ 	  load address and decompress itself to the address it has been
+ 	  compiled for and run from there. The address for which kernel is
+ 	  compiled already meets above alignment restrictions. Hence the
+ 	  end result is that kernel runs from a physical address meeting
+	  above alignment restrictions.
 
 	  Don't change this unless you know what you are doing.
 
diff -puN arch/i386/kernel/vmlinux.lds.S~i386-implement-config-physical-align-option arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.19-rc2-git7-reloc/arch/i386/kernel/vmlinux.lds.S~i386-implement-config-physical-align-option	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/kernel/vmlinux.lds.S	2006-10-23 13:15:21.000000000 -0400
@@ -8,6 +8,7 @@
 #include <asm/thread_info.h>
 #include <asm/page.h>
 #include <asm/cache.h>
+#include <asm/boot.h>
 
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
@@ -21,7 +22,7 @@ PHDRS {
 }
 SECTIONS
 {
-  . = LOAD_OFFSET + CONFIG_PHYSICAL_START;
+  . = LOAD_OFFSET + LOAD_PHYSICAL_ADDR;
   phys_startup_32 = startup_32 - LOAD_OFFSET;
   /* read-only */
   .text : AT(ADDR(.text) - LOAD_OFFSET) {
diff -puN include/asm-i386/boot.h~i386-implement-config-physical-align-option include/asm-i386/boot.h
--- linux-2.6.19-rc2-git7-reloc/include/asm-i386/boot.h~i386-implement-config-physical-align-option	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/include/asm-i386/boot.h	2006-10-23 13:15:21.000000000 -0400
@@ -12,4 +12,8 @@
 #define EXTENDED_VGA	0xfffe		/* 80x50 mode */
 #define ASK_VGA		0xfffd		/* ask for it at bootup */
 
-#endif
+/* Physical address where kenrel should be loaded. */
+#define LOAD_PHYSICAL_ADDR ((0x100000 + CONFIG_PHYSICAL_ALIGN - 1) \
+				& ~(CONFIG_PHYSICAL_ALIGN - 1))
+
+#endif /* _LINUX_BOOT_H */
_
