Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318069AbSHKSnF>; Sun, 11 Aug 2002 14:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318075AbSHKSnF>; Sun, 11 Aug 2002 14:43:05 -0400
Received: from bitmover.com ([192.132.92.2]:28105 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S318069AbSHKSnE>;
	Sun, 11 Aug 2002 14:43:04 -0400
Date: Sun, 11 Aug 2002 11:46:33 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
Message-ID: <20020811114633.A17310@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Morton <akpm@zip.com.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D56147E.15E7A98@zip.com.au> <1029095396.16216.18.camel@irongate.swansea.linux.org.uk> <3D56B13A.D3F741D1@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D56B13A.D3F741D1@zip.com.au>; from akpm@zip.com.au on Sun, Aug 11, 2002 at 11:47:22AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 11:47:22AM -0700, Andrew Morton wrote:
> Alan Cox wrote:
> > 
> > On Sun, 2002-08-11 at 08:38, Andrew Morton wrote:
> > > This information loss is unfortunate.  Examples:
> > >
> > >       for (i = 0; i < N; i++)
> > >               prefetch(foo[i]);
> > >
> > >    Problem is, if `prefetch' is a no-op, the compiler will still
> > >    generate an empty busy-wait loop.  Which it must do.
> > 
> > Why - nothing there is volatile
> 
> Because the compiler sees:
> 
> 	for (i = 0; i < N; i++)
> 		;
> 
> and it says "ah ha.  A busy wait delay loop" and leaves it alone.
> 
> It's actually a special-case inside the compiler to not optimise
> away such constructs.

Good lord.  If anyone depends all versions of GCC to not optimize this away,
they are going to hate life.  Since GCC doesn't seem to do cross file 
optimization (does it?) I've found the following works well:

	cat > use_result.c
	int dummy;	// can't be static, the compiler will see it's not read

	use_result(int i)
	{
		dummy = i;
	}
	^D

	for (i = 0; i < N; ++i) use_result(i);

I'm positive we do stuff like this in LMbench, which is fairly well supported
on a pile of different platforms/compilers.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
