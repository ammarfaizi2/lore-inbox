Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965275AbVLRU6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965275AbVLRU6t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 15:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965276AbVLRU6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 15:58:48 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:60532 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965275AbVLRU6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 15:58:48 -0500
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: USB rejecting sleep
Date: Sun, 18 Dec 2005 12:58:46 -0800
User-Agent: KMail/1.7.1
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1134937642.6102.85.camel@gaston>
In-Reply-To: <1134937642.6102.85.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512181258.47030.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 December 2005 12:27 pm, Benjamin Herrenschmidt wrote:
> Hi David, Alan !
> 
> What exactly changed in the recent USB stacks that is causing it to
> abort system suspend much more often ? I'm getting lots of user reports
> with 2.6.15-rc5 saying that they can't put their internal laptops to
> sleep, apparently because a driver doesn't have a suspend method
> (internal bluetooth in this case).

Which I hope _did_ generate a bug report to the maintainer of that
bluetooth code.  :)


> It's never been mandatory so far for all drivers of all connected
> devices to have a suspend method... didn't we decide back then that
> disconneting those was the right way to go ?

Right, but the system never stopped self-deadlocking when we did the
disconnect at suspend time.  My notes say "driver core suspend()
calls are made with dev->sem held, so usb_driver_release_interface()
always deadlocks when they try to claim the same lock" and presumably
that's still true.

I guess I didn't realize the consequence of not fixing that as part
of the other PM updates, once I found that the "most natural" fix
was (still?) not possible.


> Any reason we are rejecting the sleep process for these currently ? A
> locking issue that makes disconnecting not yet feasible ? What changed
> from the previous version where that worked ?

The current kernels tighten up the suspend processing and offloaded lots
of stuff to the driver core.  Previous kernels didn't have code that
could care about such stuff, at least without USB_SUSPEND enabled.

So the issue is now how to handle this error case.  I think it should
be possible to just mark the device as disconnected right as soon as
we notice it can't be suspended; resume processing will do the work,
it already does so for real disconnect.  And disconnect paths in USB
drivers are now pretty solid.

- Dave



