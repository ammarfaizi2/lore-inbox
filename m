Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbUBXALv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 19:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUBXALs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 19:11:48 -0500
Received: from smtp.vnoc.murphx.net ([217.148.32.26]:33784 "HELO
	smtp.vnoc.murphx.net") by vger.kernel.org with SMTP id S262101AbUBXALg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 19:11:36 -0500
Message-ID: <403A97BF.7070706@gadsdon.giointernet.co.uk>
Date: Tue, 24 Feb 2004 00:15:59 +0000
From: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040223
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: linux kernel <linux-kernel@vger.kernel.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>, greg@kroah.com
Subject: Re: [linux-usb-devel] 2.6.x support for prism2 USB wireless adapter?
References: <Pine.LNX.4.44L0.0402230953141.1175-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0402230953141.1175-100000@ida.rowland.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I applied the patch to vanilla 2.6.3, and now get the following output:

usb 1-1: new full speed USB device using address 4

# lsusb
Bus 001 Device 004: ID 066b:2212 Linksys, Inc. WUSB11v2.5 802.11b Adapter
Bus 001 Device 001: ID 0000:0000

I unplugged/plugged-in the adapter several times with no problems..

Prism2_usb module loads (apparently) OK (and I agree that any problems 
with _this_ are not for the kernel.org lists..)

Thanks..

Robert Gadsdon


Alan Stern wrote:
> On Mon, 23 Feb 2004, Robert Gadsdon wrote:
> 
> 
>>I had my Linksys prism2 USB wireless adapter (WUSB11 v2.5) working 
>>reasonably well with kernel 2.4.23, but with kernel 2.6.3 (and udev 018) 
>>I get:
>>
>>usb 1-1: new full speed USB device using address 5
>>drivers/usb/core/config.c: invalid interface number (1/1)
>>usb 1-1: can't read configurations, error -22
snip
> 
> The problem is that the prism2's single interface is number 1, but
> according to the USB standard interfaces are supposed to be
> numbered starting at 0.  This is a fairly common error among USB devices.
> The patch below will cause the kernel to accept the device; please let us
> know how it works out.
> 
> Alan Stern
> 
> 
> ===== drivers/usb/core/config.c 1.28 vs edited =====
> --- 1.28/drivers/usb/core/config.c	Fri Sep 26 12:37:44 2003
> +++ edited/drivers/usb/core/config.c	Tue Dec 16 16:41:44 2003
> @@ -8,9 +8,7 @@
>  #define USB_MAXALTSETTING		128	/* Hard limit */
>  #define USB_MAXENDPOINTS		30	/* Hard limit */
>  
> -/* these maximums are arbitrary */
> -#define USB_MAXCONFIG			8
> -#define USB_MAXINTERFACES		32
> +#define USB_MAXCONFIG			8	/* Arbitrary limit */
>  
>  static int usb_parse_endpoint(struct usb_host_endpoint *endpoint, unsigned char *buffer, int size)
>  {
> @@ -90,7 +88,8 @@
>  	kfree(intf);
>  }
>  
> -static int usb_parse_interface(struct usb_host_config *config, unsigned char *buffer, int size)
> +static int usb_parse_interface(struct usb_host_config *config,
> +		unsigned char *buffer, int size, u8 inums[])
>  {
>  	unsigned char *buffer0 = buffer;
>  	struct usb_interface_descriptor	*d;
> @@ -109,8 +108,15 @@
>  		return -EINVAL;
>  	}
>  
> +	interface = NULL;
>  	inum = d->bInterfaceNumber;
> -	if (inum >= config->desc.bNumInterfaces) {
> +	for (i = 0; i < config->desc.bNumInterfaces; ++i) {
> +		if (inums[i] == inum) {
> +			interface = config->interface[i];
> +			break;
> +		}
> +	}
> +	if (!interface) {
>  
>  		/* Skip to the next interface descriptor */
>  		buffer += d->bLength;
> @@ -126,7 +132,6 @@
>  		return buffer - buffer0;
>  	}
>  
> -	interface = config->interface[inum];
>  	asnum = d->bAlternateSetting;
>  	if (asnum >= interface->num_altsetting) {
>  		warn("invalid alternate setting %d for interface %d",
> @@ -210,6 +215,8 @@
>  	int numskipped, len;
>  	char *begin;
>  	int retval;
> +	int n;
> +	u8 inums[USB_MAXINTERFACES], nalts[USB_MAXINTERFACES];
>  
>  	memcpy(&config->desc, buffer, USB_DT_CONFIG_SIZE);
>  	if (config->desc.bDescriptorType != USB_DT_CONFIG ||
> @@ -225,25 +232,14 @@
>  		    nintf, USB_MAXINTERFACES);
>  		config->desc.bNumInterfaces = nintf = USB_MAXINTERFACES;
>  	}
> -
> -	for (i = 0; i < nintf; ++i) {
> -		interface = config->interface[i] =
> -		    kmalloc(sizeof(struct usb_interface), GFP_KERNEL);
> -		dbg("kmalloc IF %p, numif %i", interface, i);
> -		if (!interface) {
> -			err("out of memory");
> -			return -ENOMEM;
> -		}
> -		memset(interface, 0, sizeof(struct usb_interface));
> -		interface->dev.release = usb_release_intf;
> -		device_initialize(&interface->dev);
> -	}
> +	if (nintf == 0)
> +		warn("no interfaces?");
>  
>  	/* Go through the descriptors, checking their length and counting the
>  	 * number of altsettings for each interface */
> +	n = 0;
>  	buffer2 = buffer;
>  	size2 = size;
> -	j = 0;
>  	while (size2 >= sizeof(struct usb_descriptor_header)) {
>  		header = (struct usb_descriptor_header *) buffer2;
>  		if ((header->bLength > size2) || (header->bLength < 2)) {
> @@ -253,42 +249,67 @@
>  
>  		if (header->bDescriptorType == USB_DT_INTERFACE) {
>  			struct usb_interface_descriptor *d;
> +			int inum;
>  
>  			if (header->bLength < USB_DT_INTERFACE_SIZE) {
>  				warn("invalid interface descriptor");
>  				return -EINVAL;
>  			}
>  			d = (struct usb_interface_descriptor *) header;
> -			i = d->bInterfaceNumber;
> -			if (i >= nintf_orig) {
> +			inum = d->bInterfaceNumber;
> +			if (inum > nintf_orig) {
>  				warn("invalid interface number (%d/%d)",
> -				    i, nintf_orig);
> +				    inum, nintf_orig);
> +				return -EINVAL;
> +			}
> +
> +			/* Have we already encountered this interface? */
> +			for (i = n - 1; i >= 0; --i) {
> +				if (inums[i] == inum)
> +					break;
> +			}
> +			if (i >= 0)
> +				++nalts[i];
> +			else if (n >= nintf_orig) {
> +				warn("too many interfaces (> %d)", nintf_orig);
>  				return -EINVAL;
> +			} else if (n < nintf) {
> +				inums[n] = inum;
> +				nalts[n] = 1;
> +				++n;
>  			}
> -			if (i < nintf)
> -				++config->interface[i]->num_altsetting;
>  
>  		} else if ((header->bDescriptorType == USB_DT_DEVICE ||
> -		    header->bDescriptorType == USB_DT_CONFIG) && j) {
> +		    header->bDescriptorType == USB_DT_CONFIG) && buffer2 > buffer) {
>  			warn("unexpected descriptor type 0x%X", header->bDescriptorType);
>  			return -EINVAL;
>  		}
>  
> -		j = 1;
>  		buffer2 += header->bLength;
>  		size2 -= header->bLength;
>  	}
> +	if (n < nintf) {
> +		warn("not enough interfaces (%d/%d)", n, nintf);
> +		return -EINVAL;
> +	}
>  
> -	/* Allocate the altsetting arrays */
> -	for (i = 0; i < config->desc.bNumInterfaces; ++i) {
> -		interface = config->interface[i];
> +	/* Allocate the interfaces and altsetting arrays */
> +	for (i = 0; i < nintf; ++i) {
> +		interface = config->interface[i] =
> +		    kmalloc(sizeof(struct usb_interface), GFP_KERNEL);
> +		dbg("kmalloc IF %p, numif %i", interface, i);
> +		if (!interface) {
> +			err("out of memory");
> +			return -ENOMEM;
> +		}
> +		memset(interface, 0, sizeof(struct usb_interface));
> +		interface->dev.release = usb_release_intf;
> +		device_initialize(&interface->dev);
> +
> +		interface->num_altsetting = nalts[i];
>  		if (interface->num_altsetting > USB_MAXALTSETTING) {
>  			warn("too many alternate settings for interface %d (%d max %d)\n",
> -			    i, interface->num_altsetting, USB_MAXALTSETTING);
> -			return -EINVAL;
> -		}
> -		if (interface->num_altsetting == 0) {
> -			warn("no alternate settings for interface %d", i);
> +			    inums[i], interface->num_altsetting, USB_MAXALTSETTING);
>  			return -EINVAL;
>  		}
>  
> @@ -329,7 +350,7 @@
>  
>  	/* Parse all the interface/altsetting descriptors */
>  	while (size >= sizeof(struct usb_descriptor_header)) {
> -		retval = usb_parse_interface(config, buffer, size);
> +		retval = usb_parse_interface(config, buffer, size, inums);
>  		if (retval < 0)
>  			return retval;
>  
> ===== include/linux/usb.h 1.165 vs edited =====
> --- 1.165/include/linux/usb.h	Mon Dec  8 12:39:26 2003
> +++ edited/include/linux/usb.h	Tue Dec 16 16:49:47 2003
> @@ -74,8 +74,8 @@
>   * struct usb_interface - what usb device drivers talk to
>   * @altsetting: array of interface descriptors, one for each alternate
>   * 	setting that may be selected.  Each one includes a set of
> - * 	endpoint configurations and will be in numberic order,
> - * 	0..num_altsetting.
> + * 	endpoint configurations, and they will be in numeric order:
> + * 	0..num_altsetting-1.
>   * @num_altsetting: number of altsettings defined.
>   * @act_altsetting: index of current altsetting.  this number is always
>   *	less than num_altsetting.  after the device is configured, each
> @@ -110,10 +110,8 @@
>   * will use them in non-default settings.
>   */
>  struct usb_interface {
> -	/* array of alternate settings for this interface.
> -	 * these will be in numeric order, 0..num_altsettting
> -	 */
> -	struct usb_host_interface *altsetting;
> +	struct usb_host_interface *altsetting;	/* array of alternate */
> +			/* setting structures for this interface */
>  
>  	unsigned act_altsetting;	/* active alternate setting */
>  	unsigned num_altsetting;	/* number of alternate settings */
> @@ -150,8 +148,12 @@
>  struct usb_host_config {
>  	struct usb_config_descriptor	desc;
>  
> -	/* the interfaces associated with this configuration
> -	 * these will be in numeric order, 0..desc.bNumInterfaces
> +	/* The interfaces associated with this configuration.
> +	 * There are desc.bNumInterfaces of them, and they are
> +	 * *not* guaranteed to be in numeric order.  Even worse,
> +	 * some non-compliant devices number the interfaces
> +	 * starting with 1, not 0.  To be safe don't index this
> +	 * array directly; instead use usb_ifnum_to_if().
>  	 */
>  	struct usb_interface *interface[USB_MAXINTERFACES];
>  
> 
> 
> 

-- 
..................................
Robert Gadsdon
01442 872 633
rgadsdon2@netscape.net
..................................
