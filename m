Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRBHVTD>; Thu, 8 Feb 2001 16:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130259AbRBHVSy>; Thu, 8 Feb 2001 16:18:54 -0500
Received: from cs.columbia.edu ([128.59.16.20]:63901 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129737AbRBHVSj>;
	Thu, 8 Feb 2001 16:18:39 -0500
Date: Thu, 8 Feb 2001 13:18:28 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>,
        <jes@linuxcare.com>, Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <3A83017D.D84AD6B1@mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0102081259090.31024-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Jeff Garzik wrote:

> I would prefer that the zerocopy changes stay in DaveM's external patch
> until they are ready to be merged.  

I would actually prefer to have a single source for all the driver 
versions. The 2.2.x version I sent to Alan later on actually compiles on 
2.2, 2.4 and 2.4+zerocopy. I just want to test it some more; the 2.4 
version I submitted was quite well tested.

> Zerocopy is still changing and being
> actively debugged, so it is possible that we might have to patch
> starfire.c again with zerocopy updates, before the final patch makes it
> to Linus.  Let's wait on zerocopy in the main tree..

It's true that zerocopy might change. But remember, zerocopy support in 
the driver is not mandatory, and nobody forces you to #define ZEROCOPY. If 
the zerocopy proves to be unacceptable for the official kernel, ripping 
out the stuff that's #ifdef ZEROCOPY will be a trivial exercise.

> > I've also added myself as the starfire maintainer -- I hope
> > nobody objects.
> 
> If you've got the hardware and time, I'm always happy to see someone
> step up ..  

.. the hardware, the docs, the time, and the day-to-day duty to maintain 
the starfire driver (and the eepro100 driver) for an older version of 
BSDI. It's the job that pays my salary...

> I must confess that I haven't seen much of your work to
> date, however.

Oh well, I thought the code would be enough proof. For what it's worth, 
I was the main developer for the Linux version of Erez Zadok's stackable 
filesystems work. I'm also co-maintainer (with Erez and two more people) 
of the am-utils automounter suite, taking care of the Linux port and 
currently implementing autofs support for Linux and Solaris.

But hey, if you want to continue maintaining the starfire driver yourself, 
I don't really mind.

> > +/*
> > + * The ia64 doesn't allow for unaligned loads even of integers being
> > + * misaligned on a 2 byte boundary. Thus always force copying of
> > + * packets as the starfire doesn't allow for misaligned DMAs ;-(
> > + * 23/10/2000 - Jes
> > + *
> > + * Neither does the Alpha. -Ion
> > + */
> > +#if defined(__ia64__) || defined(__alpha__)
> > +#define PKT_SHOULD_COPY(pkt_len)       1
> > +#else
> > +#define PKT_SHOULD_COPY(pkt_len)       (pkt_len < rx_copybreak)
> > +#endif
> 
> Note that I have not yet sent this patch onto Linus for a reason... 
> Here is Don Becker's comment on the subject:
> 
> Donald Becker wrote:
> > On Tue, 16 Jan 2001, Jeff Garzik wrote:
> > > * IA64 support (Jes)
> > Oh, and this is completely bogus.
> > This isn't a fix, it's a hack that covers up the real problem.
> > 
> > The align-copy should *never* be required because the alignment differs
> > between DIX and E-II encapsulated packets.  The machine shouldn't crash
> > because someone sends you a different encapsulation type!

It's not *required* per se, as far as I know both the Alpha and IA64 have 
handlers for unaligned access traps. *However*, copying each packet is 
definitely better than taking an exception for each packet!

So the box won't crash. But it should behave better with this patch, in 
regular operation.

Jes can probably comment some more, it's his change after all. I have 
neither alphas nor itaniums, so my comment is based on second-hand 
knowledge and on reading the arch code.

> > @@ -757,14 +931,14 @@
> > 
> >         dev->trans_start = jiffies;
> >         np->stats.tx_errors++;
> > -       return;
> > +       netif_wake_queue(dev);
> >  }
> 
> this has not been sent on to linus/alan because, if you do not empty the
> Tx ring on tx_timeout, you should check to see if there is space on the
> ring before waking the queue.  Otherwise corruption/problems occur...

tx_timeout is completely bogus right now, to be honest. If it gets there,
you might as well just down the interface. So I just applied this part
from your patch, without really thinking about it.

What tx_timeout really needs to do is a full reset and re-initialization
of the chip. Why? Because when the timeout happens, the chip is basically
fubar'ed (usually due to driver bugs, but that's not the point).

It's in the TODO list..

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
