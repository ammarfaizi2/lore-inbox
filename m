Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbSLAGUD>; Sun, 1 Dec 2002 01:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbSLAGUD>; Sun, 1 Dec 2002 01:20:03 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:42113 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S261451AbSLAGT5>;
	Sun, 1 Dec 2002 01:19:57 -0500
Date: Sun, 1 Dec 2002 01:30:04 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: greg@kroah.com, perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] ALSA ISAPNP update for sound/isa/opl3sa2.c
Message-ID: <20021201013004.GA333@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>, greg@kroah.com,
	perex@suse.cz, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50.0211300443090.2495-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0211300443090.2495-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2002 at 07:00:13AM -0500, Zwane Mwaikambo wrote:
> ISAPNP/ALSA hasn't been working for a while now (cards didn't get
> detected), here is a patch to update OPL3SA2 to the new PnP layer.
> 
> ALSA device list:
>   #0: Yamaha OPL3-SA23 at 0x100, irq 5, dma 1&3
> 
> Driver tested in kernel and modular, i have tried to maintain
> detection/resource override semantics and general detection code
> paths.
> 
> Regards,
> 	Zwane Mwaikambo

Hi Zwane,

Many changes are pending that will allow you to manage entire pnp
cards.  For devices like opl3sa2, with only one device, you don't
have to use this, though I would prefer you do for consistency with
the other alsa drivers and because it has better card-specific
matching.  I'll send a big patch out with all of these changes.  
They should be in the bk tree soon as well.  I apologize for any
difficulty this may have caused.

Much of this driver has already been converted by me and has been
submitted publicly on the lkml.  What remains, however is the

http://marc.theaimsgroup.com/?l=linux-kernel&m=103844524222955&w=2

remove code.  I like how you did yours in this patch but it doesn't
seem to release anything.  I included comments to help you better 
understand how to convert pnp drivers.  I hope they help.

Thanks for your effort.  I'd love to see more pnp drivers converted.
If you have any questions feel free to ask.

Regards,
Adam

> 
> Index: linux-2.5.50/sound/isa/opl3sa2.c
> ===================================================================
> RCS file: /build/cvsroot/linux-2.5.50/sound/isa/opl3sa2.c,v
> retrieving revision 1.1.1.1
> diff -u -r1.1.1.1 opl3sa2.c
> --- linux-2.5.50/sound/isa/opl3sa2.c	28 Nov 2002 01:36:04 -0000	1.1.1.1
> +++ linux-2.5.50/sound/isa/opl3sa2.c	30 Nov 2002 11:51:30 -0000
> @@ -24,6 +24,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/pm.h>
>  #include <linux/slab.h>
> +#include <linux/pnp.h>
>  #ifndef LINUX_ISAPNP_H
>  #include <linux/isapnp.h>

isapnp.h isn't even needed.  Please don't use it.
instead only use pnp.h.

>  #define isapnp_card pci_bus

this is wrong, it should be pnp_card.  I actually
got rid of this definition entirely in my patch
and used pnp_card.

> @@ -135,6 +136,7 @@
>
>  typedef struct snd_opl3sa2 opl3sa2_t;
>  #define chip_t opl3sa2_t
> +int nr_cards;
>
>  struct snd_opl3sa2 {
>  	snd_card_t *card;
> @@ -148,7 +150,7 @@
>  	snd_rawmidi_t *rmidi;
>  	cs4231_t *cs4231;
>  #ifdef __ISAPNP__

the definition __ISAPNP__ should not be used, use
CONFIG_PNP or CONFIG_PNP_CARD instead.  I've only
mentioned this for this instance but it is used
throughout your patch.  Actually, now that I think
about it I need to change my patch to use 
CONFIG_PNP_CARD isntead of CONFIG_PNP.

> -	struct isapnp_dev *dev;
> +	struct pnp_dev *dev;
>  #endif
>  	unsigned char ctlregs[0x20];
>  	int ymode;		/* SL added */
> @@ -164,30 +166,28 @@
>  static snd_card_t *snd_opl3sa2_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
>
>  #ifdef __ISAPNP__
> +static struct pnp_dev *snd_opl3sa2_isapnp_devs[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
>
> -static struct isapnp_card *snd_opl3sa2_isapnp_cards[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
> -static const struct isapnp_card_id *snd_opl3sa2_isapnp_id[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
> -
> -#define ISAPNP_OPL3SA2(_va, _vb, _vc, _device, _function) \
> -        { \
> -                ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
> -                devs : { ISAPNP_DEVICE_ID(_va, _vb, _vc, _function), } \
> -        }
> -
> -static struct isapnp_card_id snd_opl3sa2_pnpids[] __devinitdata = {
> +/* Please try and keep the 1:1 mapping with the dev listing below */
> +static const struct pnp_id pnp_opl3sa2_cards[] = {
>  	/* Yamaha YMF719E-S (Genius Sound Maker 3DX) */
> -	ISAPNP_OPL3SA2('Y','M','H',0x0020,0x0021),
> +	{.id = "YMH0020",	.driver_data = 0},
>  	/* Yamaha OPL3-SA3 (integrated on Intel's Pentium II AL440LX motherboard) */
> -	ISAPNP_OPL3SA2('Y','M','H',0x0030,0x0021),
> +	{.id = "YMH0030",	.driver_data = 0},
>  	/* Yamaha OPL3-SA2 */
> -	ISAPNP_OPL3SA2('Y','M','H',0x0800,0x0021),
> +	{.id = "YMH0800",	.driver_data = 0},
>  	/* NeoMagic MagicWave 3DX */
> -	ISAPNP_OPL3SA2('N','M','X',0x2200,0x2210),
> -	/* --- */
> -	{ ISAPNP_CARD_END, }	/* end */
> +	{.id = "NMX2200",	.driver_data = 0},
> +	{"", 0}
>  };
> 
> -ISAPNP_CARD_TABLE(snd_opl3sa2_pnpids);
> +static const struct pnp_id pnp_opl3sa2_devs[] = {
> +	{.id = "YMH0021",	.driver_data = 0},
> +	{.id = "YMH0021",	.driver_data = 0},
> +	{.id = "YMH0021",	.driver_data = 0},
> +	{.id = "NMX2210",	.driver_data = 0},
> +	{"", 0}
> +};
>

this id table is fine, however, I would prefer
you use the new pnp_card_id structure instead.

>  #endif /* __ISAPNP__ */
> 
> @@ -634,22 +634,42 @@
> 
>  #endif /* CONFIG_PM */
>
> +static int snd_opl3sa2_free(opl3sa2_t *chip)
> +{
> +#ifdef __ISAPNP__
> +	pnp_disable_dev(chip->dev);

Please __NEVER__ do this if the driver has been matched with
this device, the pnp layer will automatically take care of this.

> +	pnp_remove_device(chip->dev);

This would create a big problem, if you remove the device, other
drivers can't use it.  This should only be called by protocols 
when the device is physically removed.

> +#endif
> +#ifdef CONFIG_PM
> +	if (chip->pm_dev)
> +		pm_unregister(chip->pm_dev);
> +#endif
> +	if (chip->irq >= 0)
> +		free_irq(chip->irq, (void *)chip);
> +	if (chip->res_port) {
> +		release_resource(chip->res_port);
> +		kfree_nocheck(chip->res_port);
> +	}
> +
> +	snd_magic_kfree(chip);
> +	return 0;
> +}
> +
> +static int snd_opl3sa2_dev_free(snd_device_t *device)
> +{
> +	opl3sa2_t *chip = snd_magic_cast(opl3sa2_t, device->device_data, return -ENXIO);
> +	return snd_opl3sa2_free(chip);
> +}
> +
>  #ifdef __ISAPNP__
>  static int __init snd_opl3sa2_isapnp(int dev, opl3sa2_t *chip)
>  {
> -        const struct isapnp_card_id *id = snd_opl3sa2_isapnp_id[dev];
> -        struct isapnp_card *card = snd_opl3sa2_isapnp_cards[dev];
> -	struct isapnp_dev *pdev;
> +	int res = 0;
> +	struct pnp_dev *pdev = snd_opl3sa2_isapnp_devs[dev];
> +
> +	if (!enable[dev])
> +		return -ENODEV;

once again, the pnp layer will keep track of this.

>
> -	chip->dev = isapnp_find_dev(card, id->devs[0].vendor, id->devs[0].function, NULL);
> -	if (chip->dev->active) {
> -		chip->dev = NULL;
> -		return -EBUSY;
> -	}
> -	/* PnP initialization */
> -	pdev = chip->dev;
> -	if (pdev->prepare(pdev)<0)
> -		return -EAGAIN;
>  	if (sb_port[dev] != SNDRV_AUTO_PORT)
>  		isapnp_resource_change(&pdev->resource[0], sb_port[dev], 16);
>  	if (wss_port[dev] != SNDRV_AUTO_PORT)
> @@ -666,59 +686,27 @@
>  		isapnp_resource_change(&pdev->dma_resource[1], dma2[dev], 1);
>  	if (irq[dev] != SNDRV_AUTO_IRQ)
>  		isapnp_resource_change(&pdev->irq_resource[0], irq[dev], 1);

I understand that you're trying to preserve these but there's
really no reason to.  isapnp_resource_change doesn't work. If
someone does bring up a reason to use these then I'll add
these functions.

> -	if (pdev->activate(pdev)<0) {
> -		snd_printk("isapnp configure failure (out of resources?)\n");
> -		return -EBUSY;
> -	}

The pnp layer won't call the probe function if the resource
config fails, therefore this is unnecessary.

> -	sb_port[dev] = pdev->resource[0].start;
> -	wss_port[dev] = pdev->resource[1].start;
> -	fm_port[dev] = pdev->resource[2].start;
> -	midi_port[dev] = pdev->resource[3].start;
> -	port[dev] = pdev->resource[4].start;
> +
> +	sb_port[dev] = pci_resource_start(pdev, 0);
> +	wss_port[dev] = pci_resource_start(pdev, 1);
> +	fm_port[dev] = pci_resource_start(pdev, 2);
> +	midi_port[dev] = pci_resource_start(pdev, 3);
> +	port[dev] = pci_resource_start(pdev, 4);
>  	dma1[dev] = pdev->dma_resource[0].start;
>  	dma2[dev] = pdev->dma_resource[1].start;
>  	irq[dev] = pdev->irq_resource[0].start;

New macros are available for these.  Please use them instead.
Never use pci_resource_start on a pnp_dev structure.

> +
>  	snd_printdd("isapnp OPL3-SA: sb port=0x%lx, wss port=0x%lx, fm port=0x%lx, midi port=0x%lx\n",
>  		sb_port[dev], wss_port[dev], fm_port[dev], midi_port[dev]);
>  	snd_printdd("isapnp OPL3-SA: control port=0x%lx, dma1=%i, dma2=%i, irq=%i\n",
>  		port[dev], dma1[dev], dma2[dev], irq[dev]);
> -	return 0;
> -}
> -
> -static void snd_opl3sa2_deactivate(opl3sa2_t *chip)
> -{
> -	if (chip->dev) {
> -		chip->dev->deactivate(chip->dev);
> -		chip->dev = NULL;
> -	}
> +	chip->dev = pdev;
> +
> +out_error:
> +	return res;
>  }
>  #endif /* __ISAPNP__ */
> 
> -static int snd_opl3sa2_free(opl3sa2_t *chip)
> -{
> -#ifdef __ISAPNP__
> -	snd_opl3sa2_deactivate(chip);
> -#endif
> -#ifdef CONFIG_PM
> -	if (chip->pm_dev)
> -		pm_unregister(chip->pm_dev);
> -#endif
> -	if (chip->irq >= 0)
> -		free_irq(chip->irq, (void *)chip);
> -	if (chip->res_port) {
> -		release_resource(chip->res_port);
> -		kfree_nocheck(chip->res_port);
> -	}
> -	snd_magic_kfree(chip);
> -	return 0;
> -}
> -
> -static int snd_opl3sa2_dev_free(snd_device_t *device)
> -{
> -	opl3sa2_t *chip = snd_magic_cast(opl3sa2_t, device->device_data, return -ENXIO);
> -	return snd_opl3sa2_free(chip);
> -}
> -
>  static int __init snd_opl3sa2_probe(int dev)
>  {
>  	int xirq, xdma1, xdma2;
> @@ -763,7 +751,9 @@
>  		err = -ENOMEM;
>  		goto __error;
>  	}
> +	spin_lock_init(&chip->reg_lock);
>  	chip->irq = -1;
> +
>  	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0)
>  		goto __error;
>  #ifdef __ISAPNP__
> @@ -855,30 +845,47 @@
>  }
> 
>  #ifdef __ISAPNP__
> -static int __init snd_opl3sa2_isapnp_detect(struct isapnp_card *card,
> -					    const struct isapnp_card_id *id)
> +static int pnp_opl3sa2_probe(struct pnp_dev *pdev, const struct pnp_id *card_id,
> +				const struct pnp_id *dev_id)
>  {
> -        static int dev;
> +	static int dev;
>          int res;
> 
>          for ( ; dev < SNDRV_CARDS; dev++) {
>                  if (!enable[dev])
>                          continue;
> -                snd_opl3sa2_isapnp_cards[dev] = card;
> -                snd_opl3sa2_isapnp_id[dev] = id;
> +                snd_opl3sa2_isapnp_devs[dev] = pdev;
>                  res = snd_opl3sa2_probe(dev);
>                  if (res < 0)
>                          return res;
>                  dev++;
> +		nr_cards++;
>                  return 0;
>          }
>          return -ENODEV;
>  }
> +
> +static void pnp_opl3sa2_remove(struct pnp_dev *pdev)
> +{
> +	opl3sa2_t *chip = pdev->driver_data;
> +	if (chip)
> +		chip->dev = NULL;
> +	nr_cards--;
> +}

This doesn't free anything, am I missing something?
In other words shouldn't it call snd_opl3sa2_dev_free
or something?

> +
> +static struct pnp_driver snd_opl3sa2_pnp_driver = {
> +	.name		= "opl3sa2",
> +	.card_id_table	= pnp_opl3sa2_cards,
> +	.id_table	= pnp_opl3sa2_devs,
> +	.probe		= pnp_opl3sa2_probe,
> +	.remove		= pnp_opl3sa2_remove,
> +};
> +

this is good, but you may want to make this a pnpc_driver
instead when pnp card support is included.  Actually,
in the most recent release pnp v0.93 card_id_table
doesn't exist in the pnp_driver structure.

>  #endif /* __ISAPNP__ */
>
>  static int __init alsa_card_opl3sa2_init(void)
>  {
> -	int dev, cards = 0;
> +	int dev;
>
>  	for (dev = 0; dev < SNDRV_CARDS; dev++) {
>  		if (!enable[dev])
> @@ -888,15 +895,19 @@
>  			continue;
>  #endif
>  		if (snd_opl3sa2_probe(dev) >= 0)
> -			cards++;
> +			nr_cards++;
>  	}
> +
>  #ifdef __ISAPNP__
> -	cards += isapnp_probe_cards(snd_opl3sa2_pnpids, snd_opl3sa2_isapnp_detect);
> +	/* upon registration the probe function will increment nr_cards */
> +	pnp_register_driver(&snd_opl3sa2_pnp_driver);\

this is fine to do that but please be aware that this
function will return the number of matched devices.

>  #endif
> -	if (!cards) {
> +
> +	if (nr_cards == 0) {
>  #ifdef MODULE
>  		printk(KERN_ERR "Yamaha OPL3-SA soundcard not found or device busy\n");
>  #endif
> +		pnp_unregister_driver(&snd_opl3sa2_pnp_driver);

You may not want to unregister the driver just becuase
it fails.  An isapnp protocol module could be loaded
after this driver and the device needed could be added,
in which case it would then attach to this driver if 
you didn't unregister it.

>  		return -ENODEV;

Therefore this didn't fail becuase the driver was still
registered.

>  	}
>  	return 0;
> --

