Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSHNW4N>; Wed, 14 Aug 2002 18:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSHNW4N>; Wed, 14 Aug 2002 18:56:13 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:62617 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S315762AbSHNW4M>; Wed, 14 Aug 2002 18:56:12 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       linux-kernel@vger.kernel.org
Date: Wed, 14 Aug 2002 15:53:15 -0700 (PDT)
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
In-Reply-To: <20020814204556.GA7440@alpha.home.local>
Message-ID: <Pine.LNX.4.44.0208141551020.14879-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

why are you useing loops for delays in the first place? it's a solution
that will fail as clock speeds keep improving (if for no other reason then
your loop counter will end up needing to be a larger int to achieve the
desired delay!!)

rather then debating how to convince gcc how to not optimize them away and
messing up the timing we should be talking about how to eliminate such
loops in the first place.

David Lang


 On Wed, 14 Aug 2002, Willy Tarreau wrote:

> Date: Wed, 14 Aug 2002 22:45:56 +0200
> From: Willy Tarreau <willy@w.ods.org>
> To: H. Peter Anvin <hpa@zytor.com>
> Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
> Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
>
> On Wed, Aug 14, 2002 at 12:41:04PM -0700, H. Peter Anvin wrote:
> > Rogier Wolff wrote:
> > >>
> > >>Bullsh*t.  It can legitimately transform it into:
> > >>
> > >>	   i = N;
> > >
> > >
> > >Right! But people are confusing "practise", "published interface", and
> > >"spec" again.
> > >
> > >Published interface in this case is that gcc will not optimize an empty
> > >loop away, as it is often used to generate a timing loop.
> > >
> >
> > Yes.  This is a gcc-specific wart, a bad idea from the start, and
> > apparently one which has caught up with them to the point that they've
> > had to abandon it.
>
> There would be a solution to tell gcc not to optimize things, which may
> not require too much work from gcc people. Basically, we would need to
> implement a __builtin_nop() function that would respect dependencies but
> not generate any code. This way, we could have :
>
> 	for (i=0; i<N, i++);
>
> optimized as i=N
> and
> 	for (i=0; i<N; i++)
> 		__builtin_nop();
> or even
> 	for (i=0; i<N; __builtin_nop(i++));
> do the real work.
>
> This way, some loops could be optimized, and the developpers could explicitely
> tell the compiler when they need to prevent any optimization.
>
> Cheers,
> Willy
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
