Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTLKCLA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 21:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbTLKCLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 21:11:00 -0500
Received: from ferreol-1-82-66-171-16.fbx.proxad.net ([82.66.171.16]:49636
	"EHLO diablo.hd.free.fr") by vger.kernel.org with ESMTP
	id S262319AbTLKCK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 21:10:56 -0500
Message-ID: <3FD7D219.7030408@free.fr>
Date: Thu, 11 Dec 2003 03:10:33 +0100
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031206 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>, Duncan Sands <baldrick@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <20031210153056.GA7087@kroah.com> <Pine.LNX.4.44L0.0312101212480.850-100000@ida.rowland.org> <20031210204621.GA8566@kroah.com> <20031210210854.GA8724@kroah.com>
In-Reply-To: <20031210210854.GA8724@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried this patch together with Duncan's fix for my first problem 
and I couldn't reproduce any oops on my system. I've only tried a few (a 
dozen) cyles of loading/unloading for now (but earlier that was much 
enough to trigger an oops). I'll report later if/when I get any bad 
behaviour but so far everything looks fine.

Many thanks,

Vincent

Greg KH wrote:
> Ok, below is the patch.  I've only compile tested it, not run it yet.
> Please let me know if it works for you or not.
> 
> thanks,
> 
> greg k-h
> 
> 
> ===== hcd.c 1.123 vs edited =====
> --- 1.123/drivers/usb/core/hcd.c	Sun Dec  7 04:29:05 2003
> +++ edited/hcd.c	Wed Dec 10 13:06:19 2003
> @@ -588,6 +588,9 @@
>  
>  	if (bus->release)
>  		bus->release(bus);
> +	/* FIXME change this when the driver core gets the
> +	 * class_device_unregister_wait() call */
> +	complete(&bus->released);
>  }
>  
>  static struct class usb_host_class = {
> @@ -724,7 +727,11 @@
>  
>  	clear_bit (bus->busnum, busmap.busmap);
>  
> +	/* FIXME change this when the driver core gets the
> +	 * class_device_unregister_wait() call */
> +	init_completion(&bus->released);
>  	class_device_unregister(&bus->class_dev);
> +	wait_for_completion(&bus->released);
>  }
>  EXPORT_SYMBOL (usb_deregister_bus);
>  
> ===== usb.h 1.164 vs edited =====
> --- 1.164/include/linux/usb.h	Mon Oct  6 10:46:13 2003
> +++ edited/usb.h	Wed Dec 10 13:07:27 2003
> @@ -210,6 +210,8 @@
>  
>  	struct class_device class_dev;	/* class device for this bus */
>  	void (*release)(struct usb_bus *bus);	/* function to destroy this bus's memory */
> +	/* FIXME, remove this when the driver core gets class_device_unregister_wait */
> +	struct completion released;
>  };
>  #define	to_usb_bus(d) container_of(d, struct usb_bus, class_dev)
>  

