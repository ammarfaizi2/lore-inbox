Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVAYNvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVAYNvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 08:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVAYNvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 08:51:49 -0500
Received: from mail.tmr.com ([216.238.38.203]:6016 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261939AbVAYNuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 08:50:15 -0500
Message-ID: <41F64E87.8040501@tmr.com>
Date: Tue, 25 Jan 2005 08:49:59 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Waychison <Michael.Waychison@Sun.COM>
CC: Greg KH <greg@kroah.com>, Jirka Kosina <jikos@jikos.cz>,
       Patrick Mochel <mochel@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix bad locking in drivers/base/driver.c
References: <Pine.LNX.4.58.0501241921310.5857@twin.jikos.cz> <20050125055651.GA1987@kroah.com> <41F5F623.5090903@sun.com>
In-Reply-To: <41F5F623.5090903@sun.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Greg KH wrote:
> 
>>On Mon, Jan 24, 2005 at 07:25:19PM +0100, Jirka Kosina wrote:
>>
>>
>>>Hi,
>>>
>>>there has been (for quite some time) a bug in function driver_unregister() 
>>>- the lock/unlock sequence is protecting nothing and the actual 
>>>bus_remove_driver() is called outside critical section.
>>>
>>>Please apply.
>>
>>
>>No, please read the comment in the code about why this is the way it is.
>>The code is correct as is.
>>
> 
> 
> Why don't we clean this up as in the proposed attached patch (against
> 2.6.10).  Compile-tested only.

Let's clean up the spelling as well
> 
> - --
> Mike Waychison
> Sun Microsystems, Inc.
> 1 (650) 352-5299 voice
> 1 (416) 202-8336 voice
> 

> Index: linux-2.6.10/drivers/base/driver.c
> ===================================================================
> --- linux-2.6.10.orig/drivers/base/driver.c	2004-12-24 16:35:25.000000000 -0500
> +++ linux-2.6.10/drivers/base/driver.c	2005-01-25 02:16:31.000000000 -0500
> @@ -79,14 +79,14 @@ void put_driver(struct device_driver * d
>   *	since most of the things we have to do deal with the bus
>   *	structures.
>   *
> - *	The one interesting aspect is that we initialize @drv->unload_sem
> - *	to a locked state here. It will be unlocked when the driver
> - *	reference count reaches 0.
> + *	The one interesting aspect is that we setup @drv->unloaded
> + *	as a completion that gets complete when the driver reference 
> + *	count reaches 0.
>   */
>  int driver_register(struct device_driver * drv)
>  {
>  	INIT_LIST_HEAD(&drv->devices);
> -	init_MUTEX_LOCKED(&drv->unload_sem);
> +	init_completion(&drv->unloaded);
>  	return bus_add_driver(drv);
>  }
>  
> @@ -97,7 +97,7 @@ int driver_register(struct device_driver
>   *
>   *	Again, we pass off most of the work to the bus-level call.
>   *
> - *	Though, once that is done, we attempt to take @drv->unload_sem.
> + *	Though, once that is done, we wait until @drv->unloaded is copmleted.
------------------------------------------------------------------>completed
>   *	This will block until the driver refcount reaches 0, and it is
>   *	released. Only modular drivers will call this function, and we
>   *	have to guarantee that it won't complete, letting the driver

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
