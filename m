Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266203AbUGKFwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266203AbUGKFwV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 01:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUGKFwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 01:52:21 -0400
Received: from colin2.muc.de ([193.149.48.15]:30729 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266203AbUGKFwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 01:52:17 -0400
Date: 11 Jul 2004 07:52:16 +0200
Date: Sun, 11 Jul 2004 07:52:16 +0200
From: Andi Kleen <ak@muc.de>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: ncunningham@linuxmail.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GCC 3.4 and broken inlining.
Message-ID: <20040711055216.GA87770@muc.de>
References: <2fFzK-3Zz-23@gated-at.bofh.it> <2fG2F-4qK-3@gated-at.bofh.it> <2fG2G-4qK-9@gated-at.bofh.it> <2fPfF-2Dv-21@gated-at.bofh.it> <2fPfF-2Dv-19@gated-at.bofh.it> <m34qohrdel.fsf@averell.firstfloor.org> <1089349003.4861.17.camel@nigel-laptop.wpcb.org.au> <orr7rjo8cr.fsf@livre.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orr7rjo8cr.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 06:33:40PM -0300, Alexandre Oliva wrote:
> On Jul  9, 2004, Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> 
> > I do think that functions being declared inline when they can't be
> > inlined is wrong
> 
> The problem is not when they can or cannot be inlined.  The inline
> keyword has nothing to do with that.  It's a hint to the compiler,
> that means that inlining the function is likely to be profitable.
> But, like the `register' keyword, it's just a hint.  And, unlike the
> `register' keyword, it doesn't make certain operations on objects
> marked with it ill-formed (e.g., you can't take the address of an
> register variable, but you can take the address of an inline
> function).

The main reason always_inline was added is that gcc 3.3 stopped
inlining copy_from/to_user, which generated horrible code bloat
(because it consists of a lot of code that was supposed to be optimized away,
and putting it in a static into every module generated a lot of useless code) 

At this time the poor person blessed with this compiler y took the easy way out - 
just define inline as always_inline.

It may have been possible to do it only for selected functions, but that
would have been a lot of work: you cannot really expect that the
kernel goes through a large effort just to work around compiler
bugs in specific compiler versions.

The gcc 3.4/3.5 inliner seem to be better, but is still quite bad in cases
(e.g. 3.5 stopped to inline the three line fix_to_virt() which requires 
inlining). For 3.4/3.5 it's probably feasible to do this, but I doubt
it is worth someone's time for 3.3. 

> The issue with inlining that makes it important for the compiler to
> have something to say on the decision is that several aspects of the
> profit from expanding the function inline is often machine-dependent.
> It depends on the ABI (calling conventions), on how slow call
> instructions are, on how important instruction cache hits are, etc.
> Sure enough, GCC doesn't take all of this into account, so its
> heuristics sometimes get it wrong.  But it's getting better.

gcc is extremly dumb at that currently. Linux has a lot of inline
functions like

static inline foo(int arg) 
{ 
	if (__builtin_constant_p(arg)) { 
		/* lots of code that checks for arg and does different things */
	} else { 
		/* simple code */
	}
} 

(e.g. take a look at asm/uaccess.h for extreme examples) 

The gcc inliner doesn't know that all the stuff in the constant case
will be optimized away and it assumes the function is big. That's 
really a bug in the inliner.

But even without that it seems to do badly - example is asm/fixmap.h:fix_to_virt()

#define __fix_to_virt(x)        (FIXADDR_TOP - ((x) << PAGE_SHIFT))
static inline unsigned long fix_to_virt(const unsigned int idx)
{
        if (idx >= __end_of_fixed_addresses)
                __this_fixmap_does_not_exist();

        return __fix_to_virt(idx);
}


This three liner is _not_ inlined in current gcc mainline.
I cannot describe this in any other way than badly broken.

> Meanwhile, you should probably distinguish between must-inline,
> should-inline, may-inline, should-not-inline and must-not-inline
> functions.  Attribute always_inline covers the must-inline case; the

You're asking us to do a lot of work just to work around compiler bugs?

I can see the point of having must-inline - that's so rare that
it can be declared by hand. May inline is also done, except
for a few misguided people who use -O3. should not inline seems
like overkill.

-Andi
