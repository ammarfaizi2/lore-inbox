Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262542AbTCMVAE>; Thu, 13 Mar 2003 16:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262543AbTCMVAE>; Thu, 13 Mar 2003 16:00:04 -0500
Received: from medelec.uia.ac.be ([143.169.17.1]:24842 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S262542AbTCMVAB>;
	Thu, 13 Mar 2003 16:00:01 -0500
Date: Thu, 13 Mar 2003 23:24:37 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Watchdog-Drivers
Message-ID: <20030313232437.A24873@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1046796116.1351.4.camel@vmhack>; from rusty@linux.co.intel.com on Tue, Mar 04, 2003 at 08:41:55AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

sorry for the late response

> Ok, I started looking through your patch and realized that we took some 
> rather different approaches to isolating common watchdog code.  I have
> comments on code specifics, but I think it is more important to call out 
> the big picture differences between our two patches.  
> 
> (Let me know if I missed some stuff, or misinterpreted your code.)
> 
> big picture differences:
> ------------------------
> 
> * Your code only allows one watchdog_driver device to be registered at a time,
>   while mine will allow multiple drivers to be registered, but only one
>   of those devices will be exposed via the legacy /dev/watchdog interface.
> 
> It seems like the single watchdog device limitation is artificial once
> the kernel is able move away from the existing legacy interface. I rather
> like the idea of enabling user space to see multiple watchdog devices.

I was only working on the legacy /dev/watchdog interface before I saw your sysfs patch.
I personnaly think we should go for multiple watchdog_driver devices on the same system.
(Reason why: suppose you have a multi-processor system where each processor-board would have it's own CPU it's own external cache and it's own watchdog, in this case you would need multiple watchdog devices on the same system).
So I'm just like you in favour of having more then 1 watchdog driver running on the same system.
But like you said: the current interface (/dev/watchdog) doesn't support this.
So we have two options here: 
1) Abandon the current /dev/watchdog interface and go for a new way of using watchdogs 
or 2) change the legacy /dev/watchdog device so that it would handle multiple watchdog's. 
Anyone any suggestions on this?

> For example I have a bladed architecture that can expose multiple watchdog 
> devices over a common management bus where each watchdog is implemented in a 
> micro controller that can do thing like send snmp traps on separate networks
> regardless of the heath of the cpu blade. Each watchdog could be triggering 
> separate actions external to the view of cpu blade that is running the watchdog
> deamon.
> 
> * Your code removes the temperature related function callbacks from 
>   the watchdog_driver, and instead creates a new driver type called
>   temperature_driver that follows a consistent usage model to watchdog_driver.
> 
> I like the idea of creating a temperature_driver since any piece of hardware
> could expose a temperature sensor.  
> 
> Although I think if we are going to bother exposing a legacy interface for 
> watchdog devices then we need to expose the entire interface, i.e. watchdogs 
> should still support the temperature related ioctl calls.  This could be done
> by adding a 'struct temperature_driver *' to watchdog_driver, and then
> let the miscdevice logic for watchdog drivers call on the temperature_ops
> from that pointer (if it is not null.)

We seem to have the same idea's here. And you're absolutely wright: The watchdog driver needs to be able to handle things like TEMP-PANIC's which in functionality is and stays a part of the watchdog logic. I like the idea of having a 'struct temperature_driver *' into the watchdog driver. But I think we need to solve first how we can handle multiple watchdog drivers in an efficient way. If that's clear: the temperature device will just follow :-)

> * Your code moves more watchdog logic into the common code. 
> 
> There are a couple of places where logic has been pushed to the common code 
> that I'm not so sure I would like in the common code.  For example I kind of 
> like the notion of letting the actual device driver decide when it is 
> appropriate to force the 'nowayout' functionality.

I know what you mean. For me I had the problem with both nowayout and the timeout value.
If we go for multiple watchdog's then these 2 variables should be somewhere in the watchdog_Âdrver struct's. If only one is possible then they can be in the common code.
I don't know what other's think about this.

> I like increasing code reuse, but don't really care for forcing too restrictive
> of a programming model for watchdog device drivers.  Maybe others have some
> opinions on where the line should be drawn.
> 
> A coule of  comments on the code:
> ---------------------------------
> 
> * Everything compiles, but attempting to load the softdog (the only driver
> I tried) will cause the kernel to oops.  The problem is you are not 
> initializing the embedded device_driver struct in your watchdog_driver
> with enough information.

No, I know. I quickly changed the generic drivers and not the modules to include the sysfs part and start the discussion on how to proceed first. 
> 
> So changing:
> 
> static struct watchdog_driver softdog_watchdog_driver = {
> 	.info =		&softdog_info,
> 	.ops =		&softdog_ops,
> };
> 
> to be:
> 
> static struct watchdog_driver softdog_watchdog_driver = {
> 	.info =		&softdog_info,
> 	.ops =		&softdog_ops,
> 	.driver = {
> 		.name		= "softdog",
> 		.bus		= &system_bus_type,
> 		.devclass       = &watchdog_devclass,
> 	}
> 
> };
> 
> will get you in the game.
> 
> * Instead of having two mechanisms for exposing functionality up to the
> common code (ie. the old watchdog_info and the new watchdog_ops), I would
> rather simplify the device drivers to only expose watchdog_ops, but add
> enough functionality in watchdog_ops for the common code to send
> watchdog_info to the user using the legacy interface.

I think different approaches are possible here. I'm not sure which one is the best yet.

> * I would rather see the watchdog_ops function pointers return success/failure
> so the common code can at least translate a failure into EFAIL or something.
> The common code has no way of knowing if the driver had a problem trying to
> talk to the hardware.
> 
> * If you are touching all the drivers anyway, why not move the code to the 
> new module_param() functions and then loose the #ifdefine MODULE code
> that parses the command line args?

ok, will be done.

> * Your softdog.c inherited a bug from my first patch where casually looking
> at the current timeout value will cause the watchdog to start ticking.  If
> you do not happen to have a watchdog deamon running then the watchdog will
> sneak a machine_restart on you.

Greetings,
Wim.

