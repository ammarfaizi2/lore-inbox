Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263629AbUFRF4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbUFRF4L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 01:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbUFRF4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 01:56:11 -0400
Received: from mail.homelink.ru ([81.9.33.123]:19338 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S263629AbUFRF4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 01:56:00 -0400
Date: Fri, 18 Jun 2004 09:55:59 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [1]
Message-Id: <20040618095559.20763766.zap@homelink.ru>
In-Reply-To: <20040617220510.GA4122@kroah.com>
References: <20040617223514.2e129ce9.zap@homelink.ru>
	<20040617194739.GA15983@kroah.com>
	<20040618015504.661a50a9.zap@homelink.ru>
	<20040617220510.GA4122@kroah.com>
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

On Thu, 17 Jun 2004 15:05:10 -0700
Greg KH <greg@kroah.com> wrote:

> That function should be:
> struct lcd_device lcd_device_register(const char *name, void *devdata,
> 					struct lcd_properties *lp);
> instead.  Then return an ERR_PTR() if you have an error.

Okay, that was the easy part. Fixed.

> > extern struct lcd_device *lcd_device_find(const char *name);
> > 
> > It needs a char* argument because there's no other easy way to find the
> > correspondence between framebuffer devices and lcd/backlight devices
> > corresponding to that framebuffer device.
> Then you need to have a way to corrispond those devices together,
> becides just a name.  Use the pointer that you have provided to link
> them together some way.

There's no place to stuff that pointer into, because the load order of the
framebuffer and lcd/backlight modules are not important (that's the reason for
the notification chain), and at the time l/b modules are loaded there can be
even no corresponding platform device (on my PDA for example, where platform
device is also registered from a module).

How about passing a pointer to struct dev, and a pointer to struct fbinfo to
every l/b driver and asking them if they are for this device or not? The
lcd/backlight device then could check anything they like inside the structs
and make their decision - they are bound to this fb device or not. This way,
the class_find_device() patch would not be needed anymore, and
lcd_find_device replaced instead by something like this:

struct lcd_device *lcd_device_find (struct device *ld, struct fbinfo *fb)
{
	struct class_device *class_dev;
	struct lcd_device *found = NULL;

	down_read (&lcd_class->subsys.rwsem);
	list_for_each_entry (class_dev, &lcd_class->children, node) {
		struct lcd_device *ld = to_lcd_device (class_dev);
		if (ld->props && (ld->props->check_device (ld, fb) == 0)) {
			found = lcd_device_get (ld);
			break;
		}
	}
	up_read (&lcd_class->subsys.rwsem);

	return found;
}

--
Greetings,
   Andrew
