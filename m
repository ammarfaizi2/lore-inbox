Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbWHRNtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWHRNtv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 09:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWHRNtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 09:49:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:20509 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030227AbWHRNtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 09:49:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MiuuiNoD0L3ym2UoJ9DjTS/qnUyg3bw3PT+RangkooUXMWWuBR626mIj3F0mO5pZkYhJna4ThvcnkC3YZosPzlkJXadjTQsppYphXDHOKG+im1Zw8FM/q758wu2g8tygSS1KGuxICe/TDPpGCiihUXLH940qt8ZIp8aCOrg+Xto=
Message-ID: <d120d5000608180649s20dfa64ldcc3dae1ebc97012@mail.gmail.com>
Date: Fri, 18 Aug 2006 09:49:45 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Jonathan Corbet" <corbet@lwn.net>
Subject: Re: cdev documentation (was Drop second arg of unregister_chrdev())
Cc: "Rolf Eike Beer" <eike-kernel@sf-tec.de>,
       "Alexey Dobriyan" <adobriyan@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060818130242.12410.qmail@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608180915.28763.eike-kernel@sf-tec.de>
	 <20060818130242.12410.qmail@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/06, Jonathan Corbet <corbet@lwn.net> wrote:
> Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
>
> > Nevertheless, I ported my driver to the new interface. I see it cdev_add()
> > succeeding, but the device never shows up in sysfs. Do I have to do any more
> > tricks with class devices and stuff?
>
> Yes, cdevs do not, themselves, show up in sysfs.  A simple class is what
> you want for that part of the job.
>
> > While I was sneaking around in the code I found this drivers/char/tty_io:3093
> >
> >         cdev_init(&driver->cdev, &tty_fops);
> >         driver->cdev.owner = driver->owner;
> >         error = cdev_add(&driver->cdev, dev, driver->num);
> >         if (error) {
> >                 cdev_del(&driver->cdev);
> >
> > Isn't the call to cdev_del() just wrong here?
>
> It is correct, in that it returns the reference you hold to the cdev's
> internal kobject.  If you got the cdev with cdev_alloc(), that's the
> only way it will get returned to the system.  For a cdev allocated
> elsewhere (as is the case here) it probably doesn't make any difference.
>

This is not a good practice though because it will attempt to unmap
device that is not mapped. Depeneding on changes in kmap code (for
example adding checks for regions being busy) blindly calling unmap
could unmap some other cdev. For dynamically allocated objects calling
kobject_put(&cdev->kobj) would be more correct but not very nice.

-- 
Dmitry
