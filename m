Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263810AbUFQVzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbUFQVzL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 17:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbUFQVzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 17:55:11 -0400
Received: from mail.homelink.ru ([81.9.33.123]:52639 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S263810AbUFQVzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 17:55:06 -0400
Date: Fri, 18 Jun 2004 01:55:04 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [1]
Message-Id: <20040618015504.661a50a9.zap@homelink.ru>
In-Reply-To: <20040617194739.GA15983@kroah.com>
References: <20040617223514.2e129ce9.zap@homelink.ru>
	<20040617194739.GA15983@kroah.com>
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

On Thu, 17 Jun 2004 12:47:39 -0700
Greg KH <greg@kroah.com> wrote:

> So no, I'm not going to accept this, you need to change your lcd code to
> pass around pointers to the proper structures, instead of trying to rely
> on the name of a device.  Because of this, I'm not going to apply your
> second patch.
I think you missed something. It doesn't rely on the name of the device while
registering/unregistering, I've changed this, look:

extern int lcd_device_register(const char *name, void *devdata,
                              struct lcd_properties *lp,
                              struct lcd_device **alloc_ld);
extern void lcd_device_unregister(struct lcd_device *ld);

So the `register` function returns a pointer (fourth argument) to the created
and registered device, and in module_unload it calls something like
lcd_device_unregister (my_lcd_device). The name is passed during registration
because it has to be copied to the allocated struct device (and so that
find_device_by_name() can find the device by name).

Now this:

extern struct lcd_device *lcd_device_find(const char *name);

It needs a char* argument because there's no other easy way to find the
correspondence between framebuffer devices and lcd/backlight devices
corresponding to that framebuffer device. So the conventionality is that the
lcd/backlight devices bear the same name as the framebuffer they correspond
to, so the framebuffer device can easily find them.

Same reasons apply to backlight devices, they are quite similar.

--
Greetings,
   Andrew
