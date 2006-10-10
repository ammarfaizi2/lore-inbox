Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbWJJJ6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWJJJ6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 05:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbWJJJ6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 05:58:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37783 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965132AbWJJJ6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 05:58:47 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0610091012330.27355@schroedinger.engr.sgi.com> 
References: <Pine.LNX.4.64.0610091012330.27355@schroedinger.engr.sgi.com>  <Pine.LNX.4.64.0610090403490.25336@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0610061015570.14591@schroedinger.engr.sgi.com> <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com> <20061006141704.GH2563@parisc-linux.org> <7795.1160388696@redhat.com> <9954.1160395768@redhat.com> 
To: Christoph Lameter <clameter@sgi.com>
Cc: Matthew Wilcox <matthew@wil.cx>, torvalds@osdl.org, akpm@osdl.org,
       sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 10 Oct 2006 10:58:10 +0100
Message-ID: <2396.1160474290@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:

> On Mon, 9 Oct 2006, David Howells wrote:
> 
> > On FRV, for example, I don't want to wrap fls() because the code for ilog2()
> > can be shorter and simpler.
> > 
> > If I did fls() as a wrapper around ilog2() then it would have to involve a
> > conditional jump because the compiler can't alter the inline asm of
> > ilog2() to turn the SCAN instruction into CSCAN (which is a conditionally
> > executed version of SCAN).
>
> Hmmm.. Why not? If you can define fls on a per arch basis then that should 
> be possible? You can tell the compiler to produce the correct version of 
> the scan instructions. We do that frequently on IA64.

Ummm...  How?  As far as I know there's no way to do that.  Actually, it's
harder than just changing SCAN into CSCAN: you can't tell the compiler about
condition code type parameters to inline asm, so you have to embed all the
conditional bits in the inline asm if you want them, and not if you don't.

> > (I have defined ilog2(n) as returning an undefined value if n < 1).
> 
> Undefined values are bad. Could you produce a runtime error instead?

But if I make it clear to the user of ilog(n) that *they* are expected to check
the parameters, then it shouldn't be a problem.  Quite often there's no need to
check because n can't be out of range without other things breaking.

Doing enforced runtime error checking slows things down and is frequently
unnecessary.  Actually, in a way it's better to let the caller do it as they
know whether it's necessary, and can probably find a better place to do it.

Consider div64(): that might not produce an error if the divisor is 0.  And
then there's __ffs() which is explicitly stated as producing an undefined
result if no bits are set in its argument.

> > > >  (5) fls() and fls64() can't be used to initialise a variable at compile
> > > >      time, ilog2() can.
> > > 
> > > Well that is the same issue as (4).
> > 
> > Not quite.  I think (4) might be sufficiently achievable with an inline
> > function, but (5) is definitely not.
> 
> With the appropriate per arch modification of fls() this should also be 
> possible within the existing framework.

True, but I suspect that's going to be less required of fls() and co.

David
