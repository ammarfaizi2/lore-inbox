Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWDCRsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWDCRsk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 13:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWDCRsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 13:48:40 -0400
Received: from sc-outsmtp2.homechoice.co.uk ([81.1.65.36]:25861 "HELO
	sc-outsmtp2.homechoice.co.uk") by vger.kernel.org with SMTP
	id S964821AbWDCRsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 13:48:38 -0400
Subject: Re: Patch for AICA sound support on SEGA Dreamcast
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-sh <linuxsh-dev@lists.sourceforge.net>,
       Paul Mundt <lethal@linux-sh.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <s5hvetqac7i.wl%tiwai@suse.de>
References: <1144075522.11511.20.camel@localhost.localdomain>
	 <s5hvetqac7i.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 18:48:30 +0100
Message-Id: <1144086510.11511.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 17:52 +0200, Takashi Iwai wrote:
> At Mon, 03 Apr 2006 15:45:22 +0100,
> Adrian McMenamin wrote:
> > 
> > This provides ALSA sound for the Sega Dreamcast. Seems to work well for
> > me, but there is a dearth of testers.
> > 
> > Signed off by Adrian McMenamin (adrian@mcmen.demon.co.uk)
> 
> Thanks for the patch.  Some comments are below.
> 

And my comments added back

> > diff -ruN /home/adrian/alsa-old/alsa-driver/sh/aica.h /home/adrian/alsa-driver/sh/aica.h
> > --- /home/adrian/alsa-old/alsa-driver/sh/aica.h	1970-01-01 01:00:00.000000000 +0100
> > +++ /home/adrian/alsa-driver/sh/aica.h	2006-04-03 15:40:07.000000000 +0100
> > @@ -0,0 +1,79 @@
> (snip)
> > +typedef struct {

> > +} snd_card_aica_t;
> 
> Please avoid use of typedefs as much as possible.
> We (finally :-) got rid of whole typedefs recently from the ALSA core
> code.
> 

OK


> (snip)
> > +
> > +static int index = 0;
> 
> No need for explicit zero initialization.
> 
> > +static char *id = "0";
> 
> You should set it to NULL, i.e. don't set value here.

OK

> > +/* SPU specific functions */
> > +
> > +inline void spu_write_wait()
> 
> Lack of static.  And lack of (void) argument.
> 


lack of static yes - but void inside the brackets - really?

> 
> > +{
> > +	while (1) {
> > +		if (!(readl(G2_FIFO) & 0x11))
> > +			break;
> > +	}
> 
> Safer to have a timeout?
> 

No - this is correct


> > +static void spu_memset(uint32_t toi, unsigned long what, int length)
> 
> The type of second argument should be "void __iomem *" for accessing
> readl/writel.
> 

OK

> 
> > +{
> > +	uint32_t *to = (uint32_t *) (SPU_MEMORY_BASE + toi);
> > +	int i;
> > +
> > +	if (length % 4)
> > +		length = (length / 4) + 1;
> > +	else
> > +		length = length / 4;
> 
> Shouldn't be always aligned to 4?  Something like
> 
> 	snd_assert(length % 4 == 0, return);
> 

but that would break and the code fixes it and works




> > +static void spu_memload(uint32_t toi, uint8_t * from, int length)
> 
> Also "uint8_t __iomem *from" (maybe a "void __iomem *" would be
> simpler since you can avoid an explicit cast below).
> 
> Also, these lowlevel functions look racy.  Many places call
> spu_memload() without a proper lock.
> 


OK



> > +	spu_disable();
> > +	spu_memset(0, 0, 0x200000 / 4);
> > +	*(uint32_t *) SPU_MEMORY_BASE = 0xea000002;
> 
> Is it a right code?
> 

I believe so, just a piece of ARM7 machine code that is an infinite loop


> > +	spu_enable();
> > +	schedule();
> > +	return 0;
> > +}
> > +
> > +
> > +
> > +static aica_channel_t *channel;
> 
> Better to assign this to runtime->private_data instead of a static
> record.
> 

Probably, though overkill for the current setup


> > +/* There is only one sound card on a Dreamcast */
> > +static snd_card_aica_t *dreamcastcard = NULL;
> 
> Is this static variable really needed?
> 

As there is only one instance it makes life a lot simpler, but it could
be got rid of




> > +		udelay(5);
> > +		transferred = get_dma_residue(0);
> > +	}
> > +	while (transferred < buffer_size / 2);
> 
> Hmm, is this a correct implementation?  It doesf looping in a timer
> handler.  Surely it works, but...
> 

What's the alternative? I need to wait for one dma transfer to end
before the next begins



>  = jiffies + 1;
> > +		add_timer(&(dreamcastcard->timer));
> 
> I guess you need a proper lock to avoid race here?
> 

Yes, it does need locks



> > +			/* get_dma_residue reports residue until completion when it reports total bytes transferred */
> > +			transferred = get_dma_residue(0);
> > +		}
> > +		while (transferred < AICA_PERIOD_SIZE);
> 
> Another busy loop in timer callback.
> 

As before - I cannot have a second dma transfer begin until the first
has ended, the transfer is fast (about 12 Mb/s aiui so the busy looping
should not last *too* long). If you can suggest an alternative?



> > +
> > +static int snd_aicapcm_pcm_open(snd_pcm_substream_t * substream)
> > +{
> > +	if (!enable) return -ENOENT;
> 
> This check is useless.  If needed, do it in module initialization.
> 

Why is it useless? If I do it in initialisation what is the point of the
parameter? ie why load a module with a perameter that means don't load?
If I do it this way then the user can turn enable on and off by writing
to sysfs. Isn't that what it is supposed to be there for?



> > +	channel->flags = 0;	/* default to mono */
> > +	snd_pcm_runtime_t *runtime;
> 
> Should be in the beginning of the function.
> 

yep


> > +	dreamcastcard->substream = substream;
> 
> This one is never unset...
> 
yes, but there's only one instance so it's handy that way :)


> > +	return 0;

> > +	startup_aica();
> > +	init_timer(&(dreamcastcard->timer));
> > +	dreamcastcard->timer.function = aica_period_elapsed;
> 
> This is dangerous.  The timer can be running, e.g. when a PCM stream
> is replayed.
> 

I don't understand the point you are making. Do you mean the timer could
be runing when this is (re)assigned? It's always the same function
though.


> > +
> > +
> > +	dreamcastcard->timer.expires = jiffies + 4;
> 
> Why 4?

four times as big a buffer as a one period read, no real reason though

> stream);
> > +		break;
> > +	case SNDRV_PCM_TRIGGER_STOP:
> > +		aica_chn_halt();
> 
> Isn't better to stop the timer here?

Do both probably!

> 
> > +		
> > +	pcm->private_data = dreamcastcard;
> > +	dreamcastcard->card->private_data = pcm;
> 
> What the purpose of this assignment?
> 

Good question! I suspect I wrote that last September and have forgotten
about it ever since :)



> > +static int aica_pcmswitch_put(snd_kcontrol_t * kcontrol,
> > +			      snd_ctl_elem_value_t * ucontrol)
> > +{
> > +	if (ucontrol->value.integer.value[0] == 1)
> > +		return 0;	/* TO DO: Fix me */
> > +	else
> > +		aica_chn_halt();
> > +	return 0;
> > +}
> 
> I guess this doesn't work (to reenable the DMA)?
> 

needs more thought

> 

> > +}
> > +
> > +static snd_kcontrol_new_t snd_aica_masterswitch_control __devinitdata = {
> > +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> > +	.name = "Playback Switch",
> 
> Should be "Master Playback Switch".
> 

Not what the documentation says:


"Capture Source", "Capture Switch" and "Capture Volume" are used for the
global capture (input) source, switch and volume. Similarly, "Playback
Switch" and "Playback Volume" are used for the global output gain switch
and volume. 





> > +	.info = aica_pcmswitch_info,
> > +	.get = aica_pcmswitch_get,
> > +	.put = aica_pcmswitch_put
> > +};
> 
> ... But why do you need two different switches for the very same
> thing? 


Relic of trying to get this to work. Might matter if I seriously
developed this driver to use the full capacity of the device (though
that requires significant additional reversing). Would it help with
badly configured OSS apps?


> 
> Should be "Master Playback Volume".
> 

See above. Incidentally, when it was Master Playback Volume it didn't
work with OSS :(


> > +
> > +
> > +/* Fill up the members of the embedded device structure */
> > +
> > +static void populate_dreamcastaicadev(struct device *dev)
> > +{
> > +	dev->bus = &platform_bus_type;
> > +	dev->driver = &aica_driver;
> > +	driver_register(dev->driver);
> > +	device_bind_driver(dev);
> > +}
> 
> Looks not right for the recent platform_device...
> You can do it better in platform_driver.probe and remove callbacks.
> 
> 
I'll have to have a look at that - this code is 5/6 months old and I
haven't followed recent changes to the platform device spec.


> > 
> > +	}
> 
> The code looks odd.  Simply call snd_card_new() once because this driver
> supports only one instance anyway.


Yes, but when I did that and then loaded the dummy device the driver
broke! As the dummy device can be loaded and as there are capyure
devices for the Dreamcast (never managed to get my driver to work
though) then I think it is needed
> 

> > +	/* Register the card with ALSA subsystem */
> > +	if ((err = snd_card_register(dreamcastcard->card)) < 0)
> > +		goto freepcm;
> > +
> > +	/* Load the firmware */
> > +	err = load_aica_firmware();
> 
> The firmware should be loaded before registration of the card
> instance.  snd_card_register() will create device files.  It means
> that user-space apps are allowed to access the driver.
> 
OK


> > +
> > +	if (err)
> > +		goto freepcm;
> > +
> > +
> > +	/* Add basic controls */
> > +	if (add_aicamixer_controls() < 0) goto freepcm;
> 
> This should be done before snd_card_register(), too.
> 

OK

> 
> > +	snd_printk
> > +	    ("ALSA Driver for Yamaha AICA Super Intelligent Sound Processor on slot %d\n",
> > +	     idx);
> > +
> > +	return 0;
> > +
> > +      freepcm:
> > +	snd_aicapcm_free(dreamcastcard);
> > +
> > +      freedreamcast:
> > +	snd_card_free(dreamcastcard->card);
> > +
> > +	if (pd) {
> > +		struct device_driver *drv = (&pd->dev)->driver;
> > +		device_release_driver(&pd->dev);
> > +		driver_unregister(drv);
> > +		platform_device_unregister(pd);
> > +		pd = NULL;
> > +	}
> > +	kfree(dreamcastcard);
> > +	return err;
> > +
> > +
> > +}
> > +
> > +static void __exit aica_exit(void)
> > +{
> > +
> > +	if (likely(dreamcastcard->card)) {
> 
> You don't need such an optimization in this place at all.
> 

true, more code from way back when

> > +		snd_aicapcm_free(dreamcastcard);
> > +		snd_card_free(dreamcastcard->card);
> > +		kfree(dreamcastcard);
> > +		if (likely(pd)) {
> > +			struct device_driver *drv = (&pd->dev)->driver;
> > +			device_release_driver(&pd->dev);
> > +			driver_unregister(drv);
> > +			platform_device_unregister(pd);
> > +		}
> 
> This should be in remove callback.
> 
> 
> Takashi

