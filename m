Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWFLReK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWFLReK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWFLReJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:34:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:21227 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750757AbWFLReI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:34:08 -0400
From: Oliver Bock <o.bock@fh-wolfenbuettel.de>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] usb: new driver for Cypress CY7C63xxx mirco controllers
Date: Mon, 12 Jun 2006 19:34:05 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <200606100042.19441.o.bock@fh-wolfenbuettel.de> <20060609224957.GA15130@elf.ucw.cz>
In-Reply-To: <20060609224957.GA15130@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 4428
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200606121934.05619.o.bock@fh-wolfenbuettel.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:dd33dd6c1d5f49fc970db4042b12446b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 June 2006 00:49, Pavel Machek wrote:
> Sorry, now the review begins...

No problem at all.

> > +/* used to send usb control messages to device */
> > +int vendor_command(struct cy7c63 *dev, unsigned char request,
> > +			 unsigned char address, unsigned char data) {
>
> Codingstyle: { goes to new line.

Ok, I missed that one and remembered only the if-styling. I'll change it and 
I'm glad to see that as it's according to my style.

> > +#define get_set_port(num,read_id,write_id) \
> > +static ssize_t set_port##num(struct device *dev, struct device_attribute
> > *attr,	\ +					const char *buf, size_t count) {	\
> > +										\
> > +	int value;								\
> > +	int result = 0;								\
> > +										\
> > +	struct usb_interface *intf = to_usb_interface(dev);			\
> > +	struct cy7c63 *cyp = usb_get_intfdata(intf);				\
> > +										\
> > +	dev_dbg(&cyp->udev->dev, "WRITE_PORT%d called\n", num);			\
> > +										\
> > +	/* validate input data */						\
> > +	if (sscanf(buf, "%d", &value) < 1) {					\
> > +		result = -EINVAL;						\
> > +		goto error;							\
> > +	}									\
> > +	if (value>255 || value<0) {						\
> > +		result = -EINVAL;						\
> > +		goto error;							\
> > +	}									\
> > +										\
> > +	result = vendor_command(cyp, CY7C63_WRITE_PORT, write_id,		\
> > +					 (unsigned char)value);			\
> > +										\
> > +	dev_dbg(&cyp->udev->dev, "Result of vendor_command: %d\n\n",result);	\
> > +error:										\
> > +	return result < 0 ? result : count;					\
> > +}										\
> > +										\
> > +static ssize_t get_port##num(struct device *dev,				\
> > +				 struct device_attribute *attr, char *buf) {	\
> > +										\
> > +	int result = 0;								\
> > +										\
> > +	struct usb_interface *intf = to_usb_interface(dev);			\
> > +	struct cy7c63 *cyp = usb_get_intfdata(intf);				\
> > +										\
> > +	dev_dbg(&cyp->udev->dev, "READ_PORT%d called\n", num);			\
> > +										\
> > +	result = vendor_command(cyp, CY7C63_READ_PORT, read_id, 0);		\
> > +										\
> > +	dev_dbg(&cyp->udev->dev, "Result of vendor_command: %d\n\n", result);	\
> > +										\
> > +	return sprintf(buf, "%d", cyp->port##num);				\
> > +}										\
> > +static DEVICE_ATTR(port##num, S_IWUGO | S_IRUGO, get_port##num,
> > set_port##num); +
> > +get_set_port(0, CY7C63_READ_PORT_ID0, CY7C63_WRITE_PORT_ID0);
> > +get_set_port(1, CY7C63_READ_PORT_ID1, CY7C63_WRITE_PORT_ID1);
>
> You get "best abuse of the macros" prize. Can you just use functions,
> and pass num as aditional argument? Then just wrap the long functions
> in small ones... converting cyp->port0/1 into array will be handy..

Well, thanks but I think I've to "share the price" with at least one other:
drivers/usb/misc/phidgetservo.c

I agree that this is no excuse for bad style, but I was just trying to keep 
the code compliant with the kernel coding conventions - my personal style 
looks a bit different anyway. I tried to avoid any formatting issues by 
looking at other drivers and the one mentioned above was recommended to me 
when I did the porting from ioctls to sysfs. Due to this I assumed that this 
might be a common way you guys try to avoid redundant code...

To be sure (and because he's the author of the USB skeleton I also used) I 
asked Greg K-H for an initial review of my code before I sent it to the list, 
and he didn't complain a bit about this marco. So is there any common rule 
for this?

> BTW could we get come better name for the driver? cy7c63 looks like
> password of very paranoid sysadmin.

Hm, the chipset family is just called like that and there're at least three 
other Cypress related drivers (cypress, cypress_m8 and cytherm) with generic 
names. I think this name shows clearly what kind of device it supports, 
doesn't it?

Apart from that there are again other drivers (ark3116.c, cp2101.c) which do 
it the same way, and I assumed that this might be some sort of naming 
convention...

> > +	/* let the user know what node this device is now attached to */
> > +	dev_info(&interface->dev,
> > +		"Cypress CY7C63xxx device now attached\n");
>
> In cases like this we aling " one character to the right.

You mean the whole string (line) one character to the right, correct?


Regards,
Oliver
