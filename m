Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266441AbUGJVd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266441AbUGJVd4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 17:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266442AbUGJVd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 17:33:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37097 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266441AbUGJVdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 17:33:53 -0400
To: ncunningham@linuxmail.org
Cc: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GCC 3.4 and broken inlining.
References: <2fFzK-3Zz-23@gated-at.bofh.it> <2fG2F-4qK-3@gated-at.bofh.it>
	<2fG2G-4qK-9@gated-at.bofh.it> <2fPfF-2Dv-21@gated-at.bofh.it>
	<2fPfF-2Dv-19@gated-at.bofh.it>
	<m34qohrdel.fsf@averell.firstfloor.org>
	<1089349003.4861.17.camel@nigel-laptop.wpcb.org.au>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 10 Jul 2004 18:33:40 -0300
In-Reply-To: <1089349003.4861.17.camel@nigel-laptop.wpcb.org.au>
Message-ID: <orr7rjo8cr.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  9, 2004, Nigel Cunningham <ncunningham@linuxmail.org> wrote:

> I do think that functions being declared inline when they can't be
> inlined is wrong

The problem is not when they can or cannot be inlined.  The inline
keyword has nothing to do with that.  It's a hint to the compiler,
that means that inlining the function is likely to be profitable.
But, like the `register' keyword, it's just a hint.  And, unlike the
`register' keyword, it doesn't make certain operations on objects
marked with it ill-formed (e.g., you can't take the address of an
register variable, but you can take the address of an inline
function).

The issue with inlining that makes it important for the compiler to
have something to say on the decision is that several aspects of the
profit from expanding the function inline is often machine-dependent.
It depends on the ABI (calling conventions), on how slow call
instructions are, on how important instruction cache hits are, etc.
Sure enough, GCC doesn't take all of this into account, so its
heuristics sometimes get it wrong.  But it's getting better.

Meanwhile, you should probably distinguish between must-inline,
should-inline, may-inline, should-not-inline and must-not-inline
functions.  Attribute always_inline covers the must-inline case; the
inline keyword covers the may-inline'case.  The absence of the inline
keyword implies `should-not-inline', and attribute noinline covers
must-not-inline.  should-inline can't be expressed today, and if
may-inline doesn't get the desired effect, you may feel tempted to
abuse always_inline, but I suggest you to do so using a different
macro, such that, if GCC ever introduces a new attribute that's a
stronger hint to inlining that doesn't error out if it can't be done,
you can easily switch to it.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
