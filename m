Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKQWcE>; Fri, 17 Nov 2000 17:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129227AbQKQWbx>; Fri, 17 Nov 2000 17:31:53 -0500
Received: from hera.cwi.nl ([192.16.191.1]:49864 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129183AbQKQWbs>;
	Fri, 17 Nov 2000 17:31:48 -0500
Date: Fri, 17 Nov 2000 23:01:46 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_EISA note in Documentation/Configure.help
Message-ID: <20001117230146.A173@veritas.com>
In-Reply-To: <00111317072200.00727@localhost.localdomain> <20001114205950.A25349@veritas.com> <3A127070.7DEE2527@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A127070.7DEE2527@yahoo.com>; from p_gortmaker@yahoo.com on Wed, Nov 15, 2000 at 06:16:00AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2000 at 06:16:00AM -0500, Paul Gortmaker wrote:

> > What use is knowing that a machine has EISA slots? As far as I can see
> > the only use is to ask for the EISA ID of the card.
> > Should we? I collected 1200 .cfg files and estimate that this is
> > less than 10% of what exists - we do not want a data base built
> > into the kernel, I think. But the kernel could collect these
> > EISA IDs at boot time, enabling drivers to inquire.
> 
> There could have been an API for EISA card probes if there 
> were enough drivers to demand it - but I guess there never was.
> Something like:
> 
> if (ioaddr=probe_EISA_ID("abc1234") == 0) return -ENODEV;

I see how to make

	if ((slot = probe_EISA_ID("abc1234")) == -1) return -ENODEV;

but have no idea how you want to find an ioaddr.

My code does something like

/*
 * EISA board N has a 4-byte ID that can be read from 0xNc80-0xNc83
 * return 0 for success, -1 for failure (no EISA card in slot) and
 * 1 when a card is present but still needs to be configured.
 */
static int
get_eisa_id(int board, char *id) {
        int idaddr = (board << 12) + 0x0c80;
        char val;

        outb(0xff, idaddr);
        val = inb(idaddr);
        if (val & 0x80)
                return -1;
        if ((val & 0xf0) == 0x70)
                return 1;
        id[0] = val;
        id[1] = inb(idaddr+1);
        id[2] = inb(idaddr+2);
        id[3] = inb(idaddr+3);
        return 0;
}

(I looked at this in order to get information in a situation
with several onboard chips. The EISA slot for them is 0,
but there is no obvious way to get at the ioaddr.)


> > (iv) Finally a question: does anyone know of a URL for the
> > EISA standard?
> 
> I recall looking about several years ago when I was playing
> with some drivers for old EISA ethernet cards.  Never found
> much of anything.  A couple of html-docs on a Digital EISA
> box which I found collecting dust in my personal archive of
> junk. (see below)

Thanks! However, I had these same docs.
(Labeled AA-Q0R6C-TET1.)


> > [PS I would like to be mistaken about the impossibility of
> > parsing the EISA configuration area. There is useful info
> > there, e.g. about dma and irq. It would be nice if this info
> > were available.]
> 
> I think you are mistaken - I have written several EISA drivers
> for network cards, and at least three of these I wrote having
> never seen the card at all  - only the .cfg file - which was
> enough for me to get the card I/O IRQ and so on.

Yes, the file is fine. But I only gave you the EISA configuration area.
Now what do you do? I don't know. As far as I can see only very
machine-dependent things work.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
