Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVEMXYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVEMXYn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVEMXXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:23:53 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:58763 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262621AbVEMXWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:22:12 -0400
Date: Sat, 14 May 2005 01:21:33 +0200
From: Per Svennerbrandt <per.svennerbrandt@lbi.se>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050513231917.GA1770@tsiryulnik>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050506212227.GA24066@kroah.com> <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se> <20050509211323.GB5297@tsiryulnik> <20050512214229.GA30233@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512214229.GA30233@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* On Fri, 13 May 2005, Greg KH (greg@kroah.com) wrote:
> On Mon, May 09, 2005 at 11:13:24PM +0200, Per Svennerbrandt wrote:
> > * Per Liden (per@fukt.bth.se) wrote:
> > > On Fri, 6 May 2005, Greg KH wrote:
> > > 
> > > [...]
> > > > Now, with the 2.6.12-rc3 kernel, and a patch for module-init-tools, the
> > > > USB hotplug program can be written with a simple one line shell script:
> > > > 	modprobe $MODALIAS
> > > 
> > > Nice, but why not just convert all this to a call to 
> > > request_module($MODALIAS)? Seems to me like the natural thing to do.
> > 
> > I actually have a pretty hackish proof-of-consept patch that does
> > basicly that, and have been running it on my systems for the past five
> > months or so, if anybody's interested.
> > 
> > Along with it I also have a patch witch exports the module aliases for
> > PCI and USB devices through sysfs. With it the "coldplugging" of a
> > system (module wise) can be reduced to pretty much:
> > 
> > #!/bin/sh
> > 
> > for DEV in /sys/bus/{pci,usb}/devices/*; do
> > 	modprobe `cat $DEV/modalias`
> > done
> 
> Ok, as you never posted your patch, I had to do it myself :)

Oh, crap! Seems like I'm forever doomed to be sitting on my patches for
six months thinking they arn't good enough, only to then repeatedly 
getting beaten by couple of hours when finally deciding on submitting
them then... ;) ;)

I guess I'l just have to dedicate more time if I'm ever going to get any
code into the kernel.

> Here's 3 patches that I just added to my trees, and will show up in the
> next -mm release.  They create the modalias file for usb and pci
> devices, and add the MODALIAS env variable for the pci hotplug event.

Nice to see this finally getting some attention. Comments below.

> Subject: PCI: add MODALIAS to hotplug event for pci devices
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
>  drivers/pci/hotplug.c |   10 ++++++++++
>  1 files changed, 10 insertions(+)
> 
> --- gregkh-2.6.orig/drivers/pci/hotplug.c	2005-05-12 14:28:39.000000000 -0700
> +++ gregkh-2.6/drivers/pci/hotplug.c	2005-05-12 14:28:47.000000000 -0700
> @@ -52,6 +52,16 @@
>  	if ((buffer_size - length <= 0) || (i >= num_envp))
>  		return -ENOMEM;
>  
> +	envp[i++] = scratch;
> +	length += scnprintf (scratch, buffer_size - length,
> +			    "MODALIAS=pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02x\n",
> +			    pdev->vendor, pdev->device,
> +			    pdev->subsystem_vendor, pdev->subsystem_device,
> +			    (u8)(pdev->class >> 16), (u8)(pdev->class >> 8),
> +			    (u8)(pdev->class));
> +	if ((buffer_size - length <= 0) || (i >= num_envp))
> +		return -ENOMEM;
> +
>  	envp[i] = NULL;
>  
>  	return 0;

This is pretty much identical to my patch except mine also converts PCI
into using add_hotplug_env_var().

> Subject: PCI: add modalias sysfs file for pci devices
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
>  drivers/pci/pci-sysfs.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+)
> 
> --- gregkh-2.6.orig/drivers/pci/pci-sysfs.c	2005-05-12 14:28:25.000000000 -0700
> +++ gregkh-2.6/drivers/pci/pci-sysfs.c	2005-05-12 14:28:40.000000000 -0700
> @@ -73,6 +73,17 @@
>  	return (str - buf);
>  }
>  
> +static ssize_t modalias_show(struct device *dev, char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +
> +	return sprintf(buf, "pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02x\n",
> +		       pci_dev->vendor, pci_dev->device,
> +		       pci_dev->subsystem_vendor, pci_dev->subsystem_device,
> +		       (u8)(pci_dev->class >> 16), (u8)(pci_dev->class >> 8),
> +		       (u8)(pci_dev->class));
> +}
> +
>  struct device_attribute pci_dev_attrs[] = {
>  	__ATTR_RO(resource),
>  	__ATTR_RO(vendor),
> @@ -82,6 +93,7 @@
>  	__ATTR_RO(class),
>  	__ATTR_RO(irq),
>  	__ATTR_RO(local_cpus),
> +	__ATTR_RO(modalias),
>  	__ATTR_NULL,
>  };

This is *exactly* identical to my patch. :)

> 
> Subject: USB: add modalias sysfs file for usb devices
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
>  drivers/usb/core/sysfs.c |   34 ++++++++++++++++++++++++++++++++++
>  1 files changed, 34 insertions(+)
> 
> --- gregkh-2.6.orig/drivers/usb/core/sysfs.c	2005-05-12 14:28:59.000000000 -0700
> +++ gregkh-2.6/drivers/usb/core/sysfs.c	2005-05-12 14:29:05.000000000 -0700
> @@ -286,6 +286,39 @@
>  }
>  static DEVICE_ATTR(interface, S_IRUGO, show_interface_string, NULL);
>  
> +static ssize_t show_modalias(struct device *dev, char *buf)
> +{
> +	struct usb_interface *intf;
> +	struct usb_device *udev;
> +
> +	intf = to_usb_interface(dev);
> +	udev = interface_to_usbdev(intf);
> +	if (udev->descriptor.bDeviceClass == 0) {
> +		struct usb_host_interface *alt = intf->cur_altsetting;
> +
> +		return sprintf(buf, "usb:v%04Xp%04Xd%04Xdc%02Xdsc%02Xdp%02Xic%02Xisc%02Xip%02X\n",
> +			       le16_to_cpu(udev->descriptor.idVendor),
> +			       le16_to_cpu(udev->descriptor.idProduct),
> +			       le16_to_cpu(udev->descriptor.bcdDevice),
> +			       udev->descriptor.bDeviceClass,
> +			       udev->descriptor.bDeviceSubClass,
> +			       udev->descriptor.bDeviceProtocol,
> +			       alt->desc.bInterfaceClass,
> +			       alt->desc.bInterfaceSubClass,
> +			       alt->desc.bInterfaceProtocol);

Are you sure this is correct?

I had problems with alt (intf->cur_altsetting) beeing null and actually 
ended up ignoring the interface bits altogether. I'm bretty sure the 
above will crash repeatedly on at least some of my machines.

> + 	} else {
> +		return sprintf(buf, "usb:v%04Xp%04Xd%04Xdc%02Xdsc%02Xdp%02Xic*isc*ip*\n",
> +			       le16_to_cpu(udev->descriptor.idVendor),
> +			       le16_to_cpu(udev->descriptor.idProduct),
> +			       le16_to_cpu(udev->descriptor.bcdDevice),
> +			       udev->descriptor.bDeviceClass,
> +			       udev->descriptor.bDeviceSubClass,
> +			       udev->descriptor.bDeviceProtocol);
> +	}
> +
> +}
> +static DEVICE_ATTR(modalias, S_IRUGO, show_modalias, NULL);
> +
>  static struct attribute *intf_attrs[] = {
>  	&dev_attr_bInterfaceNumber.attr,
>  	&dev_attr_bAlternateSetting.attr,
> @@ -293,6 +326,7 @@
>  	&dev_attr_bInterfaceClass.attr,
>  	&dev_attr_bInterfaceSubClass.attr,
>  	&dev_attr_bInterfaceProtocol.attr,
> +	&dev_attr_modalias.attr,
>  	NULL,
>  };
>  static struct attribute_group intf_attr_grp = {

So now that I'm not able to submit it toghether with a mixture of other,
at least slightly, related things that I actually *do believe* have a
small possibility of beeing accepted: How do I get my request_modalias
patch in? ;) ;)

Have a nice day!

/Per Svennerbrandt
