Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267803AbTBRNSH>; Tue, 18 Feb 2003 08:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267805AbTBRNSH>; Tue, 18 Feb 2003 08:18:07 -0500
Received: from mail.zmailer.org ([62.240.94.4]:59038 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S267803AbTBRNSF>;
	Tue, 18 Feb 2003 08:18:05 -0500
Date: Tue, 18 Feb 2003 15:28:03 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, Mark J Roberts <mjr@znex.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Annoying /proc/net/dev rollovers.
Message-ID: <20030218132803.GB1073@mea-ext.zmailer.org>
References: <20030217103553.GH1073@mea-ext.zmailer.org> <Pine.LNX.4.44.0302172057170.656-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302172057170.656-100000@dlang.diginsite.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 08:58:40PM -0800, David Lang wrote:
> don't forget that 10G ethernet is starting to leak out of the labs into
> the real world. I don't know of any linux support yet, but it will come
> and then you will be able to overflow 32bit bitcounters multiple times per
> second.

A machine capable to support full data speed of 10G ether needs ...
around 1.3 GB/sec I/O speed both ways for the card, which at
64-bit PCI-X 533 -- is at most 4.3 GB/sec.  In reality one can't
quite get the theorethical maximum out of the hardware.
One full-speed full-duplex 10G ether is barely doable with that new
version of PCI-X.

A giga-ether interface (or two) can be done in current generation 
hardware, and even some usefull things can be done to fill the pipe.

I do suppose that at the time we are also using 64-bit processors,
in which incrementing 64-bit counter variables uninterruptably is
trivial. 

I leave it as a thought excercise, as to why non-irq-blocking spinlock
is not a good idea to ensure data update monotonicity.


There are algorithmic ways to handle interruptible two-fetch
consistency problem in current 32-bit hardware.  None of those
are being used, as far as I know:

irq-context:
   add to less-significant-long
   add carry to more-significant-long

reader context:
   read less-significant-long into ax
   read more-significant-long into bx
   compare less-significant-long with ax
    if differ, start from begin
   compare more-significant-long with bx
    if differ, start from begin
   return ax,bx

That way the reader need not worry interrupting,
but implementation is -- likely -- assembly.


No spinlocks, no irq-blocking...


> David Lang

  /Matti Aarnio


>  On Mon, 17 Feb 2003, Matti Aarnio wrote:
> 
> > Date: Mon, 17 Feb 2003 12:35:53 +0200
> > From: Matti Aarnio <matti.aarnio@zmailer.org>
> > To: Mark J Roberts <mjr@znex.org>, linux-kernel@vger.kernel.org
> > Subject: Re: Annoying /proc/net/dev rollovers.
> >
> > On Sun, Feb 16, 2003 at 08:21:56PM -0800, Chris Wedgwood wrote:
> > > On Sun, Feb 16, 2003 at 08:46:05PM -0600, Mark J Roberts wrote:
> > > > When the windows box behind my NAT is using all of my 640kbit/sec
> > > > downstream to download movies, it takes a little over 14 hours to
> > > > download four gigabytes and roll over the byte counter.
> > >
> > > Therefore userspace needs to check the counters more often... say ever
> > > 30s or so and detect rollover.  Most of this could be simply
> > > encapsulated in a library and made transparent to the upper layers.
> >
> >   Some of my colleques complained once, that at full tilt
> >   the fiber-channel fabric overflowed its SNMP bitcounters
> >   every 2 seconds.
> >
> >   "we need to do polling more rapidly, than the poller can do"
> >
> >   The SNMP pollers do handle gracefully 32-bit unsigned overlow,
> >   they just need to get snapshots in increments a bit under 2G...
> >   (Hmm.. perhaps I remember that wrong, a bit under 4G should be ok.)
> >
> > >   --cw
> >
> > /Matti Aarnio
