Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264721AbSJOQ0k>; Tue, 15 Oct 2002 12:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264723AbSJOQ0j>; Tue, 15 Oct 2002 12:26:39 -0400
Received: from air-2.osdl.org ([65.172.181.6]:32667 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S264721AbSJOQ0i>;
	Tue, 15 Oct 2002 12:26:38 -0400
Date: Tue, 15 Oct 2002 09:35:07 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: ebiederm@xmission.com, <eblade@blackmagik.dynup.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend
 devices
In-Reply-To: <200210132214.PAA00953@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0210150928340.1038-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	device_shutdown and device_suspend are for power management.
> It is important to turn the device off as soon as possible if a power
> management routine has told you that the device is not going to be
> used any more.

device_suspend() is for power management. device_shutdown() is for 
quiescing devices before a system reboot or power off. 

It's true that the same function is called when the device is physically 
removed from the system as when the system is shutting down, and that 
might be kinda bad. If it gets to the point where it's really difficult to 
deal with for drivers, we can create another callback: ->shutdown() for 
struct device_driver. 

> 	If you've identified a bunch of devices that need
> reboot_notifier, please list them so we can fix them rather than
> taxing the users with unnecessarily slow reboots or poor battery life
> (due to device not being shut down when they are no longer being used).

No, reboot notifiers are the completely wrong way to go, for one reason 
alone: ordering. device_shutdown() does a depth-first walk of the tree to 
shut down children devices before ancestors. You cannot guarantee that 
with reboot notifiers. 

Please don't try and convolute the code because you're worried about a few
microseconds. It's about correctness first; then we can worry about
micro-optimizing the hell out of it.

	-pat

