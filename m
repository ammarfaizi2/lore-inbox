Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbTLIPzk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 10:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266077AbTLIPzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 10:55:40 -0500
Received: from ida.rowland.org ([192.131.102.52]:14852 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S266075AbTLIPzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 10:55:38 -0500
Date: Tue, 9 Dec 2003 10:55:31 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <200312091123.54412.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0312091048590.1033-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Duncan Sands wrote:

> > You may simply have to release the lock because calling
> > usb_set_configuration and then reacquire it afterwards.
> 
> Right, I did this in my patch along with the other changes, but in fact it could
> be fixed separately.

Doesn't this approach work?  I don't see anything wrong with it.  (Read 
"before" rather than "because" above -- my fingers don't always do what my 
mind wants them to do.)


> Well, you could just ensure you have a reference to the usb_device, and
> change usb_set_configuration and friends so that they don't Oops if the
> device has been disconnected.  This should be done anyway by the way -
> surely all core routines should behave themselves (eg: by failing with
> an error code) when called with a not-yet-freed struct usb_device?

Yes, that's the correct way to handle it.


> > I mean it won't cause an oops, although it might provide an invalid
> > result.  It's not _required_ by the API (maybe it should be).
> 
> It will cause an Oops - actconfig may be NULL.  This is the case after
> disconnect for example, and also momentarily the case doing configuration
> changes.

Sorry -- what I _really_ meant to say was that usb_ifnum_to_if needs to be 
rewritten to add a test for actconfig == NULL.  Once that's done properly, 
calling it without holding the lock won't oops even though it also might 
not give you the right answer.  Minor point; nobody would want to do that.


> The disconnect routine is only called if you have claimed an interface.
> If usbfs is looking for an interface to claim (and hasn't yet claimed
> one), then disconnect will not be called.  There is code in inode.c that
> informs usbfs when the device has been disconnected, but now that
> disconnect is per-interface, that is not good enough.

What about the call to usbfs_remove_device that's in usb_disconnect?

Alan Stern

