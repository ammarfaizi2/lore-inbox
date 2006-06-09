Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030463AbWFITst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbWFITst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWFITst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:48:49 -0400
Received: from psmtp04.wxs.nl ([195.121.247.13]:13250 "EHLO psmtp04.wxs.nl")
	by vger.kernel.org with ESMTP id S1030463AbWFITst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:48:49 -0400
Date: Fri, 09 Jun 2006 21:49:44 +0200
From: Marvin Raaijmakers <marvin.nospam@gmail.com>
Subject: New way of setting keycodes to scancodes
To: linux-kernel@vger.kernel.org
Message-id: <1149882584.19680.33.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution 2.4.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Currently it isn't possible to assign keycodes to keys of USB keyboards
by usign a userspace application. This is because USB keyboards do not
send scancodes, but HID usage codes. I have modified the hid-input
driver so that keycodes can be set to HID usage codes in exactly the
same way as keycodes are set to scancodes.
To make this possible I had to modify the input_dev structure (in
<linux/input.h>) by adding a "setkeycodes" member to it. This member is
a pointer to a function that sets the keycodes to scancodes (and HID
usage codes). Each driver has its own "setkeycodes" function and if a
driver does not provide the functionality to set keycodes, the pointer
will be NULL. The evdev_ioctl function will call the "setkeycode"
function if its cmd parameter is equal to EVIOCSKEYCODE.
All keyboard drivers now have a setkeycode function, including the
hid-input driver. Note that hid-usage codes are handled the same way as
scancodes.
The keycodemax, keycodesize and keycode member are not removed from the
input_dev structure so that the old way of setting a keycode (by using
the setkeycodes program) can still be used.
The files I modified can be downloaded from:
http://marvin.linux-box.nl/files/kernel_mod.tar.gz (note that I used the
source files from kernel 2.6.15)

Below you can see a simple application for setting keycodes:
----------------
#include <linux/input.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>

int
main (int argc, char **argv)
{
	int fd;
	struct input_keycode2scancode scan2key;
	
	if (argc < 4)
	{
		printf ("Usage: %s /dev/input/eventX scancode keycode\n", argv[0]);
		printf ("Where X = input device number\n");
		return 1;
	}
	
	if ((fd = open(argv[1], O_RDONLY)) < 0)
	{
		perror (argv[0]);
		return 1;
	}
	
	scan2key.scancode = (unsigned) strtol(argv[2], NULL, 0);
	scan2key.keycode = (unsigned) strtol(argv[3], NULL, 0);
	ioctl (fd, EVIOCSKEYCODE, &scan2key);
	
	return 0;
}
----------------

I hope my code will be implemented in the kernel, because with the
current code a lot of extra function keys on USB keyboards do not work
because they do not have a keycode. My code makes it possible to set a
keycode to such key, so that it will work.

Regards,
Marvin Raaijmakers

