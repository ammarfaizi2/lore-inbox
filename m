Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312166AbSCRBwl>; Sun, 17 Mar 2002 20:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312165AbSCRBwb>; Sun, 17 Mar 2002 20:52:31 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:32384 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S312163AbSCRBwR>; Sun, 17 Mar 2002 20:52:17 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 17 Mar 2002 17:56:47 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <Pine.LNX.4.33.0203171720330.14135-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0203171748210.7378-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2002, Linus Torvalds wrote:

> On Sun, 17 Mar 2002, Davide Libenzi wrote:
> >
> > What's the reason that would make more convenient for us, upon receiving a
> > request to map a NNN MB file, to map it using 4Kb pages instead of 4MB ones ?
>
> Ehh.. Let me count the ways:
>  - reliably allocation of 4MB of contiguous data
>  - graceful fallback when you need to start paging
>  - sane coherency with somebody who mapped the same file/segment in a much
>    smaller chunk
>
> Guyes, 4MB pages are always going to be a special case. There's no sane
> way to make them automatic, for the simple reason that they are USELESS
> for "normal" work, and they have tons of problems that are quite
> fundamental and just aren't going away and cannot be worked around.
>
> The only sane way to use 4MB segments is:
>
>  - the application does a special system call (or special flag to mmap)
>    saying that it wants a big page and doesn't care about coherency with
>    anybody else that didn't set the flag (and realize that that probably
>    includes things like read/write)
>
>  - the machine has sufficiently enough memory that the user can be allowed
>    to _lock_ the area down, so that you don't have to worry about
>    swapping out that thing in 4M pieces. (This of course implies that
>    per-user memory counters have to work too, or we have to limit it by
>    default with a rlimit or something to zero).
>
> In short, very much a special case.
>
> (There are two reasons you don't want to handle paging on 4M chunks: (a)
> they may be wonderful for IO throughput, but they are horrible for latency
> for other people and (b) you now have basically just a few bits of usage
> information for 4M worth of memory, as opposed to a finer granularity view
> of which parts are actually _used_).
>
> Once you can count on having memory sizes in the hundreds of Gigs, and
> disk throughput speeds in the hundreds of megs a second, and ther are
> enough of these machines to _matter_ (and reliably 64-bit address spaces
> so that virtual fragmentation doesn't matter), we might make 4MB the
> regular mapping entity.
>
> That's probably at least a decade away.

Plenty of reason thanks Linus :) ... even if workstations with Gigs of RAM
and no swap are not so uncommon nowadays. Anyway i agree about the flag
driven activation ...




- Davide


