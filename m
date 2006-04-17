Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWDQB3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWDQB3X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 21:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWDQB3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 21:29:23 -0400
Received: from smtp2.pp.htv.fi ([213.243.153.35]:63633 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1750925AbWDQB3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 21:29:22 -0400
Date: Mon, 17 Apr 2006 04:29:13 +0300
From: Paul Mundt <lethal@linux-sh.org>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-sh <linuxsh-dev@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [linuxsh-dev] [PATCH] ALSA driver for Yamaa AICA on Sega Dreamcast
Message-ID: <20060417012913.GA16821@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Adrian McMenamin <adrian@mcmen.demon.co.uk>,
	Alsa-devel <alsa-devel@lists.sourceforge.net>,
	linux-sh <linuxsh-dev@lists.sourceforge.net>,
	LKML <linux-kernel@vger.kernel.org>
References: <1145232784.12804.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145232784.12804.2.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few quick comments.. though looking at the earlier thread, most of
these were already pointed out..

On Mon, Apr 17, 2006 at 01:13:04AM +0100, Adrian McMenamin wrote:
> diff -ruN --exclude=acore --exclude='.#*' ./sh/aica.c /home/adrian/alsa-driver/sh/aica.c
> --- ./sh/aica.c	1970-01-01 01:00:00.000000000 +0100
> +++ /home/adrian/alsa-driver/sh/aica.c	2006-04-16 23:13:59.000000000 +0100

-p1 format please.

> +#include <linux/init.h>
> +#include <linux/jiffies.h>
> +#include <linux/slab.h>
> +#include <linux/time.h>
> +#include <linux/wait.h>
> +#include <linux/moduleparam.h>
> +#include <linux/platform_device.h>
> +#include <linux/firmware.h>
> +#include <linux/timer.h>
> +#include <linux/delay.h>
> +#include <asm-sh/io.h>
> +#include <asm-sh/dma.h>
> +#include <asm-sh/dreamcast/sysasic.h>

What's wrong with asm/? asm/ includes should also be last.

> +
> +

This patch adds a lot of superfluous whitespace, please trim it.

> +static char *id = NULL;

Pointless initializer.

> +
> +/* Spinlocks */
> +spinlock_t spu_memlock = SPIN_LOCK_UNLOCKED;
> +spinlock_t spu_dmalock = SPIN_LOCK_UNLOCKED;
> +
DEFINE_SPINLOCK()..

> +
> +/* SPU specific functions */
> +
> +/* spu_write_wait - wait for G2-SH FIFO to clear */
> +static inline void spu_write_wait(void)
> +{
> +	int time_count;
> +	time_count = 0;
> +	while (1) {
> +		if (!(readl(G2_FIFO) & 0x11))
> +			break;
> +		/* To ensure hardware failure doesn't wedge kernel */
> +		time_count++;
> +		if (time_count > 0x10000)
> +			break;
> +	}
> +
> +	return;
> +}
> +
Useless return.

> +
> +/* spu_memset - write to memory in SPU address space */
> +static void spu_memset(uint32_t toi, void __iomem * what, int length)
> +{
> +	uint32_t *to = (uint32_t *) (SPU_MEMORY_BASE + toi);
> +	int i;
> +
> +
> +	if (length % 4)
> +		length = (length / 4) + 1;
> +	else
> +		length = length / 4;
> +	spu_write_wait();
> +	for (i = 0; i < length; i++) {
> +		spin_lock(&spu_memlock);
> +		writel(what, to);
> +		spin_unlock(&spu_memlock);
> +		to++;
> +		if (i && !(i % 8))
> +			spu_write_wait();
> +	}
> +	return;
> +}
> +
Likewise.

> +static void spu_memload(uint32_t toi, void __iomem * from, int length)
> +{
> +	uint32_t __iomem *froml = from;
> +	uint32_t __iomem *to =
> +	    (uint32_t __iomem *) (SPU_MEMORY_BASE + toi);
> +	int i, val;
> +	if (length % 4)
> +		length = (length / 4) + 1;
> +	else
> +		length = length / 4;
> +	spu_write_wait();
> +	for (i = 0; i < length; i++) {
> +		val = *froml;
> +		spin_lock(&spu_memlock);
> +		writel(val, to);
> +		spin_unlock(&spu_memlock);
> +		froml++;
> +		to++;
> +		if (i && !(i % 8))
> +			spu_write_wait();
> +	}
> +	return;
> +
> +}
> +
And again.

> +/* Halt the sound processor,
> +   clear the memory,
> +   load some default ARM7 code,
> +   and then restart ARM7
> +*/
> +static int spu_init(void)
> +{
> +
> +	spu_disable();
> +	spu_memset(0, 0, 0x200000 / 4);
> +	*(uint32_t *) SPU_MEMORY_BASE = 0xea000002;

Why are you not using ctrl_outl() or something similar? This should also
be documented a bit better if it's not magic..

> +/* aica_chn_start - write to spu to start playback */
> +inline static void aica_chn_start(void)

static inline void..

> +/* aica_chn_halt - write to spu to halt playback */
> +inline static void aica_chn_halt(void)
> +{
Likewise..

> +/* Simple platform device */
> +static struct platform_device *pd = NULL;
> +
> +
> +
Useless initializer and whitespace damage.

> +static int stereo_buffer_transfer(struct snd_pcm_substream *substream,
> +				  int buffer_size, int period)
> +{
> +	int transferred;
> +	struct snd_pcm_runtime *runtime;
> +	int period_offset;
> +	period_offset = period;
> +	period_offset %= (AICA_PERIOD_NUMBER / 2);
> +	runtime = substream->runtime;
> +
> +	/* transfer left and then right */
> +	spin_lock(&spu_dmalock);
> +	dma_xfer(0,
> +		 runtime->dma_area + (AICA_PERIOD_SIZE * period_offset),
> +		 AICA_CHANNEL0_OFFSET + (AICA_PERIOD_SIZE * period_offset),
> +		 buffer_size / 2, 5);
> +	/* wait for completion */
> +	do {
> +		udelay(5);
> +		transferred = get_dma_residue(0);
> +	}
> +	while (transferred < buffer_size / 2);

You can't be serious, you're trying to setup, transfer, and wait for
completion for a DMA transfer while holding a spinlock? The fact this
hasn't blown up on you is sheer luck. Use dma_wait_for_completion(), it
does the right thing.

Additionaly you need a timeout here if you were for some reason intent on
doing this while working against the DMA subsystem, if your DMA gets
stuck this will blow up.

> +void static aica_period_elapsed(unsigned long timer_var)
> +{

static void..

> +	int transferred;
> +	int play_period;
> +	struct snd_pcm_runtime *runtime;
> +	struct snd_pcm_substream *substream;
> +	struct snd_card_aica *dreamcastcard;
> +	substream = (struct snd_pcm_substream *) timer_var;
> +	runtime = substream->runtime;
> +	dreamcastcard =
> +	    (struct snd_card_aica *) (substream->pcm->private_data);

Useless cast.

> +	} else {
> +		spin_lock(&spu_dmalock);
> +		dma_xfer(0,
> +			 runtime->dma_area +
> +			 (AICA_PERIOD_SIZE * dreamcastcard->clicks),
> +			 AICA_CHANNEL0_OFFSET +
> +			 (AICA_PERIOD_SIZE * dreamcastcard->clicks),
> +			 AICA_PERIOD_SIZE, 5);
> +		do {
> +			/* Try to fine tune the delay to keep it as short as possible */
> +			udelay(5);
> +			/* get_dma_residue reports residue until completion when it reports total bytes transferred */
> +			transferred = get_dma_residue(0);
> +		}
> +		while (transferred < AICA_PERIOD_SIZE);
> +		spin_unlock(&spu_dmalock);
> +	}
> +
spinlock / DMA brain damage.

> +	snd_pcm_period_elapsed(dreamcastcard->substream);
> +	dreamcastcard->clicks++;
> +	dreamcastcard->clicks %= AICA_PERIOD_NUMBER;
> +	/* reschedule the timer */
> +	dreamcastcard->timer.expires = jiffies + 1;
> +	add_timer(&(dreamcastcard->timer));
> +	return;
> +}
> +
Superfluous return.

> +static int snd_aicapcm_pcm_open(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime;
> +	struct aica_channel *channel;
> +	struct snd_card_aica *dreamcastcard;
> +
> +	if (!enable)
> +		return -ENOENT;

unlikely()?

> +	dreamcastcard =
> +	    (struct snd_card_aica *) (substream->pcm->private_data);

Useless cast.

> +static int snd_aicapcm_pcm_close(struct snd_pcm_substream *substream)
> +{
> +	struct snd_card_aica *dreamcastcard =
> +	    (struct snd_card_aica *) (substream->pcm->private_data);
Likewise.

> +static int snd_aicapcm_pcm_prepare(struct snd_pcm_substream *substream)
> +{
> +
> +	struct snd_card_aica *dreamcastcard =
> +	    (struct snd_card_aica *) (substream->pcm->private_data);

And again.

> +static void startup_aica(struct snd_card_aica *dreamcastcard)
> +{
> +	spu_memload(AICA_CHANNEL0_CONTROL_OFFSET,
> +		    (uint8_t *) dreamcastcard->channel,
> +		    sizeof(struct aica_channel));
> +	aica_chn_start();
> +	return;
> +}
> +
Useless return.

> +
> +static void spu_begin_dma(struct snd_pcm_substream *substream)
> +{
> +	int buffer_size;
> +	snd_pcm_runtime_t *runtime;
> +	struct snd_card_aica *dreamcastcard =
> +	    (struct snd_card_aica *) (substream->pcm->private_data);

Superfluous cast.

> +	runtime = substream->runtime;
> +	buffer_size = frames_to_bytes(runtime, runtime->buffer_size);
> +	if (runtime->channels == 1) {
> +		spin_lock(&spu_dmalock);
> +		dma_xfer(0, runtime->dma_area, AICA_CHANNEL0_OFFSET,
> +			 buffer_size, 5);
> +		spin_unlock(&spu_dmalock);

Broken locking.

> +static int __init snd_aicapcmchip(struct snd_card_aica *dreamcastcard,
> +				  int pcm_index)
> +{
> +	struct snd_pcm *pcm;
> +	int err;
> +
> +	/* Can we lock the memory */
> +
> +	if (request_mem_region(ARM_RESET_REGISTER, 4, "AICA ARM control")
> +	    == NULL)
> +		return -ENOMEM;
> +	if (request_mem_region(SPU_MEMORY_BASE, 0x200000, "AICA Sound RAM")
> +	    == NULL) {
> +		release_mem_region(ARM_RESET_REGISTER, 0x4);
> +		return -ENOMEM;
> +	}
> +
Why aren't these setup in the platform device?

> +	/* AICA has no capture ability */
> +	if ((err =
> +	     snd_pcm_new(dreamcastcard->card, "AICA PCM", pcm_index, 1, 0,
> +			 &pcm)) < 0)
> +		return err;

Weird notation, linux kernel style would be:

	err = snc_pcm_new(...);
	if (unlikely(err < 0))
		return err;

please refactor accordingly.

> +static int aica_pcmvolume_put(struct snd_kcontrol *kcontrol,
> +			      struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_card_aica *dreamcastcard;
> +	dreamcastcard = (struct snd_card_aica *) kcontrol->private_value;
> +
> +	if (!dreamcastcard->channel) {
> +		snd_printk("No channel yet\n");
> +		return -ETXTBSY;	/* too soon */
> +	}
> +
> +	else if (dreamcastcard->channel->vol ==
> +		 ucontrol->value.integer.value[0])
> +		return 0;
> +
> +	else {

The if/elses are all over the place, please see
Documentation/CodingStyle.

> +static struct device_driver aica_driver = {
> +	.name = "AICA",
> +	.bus = &platform_bus_type,
> +	.remove = remove_dreamcastcard,
> +};
> +
Deprecated, see struct platform_device.

> +	pd = platform_device_register_simple(dreamcastcard->card->driver,
> +					     -1, NULL, 0);
> +
This is also going away, you'll want to update this for the new platform
device semantics.

> +      freepcm:
> +	snd_aicapcm_free();
> +
> +      freedreamcast:
> +	snd_card_free(dreamcastcard->card);
> +
Why are these goto labels in magical locations?

> +static void __exit aica_exit(void)
> +{
> +	struct device_driver *drv = (&pd->dev)->driver;
> +	device_release_driver(&pd->dev);
> +	driver_unregister(drv);
> +	platform_device_unregister(pd);
> +	/* Kill any sound still playing and reset ARM7 to safe state */
> +	spu_init();
> +
> +
> +	return;
> +}
> +
And another useless return.
