Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbTJNTRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 15:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263538AbTJNTRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 15:17:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:37248 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263537AbTJNTRo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 15:17:44 -0400
Date: Tue, 14 Oct 2003 15:18:39 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chris Lattner <sabre@nondot.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [x86] Access off the bottom of stack causes a segfault?
In-Reply-To: <Pine.LNX.4.44.0310141320020.3869-100000@nondot.org>
Message-ID: <Pine.LNX.4.53.0310141510590.2211@chaos>
References: <Pine.LNX.4.44.0310141320020.3869-100000@nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003, Chris Lattner wrote:

>
> My compiler is generating accesses off the bottom of the stack (address
> below %esp).  Is there some funny kernel interaction that I should be
> aware of with this?  I'm periodically getting segfaults.
>
> Example:
>
> int main() {
>    int test[4000];
> ...
>    return 0;
> }
>
> Generated code:
>         .intel_syntax
> ...
> main:
>         mov DWORD PTR [%ESP - 16004], %EBP    # Save EBP to stack

BAM **INTERRUPT** writes return address below stack-pointer.

>         mov %EBP, %ESP                        # Set up EBP
>         sub %ESP, 16004                       # Finally adjust ESP
>         lea %EAX, DWORD PTR [%EBP - 16000]    # Get the address of the array
> ...
>         mov %EAX, 0                           # Setup return value
>         mov %ESP, %EBP                        # restore ESP
>         mov %EBP, DWORD PTR [%ESP - 16004]    # Restore EBP from stack

BAM **You get bad data, overwritten by interrupt**

>         ret
>
> This seems like perfectly valid X86 code (though unconventional), but it
> is causing segfaults pretty consistently (on the first instruction).
> Does the linux kernel assume that page faults will be above the stack
> pointer if the stack needs to be expanded?
>
> Thanks,
>
> -Chris

Well it is perfectly bad code. You can't access data elements
below the stack-pointer because that's where the return address
form interrupts, etc., will go. If you write there, you overwrite
that information, in particular an interrupt overwrites what
you put there. You do 'own' that address space, but you
can't use it in a program.

This script shows how to allocate stack-data without running
into that problem.


#!/bin/bash
#
#  Using only assembly and not any 'C' stuff, this allocates
#  64k on the stack and writes to it.
#
FNAME=/tmp/tmp
cat <<EOF >${FNAME}.S
.section	.text
.global	_start
.type	_start,@function
_start:	pushl	%ebp		# Save
	movl	%esp, %ebp	# Save SP
	subl	\$0x10000,%esp	# 64 k on the stack
	movl	\$0, (%esp)	# Write there
	movl	%ebp, %esp	# Original SP
	popl	%ebp		# Restore
	movl	\$0x01, %eax	# Exit function
	movl	\$0x00, %ebx	# Exit code
	int	\$0x80
1:	jmp	1b		# Hard stop
.end
EOF
as -o ${FNAME}.o ${FNAME}.S
ld -o ${FNAME} ${FNAME}.o
rm -f core
${FNAME}
if [ -f "core" ] ; then echo "Something's bad!" ; else echo "Okay!" ; fi
#

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.
