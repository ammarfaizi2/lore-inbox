Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVASL4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVASL4e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 06:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVASL4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 06:56:33 -0500
Received: from cantor.suse.de ([195.135.220.2]:7604 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261698AbVASL4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 06:56:21 -0500
Message-ID: <41EE4AE0.9030308@suse.de>
Date: Wed, 19 Jan 2005 12:56:16 +0100
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: dtor_core@ameritech.net, Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pawlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/2] Remove input_call_hotplug
References: <41ED23A3.5020404@suse.de> <20050118213002.GA17004@kroah.com> <d120d50005011813495b49907c@mail.gmail.com> <20050118215820.GA17371@kroah.com> <d120d500050118142068157a78@mail.gmail.com> <20050119013133.GD23296@kroah.com>
In-Reply-To: <20050119013133.GD23296@kroah.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Jan 18, 2005 at 05:20:40PM -0500, Dmitry Torokhov wrote:
> 
>>On Tue, 18 Jan 2005 13:58:20 -0800, Greg KH <greg@kroah.com> wrote:
>>
>>>On Tue, Jan 18, 2005 at 04:49:34PM -0500, Dmitry Torokhov wrote:
>>>
>>>>On Tue, 18 Jan 2005 13:30:02 -0800, Greg KH <greg@kroah.com> wrote:
>>>>
>>>>>On Tue, Jan 18, 2005 at 03:56:35PM +0100, Hannes Reinecke wrote:
>>>>>
>>>>>>Hi all,
>>>>>>
>>>>>>the input subsystem is using call_usermodehelper directly, which breaks
>>>>>>all sorts of assertions especially when using udev.
>>>>>>And it's definitely going to fail once someone is trying to use netlink
>>>>>>messages for hotplug event delivery.
>>>>>>
>>>>>>To remedy this I've implemented a new sysfs class 'input_device' which
>>>>>>is a representation of 'struct input_dev'. So each device listed in
>>>>>>'/proc/bus/input/devices' gets a class device associated with it.
>>>>>>And we'll get proper hotplug events for each input_device which can be
>>>>>>handled by udev accordingly.
>>>>>
>>>>>Hm, why another input class?  We already have /sys/class/input, which we
>>>>>get hotplug events for.  We also have the individual input device
>>>>>hotplug events, which is what I think we really want here, right?
>>>>
>>>>These are a bit different classes. One is a generic input device class
>>>>device. Then you have several class device interfaces (evdev,
>>>>mousedev, joydev, tsdev, keyboard) that together with generic input
>>>>device produce concrete input devices (mouse, js, ts) that you have
>>>>implemented with class_simple.
>>>
>>>Hm, but we still need to make the input_dev a "real" struct device,
>>>right?  And if you do that, then you just hooked up your hotplug event
>>>properly, with no userspace breakage.
>>
>>I wasn't planning on doing that. The real devices are serio ports,
>>gameport ports and USB devices.They require power and resource
>>management and so forth. input_device is just a product of binding a
>>port to appropriate driver and seems to me like an ideal class_device
>>candidate. Then you add couple of class interfaces and get another
>>class_device layer as a result.
> 
> 
> Ah, ok, that makes sense.  That would work too, although I don't know if
> udev can handle class_interfaces with a "dev" file in it or not.  If
> not, it shouldn't be that hard to change.
> 
> 
>>>Then, if you want to still make the evdev, mousedev, and so on as
>>>class_device interfaces, that's fine, but the main point of this patch
>>>was to allow the call_usermodehelper call to be removed, so that the
>>>input subsytem will work properly with the kernel event and hotplug
>>>systems.
>>>
>>
>>I was mostly talking about the need of 2 separate classes and this
>>patch lays groundwork for it althou lifetime rules in input system
>>need to be cleaned up before we can go all the way.
> 
> 
> I agree.  But I think only 1 class is needed, that way we don't break
> userspace, which is a pretty important thing.
> 
Well, if you could show me how to do this with the class_interface thing 
I'd be happy to comply.

The input layer design is like this:
- Physical devices present one (or several) abstract input devices 
(which correspond to struct input_dev)
- Each input device can be linked to one or several input handlers
(which correspond to struct input_handle)
- Each handler is represented to userspace with a device node.

The problem with the current input layer is that each 'struct 
input_handle' is associated with a class_simple device.
This class is named 'input', so we're getting 'input' events from it.
But each instantiation of struct input_dev is also sending 'input' 
events as it is doing the call_usermodehelper call directly.

Effectively we're having _two_ different hotplug events with the same 
name, which is inconsistent in itself. I don't mind at all if we're 
breaking this.

But if we were going to implement this with device_interface, we'd be 
having a /sys/class structure like:

class
|- isa0060-serio0-input0
|  |- event0
|  |  `dev
|  |- key
|  |- ...
|- ..

So we'd be moving the 'dev' attribute one directory down, again 
incurring a userland breakage.
Plus it would be far more coding involved as the entire input layer 
structure would have to be redone.

But if the powers that be decide for the latter option, who am I to 
argue ...
Only I'd like to have this resolved quite soon as it effectively blocks 
from switching to netlink messages for hotplug events completely.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
