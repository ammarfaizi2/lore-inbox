Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290385AbSAPJOi>; Wed, 16 Jan 2002 04:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289893AbSAPJOX>; Wed, 16 Jan 2002 04:14:23 -0500
Received: from [195.66.192.167] ([195.66.192.167]:8964 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S290390AbSAPJN1>; Wed, 16 Jan 2002 04:13:27 -0500
Message-Id: <200201160910.g0G9AdE10817@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [ANNC] Linld 0.94 available
Date: Wed, 16 Jan 2002 11:10:41 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just made next version of Linld: 0.94

http://port.imtp.ilyichevsk.odessa.ua/linux/vda/linld/linld094.tar.bz2
(20k)
http://port.imtp.ilyichevsk.odessa.ua/linux/vda/linld/linld_devel.tar.bz2
(500k)

Changelog
---------
0.91    Added support for cl=@filename
0.92    VCPI vodoo magic: booting under EMM386 and foes :-)
0.93    Cleanup. cl=@filename: cr/lf will be converted to two spaces
0.94    Ugly workaround for DOS int 15 fn 88 breakage

I believe this workaround really should be placed in kernel:
some day we will meet BIOS with same breakage!
It also looks much less ugly there.  Example patch against 2.4.16-pre1 
attached. Yes, there are some unrelated code cleanup (shorter instructions, 
same effect - can't resist :-).
--
vda

--- setup.S.orig	Fri Nov  9 19:58:02 2001
+++ setup.S	Wed Nov 28 11:42:00 2001
@@ -328,12 +328,10 @@
 	jnl	bail820

 	incb	(E820NR)
-	movw	%di, %ax
-	addw	$20, %ax
-	movw	%ax, %di
+	addw	$20, %di
 again820:
-	cmpl	$0, %ebx			# check to see if
-	jne	jmpe820				# %ebx is set to EOF
+	testl	%ebx, %ebx			# check to see if
+	jnz	jmpe820				# %ebx is set to EOF
 bail820:


@@ -356,28 +354,62 @@
 	int	$0x15
 	jc	mem88

-	cmpw	$0x0, %cx			# Kludge to handle BIOSes
-	jne	e801usecxdx			# which report their extended
-	cmpw	$0x0, %dx			# memory in AX/BX rather than
-	jne	e801usecxdx			# CX/DX.  The spec I have read
+	testw	%cx, %cx			# Kludge to handle BIOSes
+	jnz	e801usecxdx			# which report their extended
+	testw	%dx, %dx			# memory in AX/BX rather than
+	jnz	e801usecxdx			# CX/DX.  The spec I have read
 	movw	%ax, %cx			# seems to indicate AX/BX
 	movw	%bx, %dx			# are more reasonable anyway...

 e801usecxdx:
-	andl	$0xffff, %edx			# clear sign extend
+	movzwl	%dx, %edx			# clear sign extend
 	shll	$6, %edx			# and go from 64k to 1k chunks
-	movl	%edx, (0x1e0)			# store extended memory size
-	andl	$0xffff, %ecx			# clear sign extend
- 	addl	%ecx, (0x1e0)			# and add lower memory into
-						# total size.
+	movzwl	%cx, %ecx			# clear sign extend
+	addl	%ecx, %edx			# add lower memory to
+	movl	%edx, (0x1e0)			# extended, store

 # Ye Olde Traditional Methode.  Returns the memory size (up to 16mb or
 # 64mb, depending on the bios) in ax.
 mem88:

 #endif
+	#stc			# guard against brain damage -
+				#   int 15 must clear cf to indicate success
+	clc			# unbelievable: some BIOSes/DOSes can leave
+				#   cf as is so I had to abandon stc trick
 	movb	$0x88, %ah
 	int	$0x15
+	jc	mem_cmos
+	testw	%ax, %ax
+	jnz	mem_store
+
+# Fallback: if int15/88 fails, get same data from CMOS
+# this works around extremely stupid case I had with PC not booting
+# from DOS when I put 196 megs of RAM in it
+# (it reported 0 via int15/e801 and int15/88)
+# Also this makes unnecessary for loadlin to jump thru the hoops
+# just in order to let us know ext mem size
+# (it hooks itself on int 15/88 and does CMOS reads for us)
+mem_cmos:
+	pushf
+	cli
+	movb	$0x18, %al
+	outb	%al, $0x70
+	#iodelay?
+	inb	$0x71, %al
+	movb	%al, %ah
+	#iodelay?
+	movb	$0x17, %al
+	outb	%al, $0x70
+	#iodelay?
+	inb	$0x71, %al
+	popf
+
+mem_store:
+	cmpw	$0xffff-0x400, %ax	# We want to be sure it won't roll over
+	jbe	mem_store2		# 16 bit value when low 1024k gets added
+	movw	$0xffff-0x400, %ax	# thus max memtop is 0xffff*1k = 64m-1k
+mem_store2:
 	movw	%ax, (2)

 # Set the keyboard repeat rate to the max
