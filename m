Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314280AbSDRJoP>; Thu, 18 Apr 2002 05:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314281AbSDRJoO>; Thu, 18 Apr 2002 05:44:14 -0400
Received: from web11808.mail.yahoo.com ([216.136.172.162]:33033 "HELO
	web11808.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S314280AbSDRJoN>; Thu, 18 Apr 2002 05:44:13 -0400
Message-ID: <20020418094413.77178.qmail@web11808.mail.yahoo.com>
Date: Thu, 18 Apr 2002 11:44:13 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: [PATCH] x86 boot enhancements, Clean up the 32bit entry points 6/11
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You propose:
----------------------
diff -uNr linux-2.5.8.boot.heap/arch/i386/boot/compressed/head.S \
               
linux-2.5.8.boot.clean_32bit_entries/arch/i386/boot/compressed/head.S
--- linux-2.5.8.boot.heap/arch/i386/boot/compressed/head.S	Wed Jul  5
13:03:12 2000
+++ linux-2.5.8.boot.clean_32bit_entries/arch/i386/boot/compressed/head.S
Wed Apr 17 \
00:37:46 2002 @@ -25,24 +25,30 @@
 
 #include <linux/linkage.h>
 #include <asm/segment.h>
+#include <asm/boot.h>
 
 	.globl startup_32
 	
 startup_32:
 	cld
 	cli
-	movl $(__KERNEL_DS),%eax
-	movl %eax,%ds
-	movl %eax,%es
-	movl %eax,%fs
-	movl %eax,%gs
 
-	lss SYMBOL_NAME(stack_start),%esp
-	xorl %eax,%eax
-1:	incl %eax		# check that A20 really IS enabled
-	movl %eax,0x000000	# loop forever if it isn't
-	cmpl %eax,0x100000
-	je 1b
+	/*
+	 * Save the initial registers
+	 */
+	movl %eax, eax
+	movl %ebx, ebx
-------------------

You want to change completely the protected mode entry point, that does
bother me, you know why (gujin). It is a simple (as simple as possible)
interface, available from a _very_ long time.

  I would say:
- Please initialise registers (segment registers) before using them, it
 is already complex enough. A bug there will be really difficult to find.
 Moreover that remind me another OS using registers (%bx) without
 initialising it first.
- Please keep the 'lss SYMBOL_NAME(stack_start),%esp' around, it is the
_only_ way to know if a kernel is "loaded low" or "loaded high", just in
case you want to write a bootloader which loads _any_ kernel, even 1.x
- Please stay compatible.

  Etienne.

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
