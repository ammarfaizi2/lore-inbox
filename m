Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVCaSAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVCaSAa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 13:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVCaSAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 13:00:30 -0500
Received: from digitalimplant.org ([64.62.235.95]:21124 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261600AbVCaSAD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 13:00:03 -0500
Date: Thu, 31 Mar 2005 09:59:55 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Alan Stern <stern@rowland.harvard.edu>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <Pine.LNX.4.44L0.0503311054410.1510-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.50.0503310947180.7249-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503311054410.1510-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Mar 2005, Alan Stern wrote:

> On Wed, 30 Mar 2005, Patrick Mochel wrote:

> > In fact, we probably want to add a counter to every device for all "open
> > connections" so the device doesn't try to automatically sleep while a
> > device node is open. Once it reaches 0, we can have it enter a
> > pre-configured state, which should save us a bit of power for very little
> > pain.
>
> By "open connections", do you mean something more than unsuspended
> children?

Yes, I mean anything that requires the device be awake and functional.
This would include open device nodes for many devices, open network
connections for network devices, active children for bridges and
controllers, etc.

This will require modification of at least the open() routines at the
subsystem level. They can simply access the class device and call down to
the driver, with some help from some core utility functions and some hand
waving. The driver (or bus subsystem) can determine if the parent needs to
be awakened at that same time, and awaken it if necessary.

> Are you proposing to add these counters to struct device?  If so, would
> they be used and maintained by the core or by the driver/subsystem?  I
> should think the core wouldn't know enough about the requirements of
> different devices to do anything useful.  But then if the core doesn't use
> the counters they should be stored in a private data structure, not in
> struct device.

The core would know very little to be useful. However, it would most
likely need to modify them around calls to e.g. probe()/remove() to make
sure the device is functional when accessing it. Maybe.

At the very least, the shortest path to getting every device working with
this is to modify the subsystems' open calls. The only way to bridge their
notion of class-specific objects (and class_devices) with physical devices
is through the core.

So, I think we need the counter in struct device, along with some helper
functions.


	Pat
