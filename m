Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263446AbUJ2R1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263446AbUJ2R1q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUJ2R1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:27:21 -0400
Received: from alog0559.analogic.com ([208.224.223.96]:3712 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263454AbUJ2R01
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:26:27 -0400
Date: Fri, 29 Oct 2004 13:22:52 -0400 (EDT)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0410291316470.3945@chaos.analogic.com>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004, Linus Torvalds wrote:

>
>
> On Fri, 29 Oct 2004, linux-os wrote:
>>
>> Linus, please check this out.
>
> Yes, I concur. However, I'd suggest changing the "addl $4,%esp" into a
> "popl %ecx", which is smaller and apparently faster on some CPU's (ecx
> obviously gets immediately overwritten by the next popl).
>
> Btw, this is another case where we _really_ want "asmlinkage" to mean that
> the compiler does not own the argument stack. Is there any chance of
> getting a function attribute like that into future versions of gcc?
> Richard, Jan, Andi? Or does it already exist somewhere?
>
> 		Linus
>

Here's a version that uses `leal 4(esp), esp` to add
4 to the stack-pointer. Since this 'address-calculation`
is done in an different portion of Intel CPUs, there
is some parallel operation that can occur. The 'pop ecx'
would access memory and, therefore be slower than
simple register operations.

FYI I'm running a kernel with this patch already.


--- linux-2.6.9/arch/i386/kernel/semaphore.c.orig	2004-10-29 13:00:17.961579368 -0400
+++ linux-2.6.9/arch/i386/kernel/semaphore.c	2004-10-29 13:03:35.046617888 -0400
@@ -198,9 +198,11 @@
  #endif
  	"pushl %eax\n\t"
  	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
+	"pushl %ecx\n\t"		// Register to save
+	"pushl %ecx\n\t"		// Passed parameter
  	"call __down\n\t"
-	"popl %ecx\n\t"
+	"leal 0x04(%esp), %esp\t\n"	// Bypass corrupted parameter
+	"popl %ecx\n\t"			// Restore original
  	"popl %edx\n\t"
  	"popl %eax\n\t"
  #if defined(CONFIG_FRAME_POINTER)
@@ -220,9 +222,11 @@
  	"movl  %esp,%ebp\n\t"
  #endif
  	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
+	"pushl %ecx\n\t"		// Save register
+	"pushl %ecx\n\t"		// Passed parameter
  	"call __down_interruptible\n\t"
-	"popl %ecx\n\t"
+	"leal 0x04(%esp), %esp\n\t"	// Bypass corrupted parameter
+	"popl %ecx\n\t"			// Restore register
  	"popl %edx\n\t"
  #if defined(CONFIG_FRAME_POINTER)
  	"movl %ebp,%esp\n\t"
@@ -241,9 +245,11 @@
  	"movl  %esp,%ebp\n\t"
  #endif
  	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
+	"pushl %ecx\n\t"		// Save register
+	"pushl %ecx\n\t"		// Passed parameter
  	"call __down_trylock\n\t"
-	"popl %ecx\n\t"
+	"leal 0x04(%esp), %esp\n\t"	// Bypass corrupted parameter
+	"popl %ecx\n\t"			// Restore register
  	"popl %edx\n\t"
  #if defined(CONFIG_FRAME_POINTER)
  	"movl %ebp,%esp\n\t"
@@ -259,9 +265,11 @@
  "__up_wakeup:\n\t"
  	"pushl %eax\n\t"
  	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
+	"pushl %ecx\n\t"		// Save register
+	"pushl %ecx\n\t"		// Passed parameter
  	"call __up\n\t"
-	"popl %ecx\n\t"
+	"leal 0x04(%esp), %esp\n\t"	// Bypass corrupted parameter
+	"popl %ecx\n\t"			// Restore register
  	"popl %edx\n\t"
  	"popl %eax\n\t"
  	"ret"



Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
