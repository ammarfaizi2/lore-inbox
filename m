Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWJ2Ulb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWJ2Ulb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWJ2Ulb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:41:31 -0500
Received: from [61.49.148.168] ([61.49.148.168]:60041 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id S1030190AbWJ2Ula (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:41:30 -0500
Date: Mon, 30 Oct 2006 04:38:50 +0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200610292038.k9TKcok4018316@freya.yggdrasil.com>
To: torvalds@osdl.org
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
Cc: akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       matthew@wil.cx, pavel@ucw.cz, shemminger@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-10-28 23:55:42, Linus Torvalds wrote:
>On Sun, 29 Oct 2006, Adam J. Richter wrote:
>> 
>>       If only calls to execute_in_parallel nest, your original
>> implementation would always deadlock when the nesting depth exceeds
>> the allowed number of threads, and [...]
>
>No, I'm saying that nesting simply shouldn't be _done_. There's no real 
>reason. Any user would be already either parallel or doesn't need to be 
>parallel at all. Why would something that already _is_ parallel start 
>another parallel task?

	Suppose the system is initializing PCI cards in parallel.  The
thread that is initializing one particular PCI card discovers that it
is initializing a firewire controller.  After the already "parallel"
PCI firewire probe function initializes the card, it is going to
enumerate the devices attached to the firewire cable and spawn
separate threads to initialize drivers for each of these several
firewire devices.

	One way avoid this depth-first descent would be to change
device_attach() in drivers/base/dd.c to queue its work to helper daemon.

	Either way, we're talking about a few lines of code in
execute_in_parallel that can easily be added later if needed.  If you
really think all calls to execute_parallel will be done by the main
kernel thread, I suggest someone add a BUG_ON() statement to that
effect to execute_parallel to see.

	I would also like to suggest a very different approach, which
would not be quite as fast, but which I think would be more flexible
and would work partly by making the kernel do _less_.

	Perhaps we could offer a boot option to limit device_attach to
consider only drivers named by that option, such as
"limit_drivers=vc,ramdisk".  (If a user screwed his boot process with
the wrong limit_drivers= options, fixing the problem would be just a
matter of just eliminating the option.)  All other driver-device
bindings would be done explicitly by a user level mechanism, which
would implicitly provide the process context for blocking.  That is,
the parallelization would occur by a sysfs watcher like udev spawning
separate threads to call the user level sysfs interface for attaching
devices to drivers.  User level would also handle matching driver and
device ID information, determining parallelization limits, probe
order, choosing between multiple drivers available for devices or
deliberately not binding a driver to a device, and perhaps executing
other custom user level code along the way.

	Because the threads involved would come from clone() executed
by a user level daemon sysfs watcher like udev, execute_in_parallel()
would be less used, perhaps not used at all, depending on whether
parts the boot process besides walking the device tree would benefit
much from parallelization.

Adam Richter
