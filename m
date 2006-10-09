Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751850AbWJIMKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWJIMKB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 08:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWJIMKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 08:10:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24791 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751384AbWJIMJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 08:09:59 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0610090403490.25336@schroedinger.engr.sgi.com> 
References: <Pine.LNX.4.64.0610090403490.25336@schroedinger.engr.sgi.com>  <Pine.LNX.4.64.0610061015570.14591@schroedinger.engr.sgi.com> <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com> <20061006141704.GH2563@parisc-linux.org> <7795.1160388696@redhat.com> 
To: Christoph Lameter <clameter@sgi.com>
Cc: Matthew Wilcox <matthew@wil.cx>, torvalds@osdl.org, akpm@osdl.org,
       sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 09 Oct 2006 13:09:28 +0100
Message-ID: <9954.1160395768@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:

> So this is a case for a wrapper.

But it _is_ a wrapper - but the arch gets to decide around what.  We fall back
to fls() or fls64() if no other inspiration strikes or is available, but in
some cases we can do better.

> Good stuff. I have always wanted that. The wrapper could check for a 
> constant.

That's the main reason I put it in a common file.  The const-case wrapper is
large and probably best not repeated.

> >  (3) ilog2(n) != fls(n)
> > 
> >      This means that the asm-optimised version for one might be less
> >      optimal for the other (for example, ilog2() produces an undefined
> >      result if n <= 1, fls() must return 0).
> 
> Ok these are boundary checks that are easily coded around. Some 
> variations on fls even exist that also do various flavors of end case 
> handling.

On FRV, for example, I don't want to wrap fls() because the code for ilog2()
can be shorter and simpler.

If I did fls() as a wrapper around ilog2() then it would have to involve a
conditional jump because the compiler can't alter the inline asm of ilog2() to
turn the SCAN instruction into CSCAN (which is a conditionally executed
version of SCAN).

So fls() is 5 insns and __ilog2_u32() is 1 because of the requirement that
fls() must return 0 on a zero input value.  Similarly fls64() is 14 vs 8 for
__ilog2_u64().

(I have defined ilog2(n) as returning an undefined value if n < 1).

> >  (5) fls() and fls64() can't be used to initialise a variable at compile
> >      time, ilog2() can.
> 
> Well that is the same issue as (4).

Not quite.  I think (4) might be sufficiently achievable with an inline
function, but (5) is definitely not.

David
