Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267451AbTA3Ipl>; Thu, 30 Jan 2003 03:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267452AbTA3Ipl>; Thu, 30 Jan 2003 03:45:41 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:8462 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267451AbTA3Ipi>; Thu, 30 Jan 2003 03:45:38 -0500
Date: Thu, 30 Jan 2003 08:54:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: linux-visws-devel@lists.sf.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] visws support for 2.5.59
Message-ID: <20030130085457.A23075@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-visws-devel@lists.sf.net, linux-kernel@vger.kernel.org
References: <20030127074644.GB4648@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030127074644.GB4648@pazke>; from pazke@orbita1.ru on Mon, Jan 27, 2003 at 10:46:44AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

here some comments, I hope you'll submit visw support to Linus soon
(and I'll find one somewhere.. :)


@@ -380,7 +378,8 @@
 	  Otherwise, say N.
 
 config SMP
-	bool "Symmetric multi-processing support"
+	bool "Symmetric multi-processing support" if !X86_VISWS
+	default y if X86_VISWS

	I don't think there's a reason to not allow UP kernels on visws.

diff -urN -X /usr/share/dontdiff linux-2.5.59.vanilla/arch/i386/Makefile linux-2.5.59/arch/i386/Makefile
--- linux-2.5.59.vanilla/arch/i386/Makefile	Mon Jan 27 18:24:59 2003
+++ linux-2.5.59/arch/i386/Makefile	Sun Jan 19 18:43:10 2003
@@ -18,7 +18,7 @@
 
 LDFLAGS		:= -m elf_i386
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
-LDFLAGS_vmlinux := -e stext
+LDFLAGS_vmlinux :=
 LDFLAGS_BLOB	:= --format binary --oformat elf32-i386
 
 CFLAGS += -pipe


	IMHO the stext changes should be moved into a single patch in
	preparation of the visw support.

 
--- linux-2.5.59.vanilla/arch/i386/kernel/i8259.c	Wed Jan 15 20:37:20 2003
+++ linux-2.5.59/arch/i386/kernel/i8259.c	Sun Jan 19 18:43:10 2003
@@ -22,6 +22,7 @@
 #include <asm/desc.h>
 #include <asm/apic.h>
 #include <asm/arch_hooks.h>
+#include <asm/i8259.h>

	Dito for the i8259 and generic apic code changes (!?)

 
--- linux-2.5.59.vanilla/arch/i386/kernel/trampoline.S	Wed Jan 15 20:37:20 2003
+++ linux-2.5.59/arch/i386/kernel/trampoline.S	Sun Jan 19 18:43:10 2003
@@ -46,8 +46,8 @@
 	movl	$0xA5A5A5A5, trampoline_data - r_base
 				# write marker for master knows we're running
 
-	lidt	idt_48 - r_base	# load idt with 0, 0
-	lgdt	gdt_48 - r_base	# load gdt with whatever is appropriate
+	lidt	boot_idt - r_base	# load idt with 0, 0
+	lgdt	boot_gdt - r_base	# load gdt with whatever is appropriate

	Again, GDT changes should be a separate preparation patch.

 
@@ -11,8 +13,15 @@
 ifdef	CONFIG_ACPI_PCI
 obj-y		+= acpi.o
 endif
-obj-y		+= legacy.o
 
+ifndef	CONFIG_X86_VISWS
+obj-y		+= legacy.o
+endif
 
 endif		# CONFIG_X86_NUMAQ
-obj-y		+= irq.o common.o
+
+ifndef	CONFIG_X86_VISWS
+obj-y		+= irq.o
+endif

What about grouping the two ifndefs?

diff -urN -X /usr/share/dontdiff linux-2.5.59.vanilla/drivers/net/eepro100.c linux-2.5.59/drivers/net/eepro100.c
--- linux-2.5.59.vanilla/drivers/net/eepro100.c	Wed Jan 15 20:37:20 2003
+++ linux-2.5.59/drivers/net/eepro100.c	Sun Jan 19 18:43:10 2003
@@ -306,6 +306,10 @@
 	outw(val, port);
 }
 
+#ifdef CONFIG_X86_VISWS
+#define USE_IO
+#endif
+

	Separate patch probably.  I think you should just submit this
	one to jgarzik ASAP, independant of the other bits.
	A small cleanup suggestion would be turning USE_IO into a config
	option that is implied by CONFIG_X86_VISWS...

diff -urN -X /usr/share/dontdiff linux-2.5.59.vanilla/drivers/video/Kconfig linux-2.5.59/drivers/video/Kconfig
--- linux-2.5.59.vanilla/drivers/video/Kconfig	Mon Jan 27 18:25:07 2003
+++ linux-2.5.59/drivers/video/Kconfig	Sun Jan 19 18:43:10 2003
@@ -363,7 +363,7 @@
 
 config FB_SGIVW
 	tristate "SGI Visual Workstation framebuffer support"
-	depends on FB && VISWS
+	depends on FB && X86_VISWS

	Oops, I missed this instance :)  

diff -urN -X /usr/share/dontdiff linux-2.5.59.vanilla/drivers/video/sgivwfb.c linux-2.5.59/drivers/video/sgivwfb.c
--- linux-2.5.59.vanilla/drivers/video/sgivwfb.c	Wed Jan 15 20:37:20 2003
+++ linux-2.5.59/drivers/video/sgivwfb.c	Mon Jan 27 19:03:53 2003

	The fb driver should be a separate patch again.  As it doesn't
	currently work I'd suggest submitting it to James Simmons ASAP.

diff -urN -X /usr/share/dontdiff linux-2.5.59.vanilla/include/asm-i386/sgi-cobalt.h linux-2.5.59/include/asm-i386/sgi-cobalt.h
--- linux-2.5.59.vanilla/include/asm-i386/sgi-cobalt.h	Thu Jan  1 03:00:00 1970
+++ linux-2.5.59/include/asm-i386/sgi-cobalt.h	Sun Jan 19 18:43:10 2003

	I think this should be include/asm-i386/mach-visws/cobalt.h instead.

diff -urN -X /usr/share/dontdiff linux-2.5.59.vanilla/include/asm-i386/sgi-lithium.h linux-2.5.59/include/asm-i386/sgi-lithium.h
--- linux-2.5.59.vanilla/include/asm-i386/sgi-lithium.h	Thu Jan  1 03:00:00 1970
+++ linux-2.5.59/include/asm-i386/sgi-lithium.h	Sun Jan 19 18:43:10 2003

	Dito (include/asm-i386/mach-visws/lithium.h)

diff -urN -X /usr/share/dontdiff linux-2.5.59.vanilla/include/asm-i386/sgi-piix.h linux-2.5.59/include/asm-i386/sgi-piix.h
--- linux-2.5.59.vanilla/include/asm-i386/sgi-piix.h	Thu Jan  1 03:00:00 1970
+++ linux-2.5.59/include/asm-i386/sgi-piix.h	Sun Jan 19 18:43:10 2003

	What's really VisW-specific here (except that Linux doesn't poke the
	PIIX that much on normal PeeCees)?  IMHO it should be either
	include/asm-i386/piix.h or include/asm-i386/mach-visws/piix.h
	depending on that.

diff -urN -X /usr/share/dontdiff linux-2.5.59.vanilla/include/asm-i386/system.h linux-2.5.59/include/asm-i386/system.h
--- linux-2.5.59.vanilla/include/asm-i386/system.h	Wed Jan 15 20:37:20 2003
+++ linux-2.5.59/include/asm-i386/system.h	Mon Jan 27 18:43:23 2003
@@ -410,4 +410,10 @@
 #define BROKEN_ACPI_Sx		0x0001
 #define BROKEN_INIT_AFTER_S1	0x0002
 
+#ifdef CONFIG_X86_VISWS
+#define x86_visws	1
+#else
+#define x86_visws	0
+#endif

	Do we really need more than CONFIG_X86_VISWS and the mach-$foo
	abstraction?

diff -urN -X /usr/share/dontdiff linux-2.5.59.vanilla/sound/oss/vwsnd.c linux-2.5.59/sound/oss/vwsnd.c
--- linux-2.5.59.vanilla/sound/oss/vwsnd.c	Wed Jan 15 20:37:20 2003
+++ linux-2.5.59/sound/oss/vwsnd.c	Mon Jan 27 19:04:14 2003
@@ -144,13 +144,11 @@

	Again, I think the driver update should be submitted separately
	and ASAP.

