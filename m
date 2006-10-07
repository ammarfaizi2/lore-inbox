Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWJGMyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWJGMyQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 08:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWJGMyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 08:54:15 -0400
Received: from soundwarez.org ([217.160.171.123]:4075 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751077AbWJGMyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 08:54:15 -0400
Subject: Re: sysfs & ALSA card
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Jaroslav Kysela <perex@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20061007074440.GA9304@kroah.com>
References: <Pine.LNX.4.61.0610061548340.8573@tm8103.perex-int.cz>
	 <20061007062458.GF23366@kroah.com>  <20061007074440.GA9304@kroah.com>
Content-Type: text/plain
Date: Sat, 07 Oct 2006 14:55:30 +0200
Message-Id: <1160225730.19302.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-07 at 00:44 -0700, Greg KH wrote: 
> > On Fri, Oct 06, 2006 at 04:00:27PM +0200, Jaroslav Kysela wrote:
> > > 	I would like to discuss where is the right root for soundcards in 
> > > the sysfs tree. I would like to put card specific variables like id there 
> > > (see /proc/asound/card0/id).

> > > Also, I plan to create link from 
> > > /sys/class/sound tree to the appropriate card to show relationship. 
> > > Something like:
> > > 
> > > /sys/<somewhere>/soundcard/0
> > > 
> > > /sys/class/sound/controlC0/soundcard -> ../../../<somewhere>/soundcard/0
> > > 
> > > 	Any comments and suggestions?

No, please no links if you have stuff that can be expressed in a tree,
which you perfectly can in this case. Just create a parent "card-device"
to hold the generic card attributes, and put the stuff like pcmC0* below
that device. Userspace is fine with that and will not break,
cause /sys/class/sound/* is still just a flat directory with all devices
in one directory, only the link targets will point to a hierarchy (note
that the link target of "pcmC1D0c" includes" Audigy2". )

> Here's what /sys/class/sound now looks like for me:
>  $ tree /sys/class/sound/
>  /sys/class/sound/
>  |-- Audigy2 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2
>  |-- admmidi1 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/admmidi1
>  |-- amidi1 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/amidi1
>  |-- controlC1 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/controlC1
>  |-- dmmidi1 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/dmmidi1
>  |-- hwC1D0 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/hwC1D0
>  |-- midi1 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/midi1
>  |-- midiC1D0 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/midiC1D0
>  |-- midiC1D1 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/midiC1D1
>  |-- pcmC1D0c -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/pcmC1D0c
>  |-- pcmC1D0p -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/pcmC1D0p
>  |-- pcmC1D1c -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/pcmC1D1c
>  |-- pcmC1D2c -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/pcmC1D2c
>  |-- pcmC1D2p -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/pcmC1D2p
>  |-- pcmC1D3p -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/pcmC1D3p
>  |-- pcmC1D4c -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/pcmC1D4c
>  |-- pcmC1D4p -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/pcmC1D4p
>  `-- timer -> ../../devices/virtual/sound/timer
> 
> 
> Yeah, I picked the wrong name for the card, it should be "card1" instead
> of "Audigy2" here, but you get the idea.

That looks nice. Yeah, it should something that matches to the C1 in the
other names.

> Please also note that you will need the latest versions of udev to get
> this to work properly for your sysfs nodes.

This should be fine for all recent releases including SLE.

Thanks,
Kay

