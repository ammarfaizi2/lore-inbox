Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284264AbSBDTPe>; Mon, 4 Feb 2002 14:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285417AbSBDTPW>; Mon, 4 Feb 2002 14:15:22 -0500
Received: from zok.SGI.COM ([204.94.215.101]:11974 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S284264AbSBDTPI>;
	Mon, 4 Feb 2002 14:15:08 -0500
Subject: Re: O_DIRECT fails in some kernel and FS
From: Steve Lord <lord@sgi.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wedgwood <cw@f00f.org>,
        Jeff Garzik <garzik@havoc.gtf.org>, Chris Mason <mason@suse.com>,
        Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E16Xnkv-0004mk-00@starship.berlin>
In-Reply-To: <E16XlK0-0007Wu-00@the-village.bc.nu>
	<1012838546.26363.588.camel@jen.americas.sgi.com> 
	<E16Xnkv-0004mk-00@starship.berlin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Feb 2002 13:11:12 -0600
Message-Id: <1012849872.7434.639.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-04 at 12:22, Daniel Phillips wrote:
> On February 4, 2002 05:02 pm, Steve Lord wrote:
> > But async I/O itself needs synchronisation (being English in this email ;-)
> > to be meaningful. If I issue a bunch of async I/O calls which overlap with
> > each other then the outcome is really undefined in terms of what ends up
> > on the disk. Scheduling of the actual I/O operations is really no different
> > from them being synchronous calls from different user space threads.
> > 
> > The only questions you can really ask is 'is read atomic with respect to
> > write?' and 'are writes atomic with respect to each other?'. So when you
> > perform a read it sees data from before or after writes, but never sees
> > data from half way through a write. And for multiple write calls the output
> > appears as if one write happened after the other, not intermingled
> > with each other.
> 
> Why is it not ok to have the writes come out intermingled, if that's what the 
> user has asked for?  (Implicitly, by not synchronizing the writes.)

I cannot quote a source, but I have heard people say Posix - or some
other standard, all I can find on google is people saying read is
atomic wrt to write, but there is no definition of writes wrt other
writes.

> 
> > Irix actually takes the viewpoint that it only needs to make a best effort
> > at synchronizing between direct I/O and other modes of I/O. Multiple
> > direct writers are allowed into a file at once, and direct writers and
> > buffered readers are also allowed to operate in parallel. At this point
> > coherency is really up to the applications. I am not presenting this as
> > a recommended model for linux, just reporting what it does.
> 
> I'm having a little trouble with this.  Suppose an application does direct
> IO on a file but, unbeknownst to it, some other program has done buffered
> IO on the file, so that there are still dirty blocks in the page cache,
> waiting to land by surprise on top of unbuffered data.  A third program
> may come along to do buffered IO on the file, and find stale blocks in
> cache.  Am I missing something here?

No you are not, I did not say it was totally coherent, at the start of
the direct I/O the caches are made coherent, they can drift apart during
the operation if buffered or mmapped I/O is ongoing during the operation,
and yes those blocks are stale in the cache.

In normal life people do not seem to mix direct I/O and other forms of
I/O in parallel.

If you want full coherency you have to lock out page faults and buffered
I/O during direct I/O. You also need to deadlock avoidance code for the
case where someone does this:

	fd = open("file", O_DIRECT|O_RDWR);
	mem = mmap(&addr, 40960, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 20480);
	read(fd, mem, 32768);


Steve

> 
> -- 
> Daniel
-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
