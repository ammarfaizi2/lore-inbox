Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286945AbRL1Rnk>; Fri, 28 Dec 2001 12:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286938AbRL1Rnc>; Fri, 28 Dec 2001 12:43:32 -0500
Received: from bitmover.com ([192.132.92.2]:45218 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S286945AbRL1RnX>;
	Fri, 28 Dec 2001 12:43:23 -0500
Date: Fri, 28 Dec 2001 09:43:19 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Keith Owens <kaos@ocs.com.au>,
        "Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228094318.B3727@work.bitmover.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Larry McVoy <lm@bitmover.com>, Keith Owens <kaos@ocs.com.au>,
	"Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011227180148.A3727@work.bitmover.com> <E16JxmP-0000Yo-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16JxmP-0000Yo-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 28, 2001 at 02:14:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 02:14:37PM +0000, Alan Cox wrote:
> > Ah, OK, I get it.  Hey, would it help to have a dbm interface compat 
> > library which uses mmap instead of building the db in brk() space?
> 
> mmap for db file seems to be slower. 

I'll need to see some numbers to back up that statement, please.  If you
look at the graphs produced by LMbench, they tell you exactly what
you need to know.  It's true that for very small files, 8K and under,
using read() to access them is faster than using mmap, due to the extra
work of setting up and tearing down the mapping.  To quantify this, a
4KB open/read/close is 500MB/sec, but an open/mmap/access/unmap/close
is 425MB/sec.  By the time we hit 16K, mmap wins by 15% and just gets
better from there.

And that all assumes you are doing large reads, which in db code you 
are not.  So mmap will look better even on the small files if you 
are doing little DB style accesses.

> For basic db hash usage and raw speed
> nothing seems to touch tdb (Tridge's db hack). 

Taking nothing away from Tridge, I like Tridge, I'd like to see numbers.
I'm sure that Tridge's stuff is great, but we were very motivated to 
go well beyond the normal effort when we wrote this code.

A multithreaded version of the code that I sent to Keith was doing 455,000
lookups/second on an 8way 200Mhz R4400 SGI box in 1996.  Each lookup
was locked.  If you assume perfect scaling (it was) and you assume the
locks took 0 time (they didn't), that's 1.75 usecs for each lookup.
On a machine with horrible memory latency and a large dataset.

We designed the MDBM code to be scalable (its 64bit clean), portable
(runs on 20+ platforms today), multiplatform (metadata is stored in
network byte order on disk), and fast (we knew exactly what the 
instruction and data cache footprint was for hot cache, and we made
sure that you did at most 2 disk accesses, 1 was typical, to get at
any item in a cold cache).

SGI uses this code for their name server, every process mmaps the 
name server cache.  

We use this code all over BitKeeper.

> Its also portable code which
> is important since the tool has to be built on the compiling host.

The code works on Windows, MacOS X, and basically all Unix platforms.


Yeah, yeah, I pounding my chest and I'm sorry, but I get beat up all the
time that the BK license doesn't let you reuse code and this code is part
of BK that we broke out and licensed under the GPL.  The point being
that if there is reusable code in BK, we're willing to let people use
it under whatever license they want.  It would be nice if that actually
happened after all the yelling and screaming.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
