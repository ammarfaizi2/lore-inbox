Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTLLTRI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTLLTRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:17:08 -0500
Received: from ida.rowland.org ([192.131.102.52]:3844 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261779AbTLLTRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:17:04 -0500
Date: Fri, 12 Dec 2003 14:17:04 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: Duncan Sands <baldrick@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <3FDA0ADF.4030306@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0312121404110.677-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003, David Brownell wrote:

> Alan Stern wrote:
> 
> > The routine will:
> > 
> > 	1. issue the port reset
> > 	2. make sure the device is still attached
> > 	3. assign it the same address as it had before
> > 	4. read the device and configuration descriptors
> 
> I'd split step 4 into "4a" (device descriptors) and "4b"
> (config descriptors) ... and then re-factor so 1..4a is
> the same code as normal khubd enumeration.  That's what
> I was looking at a while back.  If you like, I'll finish
> that and forward.

Sure.  Although depending how you do it, step 3 might be different (reuse 
the old address vs. assign a new address).  Also the failure paths will be 
different.  But that could all be handled with proper refactoring.

I intended to share common code as much as possible.  Since you've already 
got part of that (almost) written, I'll be happy to use your work.

> That would also reduce the length of time the address0_sem
> is held,

It would?  How so?

>  eliminating a deadlock when a driver probe() from
> khubd calls "physical" reset_device() after firmware update.
> 
> You'll notice that today's "physical reset" codepath doesn't
> work the same way as the normal "just connected" reset.  Up
> through step (4a) there's no point to that -- it's all just
> potential bugginess, there's no good reason I can see to
> have those codepaths do the same thing differently.

Agreed.


> I think that ALL errors in that reset path should be handled
> the same way:  fail the reset, mark the device as gone, hand
> the device to some task context ... and in that task context,
> disconnect all the drivers, clean up sysfs, and re-enumerate
> the device.  (Without dropping power to the port; we don't
> want to need to re-download any firmware.)  Maybe there
> should be exceptiona if the old state wasn't CONFIGURED.
> 
> The notion of a device that's "partially reset" sounds like
> bugs waiting to happen.

Your choice makes error handling easier.  And failure to restore an 
altsetting is a pathological case anyhow, so it's not worth worrying 
about.

Alan Stern

