Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319370AbSHQJHi>; Sat, 17 Aug 2002 05:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319372AbSHQJHi>; Sat, 17 Aug 2002 05:07:38 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:52210 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S319370AbSHQJHh>; Sat, 17 Aug 2002 05:07:37 -0400
Date: Sat, 17 Aug 2002 03:09:50 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with random.c and PPC
Message-ID: <20020817090950.GN9642@clusterfs.com>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	linux-kernel@vger.kernel.org
References: <80256C17.00376E92.00@notesmta.eur.3com.com> <20020816195254.GL5418@waste.org> <200208161751.35895.henrique@cyclades.com> <20020817004520.GN5418@waste.org> <20020817060507.GM9642@clusterfs.com> <20020817072310.GQ5418@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020817072310.GQ5418@waste.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 17, 2002  02:23 -0500, Oliver Xymoron wrote:
> On Sat, Aug 17, 2002 at 12:05:07AM -0600, Andreas Dilger wrote:
> > On Aug 16, 2002  19:45 -0500, Oliver Xymoron wrote:
> > One of the problems, I believe, is that reading from /dev/urandom will
> > also deplete the entropy pool, just like reading from /dev/random.
> > The only difference is that when the entropy is gone /dev/random will
> > stop and /dev/urandom will continue to provide data.
> 
> Yep, this is a longstanding problem. Will look into it and a couple
> other things once I get the my current batch of patches running
> against -current.

Sure.

> BTW, did ttyso ever ACK your last set of random changes or is it safe
> to assume it's unmaintained?

Yes, a while later.  I'm sure it wouldn't hurt to post your patches here
before submission, but I don't think you need to funnel them through Ted.

> > If you are in there fixing things, it might make sense to have
> > /dev/urandom extract entropy from the random pool far less often than
> > /dev/random.  This way people who use /dev/urandom for a source of
> > less-strong randomness (e.g. TCP sequence numbers or whatever), will
> > not be shooting themselves in the foot for when they need a 2048-byte
> > PGP key, if they are low on entropy sources.
> 
> Not sure this is an ideal fix. We might instead have an entropy
> low-water mark (say 1/2 pool size), below which /dev/urandom will not
> deplete the pool. This way when we have ample entropy, both devices
> will behave like TRNGs, with /dev/urandom falling back to PRNG when a
> shortage is threatened.

Well, I can think of a few mechanisms that would work better than a
simple on/off method that you are proposing.  The current code will
basically "fill" the urandom pool each time it is depleted, and then
when the entropy is gone it will just go on dumping out data.  You
could make urandom only get more entropy each N times through its pool,
or make N a function of the "fullness" of the available entropy.  Then
if a system has lots of entropy sources urandom is TRNG, but if not
it will gracefully degrade from TRNG to PRNG without wiping out all
the entropy in the process.

As an alternative, instead of taking poolsize bytes of entropy each
N uses, you could take some small amount of entropy to mix into the
pool slowly.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

