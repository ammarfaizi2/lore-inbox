Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbTKUC2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 21:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbTKUC2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 21:28:33 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:55939 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S264182AbTKUC2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 21:28:30 -0500
Date: Thu, 20 Nov 2003 21:23:20 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: arvidjaar@mail.ru, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: modules.pnpmap output support
Message-ID: <20031120212320.GB25417@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Takashi Iwai <tiwai@suse.de>, arvidjaar@mail.ru,
	linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
References: <s5hptfrjezz.wl@alsa2.suse.de> <E1ALky0-000N9I-00.arvidjaar-mail-ru@f25.mail.ru> <s5had6vj99t.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5had6vj99t.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 04:37:50PM +0100, Takashi Iwai wrote:
> At Mon, 17 Nov 2003 18:07:04 +0300,
> Andrey Borzenkov wrote:

-->snip

> > > the file2alias format of (isa) pnp devices will need variable number
> > > of items, since a driver may require multiple ids.
> > > for example, snd-cs4236 driver supports the cards with three ids like
> > > 	CSCe825:CSC0100:CSC0110
> > > and four ids like
> > > 	CSCd937:CSC0000:CSC0010:CSC0003
> > > in each case, a matching card must include all ids listed there.
> > >
> >
> > do you mean that card will have to have all of these IDs to match?
> >
> > I can't get it reading sources. When driver matches card against
> > card driver it is apparently using only main IDs, not logical
> > device IDs:
> >
> > driver/pnp/card.c:match_card()
> >
> > static const struct pnp_card_device_id * match_card(struct pnp_card_driver * drv, struct pnp_card * card)
> > {
> >  	const struct pnp_card_device_id * drv_id = drv->id_table;
> >  	while (*drv_id->id){
> >  		if (compare_pnp_id(card->id,drv_id->id))
> >  			return drv_id;
> >  		drv_id++;
> >  	}
> >  	return NULL;
> >  }
> >
> > where are drv_id->devs used?
>
> hmm, i thought it checks the device ids but apparently it's not.
> IMO, this is a bug, because there are cards with the same card id but
> different device ids. (e.g. sound/isa/cs423x/cs4236.c)
> in the logic above, only the first matching entry is checked and it
> results in the failure of probing.
>
> Adam, what do you think?
>

The device ID is checked, but this checking occurs during the driver's
probe function, when it calls pnp_request_card_device.  This is needed
in order for us to properly deal with multidevice cards, especially in
ALSA.  If possibly, I'd like to see the devices in these cards be
handled individually in 2.7 but note that doing so would require
changes to some drivers and subsystems.  The current system works well
for 2.6.

Because of these factors, and the fact that pnp_device_id is also used,
I think that we have to include all of the IDs in the pnpidmap.  This
would include both the card id and the individual device IDs on each
card.  pnp_device_id can use the isapnp card device ids in addition to
the ids reported by the pnpbios.

Thanks,
Adam
