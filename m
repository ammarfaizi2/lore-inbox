Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbVITW2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbVITW2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbVITW2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:28:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31712 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965176AbVITW2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:28:43 -0400
Date: Tue, 20 Sep 2005 15:28:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: jayakumar.alsa@gmail.com
Cc: perex@suse.cz, mj@ucw.cz, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13.1 1/1] CS5535 AUDIO ALSA driver
Message-Id: <20050920152830.7ef6733b.akpm@osdl.org>
In-Reply-To: <200509190639.j8J6dIM4007948@localhost.localdomain>
References: <200509190639.j8J6dIM4007948@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jayakumar.alsa@gmail.com wrote:
>
> Hi Jaroslav, Takashi, Martin, alsa and kernel folk,
> 
> Appended is my patch adding support for the CS5535 Audio device. I've
> fixed up some errors as per Takashi's advice from the thread:
> 

Some triviata:

> +++ linux-2.6.13.1/MAINTAINERS	2005-09-15 15:00:19.000000000 +0800
> @@ -621,6 +621,11 @@ M:	davem@davemloft.net
>  L:	linux-crypto@vger.kernel.org
>  S:	Maintained
>  
> +CS5535 Audio ALSA driver
> +P:	Jaya Kumar
> +M:	jayakumar.alsa@gmail.com
> +S:	Maintained
> +

Neat, thanks.

> +
> +#include <asm/io.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +#include <linux/moduleparam.h>
> +#include <sound/driver.h>
> +#include <sound/core.h>
> +#include <sound/control.h>
> +#include <sound/pcm.h>
> +#include <sound/rawmidi.h>
> +#include <sound/ac97_codec.h>
> +#include <sound/initval.h>
> +#include <sound/asoundef.h>
> +#include "cs5535audio.h"

By convention we put the asm/ includes after the linux/ includes.

> +
> +static unsigned short snd_cs5535audio_codec_read(cs5535audio_t *cs5535au, 

typedefs are unpopular in-kernel.  We generally don't get too fussed if a
driver maintainer really wants them there.  The main objection is that we
now have two names for the same thing.  Plus they cannot be used when
forward-declaring a structure.

> +
> +	timeout = 500;
> +	do {
> +		tmp = cs_readl(ACC_CODEC_CNTL);
> +		if (!(tmp & CMD_NEW)) 
> +			break;
> +		msleep(10);
> +	} while (timeout--);
> +	if (!timeout) {
> +		snd_printk(KERN_ERR "Failure writing to cs5535 codec\n");
> +	}

This isn't right.  `timeout' will have a value of -1 if we timed out. 
(several instances).


> +	timeout = 50;
> +	do {
> +		val = cs_readl(ACC_CODEC_STATUS);
> +		if (	(val & STS_NEW) && 
> +			((unsigned long) reg == ((0xFF000000 & val)>>24)) )
> +			break;
> +		msleep(10);
> +	} while (timeout--);
> +	if (!timeout) {
> +		snd_printk(KERN_ERR "Failure reading cs5535 codec\n");
> +	}

Ditto.  Plus we prefer to not put braces around a single statement like this.

> +	timeout = 50;
> +	do {
> +		tmp = cs_readl(ACC_CODEC_CNTL);
> +		if (!(tmp & CMD_NEW)) 
> +			break;
> +		msleep(10);
> +	} while (timeout--);
> +	if (!timeout) {
> +		snd_printk(KERN_ERR "Failure writing to cs5535 codec\n");
> +	}

Again.  Perhaps a helper function so this code (and its bug) don't get
duplicated so much?

> +	snd_cs5535audio_codec_write(cs5535au,reg,val);

We normally put a space after commas.

> +	if ((err = snd_ac97_bus(card, 0, &ops, NULL, &pbus)) < 0)

And so do you ;)

> +	if (bm_stat & EOP) {
> +		cs5535audio_dma_t *dma;
> +		dma = (cs5535audio_dma_t *) 
> +			cs5535au->capture_substream->runtime->private_data;

Unneeded typecast.

> +		dma->index = (++(dma->index)) % dma->periods;

Is no locking needed for dma->index?

> +			switch (count) {
> +				case IRQ_STS:
> +					cs_readl(ACC_GPIO_STATUS);
> +					break;
> +				case WU_IRQ_STS:
> +					cs_readl(ACC_GPIO_STATUS);
> +					break;

We normally do

			switch (count) {
			case IRQ_STS:
				cs_readl(ACC_GPIO_STATUS);
				break;
			case WU_IRQ_STS:
				cs_readl(ACC_GPIO_STATUS);
				break;

Just to save a tabstop.

> +					break;
> +				default:
> +					snd_printk(KERN_ERR 
> +						"Unexpected irq src\n");
> +					break;	
> +			}
> +		}
> +	}
> +	return IRQ_HANDLED;
> +}

Perhaps the default case should return IRQ_NONE.

> +static int snd_cs5535audio_free(cs5535audio_t *cs5535au)
> +{
> +	synchronize_irq(cs5535au->irq);
> +	pci_set_power_state(cs5535au->pci, 3);
> +
> +	if (cs5535au->irq >= 0)
> +		free_irq(cs5535au->irq, (void *)cs5535au);

Unneeded typecast.

> +static int __devinit snd_cs5535audio_create(snd_card_t *card,
> +				     struct pci_dev *pci,
> +				     cs5535audio_t **rcs5535au)
> +{
> +	cs5535audio_t *cs5535au;
> +
> +	int err;
> +	static snd_device_ops_t ops = {
> +		.dev_free =	snd_cs5535audio_dev_free,
> +	};
> +
> +	*rcs5535au = NULL;
> +	if ((err = pci_enable_device(pci)) < 0)
> +		return err;
> +
> +	cs5535au = kcalloc(1, sizeof(*cs5535au), GFP_KERNEL);

We have kzalloc() now.

> +	if (cs5535au == NULL) {
> +		pci_disable_device(pci);
> +		return -ENOMEM;
> +	}
> +	spin_lock_init(&cs5535au->reg_lock);
> +	cs5535au->card = card;
> +	cs5535au->pci = pci;
> +	cs5535au->irq = -1;
> +	if ((err = pci_request_regions(pci, "CS5535 Audio")) < 0) {
> +		kfree(cs5535au);
> +		pci_disable_device(pci);
> +		return err;
> +	}
> +	cs5535au->port = pci_resource_start(pci, 0);
> +	if (request_irq(pci->irq, snd_cs5535audio_interrupt, 
> +		SA_INTERRUPT|SA_SHIRQ, "CS5535 Audio", (void *) cs5535au)) {

Unneeded typecast.

> +		snd_printk("unable to grab IRQ %d\n", pci->irq);
> +		snd_cs5535audio_free(cs5535au);
> +		return -EBUSY;
> +	}
> +
> +	cs5535au->irq = pci->irq;
> +	pci_set_master(pci);
> +
> +	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, 
> +					cs5535au, &ops)) < 0) {
> +		snd_cs5535audio_free(cs5535au);
> +		return err;
> +	}
> +
> +	snd_card_set_dev(card, &pci->dev);
> +
> +	*rcs5535au = cs5535au;
> +	return 0;
> +}

Please consider reworking functions such as the above so as to have a
single `reutrn' statement.  Or one `return' for success and just one for
the error paths.  Reason: a) it's easier to chack that all resources are
being freed on the error paths and b) It's easier to add new stuff which
allocates new resources which need to be released on error paths.  Involves
goto spaghetti.


> +static int __devinit snd_cs5535audio_probe(struct pci_dev *pci,
> +					const struct pci_device_id *pci_id)
> +{
> +	static int dev;
> +	snd_card_t *card;
> +	cs5535audio_t *cs5535au;
> +	int err;
> +
> +	if (dev >= SNDRV_CARDS)
> +		return -ENODEV;
> +	if (!enable[dev]) {
> +		dev++;
> +		return -ENOENT;
> +	}
> +
> +	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
> +	if (card == NULL)
> +		return -ENOMEM;
> +
> +	if ((err = snd_cs5535audio_create(card, pci, &cs5535au)) < 0) {
> +		snd_card_free(card);
> +		return err;
> +	}
> +
> +	if ((err = snd_cs5535audio_mixer(cs5535au)) < 0) {
> +		snd_card_free(card);
> +		return err;
> +	}
> +
> +	if ((err = snd_cs5535audio_pcm(cs5535au)) < 0) {
> +		snd_card_free(card);
> +		return err;
> +	}
> +
> +	strcpy(card->driver, DRIVER_NAME);
> +
> +	strcpy(card->shortname, "CS5535 Audio");
> +	sprintf(card->longname, "%s %s at 0x%lx, irq %i",
> +		card->shortname, card->driver,
> +		cs5535au->port, cs5535au->irq);
> +
> +	if ((err = snd_card_register(card)) < 0) {
> +		snd_card_free(card);
> +		return err;
> +	}
> +
> +	pci_set_drvdata(pci, card);
> +	dev++;
> +	return 0;
> +}

Ditto.

The handling of `dev' is racy ;)

> +	addr = (u32)substream->runtime->dma_addr;

Nope, _snd_pcm_runtime.addr has type dma_addr_t, which is an opaque type,
64-bit on some platforms.  I expect this driver will blow up on those
platforms.

> +	desc_addr = (u32)dma->desc_buf.addr;

Ditto.

> +	cs5535audio_t *cs5535au = snd_pcm_substream_chip(substream);
> +	cs5535audio_dma_t *dma = (cs5535audio_dma_t *)
> +					substream->runtime->private_data;

Unneeded cast.

+#define cs_writel(reg, val) 	outl(val, (int) cs5535au->port + reg)
+#define cs_writeb(reg, val) 	outb(val, (int) cs5535au->port + reg)
+#define cs_readl(reg) 		inl((unsigned short) (cs5535au->port + reg))
+#define cs_readw(reg) 		inw((unsigned short) (cs5535au->port + reg))
+#define cs_readb(reg) 		inb((unsigned short) (cs5535au->port + reg))

erk.   subsystem-wide helper macros which reference local variables?

Oh well - it _is_ a sound driver ;)
