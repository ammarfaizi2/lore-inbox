Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUF3UP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUF3UP5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUF3UOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:14:20 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:44812 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262381AbUF3UN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:13:26 -0400
Message-ID: <40E323CC.5030105@techsource.com>
Date: Wed, 30 Jun 2004 16:34:20 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Joshua <jhudson@cyberspace.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore floppy boot image
References: <Pine.SUN.3.96.1040630143510.23723A-100000@grex.cyberspace.org>
In-Reply-To: <Pine.SUN.3.96.1040630143510.23723A-100000@grex.cyberspace.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Joshua wrote:

> +enter:

You get a segment number here into AX...

> +	pop	%ax	/* Pointer to setup area */
> +	mov	%ax, %ds
> +	mov	%ax, %es
> +	mov	%ax, %fs
> +	mov	%ax, %gs
> +	movb	$0x20, 0x210	/* Tell setup.S that we are the bootsect
> */
> +	orb	$0x1, 0x211	/* Covert any zImage to bzImage (weird) */
> +	movw	$0x0, 0x214	/* This is where we loaded it */
> +	movw	$0x10, 0x216
> +
> +	/*
> +	 * This procedure turns off the floppy drive motor, so
> +	 * that we enter the kernel in a known state, and
> +	 * don't have to worry about it later.
> +	 *
> +	 * Actually, all this does is not annoy sysadmin, when he is
> +	 * forced to use this method of booting, because if the floppy
> +	 * is a demand-loaded module, the motor just won't turn off
> +	 * otherwise.
> +	 */
> +
> +	mov	$0x3f2, %dx

Then you clobber it here....

> +	mov	$0, %al
> +	/* outb */
> +	.byte	0xEE		/* I don't have time to figure out
> +				 * why this didn't assemble. */
> +
> +	/*
> +	 * Enter kernel with interrupts off, and at segment +20 from
> +	 * legacy bootsect location
> +	 */
> +	cli

And then you use the clobbered value here.  (Unless the low byte of SS 
is supposed to be zero.)

> +	mov	%ax, %ss
> +	mov	$0xFFF0, %sp	/* Plenty heap */
> +	ljmp	$KS_LOAD + 0x20, $0

