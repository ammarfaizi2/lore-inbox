Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270869AbTGVPX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 11:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270871AbTGVPX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 11:23:28 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:11957 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S270869AbTGVPXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 11:23:25 -0400
Subject: Re: Firmware loading problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030722145546.GC23593@ranty.pantax.net>
References: <1058885139.2757.27.camel@pegasus> 
	<20030722145546.GC23593@ranty.pantax.net>
Content-Type: multipart/mixed; boundary="=-osRQ2YztjYbwso9MOnYT"
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 Jul 2003 17:38:15 +0200
Message-Id: <1058888301.2755.8.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-osRQ2YztjYbwso9MOnYT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Manuel,

> > I installed linux-2.6.0-test1-ac2 and tried to port my driver for the
> > BlueFRITZ! USB Bluetooth dongle to 2.6. This device needs a firmware
> > download and I want to use the new firmware class for getting the
> > firmware file from userspace. After reading the documentation and
> > testing the driver samples I got the results that I expected.
> > 
> > My problem is now that the firmware loader is not working with my
> > firmware file and it seems that this is a problem of the file size,
> > because copying small files through the same interface is working fine.
> > This is the file I want to load:
> > 
> > -rw-r--r--  1 holtmann staff  418352 Jul 11 12:38 bfubase.frm
> > 
> > I have written my own firmware.agent hotplug script, which looks in
> > general something like this:
> > 
> > 	echo 1 > $LOADING
> > 	cp bfubase.frm $DATA
> > 	echo 0 > $LOADING
> > 
> > Loading the above firmware file through this interface results in
> > different behaviours. The results are complete freezes, instant reboots,
> > X server crashes with black screens and sometimes I see an oops about
> > virtual memory, but it goes bye bye too fast to let me do anything
> > useful with it.
> 
>  Could you send me a tarball with a sample showing the problem. If
>  possible I would like to do "make test" and have it compile and crash
>  the system appropriately :)

I tracked down the problem to request_firmware() or a sysfs problem.
With the firmware included in a header file the driver itself works
perfect.

Attached is a sample of how I use the request_firmware() and from the
documentation it seems correct to me.

Regards

Marcel


--=-osRQ2YztjYbwso9MOnYT
Content-Disposition: attachment; filename=fwldtest.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=fwldtest.c; charset=ISO-8859-15

/*
 *
 *  Firmware loader test driver
 *
 *  Copyright (C) 2003  Marcel Holtmann <marcel@holtmann.org>
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
 *
 */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>

#include <linux/device.h>
#include <linux/firmware.h>

#include <linux/usb.h>


static struct usb_device_id fwldtest_table[] =3D {
	{ USB_DEVICE(0x057c, 0x2200) },

	{ }	/* Terminating entry */
};

MODULE_DEVICE_TABLE(usb, fwldtest_table);


static int fwldtest_probe(struct usb_interface *iface, const struct usb_dev=
ice_id *id)
{
	const struct firmware *firmware;
	struct usb_device *udev =3D interface_to_usbdev(iface);

	if (request_firmware(&firmware, "firmware.bin", &udev->dev) < 0) {
		printk(KERN_ERR "Firmware request failed\n");
		goto error;
	}

	printk(KERN_INFO "firmware data %p size %d\n", firmware->data, firmware->s=
ize);

error:
	release_firmware(firmware);

	return -EIO;
}

static void fwldtest_disconnect(struct usb_interface *iface)
{
}

static struct usb_driver fwldtest_driver =3D {
	.owner		=3D THIS_MODULE,
	.name		=3D "fwldtest",
	.probe		=3D fwldtest_probe,
	.disconnect	=3D fwldtest_disconnect,
	.id_table	=3D fwldtest_table,
};

static int __init fwldtest_init(void)
{
	return usb_register(&fwldtest_driver);
}

static void __exit fwldtest_cleanup(void)
{
	usb_deregister(&fwldtest_driver);
}

module_init(fwldtest_init);
module_exit(fwldtest_cleanup);

MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
MODULE_DESCRIPTION("Firmware loader test driver");
MODULE_LICENSE("GPL");

--=-osRQ2YztjYbwso9MOnYT--

