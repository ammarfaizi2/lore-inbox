Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161013AbVIPBEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbVIPBEl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 21:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbVIPBEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 21:04:40 -0400
Received: from soundwarez.org ([217.160.171.123]:15849 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1161013AbVIPBEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 21:04:39 -0400
Date: Fri, 16 Sep 2005 03:04:38 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <gregkh@suse.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Message-ID: <20050916010438.GA12759@vrfy.org>
References: <20050916002036.GA6149@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916002036.GA6149@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 05:20:37PM -0700, Greg KH wrote:
> The problem:  We need a way to show complex class and class device
> structures properly in sysfs.  Examples of these "complex" views are the
> input layer's use of different input drivers for devices (usually the
> same device), the video subsystem view of frame buffer devices and
> monitors, and even the block layer with it's disks and partitions.
> 
> Proposed solutions in the past have been either add the ability to nest
> classes themselves (as shown in Dmitry's recent proposal for fixing the
> input layer), or add the ability to nest class_device structures (I
> think others have tried to do this in the past, sorry for not
> remembering the specifics.)  Both of these proposals don't really solve
> the real problem, that of the fact that we need to come up with a
> solution that all of the different subsystems can use properly.
> 
> So, here's my take on it.  Feel free to tell me what I messed up :)
> 
> I would like to add something called "subclasses" for lack of a better
> term.  These subclasses would have both drivers, and devices associated
> with them.  This would show up as the following tree of directories:
> 
> 	/sys/class/input/
> 	|-- input0
> 	|   |-- event0
> 	|   `-- mouse0
> 	|-- input1
> 	|   |-- event1
> 	|   `-- ts0
> 	|-- mice
> 	`-- drivers
> 	    |-- event
> 	    |-- mouse
> 	    `-- ts

I like that the child devices are actually below the parent device
and represent the logical structure. I prefer that compared to the
symlink-representation between the classes at the same directory
level which the input patches propose.

> Here we have 3 struct class_devices like today, input0, input1, and
> mice.  We also have struct subclass_drivers of event, mouse, and ts.
> These will create the struct subclass_devices event0, mouse0, event1,
> and ts0.  The "dev" node files will show up in the directories mice,
> event0, mouse0, event1, and ts0, like you would expect them too.
> 
> So, this lets us create a solution for the input subsystem, but will it
> also work for block and video?
> 
> For block, yes, I think so.  There is no requirement for a
> subclass_driver to create the subclass devices.  Any code can create and
> register with the class core a subclass device, just set up the parent
> pointer and away you go.  So, in the following instance:
> 	/sys/class/block/
> 	`-- sda
> 	    |-- sda1
> 	    |-- sda2
> 	    `-- sda3
> 
> "block" would represent the struct class.
> "sda" would represent the struct class_device.
> "sda1", "sda2", and "sda3" would represent the different subclass
> devices that are bound to the class device "sda".

How will the SUBSYSTEM (kset name) value look like for a "subclass"?
Will it have it's own value or will all class devices and subclass
devices share the same SUBSYSTEM?

What are the "subclass drivers"? Similar to the current "bus drivers"?

Will it be possible to have subclasses of subclasses? :)

Thanks,
Kay
