Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUFAUJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUFAUJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 16:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbUFAUJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 16:09:53 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:29686 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265196AbUFAUJu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 16:09:50 -0400
Message-ID: <40BCE28A.1050601@mvista.com>
Date: Tue, 01 Jun 2004 13:09:46 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Zabolotny <zap@homelink.ru>
CC: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: two patches - request for comments
References: <20040529012030.795ad27e.zap@homelink.ru>	<40B7B659.9010507@mvista.com> <20040529121059.3789c355.zap@homelink.ru>
In-Reply-To: <20040529121059.3789c355.zap@homelink.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Zabolotny wrote:
> On Fri, 28 May 2004 14:59:53 -0700
> Todd Poynor <tpoynor@mvista.com> wrote:
> 
> 
>>Hi, you're adding new interfaces for power management of LCD and 
>>backlight devices.  Since there's already LDM/sysfs interfaces for 
>>reading and writing power state of generic devices, is it necessary to 
>>add ones particular to these devices or device classes?  In other words, 
>>is /sys/devices/<bus>/<device>/power/state not suitable for these purposes?
> 
> Well, first liquid crystal displays and backlight are not connected to any
> specific bus. They could, on some platforms, and could not on other. For
> example, on some PDAs backlight is controlled via the programmed I/O CPU pins
> (GPIO), on other they are connected to some weird companion chips, on third
> they could be controlled via the PCI bus (on large PCs, I mean) and so on. So
> there will be no easy way for an application to find the backlight devices
> and control them. In our case that's easy: opendir ("/sys/class/backlight")
> and you found all of them.

I'm not questioning the usefulness of the other aspects of the patch, 
such as adding an LCD/backlight class for framebuffer access and adding 
attributes for the unique features of LCD/backlight devices.  My 
questions are specific to the power management interfaces, since there's 
already interfaces for this, with different semantics than the new class 
interfaces, and there's some value in sticking with a single consistent 
interface for it.

If I understand correctly, the LCD device is registered on a bus (either 
a platform-specific bus or the generic "platform" bus), and the device 
therefore already has a power/state attribute; the class entry could 
refer back to that device if needed.  So I'm interested in discussing 
whether the existing PM interface suffices for LCD/backlight devices, or 
if not, should the existing interfaces be improved (rather than working 
around deficiencies via device-specific interfaces)?

 > [...]
> On the third hand (:-) the lcd device class, for example, actually has *two*
> power switches: the 'power' and the 'enable' attribute. The first powers off
> the liquid crystal display, and seconds powers off the lcd controller. These
> are different things and it would be wise to leave them apart, as having finer
> grained control is always better. [...]

But it also sounds like the single LDM registration for an LCD device 
could be better handled by registering the LCD display, LCD controller, 
and backlight as separate devices (which they probably are), allowing 
individual control through the standard interfaces.

>>And if a PM interface for device classes is needed that ties into the 
>>device driver suspend/resume callbacks, perhaps it can be modeled more 
>>closely on the existing interfaces?  These new interfaces seem to be 
>>intended to define: 0 == power off, 1 ==  power on.  The existing 
>>ACPI-inspired interfaces use: 0 == power on/full-power, 1/2/3/4 == 
>>low-power/off state.
> 
> Um, well, this could be implemented. Although I don't see much reason for a
> backlight to be in a "semi-enabled state"; besides if it will remain a
> separate class device, it doesn't matter much. 

The main problem is that existing interfaces write zero for on and 
non-zero for off, while the new interface reverses things.  I realize 
that multiple power states are not implemented by all devices; if 
there's interest in tailoring device states to more closely match the 
hardware capabilities of non-ACPI systems then I'd be happy to talk more 
about that.

So none of my objections are terribly crucial, and if Greg et al don't 
have a problem with device-class-specific PM interfaces that have 
different semantics and/or capabilities than those of the device 
power/state attributes then I don't have much of a problem with it 
either.  Just seems worthwhile to check whether there's improvements 
needed in the existing PM interfaces instead.


-- 
Todd
