Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbTLJQCV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 11:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbTLJQCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 11:02:21 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:30617
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S263702AbTLJQCS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 11:02:18 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Wed, 10 Dec 2003 17:02:16 +0100
User-Agent: KMail/1.5.4
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <3FD64BD9.1010803@pacbell.net> <Pine.LNX.4.44L0.0312092233340.6615-100000@netrider.rowland.org> <20031210153056.GA7087@kroah.com>
In-Reply-To: <20031210153056.GA7087@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312101702.16455.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, the pci core calls the release() function in the pci driver that is
> bound to that device.  It waits for that release() call to return before
> continuing on.  You can sleep for however long you want in that
> function, but once you return from there, the pci structures for that
> device will be cleaned up.
>
> > However, the module_exit routines _don't_ wait for the release callbacks.
>
> Not true.
>
> > They just go right on ahead and exit.  Result: when the reference count
> > eventually does go to 0 (when usbfs drops its last reference), the
> > hcd_free routine is no longer present and you get an oops.
>
> Hm, this could be easily tested by sleeping until usb_host_release() is
> called when you unregister a device.  The i2c, pcmcia, and network
> subsytems do this.  I think we now have a helper function in the driver
> core to do this for us, so we don't have to declare our own completion
> variable...
>
> > The proper fix would be to have each HC driver keep track of how many
> > instances are allocated.  The module_exit routine must wait for that
> > number to drop to 0 before returning.
>
> That's what my proposal 1 paragraph up would do.  If I get the chance
> this afternoon, I'll try to implement it if no one beats me to it...

Hi Greg, so this means that rmmod will sleep in an unkillable state until
all references are dropped?  I don't know if you've been following this
thread or not, but the oops occurred when I modified usbfs to hold a
reference to the usb_device until no-one was using a given usbfs file.  I
guess this means that I should change my patch so that the reference to
the usb_device is dropped as soon as possible, right?

Thanks for looking into this,

Duncan.
