Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWB0TSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWB0TSu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbWB0TSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:18:50 -0500
Received: from digitalimplant.org ([64.62.235.95]:41412 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1751707AbWB0TSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:18:49 -0500
Date: Mon, 27 Feb 2006 11:18:43 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Greg KH <greg@kroah.com>
cc: akpm@osdl.org, "" <torvalds@osdl.org>, "" <linux-kernel@vger.kernel.org>,
       "" <linux-pm@osdl.org>
Subject: Re: [PATCH 0/4] Fix runtime device suspend/resumre interface
In-Reply-To: <20060221174950.GA23054@kroah.com>
Message-ID: <Pine.LNX.4.50.0602271111101.28882-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602201641380.21145-100000@monsoon.he.net>
 <20060221174950.GA23054@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Feb 2006, Greg KH wrote:

> On Mon, Feb 20, 2006 at 04:55:34PM -0800, Patrick Mochel wrote:
> >
> > Hi there,
> >
> > Here is an updated version of the patches to fix the sysfs interface for
> > runtime device power management by restoring the file to its originally
> > designed behavior - to place devices in the power state specified by the
> > user process writing to the file.
> >
> > Recently, the interface was changed to filter out values to prevent a
> > BUG() that was introduced in the PCI power management code. While a valid
> > fix, it makes the driver core filter values that might otherwise be used
> > by the bus/device drivers.
>
> Are there any existing bus/device drivers that are currently broken
> because of this change?

It's difficult to tell. There are several devices that support multiple
PCI power states, and several drivers that will attempt to put the device
into whatever state is passed to their ->suspend() method. But, there are
not many that handle D1 or D2 specially.

The point of the patches was to restore the functionality of the sysfs
file to its documented interface, which had been that way since the file
was created (early in 2.6). In the last year, since the conversion to the
pm_message_t in driver suspend methods, it is not behaved as it was
advertised to do.

One solution is to prohibit any suspend/resume commands besides "on" and
"off", and to change the documented semantics of the file. But, it seems
much more useful to enable the use of the intermediate states, so long as
it doesn't do any serious harm. Put another way, it doesn't seem to make
sense to intentionally prevent the use of intermediate power states.

What is also a bit wonky is the handling of those intermediate power
states now. If someone has a PCI device that advertises D1/D2 support, and
he/she knows the driver supports it (or is writing the driver support for
it), a write of "1" or "2" to the device's state file is not going to
provide the type of behavior that one would expect..

Does that help at all?

Thanks,


	Pat

