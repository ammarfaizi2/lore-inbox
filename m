Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbUKPF60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUKPF60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 00:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbUKPF5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 00:57:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:42459 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261907AbUKPFz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 00:55:29 -0500
Date: Mon, 15 Nov 2004 21:52:24 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Tejun Heo <tj@home-tj.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.10-rc1 2/5] driver-model: bus_recan_devices() locking fix
Message-ID: <20041116055224.GF29328@kroah.com>
References: <20041104185826.GA17756@kroah.com> <d120d50004110508333c183cc1@mail.gmail.com> <20041110004052.GB8672@kroah.com> <200411092317.33300.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411092317.33300.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 11:17:31PM -0500, Dmitry Torokhov wrote:
> On Tuesday 09 November 2004 07:40 pm, Greg KH wrote:
> > > I think we just have lay down the rules that one needs to get a reference
> > > to an object in the following cases:
> > > - object creation (first reference)
> > > - linking some other object to the object in question. Every link to the
> > > ? object should increase reference count.
> > > - before passing object to another thread of execution to guarantee that
> > > ? the object will live long enough for both threads.
> > 
> > The rules are defined. ?See my OLS 2004 paper on krefs for details.
> > 
> 
> So that means you will patches like the one below, right?
> 
> diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
> --- a/drivers/base/driver.c	2004-11-09 23:16:43 -05:00
> +++ b/drivers/base/driver.c	2004-11-09 23:16:43 -05:00
> @@ -26,13 +26,7 @@
>  
>  int driver_create_file(struct device_driver * drv, struct driver_attribute * attr)
>  {
> -	int error;
> -	if (get_driver(drv)) {
> -		error = sysfs_create_file(&drv->kobj, &attr->attr);
> -		put_driver(drv);
> -	} else
> -		error = -EINVAL;
> -	return error;
> +	return sysfs_create_file(&drv->kobj, &attr->attr);
>  }
>  
>  
> @@ -44,10 +38,7 @@
>  
>  void driver_remove_file(struct device_driver * drv, struct driver_attribute * attr)
>  {
> -	if (get_driver(drv)) {
> -		sysfs_remove_file(&drv->kobj, &attr->attr);
> -		put_driver(drv);
> -	}
> +	sysfs_remove_file(&drv->kobj, &attr->attr);
>  }

While not totally necessary, the current code is safe :)

I'll ask Pat about this next time I see him.

thanks,

greg k-h
