Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbTDQIgz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 04:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbTDQIgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 04:36:55 -0400
Received: from dsl-170-219.dsl.cambrium.nl ([213.239.170.219]:48297 "EHLO
	fratser") by vger.kernel.org with ESMTP id S261282AbTDQIgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 04:36:52 -0400
Date: Thu, 17 Apr 2003 10:48:51 +0200 (CEST)
From: John v/d Kamp <john@connectux.com>
X-X-Sender: john@fratser
To: Dave Olien <dmo@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DAC960_Release bug (2.4.x)
In-Reply-To: <20030416224013.GA11514@osdl.org>
Message-ID: <Pine.LNX.4.53.0304171004160.10181@fratser>
References: <Pine.LNX.4.53.0304161136270.18523@fratser> <20030416224013.GA11514@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have an application that detects hardware using the libhd from SuSE.
This lib loads the driver with the NONBLOCK flag, because it doesn't want
to use the drive, but only detect it. When it releases, the File parameter
is NULL, so the counters get decremented, but were never incremented.

When we try to partition the drive, the BLKRRPART ioctl fails because the
counter is 4294967295. (-1)
I don't think any program relies on this counter being < "0".

The whole point on the file descriptor is beyond me, but I think it's a
good thing to address.

--
John van der Kamp, ConnecTUX

On Wed, 16 Apr 2003, Dave Olien wrote:

>
> As you observed, ControllerUsageCount doesn't seem to serve
> any purpose.  It should just be removed, I think.
>
> I'm curious, what application you have that calls DAC960_Open() with NONBLOCK.
>
> Here's my interpretation of what the drivers' trying to do here.
> If you can validate these assumptions, I'd appreciate it.
>
> For the DAC960, it looks like the NONBLOCK flag is just a trick
> to allow a user-level DAC960 RAID manager utility to open the driver
> without actually interacting with any disk devices on the controller.
> The file descriptor you get back is not really associated with a specific
> device or controller.
>
> The DAC960_IOCTL function calls DAC960_UserIOCTL only when the
> NONBLOCK flag is set.  DAC960_UserIOCTL is designed to operate on
> the controller specified by a controller number argument, rather than
> a controller associated with its file descriptor argument.
>
> This lets the RAID manager utility operate on any controller at a time
> when perhaps there are NO logical devices ONLINE (i.e. you would
> be normally UNABLE to get ANY file descriptor for that controller).
>
> The ModuleOnly label in DAC960_open() apparently is meant to indicate
> we're opening "the DAC960 module" rather than a specific device.
>
> The problem is, the test for opening this file descriptor is iffy:
> 	"If the file descriptor is for controller 0, logical device
> 	0, and NONBLOCK is set, then return this `special` file descriptor."
>
> It's perfectly reasonable for an application to actually want to open
> REAL devices this way.  Instead, it gets this peculiar file descriptor.
>
> The problem is there are DAC960 utilities out there that I'm sure rely
> on this behavior.  So, it'll be hard to fix "the right way".
>
>
