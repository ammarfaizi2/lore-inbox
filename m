Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272681AbRHaMt5>; Fri, 31 Aug 2001 08:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272682AbRHaMtr>; Fri, 31 Aug 2001 08:49:47 -0400
Received: from [195.89.159.99] ([195.89.159.99]:9980 "EHLO kushida.degree2.com")
	by vger.kernel.org with ESMTP id <S272681AbRHaMth>;
	Fri, 31 Aug 2001 08:49:37 -0400
Date: Fri, 31 Aug 2001 13:50:34 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Message-ID: <20010831135034.B25128@thefinal.cern.ch>
In-Reply-To: <Pine.LNX.4.33.0108300902570.7973-100000@penguin.transmeta.com> <Pine.LNX.4.33.0108301217280.9230-100000@age.cs.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108301217280.9230-100000@age.cs.columbia.edu>; from ionut@cs.columbia.edu on Thu, Aug 30, 2001 at 12:28:05PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> So now you're turning it around. If you compare a long with unsigned char,
> there is no issue.

This is _not_ true.  What Linus said about long vs. unsigned int
depending on the architecture also applies to unsigned char, on those
old 32-bit Crays.  It is legitimate for unsigned char to have the same
size as signed long.

> If you compare long with unsigned int, you get the right result on the
> alpha and a warning on x86. If you compare long with unsigned long,
> you get a warning period.

Precisely.  Buggy code (read: architecture-specific bug) is written, and
the bug isn't noticed until somebody compiles that code on a different
architecture.  Far better to have GCC warn even on the alpha.

> And read above. You get the right result on the alpha and a warning on the 
> x86. I don't see the problem with that.
> 
> If you want to be 100% paranoid, change the sign-compare warning into an 
> error, so people don't ignore it. That's a much better alternative, and 
> gcc supports it.

See example with sizeof().  Something similar applies with PAGE_SIZE and
other unsigned constants.

> > Stating the type you compare in explicitly means that you do not get
> > surprised.
> 
> No. It means I suppress the gcc warning before I get a chance to see it. 

I have to agree with Ion here.  The explicit type is very helpful, but
if it reduces argument range, it masks a real bug.  Not that the old
macros were any better.  Ideally, there should be some way to get a
warning out of GCC when a bug is masked in this way.

This is what I see as the closest to ideal:

   1. min/max with type argument, as in new kernels.

   2. Warning added to GCC for casts which reduce argument range, but
      only when explicitly requested by an attribute on the cast...

   3. Warning added to GCC for signed vs. unsigned comparisons
      _regardless_ of type size.  This would also catch erroneous
      unsigned char vs. EOF checks in misuses of stdio.

      However, a type attribute must be provided to make the result of
      sizeof() not return a warning.  (size_t _should_ return a warning,
      though, so it is not that simple).

As you can see, at least the kernel part is done :)

-- Jamie
