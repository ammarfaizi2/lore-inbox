Return-Path: <linux-kernel-owner+w=401wt.eu-S965199AbWLUKdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbWLUKdi (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 05:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWLUKdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 05:33:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40560 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965199AbWLUKdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 05:33:37 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jean Delvare <khali@linux-fr.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
References: <20061220141808.e4b8c0ea.khali@linux-fr.org>
	<m1tzzqpt04.fsf@ebiederm.dsl.xmission.com>
	<20061220214340.f6b037b1.khali@linux-fr.org>
	<m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com>
	<20061221101240.f7e8f107.khali@linux-fr.org>
	<20061221102232.5a10bece.khali@linux-fr.org>
Date: Thu, 21 Dec 2006 03:32:33 -0700
In-Reply-To: <20061221102232.5a10bece.khali@linux-fr.org> (Jean Delvare's
	message of "Thu, 21 Dec 2006 10:22:32 +0100")
Message-ID: <m164c5pmim.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> writes:

> On Thu, 21 Dec 2006 10:12:40 +0100, Jean Delvare wrote:
>> On Wed, 20 Dec 2006 15:22:20 -0700, Eric W. Biederman wrote:
>> > Ok.  Here is a small diff that inserts the infinite loops, between
>> > each section of code in head.S  Procedurally please trying booting
>> > this unmodified and see if it boots, then remove the infinite loop
>> > until you come to the one where the system reboots instead of hangs.
>> > 
>> > That should at least give me a good idea of where to look.
>> > If 20 hangs and 21 still reboots we are into misc.c and the
>> > decompressor.  And I will have to ask something different.
>> 
>> OK, I'll start the tests now, I'll let you know the outcome when I'm
>> done.
>
> Hm, that was quick... Even with your unmodified patch, the machine
> still reboots. Does that make any sense to you?
>
> I can try installing a more recent system on the same hardware if it
> helps.

Grr.  I guessed the problem was to late in the game it seems the problem
is in setup.S  Before we switch to 32bit mode.

Ok.  There is almost enough for inference but here is a patch of stops
for setup.S let's see if one of those will stop the reboots.

I have a strong feeling that we are going to find a tool chain issue,
but I'd like to find where we ware having problems before we declare
that to be the case.


Eric

diff --git a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
index 06edf1c..2868020 100644
--- a/arch/i386/boot/setup.S
+++ b/arch/i386/boot/setup.S
@@ -795,6 +795,7 @@ a20_done:
 
 #endif /* CONFIG_X86_VOYAGER */
 # set up gdt and idt and 32bit start address
+10: jmp	10b
 	lidt	idt_48				# load idt with 0,0
 	xorl	%eax, %eax			# Compute gdt_base
 	movw	%ds, %ax			# (Convert %ds:gdt to a linear ptr)
@@ -846,6 +847,7 @@ flush_instr:
 	subw	$DELTA_INITSEG, %si
 	shll	$4, %esi			# Convert to 32-bit pointer
 
+11: jmp	11b
 # jump to startup_32 in arch/i386/boot/compressed/head.S
 #	
 # NOTE: For high loaded big kernels we need a
@@ -862,6 +864,7 @@ code32:	.long	startup_32			# will be set to %cs+startup_32
 	.word	__BOOT_CS
 .code32
 startup_32:
+12: jmp	12b
 	movl $(__BOOT_DS), %eax
 	movl %eax, %ds
 	movl %eax, %es
@@ -869,12 +872,14 @@ startup_32:
 	movl %eax, %gs
 	movl %eax, %ss
 
+13: jmp	13b
 	xorl %eax, %eax
 1:	incl %eax				# check that A20 really IS enabled
 	movl %eax, 0x00000000			# loop forever if it isn't
 	cmpl %eax, 0x00100000
 	je 1b
 
+14: jmp	14b
 	# Jump to the 32bit entry point
 	jmpl *(code32_start - start + (DELTA_INITSEG << 4))(%esi)
 .code16
