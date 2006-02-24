Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbWBXWT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbWBXWT2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbWBXWT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:19:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49167 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932606AbWBXWT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:19:27 -0500
Date: Fri, 24 Feb 2006 22:19:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
Message-ID: <20060224221909.GD28855@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <0.399206195@selenic.com> <4.399206195@selenic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.399206195@selenic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 02:12:16PM -0600, Matt Mackall wrote:
> -static const u16 mask_bits[] = {
> -	0x0000,
> -	0x0001, 0x0003, 0x0007, 0x000f, 0x001f, 0x003f, 0x007f, 0x00ff,
> -	0x01ff, 0x03ff, 0x07ff, 0x0fff, 0x1fff, 0x3fff, 0x7fff, 0xffff
> -};
> +static inline u32 readbits(u32 *b, u32 *k, int n)
> +{
> +	for( ; *k < n; *k += 8)
> +		*b |= (u32)get_byte() << *k;
> +	return *b & ((1 << n) - 1);
> +}
>  
> -#define NEXTBYTE()  ({ int v = get_byte(); if (v < 0) goto underrun; (u8)v; })

How does this change handle the case where we run out of input data?
This condition needs to be handled explicitly because the inflate
functions can infinitely loop.

Relying on a bit pattern returned by get_byte() is how this code
pre-fix used to work, and it caused several confused bug reports.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
