Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316703AbSEVToW>; Wed, 22 May 2002 15:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSEVToV>; Wed, 22 May 2002 15:44:21 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:30193 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S316703AbSEVToV>; Wed, 22 May 2002 15:44:21 -0400
Message-Id: <5.1.0.14.2.20020522115749.06b888b0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 22 May 2002 12:43:09 -0700
To: Greg KH <greg@kroah.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: What to do with all of the USB UHCI drivers in the kernel ?
Cc: Johannes Erdfelt <johannes@erdfelt.com>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20020522050640.GA646@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:06 PM 5/21/2002 -0700, Greg KH wrote:
> > On a side note. Why are URBs still not SLABified ?
> > Drivers still have those silly urb pools and stuff. I thought you guys 
> were
> > gonna fix that.
>
>It hasn't been proven that it's really needed.  95% of the current
>drivers create their urbs when the device is plugged in, and then free
>them when they are removed.  Making that kind of allocation into a slab
>is a bit silly :)
Well, I'm claiming that those drivers are wrong ;)
It makes sense to pre-allocate intr in, iso and bulk in URB. But (imo) it 
doesn't make much sense
to pre-allocate ctrl and bulk out. For example one might never send stuff 
out of USB serial port,
because it used only for logging or something, ut write_urb will always be 
allocated. Same
goes for ctrl, one sends ctrl requests only once in a while but URB is 
always allocated.

Also as Dave pointed out kmalloc is already slabified anyway. And as I 
mentioned kmalloc
has fixed size slabs and therefor will waste some memory.

>Now if more drivers start doing fun stuff like the visor.c driver does
>in the 2.5 tree, then it might make more sense to create a URB specific
>slab.
Some drivers are still maintaining bulk URB pools which is just unnecessary 
code and mem waste.
They should allocate/free bulk urbs on demand.
visor, usbnet, hci_usb and some other driver allocate URB on demand.

I guess the reason for having driver specific URB pools is because 
usb_alloc_urb (using kmalloc) was
slow. Now if it's replaced with slab cache it's no longer the case. So 
drivers should not pre-allocate
stuff unnecessary.

It definitely doesn't hurt to have URB specific cache. You get better stats 
(like URB slab utilization, etc).
You could chose to do slab poisoning and debug URB allocations and stuff. 
You could use slab constructor
to pre-initialize some URB fields.

Max

