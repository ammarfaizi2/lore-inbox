Return-Path: <linux-kernel-owner+w=401wt.eu-S1030393AbWLTWXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWLTWXM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWLTWXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:23:12 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35515 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030393AbWLTWXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:23:10 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jean Delvare <khali@linux-fr.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
References: <20061220141808.e4b8c0ea.khali@linux-fr.org>
	<m1tzzqpt04.fsf@ebiederm.dsl.xmission.com>
	<20061220214340.f6b037b1.khali@linux-fr.org>
Date: Wed, 20 Dec 2006 15:22:20 -0700
In-Reply-To: <20061220214340.f6b037b1.khali@linux-fr.org> (Jean Delvare's
	message of "Wed, 20 Dec 2006 21:43:40 +0100")
Message-ID: <m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> writes:

> Hi Eric,
>
> On Wed, 20 Dec 2006 07:00:11 -0700, Eric W. Biederman wrote:
>> Jean Delvare writes:
>> > One of my test machines (i586, Asus P4P800-X) reboots instantly when I
>> > try to boot a 2.6.20-rc1 kernel. 2.6.19 and 2.6.19.1 boot OK. I ran a
>> > git bisect and it pointed me to this patch:
>> 
>> I don't think this is a know issue.
>> 
>> The most straight forward way to debug this is to put infinite
>> loops in arch/i386/boot/compressed/head.S moving progressively farther
>> in until you find where the line in head.S that the machine reboots
>> on you is.
>
> I could try that with some guidance. What instructions should I insert
> to create an infinite loop?

10: jmp 10b
Should do it, but see below.

>> Although it is possible the problem falls in misc.c as well.
>> 
>> If you have a serial console setup we can probably make this
>> process a little easier.
>
> I can setup a serial console if needed, what are we looking for? Just
> to know where exactly the reboot happens?

Yes.  At this point I'm just trying to find a place to start.

I guess you likely have video on that machine so if we get into
misc.c and we stop rebooting you should be able to see some output.

You don't see the classic "decompressing kernel" message do you?

How big is your kernel?

You are booting a bzImage? not an ancient zImage?

>> One hunch is that we did something stupid, and have an instruction
>> that only executes on an i686 in there somewhere.
>
> This is a Pentium 4, I'm compiling for i586 for compatibility with my
> another test systems. So an i686 instruction would work fine, it has to
> be something else.

Ok.  That pretty much means something odd happened during the build
or there is some weird size issue.  What are the version of your
compiler and linker?


Ok.  Here is a small diff that inserts the infinite loops, between
each section of code in head.S  Procedurally please trying booting
this unmodified and see if it boots, then remove the infinite loop
until you come to the one where the system reboots instead of hangs.

That should at least give me a good idea of where to look.
If 20 hangs and 21 still reboots we are into misc.c and the
decompressor.  And I will have to ask something different.

Eric

diff --git a/arch/i386/boot/compressed/head.S b/arch/i386/boot/compressed/head.S
index f395a4b..f48a333 100644
--- a/arch/i386/boot/compressed/head.S
+++ b/arch/i386/boot/compressed/head.S
@@ -32,6 +32,7 @@
 	.globl startup_32
 
 startup_32:
+10:	jmp 10b	
 	cld
 	cli
 	movl $(__BOOT_DS),%eax
@@ -41,6 +42,7 @@ startup_32:
 	movl %eax,%gs
 	movl %eax,%ss
 
+11:	jmp 11b	
 /* Calculate the delta between where we were compiled to run
  * at and where we were actually loaded at.  This can only be done
  * with a short local call on x86.  Nothing  else will tell us what
@@ -53,6 +55,7 @@ startup_32:
 1:	popl %ebp
 	subl $1b, %ebp
 
+12:	jmp 12b	
 /* %ebp contains the address we are loaded at by the boot loader and %ebx
  * contains the address where we should move the kernel image temporarily
  * for safe in-place decompression.
@@ -66,6 +69,7 @@ startup_32:
 	movl $LOAD_PHYSICAL_ADDR, %ebx
 #endif
 
+13:	jmp 13b	
 	/* Replace the compressed data size with the uncompressed size */
 	subl input_len(%ebp), %ebx
 	movl output_len(%ebp), %eax
@@ -79,6 +83,7 @@ startup_32:
 	addl $4095, %ebx
 	andl $~4095, %ebx
 
+14:	jmp 14b	
 /* Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
  */
@@ -92,6 +97,7 @@ startup_32:
 	cld
 	popl %esi
 
+15:	jmp 15b	
 /* Compute the kernel start address.
  */
 #ifdef CONFIG_RELOCATABLE
@@ -101,6 +107,7 @@ startup_32:
 	movl	$LOAD_PHYSICAL_ADDR, %ebp
 #endif
 
+16:	jmp 16b	
 /*
  * Jump to the relocated address.
  */
@@ -109,6 +116,7 @@ startup_32:
 .section ".text"
 relocated:
 
+17:	jmp 17b	
 /*
  * Clear BSS
  */
@@ -120,11 +128,13 @@ relocated:
 	rep
 	stosb
 
+18:	jmp 18b	
 /*
  * Setup the stack for the decompressor
  */
 	leal stack_end(%ebx), %esp
 
+19:	jmp 19b	
 /*
  * Do the decompression, and jump to the new kernel..
  */
@@ -138,16 +148,20 @@ relocated:
 	leal _end(%ebx), %eax
 	pushl %eax	# end of the image as third argument
 	pushl %esi	# real mode pointer as second arg
+20:	jmp 20b	
 	call decompress_kernel
+21:	jmp 21b	
 	addl $20, %esp
 	popl %ecx
 
+22:	jmp 22b	
 #if CONFIG_RELOCATABLE
 /* Find the address of the relocations.
  */
 	movl %ebp, %edi
 	addl %ecx, %edi
 
+23:	jmp 23b	
 /* Calculate the delta between where vmlinux was compiled to run
  * and where it was actually loaded.
  */
@@ -167,6 +181,7 @@ relocated:
 2:
 #endif
 
+24:	jmp 24b	
 /*
  * Jump to the decompressed kernel.
  */

