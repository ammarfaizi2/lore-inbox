Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289315AbSA1Shb>; Mon, 28 Jan 2002 13:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289312AbSA1ShW>; Mon, 28 Jan 2002 13:37:22 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:17418 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289313AbSA1ShK>;
	Mon, 28 Jan 2002 13:37:10 -0500
Date: Mon, 28 Jan 2002 16:37:02 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Josh MacDonald <jmacd@CS.Berkeley.EDU>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.33.0201281005480.1609-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0201281626340.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Linus Torvalds wrote:
> On Mon, 28 Jan 2002, Rik van Riel wrote:
> >
> > I'd be interested to know exactly how much overhead -rmap is
> > causing for both page faults and fork   (but I'm sure one of
> > the regular benchmarkers can figure that one out while I fix
> > the RSS limit stuff ;))
>
> I doubt it is noticeable on page faults (the cost of maintaining the list
> at COW should be basically zero compared to all the other costs), but I've
> seen several people reporting fork() overheads of ~300% or so.

Dave McCracken has tested with applications of different
sizes and has found fork() speed differences of 10% for
small applications up to 400% for a 10 MB (IIRC) program.

This was with some debugging code enabled, however...
(some of the debugging code I've only disabled now)

> Which is not that surprising, considering that most of the fork overhead
> by _far_ is the work to copy the page tables, and rmap makes them three
> times larger or so.

For dense page tables they'll be 3 times larger, but for a page
table with is only occupied for 10%  (eg. bash with 1.5 MB spread
over executable+data, libraries and stack) the space overhead is
much smaller.

The amount of RAM touched in fork() is mostly tripled though, if
the program is completely resident, because fork() follows VMA
boundaries.

> And I agree that COW'ing the page tables may not actually help. But it
> might be worth it even _without_ rmap, so it's worth a look.

Absolutely, this is something to try...

> (Also, I'd like to understand why some people report so much better
> times on dbench, and some people reports so much _worse_ times with
> dbench. Admittedly dbench is a horrible benchmark, but still.. Is it
> just the elevator breakage, or is it rmap itself?)

We're still looking into this.  William Irwin is running a
nice script to see if the settings in /proc/sys/vm/bdflush
have an observable influence on dbench.

Another thing which could have to do with decreased dbench
and increased tiobench performance is drop behind vs. use-once.
It turns out drop behind is better able to sustain IO streams
of different speeds and can fit more IO streams in the same
amount of cache (people running very heavily loaded ftp or
web download servers can find a difference here).

For the interested parties, I've put some text and pictures of
this phenomenon online at:

http://linux-mm.org/wiki/moin.cgi/StreamingIo

It basically comes down to the fact that use-once degrades into
FIFO, which isn't too efficient when different programs do IO
at different speeds.   I'm not sure how this is supposed to
affect dbench, but it could have an influence...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

