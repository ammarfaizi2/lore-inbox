Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267405AbTBIRqM>; Sun, 9 Feb 2003 12:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267406AbTBIRqM>; Sun, 9 Feb 2003 12:46:12 -0500
Received: from gate.perex.cz ([194.212.165.105]:61968 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267405AbTBIRqK>;
	Sun, 9 Feb 2003 12:46:10 -0500
Date: Sun, 9 Feb 2003 18:55:46 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Adam Belay <ambx1@neo.rr.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [alsa, pnp] more on opl3sa2 (fwd)
In-Reply-To: <20030205220132.GA10021@neo.rr.com>
Message-ID: <Pine.LNX.4.44.0302091830260.1449-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2003, Adam Belay wrote:

> On Mon, Feb 03, 2003 at 03:15:59PM +0100, Jaroslav Kysela wrote:
> > On Thu, 30 Jan 2003, Adam Belay wrote:
> > 
> > > Hi Jaroslav,
> > > 
> > > How does this sound...
> > > 
> > > What if we make pnp card services match against all pnp cards and allow more
> > > than one card driver to use the same card.  This can be accomplished if we detach
> > > the card portion from the driver model and use driver_attach.  If you feel it is
> > 
> > The question is probably another. I know that your solution will work, but 
> > do we need such hack against the driver model in our code? If you work 
> > with cards as buses, it allows us the same model as PCI code.
> > 
> > > necessary, we could also add an optional card id to the pnp_device_id structure.
> > > As for the pnpbios, I disagree with putting it under one card.  If the pnpbios
> > > contains two opl3sa2 sound cards then only one will be matched and therefore it
> > 
> > It's not true. The driver model calls probe for all instances.
> > 
> > > is a bad idea to represent the pnpbios as a card.  When ACPI is introduced, both
> > 
> > Note that if we make card as bus, then this problem will disapear.
> > The enumeration will be simple: devices on the one bus. And it's strong 
> > advantage over current implementation when bus == protocol.
> > 
> > What do you think about this model:
> > 
> > bus (PnP BIOS) -> devices
> > bus (ACPI) -> devices
> > bus (ISA PnP) -> bus (cards) -> devices
> > 
> 
> I think this model has potential but before we go that direction I'd like to hear
> your reactions on another more simplistic model.  I'll express it with a
> hypothetical code example.  This model completely drops individual card matching
> and is compatible with both card users and non-card users.
> 
> 
> static struct pnp_device_id snd_als100_pnpids[] = {
> 	/* ALS100 - PRO16PNP */
> 	{.card_id = "ALS0001" .id = "@@@0001", .driver_data = ALS100_AUDIO},
> 	{.card_id = "ALS0001" .id = "@X@0001", .driver_data = ALS100_MPU},
> 	{.card_id = "ALS0001" .id = "@H@0001", .driver_data = ALS100_OPL},
> 	/* ALS110 - MF1000 - Digimate 3D Sound */
> 	{.card_id = "ALS0110" .id = "@@@1001", .driver_data = ALS100_AUDIO},
> 	{.card_id = "ALS0001" .id = "@X@1001", .driver_data = ALS100_MPU},
> 	{.card_id = "ALS0001" .id = "@H@1001", .driver_data = ALS100_OPL},
> ---> snip
> };
> 
> 
> static int __init snd_card_als100_probe(struct pnp_dev * dev, struct pnp_device_id * id)
> {
> ---> snip
> 	snd_card_t *card;
> ---> snip
> 	card = snd_card_find(dev->card);	/* this function searches for previously
> 						 registered sound cards and binds this
> 						 device to it if it finds that it was a
> 						 member of the same pnp_card */
> 	if (!card) {
> 		if ((card = snd_card_new(index[dev], id[dev], THIS_MODULE,
> 			 sizeof(struct snd_card_als100))) == NULL)
> 		return -ENOMEM;
> 	}
> 	switch (id->driver_data) {
> 	case ALS100_AUDIO:
> ---> snip
> 	case ALS100_MPU:
> ---> snip
> 	case ALS100_OPL:
> ---> snip
> etc . . .
> 
> 
> I'm interested in your opinions on this approach.

I'm sure that this model will work, but it's a bit complicated to 
allocate devices in this way. I'd prefer to probe / allocate devices in 
one shot. Anyway, it's a step forward. I'm thinking about this scenario:

Pass id list "match all" (or we can have a match callback in the
pnp_driver structure) and find/allocate multiple devices manually in
probe.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


