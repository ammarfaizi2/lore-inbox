Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286759AbSABFmH>; Wed, 2 Jan 2002 00:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSABFl5>; Wed, 2 Jan 2002 00:41:57 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:23506 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S286776AbSABFlt>; Wed, 2 Jan 2002 00:41:49 -0500
Date: Tue, 01 Jan 2002 21:40:03 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: highmem and usb [was:
 "sr: unaligned transfer" in 2.5.2-pre1]
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        Greg KH <greg@kroah.com>
Message-id: <06df01c1934f$ee4e68a0$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain> <20011223112249.B4493@kroah.com>
 <m23d1trr4w.fsf@pengo.localdomain> <20011230122756.L1821@suse.de>
 <20011230212700.B652@one-eyed-alien.net> <20011231125157.D1246@suse.de>
 <20011231145455.C6465@one-eyed-alien.net>
 <065e01c192fd$fe066e20$6800000a@brownell.org> <20020101233423.I16092@suse.de>
 <20020101152859.D14915@one-eyed-alien.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Not that I've seen a writeup about highmem (linux/Documentation
> > > doesn't seem to have one anyway) but if I infer correctly from that
> > > DMA-mapping.txt writeup, URBs don't support it because there's no way
> > > to specify buffers as a "struct page *" or an array of "struct
> > > scatterlist".  That's the only way that document identifies to access
> > > "highmem memory".
>
> This sounds like another good reason to have URBs take scatterlists
> directly, oddly enough. :)

If it's got to be done, I'd much rather it were "page + offset", so that the
usbcore code can be simpler.  We know how to turn scatterlists into
bulk queued requests, so there's no need for anything more ... :)


> > No, you can always ask to get pages low mem bounced. Highmem is no
> > requirement, and if your device really can't support it there's no point
> > in attempting to support it.
>
> I presume there is some overhead in bouncing to lowmem?  I imagine that
> highmem support for the HCDs wouldn't be that difficult -- they are just
> PCI devices, after all.

I'm unclear on what "bouncing to lowmem" involves, but I'd rather avoid
teaching all three HCDs a second model for addressing transfer buffers.

At least until later in the 2.5 series, when we believe they'll share a lot
more common code and so that new model can be taught to just ONE
piece of code.  Fixing bugs in one place easier than in three!


> I'd rather eliminate as much overhead as possible -- I already get
> complaints from performance fanatics about the inability of usb-storage to
> get past 92% bus saturation (sustained), and the problem will only get
> worse on USB 2.0

Well then you'll  be glad to see a patch from me, soonish, that teaches
the usb-storage "transport" code to use bulk queueing.  That'll get the
bandwidth utilization up as high as it can get.  It won't address any of
these highmem issues though.

- Dave



