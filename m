Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316441AbSETXsN>; Mon, 20 May 2002 19:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316445AbSETXsM>; Mon, 20 May 2002 19:48:12 -0400
Received: from [195.223.140.120] ([195.223.140.120]:4 "EHLO penguin.e-mind.com")
	by vger.kernel.org with ESMTP id <S316441AbSETXsL>;
	Mon, 20 May 2002 19:48:11 -0400
Date: Tue, 21 May 2002 01:46:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Bug with shared memory.
Message-ID: <20020520234622.GL21806@dualathlon.random>
In-Reply-To: <20020520141523.GB21806@dualathlon.random> <Pine.LNX.4.44L.0205201618110.24352-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 04:24:37PM -0300, Rik van Riel wrote:
> On Mon, 20 May 2002, Andrea Arcangeli wrote:
> 
> > With memclass_related_bhs() we automatically maximixed the amount of ram
> > available as inodes/indirects and everything else ZONE_NORMAL, after
> 
> OK, a question and a remark:
> 
> 1) does memclass_related_bhs() work if the bufferheads are
>    on another node ?  (NUMA-Q)

yes of course. With all the numa fixes all the classzone logic is
indipendent from the pgdat layer, not only during the
memclass_related_bhs check. The faster way to understand how the logic
works is to read the zone_idx/memclass define in mmzone.h.

> 2) memclass_related_bhs() will definately not work if the
>    data structure is pinned indirectly, say struct address_space
>    which is pinned by mere the existance of the page cache page
>    and cannot easily be freed

memclass_related_bhs is just for the bhs, it has nothing to do with the
address space. It's in the page->buffer side of the page, not the
page->mapping, so I don't understand very well.

the inode problem is a separate thing, nothing to do with
memclass_related_bhs(), the fix will be local to prune_icache.

For the memclass_related_bhs() fix in -aa, that's in the testing TODO
list of Martin (on the multi giga machines), he also nicely proposed to
compare it to the other throw-away-all-bh-regardless patch from Andrew
(that I actually didn't seen floating around yet but it's clear how it
works, it's a subset of memclass_related_bhs). However the right way to
test the memclass_related_bhs vs throw-away-all-bh, is to run a rewrite
test that fits in cache, so write,fsync,write,fsync,write,fsync. specweb
or any other read-only test will obviously perform exactly the same both
ways (actually theoretically a bit cpu-faster in throw-away-all-bh
because it doesn't check the bh list).

> > > or three, so he may not see your words.
> >
> > Ok. We CC'ed Rik so I assume it won't get lost in the mail flood.
> 
> I'm on holidays, don't expect patches soon :)

you shouldn't read emails either then, you know it is strictly forbidden
to read emails during vacations :). I'm kidding of course, thanks for
the fast reply!

Andrea
