Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTKJKTw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 05:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbTKJKTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 05:19:52 -0500
Received: from f21.mail.ru ([194.67.57.54]:7684 "EHLO f21.mail.ru")
	by vger.kernel.org with ESMTP id S262491AbTKJKTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 05:19:50 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Greg KH=?koi8-r?Q?=22=20?= <greg@kroah.com>
Cc: rusty@rustcorp.com.au, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re[2]: file2alias - incorrect=?koi8-r?Q?=3F=20?=aliases for USB
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Mon, 10 Nov 2003 13:26:39 +0300
In-Reply-To: <20031110093703.GA5449@kroah.com>
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1AJ9Fn-000PHf-00.arvidjaar-mail-ru@f21.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----

> 
> On Sun, Nov 09, 2003 at 09:55:19PM +0300, Andrey Borzenkov wrote:
> > file2aliases puts in alias device ID high and low numbers directly from match 
> > specifications. E.g. for this match table entry:
> > 
> > usb-storage          0x000f      0x04e6   0x0006    0x0100       0x0205 ...
> > 
> > it generates alias
> > 
> > alias usb:v04E6p0006dl0100dh0205dc*dsc*dp*ic*isc*ip* usb_storage
> > 
> > unfortunately real device attribute does not include high and low - rather it 
> > has single device ID (as part of PRODUCT) that should be contained in these 
> > bounds:
> > 
> >         length += snprintf (scratch, buffer_size - length, "PRODUCT=%x/%x/%x",
> >                             usb_dev->descriptor.idVendor,
> >                             usb_dev->descriptor.idProduct,
> >                             usb_dev->descriptor.bcdDevice);
> > 
> > or bcdDevice file in sysfs.
> > 
> > This makes those aliases rather useless for the purpose of matching reported 
> > device. It may take the same route as PCI and reject all device ID table 
> > entries that have High != Low but there are quite a few of them available.
> > 
> > I am rather confused because I do not see how this condition (low <= bcdDevice 
> > <= high) can be expressed using simple glob pattern (unless we are going to 
> > take glob library from Zsh :)
> 
> I would suggest just ignoring the bcdDevice value, and loading all
> modules that match the idVendor and idProduct values, and let the kernel
> sort it out :)
> 
> So for your example, you would just:
> 	modprobe usb:v04E6p0006dl*dh*dc*dsc*dp*ic*isc*ip* 
> 

any reason we put in alias fields that apparently won't be used
at all?

> Hm, but that's no good either, because the visor driver trips over that
> with its entry:
> 	MODULE_ALIAS("usb:v*p*dl*dh*dc*dsc*dp*ic*isc*ip*");
> and the improper module is loaded.  That needs to be fixed up...
> 
> Rusty, any reason why the module alias code is turning an empty
> MODULE_PARAM structure, as is declared in drivers/usb/serial/visor.c
> with the line:
>         { },                                    /* optional parameter entry */ 
> 
> Into the above MODULE_ALIAS?  I don't think that's correct.
> 

Subject:  [PATCH][2.6.0-test9] prevent catch-all USB aliases in modules.alias

http://marc.theaimsgroup.com/?l=linux-kernel&m=106787897124700&w=2

regards

-andrey

