Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132413AbRDDAJI>; Tue, 3 Apr 2001 20:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132405AbRDDAI6>; Tue, 3 Apr 2001 20:08:58 -0400
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:61344 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S132219AbRDDAIx>; Tue, 3 Apr 2001 20:08:53 -0400
From: Michael Miller <michaelm@mjmm.org>
Message-Id: <200104040003.f3403MG01149@mjmm.org>
Subject: memory size detection problem on 2.3.16+ and 2.4.x
To: linux-kernel@vger.kernel.org
Date: Wed, 4 Apr 2001 01:03:22 +0100 (BST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

summary: e801 memory size detection call failure, but bios doesnt
set carry flag on error and hence get an incorrect memory size.

Since the 2.3.16 kernel, my PC has been unable
to run any newer kernels (>2.3.16 or 2.4.x) without using the mem=64M
command line parameter.  This was when the new bigmem support was added
which changed the memory detection routines somewhat.

I have traced this down to a problem with the way in which the kernel
calls the e801 memory size detection bios call.  The kernel assumes that
the bios will set the carry flag on the return from the call should
there be an error.  However, the BIOS on my PC doesnt do this- infact
it seems to simply return from the call without changing any registers.

As a result, my memory size being used is approx 1GB which is derived from 
the values in the CX and DX registers before the call. My BIOS does not clear
them (CX or DX) nor does it set the carry flag. 

I have included a pretty harmless patch below (taken against 2.4.2) for
 arch/i386/boot/setup.S
which works around this buggy BIOS issue.  

The patch clears CX and DX before the call to the e801 routine.  This
should be harmless for any machines which currently work correctly.

Please could this patch be included in the next 2.4.x kernel source tree,
as I would guess that it is not only me affected by this...

Many thanks.
Michael Miller

--- linux-2.4.2-orig/arch/i386/boot/setup.S	Sat Jan 27 18:51:35 2001
+++ linux/arch/i386/boot/setup.S	Wed Apr  4 00:13:52 2001
@@ -32,6 +32,10 @@
  *
  * Transcribed from Intel (as86) -> AT&T (gas) by Chris Noe, May 1999.
  * <stiker@northlink.com>
+ *
+ * Workaround flakey BIOSes for e801 call - which don't use carry flag
+ * on errors. Michael Miller (michaelm@mjmm.org), April 2001
+ *
  */
 
 #define __ASSEMBLY__
@@ -341,6 +345,11 @@
 # to write everything into the same place.)
 
 meme801:
+	xorl	%edx, %edx			# Clear regs to work around
+	xorl	%ecx, %ecx			# flakey BIOSes which don't
+						# use carry bit correctly
+						# This way we get 0MB ram on
+						# call failure
 	movw	$0xe801, %ax
 	int	$0x15
 	jc	mem88




