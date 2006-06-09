Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWFIWuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWFIWuq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWFIWuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:50:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33929 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932291AbWFIWup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:50:45 -0400
Date: Sat, 10 Jun 2006 00:49:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Bock <o.bock@fh-wolfenbuettel.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1/1] usb: new driver for Cypress CY7C63xxx mirco controllers
Message-ID: <20060609224957.GA15130@elf.ucw.cz>
References: <200606100042.19441.o.bock@fh-wolfenbuettel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606100042.19441.o.bock@fh-wolfenbuettel.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sorry, now the review begins...

> +/* used to send usb control messages to device */
> +int vendor_command(struct cy7c63 *dev, unsigned char request,
> +			 unsigned char address, unsigned char data) {

Codingstyle: { goes to new line.


> +#define get_set_port(num,read_id,write_id) \
> +static ssize_t set_port##num(struct device *dev, struct device_attribute *attr,	\
> +					const char *buf, size_t count) {	\
> +										\
> +	int value;								\
> +	int result = 0;								\
> +										\
> +	struct usb_interface *intf = to_usb_interface(dev);			\
> +	struct cy7c63 *cyp = usb_get_intfdata(intf);				\
> +										\
> +	dev_dbg(&cyp->udev->dev, "WRITE_PORT%d called\n", num);			\
> +										\
> +	/* validate input data */						\
> +	if (sscanf(buf, "%d", &value) < 1) {					\
> +		result = -EINVAL;						\
> +		goto error;							\
> +	}									\
> +	if (value>255 || value<0) {						\
> +		result = -EINVAL;						\
> +		goto error;							\
> +	}									\
> +										\
> +	result = vendor_command(cyp, CY7C63_WRITE_PORT, write_id,		\
> +					 (unsigned char)value);			\
> +										\
> +	dev_dbg(&cyp->udev->dev, "Result of vendor_command: %d\n\n",result);	\
> +error:										\
> +	return result < 0 ? result : count;					\
> +}										\
> +										\
> +static ssize_t get_port##num(struct device *dev,				\
> +				 struct device_attribute *attr, char *buf) {	\
> +										\
> +	int result = 0;								\
> +										\
> +	struct usb_interface *intf = to_usb_interface(dev);			\
> +	struct cy7c63 *cyp = usb_get_intfdata(intf);				\
> +										\
> +	dev_dbg(&cyp->udev->dev, "READ_PORT%d called\n", num);			\
> +										\
> +	result = vendor_command(cyp, CY7C63_READ_PORT, read_id, 0);		\
> +										\
> +	dev_dbg(&cyp->udev->dev, "Result of vendor_command: %d\n\n", result);	\
> +										\
> +	return sprintf(buf, "%d", cyp->port##num);				\
> +}										\
> +static DEVICE_ATTR(port##num, S_IWUGO | S_IRUGO, get_port##num, set_port##num);
> +
> +get_set_port(0, CY7C63_READ_PORT_ID0, CY7C63_WRITE_PORT_ID0);
> +get_set_port(1, CY7C63_READ_PORT_ID1, CY7C63_WRITE_PORT_ID1);

You get "best abuse of the macros" prize. Can you just use functions,
and pass num as aditional argument? Then just wrap the long functions
in small ones... converting cyp->port0/1 into array will be handy..


> +static int cy7c63_probe(struct usb_interface *interface,
> +			const struct usb_device_id *id) {

{ on new line, please...

BTW could we get come better name for the driver? cy7c63 looks like
password of very paranoid sysadmin.

> +	/* let the user know what node this device is now attached to */
> +	dev_info(&interface->dev,
> +		"Cypress CY7C63xxx device now attached\n");

In cases like this we aling " one character to the right.

Otherwise it looks okay.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
