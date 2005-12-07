Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbVLGW70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbVLGW70 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbVLGW70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:59:26 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:7530 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030429AbVLGW70 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:59:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K+O2FOptvT/BQaIq6TQ4lttcVTLLfpdYyL7P8uU2PNb0OlUU8Y5fHaOKiUD7g0TZcVtt/NTJmPg2k/d+0nXXi30nPnjLSUGWbsKGafpm9L5WBNbsz4Q57N53vQmpunB9R5yLKdGvneg58q4ZSVzcs+bfttskfim/cp3y3/k42E0=
Message-ID: <d120d5000512071459s9b461d8ye7abc41d0e1950fd@mail.gmail.com>
Date: Wed, 7 Dec 2005 17:59:24 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051207225126.GA648@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051205212337.74103b96.khali@linux-fr.org>
	 <20051205202707.GH15201@flint.arm.linux.org.uk>
	 <200512070105.40169.dtor_core@ameritech.net>
	 <d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com>
	 <20051207180842.GG6793@flint.arm.linux.org.uk>
	 <d120d5000512071023u151c42f4lcc40862b2debad73@mail.gmail.com>
	 <20051207190352.GI6793@flint.arm.linux.org.uk>
	 <d120d5000512071418q521d2155r81759ef8993000d8@mail.gmail.com>
	 <20051207225126.GA648@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Greg KH <greg@kroah.com> wrote:
> On Wed, Dec 07, 2005 at 05:18:40PM -0500, Dmitry Torokhov wrote:
> > On 12/7/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> > > Unregistering is just a matter of calling platform_device_unregister().
> > > An unregister call is a del + put in exactly the same way as it is
> > > throughout the rest of the driver model.
> > >
> >
> > Yes, and it works just fine everywhere except in initialization code
> > when you need to jump in the middle of _del + _put sequence.
>
> So, if you had _del, would it work easier for you?  I just objected to
> it if it wasn't necessary.  I didn't want to add functions that aren't
> used by anyone, but if is needed, I don't see a problem with it.
>

Yes, the I can just write:

        ...
        err = platform_driver_register(&i8042_driver);
        if (err)
                goto err_controller_cleanup;

        i8042_platform_device = platform_device_alloc("i8042", -1);
        if (!i8042_platform_device) {
                err = -ENOMEM;
                goto err_unregister_driver;
        }

        err = platform_device_add(i8042_platform_device);
        if (err)
                goto err_free_device;
        ...

        if (!have_ports) {
                err = -ENODEV;
                goto err_delete_device;
        }

        mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
        return 0;

 err_delete_device:
        platform_device_del(i8042_platform_device);
 err_free_device:
        platform_device_put(i8042_platform_device);
 err_unregister_driver:
        platform_driver_unregister(&i8042_driver);
 ....

As you can see - single cleanup path..

--
Dmitry
