Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUF3TOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUF3TOj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 15:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUF3TOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 15:14:39 -0400
Received: from mail.shareable.org ([81.29.64.88]:24749 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261239AbUF3TOc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 15:14:32 -0400
Date: Wed, 30 Jun 2004 20:14:28 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ian Molton <spyro@f2s.com>, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-ID: <20040630191428.GC31064@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040630091621.A8576@flint.arm.linux.org.uk> <20040630145942.GH29285@mail.shareable.org> <20040630192654.B21104@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630192654.B21104@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> We use three domains - one for user, one for kernel and one for IO.
> Normally all three are in client mode.  However, on set_fs(KERNEL_DS)
> we switch the kernel domain to manager mode.
> 
> This means that the user-mode LDR instructions (ldrt / ldrlst etc)
> will not have their page permissions checked, and therefore the access
> will succeed - exactly as we require.

Protection permissions (i.e. read-only, PROT_NONE) should still be
checked after set_fs(KERNEL_DS).  It's only the kernel page vs. user
page distinction that should be relaxed.

>From your description, it's not obvious that it'll do the right thing
in that circumstance.

Hopefully,

> [Tables]
> We have a similar difference in kernel-mode vs user-mode accesses for
> the ARM case as well - so its all complicated and unless you really
> understand this... 8)

...this is alluding to a mechanism such that exactly the right thing
happens for PROT_NONE and PROT_READONLY pages after set_fs(KERNEL_DS), yes?

> Privileged  T-bit     00      01     10         11
>     Y         0       r/w     r/w    r/w        r/w
>     Y         1       r/w     read   no access  no access
>     N         X       r/w     read   no access  no access
> 
> Note: if PAGE_NOT_USER and PAGE_OLD are both clear (iow, young + user
> page) we use bit pattern 0x.  If PAGE_NOT_USER, PAGE_OLD, PAGE_READONLY
> and PAGE_CLEAN are all clear, we use bit pattern 00.  Otherwise we use
> bit pattern 11.

Ok, that explains nicely and should do the right thing on ARM26 with
PROT_NONE pages, even with set_fs(KERNEL_DS).

Because set_fs() is rarely used, I think you can optimise getuser.S
and putuser.S on ARM26.  Instead of comparing the address against
TI_ADDR_LIMIT, compare it against the hard-coded userspace limit.

If that succeeds, continue with ldrt et al.  Note the improvements in
the common case (fs == USER_DS and no fault): (1) you only compare
against one limit, not two; (2) no load of TI_ADDR_LIMIT; (3) one less
ldr instruction.

If that comparison fails, then branch to a version which checks
TI_ADDR_LIMIT.

Here's an example.  It's probably wrong as I haven't written ARM in a
long time, but illustrates the idea.  Note how the common case takes 4
instructions instead of 12 in the current code:

__get_user_4:
	cmp	r0,#0x02000000
4:	ldrlst	r1, [r0]
	movls	r0, #0
	movls	pc, lr
	bic	r1, sp, #0x1f00
	bic	r1, r1, #0x00ff
	str	lr, [sp, #-4]!
	ldr	r1, [r1, #TI_ADDR_LIMIT]
	sub	r1, r1, #4
	cmp	r0, r1
14:	ldrls	r1, [r0]
	movls	r0, #0
	ldmfdls	sp!, {pc}^
	b	__get_user_bad

-- Jamie
