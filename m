Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRBHUeV>; Thu, 8 Feb 2001 15:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130998AbRBHUeL>; Thu, 8 Feb 2001 15:34:11 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:65034 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129737AbRBHUeB>;
	Thu, 8 Feb 2001 15:34:01 -0500
Message-ID: <3A83017D.D84AD6B1@mandrakesoft.com>
Date: Thu, 08 Feb 2001 15:28:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
CC: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
        jes@linuxcare.com, Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <200102080152.f181q6G17259@moisil.dev.hydraweb.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> 
> Hi Jeff,
> 
> On Wed, 07 Feb 2001 14:57:16 -0500, Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> 
> > Here's the patch I have, against vanilla 2.4.2-pre1, with the
> > pci_enable_device preferred changes included...
> 
> Well, I decided to bite the bullet and port my zerocopy starfire
> changes to the official tree, properly ifdef'ed. So here it goes,
> the patch was made against 2.4.1 vanilla and includes all the
> fixes from Jeff and myself that were sent to the list so far.

I would prefer that the zerocopy changes stay in DaveM's external patch
until they are ready to be merged.  Zerocopy is still changing and being
actively debugged, so it is possible that we might have to patch
starfire.c again with zerocopy updates, before the final patch makes it
to Linus.  Let's wait on zerocopy in the main tree..


> I've also added myself as the starfire maintainer -- I hope
> nobody objects.

If you've got the hardware and time, I'm always happy to see someone
step up ..   I must confess that I haven't seen much of your work to
date, however.


> +/*
> + * The ia64 doesn't allow for unaligned loads even of integers being
> + * misaligned on a 2 byte boundary. Thus always force copying of
> + * packets as the starfire doesn't allow for misaligned DMAs ;-(
> + * 23/10/2000 - Jes
> + *
> + * Neither does the Alpha. -Ion
> + */
> +#if defined(__ia64__) || defined(__alpha__)
> +#define PKT_SHOULD_COPY(pkt_len)       1
> +#else
> +#define PKT_SHOULD_COPY(pkt_len)       (pkt_len < rx_copybreak)
> +#endif

Note that I have not yet sent this patch onto Linus for a reason... 
Here is Don Becker's comment on the subject:

Donald Becker wrote:
> On Tue, 16 Jan 2001, Jeff Garzik wrote:
> > * IA64 support (Jes)
> Oh, and this is completely bogus.
> This isn't a fix, it's a hack that covers up the real problem.
> 
> The align-copy should *never* be required because the alignment differs
> between DIX and E-II encapsulated packets.  The machine shouldn't crash
> because someone sends you a different encapsulation type!

> @@ -757,14 +931,14 @@
> 
>         dev->trans_start = jiffies;
>         np->stats.tx_errors++;
> -       return;
> +       netif_wake_queue(dev);
>  }

this has not been sent on to linus/alan because, if you do not empty the
Tx ring on tx_timeout, you should check to see if there is space on the
ring before waking the queue.  Otherwise corruption/problems occur...

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
