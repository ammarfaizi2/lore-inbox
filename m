Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264287AbUDNRJt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 13:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbUDNRJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 13:09:49 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:45276 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S264287AbUDNRJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 13:09:36 -0400
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] [PATCH 7/9] USB usbfs: destroy submitted urbs only on the disconnected interface
Date: Wed, 14 Apr 2004 19:09:29 +0200
User-Agent: KMail/1.5.4
Cc: Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sf.net>,
       <linux-kernel@vger.kernel.org>, Frederic Detienne <fd@cisco.com>,
       David Brownell <david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0404141226370.1474-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0404141226370.1474-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404141909.29810.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 14 Apr 2004, Duncan Sands wrote:
> > diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> > --- a/drivers/usb/core/devio.c	Wed Apr 14 12:18:20 2004
> > +++ b/drivers/usb/core/devio.c	Wed Apr 14 12:18:20 2004
> > @@ -341,6 +341,7 @@
> >  static void driver_disconnect(struct usb_interface *intf)
> >  {
> >  	struct dev_state *ps = usb_get_intfdata (intf);
> > +	unsigned int ifnum = intf->altsetting->desc.bInterfaceNumber;
> >
> >  	if (!ps)
> >  		return;
> > @@ -349,11 +350,12 @@
> >  	 * all pending I/O requests; 2.6 does that.
> >  	 */
> >
> > -	clear_bit(intf->cur_altsetting->desc.bInterfaceNumber, &ps->ifclaimed);
> > +	if (ifnum < 8*sizeof(ps->ifclaimed))
> > +		clear_bit(ifnum, &ps->ifclaimed);
> >  	usb_set_intfdata (intf, NULL);
> >
> >  	/* force async requests to complete */
> > -	destroy_all_async (ps);
> > +	destroy_async_on_interface(ps, ifnum);
> >  }
> >
> >  struct usb_driver usbdevfs_driver = {
>
> Quite apart from the stylistic questions about sanity tests and so on,
> this code contains a bug.  It wasn't introduced by your patch; it was
> there from before and I should have caught it earlier, along with a few
> others.

Hi Alan, it was introduced after your last devio.c fixes by the patch
"fix xsane breakage, hangs on device scan at launch" by someone
who will remain nameless :)

> The real problem is that the code in devio.c doesn't make a clear visual
> distinction between interface number (i.e., desc.bInterfaceNumber) and
> interface index (i.e., dev->actconfig->interface[index]).  The two values
> do not have to agree.
>
> The claimintf(), releaseintf(), and checkintf() routines take an index as
> argument, and the ifclaimed bitvector uses the same index.  findintfif()
> takes a number and returns the corresponding index, duplicating much of
> the functionality of usb_ifnum_to_if().  Likewise, findintfep() returns an
> index.
>
> The code here in driver_disconnect() uses a number where it needs to use
> an index.
>
> Similarly, there's a typo in proc_releaseinterface(); the second argument
> it passes to releaseintf() should be ret, not intf.
>
> And in proc_submiturb(), the value stored in as->intf is an index when it
> should be an interface number.  Or possibly it could remain an index, but
> then the value passed to destroy_async_on_interface() by
> proc_releaseinterface() should be the index and not the number.

Good catch!  I guess the index and the interface differ because interfaces are
not always consecutively numbered.  Is that right?  When can it happen?

Thanks,

Duncan.
