Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263188AbUF3XaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUF3XaY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 19:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUF3XaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 19:30:24 -0400
Received: from mail.shareable.org ([81.29.64.88]:32685 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263188AbUF3XaS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 19:30:18 -0400
Date: Thu, 1 Jul 2004 00:30:14 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ian Molton <spyro@f2s.com>, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-ID: <20040630233014.GC32560@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040630091621.A8576@flint.arm.linux.org.uk> <20040630145942.GH29285@mail.shareable.org> <20040630192654.B21104@flint.arm.linux.org.uk> <20040630191428.GC31064@mail.shareable.org> <20040630202313.A1496@flint.arm.linux.org.uk> <20040630201546.GD31064@mail.shareable.org> <20040630235921.C1496@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630235921.C1496@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> > Here's the potential improvement to current 32-bit ARM.  It's
> > 4 instructions instead of 8 and one less load, in the common case:
> > 
> > __get_user_4:
> > 	cmp	r0, #TASK_SIZE-4
> > 4:	ldrlet	r1, [r0]
> > 	movle	r0, #0
> > 	movle	pc, lr
> > 	bic	r1, sp, #0x1f00
> > 	bic	r1, r1, #0x00ff
> > 	ldr	r1, [r1, #TI_ADDR_LIMIT]
> > 	sub	r1, r1, #4
> > 	cmp	r0, r1
> > 14:	ldrlet	r1, [r0]
> > 	movle	r0, #0
> > 	movle	pc, lr
> > 	b	__get_user_bad
> 
> Ok, this could work, but there's one gotcha - TASK_SIZE-4 doesn't fit
> in an 8-bit rotated constants, so we need 2 extra instructions:
> 
> __get_user_4:
> 	mov	r1, #TASK_SIZE
> 	sub	r1, r1, #4
> 	cmp	r0, r1
> 4:	ldrlet	r1, [r0]
> 	movle	r0, #0
> 	movle	pc, lr
> 	...

One more possibility:

	cmp	r0, #(TASK_SIZE - (1<<24))

I.e. just compare against the largest constant that can be
represented.  For accesses to the last part of userspace, it's a
penalty of 4 instructions -- but it might work out to be a net gain.

Actually, since the shortest path is only three instructions in the
fast case, not counting control flow, it might be good to inline those
3 in uaccess.h, and change the "bl" to a conditonal "blhi" there.

> > Finally, I think I see a bug in current ARM.  Shouldn't this use
> > ldrlet instead of ldrlst?  Think about accesses to addresses
> > TASK_SIZE-4 and 0xfffffffc.
> 
> LS = unsigned less than or same.  LE = signed less than or equal.  You
> need the unsigned compare because addresses are unsigned.

Ah.  I was guessing the mnemonic.

That's because of the way "ge" is used on ARM26 in places, which
therefore look buggy or subtly clever:

        ldr     r1, [r1, #TI_ADDR_LIMIT]
        sub     r1, r1, #4
        cmp     r0, r1
        bge     __get_user_bad
        cmp     r0, #0x02000000
4:      ldrlst  r1, [r0]
        ldrge   r1, [r0]

"ge" is a signed comparison, and unsigned is needed here, unless I
missed something subtle.  So "bge" and "ldrge" should be "bhi" and "ldrhi".

Thanks,
-- Jamie
