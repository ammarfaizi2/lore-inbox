Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbVLIWzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbVLIWzN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 17:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVLIWzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 17:55:12 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:11872 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932500AbVLIWzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 17:55:11 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH 2.6-git] SPI core refresh
Date: Fri, 9 Dec 2005 14:55:00 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
References: <20051201191109.40f2d04b.vwool@ru.mvista.com> <200512071759.56782.david-b@pacbell.net> <4397D3AA.6050804@ru.mvista.com>
In-Reply-To: <4397D3AA.6050804@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512091455.01790.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >Whereas I've just said such threading policies don't belong in a "core" at
> >all.  You may have noticed the bitbanging adapter I posted ... oddly, that
> >implementation allocates a thread.  Hmm ...
> >  
> >
> Please remember that using threads is just a default option which may be 
> even turned off at the kernel configuration stage.

People keep saying "make it a library" in such cases, and that's the
kind of layering I've come to think is more appropriate.  So that
bitbang code needs some reshaping.  As a library, not driver or core.


> I don't argue about the need of chaining.
> But don't you want to agree that things like this
> 
> +	struct spi_transfer	x[1] = { { .tx_dma = 0, }, };
> ...more initialization follows, spread around the code...

Not quite accurate.  That initializes everything to zero, much like
memcpy.  What happens later is just kicking in the relevant options.


> are not well-readable and may shadow what's going on and even lead to 
> errors during support/extension of the functionality?

I've had my concerns, but that "zero init is safe" rule makes it easy
to add things in backwards-compatible ways.  (I'll document it.)  So
that code is equivalent to GCC calling

	static inline void
	spi_transfer_init(struct spi_transfer *t, unsigned count)
		{ memset(t, 0, count * sizeof t); }

It might be useful having and using some SPI_TRANSFER_INITIALIZER for
cases like that one.


> Exposing SPI message structure doesn't look good to me also because 
> you're making it a part of the interface (and thus unlikely to change).

The interface will be the interface, sure.  Whatever it is.
And will accordingly be unlikely to change.  We know that
from every other API in Linux and elsewhere; nothing new.

Was there some specific issue you forgot to raise here?

This one includes a chained/atomic message, which we agreed
are important.  It's also simple to set up, IMO another
Good Thing.  Dropping transfer sequencing, or making things
harder to set up, doesn't sound so good ...


> We're hiding spi_msg internals what allows us to be more flexible in 
> implementation (for instance, implement our own allocation technique for 
> spi_msg (more lightweight as the size is always the same).

What you're doing is requiring a standard dynamic allocation model for
your "spi_msg" objects ... one per transfer even, much heavier weight than
the "one per transfer group" model of current "spi_message".  (And much
heavier than stack based allocation too.)

At which point krefcounting should surely kick in, and all kinds of stuff.
I'd rather not require such things, but there's no reason such a model
couldn't be a layer on top of what I've shown.  Either a thin one (just
add krefs) or a fat one (which one expects would add real value).


> Yeah thus we don't have an ability to allocate SPI messages on stack as 
> you do, that's what votes for your approach. Yours is thus a bit faster, 
> though I suspect that this method is a possible *danger* for really 
> high-speed devices with data bursts on the SPI bus like WiFi adapters: 
> stack's gonna suffer from large amounts of data allocated.

No, you're still thinking about a purely synchronous programming model;
which we had agreed ages ago was not required.

Have a look at that ADS 7846 driver.  It always submits batched requests,
which happen to be heap allocated (not stack allocated) since some of them
must be issued from hardware IRQ context.  The technique generalizes easily.
And yes, kzalloc() is your friend.

- Dave

