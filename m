Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266088AbTLIQI6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266089AbTLIQI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:08:57 -0500
Received: from ida.rowland.org ([192.131.102.52]:16644 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S266088AbTLIQIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:08:20 -0500
Date: Tue, 9 Dec 2003 11:08:14 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <200312091136.07183.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0312091057150.1033-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Duncan Sands wrote:

> There is another solution by the way, which involves changes in the core:
> make dev->serialize into a read/write semaphore, and have disconnect
> be called with a READ lock taken on dev->serialize.  Then in usbfs, I can
> take a read lock on dev->serialize whenever I want to rummage around
> in the device configuration.  This way things can be left as they are (i.e.
> keep ps->devsem) and deadlock will not occur as long as usbfs only
> takes read locks on dev->serialize.  Of course calls to usb_set_configuration
> may deadlock as now unless you drop ps->devsem before calling, but I'm
> sure this can be dealt with (this is because it needs a write lock on
> dev->serialize).  I quite like this solution because it makes
> things more robust: as long as device drivers only take a read lock on
> dev->serialize, they should not deadlock for this reason.  (These deadlock
> possibilities are a fundamental problem because drivers call into the
> core (which makes itself atomic using dev->serialize and friends), but
> the core also calls back into drivers via disconnect methods which it
> wants to make atomic by holding the same lock).

Here's how I see it.

dev->serialize is meant to protect significant state changes, things like
set_configuration and device disconnect.  ps->devsem is meant to protect
against usbfs trying to do two things to the device at the same time.  
But you also want to protect against usbfs using the device during a state
change.  (The normal protection mechanisms don't work because usbfs might
be using a device without having a driver bound to any of its interfaces.)  
Given that, there's no reason usbfs shouldn't just use serialize instead
of devsem.

The fact that the core calls driver_disconnect with serialize already held 
then just makes your life simpler: You don't need to acquire the lock 
yourself!

The only tricky part is that you have to release serialize (which now is
your only lock) before calling set_configuration.  But as you said, you
would have to release ps->devsem anyway, so nothing's lost there.

Anything wrong with this approach?

Alan Stern

