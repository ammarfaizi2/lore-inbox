Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbTBFCuk>; Wed, 5 Feb 2003 21:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265249AbTBFCuj>; Wed, 5 Feb 2003 21:50:39 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:17802 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S265246AbTBFCuh>;
	Wed, 5 Feb 2003 21:50:37 -0500
Date: Wed, 5 Feb 2003 22:01:32 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [alsa, pnp] more on opl3sa2 (fwd)
Message-ID: <20030205220132.GA10021@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
References: <20030130222401.GH2246@neo.rr.com> <Pine.LNX.4.44.0302031457580.1116-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302031457580.1116-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 03:15:59PM +0100, Jaroslav Kysela wrote:
> On Thu, 30 Jan 2003, Adam Belay wrote:
> 
> > Hi Jaroslav,
> > 
> > How does this sound...
> > 
> > What if we make pnp card services match against all pnp cards and allow more
> > than one card driver to use the same card.  This can be accomplished if we detach
> > the card portion from the driver model and use driver_attach.  If you feel it is
> 
> The question is probably another. I know that your solution will work, but 
> do we need such hack against the driver model in our code? If you work 
> with cards as buses, it allows us the same model as PCI code.
> 
> > necessary, we could also add an optional card id to the pnp_device_id structure.
> > As for the pnpbios, I disagree with putting it under one card.  If the pnpbios
> > contains two opl3sa2 sound cards then only one will be matched and therefore it
> 
> It's not true. The driver model calls probe for all instances.
> 
> > is a bad idea to represent the pnpbios as a card.  When ACPI is introduced, both
> 
> Note that if we make card as bus, then this problem will disapear.
> The enumeration will be simple: devices on the one bus. And it's strong 
> advantage over current implementation when bus == protocol.
> 
> What do you think about this model:
> 
> bus (PnP BIOS) -> devices
> bus (ACPI) -> devices
> bus (ISA PnP) -> bus (cards) -> devices
> 

I think this model has potential but before we go that direction I'd like to hear
your reactions on another more simplistic model.  I'll express it with a
hypothetical code example.  This model completely drops individual card matching
and is compatible with both card users and non-card users.


static struct pnp_device_id snd_als100_pnpids[] = {
	/* ALS100 - PRO16PNP */
	{.card_id = "ALS0001" .id = "@@@0001", .driver_data = ALS100_AUDIO},
	{.card_id = "ALS0001" .id = "@X@0001", .driver_data = ALS100_MPU},
	{.card_id = "ALS0001" .id = "@H@0001", .driver_data = ALS100_OPL},
	/* ALS110 - MF1000 - Digimate 3D Sound */
	{.card_id = "ALS0110" .id = "@@@1001", .driver_data = ALS100_AUDIO},
	{.card_id = "ALS0001" .id = "@X@1001", .driver_data = ALS100_MPU},
	{.card_id = "ALS0001" .id = "@H@1001", .driver_data = ALS100_OPL},
---> snip
};


static int __init snd_card_als100_probe(struct pnp_dev * dev, struct pnp_device_id * id)
{
---> snip
	snd_card_t *card;
---> snip
	card = snd_card_find(dev->card);	/* this function searches for previously
						 registered sound cards and binds this
						 device to it if it finds that it was a
						 member of the same pnp_card */
	if (!card) {
		if ((card = snd_card_new(index[dev], id[dev], THIS_MODULE,
			 sizeof(struct snd_card_als100))) == NULL)
		return -ENOMEM;
	}
	switch (id->driver_data) {
	case ALS100_AUDIO:
---> snip
	case ALS100_MPU:
---> snip
	case ALS100_OPL:
---> snip
etc . . .


I'm interested in your opinions on this approach.

Thanks,
Adam
