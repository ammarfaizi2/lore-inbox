Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbTLIUgs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266113AbTLIUgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:36:48 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:385
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S266117AbTLIUgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:36:24 -0500
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Tue, 9 Dec 2003 21:36:21 +0100
User-Agent: KMail/1.5.4
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312091048590.1033-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312091048590.1033-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312092136.21746.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 December 2003 16:55, Alan Stern wrote:
> On Tue, 9 Dec 2003, Duncan Sands wrote:
> > > You may simply have to release the lock because calling
> > > usb_set_configuration and then reacquire it afterwards.
> >
> > Right, I did this in my patch along with the other changes, but in fact
> > it could be fixed separately.
>
> Doesn't this approach work?  I don't see anything wrong with it.  (Read
> "before" rather than "because" above -- my fingers don't always do what my
> mind wants them to do.)

You mean, drop ps->devsem, take dev->serialize, check for disconnect,
proceed if not disconnected, do some stuff (traverse the configuration for
example), drop dev->serialize, take ps->devsem, check for disconnect,
proceed if not disconnected?  Well yes, but doing this all over the place
would only make the whole driver more complicated and more fragile.

> > Well, you could just ensure you have a reference to the usb_device, and
> > change usb_set_configuration and friends so that they don't Oops if the
> > device has been disconnected.  This should be done anyway by the way -
> > surely all core routines should behave themselves (eg: by failing with
> > an error code) when called with a not-yet-freed struct usb_device?
>
> Yes, that's the correct way to handle it.
>
> > > I mean it won't cause an oops, although it might provide an invalid
> > > result.  It's not _required_ by the API (maybe it should be).
> >
> > It will cause an Oops - actconfig may be NULL.  This is the case after
> > disconnect for example, and also momentarily the case doing configuration
> > changes.
>
> Sorry -- what I _really_ meant to say was that usb_ifnum_to_if needs to be
> rewritten to add a test for actconfig == NULL.  Once that's done properly,
> calling it without holding the lock won't oops even though it also might
> not give you the right answer.  Minor point; nobody would want to do that.
>
> > The disconnect routine is only called if you have claimed an interface.
> > If usbfs is looking for an interface to claim (and hasn't yet claimed
> > one), then disconnect will not be called.  There is code in inode.c that
> > informs usbfs when the device has been disconnected, but now that
> > disconnect is per-interface, that is not good enough.
>
> What about the call to usbfs_remove_device that's in usb_disconnect?

That's the code in inode.c that I mentioned.

Ciao,

Duncan.
