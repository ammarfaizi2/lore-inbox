Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267543AbUHRTZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267543AbUHRTZP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 15:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267551AbUHRTZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 15:25:15 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:54978 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S267543AbUHRTWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 15:22:38 -0400
Subject: ati_remote for medion
From: Karel Demeyer <kmdemeye@vub.ac.be>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: mescapec@hotmail.com
Content-Type: multipart/mixed; boundary="=-rPSdj/FBREro8IuI3iwp"
Date: Wed, 18 Aug 2004 21:22:49 +0200
Message-Id: <1092856969.11811.12.camel@kryptonix>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rPSdj/FBREro8IuI3iwp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I got a remote control with my PC ("Medion 8080 XL titanium") that works
with an USB-receiver (via radio-waves).  As it was not supported, I
experimented a bit and found out I could 'use' the ati-remote module in
the 2.6.x-kernel.  I had to change some stuff like the "#define
ATI_REMOTE_PRODUCT_ID   0x0006" and then it gave some input for some
keys.  I also had to change the whole "Translation table from hardware
messages to input events" which took a lot oftime for me as I had to try
out very much as I don't know about what I had to use and the keys all
had other hex-codes then those of the ati-remotes.

I sent my changes to Torrey Hoffman <thoffman@arnor.net> a long time ago
and I thought he answered me he would put support for my kind of remote
in his module, but since then nothing happened in that way.  I'm not a
coder, so I can't give 'patches' of diffs of whatever ... I even can't
recode the module to support both remotes ... 

My question is: could someone please do this for me?  I spent a lot of
time on it and I want to give back to the comunnity.  There are more
people out there using linux who maybe already gave their remote away as
they couldn't use it with linux.  But I use it for xmms, TVtime, Totem,
gxine and all those other nice apps.  I don't need my name in the
credits.  Yours should be if you code it :| ... please ? :)

friendly greeting,

Karel "scapor" Demeyer.

PS: attached is the code with changes (derivated of the ati-remote.c in
2.6.8.1)



--=-rPSdj/FBREro8IuI3iwp
Content-Disposition: attachment; filename=ati_remote.c
Content-Type: text/x-csrc; name=ati_remote.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

/* 
 *  USB ATI Remote support
 *
 *  Version 2.2.0 Copyright (c) 2004 Torrey Hoffman <thoffman@arnor.net>
 *  Version 2.1.1 Copyright (c) 2002 Vladimir Dergachev
 *
 *  This 2.2.0 version is a rewrite / cleanup of the 2.1.1 driver, including
 *  porting to the 2.6 kernel interfaces, along with other modification 
 *  to better match the style of the existing usb/input drivers.  However, the
 *  protocol and hardware handling is essentially unchanged from 2.1.1.
 *  
 *  The 2.1.1 driver was derived from the usbati_remote and usbkbd drivers by 
 *  Vojtech Pavlik.
 *
 *  Changes:
 *
 *  Feb 2004: Torrey Hoffman <thoffman@arnor.net>
 *            Version 2.2.0
 *  Jun 2004: Torrey Hoffman <thoffman@arnor.net>
 *            Version 2.2.1
 *            Added key repeat support contributed by:
 *                Vincent Vanackere <vanackere@lif.univ-mrs.fr>
 *            Added support for the "Lola" remote contributed by:
 *                Seth Cohn <sethcohn@yahoo.com>
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
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
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 *
 * Hardware & software notes
 *
 * These remote controls are distributed by ATI as part of their 
 * "All-In-Wonder" video card packages.  The receiver self-identifies as a 
 * "USB Receiver" with manufacturer "X10 Wireless Technology Inc".
 *
 * The "Lola" remote is available from X10.  See: 
 *    http://www.x10.com/products/lola_sg1.htm
 * The Lola is similar to the ATI remote but has no mouse support, and slightly
 * different keys.
 *
 * It is possible to use multiple receivers and remotes on multiple computers 
 * simultaneously by configuring them to use specific channels.
 * 
 * The RF protocol used by the remote supports 16 distinct channels, 1 to 16.  
 * Actually, it may even support more, at least in some revisions of the 
 * hardware.
 *
 * Each remote can be configured to transmit on one channel as follows:
 *   - Press and hold the "hand icon" button.  
 *   - When the red LED starts to blink, let go of the "hand icon" button. 
 *   - When it stops blinking, input the channel code as two digits, from 01 
 *     to 16, and press the hand icon again.
 * 
 * The timing can be a little tricky.  Try loading the module with debug=1
 * to have the kernel print out messages about the remote control number
 * and mask.  Note: debugging prints remote numbers as zero-based hexadecimal.
 *
 * The driver has a "channel_mask" parameter. This bitmask specifies which
 * channels will be ignored by the module.  To mask out channels, just add 
 * all the 2^channel_number values together.
 *
 * For instance, set channel_mask = 2^4 = 16 (binary 10000) to make ati_remote
 * ignore signals coming from remote controls transmitting on channel 4, but 
 * accept all other channels.
 *
 * Or, set channel_mask = 65533, (0xFFFD), and all channels except 1 will be 
 * ignored.
 *
 * The default is 0 (respond to all channels). Bit 0 and bits 17-32 of this 
 * parameter are unused.
 *
 */

#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/input.h>
#include <linux/usb.h>

/*
 * Module and Version Information, Module Parameters
 */
 
#define ATI_REMOTE_VENDOR_ID 	0x0bc7
#define ATI_REMOTE_PRODUCT_ID 	0x0006
#define LOLA_REMOTE_PRODUCT_ID 	0x002

#define DRIVER_VERSION 	        "2.2.1"
#define DRIVER_AUTHOR           "Torrey Hoffman <thoffman@arnor.net>"
#define DRIVER_DESC             "ATI/X10 RF USB Remote Control"

#define NAME_BUFSIZE      80    /* size of product name, path buffers */
#define DATA_BUFSIZE      63    /* size of URB data buffers */
#define ATI_INPUTNUM      1     /* Which input device to register as */

static unsigned long channel_mask = 0;
module_param(channel_mask, ulong, 444);
MODULE_PARM_DESC(channel_mask, "Bitmask of remote control channels to ignore");

static int debug = 0;
module_param(debug, int, 444);
MODULE_PARM_DESC(debug, "Enable extra debug messages and information");

#define dbginfo(dev, format, arg...) do { if (debug) dev_info(dev , format , ## arg); } while (0)
#undef err
#define err(format, arg...) printk(KERN_ERR format , ## arg)
 
static struct usb_device_id ati_remote_table[] = {
	{ USB_DEVICE(ATI_REMOTE_VENDOR_ID, ATI_REMOTE_PRODUCT_ID) },
	{ USB_DEVICE(ATI_REMOTE_VENDOR_ID, LOLA_REMOTE_PRODUCT_ID) },
	{}	/* Terminating entry */
};

MODULE_DEVICE_TABLE(usb, ati_remote_table);

/* Get hi and low bytes of a 16-bits int */
#define HI(a)	((unsigned char)((a) >> 8))
#define LO(a)	((unsigned char)((a) & 0xff))

#define SEND_FLAG_IN_PROGRESS	1
#define SEND_FLAG_COMPLETE	2

/* Device initialization strings */
static char init1[] = { 0x01, 0x00, 0x20, 0x14 };
static char init2[] = { 0x01, 0x00, 0x20, 0x14, 0x20, 0x20, 0x20 };

/* Acceleration curve for directional control pad */
static char accel[] = { 1, 2, 4, 6, 9, 13, 20 };

/* Duplicate event filtering time. 
 * Sequential, identical KIND_FILTERED inputs with less than
 * FILTER_TIME jiffies between them are considered as repeat
 * events. The hardware generates 5 events for the first keypress
 * and we have to take this into account for an accurate repeat
 * behaviour.
 * (HZ / 20) == 50 ms and works well for me.
 */
#define FILTER_TIME (HZ / 20)

static DECLARE_MUTEX(disconnect_sem);

struct ati_remote {
	struct input_dev idev;		
	struct usb_device *udev;
	struct usb_interface *interface;
		
	struct urb *irq_urb;
	struct urb *out_urb;
	struct usb_endpoint_descriptor *endpoint_in;
	struct usb_endpoint_descriptor *endpoint_out;
	unsigned char *inbuf;
	unsigned char *outbuf;
	dma_addr_t inbuf_dma;
	dma_addr_t outbuf_dma;

	int open;                   /* open counter */
	int present;                /* device plugged in? */
	
	unsigned char old_data[2];  /* Detect duplicate events */
	unsigned long old_jiffies;
	unsigned long acc_jiffies;  /* handle acceleration */
	unsigned int repeat_count;
	
	char name[NAME_BUFSIZE];
	char phys[NAME_BUFSIZE];

	wait_queue_head_t wait;
	int send_flags;
};

/* "Kinds" of messages sent from the hardware to the driver. */
#define KIND_END        0
#define KIND_LITERAL    1   /* Simply pass to input system */
#define KIND_FILTERED   2   /* Add artificial key-up events, drop keyrepeats */
#define KIND_LU         3   /* Directional keypad diagonals - left up, */
#define KIND_RU         4   /*   right up,  */
#define KIND_LD         5   /*   left down, */
#define KIND_RD         6   /*   right down */
#define KIND_ACCEL      7   /* Directional keypad - left, right, up, down.*/

/* Translation table from hardware messages to input events. */
static struct
{
	short kind;
	unsigned char data1, data2;
	int type;
	unsigned int code;
	int value;
}  ati_remote_tbl[] = 
{
/*	How the remote looks like;  - Karel Demeyer
		Legenda:	ChLst =	"Channel List"
				TV-PR =	"TV Preview"
				ViDsk =	"Video Desktop"
				S =	"Setup"



	+---------------------------------+
	|  (TV)    (VCR)   (DVD)  (MUSIC) | 
	| (RADIO) (PHOTO) (TV-PR) (ChLst)----[PAGE UP]
	|   (S)                 | (ViDsk)----[PAGE DOWN]
	|              (+CHAN+) -------------[HOMEPAGE]
	|           -           +         |
	|           V           V         |
	|           O   ( < )   O         |
	|           L           L         |
	|           -           +         |
	|              (-CHAN-)           |
	|   (o)                    (txt)  |		==> (o) are the colored teletext-buttons
	|         (o)    (o)   (o)        |		==> F1-F4, F7
	|                                 |
        |   (1)          (2)        (3)   |
	|                                 |
        |   (4)          (5)        (6)   |
	|                                 |
        |   (7)          (8)        (9)   |
	|                                 |
[NUMLCK]---(TV/RA)       (0)        (<-)------[BACKSPACE]
	|                                 |
[TAB]------( )        (   ^   )     ( )-------[ESC]
	|                                 |
	|        (<)    ( OK )    (>)     |
	|                                 |
        |   ( )       (   v   )     ( )   |
	|                                 |
	|                                 |
        |   (<<)         (>)       (>>)   |
	|                                 |	
        |   (o)         ([])       (II)   |
	|                     ----------------[F]
        |   (|<<)        ( )--     (>>|)  |
	|                                 |
[CTRL]------(o)                     (o)-------[ALT]
	|                                 |
	|              [POWER]            |
	+---------------------------------+
*/



/*  start/function-keys */
	{KIND_FILTERED, 0xf1, 0x2c, EV_KEY, KEY_PROG1, 1},	/* (TV) */
	{KIND_FILTERED, 0xf2, 0x2d, EV_KEY, KEY_PROG2, 1},	/* (VCR) */
	{KIND_FILTERED, 0xc9, 0x04, EV_KEY, KEY_PROG3, 1},	/* (DVD) */
	{KIND_FILTERED, 0xcb, 0x06, EV_KEY, KEY_PROG4, 1},	/* (MUSIC) */
	{KIND_FILTERED, 0xf3, 0x2e, EV_KEY, KEY_BACK, 1},	/* (RADIO) */
	{KIND_FILTERED, 0xca, 0x05, EV_KEY, KEY_FORWARD, 1}, 	/* (PHOTO) */
	{KIND_FILTERED, 0xf4, 0x2f, EV_KEY, KEY_HOMEPAGE, 1},	/* "TV Preview" */
	{KIND_FILTERED, 0xf5, 0x30, EV_KEY, KEY_PAGEUP, 1},	/* (=) "Channel list */
	{KIND_FILTERED, 0xe0, 0x1b, EV_KEY, KEY_MSDOS, 1},	/* (S) "Setup" */
	{KIND_FILTERED, 0xf6, 0x31, EV_KEY, KEY_PAGEDOWN, 1}, 	/* (=) "Video Desktop" */
/* TV-zap-keys */
	{KIND_FILTERED, 0xd1, 0x0c, EV_KEY, KEY_DOWN, 1},/* (-CHAN-) */ /*KEY_CHANNELDOWN is not very useful*/
	{KIND_FILTERED, 0xcd, 0x08, EV_KEY, KEY_VOLUMEDOWN, 1},	/* (-VOL-) */
	{KIND_FILTERED, 0xc5, 0x00, EV_KEY, KEY_MUTE, 1},	/* (<)) */
	{KIND_FILTERED, 0xce, 0x09, EV_KEY, KEY_VOLUMEUP, 1},	/* (+VOL+) */
	{KIND_FILTERED, 0xd0, 0x0b, EV_KEY, KEY_UP, 1},	/* (+CHAN+) */ /*KEY_CHANNELUP is not very useful*/
/* TT keys */
	{KIND_FILTERED, 0xf7, 0x32, EV_KEY, KEY_F1, 1},	/* (o) -red- */
	{KIND_FILTERED, 0xf8, 0x33, EV_KEY, KEY_F2, 1},	/* (o) -green- */
	{KIND_FILTERED, 0xf9, 0x34, EV_KEY, KEY_F3, 1},	/* (o) -yellow- */
	{KIND_FILTERED, 0xfa, 0x35, EV_KEY, KEY_F4, 1},	/* (o) -blue- */
	{KIND_FILTERED, 0xdb, 0x16, EV_KEY, KEY_F7, 1},	/* (txt) */

/* numerical pad */
	{KIND_FILTERED, 0xd2, 0x0d, EV_KEY, KEY_KP1, 1},	/* (1) */
	{KIND_FILTERED, 0xd3, 0x0e, EV_KEY, KEY_KP2, 1},	/* (2) */
	{KIND_FILTERED, 0xd4, 0x0f, EV_KEY, KEY_KP3, 1},	/* (3) */
	{KIND_FILTERED, 0xd5, 0x10, EV_KEY, KEY_KP4, 1},	/* (4) */
	{KIND_FILTERED, 0xd6, 0x11, EV_KEY, KEY_KP5, 1},	/* (5) */
	{KIND_FILTERED, 0xd7, 0x12, EV_KEY, KEY_KP6, 1},	/* (6) */
	{KIND_FILTERED, 0xd8, 0x13, EV_KEY, KEY_KP7, 1},	/* (7) */
	{KIND_FILTERED, 0xd9, 0x14, EV_KEY, KEY_KP8, 1},	/* (8) */
	{KIND_FILTERED, 0xda, 0x15, EV_KEY, KEY_KP9, 1},	/* (9) */
	{KIND_FILTERED, 0xe1, 0x1c, EV_KEY, KEY_NUMLOCK, 1},	/* (TV/RADIO) "CH.SEARCH" */	/*NUMLOCK*/
	{KIND_FILTERED, 0xdc, 0x17, EV_KEY, KEY_KP0, 1},	/* (0) */
	{KIND_FILTERED, 0xe5, 0x20, EV_KEY, KEY_BACKSPACE, 1},	/* (<-) */
/* arrows-pad / image-keys */
	{KIND_FILTERED, 0xfb, 0x36, EV_KEY, KEY_TAB, 1},		/* "rename" */		/*TAB*/
	{KIND_FILTERED, 0xdf, 0x1a, EV_KEY, KEY_UP, 1},         /* (^) */
	{KIND_FILTERED, 0xdd, 0x18, EV_KEY, KEY_ESC, 1},	/* "snapshot" */	/*ESC*/
	{KIND_FILTERED, 0xe2, 0x1d, EV_KEY, KEY_LEFT, 1},       /* (<) */
	{KIND_FILTERED, 0xe3, 0x1e, EV_KEY, KEY_ENTER, 1},      /* "OK" */
	{KIND_FILTERED, 0xe4, 0x1f, EV_KEY, KEY_RIGHT, 1},      /* (>) */
	{KIND_FILTERED, 0xfc, 0x37, EV_KEY, KEY_PRINT, 1},	/* "aquire image " */
	{KIND_FILTERED, 0xe7, 0x22, EV_KEY, KEY_DOWN, 1},       /* (v) */
	{KIND_FILTERED, 0xfd, 0x38, EV_KEY, KEY_EDIT, 1},	/* "edit image" */
/* playback-keys (as MOUSEPAD)*/
	{KIND_FILTERED, 0xe9, 0x24, EV_KEY, KEY_REWIND, 1},	/* (<<) */
	{KIND_FILTERED, 0xea, 0x25, EV_KEY, KEY_PLAYPAUSE, 1},	/* (>) */	/* interpreted by 'xmms-xf86audio' */
	{KIND_FILTERED, 0xeb, 0x26, EV_KEY, KEY_FORWARD, 1},	/* (>>) */
	{KIND_FILTERED, 0xec, 0x27, EV_KEY, KEY_RECORD, 1},	/* (o) */
	{KIND_FILTERED, 0xed, 0x28, EV_KEY, KEY_STOPCD, 1},	/* ([])	*/	/* interpreted by 'xmms-xf86audio' */
	{KIND_FILTERED, 0xee, 0x29, EV_KEY, KEY_PAUSE, 1},		/* (II) */
	{KIND_FILTERED, 0xe6, 0x21, EV_KEY, KEY_PREVIOUSSONG, 1},	/* (|<<) */	/* interpreted by 'xmms-xf86audio' */
	{KIND_FILTERED, 0xfe, 0x39, EV_KEY, KEY_F, 1},		/* "Full screen" */	/*F ('fullscreen' for many media-apps) */
	{KIND_FILTERED, 0xe8, 0x23, EV_KEY, KEY_NEXTSONG, 1},	/* (>>|) */	/* interpreted by 'xmms-xf86audio' */
/* DVD-keys */
	{KIND_FILTERED, 0xde, 0x19, EV_KEY, KEY_LEFTCTRL, 1},	/* "DVD Menu" */
	{KIND_FILTERED, 0xff, 0x3a, EV_KEY, KEY_LEFTALT, 1},	/* "DVD Audio" */
/* Power-button */
	{KIND_FILTERED, 0xc7, 0x02, EV_KEY, KEY_POWER, 1},	/* (Q) -power- */



	{KIND_END, 0x00, 0x00, EV_MAX + 1, 0, 0}
};


/* Local function prototypes */
static void ati_remote_dump		(unsigned char *data, unsigned int actual_length);
static void ati_remote_delete		(struct ati_remote *dev);
static int ati_remote_open		(struct input_dev *inputdev);
static void ati_remote_close		(struct input_dev *inputdev);
static int ati_remote_sendpacket	(struct ati_remote *ati_remote, u16 cmd, unsigned char *data);
static void ati_remote_irq_out		(struct urb *urb, struct pt_regs *regs);
static void ati_remote_irq_in		(struct urb *urb, struct pt_regs *regs);
static void ati_remote_input_report	(struct urb *urb, struct pt_regs *regs);
static int ati_remote_initialize	(struct ati_remote *ati_remote);
static int ati_remote_probe		(struct usb_interface *interface, const struct usb_device_id *id);
static void ati_remote_disconnect	(struct usb_interface *interface);

/* usb specific object to register with the usb subsystem */
static struct usb_driver ati_remote_driver = {
	.owner        = THIS_MODULE,
	.name         = "ati_remote",
	.probe        = ati_remote_probe,
	.disconnect   = ati_remote_disconnect,
	.id_table     = ati_remote_table,
};

/*
 *	ati_remote_dump_input
 */
static void ati_remote_dump(unsigned char *data, unsigned int len)
{
	if ((len == 1) && (data[0] != (unsigned char)0xff) && (data[0] != 0x00))
		warn("Weird byte 0x%02x", data[0]);
	else if (len == 4)
		warn("Weird key %02x %02x %02x %02x", 
		     data[0], data[1], data[2], data[3]);
	else
		warn("Weird data, len=%d %02x %02x %02x %02x %02x %02x ...",
		     len, data[0], data[1], data[2], data[3], data[4], data[5]);
}

/*
 *	ati_remote_open
 */
static int ati_remote_open(struct input_dev *inputdev)
{
	struct ati_remote *ati_remote = inputdev->private;
	int retval = 0;

	down(&disconnect_sem);

	if (ati_remote->open++)
		goto exit;

	/* On first open, submit the read urb which was set up previously. */
	ati_remote->irq_urb->dev = ati_remote->udev;
	if (usb_submit_urb(ati_remote->irq_urb, GFP_KERNEL)) {
		dev_err(&ati_remote->interface->dev, 
			"%s: usb_submit_urb failed!\n", __FUNCTION__);
		ati_remote->open--;
		retval = -EIO;
	}

exit:
	up(&disconnect_sem);
	return retval;
}

/*
 *	ati_remote_close
 */
static void ati_remote_close(struct input_dev *inputdev)
{
	struct ati_remote *ati_remote = inputdev->private;
	
	if (ati_remote == NULL) {
		err("ati_remote: %s: object is NULL!\n", __FUNCTION__);
		return;
	}
	
	if (ati_remote->open <= 0)
		dev_dbg(&ati_remote->interface->dev, "%s: Not open.\n", __FUNCTION__);
	else
		--ati_remote->open;
	
	/* If still present, disconnect will call delete. */
	if (!ati_remote->present && !ati_remote->open)
		ati_remote_delete(ati_remote);
}

/*
 *		ati_remote_irq_out
 */
static void ati_remote_irq_out(struct urb *urb, struct pt_regs *regs)
{
	struct ati_remote *ati_remote = urb->context;
	
	if (urb->status) {
		dev_dbg(&ati_remote->interface->dev, "%s: status %d\n",
			__FUNCTION__, urb->status);
		return;
	}
	
	ati_remote->send_flags |= SEND_FLAG_COMPLETE;
	wmb();
	wake_up(&ati_remote->wait);
}

/*
 *	ati_remote_sendpacket
 *		
 *	Used to send device initialization strings
 */
static int ati_remote_sendpacket(struct ati_remote *ati_remote, u16 cmd, unsigned char *data)
{
	DECLARE_WAITQUEUE(wait, current);
	int timeout = HZ;	/* 1 second */
	int retval = 0;
	
	/* Set up out_urb */
	memcpy(ati_remote->out_urb->transfer_buffer + 1, data, LO(cmd));
	((char *) ati_remote->out_urb->transfer_buffer)[0] = HI(cmd);	

	ati_remote->out_urb->transfer_buffer_length = LO(cmd) + 1;
	ati_remote->out_urb->dev = ati_remote->udev;
	ati_remote->send_flags = SEND_FLAG_IN_PROGRESS;

	retval = usb_submit_urb(ati_remote->out_urb, GFP_ATOMIC);
	if (retval) {
		dev_dbg(&ati_remote->interface->dev, 
			 "sendpacket: usb_submit_urb failed: %d\n", retval);
		return retval;
	}

	set_current_state(TASK_INTERRUPTIBLE);
	add_wait_queue(&ati_remote->wait, &wait);

	while (timeout && (ati_remote->out_urb->status == -EINPROGRESS) 
	       && !(ati_remote->send_flags & SEND_FLAG_COMPLETE)) {
		timeout = schedule_timeout(timeout);
		rmb();
	}

	set_current_state(TASK_RUNNING);
	remove_wait_queue(&ati_remote->wait, &wait);
	usb_unlink_urb(ati_remote->out_urb);
	
	return retval;
}

/*
 *	ati_remote_event_lookup
 */
static int ati_remote_event_lookup(int rem, unsigned char d1, unsigned char d2)
{
	int i;

	for (i = 0; ati_remote_tbl[i].kind != KIND_END; i++) {
		/* 
		 * Decide if the table entry matches the remote input. 
		 */
		if ((((ati_remote_tbl[i].data1 & 0x0f) == (d1 & 0x0f))) &&
		    ((((ati_remote_tbl[i].data1 >> 4) - 
		       (d1 >> 4) + rem) & 0x0f) == 0x0f) && 
		    (ati_remote_tbl[i].data2 == d2))
			return i;
		
	}
	return -1;
}

/*
 *	ati_remote_report_input
 */
static void ati_remote_input_report(struct urb *urb, struct pt_regs *regs)	
{
	struct ati_remote *ati_remote = urb->context;
	unsigned char *data= ati_remote->inbuf;
	struct input_dev *dev = &ati_remote->idev; 
	int index, acc;
	int remote_num;
	
	/* Deal with strange looking inputs */
	if ( (urb->actual_length != 4) || (data[0] != 0x14) || 
		((data[3] & 0x0f) != 0x00) ) {
		ati_remote_dump(data, urb->actual_length);
		return;
	}

	/* Mask unwanted remote channels.  */
	/* note: remote_num is 0-based, channel 1 on remote == 0 here */
	remote_num = (data[3] >> 4) & 0x0f;
        if (channel_mask & (1 << (remote_num + 1))) { 
		dbginfo(&ati_remote->interface->dev,
			"Masked input from channel 0x%02x: data %02x,%02x, mask= 0x%02lx\n",
			remote_num, data[1], data[2], channel_mask);
		return;
	}

	/* Look up event code index in translation table */
	index = ati_remote_event_lookup(remote_num, data[1], data[2]);
	if (index < 0) {
		dev_warn(&ati_remote->interface->dev, 
			 "Unknown input from channel 0x%02x: data %02x,%02x\n", 
			 remote_num, data[1], data[2]);
		return;
	} 
	dbginfo(&ati_remote->interface->dev, 
		"channel 0x%02x; data %02x,%02x; index %d; keycode %d\n",
		remote_num, data[1], data[2], index, ati_remote_tbl[index].code);
	
	if (ati_remote_tbl[index].kind == KIND_LITERAL) {
		input_regs(dev, regs);
		input_event(dev, ati_remote_tbl[index].type,
			ati_remote_tbl[index].code,
			ati_remote_tbl[index].value);
		input_sync(dev);
		
		ati_remote->old_jiffies = jiffies;
		return;
	}
	
	if (ati_remote_tbl[index].kind == KIND_FILTERED) {
		/* Filter duplicate events which happen "too close" together. */
		if ((ati_remote->old_data[0] == data[1]) && 
	 		(ati_remote->old_data[1] == data[2]) && 
	 		((ati_remote->old_jiffies + FILTER_TIME) > jiffies)) {
			ati_remote->repeat_count++;
		} 
		else {
			ati_remote->repeat_count = 0;
		}
		
		ati_remote->old_data[0] = data[1];
		ati_remote->old_data[1] = data[2];
		ati_remote->old_jiffies = jiffies;

		if ((ati_remote->repeat_count > 0)
		    && (ati_remote->repeat_count < 5))
			return;
		

		input_regs(dev, regs);
		input_event(dev, ati_remote_tbl[index].type,
			ati_remote_tbl[index].code, 1);
		input_event(dev, ati_remote_tbl[index].type,
			ati_remote_tbl[index].code, 0);
		input_sync(dev);

		return;
	}			
	
	/* 
	 * Other event kinds are from the directional control pad, and have an
	 * acceleration factor applied to them.  Without this acceleration, the
	 * control pad is mostly unusable.
	 * 
	 * If elapsed time since last event is > 1/4 second, user "stopped",
	 * so reset acceleration. Otherwise, user is probably holding the control
	 * pad down, so we increase acceleration, ramping up over two seconds to
	 * a maximum speed.  The acceleration curve is #defined above.
	 */
	if ((jiffies - ati_remote->old_jiffies) > (HZ >> 2)) {
		acc = 1;
		ati_remote->acc_jiffies = jiffies;
	}
	else if ((jiffies - ati_remote->acc_jiffies) < (HZ >> 3))  acc = accel[0];
	else if ((jiffies - ati_remote->acc_jiffies) < (HZ >> 2))  acc = accel[1];
	else if ((jiffies - ati_remote->acc_jiffies) < (HZ >> 1))  acc = accel[2];
	else if ((jiffies - ati_remote->acc_jiffies) < HZ )        acc = accel[3];
	else if ((jiffies - ati_remote->acc_jiffies) < HZ+(HZ>>1)) acc = accel[4];
	else if ((jiffies - ati_remote->acc_jiffies) < (HZ << 1))  acc = accel[5];
	else acc = accel[6];

	input_regs(dev, regs);
	switch (ati_remote_tbl[index].kind) {
	case KIND_ACCEL:
		input_event(dev, ati_remote_tbl[index].type,
			ati_remote_tbl[index].code,
			ati_remote_tbl[index].value * acc);
		break;
	case KIND_LU:
		input_report_rel(dev, REL_X, -acc);
		input_report_rel(dev, REL_Y, -acc);
		break;
	case KIND_RU:
		input_report_rel(dev, REL_X, acc);
		input_report_rel(dev, REL_Y, -acc);
		break;
	case KIND_LD:
		input_report_rel(dev, REL_X, -acc);
		input_report_rel(dev, REL_Y, acc);
		break;
	case KIND_RD:
		input_report_rel(dev, REL_X, acc);
		input_report_rel(dev, REL_Y, acc);
		break;
	default:
		dev_dbg(&ati_remote->interface->dev, "ati_remote kind=%d\n", 
			ati_remote_tbl[index].kind);
	}
	input_sync(dev);

	ati_remote->old_jiffies = jiffies;
	ati_remote->old_data[0] = data[1];
	ati_remote->old_data[1] = data[2];
}

/*
 *	ati_remote_irq_in
 */
static void ati_remote_irq_in(struct urb *urb, struct pt_regs *regs)
{
	struct ati_remote *ati_remote = urb->context;
	int retval;

	switch (urb->status) {
	case 0:			/* success */
		ati_remote_input_report(urb, regs);
		break;
	case -ECONNRESET:	/* unlink */
	case -ENOENT:
	case -ESHUTDOWN:
		dev_dbg(&ati_remote->interface->dev, "%s: urb error status, unlink? \n",
			__FUNCTION__);
		return;	
	default:		/* error */
		dev_dbg(&ati_remote->interface->dev, "%s: Nonzero urb status %d\n", 
			__FUNCTION__, urb->status);
	}
	
	retval = usb_submit_urb(urb, SLAB_ATOMIC);
	if (retval)
		dev_err(&ati_remote->interface->dev, "%s: usb_submit_urb()=%d\n",
			__FUNCTION__, retval);
}

/*
 *	ati_remote_delete
 */
static void ati_remote_delete(struct ati_remote *ati_remote)
{
	if (!ati_remote) return;

	if (ati_remote->irq_urb)
		usb_unlink_urb(ati_remote->irq_urb);

	if (ati_remote->out_urb)
		usb_unlink_urb(ati_remote->out_urb);

	input_unregister_device(&ati_remote->idev);

	if (ati_remote->inbuf)
		usb_buffer_free(ati_remote->udev, DATA_BUFSIZE, 
				ati_remote->inbuf, ati_remote->inbuf_dma);
		
	if (ati_remote->outbuf)
		usb_buffer_free(ati_remote->udev, DATA_BUFSIZE, 
				ati_remote->inbuf, ati_remote->outbuf_dma);
	
	if (ati_remote->irq_urb)
		usb_free_urb(ati_remote->irq_urb);
	
	if (ati_remote->out_urb)
		usb_free_urb(ati_remote->out_urb);

	kfree(ati_remote);
}

static void ati_remote_input_init(struct ati_remote *ati_remote)
{
	struct input_dev *idev = &(ati_remote->idev);
	int i;

	idev->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
	idev->keybit[LONG(BTN_MOUSE)] = ( BIT(BTN_LEFT) | BIT(BTN_RIGHT) | 
					  BIT(BTN_SIDE) | BIT(BTN_EXTRA) );
	idev->relbit[0] = BIT(REL_X) | BIT(REL_Y);
	for (i = 0; ati_remote_tbl[i].kind != KIND_END; i++)
		if (ati_remote_tbl[i].type == EV_KEY)
			set_bit(ati_remote_tbl[i].code, idev->keybit);
	
	idev->private = ati_remote;
	idev->open = ati_remote_open;
	idev->close = ati_remote_close;
	
	idev->name = ati_remote->name;
	idev->phys = ati_remote->phys;
	
	idev->id.bustype = BUS_USB;		
	idev->id.vendor = ati_remote->udev->descriptor.idVendor;
	idev->id.product = ati_remote->udev->descriptor.idProduct;
	idev->id.version = ati_remote->udev->descriptor.bcdDevice;
}

static int ati_remote_initialize(struct ati_remote *ati_remote)
{
	struct usb_device *udev = ati_remote->udev;
	int pipe, maxp;
		
	init_waitqueue_head(&ati_remote->wait);

	/* Set up irq_urb */
	pipe = usb_rcvintpipe(udev, ati_remote->endpoint_in->bEndpointAddress);
	maxp = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
	maxp = (maxp > DATA_BUFSIZE) ? DATA_BUFSIZE : maxp;
	
	usb_fill_int_urb(ati_remote->irq_urb, udev, pipe, ati_remote->inbuf, 
			 maxp, ati_remote_irq_in, ati_remote, 
			 ati_remote->endpoint_in->bInterval);
	ati_remote->irq_urb->transfer_dma = ati_remote->inbuf_dma;
	ati_remote->irq_urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
	
	/* Set up out_urb */
	pipe = usb_sndintpipe(udev, ati_remote->endpoint_out->bEndpointAddress);
	maxp = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
	maxp = (maxp > DATA_BUFSIZE) ? DATA_BUFSIZE : maxp;

	usb_fill_int_urb(ati_remote->out_urb, udev, pipe, ati_remote->outbuf, 
			 maxp, ati_remote_irq_out, ati_remote, 
			 ati_remote->endpoint_out->bInterval);
	ati_remote->out_urb->transfer_dma = ati_remote->outbuf_dma;
	ati_remote->out_urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;

	/* send initialization strings */
	if ((ati_remote_sendpacket(ati_remote, 0x8004, init1)) ||
	    (ati_remote_sendpacket(ati_remote, 0x8007, init2))) {
		dev_err(&ati_remote->interface->dev, 
			 "Initializing ati_remote hardware failed.\n");
		return 1;
	}
	
	return 0;
}

/*
 *	ati_remote_probe
 */
static int ati_remote_probe(struct usb_interface *interface, const struct usb_device_id *id)
{
	struct usb_device *udev = interface_to_usbdev(interface);
	struct ati_remote *ati_remote = NULL;
	struct usb_host_interface *iface_host;
	int retval = -ENOMEM;
	char path[64];
	char *buf = NULL;

	/* See if the offered device matches what we can accept */
	if ((udev->descriptor.idVendor != ATI_REMOTE_VENDOR_ID) ||
		( (udev->descriptor.idProduct != ATI_REMOTE_PRODUCT_ID) &&
		  (udev->descriptor.idProduct != LOLA_REMOTE_PRODUCT_ID) ))
		return -ENODEV;

	/* Allocate and clear an ati_remote struct */
	if (!(ati_remote = kmalloc(sizeof (struct ati_remote), GFP_KERNEL)))
		return -ENOMEM;
	memset(ati_remote, 0x00, sizeof (struct ati_remote));

	iface_host = interface->cur_altsetting;
	if (iface_host->desc.bNumEndpoints != 2) {
		err("%s: Unexpected desc.bNumEndpoints\n", __FUNCTION__);
		retval = -ENODEV;
		goto error;
	}

	ati_remote->endpoint_in = &(iface_host->endpoint[0].desc);
	ati_remote->endpoint_out = &(iface_host->endpoint[1].desc);
	ati_remote->udev = udev;
	ati_remote->interface = interface;

	if (!(ati_remote->endpoint_in->bEndpointAddress & 0x80)) {
		err("%s: Unexpected endpoint_in->bEndpointAddress\n", __FUNCTION__);
		retval = -ENODEV;
		goto error;
	}
	if ((ati_remote->endpoint_in->bmAttributes & 3) != 3) {
		err("%s: Unexpected endpoint_in->bmAttributes\n", __FUNCTION__);
		retval = -ENODEV;
		goto error;
	}
	if (ati_remote->endpoint_in->wMaxPacketSize == 0) {
		err("%s: endpoint_in message size==0? \n", __FUNCTION__);
		retval = -ENODEV;
		goto error;
	}
	if (!(buf = kmalloc(NAME_BUFSIZE, GFP_KERNEL)))
		goto error;

	/* Allocate URB buffers, URBs */
	ati_remote->inbuf = usb_buffer_alloc(udev, DATA_BUFSIZE, SLAB_ATOMIC,
					     &ati_remote->inbuf_dma);
	if (!ati_remote->inbuf)
		goto error;

	ati_remote->outbuf = usb_buffer_alloc(udev, DATA_BUFSIZE, SLAB_ATOMIC,
					      &ati_remote->outbuf_dma);
	if (!ati_remote->outbuf)
		goto error;

	ati_remote->irq_urb = usb_alloc_urb(0, GFP_KERNEL);
	if (!ati_remote->irq_urb)
		goto error;

	ati_remote->out_urb = usb_alloc_urb(0, GFP_KERNEL);
	if (!ati_remote->out_urb)
		goto error;

	usb_make_path(udev, path, NAME_BUFSIZE);
	sprintf(ati_remote->phys, "%s/input%d", path, ATI_INPUTNUM);
	if (udev->descriptor.iManufacturer && 
	    (usb_string(udev, udev->descriptor.iManufacturer, buf, 
			NAME_BUFSIZE) > 0))
		strcat(ati_remote->name, buf);

	if (udev->descriptor.iProduct && 
	    (usb_string(udev, udev->descriptor.iProduct, buf, NAME_BUFSIZE) > 0))
		sprintf(ati_remote->name, "%s %s", ati_remote->name, buf);

	if (!strlen(ati_remote->name))
		sprintf(ati_remote->name, DRIVER_DESC "(%04x,%04x)",
			ati_remote->udev->descriptor.idVendor, 
			ati_remote->udev->descriptor.idProduct);

	/* Device Hardware Initialization - fills in ati_remote->idev from udev. */
	retval = ati_remote_initialize(ati_remote);
	if (retval)
		goto error;

	/* Set up and register input device */
	ati_remote_input_init(ati_remote);
	input_register_device(&ati_remote->idev);

	dev_info(&ati_remote->interface->dev, "Input registered: %s on %s\n", 
		 ati_remote->name, path);

	usb_set_intfdata(interface, ati_remote);
	ati_remote->present = 1;	
	
error:
	if (buf)
		kfree(buf);

	if (retval)
		ati_remote_delete(ati_remote);

	return retval;
}

/*
 *	ati_remote_disconnect
 */
static void ati_remote_disconnect(struct usb_interface *interface)
{
	struct ati_remote *ati_remote;

	down(&disconnect_sem);

	ati_remote = usb_get_intfdata(interface);
	usb_set_intfdata(interface, NULL);
	if (!ati_remote) {
		warn("%s - null device?\n", __FUNCTION__);
		return;
	}
	
	/* Mark device as unplugged */
	ati_remote->present = 0;

	/* If device is still open, ati_remote_close will call delete. */
	if (!ati_remote->open)
		ati_remote_delete(ati_remote);

	up(&disconnect_sem);
}

/*
 *	ati_remote_init
 */
static int __init ati_remote_init(void)
{
	int result;
	
	result = usb_register(&ati_remote_driver);
	if (result)
		err("usb_register error #%d\n", result);
	else
		info("Registered USB driver " DRIVER_DESC " v. " DRIVER_VERSION);

	return result;
}

/*
 *	ati_remote_exit
 */
static void __exit ati_remote_exit(void)
{
	usb_deregister(&ati_remote_driver);
}

/* 
 *	module specification 
 */

module_init(ati_remote_init);
module_exit(ati_remote_exit);

MODULE_AUTHOR(DRIVER_AUTHOR);
MODULE_DESCRIPTION(DRIVER_DESC);
MODULE_LICENSE("GPL");

--=-rPSdj/FBREro8IuI3iwp--

