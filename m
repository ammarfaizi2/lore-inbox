Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVIPA64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVIPA64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 20:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVIPA64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 20:58:56 -0400
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:3207 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932274AbVIPA6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 20:58:55 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Date: Thu, 15 Sep 2005 19:58:44 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
References: <20050916002036.GA6149@suse.de>
In-Reply-To: <20050916002036.GA6149@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509151958.45573.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 September 2005 19:20, Greg KH wrote:
> Ok, first off, I hate talking about architecture changes without showing
> the code for what I am talking about first, but as this is an issue that
> needs to be agreed upon by a wide range of developers, I'll just write
> up what I am thinking about doing before actually doing it...
> 
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
> 
> Here we have 3 struct class_devices like today, input0, input1, and
> mice.  We also have struct subclass_drivers of event, mouse, and ts.
> These will create the struct subclass_devices event0, mouse0, event1,
> and ts0.  The "dev" node files will show up in the directories mice,
> event0, mouse0, event1, and ts0, like you would expect them too.
>

This proposed scheme does not answer the question: "what input interfaces
present in my system?". Input interfaces are objects in their own right
and deserve their own spot. Compare your picture with the one below:

[dtor@core ~]$ tree /sys/class/input/
/sys/class/input/
|-- devices
|   |-- input0
|   |   |-- device -> ../../../../devices/platform/i8042/serio1
|   |   `-- event0 -> ../../../../class/input/interfaces/event0
|   |-- input1
|   |   |-- device -> ../../../../devices/platform/i8042/serio0
|   |   |-- event1 -> ../../../../class/input/interfaces/event1
|   |   |-- mouse0 -> ../../../../class/input/interfaces/mouse0
|   |   `-- ts0 -> ../../../../class/input/interfaces/ts0
|   `-- input2
|       |-- device -> ../../../../devices/platform/i8042/serio0/serio2
|       |-- event2 -> ../../../../class/input/interfaces/event2
|       |-- mouse1 -> ../../../../class/input/interfaces/mouse1
|       `-- ts1 -> ../../../../class/input/interfaces/ts1
`-- interfaces
    |-- event0
    |   |-- dev
    |   `-- device -> ../../../../class/input/devices/input0
    |-- event1
    |   |-- dev
    |   `-- device -> ../../../../class/input/devices/input1
    |-- event2
    |   |-- dev
    |   `-- device -> ../../../../class/input/devices/input2
    |-- mice
    |   `-- dev
    |-- mouse0
    |   |-- dev
    |   `-- device -> ../../../../class/input/devices/input1
    |-- mouse1
    |   |-- dev
    |   `-- device -> ../../../../class/input/devices/input2
    |-- ts0
    |   |-- dev
    |   `-- device -> ../../../../class/input/devices/input1
    `-- ts1
        |-- dev
        `-- device -> ../../../../class/input/devices/input2

Here you have exactly the same information as in your picture plus you can
see the other class (input interfaces) as well.

The only issue is that links between those class devices are created in
input core but we can solve it. We just need to allow class devices be
children of other class devices.

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

Here is a different puzzle. Instead of adding interfaces to a device you
partition it. I don't think we need to mix those 2 tasks together.


-- 
Dmitry
