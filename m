Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161390AbWLAXO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161390AbWLAXO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162169AbWLAXO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:14:59 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34759 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161390AbWLAXO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:14:57 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Greg KH <gregkh@suse.de>
Cc: "Lu, Yinghai" <yinghai.lu@amd.com>,
       Stefan Reinauer <stepan@coresystems.de>,
       Peter Stuge <stuge-linuxbios@cdy.org>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
References: <5986589C150B2F49A46483AC44C7BCA4907276@ssvlexmb2.amd.com>
	<20061201191916.GB3539@suse.de>
Date: Fri, 01 Dec 2006 16:13:39 -0700
In-Reply-To: <20061201191916.GB3539@suse.de> (Greg KH's message of "Fri, 1 Dec
	2006 11:19:16 -0800")
Message-ID: <m1slfzfbvg.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Greg KH <gregkh@suse.de> writes:

> On Fri, Dec 01, 2006 at 10:55:48AM -0800, Lu, Yinghai wrote:
>> -----Original Message-----
>> From: Greg KH [mailto:gregkh@suse.de] 
>> 
>> >I can do that in about 15 minutes if you give me the device ids for the
>> >usb debug device that you wish to have.
>> 
>> >Or you can also use the generic usb-serial driver today just fine with
>> >no modification.  Have you had a problem with using that option?
>> 
>> We are talking about using USB debug device/EHCI debug port in LinuxBIOS
>> in legacy free PC.
>> Because one AM2+MCP55 MB doesn't have serial port.
>> 
>> I guess Eric is working on USB debug device/EHCI debug port for
>> earlyprintk or printk.
>
> Well, earlyprintk will not work, as you need PCI up and running.
>
> And I have some code that barely works for this already, perhaps Eric
> and I should work together on this :)

I'd love to work with someone on this.  I'm cc'ing Andi Kleen because
he asked me where we had gotten on this the other day.

One big thing we need is a way to tell if you have the
system booted if your device is plugged into the usb port that
connects to the usb debug port.  Figuring out which usb port
you really have to plug into is still trying and error but at
least being able to tell without having to try the code is good.

So here is my mostly somewhat working code.  I don't understand
what you have todo if you want to reset the device and then
find the device so this code currently only works if you have
ehci_hcd already loaded. 

I am avoiding the pci bit simply by having someone pass me the
hard coded numbers...

I think I can get it down to a single base address if I don't
print debugging of which port you are plugged into, or try and
debug the state out of reset.

usbtest.c is my little libusb client program.  It's useful
for exploring things.

usbdebug_direct.c is roughly a driver living in user space
so I can debug the hard bits of the logic.  Not a good production
technique but great for prototyping.  It has all of the basic
primitives needed to actually use the ehci debug port.

The next big thing for me I guess is to modify a kernel and see
what state the usb ports are in when I am booting and how much
of the reset logic I need to understand to make this work.
Greg I expect you understand that a little better than I do.

Eric


--=-=-=
Content-Type: text/x-csrc
Content-Disposition: inline; filename=usbtest.c

/*
 * Copyright (C) 2006 Eric Biederman (ebiederm@xmission.com)
 *
 *	This program is free software; you can redistribute it and/or
 *	modify it under the terms of the GNU General Public License version
 *	2 as published by the Free Software Foundation.
 *
 *      gcc -Wall -o ./usbtest ./usbtest.c -lusb
 */
#include <stdarg.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <usb.h>

#define DEBUG_DEVICE_MAX 8

#ifndef USB_DT_DEBUG
#define USB_DT_DEBUG	10
#endif
#ifndef USB_FT_DEBUG_MODE
#define USB_FT_DEBUG_MODE	6
#endif 
#define CTRL_TIMEOUT	(5*1000)	/* milliseconds */
#define WRITE_TIMEOUT	(60*1000*1000)	/* 1 minute */

struct usb_debug_descriptor {
	uint8_t	bLength;
	uint8_t bDescriptorType;
	uint8_t bDebugInEndpoint;
	uint8_t bDebugOutEndpoint;
} __attribute__ ((packed));


static void die(char *fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
	fflush(stderr);
	fflush(stdout);
	exit(1);
}


static struct usb_device *next_debug_device(struct usb_device *dev,
	struct usb_debug_descriptor *debug)
{
	struct usb_bus *bus;
	if (dev) {
		bus = dev->bus;
		goto next;
	}
	for (bus = usb_busses; bus; bus = bus->next) {
		for (dev = bus->devices; dev; dev = dev->next) {
			struct usb_dev_handle *handle;
			int ret;
#if 1
			printf("%02x:%02x\n",
				dev->descriptor.idVendor,
				dev->descriptor.idProduct);
#endif
			handle = usb_open(dev);
			if (!handle)
				goto next;
			ret = usb_get_descriptor(handle, USB_DT_DEBUG, 0,
				debug, sizeof(*debug));
			usb_close(handle);
#if 1
			printf("ret: %d\n", ret);
#endif
			if (ret == sizeof(*debug))
				return dev;
next:
			;
		}
	}
	return NULL;
}

static int usb_set_debug_mode(usb_dev_handle *handle)
{
	return usb_control_msg(handle, USB_TYPE_STANDARD | USB_RECIP_DEVICE,
		USB_REQ_SET_FEATURE, USB_FT_DEBUG_MODE, 0, NULL, 0,
		CTRL_TIMEOUT);
		
}

static int usb_unconfigure(usb_dev_handle *handle)
{
	return usb_control_msg(handle, USB_TYPE_STANDARD | USB_RECIP_DEVICE,
		USB_REQ_SET_CONFIGURATION, 0, 0, NULL, 0,
		CTRL_TIMEOUT);
}


static int usb_debug_read(struct usb_device *dev,
				struct usb_debug_descriptor *debug)
{
	struct usb_dev_handle *handle;
	char buf[DEBUG_DEVICE_MAX];
	int iface, i, j;
	int ret = -1;

	/* Find the interface to claim! */
	iface = -1;
	for (i = 0; i < dev->config->interface->num_altsetting; i++) {
		struct usb_interface_descriptor *face;
		face = &dev->config->interface->altsetting[i];
		for (j = 0; j < face->bNumEndpoints; j++) {
			if (face->endpoint[j].bEndpointAddress == 
			    debug->bDebugInEndpoint) {
				iface = face->bInterfaceNumber;
				printf("wMaxPacketSize: %u iface: %d\n",
					face->endpoint[j].bEndpointAddress,
					iface);
				goto found_iface;
			}
		}
	}
	goto out;
found_iface:

	handle = usb_open(dev);
	if (!handle)
		goto out;
	if ((ret = usb_claim_interface(handle, iface)) < 0)
		goto out_close;
	if ((ret = usb_set_debug_mode(handle)) < 0)
		goto out_release;
	for (;;) {
		ret = usb_bulk_read(handle, debug->bDebugInEndpoint,
			buf, sizeof(buf), 1000000);
		if (ret < 0)
			goto out_release;
		printf("%d:%*.*s", ret, ret, ret, buf);
	}
out_release:
	usb_release_interface(handle, iface);
out_close:	
	usb_close(handle);
out:
	return ret;
}


static int usb_debug_write(struct usb_device *dev,
				struct usb_debug_descriptor *debug)
{
	struct usb_dev_handle *handle;
	char buf[DEBUG_DEVICE_MAX];
	int iface, i, j;
	int ret;

	ret = -1;
	/* Find the interface to claim! */
	iface = -1;
	for (i = 0; i < dev->config->interface->num_altsetting; i++) {
		struct usb_interface_descriptor *face;
		face = &dev->config->interface->altsetting[i];
		for (j = 0; j < face->bNumEndpoints; j++) {
			if (face->endpoint[j].bEndpointAddress == 
			    debug->bDebugOutEndpoint) {
				iface = face->bInterfaceNumber;
				printf("wMaxPacketSize: %u iface: %d\n",
					face->endpoint[j].bEndpointAddress,
					iface);
				goto found_iface;
			}
		}
	}
	goto out;
found_iface:
	handle = usb_open(dev);
	if (!handle)
		goto out;
	if ((ret = usb_claim_interface(handle, iface)) < 0)
		goto out_close;
	if ((ret = usb_set_debug_mode(handle)) < 0)
		goto out_release;
	for (;;) {
		if ((ret = read(STDIN_FILENO, buf, sizeof(buf))) <= 0)
			goto out_shutdown;

#if 1
		printf("%d:%*.*s", ret, ret, ret, buf);
#endif
		ret = usb_bulk_write(handle, debug->bDebugOutEndpoint,
			buf, ret, WRITE_TIMEOUT);
#if 1
		printf("usb_bulk_write: %d\n", ret);
#endif
		if (ret < 0)
			goto out_shutdown;
	}
out_shutdown:
	usb_unconfigure(handle);
out_release:
	usb_release_interface(handle, iface);
out_close:	
	usb_close(handle);
out:
	return ret;
}

enum debug_op {
	DEBUG_LIST = 0,
	DEBUG_REDIR = 1,
	DEBUG_READ  = 2,
	DEBUG_WRITE = 3,
};
int main(int argc, char **argv)
{
	struct usb_device *dev;
	struct usb_debug_descriptor debug_desc;
	int i;
	int wanted_bus, wanted_dev;
	int wanted_vendor, wanted_product;
	enum debug_op op;

	op = DEBUG_REDIR;
	wanted_bus = wanted_dev = -1;
	wanted_vendor = wanted_product = -1;
	for (i = 1; i < argc; i++) {
		if (strcmp(argv[i], "-s") == 0) {
			char *colon;
			i++;
			if (i >= argc)
				die("missing argument");
			colon = strchr(argv[i], ':');
			if (!colon)
				wanted_dev = strtoul(argv[i], NULL, 10);
			else {
				wanted_bus = strtoul(argv[i], NULL, 10);
				wanted_dev = strtoul(colon + 1, NULL, 10);
			}
		} 
		else if (strcmp(argv[i], "-d") == 0) {
			char *colon;
			i++;
			if (i >= argc)
				die("missing argument");
			wanted_vendor = strtoul(argv[i], NULL, 16);
			if (colon)
				wanted_product = strtoul(colon + 1, NULL, 16);
		}
		else if (strcmp(argv[i], "-l") == 0) {
			op = DEBUG_LIST;
		}
		else if (strcmp(argv[i], "-r") == 0) {
			op = DEBUG_READ;
		}
		else if (strcmp(argv[i], "-w") == 0) {
			op = DEBUG_WRITE;
		}
		else if (strcmp(argv[i], "-rw") == 0) {
			op = DEBUG_REDIR;
		}
		else {
			die("Unknown argument: %s\n", argv[i]);
		}
#if 0
		if (strcmp(argv[i], "-d") == 0)
			break;
#endif
	}

	
	usb_init();
	usb_find_busses();
	usb_find_devices();
	
	dev = next_debug_device(NULL, &debug_desc);
	for (; dev; dev = next_debug_device(dev, &debug_desc)) {
		int busnum;
		busnum = strtol(dev->bus->dirname, NULL, 10);
		if ((wanted_bus != -1) && (busnum != wanted_bus))
			continue;
		if ((wanted_dev != -1) && (dev->devnum != wanted_dev))
			continue;
		if ((wanted_vendor != -1) && 
		    (dev->descriptor.idVendor != wanted_vendor))
			continue;
		if ((wanted_product != -1) && 
		    (dev->descriptor.idProduct != wanted_product))
			continue;
		if (op != DEBUG_LIST)
			goto found;
		printf("%d.%d %04x:%04x\n",
			busnum, dev->devnum,
			dev->descriptor.idVendor,
			dev->descriptor.idProduct);
	}
	if (op == DEBUG_LIST)
		return 0;
	die("No debug devices found\n");
found:	
	printf("Found one!\n");
	printf("desc: %02x %02x %02x %02x\n",
		debug_desc.bLength,
		debug_desc.bDescriptorType,
		debug_desc.bDebugInEndpoint,
		debug_desc.bDebugOutEndpoint);


	switch(op) {
	case DEBUG_READ:
		usb_debug_read(dev, &debug_desc);
		break;
	case DEBUG_WRITE:
		usb_debug_write(dev, &debug_desc);
		break;
	default:
		die("Unknown operation\n");
	}
	return 0;
}

--=-=-=
Content-Type: text/x-csrc
Content-Disposition: inline; filename=usbdebug_direct.c

/*
 * Copyright (C) 2006 Eric Biederman (ebiederm@xmission.com)
 *
 *	This program is free software; you can redistribute it and/or
 *	modify it under the terms of the GNU General Public License version
 *	2 as published by the Free Software Foundation.
 *
 *      gcc -Wall -o ./usbdebug_direct ./usbdebug_direct.c
 */

#define _LARGEFILE_SOURCE
#define _FILE_OFFSET_BITS 64
#define _POSIC_C_SOURCE 199309
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdarg.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <time.h>

static void die(char *fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
	fflush(stderr);
	fflush(stdout);
	exit(1);
}


static inline uint8_t readb(const volatile void  *addr)
{
	return *(volatile uint8_t *)addr;
}
static inline uint16_t readw(const volatile void  *addr)
{
	return *(volatile uint16_t *)addr;
}
static inline uint32_t readl(const volatile void  *addr)
{
	return *(volatile uint32_t *)addr;
}
static inline void writel(uint32_t b, volatile void  *addr)
{
	*(volatile uint32_t *)addr = b;
}
static inline void writeb(uint8_t b, volatile void  *addr)
{
	*(volatile uint8_t *)addr = b;
}
static inline void writew(uint16_t b, volatile void  *addr)
{
	*(volatile uint16_t *)addr = b;
}


//#define EHCI_BAR 0xbfce0000
#define EHCI_BAR_BYTES 4096
//#define EHCI_DEBUG_OFFSET 0x98
#define PAGE_SIZE 4096UL

static void *ehci_base, *ehci_op_base, *ehci_debug_base;

/* Off of ehci_base */
#define EHCI_CAPLENGTH		0x00
#define EHCI_HCIVERSION		0x02
#define EHCI_HCSPARAMS		0x04
#define EHCI_HCCPARAMS		0x08
#define EHCI_HCSP_PORTROUTE	0x0c

/* Off of ehci_op_base */
#define EHCI_USBCMD		0x00
#define  EHCI_USBCMD_RUN		(1 << 0)
#define EHCI_USBSTS		0x04
#define  EHCI_USBSTS_HCHALTED		(1 << 12)
#define EHCI_USBINTR		0x08
#define EHCI_FRINDEX		0x0c
#define EHCI_CTRLDSSEGMENT	0x10
#define EHCI_PERIODICLISTBASE	0x14
#define EHCI_ASYNCLISTADDR	0x18
#define EHCI_CONFIGFLAG		0x40
#define  EHCI_CONFIGFLAG_FLAG		(1 << 0)
#define EHCI_PORTSC		0x44
#define  EHCI_PORTSC_PORT_OWNER			(1 << 13)
#define  EHCI_PORTSC_PORT_RESET			(1 << 12)
#define  EHCI_PORTSC_PORT_ENABLED		(1 << 2)
#define  EHCI_PORTSC_CONNECT_STATUS_CHANGED	(1 << 1)
#define  EHCI_PORTSC_CONNECTED			(1 << 0)

/* Off of ehci_debug_base */
#define EHCI_CTRL	0x00
#define  EHCI_CTRL_OWNER			(1 << 30)
#define  EHCI_CTRL_ENABLED			(1 << 28)
#define  EHCI_CTRL_DONE				(1 << 16)
#define  EHCI_CTRL_INUSE			(1 << 10)
#define  EHCI_CTRL_EXCEPTION_MASK		7
#define  EHCI_CTRL_EXCEPTION_SHIFT		7
#define  EHCI_CTRL_EXCEPTION_NONE		0
#define  EHCI_CTRL_EXCEPTION_TRANSACTION	1
#define  EHCI_CTRL_EXCEPTION_HARDWARE		2
#define  EHCI_CTRL_ERROR			(1 << 6)
#define  EHCI_CTRL_GO				(1 << 5)
#define  EHCI_CTRL_WRITE			(1 << 4)
#define  EHCI_CTRL_LENGTH_MASK			(0xf << 0)
#define EHCI_PID		0x04
#define  EHCI_PID_RECEIVED_SHIFT	16
#define  EHCI_PID_SEND_SHIFT		8
#define  EHCI_PID_TOKEN_SHIFT		0
#define EHCI_DATA0	0x08
#define EHCI_DATA1	0x0c
#define EHCI_ADDR	0x10
#define  EHCI_ADDR_DEVNUM_SHIFT   8
#define  EHCI_ADDR_ENDPOINT_SHIFT 0

#define MKPID(x) (((x) & 0xf) | ((~(x) & 0xf) << 4))

/* token */
#define PID_OUT	MKPID(0x1)
#define PID_IN	MKPID(0x9)
#define PID_SOF	MKPID(0x5)
#define PID_SETUP	MKPID(0xd)
/* data */
#define PID_DATA0	MKPID(0x3)
#define PID_DATA1	MKPID(0xb)
#define PID_DATA2	MKPID(0x7)
#define PID_MDATA	MKPID(0xf)
#define PID_DATA_TOGGLE	(0x88)
/* handshake */
#define PID_ACK	MKPID(0x2)
#define PID_NAK	MKPID(0xa)
#define PID_STALL	MKPID(0xe)
#define PID_NYET	MKPID(0x6)
/* Special */
#define PID_PRE	MKPID(0xc)
#define PID_ERR	MKPID(0xc)
#define PID_SPLIT	MKPID(0x8)
#define PID_PING	MKPID(0x4)
#define PID_RESERVED	MKPID(0x0)

/*
 * Standard requests
 */
#define USB_REQ_GET_STATUS              0x00
#define USB_REQ_CLEAR_FEATURE           0x01
/* 0x02 is reserved */
#define USB_REQ_SET_FEATURE             0x03
/* 0x04 is reserved */
#define USB_REQ_SET_ADDRESS             0x05
#define USB_REQ_GET_DESCRIPTOR          0x06
#define USB_REQ_SET_DESCRIPTOR          0x07
#define USB_REQ_GET_CONFIGURATION       0x08
#define USB_REQ_SET_CONFIGURATION       0x09
#define USB_REQ_GET_INTERFACE           0x0A
#define USB_REQ_SET_INTERFACE           0x0B
#define USB_REQ_SYNCH_FRAME             0x0C

#define USB_TYPE_STANDARD	(0x00 << 5)
#define USB_TYPE_CLASS		(0x01 << 5)
#define USB_TYPE_VENDOR		(0x02 << 5)
#define USB_TYPE_RESERVED	(0x03 << 5)

#define USB_RECIP_DEVICE                0x00
#define USB_RECIP_INTERFACE             0x01
#define USB_RECIP_ENDPOINT              0x02
#define USB_RECIP_OTHER                 0x03

/*
 * Various libusb API related stuff
 */

#define USB_ENDPOINT_IN                 0x80
#define USB_ENDPOINT_OUT                0x00

#ifndef USB_DT_DEBUG
#define USB_DT_DEBUG	10
#endif
#ifndef USB_FT_DEBUG_MODE
#define USB_FT_DEBUG_MODE	6
#endif 

struct usb_debug_descriptor {
	uint8_t	bLength;
	uint8_t bDescriptorType;
	uint8_t bDebugInEndpoint;
	uint8_t bDebugOutEndpoint;
} __attribute__ ((packed));

struct usb_status {
	uint16_t status;
} __attribute__ ((packed));


struct usb_request {
	uint8_t  bmRequestType;
	uint8_t  bRequest;
	uint16_t wValue;
	uint16_t wIndex;
	uint16_t wLength;
} __attribute__ ((packed));

static int usb_wait_until_complete(void)
{
	unsigned ctrl;
	for (;;) {
		ctrl = readl(ehci_debug_base + EHCI_CTRL);
		/* Stop when the transaction is finished */
		if (ctrl & EHCI_CTRL_DONE)
			break;
	}
	/* Now that we have observed the completed transaction,
	 * clear the done bit.
	 */
	writel(ctrl | EHCI_CTRL_DONE, ehci_debug_base + EHCI_CTRL);
	return (ctrl & EHCI_CTRL_ERROR) ? 
		-((ctrl >> EHCI_CTRL_EXCEPTION_SHIFT) & EHCI_CTRL_EXCEPTION_MASK):
		ctrl & 0xf;
}

static void usb_breath(void)
{
	struct timespec req;
	/* Sleep to give the debug port a chance to breathe */
	req.tv_sec = 0;
	req.tv_nsec = 10*1000*1000; /* 10 miliseconds seems good */

	while (nanosleep(&req, &req) < 0)
		;
}

static int usb_wait_until_done(unsigned ctrl)
{
	unsigned pids, lpid;
	int ret;

retry:
	writel(ctrl | EHCI_CTRL_GO, ehci_debug_base + EHCI_CTRL);
	ret = usb_wait_until_complete();
	pids = readl(ehci_debug_base + EHCI_PID);
	lpid = (pids >> EHCI_PID_RECEIVED_SHIFT) & 0xff;
#if 0
	if ((ret >= 0) && lpid != PID_ACK)
		printf("lpid: %02x ret: %d\n", lpid, ret);
#endif
	if (ret < 0)
		return ret;

	/* If the port is getting full or it has dropped data
	 * start pacing ourselves, not necessary but it's friendly.
	 */
	if ((lpid == PID_NAK) || (lpid == PID_NYET))
		usb_breath();
	
	/* If I get a NACK reissue the transmission */
	if (lpid == PID_NAK)
		goto retry;

	return ret;
}

static void usb_set_data(const void *buf, int size)
{
	const unsigned char *bytes = buf;
	uint32_t lo, hi;
	int i;
	lo = hi = 0;
	for (i = 0; i < 4 && i < size; i++)
		lo |= bytes[i] << (8*i);
	for (; i < 8 && i < size; i++)
		hi |= bytes[i] << (8*(i - 4));
	writel(lo, ehci_debug_base + EHCI_DATA0);
	writel(hi, ehci_debug_base + EHCI_DATA1);
}

static void usb_get_data(void *buf, int size)
{
	unsigned char *bytes = buf;
	uint32_t lo, hi;
	int i;
	lo = readl(ehci_debug_base + EHCI_DATA0);
	hi = readl(ehci_debug_base + EHCI_DATA1);
#if 0
	printf("data: %08x%08x\n", hi, lo);
#endif
	for (i = 0; i < 4 && i < size; i++)
		bytes[i] = (lo >> (8*i)) & 0xff;
	for (; i < 8 && i < size; i++)
		bytes[i] = (hi >> (8*(i - 4))) & 0xff;
}

static int usb_bulk_write(int address, int endpoint, const char *bytes, int size)
{
	unsigned pids, addr, ctrl;
	int ret;
	if (size > 8)
		return -1;

	addr = ((address & 0x7f) << EHCI_ADDR_DEVNUM_SHIFT) | (endpoint & 0xf);

	pids = readl(ehci_debug_base + EHCI_PID);
	pids &= ~(0xff << EHCI_PID_TOKEN_SHIFT);
	pids |= PID_OUT << EHCI_PID_TOKEN_SHIFT;
	pids ^= (PID_DATA_TOGGLE << EHCI_PID_SEND_SHIFT);
	
	ctrl = readl(ehci_debug_base + EHCI_CTRL);
	ctrl &= ~EHCI_CTRL_LENGTH_MASK;
	ctrl |= EHCI_CTRL_WRITE;
	ctrl |= size & EHCI_CTRL_LENGTH_MASK;
	ctrl |= EHCI_CTRL_GO;

	usb_set_data(bytes, size);
	writel(addr, ehci_debug_base + EHCI_ADDR);
	writel(pids, ehci_debug_base + EHCI_PID);

	ret = usb_wait_until_done(ctrl);
	if (ret < 0) {
		printf("out failed!: %d\n", ret);
		return ret;
	}
	return ret;
}

static int usb_bulk_read(int address, int endpoint, void *data, int size)
{
	unsigned pids, addr, ctrl;
	int ret;

	if (size > 8)
		return -1;

	addr = ((address & 0x7f) << EHCI_ADDR_DEVNUM_SHIFT) | (endpoint & 0xf);

	pids = readl(ehci_debug_base + EHCI_PID);
	pids &= ~(0xff << EHCI_PID_TOKEN_SHIFT);
	pids |= PID_IN << EHCI_PID_TOKEN_SHIFT;
	pids ^= (PID_DATA_TOGGLE << EHCI_PID_SEND_SHIFT);
		
	ctrl = readl(ehci_debug_base + EHCI_CTRL);
	ctrl &= ~EHCI_CTRL_LENGTH_MASK;
	ctrl &= ~EHCI_CTRL_WRITE;
	ctrl |= size & EHCI_CTRL_LENGTH_MASK;
	ctrl |= EHCI_CTRL_GO;
		
	writel(addr, ehci_debug_base + EHCI_ADDR);
	writel(pids, ehci_debug_base + EHCI_PID);
	ret = usb_wait_until_done(ctrl);
	if (ret < 0) {
		printf("in failed!: %d\n", ret);
		return ret;
	}
	if (size > ret)
		size = ret;
	usb_get_data(data, size);
	return ret;
}

static int usb_control_msg(int address, int requesttype, int request, 
	int value, int index, void *data, int size)
{
	unsigned pids, addr, ctrl;
	struct usb_request req;
	int read;
	int ret;

	read = (requesttype & USB_ENDPOINT_IN) != 0;
	if (size > (read?8:0))
		return -1;
	
	/* Compute the control message */
	req.bmRequestType = requesttype;
	req.bRequest = request;
	req.wValue = value;
	req.wIndex = index;
	req.wLength = size;

	pids = PID_SETUP << EHCI_PID_TOKEN_SHIFT;
	pids |= PID_DATA0 << EHCI_PID_SEND_SHIFT;

	addr = ((address & 0x7f) << EHCI_ADDR_DEVNUM_SHIFT) | 0;
	
	ctrl = readl(ehci_debug_base + EHCI_CTRL);
	ctrl &= ~EHCI_CTRL_LENGTH_MASK;
	ctrl |= EHCI_CTRL_WRITE;
	ctrl |= sizeof(req) & EHCI_CTRL_LENGTH_MASK;
	ctrl |= EHCI_CTRL_GO;

	/* Send the setup message */
	usb_set_data(&req, sizeof(req));
	writel(addr, ehci_debug_base + EHCI_ADDR);
	writel(pids, ehci_debug_base + EHCI_PID);
	ret = usb_wait_until_done(ctrl);
	if (ret < 0) {
		//printf("setup failed!: %d\n", ret);
		return ret;
	}


	/* Read the result */
	ret = usb_bulk_read(address, 0, data, size);
#if 1
	pids = readl(ehci_debug_base + EHCI_PID);
	printf("final pids: %08x ret: %d, size: %d\n", pids, ret, size);
#endif
	return ret;
}

static int usb_control_msg0(int address, int requesttype, int request, 
	int value, int index)
{
	return usb_control_msg(address, requesttype, request, value, index, NULL, 0);
}

int main(int argc, char **argv)
{
	struct usb_debug_descriptor debug;
	unsigned long ehci_bar, ehci_debug_offset;
	unsigned endpoint_out, endpoint_in;
	unsigned devnum;
	unsigned hcsparams;
	unsigned debug_port, n_ports;
	int fd;
	unsigned val;
	int result = -1;
	int ret, i;

	if (argc != 3)
		die("usage: %s <bar base> <bar offset>\n"
		     "ex:  ./usbdebug_direct 0xbfce0000 0x98\n"
		     "ex:  ./usbdebug_direct 0x90404400 0xa0\n",
			argv[0]);

	ehci_bar = strtoul(argv[1], NULL, 0);
	ehci_debug_offset = strtoul(argv[2], NULL, 0);
	
	fd = open("/dev/mem", O_RDWR, O_SYNC);
	if (fd < 0)
		die("Cannot open /dev/mem: %s\n", strerror(errno));

	ehci_base = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
		ehci_bar & ~(PAGE_SIZE - 1));
	if (ehci_base == MAP_FAILED)
		die("mmap of /dev/mem failed: %s\n", strerror(errno));

	ehci_base += ehci_bar & (PAGE_SIZE - 1);
	val = readb(ehci_base + EHCI_CAPLENGTH);
	ehci_op_base = ehci_base + val;
	ehci_debug_base = ehci_base + ehci_debug_offset;


	hcsparams = readl(ehci_base + EHCI_HCSPARAMS);
	debug_port = (hcsparams >> 20) & 0xf;
	n_ports = hcsparams & 0xf;

	printf("debug_port: %d\n", debug_port);
	printf("n_ports:    %d\n", n_ports);

	for (i = 1; i <= n_ports; i++) {
		val = readl(ehci_op_base + EHCI_PORTSC + (4*(i - 1)));
		printf("portsc%d: %08x\n", i, val);
	}
#if 0
	/* Reset the silly port */
#endif 
#if 0
	/* Claim ownership, but do not enable yet */
	val = readl(ehci_debug_base + EHCI_CTRL);
	printf("ctrl: %08x\n", val);
	val |= EHCI_CTRL_OWNER;
	val &= ~(EHCI_CTRL_ENABLED | EHCI_CTRL_INUSE);
	writel(val, ehci_debug_base + EHCI_CTRL);

	val = readl(ehci_debug_base + EHCI_CTRL);
	printf("ctrl: %08x\n", val);


#if 1
	/* Ensure everything is routed to the EHCI */
	val = readl(ehci_op_base + EHCI_CONFIGFLAG);
	val |= EHCI_CONFIGFLAG_FLAG;
	writel(val, ehci_op_base + EHCI_CONFIGFLAG);


	for (i = 1; i <= n_ports; i++) {
		val = readl(ehci_op_base + EHCI_PORTSC + (4*(i - 1)));
		printf("portsc%d: %08x\n", i, val);
	}
#endif

	/* Ensure the EHCI controller is running */
	val = readl(ehci_op_base + EHCI_USBCMD);
	val |= EHCI_USBCMD_RUN;
	writel(val, ehci_op_base + EHCI_USBCMD);

	while(readl(ehci_op_base + EHCI_USBSTS) & EHCI_USBSTS_HCHALTED)
		;

	/* Reset the usb debug port */
	val = readl(ehci_op_base + EHCI_PORTSC + 4*(debug_port - 1));
	val |= EHCI_PORTSC_PORT_RESET;
	writel(val, ehci_op_base + EHCI_PORTSC + 4*(debug_port - 1));
	
	/* Sleep long enough for the reset to take effect */
	usb_breath(); /* 10 millseconds */

	/* Stop the reset of the usb debug port */
	val &= ~EHCI_PORTSC_PORT_RESET;
	writel(val, ehci_op_base + EHCI_PORTSC + 4*(debug_port - 1));


	for (i = 1; i <= n_ports; i++) {
		val = readl(ehci_op_base + EHCI_PORTSC + (4*(i - 1)));
		printf("portsc%d: %08x\n", i, val);
	}

	/* Test to see if there is an attached device */
	val = readl(ehci_op_base + EHCI_PORTSC + 4*(debug_port - 1));
	if (!(val & EHCI_PORTSC_CONNECTED)) {
		printf("No device in debug port after reset \n");
		/* Give up the device */
		return -1;
	}

	/* Enable the debug port */
	val = readl(ehci_debug_base + EHCI_CTRL);
	printf("post reset ctrl: %08x\n", val);

	val |= EHCI_CTRL_ENABLED | EHCI_CTRL_INUSE;
	writel(val, ehci_debug_base + EHCI_CTRL);

	val = readl(ehci_debug_base + EHCI_CTRL);
	printf("post reset ctrl: %08x\n", val);

# if 1
	/* Hide the presence of this device from other software */
	val = readl(ehci_op_base + EHCI_PORTSC + 4*(debug_port - 1));
	val &= ~EHCI_PORTSC_PORT_ENABLED;
	writel(val, ehci_op_base + EHCI_PORTSC + 4*(debug_port - 1));
# endif
# if 1
	/* Disable the ehci controller */
	val = readl(ehci_op_base + EHCI_USBCMD);
	val &= ~EHCI_USBCMD_RUN;
	writel(val, ehci_op_base + EHCI_USBCMD);

	while(!(readl(ehci_op_base + EHCI_USBSTS) & EHCI_USBSTS_HCHALTED))
		;
# endif
#else
#define EHCI_CTRL_CLAIM (EHCI_CTRL_OWNER | EHCI_CTRL_ENABLED | EHCI_CTRL_INUSE)
	val  = readl(ehci_debug_base + EHCI_CTRL);
	printf("ctrl: %04x\n", val);

	writel(val | EHCI_CTRL_CLAIM, ehci_debug_base + EHCI_CTRL);

	val  = readl(ehci_debug_base + EHCI_CTRL);
	printf("ctrl: %04x\n", val);
	if ((val & EHCI_CTRL_CLAIM) != EHCI_CTRL_CLAIM) {
		printf("No device in debug port\n");
		writel(val & ~EHCI_CTRL_CLAIM, ehci_debug_base + EHCI_CTRL);
		return -1;
	}
	
#endif

	printf("Find the debug device!\n");

	/* Find the debug device and make it device number 127 */
	for (devnum = 0; devnum <= 127; devnum++) {
		//printf("devnum: %d\n", devnum);
		ret = usb_control_msg(devnum, 
			USB_ENDPOINT_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE,
			USB_REQ_GET_DESCRIPTOR, (USB_DT_DEBUG << 8), 0,
			&debug, sizeof(debug));
		if (ret > 0)
			break;
	}
	if (devnum > 127) {
		printf("Could not find attached debug device\n");
		goto err;
	}
	if (ret < 0) {
		printf("Attach device is not a debug device\n");
		goto err;
	}
	printf("devnum: %d\n", devnum);
	endpoint_out = debug.bDebugOutEndpoint;
	endpoint_in = debug.bDebugInEndpoint;


	/* Move the device to 127 if it isn't already there */
	if (devnum != 127) {
		ret = usb_control_msg0(devnum,
			USB_TYPE_STANDARD | USB_RECIP_DEVICE,
			USB_REQ_SET_ADDRESS, 127, 0);
		printf("set_address: %d\n", ret);
		if (ret < 0) {
			printf("Could not move attached device to 127\n");
			goto err;
		}
		devnum = 127;
	}

	/* Enable the debug interface */
	ret = usb_control_msg0(devnum, USB_TYPE_STANDARD | USB_RECIP_DEVICE,
		USB_REQ_SET_FEATURE, USB_FT_DEBUG_MODE, 0);
	printf("set_feature_debug_mode: %d\n", ret);
	if (ret < 0) {
		printf(" Could not enable the debug device\n");
		goto err;
	}

#if 1
	{
		//unsigned devnum = 2;
		//unsigned endpoint_out = 1;
		//unsigned endpoint_in = 0x82;
		char *test_strings[] = {
			"zero\n",
			"one\n",
			"two\n",
			"three\n",
			"four\n",
			"five\n",
			"six\n",
			"seven\n",
			"eight\n",
			"nine\n",
			"ten\n",
			"eleven\n",
#if 0
			"twelve\n",
#endif
			NULL,
		};
		char **ptr;

		/* Perform a small write to get the even/odd data state in sync
		 */
		ret = usb_bulk_write(devnum, endpoint_out, " ",1);
		printf("usb_bulk_write: %d\n", ret);

		/* Write the test messages */
		for (ptr = test_strings; *ptr; ptr++) {
			/* Write a test message */
			ret = usb_bulk_write(devnum, endpoint_out,
				*ptr, strlen(*ptr));
			printf("usb_bulk_write: %d\n", ret);
		}
	}
#endif
#if 0

	/* Read some test messages */
	for (;;) {
		char buf[8];
		ret = usb_bulk_read(devnum, endpoint_in, 
			buf, sizeof(buf));
		if (ret > 0)
			printf("%d:%*.*s", ret, ret, ret, buf);
	}
#endif
	for (i = 0; i < 256; i+=1) {
		val = readb(ehci_base + i);
		printf("%02x ", val);
		if ((i & 0xf) == 0xf)
			printf("\n");
	}
	printf("\n");

	result = 0;
err:
#ifdef EHCI_CTRL_CLAIM
	val = readl(ehci_debug_base + EHCI_CTRL);
	printf("ctrl: %08x\n", val);
	val &= ~(EHCI_CTRL_CLAIM | EHCI_CTRL_WRITE);
	writel(val, ehci_debug_base + EHCI_CTRL);
	val = readl(ehci_debug_base + EHCI_CTRL);
	printf("ctrl: %08x\n", val);
#endif
	return result;
	
}

--=-=-=--
