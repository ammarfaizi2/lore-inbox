Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129759AbRAEA6m>; Thu, 4 Jan 2001 19:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129518AbRAEA6c>; Thu, 4 Jan 2001 19:58:32 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:17414 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129759AbRAEA6U>; Thu, 4 Jan 2001 19:58:20 -0500
Date: Thu, 4 Jan 2001 21:06:34 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: And oh, btw..
In-Reply-To: <Pine.LNX.4.10.10101041546120.1153-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101042050421.1453-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2001, Linus Torvalds wrote:

> 
> In a move unanimously hailed by the trade press and industry analysts as
> being a sure sign of incipient braindamage, Linus Torvalds (also known as
> the "father of Linux" or, more commonly, as "mush-for-brains") decided
> that enough is enough, and that things don't get better from having the
> same people test it over and over again. In short, 2.4.0 is out there.

I have 1 patch which has not been answered and I still dont know if you
want it only for 2.5.

I dunno if you've read the swap write clustering patch I sent sometime
ago. Basically it changes swap_writepage to search for physically
contiguous dirty swap cache pages and if it finds them, it writes all of
them in a cluster. The nice thing is that we save disk seek time which are
well known to be nasty.

I've received one report of 13% improvement with dbench and reiserfs, and
on my own benchmarks I've seen improvements of 15% successful write merges
on the swap device (using SAR patch to measure).

I'm not sure if its a intrusive change now with 2.4.0 released. What do
you think?

----

Another problem which we have now is swap-in readahead. Currently swapin
readahead is done on a physical device basis.

The problem is that physical swap pages are not necessarily virtually
contiguous. So what can happen (and is happening) is that we readahead
pages which are not going to be used soon.

What we probably want to do is only readahead swap pages if they really
are virtually contiguous too, to avoid wasting memory and IO processing
with "guesses" about the swap device.

I have a patch which does that (I'm still searching for an SMP deadlock
but I'm looking at it). It walks the virtually contiguous pte's starting
from the one which was faulted, and then it only cluster them if they are
virtually contiguous too.

I'll send the patch as soon as I figured out the deadlock and stress it a
more.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
