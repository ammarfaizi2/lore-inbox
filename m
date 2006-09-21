Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWIUOo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWIUOo2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 10:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWIUOo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 10:44:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:20103 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751009AbWIUOo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 10:44:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vapg6XKI+Ok8mTEDbIm4p652QB30NpXH3lDfcQr9aWVZnPa4tBB2pJRdBUMiVLqEhTtWfz+vbUeaDldrEWQ0hn34itdnQr4+YYO1xQ8h9LuFiex96hiEbZu2892a8BN3SSaNIK1EEsjDtIXb6/x+gmiaaNSf5NLEm2KAVgr/FBI=
Message-ID: <d120d5000609210744w4c52bcf0qda2c3b9f12d4c2d3@mail.gmail.com>
Date: Thu, 21 Sep 2006 10:44:24 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Rolf Eike Beer" <eike-kernel@sf-tec.de>
Subject: Re: [RTC] Remove superfluous call to call to cdev_del()
Cc: "Alessandro Zummo" <alessandro.zummo@towertech.it>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Jonathan Corbet" <corbet@lwn.net>
In-Reply-To: <200609211030.07944.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609210946.06924.eike-kernel@sf-tec.de>
	 <20060921095619.0b2f1774@inspiron>
	 <200609211030.07944.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> Alessandro Zummo wrote:
> > On Thu, 21 Sep 2006 09:46:06 +0200
> >
> > Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > > If cdev_add() fails there is no good reason to call cdev_del().
> > >
> > > Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
> > >
> > >     rtc->char_dev.owner = rtc->owner;
> > >
> > >     if (cdev_add(&rtc->char_dev, MKDEV(MAJOR(rtc_devt), rtc->id), 1)) {
> > > -           cdev_del(&rtc->char_dev);
> > >             dev_err(class_dev->dev,
> > >                     "failed to add char device %d:%d\n",
> > >                     MAJOR(rtc_devt), rtc->id);
> >
> >  I'm not sure.. this is drivers/char/raw.c:
> >
> >
> >  cdev_init(&raw_cdev, &raw_fops);
> >         if (cdev_add(&raw_cdev, dev, MAX_RAW_MINORS)) {
> >                 kobject_put(&raw_cdev.kobj);
> >                 unregister_chrdev_region(dev, MAX_RAW_MINORS);
> >                 goto error;
> >         }
> >
> >  in case of failure, it does a kobject_put.
> >  tha same call is done by cdev_del.

But cdev_del also tries to do kobj_unmap before doing kobject_put. If
cdev_add fails the object is not added to the map so we shoult not try
to unmap it (although it does not hurt in the current implementation).

>
> This is unneeded here as it's embedded into struct rtc_device. Jonathan?
>

cdev distingueshes between stattically and synamically allocated
objects and so it is safe to do kobject_put/cdev_del even on cdevs
embedded into other structures.

> >  other drivers have implemented different error paths.
> >  which one is correct?
>

raw.c seems to be DTRT.

> Probably half of them are wrong, ugly or both. I think this interface is not
> very intuitive at all. This two calls needed to set up an embedded cdev are
> IMHO the best way to keep people confused. At least the (possible) need to
> call cdev_del() on failed cdev_add() is just weird.
>

The rule is simple - after cdev_init/cdev_alloc call kobject_put.
After successful cdev_add call cdev_del.

-- 
Dmitry
