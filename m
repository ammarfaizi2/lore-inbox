Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUF3W7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUF3W7c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 18:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUF3W7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 18:59:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39947 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263062AbUF3W7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 18:59:25 -0400
Date: Wed, 30 Jun 2004 23:59:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Ian Molton <spyro@f2s.com>, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-ID: <20040630235921.C1496@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Ian Molton <spyro@f2s.com>, linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <20040630024434.GA25064@mail.shareable.org> <20040630091621.A8576@flint.arm.linux.org.uk> <20040630145942.GH29285@mail.shareable.org> <20040630192654.B21104@flint.arm.linux.org.uk> <20040630191428.GC31064@mail.shareable.org> <20040630202313.A1496@flint.arm.linux.org.uk> <20040630201546.GD31064@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040630201546.GD31064@mail.shareable.org>; from jamie@shareable.org on Wed, Jun 30, 2004 at 09:15:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 09:15:46PM +0100, Jamie Lokier wrote:
> Russell King wrote:
> > Trust me, it does.  Unless you fully understand how the MMU and domains
> > work on ARM, you've little chance of working it out from the code.
> 
> Thanks, that's fine.  I just wanted you to confirm PROT_NONE works
> with set_fs(KERNEL_DS), as it's not apparent from your earlier
> description.  I don't need to know _how_ it works - I can read manuals
> too - although you description was interesting.

Ok, to fill in for just this bit, the domain covering user space mappings
always remains in "client" mode, so page protections are always checked.
PAGE_NONE does not have the "user" bit set, so both user space accesses
and ldrt/strt instructions will be unable to access the pages, which is
the desired behaviour.

However, plain ldr and str instructions will access the page, but
get_user/put_user doesn't use them, and copy_from_user/copy_to_user
are carefully crafted to ensure that we hit the necessary permission
checks for each page it touches on the first access.

> > > Instead of comparing the address against TI_ADDR_LIMIT, compare it
> > > against the hard-coded userspace limit.
> > 
> > Wrong.  That means that if userspace passes an address above the hard
> > coded limit, we _WILL_ bypass all protections and access that memory.
> 
> No - it does check against TI_ADDR_LIMIT in the case that the address
> is above the hard-coded limit, so prevents that.

Ok.

> Here's the potential improvement to current 32-bit ARM.  It's
> 4 instructions instead of 8 and one less load, in the common case:
> 
> __get_user_4:
> 	cmp	r0, #TASK_SIZE-4
> 4:	ldrlet	r1, [r0]
> 	movle	r0, #0
> 	movle	pc, lr
> 	bic	r1, sp, #0x1f00
> 	bic	r1, r1, #0x00ff
> 	ldr	r1, [r1, #TI_ADDR_LIMIT]
> 	sub	r1, r1, #4
> 	cmp	r0, r1
> 14:	ldrlet	r1, [r0]
> 	movle	r0, #0
> 	movle	pc, lr
> 	b	__get_user_bad

Ok, this could work, but there's one gotcha - TASK_SIZE-4 doesn't fit
in an 8-bit rotated constants, so we need 2 extra instructions:

__get_user_4:
	mov	r1, #TASK_SIZE
	sub	r1, r1, #4
	cmp	r0, r1
4:	ldrlet	r1, [r0]
	movle	r0, #0
	movle	pc, lr
	...

> Finally, I think I see a bug in current ARM.  Shouldn't this use
> ldrlet instead of ldrlst?  Think about accesses to addresses
> TASK_SIZE-4 and 0xfffffffc.

LS = unsigned less than or same.  LE = signed less than or equal.  You
need the unsigned compare because addresses are unsigned.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
