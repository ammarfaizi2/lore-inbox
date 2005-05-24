Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVEXQXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVEXQXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVEXQXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:23:34 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:30444 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262110AbVEXQXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:23:04 -0400
Date: Tue, 24 May 2005 11:22:45 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ioc4: Driver rework
In-Reply-To: <429289C6.9080707@pobox.com>
Message-ID: <20050524100237.W80608@chenjesu.americas.sgi.com>
References: <20050523192157.V75588@chenjesu.americas.sgi.com>
 <429289C6.9080707@pobox.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2005, Jeff Garzik wrote:

> Brent Casavant wrote:
> > - The IOC4 chip implements multiple functions (serial, IDE, others not
> >   yet implemented in the mainline kernel) but is not a multifunction
> >   PCI device.  In order to properly handle device addition and removal
> >   as well as module insertion and deletion, an intermediary IOC4-specific
> >   driver layer is needed to handle these operations cleanly.
> 
> I disagree that a layer is needed.
> 
> Just write a PCI driver that does the following in probe:
> 
> 	register IDE
> 	register serial
> 	...
> 
> and undoes all that in remove.
> 
> Device addition and removal work just fine with that scheme.

That is the structure of the current device driver, and we've found it
to be inadequate.  What the structure you mention doesn't allow is
the independent loading and unloading of modules to support the various
functions of the IOC4 chip.

On most systems the only component of IOC4 that is used is the IDE
driver.  In this case the serial devices are not needed, and there is
no use carrying around that code during runtime.  There are similar
situations for the IOC4 external interrupt capability (to be open-sourced
soon) and kbd/mouse (no plans to even write this driver, but you never
know).  This isn't a huge deal with the amount of RAM present on a typical
SGI Altix machine, however it can become an issue when we consider the
initrd images and installer kernels supplied with vendor distributions.

A quarter meg here, a quarter meg there, and before you know it, you're
talking about real disk space. :)

Another minor point, the current driver code inverts the mental model
that makes sense to most people.  Having the core driver cause a load
of the function-level drivers (via modprobe) seems counterintuitive.
The new method seems to make sense to most everyone I've bounced it
off of (granted, internal to SGI).  Very much related to this point,
the new code is just far far cleaner, code-wise and mentally.

On a more personal level, having a structure which allows loading and
unloading of the drivers for the individual functions of the IOC4
greatly eases the debugging cycle.  While in theory my code should be
perfect...

Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
