Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVARWUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVARWUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 17:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVARWUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 17:20:49 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:32594 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261447AbVARWUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 17:20:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HGbCwmB0uII2XUIxZxN+fF9PSWqLyalpjbBzhZggq30R12ZJUf+6b9PcO8wifNrsjCohS8m16sNfsE7QAPd46EDO/ZVoo0MzJHLoN4HYqHHfhvl6RUJpI+j1b3EdomBmzDfDr9DnluPVWR6rmOd4+HHQ5olXBvLF97MUHEQ3aeg=
Message-ID: <d120d500050118142068157a78@mail.gmail.com>
Date: Tue, 18 Jan 2005 17:20:40 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/2] Remove input_call_hotplug
Cc: Hannes Reinecke <hare@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pawlik <vojtech@suse.cz>
In-Reply-To: <20050118215820.GA17371@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41ED23A3.5020404@suse.de> <20050118213002.GA17004@kroah.com>
	 <d120d50005011813495b49907c@mail.gmail.com>
	 <20050118215820.GA17371@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005 13:58:20 -0800, Greg KH <greg@kroah.com> wrote:
> On Tue, Jan 18, 2005 at 04:49:34PM -0500, Dmitry Torokhov wrote:
> > On Tue, 18 Jan 2005 13:30:02 -0800, Greg KH <greg@kroah.com> wrote:
> > > On Tue, Jan 18, 2005 at 03:56:35PM +0100, Hannes Reinecke wrote:
> > > > Hi all,
> > > >
> > > > the input subsystem is using call_usermodehelper directly, which breaks
> > > > all sorts of assertions especially when using udev.
> > > > And it's definitely going to fail once someone is trying to use netlink
> > > > messages for hotplug event delivery.
> > > >
> > > > To remedy this I've implemented a new sysfs class 'input_device' which
> > > > is a representation of 'struct input_dev'. So each device listed in
> > > > '/proc/bus/input/devices' gets a class device associated with it.
> > > > And we'll get proper hotplug events for each input_device which can be
> > > > handled by udev accordingly.
> > >
> > > Hm, why another input class?  We already have /sys/class/input, which we
> > > get hotplug events for.  We also have the individual input device
> > > hotplug events, which is what I think we really want here, right?
> >
> > These are a bit different classes. One is a generic input device class
> > device. Then you have several class device interfaces (evdev,
> > mousedev, joydev, tsdev, keyboard) that together with generic input
> > device produce concrete input devices (mouse, js, ts) that you have
> > implemented with class_simple.
> 
> Hm, but we still need to make the input_dev a "real" struct device,
> right?  And if you do that, then you just hooked up your hotplug event
> properly, with no userspace breakage.

I wasn't planning on doing that. The real devices are serio ports,
gameport ports and USB devices.They require power and resource
management and so forth. input_device is just a product of binding a
port to appropriate driver and seems to me like an ideal class_device
candidate. Then you add couple of class interfaces and get another
class_device layer as a result.

> Then, if you want to still make the evdev, mousedev, and so on as
> class_device interfaces, that's fine, but the main point of this patch
> was to allow the call_usermodehelper call to be removed, so that the
> input subsytem will work properly with the kernel event and hotplug
> systems.
>

I was mostly talking about the need of 2 separate classes and this
patch lays groundwork for it althou lifetime rules in input system
need to be cleaned up before we can go all the way.

-- 
Dmitry
