Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264869AbUEMVDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264869AbUEMVDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 17:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbUEMVDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 17:03:14 -0400
Received: from ida.rowland.org ([192.131.102.52]:11524 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264869AbUEMVDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 17:03:10 -0400
Date: Thu, 13 May 2004 17:03:09 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: Greg KH <greg@kroah.com>, Nuno Ferreira <nuno.ferreira@graycell.biz>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sf.net>
Subject: Re: PATCH: (as279) Don't delete interfaces until all are unbound
In-Reply-To: <200405132150.21710.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0405131656470.651-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004, Duncan Sands wrote:

> Hi Alan,
> 
> > +		/* Now that the interfaces are unbound, nobody should
> > +		 * try to access them.
> > +		 */
> 
> how is usbfs going to claim interfaces after this?

After this there _are_ no interfaces!  They've all been destroyed by
usb_disable_device(), called as part of usb_set_configuration() or
usb_disconnect().  Of course, usb_set_configuration() will go ahead and
create a new set of interfaces that usbfs can then bind.

> > + * Don't call this function unless you are bound to one of the interfaces
> > + * on this device or you own the dev->serialize semaphore!
> 
> Owning dev->serialize won't stop an Oops if the interfaces are all NULL...

If you own dev->serialize then usb_disable_device() can't be running
concurrently, since it requires its caller to own that semaphore (although
that may not be stated explicitly).  Hence either the interfaces won't be
NULL or else dev->actconfig will be NULL, and in either case
usb_ifnum_to_if() will work okay.

Alan Stern

