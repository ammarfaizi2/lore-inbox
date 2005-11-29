Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbVK2AGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVK2AGY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 19:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVK2AGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 19:06:24 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:21277 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S932305AbVK2AGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 19:06:23 -0500
Date: Tue, 29 Nov 2005 01:06:15 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: debian-powerpc@lists.debian.org,
       linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Subject: Re: PowerBook5,8 - TrackPad update
Message-ID: <20051129000615.GA20843@hansmi.ch>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net> <70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: multipart/mixed; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Parag

> Attached is the code which takes care of above 3 - tested but it
> should be considered half baked for obvious reasons and

I hacked your code some more to make it work on my October 2005
PowerBook 1.67 GHz. The product ID I have, 0x0215, was in none of the
available drivers and the data format is somewhat different.

You find my hacked version attached -- be aware that in its current form
it will not work with any touchpad except 0x0215.

> in addition I added some relayfs write calls [...]

I wrapped them into #if's, so one is not required to have relayfs in the
kernel to use the driver.

> The code might break the existing (old) trackpads as the detection
> might not  be correct.

My changes do that definitively, but it's only a hack.

As far as I see it, all methods can be built into one driver. Is there
already someone working on combining them?

Greets,
Michael

--=20
Gentoo Linux Developer using m0n0wall | http://hansmi.ch/

--TiqCXmo5T1hvSQQg
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="appletouch.c"
Content-Transfer-Encoding: quoted-printable

/*
 * Apple USB Touchpad (for post-February 2005 PowerBooks) driver
 *
 * Copyright (C) 2001-2004 Greg Kroah-Hartman (greg@kroah.com)
 * Copyright (C) 2005      Johannes Berg (johannes@sipsolutions.net)
 * Copyright (C) 2005      Stelian Pop (stelian@popies.net)
 * Copyright (C) 2005      Frank Arnold (frank@scirocco-5v-turbo.de)
 * Copyright (C) 2005      Peter Osterlund (petero2@telia.com)
 * Copyright (C) 2005      Parag Warudkar (parag.warudkar@gmail.com)
 *
 * Thanks to Alex Harper <basilisk@foobox.net> for his inputs.
 * Nov 2005 - Parag Warudkar=20
 * 	o Add preliminary support for Oct 2005 Powerbooks=20
 * 	  (Doesn't work fully yet)
 * 	o Converted to use input_device_allocate()
 * 	o Added ability to export data via relayfs
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */

#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/module.h>
#include <linux/usb.h>
#include <linux/input.h>
#include <linux/usb_input.h>
#include <linux/debugfs.h>
#include <asm/prom.h>

#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
#include <linux/relayfs_fs.h>
#endif

#if !defined(PPC) && !defined(POWERPC)
#error "Module intended for PowerPC based PowerBooks!"
#endif

/* Apple has powerbooks which have the keyboard with different Product IDs =
*/
#define APPLE_VENDOR_ID		0x05AC

#define ATP_DEVICE(prod)					\
	.match_flags =3D USB_DEVICE_ID_MATCH_DEVICE |   		\
		       USB_DEVICE_ID_MATCH_INT_CLASS |		\
		       USB_DEVICE_ID_MATCH_INT_PROTOCOL,	\
	.idVendor =3D APPLE_VENDOR_ID,				\
	.idProduct =3D (prod),					\
	.bInterfaceClass =3D 0x03,				\
	.bInterfaceProtocol =3D 0x02

/* table of devices that work with this driver */
static struct usb_device_id atp_table [] =3D {
	/* Earlier PowerBooks */
	{ ATP_DEVICE(0x020E) },
	{ ATP_DEVICE(0x020F) },
	{ ATP_DEVICE(0x030A) },
	{ ATP_DEVICE(0x030B) },

	/* PowerBooks Late Oct 2005 */
	{ ATP_DEVICE(0x0214) },
	{ ATP_DEVICE(0x0215) },

	/* Terminating entry */
	{ }
};
MODULE_DEVICE_TABLE (usb, atp_table);

#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
struct rchan* rch =3D NULL;
struct rchan_callbacks* rcb =3D NULL;
#endif

/*
 * number of sensors. Note that only 16 instead of 26 X (horizontal)
 * sensors exist on 12" and 15" PowerBooks. All models have 16 Y
 * (vertical) sensors.
 */
#define ATP_MAX_XSENSORS	15
#define ATP_MAX_YSENSORS	7

/* amount of fuzz this touchpad generates */
#define ATP_FUZZ	16

/* maximum pressure this driver will report */
#define ATP_PRESSURE	300

/*
 * multiplication factor for the X and Y coordinates.
 * We try to keep the touchpad aspect ratio while still doing only simple
 * arithmetics.
 * The factors below give coordinates like:
 * 	0 <=3D x <  960 on 12" and 15" Powerbooks
 * 	0 <=3D x < 1600 on 17" Powerbooks
 * 	0 <=3D y <  646
 */
#define ATP_XFACT	64
#define ATP_YFACT	43

/*
 * Threshold for the touchpad sensors. Any change less than ATP_THRESHOLD is
 * ignored.
 */
#define ATP_THRESHOLD	 5

typedef enum PB_MAC_TYPE {
	PowerBook54,
	PowerBook56,
	PowerBook58,
	PowerBook59,
	Unknown
} PB_MAC_TYPE;


/* Structure to hold all of our device specific stuff */
struct atp {
	struct usb_device *	udev;		/* usb device */
	struct urb *		urb;		/* usb request block */
	signed char *		data;		/* transferred data */
	int			open;		/* non-zero if opened */
	struct input_dev	*input;		/* input dev */
	int			valid;		/* are the sensors valid ? */
	int			x_old;		/* last reported x/y, */
	int			y_old;		/* used for smoothing */
						/* current value of the sensors */
	signed char		xy_cur[ATP_MAX_XSENSORS + ATP_MAX_YSENSORS];
						/* last value of the sensors */
	signed char		xy_old[ATP_MAX_XSENSORS + ATP_MAX_YSENSORS];
						/* accumulated sensors */
	int			xy_acc[ATP_MAX_XSENSORS + ATP_MAX_YSENSORS];
	PB_MAC_TYPE		mtype;
};

#define dbg_dump(msg, tab) \
	if (debug > 1) {						\
		int i;							\
		printk("appletouch: %s %lld", msg, (long long)jiffies); \
		for (i =3D 0; i < ATP_MAX_XSENSORS + ATP_MAX_YSENSORS; i++)	\
			printk(" %02x", tab[i]); 			\
		printk("\n"); 						\
	}

#define dprintk(format, a...) 						\
	do {								\
		if (debug) printk(format, ##a);				\
	} while (0)

MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold, Parag Warudkar");
MODULE_DESCRIPTION("Apple Al PowerBook USB touchpad driver");
MODULE_LICENSE("GPL");

static int debug =3D 1;
module_param(debug, int, 0644);
MODULE_PARM_DESC(debug, "Activate debugging output");

/* USB URB buffer length - 81 works on Feb 05 models.
 * Oct 05 models fail with EOVERFLOW, detected and corrected=20
 * separately.
 */
//static int data_len =3D 81;
static int data_len =3D 80;
module_param(data_len, int, 0644);
MODULE_PARM_DESC(data_len, "Specify USB URB buffer length (auto-detected no=
rmally)");

PB_MAC_TYPE atp_machine_detect(void)
{
	if(machine_is_compatible("PowerBook5,9"))
		return PowerBook59;
	if(machine_is_compatible("PowerBook5,8"))
		return PowerBook58;
	if(machine_is_compatible("PowerBook5,6"))
		return PowerBook56;
	if (machine_is_compatible("PowerBook5,4"))
		return PowerBook54;
	return Unknown;
}

static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
			     int *z, int *fingers)
{
	int i;
	/* values to calculate mean */
	int pcum =3D 0, psum =3D 0;

	*fingers =3D 0;

	for (i =3D 0; i < nb_sensors; i++) {
		if (xy_sensors[i] < ATP_THRESHOLD)
			continue;
		if ((i - 1 < 0) || (xy_sensors[i - 1] < ATP_THRESHOLD))
			(*fingers)++;
		pcum +=3D xy_sensors[i] * i;
		psum +=3D xy_sensors[i];
	}

	if (psum > 0) {
		*z =3D psum;
		return pcum * fact / psum;
	}

	return 0;
}

static inline void atp_report_fingers(struct input_dev *input, int fingers)
{
	input_report_key(input, BTN_TOOL_FINGER, fingers =3D=3D 1);
	input_report_key(input, BTN_TOOL_DOUBLETAP, fingers =3D=3D 2);
	input_report_key(input, BTN_TOOL_TRIPLETAP, fingers > 2);
}

static void atp_complete(struct urb* urb, struct pt_regs* regs)
{
	int x, y, x_z, y_z, x_f, y_f;
	int retval, i;
	struct atp *dev =3D urb->context;
	static int ctr =3D 1;

	switch (urb->status) {
	case 0:
		/* success */
		break;
	case -EOVERFLOW:
		if(ctr){
			printk("appletouch: OVERFLOW with data length %d\n", data_len);
			ctr =3D 0;
		}
	case -ECONNRESET:
	case -ENOENT:
	case -ESHUTDOWN:
		/* This urb is terminated, clean up */
		dbg("%s - urb shutting down with status: %d",
		    __FUNCTION__, urb->status);
		return;
	default:
		goto exit;
	}

	/* drop incomplete datasets */
	if (dev->urb->actual_length !=3D data_len) {
		printk(KERN_WARNING "appletouch: incomplete data package length %d\n", de=
v->urb->actual_length);
		goto exit;
	}

#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
	if ( dev->data ) {
		relay_write(rch, dev->data, dev->urb->actual_length);
	}
#endif

        dev->xy_cur[0] =3D dev->data[19];
        dev->xy_cur[1] =3D dev->data[20];
        dev->xy_cur[2] =3D dev->data[22];
        dev->xy_cur[3] =3D dev->data[23];
        dev->xy_cur[4] =3D dev->data[25];
        dev->xy_cur[5] =3D dev->data[26];
        dev->xy_cur[6] =3D dev->data[28];
        dev->xy_cur[7] =3D dev->data[29];
        dev->xy_cur[8] =3D dev->data[31];
        dev->xy_cur[9] =3D dev->data[32];
        dev->xy_cur[10] =3D dev->data[34];
        dev->xy_cur[11] =3D dev->data[35];
        dev->xy_cur[12] =3D dev->data[37];
        dev->xy_cur[13] =3D dev->data[38];
        dev->xy_cur[14] =3D dev->data[40];

        dev->xy_cur[15] =3D dev->data[1];
        dev->xy_cur[16] =3D dev->data[2];
        dev->xy_cur[17] =3D dev->data[4];
        dev->xy_cur[18] =3D dev->data[5];
        dev->xy_cur[19] =3D dev->data[7];
        dev->xy_cur[20] =3D dev->data[8];
        dev->xy_cur[21] =3D dev->data[10];

        /*
        for(i =3D 0; i < ATP_MAX_XSENSORS + ATP_MAX_YSENSORS; i++) {
            printk("%2x ", dev->xy_cur[i]);
        }
        printk("\n");
        */

	/* reorder the sensors values */
	//for (i =3D 0; i < 8; i++) {
		/* X values */
		/*dev->xy_cur[i     ] =3D dev->data[5 * i +  2];
		dev->xy_cur[i +  8] =3D dev->data[5 * i +  4];
		dev->xy_cur[i + 16] =3D dev->data[5 * i + 42];
		if (i < 2)
			dev->xy_cur[i + 24] =3D dev->data[5 * i + 44];*/

		/* Y values */
		/*dev->xy_cur[i + 26] =3D dev->data[5 * i +  1];
		dev->xy_cur[i + 34] =3D dev->data[5 * i +  3];
	}*/

        //dbg_dump("sample", dev->xy_cur);

	if (!dev->valid) {
		/* first sample */
		dev->valid =3D 1;
		dev->x_old =3D dev->y_old =3D -1;

		memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));

		/* 17" Powerbooks have 10 extra X sensors */
		/*for (i =3D 16; i < ATP_MAX_XSENSORS; i++)
			if (dev->xy_cur[i]) {
				printk("appletouch: 17\" model detected.\n");
				input_set_abs_params(dev->input, ABS_X, 0,
				     		     ((ATP_MAX_XSENSORS - 1) * ATP_XFACT) - 1,
						     ATP_FUZZ, 0);
				break;
			}*/

		goto exit;
	}

	for (i =3D 0; i < ATP_MAX_XSENSORS + ATP_MAX_YSENSORS; i++) {
		/* accumulate the change */
		signed char change =3D dev->xy_old[i] - dev->xy_cur[i];
		dev->xy_acc[i] -=3D change;

		/* prevent down drifting */
		if (dev->xy_acc[i] < 0)
			dev->xy_acc[i] =3D 0;
	}

	memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));

	//dbg_dump("accumulator", dev->xy_acc);

	x =3D atp_calculate_abs(dev->xy_acc, ATP_MAX_XSENSORS,
			      ATP_XFACT, &x_z, &x_f);
	y =3D atp_calculate_abs(dev->xy_acc + ATP_MAX_XSENSORS, ATP_MAX_YSENSORS,
			      ATP_YFACT, &y_z, &y_f);

	if (x && y) {
		if (dev->x_old !=3D -1) {
			x =3D (dev->x_old * 3 + x) >> 2;
			y =3D (dev->y_old * 3 + y) >> 2;
			dev->x_old =3D x;
			dev->y_old =3D y;

			if (debug > 1)
				printk("appletouch: X: %3d Y: %3d "
				       "Xz: %3d Yz: %3d\n",
				       x, y, x_z, y_z);

			input_report_key(dev->input, BTN_TOUCH, 1);
			input_report_abs(dev->input, ABS_X, x);
			input_report_abs(dev->input, ABS_Y, y);
			input_report_abs(dev->input, ABS_PRESSURE,
					 min(ATP_PRESSURE, x_z + y_z));
			atp_report_fingers(dev->input, max(x_f, y_f));
		}
		dev->x_old =3D x;
		dev->y_old =3D y;
	}
	else if (!x && !y) {

		dev->x_old =3D dev->y_old =3D -1;
		input_report_key(dev->input, BTN_TOUCH, 0);
		input_report_abs(dev->input, ABS_PRESSURE, 0);
		atp_report_fingers(dev->input, 0);

		/* reset the accumulator on release */
		memset(dev->xy_acc, 0, sizeof(dev->xy_acc));
	}

	input_report_key(dev->input, BTN_LEFT, !!dev->data[data_len-1]);

	input_sync(dev->input);

exit:
	retval =3D usb_submit_urb(dev->urb, GFP_ATOMIC);
	if (retval) {
		err("%s - usb_submit_urb failed with result %d",
		    __FUNCTION__, retval);
	}
}

static int atp_open(struct input_dev *input)
{
	struct atp *dev =3D input->private;
	if (usb_submit_urb(dev->urb, GFP_ATOMIC)) {
		printk("atp: usb_submit_urb Error\n");
		return -EIO;
	}

	dev->open =3D 1;
	return 0;
}

static void atp_close(struct input_dev *input)
{
	struct atp *dev =3D input->private;
	usb_kill_urb(dev->urb);
	dev->open =3D 0;
}

static int atp_probe(struct usb_interface *iface, const struct usb_device_i=
d *id)
{
	struct atp *dev =3D NULL;
	struct usb_host_interface *iface_desc;
	struct usb_endpoint_descriptor *endpoint;
	int int_in_endpointAddr =3D 0;
	int i, retval =3D -ENOMEM;
	int regret=3D0;
	printk(KERN_INFO "AppleTouch: Inside atp_probe\n");
=09
	/* allocate memory for our device state and initialize it */
	dev =3D kmalloc(sizeof(struct atp), GFP_KERNEL);
	if (dev =3D=3D NULL) {
		err("Out of memory");
		goto err_kmalloc;
	}
=09
	memset(dev, 0, sizeof(struct atp));
	dev->mtype =3D atp_machine_detect();
	if(dev->mtype =3D=3D Unknown)
	{
		printk(KERN_INFO "appletouch: Unknown machine type!\n");
		return -ENODEV;
	}
	if(dev->mtype > 1)
	{
		if(data_len < 256)
		{
			printk(KERN_INFO "appletouch: Setting URB buffer length to 256\n");
			data_len =3D 256;
		}
	}

	printk("appletouch: Machine type is: %d\n", dev->mtype);

	dev->udev =3D interface_to_usbdev(iface);

	/* set up the endpoint information */
	/* use only the first interrupt-in endpoint */
	iface_desc =3D iface->cur_altsetting;
	for (i =3D 0; i < iface_desc->desc.bNumEndpoints; i++) {
		endpoint =3D &iface_desc->endpoint[i].desc;
		if (!int_in_endpointAddr &&
		    (endpoint->bEndpointAddress & USB_DIR_IN) &&
		    ((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
					=3D=3D USB_ENDPOINT_XFER_INT)) {
			/* we found an interrupt in endpoint */
			int_in_endpointAddr =3D endpoint->bEndpointAddress;
			printk(KERN_INFO "AppleTouch: atp_probe found interrupt in endpoint: %d\=
n", int_in_endpointAddr);
			break;
		}
	}
	if (!int_in_endpointAddr) {
		retval =3D -EIO;
		err("Could not find int-in endpoint");
		goto err_endpoint;
	}

	/* save our data pointer in this interface device */
	usb_set_intfdata(iface, dev);

	dev->urb =3D usb_alloc_urb(0, GFP_KERNEL);
	if (!dev->urb) {
		retval =3D -ENOMEM;
		goto err_usballoc;
	}
	dev->data =3D usb_buffer_alloc(dev->udev, data_len, GFP_KERNEL,
				     &dev->urb->transfer_dma);
	if (!dev->data) {
		retval =3D -ENOMEM;
		goto err_usbbufalloc;
	}
	usb_fill_int_urb(dev->urb, dev->udev,
			 usb_rcvintpipe(dev->udev, int_in_endpointAddr),
			 dev->data, data_len, atp_complete, dev, 1);

	dev->input =3D input_allocate_device();
	dev->input->name =3D "appletouch";
	dev->input->dev =3D &iface->dev;
	dev->input->private =3D dev;
	dev->input->open =3D atp_open;
	dev->input->close =3D atp_close;

	usb_to_input_id(dev->udev, &dev->input->id);

	set_bit(EV_ABS, dev->input->evbit);

	/*
	 * 12" and 15" Powerbooks only have 16 x sensors,
	 * 17" models are detected later.
	 */
	input_set_abs_params(dev->input, ABS_X, 0,
			     (16 - 1) * ATP_XFACT - 1, ATP_FUZZ, 0);
	input_set_abs_params(dev->input, ABS_Y, 0,
			     (ATP_MAX_YSENSORS - 1) * ATP_YFACT - 1, ATP_FUZZ, 0);
	input_set_abs_params(dev->input, ABS_PRESSURE, 0, ATP_PRESSURE, 0, 0);

	set_bit(EV_KEY, dev->input->evbit);
	set_bit(BTN_TOUCH, dev->input->keybit);
	set_bit(BTN_TOOL_FINGER, dev->input->keybit);
	set_bit(BTN_TOOL_DOUBLETAP, dev->input->keybit);
	set_bit(BTN_TOOL_TRIPLETAP, dev->input->keybit);
	set_bit(BTN_LEFT, dev->input->keybit);

	regret =3D input_register_device(dev->input);

	printk(KERN_INFO "input: appletouch connected, Reg code: %d\n", regret);

	return 0;

err_usbbufalloc:
	usb_free_urb(dev->urb);
err_usballoc:
	usb_set_intfdata(iface, NULL);
err_endpoint:
	kfree(dev);
err_kmalloc:
	return retval;
}

static void atp_disconnect(struct usb_interface *iface)
{
	struct atp *dev =3D usb_get_intfdata(iface);

	usb_set_intfdata(iface, NULL);
	if (dev) {
		usb_kill_urb(dev->urb);
		input_unregister_device(dev->input);
		usb_free_urb(dev->urb);
		usb_buffer_free(dev->udev, data_len,
				dev->data, dev->urb->transfer_dma);
		kfree(dev);
	}
	printk(KERN_INFO "input: appletouch disconnected\n");
}

static int atp_suspend(struct usb_interface *iface, pm_message_t message)
{
	struct atp *dev =3D usb_get_intfdata(iface);
	usb_kill_urb(dev->urb);
	dev->valid =3D 0;
	return 0;
}

static int atp_resume(struct usb_interface *iface)
{
	struct atp *dev =3D usb_get_intfdata(iface);
	if (dev->open && usb_submit_urb(dev->urb, GFP_ATOMIC))
		return -EIO;

	return 0;
}

static struct usb_driver atp_driver =3D {
	.owner		=3D THIS_MODULE,
	.name		=3D "appletouch",
	.probe		=3D atp_probe,
	.disconnect	=3D atp_disconnect,
	.suspend	=3D atp_suspend,
	.resume		=3D atp_resume,
	.id_table	=3D atp_table,
};


static int __init atp_init(void)
{
#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
	rcb  =3D kmalloc(sizeof(struct rchan_callbacks), GFP_KERNEL);
	rcb->subbuf_start =3D NULL;
	rcb->buf_mapped =3D NULL;
	rcb->buf_unmapped =3D NULL;
	rch =3D relay_open("atpdata", NULL, 256, 256, NULL);
	if (!rch) return -ENOMEM;
	printk("appletouch: Relayfs enabled.\n");
#endif
	return usb_register(&atp_driver);
}

static void __exit atp_exit(void)
{
#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
	relay_close(rch);
	kfree(rcb);
#endif
	usb_deregister(&atp_driver);
}

module_init(atp_init);
module_exit(atp_exit);

--TiqCXmo5T1hvSQQg--

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDi5t36J0saEpRu+oRAg9fAJwKPkqSsGTWp7QoGr7hdMOFa6Xq3wCcCinm
6rUKhEx5zYkF/a/uOEA8KvQ=
=KXXs
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
