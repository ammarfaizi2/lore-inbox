Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264735AbUEFBIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264735AbUEFBIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 21:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264741AbUEFBIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 21:08:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35065 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264735AbUEFBIo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 21:08:44 -0400
Message-ID: <40999017.4090603@mvista.com>
Date: Wed, 05 May 2004 18:08:39 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@digitalimplant.org>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hotplug for device power state changes
References: <20040429202654.GA9971@dhcp193.mvista.com> <Pine.LNX.4.50.0405040819490.3562-100000@monsoon.he.net> <4097FED8.3020003@mvista.com> <Pine.LNX.4.50.0405042110440.30304-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0405042110440.30304-100000@monsoon.he.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
>>The ability to do this was originally requested in the context of a
>>driver managing the power state of its devices (according to some
>>unspecified logic); agreed that state changes requested via sysfs are a
>>less compelling usage scenario.  Small battery-powered gadgets often
>>implement drivers that are more actively involved in managing power
>>state than the desktop/notebook/server norm, invoking LDM suspend
>>routines when an opportunity to power down arises.  But it is also
>>common in wall-plug-wired systems to have a few power state transitions
>>that result from things under kernel control, such as blanking a display
>>device after a timer expires.
> 
> 
> It seems like it would best be done at the class level, rather than the
> core driver level, if you wanted to do it all. For things like
> communication devices going out of range, you would probably want to
> easily support multiple drivers of the same type, so you might as well
> abstract it to the class. And, I don't see a reason for it to be
> synchronous, since any apps trying to communicate over it will soon
> realize it's not available; and any policy in userspace shouldn't by
> definition be that critical to the health of the system.
> 
> Display blanking is based on user input inactivity, and already works on
> most systems.

Although there are a number of ways this information could be used, the
specific use I intended is for system power management purposes.  I wouldn't
suggest implementing features such as screen blanking (which was brought up
as an example of a device power state transition that occurs according to kernel
logic and not at the request of an app) or notifying network applications of
downed links using this mechanism.  

Let me throw out an example to help discuss the model best suits that situation.
An XScale PXA27x "Bulverde", a smartphone platform, has a low-power mode that
helps conserve battery power during periods of reduced activity while leaving
the CPU running at a low clock rate (and often idling) to handle any events
that occur during that time.  In that mode, certain devices must be powered off
(apparently critical input clocks are turned off and the device may get wedged
and cease to function).  Among these devices are the LCD controller and serial
devices such as IrDA and Bluetooth.  If a system power management mechanism such
as cpufreq is employed to place the system into low-power mode during idle
periods, some coordination between device state and entering/exiting low-power
state is needed.

Various interactions to accomplish this coordination are possible.  For the
patch under discussion it is suggested that an appropriate mechanism by which
the power management control app may be informed of changes in device state
would be for the LCD and serial drivers to notify the app about changes in the
state of their devices at exactly the time the state transition is to occur (and
that hotplug is an appropriate method to use for this).  The notification
might be used by the power management app to take the system out of low-power
mode prior to powering up the device, or to note that low-power mode may be
entered now that all conflicting devices are off.  So in this case an app not
using the device for I/O purposes could still benefit from information about
its state.

A similar request was made by another smartphone development team to handle a
dual-core CPU + DSP ARM OMAP system, where changes in DSP or network activity
(i.e., a call or other communication is starting or stopping) are to trigger
changes in system power state.  In this case, the affected devices might not be
all-the-way powered off, but in an intermediate lower-power state.

Now it may be the case that application-level state could be used to manage
these interactions; I have very limited knowledge of what happens above the
kernel (and the device usage models) in the example systems I'm discussing.
Placing the ability to notify of power state changes into the drivers would
seem to be the model that offers the most flexibility, which is probably why
it was originally requested and why I thought it might be appropriate.  If
there continue to be strong reservations regarding the suitability of
kernel-to-userspace device power state notifiers then I'll encourage the
developers to either add their voices directly to the debate or to explore
solutions using existing kernel interfaces and/or pure userspace methods.


-- 
Todd Poynor
MontaVista Software

