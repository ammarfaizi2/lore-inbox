Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132485AbRDDV6c>; Wed, 4 Apr 2001 17:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132492AbRDDV6V>; Wed, 4 Apr 2001 17:58:21 -0400
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:11143 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S132485AbRDDV6P>; Wed, 4 Apr 2001 17:58:15 -0400
From: Michael Miller <michaelm@mjmm.org>
Message-Id: <200104042152.f34Lqmx00835@mjmm.org>
Subject: Re: memory size detection problem on 2.3.16+ and 2.4.x
To: alan@lxorguk.ukuu.org.uk
Date: Wed, 4 Apr 2001 22:52:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> the bios will set the carry flag on the return from the call should 
>> there be an error.  However, the BIOS on my PC doesnt do this- infact 
>> it seems to simply return from the call without changing any registers. 
>
> Your BIOS is faulty. No new suprises. 

Hmm- not as wrong as I had at first thought...

>
>>  meme801: 
>> +     xorl    %edx, %edx                      # Clear regs to work around 
>> +     xorl    %ecx, %ecx                      # flakey BIOSes which don't 
>> +                                             # use carry bit correctly 
>> +                                             # This way we get 0MB ram on 
>> +                                             # call failure 
>
>Wouldn't setting the carry flag be clearer ? 

Yup- so I gave it a try and I was surprised that my OOPs happened again. Turns
out (after doing loads of tests using ms debug!!!) that my BIOS does clear
the carry flag (correctly!) and sets the memory size in AX and BX as opposed
to CX and DX (correct? possibly) which is what the Linux kernel uses.  The
crunch which got my machine, was that CX and DX are returned unchanged.  Thus
my xorl above was making the problem go away.

I looked on various sites (including Grub and Ralf Brown(?) interrupt lists)
and it seems that AX and BX are for 'extended memory' and CX/DX are for
'configured' memory...  No one seemed clear on the difference.  Since CX/DX
are currently being used byu the kernel, I thought I would make my patch
have minimal impact on users who are currently working fine.

As a result I have a second patch, which I would like to propose for
kernel addition, below.  This patch basically sets cx/dx to 0x0 before
the e801 call and then tests to see if they are still both 0, if so
ax/bx are used instead.  Obviously the carry test for sucess is still
in place.

Many thanks for suggesting an alternate solution, which although did not
solve the problem (due to my original wrong info) it did result in, 
what I consider to be, a better solution...

Mike



--- linux-2.4.2-orig/arch/i386/boot/setup.S	Sat Jan 27 18:51:35 2001
+++ linux/arch/i386/boot/setup.S	Wed Apr  4 22:30:31 2001
@@ -32,6 +32,16 @@
  *
  * Transcribed from Intel (as86) -> AT&T (gas) by Chris Noe, May 1999.
  * <stiker@northlink.com>
+ *
+ * Fix to work around buggy BIOSes which dont use carry bit correctly
+ * and/or report extended memory in CX/DX for e801h memory size detection 
+ * call.  As a result the kernel got wrong figures.  The int15/e801h docs
+ * from Ralf Brown interrupt list seem to indicate AX/BX should be used
+ * anyway.  So to avoid breaking many machines (presumably there was a reason
+ * to orginally use CX/DX instead of AX/BX), we do a kludge to see
+ * if CX/DX have been changed in the e801 call and if so use AX/BX .
+ * Michael Miller, April 2001 <michaelm@mjmm.org>
+ *
  */
 
 #define __ASSEMBLY__
@@ -341,10 +351,24 @@
 # to write everything into the same place.)
 
 meme801:
+	stc					# fix to work around buggy
+	xorw	%cx,%cx				# BIOSes which dont clear/set
+	xorw	%dx,%dx				# carry on pass/error of
+						# e801h memory size call
+						# or merely pass cx,dx though
+						# without changing them.
 	movw	$0xe801, %ax
 	int	$0x15
 	jc	mem88
 
+	cmpw	$0x0, %cx			# Kludge to handle BIOSes
+	jne	e801usecxdx			# which report their extended
+	cmpw	$0x0, %dx			# memory in AX/BX rather than
+	jne	e801usecxdx			# CX/DX.  The spec I have read
+	movw	%ax, %cx			# seems to indicate AX/BX 
+	movw	%bx, %dx			# are more reasonable anyway...
+
+e801usecxdx:
 	andl	$0xffff, %edx			# clear sign extend
 	shll	$6, %edx			# and go from 64k to 1k chunks
 	movl	%edx, (0x1e0)			# store extended memory size
