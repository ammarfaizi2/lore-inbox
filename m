Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317571AbSHLJGQ>; Mon, 12 Aug 2002 05:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317599AbSHLJGQ>; Mon, 12 Aug 2002 05:06:16 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:55568 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317571AbSHLJGP>; Mon, 12 Aug 2002 05:06:15 -0400
Message-ID: <3D577BC3.5BD0DE4@aitel.hist.no>
Date: Mon, 12 Aug 2002 11:11:31 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.30 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Daniel Egger <degger@fhm.edu>, linux-kernel@vger.kernel.org
Subject: Re: mmapping large files hits swap in 2.4?
References: <Pine.LNX.4.33.0208101437380.838-100000@coffee.psychology.mcmaster.ca> <1029018000.2539.7.camel@sonja.de.interearth.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:
> 
> Am Sam, 2002-08-10 um 20.49 schrieb Mark Hahn:
> 
> > > It is just that it seems the mmaped region is not really bakked by
> > > the underlying file but by swap space which was exactly what I
> > > was trying to avoid by using a file.
> 
> > why do you think that?
> 
> Because the amount of free swap shrinks continously with mmaped memory
> being touched. If I understood the concept of mmap correctly the system
> should buffer read/writes to the mapped memory location with real RAM
> and page out to the file.
                  ^^^^^^^^^
The system buffer reads/writes by bringing parts of the file into
the page cache.  Writing dirties those pages, and they
will be written back to the file during memory pressure,
or at umount time.

Your mmapped file should NOT get swapped to a swap device.
But other memory certainly may!  When you touch a lot of your
big mmapped file you create memory pressure.  Some of that
pressure writes pages back to your file.  Some of that
pressure swaps other programs / other memory out to the
swap device.  

In short - memory used to cache your big mmapped file don't merely 
compete with memory used for caching other parts of that file.
It competes with all other swappable (or discardable) memory
in the system, and some of that might go to the swap device.

Maybe you only need a little of that big file at a time - but
the VM system cannot know that.  It simply looks at _all_
memory, considers "what is recently used, and what is _not_"
and goes on to swap/writeback the latter parts.

 
> My problem actually is that although I have enough memory to buffer the
> whole area the kernel decides to hit hard on the disc which makes the
> performance suck.

You have enough RAM, but was all of it _free_ according to free?
Lots of it will usually be in use as cache, so something must be
evicted.  Cache are freed sometimes, swapping happens at
other times.

Helge Hafting
