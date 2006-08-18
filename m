Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWHRNCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWHRNCn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 09:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWHRNCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 09:02:43 -0400
Received: from vena.lwn.net ([206.168.112.25]:16527 "HELO lwn.net")
	by vger.kernel.org with SMTP id S1751275AbWHRNCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 09:02:42 -0400
Message-ID: <20060818130242.12410.qmail@lwn.net>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: cdev documentation (was Drop second arg of unregister_chrdev()) 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Fri, 18 Aug 2006 09:15:28 +0200."
             <200608180915.28763.eike-kernel@sf-tec.de> 
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Date: Fri, 18 Aug 2006 07:02:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:

> Nevertheless, I ported my driver to the new interface. I see it cdev_add() 
> succeeding, but the device never shows up in sysfs. Do I have to do any more 
> tricks with class devices and stuff?

Yes, cdevs do not, themselves, show up in sysfs.  A simple class is what
you want for that part of the job.

> While I was sneaking around in the code I found this drivers/char/tty_io:3093
> 
>         cdev_init(&driver->cdev, &tty_fops);
>         driver->cdev.owner = driver->owner;
>         error = cdev_add(&driver->cdev, dev, driver->num);
>         if (error) {
>                 cdev_del(&driver->cdev);
> 
> Isn't the call to cdev_del() just wrong here?

It is correct, in that it returns the reference you hold to the cdev's
internal kobject.  If you got the cdev with cdev_alloc(), that's the
only way it will get returned to the system.  For a cdev allocated
elsewhere (as is the case here) it probably doesn't make any difference.

jon
