Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262048AbRENBph>; Sun, 13 May 2001 21:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262065AbRENBpS>; Sun, 13 May 2001 21:45:18 -0400
Received: from bitmover.com ([207.181.251.162]:55112 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S262048AbRENBpK>;
	Sun, 13 May 2001 21:45:10 -0400
Date: Sun, 13 May 2001 18:45:09 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
Message-ID: <20010513184509.P2103@work.bitmover.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200105140117.f4E1HqN07362@vindaloo.ras.ucalgary.ca> <Pine.LNX.4.21.0105131824090.20981-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0105131824090.20981-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, May 13, 2001 at 06:32:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 06:32:02PM -0700, Linus Torvalds wrote:
> >   Hi, Linus. I've been thinking more about trying to warm the page
> > cache with blocks needed by the bootup process. What is currently
> > missing is (AFAIK) a mechanism to find out what inodes and blocks have
> > been accessed. Sure, you can use bmap() to convert from file block to
> > device block, but first you need to figure out the file blocks
> > accessed. I'd like to find out what kind of patch you'd accept to
> > provide the missing functionality.
> 
> Why would you use bmap() anyway? You CANNOT warm up the page cache with
> the physical map nr as discussed. So there's no real point in using
> bmap() at any time.

Ha.  For once you're both wrong but not where you are thinking.  One of
the few places that I actually hacked Linux was for exactly this - it was
in the 0.99 days I think.  I saved the list of I/O's in a file and filled
the buffer cache with them at next boot.  It actually didn't help at all.

I don't remember why, maybe it was back so long ago that I didn't have the
memory, but I think it was more subtle than that.  It's basically a queuing
problem and my instincts were wrong, I thought if I could get all the data
in there then things would go faster.  If you think through all the stuff
going on during a boot it doesn't really work that way.

Anyway, a _much_ better thing to do would be to have all this data laid
out contig, then slurp in all the blocks in on I/O and then let them get
turned into files.  This has been true for the last 30 years and people
still don't do it.  We're actually moving in this direction with BitKeeper,
in the future, large numbers of small files will be stored in one big file
and extracted on demand.  Then we do one I/O to get all the related stuff.

Dave Hitz at NetApp is about the only guy I know who really gets this,
Daniel Phillips may also get it, he's certainly thinking about it.  Lots
of little I/O's == bad, one big I/O == good.  Work through the numbers 
and it starts to look like you'd never want to do less than a 1MB I/O,
probably not less than a 4MB I/O.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
