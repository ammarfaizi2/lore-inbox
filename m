Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVBGSla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVBGSla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 13:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVBGSla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 13:41:30 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:44347 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261218AbVBGSlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 13:41:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=nknEhyMamYk9AWqgmH36oKfDpnH5m2TP+h/BnVfW7c9pNQYzQYaLy9L5pks7SYyX2gT93TvR/IVREYClY7DWRti3wUh44za+5sJaEUCElY0397IAW7kMxgYh10Ei+3oBShEQrtBbbRrFOl2RDcNHZO/Y1+QaOKuhLIHi7Ii5sy0=
Message-ID: <d4b3852050207104172d1b8d0@mail.gmail.com>
Date: Mon, 7 Feb 2005 19:41:25 +0100
From: Mikkel Krautz <krautz@gmail.com>
Reply-To: Mikkel Krautz <krautz@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling Interval
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20050207183818.GB2006@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050207154424.GB4742@omnipotens.localhost>
	 <20050207174303.GA3113@ucw.cz>
	 <d4b385205020709515d579934@mail.gmail.com>
	 <d4b3852050207095647c74baa@mail.gmail.com>
	 <20050207183818.GB2006@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, I'll send it in a bit!

Thanks,
Mikkel


On Mon, 7 Feb 2005 19:38:18 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Mon, Feb 07, 2005 at 06:56:50PM +0100, Mikkel Krautz wrote:
> > Sorry, I now realise that my way of doing this only sets
> > hid_mousepoll_interval to the latest-plugged-in mouse's polling
> > interval.
> >
> > How should I handle this? Just remove the line, and keep the "0 feature"?
> 
> Yes. And please merge both the patches (documentation and code) into one.
> 
> >
> > Thanks,
> > Mikkel
> >
> >
> > On Mon, 7 Feb 2005 18:51:46 +0100, Mikkel Krautz <krautz@gmail.com> wrote:
> > > Are you talking about the following line?
> > >
> > > +               else
> > > +                       hid_mousepoll_interval = interval;
> > >
> > > If so, I put it there, to fill a tiny gap, i felt was missing.
> > >
> > > If no parameter is passed, hid_mousepoll_interval is obviously 0.
> > >
> > > If a user, who doesn't pass the parameter to usbhid, reads
> > > '/sys/module/usbhid/parameters/mousepoll', the answer would be "0",
> > > which is incorrect, no?
> > >
> > > Thanks,
> > > Mikkel
> > >
> > > On Mon, 7 Feb 2005 18:43:03 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > > > On Mon, Feb 07, 2005 at 04:44:24PM +0100, Mikkel Krautz wrote:
> > > > > And, here's an updated version of hid-core.c:
> > > > >
> > > > > Signed-off-by: Mikkel Krautz <krautz@gmail.com>
> > > > > ---
> > > > > --- clean/drivers/usb/input/hid-core.c
> > > > > +++ dirty/drivers/usb/input/hid-core.c
> > > > > @@ -37,13 +37,20 @@
> > > > >   * Version Information
> > > > >   */
> > > > >
> > > > > -#define DRIVER_VERSION "v2.0"
> > > > > +#define DRIVER_VERSION "v2.01"
> > > > >  #define DRIVER_AUTHOR "Andreas Gal, Vojtech Pavlik"
> > > > >  #define DRIVER_DESC "USB HID core driver"
> > > > >  #define DRIVER_LICENSE "GPL"
> > > > >
> > > > >  static char *hid_types[] = {"Device", "Pointer", "Mouse", "Device", "Joystick",
> > > > >                               "Gamepad", "Keyboard", "Keypad", "Multi-Axis Controller"};
> > > > > +/*
> > > > > + * Module parameters.
> > > > > + */
> > > > > +
> > > > > +static unsigned int hid_mousepoll_interval;
> > > > > +module_param_named(mousepoll, hid_mousepoll_interval, uint, 0644);
> > > > > +MODULE_PARM_DESC(mousepoll, "Polling interval of mice");
> > > > >
> > > > >  /*
> > > > >   * Register a new report for a device.
> > > > > @@ -1695,6 +1702,12 @@
> > > > >               if (dev->speed == USB_SPEED_HIGH)
> > > > >                       interval = 1 << (interval - 1);
> > > > >
> > > > > +             /* Change the polling interval of mice. */
> > > > > +             if (hid->collection->usage == HID_GD_MOUSE && hid_mousepoll_interval > 0)
> > > > > +                     interval = hid_mousepoll_interval;
> > > > > +             else
> > > > > +                     hid_mousepoll_interval = interval;
> > > >
> > > > This line is trying to achieve what?
> > > >
> > > > > +
> > > > >               if (endpoint->bEndpointAddress & USB_DIR_IN) {
> > > > >                       if (hid->urbin)
> > > > >                               continue;
> > > > >
> > > > >
> > > >
> > > > --
> > > > Vojtech Pavlik
> > > > SuSE Labs, SuSE CR
> > > >
> > >
> >
> 
> --
> Vojtech Pavlik
> SuSE Labs, SuSE CR
>
