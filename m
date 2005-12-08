Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbVLHUvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVLHUvD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVLHUvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:51:03 -0500
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:5381 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751056AbVLHUvB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:51:01 -0500
Date: Thu, 8 Dec 2005 21:52:57 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] Minor change to platform_device_register_simple
 prototype
Message-Id: <20051208215257.78d7c67a.khali@linux-fr.org>
In-Reply-To: <d120d5000512071459s9b461d8ye7abc41d0e1950fd@mail.gmail.com>
References: <20051205212337.74103b96.khali@linux-fr.org>
	<20051205202707.GH15201@flint.arm.linux.org.uk>
	<200512070105.40169.dtor_core@ameritech.net>
	<d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com>
	<20051207180842.GG6793@flint.arm.linux.org.uk>
	<d120d5000512071023u151c42f4lcc40862b2debad73@mail.gmail.com>
	<20051207190352.GI6793@flint.arm.linux.org.uk>
	<d120d5000512071418q521d2155r81759ef8993000d8@mail.gmail.com>
	<20051207225126.GA648@kroah.com>
	<d120d5000512071459s9b461d8ye7abc41d0e1950fd@mail.gmail.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmirty, Russell, Greg,

> On 12/7/05, Greg KH <greg@kroah.com> wrote:
> > So, if you had _del, would it work easier for you?  I just objected to
> > it if it wasn't necessary.  I didn't want to add functions that aren't
> > used by anyone, but if is needed, I don't see a problem with it.
> 
> Yes, the I can just write:
> 
>         ...
>         err = platform_driver_register(&i8042_driver);
>         if (err)
>                 goto err_controller_cleanup;
> 
>         i8042_platform_device = platform_device_alloc("i8042", -1);
>         if (!i8042_platform_device) {
>                 err = -ENOMEM;
>                 goto err_unregister_driver;
>         }
> 
>         err = platform_device_add(i8042_platform_device);
>         if (err)
>                 goto err_free_device;
>         ...
> 
>         if (!have_ports) {
>                 err = -ENODEV;
>                 goto err_delete_device;
>         }
> 
>         mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
>         return 0;
> 
>  err_delete_device:
>         platform_device_del(i8042_platform_device);
>  err_free_device:
>         platform_device_put(i8042_platform_device);
>  err_unregister_driver:
>         platform_driver_unregister(&i8042_driver);
>  ....
> 
> As you can see - single cleanup path..

I second Dmitry's request here. I can't seem to possibly build a valid
error path during device registration with the current API. Having
platform_device_del() would make it possible.

BTW, doesn't this suggest that the error path in
platform_device_register_simple() is currently broken as well? If
platform_device_add() fails therein, I take it that the resources
previously allocated by platform_device_add_resources() will never be
freed.

-- 
Jean Delvare
