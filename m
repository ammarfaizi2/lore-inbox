Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264191AbUE2Ior@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264191AbUE2Ior (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 04:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbUE2Ioq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 04:44:46 -0400
Received: from mail.homelink.ru ([81.9.33.123]:22490 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S264191AbUE2Io0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 04:44:26 -0400
Date: Sat, 29 May 2004 12:44:21 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: two patches - request for comments
Message-Id: <20040529124421.28c776cc.zap@homelink.ru>
In-Reply-To: <20040528221006.GB13851@kroah.com>
References: <20040529012030.795ad27e.zap@homelink.ru>
	<20040528221006.GB13851@kroah.com>
Organization: home
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2004 15:10:06 -0700
Greg KH <greg@kroah.com> wrote:

> 	- you create the DEVICE_ATTR macro, why not use the one already
> 	  created for you (CLASS_DEVICE_ATTR will work I think.)
Because it would involve unneeded extra garbage into data segment. See:

CLASS_DEVICE_ATTR(_name,_mode,_show,_store) is:
struct class_device_attribute class_device_attr_##_name = {
  ...
}

DECLARE_ATTR is just:
{ ... }

This way, I cannot use CLASS_DEVICE_ATTR for things like:

static struct class_device_attribute bl_class_device_attributes[] = {
	DECLARE_ATTR(...),
	DECLARE_ATTR(...),
	...
};

Instead, I must declare it this way:

CLASS_DEVICE_ATTR(blah1)
CLASS_DEVICE_ATTR(blah2)
CLASS_DEVICE_ATTR(blah3)

and after that:

struct class_device_attribut *blah_ptr [] = {
	blah1, blah2, blah3
};

The second array is absolutely unneeded here (one garbage pointer for every
device attribute plus alignment), since the array is absolutely static. And
even worse, the array cannot be declared __initdata since devices can
register and unregister at any time.

> 	- Don't do a unregister function by passing a string to it.
> 	  Explicitly pass the pointer of the object that you want to
> 	  unregister, like all other kernel interfaces do.  With that
> 	  change you no longer need the class_find_device() patch,
> 	  right?
No. class_find_device was written for lcd_find_device() and
backlight_find_device() (framebuffer devices use them). On the other hand,
the driver that registers the backlight device doesn't have a pointer to the
class device (well, the lcd_register_device could return it). Since the
lcd/backlight names are unique anyway, I don't see any problems with that, and
moreover, it is *registered* by giving it a name, why it should be
unregistered in a different way?

In any case, if you have strong objections against that, this could be changed
of course. But again, it will result in more useless code/data (the driver
will have to store somewhere the device it has registered, or alternatively,
use lcd/backlight_device_find()).

> 	- How about some drivers that actually use this interface?
> 	  Again, you are creating interfaces with no examples of users
> 	  of the interface, which isn't acceptable.
There are already four drivers that implement the lcd/backlight devices (for
Dell Axim X5, iPAQ 2210, Jornada 560, Rover P5), and three framebuffer devices
that were modified to use it (sa1100fb, pxafb and mq1100fb). I would paste
them here but they are quite large, and I wouldn't like to pollute this list,
it's so high-traffic already.

Instead, you can download them from
http://zap.eltrast.ru/data/backlight-lcd-class-devices.tar.bz2 (~33k).

The full sources are in handhelds.org' public CVS
(:pserver:anoncvs@cvs.handhelds.org:/cvs, repository linux/kernel26).

--
Greetings,
   Andrew
