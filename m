Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317270AbSGIAHJ>; Mon, 8 Jul 2002 20:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317271AbSGIAHI>; Mon, 8 Jul 2002 20:07:08 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:14866 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317270AbSGIAHH>;
	Mon, 8 Jul 2002 20:07:07 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Driverfs updates 
In-reply-to: Your message of "Mon, 08 Jul 2002 17:52:13 CST."
             <Pine.LNX.4.44.0207081745150.10105-100000@hawkeye.luckynet.adm> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Jul 2002 10:09:37 +1000
Message-ID: <22049.1026173377@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2002 17:52:13 -0600 (MDT), 
Thunder from the hill <thunder@ngforever.de> wrote:
>Hi,
>
>On Tue, 9 Jul 2002, Keith Owens wrote:
>> struct device_driver * get_driver(struct device_driver * drv)
>> {
> +        struct device_driver *ret = NULL;
> +
> +        if (!drv)
> +                goto out;
> +        lock_somehow(drv->lock);
> +        if (drv->owner)
>>                 if (!try_inc_mod_count(drv->owner))
> +                        goto out;
> +
> +        ret = drv;
> + out:
> +        unlock_somehow(drv->lock);
> +        return ret;
>> }
>> 
>> I suggest you add a global driverfs_lock.
>
>Better than locking all kernel threads, isn't it?

What protects drv in that code?  drv is a dynamically registered object
and can be dynamically unregistered and freed at any time from another
cpu, or even the same cpu with preempt.  Any reference to drv without
an external lock or a reference count on the module that registered drv
is racy.  In particular, you cannot use drv->anything to protect drv!

The global driverfs_lock is required to protect the bus/drv list
against changes while you are processing an entry on the list AND that
entry is in a module with a use count of 0.  In that state, you have an
uncounted reference to module data which must be protected until you
can set the use count, at which point the use count will take over and
protect the structure.

Did I mention that this method is complex and fragile?

