Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWJLSJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWJLSJp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWJLSJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:09:44 -0400
Received: from justus.rz.uni-saarland.de ([134.96.7.31]:45681 "EHLO
	justus.rz.uni-saarland.de") by vger.kernel.org with ESMTP
	id S1751059AbWJLSJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:09:43 -0400
Date: Thu, 12 Oct 2006 20:15:33 +0200
From: Alexander van Heukelum <heukelum@mailshack.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Coffman <johninsd@san.rr.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] Remove  lilo-loads-only-five-sectors-of-zImage-fixup from setup.S
Message-ID: <20061012181533.GA2901@mailshack.com>
References: <20061011163356.GA2022@mailshack.com> <452D3A11.5020100@zytor.com> <20061011194301.GA2084@mailshack.com> <6.2.3.4.0.20061012095229.048db398@pop-server.san.rr.com> <452E758E.2060701@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452E758E.2060701@zytor.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.1 (justus.rz.uni-saarland.de [134.96.7.31]); Thu, 12 Oct 2006 20:08:58 +0200 (CEST)
X-AntiVirus: checked by AntiVir Milter (version: 1.1.3-1; AVE: 7.2.0.30; VDF: 6.36.0.115; host: AntiVir1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 10:04:14AM -0700, H. Peter Anvin wrote:
> John Coffman wrote:
> >Alexander,
> >
> >You are referring to versions of LILO more than 8 years old.  Since 
> >version 21, when I took over maintenance from Werner, LILO has been 
> >sensitive to the boot protocol in use.  Peter has been kind enough to 
> >point out upgrades to the 2.00+ protocols when they have been introduced.
> >
> >All versions of LILO since version 21 should be able to correctly handle 
> >both zImage and bzImage kernels, old and new.  The command:  "lilo -V 
> >-v" should indicate the version of LILO you are using, and may indicate 
> >a release date.
> 
> We're talking old enough that it didn't support either bzImage or initrd.
> 
> 	-hpa

Hello John, Peter,

I didn't run into problems because of this ;). I found this by just
looking at the code. I've looked at the source of Bootlin, and that
one would have just crashed. I didn't check the case for lilo, but
just copied the accusation from a comment in setup.S.

So, how about the following patch?
I test-booted bzImages using Bochs.

Alexander


The real-mode kernel (on i386 and x86_64) checks if the bootloader
loaded it correctly. Bootlin and ancient versions of LILO disregarded
the setup_sects field in the bootsector and always just loaded the first
five sectors. If the kernel is compiled as a zImage, the real-mode
kernel is able to rectify the situation. At least it was, until the code
to do so was moved to the eighth sector in order to make space for more
E820 entries (commit: f9ba70535dc12d9eb57d466a2ecd749e16eca866). This
occured on 1 May 2005 and, as far as I know, noone has complained yet.
This patch removes the checks for the signature and the fixup code
completely. Following hpa's advice, it adds a check 'right away' at the
earliest possible opportunity, before the E820/EDD-reserved space.

The patch changes behaviour only if one tries to boot a kernel in zImage
format (very rare) with a bootloader that does not support boot protocol
2.00+. They will now see the message "Wrong bootloader, giving up...".

Signed-off-by: Alexander van Heukelum <heukelum@mailshack.com>
---
 arch/i386/boot/setup.S   |  134 ++++++++++++----------------------------------
 arch/x86_64/boot/setup.S |  134 ++++++++++++----------------------------------
 2 files changed, 72 insertions(+), 196 deletions(-)

diff --git a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
index 3aec453..33efcc6 100644
--- a/arch/i386/boot/setup.S
+++ b/arch/i386/boot/setup.S
@@ -52,8 +52,8 @@ #include <linux/compile.h>
 #include <asm/boot.h>
 #include <asm/e820.h>
 #include <asm/page.h>
-	
-/* Signature words to ensure LILO loaded us right */
+
+/* Signature words to mark the end of the real-mode kernel */
 #define SIG1	0xAA55
 #define SIG2	0x5A5A
 
@@ -160,36 +160,36 @@ ramdisk_max:	.long (-__PAGE_OFFSET-(512 
 					# The highest safe address for
 					# the contents of an initrd
 
-trampoline:	call	start_of_setup
-		.align 16
-					# The offset at this point is 0x240
-		.space	(0xeff-0x240+1) # E820 & EDD space (ending at 0xeff)
-# End of setup header #####################################################
-
-start_of_setup:
-# Bootlin depends on this being done early
-	movw	$0x01500, %ax
-	movb	$0x81, %dl
-	int	$0x13
-
-#ifdef SAFE_RESET_DISK_CONTROLLER
-# Reset the disk controller.
-	movw	$0x0000, %ax
-	movb	$0x80, %dl
-	int	$0x13
-#endif
-
-# Set %ds = %cs, we know that SETUPSEG = %cs at this point
-	movw	%cs, %ax		# aka SETUPSEG
-	movw	%ax, %ds
-# Check signature at end of setup
-	cmpw	$SIG1, setup_sig1
-	jne	bad_sig
-
-	cmpw	$SIG2, setup_sig2
-	jne	bad_sig
+trampoline:
+
+	# Fail with a message if the loader does not understand boot
+	# protocol 2.00 or later. This check is done early in order
+	# to catch truely ancient bootloaders that do not know about
+	# setup_sects. Assumptions: working stack and %cs = SETUPSEG.
+	cmpb	$0x00, %cs:(type_of_loader - start)
+	jz	bad_loader_alert
+	jmp	start_of_setup
+
+bad_loader_alert:
+	movw	$(bad_loader_msg - start), %si
+bad_loader_print:
+	movw	$0x0007, %bx
+	movw	$0x0e00, %ax
+	xorb	%cs:(%si), %al
+	jz	bad_loader_loop
+	int	$0x10
+	inc	%si
+	jmp	bad_loader_print
+bad_loader_loop:
+	hlt
+	jmp	bad_loader_loop
+bad_loader_msg:
+	.string	"Wrong bootloader, giving up..."
 
-	jmp	good_sig1
+	.align	0x80
+	# The offset at this point is 0x280
+	.space  (0xeff-0x280+1)	# E820 & EDD space (ending at 0xeff)
+# End of setup header #####################################################
 
 # Routine to print asciiz string at ds:si
 prtstr:
@@ -206,8 +206,8 @@ # Space printing
 prtsp2:	call	prtspc		# Print double space
 prtspc:	movb	$0x20, %al	# Print single space (note: fall-thru)
 
-# Part of above routine, this one just prints ascii al
-prtchr:	pushw	%ax
+prtchr:
+	pushw	%ax
 	pushw	%cx
 	movw	$7,%bx
 	movw	$0x01, %cx
@@ -219,76 +219,14 @@ prtchr:	pushw	%ax
 
 beep:	movb	$0x07, %al
 	jmp	prtchr
-	
-no_sig_mess: .string	"No setup signature found ..."
-
-good_sig1:
-	jmp	good_sig
-
-# We now have to find the rest of the setup code/data
-bad_sig:
-	movw	%cs, %ax			# SETUPSEG
-	subw	$DELTA_INITSEG, %ax		# INITSEG
-	movw	%ax, %ds
-	xorb	%bh, %bh
-	movb	(497), %bl			# get setup sect from bootsect
-	subw	$4, %bx				# LILO loads 4 sectors of setup
-	shlw	$8, %bx				# convert to words (1sect=2^8 words)
-	movw	%bx, %cx
-	shrw	$3, %bx				# convert to segment
-	addw	$SYSSEG, %bx
-	movw	%bx, %cs:start_sys_seg
-# Move rest of setup code/data to here
-	movw	$2048, %di			# four sectors loaded by LILO
-	subw	%si, %si
-	pushw	%cs
-	popw	%es
-	movw	$SYSSEG, %ax
-	movw	%ax, %ds
-	rep
-	movsw
-	movw	%cs, %ax			# aka SETUPSEG
-	movw	%ax, %ds
-	cmpw	$SIG1, setup_sig1
-	jne	no_sig
-
-	cmpw	$SIG2, setup_sig2
-	jne	no_sig
-
-	jmp	good_sig
-
-no_sig:
-	lea	no_sig_mess, %si
-	call	prtstr
 
-no_sig_loop:
-	hlt
-	jmp	no_sig_loop
-
-good_sig:
+start_of_setup:
+	# Set %ds = %cs, we know that SETUPSEG = %cs at this point
 	movw	%cs, %ax			# aka SETUPSEG
-	subw	$DELTA_INITSEG, %ax 		# aka INITSEG
+	subw	$DELTA_INITSEG, %ax		# aka INITSEG
 	movw	%ax, %ds
-# Check if an old loader tries to load a big-kernel
-	testb	$LOADED_HIGH, %cs:loadflags	# Do we have a big kernel?
-	jz	loader_ok			# No, no danger for old loaders.
-
-	cmpb	$0, %cs:type_of_loader 		# Do we have a loader that
-						# can deal with us?
-	jnz	loader_ok			# Yes, continue.
 
-	pushw	%cs				# No, we have an old loader,
-	popw	%ds				# die. 
-	lea	loader_panic_mess, %si
-	call	prtstr
-
-	jmp	no_sig_loop
-
-loader_panic_mess: .string "Wrong loader, giving up..."
-
-loader_ok:
 # Get memory size (extended mem, kB)
-
 	xorl	%eax, %eax
 	movl	%eax, (0x1e0)
 #ifndef STANDARD_MEMORY_BIOS_CALL
diff --git a/arch/x86_64/boot/setup.S b/arch/x86_64/boot/setup.S
index c3bfd22..50d3708 100644
--- a/arch/x86_64/boot/setup.S
+++ b/arch/x86_64/boot/setup.S
@@ -52,7 +52,7 @@ #include <asm/boot.h>
 #include <asm/e820.h>
 #include <asm/page.h>
 
-/* Signature words to ensure LILO loaded us right */
+/* Signature words to mark the end of the real-mode kernel */
 #define SIG1	0xAA55
 #define SIG2	0x5A5A
 
@@ -155,37 +155,37 @@ cmd_line_ptr:	.long 0			# (Header versio
 					# low memory 0x10000 or higher.
 
 ramdisk_max:	.long 0xffffffff
-	
-trampoline:	call	start_of_setup
-		.align 16
-					# The offset at this point is 0x240
-		.space  (0xeff-0x240+1)	# E820 & EDD space (ending at 0xeff)
-# End of setup header #####################################################
 
-start_of_setup:
-# Bootlin depends on this being done early
-	movw	$0x01500, %ax
-	movb	$0x81, %dl
-	int	$0x13
-
-#ifdef SAFE_RESET_DISK_CONTROLLER
-# Reset the disk controller.
-	movw	$0x0000, %ax
-	movb	$0x80, %dl
-	int	$0x13
-#endif
-
-# Set %ds = %cs, we know that SETUPSEG = %cs at this point
-	movw	%cs, %ax		# aka SETUPSEG
-	movw	%ax, %ds
-# Check signature at end of setup
-	cmpw	$SIG1, setup_sig1
-	jne	bad_sig
-
-	cmpw	$SIG2, setup_sig2
-	jne	bad_sig
-
-	jmp	good_sig1
+trampoline:
+
+	# Fail with a message if the loader does not understand boot
+	# protocol 2.00 or later. This check is done early in order
+	# to catch truely ancient bootloaders that do not know about
+	# setup_sects. Assumptions: working stack and %cs = SETUPSEG.
+	cmpb	$0x00, %cs:(type_of_loader - start)
+	jz	bad_loader_alert
+	jmp	start_of_setup
+
+bad_loader_alert:
+	movw	$(bad_loader_msg - start), %si
+bad_loader_print:
+	movw	$0x0007, %bx
+	movw	$0x0e00, %ax
+	xorb	%cs:(%si), %al
+	jz	bad_loader_loop
+	int	$0x10
+	inc	%si
+	jmp	bad_loader_print
+bad_loader_loop:
+	hlt
+	jmp	bad_loader_loop
+bad_loader_msg:
+	.string	"Wrong bootloader, giving up..."
+
+	.align	0x80
+	# The offset at this point is 0x280
+	.space  (0xeff-0x280+1)	# E820 & EDD space (ending at 0xeff)
+# End of setup header #####################################################
 
 # Routine to print asciiz string at ds:si
 prtstr:
@@ -202,10 +202,10 @@ # Space printing
 prtsp2:	call	prtspc		# Print double space
 prtspc:	movb	$0x20, %al	# Print single space (note: fall-thru)
 
-prtchr:	
+prtchr:
 	pushw	%ax
 	pushw	%cx
-	movw	$0007,%bx
+	movw	$7,%bx
 	movw	$0x01, %cx
 	movb	$0x0e, %ah
 	int	$0x10
@@ -215,77 +215,16 @@ prtchr:	
 
 beep:	movb	$0x07, %al
 	jmp	prtchr
-	
-no_sig_mess: .string	"No setup signature found ..."
-
-good_sig1:
-	jmp	good_sig
-
-# We now have to find the rest of the setup code/data
-bad_sig:
-	movw	%cs, %ax			# SETUPSEG
-	subw	$DELTA_INITSEG, %ax		# INITSEG
-	movw	%ax, %ds
-	xorb	%bh, %bh
-	movb	(497), %bl			# get setup sect from bootsect
-	subw	$4, %bx				# LILO loads 4 sectors of setup
-	shlw	$8, %bx				# convert to words (1sect=2^8 words)
-	movw	%bx, %cx
-	shrw	$3, %bx				# convert to segment
-	addw	$SYSSEG, %bx
-	movw	%bx, %cs:start_sys_seg
-# Move rest of setup code/data to here
-	movw	$2048, %di			# four sectors loaded by LILO
-	subw	%si, %si
-	movw	%cs, %ax			# aka SETUPSEG
-	movw	%ax, %es
-	movw	$SYSSEG, %ax
-	movw	%ax, %ds
-	rep
-	movsw
-	movw	%cs, %ax			# aka SETUPSEG
-	movw	%ax, %ds
-	cmpw	$SIG1, setup_sig1
-	jne	no_sig
-
-	cmpw	$SIG2, setup_sig2
-	jne	no_sig
-
-	jmp	good_sig
-
-no_sig:
-	lea	no_sig_mess, %si
-	call	prtstr
-
-no_sig_loop:
-	jmp	no_sig_loop
 
-good_sig:
+start_of_setup:
+	# Set %ds = %cs, we know that SETUPSEG = %cs at this point
 	movw	%cs, %ax			# aka SETUPSEG
-	subw	$DELTA_INITSEG, %ax 		# aka INITSEG
+	subw	$DELTA_INITSEG, %ax		# aka INITSEG
 	movw	%ax, %ds
-# Check if an old loader tries to load a big-kernel
-	testb	$LOADED_HIGH, %cs:loadflags	# Do we have a big kernel?
-	jz	loader_ok			# No, no danger for old loaders.
-
-	cmpb	$0, %cs:type_of_loader 		# Do we have a loader that
-						# can deal with us?
-	jnz	loader_ok			# Yes, continue.
-
-	pushw	%cs				# No, we have an old loader,
-	popw	%ds				# die. 
-	lea	loader_panic_mess, %si
-	call	prtstr
-
-	jmp	no_sig_loop
-
-loader_panic_mess: .string "Wrong loader, giving up..."
 
-loader_ok:
 	/* check for long mode. */
 	/* we have to do this before the VESA setup, otherwise the user
 	   can't see the error message. */
-	
 	pushw	%ds
 	movw	%cs,%ax
 	movw	%ax,%ds
@@ -367,7 +306,6 @@ # tell BIOS we want to go to long mode
 	int $0x15			
 	
 # Get memory size (extended mem, kB)
-
 	xorl	%eax, %eax
 	movl	%eax, (0x1e0)
 #ifndef STANDARD_MEMORY_BIOS_CALL
-- 
1.4.1

