Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSKKWYt>; Mon, 11 Nov 2002 17:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSKKWYt>; Mon, 11 Nov 2002 17:24:49 -0500
Received: from fmr01.intel.com ([192.55.52.18]:14040 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261448AbSKKWYs>;
	Mon, 11 Nov 2002 17:24:48 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC91C@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Mark Mielke'" <mark@mark.mielke.cc>
Cc: linux-kernel@vger.kernel.org
Subject: RE: PROT_SEM + FUTEX
Date: Mon, 11 Nov 2002 14:31:28 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> hoping that
> > > PROT_SEM is not required, as I intend to scatter the 
> words throughout
> > > memory, and it would be a real pain to mprotect(PROT_SEM) 
> each page
> > > that contains a FUTEX word.
> >
> > Still you want to group them as much as possible - each 
> time you lock
> > a futex you are pinning the containing page into physical 
> memory, that
> > would cause that if you have, for example, 4000 futexes 
> locked in 4000 
> > different pages, there is going to be 4 MB of memory locked 
> in ... it
> > helps to have an allocator that ties them together.
> 
> This is not necessarily correct for a high-capacity, low-latency
> application (i.e. a poorly designed thread architecture might suffer
> from this problem -- but a poorly designed thread architecture suffers
> from more problems than pinned pages).

Too much thinking about the general case - you are absolutely right, but
only as long as you are sure that the contention rate across the many
futexes you have is going to be _really_ low; that, or if your applications
are always mlocked in memory, then you are ok.

I keep thinking about multi-thousand threads and their locks, so spare me, I
forget about the well-designed cases.

> As far as I understand - PROT_SEM has no effect on the behaviour of
> FUTEX operations. I think it should be removed.

Rusty (Russel) declared that Linus declared that platforms that don't
implement a sane cache architecture can not implement futexes ... so I guess
this means we can forget about PROT_SEM for futexes.

> As long as the person attempting to manipulate the FUTEX word succeeds
> (i.e. 0 -> 1, or 0 -> -1, or whatever), futex_wait() need not 
> be issued.
> futex_wake() only pins the page for a brief period of time.

Define brief - remember that if the futex is locked, the page is already
pinned, futex_wake() is just making sure it is there while it uses it - and
again, as you said before, this is completely application specific; the
kernel cannot count on any specific behaviour on the user side.

> same cache line. Also, if the memory word is used to synchronize
> access to a smaller data structure (<128 bytes), it is actually
> optimal to include the memory word used to synchronize access to the
> data, and the data itself, in the same cache line.

Sure, this makes full sense; if you are using the futexes straight off from
the kernel for synchronization; however, when used by something like NGPT's
mutex system, the story changes, because you cannot assume anything, you
have to be generic - and there is my bias. 

Lucky you that don't need to worry about that :)

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]

