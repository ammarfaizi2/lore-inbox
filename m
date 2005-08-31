Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbVIAA0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbVIAA0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 20:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbVIAA0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 20:26:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:39323 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965002AbVIAA0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 20:26:22 -0400
Date: Wed, 31 Aug 2005 14:43:07 -0700
From: Greg KH <greg@kroah.com>
To: dtor_core@ameritech.net
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Matthew Wilcox <matthew@wil.cx>, James.Smart@emulex.com,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk@arm.linux.org.uk>, Dmitry Torokhov <dtor@mail.ru>
Subject: Re: [PATCH] add transport class symlink to device object
Message-ID: <20050831214307.GE20443@kroah.com>
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AD35@xbl3.ma.emulex.com> <20050813213955.GB19235@kroah.com> <20050814150231.GA9466@parcelfarce.linux.theplanet.co.uk> <1124145677.5089.68.camel@mulgrave> <20050818052311.GD29301@kroah.com> <20050818063712.GA25321@kroah.com> <d120d500050818125031d1bc98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050818125031d1bc98@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 02:50:19PM -0500, Dmitry Torokhov wrote:
> On 8/18/05, Greg KH <greg@kroah.com> wrote:
> > @@ -500,9 +519,13 @@ int class_device_add(struct class_device
> >        }
> > 
> >        class_device_add_attrs(class_dev);
> > -       if (class_dev->dev)
> > +       if (class_dev->dev) {
> > +               class_name = make_class_name(class_dev);
> >                sysfs_create_link(&class_dev->kobj,
> >                                  &class_dev->dev->kobj, "device");
> > +               sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
> > +                                 class_name);
> > +       }
> > 
> 
> I wonder if we need to grab a reference to class_dev->dev here:
> 
>         dev = device_get(class_dev->dev);
>         if (dev) {
>              ....
>         }
> 
> Otherwise, if device gets unregistered/deleted before class device is
> deleted we'll get into trouble when removing the link since
> class_dev->dev will be garbage.
> 
> .. But grabbing that reference will cause pains in SCSI system which,
> when I looked, removed class devices from device's release function.

No the sysfs_create_link() call increments the kobject reference on the
target of the symlink.  See sysfs_add_link() for details.  So this
should be just fine, right?

thanks,

greg k-h
