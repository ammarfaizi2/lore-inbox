Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266098AbTLIU0u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbTLIU0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:26:19 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:57984
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S266123AbTLIUYr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:24:47 -0500
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Tue, 9 Dec 2003 21:24:45 +0100
User-Agent: KMail/1.5.4
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312091057150.1033-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312091057150.1033-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312092124.45224.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here's how I see it.
>
> dev->serialize is meant to protect significant state changes, things like
> set_configuration and device disconnect.  ps->devsem is meant to protect
> against usbfs trying to do two things to the device at the same time.

Actually no: it is a read lock and all routines take it with down_read except
for the disconnect routine.  So it is only there to guard against disconnect.

> But you also want to protect against usbfs using the device during a state
> change.  (The normal protection mechanisms don't work because usbfs might
> be using a device without having a driver bound to any of its interfaces.)
> Given that, there's no reason usbfs shouldn't just use serialize instead
> of devsem.
>
> The fact that the core calls driver_disconnect with serialize already held
> then just makes your life simpler: You don't need to acquire the lock
> yourself!
>
> The only tricky part is that you have to release serialize (which now is
> your only lock) before calling set_configuration.  But as you said, you
> would have to release ps->devsem anyway, so nothing's lost there.
>
> Anything wrong with this approach?

Nothing - that is exactly what my patch does.  And it works... except
for the Oops in usb_put_dev.

All the best,

Duncan.
