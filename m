Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267505AbSIRQnR>; Wed, 18 Sep 2002 12:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267514AbSIRQnR>; Wed, 18 Sep 2002 12:43:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267505AbSIRQnO>; Wed, 18 Sep 2002 12:43:14 -0400
Date: Wed, 18 Sep 2002 09:48:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andries Brouwer <aebr@win.tue.nl>, Ingo Molnar <mingo@elte.hu>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44L.0209181330580.1519-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0209180938590.1913-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Rik van Riel wrote:

> On Wed, 18 Sep 2002, Linus Torvalds wrote:
> 
> > I would suggest something like this:
> >  - make pid_max start out at 32k or whatever, to make "ps" look nice if
> >    nothing else.
> >  - every time we have _any_ trouble at all with looking up a new pid, we
> >    double pid_max.
> 
> > +		if (nr_threads > pid_max >> 4)
> > +			pid_max <<= 1;
> 
> ... but watch out for over/underflow.  ;)

Actually, you can't overflow without having nr_threads be something like 
27 bits, which means that you'd need to have 100 million threads active at 
the same time.

Which, btw, is impossible anyway due to running out of memory to hold all
the thread data structures on a 32-bit architecture _long_ before you get
close to having a high enough nr_threads.

On a 64-bit architecture you can do it with enough memory, but even that
is a few years away (you'd need on the order of a couple of terabytes to
do it).

> It would also be nice if we had some known limit on pid_max (say 8
> million, fits in 7 digits).

Do the math. The above _will_ fit in 7 digits as long as you never have 
more then about half a million threads active at the same time.

Which, practically speaking, means that we're done. Quite frankly, the
people who maintain machines that run millions of threads concurrently 
care a hell of a lot more about the maching running _stable_ than about 
"ps" being pretty.

The people who care about ps being pretty will probably never see more 
than 5 digits.

		Linus

