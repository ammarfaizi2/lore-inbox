Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbTHYTxt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 15:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbTHYTxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 15:53:49 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:32217 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262274AbTHYTxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 15:53:48 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0308251201310.1157-100000@cherise>
References: <Pine.LNX.4.44.0308251201310.1157-100000@cherise>
Message-Id: <1061841190.717.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 25 Aug 2003 21:53:10 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: [PM] powering down special devices
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-25 at 21:05, Patrick Mochel wrote:

> How about a flag in the power struct, which would place the device on a 
> completely separate list from the beginning. The drivers should know 
> whether a device needs special handling a priori, so we don't even need to 
> touch it during the first iteration of the lists.
> 
> This would eliminate the need to check in the drivers, have no impact on 
> the majority of drivers, and allow us to easily determine whether or not 
> the device supports runtime power management. 

Not sure if we don't actually want both iterations :) It's difficult to
knwo for sure as I lack such a device actually... But I can imagine your
need to run with IRQs enabled to properly "flush" pending requests, then
have IRQs disabled to do the HW shutdown.

For example, if you are a block device, then you need IRQ enabled so you
can send a SUSPEND request down your request queue like IDE does (that's
the best way to get proper synchronisation) and wait on it to complete.
But if your HW is then broken enough that when you actually want to turn
it off (after the queue has been properly suspended) it will leave a
dangling interrupt, then you need to do that last part with IRQs disabled.

Of course, the above only comes out of my imagination, I don't have such
a device, I suspect Alan may know more about the kind of devices we may
expect with an IRQ problem on suspend..

Ben.


