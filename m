Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWDEMBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWDEMBP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 08:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWDEMBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 08:01:15 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:40207 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751224AbWDEMBO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 08:01:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <4432EC08.4010104@nortel.com>
x-originalarrivaltime: 05 Apr 2006 12:01:13.0320 (UTC) FILETIME=[A2A65E80:01C658A8]
Content-class: urn:content-classes:message
Subject: Re: CONFIG_FRAME_POINTER and module vermagic
Date: Wed, 5 Apr 2006 08:01:12 -0400
Message-ID: <Pine.LNX.4.61.0604050729210.4636@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CONFIG_FRAME_POINTER and module vermagic
Thread-Index: AcZYqKKtlTrODgAsTtSONAKj+FQnmA==
References: <442ACAD6.6@nortel.com> <Pine.LNX.4.61.0603291308240.28274@chaos.analogic.com> <4432EC08.4010104@nortel.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Christopher Friesen" <cfriesen@nortel.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Apr 2006, Christopher Friesen wrote:

>
> A while back there was a post that CONFIG_FRAME_POINTER doesn't affect
> calling conventions and doesn't need to be in vermagic.
>
> One of my coworkers seems to think otherwise, and I don't know enough
> about the issue to know for sure.  Could someone with i386 knowledge
> comment on his thoughts?
>
> Here's what he's currently thinking:
>
> 1) regs->ebp hold a copy of the stack frame pointer. It's value is
> conserved through any function that are compiled with FRAME_POINTER on.
>
> 2) (unsigned long *)(regs->ebp + 4) is the "pc" of the caller (like the
> link register on PPC which is relative to "fp")
>
> 3) The profile_pc function usually look directly at "pc" to do it's
> profiling magic but sometimes (when the current "pc" is inside a
> lock_function, we're SMP, and CONFIG_FRAME_POINTER is enabled) it uses
> "regs->ebp+4" to be more accurate on the profiling. In other word
> profile_pc doesn't want to create a profiling entry that would show
> redundant information about being stuck into a spin_lock...
>
> So, if the kernel was built with SMP and FRAME_POINTER, a module wasn't,
> the module used ebp as a general register, then blocked in a spinlock
> when profile_pc started...then a regs->ebp value of something
> interesting (like "0", for instance) could cause interesting behaviour.
>
> Seems reasonable to me, but like I said, I'm not an expert on i386.
>
> Chris
>

Register EBP is used to set up a stack frame. The CPU has internal
macros that do this for you with 'enter nn' and 'leave'. Properly
used, these will also collapse the stack to its entry value,
discarding local variables when leaving the procedure.

Register EBP is an index register, considered precious by the 'C'
compiler. Such other registers are EBX, ESI, and EDI. These are
never to be destroyed by a called function.

When EBP is used for a frame pointer, it must always be
saved prior to use and restored after...

PAR1 = 0x08
PAR2 = 0x0c
PAR3 = 0x10
 		push	%ebp
 		movl	%esp, %ebp		# Enter
 		movl	PAR1(%ebp), %eax	# Get first parameter
 		movl	PAR2(%ebp), %ecx	# Get second parameter
 		movl	PAR3(%ebp), %edx	# Get third parameter
 		.........
 		.........
 		movl	%ebp, %esp		# leave
 		popl	%esp
 		ret

If a frame-pointer is not used, the code becomes.

PAR1 = 0x04
PAR2 = 0x08
PAR3 = 0x0c
 		movl	PAR1(%esp), %eax
 		movl	PAR2(%esp), %ecx
 		movl	PAR3(%esp), %edx

This saves instuctions and frees up register EBP for use as a general
purpose register, or as an index register off from the stack segment.
However, since EBP is precious, its contents must be saved before use
and restored later, as:

 		pushl	EBP
 		...........
 		...........
 		popl	EBP


Failure to do this is a BUG. If you find any code that uses either
EBP, EBX, ESI, or EDI in a called function, without first saving and
then later restoring them, it is a BUG and needs to be reported.

There is a possibility that some inline assembly was improperly
coded and ends up using some register it shouldn't, but this
would quickly lead to crash and would be descovered early in
the development phase. Note that upon entry to the kernel all
the caller's registers are saved on the intermediate kernel
stack and restored upon exit. That's what the (regs *) to which
you refer, points to. The structure member, ebp, contains the
value of the EBP register when the kernel was called. Since EBP
was the first register saved in the array, it is likely (didn't check)
that the location referenced by "regs->ebp + 4" was, in fact, the
return address. In any event, the value of regs->ebp is simply
the value in a structure member, not the value of any current
registers.

Again, you can use a stack-frame if you want, or not in your
modules. It makes no difference to the rest of the kernel.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
