Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWHBUjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWHBUjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWHBUjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:39:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23458 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751316AbWHBUjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:39:49 -0400
Date: Wed, 2 Aug 2006 22:39:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: driver for thinkpad fingerprint sensor
Message-ID: <20060802203925.GA13899@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here's GPLed driver for thinkpad fingerprint sensor. It is in
userspace -- for now, but it is so simple it could be easily moved
into kernel (everything is done in hardware).

Questions are:

*) should it be kernel or userspace?

*) can someone test it/fix it on X41 and similar models? It works okay
on x60.

*) are there other similar sensors? I know one in-kernel driver that
produces images, this is quite different.
								Pavel

/*
 * Fingerprint scanner driver for thinkpad x60 (and similar).
 *
 * Copyright (C) 2006 Pavel Machek <pavel@suse.cz>
 *
 *	This program is free software; you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, version 2 of the License.
 *
 * Hardware should be 248 x 4 pixels, 8bit per pixel, but seems to do matching
 * completely in hardware.
 *
   gcc thinkfinger.c -Wall -o thinkfinger -lusb

    Use thinkfinger to create result.bir files (you'll need to swipe
    finger 3 times). Use thinkfinger something.bir to recognize if
    it is the right fingerprint. Note: closed-source version will eat
    these .bir files (but they are two bytes too long), but thinkfinger
    will not eat files from closed-source version (see HACK for line
    that breaks it).

    Note that you need to be root to use this.
 */


#include <stdio.h>
#include <string.h>
#include <usb.h>
#include <fcntl.h>

typedef unsigned short u16;
typedef unsigned char u8;

/*
 * crc.c
 *
 * PURPOSE
 *	Routines to generate, calculate, and test a 16-bit CRC.
 *
 * DESCRIPTION
 *	The CRC code was devised by Don P. Mitchell of AT&T Bell Laboratories
 *	and Ned W. Rhodes of Software Systems Group. It has been published in
 *	"Design and Validation of Computer Protocols", Prentice Hall,
 *	Englewood Cliffs, NJ, 1991, Chapter 3, ISBN 0-13-539925-4.
 *
 *	Copyright is held by AT&T.
 *
 *	AT&T gives permission for the free use of the CRC source code.
 *
 * COPYRIGHT
 *	This file is distributed under the terms of the GNU General Public
 *	License (GPL). Copies of the GPL can be obtained from:
 *		ftp://prep.ai.mit.edu/pub/gnu/GPL
 *	Each contributing author retains all rights to their own work.
 */

static u16 crc_table[256] = {
	0x0000U, 0x1021U, 0x2042U, 0x3063U, 0x4084U, 0x50a5U, 0x60c6U, 0x70e7U,
	0x8108U, 0x9129U, 0xa14aU, 0xb16bU, 0xc18cU, 0xd1adU, 0xe1ceU, 0xf1efU,
	0x1231U, 0x0210U, 0x3273U, 0x2252U, 0x52b5U, 0x4294U, 0x72f7U, 0x62d6U,
	0x9339U, 0x8318U, 0xb37bU, 0xa35aU, 0xd3bdU, 0xc39cU, 0xf3ffU, 0xe3deU,
	0x2462U, 0x3443U, 0x0420U, 0x1401U, 0x64e6U, 0x74c7U, 0x44a4U, 0x5485U,
	0xa56aU, 0xb54bU, 0x8528U, 0x9509U, 0xe5eeU, 0xf5cfU, 0xc5acU, 0xd58dU,
	0x3653U, 0x2672U, 0x1611U, 0x0630U, 0x76d7U, 0x66f6U, 0x5695U, 0x46b4U,
	0xb75bU, 0xa77aU, 0x9719U, 0x8738U, 0xf7dfU, 0xe7feU, 0xd79dU, 0xc7bcU,
	0x48c4U, 0x58e5U, 0x6886U, 0x78a7U, 0x0840U, 0x1861U, 0x2802U, 0x3823U,
	0xc9ccU, 0xd9edU, 0xe98eU, 0xf9afU, 0x8948U, 0x9969U, 0xa90aU, 0xb92bU,
	0x5af5U, 0x4ad4U, 0x7ab7U, 0x6a96U, 0x1a71U, 0x0a50U, 0x3a33U, 0x2a12U,
	0xdbfdU, 0xcbdcU, 0xfbbfU, 0xeb9eU, 0x9b79U, 0x8b58U, 0xbb3bU, 0xab1aU,
	0x6ca6U, 0x7c87U, 0x4ce4U, 0x5cc5U, 0x2c22U, 0x3c03U, 0x0c60U, 0x1c41U,
	0xedaeU, 0xfd8fU, 0xcdecU, 0xddcdU, 0xad2aU, 0xbd0bU, 0x8d68U, 0x9d49U,
	0x7e97U, 0x6eb6U, 0x5ed5U, 0x4ef4U, 0x3e13U, 0x2e32U, 0x1e51U, 0x0e70U,
	0xff9fU, 0xefbeU, 0xdfddU, 0xcffcU, 0xbf1bU, 0xaf3aU, 0x9f59U, 0x8f78U,
	0x9188U, 0x81a9U, 0xb1caU, 0xa1ebU, 0xd10cU, 0xc12dU, 0xf14eU, 0xe16fU,
	0x1080U, 0x00a1U, 0x30c2U, 0x20e3U, 0x5004U, 0x4025U, 0x7046U, 0x6067U,
	0x83b9U, 0x9398U, 0xa3fbU, 0xb3daU, 0xc33dU, 0xd31cU, 0xe37fU, 0xf35eU,
	0x02b1U, 0x1290U, 0x22f3U, 0x32d2U, 0x4235U, 0x5214U, 0x6277U, 0x7256U,
	0xb5eaU, 0xa5cbU, 0x95a8U, 0x8589U, 0xf56eU, 0xe54fU, 0xd52cU, 0xc50dU,
	0x34e2U, 0x24c3U, 0x14a0U, 0x0481U, 0x7466U, 0x6447U, 0x5424U, 0x4405U,
	0xa7dbU, 0xb7faU, 0x8799U, 0x97b8U, 0xe75fU, 0xf77eU, 0xc71dU, 0xd73cU,
	0x26d3U, 0x36f2U, 0x0691U, 0x16b0U, 0x6657U, 0x7676U, 0x4615U, 0x5634U,
	0xd94cU, 0xc96dU, 0xf90eU, 0xe92fU, 0x99c8U, 0x89e9U, 0xb98aU, 0xa9abU,
	0x5844U, 0x4865U, 0x7806U, 0x6827U, 0x18c0U, 0x08e1U, 0x3882U, 0x28a3U,
	0xcb7dU, 0xdb5cU, 0xeb3fU, 0xfb1eU, 0x8bf9U, 0x9bd8U, 0xabbbU, 0xbb9aU,
	0x4a75U, 0x5a54U, 0x6a37U, 0x7a16U, 0x0af1U, 0x1ad0U, 0x2ab3U, 0x3a92U,
	0xfd2eU, 0xed0fU, 0xdd6cU, 0xcd4dU, 0xbdaaU, 0xad8bU, 0x9de8U, 0x8dc9U,
	0x7c26U, 0x6c07U, 0x5c64U, 0x4c45U, 0x3ca2U, 0x2c83U, 0x1ce0U, 0x0cc1U,
	0xef1fU, 0xff3eU, 0xcf5dU, 0xdf7cU, 0xaf9bU, 0xbfbaU, 0x8fd9U, 0x9ff8U,
	0x6e17U, 0x7e36U, 0x4e55U, 0x5e74U, 0x2e93U, 0x3eb2U, 0x0ed1U, 0x1ef0U
};

/*
 * udf_crc
 *
 * PURPOSE
 *	Calculate a 16-bit CRC checksum using ITU-T V.41 polynomial.
 *
 * DESCRIPTION
 *	The OSTA-UDF(tm) 1.50 standard states that using CRCs is mandatory.
 *	The polynomial used is:	x^16 + x^12 + x^15 + 1
 *
 * PRE-CONDITIONS
 *	data		Pointer to the data block.
 *	size		Size of the data block.
 *
 * POST-CONDITIONS
 *	<return>	CRC of the data block.
 *
 * HISTORY
 *	July 21, 1997 - Andrew E. Mileski
 *	Adapted from OSTA-UDF(tm) 1.50 standard.
 */
u16
udf_crc(u8 *data, unsigned int size, u16 crc)
{
	while (size--)
		crc = crc_table[(crc >> 8 ^ *(data++)) & 0xffU] ^ (crc << 8);

	return crc;
}

#define LED_VENDOR_ID	0x0483
#define LED_PRODUCT_ID	0x2016

struct usb_dev_handle *usb_handle;
int write_fingerprint = 0;

static void hello(struct usb_dev_handle *handle)
{
	char dummy[] = "\x10";

	/* SET_CONFIGURATION 1 -- should not be relevant */
	usb_control_msg(handle,		 	// usb_dev_handle *dev
			0x00000000,		// int requesttype
			0x00000009,		// int request
			0x001,			// int value
			0x000,			// int index
			dummy,			// char *bytes
			0x00000000,		// int size
			5000);			// int timeout

	usb_control_msg(handle,		 	// usb_dev_handle *dev
			0x00000040,		// int requesttype
			0x0000000c,		// int request
			0x100,			// int value
			0x400,			// int index
			dummy,			// char *bytes
			0x00000001,		// int size
			5000);			// int timeout
}

static struct usb_device *device_init(void)
{
	struct usb_bus *usb_bus;
	struct usb_device *dev;

	usb_init();
	usb_find_busses();
	usb_find_devices();

	for (usb_bus = usb_busses; usb_bus; usb_bus = usb_bus->next) {
		for (dev = usb_bus->devices; dev; dev = dev->next) {
			if ((dev->descriptor.idVendor == LED_VENDOR_ID) && 
			    (dev->descriptor.idProduct == LED_PRODUCT_ID))
				return dev;
		}
	}
	return NULL;
}

void printhex(unsigned char *data, int len)
{
	int i;
	for (i=0; i<len; i++)
		fprintf(stdout, "%02x%s", data[i], (i+1)%4 ? " " : " ");
	fprintf(stdout, "\n");
}

void parse_scan_reply(unsigned char *inbuf)
{
	switch (inbuf[18]) {
	case 0x0c:
		printf("Please swipe your finger\n");
		break;
	case 0x0d: case 0x0e:
		printf("Please swipe your finger %d rd time\n", inbuf[18]-0x0c);
		break;
	case 0x20:
		printf("Processing\n");
		break;
	case 0x00:
		printf("...and the result is:\n");
		break;
	default:
		printf("Scanning: %02x\n", inbuf[18]);
	}
}

void process_fingerprint(unsigned char *buf)
{
	int birfile = open("result.bir", O_WRONLY | O_CREAT, 0777);
	write(birfile, buf+18, 0x40-18);
	write_fingerprint = birfile;
	printf("birfile is %d\n", birfile);
}


/* returns 1 if it understood the packet */
int parse(unsigned char *inbuf)
{
	char fingerprint_is[] =  { 0x00, 0x00, 0x00, 0x02, 0x12, 0xff, 0xff, 0xff, 0xff };
	switch(inbuf[7]) {
	case 0xa1:
		printf("Fingerprint follows?\n");
		return 1;
	case 0x28:
		if (!memcmp(inbuf+9, fingerprint_is, 9)) {
			printf("Fingerprint is:\n");
			process_fingerprint(inbuf);
			return 0;
		}
		switch(inbuf[6]) {
		case 0x07:
			printf("Communication failed.\n");
			exit(3);
		case 0x14:			/* REPLY_1 */
			parse_scan_reply(inbuf);
			break;
		case 0x13:			/* Fingerprint match */
			switch(inbuf[14]) {
			case 0x00:
				printf("Fingerprint did not match. (1)\n");
				break;
			case 0x01:
				printf("Fingerprint matches.\n");
				exit(1);
				break;
			}
			break;
		case 0x0b:
			printf("Fingerprint did not match. (2)\n");
		default: 
			return 0;
		}
		return 1;
	default:
		return 0;
	}
}

#define SILENT 1
#define PARSE 2
void ask_scanner_raw(struct usb_dev_handle *usb_handle, int flags, u8 *ctrldata, int len)
{
	int real_len;
	unsigned char inbuf[10240];

	/* Bulk read, length = 0x40 */
	real_len = usb_bulk_read(usb_handle, 0x01, (char *) inbuf, 0x40, 5000);
	if (real_len != 0x40)
		printf("*** Wanted 0x40 bytes, got %d\n", real_len);
	if (write_fingerprint) {
		if ((inbuf[0] == 0x43) && (inbuf[1] == 0x69)) {
			printf("CIAO: end of finerprint\n");
			write_fingerprint = 0;
		} else {
			printf("Writing fingerprint (%d bytes)\n", real_len);
			write(write_fingerprint, inbuf, real_len);
		}
	}
	if (flags & PARSE) {
		if (parse(inbuf))
			flags |= SILENT;
	}
	if (!(flags & SILENT)) {
		//	if (1) {
		fprintf(stdout, "Read: ");
		printhex(inbuf, real_len);

		fprintf(stdout, "Write: ");
		printhex(ctrldata, len);
	}

	*((short *) (ctrldata+len-2)) = udf_crc(&(ctrldata[4]), len-6, 0);
	//	printf("good crc: %x %x my crc: %x\n", ctrldata[len-2], ctrldata[len-1], udf_crc(&(ctrldata[4]), len-6, 0));

	if (len != usb_bulk_write(usb_handle, 0x02, (char *) ctrldata, len, 5000))
		printf("*** Did not write whole %d bytes\n", len);
}

void ask_scanner(struct usb_dev_handle *usb_handle, int flags, char *what)
{
	unsigned char ctrldata[10240];
	int i;
	int len = strlen(what)/3+1;

	for (i=0; i<len; i++) {
		if (1 != sscanf(what+3*i, "%02x", (unsigned int *) &ctrldata[i]))
			printf("badness asking scanner");
	}

	ask_scanner_raw(usb_handle, flags, ctrldata, len);
}

void verify(struct usb_dev_handle *usb_handle, char *file)
{
	unsigned char ctrlbuf[10240] =
		/*			      REVERSE-ENDIAN?! 	  FILE
					      LENGTH + 20511?!
		 *                              0x50  0xbb        LENGTH+28
		 */
		{ 0x43, 0x69, 0x61, 0x6f, 0x00, 0x51, 0x0b, 0x28, 0xb8, 0x00, 0x00, 0x00, 0x03, 
		  0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
		  0xc0, 0xd4, 0x01, 0x00, 0x20, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00 };

	/*

38 bytes header + 156 bytes little.bir

Upload result.bir 238 bytes? (236?)

<6>usb 5-2: bulk write: data: 
                  _CIAO_                  00 51 0b 28             08 01 00 00             03
		  02 00 00 00             00 00 00 00             00 00 00 00             00
		  c0 d4 01 00             20 00 00 00             03 00 00 00

 ec 00 00 00 01 04 12 00 00 00 fe 04 08 00 00 00 41 50 52 39 08 01 00 60 00 00 ff 31 01 58 3e 33 08 00 00 00 4e 3c a4 00 49 54 84 0f 48 68 a4 1f 76 74 f8 0f ac 88 78 11 94 ac 84 01 92 ec 94 10 59 04 e5 0e 79 10 e5 00 31 14 f9 1d 88 64 c5 10 81 7a 25 10 8d 88 55 10 58 9a 95 0c a6 a2 95 03 38 ac e5 1c a4 c8 25 06 4e da 59 09 76 e4 05 0a 79 f8 05 08 7d 02 ba 05 94 20 a6 15 6e 28 fa 05 98 90 75 2f 91 a0 55 30 98 0a 86 35 d0 12 d6 06 99 14 b6 29 91 30 56 15 90 3c aa 1e 95 40 5a 19 a0 42 2a 0f b4 4a 4a 09 39 54 96 17 89 5a 2a 01 ba 62 56 09 a8 64 c6 0d 69 70 aa 04 a0 c2 d5 45 80 f0 e5 43 82 f0 85 40 7f f6 d9 43 96 42 3a 14 9a 52 aa 13 96 58 66 10 a2 6a 4a 1c a3 72 26 0c 8f 7a 26 00 ab 7c 5a 0e 00 00 00 00 a5 1b
<6>usb 5-2: usbdev_ioctl: BULK

	 */
	int birfile = open(file, O_RDONLY);
	int header = 13*3-1;
	int filesize;

	fprintf(stdout, "Preparing verify...\n");
	/* Upload my little finger */
	filesize = read(birfile, ctrlbuf+header, 10200-header);
	printf("(Fingerprint is %d bytes)\n", filesize);

	filesize -= 2; // HACK!

	*((short *) (ctrlbuf+8)) = filesize + 28;
	ctrlbuf[5] = (filesize+20511) >> 8;
	ctrlbuf[6] = (filesize+20511) & 0xff;
	ctrlbuf[header+filesize] = 0x4f;
	ctrlbuf[header+filesize+1] = 0x47;
	ask_scanner_raw(usb_handle, 0, ctrlbuf, header+filesize+2);
	fprintf(stdout, "Ready.\n");
	while (1) {
		ask_scanner(usb_handle, PARSE, "43 69 61 6f 00 60 08 28 05 00 00 00 00 30 01 49 6b");
		ask_scanner(usb_handle, PARSE, "43 69 61 6f 00 70 08 28 05 00 00 00 00 30 01 df ff");
		ask_scanner(usb_handle, PARSE, "43 69 61 6f 00 80 08 28 05 00 00 00 00 30 01 6a c4");
	}
}

void enroll(struct usb_dev_handle *usb_handle, char *file)
{
	fprintf(stdout, "Preparing enroll...\n");
	/* Please enroll */
	ask_scanner(usb_handle, SILENT,  "43 69 61 6f 00 50 0e 28 0b 00 00 00 02 02 c0 d4 01 00 04 00 08 0f 86");
	fprintf(stdout, "Ready.\n");
	while (1) {
		ask_scanner(usb_handle, PARSE, "43 69 61 6f 00 60 08 28 05 00 00 00 00 30 01 49 6b");
		ask_scanner(usb_handle, PARSE, "43 69 61 6f 00 70 08 28 05 00 00 00 00 30 01 df ff");
		ask_scanner(usb_handle, PARSE, "43 69 61 6f 00 80 08 28 05 00 00 00 00 30 01 6a c4");
	}
}

int main(int argc, char **argv)
{
	struct usb_device *usb_dev;
	int retval = 1;

	setvbuf( stdout, NULL, _IONBF, 0 );
	usb_dev = device_init();
	if (usb_dev == NULL) {
		fprintf(stdout, "Device not found.\n");
		goto exit;
	}
	fprintf(stdout, "Device found.\n");

	usb_handle = usb_open(usb_dev);
	if (usb_handle == NULL) {
		fprintf(stdout, "Not able to claim the USB device\n");
		goto exit;
	}
	
	hello(usb_handle);
	sleep(1);		/* Original code waits, too */

	/* Initialize */
	fprintf(stdout, "Initializing...\n");
	/* Command form seems to be      Ciao....... ??seq len28 len? */ 
	ask_scanner(usb_handle, SILENT, "43 69 61 6f 04 00 08 01 00 e8 03 00 00 ff 07 db 24");
	ask_scanner(usb_handle, SILENT, "43 69 61 6f 00 00 07 28 04 00 00 00 06 04 c0 d6");
	ask_scanner(usb_handle, SILENT, "43 69 61 6f 00 10 07 28 04 00 00 00 07 04 0f b6");
	ask_scanner(usb_handle, SILENT, "43 69 61 6f 00 20 1f 28 1c 00 00 00 08 04 83 00 2c 22 23 97 c9 a7 15 a0 8a ab 3c d0 bf db f3 92 6f ae 3b 1e 44 c4 9a 45");
	ask_scanner(usb_handle, SILENT, "43 69 61 6f 00 30 0b 28 08 00 00 00 0c 04 03 00 00 00 6d 7e");
	/* Prepare to verify */
	ask_scanner(usb_handle, SILENT, "43 69 61 6f 00 40 6f 28 6c 00 00 00 0b 04 03 00 00 00 60 00 00 00 03 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00 02 00 00 00 00 00 00 00 f4 01 00 00 64 01 00 00 00 00 00 00 02 00 02 00 00 00 00 00 00 00 00 00 03 00 01 00 01 00 00 00 01 00 00 00 00 00 00 00 0a 00 0a 00 64 00 f4 01 32 00 00 00 00 10 00 00 04 00 02 00 02 00 08 00 93 0f");

	if (argc > 1)
		verify(usb_handle, argv[1]);
	else
		enroll(usb_handle, "test.bir");

	retval = 0;
	
exit:
	usb_close(usb_handle);
	return retval;
}


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
