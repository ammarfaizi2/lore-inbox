Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292359AbSBBTP0>; Sat, 2 Feb 2002 14:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292355AbSBBTPN>; Sat, 2 Feb 2002 14:15:13 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:2193 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S292358AbSBBTPB>; Sat, 2 Feb 2002 14:15:01 -0500
Date: Sat, 02 Feb 2002 11:13:26 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [PATCH] driverfs support for USB - take 2
To: Greg KH <greg@kroah.com>
Cc: Patrick Mochel <mochel@osdl.org>, Dave Jones <davej@suse.de>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <0e9101c1ac1d$b18b25c0$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <Pine.LNX.4.33.0201291711560.800-100000@segfault.osdlab.org>
 <08cf01c1a933$f45ac460$6800000a@brownell.org>
 <20020130040908.GA23261@kroah.com>
 <0a1501c1a9c9$bdf427e0$6800000a@brownell.org>
 <20020202001804.GC10313@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > And there can be a lot more such files.  Though that 4KB limit
> > may become an issue at some point.
> 
> I doubt it, we are talking one value per file here.  I can't see any USB
> driver wanting to go over 4Kb for 1 value (and if it does, I'll change
> it :)

I could see descriptors getting that large, particularly if
they're turned from binary form into text.  I seem to recall
Patrick was anticipating troubles with that 4K limit, at
some point.


> > Also, one could argue that each USB function ("interface")
> > should be presented as an individual device, just like each PCI
> > function is handled ... after all, USB drivers bind to interfaces,
> > not devices, and this is the "driver" FS!  :)
> 
> No, I'll say that we need to stay one physical device per device in the
> tree. 

But we aren't that way today.  Examples:

    - Take a multifunction PCI card ("physical device") and plug it in.
      Each function shows up as another "logical device" in the tree.
      Each such logical device gets one driver.

    - Take a composite USB device ("physical device", like a keyboard
      with hub) and plug it in.  Each logical device shows up separately.
      Each such logical device gets one driver.

The issue with USB is that it's got a much more complex configuration
model, not all of which is well supported yet in Linux.   There's a type
of device which is handled inconsistently:

    - Take a multiple-interface USB device ("physical device") and
      plug it in.  It's presented as one logical device.  BUT (!!) such
      devices need MULTIPLE drivers!!  (Example:  speaker with
      built in volume control, needs audio and HID drivers.)

I was observing that we have a chance to make things consistent.
In my experience, that's normally a good thing.  Similarly, I think USB
should handle configurations more as first class entities.  Changing
a device's config doesn't trigger driver rebinding, for example; we're
in luck, so far, that most devices don't have many configurations.


>     If you want to do an interface tree, let's put that in usbfs,
> where it belongs :)

Ah, but changing usbfs is impractical at this point since lots of
userspace programs rely on it not changing.  Which is why I
was pointing this out in the context of driverfs, which can still
be improved in such ways ... "usbdevfs" was always advertised
as "preliminary", anyway! :)

- Dave


