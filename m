Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTLLS2y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 13:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTLLS2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 13:28:53 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:24751 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S261753AbTLLS2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 13:28:51 -0500
Message-ID: <3FDA0ADF.4030306@pacbell.net>
Date: Fri, 12 Dec 2003 10:37:19 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Duncan Sands <baldrick@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <Pine.LNX.4.44L0.0312121047590.1297-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312121047590.1297-100000@ida.rowland.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:

> Maybe it will help if I explain how usb_reset_device will work in the 
> future.
> 
> First of all, as David has said, it does and will grab dev->serialize.  

Well, it "does" in my tree, but test11 doesn't (except in the
broken DFU path).  That's likely a source of some of Duncan's
confusion -- my bad, sorry.


> The alternate entry point (...physical...) will require the caller to 
> hold it already.
> 
> The routine will:
> 
> 	1. issue the port reset
> 	2. make sure the device is still attached
> 	3. assign it the same address as it had before
> 	4. read the device and configuration descriptors

I'd split step 4 into "4a" (device descriptors) and "4b"
(config descriptors) ... and then re-factor so 1..4a is
the same code as normal khubd enumeration.  That's what
I was looking at a while back.  If you like, I'll finish
that and forward.

That would also reduce the length of time the address0_sem
is held, eliminating a deadlock when a driver probe() from
khubd calls "physical" reset_device() after firmware update.

You'll notice that today's "physical reset" codepath doesn't
work the same way as the normal "just connected" reset.  Up
through step (4a) there's no point to that -- it's all just
potential bugginess, there's no good reason I can see to
have those codepaths do the same thing differently.


> 	5. make sure they are equal to the old descriptor values
> 	6. install the old configuration (if the old state was CONFIGURED) 
> 	7. select the old altsettings for each interface
> 
> ...
> 
> If a problem arises in step 7, I'm not sure what to do.  ...

I think that ALL errors in that reset path should be handled
the same way:  fail the reset, mark the device as gone, hand
the device to some task context ... and in that task context,
disconnect all the drivers, clean up sysfs, and re-enumerate
the device.  (Without dropping power to the port; we don't
want to need to re-download any firmware.)  Maybe there
should be exceptiona if the old state wasn't CONFIGURED.

The notion of a device that's "partially reset" sounds like
bugs waiting to happen.

- Dave


