Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbVIAF5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbVIAF5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 01:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbVIAF5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 01:57:23 -0400
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:37789 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964993AbVIAF5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 01:57:22 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] add transport class symlink to device object
Date: Thu, 1 Sep 2005 00:57:04 -0500
User-Agent: KMail/1.8.2
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Matthew Wilcox <matthew@wil.cx>, James.Smart@emulex.com,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk@arm.linux.org.uk>, Dmitry Torokhov <dtor@mail.ru>
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AD35@xbl3.ma.emulex.com> <d120d500050818125031d1bc98@mail.gmail.com> <20050831214307.GE20443@kroah.com>
In-Reply-To: <20050831214307.GE20443@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509010057.06479.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 August 2005 16:43, Greg KH wrote:
> On Thu, Aug 18, 2005 at 02:50:19PM -0500, Dmitry Torokhov wrote:
> > On 8/18/05, Greg KH <greg@kroah.com> wrote:
> > > @@ -500,9 +519,13 @@ int class_device_add(struct class_device
> > >        }
> > > 
> > >        class_device_add_attrs(class_dev);
> > > -       if (class_dev->dev)
> > > +       if (class_dev->dev) {
> > > +               class_name = make_class_name(class_dev);
> > >                sysfs_create_link(&class_dev->kobj,
> > >                                  &class_dev->dev->kobj, "device");
> > > +               sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
> > > +                                 class_name);
> > > +       }
> > > 
> > 
> > I wonder if we need to grab a reference to class_dev->dev here:
> > 
> >         dev = device_get(class_dev->dev);
> >         if (dev) {
> >              ....
> >         }
> > 
> > Otherwise, if device gets unregistered/deleted before class device is
> > deleted we'll get into trouble when removing the link since
> > class_dev->dev will be garbage.
> > 
> > .. But grabbing that reference will cause pains in SCSI system which,
> > when I looked, removed class devices from device's release function.
> 
> No the sysfs_create_link() call increments the kobject reference on the
> target of the symlink.  See sysfs_add_link() for details.  So this
> should be just fine, right?
>

Yes, you are right. Sorry for the moise.

-- 
Dmitry
