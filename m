Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTLSIcK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 03:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTLSIcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 03:32:10 -0500
Received: from holomorphy.com ([199.26.172.102]:14486 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262051AbTLSIbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 03:31:55 -0500
Date: Fri, 19 Dec 2003 00:31:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 incorrect memory sizing (without a full BIOS)..
Message-ID: <20031219083148.GF22443@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0312190451210.9093@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312190451210.9093@skynet>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19, 2003 at 05:04:25AM +0000, Dave Airlie wrote:
> 	I've got an internal development board based on the Intel 815
> chipset and the Intel ACSFL mini-BIOS for embedded systems, and then using
> grub 0.93 to boot Linux.
> under 2.4 my memory is correctly sized at 256MB, but under 2.6 I'm only
> seeing 64MB,
[... e88/e820 snipped ...]
> So is this 2.6 just being more fussy about the contents of the e820 that
> my "BIOS" is supplying and falling back to the old style detection?

We've had one other report of something like this. I don't see any
obvious reason why setup.S should be failing in 2.6; diff below. It
could be some kind of binutils issue.

Could I get dmesg and .config from 2.4 and 2.5?


-- wli


The relevant code starts around line 293 and is untouched.

--- linux-2.4/arch/i386/boot/setup.S	2003-12-07 06:38:32.000000000 -0800
+++ linux-2.5/arch/i386/boot/setup.S	2003-12-05 18:58:56.000000000 -0800
@@ -44,13 +44,11 @@
  *
  * New A20 code ported from SYSLINUX by H. Peter Anvin. AMD Elan bugfixes
  * by Robert Schwebel, December 2001 <robert@schwebel.de>
- *
+ *    
  * BIOS Enhanced Disk Drive support
  * by Matt Domsch <Matt_Domsch@dell.com> October 2002
  * conformant to T13 Committee www.t13.org
  *   projects 1572D, 1484D, 1386D, 1226DT
- * disk signature read by Matt Domsch <Matt_Domsch@dell.com>
- *	and Andrew Wilks <Andrew_Wilks@dell.com> September 2003
  */
 
 #include <linux/config.h>
@@ -59,7 +57,7 @@
 #include <linux/compile.h>
 #include <asm/boot.h>
 #include <asm/e820.h>
-#include <asm/edd.h>
+#include <asm/edd.h>    
 #include <asm/page.h>
 	
 /* Signature words to ensure LILO loaded us right */
@@ -164,7 +162,7 @@
 					# can be located anywhere in
 					# low memory 0x10000 or higher.
 
-ramdisk_max:	.long __MAXMEM-1	# (Header version 0x0203 or later)
+ramdisk_max:	.long MAXMEM-1		# (Header version 0x0203 or later)
 					# The highest safe address for
 					# the contents of an initrd
 
@@ -215,7 +213,7 @@
 # Part of above routine, this one just prints ascii al
 prtchr:	pushw	%ax
 	pushw	%cx
-	xorb	%bh, %bh
+	movw	$7,%bx
 	movw	$0x01, %cx
 	movb	$0x0e, %ah
 	int	$0x10
@@ -478,6 +476,24 @@
 	movsb
 	popw	%ds
 no_mca:
+#ifdef CONFIG_X86_VOYAGER
+	movb	$0xff, 0x40	# flag on config found
+	movb	$0xc0, %al
+	mov	$0xff, %ah
+	int	$0x15		# put voyager config info at es:di
+	jc	no_voyager
+	movw	$0x40, %si	# place voyager info in apm table
+	cld
+	movw	$7, %cx
+voyager_rep:
+	movb	%es:(%di), %al
+	movb	%al,(%si)
+	incw	%di
+	incw	%si
+	decw	%cx
+	jnz	voyager_rep
+no_voyager:	
+#endif
 # Check for PS/2 pointing device
 	movw	%cs, %ax			# aka SETUPSEG
 	subw	$DELTA_INITSEG, %ax		# aka INITSEG
@@ -490,6 +506,17 @@
 	movw	$0xAA, (0x1ff)			# device present
 no_psmouse:
 
+#if defined(CONFIG_X86_SPEEDSTEP_SMI) || defined(CONFIG_X86_SPEEDSTEP_SMI_MODULE)
+	movl	$0x0000E980, %eax		# IST Support 
+	movl	$0x47534943, %edx		# Request value
+	int	$0x15
+
+	movl	%eax, (96)
+	movl	%ebx, (100)
+	movl	%ecx, (104)
+	movl	%edx, (108)
+#endif
+
 #if defined(CONFIG_APM) || defined(CONFIG_APM_MODULE)
 # Then check for an APM BIOS...
 						# %ds points to the bootsector
@@ -551,25 +578,6 @@
 #endif
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
-# Read the first sector of device 80h and store the 4-byte signature
-	movl	$0xFFFFFFFF, %eax
-	movl	%eax, (DISK80_SIG_BUFFER)	# assume failure
-	movb	$READ_SECTORS, %ah
-	movb	$1, %al				# read 1 sector
-	movb	$0x80, %dl			# from device 80
-	movb	$0, %dh				# at head 0
-	movw	$1, %cx				# cylinder 0, sector 0
-	pushw	%es
-	pushw	%ds
-	popw	%es
-	movw	$EDDBUF, %bx
-	int	$0x13
-	jc	disk_sig_done
-	movl	(EDDBUF+MBR_SIG_OFFSET), %eax
-	movl	%eax, (DISK80_SIG_BUFFER)	# store success
-disk_sig_done:
-	popw	%es
-
 # Do the BIOS Enhanced Disk Drive calls
 # This consists of two calls:
 #    int 13h ah=41h "Check Extensions Present"
@@ -591,13 +599,13 @@
 # A second one-byte buffer, EDDNR, in the empty_zero_page stores
 # the number of BIOS devices which exist, up to EDDMAXNR.
 # In setup.c, copy_edd() stores both empty_zero_page buffers away
-# for later use, as they would get overwritten otherwise.
+# for later use, as they would get overwritten otherwise. 
 # This code is sensitive to the size of the structs in edd.h
-edd_start:
+edd_start:  
 						# %ds points to the bootsector
        						# result buffer for fn48
     	movw	$EDDBUF+EDDEXTSIZE, %si		# in ds:si, fn41 results
-						# kept just before that
+						# kept just before that    
 	movb	$0, (EDDNR)			# zero value at EDDNR
     	movb	$0x80, %dl			# BIOS device 0x80
 
@@ -614,8 +622,8 @@
     	movb	%ah, %ds:-3(%si)		# store version
 	movw	%cx, %ds:-2(%si)		# store extensions
 	incb	(EDDNR)				# note that we stored something
-
-edd_get_device_params:
+        
+edd_get_device_params:  
 	movw	$EDDPARMSIZE, %ds:(%si)		# put size
     	movb	$GETDEVICEPARAMETERS, %ah	# Function 48
 	int	$0x13				# make the call
@@ -629,15 +637,15 @@
         incb	%dl				# increment to next device
        	cmpb	$EDDMAXNR, (EDDNR) 		# Out of space?
 	jb	edd_check_ext			# keep looping
-
-edd_done:
+    
+edd_done:   
 #endif
 
 # Now we want to move to protected mode ...
 	cmpw	$0, %cs:realmode_swtch
 	jz	rmodeswtch_normal
 
-	lcall	%cs:realmode_swtch
+	lcall	*%cs:realmode_swtch
 
 	jmp	rmodeswtch_end
 
@@ -751,8 +759,8 @@
 	movb $0x02, %al			# alternate A20 gate
 	outb %al, $0x92			# this works on SC410/SC520
 a20_elan_wait:
-        call a20_test
-        jz a20_elan_wait
+	call a20_test
+	jz a20_elan_wait
 	jmp a20_done
 #endif
 
@@ -761,6 +769,7 @@
 A20_ENABLE_LOOPS	= 255		# Total loops to try		
 
 
+#ifndef CONFIG_X86_VOYAGER
 a20_try_loop:
 
 	# First, see if we are on a system with no A20 gate.
@@ -779,11 +788,14 @@
 	jnz	a20_done
 
 	# Try enabling A20 through the keyboard controller
+#endif /* CONFIG_X86_VOYAGER */
 a20_kbc:
 	call	empty_8042
 
+#ifndef CONFIG_X86_VOYAGER
 	call	a20_test			# Just in case the BIOS worked
 	jnz	a20_done			# but had a delayed reaction.
+#endif
 
 	movb	$0xD1, %al			# command write
 	outb	%al, $0x64
@@ -793,6 +805,7 @@
 	outb	%al, $0x60
 	call	empty_8042
 
+#ifndef CONFIG_X86_VOYAGER
 	# Wait until a20 really *is* enabled; it can take a fair amount of
 	# time on certain systems; Toshiba Tecras are known to have this
 	# problem.
@@ -840,6 +853,7 @@
 	# If we get here, all is good
 a20_done:
 
+#endif /* CONFIG_X86_VOYAGER */
 # set up gdt and idt
 	lidt	idt_48				# load idt with 0,0
 	xorl	%eax, %eax			# Compute gdt_base
@@ -890,8 +904,11 @@
 	movw	%cs, %si
 	subw	$DELTA_INITSEG, %si
 	shll	$4, %esi			# Convert to 32-bit pointer
+
+# jump to startup_32 in arch/i386/kernel/head.S
+#	
 # NOTE: For high loaded big kernels we need a
-#	jmpi    0x100000,__KERNEL_CS
+#	jmpi    0x100000,__BOOT_CS
 #
 #	but we yet haven't reloaded the CS register, so the default size 
 #	of the target offset still is 16 bit.
@@ -902,7 +919,7 @@
 	.byte 0x66, 0xea			# prefix + jmpi-opcode
 code32:	.long	0x1000				# will be set to 0x100000
 						# for big kernels
-	.word	__KERNEL_CS
+	.word	__BOOT_CS
 
 # Here's a bunch of information about your current kernel..
 kernel_version:	.ascii	UTS_RELEASE
@@ -1006,6 +1023,7 @@
 	.string	"INT15 refuses to access high mem, giving up."
 
 
+#ifndef CONFIG_X86_VOYAGER
 # This routine tests whether or not A20 is enabled.  If so, it
 # exits with zf = 0.
 #
@@ -1036,6 +1054,8 @@
 	popw	%cx
 	ret	
 
+#endif /* CONFIG_X86_VOYAGER */
+
 # This routine checks that the keyboard command queue is empty
 # (after emptying the output buffers)
 #
@@ -1095,9 +1115,20 @@
 	ret
 
 # Descriptor tables
+#
+# NOTE: The intel manual says gdt should be sixteen bytes aligned for
+# efficiency reasons.  However, there are machines which are known not
+# to boot with misaligned GDTs, so alter this at your peril!  If you alter
+# GDT_ENTRY_BOOT_CS (in asm/segment.h) remember to leave at least two
+# empty GDT entries (one for NULL and one reserved).
+#
+# NOTE:	On some CPUs, the GDT must be 8 byte aligned.  This is
+# true for the Voyager Quad CPU card which will not boot without
+# This directive.  16 byte aligment is recommended by intel.
+#
+	.align 16
 gdt:
-	.word	0, 0, 0, 0			# dummy
-	.word	0, 0, 0, 0			# unused
+	.fill GDT_ENTRY_BOOT_CS,8,0
 
 	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
 	.word	0				# base address = 0
@@ -1110,13 +1141,17 @@
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
