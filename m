Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTDPW2Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 18:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTDPW2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 18:28:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:32141 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261757AbTDPW2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 18:28:14 -0400
Date: Wed, 16 Apr 2003 15:40:13 -0700
From: Dave Olien <dmo@osdl.org>
To: John v/d Kamp <john@connectux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DAC960_Release bug (2.4.x)
Message-ID: <20030416224013.GA11514@osdl.org>
References: <Pine.LNX.4.53.0304161136270.18523@fratser>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0304161136270.18523@fratser>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As you observed, ControllerUsageCount doesn't seem to serve
any purpose.  It should just be removed, I think.

I'm curious, what application you have that calls DAC960_Open() with NONBLOCK.

Here's my interpretation of what the drivers' trying to do here.
If you can validate these assumptions, I'd appreciate it.

For the DAC960, it looks like the NONBLOCK flag is just a trick
to allow a user-level DAC960 RAID manager utility to open the driver
without actually interacting with any disk devices on the controller.
The file descriptor you get back is not really associated with a specific
device or controller.

The DAC960_IOCTL function calls DAC960_UserIOCTL only when the
NONBLOCK flag is set.  DAC960_UserIOCTL is designed to operate on
the controller specified by a controller number argument, rather than
a controller associated with its file descriptor argument.

This lets the RAID manager utility operate on any controller at a time
when perhaps there are NO logical devices ONLINE (i.e. you would
be normally UNABLE to get ANY file descriptor for that controller).

The ModuleOnly label in DAC960_open() apparently is meant to indicate
we're opening "the DAC960 module" rather than a specific device.

The problem is, the test for opening this file descriptor is iffy:
	"If the file descriptor is for controller 0, logical device
	0, and NONBLOCK is set, then return this `special` file descriptor."

It's perfectly reasonable for an application to actually want to open
REAL devices this way.  Instead, it gets this peculiar file descriptor.

The problem is there are DAC960 utilities out there that I'm sure rely
on this behavior.  So, it'll be hard to fix "the right way".


On Wed, Apr 16, 2003 at 11:55:51AM +0200, John v/d Kamp wrote:
> Hi,
> 
> It seems the DAC960_Release function doesn't work correctly when
> DAC960_Open is called with File->f_flags has O_NONBLOCK set. This causes
> BLKRRPART to fail, as an unsigned int gets decreased below 0.
> The File struct passed to DAC960_Release is NULL, so in Open the counters
> aren't increased, but in Release they are decreased. I've added a simple
> check that prevents the decrements if the counters are 0.
> 
> Allso, I've no idea why there are two counters. It seems that the
> ControllerUsageCount is only used to increment and decrement.
> 
> --
> John van der Kamp, ConnecTUX
> diff -ur linux-2.4.19/drivers/block/DAC960.c patched-2.4.19/drivers/block/DAC960.c
> --- linux-2.4.19/drivers/block/DAC960.c	2002-09-13 17:41:30.000000000 +0200
> +++ patched-2.4.19/drivers/block/DAC960.c	2003-04-16 11:07:16.000000000 +0200
> @@ -5398,8 +5398,10 @@
>    /*
>      Decrement the Logical Drive and Controller Usage Counts.
>    */
> -  Controller->LogicalDriveUsageCount[LogicalDriveNumber]--;
> -  Controller->ControllerUsageCount--;
> +  if (Controller->LogicalDriveUsageCount[LogicalDriveNumber] > 0)
> +    Controller->LogicalDriveUsageCount[LogicalDriveNumber]--;
> +  if (Controller->ControllerUsageCount > 0)
> +    Controller->ControllerUsageCount--;
>    return 0;
>  }

