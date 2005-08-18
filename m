Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbVHRTu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVHRTu0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 15:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVHRTu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 15:50:26 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:53150 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932412AbVHRTuX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 15:50:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YL28B+dOG4FRcY1M/VJaA2yujlog9/LgEJG90YCr5kYkwKFLn60ZMrXG03OT1F9ySm0AUK+lsaLfrs8chYDmA7ZR34PnM93CyRYbKzses5m4oVACuobxGr4a1ZM/ixQ4gpTv1qvhaUqhzk5MbaqE3bktSytMS3xMdz5ie9KTAcY=
Message-ID: <d120d500050818125031d1bc98@mail.gmail.com>
Date: Thu, 18 Aug 2005 14:50:19 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] add transport class symlink to device object
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Matthew Wilcox <matthew@wil.cx>, James.Smart@emulex.com,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk@arm.linux.org.uk>, Dmitry Torokhov <dtor@mail.ru>
In-Reply-To: <20050818063712.GA25321@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AD35@xbl3.ma.emulex.com>
	 <20050813213955.GB19235@kroah.com>
	 <20050814150231.GA9466@parcelfarce.linux.theplanet.co.uk>
	 <1124145677.5089.68.camel@mulgrave> <20050818052311.GD29301@kroah.com>
	 <20050818063712.GA25321@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/05, Greg KH <greg@kroah.com> wrote:
> @@ -500,9 +519,13 @@ int class_device_add(struct class_device
>        }
> 
>        class_device_add_attrs(class_dev);
> -       if (class_dev->dev)
> +       if (class_dev->dev) {
> +               class_name = make_class_name(class_dev);
>                sysfs_create_link(&class_dev->kobj,
>                                  &class_dev->dev->kobj, "device");
> +               sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
> +                                 class_name);
> +       }
> 

I wonder if we need to grab a reference to class_dev->dev here:

        dev = device_get(class_dev->dev);
        if (dev) {
             ....
        }

Otherwise, if device gets unregistered/deleted before class device is
deleted we'll get into trouble when removing the link since
class_dev->dev will be garbage.

.. But grabbing that reference will cause pains in SCSI system which,
when I looked, removed class devices from device's release function.

-- 
Dmitry
