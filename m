Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWDXRGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWDXRGE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWDXRGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:06:04 -0400
Received: from tim.rpsys.net ([194.106.48.114]:4841 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750930AbWDXRGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:06:01 -0400
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
From: Richard Purdie <rpurdie@rpsys.net>
To: dtor_core@ameritech.net
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <d120d5000604240926u51fc06d6gbf4f23832064e0ad@mail.gmail.com>
References: <20060419195356.GA24122@srcf.ucam.org>
	 <20060419200447.GA2459@isilmar.linta.de>
	 <20060419202421.GA24318@srcf.ucam.org>
	 <d120d5000604240745i71bd56b8n99b97130388d36f6@mail.gmail.com>
	 <1145894731.7155.120.camel@localhost.localdomain>
	 <d120d5000604240926u51fc06d6gbf4f23832064e0ad@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 18:05:40 +0100
Message-Id: <1145898341.7155.145.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 12:26 -0400, Dmitry Torokhov wrote:
> On 4/24/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> > This gets tricky as the handhelds have two "lid" switches. Pictures of
> > how it can fold are at http://www.dynamism.com/sl-c3000/main.shtml . To
> > summarise, it can be in three positions:
> >
> > * Screen folded facing the keys (shut like a laptop)
> > * Screen open above the keyboard (like an open laptop)
> > * Screen folded over the keys but with the screen visible (becomes a
> > tablet like handheld with no keyboard)
> >
> > Shut is when both switches (SW_0 and SW_1) are pressed, open is when
> > neither are pressed and the "no keyboard" mode has only one switch
> > pressed.
> 
> Ugh... I wonder if we could change SW_0 to report "comletely
> shut"/"open" and SW_1 to report orientation. Then we could alias SW_0
> <-> SW_LID, SW_1 <-> SW_TABLET_MODE.

I've checked which switch is which and SW_0 is equivalent to SW_LID. We
can just rename them and retain compatibility if:

SW_0/SW_LID is pressed to indicate shut
SW_1/SW_TABLET_MODE is pressed to indicate tablet mode
SW_2/SW_HEADPHONE_DETECT is pressed to indicate headphone jack insertion

I'm happy to submit a patch to make that change (and remove the as yet
unused SW_[3-7] if you like?

I realise there are arguments for having the headphone jack control
monitoring in the sound driver but this was the nicest way I've found of
passing the event to user space to deal with. I didn't want to deal with
it in the sound driver as in this case there is no right answer as to
what the sound driver should do (we can't detect if it was headphones, a
speaker + mic headset etc. or just a mic that was inserted yet we can
support all of them).

> > If we are going to have a KEY_LID switch, we should probably decide now
> > whether the switch is pressed (1) when the lid is either open or shut
> > otherwise things are going to get confused.
>
> SW_LID please.

Sorry, I did mean SW_LID.

> > I've often wondered whether the input system could/should be used to
> > pass more generic events. I know my handheld has lots of other switch
> > like events such as MMC/SD card insertion, CF card insertion, a battery
> > lock switch, AC power insertion switch and USB cable detection "switch".
> > Most of these are currently acted on by the kernel so userspace doesn't
> > need to see them but some like the USB cable detection would be useful.
> > It could then load the user's chosen USB gadget kernel module for
> > example. In that case its a user choice as there is no "right" gadget
> > module to autoload. I'm not sure if it would be right for these to go
> > via the input system and last time I looked, udev wasn't able to handle
> > generic events like this.
> >
> 
> I don't think these belong to input system.

Yet they're arguably switches and have all the right semantics to be
reported as such. I agree they shouldn't be in the input system but
where should they be? Currently we don't need most of them but some
would be useful.

> > Whilst sort of on the subject (AC power switches and AC power events)
> > I'd like to see some standard way of exporting power/battery information
> > to userspace. Currently, the ARM handhelds use kernel emulation of an
> > APM bios and export the battery info as part of that. Making ARM emulate
> > ACPI interfaces doesn't appeal. The answer could be a battery sysfs
> > class and the above system events interface but I'm open to other
> > suggestions.
> >
> 
> Having generic battery interface would be nice.

It gets tricky. AC presence isn't a property of a battery for example
and is in fact more like a switch (my handheld has a mechanical switch
to detect when its plugged in) ;). The battery class would export some
information but not all of it and I don't know where the leftover
information should go. If I knew that, I'd write the class.

Cheers,

Richard

