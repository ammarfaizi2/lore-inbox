Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131642AbRADBGq>; Wed, 3 Jan 2001 20:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131501AbRADBGh>; Wed, 3 Jan 2001 20:06:37 -0500
Received: from selene.cps.intel.com ([192.198.165.10]:51974 "EHLO
	selene.cps.intel.com") by vger.kernel.org with ESMTP
	id <S129436AbRADBGQ>; Wed, 3 Jan 2001 20:06:16 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDE9F@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'David Brownell'" <david-b@pacbell.net>, josh <skulcap@mammoth.org>
Cc: linux-kernel@vger.kernel.org,
        l-u-d <linux-usb-devel@lists.sourceforge.net>
Subject: RE: usb dc2xx quirk
Date: Wed, 3 Jan 2001 17:05:18 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David Brownell [mailto:david-b@pacbell.net]
> 
> If this makes it go away, then by all means apply this patch;
> though I don't quite see what the failure mode would be.

Josh didn't have HOTPLUG defined and he has
confirmed to me that this patch fixes the oops.
I'll forward it again.

> The proximate cause of that Oops looked to be in one of the
> UHCI drivers, but of course it's also possible that it was
> triggered by driver misbehavior.

You didn't look hard enough.  8;)
hub_thread got a disconnect event, called usb_disconnect,
which tried to call driver->disconnect, which wasn't there
due to using __devexit without CONFIG_HOTPLUG defined.

> Have we identified anything that actually does anything with
> code labeled __dev{in,ex}it (or data), beyond putting it into
> a different section?  If so, what's it doing?

That's a great question.  I'd like to know the answer also.
Then we can see what the correct fixes should be.
This patch could just be a short-lived 2.4.0-prerel
fix-the-oops patch.

> I just tried plug/unplug of a dc-240, albeit on a kernel
> with HOTPLUG defined (and using OHCI) and it worked without
> any Oops.

Yes, HOTPLUG (and #define of __devexit) is the key.

~Randy


> - Dave
> 
> 
> ----- Original Message -----
> From: Randy Dunlap <randy.dunlap@intel.com>
> To: josh <skulcap@mammoth.org>
> Cc: <linux-kernel@vger.kernel.org>; <david-b@pacbell.net>; l-u-d
> <linux-usb-devel@lists.sourceforge.net>
> Sent: Wednesday, January 03, 2001 11:23 AM
> Subject: Re: usb dc2xx quirk
> 
> 
> > Hi,
> >
> > Looks like dc2xx.c shouldn't use __devinit/__devexit
> > [patch attached]
> > or you should enable CONFIG_HOTPLUG under General Setup.
> >
> > David?
> >
> > The ov511 (usb) driver is the only other USB device driver
> > that uses __devinit/__devexit.
> >
> > ~Randy
> >
> > josh wrote:
> > >
> > > Kernel Version: 2.4.0-test11 - 2.4.0-prerelease
> > > Platform: ix86 (PIII)
> > > Problem Hardware: Kodac DC280, firmware 1.01
> > >
> > > Ever since test10 or after, removing my dc280 from the usb
> > > bus causes khubd to crash.  I have tried both UHCI drivers
> > > and they produce the same effect.
> > >
> > > dmesg, syslog, messages, and .config can be found at:
> > > http://mammoth.org/~skulcap/usb-problem
> > >
> > > I have looked throug the archives and havent found anything
> > > like this, so I'm sorry if it has been covered already.
> > >
> > > Thanks in advance!
> > --
> > _______________________________________________
> > |randy.dunlap_at_intel.com        503-677-5408|
> > |NOTE: Any views presented here are mine alone|
> > |& may not represent the views of my employer.|
> > -----------------------------------------------
> 
> 
> --------------------------------------------------------------
> ------------------
> 
> 
> > --- linux/drivers/usb/dc2xx.c.org Sun Nov 12 20:40:42 2000
> > +++ linux/drivers/usb/dc2xx.c Wed Jan  3 11:15:11 2001
> > @@ -353,7 +353,7 @@
> >
> >
> >
> > -static void * __devinit
> > +static void *
> >  camera_probe (struct usb_device *dev, unsigned int ifnum, 
> const struct usb_device_id
> *camera_info)
> >  {
> >   int i;
> > @@ -451,7 +451,7 @@
> >   return camera;
> >  }
> >
> > -static void __devexit camera_disconnect(struct usb_device 
> *dev, void *ptr)
> > +static void camera_disconnect(struct usb_device *dev, void *ptr)
> >  {
> >   struct camera_state *camera = (struct camera_state *) ptr;
> >   int subminor = camera->subminor;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
