Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268594AbUH3R2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268594AbUH3R2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268593AbUH3R2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:28:25 -0400
Received: from chaos.analogic.com ([204.178.40.224]:55174 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268594AbUH3R1I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:27:08 -0400
Date: Mon, 30 Aug 2004 13:26:59 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Arthur Perry <kernel@linuxfarms.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Celistica with AMD chip-set
In-Reply-To: <Pine.LNX.4.58.0408301130230.23343@tiamat.perryconsulting.net>
Message-ID: <Pine.LNX.4.53.0408301322090.22149@chaos>
References: <Pine.LNX.4.53.0408300955470.21607@chaos>
 <1093871709.30082.11.camel@localhost.localdomain>
 <Pine.LNX.4.58.0408301052030.23343@tiamat.perryconsulting.net>
 <Pine.LNX.4.58.0408301130230.23343@tiamat.perryconsulting.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004, Arthur Perry wrote:

> I believe that in the card's own PCI config space, there should be a
> bit (bit 3) in the BAR configuration register which will tell
> "somebody" how to set up the device.
> Bit 3 tells "somebody" whether or not it is prefetchable.
> The bridge then be configured properly for this device.
>

No. The prefetch bit in the BAR is for the device, not for the
system RAM to which a DMA may be accomplished. Since DMA
occurs from a fixed address on the device, to a incrementing
address in RAM, the prefetch bit must NOT be set for this
BAR or else a cache-line is fetched and one one DWORD is
used, the rest thrown away.

> I am not sure yet just who this should be, but my guess is that there
> should be a routine
> in BIOS that does this.
>

The BIOS should configure bridges to be correct.

> So the first question I think is to verify that the card does indeed
> set this bit proper
> for the BARs used.
>

The card correctly sets its BARs.

> If it is then not being set in the bridge, I would suspect a fault in BIOS.
>
> Am I missing something here?
> Please let me know if I am totally off track.
>
>
> Thanks!
>
>
>
>
> On Mon, 30 Aug 2004, Arthur Perry wrote:
>
> > Hello Alan and Richard,
> >
> > I have to advise caution here, as it is currently unconfirmed whether or
> > not the PCI bridge configuration is "incorrect", and that it has "very
> > poor PCI performance".
> > Unless everyone in the whole wide world is setting this value and we are
> > the only ones who are not, I find it hard to believe that this statement
> > is not overspeculative.
> >
> > The proper place for this should be in the BIOS, if it is indeed a true
> > optimization point.
> > But until that is positively identified, we should not assume that
> > applying this globally for everyone is the right thing to do.
> > As in any assumed optimization for a simgle case, it could potentially
> > cause performance degradation in somebody else's HBA.
> >
> > This is a cache optimization.
> >
> > Have you considered the possibility of this "optimization" causing a
> > performance hit with Mellanox's PCI implementation?
> >
> > What about people who have already tailored their device driver to work
> > well in on this chipset and currently use "read multiple" rather than
> > "read cacheline". This optimization could potentially cause a slight
> > degradation of performance for them.
> >
> > I just propose that we test this change with various card vendors and see
> > what the real impact is before we jump to the conclusion that this is a
> > serious performance problem for everybody.
> >
> > Secondly, if it is the case, then the correct place to put this change is
> > in the system's BIOS, and having a software workaround is a last resort.
> >
> > If you want, I can write a userspace utility to package with your existing
> > tools that can be installed and launched from init to provide this
> > optimization feature to the 8131 PCI bridge that your card resides on, to
> > ensure that your card gets this necessary optimization.
> > Or, you can easily put this capability into your existing device driver.
> >
> > I would just rather not assume too much when dealing with something that
> > can potentially have a large reprocussion.
> >
> >
> > On Mon, 30 Aug 2004, Alan Cox wrote:
> >
> > > On Llu, 2004-08-30 at 15:02, Richard B. Johnson wrote:
> > > > Hello all,
> > > >
> > > > The Celistica server with the AMD chip-set has very poor
> > > > PCI performance with Linux (and probably W$ too).
> > > >
> > > > The problem was traced to incorrect bridge configuration
> > > > in the HyperTransport(tm) chips that connect up pairs
> > > > of slots.
> > >
> > > Can you get Celestica to mail me their PCI subvendor
> > > id/devid's for the problem configuration or DMI strings
> > > and then we can do a PCI quirk properly for this.
> > >
> > > Alan
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> >
> >
> >
> >
> >
> > Arthur Perry
> > Linux Systems/Software Architect
> > Lead Linux Engineer
> > CSU Validation Group
> > Celestica, Salem, NH
> > aperry@celestica.com
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>
> Arthur Perry
> Linux Systems/Software Architect
> Lead Linux Engineer
> CSU Validation Group
> Celestica, Salem, NH
> aperry@celestica.com
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

