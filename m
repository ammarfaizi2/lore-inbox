Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbTDWRZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTDWRZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:25:20 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18824 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264143AbTDWRZQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:25:16 -0400
Date: Wed, 23 Apr 2003 13:39:55 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andrew Kirilenko <icedank@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Searching for string problems
In-Reply-To: <200304231958.43235.icedank@gmx.net>
Message-ID: <Pine.LNX.4.53.0304231311460.25222@chaos>
References: <200304231958.43235.icedank@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Andrew Kirilenko wrote:

> Hello!
>
> OK. I've solved my problems with storing data (problem was with improper DS
> setup - thanks to all, pointed me to this). And now I should perform a search
> in the BIOS are for particular string (version of BIOS ). Here is my code
> (it's located in the setup.S, so executes in the real mode, not ptotected).
>
> -->
> start_of_setup:
> 	jmp cl_start
> cl_id_str:      .string "BIOS 0.1"
> cl_start:
>         movb    $0, %al
>         movw    $0xe000, %bx
> cl_compare:
>         incw    %bx
>         movw    %bx, %si
>         cmpw    $0xefff, %si
>         je      cl_compare_done
>         movw    $cl_id_str, %di
> cl_compare_inner:
>         movb    (%di), %ah
>         cmpb    $0, %ah
>         je      cl_compare_done_good
>         cmpb    (%si), %ah
>         jne     cl_compare
>         incw    %si
>         incw    %di
>         jmp     cl_compare_inner
> cl_compare_done_good:
>         movb    $1, %al
> cl_compare_done:
> <--
>
> This code don't work... I'm sure, that's because of inproper registers setup
> (or maybe address range is wrong). Please help me.
>

Hmm, maybe you should just learn assembly off-line.

cl_id_str:      .string "BIOS 0.1"
cl_id_end:

scan:	movw	%cs, %ax	# Get code-segment
	movw	%ax, %ds	# Set into data segment
	movw	%ax, %es	# Set into extra segment CS=ES=DS
	cld			# Compare forwards
	movw	$cl_id_str, %si	# String to compare
	movw	$were_in_the_bios_you_expect_to_find_it, %di
	movw	$cl_id_end, %cx	# Offset to this label
	subw	%si, %cx	# CX = length of string
	decw	%cx		# Don't compare \0
	repz	cmpsb		# Continue as long as they compare
	jz	found		# String was found
				# Not found here
found:

If you need to search the whole BIOS for that string, you need to
set up an outer loop using an unused register which starts at
the offset of the BIOS and increments by one byte everytime
you can't find the string. This value gets put into %di, instead
of the absolute number specified above.

Like:

scan:	movw	%cs, %ax
	movw	%ax, %ds
	movw	%ax, %es
	movw	$where_in_BIOS_to_start, %bx
	cld
1:	movw	$cl_id_str, %si		# Offset of search string
	movw	$cl_id_end, %cx		# Offset of string end + 1
	subw	%si, %cx		# String length
	decw	%cx			# Don't look for the \0
	movw	%bx, %di		# ES:DI = where to look
	repz	cmpsb			# Loop while the same
	jz	found			# Found the string
	incb	%bx			# Next starting offset
	cmpb	$_BIOS_END, %bx		# Check for limit
	jb	1b			# Continue
never_found_anywhere:

found:


Note that the `gas` .string macro puts in a '\0', assuming it's
a 'C' string. You don't want to put that in the comparison. That's
why you search one-less than the allocation length. There are
predefined macros available for 'len', also.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

