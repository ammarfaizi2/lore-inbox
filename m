Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030671AbWJKQ2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030671AbWJKQ2J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030680AbWJKQ2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:28:08 -0400
Received: from justus.rz.uni-saarland.de ([134.96.7.31]:57539 "EHLO
	justus.rz.uni-saarland.de") by vger.kernel.org with ESMTP
	id S1030671AbWJKQ2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:28:04 -0400
Date: Wed, 11 Oct 2006 18:33:56 +0200
From: Alexander van Heukelum <heukelum@mailshack.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       John Coffman <johninsd@san.rr.com>
Subject: [PATCH] Remove lilo-loads-only-five-sectors-of-zImage-fixup from setup.S
Message-ID: <20061011163356.GA2022@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.1 (justus.rz.uni-saarland.de [134.96.7.31]); Wed, 11 Oct 2006 18:27:38 +0200 (CEST)
X-AntiVirus: checked by AntiVir Milter (version: 1.1.3-1; AVE: 7.2.0.25; VDF: 6.36.0.108; host: AntiVir1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The real-mode kernel (on i386 and x86_64) checks if the bootloader
loaded it correctly. Apparantly, very old versions of LILO disregarded
the setupsects field in the bootsector and always just loaded the first
five sectors. If the kernel is compiled as a zImage, the real-mode
kernel is able to rectify the situation. At least it was, until the code
to do so was moved to the eighth sector in order to make space for more
E820 entries (commit: f9ba70535dc12d9eb57d466a2ecd749e16eca866). This
occured on 1 May 2005 and as far as I know, noone has complained yet.
This patch removes the checks for the signature and the fixup code
completely.

Comments? Which bootloaders are still in use? Kill zImage?

Alexander

If acceptable as-is:
Signed-off-by: Alexander van Heukelum <heukelum@mailshack.com>

---
 arch/i386/boot/setup.S   |   68 +++++-----------------------------------------
 arch/x86_64/boot/setup.S |   64 ++++---------------------------------------
 2 files changed, 13 insertions(+), 119 deletions(-)

diff --git a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
index 3aec453..cd354b2 100644
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
 
@@ -179,17 +179,7 @@ # Reset the disk controller.
 	int	$0x13
 #endif
 
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
+	jmp	test_loader
 
 # Routine to print asciiz string at ds:si
 prtstr:
@@ -220,52 +210,7 @@ prtchr:	pushw	%ax
 beep:	movb	$0x07, %al
 	jmp	prtchr
 	
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
-
-no_sig_loop:
-	hlt
-	jmp	no_sig_loop
-
-good_sig:
+test_loader:
 	movw	%cs, %ax			# aka SETUPSEG
 	subw	$DELTA_INITSEG, %ax 		# aka INITSEG
 	movw	%ax, %ds
@@ -281,8 +226,9 @@ # Check if an old loader tries to load a
 	popw	%ds				# die. 
 	lea	loader_panic_mess, %si
 	call	prtstr
-
-	jmp	no_sig_loop
+bad_loader:
+	hlt
+	jmp	bad_loader
 
 loader_panic_mess: .string "Wrong loader, giving up..."
 
diff --git a/arch/x86_64/boot/setup.S b/arch/x86_64/boot/setup.S
index c3bfd22..5542c59 100644
--- a/arch/x86_64/boot/setup.S
+++ b/arch/x86_64/boot/setup.S
@@ -52,7 +52,7 @@ #include <asm/boot.h>
 #include <asm/e820.h>
 #include <asm/page.h>
 
-/* Signature words to ensure LILO loaded us right */
+/* Signature words to mark the end of the real-mode kernel */
 #define SIG1	0xAA55
 #define SIG2	0x5A5A
 
@@ -175,17 +175,7 @@ # Reset the disk controller.
 	int	$0x13
 #endif
 
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
+	jmp	test_loader
 
 # Routine to print asciiz string at ds:si
 prtstr:
@@ -216,51 +206,7 @@ prtchr:	
 beep:	movb	$0x07, %al
 	jmp	prtchr
 	
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
-
-good_sig:
+test_loader:
 	movw	%cs, %ax			# aka SETUPSEG
 	subw	$DELTA_INITSEG, %ax 		# aka INITSEG
 	movw	%ax, %ds
@@ -277,7 +223,9 @@ # Check if an old loader tries to load a
 	lea	loader_panic_mess, %si
 	call	prtstr
 
-	jmp	no_sig_loop
+bad_loader:
+	hlt
+	jmp	bad_loader
 
 loader_panic_mess: .string "Wrong loader, giving up..."
 
-- 
1.4.1
