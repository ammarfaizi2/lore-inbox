Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVL1GYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVL1GYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 01:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVL1GYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 01:24:10 -0500
Received: from waste.org ([64.81.244.121]:54671 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751148AbVL1GYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 01:24:09 -0500
Date: Wed, 28 Dec 2005 00:20:56 -0600
From: Matt Mackall <mpm@selenic.com>
To: David Wagner <daw@cs.berkeley.edu>
Cc: bos@serpentine.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1 of 3] Introduce __memcpy_toio32
Message-ID: <20051228062056.GH3356@waste.org>
References: <200512280603.jBS63WGB031117@taverner.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512280603.jBS63WGB031117@taverner.CS.Berkeley.EDU>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 10:03:32PM -0800, David Wagner wrote:
> 
> In article <20051228035231.GA3356@waste.org> you write:
> >> +void fastcall __memcpy_toio32(volatile void __iomem *d, const void
> >*s, size_t count)
> >> +{
> >> +	volatile u32 __iomem *dst = d;
> >> +	const u32 *src = s;
> >> +
> >> +	while (--count >= 0) {
> >> +		__raw_writel(*src++, dst++);
> >> +}
> >
> >Suspicious use of volatile - writel is doing the actual write, this
> >function never does a dereference. As you've already got private
> >copies of the pointers already in s and d, it's perfectily reasonable
> >and idiomatic to do:
> >
> >	while (--count >= 0)
> >		__raw_writel(*s++, d++);
> 
> I don't think *s++ or d++ is going to be accepted by the compiler,
> given that s and d are both "void *"'s.  The posted code casts to
> "u32 *", which should make the dereference and autoincrement work
> correctly.
> 
> [Not posted to linux-kernel, in case I'm totally confused.]

No, you're absolutely right. It's idiomatic for things like strcpy,
where the type is known, but not for memcpy.

However, it just so happens that GCC will happily treat math on void
pointers as if they were char pointers. So this in fact will
compile without errors:

void cpy(void *a, void *b, int count)
{
        while (count--)
                copybyte(a++, b++);
}

Linus thinks this is a feature but I don't, so I'm not recommending
it. In fact, given the whole point of this function is to copy dwords,
not bytes, this GCCism fails us for type-safety.

At any rate, the dereference on s above _is_ a compile error - it's void
type.

[cc:ed back to lkml to keep me honest]

-- 
Mathematics is the supreme nostalgia of our time.
