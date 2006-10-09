Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751710AbWJIJcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbWJIJcL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 05:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbWJIJcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 05:32:10 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:24465 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751710AbWJIJcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 05:32:09 -0400
Date: Mon, 9 Oct 2006 11:32:42 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: akinobu.mita@gmail.com (Akinobu Mita)
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH] driver core: handle bus_attach_device() failure
Message-ID: <20061009113242.08ab11f0@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061009091201.GA6448@localhost>
References: <20061009091201.GA6448@localhost>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006 18:12:01 +0900,
akinobu.mita@gmail.com (Akinobu Mita) wrote:

> This patch handles bus_attach_device() failure in device_add().
> 
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
>  drivers/base/core.c |   22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> Index: 2.6-mm/drivers/base/core.c
> ===================================================================
> --- 2.6-mm.orig/drivers/base/core.c	2006-10-03 22:58:40.000000000 +0900
> +++ 2.6-mm/drivers/base/core.c	2006-10-09 16:57:52.000000000 +0900
> @@ -530,7 +530,9 @@ int device_add(struct device *dev)
>  	if ((error = bus_add_device(dev)))
>  		goto BusError;
>  	kobject_uevent(&dev->kobj, KOBJ_ADD);
> -	bus_attach_device(dev);
> +	if ((error = bus_attach_device(dev)))
> +		goto BusAttachError;
> +
>  	if (parent)
>  		klist_add_tail(&dev->knode_parent, &parent->klist_children);
>  
> @@ -548,6 +550,8 @@ int device_add(struct device *dev)
>   Done:
>  	put_device(dev);
>  	return error;
> + BusAttachError:
> +	bus_remove_device(dev);
>   BusError:
>  	device_pm_remove(dev);
>   PMError:

This won't quite work :)

See also
http://marc.theaimsgroup.com/?l=linux-kernel&m=116008235424179&w=2 ff.
for a discussion on it. I'll send an updated patch soon :)

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
