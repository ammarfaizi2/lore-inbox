Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288925AbSANH2h>; Mon, 14 Jan 2002 02:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288914AbSANH2T>; Mon, 14 Jan 2002 02:28:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38466 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S288890AbSANH2G>; Mon, 14 Jan 2002 02:28:06 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: Adam Kropelin <akropel1@rochester.rr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18pre3-ac1
In-Reply-To: <Pine.LNX.4.33L.0201140409260.32617-100000@imladris.surriel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Jan 2002 00:25:16 -0700
In-Reply-To: <Pine.LNX.4.33L.0201140409260.32617-100000@imladris.surriel.com>
Message-ID: <m1y9j1pf6r.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On 13 Jan 2002, Eric W. Biederman wrote:
> > Rik van Riel <riel@conectiva.com.br> writes:
> 
> > Rik while you are looking at your reverse mapping code, I would like
> > to call to your attention the at least trippling of times for fork.
> 
> Dave McCracken has measured this on his system, it seems to vary
> from between 10% for bash to 400% for a process with 10 MB of memory.

O.k. That sounds about like what I was expecting.
 
> This is a problem which will need to be solved, a number of designs
> on how to deal with this are ready, implementation needs to be done.

 
> > I wouldn't be surprised if the reason your rmap vm handles things like
> > gcc -j better than the stock kernel is simply the reduced number of
> > processes, due to slower forking.
> 
> I really doubt this, since gcc spends so much more time doing
> real work than forking that the time used in fork can be ignored,
> even if it gets 3 times slower.

But for make -j the forking is done by make and it is nearly a
fork bomb, there is simply a linear increase in the number of processes
instead of an exponential one.  So I will at least hold this as a candidate
for the make -j kernel fixes.

> > Just my 2 cents so we don't forget the caveats of the reverse map
> > approach.
> 
> The main way we can speed up fork easily is by not copying the
> page tables at all at fork time but filling them in later at page
> fault time. While this might look like it's just moving the overhead
> from one place to another, but for the typical fork()+exec() case it
> means (1) we don't copy the page tables at fork time (2) we don't
> need to free them at exec time (3) after the exec, the parent can
> just take back the complete page tables without having to take COW
> faults on all its pages.

Which is definitely a win.  Perhaps we could even have paged page tables
at that point.

There is a second piece that should make things faster as well.  Adopt
the a BSD style page table allocation where we do an order 1 allocation
and allocate both the page table and the reverse page tables all in the same
chunk of memory.  Which means you can jump from one to the other with pointer
arithmetic.  So you can lose one element of your reverse page table chain
structure.

Eric
