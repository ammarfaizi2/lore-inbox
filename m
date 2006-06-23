Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbWFWAlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWFWAlf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 20:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWFWAlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 20:41:35 -0400
Received: from cantor.suse.de ([195.135.220.2]:59831 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751679AbWFWAlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 20:41:35 -0400
Date: Thu, 22 Jun 2006 17:41:26 -0700
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.17
Message-ID: <20060623004126.GA3098@suse.de>
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606221546120.6483@g5.osdl.org> <20060622234040.GB30143@suse.de> <Pine.LNX.4.64.0606221646200.6483@g5.osdl.org> <20060622235259.GA30639@suse.de> <20060622173215.446e9de8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622173215.446e9de8.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 05:32:15PM -0700, Andrew Morton wrote:
> Greg KH <gregkh@suse.de> wrote:
> >
> > I would think it's something new too, as I did change that very line
> > that oopsed.  That's why I found it odd that I couldn't reproduce it
> > anymore.
> 
> device_destroy() looks wrong.  It alters the class->devices list outside
> its lock.
> 
> --- 25/drivers/base/core.c~device_destroy-locking-fix	Thu Jun 22 17:29:07 2006
> +++ 25-akpm/drivers/base/core.c	Thu Jun 22 17:29:34 2006
> @@ -632,14 +632,13 @@ void device_destroy(struct class *class,
>  	list_for_each_entry(dev_tmp, &class->devices, node) {
>  		if (dev_tmp->devt == devt) {
>  			dev = dev_tmp;
> +			list_del_init(&dev->node);
>  			break;
>  		}
>  	}
>  	up(&class->sem);
>  
> -	if (dev) {
> -		list_del_init(&dev->node);
> +	if (dev)
>  		device_unregister(dev);
> -	}
>  }
>  EXPORT_SYMBOL_GPL(device_destroy);
> 
> That won't be it though.

No, and that function doesn't get called for the usb endpoints, it goes
through a different path, that's the problem...  I think I've found it
now, let me reboot a bunch...

thanks,

greg k-h
