Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760663AbWLFOiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760663AbWLFOiv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 09:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760660AbWLFOiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 09:38:51 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:54888 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760667AbWLFOiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 09:38:50 -0500
Subject: Re: [PATCH] usb/hid: The HID Simple Driver Interface 0.4.1 (core)
From: Marcel Holtmann <marcel@holtmann.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Li Yu <raise.sail@gmail.com>,
       Greg Kroah Hartman <greg@kroah.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Vincent Legoll <vincentlegoll@gmail.com>,
       "Zephaniah E. Hull" <warp@aehallh.com>, liyu <liyu@ccoss.com.cn>
In-Reply-To: <d120d5000612060624o15f608dk83f35a228b9a6d18@mail.gmail.com>
References: <200612061803324532133@gmail.com>
	 <Pine.LNX.4.64.0612061114560.28502@twin.jikos.cz>
	 <d120d5000612060624o15f608dk83f35a228b9a6d18@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 15:38:43 +0100
Message-Id: <1165415924.2756.63.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> > >       1. Make hidinput_disconnect_core() be more robust, it can not
> > >          break anything even failed to allocate device struct.
> > >       2. Thanks new input device driver API, we need not the extra code
> > >          for support force-feed device yet, so say bye to
> > >          CONFIG_HID_SIMPLE_FF.
> > > Is this ready to merge? or What still is problem in them? Thanks.
> >
> > Hi,
> >
> > actually, I have prepared patches to split the USBHID code in two parts -
> > generic HID, which could be hooked by transport-specific HID layers (USB,
> > Bluetooth).
> >
> > I did not send them to lkml/linux-usb, as they are quite big (mainly
> > because a lot of code is being moved around). I am currently trying to
> > setup a git repository on kernel.org, hopefully kernel.org people will
> > react, so that the patches could be easily put into git repository and be
> > available for rewiew and easy merge. After that, they are planned to be
> > merged either into Greg's or Andrew's tree. I can send them to you if you
> > want.
> >
> > Do you think that you could wait a little bit more, after the split has
> > been done? (it's currently planned approximately after 2.6.20-rc1). It
> > seems to me that your patches will apply almost cleanly on top of the
> > split patches (you will have to change the pathnames, of course).
> >
> 
> I still have the same objection - the "simple'" code will have to be
> compiled into the driver instead of being a separate module and
> eventyally will lead to a monster-size HID module. We have this issue
> with psmouse to a degree but with HID the growth potential is much
> bigger IMO.
> 
> Jiri, I have not looked at your patches yet (I need to do that) but
> what I was hoping to do (or have someone to do ;) ) is to provide
> ability to define HID transport drivers (we would have USB transport
> and bluetooth transport) and then say:
> 
>   device = hid_create_device(&my_transport);
>   device->event = my_event_handler;
>   ....
>   hid_start_device(device);
> 
> hid-create_device would parse all reports and create "standard" hid
> device. Then you have a chance to override and tweak it as you see
> fit.

I actually prefer that we go the way hid_{register|unregister}_device
and have a hid_alloc_device(descriptor) to actually create the new HID
device and allocate its descriptor tables.

The transport actually doesn't care on how you interpret or tweak the
events. This is not its job. It is a simple plain stupid transport.
Every additional driver that you put on top of the HID parser will look
at the VID/PID and then decide which input event to send or what to do.
So from my understanding the generic one should work just fine, but in
case we need some special handling you can load an extra driver to
handle this. And this could be done as HID driver. One driver could be
the new hidraw driver to allow raw access to the HID reports.

> This way we could have several small drivers implementing quirks to
> the generic HID driver. Most of the code is still in hid core module
> but every individual driver is complete USB (or bluetooth) driver, has
> its own device table and is loaded via standard driver code bust
> matching/hotplug modalias mechanism.

Again. The driver doesn't have to know if it is Bluetooth or USB that
the reports are send over. For example a company can make the same
keyboard and one version is using Bluetooth and the other USB. You don't
wanna have two different drivers for it. You only need one driver that
knows how to speak HID.

> Btw, I saw you moving it into drivers/hid, would not
> drivers/input/hid/ suit better?

This would stick HID to the input subsystem and from my understanding
the HID parser can even work without input. The input subsystem is only
one user of it. In case of hidraw access you don't need the input
subsystem at all.

Regards

Marcel


