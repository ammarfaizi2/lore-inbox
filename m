Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267393AbTAVJfO>; Wed, 22 Jan 2003 04:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267396AbTAVJfO>; Wed, 22 Jan 2003 04:35:14 -0500
Received: from gate.perex.cz ([194.212.165.105]:33799 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267393AbTAVJfN>;
	Wed, 22 Jan 2003 04:35:13 -0500
Date: Wed, 22 Jan 2003 10:44:15 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Adam Belay <ambx1@neo.rr.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [alsa, pnp] more on opl3sa2
In-Reply-To: <20030121182303.GI26108@neo.rr.com>
Message-ID: <Pine.LNX.4.44.0301220924080.1210-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003, Adam Belay wrote:

> On Tue, Jan 21, 2003 at 10:43:43PM +0100, Jaroslav Kysela wrote:
> > On Tue, 21 Jan 2003, Adam Belay wrote:
> > > 1.) If a driver attaches to the pnpbios card all other card-based drivers will
> > > be unable to use the pnpbios.  One will attach and cause the others to fail.  It
> > > is possible for the user to have more than one pnpbios sound card but with this
> > > approach such a user would only be able to use one sound device from the entire
> > > pnpbios.
> >
> > I see. I think it's a design problem then. The rule card -> one driver is
> > bad. We need something between card and device which will take care about
> > drivers. Unfortunately, this information is dynamic (only driver knows
> > which devices have to be attached).
> >
> > I think that we need to discuss this thing very carefully.
> 
> I agree that we need to discuss this carefully and that there is a need for this
> change.  Here are a few ideas to get a discussion started.
> 
> How does this sound...
> 1.) detach pnp card service matching from the driver model, the driver model is
> what is imposing this one card per driver limit.
> 2.) create a special pnp_driver that handles cards and forwards driver model calls
> to the pnp card services, we can use attach_driver to avoid matching problems.
> 
> design goals for these changes should be as follows:
> 1.) multiple drivers can bind to one card
> 2.) pnp_attach, pnp_detach, and pnp status should be phased out and replaced with
> the special card driver, in other words the driver model can take care of this.

Yes, it's quite clear except I think that the current pnp scheme is bad.
It would be probably better to have:

pnp_protocol -> pnp_card -> pnp_device

While pnp_protocol and pnp_card are buses (in the driver model) the 
pnp_device is device. Actually, we have this model:

pnp_protocol (bus) -> pnp_card (device)
                   -> pnp_device (device)

Which don't really describe the real situation.

Also, we can revert to the previous probe() mechanism with device and card
IDs stored in one pnp_driver structure. We can export a function which
will chain the devices together (and pnp_device code will filter the
callbacks from the driver model to this chain of devices to remove 
duplicate actions).

> This will solve the one device limit but I'm not sure how to handle the pnpbios
> stuff yet.  I want it to be with as little overhead as possible and would prefer we
> don't use fake cards, any ideas?  All that comes to mind for me is a unique pnpbios
> ID that the pnp layer will interpret and grant special exceptions.

It makes things a bit complicated. I personally like that all PnP BIOS 
devices can enumerated separately via card_for_each_dev() and similar 
macros without having any knowledge about used protocol. It's possible to 
export the PnP BIOS card variable to make things more easy.

> > > 2.) Doing so would misrepresent the pnpbios topology because it physically
> > > doesn't have any cards.
> > >
> > > 3.) The opl3sa2 driver doesn't need a card because it is only asking for one
> > > device anyway.  Using the card interface puts unnecessary overhead on both the
> > > driver and the pnp layer.
> >
> > Yes, but IT SHOULD WORK. Although it isn't an most efficient way. (I
> > personally think that it's better to keep as much IDs as possible to avoid
> > clashes in future).
> 
> Hmm, I'm not sure what you mean by clashes in the future.  Nearly all of 
> these isapnp devices are no longer manufactured, hence these devices will
> not have many future changes.
> 
> Still I do see value in describing as many ids as possible but I worry that the
> extra overhead may not be worth it.  This also needs to be further discussed.

If you think in this way, then whole device model is overhead and we can 
return to simple lists as before :-)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


