Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129804AbRBHVnp>; Thu, 8 Feb 2001 16:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130056AbRBHVnf>; Thu, 8 Feb 2001 16:43:35 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:3596 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129804AbRBHVn0>;
	Thu, 8 Feb 2001 16:43:26 -0500
Message-ID: <3A8311D8.C8C81E95@mandrakesoft.com>
Date: Thu, 08 Feb 2001 16:38:32 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
        jes@linuxcare.com, Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.30.0102081259090.31024-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> 
> On Thu, 8 Feb 2001, Jeff Garzik wrote:
> 
> > I would prefer that the zerocopy changes stay in DaveM's external patch
> > until they are ready to be merged.
> 
> I would actually prefer to have a single source for all the driver
> versions. The 2.2.x version I sent to Alan later on actually compiles on
> 2.2, 2.4 and 2.4+zerocopy. I just want to test it some more; the 2.4
> version I submitted was quite well tested.

Well at least let's do it the Linux Kernel Way(tm):  separate out the
zerocopy stuff such that there are minimal ifdefs in the code...  For
example:

	/* add these functions... */
	#ifdef ZEROCOPY
	static inline setup_txrx_rings(...) { /*...*/ }
	#else
	static inline setup_txrx_rings(...) { /*...*/ }
	#endif

then in the code itself, where the TxRx ring setup occurs now (ie. where
ifdefs exist in the code) simply call the new static inline functions.


> > Zerocopy is still changing and being
> > actively debugged, so it is possible that we might have to patch
> > starfire.c again with zerocopy updates, before the final patch makes it
> > to Linus.  Let's wait on zerocopy in the main tree..
> 
> It's true that zerocopy might change. But remember, zerocopy support in
> the driver is not mandatory, and nobody forces you to #define ZEROCOPY. If
> the zerocopy proves to be unacceptable for the official kernel, ripping
> out the stuff that's #ifdef ZEROCOPY will be a trivial exercise.

You totally missed my point.  It's unclean.  If you have some code that
will not work at all in the current tree, it should not be in the
current tree.  If Alan or Linus applies a starfire.c patch that includes
ZEROCOPY support while the tree as a whole does not include such
support, you are effectively including a developer-local change in the
global tree.  With your patch but without zercopy infrastructure,
defining ZEROCOPY is completely pointless without an additional,
experimental patch.

The #ifdef ZEROCOPY code you added is a classic example of the kind of
code I -remove- from the kernel tree.


> > > I've also added myself as the starfire maintainer -- I hope
> > > nobody objects.
> >
> > If you've got the hardware and time, I'm always happy to see someone
> > step up ..
> 
> .. the hardware, the docs, the time, and the day-to-day duty to maintain
> the starfire driver (and the eepro100 driver) for an older version of
> BSDI. It's the job that pays my salary...

excellent :)


> tx_timeout is completely bogus right now, to be honest. If it gets there,
> you might as well just down the interface. So I just applied this part
> from your patch, without really thinking about it.
> 
> What tx_timeout really needs to do is a full reset and re-initialization
> of the chip. Why? Because when the timeout happens, the chip is basically
> fubar'ed (usually due to driver bugs, but that's not the point).

agreed

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
