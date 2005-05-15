Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVEOWl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVEOWl4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 18:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVEOWl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 18:41:56 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:38876 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261311AbVEOWlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 18:41:50 -0400
Date: Mon, 16 May 2005 00:37:32 +0200
From: Per Svennerbrandt <per.svennerbrandt@lbi.se>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050515223731.GA1101@tsiryulnik>
References: <20050506212227.GA24066@kroah.com> <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se> <20050509211323.GB5297@tsiryulnik> <20050512214229.GA30233@kroah.com> <20050513231917.GA1770@tsiryulnik> <20050514055916.GA19188@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050514055916.GA19188@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> On Sat, May 14, 2005 at 01:21:33AM +0200, Per Svennerbrandt wrote:
> > * On Fri, 13 May 2005, Greg KH (greg@kroah.com) wrote:
> > > Ok, as you never posted your patch, I had to do it myself :)
> > 
> > Oh, crap! Seems like I'm forever doomed to be sitting on my patches for
> > six months thinking they arn't good enough, only to then repeatedly 
> > getting beaten by couple of hours when finally deciding on submitting
> > them then... ;) ;)
> > 
> > I guess I'l just have to dedicate more time if I'm ever going to get any
> > code into the kernel.
> 
> Or just send those patches earlier :)

Well, it's not sending the patches that's the hard part. :) It's getting to
the point where you're feeling a 100% confident that the code is a 100% 
correct and without side effects that is. And since I'm so inexperienced in
kernel programming getting to that point simply involves reading just
lots and lots of code, and hence ends up taking a lot of time...
But enough about that. :)

Personal TODO list:
# prt-get install aspell
$ code++
$ talk--

> > > +static ssize_t show_modalias(struct device *dev, char *buf)
> > > +{
> > > +	struct usb_interface *intf;
> > > +	struct usb_device *udev;
> > > +
> > > +	intf = to_usb_interface(dev);
> > > +	udev = interface_to_usbdev(intf);
> > > +	if (udev->descriptor.bDeviceClass == 0) {
> > > +		struct usb_host_interface *alt = intf->cur_altsetting;
> > > +
> > > +		return sprintf(buf, "usb:v%04Xp%04Xd%04Xdc%02Xdsc%02Xdp%02Xic%02Xisc%02Xip%02X\n",
> > > +			       le16_to_cpu(udev->descriptor.idVendor),
> > > +			       le16_to_cpu(udev->descriptor.idProduct),
> > > +			       le16_to_cpu(udev->descriptor.bcdDevice),
> > > +			       udev->descriptor.bDeviceClass,
> > > +			       udev->descriptor.bDeviceSubClass,
> > > +			       udev->descriptor.bDeviceProtocol,
> > > +			       alt->desc.bInterfaceClass,
> > > +			       alt->desc.bInterfaceSubClass,
> > > +			       alt->desc.bInterfaceProtocol);
> > 
> > Are you sure this is correct?
> 
> Works for me :)
> 
> > I had problems with alt (intf->cur_altsetting) beeing null and actually 
> > ended up ignoring the interface bits altogether. I'm bretty sure the 
> > above will crash repeatedly on at least some of my machines.
> 
> Please let me know if it does.  Did you put the modalias on the
> usb_device or the interface?  It belongs on the interface, as this patch
> does.

Here's what I did:

--- linux-2.6.12-rc2/drivers/usb/core/sysfs.c.orig	2005-04-12 14:25:44.000000000 +0200
+++ linux-2.6.12-rc2/drivers/usb/core/sysfs.c	2005-04-12 15:14:24.000000000 +0200
@@ -164,6 +164,22 @@ show_maxchild (struct device *dev, char 
 }
 static DEVICE_ATTR(maxchild, S_IRUGO, show_maxchild, NULL);
 
+static ssize_t
+show_modalias (struct device *dev, char *buf)
+{
+	struct usb_device *udev = to_usb_device (dev);
+	/* FIXME: Add proper interface support */
+	return sprintf (buf, "usb:v%04Xp%04Xdl%04Xdh%04Xdc%02Xdsc%02Xdp%02Xic*isc*ip*\n",
+			le16_to_cpu(udev->descriptor.idVendor),
+			le16_to_cpu(udev->descriptor.idProduct),
+			le16_to_cpu(udev->descriptor.bcdDevice),
+			udev->descriptor.bcdDevice,
+			udev->descriptor.bDeviceClass,
+			udev->descriptor.bDeviceSubClass,
+			udev->descriptor.bDeviceProtocol);
+}
+static DEVICE_ATTR(modalias, S_IRUGO, show_modalias, NULL);
+
 /* Descriptor fields */
 #define usb_descriptor_attr_le16(field, format_string)			\
 static ssize_t								\
@@ -211,6 +245,7 @@ static struct attribute *dev_attrs[] = {
 	&dev_attr_bDeviceSubClass.attr,
 	&dev_attr_bDeviceProtocol.attr,
 	&dev_attr_bNumConfigurations.attr,
+	&dev_attr_modalias.attr,
 	&dev_attr_speed.attr,
 	&dev_attr_devnum.attr,
 	&dev_attr_version.attr,

So, yeah, it was on the device and your version is obviously better. It
does, however, have one little "problem" in common with mine:

Plug in GPS.

$ grep MODALIAS /tmp/hotplug.log
MODALIAS=usb:v067Bp2303dl0202dh0202dc00dsc00dp00icFFisc00ip00
                                                ^^^^^^^^^^^^^
$ cat /sys/devices/pci0000\:00/0000\:00\:07.2/usb1/1-1/modalias
usb:v067Bp2303dl0202dh0202dc00dsc00dp00ic*isc*ip*
                                       ^^^^^^^^^^
> cur_altsetting could be NULL pretty early in the initialization phase of
> a USB device, but by the time these files are created, it should be fine
> (otherwise this same check in the hotplug call would also fail, right?)

> > So now that I'm not able to submit it toghether with a mixture of other,
> > at least slightly, related things that I actually *do believe* have a
> > small possibility of beeing accepted: How do I get my request_modalias
> > patch in? ;) ;)
> 
> Send them on, let's see what you have, and we can take it from there.

I'll do that.

Pelle
