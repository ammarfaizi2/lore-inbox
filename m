Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUF3URz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUF3URz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUF3UQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:16:34 -0400
Received: from mail.shareable.org ([81.29.64.88]:27053 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262382AbUF3UPw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:15:52 -0400
Date: Wed, 30 Jun 2004 21:15:46 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ian Molton <spyro@f2s.com>, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-ID: <20040630201546.GD31064@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040630091621.A8576@flint.arm.linux.org.uk> <20040630145942.GH29285@mail.shareable.org> <20040630192654.B21104@flint.arm.linux.org.uk> <20040630191428.GC31064@mail.shareable.org> <20040630202313.A1496@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630202313.A1496@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Trust me, it does.  Unless you fully understand how the MMU and domains
> work on ARM, you've little chance of working it out from the code.

Thanks, that's fine.  I just wanted you to confirm PROT_NONE works
with set_fs(KERNEL_DS), as it's not apparent from your earlier
description.  I don't need to know _how_ it works - I can read manuals
too - although you description was interesting.

> > Instead of comparing the address against TI_ADDR_LIMIT, compare it
> > against the hard-coded userspace limit.
> 
> Wrong.  That means that if userspace passes an address above the hard
> coded limit, we _WILL_ bypass all protections and access that memory.

No - it does check against TI_ADDR_LIMIT in the case that the address
is above the hard-coded limit, so prevents that.

The optimisation is valid on all architectures, actually, including
current ARM where it saves a few instructions in the common path.

Here's the potential improvement to current 32-bit ARM.  It's
4 instructions instead of 8 and one less load, in the common case:

__get_user_4:
	cmp	r0, #TASK_SIZE-4
4:	ldrlet	r1, [r0]
	movle	r0, #0
	movle	pc, lr
	bic	r1, sp, #0x1f00
	bic	r1, r1, #0x00ff
	ldr	r1, [r1, #TI_ADDR_LIMIT]
	sub	r1, r1, #4
	cmp	r0, r1
14:	ldrlet	r1, [r0]
	movle	r0, #0
	movle	pc, lr
	b	__get_user_bad

Finally, I think I see a bug in current ARM.  Shouldn't this use
ldrlet instead of ldrlst?  Think about accesses to addresses
TASK_SIZE-4 and 0xfffffffc.

	ldr	r1, [r1, #TI_ADDR_LIMIT]
	sub	r1, r1, #4
	cmp	r0, r1
4:	ldrlst	r1, [r0]

Thanks,
-- Jamie
