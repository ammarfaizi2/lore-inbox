Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWJIGY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWJIGY6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 02:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWJIGY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 02:24:58 -0400
Received: from gate.perex.cz ([85.132.177.35]:40363 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932254AbWJIGY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 02:24:57 -0400
Date: Mon, 9 Oct 2006 08:24:55 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: sysfs & ALSA card
In-Reply-To: <20061007191228.GA31396@vrfy.org>
Message-ID: <Pine.LNX.4.61.0610090820230.8665@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0610061548340.8573@tm8103.perex-int.cz>
 <20061007062458.GF23366@kroah.com> <20061007074440.GA9304@kroah.com>
 <1160225730.19302.1.camel@localhost> <20061007191228.GA31396@vrfy.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2006, Kay Sievers wrote:

> On Sat, Oct 07, 2006 at 02:55:31PM +0200, Kay Sievers wrote:
> > On Sat, 2006-10-07 at 00:44 -0700, Greg KH wrote: 
> > >  $ tree /sys/class/sound/
> > >  /sys/class/sound/
> > >  |-- Audigy2 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2
> > >  |-- admmidi1 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/admmidi1
> 
> > > Yeah, I picked the wrong name for the card, it should be "card1" instead
> > > of "Audigy2" here, but you get the idea.
> > 
> > That looks nice. Yeah, it should something that matches to the C1 in the
> > other names.
> 
> This works fine for me with two soundcards and connect/disconnect
> module load/unload.
> 
> All devices are in a flat list in the class directory, also the card%i
> ones:
>   $ tree /sys/class/sound/
>   /sys/class/sound/
>   |-- adsp -> ../../devices/pci0000:00/0000:00:1e.2/card0/adsp

....

> In the /sys/devices hierarchy all devices belonging to the same card are
> nicely below the card device:
>   $ ls -l /sys/devices/pci0000:00/0000:00:1e.2/card0
>   total 0
>   drwxr-xr-x 3 root root    0 2006-10-07 21:09 0-0:AD1981B
>   drwxr-xr-x 3 root root    0 2006-10-07 21:09 adsp
>   drwxr-xr-x 3 root root    0 2006-10-07 21:09 audio

....

The implementation looks good (Acked-by: Jaroslav Kysela <perex@suse.cz>).
Please, fix this small typo:

> --- linux-2.6.orig/sound/core/sound.c
> +++ linux-2.6/sound/core/sound.c
> @@ -268,11 +268,10 @@ int snd_register_device(int type, struct
>  	snd_minors[minor] = preg;
>  	if (card)
>  		device = card->dev;
> -	preg->class_dev = class_device_create(sound_class, NULL,
> -					      MKDEV(major, minor),
> -					      device, "%s", name);
> -	if (preg->class_dev)
> -		class_set_devdata(preg->class_dev, private_data);
> +	preg->dev = device_create(sound_class, device, MKDEV(major, minor),
> +				  "%s", name);
> +	if (preg->dev)
> +		dev_get_drvdata(preg->dev);

I think, it should be:

	if (preg->dev)
		dev_set_drvdata(preg->dev, private_data);

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
