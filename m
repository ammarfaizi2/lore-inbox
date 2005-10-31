Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbVJaXK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVJaXK6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 18:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbVJaXK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 18:10:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49680 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964881AbVJaXK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 18:10:58 -0500
Date: Mon, 31 Oct 2005 23:10:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 17/20] inflate: mark some arrays as initdata
Message-ID: <20051031231052.GA1710@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
References: <17.196662837@selenic.com> <18.196662837@selenic.com> <20051031224301.GF20452@flint.arm.linux.org.uk> <20051031225746.GD4367@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031225746.GD4367@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 02:57:46PM -0800, Matt Mackall wrote:
> On Mon, Oct 31, 2005 at 10:43:01PM +0000, Russell King wrote:
> > On Mon, Oct 31, 2005 at 02:54:51PM -0600, Matt Mackall wrote:
> > > inflate: mark some arrays as INITDATA and define it in in-core callers
> > 
> > This breaks ARM.  Our decompressor has some rather odd requirements
> > due to the way we support PIC - it's PIC text with fixed data.
> > 
> > This means that all fixed initialised data must be "const" or initialised
> > by code.  This patch breaks that assertion.
> 
> It would have been helpful if you quoted the patch.

That's what threading is for. 8)

> +#ifndef INITDATA
> +#define INITDATA
> +#endif
> ...
> -static const u16 cplens[] = {
> +static INITDATA u16 cplens[] = {
>         3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31,
>         35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258, 0, 0
>  };
> 
> etc..
> 
> I think for ARM, we can simply do -DINITDATA=const, yes?

No, unless you want to make this const:

-static u8 window[0x8000]; /* use a statically allocated window */
+static u8 INITDATA window[0x8000]; /* use a statically allocated window */

It shouldn't be marked INITDATA either anyway - it's uninitialised so
it'll end up in the BSS.  There is no "discarded at runtime" BSS so
anything you want to place in a non-BSS section has to be initialised.

Of course, if you initialise it, you end up needlessly adding 32K to
the kernel image size...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
