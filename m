Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSLAR5J>; Sun, 1 Dec 2002 12:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbSLAR5J>; Sun, 1 Dec 2002 12:57:09 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:53633 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S262215AbSLAR5H>;
	Sun, 1 Dec 2002 12:57:07 -0500
Date: Sun, 1 Dec 2002 13:07:15 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: greg@kroah.com, perex@suse.cz, linux-kernel@vger.kernel.org,
       pelaufer@adelphia.net
Subject: Re: [PATCH][2.5] ALSA ISAPNP update for sound/isa/opl3sa2.c
Message-ID: <20021201130715.GB333@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>, greg@kroah.com,
	perex@suse.cz, linux-kernel@vger.kernel.org, pelaufer@adelphia.net
References: <Pine.LNX.4.50.0211300443090.2495-100000@montezuma.mastecende.com> <20021201013004.GA333@neo.rr.com> <Pine.LNX.4.50.0212010139460.1628-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0212010139460.1628-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 02:02:48AM -0500, Zwane Mwaikambo wrote:
> On Sun, 1 Dec 2002, Adam Belay wrote:
> 
> > Many changes are pending that will allow you to manage entire pnp
> > cards.  For devices like opl3sa2, with only one device, you don't
> > have to use this, though I would prefer you do for consistency with
> > the other alsa drivers and because it has better card-specific
> > matching.  I'll send a big patch out with all of these changes.
> > They should be in the bk tree soon as well.  I apologize for any
> > difficulty this may have caused.
> >
> > Much of this driver has already been converted by me and has been
> > submitted publicly on the lkml.  What remains, however is the
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103844524222955&w=2
> 
> Cool, i think a more interesting device would be the AWE32 portion of the
> soundblaster driver since that has the wavetable device on it.

Agreed. Pual is currently working on the OSS driver.  I'd love to see the
ALSA sb driver working with the new card API.  There are some ALSA drivers
that have three and perhaps even four devices.  They should be interesting
:).


> > >  #endif /* __ISAPNP__ */
> > >
> > > @@ -634,22 +634,42 @@
> > >
> > >  #endif /* CONFIG_PM */
> > >
> > > +static int snd_opl3sa2_free(opl3sa2_t *chip)
> > > +{
> > > +#ifdef __ISAPNP__
> > > +	pnp_disable_dev(chip->dev);
> >
> > Please __NEVER__ do this if the driver has been matched with
> > this device, the pnp layer will automatically take care of this.
> 
> I actually removed that just before because it causes an oops on module
> unload.

It caused an oops?  I'll bet the pnp layer got confused by it.  I'll add
some busy flags to prevent drivers from calling this when the device is
being used by the driver through the conventional driver-model style.
Thanks for pointing this out.

> 
> > > +	pnp_remove_device(chip->dev);
> >
> > This would create a big problem, if you remove the device, other
> > drivers can't use it.  This should only be called by protocols
> > when the device is physically removed.
> >
> > I understand that you're trying to preserve these but there's
> > really no reason to.  isapnp_resource_change doesn't work. If
> > someone does bring up a reason to use these then I'll add
> > these functions.
>
> Left to avoid too much change in the first round.

I think it's better just to remove these becuase they may be
dependent on isapnp.h.  Eventually I'll remove all of these from
isapnp.h.

> > > +static void pnp_opl3sa2_remove(struct pnp_dev *pdev)
> > > +{
> > > +	opl3sa2_t *chip = pdev->driver_data;
> > > +	if (chip)
> > > +		chip->dev = NULL;
> > > +	nr_cards--;
> > > +}
> >
> > This doesn't free anything, am I missing something?
> > In other words shouldn't it call snd_opl3sa2_dev_free
> > or something?
> 
> That is called in a different path, the ALSA freeing/unloading paths can
> get a bit confusing.

I see now.  The problem is that when the remove function is called, the pnp
layer expects the device's resources to be freed and not in use.  I should
add some checks for this as well.  The pnp layer will disable the device
and this could cause big problems if the driver is used in between the time
of the ALSA remove code path and this driver removal.  Furthermore, if there
is more than one sound card and the driver-model wants to remove one, a
problem would occur.  Perhaps this aspect of ALSA needs to be changed.  
Any ideas?

Thanks,
Adam
