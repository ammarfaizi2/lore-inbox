Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289455AbSAWWsw>; Wed, 23 Jan 2002 17:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289511AbSAWWsH>; Wed, 23 Jan 2002 17:48:07 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:4364 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S289455AbSAWWrR>;
	Wed, 23 Jan 2002 17:47:17 -0500
Date: Wed, 23 Jan 2002 23:47:14 +0100
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Torrey Hoffman <thoffman@arnor.net>, vojtech@ucw.cz,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: depmod problem for 2.5.2-dj4
Message-ID: <20020123234714.A7536@suse.cz>
In-Reply-To: <1011744752.2440.0.camel@shire.arnor.net> <20020123045405.GA12060@kroah.com> <20020123094414.D5170@suse.cz> <20020123212435.GB15259@kroah.com> <20020123222251.GE15259@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020123222251.GE15259@kroah.com>; from greg@kroah.com on Wed, Jan 23, 2002 at 02:22:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 02:22:51PM -0800, Greg KH wrote:
> On Wed, Jan 23, 2002 at 01:24:36PM -0800, Greg KH wrote:
> > On Wed, Jan 23, 2002 at 09:44:14AM +0100, Vojtech Pavlik wrote:
> > > On Tue, Jan 22, 2002 at 08:54:05PM -0800, Greg KH wrote:
> > > > Vojtech, is this a USB function that you want added to usb.c?
> > > 
> > > Yes, please. This will change later when Pat Mochels devicefs kicks in,
> > > but for the time being, it'd be very useful.
> > 
> > Here's a patch against 2.5.3-pre3, does it look ok to you (I fixed the
> > potential memory leak in the second kmalloc call from what was in
> > 2.5.2-dj4)?

Yes, this is perfect. *shiver* I can't believe I made the code so leaky.
Sorry for that, it's a copy-paste problem.
Thanks for fixing it.

> Oops, more memory leak fixes:
> 
> > diff -Nru a/drivers/usb/usb.c b/drivers/usb/usb.c
> > --- a/drivers/usb/usb.c	Wed Jan 23 13:20:28 2002
> > +++ b/drivers/usb/usb.c	Wed Jan 23 13:20:28 2002
> > @@ -2513,6 +2513,49 @@
> >  	return err;
> >  }
> >  
> > +/**
> > + * usb_make_path - returns device path in the hub tree
> > + * @dev: the device whose path is being constructed
> > + * @buf: where to put the string
> > + * @size: how big is "buf"?
> > + *
> > + * Returns length of the string (>= 0) or out of memory status (< 0).
> > + */
> > +int usb_make_path(struct usb_device *dev, char *buf, size_t size)
> > +{
> > +	struct usb_device *pdev = dev->parent;
> > +	char *tmp;
> > +	char *port;
> > +	int i;
> > +
> > +	if (!(port = kmalloc(size, GFP_KERNEL)))
> > +		return -ENOMEM;
> > +	if (!(tmp = kmalloc(size, GFP_KERNEL))) {
> > +		kfree(port);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	*port = 0;
> > +
> > +	while (pdev) {
> > +		for (i = 0; i < pdev->maxchild; i++)
> > +			if (pdev->children[i] == dev)
> > +				break;
> > +
> > +		if (pdev->children[i] != dev)
> > +			return -1;
> 
> Should be:
> 		if (pdev->children[i] != dev) {
> 			kfree(port);
> 			kfree(tmp);
> 			return -ENODEV;
> 		}
> 
> > +
> > +		strcpy(tmp, port);
> > +		snprintf(port, size, strlen(port) ? "%d.%s" : "%d", i + 1, tmp);
> > +
> > +		dev = pdev;
> > +		pdev = dev->parent;
> > +	}
> > +
> > +	snprintf(buf, size, "usb%d:%s", dev->bus->busnum, port);
> 
> And add:
> 	kfree(port);
> 	kfree(tmp);
> 
> > +	return strlen(buf);
> > +}
> 
> 
> Does that look better?
> 
> thanks,
> 
> greg k-h

-- 
Vojtech Pavlik
SuSE Labs
