Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314082AbSEXFnO>; Fri, 24 May 2002 01:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSEXFnO>; Fri, 24 May 2002 01:43:14 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:58507 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S314082AbSEXFnM>; Fri, 24 May 2002 01:43:12 -0400
Message-ID: <3CEDD208.4060706@didntduck.org>
Date: Fri, 24 May 2002 01:39:20 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 head.S cleanup
Content-Type: multipart/mixed;
 boundary="------------040902020307030007020306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040902020307030007020306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Cleans up some redundant code in head.S:
- Combine checking of AC and ID eflags.
- Streamline the setting of %cr0.

-- 

						Brian Gerst

--------------040902020307030007020306
Content-Type: text/plain;
 name="head-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="head-1"

diff -urN linux-bk/arch/i386/kernel/head.S linux/arch/i386/kernel/head.S
--- linux-bk/arch/i386/kernel/head.S	Wed May 15 10:27:23 2002
+++ linux/arch/i386/kernel/head.S	Fri May 24 01:22:06 2002
@@ -182,26 +182,19 @@
 	pushfl			# push EFLAGS
 	popl %eax		# get EFLAGS
 	movl %eax,%ecx		# save original EFLAGS
-	xorl $0x40000,%eax	# flip AC bit in EFLAGS
+	xorl $0x240000,%eax	# flip AC and ID bits in EFLAGS
 	pushl %eax		# copy to EFLAGS
 	popfl			# set EFLAGS
 	pushfl			# get new EFLAGS
 	popl %eax		# put it in eax
 	xorl %ecx,%eax		# change in flags
-	andl $0x40000,%eax	# check if AC bit changed
+	pushl %ecx		# restore original EFLAGS
+	popfl
+	testl $0x40000,%eax	# check if AC bit changed
 	je is386
 
 	movb $4,X86		# at least 486
-	movl %ecx,%eax
-	xorl $0x200000,%eax	# check ID flag
-	pushl %eax
-	popfl			# if we are on a straight 486DX, SX, or
-	pushfl			# 487SX we can't change it
-	popl %eax
-	xorl %ecx,%eax
-	pushl %ecx		# restore original EFLAGS
-	popfl
-	andl $0x200000,%eax
+	testl $0x200000,%eax	# check if ID bit changed
 	je is486
 
 	/* get vendor info */
@@ -227,18 +220,15 @@
 	movb %cl,X86_MASK
 	movl %edx,X86_CAPABILITY
 
-is486:
-	movl %cr0,%eax		# 486 or better
-	andl $0x80000011,%eax	# Save PG,PE,ET
-	orl $0x50022,%eax	# set AM, WP, NE and MP
+is486:	movl $0x50022,%ecx	# set AM, WP, NE and MP
 	jmp 2f
 
-is386:	pushl %ecx		# restore original EFLAGS
-	popfl
-	movl %cr0,%eax		# 386
+is386:	movl $2,%ecx		# set MP
+2:	movl %cr0,%eax
 	andl $0x80000011,%eax	# Save PG,PE,ET
-	orl $2,%eax		# set MP
-2:	movl %eax,%cr0
+	orl %ecx,%eax
+	movl %eax,%cr0
+
 	call check_x87
 	incb ready
 	lgdt gdt_descr

--------------040902020307030007020306--

