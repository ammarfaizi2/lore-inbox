Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUDNQsV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbUDNQsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:48:20 -0400
Received: from ida.rowland.org ([192.131.102.52]:6148 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264278AbUDNQsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:48:15 -0400
Date: Wed, 14 Apr 2004 12:48:14 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sf.net>,
       <linux-kernel@vger.kernel.org>, Frederic Detienne <fd@cisco.com>
Subject: Re: [linux-usb-devel] [PATCH 7/9] USB usbfs: destroy submitted urbs
 only on the disconnected interface
In-Reply-To: <200404141245.37101.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0404141226370.1474-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004, Duncan Sands wrote:

> diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> --- a/drivers/usb/core/devio.c	Wed Apr 14 12:18:20 2004
> +++ b/drivers/usb/core/devio.c	Wed Apr 14 12:18:20 2004
> @@ -341,6 +341,7 @@
>  static void driver_disconnect(struct usb_interface *intf)
>  {
>  	struct dev_state *ps = usb_get_intfdata (intf);
> +	unsigned int ifnum = intf->altsetting->desc.bInterfaceNumber;
>  
>  	if (!ps)
>  		return;
> @@ -349,11 +350,12 @@
>  	 * all pending I/O requests; 2.6 does that.
>  	 */
>  
> -	clear_bit(intf->cur_altsetting->desc.bInterfaceNumber, &ps->ifclaimed);
> +	if (ifnum < 8*sizeof(ps->ifclaimed))
> +		clear_bit(ifnum, &ps->ifclaimed);
>  	usb_set_intfdata (intf, NULL);
>  
>  	/* force async requests to complete */
> -	destroy_all_async (ps);
> +	destroy_async_on_interface(ps, ifnum);
>  }
>  
>  struct usb_driver usbdevfs_driver = {


Quite apart from the stylistic questions about sanity tests and so on, 
this code contains a bug.  It wasn't introduced by your patch; it was 
there from before and I should have caught it earlier, along with a few 
others.

The real problem is that the code in devio.c doesn't make a clear visual
distinction between interface number (i.e., desc.bInterfaceNumber) and
interface index (i.e., dev->actconfig->interface[index]).  The two values
do not have to agree.

The claimintf(), releaseintf(), and checkintf() routines take an index as
argument, and the ifclaimed bitvector uses the same index.  findintfif()
takes a number and returns the corresponding index, duplicating much of
the functionality of usb_ifnum_to_if().  Likewise, findintfep() returns an 
index.

The code here in driver_disconnect() uses a number where it needs to use 
an index.

Similarly, there's a typo in proc_releaseinterface(); the second argument 
it passes to releaseintf() should be ret, not intf.

And in proc_submiturb(), the value stored in as->intf is an index when it 
should be an interface number.  Or possibly it could remain an index, but 
then the value passed to destroy_async_on_interface() by 
proc_releaseinterface() should be the index and not the number.

Alan Stern

