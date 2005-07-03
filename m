Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVGCEzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVGCEzT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 00:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVGCEzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 00:55:19 -0400
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:3500 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261361AbVGCEzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 00:55:01 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: matthieu castet <castet.matthieu@free.fr>
Subject: Re: device_remove_file and disconnect
Date: Sat, 2 Jul 2005 23:54:51 -0500
User-Agent: KMail/1.8.1
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>
References: <42C2D354.6060607@free.fr> <42C456B0.6010706@free.fr> <42C722F9.8060809@free.fr>
In-Reply-To: <42C722F9.8060809@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507022354.52015.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 July 2005 18:27, matthieu castet wrote:
> Hi,
> matthieu castet wrote:
> >>
> >>
> >> Then they should be fixed.  Any specific examples?
> >>
> >>
> > I am a little lasy to list all, but some drivers in driver/usb should 
> > have this problem : the first driver I look : ./misc/phidgetkit.c do 
> > [1]. So sysfs read don't check if to_usb_interface or usb_get_intfdata 
> > return NULL pointer...
> > And it is a bit your fault, as many developper should have read your 
> > great tutorial [2] ;)
> > 
> >>> Also I always see driver free their privatre data in device disconnect,
> >>> so if read/write from sysfs aren't serialized with device disconnect
> >>> there are still a possible race like I show in my example.
> >>
> >>
> >>
> >> Yes, you are correct.  Again, any specific drivers you see with this
> >> problem?
> > 
> > I believe near all drivers that use sysfs via device_create_file, as I 
> > never see them use mutex in read/write in order to check there aren't in 
> > the same time in their disconnect that could free there private data 
> > when they do operation on it...
> > 
> > 
> > Couldn't be possible the make device_remove_file blocking until all the 
> > open file are closed ?
> >

I don't think we want "rmmod <moudule> < /sys/..../attribute" wedge the box.
 
> > thanks,
> > 
> > Matthieu
> > 
> > [1]
> > #define show_input(value)       \
> > static ssize_t show_input##value(struct device *dev, char *buf) \
> > {                                                                       \
> >         struct usb_interface *intf = to_usb_interface(dev);             \
> >         struct phidget_interfacekit *kit = usb_get_intfdata(intf);      \
> >                                                                         \
> >         return sprintf(buf, "%d\n", kit->inputs[value - 1]);            \
> > }                                                                       \
> > static DEVICE_ATTR(input##value, S_IRUGO, show_input##value, NULL);
> > 
> > [2] http://www.linuxjournal.com/article/7353
> > 
> 
> So will there be a fix in the kernel, or all this driver are broken and 
> should be fixed ?
> 

I think the drivers should be fixed, most likely with the help of bus code
they are on.

-- 
Dmitry
