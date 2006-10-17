Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWJQIDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWJQIDK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 04:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWJQIDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 04:03:10 -0400
Received: from vesl.donpac.ru ([80.254.111.33]:180 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S932225AbWJQIDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 04:03:06 -0400
Date: Tue, 17 Oct 2006 12:03:00 +0400
To: Marc-Antoine Avon Charreyron <marcantoine@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driver for usb remote control (pid 13ec, vid 000a)
Message-ID: <20061017080300.GA32476@pazke.donpac.ru>
Mail-Followup-To: Marc-Antoine Avon Charreyron <marcantoine@gmail.com>,
	linux-kernel@vger.kernel.org
References: <78e1af440610150951n724887e1i8b3c43cb618233e1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <78e1af440610150951n724887e1i8b3c43cb618233e1@mail.gmail.com>
X-Uname: Linux 2.6.18-1-amd64 x86_64
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 288, 10 15, 2006 at 12:51:24PM -0400, Marc-Antoine Avon Charreyron wrote:
>
> Hello, the following is a driver for a usb remote control with product
> id 13ec and vendor id 000a  (it came with a Asus tv card).  I'm
> looking for comments and people to help test it.

IMHO you need to integrate this driver with input subsystem, instead of inv=
enting your
own homebrew char device interface. Look at Documentation/input/input-progr=
amming.txt
for more details.

Anyway, some comments follow.=20

> Thank you
>=20
> P.S. please CC me personally
>=20
> /*
> *      USB remote control driver
> *
> *      2006 Marc-Antoine Avon-Charreyron <mavon006@uottawa.ca>
> *
> *      This driver is based on drivers/usb/usb-skeleton.c
> */
>=20
> /*
> *	This program is free software; you can redistribute it and/or
> *	modify it under the terms of the GNU General Public License as
> *	published by the Free Software Foundation, version 2.
> */
>=20
> #include <linux/config.h>
> #include <linux/kernel.h>
> #include <linux/errno.h>
> #include <linux/init.h>
> #include <linux/slab.h>
> #include <linux/module.h>
> #include <linux/kref.h>
> #include <asm/uaccess.h>
> #include <linux/usb.h>
>=20
>=20
> /* Define these values to match your devices */
> #define USB_REMCTL_VENDOR_ID	0x13ec
> #define USB_REMCTL_PRODUCT_ID	0x000a
>=20
>=20
> /* table of devices that work with this driver */
> static struct usb_device_id rem_ctl_table [] =3D {
> 	{ USB_DEVICE(USB_REMCTL_VENDOR_ID, USB_REMCTL_PRODUCT_ID) },
> 	{ }					/* Terminating entry */
> };
> MODULE_DEVICE_TABLE (usb, rem_ctl_table);
>=20
> /* Get a minor range for your devices from the usb maintainer */
> #define USB_REMCTL_MINOR_BASE	192
>=20
> struct semaphore sem;

Looks like you need to move this semaphore into the usb_rem_ctl structure to
support multiple devices. Anyway global variable with very generic name is =
bad.


> /* Structure to hold all of our device specific stuff */
> struct usb_rem_ctl {
> 	struct usb_device *	udev;			/* the usb device for this device */
> 	struct usb_interface *	interface;		/* the interface for this device */
> 	unsigned char *		data_in_buffer1;	/* the buffer to receive data from end=
point 0x81*/
> 	unsigned char *		data_in_buffer2;        /* the buffer to receive data f=
rom endpoint 0x82*/
> 	size_t			data_in_size;		/* the size of the receive buffer */
> 	struct kref		kref;
> };
> #define to_rem_ctl_dev(d) container_of(d, struct usb_rem_ctl, kref)
>=20
> static struct usb_driver rem_ctl_driver;
>=20
> static void rem_ctl_delete(struct kref *kref)
> {=09
> 	struct usb_rem_ctl *dev =3D to_rem_ctl_dev(kref);
>=20
> 	usb_put_dev(dev->udev);
> 	kfree (dev->data_in_buffer1);
> 	kfree (dev->data_in_buffer2);
> 	kfree (dev);
> }
>=20
> static void cb_read0(struct urb *urb, struct pt_regs *regs)
> {
> 	usb_submit_urb(urb, GFP_ATOMIC);
> 	up(&sem);
> }
>=20
> static void cb_read1(struct urb *urb, struct pt_regs *regs)
> {
> 	usb_submit_urb(urb, GFP_ATOMIC);
> }
>=20
> static int rem_ctl_open(struct inode *inode, struct file *file)
> {
> 	struct usb_rem_ctl *dev;
> 	struct usb_interface *interface;
> 	int subminor;
> 	int retval =3D 0;
>=20
> 	subminor =3D iminor(inode);
>=20
> 	interface =3D usb_find_interface(&rem_ctl_driver, subminor);
> 	if (!interface) {
> 		err ("%s - error, can't find device for minor %d",
> 		     __FUNCTION__, subminor);
> 		retval =3D -ENODEV;
> 		goto exit;
> 	}
>=20
> 	dev =3D usb_get_intfdata(interface);
> 	if (!dev) {
> 		retval =3D -ENODEV;
> 		goto exit;
> 	}
>=20
> 	/* increment our usage count for the device */
> 	kref_get(&dev->kref);
>=20
> 	/* save our object in the file's private structure */
> 	file->private_data =3D dev;
>=20
>=20
> 	struct urb *urb;
> 	struct urb *urb2;

Don't declare variables this way, move them at the start of code block, ple=
ase.

> 	urb =3D usb_alloc_urb(0, GFP_KERNEL);
> 	if (!urb) {
> 		return -ENOMEM;
> 	}

Don't put single statement into { }.

> 	urb2 =3D usb_alloc_urb(0, GFP_KERNEL);
> 	if (!urb2) {

urb leaked here ?

> 		return -ENOMEM;
> 	}
>=20
> 	usb_fill_int_urb(urb, dev->udev, usb_rcvintpipe(dev->udev, 0x81),
> dev->data_in_buffer1,
> dev->data_in_size, cb_read0, dev, 128);
> 	usb_fill_int_urb(urb2, dev->udev, usb_rcvintpipe(dev->udev, 0x82),
> dev->data_in_buffer2, dev->data_in_size, cb_read1, dev, 128);
>=20
> 	retval =3D usb_submit_urb(urb, GFP_KERNEL);
> 	retval =3D usb_submit_urb(urb2, GFP_KERNEL);
> 	sema_init(&sem, 0);
>=20
> exit:
> 	return retval;
> }
>=20
> static int rem_ctl_release(struct inode *inode, struct file *file)
> {
> 	struct usb_rem_ctl *dev;
>=20
> 	dev =3D (struct usb_rem_ctl *)file->private_data;
> 	if (dev =3D=3D NULL)
> 		return -ENODEV;
>=20
> 	/* decrement the count on our device */
> 	kref_put(&dev->kref, rem_ctl_delete);
> 	return 0;
> }
>=20
>=20
> static ssize_t read(struct file *file, char *buffer, size_t count, loff_t=
=20
> *ppos)
> {
> 	struct usb_rem_ctl *dev;
> 	int retval =3D 0;
>=20
> 	char buf[1]=3D"0";
>=20
> 	dev =3D (struct usb_rem_ctl *)file->private_data;
>=20
> 	down_interruptible(&sem);
>=20
> 	if((dev->data_in_buffer1[1] =3D=3D 0x07) &&
> 	   (dev->data_in_buffer1[3] =3D=3D 0x1f)) {                             =
=20
> 	   //TV
>=20
> 		buf[0] =3D 0x01;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x07) &&
> 		  (dev->data_in_buffer1[3] =3D=3D 0x23)) {                      =20
> 		  //FM
> 	=09
> 		buf[0] =3D 0x02;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x07) &&
> 		  (dev->data_in_buffer1[3] =3D=3D 0x1e)) {                      =20
> 		  //DVD
> 	=09
> 		buf[0] =3D 0x03;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x04) &&
>    //Close
> 	          (dev->data_in_buffer1[3] =3D=3D 0x3d)) {
> 	=09
> 		buf[0] =3D 0x04;
> 		retval =3D 1;
>=20
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x03) &&                      =
=20
> 	//<<
> 	          (dev->data_in_buffer1[3] =3D=3D 0x05)) {
> 	=09
> 		buf[0] =3D 0x05;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x01) &&
>    //Stop
> 	          (dev->data_in_buffer1[3] =3D=3D 0x16)) {
> 	=09
> 		buf[0] =3D 0x06;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x01) &&
>    //Play/Pause
> 	          (dev->data_in_buffer1[3] =3D=3D 0x13)) {
> 	=09
> 		buf[0] =3D 0x07;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x03) &&                      =
=20
> 	//>>
> 	          (dev->data_in_buffer1[3] =3D=3D 0x09)) {
> 	=09
> 		buf[0] =3D 0x08;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x07) &&
>    //don't know
> 	          (dev->data_in_buffer1[3] =3D=3D 0x18)) {
> 	=09
> 		buf[0] =3D 0x09;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x01) &&
>    //record
> 	          (dev->data_in_buffer1[3] =3D=3D 0x15)) {
> 	=09
> 		buf[0] =3D 0x0a;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&                      =
=20
> 	//pip
> 	          (dev->data_in_buffer1[3] =3D=3D 0x1d)) {
> 	=09
> 		buf[0] =3D 0x0b;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&                      =
=20
> 	//1
> 	          (dev->data_in_buffer1[3] =3D=3D 0x1e)) {
> 	=09
> 		buf[0] =3D 0x0c;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&                      =
=20
> 	//2
> 	          (dev->data_in_buffer1[3] =3D=3D 0x1f)) {
> 	=09
> 		buf[0] =3D 0x0d;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&                      =
=20
> 	//3
> 	          (dev->data_in_buffer1[3] =3D=3D 0x20)) {
> 	=09
> 		buf[0] =3D 0x0e;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x01) &&
>    //ch up
> 	          (dev->data_in_buffer1[3] =3D=3D 0x09)) {
> 	=09
> 		buf[0] =3D 0x0f;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&                      =
=20
> 	//4
> 	          (dev->data_in_buffer1[3] =3D=3D 0x21)) {
> 	=09
> 		buf[0] =3D 0x10;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&                      =
=20
> 	//5
> 	          (dev->data_in_buffer1[3] =3D=3D 0x22)) {
> 	=09
> 		buf[0] =3D 0x11;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&                      =
=20
> 	//6
> 	          (dev->data_in_buffer1[3] =3D=3D 0x23)) {
> 	=09
> 		buf[0] =3D 0x12;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x01) &&
>    //ch down
> 	          (dev->data_in_buffer1[3] =3D=3D 0x05)) {
> 	=09
> 		buf[0] =3D 0x13;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&                      =
=20
> 	//7
> 	          (dev->data_in_buffer1[3] =3D=3D 0x24)) {
> 	=09
> 		buf[0] =3D 0x14;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&                      =
=20
> 	//8
> 	          (dev->data_in_buffer1[3] =3D=3D 0x25)) {
> 	=09
> 		buf[0] =3D 0x15;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&                      =
=20
> 	//9
> 	          (dev->data_in_buffer1[3] =3D=3D 0x26)) {
> 	=09
> 		buf[0] =3D 0x16;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&
>    //Back
> 	          (dev->data_in_buffer1[3] =3D=3D 0x2a)) {
> 	=09
> 		buf[0] =3D 0x17;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&                      =
=20
> 	//0
> 	          (dev->data_in_buffer1[3] =3D=3D 0x27)) {
> 	=09
> 		buf[0] =3D 0x18;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&                      =
=20
> 	//up
> 	          (dev->data_in_buffer1[3] =3D=3D 0x52)) {
> 	=09
> 		buf[0] =3D 0x1c;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&
>    //right
> 	          (dev->data_in_buffer1[3] =3D=3D 0x4f)) {
> 	=09
> 		buf[0] =3D 0x1d;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&
>    //down
> 	          (dev->data_in_buffer1[3] =3D=3D 0x51)) {
> 	=09
> 		buf[0] =3D 0x1e;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&
>    //left
> 	          (dev->data_in_buffer1[3] =3D=3D 0x50)) {
> 	=09
> 		buf[0] =3D 0x1f;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&
>    //enter
> 	          (dev->data_in_buffer1[3] =3D=3D 0x28)) {
> 	=09
> 		buf[0] =3D 0x20;
> 		retval =3D 1;
> 	=09
> 	} else if((dev->data_in_buffer1[1] =3D=3D 0x00) &&
>    //Volumes
> 	          (dev->data_in_buffer1[3] =3D=3D 0x00)) {
>=20
> 		if(dev->data_in_buffer2[1] =3D=3D 0x04) {           //Vol Down
> 			buf[0] =3D 0x19;
> 			retval =3D 1;
> 		} else if(dev->data_in_buffer2[1] =3D=3D 0x02) {    //Vol Up
> 			buf[0] =3D 0x1a;
> 			retval =3D 1;
> 		} else if(dev->data_in_buffer2[1] =3D=3D 0x01) {    //Mute
> 			buf[0] =3D 0x1b;
> 			retval =3D 1;
> 		}
> 	=09
> 	} else {
> 		return 0;
> 	}
>=20
> 	if (copy_to_user(buffer, buf, sizeof(buffer))) {
> 		retval =3D -EFAULT;
> 	}
>=20
> 	return retval;
> }
>
> static struct file_operations rem_ctl_fops =3D {
> 	.owner =3D	THIS_MODULE,
> 	.read =3D		read,
> 	.open =3D		rem_ctl_open,
> 	.release =3D	rem_ctl_release,
> };
>=20
> /*
> * usb class driver info in order to get a minor number from the usb core,
> * and to have the device registered with devfs and the driver core
> */
> static struct usb_class_driver rem_ctl_class =3D {
> 	.name =3D		"usb/remote%d",
> 	.fops =3D		&rem_ctl_fops,
> 	.minor_base =3D	USB_REMCTL_MINOR_BASE,
> };
>=20
> static int rem_ctl_probe(struct usb_interface *interface, const struct
> usb_device_id *id)
> {
> =09
> 	struct usb_rem_ctl *dev =3D NULL;
> 	struct usb_host_interface *iface_desc;
> 	struct usb_endpoint_descriptor *endpoint;
> 	size_t buffer_size;
> 	int retval =3D -ENOMEM;
> =09
> 	/* allocate memory for our device state and initialize it */
> 	dev =3D kmalloc(sizeof(*dev), GFP_KERNEL);
> 	if (dev =3D=3D NULL) {
> 		err("Out of memory");
> 		goto error;
> 	}
> 	memset(dev, 0x00, sizeof(*dev));

Use kzalloc instead of kmalloc+memset, please.

> 	kref_init(&dev->kref);
>=20
> 	dev->udev =3D usb_get_dev(interface_to_usbdev(interface));
> 	dev->interface =3D interface;
>=20
> 	/* set up the endpoint information */
> 	iface_desc =3D interface->cur_altsetting;
> 	endpoint =3D &iface_desc->endpoint[0].desc;
>=20
> 	buffer_size =3D le16_to_cpu(endpoint->wMaxPacketSize);
> 	dev->data_in_size =3D buffer_size;
> 	dev->data_in_buffer1 =3D kmalloc(buffer_size, GFP_KERNEL);
> 	if (!dev->data_in_buffer1) {

Memory leak here, dev is not freed.

> 		err("Could not allocate data_in_buffer1");
> 		goto error;
> 	}
> 	dev->data_in_buffer2 =3D kmalloc(buffer_size, GFP_KERNEL);
> 	if (!dev->data_in_buffer2) {

Another memory leak, dev and dev->data_in_buffer1 are not freed.

> 		err("Could not allocate data_in_buffer2");
> 		goto error;
> 	}
>=20
> 	/* save our data pointer in this interface device */
> 	usb_set_intfdata(interface, dev);
>=20
> 	/* we can register the device now, as it is ready */
> 	retval =3D usb_register_dev(interface, &rem_ctl_class);
> 	if (retval) {
> 		/* something prevented us from registering this driver */
> 		err("Not able to get a minor for this device.");
> 		usb_set_intfdata(interface, NULL);
> 		goto error;
> 	}
>=20
> 	/* let the user know what node this device is now attached to */
> 	info("USB remote control device now attached to USBrem-%d",=20
> 	interface->minor);
> 		return 0;
>=20
> 	error:
>
> 		if (dev)
> 			kref_put(&dev->kref, rem_ctl_delete);
> 		return retval;
> }
>=20
> static void rem_ctl_disconnect(struct usb_interface *interface)
> {
> 	struct usb_rem_ctl *dev;
> 	int minor =3D interface->minor;
>=20
> 	/* prevent rem_open() from racing rem_disconnect() */
> 	lock_kernel();
>=20
> 	dev =3D usb_get_intfdata(interface);
> 	usb_set_intfdata(interface, NULL);
>=20
> 	/* give back our minor */
> 	usb_deregister_dev(interface, &rem_ctl_class);
>=20
> 	unlock_kernel();
>=20
> 	/* decrement our usage count */
> 	kref_put(&dev->kref, rem_ctl_delete);
>=20
> 	info("USB remote #%d now disconnected", minor);
> }
>=20
> static struct usb_driver rem_ctl_driver =3D {
> 	.name =3D		"remote",
> 	.probe =3D	rem_ctl_probe,
> 	.disconnect =3D	rem_ctl_disconnect,
> 	.id_table =3D	rem_ctl_table,
>=20
> };
>=20
> static int __init usb_rem_ctl_init(void)
> {
> 	int result;
>=20
> 	/* register this driver with the USB subsystem */
> 	result =3D usb_register(&rem_ctl_driver);
> 	if (result)
> 		err("usb_register failed. Error number %d", result);
>=20
> 	return result;
> }
>=20
> static void __exit usb_rem_ctl_exit(void)
> {
> 	/* deregister this driver with the USB subsystem */
> 	usb_deregister(&rem_ctl_driver);
> }
>=20
> module_init (usb_rem_ctl_init);
> module_exit (usb_rem_ctl_exit);
>=20
> MODULE_LICENSE("GPL");

No MODULE_AUTHOR tag ? :)


Thank you for the effort.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFNI40PjHNUy6paxMRAtHrAJ9OyceAi5Ix3hyDERWq6pNbzte3/QCfb8CJ
oimItEKdUmTKf9Z/ahp3uyQ=
=qfk4
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
