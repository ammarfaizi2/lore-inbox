Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVLRVGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVLRVGj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 16:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbVLRVGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 16:06:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:3037 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751180AbVLRVGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 16:06:38 -0500
Subject: Re: USB rejecting sleep
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200512181258.47030.david-b@pacbell.net>
References: <1134937642.6102.85.camel@gaston>
	 <200512181258.47030.david-b@pacbell.net>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 08:01:26 +1100
Message-Id: <1134939687.6102.99.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-18 at 12:58 -0800, David Brownell wrote:
> On Sunday 18 December 2005 12:27 pm, Benjamin Herrenschmidt wrote:
> > Hi David, Alan !
> > 
> > What exactly changed in the recent USB stacks that is causing it to
> > abort system suspend much more often ? I'm getting lots of user reports
> > with 2.6.15-rc5 saying that they can't put their internal laptops to
> > sleep, apparently because a driver doesn't have a suspend method
> > (internal bluetooth in this case).
> 
> Which I hope _did_ generate a bug report to the maintainer of that
> bluetooth code.  :)

I'm working on it :)

> Right, but the system never stopped self-deadlocking when we did the
> disconnect at suspend time.  My notes say "driver core suspend()
> calls are made with dev->sem held, so usb_driver_release_interface()
> always deadlocks when they try to claim the same lock" and presumably
> that's still true.

Ok.

> I guess I didn't realize the consequence of not fixing that as part
> of the other PM updates, once I found that the "most natural" fix
> was (still?) not possible.

Makes sense. Just wanted to be sure.

> So the issue is now how to handle this error case.  I think it should
> be possible to just mark the device as disconnected right as soon as
> we notice it can't be suspended; resume processing will do the work,
> it already does so for real disconnect.  And disconnect paths in USB
> drivers are now pretty solid.

Ok, and so at the parent hub level, we can do either the actual suspend
of the port, or even power the port off if the device got into this
"latent disconnect" state.

Ben.
 

