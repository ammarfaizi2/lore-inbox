Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbTH1Pcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 11:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264053AbTH1Pcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 11:32:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:55512 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264052AbTH1Pck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 11:32:40 -0400
Date: Thu, 28 Aug 2003 08:38:36 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Russell King <rmk@arm.linux.org.uk>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Platform Devices
In-Reply-To: <20030825172737.E16790@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308280813130.4140-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry it's taken so long to reply, this has needed a chance to sink in 
(and for other things to be resolved). 

> I think we need to expand the platform device support to include the
> notion of platform drivers.  For example:
> 
> 	struct platform_driver {
> 		int (*probe)(struct platform_device *);
> 		int (*remove)(struct platform_device *);
> 		int (*suspend)(struct platform_device *, u32);
> 		int (*resume)(struct platform_device *);
> 		struct device_driver drv;
> 	};

I see two ways of supporting platform devices that will have a variable 
number of logical interfaces -- depending on the platform -- per physical 
device, and support power management on them. 

The first: put power management methods in struct class. 

As we suspend each physical device, we would loop over each class device 
that is associated with the physical device, and call its class's 
->suspend() method for it. The class would be responsible for stopping the 
device and taking that view of the device offline. The class-specific 
portion of the driver may optionally have suspend()/resume() methods that 
the class could call to save those bits of device state. 

This would leave the bus-specific power management calls to only power 
down the device and save config-space-like register state of the device.
(Especially if there were per-driver class-specific suspend/resume 
methods, as they would be responsible for saving/restoring the interesting 
parts of the device.)


The second: Allow mulitple drivers to bind to platform devices. 

We would use a similar structure as you have above, with a struct
list_head in it to allow us to chain them together. When we suspended a
platform device, the platform bus would iterate through each driver that's
bound to a device and call ->suspend(). 

Simple enough, though we'd have to create some sort of notion of a 
'platform_class' for each device type, as there could theoretically be 
multiple instances of a device type, and a chain of drivers could only 
bind to one without dynamically allocating each instance of the driver. It 
would be similar to the way system devices are handled, but without 
breaking away from the unified device hierarchy. 

Either way is relatively easy to implement, and I'm ambivalent about which 
to choose this morning. The former may have much added benefit by reducing 
the amount of work that needs to be done in each driver of each type, 
while the latter focuses on just resolving your issue.. 


	Pat


