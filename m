Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312160AbSCRBck>; Sun, 17 Mar 2002 20:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312162AbSCRBc3>; Sun, 17 Mar 2002 20:32:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:522 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312160AbSCRBcP>; Sun, 17 Mar 2002 20:32:15 -0500
Date: Sun, 17 Mar 2002 17:31:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <Pine.LNX.4.44.0203171709000.7378-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0203171720330.14135-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Mar 2002, Davide Libenzi wrote:
>
> What's the reason that would make more convenient for us, upon receiving a
> request to map a NNN MB file, to map it using 4Kb pages instead of 4MB ones ?

Ehh.. Let me count the ways:
 - reliably allocation of 4MB of contiguous data
 - graceful fallback when you need to start paging
 - sane coherency with somebody who mapped the same file/segment in a much
   smaller chunk

Guyes, 4MB pages are always going to be a special case. There's no sane
way to make them automatic, for the simple reason that they are USELESS
for "normal" work, and they have tons of problems that are quite
fundamental and just aren't going away and cannot be worked around.

The only sane way to use 4MB segments is:

 - the application does a special system call (or special flag to mmap)
   saying that it wants a big page and doesn't care about coherency with
   anybody else that didn't set the flag (and realize that that probably
   includes things like read/write)

 - the machine has sufficiently enough memory that the user can be allowed
   to _lock_ the area down, so that you don't have to worry about
   swapping out that thing in 4M pieces. (This of course implies that
   per-user memory counters have to work too, or we have to limit it by
   default with a rlimit or something to zero).

In short, very much a special case.

(There are two reasons you don't want to handle paging on 4M chunks: (a)
they may be wonderful for IO throughput, but they are horrible for latency
for other people and (b) you now have basically just a few bits of usage
information for 4M worth of memory, as opposed to a finer granularity view
of which parts are actually _used_).

Once you can count on having memory sizes in the hundreds of Gigs, and
disk throughput speeds in the hundreds of megs a second, and ther are
enough of these machines to _matter_ (and reliably 64-bit address spaces
so that virtual fragmentation doesn't matter), we might make 4MB the
regular mapping entity.

That's probably at least a decade away.

		Linus

