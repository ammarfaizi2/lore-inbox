Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279628AbRJ2Xja>; Mon, 29 Oct 2001 18:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279630AbRJ2XjV>; Mon, 29 Oct 2001 18:39:21 -0500
Received: from [63.231.122.81] ([63.231.122.81]:44402 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S279628AbRJ2XjM>;
	Mon, 29 Oct 2001 18:39:12 -0500
Date: Mon, 29 Oct 2001 16:39:20 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random.c bugfix
Message-ID: <20011029163920.F806@lynx.no>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200110291615.f9TGFYYY010564@pincoya.inf.utfsm.cl> <Pine.LNX.4.30.0110291053240.5815-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0110291053240.5815-100000@waste.org>; from oxymoron@waste.org on Mon, Oct 29, 2001 at 10:58:28AM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 29, 2001  10:58 -0600, Oliver Xymoron wrote:
> > > (*) I don't know enough about the hash functions to know how to add a
> > >     few odd bytes into the store in a useful and safe way.  We don't
> > >     really want to discard them either - think if a user-space random
> > >     daemon on an otherwise entropy-free system only writes one byte at
> > >     a time...
> >
> > I'm no expert either, but padding with anything (zeroes?) to get the right
> > length should be safe, no?
> 
> No. A 4-byte accumulator is the right answer. We have to be careful here
> though - the actual entropy might be in the partial words, we have to
> account for it conservatively.

In a large majority of the cases, there are only full-word entropy additions.
The only time we need to deal with sub-word additions is from random_write()
and from the equivalent ioctl.  It also appears that we do this when filling
the secondary pool, but that is OK because we periodically dump far more
entropy into the secondary pool than we could possibly lose through rounding
errors.

Having an accumulator would only handle a rarely-used corner case.  We
could just as easily fix any user-space entropy daemon to write at least
4 bytes at a time.  Alternately, we could "pad" with enough bytes from
the random pool, and not accumulate at all.

In any case, this is in the noise compared to not using the input data
at all (which I fixed in the other patch).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

