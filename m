Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSLAGwb>; Sun, 1 Dec 2002 01:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSLAGwb>; Sun, 1 Dec 2002 01:52:31 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:59557
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261486AbSLAGw3>; Sun, 1 Dec 2002 01:52:29 -0500
Date: Sun, 1 Dec 2002 02:02:48 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Adam Belay <ambx1@neo.rr.com>
cc: greg@kroah.com, "" <perex@suse.cz>, "" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] ALSA ISAPNP update for sound/isa/opl3sa2.c
In-Reply-To: <20021201013004.GA333@neo.rr.com>
Message-ID: <Pine.LNX.4.50.0212010139460.1628-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0211300443090.2495-100000@montezuma.mastecende.com>
 <20021201013004.GA333@neo.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Dec 2002, Adam Belay wrote:

> Many changes are pending that will allow you to manage entire pnp
> cards.  For devices like opl3sa2, with only one device, you don't
> have to use this, though I would prefer you do for consistency with
> the other alsa drivers and because it has better card-specific
> matching.  I'll send a big patch out with all of these changes.
> They should be in the bk tree soon as well.  I apologize for any
> difficulty this may have caused.
>
> Much of this driver has already been converted by me and has been
> submitted publicly on the lkml.  What remains, however is the
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103844524222955&w=2

Cool, i think a more interesting device would be the AWE32 portion of the
soundblaster driver since that has the wavetable device on it.

> remove code.  I like how you did yours in this patch but it doesn't
> seem to release anything.  I included comments to help you better
> understand how to convert pnp drivers.  I hope they help.
>
> Thanks for your effort.  I'd love to see more pnp drivers converted.
> If you have any questions feel free to ask.
>
> >  #define isapnp_card pci_bus
>
> this is wrong, it should be pnp_card.  I actually
> got rid of this definition entirely in my patch
> and used pnp_card.

That would be a remnant from the driver before the conversion, i didn't
actually used it and removed all references in code.

> > @@ -135,6 +136,7 @@
> >
> >  typedef struct snd_opl3sa2 opl3sa2_t;
> >  #define chip_t opl3sa2_t
> > +int nr_cards;
> >
> >  struct snd_opl3sa2 {
> >  	snd_card_t *card;
> > @@ -148,7 +150,7 @@
> >  	snd_rawmidi_t *rmidi;
> >  	cs4231_t *cs4231;
> >  #ifdef __ISAPNP__
>
> the definition __ISAPNP__ should not be used, use
> CONFIG_PNP or CONFIG_PNP_CARD instead.  I've only
> mentioned this for this instance but it is used
> throughout your patch.  Actually, now that I think
> about it I need to change my patch to use
> CONFIG_PNP_CARD isntead of CONFIG_PNP.

Noted

> >  #endif /* __ISAPNP__ */
> >
> > @@ -634,22 +634,42 @@
> >
> >  #endif /* CONFIG_PM */
> >
> > +static int snd_opl3sa2_free(opl3sa2_t *chip)
> > +{
> > +#ifdef __ISAPNP__
> > +	pnp_disable_dev(chip->dev);
>
> Please __NEVER__ do this if the driver has been matched with
> this device, the pnp layer will automatically take care of this.

I actually removed that just before because it causes an oops on module
unload.

> > +	pnp_remove_device(chip->dev);
>
> This would create a big problem, if you remove the device, other
> drivers can't use it.  This should only be called by protocols
> when the device is physically removed.
>
> I understand that you're trying to preserve these but there's
> really no reason to.  isapnp_resource_change doesn't work. If
> someone does bring up a reason to use these then I'll add
> these functions.

Left to avoid too much change in the first round.

> > -	if (pdev->activate(pdev)<0) {
> > -		snd_printk("isapnp configure failure (out of resources?)\n");
> > -		return -EBUSY;
> > -	}
>
> The pnp layer won't call the probe function if the resource
> config fails, therefore this is unnecessary.

Yep, thats why i removed them, i would think that would be the same for
the former pdev->prepare() function?

> >  	dma2[dev] = pdev->dma_resource[1].start;
> >  	irq[dev] = pdev->irq_resource[0].start;
>
> New macros are available for these.  Please use them instead.
> Never use pci_resource_start on a pnp_dev structure.

gotcha.

> > +static void pnp_opl3sa2_remove(struct pnp_dev *pdev)
> > +{
> > +	opl3sa2_t *chip = pdev->driver_data;
> > +	if (chip)
> > +		chip->dev = NULL;
> > +	nr_cards--;
> > +}
>
> This doesn't free anything, am I missing something?
> In other words shouldn't it call snd_opl3sa2_dev_free
> or something?

That is called in a different path, the ALSA freeing/unloading paths can
get a bit confusing.

> >  #ifdef __ISAPNP__
> > -	cards += isapnp_probe_cards(snd_opl3sa2_pnpids, snd_opl3sa2_isapnp_detect);
> > +	/* upon registration the probe function will increment nr_cards */
> > +	pnp_register_driver(&snd_opl3sa2_pnp_driver);\
>
> this is fine to do that but please be aware that this
> function will return the number of matched devices.

Thats ok because we're incrementing nr_cards in the ->probe function and
using that instead of 'cards'.

> > -	if (!cards) {
> > +
> > +	if (nr_cards == 0) {
> >  #ifdef MODULE
> >  		printk(KERN_ERR "Yamaha OPL3-SA soundcard not found or device busy\n");
> >  #endif
> > +		pnp_unregister_driver(&snd_opl3sa2_pnp_driver);
>
> You may not want to unregister the driver just becuase
> it fails.  An isapnp protocol module could be loaded
> after this driver and the device needed could be added,
> in which case it would then attach to this driver if
> you didn't unregister it.

Yep had fixed that when i testing module failures.

Cheers,
	Zwane
-- 
function.linuxpower.ca
