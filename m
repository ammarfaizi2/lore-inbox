Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283058AbRK1PUk>; Wed, 28 Nov 2001 10:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282156AbRK1PU2>; Wed, 28 Nov 2001 10:20:28 -0500
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:6157 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S283040AbRK1PUQ>; Wed, 28 Nov 2001 10:20:16 -0500
Date: Wed, 28 Nov 2001 16:19:35 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Mike Black <mblack@csihq.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.16 Compiler warning
In-Reply-To: <000701c177fa$36872380$e1de11cc@csihq.com>
Message-ID: <Pine.LNX.4.33.0111281617410.27255-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Nov 2001, Mike Black wrote:

> This appears to be a non-fatal warning....does this need to be cleaned up?
> [...]
> {standard input}: Assembler messages:
> {standard input}:1107: Warning: indirect lcall without `*'
> {standard input}:1192: Warning: indirect lcall without `*'
> [...]

I believe this cannot be cleaned up in 2.4 because it breaks older 
binutils. However, what about the appended patch for 2.5?

diff -X excl -urN linux-2.5.1-pre2.patches/arch/i386/boot/setup.S linux-2.5.1-pre2.work/arch/i386/boot/setup.S
--- linux-2.5.1-pre2.patches/arch/i386/boot/setup.S	Fri Nov  9 22:58:02 2001
+++ linux-2.5.1-pre2.work/arch/i386/boot/setup.S	Wed Nov 28 15:09:44 2001
@@ -539,7 +539,7 @@
 	cmpw	$0, %cs:realmode_swtch
 	jz	rmodeswtch_normal
 
-	lcall	%cs:realmode_swtch
+	lcall	*%cs:realmode_swtch
 
 	jmp	rmodeswtch_end
 
diff -X excl -urN linux-2.5.1-pre2.patches/arch/i386/kernel/apm.c linux-2.5.1-pre2.work/arch/i386/kernel/apm.c
--- linux-2.5.1-pre2.patches/arch/i386/kernel/apm.c	Fri Nov  9 22:58:02 2001
+++ linux-2.5.1-pre2.work/arch/i386/kernel/apm.c	Wed Nov 28 15:04:20 2001
@@ -526,7 +526,7 @@
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
-		"lcall %%cs:" SYMBOL_NAME_STR(apm_bios_entry) "\n\t"
+		"lcall *%%cs:" SYMBOL_NAME_STR(apm_bios_entry) "\n\t"
 		"setc %%al\n\t"
 		"popl %%ebp\n\t"
 		"popl %%edi\n\t"
@@ -573,7 +573,7 @@
 		__asm__ __volatile__(APM_DO_ZERO_SEGS
 			"pushl %%edi\n\t"
 			"pushl %%ebp\n\t"
-			"lcall %%cs:" SYMBOL_NAME_STR(apm_bios_entry) "\n\t"
+			"lcall *%%cs:" SYMBOL_NAME_STR(apm_bios_entry) "\n\t"
 			"setc %%bl\n\t"
 			"popl %%ebp\n\t"
 			"popl %%edi\n\t"
diff -X excl -urN linux-2.5.1-pre2.patches/arch/i386/kernel/pci-pc.c linux-2.5.1-pre2.work/arch/i386/kernel/pci-pc.c
--- linux-2.5.1-pre2.patches/arch/i386/kernel/pci-pc.c	Fri Nov  9 22:58:02 2001
+++ linux-2.5.1-pre2.work/arch/i386/kernel/pci-pc.c	Wed Nov 28 15:04:47 2001
@@ -458,7 +458,7 @@
 	unsigned long flags;
 
 	__save_flags(flags); __cli();
-	__asm__("lcall (%%edi); cld"
+	__asm__("lcall *(%%edi); cld"
 		: "=a" (return_code),
 		  "=b" (address),
 		  "=c" (length),
@@ -499,7 +499,7 @@
 
 		__save_flags(flags); __cli();
 		__asm__(
-			"lcall (%%edi); cld\n\t"
+			"lcall *(%%edi); cld\n\t"
 			"jc 1f\n\t"
 			"xor %%ah, %%ah\n"
 			"1:"
@@ -544,7 +544,7 @@
 	unsigned short bx;
 	unsigned short ret;
 
-	__asm__("lcall (%%edi); cld\n\t"
+	__asm__("lcall *(%%edi); cld\n\t"
 		"jc 1f\n\t"
 		"xor %%ah, %%ah\n"
 		"1:"
@@ -573,7 +573,7 @@
 
 	switch (len) {
 	case 1:
-		__asm__("lcall (%%esi); cld\n\t"
+		__asm__("lcall *(%%esi); cld\n\t"
 			"jc 1f\n\t"
 			"xor %%ah, %%ah\n"
 			"1:"
@@ -585,7 +585,7 @@
 			  "S" (&pci_indirect));
 		break;
 	case 2:
-		__asm__("lcall (%%esi); cld\n\t"
+		__asm__("lcall *(%%esi); cld\n\t"
 			"jc 1f\n\t"
 			"xor %%ah, %%ah\n"
 			"1:"
@@ -597,7 +597,7 @@
 			  "S" (&pci_indirect));
 		break;
 	case 4:
-		__asm__("lcall (%%esi); cld\n\t"
+		__asm__("lcall *(%%esi); cld\n\t"
 			"jc 1f\n\t"
 			"xor %%ah, %%ah\n"
 			"1:"
@@ -628,7 +628,7 @@
 
 	switch (len) {
 	case 1:
-		__asm__("lcall (%%esi); cld\n\t"
+		__asm__("lcall *(%%esi); cld\n\t"
 			"jc 1f\n\t"
 			"xor %%ah, %%ah\n"
 			"1:"
@@ -640,7 +640,7 @@
 			  "S" (&pci_indirect));
 		break;
 	case 2:
-		__asm__("lcall (%%esi); cld\n\t"
+		__asm__("lcall *(%%esi); cld\n\t"
 			"jc 1f\n\t"
 			"xor %%ah, %%ah\n"
 			"1:"
@@ -652,7 +652,7 @@
 			  "S" (&pci_indirect));
 		break;
 	case 4:
-		__asm__("lcall (%%esi); cld\n\t"
+		__asm__("lcall *(%%esi); cld\n\t"
 			"jc 1f\n\t"
 			"xor %%ah, %%ah\n"
 			"1:"
@@ -875,7 +875,7 @@
 	__asm__("push %%es\n\t"
 		"push %%ds\n\t"
 		"pop  %%es\n\t"
-		"lcall (%%esi); cld\n\t"
+		"lcall *(%%esi); cld\n\t"
 		"pop %%es\n\t"
 		"jc 1f\n\t"
 		"xor %%ah, %%ah\n"
@@ -908,7 +908,7 @@
 {
 	int ret;
 
-	__asm__("lcall (%%esi); cld\n\t"
+	__asm__("lcall *(%%esi); cld\n\t"
 		"jc 1f\n\t"
 		"xor %%ah, %%ah\n"
 		"1:"

