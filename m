Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbWHQSoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWHQSoh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 14:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbWHQSoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 14:44:37 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:14232 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932570AbWHQSog
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 14:44:36 -0400
Date: Thu, 17 Aug 2006 14:44:01 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Horms <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>,
       fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060817184401.GA18458@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <20060804225611.GG19244@in.ibm.com> <m1k65onleq.fsf@ebiederm.dsl.xmission.com> <20060808033405.GA6767@verge.net.au> <44D813D7.3050004@zytor.com> <20060808060957.GC7681@verge.net.au> <m18xlz8zdo.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18xlz8zdo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 01:23:15AM -0600, Eric W. Biederman wrote:
> Horms <horms@verge.net.au> writes:
> 
> > On Mon, Aug 07, 2006 at 09:32:23PM -0700, H. Peter Anvin wrote:
> >> Horms wrote:
> >> >
> >> >I also agree that it is non-intitive. But I wonder if a cleaner
> >> >fix would be to remove CONFIG_PHYSICAL_START all together. Isn't
> >> >it just a work around for the kernel not being relocatable, or
> >> >are there uses for it that relocation can't replace?
> >> >
> >> 
> >> Yes, booting with the 2^n existing bootloaders.
> >
> > Ok, I must be confused then. I though CONFIG_PHYSICAL_START was
> > introduced in order to allow an alternative address to be provided for
> > kdump, and that previously it was hard-coded to some
> > architecture-specific value.
> >
> > What I was really getting as is if it needs to be configurable at
> > compile time or not. Obviously there needs to be some sane default
> > regardless.
> 
> CONFIG_PHYSICAL_START has had 2 uses.
> 1) To allow a kernel to run a completely different address for use
>    with kexec on panic.
> 2) To allow the kernel to be better aligned for better performance.
> 
> For maintenance reasons I propose we introduce CONFIG_PHYSICAL_ALIGN.
> Which will round our load address up to the nearest aligned address
> and run the kernel there.  That is roughly what I am doing on x86_64
> at this point.
> 
> s/CONFIG_PHYSICAL_START/CONFIG_PHYSICAL_ALIGN/ gives me well defined
> behavior and allows the alignment optimization without getting into 
> weird semantics.
> 
> Before CONFIG_PHYSICAL_START we _always_ ran the arch/i386 kernel
> where it was loaded and I assumed we always would.  Since people have
> realized better aligned kernels can run better this assumption became
> false.  Going to CONFIG_PHYSICAL_ALIGN allows us to return to the
> simple assumption of always running the kernel where it is loaded
> modulo a little extra alignment.
>

Hi Eric,

I have tried implementing your idea of replacing CONFIG_PHYSICAL_START
with CONFIG_PHYSICAL_ALIGN.  Please find attached the patch.

It applies on top of your relocatable kernel patch series.

I guess there should be a way for running kernel to tell user space
that what's the offset of the addr at which kernel is running to
the address for which kernel has been compiled. This info can be useful
for debuggers in case they happen to debug the core of a kernel which
was not running at compiled addr.

Thanks
Vivek

 


o Get rid of CONFIG_PHYSICAL_START and implement CONFIG_PHYSICAL_ALIGN

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/Kconfig                     |   34 ++++++++++++++++++----------------
 arch/i386/boot/bootsect.S             |    8 ++++----
 arch/i386/boot/compressed/head.S      |   28 ++++++++++++++++------------
 arch/i386/boot/compressed/misc.c      |    7 ++++---
 arch/i386/boot/compressed/vmlinux.lds |    3 +++
 arch/i386/kernel/vmlinux.lds.S        |    5 +++--
 include/asm-i386/boot.h               |    6 +++++-
 7 files changed, 53 insertions(+), 38 deletions(-)

diff -puN arch/i386/Kconfig~i386-implement-config-physical-align-option arch/i386/Kconfig
--- linux-2.6.18-rc3-1M/arch/i386/Kconfig~i386-implement-config-physical-align-option	2006-08-17 10:56:46.000000000 -0400
+++ linux-2.6.18-rc3-1M-root/arch/i386/Kconfig	2006-08-17 11:28:40.000000000 -0400
@@ -773,24 +773,26 @@ config RELOCATABLE
           must live at a different physical address than the primary
           kernel.
 
-config PHYSICAL_START
-	hex "Physical address where the kernel is loaded" if (EMBEDDED || CRASH_DUMP)
-
-	default "0x1000000" if CRASH_DUMP
+config PHYSICAL_ALIGN
+	hex "Alignment value to which kernel should be aligned" if (EMBEDDED)
 	default "0x100000"
-	range 0x100000 0x37c00000
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
+	  where kernel is loaded and run from. Kernel is compiled for an
+	  address which meets above alignment restriction.
+
+	  If bootloader loads the kernel at a non-aligned address and
+	  CONFIG_RELOCATABLE is set, kernel will move itself to nearest
+	  address aligned to above value and run from there.
+
+	  If bootloader loads the kernel at a non-aligned address and
+	  CONFIG_RELOCATABLE is not set, kernel will ignore the run time
+	  load address and decompress itself to the address it has been
+	  compiled for and run from there. The address for which kernel is
+	  compiled already meets above alignment restrictions. Hence the
+	  end result is that kernel runs from a physical address meeting above
+	  alignment restrictions.
 
 	  Don't change this unless you know what you are doing.
 
diff -puN include/asm-i386/boot.h~i386-implement-config-physical-align-option include/asm-i386/boot.h
--- linux-2.6.18-rc3-1M/include/asm-i386/boot.h~i386-implement-config-physical-align-option	2006-08-17 10:56:46.000000000 -0400
+++ linux-2.6.18-rc3-1M-root/include/asm-i386/boot.h	2006-08-17 10:56:46.000000000 -0400
@@ -12,4 +12,8 @@
 #define EXTENDED_VGA	0xfffe		/* 80x50 mode */
 #define ASK_VGA		0xfffd		/* ask for it at bootup */
 
-#endif
+/* Physical address where kenrel should be loaded. */
+#define LOAD_PHYSICAL_ADDR ((0x100000 + CONFIG_PHYSICAL_ALIGN - 1) \
+				& ~(CONFIG_PHYSICAL_ALIGN - 1))
+
+#endif /* _LINUX_BOOT_H */
diff -puN arch/i386/kernel/vmlinux.lds.S~i386-implement-config-physical-align-option arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.18-rc3-1M/arch/i386/kernel/vmlinux.lds.S~i386-implement-config-physical-align-option	2006-08-17 10:56:46.000000000 -0400
+++ linux-2.6.18-rc3-1M-root/arch/i386/kernel/vmlinux.lds.S	2006-08-17 10:56:46.000000000 -0400
@@ -2,13 +2,14 @@
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
  */
 
-#define LOAD_OFFSET __PAGE_OFFSET
+#define LOAD_OFFSET	__PAGE_OFFSET
 
 #include <linux/config.h>
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
 #include <asm/cache.h>
+#include <asm/boot.h>
 
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
@@ -16,7 +17,7 @@ ENTRY(phys_startup_32)
 jiffies = jiffies_64;
 SECTIONS
 {
-  . = LOAD_OFFSET + CONFIG_PHYSICAL_START;
+  . = LOAD_OFFSET + LOAD_PHYSICAL_ADDR;
   phys_startup_32 = startup_32 - LOAD_OFFSET;
   /* read-only */
   .text : AT(ADDR(.text) - LOAD_OFFSET) {
diff -puN arch/i386/boot/bootsect.S~i386-implement-config-physical-align-option arch/i386/boot/bootsect.S
--- linux-2.6.18-rc3-1M/arch/i386/boot/bootsect.S~i386-implement-config-physical-align-option	2006-08-17 10:56:46.000000000 -0400
+++ linux-2.6.18-rc3-1M-root/arch/i386/boot/bootsect.S	2006-08-17 12:37:19.000000000 -0400
@@ -69,7 +69,7 @@ ehdr:
 #endif
 	.word EM_386				# e_machine
 	.int  1					# e_version
-	.int  CONFIG_PHYSICAL_START		# e_entry
+	.int  LOAD_PHYSICAL_ADDR		# e_entry
 	.int  phdr - _start			# e_phoff
 	.int  0					# e_shoff
 	.int  0					# e_flags
@@ -90,12 +90,12 @@ normalize:
 phdr:
 	.int PT_LOAD					# p_type
 	.int (SETUPSECTS+1)*512				# p_offset
-	.int __PAGE_OFFSET + CONFIG_PHYSICAL_START	# p_vaddr
-	.int CONFIG_PHYSICAL_START			# p_paddr
+	.int LOAD_PHYSICAL_ADDR + __PAGE_OFFSET		# p_vaddr
+	.int LOAD_PHYSICAL_ADDR				# p_paddr
 	.int SYSSIZE*16					# p_filesz
 	.int 0						# p_memsz
 	.int PF_R | PF_W | PF_X				# p_flags
-	.int 4*1024*1024				# p_align
+	.int CONFIG_PHYSICAL_ALIGN			# p_align
 e_phdr1:
 
 	.int PT_NOTE					# p_type
diff -puN arch/i386/boot/compressed/vmlinux.lds~i386-implement-config-physical-align-option arch/i386/boot/compressed/vmlinux.lds
--- linux-2.6.18-rc3-1M/arch/i386/boot/compressed/vmlinux.lds~i386-implement-config-physical-align-option	2006-08-17 10:56:46.000000000 -0400
+++ linux-2.6.18-rc3-1M-root/arch/i386/boot/compressed/vmlinux.lds	2006-08-17 10:56:46.000000000 -0400
@@ -3,6 +3,9 @@ OUTPUT_ARCH(i386)
 ENTRY(startup_32)
 SECTIONS
 {
+        /* Be careful parts of head.S assume startup_32 is at
+         * address 0.
+	 */
 	. =  0 	;
 	.text.head : {
 		_head = . ;
diff -puN arch/i386/boot/compressed/head.S~i386-implement-config-physical-align-option arch/i386/boot/compressed/head.S
--- linux-2.6.18-rc3-1M/arch/i386/boot/compressed/head.S~i386-implement-config-physical-align-option	2006-08-17 10:56:46.000000000 -0400
+++ linux-2.6.18-rc3-1M-root/arch/i386/boot/compressed/head.S	2006-08-17 11:12:51.000000000 -0400
@@ -27,6 +27,7 @@
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/page.h>
+#include <asm/boot.h>
 
 .section ".text.head"
 	.globl startup_32
@@ -53,17 +54,19 @@ startup_32:
 1:	popl %ebp
 	subl $1b, %ebp
 
-/* Compute the delta between where we were compiled to run at
- * and where the code will actually run at.
+
+/* %ebp contains the address we are loaded at by the boot loader and %ebx
+ * contains the address where we should move the kernel image temporarily
+ * for safe in-place decompression.
  */
-	/* Start with the delta to where the kernel will run at.  If we are
-	 * a relocatable kernel this is the delta to our load address otherwise
-	 * this is the delta to CONFIG_PHYSICAL start.
-	 */
+
 #ifdef CONFIG_RELOCTABLE
-	movl %ebp, %ebx
+	movl 	%ebp, %ebx
+	addl    $(CONFIG_PHYSICAL_ALIGN - 1), %ebx
+	andl    $(~(CONFIG_PHYSICAL_ALIGN - 1)), %ebx
+
 #else
-	movl $(CONFIG_PHYSICAL_START - startup_32), %ebx
+	movl $LOAD_PHYSICAL_ADDR, %ebx
 #endif
 
 	/* Replace the compressed data size with the uncompressed size */
@@ -95,9 +98,10 @@ startup_32:
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
@@ -151,8 +155,8 @@ relocated:
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
--- linux-2.6.18-rc3-1M/arch/i386/boot/compressed/misc.c~i386-implement-config-physical-align-option	2006-08-17 10:56:46.000000000 -0400
+++ linux-2.6.18-rc3-1M-root/arch/i386/boot/compressed/misc.c	2006-08-17 11:19:05.000000000 -0400
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include <asm/setup.h>
 #include <asm/page.h>
+#include <asm/boot.h>
 
 /* WARNING!!
  * This code is compiled with -fPIC and it is relocated dynamically
@@ -585,12 +586,12 @@ asmlinkage void decompress_kernel(void *
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
 
_
