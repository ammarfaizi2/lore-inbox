Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWGYIJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWGYIJG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 04:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWGYIJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 04:09:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58039 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751508AbWGYIJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 04:09:03 -0400
Date: Tue, 25 Jul 2006 01:08:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [Patch] [mm] More driver core fixes for -mm
Message-Id: <20060725010852.75afe430.akpm@osdl.org>
In-Reply-To: <20060721152000.5a59813a@gondolin.boeblingen.de.ibm.com>
References: <20060720165911.42603374@gondolin.boeblingen.de.ibm.com>
	<20060721152000.5a59813a@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2006 15:20:00 +0200
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> 
> I've looked some more into the __must_check stuff in the driver core,
> and tried to fix some functions (especially device_add() is a bit of a
> beast; I split off helper functions).

OK.

> Question: What is considered "good style" concerning symlinks? I would
> think I should remove symlinks I created, but most places don't seem to
> do this...

Removing symlinks seems like a good idea.  Leaving them around might cause
a subsequent driver load to fail due to EEXIST (assuming that the caller
checks error codes, as if).

I assume you're referring to error paths here?

> -- 
> Cornelia Huck
> Linux for zSeries Developer
> Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
> 
> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Fix missing checks of return codes for driver model functions called in
> the driver core.
> 
> Also fix bus_attach_device(), which didn't take into account that
> device_attach() may return 0 or 1 on success.
> 

Yes, this was nasty (oopses).

> @@ -401,13 +401,33 @@ int bus_attach_device(struct device * de
>  
>  	if (bus) {
>  		ret = device_attach(dev);
> -		if (ret == 0)
> +		if (ret >= 0)
>  			klist_add_tail(&dev->knode_bus, &bus->klist_devices);
>  	}

But I made bus_attach_device() convert the positive return value to zero. 
See
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/hot-fixes/drivers-base-check-errors-fix.patch.

Is there a reason to propagate this irritating "1" back out of
bus_attach_device() as well?
