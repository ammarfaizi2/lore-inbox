Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933568AbWLFPG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933568AbWLFPG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933336AbWLFPGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:06:55 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:54937 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933568AbWLFPGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:06:55 -0500
Subject: Re: [PATCH] usb/hid: The HID Simple Driver Interface 0.4.1 (core)
From: Marcel Holtmann <marcel@holtmann.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Li Yu <raise.sail@gmail.com>,
       Greg Kroah Hartman <greg@kroah.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Vincent Legoll <vincentlegoll@gmail.com>,
       "Zephaniah E. Hull" <warp@aehallh.com>, liyu <liyu@ccoss.com.cn>
In-Reply-To: <d120d5000612060656o6c0690ffj50ba79bc8bcd028d@mail.gmail.com>
References: <200612061803324532133@gmail.com>
	 <Pine.LNX.4.64.0612061114560.28502@twin.jikos.cz>
	 <d120d5000612060624o15f608dk83f35a228b9a6d18@mail.gmail.com>
	 <1165415924.2756.63.camel@localhost>
	 <d120d5000612060656o6c0690ffj50ba79bc8bcd028d@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 16:07:12 +0100
Message-Id: <1165417632.2756.71.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> > > I still have the same objection - the "simple'" code will have to be
> > > compiled into the driver instead of being a separate module and
> > > eventyally will lead to a monster-size HID module. We have this issue
> > > with psmouse to a degree but with HID the growth potential is much
> > > bigger IMO.
> > >
> > > Jiri, I have not looked at your patches yet (I need to do that) but
> > > what I was hoping to do (or have someone to do ;) ) is to provide
> > > ability to define HID transport drivers (we would have USB transport
> > > and bluetooth transport) and then say:
> > >
> > >   device = hid_create_device(&my_transport);
> > >   device->event = my_event_handler;
> > >   ....
> > >   hid_start_device(device);
> > >
> > > hid-create_device would parse all reports and create "standard" hid
> > > device. Then you have a chance to override and tweak it as you see
> > > fit.
> >
> > I actually prefer that we go the way hid_{register|unregister}_device
> > and have a hid_alloc_device(descriptor) to actually create the new HID
> > device and allocate its descriptor tables.
> >
> > The transport actually doesn't care on how you interpret or tweak the
> > events. This is not its job. It is a simple plain stupid transport.
> > Every additional driver that you put on top of the HID parser will look
> > at the VID/PID and then decide which input event to send or what to do.
> > So from my understanding the generic one should work just fine, but in
> > case we need some special handling you can load an extra driver to
> > handle this. And this could be done as HID driver. One driver could be
> > the new hidraw driver to allow raw access to the HID reports.
> 
> Well, it seems we have 2 different kinds of HID drivers. Hidraw is an
> alternate interface driver - it provides different interface to HID
> device and therefore can be implemented as "extra" driver. Li Yu's
> "simple" drivers extend existing input interfaces. I do not think
> you'd want to have /dev/input/event0 implementing partially incorrect
> keyboard support (for a particular keyboard) and /dev/input/event1
> (the one cretaed by a simple drver if impleented as extra interface)
> implementing better support.

I think for every HID report id, you should be able to attach a special
driver that handles the reports of this id.

> > > This way we could have several small drivers implementing quirks to
> > > the generic HID driver. Most of the code is still in hid core module
> > > but every individual driver is complete USB (or bluetooth) driver, has
> > > its own device table and is loaded via standard driver code bust
> > > matching/hotplug modalias mechanism.
> >
> > Again. The driver doesn't have to know if it is Bluetooth or USB that
> > the reports are send over. For example a company can make the same
> > keyboard and one version is using Bluetooth and the other USB. You don't
> > wanna have two different drivers for it. You only need one driver that
> > knows how to speak HID.
> >
> 
> But you need to know when to attach your driver. How would pure HID
> driver know that? USB driver can do that via manufacturer/product IDs.
> And we have all that infrastructure of loading proper modules. Or do
> you want to create a hid bus?

Actually creating a HID bus is not a bad idea. And even Bluetooth
provides the VID/PID values for every device. So the transports only
have to give these to the HID parser. Then every driver on top of the
common HID layer can do whatever they think is best and they don't have
to care about the actual transport. Actually the report descriptor is a
good example which both (USB and Bluetooth) have in common, but they are
retrieved totally different. The driver on-top of HID doesn't need to
have to deal with that.

However separating out the transports and creating a common HID layer
should be done sooner than later. Once we have done that, we can talk
about the HID simple driver or device specific drivers on top of the
common HID layer.

Regards

Marcel


