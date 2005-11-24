Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbVKXCBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbVKXCBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 21:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVKXCBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 21:01:39 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:41039 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932584AbVKXCBi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 21:01:38 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.6.14.2] Updated itmtouch kernel usb input driver (1/1)
Date: Wed, 23 Nov 2005 21:01:33 -0500
User-Agent: KMail/1.8.3
Cc: Hans-Christian Egtvedt <hc@mivu.no>, LKML <linux-kernel@vger.kernel.org>,
       linux-input@atrey.karlin.mff.cuni.cz
References: <1132764764.6394.14.camel@charlie.egtvedt.no> <20051123165813.GA3201@ucw.cz>
In-Reply-To: <20051123165813.GA3201@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511232101.33783.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 11:58, Vojtech Pavlik wrote:
> >  static int itmtouch_open(struct input_dev *input)
> >  {
> >       struct itmtouch_dev *itmtouch = input->private;
> >  
> > +     if (itmtouch->users++)
> > +             return 0;
> > +

Why are you adding this? input_open/close are serialized and called
only once when needed.

> >       itmtouch->readurb->dev = itmtouch->usbdev;
> >  
> >       if (usb_submit_urb(itmtouch->readurb, GFP_KERNEL))
> > +     {
> > +             itmtouch->users--;
> >               return -EIO;
> > +     }
> >  

Brace should go on the same line with "if".

> > -     usb_to_input_id(udev, &itmtouch->inputdev.id);
> > +     itmtouch->inputdev.id.bustype = BUS_USB;
> > +     itmtouch->inputdev.id.vendor = udev->descriptor.idVendor;
> > +     itmtouch->inputdev.id.product = udev->descriptor.idProduct;
> > +     itmtouch->inputdev.id.version = udev->descriptor.bcdDevice;
> >       itmtouch->inputdev.dev = &intf->dev;

Why are you replacing perfectly good code with incorrect one (endianess
issues)?

Plus you need to convert it to dynamic input_dev allocation for newer
kernels. 

-- 
Dmitry
