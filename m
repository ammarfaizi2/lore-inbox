Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263543AbTKQPJP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 10:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263546AbTKQPJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 10:09:15 -0500
Received: from f25.mail.ru ([194.67.57.151]:35338 "EHLO f25.mail.ru")
	by vger.kernel.org with ESMTP id S263543AbTKQPJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 10:09:07 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Takashi Iwai=?koi8-r?Q?=22=20?= <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: modules.pnpmap output support
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Mon, 17 Nov 2003 18:07:04 +0300
In-Reply-To: <s5hptfrjezz.wl@alsa2.suse.de>
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1ALky0-000N9I-00.arvidjaar-mail-ru@f25.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > 
> > Oh, BTW, it reminds me - file2alias prints hex in upper
> > case while both sysfs and hotplug present them in lower case
> > (for sure for USB and PCI, and for PNP entries detected by 
> > PNP BIOS). Should not we unify representation?
> 
> hmm, file2alias uses lower letters as the identifier (seprator?), so i
> think simply using lower hex letter will be confusing.  wouldn't it be
> better to have an  explicit delimter character like ':' (or '/' or
> whatever) ?
> 

those are not meant to be end-user visible anyway so no I do not
expect any confustion. Nor do I suggest making them lower case -
we could fix all occurences in kernel instead :)

if you want to use separator, = is probably better. v=XXXp=YYY
> 
> at first i'll try to add the support of old isapnp format for
> compatibility, so that old programs can work as they are.
>

??? old programs do not know about modules.alias at all. Or I
do not understand what you mean.
 
> the file2alias format of (isa) pnp devices will need variable number
> of items, since a driver may require multiple ids.
> for example, snd-cs4236 driver supports the cards with three ids like
> 	CSCe825:CSC0100:CSC0110
> and four ids like
> 	CSCd937:CSC0000:CSC0010:CSC0003
> in each case, a matching card must include all ids listed there.
> 

do you mean that card will have to have all of these IDs to match? 
I can't get it reading sources. When driver matches card against
card driver it is apparently using only main IDs, not logical
device IDs:

driver/pnp/card.c:match_card()

static const struct pnp_card_device_id * match_card(struct pnp_card_driver * drv, struct pnp_card * card)
{
 	const struct pnp_card_device_id * drv_id = drv->id_table;
 	while (*drv_id->id){
 		if (compare_pnp_id(card->id,drv_id->id))
 			return drv_id;
 		drv_id++;
 	}
 	return NULL;
 }

where are drv_id->devs used?

because the point of modules.alias is to follow the same logic (to
determine which driver to load), where do ->devs fit in?

> well, i'm not sure which identifier (separator) letter in which style
> should be used.  something like
> 	pnp:idXXXxxxxd0XXXxxxxd1XXXXxxxx

leave it as is, it is just fine actually. Assuming you really need
those extra IDs at all.

What application do you have in mind? I aim at hotplug, i.e.
(isa|bios)pnp after getting list of devices would call hotplug to load
drivers. So i need the same logic as in driver matching and this
does not need extra IDs.

regards

-andrey
