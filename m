Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293714AbSCAU1U>; Fri, 1 Mar 2002 15:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293723AbSCAU1Q>; Fri, 1 Mar 2002 15:27:16 -0500
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:59631 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S293714AbSCAU05>;
	Fri, 1 Mar 2002 15:26:57 -0500
Date: Fri, 1 Mar 2002 15:27:26 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Patrick Schaaf <bof@bof.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Ben Greear <greearb@candelatech.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org
Subject: Re: Various 802.1Q VLAN driver patches.
In-Reply-To: <20020301204400.B24565@oknodo.bof.de>
Message-ID: <Pine.LNX.4.10.10203011510350.1130-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Patrick Schaaf wrote:
> On Fri, Mar 01, 2002 at 02:17:22PM -0500, Jeff Garzik wrote:
> > Ben Greear wrote:
> > > --- linux-2.4.16/drivers/net/eepro100.c Mon Nov 12 18:47:18 2001
> > > +++ linux/drivers/net/eepro100.c        Tue Dec 18 11:36:11 2001
> > > @@ -510,12 +510,12 @@
> > >   static const char i82557_config_cmd[CONFIG_DATA_SIZE] = {
> > >          22, 0x08, 0, 0,  0, 0, 0x32, 0x03,  1, /* 1=Use MII  0=Use AUI */
> > >          0, 0x2E, 0,  0x60, 0,
> > > -       0xf2, 0x48,   0, 0x40, 0xf2, 0x80,              /* 0x40=Force full-duplex */
> > > +       0xf2, 0x48,   0, 0x40, 0xfa, 0x80,              /* 0x40=Force full-duplex */
> > >          0x3f, 0x05, };
> > >   static const char i82558_config_cmd[CONFIG_DATA_SIZE] = {
> > >          22, 0x08, 0, 1,  0, 0, 0x22, 0x03,  1, /* 1=Use MII  0=Use AUI */
> > >          0, 0x2E, 0,  0x60, 0x08, 0x88,
> > > -       0x68, 0, 0x40, 0xf2, 0x84,              /* Disable FC */
> > > +       0x68, 0, 0x40, 0xfa, 0x84,              /* Disable FC */
> > >          0x31, 0x05, };
> > 
> > hmmm. hmmm. hmmm.
> > 
> > I am sorely tempted to drop this patch, simply because it's changing one
> > magic number to another.

That's a good reason to object.

> >  One key question I have is, what the fsck does
> > this patch really do???  If it turns on VLAN [de-]tagging
> > unconditionally, for example, that's unacceptable.
> 
> This patch, from all I know using it, does exactly one thing: it permits
> receiving (and sending) slightly larger frames, for setting the MTU on the
> base interface to 1504, so the VLAN interfaces themselves can run the
> normal 1500 byte MTU.

The patch turns on the reception for larger frames.
It only works for some chip revisions.  Specifically, the i82557 does
not document this bit.

It should have been handled like all of the other interface- and
chip-specific settings -- modifying a copy of the table, not
the original static table.

> I have been using the patch to this end on several eepro100 based systems,
> over the last year, with no surprises.

Have you tried sending slightly oversized non-VLAN frames?
What about testing with '557, '558 and '559 chips?  

I have a similar objection to the Tulip modification: the change
just disables the overlength packet protection.  This won't work as you
expect with all chips.

> I agree that such an array of magic constants is very very undesirable.

The reason for the magic numbers is twofold: I got the documentation only
with a negotiated NDA, and even with the documentation many of the bits
have specified-but-undocumented values.  Others bits are fundamentally
uninteresting modifications of standard Ethernet: disabling preamble,
extending the IFG1/IFG2 period, changing to linear back-off. 

OTOH, this patch is a case where the setting should be documented.  It is a
change from the default/recommended value.

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

