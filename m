Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUHCHmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUHCHmy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 03:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUHCHmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 03:42:54 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:55493 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265264AbUHCHmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 03:42:52 -0400
Date: Tue, 3 Aug 2004 13:11:50 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [patchset] Lockfree fd lookup 2 of 5
Message-ID: <20040803074150.GB1753@vitalstatistix.in.ibm.com>
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com> <20040802101604.GD4385@vitalstatistix.in.ibm.com> <20040803064424.GB10454@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803064424.GB10454@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 11:44:24PM -0700, Greg KH wrote:
> On Mon, Aug 02, 2004 at 03:46:06PM +0530, Ravikiran G Thirumalai wrote:
> > diff -ruN -X dontdiff2 linux-2.6.7/drivers/usb/core/message.c kref-2.6.7/drivers/usb/core/message.c
> > --- linux-2.6.7/drivers/usb/core/message.c	2004-06-16 10:49:02.000000000 +0530
> > +++ kref-2.6.7/drivers/usb/core/message.c	2004-07-20 15:07:24.000000000 +0530
> > @@ -1077,11 +1077,12 @@
> >  
> >  static void release_interface(struct device *dev)
> >  {
> > +	extern void destroy_serial(struct kref *kref);
> >  	struct usb_interface *intf = to_usb_interface(dev);
> >  	struct usb_interface_cache *intfc =
> >  			altsetting_to_usb_interface_cache(intf->altsetting);
> >  
> > -	kref_put(&intfc->ref);
> > +	kref_put(&intfc->ref, destroy_serial);
> >  	kfree(intf);
> >  }
> 
> This is the bug.  destroy_serial() is for the usb_serial core and does
> not clean up for this type of structure (and is not exported, so it will
> not even build properly).  Also, never put a function prototype within a
> function like you did here.
> 
> So, I'm guessing you didn't try to remove any USB devices after applying
> your patch?  :)

No I didn't :).  I just checked the build not the working as such.  
>From what I could infer from the 2.6.7 tree, there is no kref_init()
in core/message.c.  Well I dunno what made me think destroy_serial
was used to init (kref_init) that refcounter at that time so I have 
even exported destroy_serial in the patch so that it builds.  
(expored as in changing static to non static .. I build all drivers 
into the kernel usually and so the build didn't break for me).
I now realise destroy_serial is the wrong release function.  I am no expert 
in usb-drivers area, but I should be more careful than that. 

Thanks,
Kiran
