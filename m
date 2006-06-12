Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWFLVas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWFLVas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWFLVas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:30:48 -0400
Received: from cantor.suse.de ([195.135.220.2]:59322 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932134AbWFLVaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:30:46 -0400
Date: Mon, 12 Jun 2006 14:28:12 -0700
From: Greg KH <gregkh@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb, error -28
Message-ID: <20060612212812.GA17458@suse.de>
References: <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD50F.3060002@rtr.ca> <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD968.2010000@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448DD50F.3060002@rtr.ca> <448DD968.2010000@rtr.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 05:15:20PM -0400, Mark Lord wrote:
> Greg KH wrote:
> >On Mon, Jun 12, 2006 at 04:06:22PM -0400, Mark Lord wrote:
> >> pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb, error -28
> >>
> >>The pl2303 serial port is part of a USB1.1 Hub/dock device,
> >>plugged into a USB2 port on my notebook.
> >
> >Known issue for years.  Either plug it directly into the USB 2.0 root
> >hub, or disable the ehci driver.
> >
> >>I get the same failure again when trying to use the port with Kermit.
> >>This device was working fine here not long ago -- on the -rc5 kernels I 
> >>think.
> >
> >It's a flaky thing.
> >
> >Also, look in the -mm tree, there is a fix for this direct error, and
> >hopefully some ehci fixes that enable the whole thing to work properly.
> 
> I found this fix in -mm:   gregkh-usb-usb-rmmod-pl2303-after-28.patch
> It did *not* fix the problem.

That should fix the memory leak after getting that error and let you
unload the module, right?

> Any other candidates available?

Look at the ehci patch:
	improved-tt-scheduling-for-ehci.patch

And enable that option.

On Mon, Jun 12, 2006 at 04:56:47PM -0400, Mark Lord wrote:
> Greg KH wrote:
> ..
> >It's a flaky thing.
> 
> No kidding.  Okay, it is also now failing for me with 2.6.16.18.
> 
> BUT.. with exactly that same binary kernel, it worked fine
> not long ago --> but I've swapped out userland since then,
> upgrading from Breezy to Dapper.  So something userland in Dapper
> is triggering this failure, in a way that Breezy never did before.
> 
> This device has been quite usable until now (the upgrade to Dapper).

Yeah, it's a timing issue with the EHCI TT code.  It's never been
"correct" and we have had this problem since we first got USB 2.0
support.  You were just lucky in not hitting it before.

> >Known issue for years.  Either plug it directly into the USB 2.0 root
> >hub, or disable the ehci driver.
> 
> MMm.. yes, that makes some sense.  I have a pl2303 standalone that works 
> fine, but the one integrated into the 1.1 hub/dock is the one that
> fails.
> 
> If I plug the 1.1 hub/dock into another external hub, no problems.

I recommend doing that :)

It's not like you get _any_ speed differences by using a USB 2.0 hub
with this device...

thanks,

greg k-h
