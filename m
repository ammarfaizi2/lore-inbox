Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTDRRpr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 13:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbTDRRpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 13:45:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:28035 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263187AbTDRRpo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 13:45:44 -0400
Date: Fri, 18 Apr 2003 14:00:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Trivial Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] kstrdup
In-Reply-To: <3EA02E55.80103@pobox.com>
Message-ID: <Pine.LNX.4.53.0304181323400.22493@chaos>
References: <Pine.LNX.4.44.0304180919380.2950-100000@home.transmeta.com>
 <3EA02E55.80103@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Apr 2003, Jeff Garzik wrote:

> Linus Torvalds wrote:
> > On Fri, 18 Apr 2003, Jeff Garzik wrote:
> >
> >>You should save the strlen result to a temp var, and then s/strcpy/memcpy/
> >
> >
> > No, you should just not do this. I don't see the point.
>
>
> strcpy has a test for each byte of its contents, and memcpy doesn't.
> Why search 's' for NULL twice?
>
> 	Jeff

Because it doesn't. strcpy() is usually implimented by getting
the string-length, using the same code sequence as strlen(), then
using the same code sequence as memcpy(), but copying the null-byte
as well. The check for the null-byte is done in the length routine.

If you do a memcpy(a, b, strlen(b));, then you are making two
procedure calls and dirtying the cache twice..

A typical Intel procedure, stripped of the push/pops to save
registers is here....

		cld
		movl	SRC(%esp), %edi
		movl	%edi, %esi	# Source = ESI and EDI
		orl	$-1, %ecx
		xorl	%eax,%eax	# Zero
		repnz	scasb		# Look for the null-byte
		negl	%ecx		# ecx = string length
		incl	%ecx		# copy the null
		movl	DST(%esp), %edi	# Destination buffer EDI
		shrl	$1, %ecx	# Make word count
		pushf			# Save result
		shrl	$1, %ecx	# Make longword count
		rep	movsl		# copy longwords
		adcl	%ecx, %ecx	# Possible word count
		rep	movsw		# Copy possible last word
		popf			# Result from first shift
		adcl	%ecx, %ecx	# Possible byte-count
		rep	movsb		# Copy last byte

There are no jumps and the locality of action is good. This could
be improved in the corner cases of long, aligned buffers.

A lot of persons who are unfamiliar with tools other than 'C' think
that strcpy() is made like this:

	while(*dsp++ = *src++)
                   ;

... ahaaa .. Wouderful short portable code! Wrong, awful code, possibly
portable.


.L2:
	movl 8(%ebp),%edx	# Memory reference (destination)
	movl 12(%ebp),%ecx	# Memory reference (source)
	movb (%ecx),%al		# Get a byte
	movb %al,(%edx)		# Put it into destination buffer
	incl 12(%ebp)		# Memory reference (bump the source)
	incl 8(%ebp)		# Memory reference (bump the destination)
	testb %al,%al		# Check for zero on every byte
	jne .L4			# Why a jump to here? (should be jne .L2)
	jmp .L3
	.align 4
.L4:
	jmp .L2			# Now we go back to the beginning.
	.align 4
.L3:
.L1:
	movl %ebp,%esp
	popl %ebp
	ret


Now; this code is 'shorter', but it is very slow compared to the
smarter strcpy() as previously shown.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

