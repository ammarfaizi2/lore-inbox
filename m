Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265119AbUHCG5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUHCG5Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 02:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUHCG5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 02:57:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:23718 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265106AbUHCG4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 02:56:52 -0400
Date: Mon, 2 Aug 2004 23:44:24 -0700
From: Greg KH <greg@kroah.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [patchset] Lockfree fd lookup 2 of 5
Message-ID: <20040803064424.GB10454@kroah.com>
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com> <20040802101604.GD4385@vitalstatistix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802101604.GD4385@vitalstatistix.in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 03:46:06PM +0530, Ravikiran G Thirumalai wrote:
> diff -ruN -X dontdiff2 linux-2.6.7/drivers/usb/core/message.c kref-2.6.7/drivers/usb/core/message.c
> --- linux-2.6.7/drivers/usb/core/message.c	2004-06-16 10:49:02.000000000 +0530
> +++ kref-2.6.7/drivers/usb/core/message.c	2004-07-20 15:07:24.000000000 +0530
> @@ -1077,11 +1077,12 @@
>  
>  static void release_interface(struct device *dev)
>  {
> +	extern void destroy_serial(struct kref *kref);
>  	struct usb_interface *intf = to_usb_interface(dev);
>  	struct usb_interface_cache *intfc =
>  			altsetting_to_usb_interface_cache(intf->altsetting);
>  
> -	kref_put(&intfc->ref);
> +	kref_put(&intfc->ref, destroy_serial);
>  	kfree(intf);
>  }

This is the bug.  destroy_serial() is for the usb_serial core and does
not clean up for this type of structure (and is not exported, so it will
not even build properly).  Also, never put a function prototype within a
function like you did here.

So, I'm guessing you didn't try to remove any USB devices after applying
your patch?  :)

thanks,

greg k-h
